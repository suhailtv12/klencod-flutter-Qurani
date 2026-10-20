
import 'package:flutter/material.dart';

void main() {
  runApp(const NoorQuranApp());
}

const Color green = Color(0xFF126B50);
const Color gold = Color(0xFFD7B46A);

class Surah {
  final int number;
  final String name;
  final String type;
  final int verses;

  const Surah(this.number, this.name, this.type, this.verses);
}

const List<Surah> surahs = [
  Surah(1,'الفاتحة','مكية',7),
  Surah(2,'البقرة','مدنية',286),
  Surah(3,'آل عمران','مدنية',200),
  Surah(4,'النساء','مدنية',176),
  Surah(5,'المائدة','مدنية',120),
  Surah(6,'الأنعام','مكية',165),
  Surah(7,'الأعراف','مكية',206),
  Surah(8,'الأنفال','مدنية',75),
  Surah(9,'التوبة','مدنية',129),
  Surah(10,'يونس','مكية',109),
  Surah(11,'هود','مكية',123),
  Surah(12,'يوسف','مكية',111),
  Surah(13,'الرعد','مدنية',43),
  Surah(14,'إبراهيم','مكية',52),
  Surah(15,'الحجر','مكية',99),
  Surah(16,'النحل','مكية',128),
  Surah(17,'الإسراء','مكية',111),
  Surah(18,'الكهف','مكية',110),
  Surah(19,'مريم','مكية',98),
  Surah(20,'طه','مكية',135),
  Surah(21,'الأنبياء','مكية',112),
  Surah(22,'الحج','مدنية',78),
  Surah(23,'المؤمنون','مكية',118),
  Surah(24,'النور','مدنية',64),
  Surah(25,'الفرقان','مكية',77),
  Surah(26,'الشعراء','مكية',227),
  Surah(27,'النمل','مكية',93),
  Surah(28,'القصص','مكية',88),
  Surah(29,'العنكبوت','مكية',69),
  Surah(30,'الروم','مكية',60),
  Surah(31,'لقمان','مكية',34),
  Surah(32,'السجدة','مكية',30),
  Surah(33,'الأحزاب','مدنية',73),
  Surah(34,'سبأ','مكية',54),
  Surah(35,'فاطر','مكية',45),
  Surah(36,'يس','مكية',83),
  Surah(37,'الصافات','مكية',182),
  Surah(38,'ص','مكية',88),
  Surah(39,'الزمر','مكية',75),
  Surah(40,'غافر','مكية',85),
  Surah(41,'فصلت','مكية',54),
  Surah(42,'الشورى','مكية',53),
  Surah(43,'الزخرف','مكية',89),
  Surah(44,'الدخان','مكية',59),
  Surah(45,'الجاثية','مكية',37),
  Surah(46,'الأحقاف','مكية',35),
  Surah(47,'محمد','مدنية',38),
  Surah(48,'الفتح','مدنية',29),
  Surah(49,'الحجرات','مدنية',18),
  Surah(50,'ق','مكية',45),
  Surah(51,'الذاريات','مكية',60),
  Surah(52,'الطور','مكية',49),
  Surah(53,'النجم','مكية',62),
  Surah(54,'القمر','مكية',55),
  Surah(55,'الرحمن','مدنية',78),
  Surah(56,'الواقعة','مكية',96),
  Surah(57,'الحديد','مدنية',29),
  Surah(58,'المجادلة','مدنية',22),
  Surah(59,'الحشر','مدنية',24),
  Surah(60,'الممتحنة','مدنية',13),
  Surah(61,'الصف','مدنية',14),
  Surah(62,'الجمعة','مدنية',11),
  Surah(63,'المنافقون','مدنية',11),
  Surah(64,'التغابن','مدنية',18),
  Surah(65,'الطلاق','مدنية',12),
  Surah(66,'التحريم','مدنية',12),
  Surah(67,'الملك','مكية',30),
  Surah(68,'القلم','مكية',52),
  Surah(69,'الحاقة','مكية',52),
  Surah(70,'المعارج','مكية',44),
  Surah(71,'نوح','مكية',28),
  Surah(72,'الجن','مكية',28),
  Surah(73,'المزمل','مكية',20),
  Surah(74,'المدثر','مكية',56),
  Surah(75,'القيامة','مكية',40),
  Surah(76,'الإنسان','مدنية',31),
  Surah(77,'المرسلات','مكية',50),
  Surah(78,'النبأ','مكية',40),
  Surah(79,'النازعات','مكية',46),
  Surah(80,'عبس','مكية',42),
  Surah(81,'التكوير','مكية',29),
  Surah(82,'الانفطار','مكية',19),
  Surah(83,'المطففين','مكية',36),
  Surah(84,'الانشقاق','مكية',25),
  Surah(85,'البروج','مكية',22),
  Surah(86,'الطارق','مكية',17),
  Surah(87,'الأعلى','مكية',19),
  Surah(88,'الغاشية','مكية',26),
  Surah(89,'الفجر','مكية',30),
  Surah(90,'البلد','مكية',20),
  Surah(91,'الشمس','مكية',15),
  Surah(92,'الليل','مكية',21),
  Surah(93,'الضحى','مكية',11),
  Surah(94,'الشرح','مكية',8),
  Surah(95,'التين','مكية',8),
  Surah(96,'العلق','مكية',19),
  Surah(97,'القدر','مكية',5),
  Surah(98,'البينة','مدنية',8),
  Surah(99,'الزلزلة','مدنية',8),
  Surah(100,'العاديات','مكية',11),
  Surah(101,'القارعة','مكية',11),
  Surah(102,'التكاثر','مكية',8),
  Surah(103,'العصر','مكية',3),
  Surah(104,'الهمزة','مكية',9),
  Surah(105,'الفيل','مكية',5),
  Surah(106,'قريش','مكية',4),
  Surah(107,'الماعون','مكية',7),
  Surah(108,'الكوثر','مكية',3),
  Surah(109,'الكافرون','مكية',6),
  Surah(110,'النصر','مدنية',3),
  Surah(111,'المسد','مكية',5),
  Surah(112,'الإخلاص','مكية',4),
  Surah(113,'الفلق','مكية',5),
  Surah(114,'الناس','مكية',6),
];

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
  final Set<int> favorites = {};
  final TextEditingController search = TextEditingController();

  @override
  void dispose() {
    search.dispose();
    super.dispose();
  }

  ThemeData buildTheme() {
    return ThemeData(
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      homePage(),
      quranPage(),
      favoritesPage(),
      morePage(),
    ];

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
                label: 'الرئيسية',
              ),
              NavigationDestination(
                icon: Icon(Icons.menu_book_outlined),
                selectedIcon: Icon(Icons.menu_book),
                label: 'القرآن',
              ),
              NavigationDestination(
                icon: Icon(Icons.favorite_outline),
                selectedIcon: Icon(Icons.favorite),
                label: 'المفضلة',
              ),
              NavigationDestination(
                icon: Icon(Icons.grid_view_rounded),
                label: 'المزيد',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget pageTitle(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(
            fontSize: 27, fontWeight: FontWeight.w900)),
          const SizedBox(height: 5),
          Text(subtitle, style: TextStyle(
            color: Theme.of(context).colorScheme.onSurfaceVariant)),
        ],
      ),
    );
  }

  Widget homePage() {
    return ListView(
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
                    color: Colors.white, fontSize: 21,
                    height: 1.8, fontWeight: FontWeight.bold)),
                const Text('فَهَلْ مِن مُّدَّكِرٍ',
                  style: TextStyle(color: gold, fontSize: 19)),
                const SizedBox(height: 9),
                const Text('سورة القمر · آية 17',
                  style: TextStyle(color: Colors.white70)),
                const SizedBox(height: 20),
                FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: gold, foregroundColor: Colors.black87),
                  onPressed: () => openSurah(surahs[0]),
                  child: const Text('ابدأ القراءة'),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Row(
            children: [
              Expanded(child: statCard(
                Icons.menu_book, '$khatma / 604',
                'صفحة في الختمة', green)),
              const SizedBox(width: 12),
              Expanded(child: statCard(
                Icons.favorite, '${favorites.length}',
                'السور المفضلة', gold)),
            ],
          ),
        ),
        const SizedBox(height: 24),
        sectionHeader('متابعة القراءة', 'متابعة'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: green.withValues(alpha: .12),
                child: const Icon(Icons.menu_book, color: green)),
              title: const Text('سورة الفاتحة',
                style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: const Text('ابدأ رحلتك مع القرآن الكريم'),
              trailing: const Icon(Icons.arrow_back_ios_new, size: 16),
              onTap: () => openSurah(surahs[0]),
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
              toolCard(Icons.fingerprint, 'المسبحة',
                'عداد التسبيح', () => openTasbih()),
              toolCard(Icons.track_changes, 'ختمة القرآن',
                'متابعة الإنجاز', () => openKhatma()),
              toolCard(Icons.bookmark_outline, 'المفضلة',
                'سورك المحفوظة', () => setState(() => tab = 2)),
              toolCard(Icons.nights_stay_outlined, 'الوضع الليلي',
                'راحة لعينيك', () => setState(() => dark = !dark)),
            ],
          ),
        ),
      ],
    );
  }

  Widget statCard(IconData icon, String value, String label, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 25),
            const SizedBox(height: 12),
            Text(value, style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.w900)),
            Text(label, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget sectionHeader(String title, String action) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
      child: Row(
        children: [
          Expanded(child: Text(title, style: const TextStyle(
            fontSize: 19, fontWeight: FontWeight.bold))),
          Text(action, style: const TextStyle(color: green)),
        ],
      ),
    );
  }

  Widget toolCard(IconData icon, String title, String subtitle,
      VoidCallback onTap) {
    return Card(
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
              Text(title, style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 15)),
              Text(subtitle, style: const TextStyle(fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }

  Widget quranPage() {
    final query = search.text.trim();
    final filtered = surahs.where((s) =>
      s.name.contains(query) ||
      s.number.toString() == query).toList();

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
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: ListView.builder(
            itemCount: filtered.length,
            itemBuilder: (context, index) {
              final s = filtered[index];
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14, vertical: 3),
                child: Card(
                  child: ListTile(
                    leading: Container(
                      width: 43, height: 43,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: green.withValues(alpha: .10),
                        borderRadius: BorderRadius.circular(14)),
                      child: Text('${s.number}',
                        style: const TextStyle(
                          color: green, fontWeight: FontWeight.bold)),
                    ),
                    title: Text(s.name, style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 17)),
                    subtitle: Text('${s.type} · ${s.verses} آية'),
                    trailing: IconButton(
                      icon: Icon(
                        favorites.contains(s.number)
                          ? Icons.favorite : Icons.favorite_border,
                        color: favorites.contains(s.number)
                          ? Colors.red : null),
                      onPressed: () => setState(() {
                        if (!favorites.add(s.number)) {
                          favorites.remove(s.number);
                        }
                      }),
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
    final saved = surahs.where((s) =>
      favorites.contains(s.number)).toList();

    return Column(
      children: [
        pageTitle('السور المفضلة', 'وصول سريع إلى سورك المختارة'),
        Expanded(
          child: saved.isEmpty
            ? const Center(child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.favorite_border, size: 58, color: green),
                  SizedBox(height: 12),
                  Text('لم تضف سورًا إلى المفضلة بعد'),
                  Text('اضغط على رمز القلب بجانب أي سورة'),
                ],
              ))
            : ListView(
                children: saved.map((s) => Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 5),
                  child: ListTile(
                    title: Text(s.name),
                    subtitle: Text('${s.verses} آية'),
                    trailing: const Icon(Icons.arrow_back_ios_new),
                    onTap: () => openSurah(s),
                  ),
                )).toList(),
              ),
        ),
      ],
    );
  }

  Widget morePage() {
    return ListView(
      children: [
        pageTitle('المزيد', 'أدوات تساعدك على الاستمرار'),
        Card(child: SwitchListTile(
          secondary: const Icon(Icons.dark_mode_outlined, color: green),
          title: const Text('الوضع الليلي'),
          subtitle: const Text('تبديل مظهر التطبيق'),
          value: dark,
          onChanged: (v) => setState(() => dark = v),
        )),
        Card(child: ListTile(
          leading: const Icon(Icons.fingerprint, color: green),
          title: const Text('المسبحة الإلكترونية'),
          subtitle: const Text('عداد تسبيح تفاعلي'),
          trailing: const Icon(Icons.chevron_left),
          onTap: openTasbih,
        )),
        Card(child: ListTile(
          leading: const Icon(Icons.track_changes, color: green),
          title: const Text('خطة ختم القرآن'),
          subtitle: const Text('تسجيل الصفحات المقروءة'),
          trailing: const Icon(Icons.chevron_left),
          onTap: openKhatma,
        )),
        Card(child: const ListTile(
          leading: Icon(Icons.info_outline, color: green),
          title: Text('حول التطبيق'),
          subtitle: Text('نور القرآن — رفيقك اليومي'),
        )),
        const Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            'نسأل الله أن يجعل القرآن ربيع قلوبنا ونور صدورنا.',
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  void openSurah(Surah s) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => ReaderPage(surah: s),
    ));
  }

  void openTasbih() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => TasbihPage(
        onCount: (v) => setState(() => tasbih = v),
        initialCount: tasbih,
      ),
    ));
  }

  void openKhatma() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => KhatmaPage(
        initial: khatma,
        onSave: (v) => setState(() => khatma = v),
      ),
    ));
  }
}

