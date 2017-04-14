library example;

import 'dart:async';
import 'dart:html';

import 'package:react/react_client.dart' as react_client;
import 'package:react/react_dom.dart' as react_dom;
import 'package:built_collection/built_collection.dart';
import 'package:built_redux/built_redux.dart';
import 'package:func_comp/func_comp.dart';

import 'package:example/example.dart';

Future main() async {
  react_client.setClientConfiguration();
  //
  // var actions = new TodoActions();
  // var store = new TodoStore(actions);
  //
  // react_dom.render(
  //   todosBuilder(new TodoFluxProps(store, actions)),
  //   querySelector('#container-flux'),
  // );
  //
  var reduxStore = new Store<AppState>(
    _defaultState(),
    middleware: [newGroupMiddleware, newTodoMiddleware],
  );

  react_dom.render(
    todosReduxBuilder(new ReduxProps(reduxStore)),
    querySelector('#container'),
  );
}

_defaultState() => new AppState((b) => b
  ..currentGroup = -1
  ..groups = new GroupsReducer((b) => b..groupMap = new BuiltMap<int, Group>().toBuilder())
      .toBuilder() // ..groupMap = new BuiltMap<int, Group>(),

  ..todos =
      new TodosReducer((b) => b..todosMap = new BuiltMap<int, Todo>().toBuilder()).toBuilder());