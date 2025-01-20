import 'package:flutter/material.dart';

class FlashcardFace {
  String title = "";
  String description = "";
}

class Flashcard {
  UniqueKey uniqueKey = UniqueKey();
  FlashcardFace front = FlashcardFace();
  FlashcardFace back = FlashcardFace();
}

class FlashcardSet {
  FlashcardSet({
    required this.name,
  });
  String name;
  List<Flashcard> flashcards = <Flashcard>[];
}

class MyAppState extends ChangeNotifier {
  FlashcardSet? curSet;
  var sets = <FlashcardSet>[];

  void addSet(String setName) {
    sets.add(
      FlashcardSet(
        name: setName,
      ),
    );
    notifyListeners();
  }

  void addCardToSet(String setName, Flashcard card) {
    int index = sets.indexWhere((item) => item.name == setName);
    sets[index].flashcards.add(card);
    curSet = sets[index];
    notifyListeners();
  }

  void updateSet(String setName, Flashcard card) {
    int setIndex = sets.indexWhere((item) => item.name == setName);
    int cardIndex =
        sets[setIndex].flashcards.indexWhere((item) => item.uniqueKey == card.uniqueKey);
    sets[setIndex].flashcards[cardIndex] = card;
    curSet = sets[setIndex];
    notifyListeners();
  }
}

final theme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.blue,
    //cardColor: Colors.lightBlueAccent,
  ),
);

final style = theme.textTheme.displayMedium!.copyWith(
  color: theme.colorScheme.onSecondary,
);
