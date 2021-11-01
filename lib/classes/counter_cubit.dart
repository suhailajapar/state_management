import 'package:flutter_bloc/flutter_bloc.dart';


//For Question 1
class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  // Increment
  void increment() => emit(state + 1);
}
