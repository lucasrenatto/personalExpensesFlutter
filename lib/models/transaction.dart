class Transaction {
  final int ID;
  final String Title;
  final double Value;
  final DateTime Date;

  Transaction(
      {required this.ID,
      required this.Title,
      required this.Value,
      required this.Date});
}
