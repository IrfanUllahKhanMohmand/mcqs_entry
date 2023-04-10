import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mcqs_entry/common/utills/app_constants.dart';

class DataEntryProvider extends ChangeNotifier{
  String _type = "MCQS";
  String get type => _type;

  String _topic = "";
  String get topic => _topic;


  bool _option1 = true;
  bool _option2 = false;
  bool _option3 = false;
  bool _option4 = false;


  bool get option1 => _option1;
  bool get option2 => _option2;
  bool get option3 => _option3;
  bool get option4 => _option4;



  void setOption(bool value, int optionNumber){
    if(optionNumber == 1){
      _option1 = value;
      _option2 = false;
      _option3 = false;
      _option4 = false;
    }else if(optionNumber == 2){
      _option1 = false;
      _option2 = value;
      _option3 = false;
      _option4 = false;
    }else if(optionNumber == 3){
      _option1 = false;
      _option2 = false;
      _option3 = value;
      _option4 = false;
    }else if(optionNumber == 4){
      _option1 = false;
      _option2 = false;
      _option3 = false;
      _option4 = value;
    }
    notifyListeners();
  }


  /// logic for categories
  int _currentCategory = 0;
  List<String> _categories = [];
  List<String> get categories => _categories;
  String _selectedCategory = "";
  String get selectedCategory => _selectedCategory;


  int get currentCategory => _currentCategory;
  final List _availableMainCategoriesList = [
    mCQSMainCategories,
    testMainCategories
  ];


  void setType(String value){
    _type = value;
    if(_type == "MCQS"){
      /// this is for MCQs section
      _currentCategory = 0;
      _categories = _availableMainCategoriesList[0];
      _selectedCategory = categories[0];
      int subjectIndex = _availableSubjectsList.indexWhere((element) => element.currentTopic == _selectedCategory);
      _currentSubject = subjectIndex;
      _subjectsList = _availableSubjectsList[subjectIndex].list!;
      _selectedSubject = _subjectsList[0];
      int topicIndex = _availableTopicsList.indexWhere((element) => element.currentTopic == _selectedSubject);
      _currentTopic = topicIndex;
      _topicList = _availableTopicsList[topicIndex].list!;
      _selectedTopic = _topicList[0];
    }else{
      /// this is for test section
      _currentCategory = 1;
      _categories = _availableMainCategoriesList[1];
      _selectedCategory = categories[0];
      int topicIndex = _availableTestTopicsList.indexWhere((element) => element.currentTopic == _selectedCategory);
      _currentTopic = topicIndex;
      _topicList = _availableTestTopicsList[topicIndex].list!;
      _selectedTopic = _topicList[0];
    }
    notifyListeners();
  }

  void setMainCategory(String categorySelected){
    _selectedCategory = categorySelected;
    if(_type == "MCQS"){
      int subjectIndex = _availableSubjectsList.indexWhere((element)=>element.currentTopic == categorySelected);
      if(subjectIndex != -1){
        _subjectsList = _availableSubjectsList[subjectIndex].list!;
        _currentSubject = subjectIndex;
        if(_subjectsList.isNotEmpty){
          _selectedSubject = _subjectsList[0];
          int topicIndex = _availableTopicsList.indexWhere((element) => element.currentTopic == _selectedSubject);
          if(topicIndex != -1){
            _topicList = _availableTopicsList[topicIndex].list!;
            _currentTopic = topicIndex;
            if(_topicList.isNotEmpty){
              _selectedTopic = _topicList[0];
            }else{
              _selectedTopic = "";
            }
          }else{
            _topicList = [];
            _selectedTopic = "No Topics";
          }
        }else{
          _selectedSubject = "No Subject";
        }
      }
    }else{
      int testIndex = _availableTestTopicsList.indexWhere((element) => element.currentTopic == categorySelected);
      if(testIndex != -1){
        _topicList = _availableTestTopicsList[testIndex].list!;
        _currentTopic = testIndex;
        if(topicList.isNotEmpty){
          _selectedTopic = _topicList[0];
        }else{
          _selectedTopic = "";
        }
      }else{
        _topicList = [];
        _selectedTopic = "";
      }
    }
    notifyListeners();
  }

