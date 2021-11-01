import 'package:flutter_bloc/flutter_bloc.dart';


//For Question 2
class InputCubit extends Cubit<String> {
  InputCubit() : super("");

  // Input field
  void inputs(strings) => emit(strings.toUpperCase());
}
