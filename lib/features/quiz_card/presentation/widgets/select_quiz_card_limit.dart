import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocab/features/quiz_card/presentation/bloc/bloc.dart';

class SelectQuizCardLimit extends StatefulWidget {
  SelectQuizCardLimit({Key key}) : super(key: key);

  @override
  _SelectQuizCardLimitState createState() => _SelectQuizCardLimitState();
}

class _SelectQuizCardLimitState extends State<SelectQuizCardLimit> {
  QuizBloc _bloc;
  double _limit = 25;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = Provider.of<QuizBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            child: Text("Quiz only on words added today."),
            textTheme: ButtonTextTheme.primary,
            color: Theme.of(context).accentColor,
            onPressed: () {
              _bloc.add(InitiateQuizEvent(fetchOnlyToday: true));
            },
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                Expanded(flex: 1, child: Divider(thickness: 2)),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Or', style: Theme.of(context).textTheme.display1),
                ),
                Expanded(flex: 1, child: Divider(thickness: 2)),
              ],
            ),
          ),
          Text(
            "Quiz on ${_limit.toInt()} cards?",
            style: Theme.of(context).textTheme.headline,
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 8.0,
            ),
            child: Slider(
              value: _limit,
              max: 50,
              min: 10,
              divisions: 8,
              label: "$_limit",
              onChanged: (double value) {
                setState(() {
                  _limit = value;
                });
              },
            ),
          ),
          RaisedButton(
            child: Text("Begin quiz"),
            textTheme: ButtonTextTheme.primary,
            color: Theme.of(context).accentColor,
            onPressed: () {
              _bloc.add(InitiateQuizEvent(limit: _limit.toInt()));
            },
          ),
        ],
      ),
    );
  }
}
