import 'package:flutter/material.dart';

class Bars extends StatelessWidget {
  final String label;
  final double txnAmount;
  final spendPctAmount;

  Bars(
    this.label,
    this.txnAmount,
    this.spendPctAmount,
  );

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Column(
          children: [
            Container(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                child: Text(
                  "\$${txnAmount.toStringAsFixed(0)}",
                  style: TextStyle(
                      // height: 2,
                      ),
                ),
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.1,
            ),
            Container(
              height: constraints.maxHeight * 0.6,
              width: 10,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.0),
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: spendPctAmount,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                child: Text("$label"),
              ),
            ),
          ],
        );
      },
      //builder method is closing here
    );
  }
}
