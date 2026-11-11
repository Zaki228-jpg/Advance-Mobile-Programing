import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gesture Detector Lab',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const GestureLabPage(),
    );
  }
}

class GestureLabPage extends StatefulWidget {
  const GestureLabPage({super.key});

  @override
  State<GestureLabPage> createState() => _GestureLabPageState();
}

class _GestureLabPageState extends State<GestureLabPage> {
  bool _gestureColorChanged = false;
  bool _gestureFavorite = false;
  bool _inkWellColorChanged = false;
  bool _inkWellFavorite = false;
  bool _listItemFavorite = false;
  String _lastItemAction = 'No item action selected';

  void _printTapPosition(String source, TapDownDetails details) {
    debugPrint('$source local position: ${details.localPosition}');
    debugPrint('$source global position: ${details.globalPosition}');
  }

  void _printLongPressPosition(LongPressStartDetails details) {
    debugPrint('Long press local position: ${details.localPosition}');
    debugPrint('Long press global position: ${details.globalPosition}');
  }

  Future<void> _showItemActions() async {
    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(
                  _listItemFavorite ? Icons.favorite : Icons.favorite_border,
                ),
                title: Text(
                  _listItemFavorite
                      ? 'Remove from favorites'
                      : 'Add to favorites',
                ),
                onTap: () {
                  Navigator.pop(sheetContext);
                  setState(() {
                    _listItemFavorite = !_listItemFavorite;
                    _lastItemAction = _listItemFavorite
                        ? 'Added to favorites'
                        : 'Removed from favorites';
                  });
                },
              ),
              ListTile(
                leading: const Icon(Icons.archive_outlined),
                title: const Text('Archive item'),
                onTap: () {
                  Navigator.pop(sheetContext);
                  setState(() {
                    _lastItemAction = 'Item archived';
                  });
                },
              ),
              ListTile(
                leading: const Icon(Icons.share_outlined),
                title: const Text('Share item'),
                onTap: () {
                  Navigator.pop(sheetContext);
                  setState(() {
                    _lastItemAction = 'Share selected';
                  });
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GestureDetector vs InkWell'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Text(
                'Tap a card to change its color. Double-tap it to toggle the '
                'favorite icon. Tap positions are printed in the debug console.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 28),
              _buildGestureDetectorExample(),
              const SizedBox(height: 28),
              _buildInkWellExample(),
              const SizedBox(height: 28),
              _buildLongPressExample(),
              const SizedBox(height: 24),
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Comparison: both widgets detect taps, double-taps, and tap '
                    'positions. InkWell provides Material feedback (a ripple, '
                    'highlight, hover, and focus response). GestureDetector '
                    'detects gestures but provides no visual feedback by itself.',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Discoverability: long-press actions are easy to miss '
                    'because they are hidden and leave no visual clue. The '
                    'visible Actions button exposes the same bottom sheet for '
                    'people who do not know or cannot use the gesture.',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGestureDetectorExample() {
    return Column(
      children: [
        Text('GestureDetector', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 10),
        GestureDetector(
          key: const Key('gesture-card'),
          onTapDown: (details) => _printTapPosition('GestureDetector', details),
          onTap: () {
            setState(() {
              _gestureColorChanged = !_gestureColorChanged;
            });
          },
          onDoubleTap: () {
            setState(() {
              _gestureFavorite = !_gestureFavorite;
            });
          },
          child: Container(
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
              color: _gestureColorChanged
                  ? Colors.orange.shade300
                  : Colors.indigo.shade300,
              borderRadius: BorderRadius.circular(20),
            ),
            child: _CardContents(
              label: 'No built-in ripple',
              isFavorite: _gestureFavorite,
              favoriteKey: const Key('gesture-favorite'),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInkWellExample() {
    return Column(
      children: [
        Text('InkWell', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 10),
        Material(
          color: _inkWellColorChanged
              ? Colors.teal.shade300
              : Colors.purple.shade300,
          borderRadius: BorderRadius.circular(20),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            key: const Key('inkwell-card'),
            onTapDown: (details) => _printTapPosition('InkWell', details),
            onTap: () {
              setState(() {
                _inkWellColorChanged = !_inkWellColorChanged;
              });
            },
            onDoubleTap: () {
              setState(() {
                _inkWellFavorite = !_inkWellFavorite;
              });
            },
            child: SizedBox(
              width: double.infinity,
              height: 150,
              child: _CardContents(
                label: 'Material ripple feedback',
                isFavorite: _inkWellFavorite,
                favoriteKey: const Key('inkwell-favorite'),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLongPressExample() {
    return Column(
      children: [
        Text(
          'Long-press card item',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 10),
        GestureDetector(
          key: const Key('long-press-card'),
          onLongPressStart: _printLongPressPosition,
          onLongPress: _showItemActions,
          child: Card(
            margin: EdgeInsets.zero,
            child: ListTile(
              contentPadding: const EdgeInsets.fromLTRB(16, 10, 8, 10),
              leading: CircleAvatar(
                child: Icon(
                  _listItemFavorite ? Icons.favorite : Icons.description,
                  key: const Key('item-state-icon'),
                ),
              ),
              title: const Text('Lecture notes'),
              subtitle: Text('Long-press for actions\n$_lastItemAction'),
              isThreeLine: true,
              trailing: TextButton.icon(
                key: const Key('item-actions-button'),
                onPressed: _showItemActions,
                icon: const Icon(Icons.more_vert),
                label: const Text('Actions'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _CardContents extends StatelessWidget {
  const _CardContents({
    required this.label,
    required this.isFavorite,
    required this.favoriteKey,
  });

  final String label;
  final bool isFavorite;
  final Key favoriteKey;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            key: favoriteKey,
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: isFavorite ? Colors.red.shade700 : Colors.white,
            size: 44,
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: Theme.of(context).textTheme.titleMedium
                ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
