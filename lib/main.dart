import 'package:flutter/material.dart';
import 'package:flutter_bloc_state_management/state/counter_bloc.dart';
import 'package:flutter_bloc_state_management/state/counter_event.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _bloc = CounterBloc();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: StreamBuilder(
            stream: _bloc.counter,
            initialData: 0,
            builder: (context, AsyncSnapshot<int> snapshot) {
              return Container(
                child: Text('${snapshot.data}'),
              );
            },
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () => _bloc.counterEventSink.add(IncrementEvent()),
              tooltip: 'Increase',
              child: Icon(Icons.add),
            ),
            FloatingActionButton(
              onPressed: () => _bloc.counterEventSink.add(DecrementEvent()),
              tooltip: 'Decrease',
              child: Icon(Icons.remove),
            )
          ],
        ),
      ),
    );
  }
}
