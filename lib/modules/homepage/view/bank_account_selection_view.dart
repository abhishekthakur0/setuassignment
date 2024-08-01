import 'package:flutter/material.dart';

import '../bloc/accounts_bloc.dart';
import '../widgets/bank_loading_widget.dart';
import '../widgets/bank_widget.dart';

class BankAccountSelectionView extends StatefulWidget {
  const BankAccountSelectionView({
    super.key,
    required this.selectedBanks,
    required this.selectedBankAccounts,
    required this.bloc,
    required this.onChooseBank,
    required this.onAddNewBankAccount,
    required this.onRemoveBankAccount,
  });
  final List<Map> selectedBanks;
  final List<Map> selectedBankAccounts;
  final AccountsBloc bloc;
  final Function onChooseBank;
  final Function(Map) onAddNewBankAccount;
  final Function(Map) onRemoveBankAccount;
  @override
  State<BankAccountSelectionView> createState() =>
      _BankAccountSelectionViewState();
}

class _BankAccountSelectionViewState extends State<BankAccountSelectionView>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late final AccountsBloc _bloc;
  final List<AnimationController> _animationControllers = [];
  late final ValueNotifier<Map<String, dynamic>> _loadingStatusNotifier;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    _bloc = widget.bloc;

    // Start fetching bank accounts
    _bloc.fetchBankAccounts(widget.selectedBanks);

    // Listen to the stream and update the UI
    _bloc.bankAccountsStream.listen(
      (account) {
        _addBankAccountWithAnimation(account);
      },
    );
    _loadingStatusNotifier = _bloc.loadingStatus;
    _loadingStatusNotifier.addListener(_handleLoadingStatusChange);
  }

  void _handleLoadingStatusChange() {
    if (_bloc.loadingStatus.value['isFetching'] == false) {
      setState(() {
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = true;
      });
    }
  }

  @override
  void dispose() {
    _loadingStatusNotifier.removeListener(_handleLoadingStatusChange);
    for (var controller in _animationControllers) {
      if (controller.isAnimating) {
        controller.stop(); // Stop the animation if it's still running
      }
      controller.dispose();
    }
    super.dispose(); // Call super.dispose() at the end
  }

  void _addBankAccountWithAnimation(Map account) {
    if (!mounted) return; // Check if the widget is still mounted
    final controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _animationControllers.add(controller);
    _bloc.myBankAccounts.add(account);
    controller.forward();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
          _bloc.myBankAccounts.isEmpty && !_isLoading
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
                  itemCount: _bloc.myBankAccounts.length + (_isLoading ? 1 : 0),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    if (index == _bloc.myBankAccounts.length) {
                      return const BankLoadingWidget();
                    }
                    final account = _bloc.myBankAccounts[index];
                    final controller = _animationControllers[index];
                    final isSelected =
                        widget.selectedBankAccounts.contains(account);
                    return InkWell(
                      onTap: () {
                        if (isSelected) {
                          widget.onRemoveBankAccount(account);
                        } else {
                          widget.onAddNewBankAccount(account);
                        }
                      },
                      child: FadeTransition(
                        opacity: controller,
                        child: BankWidget(
                          isSelected: isSelected,
                          bank: account,
                        ),
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
                  _isLoading ? Colors.red : Theme.of(context).primaryColor,
                ),
              ),
              onPressed: () {
                if (_isLoading) {
                  _bloc.stopFetching();
                } else {
                  _bloc.fetchBankAccounts(
                    widget.selectedBanks,
                  );
                }
              },
              child: Text(
                _isLoading ? "Stop fetching" : "Refresh accounts",
                style: const TextStyle(
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

  @override
  bool get wantKeepAlive => true;
}
