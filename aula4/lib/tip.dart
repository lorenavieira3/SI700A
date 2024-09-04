// tip.dart
class Tip {
  String amount;
  String customTip;

  Tip({this.amount = '0', this.customTip = '10'});

  String get defaultTippedAmount {
    return (double.parse(amount) * 0.10).toStringAsFixed(2);
  }

  String get customTippedAmount {
    return (double.parse(amount) * double.parse(customTip) / 100)
        .toStringAsFixed(2);
  }

  String get amountPlusDefaultTippedAmount {
    return (double.parse(amount) + double.parse(defaultTippedAmount))
        .toStringAsFixed(2);
  }

  String get amountPlusCustomTippedAmount {
    return (double.parse(amount) + double.parse(customTippedAmount))
        .toStringAsFixed(2);
  }
}
