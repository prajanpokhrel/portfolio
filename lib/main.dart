// Updated with animated project card switching
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:animate_do/animate_do.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const PortfolioApp());
}

class Project {
  final String title;
  final String description;
  final String techStack;
  final String? url;
  final String? imageUrl;

  const Project({
    required this.title,
    required this.description,
    required this.techStack,
    this.url,
    this.imageUrl,
  });
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
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme.apply(bodyColor: Colors.black87),
        ),
        iconTheme: const IconThemeData(color: Colors.black87),
        cardColor: Colors.white,
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF1E1E1E),
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme.apply(bodyColor: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white70),
        cardColor: const Color(0xFF2A2A2A),
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

  final List<Project> projects = const [
    Project(
      title: 'Awesome Flutter App',
      description: 'A task management app built with Flutter and Firebase.',
      techStack: 'Flutter, Firebase, Provider',
      url: 'https://github.com/prajanpokhrel/awesome-flutter-app',
      imageUrl: 'https://via.placeholder.com/300x150.png?text=Flutter+App',
    ),
    Project(
      title: 'Portfolio Website',
      description: 'My personal portfolio built with Flutter Web.',
      techStack: 'Flutter Web, Google Fonts, Animate_do',
      imageUrl: 'https://via.placeholder.com/300x150.png?text=Portfolio+Site',
    ),
  ];

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
                child: Text(
                  'Hi, I am',
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium!.copyWith(color: Colors.grey),
                ),
              ),
              FadeInDown(
                delay: const Duration(milliseconds: 200),
                child: Text(
                  'Prajan Pokhrel',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.bodyLarge!.color,
                  ),
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
                child: Text(
                  "I'm Prajan Pokhrel, a passionate Flutter developer focused on building beautiful, responsive, and high-performance mobile applications. With a strong grasp of clean architecture, state management, and Firebase integration, I aim to deliver user-first experiences and scalable solutions.",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              const SizedBox(height: 40),
              const Divider(),
              const SizedBox(height: 40),
              Container(key: projectsKey),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 600),
                child: buildProjectSection(context),
              ),
              const SizedBox(height: 40),
              Container(key: skillsKey),
              buildSkillsSection(),
              const SizedBox(height: 40),
              Container(key: contactKey),
              buildContactSection(context),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProjectSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Projects',
          style: Theme.of(
            context,
          ).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 20,
          runSpacing: 20,
          children:
              projects.asMap().entries.map((entry) {
                final project = entry.value;
                return FadeInUp(
                  key: ValueKey(project.title),
                  delay: Duration(milliseconds: 100 * entry.key),
                  child: SizedBox(
                    width: 300,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (project.imageUrl != null)
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(16),
                              ),
                              child: Image.network(
                                project.imageUrl!,
                                height: 150,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  project.title,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  project.description,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Tech: ${project.techStack}',
                                  style: Theme.of(context).textTheme.bodySmall!
                                      .copyWith(fontStyle: FontStyle.italic),
                                ),
                                if (project.url != null) ...[
                                  const SizedBox(height: 8),
                                  InkWell(
                                    onTap:
                                        () =>
                                            launchUrl(Uri.parse(project.url!)),
                                    child: Text(
                                      'View Project',
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodyMedium!.copyWith(
                                        color:
                                            Theme.of(
                                              context,
                                            ).colorScheme.primary,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contact Me',
          style: Theme.of(
            context,
          ).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Icon(
              FontAwesomeIcons.envelope,
              color: Theme.of(context).iconTheme.color,
            ),
            const SizedBox(width: 10),
            SelectableText(
              'prajanpokhrel09@gmail.com',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Icon(
              FontAwesomeIcons.github,
              color: Theme.of(context).iconTheme.color,
            ),
            const SizedBox(width: 10),
            InkWell(
              onTap:
                  () =>
                      launchUrl(Uri.parse('https://github.com/prajanpokhrel')),
              child: Text(
                'github.com/prajanpokhrel',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  decoration: TextDecoration.underline,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Icon(
              FontAwesomeIcons.linkedin,
              color: Theme.of(context).iconTheme.color,
            ),
            const SizedBox(width: 10),
            InkWell(
              onTap:
                  () => launchUrl(
                    Uri.parse('https://linkedin.com/in/yourusername'),
                  ),
              child: Text(
                'linkedin.com/in/yourusername',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  decoration: TextDecoration.underline,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
