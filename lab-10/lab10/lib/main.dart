import 'package:flutter/material.dart';

void main() {
  runApp(const AnimatedContainerLabApp());
}

class AnimatedContainerLabApp extends StatelessWidget {
  const AnimatedContainerLabApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Animation Labs',
      theme: ThemeData(
        fontFamily: 'Arial',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const AnimationLabsHome(),
    );
  }
}

class AnimationLabsHome extends StatelessWidget {
  const AnimationLabsHome({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Animation Labs'),
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'Lab 1 · Container'),
              Tab(text: 'Lab 2 · Profile'),
              Tab(text: 'Lab 3 · Scale'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            AnimatedContainerLab(),
            OpacityCrossFadeLab(),
            ScaleTransitionLab(),
          ],
        ),
      ),
    );
  }
}

class AnimatedContainerLab extends StatefulWidget {
  const AnimatedContainerLab({super.key});

  @override
  State<AnimatedContainerLab> createState() => _AnimatedContainerLabState();
}

class _AnimatedContainerLabState extends State<AnimatedContainerLab> {
  bool _isExpanded = false;
  int _durationInMilliseconds = 800;

  void _toggleContainer() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  String get _durationExplanation {
    switch (_durationInMilliseconds) {
      case 300:
        return 'Fast feels snappy. It is good for small, frequent changes.';
      case 1600:
        return 'Slow makes the movement easy to see, but can feel like a wait.';
      default:
        return 'Medium gives you time to notice the change without waiting too long.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Column(
              children: [
                Text(
                  'Watch the box change',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Tap the button to make it grow. Tap again to bring it back.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  height: 210,
                  child: Center(
                    child: AnimatedContainer(
                      key: const ValueKey('animated-square'),
                      width: _isExpanded ? 200 : 120,
                      height: _isExpanded ? 170 : 120,
                      duration: Duration(milliseconds: _durationInMilliseconds),
                      curve: Curves.easeInOut,
                      decoration: BoxDecoration(
                        color: _isExpanded ? Colors.orange : Colors.blue,
                        borderRadius: BorderRadius.circular(
                          _isExpanded ? 40 : 8,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  key: const ValueKey('toggle-button'),
                  onPressed: _toggleContainer,
                  child: Text(_isExpanded ? 'Make it small' : 'Make it grow'),
                ),
                const SizedBox(height: 28),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Speed: '),
                    const SizedBox(width: 12),
                    DropdownButton<int>(
                      value: _durationInMilliseconds,
                      items: const [
                        DropdownMenuItem(
                          value: 300,
                          child: Text('Fast (300 ms)'),
                        ),
                        DropdownMenuItem(
                          value: 800,
                          child: Text('Medium (800 ms)'),
                        ),
                        DropdownMenuItem(
                          value: 1600,
                          child: Text('Slow (1600 ms)'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value == null) return;
                        setState(() {
                          _durationInMilliseconds = value;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  _durationExplanation,
                  key: const ValueKey('duration-explanation'),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OpacityCrossFadeLab extends StatefulWidget {
  const OpacityCrossFadeLab({super.key});

  @override
  State<OpacityCrossFadeLab> createState() => _OpacityCrossFadeLabState();
}

class _OpacityCrossFadeLabState extends State<OpacityCrossFadeLab> {
  bool _showProfile = true;
  bool _isUnlocked = false;

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleMedium;

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'A little profile experiment',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Try hiding the card, then switch between locked and unlocked.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 28),
                Text('Fade the profile card', style: titleStyle),
                const SizedBox(height: 12),
                AnimatedOpacity(
                  key: const ValueKey('profile-opacity'),
                  opacity: _showProfile ? 1 : 0,
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeInOut,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Samira Khan', style: TextStyle(fontSize: 18)),
                        SizedBox(height: 6),
                        Text('Flutter student'),
                        Text('Learning to make apps feel more alive.'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                OutlinedButton(
                  key: const ValueKey('opacity-button'),
                  onPressed: () {
                    setState(() {
                      _showProfile = !_showProfile;
                    });
                  },
                  child: Text(_showProfile ? 'Hide profile' : 'Show profile'),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Notice: the card keeps its space even when it is invisible.',
                  textAlign: TextAlign.center,
                ),
                const Divider(height: 48),
                Text('Lock and unlock details', style: titleStyle),
                const SizedBox(height: 12),
                AnimatedCrossFade(
                  key: const ValueKey('profile-crossfade'),
                  duration: const Duration(milliseconds: 600),
                  crossFadeState: _isUnlocked
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  firstChild: Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(minHeight: 112),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Locked', style: TextStyle(fontSize: 18)),
                        SizedBox(height: 6),
                        Text('Unlock to see the contact details.'),
                      ],
                    ),
                  ),
                  secondChild: Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(minHeight: 160),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Unlocked', style: TextStyle(fontSize: 18)),
                        SizedBox(height: 6),
                        Text('Email: samira@example.com'),
                        Text('Phone: +93 700 123 456'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                OutlinedButton(
                  key: const ValueKey('crossfade-button'),
                  onPressed: () {
                    setState(() {
                      _isUnlocked = !_isUnlocked;
                    });
                  },
                  child: Text(_isUnlocked ? 'Lock profile' : 'Unlock profile'),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Here the card also changes height as the content switches.',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ScaleTransitionLab extends StatefulWidget {
  const ScaleTransitionLab({super.key});

  @override
  State<ScaleTransitionLab> createState() => _ScaleTransitionLabState();
}

class _ScaleTransitionLabState extends State<ScaleTransitionLab>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final CurvedAnimation _curve;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _curve = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(_curve);
  }

  @override
  void dispose() {
    _curve.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Scale animation',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 12),
            const Text('Tap the button to grow the square.'),
            const SizedBox(height: 40),
            ScaleTransition(
              key: const ValueKey('scale-transition'),
              scale: _scaleAnimation,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.auto_awesome,
                  color: Colors.white,
                  size: 48,
                ),
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              key: const ValueKey('start-scale-button'),
              onPressed: () => _controller.forward(from: 0),
              child: const Text('Start animation'),
            ),
          ],
        ),
      ),
    );
  }
}
