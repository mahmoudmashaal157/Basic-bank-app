import 'package:basic_bank_app/screens/all_transfers/cubit/all_transfer_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/transfer_model.dart';
import '../../shared/components/components.dart';

class AllTransfersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: appBarTitle(title: "Transfers History"),
      ),
      body: BlocProvider(
        create: (context) => AllTransferCubit()..openTheDatabase(),
        child: BlocConsumer<AllTransferCubit, AllTransferState>(
          listener: (context, state) {},
          builder: (context, state) {
            AllTransferCubit cubit = AllTransferCubit.get(context);

            return ListView.separated(
                itemBuilder: (BuildContext context, int index)
                => TransferItem(index, context, cubit.allTransfers),

                separatorBuilder: (BuildContext context, int index)=> seperator(),
                itemCount: cubit.allTransfers.length);
          },
        ),
      ),
    );
  }

  Widget TransferItem(
      int index, BuildContext context, List<TransferModel> trns) {
    return Card(

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),

      child: Padding(
        padding: const EdgeInsets.only(left: 10.0),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [

                Text(
                  "${trns[index].sender}",
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),

                const SizedBox(
                  width: 10,
                ),

                const Icon(
                  Icons.arrow_forward_sharp,
                  size: 30,
                ),

                const SizedBox(
                  width: 10,
                ),

                Text(
                  "${trns[index].receiver}",
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),

              ],
            ),
            const SizedBox(
              height: 10,
            ),

            Text(
              "Money :${trns[index].amount} \$",
              style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 17
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            Text(
              "Date : ${trns[index].date}",
              style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 17
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget seperator(){
    return const SizedBox(
      height: 10,
    );
  }


}
