import 'package:flutter/material.dart';

void main() {
  runApp(const IAmRichApp());
}

class IAmRichApp extends StatelessWidget {
  const IAmRichApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'I Am Rich',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF080808),
      ),
      home: const CollectionScreen(),
    );
  }
}

class CollectionScreen extends StatelessWidget {
  const CollectionScreen({super.key});

  static const String imagePath = 'assets/images/myphoto.jpeg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // The picture grows with the screen while keeping sensible limits.
            final imageHeight = (constraints.maxHeight * 0.55).clamp(
              180.0,
              480.0,
            );

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight - 64,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 520),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'I Am Rich',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFFE7C875),
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 2,
                          ),
                        ),
                        const SizedBox(height: 28),
                        SizedBox(
                          width: double.infinity,
                          height: imageHeight,
                          child: Image.asset(
                            imagePath,
                            // contain keeps the image's original proportions.
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return const _MissingImageNotice();
                            },
                          ),
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'My Collection',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFFB8B8B8),
                            fontSize: 15,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

/// This is shown until assets/images/my_image.png is added to the project.
class _MissingImageNotice extends StatelessWidget {
  const _MissingImageNotice();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0xFF121212),
        border: Border.all(color: const Color(0xFF3A3A3A)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.add_photo_alternate_outlined,
                color: Color(0xFFE7C875),
                size: 48,
              ),
              SizedBox(height: 16),
              Text(
                'Add your image at\nassets/images/my_image.png',
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xFFB8B8B8), height: 1.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