  void addCategory(String category,List toBeUpdated){
    /// either adding in test list or mCQS list
    _availableMainCategoriesList[_currentCategory].add(category);
    _selectedCategory = category;
    if(_currentCategory == 0){
      _topicList = [];
      _selectedTopic = "No";
      Hive.box(appBox).put(mainCategoriesListKey, _availableMainCategoriesList[_currentCategory]);
      _availableSubjectsList.add(AvailableTopics(key: "${category}SubjectsKey", list: [],currentTopic: category));
      Hive.box(appBox).put(availableSubjectListKey, _availableSubjectsList);
      int subjectIndex = _availableSubjectsList.indexWhere((element) => element.currentTopic == category);
      if(subjectIndex != -1){
        _selectedSubject = "";
        _subjectsList = _availableSubjectsList[subjectIndex].list!;
        _currentSubject = subjectIndex;
      }
    }else{
      /// so for test, value could be css, which is a test name as currentTopic.
      Hive.box(appBox).put(mainTestListKey, _availableMainCategoriesList[_currentCategory]);
      _availableTestTopicsList.add(AvailableTopics(key: "${category}TopicsKey", list: [],currentTopic: category));
      Hive.box(appBox).put(availableTestTopicsListKey, _availableTestTopicsList);
      int topicIndex = _availableTestTopicsList.indexWhere((element) => element.currentTopic == category);
      if(topicIndex != -1){
        _selectedTopic = "";
        _topicList = _availableTestTopicsList[topicIndex].list!;
        _currentTopic = topicIndex;
      }
    }
    notifyListeners();
  }


  /// to update list after adding new item
  void updateData(){
    List<String> updatedMainCategory = (Hive.box(appBox).get(_currentCategory == 0 ? mainCategoriesListKey : mainTestListKey) as List<dynamic>).map((e) => e.toString()).toList();
    _categories = updatedMainCategory;
  }

  /// to do searching in list
  void searchCategory(String query){
    List<String> categoryListCopy = _availableMainCategoriesList[_currentCategory];
    if(query.isEmpty){
      _categories = categoryListCopy;
    }else{
      var suggestions = categoryListCopy.where((element) {
        final title = element.toLowerCase();
        final input = query.toLowerCase();
        return title.contains(input);
      }).toList();
      _categories = suggestions;
    }
    notifyListeners();
  }

  /// logic for subjects
  int _currentSubject = 0;
  int get currentSubject => _currentSubject;
  List<String> _subjectsList = [];
  List<String> get subjectsList => _subjectsList;
  String _selectedSubject = "";
  String get selectedSubject => _selectedSubject;



  // Hive.box(appBox).get(availableSubjectListKey) != null ? (jsonDecode() as List<dynamic>).map((e) => Available.fromJson(e)).toList() :
  final List<AvailableTopics> _availableSubjectsList =  Hive.box(appBox).get(availableSubjectListKey)!= null ? (Hive.box(appBox).get(availableSubjectListKey) as List<dynamic>).map((e) => AvailableTopics(key: e.key, list: e.list,currentTopic: e.currentTopic)).toList(): [
    AvailableTopics(key: commonSubjectsCategoriesListKey,list: commonSubjectsCategories,currentTopic: "Common Subjects"),
    AvailableTopics(key: managementSubjectsCategoriesListKey,list: managementSubjectsCategories,currentTopic: "Management Subjects"),
    AvailableTopics(key: medicalSubjectsCategoriesListKey,list: medicalSubjectsCategories,currentTopic: "Medical Subjects"),
    AvailableTopics(key: engineeringSubjectsCategoriesListKey,list: engineeringSubjectsCategories,currentTopic: "Engineering"),
  ];


  void setSubject(String subjectSelected,int index){
    _selectedSubject = subjectSelected;
    int subjectIndex = _availableTopicsList.indexWhere((element) => element.currentTopic == subjectSelected);
    if(subjectIndex != -1){
      _topicList = _availableTopicsList[subjectIndex].list!;
      _currentSubject = subjectIndex;
      if(topicList.isNotEmpty){
        _selectedTopic = _topicList[0];
      }else{
        _selectedTopic = "";
      }
    }else{
      _topicList = [];
      _selectedTopic = "No Topics Yet";
    }
    notifyListeners();
  }

