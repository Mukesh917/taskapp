import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(MaterialApp(
    home: TaskApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class TaskApp extends StatefulWidget {
  const TaskApp({Key? key}) : super(key: key);

  @override
  _TaskAppState createState() => _TaskAppState();
}

class _TaskAppState extends State<TaskApp> {
  TextEditingController _contoller = TextEditingController();
  TextEditingController _textController = TextEditingController();
  GlobalKey<FormState> _form = GlobalKey<FormState>();
  List updatedlist = [];
  var textString;
  var numberInputFormatters = [
    new FilteringTextInputFormatter.allow(RegExp("[0-9]")),
  ];
  String pattern = "^[A-Za-z\s]{1,}[\.]{0,1}[A-Za-z\s]{0,}";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("taskApp"),
      ),
      body: Form(
        key: _form,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _textController,
                  maxLines: 3,
                  decoration: InputDecoration(
                      hintText: 'Enter data',
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 2)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 2)),
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 2)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 2))),
                  onChanged: (value) {
                    setState(() {
                      textString = value;
                    });

                    print(textString);
                  },
                ),
                // Text(
                //   demotext,
                //   style: TextStyle(fontSize: 18),
                // ),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: SizedBox(
                    width: 50,
                    child: TextFormField(
                      // inputFormatters: numberInputFormatters,
                      keyboardType: TextInputType.number,
                      controller: _contoller,
                      validator: (value) {
                        if (value!.isEmpty) {
                          Fluttertoast.showToast(
                              msg: "Please enter number",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.white,
                              textColor: Colors.white,
                              fontSize: 16.0);
                          return "Enter number";
                        }
                        if (value == '-') {
                          Fluttertoast.showToast(
                              msg: "Please enter number",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.white,
                              textColor: Colors.white,
                              fontSize: 16.0);
                          return "Enter number";
                        }
                        if (RegExp(r'[!@#<>?":_`~;,.[\]\\|=+)(*&^%]')
                            .hasMatch(value)) {
                          Fluttertoast.showToast(
                              msg: "enter only valid number",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.white,
                              textColor: Colors.white,
                              fontSize: 16.0);
                          return 'Zero value not valid';
                        }
                      },
                      decoration: InputDecoration(
                          hintText: ' No.',
                          contentPadding: EdgeInsets.all(7),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 2)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 2)),
                          errorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 2)),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 2))),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: ElevatedButton(
                      onPressed: () {
                        updatedlist.clear();
                        setState(() {
                          
                        });
                        if (_form.currentState!.validate()) {
                          _form.currentState!.save();

                          var stringlist = textString.split(".");
                          print(stringlist);
                          if (_contoller.text.contains('-')) {
                            for (int j = 0; j < stringlist.length; j++) {
                              updatedlist
                                  .add(stringlist[j].split(' ').reversed);

                              setState(() {});
                           
                            }
                           
                          } else {
                            for (int i = 0; i < stringlist.length; i++) {
                              if (stringlist[i].split(' ').length >
                                  int.parse(_contoller.text)) {
                                updatedlist.add(stringlist[i]
                                        .split(' ')
                                        .sublist(
                                            0,
                                            stringlist[i].split(' ').length -
                                                int.parse(_contoller.text))
                                        .reversed
                                        .toString() +
                                    stringlist[i]
                                        .split(' ')
                                        .getRange(
                                            stringlist[i].split(' ').length -
                                                int.parse(_contoller.text),
                                            stringlist[i].split(' ').length)
                                        .toString());
                                setState(() {});
                                print(updatedlist);
                              } else {
                                updatedlist
                                    .add(stringlist[i].split(' ').toString());
                              }
                            }
                          }
                        }
                      },
                      child: Text("Update")),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: Text(
                    updatedlist
                        .join('.')
                        .split('[')
                        .join()
                        .split('(')
                        .join()
                        .split(']')
                        .join()
                        .split('')
                        .join()
                        .split(',')
                        .join()
                        // .split('(').join()
                        .split(')')
                        .join()
                    // .split('.').join('.')
                    ,
                    style: TextStyle(fontSize: 17),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
