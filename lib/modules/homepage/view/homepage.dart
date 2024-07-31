import 'package:flutter/material.dart';
import 'package:setuassignment/modules/homepage/bloc/accounts_bloc.dart';

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

  final AccountsBloc _homepageBloc = AccountsBloc();

  late AnimationController _phoneNumbersAnimationController;
  late Animation<double> _phoneNumbersFadeAnimation;
  late AnimationController _bannerAnimationController;
  late Animation<double> _bannerFadeAnimation;
  late AnimationController _bankAnimationController;
  late Animation<double> _bankFadeAnimation;

  bool _showBankSelectionView = false;
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
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryColor,
            ),
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
                      ? BankAccountSelectionView(
                          bloc: _homepageBloc,
                          onChooseBank: () {
                            setState(() {
                              _showBankSelectionView = true;
                            });
                          },
                        )
                      : BankSelectionView(
                          selectedBanks: _selectedBankAccounts,
                          onSelectBank: (newBank) {
                            setState(() {
                              _selectedBankAccounts.add(newBank);
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
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              (_homepageBloc.loadingPercentage > 0)
                  ? LinearProgressIndicator(
                      value: _homepageBloc.loadingPercentage.toDouble() ?? 0.0,
                      minHeight: 6.0,
                      color: Theme.of(context).primaryColor,
                      backgroundColor: Colors.white,
                      semanticsLabel: "Loading progress",
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
                child: _showBankSelectionView
                    ? ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _showBankSelectionView = false;
                          });
                        },
                        style: const ButtonStyle(
                          minimumSize: WidgetStatePropertyAll<Size>(
                            Size(double.infinity, 50.0),
                          ),
                        ),
                        child: const Text(
                          "Fetch my accounts",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "1",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                " accounts selected",
                                style: TextStyle(
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
                            onPressed: () {
                              setState(() {});
                            },
                            style: const ButtonStyle(
                              minimumSize: WidgetStatePropertyAll<Size>(
                                Size(double.infinity, 50.0),
                              ),
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
          ),
        ],
      ),
    );
  }
}