  void addSubject(String subject,List toBeUpdated){
    _availableSubjectsList[_currentSubject].list!.add(subject);
    _selectedSubject = subject;
    _topicList = [];
    _selectedTopic = "";
    notifyListeners();
    Hive.box(appBox).put(_availableSubjectsList[_currentSubject].key, _availableSubjectsList[_currentSubject].list);
    _availableTopicsList.add(AvailableTopics(key: "${subject}TopicKey", list: [], currentTopic: subject));
    Hive.box(appBox).put(availableTopicsListKey, _availableTopicsList);
    Hive.box(appBox).put(availableSubjectListKey, _availableSubjectsList).then((value) {
      int topicIndex = _availableTopicsList.indexWhere((element) => element.currentTopic == subject);
      if(topicIndex != -1){
        _topicList = _availableTopicsList[topicIndex].list!;
        _currentTopic = topicIndex;
        if(_topicList.isNotEmpty){
          _selectedTopic = _topic[0];
        }else{
          _selectedTopic = "";
        }
      }
    });
  }

  /// to update list after adding new item
  void updateSubjectsData(){
    List<String> updatedSubjectList = (Hive.box(appBox).get(_availableSubjectsList[_currentSubject].key) as List<dynamic>).map((e) => e.toString()).toList();
    _subjectsList = updatedSubjectList;
  }

  /// to do searching in list
  void searchSubject(String query){
    List<String> subjectsListCopy = _availableSubjectsList[_currentSubject].list!;
    if(query.isEmpty){
      _subjectsList = subjectsListCopy;
    }else{
      var suggestions = subjectsListCopy.where((element) {
        final title = element.toLowerCase();
        final input = query.toLowerCase();
        return title.contains(input);
      }).toList();
      _subjectsList = suggestions;
    }
    notifyListeners();
  }


  /// logic for Topics
  int _startingIndex = 0;
  int get startingIndex => _startingIndex;
  int _currentTopic = 0;
  int get currentTopic => _currentTopic;
  List<String> _topicList = [];
  List<String> get topicList => _topicList;
  String _selectedTopic = "";
  String get selectedTopic => _selectedTopic;

  // Hive.box(appBox).get(availableTopicsListKey) != null ? (jsonDecode(Hive.box(appBox).get(availableTopicsListKey)) as List<dynamic>).map((e) => Available.fromJson(e)).toList() :
  final List<AvailableTopics> _availableTopicsList = Hive.box(appBox).get(availableTopicsListKey) != null ? (Hive.box(appBox).get(availableTopicsListKey) as List<dynamic>).map((e) => AvailableTopics(key: e.key,list: e.list,currentTopic: e.currentTopic)).toList() : [
    AvailableTopics(key: englishTopicsKey, list: englishTopics,currentTopic: "English"),
    AvailableTopics(key: generalKnowledgeTopicsKey,list:  generalKnowledgeTopics,currentTopic: "General Knowledge"),
    AvailableTopics(key: pakistanCurrentAffairsTopicsKey,list:  pakistanCurrentAffairsTopics,currentTopic: "Pak Studies"),
    AvailableTopics(key: mathematicsTopicsKey,list:  mathematicsTopics,currentTopic: "Chemical Engineering"),
  ];


  final List<AvailableTopics> _availableTestTopicsList = Hive.box(appBox).get(availableTestTopicsListKey) != null ? (Hive.box(appBox).get(availableTestTopicsListKey) as List<dynamic>).map((e) => AvailableTopics(key: e.key,list: e.list,currentTopic: e.currentTopic)).toList() :[
    AvailableTopics(key: ntsTestTopicsKey, list: ntsTestTopics,currentTopic: "NTS"),
    AvailableTopics(key: fpscTestTopicsKey, list: fpscTestTopics,currentTopic: "FPSC"),
    AvailableTopics(key: ppscTestTopicsKey, list: ppscTestTopics,currentTopic: "PPSC"),
  ];


  void setTopic(String topicSelected){
    _selectedTopic = topicSelected;
    notifyListeners();
  }