class ReaderPage extends StatelessWidget {
  final Surah surah;
  const ReaderPage({super.key, required this.surah});

  static const String fatiha =
      'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ\n\n'
      'الْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ ۝\n'
      'الرَّحْمَٰنِ الرَّحِيمِ ۝\n'
      'مَالِكِ يَوْمِ الدِّينِ ۝\n'
      'إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ ۝\n'
      'اهْدِنَا الصِّرَاطَ الْمُسْتَقِيمَ ۝\n'
      'صِرَاطَ الَّذِينَ أَنْعَمْتَ عَلَيْهِمْ '
      'غَيْرِ الْمَغْضُوبِ عَلَيْهِمْ وَلَا الضَّالِّينَ ۝';

  @override
  Widget build(BuildContext context) {
    final isFatiha = surah.number == 1;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: Text('سورة ${surah.name}')),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: const LinearGradient(
                  colors: [Color(0xFF0D5943), Color(0xFF238568)],
                ),
              ),
              child: Column(
                children: [
                  const Icon(Icons.auto_awesome, color: gold, size: 30),
                  const SizedBox(height: 12),
                  Text(surah.name, style: const TextStyle(
                    color: Colors.white, fontSize: 30,
                    fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text('${surah.type} · ${surah.verses} آية',
                    style: const TextStyle(color: Colors.white70)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            if (isFatiha) ...[
              const Text('بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 21, color: green)),
              const SizedBox(height: 20),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(22),
                  child: Text(fatiha,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 25, height: 2.2)),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'تنبيه: راجع النص مع مصحف معتمد قبل نشر التطبيق.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12)),
            ] else
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      const Icon(Icons.menu_book,
                        color: green, size: 48),
                      const SizedBox(height: 16),
                      const Text('قارئ القرآن',
                        style: TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      const Text(
                        'فهرس السور جاهز. لعرض النص الكامل لهذه السورة '
                        'يجب ربط التطبيق بمصدر موثوق للنص القرآني '
                        'مع التحقق من الرسم العثماني وأرقام الآيات.',
                        textAlign: TextAlign.center,
                        style: TextStyle(height: 1.8)),
                      const SizedBox(height: 12),
                      Text('عدد الآيات: ${surah.verses}'),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class TasbihPage extends StatefulWidget {
  final int initialCount;
  final ValueChanged<int> onCount;

  const TasbihPage({
    super.key,
    required this.initialCount,
    required this.onCount,
  });

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
  Widget build(BuildContext context) {
    return Directionality(
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
              Text('$count', style: const TextStyle(
                fontSize: 65, fontWeight: FontWeight.w900)),
              const Text('عدد التسبيحات'),
              const SizedBox(height: 35),
              GestureDetector(
                onTap: () {
                  setState(() => count++);
                  widget.onCount(count);
                },
                child: Container(
                  width: 180, height: 180,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [Color(0xFF126B50), Color(0xFF238568)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: green.withValues(alpha: .25),
                        blurRadius: 25, offset: const Offset(0, 10)),
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
}

class KhatmaPage extends StatefulWidget {
  final int initial;
  final ValueChanged<int> onSave;

  const KhatmaPage({
    super.key,
    required this.initial,
    required this.onSave,
  });

  @override
  State<KhatmaPage> createState() => _KhatmaPageState();
}

class _KhatmaPageState extends State<KhatmaPage> {
  late int pages;

  @override
  void initState() {
    super.initState();
    pages = widget.initial.clamp(0, 604);
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
              style: TextStyle(fontSize: 26,
                fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(22),
                child: Column(
                  children: [
                    Text('${(progress * 100).toStringAsFixed(1)}%',
                      style: const TextStyle(
                        fontSize: 42, fontWeight: FontWeight.w900,
                        color: green)),
                    const SizedBox(height: 16),
                    LinearProgressIndicator(
                      value: progress,
                      minHeight: 12,
                      borderRadius: BorderRadius.circular(20),
                      color: green,
                    ),
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
              'حدّث عدد الصفحات بعد القراءة. عدد الصفحات هنا تقديري '
              'لمصحف من 604 صفحات، وقد يختلف بحسب طبعة المصحف.',
              textAlign: TextAlign.center,
              style: TextStyle(height: 1.7, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
