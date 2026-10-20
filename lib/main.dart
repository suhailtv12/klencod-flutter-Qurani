import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.noorquran.audio',
    androidNotificationChannelName: 'تلاوة القرآن الكريم',
    androidNotificationOngoing: true,
  );
  runApp(const NoorQuranApp());
}

const Color green = Color(0xFF126B50);
const Color gold = Color(0xFFD7B46A);
const String quranApi = 'https://api.alquran.cloud/v1';

class Surah {
  final int number;
  final String name;
  final String englishName;
  final String type;
  final int verses;

  const Surah({
    required this.number,
    required this.name,
    required this.englishName,
    required this.type,
    required this.verses,
  });

  factory Surah.fromJson(Map<String, dynamic> json) => Surah(
        number: json['number'] as int,
        name: (json['name'] ?? 'سورة') as String,
        englishName: (json['englishName'] ?? '') as String,
        type: json['revelationType'] == 'Meccan' ? 'مكية' : 'مدنية',
        verses: json['numberOfAyahs'] as int,
      );
}

class Ayah {
  final int number;
  final String text;
  const Ayah(this.number, this.text);
}

class QuranService {
  static Future<List<Surah>> getSurahs() async {
    final response = await http
        .get(Uri.parse('$quranApi/surah'))
        .timeout(const Duration(seconds: 20));
    if (response.statusCode != 200) {
      throw Exception('تعذر تحميل فهرس السور (${response.statusCode})');
    }
    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final data = json['data'] as List<dynamic>;
    return data
        .map((item) => Surah.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  static Future<List<Ayah>> getAyahs(int surahNumber) async {
    final response = await http
        .get(Uri.parse('$quranApi/surah/$surahNumber/quran-uthmani'))
        .timeout(const Duration(seconds: 25));
    if (response.statusCode != 200) {
      throw Exception('تعذر تحميل آيات السورة (${response.statusCode})');
    }
    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final data = json['data'] as Map<String, dynamic>;
    final list = data['ayahs'] as List<dynamic>;
    return list
        .map((item) {
          final map = item as Map<String, dynamic>;
          return Ayah(map['numberInSurah'] as int, map['text'] as String);
        })
        .toList();
  }

  static Uri audioUri(int surahNumber) => Uri.parse(
      'https://cdn.islamic.network/quran/audio-surah/128/ar.alafasy/$surahNumber.mp3');
}

class NoorQuranApp extends StatefulWidget {
  const NoorQuranApp({super.key});

  @override
  State<NoorQuranApp> createState() => _NoorQuranAppState();
}

class _NoorQuranAppState extends State<NoorQuranApp> {
  bool dark = false;
  int tab = 0;
  int tasbih = 0;
  int khatma = 0;
  Set<int> favorites = {};
  final TextEditingController search = TextEditingController();
  List<Surah> surahs = [];
  bool loading = true;
  String? loadError;

  @override
  void initState() {
    super.initState();
    _loadLocalData();
    _loadSurahs();
  }

  Future<void> _loadLocalData() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      favorites = (prefs.getStringList('favorites') ?? [])
          .map(int.parse)
          .toSet();
      khatma = prefs.getInt('khatma_pages') ?? 0;
      tasbih = prefs.getInt('tasbih_count') ?? 0;
      dark = prefs.getBool('dark_mode') ?? false;
    });
  }

  Future<void> _loadSurahs() async {
    try {
      final data = await QuranService.getSurahs();
      if (!mounted) return;
      setState(() {
        surahs = data;
        loading = false;
        loadError = null;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        loading = false;
        loadError = e.toString().replaceFirst('Exception: ', '');
      });
    }
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
        'favorites', favorites.map((e) => e.toString()).toList());
  }

  Future<void> _saveInt(String key, int value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, value);
  }

  Future<void> _setDark(bool value) async {
    setState(() => dark = value);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('dark_mode', value);
  }

  @override
  void dispose() {
    search.dispose();
    super.dispose();
  }

  ThemeData buildTheme() => ThemeData(
        useMaterial3: true,
        brightness: dark ? Brightness.dark : Brightness.light,
        scaffoldBackgroundColor:
            dark ? const Color(0xFF101A18) : const Color(0xFFF7F8F3),
        colorScheme: ColorScheme.fromSeed(
          seedColor: green,
          brightness: dark ? Brightness.dark : Brightness.light,
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        cardTheme: CardThemeData(
          elevation: 0,
          color: dark ? const Color(0xFF1A2925) : Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final pages = [homePage(), quranPage(), favoritesPage(), morePage()];
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'نور القرآن',
      theme: buildTheme(),
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: SafeArea(child: pages[tab]),
          bottomNavigationBar: NavigationBar(
            selectedIndex: tab,
            onDestinationSelected: (v) => setState(() => tab = v),
            destinations: const [
              NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home),
                  label: 'الرئيسية'),
              NavigationDestination(
                  icon: Icon(Icons.menu_book_outlined),
                  selectedIcon: Icon(Icons.menu_book),
                  label: 'القرآن'),
              NavigationDestination(
                  icon: Icon(Icons.favorite_outline),
                  selectedIcon: Icon(Icons.favorite),
                  label: 'المفضلة'),
              NavigationDestination(
                  icon: Icon(Icons.grid_view_rounded), label: 'المزيد'),
            ],
          ),
        ),
      ),
    );
  }

  Widget pageTitle(String title, String subtitle) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style:
                    const TextStyle(fontSize: 27, fontWeight: FontWeight.w900)),
            const SizedBox(height: 5),
            Text(subtitle,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurfaceVariant)),
          ],
        ),
      );

  Widget homePage() => ListView(
        padding: const EdgeInsets.only(bottom: 24),
        children: [
          pageTitle('نور القرآن', 'رفيقك اليومي لكتاب الله'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Container(
              padding: const EdgeInsets.all(23),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                gradient: const LinearGradient(
                  colors: [Color(0xFF0D5943), Color(0xFF238568)],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.auto_awesome, color: gold, size: 32),
                  const SizedBox(height: 18),
                  const Text('وَلَقَدْ يَسَّرْنَا الْقُرْآنَ لِلذِّكْرِ',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 21,
                          height: 1.8,
                          fontWeight: FontWeight.bold)),
                  const Text('فَهَلْ مِن مُّدَّكِرٍ',
                      style: TextStyle(color: gold, fontSize: 19)),
                  const SizedBox(height: 9),
                  const Text('سورة القمر · آية 17',
                      style: TextStyle(color: Colors.white70)),
                  const SizedBox(height: 20),
                  FilledButton(
                    style: FilledButton.styleFrom(
                        backgroundColor: gold,
                        foregroundColor: Colors.black87),
                    onPressed: () {
                      if (surahs.isNotEmpty) openSurah(surahs.first);
                      setState(() => tab = 1);
                    },
                    child: const Text('ابدأ القراءة'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Row(children: [
              Expanded(
                  child: statCard(Icons.menu_book, '$khatma / 604',
                      'صفحة في الختمة', green)),
              const SizedBox(width: 12),
              Expanded(
                  child: statCard(Icons.favorite, '${favorites.length}',
                      'السور المفضلة', gold)),
            ]),
          ),
          const SizedBox(height: 24),
          sectionHeader('متابعة القراءة', 'متابعة'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Card(
              child: ListTile(
                leading: const CircleAvatar(
                    backgroundColor: Color(0x1F126B50),
                    child: Icon(Icons.menu_book, color: green)),
                title: const Text('ابدأ قراءة القرآن',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: const Text('اختر سورة من الفهرس الكامل'),
                trailing: const Icon(Icons.arrow_back_ios_new, size: 16),
                onTap: () => setState(() => tab = 1),
              ),
            ),
          ),
          const SizedBox(height: 24),
          sectionHeader('أدواتك اليومية', 'اكتشف'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.35,
              children: [
                toolCard(Icons.fingerprint, 'المسبحة', 'عداد التسبيح',
                    () => openTasbih()),
                toolCard(Icons.track_changes, 'ختمة القرآن', 'متابعة الإنجاز',
                    () => openKhatma()),
                toolCard(Icons.bookmark_outline, 'المفضلة', 'سورك المحفوظة',
                    () => setState(() => tab = 2)),
                toolCard(Icons.nights_stay_outlined, 'الوضع الليلي',
                    'راحة لعينيك', () => _setDark(!dark)),
              ],
            ),
          ),
        ],
      );

  Widget statCard(IconData icon, String value, String label, Color color) =>
      Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: color, size: 25),
              const SizedBox(height: 12),
              Text(value,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w900)),
              Text(label, style: const TextStyle(fontSize: 12)),
            ],
          ),
        ),
      );

  Widget sectionHeader(String title, String action) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
        child: Row(children: [
          Expanded(
              child: Text(title,
                  style: const TextStyle(
                      fontSize: 19, fontWeight: FontWeight.bold))),
          Text(action, style: const TextStyle(color: green)),
        ]),
      );

  Widget toolCard(
          IconData icon, String title, String subtitle, VoidCallback onTap) =>
      Card(
        child: InkWell(
          borderRadius: BorderRadius.circular(22),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: green, size: 28),
                const SizedBox(height: 9),
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15)),
                Text(subtitle, style: const TextStyle(fontSize: 12)),
              ],
            ),
          ),
        ),
      );

  Widget quranPage() {
    final query = search.text.trim();
    final filtered = surahs
        .where((s) => s.name.contains(query) || '${s.number}' == query)
        .toList();
    return Column(
      children: [
        pageTitle('القرآن الكريم', 'فهرس سور كتاب الله'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: TextField(
            controller: search,
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              hintText: 'ابحث عن سورة...',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Theme.of(context).cardTheme.color,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: loading
              ? const Center(child: CircularProgressIndicator(color: green))
              : loadError != null
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.cloud_off, size: 48, color: green),
                            const SizedBox(height: 12),
                            Text(loadError!, textAlign: TextAlign.center),
                            const SizedBox(height: 12),
                            FilledButton.icon(
                              onPressed: () {
                                setState(() {
                                  loading = true;
                                  loadError = null;
                                });
                                _loadSurahs();
                              },
                              icon: const Icon(Icons.refresh),
                              label: const Text('إعادة المحاولة'),
                            ),
                          ],
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: filtered.length,
                      itemBuilder: (context, index) {
                        final s = filtered[index];
                        final isFav = favorites.contains(s.number);
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 3),
                          child: Card(
                            child: ListTile(
                              leading: Container(
                                width: 43,
                                height: 43,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: green.withValues(alpha: .10),
                                    borderRadius: BorderRadius.circular(14)),
                                child: Text('${s.number}',
                                    style: const TextStyle(
                                        color: green,
                                        fontWeight: FontWeight.bold)),
                              ),
                              title: Text(s.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17)),
                              subtitle: Text('${s.type} · ${s.verses} آية'),
                              trailing: IconButton(
                                icon: Icon(
                                    isFav
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: isFav ? Colors.red : null),
                                onPressed: () async {
                                  setState(() {
                                    if (isFav) {
                                      favorites.remove(s.number);
                                    } else {
                                      favorites.add(s.number);
                                    }
                                  });
                                  await _saveFavorites();
                                },
                              ),
                              onTap: () => openSurah(s),
                            ),
                          ),
                        );
                      },
                    ),
        ),
      ],
    );
  }

  Widget favoritesPage() {
    final saved =
        surahs.where((s) => favorites.contains(s.number)).toList();
    return Column(
      children: [
        pageTitle('السور المفضلة', 'وصول سريع إلى سورك المختارة'),
        Expanded(
          child: saved.isEmpty
              ? const Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.favorite_border, size: 58, color: green),
                      SizedBox(height: 12),
                      Text('لم تضف سورًا إلى المفضلة بعد'),
                      Text('اضغط على رمز القلب بجانب أي سورة'),
                    ],
                  ),
                )
              : ListView(
                  children: saved
                      .map((s) => Card(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 5),
                            child: ListTile(
                              title: Text(s.name),
                              subtitle: Text('${s.verses} آية'),
                              trailing:
                                  const Icon(Icons.arrow_back_ios_new),
                              onTap: () => openSurah(s),
                            ),
                          ))
                      .toList(),
                ),
        ),
      ],
    );
  }

  Widget morePage() => ListView(
        children: [
          pageTitle('المزيد', 'أدوات تساعدك على الاستمرار'),
          Card(
              child: SwitchListTile(
            secondary: const Icon(Icons.dark_mode_outlined, color: green),
            title: const Text('الوضع الليلي'),
            subtitle: const Text('تبديل مظهر التطبيق'),
            value: dark,
            onChanged: _setDark,
          )),
          Card(
              child: ListTile(
            leading: const Icon(Icons.fingerprint, color: green),
            title: const Text('المسبحة الإلكترونية'),
            subtitle: const Text('عداد تسبيح محفوظ'),
            trailing: const Icon(Icons.chevron_left),
            onTap: openTasbih,
          )),
          Card(
              child: ListTile(
            leading: const Icon(Icons.track_changes, color: green),
            title: const Text('خطة ختم القرآن'),
            subtitle: const Text('تسجيل الصفحات المقروءة'),
            trailing: const Icon(Icons.chevron_left),
            onTap: openKhatma,
          )),
          const Card(
              child: ListTile(
            leading: Icon(Icons.info_outline, color: green),
            title: Text('حول التطبيق'),
            subtitle: Text('نور القرآن — رفيقك اليومي'),
          )),
          const Padding(
            padding: EdgeInsets.all(20),
            child: Text(
                'نسأل الله أن يجعل القرآن ربيع قلوبنا ونور صدورنا.',
                textAlign: TextAlign.center),
          ),
        ],
      );

  void openSurah(Surah s) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => ReaderPage(surah: s),
    ));
  }

  void openTasbih() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => TasbihPage(
        initialCount: tasbih,
        onCount: (v) {
          setState(() => tasbih = v);
          _saveInt('tasbih_count', v);
        },
      ),
    ));
  }

  void openKhatma() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => KhatmaPage(
        initial: khatma,
        onSave: (v) {
          setState(() => khatma = v);
          _saveInt('khatma_pages', v);
        },
      ),
    ));
  }
}

