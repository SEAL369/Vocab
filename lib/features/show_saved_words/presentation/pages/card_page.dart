import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocab/core/navigation/routes.dart' as MyRoute;
import 'package:vocab/core/ui/widgets/app_title.dart';
import 'package:vocab/core/ui/widgets/side_drawer.dart';
import 'package:vocab/features/show_saved_words/presentation/bloc/word_list_bloc.dart';
import 'package:vocab/features/show_saved_words/presentation/widgets/view_saved_words.dart';
import 'package:vocab/injection_container.dart';

class CardPage extends StatelessWidget {
  CardPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WordListBloc>(
      create: (BuildContext context) => sl(),
      child: Scaffold(
        appBar: AppBar(
          title: AppTitle(),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              tooltip: 'Add new word entry',
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '${MyRoute.Page.CardFormPage}',
                  arguments: {'isEditing': false},
                );
              },
            ),
          ],
        ),
      //  drawer: SideDrawer(page: Page.CardPage),
         drawer: SideDrawer(),
        body: ViewSavedWords(),
      ),
    );
  }
}
