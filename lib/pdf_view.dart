import 'package:flutter/material.dart';
import 'package:pdf_creator/pdf_creator.dart';
import 'package:pdf_creator/pdf_receipt_model.dart';

class PdfView extends StatefulWidget {
  const PdfView({Key? key}) : super(key: key);

  @override
  State<PdfView> createState() => _PdfViewState();
}

class _PdfViewState extends State<PdfView> {
  bool isCreating = false;
  @override
  Widget build(BuildContext context) {
    final PdfReceipt receipt = PdfReceipt(
        reference: "123456789",
        date: "2022-01-01",
        amount: "\$ 4,000.00",
        sender: "Ayodeji Ogundairo",
        beneficiary: "Flutter stores");
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF View'),
      ),
      body: Center(
        child: isCreating
            ? const CircularProgressIndicator()
            : ElevatedButton(
                child: const Text('Open PDF'),
                onPressed: () async {
                  setState(() {
                    isCreating = true;
                  });
                  final file = await PdfCreator.createPdf(
                    receipt: receipt,
                  );
                  if (file != null) {
                    setState(() {
                      isCreating = false;
                    });
                    await PdfCreator.openFile(file);
                  }
                },
              ),
      ),
    );
  }
}