class ReaderPage extends StatefulWidget {
  final Surah surah;
  const ReaderPage({super.key, required this.surah});

  @override
  State<ReaderPage> createState() => _ReaderPageState();
}

class _ReaderPageState extends State<ReaderPage> {
  final AudioPlayer player = AudioPlayer();
  List<Ayah> ayahs = [];
  bool loading = true;
  String? error;
  bool repeat = false;

  @override
  void initState() {
    super.initState();
    _loadAyahs();
  }

  Future<void> _loadAyahs() async {
    try {
      final data = await QuranService.getAyahs(widget.surah.number);
      if (!mounted) return;
      setState(() {
        ayahs = data;
        loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        loading = false;
        error = e.toString().replaceFirst('Exception: ', '');
      });
    }
  }

  Future<void> _playAudio() async {
    try {
      if (player.playing) {
        await player.pause();
        return;
      }
      if (player.processingState == ProcessingState.idle) {
        await player.setAudioSource(AudioSource.uri(
          QuranService.audioUri(widget.surah.number),
          tag: MediaItem(
            id: '${widget.surah.number}',
            album: 'القرآن الكريم',
            title: 'سورة ${widget.surah.name}',
            artist: 'مشاري العفاسي',
          ),
        ));
      }
      await player.play();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('تعذر تشغيل التلاوة: $e')));
    }
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(title: Text('سورة ${widget.surah.name}')),
          body: loading
              ? const Center(child: CircularProgressIndicator(color: green))
              : error != null
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(error!, textAlign: TextAlign.center),
                          const SizedBox(height: 12),
                          FilledButton(
                              onPressed: () {
                                setState(() {
                                  loading = true;
                                  error = null;
                                });
                                _loadAyahs();
                              },
                              child: const Text('إعادة المحاولة')),
                        ],
                      ),
                    )
                  : Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(16, 10, 16, 12),
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            gradient: const LinearGradient(
                                colors: [
                                  Color(0xFF0D5943),
                                  Color(0xFF238568)
                                ]),
                          ),
                          child: Column(
                            children: [
                              const Icon(Icons.auto_awesome,
                                  color: gold, size: 28),
                              const SizedBox(height: 8),
                              Text(widget.surah.name,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(height: 6),
                              Text(
                                  '${widget.surah.type} · ${widget.surah.verses} آية',
                                  style:
                                      const TextStyle(color: Colors.white70)),
                              const SizedBox(height: 12),
                              StreamBuilder<PlayerState>(
                                stream: player.playerStateStream,
                                builder: (context, snapshot) {
                                  final playing =
                                      snapshot.data?.playing ?? false;
                                  return FilledButton.icon(
                                    style: FilledButton.styleFrom(
                                        backgroundColor: gold,
                                        foregroundColor: Colors.black87),
                                    onPressed: _playAudio,
                                    icon: Icon(playing
                                        ? Icons.pause
                                        : Icons.play_arrow),
                                    label: Text(playing
                                        ? 'إيقاف مؤقت'
                                        : 'استمع إلى السورة'),
                                  );
                                },
                              ),
                              StreamBuilder<Duration?>(
                                stream: player.durationStream,
                                builder: (context, snapshot) {
                                  final duration =
                                      snapshot.data ?? Duration.zero;
                                  return StreamBuilder<Duration>(
                                    stream: player.positionStream,
                                    builder: (context, posSnapshot) {
                                      final position =
                                          posSnapshot.data ?? Duration.zero;
                                      final max = duration.inMilliseconds
                                          .toDouble();
                                      final value = max <= 0
                                          ? 0.0
                                          : position.inMilliseconds
                                              .clamp(0, duration.inMilliseconds)
                                              .toDouble();
                                      return Column(
                                        children: [
                                          Slider(
                                            value: value,
                                            max: max <= 0 ? 1 : max,
                                            onChanged: max <= 0
                                                ? null
                                                : (v) => player.seek(Duration(
                                                    milliseconds: v.round())),
                                          ),
                                          Text(
                                            '${_duration(position)} / ${_duration(duration)}',
                                            style: const TextStyle(
                                                color: Colors.white70,
                                                fontSize: 12),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                            itemCount: ayahs.length,
                            itemBuilder: (context, index) {
                              final ayah = ayahs[index];
                              return Card(
                                margin: const EdgeInsets.only(bottom: 10),
                                child: Padding(
                                  padding: const EdgeInsets.all(18),
                                  child: Column(
                                    children: [
                                      Text(ayah.text,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontSize: 25, height: 2.0)),
                                      const SizedBox(height: 12),
                                      CircleAvatar(
                                        radius: 16,
                                        backgroundColor:
                                            green.withValues(alpha: .12),
                                        child: Text('${ayah.number}',
                                            style: const TextStyle(
                                                color: green,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
        ),
      );

  String _duration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '${d.inHours > 0 ? '${d.inHours}:' : ''}$minutes:$seconds';
  }
}

class TasbihPage extends StatefulWidget {
  final int initialCount;
  final ValueChanged<int> onCount;
  const TasbihPage(
      {super.key, required this.initialCount, required this.onCount});

  @override
  State<TasbihPage> createState() => _TasbihPageState();
}

class _TasbihPageState extends State<TasbihPage> {
  late int count;

  @override
  void initState() {
    super.initState();
    count = widget.initialCount;
  }

  @override
  Widget build(BuildContext context) => Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(title: const Text('المسبحة الإلكترونية')),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('سُبْحَانَ اللَّهِ',
                    style: TextStyle(fontSize: 30, color: green)),
                const SizedBox(height: 30),
                Text('$count',
                    style: const TextStyle(
                        fontSize: 65, fontWeight: FontWeight.w900)),
                const Text('عدد التسبيحات'),
                const SizedBox(height: 35),
                GestureDetector(
                  onTap: () {
                    setState(() => count++);
                    widget.onCount(count);
                  },
                  child: Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                          colors: [Color(0xFF126B50), Color(0xFF238568)]),
                      boxShadow: [
                        BoxShadow(
                            color: green.withValues(alpha: .25),
                            blurRadius: 25,
                            offset: const Offset(0, 10))
                      ],
                    ),
                    child: const Icon(Icons.touch_app,
                        size: 65, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 30),
                const Text('اضغط على الدائرة للتسبيح'),
                const SizedBox(height: 15),
                OutlinedButton.icon(
                  onPressed: () {
                    setState(() => count = 0);
                    widget.onCount(0);
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('إعادة التصفير'),
                ),
              ],
            ),
          ),
        ),
      );
}

class KhatmaPage extends StatefulWidget {
  final int initial;
  final ValueChanged<int> onSave;
  const KhatmaPage({super.key, required this.initial, required this.onSave});

  @override
  State<KhatmaPage> createState() => _KhatmaPageState();
}

class _KhatmaPageState extends State<KhatmaPage> {
  late int pages;

  @override
  void initState() {
    super.initState();
    pages = widget.initial.clamp(0, 604).toInt();
  }

  @override
  Widget build(BuildContext context) {
    final progress = pages / 604;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('ختمة القرآن')),
        body: ListView(
          padding: const EdgeInsets.all(22),
          children: [
            const SizedBox(height: 25),
            const Icon(Icons.auto_stories, size: 70, color: green),
            const SizedBox(height: 20),
            const Text('رحلتك مع كتاب الله',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(22),
                child: Column(
                  children: [
                    Text('${(progress * 100).toStringAsFixed(1)}%',
                        style: const TextStyle(
                            fontSize: 42,
                            fontWeight: FontWeight.w900,
                            color: green)),
                    const SizedBox(height: 16),
                    LinearProgressIndicator(
                        value: progress,
                        minHeight: 12,
                        borderRadius: BorderRadius.circular(20),
                        color: green),
                    const SizedBox(height: 15),
                    Text('$pages من 604 صفحة'),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton.filledTonal(
                          onPressed: pages > 0
                              ? () => setState(() {
                                    pages--;
                                    widget.onSave(pages);
                                  })
                              : null,
                          icon: const Icon(Icons.remove),
                        ),
                        const SizedBox(width: 24),
                        IconButton.filled(
                          onPressed: pages < 604
                              ? () => setState(() {
                                    pages++;
                                    widget.onSave(pages);
                                  })
                              : null,
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    if (pages == 604)
                      const Text('ما شاء الله! أتممت الختمة.',
                          style: TextStyle(
                              color: green, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),
            const Text(
                'حدّث عدد الصفحات بعد القراءة. عدد الصفحات تقديري لمصحف من 604 صفحات.',
                textAlign: TextAlign.center,
                style: TextStyle(height: 1.7, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}