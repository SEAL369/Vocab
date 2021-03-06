import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vocab/core/navigation/routes.dart' as MyRoute;
import 'core/database/card_database.dart';
import 'package:provider/provider.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(Vocab());
}

class Vocab extends StatelessWidget {
  const Vocab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<CardDatabase>(
      create: (BuildContext context) => di.sl(),
      child: MaterialApp(
        theme: ThemeData(primaryColor: Colors.blue),
        initialRoute: '${MyRoute.Page.QuizPage}',
        onGenerateRoute: MyRoute.generateRoute,
      ),
    );
  }
}
