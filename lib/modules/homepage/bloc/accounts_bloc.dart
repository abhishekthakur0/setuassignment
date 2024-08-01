import 'dart:async';

import 'package:flutter/foundation.dart';

class AccountsBloc {
  final ValueNotifier<Map<String, dynamic>> loadingStatus =
      ValueNotifier<Map<String, dynamic>>({
    'isFetching': false,
    'percentage': 0,
  });

  bool _isFetching = false; // Flag to control fetching process

  final banks = [
    {
      "id": 100,
      "active": true,
      "title": "Axis Bank",
      "logo_url":
          "https://play-lh.googleusercontent.com/65bNWleT8HZ_n6NqbsdzhDIFsYW56qta2RLQWNmS4u8pECsWUVAPvT47VWbk3ZQABq-9",
    },
    {
      "id": 200,
      "active": true,
      "title": "HDFC Bank",
      "logo_url":
          "https://play-lh.googleusercontent.com/65bNWleT8HZ_n6NqbsdzhDIFsYW56qta2RLQWNmS4u8pECsWUVAPvT47VWbk3ZQABq-9",
    },
    {
      "id": 300,
      "active": true,
      "title": "ICICI Bank",
      "logo_url":
          "https://play-lh.googleusercontent.com/65bNWleT8HZ_n6NqbsdzhDIFsYW56qta2RLQWNmS4u8pECsWUVAPvT47VWbk3ZQABq-9",
    },
    {
      "id": 400,
      "active": true,
      "title": "SBI Bank",
      "logo_url":
          "https://play-lh.googleusercontent.com/65bNWleT8HZ_n6NqbsdzhDIFsYW56qta2RLQWNmS4u8pECsWUVAPvT47VWbk3ZQABq-9",
    },
    {
      "id": 500,
      "active": false,
      "title": "PNB Bank",
      "logo_url":
          "https://play-lh.googleusercontent.com/65bNWleT8HZ_n6NqbsdzhDIFsYW56qta2RLQWNmS4u8pECsWUVAPvT47VWbk3ZQABq-9",
    },
    {
      "id": 600,
      "active": false,
      "title": "Kotak Bank",
      "logo_url":
          "https://play-lh.googleusercontent.com/65bNWleT8HZ_n6NqbsdzhDIFsYW56qta2RLQWNmS4u8pECsWUVAPvT47VWbk3ZQABq-9",
    },
  ];

  final bankAccounts = [
    {
      "id": 1,
      "bank_id": 100,
      "account_number": "1234567890",
      "type": "Savings"
    },
    {
      "id": 2,
      "bank_id": 100,
      "account_number": "1234567891",
      "type": "Current"
    },
    {
      "id": 3,
      "bank_id": 300,
      "account_number": "1234567890",
      "type": "Savings"
    },
  ];

  List<Map> myBankAccounts = [];

  final StreamController<Map> bankAccountsController =
      StreamController<Map>.broadcast();
  Stream<Map> get bankAccountsStream => bankAccountsController.stream;

  fetchBankAccounts([List? selectedBanks]) async {
    myBankAccounts.clear();
    loadingStatus.value = {'isFetching': true, 'percentage': 0};
    _isFetching = true; // Set fetching flag to true
    if (selectedBanks != null && selectedBanks.isNotEmpty) {
      // Fetch bank accounts for selected banks
      for (var bank in selectedBanks) {
        if (!_isFetching) break; // Check the flag to stop fetching
        await Future.delayed(const Duration(seconds: 4));
        final int currentIndex = selectedBanks.indexOf(bank);
        final totalLength = selectedBanks.length;
        int percentage = ((currentIndex + 1) / totalLength * 100).toInt();
        loadingStatus.value = {'isFetching': true, 'percentage': percentage};
        final accountsOfThisBank = bankAccounts.where(
          (element) => element['bank_id'] == bank['id'],
        );
        for (var account in accountsOfThisBank) {
          final bankAccountPayload = {
            "id": bank['id'],
            "bank_id": bank['id'],
            "title": bank['title'],
            "logo_url": bank['logo_url'],
            "account_number": account['account_number'],
            "type": account['type'],
          };
          bankAccountsController.sink.add(bankAccountPayload);
        }
      }
    } else {
      for (var account in bankAccounts) {
        if (!_isFetching) break; // Check the flag to stop fetching
        await Future.delayed(const Duration(seconds: 4));
        final int currentIndex = bankAccounts.indexOf(account);
        final totalLength = bankAccounts.length;
        int percentage = ((currentIndex + 1) / totalLength * 100).toInt();
        loadingStatus.value = {'isFetching': true, 'percentage': percentage};
        final bank =
            banks.where((bank) => bank['id'] == account['bank_id']).first;
        final bankAccountPayload = {
          "id": account['id'],
          "bank_id": account['bank_id'],
          "title": bank['title'],
          "logo_url": bank['logo_url'],
          "account_number": account['account_number'],
          "type": account['type'],
        };
        bankAccountsController.sink.add(bankAccountPayload);
      }
    }
    loadingStatus.value = {'isFetching': false, 'percentage': 100};
    _isFetching = false; // Reset fetching flag
  }

  void stopFetching() {
    _isFetching = false; // Method to stop fetching
  }

  void dispose() {
    bankAccountsController.close();
  }
}
