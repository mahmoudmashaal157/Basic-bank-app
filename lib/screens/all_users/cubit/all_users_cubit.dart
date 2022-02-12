import 'package:basic_bank_app/models/user_model.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';

part 'all_users_state.dart';

class AllUsersCubit extends Cubit<AllUsersState> {
  AllUsersCubit() : super(AllUsersInitial());
  
   var database;
  List<UserModel>allUsersData=[];

  static AllUsersCubit get(context) => BlocProvider.of(context);

  void createDatabase ()async{
    openDatabase(
      "Bank.db",
      version: 1,

      onCreate: (database ,version){
        database.execute("CREATE TABLE USERS (id TEXT PRIMARY KEY , name TEXT ,"
            "email TEXT , phone TEXT , balance REAL)").then((value) {

          print("database Created Successfully");

        }).catchError((error){
          print("error in create Database ${error.toString()}");
        });

        database.execute("CREATE TABLE TRANSFERS (sendr TEXT , receiver TEXT ,"
            " amount REAL , date TEXT)").then((value) {
          print("Transfers table added");
        }).catchError((error){
          print("error in transfers table ${error.toString()}");
        });
      },

      onOpen:(Database database){
        this.database = database;
        print("Database Opened");
      }

    ).then((value)async {
      database = value;
      await getAllusersFromDatabase();
    });

  }

  Future getAllusersFromDatabase()async{
    allUsersData=[];
    await database.rawQuery("SELECT * FROM USERS").then((value){
      value.forEach((element){
        allUsersData.add(UserModel.fromDatabase(element));
      });
      emit(GetUsersFromDatabaseSuccessfullyState());
    }).catchError((error){
      print("error in getData from database");
      emit(GetUsersFromDatabaseErrorState());
    });
  }

  void updateUserBalance({
    required String id,
    required double newBalance
  })async{
     database.rawUpdate("UPDATE USERS SET balance ="
         " $newBalance WHERE id = $id").then((value){
      emit(UpdateBalanceSuccessfullyState());
      getAllusersFromDatabase();
    }).catchError((error){
      emit(UpdateBalanceErrorState());
      print("Error in Update Balance Addition ${error.toString()}");
    });
  }


  Future insertToTransfersHistory({
   required String sender,
    required String receiver,
    required double amount,
    required String date
  })async {
      return await database.transaction((txn)async {
      txn.rawInsert('INSERT INTO TRANSFERS (sendr,receiver,amount,date) VALUES'
          ' ("$sender","$receiver",$amount,"$date") ').then((value) {
        emit(InsertIntoTransfersTableSuccessfullyState());
      }).catchError((error){
        emit(InsertIntoTransfersTableErrorState());
      });
      return null;
    });
  }


}
