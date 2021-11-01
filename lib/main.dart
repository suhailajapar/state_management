import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_management/classes/counter_cubit.dart';
import 'package:state_management/classes/input_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BLoC Exercise bySuhaila',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => CounterCubit()
          ),
          BlocProvider(
            create: (context) => InputCubit()
          ),
        ],
        child: const MyHomePage(title: 'Counter App & User Input'),
      )
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String _text = "";

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.pink,
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              // Question 2 -------------------------------------------
              BlocBuilder<InputCubit, String>(
                bloc: context.read<InputCubit>(),
                builder: (context, state){
                  return Container(
                    width: 350,
                    child: Column(
                      children: [
                        Form(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    isDense: true,
                                    border: OutlineInputBorder(),
                                    labelText: "Your word",
                                    hintText: 'Enter anything!'
                                  ),
                                  onChanged: (String value) => _text = value,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top:5),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: Size(200, 30),
                                  ),
                                  child: Text(
                                    'Enter',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  onPressed: () {
                                    context.read<InputCubit>().inputs(_text);
                                  }
                                ),
                              )
                            ],
                          )
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Text(
                                'Your word:',
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              Text(
                                '$state',
                                style: TextStyle(
                                  fontSize: 24, 
                                  color: Colors.pink
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }
              ),

      // Question 1 ----------------------------------------------------
              BlocConsumer<CounterCubit, int>(
                bloc: BlocProvider.of<CounterCubit>(context),
                listener: (context, state) {
                  _incrementCounter();
                },
                builder: (context, state) {
                  return Container(
                    child: Column(
                      children: [
                        Text(
                          'You have pushed the button this many times:',
                        ),
                        Text(
                          '$_counter',
                          style: Theme.of(context).textTheme.headline4,
                        )
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      
      floatingActionButton: BlocBuilder<CounterCubit, int>(
        bloc: context.read<CounterCubit>(),
        builder: (context, state) {
          return FloatingActionButton(
            onPressed: () => context.read<CounterCubit>().increment(),
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          );
        },
      ),
    );
  }
}
