class InvoiceItem {
  String description;
  int quantity;
  double unitPriceHT;

  InvoiceItem({
    this.description = '',
    this.quantity = 1,
    this.unitPriceHT = 0.0,
  });

  double get totalHT => quantity * unitPriceHT;

  InvoiceItem copyWith({
    String? description,
    int? quantity,
    double? unitPriceHT,
  }) {
    return InvoiceItem(
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      unitPriceHT: unitPriceHT ?? this.unitPriceHT,
    );
  }
}
