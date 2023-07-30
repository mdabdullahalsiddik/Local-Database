import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController titleController = TextEditingController();

  late Box studentBox;
  @override
  void initState() {
    studentBox = Hive.box("Student");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Hive Local Database"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return AlertDialog(
                  actions: [
                    SizedBox(height: 10.0),
                    TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                        hintText: "Note Title",
                        hintStyle: TextStyle(color: Colors.black),
                        labelStyle: TextStyle(color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blueGrey)),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("No Save")),
                        ElevatedButton(
                            onPressed: () {
                              studentBox.add(titleController.text);
                              titleController.clear();
                              Navigator.pop(context);
                            },
                            child: Text("Save")),
                      ],
                    )
                  ],
                );
              },
            );
          },
          child: Icon(Icons.add),
        ),
        body: ValueListenableBuilder(
          valueListenable: Hive.box("Student").listenable(),
          builder: (context, value, child) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: studentBox.keys.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: ListTile(
                    tileColor: Colors.blue,
                    title: Text(studentBox.getAt(index).toString()),
                    trailing: SizedBox(
                      width: 70,
                      child: Row(
                        children: [
                          InkWell(
                              onTap: () {
                                showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      actions: [
                                        SizedBox(height: 10.0),
                                        TextField(
                                          controller: titleController,
                                          decoration: InputDecoration(
                                            hintText: "Note Title",
                                            hintStyle:
                                                TextStyle(color: Colors.black),
                                            labelStyle:
                                                TextStyle(color: Colors.black),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.blueGrey)),
                                          ),
                                        ),
                                        SizedBox(height: 20.0),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text("No Update")),
                                            ElevatedButton(
                                                onPressed: () {
                                                  studentBox.putAt(index,
                                                      titleController.text);
                                                  titleController.clear();
                                                  Navigator.pop(context);
                                                },
                                                child: Text("Update")),
                                          ],
                                        )
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Icon(Icons.edit)),
                          SizedBox(width: 20),
                          InkWell(
                              onTap: () {
                                studentBox.deleteAt(index);
                              },
                              child: Icon(Icons.delete)),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