  void addTopic(String value,List toBeUpdated){
    if(_type == "MCQS"){
      _availableTopicsList[_currentTopic].list!.add(value);
      _selectedTopic = value;
      Hive.box(appBox).put(_availableTopicsList[_currentTopic].key, _availableTopicsList[_currentTopic].list);
      Hive.box(appBox).put(availableTopicsListKey, _availableTopicsList);
      notifyListeners();
    }else{
      _availableTestTopicsList[_currentTopic].list!.add(value);
      _selectedTopic = value;
      Hive.box(appBox).put(_availableTestTopicsList[_currentTopic].key, _availableTestTopicsList[_currentTopic].list);
      Hive.box(appBox).put(availableTestTopicsListKey, _availableTestTopicsList);
      notifyListeners();
    }
  }


  /// to update list after adding new item
  void updateTopicData(){
    if(_type == "MCQS"){
      List<String> updatedTopicList = (Hive.box(appBox).get(_availableTopicsList[_currentTopic].key) as List<dynamic>).map((e) => e.toString()).toList();
      _topicList = updatedTopicList;
    }else{
      List<String> updatedTopicList = (Hive.box(appBox).get(_availableTestTopicsList[_currentTopic].key) as List<dynamic>).map((e) => e.toString()).toList();
      _topicList = updatedTopicList;
    }
  }

  /// to do searching in list
  void searchTopics(String query){
    List<String> topicsListCopy = _type == "MCQS" ? _availableTopicsList[_currentTopic].list! : _availableTestTopicsList[_currentTopic].list!;
    if(query.isEmpty){
      _topicList = topicsListCopy;
    }else{
      var suggestions = topicsListCopy.where((element) {
        final title = element.toLowerCase();
        final input = query.toLowerCase();
        return title.contains(input);
      }).toList();
      _topicList = suggestions;
    }
    notifyListeners();
  }

  // init category
  initCategory(){
    /// for main categories
    _currentCategory = 0;
    _categories = _availableMainCategoriesList[0];
    _selectedCategory = categories[0];
    /// for subjects
    int subjectIndex = _availableSubjectsList.indexWhere((element) => element.currentTopic == _selectedCategory);
    _currentSubject = subjectIndex;
    _subjectsList = _availableSubjectsList[subjectIndex].list!;
    _selectedSubject = _subjectsList[0];
    /// for topics
    int topicIndex = _availableTopicsList.indexWhere((element) => element.currentTopic == _selectedSubject);
    _currentTopic = topicIndex;
    _topicList = _availableTopicsList[topicIndex].list!;
    _selectedTopic = _topicList[0];
    notifyListeners();
  }

  // upload Data

