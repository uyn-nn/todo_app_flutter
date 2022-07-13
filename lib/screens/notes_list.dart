import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/screens/my_note.dart';
import 'my_note.dart';
import 'controller.dart';

class NoteList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final NoteController nc = Get.put(NoteController());
    Widget getNoteList() {
      return Obx(
        () => nc.notes.length == 0
            ? Center(
                //child: Image.asset('assets/lists.jpeg'),
              )
            : ListView.builder(
                itemCount: nc.notes.length,
                itemBuilder: (context, index) => Card(
                      child: ListTile(
                          // CheckBox(
                          //   varlue = values
                          // ),
                          title: Text(nc.notes[index].title,
                              style: TextStyle(fontWeight: FontWeight.w500)),
                          leading: Text(
                            toString() + ".",
                            style: TextStyle(fontSize: 15),
                          ),
                          
                          trailing: Wrap(children: <Widget>[
                            IconButton(
                                icon: Icon(Icons.create),
                                onPressed: () => Get.to(MyNote(index: index))),
                            IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  Get.defaultDialog(
                                      title: 'Are you sure you want to delete?',
                                      middleText: nc.notes[index].title,
                                      onCancel: () => Get.back(),
                                      confirmTextColor: Colors.white,
                                      onConfirm: () {
                                        nc.notes.removeAt(index);
                                        Get.back();
                                      });
                                })
                          ])),
                    )),
      );
    }

    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              centerTitle: true,
              title: Text('Todo List'),
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                Get.to(MyNote(index: 0,));
              },
            ),
            body: Container(
              child: Padding(padding: EdgeInsets.all(5), child: getNoteList()),
            )));
  }
}
