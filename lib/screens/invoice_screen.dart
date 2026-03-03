import 'package:flutter/material.dart';
import '../models/invoice_item.dart';
import '../widgets/item_card.dart';

class InvoiceScreen extends StatefulWidget {
  const InvoiceScreen({super.key});

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  final TextEditingController _clientNameCtrl = TextEditingController();
  final TextEditingController _clientEmailCtrl = TextEditingController();

  DateTime? _invoiceDate;
  final List<InvoiceItem> _items = [];

  @override
  void dispose() {
    _clientNameCtrl.dispose();
    _clientEmailCtrl.dispose();
    super.dispose();
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString();
    return '$day/$month/$year';
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final initial = _invoiceDate ?? now;

    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _invoiceDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateText = _formatDate(_invoiceDate);

    return Scaffold(
      appBar: AppBar(title: const Text('Invoice')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text(
              'Client details',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),

            TextField(
              controller: _clientNameCtrl,
              decoration: const InputDecoration(
                labelText: 'Client name',
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 12),

            TextField(
              controller: _clientEmailCtrl,
              decoration: const InputDecoration(
                labelText: 'Client email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 12),

            GestureDetector(
              onTap: _pickDate,
              child: AbsorbPointer(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Invoice date',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: _pickDate,
                      icon: const Icon(Icons.calendar_month),
                    ),
                  ),
                  controller: TextEditingController(text: dateText),
                  readOnly: true,
                ),
              ),
            ),

            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 12),

            const Text(
              'Items ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Spacer(),
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      _items.add(InvoiceItem());
                    });
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Ajouter un article'),
                ),
              ],
            ),
            const SizedBox(height: 12),

            if (_items.isEmpty)
              const Text('Aucun article ajouté')
            else
              ListView.builder(
                itemCount: _items.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final item = _items[index];
                  return ItemCard(
                    index: index,
                    item: item,
                    onDelete: () {
                      setState(() {
                        _items.removeAt(index);
                      });
                    },
                    onChanged: (updated) {
                      setState(() {
                        _items[index] = updated;
                      });
                    },
                  );
                },
              ),

            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 8),

            Builder(
              builder: (_) {
                final totalHT = _items.fold<double>(
                  0.0,
                  (sum, it) => sum + it.totalHT,
                );
                final tva = totalHT * 0.20;
                final totalTTC = totalHT + tva;

                Widget line(String label, String value, {bool bold = false}) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        Text(
                          label,
                          style: TextStyle(
                            fontWeight: bold
                                ? FontWeight.w700
                                : FontWeight.w400,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          value,
                          style: TextStyle(
                            fontWeight: bold
                                ? FontWeight.w700
                                : FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return Column(
                  children: [
                    line('Total HT', '${totalHT.toStringAsFixed(2)} €'),
                    line('TVA (20%)', '${tva.toStringAsFixed(2)} €'),
                    line(
                      'Total TTC',
                      '${totalTTC.toStringAsFixed(2)} €',
                      bold: true,
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
