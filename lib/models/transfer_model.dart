class TransferModel{
  String? sender;
  String? receiver;
  double? amount;
  String? date;

  TransferModel({required String sender,required String receiver,required double amount,required String date}){
    this.sender=sender;
    this.receiver=receiver;
    this.amount=amount;
    this.date=date;
  }
  TransferModel.fromDatabase(Map<String,dynamic>data){
    sender=data['sendr'];
    receiver=data['receiver'];
    amount=data['amount'];
    date=data['date'];
  }
}