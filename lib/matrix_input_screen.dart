import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

import 'algorithms/restricted_unbalanced.dart';

class MatrixInput extends StatefulWidget {
  const MatrixInput({super.key});
  @override
  _MatrixInputState createState() => _MatrixInputState();
}

class _MatrixInputState extends State<MatrixInput> {
  List<List<int>> matrix = [];

  TextEditingController rowController = TextEditingController();
  TextEditingController colController = TextEditingController();

  String _displayText = 'Result';

  void _changeText() {
    setState(() {
      _displayText = RestrictedUnbalanced().getDoneJobs(matrix);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Matrix Input"),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: rowController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: "Enter Rows"),
            ),
            SizedBox(height: 10),
            TextField(
              controller: colController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: "Enter Columns"),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                ElevatedButton(
                  child: Text("Input Matrix"),
                  onPressed: () {
                    int rows = int.parse(rowController.text);
                    int cols = int.parse(colController.text);
                    setState(() {
                      matrix = List.generate(rows, (_) => List.filled(cols, 0),
                          growable: false);
                    });
                    showDialog(
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                          title: Text("Enter Matrix"),
                          content: Container(
                            width: double.maxFinite,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: rows,
                              itemBuilder: (context, row) {
                                return Row(
                                  children: List.generate(cols, (col) {
                                    return Expanded(
                                      child: TextField(
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) {
                                          matrix[row][col] = int.parse(value);
                                        },
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    );
                                  }),
                                );
                              },
                            ),
                          ),
                          actions: [
                            Row(
                              children: [
                                ElevatedButton(
                                  child: const Text("Submit"),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    setState(() {});
                                  },
                                ),
                              ],
                            )
                          ],
                        );
                      },
                    );
                  },
                ),
                const Spacer(),
                ElevatedButton(
                  child: const Text("Calculate Result"),
                  onPressed: () {
                    _changeText();
                    //Navigator.pop(context);
                    setState(() {});
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            matrix.isNotEmpty
                ? Container(
                    height: 200,
                    width: double.maxFinite,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: List.generate(
                          matrix[0].length,
                          (col) => DataColumn(label: Text("Col ${col + 1}")),
                        ),
                        rows: List.generate(
                          matrix.length,
                          (row) => DataRow(
                            cells: List.generate(
                              matrix[row].length,
                              (col) => DataCell(Text("${matrix[row][col]}")),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : const SizedBox(),
            const Spacer(),
            Text(_displayText)
          ],
        ),
      ),
    );
  }
}
