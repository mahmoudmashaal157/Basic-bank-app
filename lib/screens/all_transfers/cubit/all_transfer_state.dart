part of 'all_transfer_cubit.dart';

@immutable
abstract class AllTransferState {}

class AllTransferInitial extends AllTransferState {}

class OpenDatabaseForTransfersSuccessfullyState extends AllTransferState {}

class OpenDatabaseForTransfersErrorState extends AllTransferState {}

class GetAllTransfersSuccessfullyState extends AllTransferState {}

class GetAllTransfersErrorState extends AllTransferState {}

