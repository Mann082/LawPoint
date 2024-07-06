import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lawyers_diary/controllers/case_controller.dart';
import 'package:percent_indicator/percent_indicator.dart';

class TestScreen extends ConsumerStatefulWidget {
  static const routeName = '/TestScreen';
  const TestScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TestScreenState();
}

class _TestScreenState extends ConsumerState<TestScreen> {
  @override
  Widget build(BuildContext context) {
    CaseController _controller = CaseController(ref: ref, context: context);
    return ProfileProgress();
  }
}

// ProfileProgress Widget
// ProfileProgress Widget
class ProfileProgress extends StatelessWidget {
  final double completionPercentage = 0.40; // Example completion percentage

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile Progress')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircularPercentIndicator(
                radius: 80.0, // Increased radius for better visibility
                lineWidth: 30.0, // Increased line width
                percent: completionPercentage,
                backgroundColor: Colors.grey[300]!,
                progressColor: Theme.of(context).colorScheme.primary,
                center: Text(
                  "${(completionPercentage * 100).toStringAsFixed(0)}%",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 30),
            Wrap(
              spacing: 5,
              runSpacing: 5,
              children: [
                SwipeableCards(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SwipeableCards extends StatefulWidget {
  const SwipeableCards({super.key});

  @override
  State<SwipeableCards> createState() => _SwipeableCardsState();
}

class _SwipeableCardsState extends State<SwipeableCards> {
  List<int> cardOrder = [0, 1, 2, 3, 4];

  List<LinearGradient> colors = [
    const LinearGradient(
      colors: [Color(0xffFF512F), Color(0xffDD2476)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    const LinearGradient(
      colors: [Color(0xff1488CC), Color(0xff2B32B2)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    const LinearGradient(
      colors: [Color(0xffad5389), Color(0xff3c1053)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    const LinearGradient(
      colors: [Color(0xffFFB75E), Color(0xffED8F03)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    const LinearGradient(
      colors: [Color(0xff6A9113), Color(0xff141517)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  ];

  List<Map<String, dynamic>> cardDetails = [
    {'title': 'Personal Details', 'completed': true},
    {'title': 'Manage Store', 'completed': false},
    {'title': 'Bank Details', 'completed': false},
    {'title': 'KYC', 'completed': true},
    {'title': 'Settings', 'completed': false},
  ];

  void changeCardOrder(int sCard, int index) {
    setState(() {
      LinearGradient materialAccentColor = colors.removeAt(index);
      colors.insert(0, materialAccentColor);
      cardOrder.remove(sCard);
      cardOrder.insert(0, sCard);
    });
  }

  @override
  void initState() {
    super.initState();
    cardOrder = cardOrder.reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: 300,
      // height: 300,
      child: Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (int i = 0; i < cardOrder.length; i++)
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: SCard(
                      color: colors[i],
                      index: i,
                      key: ValueKey(cardOrder[i]),
                      value: cardOrder[i],
                      details: cardDetails[cardOrder[i]],
                      onDragged: () => changeCardOrder(cardOrder[i], i),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class SCard extends StatefulWidget {
  final int index;
  final int value;
  final Function onDragged;
  final LinearGradient color;
  final Map<String, dynamic> details;

  const SCard({
    super.key,
    required this.index,
    required this.onDragged,
    required this.value,
    required this.color,
    required this.details,
  });

  @override
  State<SCard> createState() => _SCardState();
}

class _SCardState extends State<SCard> with TickerProviderStateMixin {
  Offset _position = Offset.zero;
  double height = 100;
  double width = 100;
  Curve _myCurve = Curves.linear;
  Duration _duration = const Duration(milliseconds: 0);

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      left: _position.dx,
      top: 0,
      duration: _duration,
      curve: _myCurve,
      child: GestureDetector(
        onPanUpdate: (details) {
          if (widget.index == 0) {
            setState(() {
              _myCurve = Curves.linear;
              _duration = const Duration(milliseconds: 0);
              _position += details.delta;
            });
          }
        },
        onPanEnd: (details) {
          if (widget.index == 0) {
            setState(() {
              _myCurve = Curves.easeIn;
              _duration = const Duration(milliseconds: 300);
              if (_position.dx.abs() > width / 2) {
                widget.onDragged();
                _position = Offset.zero;
              } else {
                _position = Offset.zero;
              }
            });
          }
        },
        child: SizedBox(
          width: 100,
          height: 100,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: height, // Specify width
              maxWidth: width,
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: widget.color,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      widget.details['completed']
                          ? Icons.check_circle
                          : Icons.error,
                      color: widget.details['completed']
                          ? Colors.green
                          : Colors.red,
                      size: 40,
                    ),
                    Text(
                      widget.details['title'],
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
