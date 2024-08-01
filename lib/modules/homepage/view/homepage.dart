import 'package:flutter/material.dart';
import 'package:setuassignment/modules/homepage/bloc/accounts_bloc.dart';

import '../widgets/animated_linear_progress_indicator.dart';
import '../widgets/my_animated_count_switcher.dart';
import '../widgets/select_account_banner.dart';
import 'bank_account_selection_view.dart';
import 'bank_selection_view.dart';
import 'mobile_number_mgmt_view.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with TickerProviderStateMixin {
  final _phoneNumbers = [
    '9876543210',
  ];

  final AccountsBloc _bloc = AccountsBloc();

  late AnimationController _phoneNumbersAnimationController;
  late Animation<double> _phoneNumbersFadeAnimation;
  late AnimationController _bannerAnimationController;
  late Animation<double> _bannerFadeAnimation;
  late AnimationController _bankAnimationController;
  late Animation<double> _bankFadeAnimation;

  bool _showBankSelectionView = false;
  final List<Map> _selectedBanks = [];
  final List<Map> _selectedBankAccounts = [];

  @override
  void initState() {
    _phoneNumbersAnimationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _phoneNumbersFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _phoneNumbersAnimationController, curve: Curves.elasticOut),
    );

    _bannerAnimationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _bannerFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _bannerAnimationController, curve: Curves.elasticOut),
    );

    _bankAnimationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _bankFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _bankAnimationController, curve: Curves.elasticOut),
    );

    /// Start the animation in sequence
    _phoneNumbersAnimationController.forward().then((value) {
      _bannerAnimationController.forward().then((value) {
        _bankAnimationController.forward();
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _phoneNumbersAnimationController.dispose();
    _bannerAnimationController.dispose();
    _bankAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Image.network(
                const String.fromEnvironment('logo_url'),
                height: 30,
              ),
            ),
            const Text(
              String.fromEnvironment('brand_name'),
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          PopupMenuButton(
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryColor,
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.help,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(width: 10.0),
                    Text(
                      'Help',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 2,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.logout,
                      color: Colors.red,
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      'Cancel data sharing',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 20.0,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_back,
                        ),
                      ),
                      const Expanded(
                        child: Text(
                          "Select bank accounts to share",
                          maxLines: null,
                          style: TextStyle(
                            fontSize: 30.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                FadeTransition(
                  opacity: _phoneNumbersFadeAnimation,
                  child: MobileNumberManagementView(
                    phoneNumbers: _phoneNumbers,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                FadeTransition(
                  opacity: _bannerFadeAnimation,
                  child: const SelectAccountBanner(),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                FadeTransition(
                  opacity: _bankFadeAnimation,
                  child: _showBankSelectionView
                      ? BankSelectionView(
                          bloc: _bloc,
                          selectedBanks: _selectedBanks,
                          onAddBank: (newBank) {
                            setState(() {
                              _selectedBanks.add(newBank);
                            });
                          },
                          onRemoveBank: (bank) {
                            setState(() {
                              _selectedBanks.remove(bank);
                            });
                          },
                        )
                      : BankAccountSelectionView(
                          selectedBanks: _selectedBanks,
                          selectedBankAccounts: _selectedBankAccounts,
                          bloc: _bloc,
                          onChooseBank: () {
                            setState(() {
                              _showBankSelectionView = true;
                            });
                          },
                          onAddNewBankAccount: (newAccount) {
                            setState(() {
                              _selectedBankAccounts.add(newAccount);
                            });
                          },
                          onRemoveBankAccount: (account) {
                            setState(() {
                              _selectedBankAccounts.remove(account);
                            });
                          },
                        ),
                ),
                const SizedBox(
                  height: 50.0,
                ),
                const Center(
                  child: Text(
                    "Secure data sharing powered by Setu AA, an RBI licensed Account Aggregator",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.grey,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 200.0,
                ),
              ],
            ),
          ),
          // Action Panel
          _showBankSelectionView
              ? Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 20.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(10.0),
                    ),
                    boxShadow: [
                      // Simple box shadow
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 4,
                        blurRadius: 2,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      _selectedBankAccounts.clear();
                      setState(() {
                        _showBankSelectionView = false;
                      });
                    },
                    style: ButtonStyle(
                        minimumSize: const WidgetStatePropertyAll<Size>(
                          Size(double.infinity, 50.0),
                        ),
                        backgroundColor: _selectedBanks.isEmpty
                            ? const WidgetStatePropertyAll(Colors.grey)
                            : null),
                    child: const Text(
                      "Fetch my accounts",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              : ValueListenableBuilder<Map<String, dynamic>>(
                  valueListenable: _bloc.loadingStatus,
                  builder: (context, value, child) {
                    bool isLoading = value["isFetching"] ?? false;
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        isLoading
                            ? AnimatedLinearProgressIndicator(
                                value: value["percentage"].toDouble() / 100,
                              )
                            : const SizedBox(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 20.0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(10.0),
                            ),
                            boxShadow: [
                              // Simple box shadow
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 4,
                                blurRadius: 2,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: isLoading
                              ? AnimatedOpacity(
                                  duration: const Duration(milliseconds: 200),
                                  opacity: isLoading ? 1.0 : 0.0,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Fetching accounts linked to your mobile number",
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      ElevatedButton(
                                        onPressed: () {},
                                        style: const ButtonStyle(
                                          backgroundColor:
                                              WidgetStatePropertyAll<Color>(
                                                  Colors.grey),
                                          minimumSize:
                                              WidgetStatePropertyAll<Size>(
                                            Size(double.infinity, 40.0),
                                          ),
                                        ),
                                        child: const SizedBox(
                                          height: 20.0,
                                          width: 20.0,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 4,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              : Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        MyAnimatedSwitcher(
                                          itemCount:
                                              _selectedBankAccounts.length,
                                        ),
                                        Text(
                                          " ${_selectedBankAccounts.length > 1 ? "accounts" : "account"} selected",
                                          style: const TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20.0,
                                    ),
                                    ElevatedButton(
                                      onPressed: () {},
                                      style: ButtonStyle(
                                        minimumSize:
                                            const WidgetStatePropertyAll<Size>(
                                          Size(double.infinity, 50.0),
                                        ),
                                        backgroundColor:
                                            _selectedBankAccounts.isEmpty
                                                ? const WidgetStatePropertyAll<
                                                    Color>(Colors.grey)
                                                : null,
                                      ),
                                      child: const Text(
                                        "Verify accounts",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ],
                    );
                  }),
        ],
      ),
    );
  }
}
