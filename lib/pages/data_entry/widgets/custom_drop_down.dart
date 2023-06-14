import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mcqs_entry/common/utills/app_colors.dart';
import 'package:mcqs_entry/common/utills/dimensions.dart';
import 'package:mcqs_entry/pages/data_entry/provider.dart';
import 'package:provider/provider.dart';

class CategoryDropDown extends StatefulWidget {
  const CategoryDropDown({Key? key}) : super(key: key);

  @override
  State<CategoryDropDown> createState() => _CategoryDropDownState();
}

class _CategoryDropDownState extends State<CategoryDropDown> {
  final _searchController = TextEditingController();

  late int _key;
  _collapse() {
    int newKey = 0;
    do {
      _key = Random().nextInt(10000);
    } while (newKey == _key);
  }

  @override
  void initState() {
    super.initState();
    _collapse();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DataEntryProvider>(
      builder: (context, dataEntry, child) {
        return Container(
          color: AppColors.greyColor,
          child: ExpansionTile(
            key: Key(_key.toString()),
            title: Text(dataEntry.selectedCategory),
            backgroundColor: AppColors.greyColor,
            children: [
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    TextField(
                      controller: _searchController,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        hintText: 'Type to search',
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                      ),
                      onChanged: (value) {
                        dataEntry.searchCategory(value);
                      },
                    ),
                    const Divider(
                      color: Colors.black,
                      height: 1,
                    ),
                    SizedBox(
                      height: 150.h,
                      child: ListView.builder(
                        itemCount: dataEntry.categories.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              dataEntry
                                  .setMainCategory(dataEntry.categories[index]);
                              _collapse();
                            },
                            child: Container(
                              color: Colors.white,
                              padding: EdgeInsets.only(top: 10.h),
                              alignment: Alignment.center,
                              child: Column(
                                children: [
                                  Text(
                                    dataEntry.categories[index],
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  const Divider(
                                    color: Colors.black,
                                    height: 1,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (_searchController.text.isNotEmpty) {
                          dataEntry.addCategory(
                              _searchController.text, dataEntry.categories);
                          _searchController.clear();
                          _collapse();
                          dataEntry.updateData();
                        } else {
                          ScaffoldMessenger.of(context)
                            ..removeCurrentSnackBar()
                            ..showSnackBar(const SnackBar(
                                content: Text("Can Not Be Empty")));
                        }
                      },
                      child: Container(
                          padding: EdgeInsets.all(10.h),
                          color: AppColors.brandingColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                              Dimensions.width < 600
                                  ? const SizedBox.shrink()
                                  : const Text(
                                      'Add New',
                                      style: TextStyle(color: Colors.white),
                                    )
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class SubjectsDropDown extends StatefulWidget {
  const SubjectsDropDown({Key? key}) : super(key: key);

  @override
  State<SubjectsDropDown> createState() => _SubjectsDropDownState();
}

class _SubjectsDropDownState extends State<SubjectsDropDown> {
  final _searchController = TextEditingController();

  late int _key;
  _collapse() {
    int newKey = 0;
    do {
      _key = Random().nextInt(10000);
    } while (newKey == _key);
  }

  @override
  void initState() {
    super.initState();
    _collapse();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DataEntryProvider>(
      builder: (context, dataEntry, child) {
        return Container(
          color: AppColors.greyColor,
          child: ExpansionTile(
            key: Key(_key.toString()),
            title: Text(dataEntry.selectedSubject),
            backgroundColor: AppColors.greyColor,
            children: [
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    TextField(
                      controller: _searchController,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        hintText: 'Type to search',
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                      ),
                      onChanged: (value) {
                        dataEntry.searchSubject(value);
                      },
                    ),
                    const Divider(
                      color: Colors.black,
                      height: 1,
                    ),
                    SizedBox(
                      height: 150.h,
                      child: ListView.builder(
                        itemCount: dataEntry.subjectsList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              dataEntry.setSubject(
                                  dataEntry.subjectsList[index],
                                  dataEntry.categories[dataEntry.currentSubject]
                                      .toString(),
                                  index);
                              _collapse();
                            },
                            child: Container(
                              color: Colors.white,
                              padding: EdgeInsets.only(top: 10.h),
                              alignment: Alignment.center,
                              child: Column(
                                children: [
                                  Text(
                                    dataEntry.subjectsList[index],
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  const Divider(
                                    color: Colors.black,
                                    height: 1,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (_searchController.text.isNotEmpty) {
                          dataEntry.addSubject(
                              _searchController.text, dataEntry.subjectsList);
                          _searchController.clear();
                          _collapse();
                          dataEntry.updateSubjectsData();
                        } else {
                          ScaffoldMessenger.of(context)
                            ..removeCurrentSnackBar()
                            ..showSnackBar(const SnackBar(
                                content: Text("Can Not Be Empty")));
                        }
                      },
                      child: Container(
                          padding: EdgeInsets.all(10.h),
                          color: AppColors.brandingColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                              Text(
                                'Add New',
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class TopicsDropDown extends StatefulWidget {
  const TopicsDropDown({Key? key}) : super(key: key);

  @override
  State<TopicsDropDown> createState() => _TopicsDropDownState();
}

class _TopicsDropDownState extends State<TopicsDropDown> {
  final _searchController = TextEditingController();

  late int _key;
  _collapse() {
    int newKey = 0;
    do {
      _key = Random().nextInt(10000);
    } while (newKey == _key);
  }

  @override
  void initState() {
    super.initState();
    _collapse();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DataEntryProvider>(
      builder: (context, dataEntry, child) {
        return Container(
          color: AppColors.greyColor,
          child: ExpansionTile(
            key: Key(_key.toString()),
            title: Text(dataEntry.selectedTopic),
            backgroundColor: AppColors.greyColor,
            children: [
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    TextField(
                      controller: _searchController,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        hintText: 'Type to search',
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                      ),
                      onChanged: (value) {
                        dataEntry.searchTopics(value);
                      },
                    ),
                    const Divider(
                      color: Colors.black,
                      height: 1,
                    ),
                    SizedBox(
                      height: 150.h,
                      child: ListView.builder(
                        itemCount: dataEntry.topicList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              dataEntry.setTopic(dataEntry.topicList[index]);
                              _collapse();
                            },
                            child: Container(
                              color: Colors.white,
                              padding: EdgeInsets.only(top: 10.h),
                              alignment: Alignment.center,
                              child: Column(
                                children: [
                                  Text(
                                    dataEntry.topicList[index],
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  const Divider(
                                    color: Colors.black,
                                    height: 1,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (_searchController.text.isNotEmpty) {
                          dataEntry.addTopic(
                              _searchController.text, dataEntry.topicList);
                          _searchController.clear();
                          _collapse();
                          dataEntry.updateTopicData();
                        } else {
                          ScaffoldMessenger.of(context)
                            ..removeCurrentSnackBar()
                            ..showSnackBar(const SnackBar(
                                content: Text("Can Not Be Empty")));
                        }
                      },
                      child: Container(
                          padding: EdgeInsets.all(10.h),
                          color: AppColors.brandingColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                              Text(
                                'Add New',
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
