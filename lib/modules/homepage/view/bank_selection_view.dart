import 'package:flutter/material.dart';

class BankSelectionView extends StatefulWidget {
  const BankSelectionView({
    super.key,
    required this.selectedBanks,
    required this.onSelectBank,
  });

  final List<Map> selectedBanks;
  final Function(Map) onSelectBank;

  @override
  State<BankSelectionView> createState() => _BankSelectionViewState();
}

class _BankSelectionViewState extends State<BankSelectionView> {
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
                  itemCount: banks.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final bank = banks[index];
                    final isBankAvailable = bank['active'] as bool;
                    final isSelected = widget.selectedBanks.contains(bank);
                    return ListTile(
                      enabled: isBankAvailable,
                      onTap: () {
                        if (isSelected) {
                          widget.selectedBanks.remove(bank);
                        } else {
                          widget.selectedBanks.add(bank);
                        }
                      },
                      leading: isSelected
                          ? null
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
              Positioned(
                child: CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  child: Text(
                    widget.selectedBanks.length.toString(),
                    style: TextStyle(color: Theme.of(context).primaryColor),
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
