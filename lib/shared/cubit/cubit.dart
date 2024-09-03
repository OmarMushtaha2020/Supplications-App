
import 'package:daily_supplications_app/shared/cubit/status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';




class AppCubit extends Cubit<AppStates>{
  AppCubit() : super(InitialState());
  static AppCubit get(context)=>BlocProvider.of(context);

}