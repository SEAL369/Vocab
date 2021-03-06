import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:vocab/core/entities/pronunciation.dart';
import 'package:vocab/core/entities/syllable.dart';
import 'package:vocab/core/entities/word_card.dart';
import 'package:vocab/core/entities/word_card_details.dart';
import 'package:vocab/core/enums/part_of_speech.dart';
import 'package:vocab/core/error/failures.dart';
import 'package:vocab/core/usecases/usecase.dart';
import 'package:vocab/features/word_save/domain/entity/word_details_keys.dart';
import 'package:vocab/features/word_save/domain/repository/word_save_repository.dart';

const String SEPERATOR = ' | ';

class InsertWordDetails extends UseCase<bool, Param> {
  final WordSaveRepository repository;

  InsertWordDetails({@required this.repository});

  @override
  Future<Either<Failure, bool>> call(Param params) async {
    final WordCard wordCard = _parse(params);

    final attemptInsertion = await repository.insertWordDetails(wordCard);
    return attemptInsertion.fold(
      (Failure l) => Left(l),
      (bool r) => _handleSuccess(r, wordCard),
    );
  }

  WordCard _parse(Param params) {
    final List<String> syllables = params
        .wordDetails[getWordDetailKeyString(WordDetailKeys.syllables)]
        .split(SEPERATOR);

    final List<WordCardDetails> detailList = [];

    params.wordDetails[getWordDetailKeyString(WordDetailKeys.senses)].forEach(
      (Map<String, dynamic> value) {
        detailList.add(
          WordCardDetails(
            id: value[getWordDetailKeyString(WordDetailKeys.senseID)],
            definition:
                value[getWordDetailKeyString(WordDetailKeys.definition)],
            partOfSpeech: ID_TO_PART_OF_SPEECH_TYPE[
                value[getWordDetailKeyString(WordDetailKeys.partOfSpeech)]],
            antonymList: value[getWordDetailKeyString(WordDetailKeys.antonyms)]
                ?.split(SEPERATOR),
            synonymList: value[getWordDetailKeyString(WordDetailKeys.synonyms)]
                ?.split(SEPERATOR),
            exampleList: value[getWordDetailKeyString(WordDetailKeys.examples)]
                ?.split(SEPERATOR),
          ),
        );
      },
    );

    return WordCard(
      id: params.wordDetails[getWordDetailKeyString(WordDetailKeys.id)],
      word: params.wordDetails[getWordDetailKeyString(WordDetailKeys.word)],
      syllables: syllables,
      detailList: detailList,
      pronunciation: params
          .wordDetails[getWordDetailKeyString(WordDetailKeys.pronunciation)],
    );
  }

  FutureOr<Either<Failure, bool>> _handleSuccess(
    bool r,
    WordCard wordCard,
  ) async {
    if (r) {
      final attemptCardCreation = await repository.createQuizCards(wordCard);
      return attemptCardCreation.fold(
        (Failure f) => Left(f),
        (bool r) => Right(r),
      );
    } else {
      return Left(DatabaseInsertionFailure());
    }
  }
}

class Param extends Equatable {
  final Map<String, dynamic> wordDetails;

  const Param({@required this.wordDetails});

  @override
  List<Object> get props => [wordDetails];
}
