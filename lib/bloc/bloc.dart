import 'dart:async';

import 'package:cswebapp/bloc/event.dart';
import 'package:cswebapp/pages/home_page.dart';

import '../pages/test.dart';

class Bloc {
  final _eventController = StreamController<CounterEvent>();
  Stream<CounterEvent> get eventStream => _eventController.stream;
  Sink<CounterEvent> get eventSink => _eventController.sink;

  final _pageController = StreamController<int>();
  Stream<int> get pageStream => _pageController.stream;
  Sink<int> get pageSink => _pageController.sink;

  final _pageNoController = StreamController<int>();
  Stream<int> get pageNoStream => _pageNoController.stream;
  Sink<int> get pageNoSink => _pageNoController.sink;

  Bloc() {
    eventStream.listen((CounterEvent event) {
      /// This call back will be called when new event will be added from sink

      if (event is PageChange) {
        pageSink.add(event.index);
      }
      if (event is PageNoChange) {
        pageNoSink.add(event.page);
      }
    });
  }

  /// call this method to close all the streams
  /// call this method in dispose method of stateful widget
  /// always a good practice to close all the stream at the end
  void dispose() {
    _eventController.close();
    _pageController.close();
  }
}
