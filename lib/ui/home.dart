import 'package:flutter/material.dart';

class BillSplitter extends StatefulWidget {
  const BillSplitter({Key? key}) : super(key: key);

  @override
  State<BillSplitter> createState() => _BillSplitterState();
}

class _BillSplitterState extends State<BillSplitter> {
  int tippercentage = 0;
  int personCount = 1;
  double billamount = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
      alignment: Alignment.center,
      color: Colors.white,
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                width: 300,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.purpleAccent.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Total per person",
                        style: TextStyle(color: Colors.purple)),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("\$ ${calculateTotalperperson(billamount,personCount,tippercentage)}",
                          style: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.purple)),
                    )
                  ],
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                      color: Colors.blueGrey.shade100,
                      style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(14)),
              child: Column(
                children: [
                  TextField(
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    style: TextStyle(color: Colors.grey),
                    decoration: InputDecoration(
                        prefixText: "Bill Amount",
                        prefixIcon: Icon(Icons.attach_money)),
                    onChanged: (String value) {
                      try {
                        billamount = double.parse(value);
                      } catch (ex) {
                        billamount = 0.0;
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Split'),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  if (personCount > 1) {
                                    personCount--;
                                  } else {}
                                });
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color:
                                        Colors.purpleAccent.withOpacity(0.3)),
                                child: Center(
                                    child: Text("-",
                                        style: TextStyle(
                                            fontStyle: FontStyle.normal,
                                            fontSize: 20,
                                            color: Colors.purple))),
                              ),
                            ),
                            Text("$personCount",
                                style: TextStyle(
                                    fontStyle: FontStyle.normal, fontSize: 17)),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  personCount++;
                                });
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color:
                                        Colors.purpleAccent.withOpacity(0.3)),
                                child: Center(
                                    child: Text("+",
                                        style: TextStyle(
                                            fontStyle: FontStyle.normal,
                                            fontSize: 18,
                                            color: Colors.purple))),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Tip"),
                        Text("\$ ${(calculateTotaltip(billamount,personCount,tippercentage)).toStringAsFixed(2)}",
                            style: TextStyle(
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.purple))
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Text("$tippercentage%",
                          style: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple)),
                      Slider(
                          min: 0,
                          max: 100,
                          activeColor: Colors.purpleAccent,
                          inactiveColor: Colors.grey,
                          value: tippercentage.toDouble(),
                          onChanged: (double newvalue) {
                            setState(() {
                              tippercentage = newvalue.round();
                            });
                          })
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }

  calculateTotalperperson(double billamount, int splitby,int tippercentage) {
    var totalperperson = (billamount + calculateTotaltip(billamount, splitby, tippercentage)) / splitby;
    return totalperperson.toStringAsFixed(2);
  }

  calculateTotaltip(double billamount, int splitby, int tippercentage) {
    double totaltip = 0.0;
    if (billamount < 0 || billamount == null || billamount.toString().isEmpty) {
    } else {
      totaltip = (billamount * tippercentage) / 100;
    }
    return totaltip;
  }
}
