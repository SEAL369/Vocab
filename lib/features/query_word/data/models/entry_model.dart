import 'package:vocab/features/query_word/domain/entities/entry.dart';

import 'sense_model.dart';
import 'pronunciation_model.dart';
import 'base_info_model.dart';
import 'variant_form_model.dart';

/// [EntryModel] class
/// [etymologyList] (List[String], optional): The origin of the word and the way in which its meaning has changed throughout history ,
/// [grammaticalFeatureList] (List[BaseInfoModel], optional),
/// [homographNumber] (string, optional): Identifies the homograph grouping. The last two digits identify different entries of the same homograph. The first one/two digits identify the homograph number. ,
/// [noteList] (List[BaseInfoModel], optional),
/// [pronunciationList] (List[PronunciationModel], optional),
/// [senseList] (Array[SenseModel], optional): Complete list of senses ,
/// [variantForms] (List[VariantFormModel], optional): Various words that are used interchangeably depending on the context, e.g 'a' and 'an'
class EntryModel extends Entry {
  EntryModel({
    List<String> etymologyList,
    List<BaseInfoModel> grammaticalFeatureList,
    String homographNumber,
    List<BaseInfoModel> noteList,
    List<PronunciationModel> pronunciationList,
    List<SenseModel> senseList,
    List<VariantFormModel> variantFormList,
  }) : super(
          etymologyList: etymologyList,
          grammaticalFeatureList: grammaticalFeatureList,
          homographNumber: homographNumber,
          noteList: noteList,
          pronunciationList: pronunciationList,
          senseList: senseList,
          variantFormList: variantFormList,
        );

  factory EntryModel.fromJson(Map<String, dynamic> json) {
    final Function toBaseinfoList = (key) => List<BaseInfoModel>.from(
          json[key].map((element) => BaseInfoModel.fromJson(element)),
        );
    final Function toPronunciationList = (key) => List<PronunciationModel>.from(
          json[key].map((element) => PronunciationModel.fromJson(element)),
        );
    final Function toSenseList = (key) => List<SenseModel>.from(
          json[key].map((element) => SenseModel.fromJson(element)),
        );
    final Function toVariantFormList = (key) => List<VariantFormModel>.from(
          json[key].map((element) => VariantFormModel.fromJson(element)),
        );
    return EntryModel(
      etymologyList: List<String>.from(json['etymologies']),
      grammaticalFeatureList: toBaseinfoList('grammaticalFeatures'),
      homographNumber: json['homographNumber'],
      noteList: toBaseinfoList('notes'),
      pronunciationList: toPronunciationList('pronunciations'),
      senseList: toSenseList('senses'),
      variantFormList: toVariantFormList('variantForms'),
    );
  }

  Map<String, dynamic> toJson() {
    final Function toString = (element) => element.toJson();
    final Map<String, dynamic> json = {};

    json['etymologies'] = this.etymologyList;
    json['homographNumber'] = this.homographNumber;
    json['notes'] = this.noteList.map(toString);
    json['grammaticalFeatures'] = this.grammaticalFeatureList.map(toString);
    json['pronunciations'] = this.pronunciationList.map(toString);
    json['senses'] = this.senseList.map(toString);
    json['variantForms'] = this.variantFormList.map(toString);

    return json;
  }
}
