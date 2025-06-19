import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:animate_do/animate_do.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatefulWidget {
  const PortfolioApp({super.key});

  @override
  State<PortfolioApp> createState() => _PortfolioAppState();
}

class _PortfolioAppState extends State<PortfolioApp> {
  bool isDark = true;

  void toggleTheme() {
    setState(() {
      isDark = !isDark;
    });
  }

  final homeKey = GlobalKey();
  final projectsKey = GlobalKey();
  final skillsKey = GlobalKey();
  final contactKey = GlobalKey();
  final scrollController = ScrollController();

  void scrollTo(GlobalKey key) {
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Prajan Pokhrel | Flutter Developer',
      theme:
          isDark
              ? ThemeData(
                scaffoldBackgroundColor: const Color(0xFF1E1E1E),
                textTheme: GoogleFonts.poppinsTextTheme(
                  Theme.of(context).textTheme.apply(bodyColor: Colors.white),
                ),
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
                useMaterial3: true,
              )
              : ThemeData.light().copyWith(
                textTheme: GoogleFonts.poppinsTextTheme(),
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
                useMaterial3: true,
              ),
      home: HomePage(
        toggleTheme: toggleTheme,
        scrollTo: scrollTo,
        scrollController: scrollController,
        homeKey: homeKey,
        projectsKey: projectsKey,
        skillsKey: skillsKey,
        contactKey: contactKey,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final VoidCallback toggleTheme;
  final void Function(GlobalKey) scrollTo;
  final ScrollController scrollController;
  final GlobalKey homeKey;
  final GlobalKey projectsKey;
  final GlobalKey skillsKey;
  final GlobalKey contactKey;

  const HomePage({
    super.key,
    required this.toggleTheme,
    required this.scrollTo,
    required this.scrollController,
    required this.homeKey,
    required this.projectsKey,
    required this.skillsKey,
    required this.contactKey,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Prajan Pokhrel'),
        actions: [
          TextButton(
            onPressed: () => scrollTo(homeKey),
            child: const Text('Home'),
          ),
          TextButton(
            onPressed: () => scrollTo(projectsKey),
            child: const Text('Projects'),
          ),
          TextButton(
            onPressed: () => scrollTo(skillsKey),
            child: const Text('Skills'),
          ),
          TextButton(
            onPressed: () => scrollTo(contactKey),
            child: const Text('Contact'),
          ),
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: toggleTheme,
          ),
        ],
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(key: homeKey),
              FadeInDown(
                child: const Text(
                  'Hi, I am',
                  style: TextStyle(fontSize: 24, color: Colors.grey),
                ),
              ),
              FadeInDown(
                delay: const Duration(milliseconds: 200),
                child: const Text(
                  'Prajan Pokhrel',
                  style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                ),
              ),
              FadeInDown(
                delay: const Duration(milliseconds: 400),
                child: const Text(
                  'Flutter Developer',
                  style: TextStyle(fontSize: 28, color: Colors.blueAccent),
                ),
              ),
              const SizedBox(height: 20),
              FadeIn(
                delay: const Duration(milliseconds: 600),
                child: const Text(
                  "I'm Prajan Pokhrel, a passionate Flutter developer focused on building beautiful, responsive, and high-performance mobile applications. With a strong grasp of clean architecture, state management, and Firebase integration, I aim to deliver user-first experiences and scalable solutions.",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 40),
              const Divider(),
              const SizedBox(height: 40),
              Container(key: projectsKey),
              buildProjectSection(),
              const SizedBox(height: 40),
              Container(key: skillsKey),
              buildSkillsSection(),
              const SizedBox(height: 40),
              Container(key: contactKey),
              buildContactSection(context), // <-- Updated here to pass context
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProjectSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Projects',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 20,
          runSpacing: 20,
          children: List.generate(
            3,
            (index) => FadeInUp(
              delay: Duration(milliseconds: 100 * index),
              child: SizedBox(
                width: 300,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Project Title',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Short description of the project goes here. Built with Flutter, Firebase.',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildSkillsSection() {
    final skills = ['Flutter', 'Dart', 'Firebase', 'REST APIs', 'Provider'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Skills',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: skills.map((skill) => Chip(label: Text(skill))).toList(),
        ),
      ],
    );
  }

  Widget buildContactSection(BuildContext context) {
    final color = Theme.of(context).colorScheme.onBackground;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contact Me',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Icon(FontAwesomeIcons.envelope, color: color),
            const SizedBox(width: 10),
            SelectableText(
              'prajanpokhrel09@gmail.com',
              style: TextStyle(fontSize: 18, color: color),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Icon(FontAwesomeIcons.github, color: color),
            const SizedBox(width: 10),
            InkWell(
              onTap:
                  () =>
                      launchUrl(Uri.parse('https://github.com/prajanpokhrel')),
              child: Text(
                'github.com/prajanpokhrel',
                style: TextStyle(
                  fontSize: 18,
                  color: color,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Icon(FontAwesomeIcons.linkedin, color: color),
            const SizedBox(width: 10),
            InkWell(
              onTap:
                  () => launchUrl(
                    Uri.parse('https://linkedin.com/in/yourusername'),
                  ),
              child: Text(
                'linkedin.com/in/yourusername',
                style: TextStyle(
                  fontSize: 18,
                  color: color,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
