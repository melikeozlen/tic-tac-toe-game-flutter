import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool oTurn = true;
  List<String> displayA = ['', '', '', '', '', '', '', '', ''];
  int oWin = 0;
  int xWin = 0;
  int count = 0;
  List<int> winningCombination = [];
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    double deviceWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      title: "Tic-Toc-Toe Game",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Roboto Mono'),
      home: Scaffold(
        backgroundColor: const Color.fromRGBO(43, 0, 64, 100),
        body: SafeArea(
            child: Container(
          margin: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const Expanded(
                  flex: 1,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Tic",
                          style: TextStyle(
                              color: Color.fromRGBO(220, 191, 63, 1),
                              fontSize: 25.0),
                        ),
                        Text(
                          " Tac ",
                          style: TextStyle(
                              color: Color.fromRGBO(114, 207, 249, 1),
                              fontSize: 30.0),
                        ),
                        Text(
                          "Toe ",
                          style: TextStyle(
                              color: Color.fromRGBO(220, 191, 63, 1),
                              fontSize: 25.0),
                        ),
                        Text(
                          "Game",
                          style: TextStyle(
                              color: Color.fromRGBO(114, 207, 249, 1),
                              fontSize: 30.0),
                        )
                      ])),
              Expanded(
                flex: 1,
                child: Container(
                  width: deviceWidth - 27,
                  height: 50.0,
                  padding: EdgeInsets.only(top: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        width: 85.0,
                        height: 85.0,
                        decoration: const BoxDecoration(
                            color: Color.fromRGBO(72, 208, 254, 1)),
                        child: Center(
                          child: Text(
                            oTurn == true ? "O Turn" : "X Turn",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Color.fromARGB(226, 41, 41, 41),
                                fontSize: 25.0,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        width: 85.0,
                        height: 85.0,
                        decoration: const BoxDecoration(
                            color: Color.fromRGBO(188, 218, 249, 1)),
                        child: Align(
                          alignment: const Alignment(0.0, 0.0),
                          child: Text('X : $xWin',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Color.fromARGB(226, 41, 41, 41),
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.w500)),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        width: 85.0,
                        height: 85.0,
                        decoration: const BoxDecoration(
                            color: Color.fromRGBO(255, 213, 0, 1)),
                        child: Align(
                          alignment: const Alignment(0.0, 0.0),
                          child: Text('O : $oWin',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Color.fromARGB(226, 41, 41, 41),
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.w500)),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Center(
                  child: Container(
                      width: deviceWidth - 27,
                      height: deviceWidth - 27,
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                        ),
                        itemCount: 9, // Number of cells in the grid
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              if (displayA[index] == '') {
                                count += 1;

                                if (oTurn) {
                                  displayA[index] = 'O';
                                } else
                                  displayA[index] = 'X';
                                setState(() {
                                  oTurn = !oTurn;
                                });
                                if (_check(
                                    index, displayA, winningCombination)) {
                                  setState(() {
                                    if (oTurn == true) {
                                      xWin += 1;
                                    } else
                                      oWin += 1;
                                  });

                                  Future.delayed(Duration(milliseconds: 300),
                                      () {
                                    showDialog<String>(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        backgroundColor:
                                            Color.fromRGBO(43, 0, 64, 0.678),
                                        title: const Text('GAME OVER',
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    255, 255, 255, 1),
                                                fontSize: 25.0,
                                                fontWeight: FontWeight.w500)),
                                        content: Text(
                                            oTurn == true ? "X Win" : "O Win",
                                            style: TextStyle(
                                                color: oTurn == false
                                                    ? const Color.fromRGBO(
                                                        114, 207, 249, 1)
                                                    : const Color.fromRGBO(
                                                        220, 191, 63, 1),
                                                fontSize: 25.0,
                                                fontWeight: FontWeight.w500)),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context, 'OK');
                                              setState(() {
                                                count = 0;
                                                displayA = [
                                                  '',
                                                  '',
                                                  '',
                                                  '',
                                                  '',
                                                  '',
                                                  '',
                                                  '',
                                                  ''
                                                ];

                                                oTurn = true;
                                                winningCombination = [];
                                              });
                                            },
                                            child: const Text('OK',
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        192, 255, 255, 255),
                                                    fontSize: 25.0,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                                } else if (count == 9 &&
                                    _check(index, displayA,
                                            winningCombination) ==
                                        false) {
                                  showDialog<String>(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      backgroundColor: Colors.amber.shade400,
                                      title: const Text('GAME OVER',
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  192, 31, 31, 31),
                                              fontSize: 25.0,
                                              fontWeight: FontWeight.w500)),
                                      content: const Text(
                                        "Draw",
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                248, 255, 48, 128),
                                            fontSize: 25.0,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context, 'OK');
                                            setState(() {
                                              count = 0;
                                              displayA = [
                                                '',
                                                '',
                                                '',
                                                '',
                                                '',
                                                '',
                                                '',
                                                '',
                                                ''
                                              ];

                                              oTurn = true;
                                              winningCombination = [];
                                            });
                                          },
                                          child: const Text('OK',
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      192, 255, 255, 255),
                                                  fontSize: 25.0,
                                                  fontWeight: FontWeight.w500)),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              }
                            },
                            child: Container(
                              margin: const EdgeInsets.all(9.0),
                              decoration: BoxDecoration(
                                color: winningCombination.contains(index)
                                    ? Color.fromRGBO(29, 255, 123, 0.612)
                                    : Color.fromRGBO(67, 17, 91, 100),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                child: Text(
                                  displayA[index],
                                  style: TextStyle(
                                    color: displayA[index] == "X"
                                        ? const Color.fromARGB(255, 226, 188, 0)
                                        : const Color.fromARGB(
                                            255, 70, 211, 254),
                                    fontSize: 70.0,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ), // Make sure index is within bounds
                              ),
                            ),
                          );
                        },
                      )),
                ),
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        count = 0;
                        displayA = ['', '', '', '', '', '', '', '', ''];
                        oTurn = true;
                        winningCombination = [];
                        xWin = 0;
                        oWin = 0;
                      });
                    },
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.amber)),
                    child: Container(
                      padding: EdgeInsets.all(15.0),
                      child: const Text(
                        "Reset",
                        style: TextStyle(
                            fontSize: 25.0,
                            fontFamily: 'Roboto Mono',
                            color: Colors.black),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}

bool _check(int index, List<String> displayA, List<int> winningCombination) {
  // 1-2-3 , 4-5-6 , 7-8-9 , 1-5-9,  3-5-7, 1-4-7, 2-5-8, 3-6-9 all wins

  for (var i = 0; i < 3; i++) {
    if (displayA[i * 3] == displayA[i * 3 + 1] &&
        displayA[i * 3 + 1] == displayA[i * 3 + 2] &&
        displayA[i * 3] != '') {
      winningCombination.addAll([i * 3, i * 3 + 1, i * 3 + 2]);
      return true; //
    }
    if (displayA[i] == displayA[i + 3] &&
        displayA[i + 3] == displayA[i + 6] &&
        displayA[i] != '') {
      winningCombination.addAll([i, i + 3, i + 6]);
      return true; //
    }
  }

  if (displayA[0] == displayA[4] &&
      displayA[4] == displayA[8] &&
      displayA[0] != '') {
    winningCombination.addAll([0, 4, 8]);
    return true;
  }
  if (displayA[2] == displayA[4] &&
      displayA[4] == displayA[6] &&
      displayA[2] != '') {
    winningCombination.addAll([2, 4, 6]);
    return true;
  }

  return false;
}
