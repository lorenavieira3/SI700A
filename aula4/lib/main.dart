// main.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'tip.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const TipCalculator(),
    );
  }
}

class TipCalculator extends StatefulWidget {
  const TipCalculator({Key? key}) : super(key: key);

  @override
  _TipCalculatorState createState() => _TipCalculatorState();
}

class _TipCalculatorState extends State<TipCalculator> {
  final _formKey = GlobalKey<FormState>();
  final _tip = Tip();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de Gorjeta'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _tip.amount,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Valor Total'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um valor';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Por favor, insira um número válido';
                  }
                  return null;
                },
                onSaved: (value) => _tip.amount = value!,
              ),
              InputDecorator(
                decoration:
                    const InputDecoration(labelText: 'Gorjeta Customizada'),
                child: Slider(
                  min: 1,
                  max: 100,
                  value: double.parse(_tip.customTip),
                  onChanged: (value) {
                    setState(() {
                      _tip.customTip = value.toString();
                    });
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    setState(() {});
                  }
                },
                child: const Text('Calcular Gorjeta'),
              ),
              Text('Valor Padrão da Gorjeta: ${_tip.defaultTippedAmount}'),
              Text('Valor da Gorjeta Customizada: ${_tip.customTippedAmount}'),
              Text(
                  'Total com Gorjeta Padrão: ${_tip.amountPlusDefaultTippedAmount}'),
              Text(
                  'Total com Gorjeta Customizada: ${_tip.amountPlusCustomTippedAmount}'),
            ],
          ),
        ),
      ),
    );
  }
}
