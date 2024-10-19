import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

void main() => runApp(const PoemSwipeApp());

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

  Poem(
      {required this.title,
      required this.content,
      required this.poet,
      required this.details});
}

class PoemSwipePage extends StatefulWidget {
  const PoemSwipePage({super.key});

  @override
  _PoemSwipePageState createState() => _PoemSwipePageState();
}

class _PoemSwipePageState extends State<PoemSwipePage> {
  final List<Poem> poems = [
    Poem(
        title: "Roses are Red",
        content:
            "Roses are red,\nViolets are blue,\nFlutter is awesome,\nAnd so are you!",
        poet: "Anonymous",
        details:
            "This is a classic short poem that is often used in a variety of contexts. The author is unknown, but it remains popular for its simplicity and charm."),
    Poem(
        title: "Sunset Sky",
        content:
            "The sun sets low,\nThe moon begins to rise,\nStars paint the sky,\nLike glitter in our eyes.",
        poet: "Jane Doe",
        details:
            "Jane Doe is a contemporary poet known for her vivid imagery and ability to capture nature's beauty in a few simple lines."),
    Poem(
        title: "Whispers of Nature",
        content:
            "A gentle breeze,\nWhispers through the trees,\nNature's secret language,\nPuts my mind at ease.",
        poet: "John Smith",
        details:
            "John Smith's poetry often focuses on the tranquil aspects of nature, providing readers with a sense of calm and reflection."),
    Poem(
        title: "Wanderlust",
        content:
            "Mountains high,\nValleys deep,\nWanderlust calls,\nMy soul to keep.",
        poet: "Emily White",
        details:
            "Emily White is an adventurer and poet who finds inspiration in her travels. Her work often speaks to the longing for exploration and discovery."),
    Poem(
        title: "Ocean's Song",
        content:
            "The waves crash,\nUpon the shore,\nNature's music,\nI can never ignore.",
        poet: "Michael Green",
        details:
            "Michael Green's poetry is heavily influenced by his love for the ocean. He often writes about the relationship between humans and the sea."),
    Poem(
        title: "City Lights",
        content:
            "The city lights,\nShining bright,\nNeon glows,\nThroughout the night.",
        poet: "Lisa Brown",
        details:
            "Lisa Brown captures the energy of urban life in her poetry, using vivid descriptions to bring the city to life for her readers."),
    Poem(
        title: "Autumn Leaves",
        content:
            "The autumn leaves,\nFalling slow,\nPainting paths,\nWherever they go.",
        poet: "Robert Black",
        details:
            "Robert Black is known for his seasonal poetry, often focusing on the changing aspects of nature and the passage of time."),
    Poem(
        title: "Rain's Lullaby",
        content:
            "Rain falls softly,\nOn the roof above,\nNature's lullaby,\nA song of love.",
        poet: "Sophie Gray",
        details:
            "Sophie Gray finds inspiration in the small, quiet moments of life. Her poetry often reflects a deep appreciation for the beauty in everyday occurrences."),
    Poem(
        title: "Blooming Beauty",
        content:
            "A blooming flower,\nPetals so bright,\nA burst of color,\nA pure delight.",
        poet: "Anna Lee",
        details:
            "Anna Lee's work is filled with bright, colorful imagery that brings her love for flowers and gardening to the forefront."),
    Poem(
        title: "Midnight Sky",
        content:
            "The midnight sky,\nA dark embrace,\nTwinkling stars,\nLighting up the space.",
        poet: "David Brown",
        details:
            "David Brown is a poet who often writes about the night and the cosmos, exploring the mysteries of the universe through his work."),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Swipe Poems'),
        centerTitle: true,
      ),
      body: poems.isEmpty
          ? const Center(
              child: Text(
                'That is it for today. Come back tomorrow for more poems!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
            )
          : CardSwiper(
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
                  children: [
                    Container(child: Text(poems[index].title)),
                    Container(child: Text(poems[index].content)),
                    Container(child: Text(poems[index].poet)),
                    Container(child: Text(poems[index].details)),
                  ],
                ),
              ),
              onSwipe: _onSwipe,
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
      setState(() {});
    } else if (direction == CardSwiperDirection.left) {
      showAnimatedFeedback(context, Icons.thumb_down_sharp, Colors.red);
      setState(() {
        poems.removeAt(previousIndex);
      });
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
