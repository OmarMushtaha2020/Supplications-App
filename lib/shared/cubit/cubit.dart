
import 'package:daily_supplications_app/shared/cubit/status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';




class AppCubit extends Cubit<AppStates>{
  AppCubit() : super(InitialState());
  static AppCubit get(context)=>BlocProvider.of(context);
  late Database db;
  List<Map>supplications=[];
  void creatDd() async {
    openDatabase(
      'qwq.db',
      version: 5,
      onCreate: (db, version) {
        db.execute(
            'CREATE TABLE Tasq (id INTEGER PRIMARY KEY, title TEXT,time TEXT , date TEXT ,statue TEXT,color INTEGER,value INTEGER)')
            .then((value) {
          print("table creat");
        }).catchError((error) {
          print("error is ${error.toString()}");
        });
        print("data base creat");
      },
      onOpen: (db) {
        print("data base open");
        getListOfNewTask(db,0);
      },
    ).then((value){
      db=value;
      emit(CreatDb());
    });
  }
  Future<void> insertToDd({
    required String title,
    required String time,
    required String date,
    required int color,
    required int value,

  }) async =>
      db.transaction((txn) async{
        await txn
            .rawInsert(
            'INSERT INTO Tasq(title, time, date,statue,color,value) VALUES("$title", "$time", "$date","New","$color","$value")')

            .then((value) {

          print("$value insert succfelod");
          emit(InsertToDb());

          getListOfNewTask(db,0);


        }).catchError((error) {
          print("Error");
        });
      });

  void getListOfNewTask(db,int value)  {

    emit(LoadData());
    db.rawQuery('SELECT * FROM Tasq WHERE value =?',[value]).then((value) {
      supplications = value;

      emit(GetFormDb());
    });
  }
}