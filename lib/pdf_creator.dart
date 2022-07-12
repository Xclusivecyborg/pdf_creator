import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';
import 'package:pdf_creator/pdf_receipt_model.dart';
import 'package:pdf_creator/pdf_widget.dart';

class PdfCreator {
  ///THIS METHOD IS USED TO CREATE OUR PDF
  ///WE USE THE WIDGEETS FROM THE PDF PACKAGE TO CREATE OUR PDF AND RETURN THE FILE WHEN
  ///WE ARE DONE.
  ///
  static Future<File?> createPdf({
    required PdfReceipt receipt,
  }) async {
    final pdf = Document();

///WE MAP THE VALUES FROM OUR RECEIPT OBJECT TO OUR PDF WIDGETS      
    List<Map<String, dynamic>> details = [
      {
        "name": "Transaction reference",
        "item": receipt.reference,
      },
      {
        "name": "Date",
        "item": receipt.date,
      },
      {
        "name": "Amount",
        "item": receipt.amount,
      },
      {
        "name": "Beneficiary",
        "item": receipt.beneficiary,
      },
    ];

//THIS HELPS US LOAD THE FLUTTER LOGO FROM OUR ASSETS FOLDER
    ByteData logo = await rootBundle.load('assets/flutter.png');
    Uint8List logoBytes = logo.buffer.asUint8List();
    MemoryImage logoImage = MemoryImage(logoBytes);


///WE CALL THE addPage METHOD ON OUR PDF OBJECT TO CREATE A PAGE THAT WILL TAKE IN THE 
///DETAILS FROM OUR RECEIPT AND THE FLUTTER LOGO WE LOADED ABOVE.  
    pdf.addPage(
      pdfPage(logoImage, receipt, details),
    );

//THIS SAVES OUR PDF TO OUR DEVICE
    final file = PdfCreator.saveDocument(
      pdf: pdf,
      name: "${receipt.reference}_${receipt.date}.pdf",
    );
    return file;
  }

  //THIS METHOD HELPS US OPEN OUR CREATED PDF FILE USING THE
  //open_file PACKAGE FROM PUB.DEV
  static Future openFile(File file) async {
    await OpenFile.open(file.path);
  }

//THIS METHODS SAVES OUR CREATED PDF INTO OUR DEVICE'S STORAGE
  static Future<File> saveDocument({
    required String name,
    required Document pdf,
  }) async {
    final bytes = await pdf.save();
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');
    await file.writeAsBytes(bytes);
    return file;
  }
}
