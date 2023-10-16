// show loading dialge it bloc all the app when loading
import 'package:box_time/models/boxtime_model.dart';
import 'package:box_time/provider/app_provider.dart';
import 'package:box_time/utils/extension.dart';
import 'package:box_time/utils/helper_padding.dart';
import 'package:box_time/widgets/widget_color.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void showLoadingDialog(
  BuildContext context,
) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return Consumer<AppProvider>(
        builder: (context, appProvider, child) {
          return WillPopScope(
            onWillPop: () async => true,
            child: AlertDialog(
                content: Container(
              width: double.infinity,
              height: 400,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //! from Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("From:"),
                        Text(appProvider.listBoxTime.isEmpty
                            ? DateFormat('HH:mm').format(appProvider.time!)
                            : DateFormat('HH:mm').format(appProvider
                                .listBoxTime[appProvider.listBoxTime.length - 1]
                                .to!)),
                      ],
                    ),
                    //! TO section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          child: Text("to:"),
                          onPressed: () {
                            showTimePicker(
                                    context: context,
                                    initialTime: appProvider.listBoxTime.isEmpty
                                        ? TimeOfDay.fromDateTime(
                                            appProvider.time)
                                        : TimeOfDay.fromDateTime(appProvider
                                            .listBoxTime[
                                                appProvider.listBoxTime.length -
                                                    1]
                                            .to!))
                                .then((value) {
                              appProvider.setTo = appProvider.date.applied(
                                  value ??
                                      TimeOfDay.fromDateTime(appProvider.to)
                                  // value ?? TimeOfDay.fromDateTime(appProvider.to),
                                  );
                            });
                          },
                        ),
                        appProvider.to ==
                                DateTime(
                                    appProvider.to.year,
                                    appProvider.to.month,
                                    appProvider.to.day,
                                    5,
                                    0)
                            ? const SizedBox()
                            : appProvider.listBoxTime.isNotEmpty &&
                                    appProvider.to ==
                                        appProvider
                                            .listBoxTime[
                                                appProvider.listBoxTime.length -
                                                    1]
                                            .to
                                ? const SizedBox()
                                : Text(
                                    DateFormat('HH:mm').format(
                                      appProvider.to,
                                    ),
                                  ),
                      ],
                    ),
                    //! description
                    mediumPaddingVert,
                    Text("Descripition your box"),
                    TextField(
                      controller: appProvider.goalBoxController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          // Border around the text field
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                    ),
                    //! Chosse color Section
                    mediumPaddingVert,
                    WidgetColor(
                      colorBox: appProvider.colorBox,
                    ),
                    //! button add Box
                    mediumPaddingVert,

                    Center(
                      child: ElevatedButton(
                          child: const Text("Add Box"),
                          onPressed: () {
                            if (appProvider.goalBoxController.text.isNotEmpty &&
                                appProvider.colorBox != null) {
                              appProvider.addBox(
                                BoxTimeModel(
                                  goal: appProvider.goalBoxController.text,
                                  color: appProvider.colorBox!,
                                  from: appProvider.listBoxTime.isEmpty
                                      ? appProvider.time
                                      : appProvider
                                          .listBoxTime[
                                              appProvider.listBoxTime.length -
                                                  1]
                                          .to!,
                                  to: appProvider.to,
                                ),
                              );
                              clearInfo(context);
                            } else {
                              appProvider.setRemark = true;
                            }
                          }),
                    ),
                    Center(
                      child: appProvider.remark
                          ? const Text("Every Box Need Color and Description")
                          : const SizedBox(),
                    )
                  ],
                ),
              ),
            )),
          );
        },
      );
    },
  );
}

void myShowTimePicker(BuildContext context) {
  AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
  showTimePicker(
          context: context, initialTime: const TimeOfDay(hour: 5, minute: 0))
      .then((value) {
    appProvider.setTime = appProvider.date
        .applied(value ?? TimeOfDay.fromDateTime(appProvider.time));
    //value ?? appProvider.time;
  });
}

void myShowDatePicker(BuildContext context) {
  AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
  showDatePicker(
          context: context,
          initialDate: DateTime.now().add(const Duration(days: 1)),
          firstDate: DateTime.now().add(const Duration(days: 1)),
          lastDate: DateTime(3000))
      .then((value) {
    appProvider.setDate = value ?? appProvider.date;
  });
}

clearInfo(BuildContext context) {
  AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
  appProvider.goalBoxController.clear();
  appProvider.setColor = null;

  appProvider.setTo = appProvider.to;
  appProvider.setRemark = false;
  Navigator.pop(context);
}

void showBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: 200, // Adjust the height as needed
        child: Center(
          child: Text('This is a bottom sheet'),
        ),
      );
    },
  );
}

void showSnackbar(BuildContext context, {required String msg}) {
  final snackBar = SnackBar(
    content: Text(msg),
    action: SnackBarAction(
      label: 'Undo',
      onPressed: () {
        // Action to perform when the "Undo" button is pressed.
        // You can add custom logic here.
      },
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void showAlertDialog(
  BuildContext context,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return const AlertDialog(
        title: Text('Waiting ...'),
        content: SizedBox(
          height: 50,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    },
  );
}

Future<bool> checkFirstTime() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isFirstTime = prefs.getBool('first_time') ?? true;
  if (isFirstTime) {
    // If it's the first time, set the flag to false
    await prefs.setBool('first_time', false);
  }
  return isFirstTime;
}

void showEditBox(BuildContext context,
    {required BoxTimeModel box, required int index}) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return Consumer<AppProvider>(
        builder: (context, appProvider, child) {
          return WillPopScope(
            onWillPop: () async => true,
            child: AlertDialog(
                content: Container(
              width: double.infinity,
              height: 400,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //! from Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          child: Text("From:"),
                          onPressed: () {
                            showTimePicker(
                                    context: context,
                                    initialTime:
                                        TimeOfDay.fromDateTime(box.from!))
                                .then((value) {
                              appProvider.editBox(
                                index,
                                newFrom: appProvider.date.applied(
                                  value ?? TimeOfDay.fromDateTime(box.from!),
                                ),
                              );
                            });
                          },
                        ),
                        Text(DateFormat('HH:mm').format(box.from!)),
                      ],
                    ),
                    //! TO section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          child: Text("to:"),
                          onPressed: () {
                            showTimePicker(
                                    context: context,
                                    initialTime: appProvider.listBoxTime.isEmpty
                                        ? TimeOfDay.fromDateTime(
                                            appProvider.time)
                                        : TimeOfDay.fromDateTime(appProvider
                                            .listBoxTime[
                                                appProvider.listBoxTime.length -
                                                    1]
                                            .to!))
                                .then((value) {
                              appProvider.setTo = appProvider.date.applied(
                                  value ??
                                      TimeOfDay.fromDateTime(appProvider.to)
                                  // value ?? TimeOfDay.fromDateTime(appProvider.to),
                                  );
                            });
                          },
                        ),
                        appProvider.to ==
                                DateTime(
                                    appProvider.to.year,
                                    appProvider.to.month,
                                    appProvider.to.day,
                                    5,
                                    0)
                            ? const SizedBox()
                            : appProvider.listBoxTime.isNotEmpty &&
                                    appProvider.to ==
                                        appProvider
                                            .listBoxTime[
                                                appProvider.listBoxTime.length -
                                                    1]
                                            .to
                                ? const SizedBox()
                                : Text(
                                    DateFormat('HH:mm').format(
                                      appProvider.to,
                                    ),
                                  ),
                      ],
                    ),
                    //! description
                    mediumPaddingVert,
                    Text("Descripition your box"),
                    TextField(
                      controller: appProvider.goalBoxController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          // Border around the text field
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                    ),
                    //! Chosse color Section
                    mediumPaddingVert,
                    WidgetColor(
                      colorBox: appProvider.colorBox,
                    ),
                    //! button add Box
                    mediumPaddingVert,

                    Center(
                      child: ElevatedButton(
                          child: const Text("Add Box"),
                          onPressed: () {
                            if (appProvider.goalBoxController.text.isNotEmpty &&
                                appProvider.colorBox != null) {
                              appProvider.addBox(
                                BoxTimeModel(
                                  goal: appProvider.goalBoxController.text,
                                  color: appProvider.colorBox!,
                                  from: appProvider.listBoxTime.isEmpty
                                      ? appProvider.time
                                      : appProvider
                                          .listBoxTime[
                                              appProvider.listBoxTime.length -
                                                  1]
                                          .to!,
                                  to: appProvider.to,
                                ),
                              );
                              clearInfo(context);
                            } else {
                              appProvider.setRemark = true;
                            }
                          }),
                    ),
                    Center(
                      child: appProvider.remark
                          ? const Text("Every Box Need Color and Description")
                          : const SizedBox(),
                    )
                  ],
                ),
              ),
            )),
          );
        },
      );
    },
  );
}
