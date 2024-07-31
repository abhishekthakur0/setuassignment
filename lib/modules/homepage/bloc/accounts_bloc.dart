import 'dart:async';

class AccountsBloc {
  int loadingPercentage = 0;
  final bankAccounts = [
    {
      "id": 1,
      "bank_id": 100,
      "title": "Axis Bank",
      "logo_url":
          "https://play-lh.googleusercontent.com/65bNWleT8HZ_n6NqbsdzhDIFsYW56qta2RLQWNmS4u8pECsWUVAPvT47VWbk3ZQABq-9",
      "account_number": "1234567890",
      "type": "Savings"
    },
    {
      "id": 2,
      "bank_id": 200,
      "title": "HDFC Bank",
      "logo_url":
          "https://play-lh.googleusercontent.com/65bNWleT8HZ_n6NqbsdzhDIFsYW56qta2RLQWNmS4u8pECsWUVAPvT47VWbk3ZQABq-9",
      "account_number": "1234567890",
      "type": "Current"
    },
  ];

  final StreamController<Map> bankAccountsController =
      StreamController<Map>.broadcast();
  Stream<Map> get bankAccountsStream => bankAccountsController.stream;

  fetchBankAccounts() async {
    for (var account in bankAccounts) {
      await Future.delayed(const Duration(seconds: 4));
      final int currentIndex = bankAccounts.indexOf(account);
      final totalLength = bankAccounts.length;
      loadingPercentage = (currentIndex / totalLength * 100).toInt();
      bankAccountsController.sink.add(account);
    }
    bankAccountsController.close();
  }

  void dispose() {
    bankAccountsController.close();
  }
}
