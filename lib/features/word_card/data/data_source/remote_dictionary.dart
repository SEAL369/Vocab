import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vocab/core/error/exceptions.dart';

import 'package:vocab/features/word_card/data/models/word_search_result_model.dart';

//import 'key.dart';

abstract class RemoteDictionary {
  String get host;
  String get key;
  String get url;
  Future<WordSearchResultModel> getWordDetails(String word);
}

const String HEADER_HOST = "x-rapidapi-host";
const String HEADER_KEY = "x-rapidapi-key";

class WordsAPIRemoteDictionary implements RemoteDictionary {
  final http.Client client;

  WordsAPIRemoteDictionary({this.client});

  @override
  String get host => "wordsapiv1.p.rapidapi.com";
//String get host => WORDS_API_HOST;
  @override
  String get key => "9690b0d674msh905b65784e3ede5p106b3ejsncd4c906df18a";
//String get key => WORDS_API_KEY;
  @override
  String get url => "https://wordsapiv1.p.rapidapi.com/words/";

  @override
  Future<WordSearchResultModel> getWordDetails(String word) async {
    final response = await client.get(
      url + "$word",
      headers: {
        'Content-Type': 'application/json',
        HEADER_HOST: host,
        HEADER_KEY: key,
      },
    );

    switch (response.statusCode) {
      case 200:
        return WordSearchResultModel.fromJson(json.decode(response.body));
      case 404:
        throw NotFoundException();
      case 400:
        throw InvalidFilterException();
      case 401:
        throw UnauthorizedException();
      case 500:
        throw ServerException();
      default:
        throw UnknownException();
    }
  }
}
