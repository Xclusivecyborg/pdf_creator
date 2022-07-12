import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:pdf_creator/pdf_receipt_model.dart';


///THIS IS THE EIDGET USED TO DISPLAY OUR RECEIPT DETAILS 
Page pdfPage(MemoryImage logoImage, PdfReceipt receipt,
    List<Map<String, dynamic>> details) {
  return Page(
    build: (context) {
      return Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image(
              logoImage,
              height: 95,
              width: 95,
            ),
            SizedBox(height: 20),
            Text(
              "Hi, ${receipt.sender}.",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: const PdfColor.fromInt(0xFF5AA0FF),
                font: Font.times(),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Here is the receipt for your transaction",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.normal,
                font: Font.timesItalic(),
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  ...details.map(
                    ((index) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                index["name"],
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  font: Font.timesItalic(),
                                  fontSize: 23,
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "${index["item"]}",
                                        style: TextStyle(
                                          font: Font.times(),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: const PdfColor.fromInt(
                                              0xFF5AA0FF),
                                        ),
                                        textAlign: TextAlign.right,
                                        overflow: TextOverflow.clip,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Divider(
                            thickness: 0.5,
                          ),
                          SizedBox(height: 5),
                        ],
                      );
                    }),
                  ),
                ],
              ),
            ),
            Text(
              " Thank you for choosing Flutter stores, have a nice day!",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.normal,
                font: Font.times(),
              ),
            ),
          ],
        ),
      );
    },
  );
}
