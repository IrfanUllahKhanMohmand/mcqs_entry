import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mcqs_entry/common/utills/app_constants.dart';

class DataEntryProvider extends ChangeNotifier {
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
  int correctOption = 1;
  bool isUploading = false;

  setIsUploading(bool value) {
    isUploading = value;
    notifyListeners();
  }

  void setOption(bool value, int optionNumber) {
    correctOption = optionNumber;
    if (optionNumber == 1) {
      _option1 = value;
      _option2 = false;
      _option3 = false;
      _option4 = false;
    } else if (optionNumber == 2) {
      _option1 = false;
      _option2 = value;
      _option3 = false;
      _option4 = false;
    } else if (optionNumber == 3) {
      _option1 = false;
      _option2 = false;
      _option3 = value;
      _option4 = false;
    } else if (optionNumber == 4) {
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

  void setType(String value) {
    _type = value;
    if (_type == "MCQS") {
      /// this is for MCQs section
      _currentCategory = 0;
      _categories = _availableMainCategoriesList[0];
      _selectedCategory = categories[0];
      int subjectIndex = _availableSubjectsList
          .indexWhere((element) => element.currentTopic == _selectedCategory);
      _currentSubject = subjectIndex;
      _subjectsList = _availableSubjectsList[subjectIndex].list!;
      _selectedSubject = _subjectsList[0];
      int topicIndex = _availableTopicsList
          .indexWhere((element) => element.currentTopic == _selectedSubject);
      _currentTopic = topicIndex;
      _topicList = _availableTopicsList[topicIndex].list!;
      _selectedTopic = _topicList[0];
    } else {
      /// this is for test section
      _currentCategory = 1;
      _categories = _availableMainCategoriesList[1];
      _selectedCategory = categories[0];
      int topicIndex = _availableTestTopicsList
          .indexWhere((element) => element.currentTopic == _selectedCategory);
      _currentTopic = topicIndex;
      _topicList = _availableTestTopicsList[topicIndex].list!;
      if (_topicList.isNotEmpty) {
        _selectedTopic = _topicList[0];
      } else {
        _selectedTopic = "";
      }
    }
    notifyListeners();
  }

  void setMainCategory(String categorySelected) {
    _selectedCategory = categorySelected;
    if (_type == "MCQS") {
      int subjectIndex = _availableSubjectsList
          .indexWhere((element) => element.currentTopic == categorySelected);
      if (subjectIndex != -1) {
        _subjectsList = _availableSubjectsList[subjectIndex].list!;
        _currentSubject = subjectIndex;
        if (_subjectsList.isNotEmpty) {
          _selectedSubject = _subjectsList[0];
          int topicIndex = _availableTopicsList.indexWhere(
              (element) => element.currentTopic == _selectedSubject);
          if (topicIndex != -1) {
            _topicList = _availableTopicsList[topicIndex].list!;
            _currentTopic = topicIndex;
            if (_topicList.isNotEmpty) {
              _selectedTopic = _topicList[0];
            } else {
              _selectedTopic = "";
            }
          } else {
            _topicList = [];
            _selectedTopic = "No Topics";
          }
        } else {
          _selectedSubject = "No Subject";
        }
      }
    } else {
      int testIndex = _availableTestTopicsList
          .indexWhere((element) => element.currentTopic == categorySelected);
      if (testIndex != -1) {
        _topicList = _availableTestTopicsList[testIndex].list!;
        _currentTopic = testIndex;
        if (topicList.isNotEmpty) {
          _selectedTopic = _topicList[0];
        } else {
          _selectedTopic = "";
        }
      } else {
        _topicList = [];
        _selectedTopic = "";
      }
    }
    notifyListeners();
  }

  void addCategory(String category, List toBeUpdated) {
    /// either adding in test list or mCQS list
    _availableMainCategoriesList[_currentCategory].add(category);
    _selectedCategory = category;
    if (_currentCategory == 0) {
      _topicList = [];
      _selectedTopic = "No";
      Hive.box(appBox).put(mainCategoriesListKey,
          _availableMainCategoriesList[_currentCategory]);
      _availableSubjectsList.add(AvailableTopics(
          key: "${category}SubjectsKey",
          list: [],
          currentTopic: category,
          currentCategory: categories[currentSubject]));
      Hive.box(appBox).put(availableSubjectListKey, _availableSubjectsList);
      int subjectIndex = _availableSubjectsList
          .indexWhere((element) => element.currentTopic == category);
      if (subjectIndex != -1) {
        _selectedSubject = "";
        _subjectsList = _availableSubjectsList[subjectIndex].list!;
        _currentSubject = subjectIndex;
      }
    } else {
      /// so for test, value could be css, which is a test name as currentTopic.
      Hive.box(appBox)
          .put(mainTestListKey, _availableMainCategoriesList[_currentCategory]);
      _availableTestTopicsList.add(AvailableTopics(
          key: "${category}TopicsKey",
          list: [],
          currentTopic: category,
          currentCategory: categories[currentSubject]));
      Hive.box(appBox)
          .put(availableTestTopicsListKey, _availableTestTopicsList);
      int topicIndex = _availableTestTopicsList
          .indexWhere((element) => element.currentTopic == category);
      if (topicIndex != -1) {
        _selectedTopic = "";
        _topicList = _availableTestTopicsList[topicIndex].list!;
        _currentTopic = topicIndex;
      }
    }
    notifyListeners();
  }

  /// to update list after adding new item
  void updateData() {
    List<String> updatedMainCategory = (Hive.box(appBox).get(
                _currentCategory == 0 ? mainCategoriesListKey : mainTestListKey)
            as List<dynamic>)
        .map((e) => e.toString())
        .toList();
    _categories = updatedMainCategory;
  }

  /// to do searching in list
  void searchCategory(String query) {
    List<String> categoryListCopy =
        _availableMainCategoriesList[_currentCategory];
    if (query.isEmpty) {
      _categories = categoryListCopy;
    } else {
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
  final List<AvailableTopics> _availableSubjectsList =
      Hive.box(appBox).get(availableSubjectListKey) != null
          ? (Hive.box(appBox).get(availableSubjectListKey) as List<dynamic>)
              .map((e) => AvailableTopics(
                  key: e.key,
                  list: e.list,
                  currentTopic: e.currentTopic,
                  currentCategory: e.currentCategory))
              .toList()
          : [
              AvailableTopics(
                  key: commonSubjectsListKey,
                  list: commonSubjectsList,
                  currentTopic: "Common Subjects",
                  currentCategory: "Common Subjects"),
              AvailableTopics(
                  key: generalKnowledgeSubjectsListKey,
                  list: generalKnowledgeSubjectList,
                  currentTopic: "General Knowledge",
                  currentCategory: "General Knowledge"),
              AvailableTopics(
                  key: managementSubjectsListKey,
                  list: managementSubjectList,
                  currentTopic: "Management Subjects",
                  currentCategory: "Management Subjects"),
              AvailableTopics(
                  key: medicalSubjectsListKey,
                  list: medicalSubjectList,
                  currentTopic: "Medical Subjects",
                  currentCategory: "Medical Subjects"),
              AvailableTopics(
                  key: engineeringSubjectsListKey,
                  list: engineeringSubjectList,
                  currentTopic: "Engineering",
                  currentCategory: "Engineering"),
              AvailableTopics(
                  key: generalScienceSubjectListKey,
                  list: generalScienceSubjectList,
                  currentTopic: "General Science",
                  currentCategory: "General Science"),
              AvailableTopics(
                  key: educationSubjectListKey,
                  list: educationSubjectList,
                  currentTopic: "Education",
                  currentCategory: "Education"),
              AvailableTopics(
                  key: aptitudeSubjectListKey,
                  list: aptitudeSubjectList,
                  currentTopic: "Aptitude",
                  currentCategory: "Aptitude"),
              AvailableTopics(
                  key: otherSubjectListKey,
                  list: otherSubjectList,
                  currentTopic: "Other Subjects",
                  currentCategory: "Other Subjects"),
            ];

  void setSubject(String subjectSelected, String currentCategory, int index) {
    _selectedSubject = subjectSelected;

    int topicIndex = _availableTopicsList.indexWhere((element) =>
        element.currentTopic == subjectSelected &&
        element.currentCategory == currentCategory);
    if (topicIndex != -1) {
      _topicList = _availableTopicsList[topicIndex].list!;
      _currentTopic = topicIndex;
      if (topicList.isNotEmpty) {
        _selectedTopic = _topicList[0];
      } else {
        _selectedTopic = "";
      }
    } else {
      _topicList = [];
      _selectedTopic = "No Topics Yet";
    }
    notifyListeners();
  }

  void addSubject(String subject, List toBeUpdated) {
    _availableSubjectsList[_currentSubject].list!.add(subject);
    _selectedSubject = subject;
    _topicList = [];
    _selectedTopic = "";
    notifyListeners();
    Hive.box(appBox).put(_availableSubjectsList[_currentSubject].key,
        _availableSubjectsList[_currentSubject].list);
    _availableTopicsList.add(AvailableTopics(
        key: "${subject}TopicKey",
        list: [],
        currentTopic: subject,
        currentCategory: categories[currentSubject]));
    Hive.box(appBox).put(availableTopicsListKey, _availableTopicsList);
    Hive.box(appBox)
        .put(availableSubjectListKey, _availableSubjectsList)
        .then((value) {
      int topicIndex = _availableTopicsList
          .indexWhere((element) => element.currentTopic == subject);
      if (topicIndex != -1) {
        _topicList = _availableTopicsList[topicIndex].list!;
        _currentTopic = topicIndex;
        if (_topicList.isNotEmpty) {
          _selectedTopic = _topic[0];
        } else {
          _selectedTopic = "";
        }
      }
    });
  }

  /// to update list after adding new item
  void updateSubjectsData() {
    List<String> updatedSubjectList = (Hive.box(appBox)
            .get(_availableSubjectsList[_currentSubject].key) as List<dynamic>)
        .map((e) => e.toString())
        .toList();
    _subjectsList = updatedSubjectList;
  }

  /// to do searching in list
  void searchSubject(String query) {
    List<String> subjectsListCopy =
        _availableSubjectsList[_currentSubject].list!;
    if (query.isEmpty) {
      _subjectsList = subjectsListCopy;
    } else {
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
  final List<AvailableTopics> _availableTopicsList =
      Hive.box(appBox).get(availableTopicsListKey) != null
          ? (Hive.box(appBox).get(availableTopicsListKey) as List<dynamic>)
              .map((e) => AvailableTopics(
                  key: e.key,
                  list: e.list,
                  currentTopic: e.currentTopic,
                  currentCategory: e.currentCategory))
              .toList()
          : [
              /// for common subject
              AvailableTopics(
                  key: englishTopicsListKey,
                  list: englishTopicsList,
                  currentTopic: "English",
                  currentCategory: "Common Subjects"),
              AvailableTopics(
                  key: pakistanCurrentAffairTopicsListKey,
                  list: pakistanCurrentAffairsTopicsList,
                  currentTopic: "Pakistan Current Affairs",
                  currentCategory: "Common Subjects"),
              AvailableTopics(
                  key: internationalCurrentAffairsTopicsListKey,
                  list: internationalCurrentAffairsTopicsList,
                  currentTopic: "International Current Affairs",
                  currentCategory: "Common Subjects"),
              AvailableTopics(
                  key: mathsTopicsListKey,
                  list: mathematicsTopicsList,
                  currentTopic: "Mathematics",
                  currentCategory: "Common Subjects"),
              AvailableTopics(
                  key: pakStudyTopicsListKey,
                  list: pakStudyTopicsList,
                  currentTopic: "Pak Study",
                  currentCategory: "Common Subjects"),
              AvailableTopics(
                  key: islamicStudyTopicListKey,
                  list: islamicStudyTopicsList,
                  currentTopic: "Islamic Study",
                  currentCategory: "Common Subjects"),
              AvailableTopics(
                  key: computerTopicsListKey,
                  list: computerTopicsList,
                  currentTopic: "Computer",
                  currentCategory: "Common Subjects"),
              AvailableTopics(
                  key: everydayScienceTopicsListKey,
                  list: everydayScienceTopicsList,
                  currentTopic: "Everyday Science",
                  currentCategory: "Common Subjects"),
              AvailableTopics(
                  key: urduTopicsListKey,
                  list: urduTopicsList,
                  currentTopic: "Urdu",
                  currentCategory: "Common Subjects"),

              /// for general Knowledge now
              AvailableTopics(
                  key: basicGeneralKnowledgeTopicsListKey,
                  list: basicGeneralKnowledgeTopicsList,
                  currentTopic: "Basic General Knowledge",
                  currentCategory: "General Knowledge"),
              AvailableTopics(
                  key: subjectWiseGkTopicsListKey,
                  list: subjectWiseGkTopicsList,
                  currentTopic: "Subject wise Gk",
                  currentCategory: "General Knowledge"),
              AvailableTopics(
                  key: worldGkTopicsListKey,
                  list: worldGkTopicsList,
                  currentTopic: "World Gk",
                  currentCategory: "General Knowledge"),
              AvailableTopics(
                  key: pakistanGeneralKnowledgeTopicsListKey,
                  list: pakistanGeneralKnowledgeTopicsList,
                  currentTopic: "Pakistan General Knowledge",
                  currentCategory: "General Knowledge"),
              // AvailableTopics(
              //     key: allTestGeneralKnowledgeTopicsListKey,
              //     list: allTestGeneralKnowledgeTopicsList,
              //     currentTopic: "All test General Knowledge"),

              /// for medical Subject Now
              AvailableTopics(
                  key: biologyTopicsListKey,
                  list: biologyTopicList,
                  currentTopic: "Biology",
                  currentCategory: "Medical Subjects"),
              AvailableTopics(
                  key: bioChemistryTopicsListKey,
                  list: biochemistryTopicList,
                  currentTopic: "Bio Chemistry",
                  currentCategory: "Medical Subjects"),
              AvailableTopics(
                  key: oralAnatomyTopicsListKey,
                  list: oralAnatomyTopicList,
                  currentTopic: "Oral Anatomy",
                  currentCategory: "Medical Subjects"),
              AvailableTopics(
                  key: oralPathologyAndMedicineTopicsListKey,
                  list: oralPathologyAndMedicinesTopicList,
                  currentTopic: "Oral Pathology and Medicine",
                  currentCategory: "Medical Subjects"),
              AvailableTopics(
                  key: oralHistologyTopicsListKey,
                  list: oralHistologyTopicList,
                  currentTopic: "Oral Histology",
                  currentCategory: "Medical Subjects"),
              AvailableTopics(
                  key: pathologyTopicsListKey,
                  list: pathologyTopicList,
                  currentTopic: "Pathology",
                  currentCategory: "Medical Subjects"),
              AvailableTopics(
                  key: dentalTopicsListKey,
                  list: dentalTopicList,
                  currentTopic: "Dental",
                  currentCategory: "Medical Subjects"),
              AvailableTopics(
                  key: pharmacologyTopicsListKey,
                  list: pharmacologyTopicList,
                  currentTopic: "Pharmacology",
                  currentCategory: "Medical Subjects"),
              AvailableTopics(
                  key: physiologyTopicsListKey,
                  list: physiologyTopicList,
                  currentTopic: "Physiology",
                  currentCategory: "Medical Subjects"),
              AvailableTopics(
                  key: generalAnatomyTopicsListKey,
                  list: generalAnatomyTopicList,
                  currentTopic: "General Anatomy",
                  currentCategory: "Medical Subjects"),
              AvailableTopics(
                  key: bioTechnologyTopicsListKey,
                  list: bioTechnologyTopicList,
                  currentTopic: "Bio Technology",
                  currentCategory: "Medical Subjects"),
              AvailableTopics(
                  key: bioInformaticsTopicsListKey,
                  list: bioInformaticsTopicList,
                  currentTopic: "Bio Informatics",
                  currentCategory: "Medical Subjects"),
              AvailableTopics(
                  key: botanyTopicsListKey,
                  list: botanyTopicList,
                  currentTopic: "Botany",
                  currentCategory: "Medical Subjects"),
              AvailableTopics(
                  key: zoologyTopicsListKey,
                  list: zoologyTopicList,
                  currentTopic: "Zoology",
                  currentCategory: "Medical Subjects"),

              /// for management Science Now
              AvailableTopics(
                  key: accountingTopicsListKey,
                  list: accountingTopicList,
                  currentTopic: "Accounting",
                  currentCategory: "Management Subjects"),
              AvailableTopics(
                  key: economicsTopicsListKey,
                  list: economicsTopicList,
                  currentTopic: "Economics",
                  currentCategory: "Management Subjects"),
              AvailableTopics(
                  key: auditingTopicsListKey,
                  list: auditingTopicList,
                  currentTopic: "Auditing",
                  currentCategory: "Management Subjects"),
              AvailableTopics(
                  key: financeTopicsListKey,
                  list: financeTopicList,
                  currentTopic: "Finance",
                  currentCategory: "Management Subjects"),
              AvailableTopics(
                  key: marketingTopicsListKey,
                  list: marketingTopicList,
                  currentTopic: "Marketing",
                  currentCategory: "Management Subjects"),

              /// for Engineering Subject Now
              AvailableTopics(
                  key: chemicalEngineeringTopicListKey,
                  list: chemicalEngineeringTopicList,
                  currentTopic: "Chemical Engineering",
                  currentCategory: "Engineering"),
              AvailableTopics(
                  key: electricalEngineeringTopicListKey,
                  list: electricalEngineeringTopicList,
                  currentTopic: "Electrical Engineering",
                  currentCategory: "Engineering"),
              AvailableTopics(
                  key: civilEngineeringTopicListKey,
                  list: civilEngineeringTopicList,
                  currentTopic: "Civil Engineering",
                  currentCategory: "Engineering"),
              AvailableTopics(
                  key: mechanicalEngineeringTopicListKey,
                  list: mechanicalEngineeringTopicList,
                  currentTopic: "Mechanical Engineering",
                  currentCategory: "Engineering"),
              AvailableTopics(
                  key: softwareEngineeringTopicListKey,
                  list: softwareEngineeringTopicList,
                  currentTopic: "Software Engineering",
                  currentCategory: "Engineering"),
              AvailableTopics(
                  key: electronicsTopicListKey,
                  list: electronicsTopicList,
                  currentTopic: "Electronics",
                  currentCategory: "Engineering"),

              /// for General Science Now
              AvailableTopics(
                  key: physicsTopicsListKey,
                  list: physicsTopicList,
                  currentTopic: "Physics",
                  currentCategory: "General Science"),
              AvailableTopics(
                  key: chemistryTopicsListKey,
                  list: chemistryTopicList,
                  currentTopic: "Chemistry",
                  currentCategory: "General Science"),
              AvailableTopics(
                  key: biologyGSTopicsListKey,
                  list: biologyGSTopicList,
                  currentTopic: "Biology",
                  currentCategory: "General Science"),

              /// for Education
              AvailableTopics(
                  key: pedagogyTopicsListKey,
                  list: pedagogyTopicList,
                  currentTopic: "Pedagogy",
                  currentCategory: "Education"),
              AvailableTopics(
                  key: psychologyTopicsListKey,
                  list: psychologyTopicList,
                  currentTopic: "Psychology",
                  currentCategory: "Education"),

              /// for Aptitude
              AvailableTopics(
                  key: verbalReasoningTopicsListKey,
                  list: verbalReasoningTopicList,
                  currentTopic: "Verbal Reasoning",
                  currentCategory: "Aptitude"),
              AvailableTopics(
                  key: analyticalReasoningTopicsListKey,
                  list: verbalReasoningTopicList,
                  currentTopic: "Analytical Reasoning",
                  currentCategory: "Aptitude"),
              AvailableTopics(
                  key: quantitativeReasoningListKey,
                  list: verbalReasoningTopicList,
                  currentTopic: "Quantitative Reasoning",
                  currentCategory: "Aptitude"),

              /// for Other Subjects
              AvailableTopics(
                  key: agricultureTopicsListKey,
                  list: agricultureTopicList,
                  currentTopic: "Agriculture",
                  currentCategory: "Other Subjects"),
              AvailableTopics(
                  key: sociologyTopicsListKey,
                  list: sociologyTopicList,
                  currentTopic: "Sociology",
                  currentCategory: "Other Subjects"),
              AvailableTopics(
                  key: englishLiteratureTopicsListKey,
                  list: englishLiteratureTopicList,
                  currentTopic: "English Literature",
                  currentCategory: "Other Subjects"),
              AvailableTopics(
                  key: judiciaryAndLawTopicsListKey,
                  list: judiciaryAndLawTopicList,
                  currentTopic: "Judiciary and Law",
                  currentCategory: "Other Subjects"),
            ];

  final List<AvailableTopics> _availableTestTopicsList =
      Hive.box(appBox).get(availableTestTopicsListKey) != null
          ? (Hive.box(appBox).get(availableTestTopicsListKey) as List<dynamic>)
              .map((e) => AvailableTopics(
                  key: e.key,
                  list: e.list,
                  currentTopic: e.currentTopic,
                  currentCategory: e.currentCategory))
              .toList()
          : [
              AvailableTopics(
                  key: ntsTestTopicsKey,
                  list: ntsTestTopics,
                  currentTopic: "NTS",
                  currentCategory: null),
              AvailableTopics(
                  key: fpscTestTopicsKey,
                  list: fpscTestTopics,
                  currentTopic: "FPSC",
                  currentCategory: null),
              AvailableTopics(
                  key: ppscTestTopicsKey,
                  list: ppscTestTopics,
                  currentTopic: "PPSC",
                  currentCategory: null),
            ];

  void setTopic(String topicSelected) {
    _selectedTopic = topicSelected;
    notifyListeners();
  }

  void addTopic(String value, List toBeUpdated) {
    if (_type == "MCQS") {
      _availableTopicsList[_currentTopic].list!.add(value);
      _selectedTopic = value;
      Hive.box(appBox).put(_availableTopicsList[_currentTopic].key,
          _availableTopicsList[_currentTopic].list);
      Hive.box(appBox).put(availableTopicsListKey, _availableTopicsList);
      notifyListeners();
    } else {
      _availableTestTopicsList[_currentTopic].list!.add(value);
      _selectedTopic = value;
      Hive.box(appBox).put(_availableTestTopicsList[_currentTopic].key,
          _availableTestTopicsList[_currentTopic].list);
      Hive.box(appBox)
          .put(availableTestTopicsListKey, _availableTestTopicsList);
      notifyListeners();
    }
  }

  /// to update list after adding new item
  void updateTopicData() {
    if (_type == "MCQS") {
      List<String> updatedTopicList = (Hive.box(appBox)
              .get(_availableTopicsList[_currentTopic].key) as List<dynamic>)
          .map((e) => e.toString())
          .toList();
      _topicList = updatedTopicList;
    } else {
      List<String> updatedTopicList =
          (Hive.box(appBox).get(_availableTestTopicsList[_currentTopic].key)
                  as List<dynamic>)
              .map((e) => e.toString())
              .toList();
      _topicList = updatedTopicList;
    }
  }

  /// to do searching in list
  void searchTopics(String query) {
    List<String> topicsListCopy = _type == "MCQS"
        ? _availableTopicsList[_currentTopic].list!
        : _availableTestTopicsList[_currentTopic].list!;
    if (query.isEmpty) {
      _topicList = topicsListCopy;
    } else {
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
  initCategory() {
    /// for main categories
    _currentCategory = 0;
    _categories = _availableMainCategoriesList[0];
    _selectedCategory = categories[0];

    /// for subjects
    int subjectIndex = _availableSubjectsList
        .indexWhere((element) => element.currentTopic == _selectedCategory);
    _currentSubject = subjectIndex;
    _subjectsList = _availableSubjectsList[subjectIndex].list!;
    _selectedSubject = _subjectsList[0];

    /// for topics
    int topicIndex = _availableTopicsList
        .indexWhere((element) => element.currentTopic == _selectedSubject);
    _currentTopic = topicIndex;
    _topicList = _availableTopicsList[topicIndex].list!;
    _selectedTopic = _topicList[0];
    notifyListeners();
  }

  //upload data to api
  uploadDataToCPanel(
      {required String question,
      required String optionOne,
      required String optionTwo,
      required String optionThree,
      required String optionFour,
      required VoidCallback onComplete}) async {
    final dio = Dio();
    if (_type == "MCQS") {
      await dio.post(
        'https://apis.pkmcqsquiz.com/api/mcqsRequest',
        options: Options(
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
        ),
        data: {
          "category": _selectedCategory,
          "subject": _selectedSubject,
          "topic": _selectedTopic,
          "question": question,
          "option1": optionOne,
          "option2": optionTwo,
          "option3": optionThree,
          "option4": optionFour,
          "correct_option": correctOption
        },
      ).then((value) {
        if (value.statusCode == 200) {
          onComplete();
        }
      });
    } else {
      await dio.post(
        'https://apis.pkmcqsquiz.com/api/testMcqsRequest',
        options: Options(
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            "Access-Control-Allow-Origin": "*",
            "Access-Control-Allow-Credentials": "true",
            "Access-Control-Allow-Headers":
                "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
            "Access-Control-Allow-Methods": "POST, OPTIONS"
          },
        ),
        data: {
          "category": _selectedCategory,
          "topic": _selectedTopic,
          "question": question,
          "option1": optionOne,
          "option2": optionTwo,
          "option3": optionThree,
          "option4": optionFour,
          "correct_option": correctOption
        },
      ).then((value) {
        if (value.statusCode == 200) {
          onComplete();
        }
      });
    }
  }

  // upload Data
  uploadDataToFirebase(
      {required String question,
      required String optionOne,
      required String optionTwo,
      required String optionThree,
      required String optionFour,
      required VoidCallback onComplete}) async {
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
              "icon":
                  "assets/icons/categories_icons/${_selectedSubject.toLowerCase().replaceAll(" ", "")}.png"
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
                "subcategory_icon":
                    "assets/icons/categories_icons/${_selectedSubject.toLowerCase().replaceAll(" ", "")}.png",
                "questions": [
                  {
                    "isClick": false,
                    "question": question,
                    "options": [
                      {"text": optionOne, "isCorrect": _option1},
                      {"text": optionTwo, "isCorrect": _option2},
                      {"text": optionThree, "isCorrect": _option3},
                      {"text": optionFour, "isCorrect": _option4}
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
                      {"text": optionOne, "isCorrect": _option1},
                      {"text": optionTwo, "isCorrect": _option2},
                      {"text": optionThree, "isCorrect": _option3},
                      {"text": optionFour, "isCorrect": _option4}
                    ]
                  }
                ])
              }).then((value) async {
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
                    {"text": optionOne, "isCorrect": _option1},
                    {"text": optionTwo, "isCorrect": _option2},
                    {"text": optionThree, "isCorrect": _option3},
                    {"text": optionFour, "isCorrect": _option4}
                  ]
                }
              ]
            }).then((value) {
              onComplete();
            });
          } else {
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
                    {"text": optionOne, "isCorrect": _option1},
                    {"text": optionTwo, "isCorrect": _option2},
                    {"text": optionThree, "isCorrect": _option3},
                    {"text": optionFour, "isCorrect": _option4}
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

class AvailableTopics {
  String? key;
  List<String>? list;
  String? currentTopic;
  String? currentCategory;
  AvailableTopics(
      {required this.key,
      required this.list,
      required this.currentTopic,
      required this.currentCategory});
  AvailableTopics.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    list = json['list'];
    currentTopic = json['topicName'];
    currentCategory = json['currentCategory'];
  }

  Map toJson() {
    return {
      "key": key,
      "list": list,
      'topicName': currentTopic,
      'currentCategory': currentCategory
    };
  }
}