  uploadDataToFirebase({
    required String question,
    required String optionOne,
    required String optionTwo,
    required String optionThree,
    required String optionFour,
    required VoidCallback onComplete
  }) async {
    /// this is for MCQS Entry
    if (_type == "MCQS") {
      FirebaseFirestore.instance
          .collection(_type)
          .doc(_selectedCategory)
          .get()
          .then((doc) {
        if (!doc.exists) {
          FirebaseFirestore.instance
              .collection(_type)
              .doc(_selectedCategory)
              .set({"name": _selectedCategory});
        }
        FirebaseFirestore.instance
            .collection(_type)
            .doc(_selectedCategory)
            .collection("categories")
            .doc(_selectedSubject)
            .get()
            .then((catDoc) {
          if (!catDoc.exists) {
            FirebaseFirestore.instance
                .collection(_type)
                .doc(_selectedCategory)
                .collection("categories")
                .doc(_selectedSubject)
                .set({
              "name": _selectedSubject,
              "icon": "assets/icons/categories_icons/${_selectedSubject.toLowerCase().replaceAll(" ", "")}.png"
            });
          }

          FirebaseFirestore.instance
              .collection(_type)
              .doc(_selectedCategory)
              .collection("categories")
              .doc(_selectedSubject)
              .collection("subCategory")
              .doc(_selectedTopic)
              .get()
              .then((subCatDoc) async {
            if (!subCatDoc.exists) {
              FirebaseFirestore.instance
                  .collection(_type)
                  .doc(_selectedCategory)
                  .collection("categories")
                  .doc(_selectedSubject)
                  .collection("subCategory")
                  .doc(_selectedTopic)
                  .set({
                "subcategory_name": _selectedTopic,
                "subcategory_icon": "assets/icons/categories_icons/${_selectedSubject.toLowerCase().replaceAll(" ", "")}.png",
                "questions": [
                  {
                    "isClick": false,
                    "question": question,
                    "options": [
                      {
                        "text": optionOne,
                        "isCorrect": _option1
                      },
                      {
                        "text": optionTwo,
                        "isCorrect": _option2
                      },
                      {
                        "text": optionThree,
                        "isCorrect": _option3
                      },
                      {
                        "text": optionFour,
                        "isCorrect": _option4
                      }
                    ]
                  },
                ]
              }).then((value) {
                onComplete();
              });
            } else {
              await FirebaseFirestore.instance
                  .collection(_type)
                  .doc(_selectedCategory)
                  .collection("categories")
                  .doc(_selectedSubject)
                  .collection("subCategory")
                  .doc(_selectedTopic)
                  .update({
                "questions": FieldValue.arrayUnion([
                  {
                    "isClick": false,
                    "question": question,
                    "options": [
                      {
                        "text": optionOne,
                        "isCorrect": _option1
                      },
                      {
                        "text": optionTwo,
                        "isCorrect": _option2
                      },
                      {
                        "text": optionThree,
                        "isCorrect": _option3
                      },
                      {
                        "text": optionFour,
                        "isCorrect": _option4
                      }
                    ]
                  }
                ])
              }).then((value) async{
                onComplete();
              });
            }
          });
        });
      });
    } else {
      /// This is For Test Entry
      FirebaseFirestore.instance
          .collection(_type)
          .doc(_selectedCategory)
          .get()
          .then((doc) {
        if (!doc.exists) {
          FirebaseFirestore.instance
              .collection(_type)
              .doc(_selectedCategory)
              .set({"test_name": _selectedCategory});
        }

        FirebaseFirestore.instance
            .collection(_type)
            .doc(_selectedCategory)
            .collection("test_sub_categories")
            .doc(_selectedTopic)
            .get()
            .then((catDoc) {
          if (!catDoc.exists) {
            FirebaseFirestore.instance
                .collection(_type)
                .doc(_selectedCategory)
                .collection("test_sub_categories")
                .doc(_selectedTopic)
                .set({
              "subcategory_name": _selectedTopic,
              "subcategory_icon": "assets/icons/categories_icons/test.png",
              "questions": [
                {
                  "isClick": false,
                  "question": question,
                  "options": [
                    {
                      "text": optionOne,
                      "isCorrect": _option1
                    },
                    {
                      "text": optionTwo,
                      "isCorrect": _option2
                    },
                    {
                      "text": optionThree,
                      "isCorrect": _option3
                    },
                    {
                      "text": optionFour,
                      "isCorrect": _option4
                    }
                  ]
                }
              ]
            }).then((value) {
              onComplete();
            });
          }else{
            FirebaseFirestore.instance
                .collection(_type)
                .doc(_selectedCategory)
                .collection("test_sub_categories")
                .doc(_selectedTopic)
                .update({
              "questions": FieldValue.arrayUnion([
                {
                  "isClick": false,
                  "question": question,
                  "options": [
                    {
                      "text": optionOne,
                      "isCorrect": _option1
                    },
                    {
                      "text": optionTwo,
                      "isCorrect": _option2
                    },
                    {
                      "text": optionThree,
                      "isCorrect": _option3
                    },
                    {
                      "text": optionFour,
                      "isCorrect": _option4
                    }
                  ]
                }
              ])
            }).then((value) {
              onComplete();
            });
          }
        });
      });
    }
  }
}


class AvailableTopics{
  String? key;
  List<String>? list;
  String? currentTopic;
  AvailableTopics({required this.key,required this.list,required this.currentTopic});
  AvailableTopics.fromJson(Map<String,dynamic> json){
    key = json['key'];
    list = json['list'];
    currentTopic = json['topicName'];
  }

  Map toJson(){
    return {
      "key":key,
      "list":list,
      'topicName':currentTopic
    };
  }
}