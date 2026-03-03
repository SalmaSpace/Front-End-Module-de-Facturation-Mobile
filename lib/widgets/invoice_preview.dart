import 'package:flutter/material.dart';
import '../models/invoice_item.dart';

class InvoicePreview extends StatelessWidget {
  final String clientName;
  final String clientEmail;
  final DateTime? invoiceDate;
  final List<InvoiceItem> items;

  const InvoicePreview({
    super.key,
    required this.clientName,
    required this.clientEmail,
    required this.invoiceDate,
    required this.items,
  });

  String _formatDate(DateTime? date) {
    if (date == null) return '-';
    final d = date.day.toString().padLeft(2, '0');
    final m = date.month.toString().padLeft(2, '0');
    final y = date.year.toString();
    return '$d/$m/$y';
  }

  @override
  Widget build(BuildContext context) {
    final totalHT = items.fold<double>(0.0, (sum, it) => sum + it.totalHT);
    final tva = totalHT * 0.20;
    final totalTTC = totalHT + tva;

    return ListView(
      children: [
        // ===== HEADER BLEU =====
        Container(
          width: double.infinity,
          color: Colors.blue.shade800,
          padding: const EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(width: 16),
              const Expanded(
                child: Text(
                  'FACTURE',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Mon Entreprise',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '22 Avenue Lenine\n75000 Paris',
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ],
          ),
        ),

        // ===== CORPS BLANC =====
        Container(
          color: Colors.white,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Bloc client + date
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Client :',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(clientName.isEmpty ? '-' : clientName),
                        const SizedBox(height: 4),
                        Text(clientEmail.isEmpty ? '-' : clientEmail),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          'Date :',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(_formatDate(invoiceDate)),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),
              Divider(color: Colors.blue.shade800, thickness: 1),
              const SizedBox(height: 8),

              const Text(
                'Articles',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              if (items.isEmpty)
                const Text('Aucun article ajouté')
              else ...[
                const Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Text(
                        'Description',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        'Qté',
                        textAlign: TextAlign.right,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        'PU',
                        textAlign: TextAlign.right,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        'Total',
                        textAlign: TextAlign.right,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Divider(color: Colors.blue.shade800, thickness: 1),
                for (final it in items)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Text(
                            it.description.isEmpty ? '-' : it.description,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            '${it.quantity}',
                            textAlign: TextAlign.right,
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            '${it.unitPriceHT.toStringAsFixed(2)} €',
                            textAlign: TextAlign.right,
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            '${it.totalHT.toStringAsFixed(2)} €',
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],

              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 8),

              Align(
                alignment: Alignment.centerRight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('Total HT : ${totalHT.toStringAsFixed(2)} €'),
                    Text('TVA (20%) : ${tva.toStringAsFixed(2)} €'),
                    const SizedBox(height: 6),
                    Text(
                      'Total TTC : ${totalTTC.toStringAsFixed(2)} €',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade800,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
