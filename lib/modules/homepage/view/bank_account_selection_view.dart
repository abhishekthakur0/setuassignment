import 'package:flutter/material.dart';

import '../bloc/accounts_bloc.dart';
import '../widgets/bank_loading_widget.dart';
import '../widgets/bank_widget.dart';

class BankAccountSelectionView extends StatefulWidget {
  const BankAccountSelectionView({
    super.key,
    required this.bloc,
    required this.onChooseBank,
  });
  final AccountsBloc bloc;
  final Function onChooseBank;
  @override
  State<BankAccountSelectionView> createState() =>
      _BankAccountSelectionViewState();
}

class _BankAccountSelectionViewState extends State<BankAccountSelectionView>
    with TickerProviderStateMixin {
  late final AccountsBloc _bloc;
  final List<Map> _bankAccounts = [];
  final List<AnimationController> _animationControllers = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    _bloc = widget.bloc;

    // Start fetching bank accounts
    _bloc.fetchBankAccounts();

    // Listen to the stream and update the UI
    _bloc.bankAccountsStream.listen(
      (account) {
        _addBankAccountWithAnimation(account);
      },
      onDone: () {
        setState(() {
          _isLoading = false;
        });
      },
    );
  }

  @override
  void dispose() {
    for (var controller in _animationControllers) {
      controller
          .dispose(); // Ensure each AnimationController is properly disposed
    }
    _bloc.dispose(); // Dispose the BLoC
    super.dispose(); // Call super.dispose() at the end
  }

  void _addBankAccountWithAnimation(Map account) {
    final controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _animationControllers.add(controller);
    _bankAccounts.add(account);
    controller.forward();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _isLoading ? "Fetching bank accounts" : "Select bank accounts",
            style: const TextStyle(
              fontSize: 20.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          _bankAccounts.isEmpty && !_isLoading
              ? Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline,
                          color: Theme.of(context).primaryColor),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'Sorry, no accounts found!',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      TextButton(
                        onPressed: () {},
                        style: const ButtonStyle(
                          visualDensity: VisualDensity.compact,
                        ),
                        child: const Text(
                          "Help",
                          style: TextStyle(
                            color: Colors.blueAccent,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: _bankAccounts.length + (_isLoading ? 1 : 0),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    if (index == _bankAccounts.length) {
                      return const BankLoadingWidget();
                    }
                    final account = _bankAccounts[index];
                    final controller = _animationControllers[index];
                    return FadeTransition(
                      opacity: controller,
                      child: BankWidget(
                        bank: account,
                      ),
                    );
                  },
                ),
          const SizedBox(
            height: 50.0,
          ),
          Center(
            child: TextButton(
              style: ButtonStyle(
                foregroundColor: WidgetStateProperty.all<Color>(
                  Theme.of(context).primaryColor,
                ),
              ),
              onPressed: () {},
              child: const Text(
                "Refresh accounts",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Center(
            child: TextButton(
              style: ButtonStyle(
                foregroundColor: WidgetStateProperty.all<Color>(
                  Theme.of(context).primaryColor,
                ),
              ),
              onPressed: () {
                widget.onChooseBank();
              },
              child: const Text(
                "Choose again",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
