import 'package:box_time/models/boxtime_model.dart';
import 'package:box_time/provider/app_provider.dart';
import 'package:box_time/utils/extension.dart';
import 'package:box_time/utils/helper_method.dart';
import 'package:box_time/utils/helper_padding.dart';
import 'package:box_time/widgets/widget_color.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({super.key});

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  // DateTime date = DateTime.now();
  // TimeOfDay time = TimeOfDay.now();

  // void _showDatePicker() {
  //   showDatePicker(
  //           context: context,
  //           initialDate: DateTime.now(),
  //           firstDate: DateTime.now(),
  //           lastDate: DateTime(3000))
  //       .then((value) {
  //     setState(() {
  //       date = value ?? date;
  //     });
  //   });
  // }

  // void _showTimePicker() {
  //   showTimePicker(context: context, initialTime: TimeOfDay.now())
  //       .then((value) {
  //     setState(() {
  //       time = value ?? time;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);

    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //
          Center(
            child: Text(
              "Schedule day",
            ),
          ),
          mediumPaddingVert,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                child: Text("Choose Date"),
                onPressed: () {
                  myShowDatePicker(context);
                },
              ),
              Text(DateFormat('dd/MM/yyyy').format(appProvider.date)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                child: Text("Wake up Time"),
                onPressed: () {
                  myShowTimePicker(context);
                },
              ),
              Text(DateFormat('HH:mm').format(appProvider.time)),
            ],
          ),
          smallPaddingVert,
          Center(
            child: ElevatedButton(
              child: Text("+ Add Your Box Time"),
              onPressed: () {
                showLoadingDialog(context);
              },
            ),
          ),
          smallPaddingVert,
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) => Container(
                decoration: BoxDecoration(
                  color: appProvider.listBoxTime[index].color,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.black,
                    width: 2.0,
                  ),
                ),
                width: 100,
                height: 150,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              appProvider
                                  .deleteBox(appProvider.listBoxTime[index]);
                            },
                            icon: Icon(Icons.delete),
                          ),
                          // IconButton(
                          //   onPressed: () {
                          //     showEditBox(
                          //       context,
                          //       box: appProvider.listBoxTime[index],
                          //       index: index,
                          //     );
                          //   },
                          //   icon: Icon(Icons.edit),
                          // ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("From"),
                          Text(DateFormat('HH:mm')
                              .format(appProvider.listBoxTime[index].from!))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("to"),
                          Text(DateFormat('HH:mm')
                              .format(appProvider.listBoxTime[index].to!))
                        ],
                      ),
                      Text(appProvider.listBoxTime[index].goal)
                    ],
                  ),
                ),
              ),
              separatorBuilder: (context, index) => smallPaddingVert,
              itemCount: appProvider.listBoxTime.length,
            ),
          )
        ],
      ),
    );
  }
}
