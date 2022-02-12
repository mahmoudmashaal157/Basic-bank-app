part of 'all_users_cubit.dart';

@immutable
abstract class AllUsersState {}

class AllUsersInitial extends AllUsersState {}

class GetUsersFromDatabaseSuccessfullyState extends AllUsersState{}

class GetUsersFromDatabaseErrorState extends AllUsersState{}

class UpdateBalanceSuccessfullyState extends AllUsersState{}

class UpdateBalanceErrorState extends AllUsersState{}

class InsertIntoTransfersTableSuccessfullyState extends AllUsersState{}

class InsertIntoTransfersTableErrorState extends AllUsersState{}
