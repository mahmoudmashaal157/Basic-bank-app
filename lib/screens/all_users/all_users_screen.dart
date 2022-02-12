import 'package:basic_bank_app/screens/all_transfers/all_transfers_screen.dart';
import 'package:basic_bank_app/screens/all_users/cubit/all_users_cubit.dart';
import 'package:basic_bank_app/screens/user_info/user_info_screen.dart';
import 'package:basic_bank_app/shared/components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/user_model.dart';

class AllUsersScreen extends StatelessWidget {

  bool isTransfer = false;
  String? senderId;
  double? senderBalance;
  double? amountTransfered;
  String? senderName;

  AllUsersScreen({
    required bool isTransfer,
    String? senderId,
    double? senderBalance,
    double? amountTransfered,
    String?senderName
  }){

    this.isTransfer = isTransfer;
    this.senderId = senderId;
    this.senderBalance = senderBalance;
    this.amountTransfered = amountTransfered;
    this.senderName=senderName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: appBarTitle(title: "Bank Users"),
      ),
      drawer: drawer(context),

      body: BlocProvider(
        create: (context) => AllUsersCubit()..createDatabase(),
        child: BlocConsumer<AllUsersCubit, AllUsersState>(
          listener: (context, state) {},
          builder: (context, state) {
            AllUsersCubit cubit = AllUsersCubit.get(context);
            return ListView.separated(
                itemBuilder: (context, index)
                =>userItem(context,cubit.allUsersData,index),

                separatorBuilder: (context, index)
                => Container(height: 2, width: double.infinity,),

                itemCount: cubit.allUsersData.length
            );
          },
        ),
      ),
    );
  }

  Widget userItem(BuildContext context,List<UserModel>users,int index) {

    if(senderId!=null && users[index].id==senderId){
      return Container();
    }

    return InkWell(
      child: Card(
        child: Container(
          height: 80,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text("${users[index].name}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                  ),
                ),
              ),

              const SizedBox(height: 10,),

              Row(
                children: [
                  Text("Id:${users[index].id}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.grey
                    ),
                  ),

                  const Spacer(),

                  Text("Balance: ${users[index].balance} \$ ",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.grey
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        if(isTransfer==true){
          transferMoney(
              amountTransfered: amountTransfered!,
              senderBalance: senderBalance!,
              receiverBalance: users[index].balance!,
              senderId: senderId!,
              receiverId: users[index].id!,
              senderName: senderName!,
              receiverName: users[index].name!,
              context: context
          );
        }

        else {
          navigateTo(
              UserInfoScreen(
            name:"${users[index].name}",
            balance: users[index].balance,
            id: '${users[index].id}',
            phone: '${users[index].phone}',
            email: '${users[index].email}',
              ),
              context
          );
        }

      },
    );
  }

  Widget drawer(BuildContext context){
    return Drawer(
      child: ListView(
        children: [
          Container(
            height: 75,
            child: const DrawerHeader(

                decoration: BoxDecoration(
                    color: Color(0xff4849bf)
                ),

                child: Center(
                  child: Text("Transfers History",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),

            ),
          ),

          Container(

            decoration: BoxDecoration(
              border:Border.all(color:Colors.black),
              borderRadius:BorderRadius.circular(20.0),
            ),

            child: ListTile(
              title:const  Text(
                "All Transfers",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold
                ),
              ),
              leading: const Icon(Icons.monetization_on_sharp, color: Color(0xff4849bf),),
              onTap: () {
                navigateTo(AllTransfersScreen(), context);
              },
            ),

          ),
        ],
      ),
    );
  }

  void transferMoney({
  required double amountTransfered,
    required double senderBalance,
    required double receiverBalance,
    required String senderId,
    required String receiverId,
    required String senderName,
    required String receiverName,
    required BuildContext context
})
  {
    double? receiverNewBalance = receiverBalance + amountTransfered;

    double? senderNewBalance = senderBalance - amountTransfered;

    AllUsersCubit.get(context).updateUserBalance
      (id: senderId, newBalance:senderNewBalance );

    AllUsersCubit.get(context).updateUserBalance
      (id:receiverId, newBalance:receiverNewBalance);

    AllUsersCubit.get(context).insertToTransfersHistory(
        sender: senderName,
        receiver: receiverName,
        amount: amountTransfered,
        date: dateTimeFormated() );

    showToast("Money Transfered Successfully");

    navigateToAndCloseAll(AllUsersScreen(isTransfer: false), context);

  }
}
