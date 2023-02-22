import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/domain/model/todo_model.dart';
import 'package:todo_app/view/pages/home/todo_add.dart';
import 'dart:io' show Platform;

import 'package:todo_app/view/util/style/style.dart';
import 'package:todo_app/view/util/widgets/onunfocus.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  List<TodoModel> listOfTodo = [];
  List<TodoModel> listOfDone = [];
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    getInfo();
    super.initState();
  }

  Future getInfo() async {
    setState(() {});
  }

  bool isCheck = false;
  @override
  Widget build(BuildContext context) {
    return OnUnFocusTap(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Style.primaryColor,
          title: const Text(
            'TODO LIST',
            style: TextStyle(
              color: Style.whiteColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          centerTitle: true,
          bottom: TabBar(
            controller: _tabController,
            labelColor: Style.whiteColor,
            unselectedLabelColor: const Color.fromARGB(255, 174, 178, 185),
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Style.helperColor,
            tabs: [
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'In Progrres',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.done),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Done',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.done_all),
                  ],
                ),
              )
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            Column(
              children: [
                const SizedBox(height: 32),
                Expanded(
                  child: ListView.builder(
                      itemCount: listOfTodo.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onLongPress: () {
                            Platform.isAndroid
                                ? showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('Choose'),
                                        actions: [
                                          GestureDetector(
                                            child: Padding(
                                              padding: const EdgeInsets.all(8),
                                              child: Text(
                                                'Edit',
                                                style: Style.textStyleNormal(),
                                              ),
                                            ),
                                            onTap: () {
                                              // Navigator.of(context).push(
                                                // MaterialPageRoute(
                                                //   builder: (a) => EditTodoPage(
                                                //     todoModel:
                                                //         listOfTodo[index],
                                                //     index: index,
                                                //   ),
                                                // ),
                                              // );
                                              setState(() {});
                                            },
                                          ),
                                          GestureDetector(
                                            child: Padding(
                                              padding: const EdgeInsets.all(8),
                                              child: Text(
                                                'Delete',
                                                style: Style.textStyleNormal(),
                                              ),
                                            ),
                                            onTap: () {
                                              listOfTodo.removeAt(index);
                                              Navigator.pop(context);
                                              setState(() {});
                                            },
                                          ),
                                          GestureDetector(
                                            child: Padding(
                                              padding: const EdgeInsets.all(8),
                                              child: Text(
                                                'Cancel',
                                                style: Style.textStyleNormal(),
                                              ),
                                            ),
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      );
                                    })
                                : showCupertinoDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('Choose'),
                                        actions: [
                                          GestureDetector(
                                            child: Padding(
                                              padding: const EdgeInsets.all(8),
                                              child: Text(
                                                'Edit',
                                                style: Style.textStyleNormal(),
                                              ),
                                            ),
                                            onTap: () {
                                              // Navigator.of(context).push(
                                                  // MaterialPageRoute(
                                                  //   builder: (a) => EditTodoPage(
                                                  //     todoModel:
                                                  //         listOfTodo[index],
                                                  //     index: index,
                                                  //   ),
                                                  // ),
                                                  // );
                                              setState(() {});
                                            },
                                          ),
                                          GestureDetector(
                                            child: Padding(
                                              padding: const EdgeInsets.all(8),
                                              child: Text(
                                                'Delete',
                                                style: Style.textStyleNormal(),
                                              ),
                                            ),
                                            onTap: () {
                                              listOfTodo.removeAt(index);
                                              Navigator.pop(context);
                                              setState(() {});
                                            },
                                          ),
                                          GestureDetector(
                                            child: Padding(
                                              padding: const EdgeInsets.all(8),
                                              child: Text(
                                                'Cancel',
                                                style: Style.textStyleNormal(),
                                              ),
                                            ),
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      );
                                    });
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 8),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Style.helperColor,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                        value: listOfTodo[index].isDone,
                                        onChanged: (value) {
                                          listOfTodo[index].isDone =
                                              !listOfTodo[index].isDone;
                                          listOfDone.add(listOfTodo[index]);
                                          listOfTodo.removeAt(index);
                                          setState(() {});
                                        }),
                                    Text(
                                      listOfTodo[index].title,
                                      style: Style.textStyleNormal(
                                          textColor: Style.primaryColor,
                                          size: 18,
                                          isDone: listOfTodo[index].isDone),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
            Column(
              children: [
                const SizedBox(height: 32),
                Expanded(
                  child: ListView.builder(
                      itemCount: listOfDone.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onLongPress: () {
                            Platform.isAndroid
                                ? showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('Choose'),
                                        actions: [
                                          // GestureDetector(
                                          //   child: Padding(
                                          //     padding: const EdgeInsets.all(8),
                                          //     child: Text(
                                          //       'Edit',
                                          //       style: Style.textStyleNormal(),
                                          //     ),
                                          //   ),
                                          //   onTap: () {
                                          //     Navigator.of(context).push(
                                          //       MaterialPageRoute(
                                          //         builder: (a) => EditTodoPage(
                                          //           todoModel:
                                          //               listOfDone[index],
                                          //           index: index,
                                          //         ),
                                          //       ),
                                          //     );
                                          //     setState(() {});
                                          //   },
                                          // ),
                                          GestureDetector(
                                            child: Padding(
                                              padding: const EdgeInsets.all(8),
                                              child: Text(
                                                'Delete',
                                                style: Style.textStyleNormal(),
                                              ),
                                            ),
                                            onTap: () {
                                              listOfDone.removeAt(index);
                                              Navigator.pop(context);
                                              setState(() {});
                                            },
                                          ),
                                          GestureDetector(
                                            child: Padding(
                                              padding: const EdgeInsets.all(8),
                                              child: Text(
                                                'Cancel',
                                                style: Style.textStyleNormal(),
                                              ),
                                            ),
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      );
                                    })
                                : showCupertinoDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('Choose'),
                                        actions: [
                                          // GestureDetector(
                                          //   child: Padding(
                                          //     padding: const EdgeInsets.all(8),
                                          //     child: Text(
                                          //       'Edit',
                                          //       style: Style.textStyleNormal(),
                                          //     ),
                                          //   ),
                                          //   onTap: () {
                                          //     Navigator.of(context).push(
                                          //       MaterialPageRoute(
                                          //         builder: (a) => EditTodoPage(
                                          //           todoModel:
                                          //               listOfDone[index],
                                          //           index: index,
                                          //         ),
                                          //       ),
                                          //     );
                                          //     setState(() {});
                                          //   },
                                          // ),
                                          GestureDetector(
                                            child: Padding(
                                              padding: const EdgeInsets.all(8),
                                              child: Text(
                                                'Delete',
                                                style: Style.textStyleNormal(),
                                              ),
                                            ),
                                            onTap: () {
                                              listOfDone.removeAt(index);
                                              Navigator.pop(context);
                                              setState(() {});
                                            },
                                          ),
                                          GestureDetector(
                                            child: Padding(
                                              padding: const EdgeInsets.all(8),
                                              child: Text(
                                                'Cancel',
                                                style: Style.textStyleNormal(),
                                              ),
                                            ),
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      );
                                    });
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 8),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Style.helperColor,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                        value: listOfDone[index].isDone,
                                        onChanged: (value) {
                                          listOfDone[index].isDone =
                                              !listOfDone[index].isDone;
                                          listOfTodo.add(listOfDone[index]);

                                          listOfDone.removeAt(index);
                                          setState(() {});
                                        }),
                                    Text(
                                      listOfDone[index].title,
                                      style: Style.textStyleNormal(
                                          textColor: Style.primaryColor,
                                          size: 18,
                                          isDone: listOfDone[index].isDone),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
          ],
        ),
        floatingActionButton: GestureDetector(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (a) => const TodoAdd()));
          },
          child: Container(
            height: 60,
            width: 60,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Style.primaryColor,
            ),
            child: const Icon(
              Icons.add,
              color: Style.whiteColor,
            ),
          ),
        ),
      ),
    );
  }
}
