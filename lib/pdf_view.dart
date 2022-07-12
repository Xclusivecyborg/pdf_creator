import 'package:flutter/material.dart';
import 'package:pdf_creator/pdf_creator.dart';
import 'package:pdf_creator/pdf_receipt_model.dart';

class PdfView extends StatefulWidget {
  const PdfView({Key? key}) : super(key: key);

  @override
  State<PdfView> createState() => _PdfViewState();
}

class _PdfViewState extends State<PdfView> {
  //WE CREATE A PDFRECEIPT OBJECT AND PASS IN THE VALUES WE WANT TO DISPLAY ON THE SCREEN
  final PdfReceipt receipt = PdfReceipt(
    reference: "123456789",
    date: "2022-01-01",
    amount: "\$ 4,000.00",
    sender: "Ayodeji Ogundairo",
    beneficiary: "Flutter stores",
  );

  //WE CREATE A BOOLEAN VARIABLE THAT HELPS US MANAGE THE STATE OF OUR VIEW
  //WHEN WE ARE CREATING THE PDF WE SET IT TO TRUE AND WHEN WE ARE DONE WE SET IT TO FALSE
  //WHEN THIS IS TRUE A CIRCULAR_PROGRESS_INDICATOR IS DISPLAYED IN PLACE OF OUR ELEVATED_BUTTON
  bool isCreating = false;
  @override
  Widget build(BuildContext context) {
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
                  ///here we set the isCreating variable to true so that we can display a circular progress indicator
                  setState(() {
                    isCreating = true;
                  });
                  final file = await PdfCreator.createPdf(
                    receipt: receipt,
                  );

                  ///here we set the isCreating variable to false so that we can display the button again
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
