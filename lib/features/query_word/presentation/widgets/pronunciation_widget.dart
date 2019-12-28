import 'package:flutter/material.dart';
import 'package:vocab/features/query_word/domain/entities/pronunciation.dart';
import 'package:vocab/features/query_word/presentation/widgets/subtitle_text.dart';
import 'package:vocab/features/query_word/presentation/widgets/title_text.dart';

class PronunciationWidget extends StatelessWidget {
  final int index;
  final Pronunciation pronunciation;

  const PronunciationWidget({
    Key key,
    @required this.index,
    @required this.pronunciation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextStyle subtitleStyle = Theme.of(context).textTheme.subtitle;
    final List<Widget> children = [
      TitleText(text: 'Pronunciation #$index'),
      Text('Dialect(s)', style: subtitleStyle),
      Column(
        children: List.from(
          pronunciation.dialectList.map((String e) => Text(e)),
        ),
      ),
      SubtitleText(
        text: 'Phonetic Notation: ${pronunciation.phoneticNotation}',
      ),
      SubtitleText(
        text: 'Phonetic Spelling: ${pronunciation.phoneticSpelling}',
      )
    ];

    if (pronunciation.audioFileUrl != null)
      children.add(IconButton(
        icon: Icon(Icons.play_arrow),
        onPressed: () {
          // TODO: Pronunciation playing
        },
      ));

    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}
