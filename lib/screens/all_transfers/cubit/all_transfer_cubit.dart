import 'package:basic_bank_app/models/transfer_model.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';

part 'all_transfer_state.dart';

class AllTransferCubit extends Cubit<AllTransferState> {
  AllTransferCubit() : super(AllTransferInitial());

  List<TransferModel>allTransfers=[];
  var database;

  static AllTransferCubit get(context)=>BlocProvider.of(context);

  Future<void> openTheDatabase()async{
   await openDatabase(
      'Bank.db',
      version:1,
      onOpen: (Database database){
        this.database=database;
      }
    ).then((value) {
      emit(OpenDatabaseForTransfersSuccessfullyState());
      getAllTransfersData(value);
   }).catchError((error){
     emit(OpenDatabaseForTransfersErrorState());
     print("error in opening database for Transfers ${error.toString()}");
   });
  }

  void getAllTransfersData(Database database){
    database.rawQuery("SELECT * FROM TRANSFERS").then((value){
      value.forEach((element){
        allTransfers.add(TransferModel.fromDatabase(element));

      });
      emit(GetAllTransfersSuccessfullyState());
    }).catchError((error){
      emit(GetAllTransfersErrorState());
      print("Error in get all Transfers ${error.toString()}");
    });
  }

}
