import 'dart:async';

import 'package:flutter_bloc_state_management/state/counter_event.dart';

class CounterBloc {
  int _counter = 0;

  /// we can imagine stream controller as box one to the input and another to output
  /// input is called a sink
  /// output is called a stream
  final _counterStateController = StreamController<int>();

  StreamSink<int> get _inCounter => _counterStateController.sink;

  // for state, exposing only a stream which output data.
  // this is output of our value
  Stream<int> get counter => _counterStateController.stream;

  /// Another stream controller ..... here we will input value
  // our ui will put event incrementEvent or decrement event from ui
  final _counterEventController = StreamController<CounterEvent>();

  Sink<CounterEvent> get counterEventSink => _counterEventController.sink;

  // make constructor to listen to stream
  CounterBloc() {
    // listen to function accept the event
    _counterEventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(CounterEvent event) {
    if (event is IncrementEvent) {
      _counter++;
    } else {
      _counter--;
    }
    // add value to sink
    _inCounter.add(_counter);
  }

  void dispose() {
    _counterEventController.close();
    _counterStateController.close();
  }
}
