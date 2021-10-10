import 'dart:math';

class Constants {
  static const String END_POINTS = "https://jsonplaceholder.typicode.com/";
  static const List<String> _MOCK_BACKGROUNDS = [
    "https://img.freepik.com/free-vector/white-abstract-background_23-2148810113.jpg?size=626&ext=jpg",
    "https://img.freepik.com/free-photo/hand-painted-watercolor-background-with-sky-clouds-shape_24972-1095.jpg?size=626&ext=jpg&ga=GA1.2.1908636980.1633737600",
    "https://img.freepik.com/free-vector/wavy-background-with-copy-space_52683-65230.jpg?size=626&ext=jpg",
    "https://image.freepik.com/free-photo/top-view-background-beautiful-white-grey-brown-cream-blue-background_140725-72219.jpg"
  ];

  static get MOCK_IMAGE {
    final rnd = Random().nextInt(_MOCK_BACKGROUNDS.length);
    return _MOCK_BACKGROUNDS[rnd];
  }
}
