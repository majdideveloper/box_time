import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';

import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';

class PdfGenerator {
  static createPdf() async {
    String path = (await getApplicationDocumentsDirectory()).path;
    File file = File(path + "myPdf.pdf");

    Document pdf = Document();
    pdf.addPage(await createPage());

    Uint8List bytes = await pdf.save();
    await file.writeAsBytes(bytes);
    // await OpenFile.open(file.path);
  }

  static Future<Page> createPage() async {
    final font = await rootBundle.load("assets/open-sans.ttf");
    final ttf = Font.ttf(font);

    return Page(build: (context) {
      return Center(
          child: Container(
        child: Text(
          "Tunisia",
          style: TextStyle(font: ttf, fontSize: 40),
        ),
      ));
    });
  }
}
