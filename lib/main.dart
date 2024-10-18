import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';

void main() => runApp(PoemSwipeApp());

class PoemSwipeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Poem Swipe App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PoemSwipePage(),
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

  final List<Poem> likedPoems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Swipe Poems'),
        centerTitle: true,
      ),
      body: poems.isEmpty
          ? Center(
              child: Text(
                'That is it for today. Come back tomorrow for more poems!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
            )
          : Swiper(
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  key: UniqueKey(),
                  onDismissed: (direction) {
                    setState(() {
                      if (direction == DismissDirection.endToStart) {
                        // Swiped left, remove poem
                        poems.removeAt(index);
                      } else if (direction == DismissDirection.startToEnd) {
                        // Swiped right, like poem
                        likedPoems.add(poems[index]);
                        poems.removeAt(index);
                      }
                    });
                  },
                  background: Container(
                    color: Colors.green,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Icon(Icons.thumb_up, color: Colors.white),
                  ),
                  secondaryBackground: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Icon(Icons.thumb_down, color: Colors.white),
                  ),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    elevation: 4.0,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            poems[index].title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 16.0),
                          Text(
                            poems[index].content,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          SizedBox(height: 24.0),
                          Text(
                            "Poet: ${poems[index].poet}",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Text(
                                poems[index].details,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount: poems.length,
              itemWidth: MediaQuery.of(context).size.width * 0.9,
              itemHeight: MediaQuery.of(context).size.height * 0.75,
              layout: SwiperLayout.STACK,
            ),
    );
  }
}
