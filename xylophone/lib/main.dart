import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const XylophoneApp());
}

class XylophoneApp extends StatelessWidget {
  const XylophoneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Xylophone',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: const XylophonePage(),
    );
  }
}

class XylophonePage extends StatefulWidget {
  const XylophonePage({super.key});

  @override
  State<XylophonePage> createState() => _XylophonePageState();
}

class _XylophonePageState extends State<XylophonePage> {
  final AudioPlayer _player = AudioPlayer();

  // Hit boxes are normalized to the 554 x 553 reference image.
  // Each box covers one colored wooden bar.
  final List<_Bar> _bars = const [
    _Bar(left: 88, top: 150, width: 48, height: 150, sound: 'audio/note_1.wav'),
    _Bar(left: 136, top: 142, width: 47, height: 162, sound: 'audio/note_2.wav'),
    _Bar(left: 184, top: 133, width: 48, height: 171, sound: 'audio/note_3.wav'),
    _Bar(left: 231, top: 123, width: 49, height: 182, sound: 'audio/note_4.wav'),
    _Bar(left: 278, top: 111, width: 49, height: 194, sound: 'audio/note_5.wav'),
    _Bar(left: 326, top: 101, width: 51, height: 204, sound: 'audio/note_6.wav'),
    _Bar(left: 374, top: 89, width: 66, height: 214, sound: 'audio/note_7.wav'),
    _Bar(left: 423, top: 76, width: 75, height: 230, sound: 'audio/note_8.wav'),
  ];

  Future<void> _play(String sound) async {
    // One AudioPlayer is enough for this simple app.
    // If the user taps quickly, the previous note is restarted.
    await _player.stop();
    await _player.play(AssetSource(sound));
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFDFD),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Tap the xylophone bars',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12),
                AspectRatio(
                  aspectRatio: 554 / 553,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final scale = constraints.maxWidth / 554.0;

                      return Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.asset(
                            'assets/images/xylophone.jpg',
                            fit: BoxFit.contain,
                          ),

                          // Transparent hit areas on top of the original image.
                          for (final bar in _bars)
                            Positioned(
                              left: bar.left * scale,
                              top: bar.top * scale,
                              width: bar.width * scale,
                              height: bar.height * scale,
                              child: GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () => _play(bar.sound),
                                child: const SizedBox.expand(),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Each colored bar plays a different note.',
                  style: TextStyle(color: Colors.black54),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Bar {
  final double left;
  final double top;
  final double width;
  final double height;
  final String sound;

  const _Bar({
    required this.left,
    required this.top,
    required this.width,
    required this.height,
    required this.sound,
  });
}
