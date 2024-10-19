import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const PoemSwipeApp());
}

class PoemSwipeApp extends StatelessWidget {
  const PoemSwipeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Poem Swipe App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PoemSwipePage(),
    );
  }
}

class Poem {
  final String title;
  final String content;
  final String poet;
  final String details;

  Poem({
    required this.title,
    required this.content,
    required this.poet,
    required this.details,
  });

  // Factory method to create a Poem from Firestore document
  factory Poem.fromDocument(DocumentSnapshot doc) {
    return Poem(
      title: doc['Title'] ?? 'Unknown',
      content: doc['Poem'] ?? 'No content available',
      poet: doc['Poet'] ?? 'Unknown',
      details: doc['Tags'] ?? 'No details available',
    );
  }
}

class PoemSwipePage extends StatefulWidget {
  const PoemSwipePage({super.key});

  @override
  _PoemSwipePageState createState() => _PoemSwipePageState();
}

class _PoemSwipePageState extends State<PoemSwipePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Swipe Poems'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('poems')
            .doc('dataset')
            .collection('poems_dataset')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text(
                'An error occurred while loading poems. Please try again later.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                'No poems found. Please add some poems to the database.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
            );
          }

          final poems =
              snapshot.data!.docs.map((doc) => Poem.fromDocument(doc)).toList();

          return CardSwiper(
            cardsCount: poems.length,
            allowedSwipeDirection: const AllowedSwipeDirection.symmetric(
              horizontal: true,
              vertical: false,
            ),
            cardBuilder:
                (context, index, percentThresholdX, percentThresholdY) =>
                    Container(
              alignment: Alignment.center,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    poems[index].title,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    poems[index].content,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'By: ${poems[index].poet}',
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    poems[index].details,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            onSwipe: _onSwipe,
          );
        },
      ),
    );
  }

  bool _onSwipe(
    int previousIndex,
    int? currentIndex,
    CardSwiperDirection direction,
  ) {
    debugPrint(
      'The card $previousIndex was swiped to the ${direction.name}. Now the card $currentIndex is on top',
    );
    if (direction == CardSwiperDirection.right) {
      showAnimatedFeedback(context, Icons.thumb_up_sharp, Colors.green);
    } else if (direction == CardSwiperDirection.left) {
      showAnimatedFeedback(context, Icons.thumb_down_sharp, Colors.red);
    }
    return true;
  }

  void showAnimatedFeedback(BuildContext context, IconData icon, Color color) {
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).size.height / 2 - 50,
        left: MediaQuery.of(context).size.width / 2 - 50,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.elasticOut,
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: color.withOpacity(0.8),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 50,
          ),
        ),
      ),
    );

    Overlay.of(context).insert(overlayEntry);
    Future.delayed(const Duration(seconds: 1), () => overlayEntry.remove());
  }
}
