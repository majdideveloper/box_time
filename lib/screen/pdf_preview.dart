import 'dart:io';

import 'package:box_time/models/boxtime_model.dart';
import 'package:box_time/provider/app_provider.dart';
import 'package:box_time/utils/colors.dart';
import 'package:box_time/utils/helper_method.dart';
import 'package:document_file_save_plus/document_file_save_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';

class PdfPreviewPage extends StatelessWidget {
  String? text;
  PdfPreviewPage(this.text, {Key? key}) : super(key: key);

  final pdf = pw.Document();

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Preview'),
      ),
      body: Stack(children: [
        PdfPreview(
          build: (context) => makePdf(
              goalOne: appProvider.firstGoalController.text,
              goalTwo: appProvider.secondGoalController.text,
              goalThree: appProvider.thirdGoalController.text,
              allGoalsOfDay: appProvider.ideaDayController.text,
              date: DateFormat('dd/MM/yyyy').format(appProvider.date),
              numberOfBox: appProvider.listBoxTime.length,
              listOfBox: appProvider.listBoxTime),
        ),
        Positioned(
          right: 10.0,
          bottom: 100,
          child: Container(
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(50.0), // Adjust the radius as needed
              color: Colors.grey, // You can change the color to your preference
            ),
            child: IconButton(
                tooltip: "register your Pdf",
                onPressed: () async {
                  await savePdf().then((_) => showAlertDialog(context));
                  Future.delayed(const Duration(seconds: 2), () {
                    Navigator.pop(context);
                  });
                },
                icon: const Icon(
                  Icons.save,
                  color: Colors.black,
                  size: 36,
                )),
          ),
        ),
      ]),
    );
  }

  Future<Uint8List> makePdf({
    required String goalOne,
    required String goalTwo,
    required String goalThree,
    required String allGoalsOfDay,
    required String date,
    required int numberOfBox,
    required List<BoxTimeModel> listOfBox,
  }) async {
    // final pdf = pw.Document();
    // final ByteData bytes = await rootBundle.load('assets/bigLogo.png');
    // final Uint8List byteList = bytes.buffer.asUint8List();

    pdf.addPage(pw.Page(
        margin: const pw.EdgeInsets.all(25),
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
              children: [
                pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      // pw.Divider(borderStyle: pw.BorderStyle.dashed),
                      pw.Text(
                        "Top Priorities",
                        style: pw.TextStyle(
                          fontSize: 24.0, // Title font size
                          fontWeight: pw.FontWeight.bold, // Title font weight
                        ),
                      ),
                      pw.SizedBox(height: 20),
                      pw.Container(
                        width: 200.0, // Width of the rectangle
                        height: 60.0, // Height of the rectangle
                        decoration: pw.BoxDecoration(
                          border: pw.Border.all(
                            color: PdfColor.fromInt(0xFF000000),
                          ),
                        ),
                        child: pw.Center(
                          child: pw.Text(
                            goalOne,
                            style: pw.TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                      pw.Container(
                        width: 200.0, // Width of the rectangle
                        height: 60.0, // Height of the rectangle
                        decoration: pw.BoxDecoration(
                          border: pw.Border.all(
                            color: PdfColor.fromInt(0xFF000000),
                          ),
                        ),
                        child: pw.Center(
                          child: pw.Text(
                            goalTwo,
                            style: pw.TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                      pw.Container(
                        width: 200.0, // Width of the rectangle
                        height: 60.0, // Height of the rectangle
                        decoration: pw.BoxDecoration(
                          border: pw.Border.all(
                            color: PdfColor.fromInt(0xFF000000),
                          ),
                        ),
                        child: pw.Center(
                          child: pw.Text(
                            goalThree,
                            style: pw.TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                      pw.SizedBox(height: 20),
                      pw.Text(
                        "Brain Dump",
                        style: pw.TextStyle(
                          fontSize: 24.0, // Title font size
                          fontWeight: pw.FontWeight.bold, // Title font weight
                        ),
                      ),
                      pw.SizedBox(height: 20),
                      pw.Container(
                        width: 200.0, // Width of the rectangle
                        height: 400.0, // Height of the rectangle
                        decoration: pw.BoxDecoration(
                          border: pw.Border.all(
                            color: PdfColor.fromInt(0xFF000000),
                          ),
                        ),
                        child: pw.Padding(
                          padding: pw.EdgeInsets.all(4),
                          child: pw.Text(
                            allGoalsOfDay,
                            style: pw.TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                    ]),
                //!second Column
                pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        "Date $date",
                        style: pw.TextStyle(
                          fontSize: 24.0, // Title font size
                          fontWeight: pw.FontWeight.bold, // Title font weight
                        ),
                      ),
                      pw.SizedBox(height: 20),
                      pw.ListView.separated(
                        itemBuilder: (context, index) {
                          return pw.Container(
                            height: 60,
                            width: 200,
                            decoration: pw.BoxDecoration(
                              color: PdfColor.fromInt(
                                  listOfBox[index].color.value),
                              border: pw.Border.all(
                                color: PdfColor.fromInt(0xFF000000),
                              ),
                            ),
                            child: pw.Padding(
                              padding: pw.EdgeInsets.all(2),
                              child: pw.Row(children: [
                                pw.Column(
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.spaceEvenly,
                                    children: [
                                      pw.Text("From"),
                                      pw.Text(
                                        DateFormat('HH:mm')
                                            .format(listOfBox[index].from!),
                                      ),
                                      pw.Text("To"),
                                      pw.Text(
                                        DateFormat('HH:mm')
                                            .format(listOfBox[index].to!),
                                      ),
                                    ]),
                                pw.Expanded(
                                    child: pw.Center(
                                  child: pw.Text(listOfBox[index].goal),
                                ))
                              ]),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return pw.SizedBox(height: 5);
                        },
                        itemCount: numberOfBox,
                      )
                    ]),
              ]);
        }));

    return pdf.save();
  }

  Future<void> savePdf() async {
    final DateTime time = DateTime.now();
    final date = DateFormat('dd/MM/yyyy mm:ss').format(time);

    final directory = await getExternalStorageDirectory();
    final file = File("${directory?.path}/BoxTime.pdf");

    final pdfBytes = await pdf.save();
    await file.writeAsBytes(pdfBytes.toList());

    DocumentFileSavePlus().saveMultipleFiles(
      dataList: [
        pdfBytes,
      ],
      fileNameList: [
        "boxtime$date.pdf",
      ],
      mimeTypeList: [
        "example/pdf",
      ],
    );
  }
}
