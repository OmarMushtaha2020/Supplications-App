import 'package:daily_supplications_app/shared/cubit/status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:vibration/vibration.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialState());
  static AppCubit get(context) => BlocProvider.of(context);
  int sum=0;
double number=0;
bool isClick=false;
   Future<void> changeValueOfClick(bool value) async {
  isClick=value;
  emit(ChangeValueOfClick());
}
  late Database db;
  List<Map> supplications = [];
Future<void> changeValueNumber(int num) async {
  if(number<num){
    number++;
    print(number);

    if(number==num){
  Future.delayed(Duration(seconds: 1)).then((value) {
    number=0;
emit(ChangeValueNumber());
  });
  Vibration.hasVibrator().then((hasVibrator) {
    if (hasVibrator ?? false) {
      // Trigger a short vibration
      Vibration.vibrate(duration: 800).then((value) {

      });
// duration in milliseconds
    }
  });

}
    emit(ChangeValueNumber());

  }

}
  void createDb() async {
    openDatabase(
      'supplications.db',
      version: 1,
      onCreate: (db, version) {
        db.execute(
          'CREATE TABLE myPrayers (id INTEGER PRIMARY KEY, title TEXT, number INTEGER)',
        ).then((value) {
          print("Table created");
        }).catchError((error) {
          print("Error during table creation: ${error.toString()}");
        });
        print("Database created");
      },
      onOpen: (db) {
        print("Database opened");
        getAllSupplications(db);
      },
    ).then((value) {
      db = value;
      emit(CreatDb());
    }).catchError((error) {
      print("Error opening database: ${error.toString()}");
    });
  }

  Future<void> insertToDb({
    required String title,
    required int number,
  }) async {
    await db.transaction((txn) async {
      await txn.rawInsert(
        'INSERT INTO myPrayers(title, number) VALUES(?, ?)',
        [title, number],
      ).then((value) {
        print(sum);
        print("Record inserted successfully with ID: $value");
        emit(InsertToDb());
        getAllSupplications(db);
      }).catchError((error) {
        print("Error during insertion: ${error.toString()}");
      });
    });
  }

  void getAllSupplications(Database db) async {
    sum=0;
    emit(LoadData());

    db.rawQuery('SELECT * FROM myPrayers').then((value) {
      supplications = value;

      int total = 0;

      for (var supplication  in supplications) {
        sum += supplication['number']as int? ??0;
      }

      print('Total sum of numbers: $total');
print(supplications);
      emit(GetFormDb());
    }).catchError((error) {
      print("Error fetching data: ${error.toString()}");
    });
  }
  void deleteElement( int id){
    db.rawDelete(
        'DELETE FROM myPrayers WHERE id = ?', [id]).then((value) {

      getAllSupplications(db);
      emit(DeleteElement());
    }) ;

  }

  void updatesDataForElement( String title,int number,int id){

changeValueOfClick(true);
    db.rawUpdate(
        'UPDATE myPrayers SET  title= ?, number=?  WHERE id = ?',
        ['$title',number, id]).then((value){
          getAllSupplications(db);

      emit(UpdateSupplication());
    });
    emit(UpdateSupplication());

  }

}
