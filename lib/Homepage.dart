import 'dart:ffi';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  TextEditingController textcontroller = TextEditingController();
  // TextEditingController descriptioncontroller = TextEditingController();
  TextEditingController editingController = TextEditingController();
  var box = Hive.box("mybox");
  var descriptiones = Hive.box("mybox");

  // Future<void> des() async {
  //   int num = descriptiones.length + 1;
  //   if (descriptioncontroller.text != '') {
  //     num++;
  //     setState(() {
  //       descriptiones.put(num, descriptioncontroller.text);
  //     });
  //     descriptioncontroller.clear();
  //     Navigator.pop(context);
  //   }
  // }

  Future<void> addData() async {
    int num = box.length + 1;
    if (textcontroller.text != '') {
      num++;
      setState(() {
        box.put(num, textcontroller.text);
      });
      textcontroller.clear();
      Navigator.pop(context);
    }
  }

  // List<String> description = [
  //   "is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, ",
  //   " when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap ",
  //   " It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
  //   "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",
  //   "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",
  //   "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",
  //   "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",
  // ];

  void editFct(int index) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            backgroundColor: Color.fromARGB(255, 232, 213, 213),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Text("Edit Text"),
            content: TextField(
              controller: editingController,
              autofocus: true,
              decoration: InputDecoration(
                hintText: box.getAt(index),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancle It",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )),
              TextButton(
                  onPressed: () {
                    if (editingController.text != '') {
                      setState(() {
                        box.putAt(index, editingController.text);
                        editingController.clear();
                        Navigator.pop(context);
                      });
                    }
                  },
                  child: Text("Update ")),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //AppBAR
        appBar: AppBar(
          title: Text("To-Do "),
          shadowColor: Colors.blueGrey.withOpacity(0.9),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            ),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(
                Icons.android,
                size: 30,
              ),
            ),
          ],
        ),
        //To Do List
        body: ListView.builder(
            reverse: true,
            shrinkWrap: true,
            itemCount: box.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.all(15.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  color: Color.fromARGB(255, 27, 25, 25),
                  //fromARGB(255, 27, 25, 25),
                  child: Padding(
                    padding: EdgeInsets.all(6.0),
                    child: Column(
                      children: [
                        ListTile(
                          onTap: () => editFct(index),
                          tileColor: Colors.primaries[
                              Random().nextInt(Colors.primaries.length)],
                          title: Text(
                            box.getAt(index),
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          // // subtitle: Text(
                          // //   description[index],
                          // //   style: TextStyle(
                          // //       fontSize: 15, fontWeight: FontWeight.bold),
                          // ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              setState(() {
                                box.deleteAt(index);
                              });
                            },
                            icon: Icon(
                              Icons.delete,
                              size: 30,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),

        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    child: Column(
                      children: [
                        Text(
                          "Add your Task",
                          style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Colors.primaries[
                                  Random().nextInt(Colors.primaries.length)]),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 28.0),
                          child: TextField(
                            enableSuggestions: true,
                            autofocus: true,
                            controller: textcontroller,
                            decoration: InputDecoration(
                                label: Text("My Task"),
                                hintText: "Enter Your Task",
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide:
                                        BorderSide(color: Colors.redAccent)),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(221, 110, 16, 16)),
                                )),
                          ),
                        ),
                        Column(
                          children: [
                            Container(
                              height: 70,
                              padding:
                                  EdgeInsets.only(top: 15, left: 30, right: 30),
                              child: MaterialButton(
                                height: 40,
                                onPressed: addData,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.add),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Add Data",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                color: Colors.primaries[
                                    Random().nextInt(Colors.primaries.length)],
                              ),
                            ),

                            /////Subtitle update
                            // MaterialButton(
                            //   height: 40,
                            //   minWidth: 40,
                            //   onPressed: des,
                            //   child: Row(
                            //     mainAxisAlignment: MainAxisAlignment.center,
                            //     children: [
                            //       Icon(Icons.add),
                            //       SizedBox(
                            //         width: 5,
                            //       ),
                            //       Text(
                            //         "Add Description",
                            //         style: TextStyle(
                            //             fontSize: 20,
                            //             fontWeight: FontWeight.bold),
                            //       ),
                            //     ],
                            //   ),
                            //   color: Colors.primaries[
                            //       Random().nextInt(Colors.primaries.length)],
                            // ),
                          ],
                        ),
                      ],
                    ),
                  );
                });
          },
          child: Icon(
            Icons.add,
            size: 40,
          ),
          backgroundColor:
              Colors.primaries[Random().nextInt(Colors.primaries.length)],
        ),
      ),
    );
  }
}
