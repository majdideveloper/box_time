import 'dart:io';

import 'package:box_time/provider/app_provider.dart';
import 'package:box_time/screen/homepage/screens/first_screen.dart';
import 'package:box_time/screen/homepage/screens/second_screen.dart';
import 'package:box_time/screen/homepage/screens/third_screen.dart';
import 'package:box_time/screen/pdf_preview.dart';

import 'package:box_time/services/pdf_creator.dart';
import 'package:box_time/utils/helper_method.dart';

import 'package:flutter/material.dart';

import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:provider/provider.dart';
import 'package:pdf/widgets.dart' as pw;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final pdf = pw.Document();
  late File? file = null;

  writeOnPDF() async {
    //Single Page Demo
    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text("Hello World"),
          );
        }));
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String documentPath = documentDirectory.path;

    File _file = File("$documentPath/sample.pdf");
    _file.writeAsBytes(await pdf.save());

    setState(() {
      file = _file;
    });

    //MultiPage Demo
    // pdf.addPage(pw.MultiPage(
    //     pageFormat: PdfPageFormat.a4,
    //     margin: const pw.EdgeInsets.all(32),
    //     build: (pw.Context context) {
    //       return <pw.Widget>[
    //         pw.Header(
    //             level: 0, child: pw.Text("Demo Sample Document First Header")),
    //         pw.Paragraph(
    //             text:
    //                 "The first personnel management department started at the National Cash Register Co. in 1900. The owner, John Henry Patterson, organized a personnel department to deal with grievances, discharges and safety, and training for supervisors on new laws and practices after several strikes and employee lockouts. During the 1970s, companies experienced globalization, deregulation, and rapid technological change which caused the major companies to enhance their strategic planning and focus on ways to promote organizational effectiveness. This resulted in developing more jobs and opportunities for people to show their skills which were directed to effective applying employees toward the fulfillment of individual, group, and organizational goals. Many years later the major/minor of human resource management was created at universities and colleges also known as business administration."),
    //         pw.Header(level: 1, child: pw.Text("Second Header")),
    //         pw.Paragraph(
    //             text:
    //                 "The second personnel management department started at the National Cash Register Co. in 1900. The owner, John Henry Patterson, organized a personnel department to deal with grievances, discharges and safety, and training for supervisors on new laws and practices after several strikes and employee lockouts. During the 1970s, companies experienced globalization, deregulation, and rapid technological change which caused the major companies to enhance their strategic planning and focus on ways to promote organizational effectiveness. This resulted in developing more jobs and opportunities for people to show their skills which were directed to effective applying employees toward the fulfillment of individual, group, and organizational goals. Many years later the major/minor of human resource management was created at universities and colleges also known as business administration."),
    //         pw.Paragraph(
    //             text:
    //                 "The third personnel management department started at the National Cash Register Co. in 1900. The owner, John Henry Patterson, organized a personnel department to deal with grievances, discharges and safety, and training for supervisors on new laws and practices after several strikes and employee lockouts. During the 1970s, companies experienced globalization, deregulation, and rapid technological change which caused the major companies to enhance their strategic planning and focus on ways to promote organizational effectiveness. This resulted in developing more jobs and opportunities for people to show their skills which were directed to effective applying employees toward the fulfillment of individual, group, and organizational goals. Many years later the major/minor of human resource management was created at universities and colleges also known as business administration.")
    //       ];
    //     }));
  }

  Future savePDF() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String documentPath = documentDirectory.path;

    File _file = File("$documentPath/sample.pdf");
    _file.writeAsBytes(await pdf.save());

    setState(() {
      file = _file;
    });
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    PageController pageController =
        PageController(initialPage: appProvider.currentIndex);

    return Scaffold(
      body: SafeArea(
        child: PageView(
          onPageChanged: (value) => appProvider.currentIndex = value,
          controller: pageController,
          children: const [
            FirstScreen(),
            SecondScreen(),
            ThirdScreen(),
          ],
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          appProvider.currentIndex == 0
              ? const SizedBox()
              : ElevatedButton(
                  child: Text("previos Step"),
                  onPressed: () {
                    pageController.previousPage(
                        duration: const Duration(milliseconds: 800),
                        curve: Curves.ease);
                  },
                ),
          ElevatedButton(
            child: appProvider.currentIndex == 2
                ? const Text("PREVIEW PDF")
                : const Text("Next Step"),
            onPressed: () async {
              if (appProvider.currentIndex == 2) {
                if (appProvider.ideaDayController.text.isEmpty) {
                  showSnackbar(context, msg: "complete  Your Idea of your Day");
                } else if (appProvider.firstGoalController.text.isEmpty) {
                  showSnackbar(context,
                      msg: "write your first goal of your Day");
                } else if (appProvider.secondGoalController.text.isEmpty) {
                  showSnackbar(context,
                      msg: "write your second goal of your Day");
                } else if (appProvider.thirdGoalController.text.isEmpty) {
                  showSnackbar(context,
                      msg: "write your third  goal of your Day");
                } else if (appProvider.listBoxTime.isEmpty) {
                  showSnackbar(context, msg: "write at least one box ");
                } else {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return PdfPreviewPage("majdouch");
                  }));
                }
              } else {
                pageController.nextPage(
                    duration: const Duration(milliseconds: 800),
                    curve: Curves.ease);
              }
            },
          ),
        ],
      ),
    );
  }
}
