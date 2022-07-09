class PdfReceipt {
  final String date;
  final String sender;
  final String beneficiary;
  final String amount;
  final String reference;

  PdfReceipt({
    required this.date,
    required this.sender,
    required this.beneficiary,
    required this.amount,
    required this.reference,
  });
}
