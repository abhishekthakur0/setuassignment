import 'package:flutter/material.dart';
import 'package:setuassignment/modules/homepage/bloc/accounts_bloc.dart';

import '../widgets/flip_opacity_transition.dart';

class BankSelectionView extends StatefulWidget {
  const BankSelectionView({
    super.key,
    required this.bloc,
    required this.selectedBanks,
    required this.onAddBank,
    required this.onRemoveBank,
  });

final AccountsBloc bloc;
  final List<Map> selectedBanks;
  final Function(Map) onAddBank;
  final Function(Map) onRemoveBank;

  @override
  State<BankSelectionView> createState() => _BankSelectionViewState();
}

class _BankSelectionViewState extends State<BankSelectionView> {
  late final AccountsBloc _bloc;

  @override
  void initState() {
    _bloc = widget.bloc;
    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  "Choose one or more banks",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.search,
                  color: Theme.of(context).primaryColor,
                ),
              )
            ],
          ),
          Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 10, top: 10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  color: Colors.white,
                  boxShadow: const [
                    // Inner BoxShadow
                    BoxShadow(
                      color: Colors.black,
                    ),
                    BoxShadow(
                      color: Colors.black,
                      spreadRadius: -12.0,
                      blurRadius: 12.0,
                    ),
                  ],
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: _bloc.banks.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final bank = _bloc.banks[index];
                    final isBankAvailable = bank['active'] as bool;
                    final isSelected = widget.selectedBanks.contains(bank);
                    return ListTile(
                      enabled: isBankAvailable,
                      onTap: () {
                        if (isSelected) {
                          widget.onRemoveBank(bank);
                        } else {
                          widget.onAddBank(bank);
                        }
                      },
                      leading: isSelected
                          ? const FlipOpacityTransition(
                              duration: Duration(milliseconds: 1000),
                              child: CircleAvatar(
                                  backgroundColor: Colors.green,
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.white,
                                  )),
                            )
                          : CircleAvatar(
                              backgroundColor: Colors.white,
                              child: ColorFiltered(
                                colorFilter: ColorFilter.mode(
                                  !isBankAvailable
                                      ? Colors.grey
                                      : Colors.transparent,
                                  BlendMode.saturation,
                                ),
                                child: Image.network(
                                  bank['logo_url'] as String,
                                  width: 32.0,
                                  height: 32.0,
                                ),
                              ),
                            ),
                      title: Text(
                        bank['title'] as String,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: isBankAvailable ? Colors.black : Colors.grey,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      subtitle: isBankAvailable
                          ? null
                          : const Text(
                              'Temporarily unavailable',
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(thickness: 1),
                ),
              ),
              widget.selectedBanks.isEmpty
                  ? const SizedBox()
                  : Positioned(
                      child: AnimatedSwitcher(
                        duration: const Duration(
                          milliseconds: 500,
                        ), // Duration of the animation
                        switchInCurve: Curves.elasticIn,
                        transitionBuilder:
                            (Widget child, Animation<double> animation) {
                          // Using FadeTransition to handle opacity change
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                        child: CircleAvatar(
                          key: ValueKey(widget.selectedBanks.length),
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          child: Text(
                            widget.selectedBanks.length.toString(),
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                      ),
                    )
            ],
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
              "Can't find your banks?",
              style: TextStyle(
                color: Colors.blueAccent,
              ),
            ),
          )
        ],
      ),
    );
  }
}
