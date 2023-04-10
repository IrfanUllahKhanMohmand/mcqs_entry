import 'package:hive/hive.dart';

const String appBox = "hive_box";

const String mainCategoriesListKey = "mainMcqsList";


const String commonSubjectsCategoriesListKey= "commonList";
const String managementSubjectsCategoriesListKey = "managementSubjectsCategoriesKey";
const String medicalSubjectsCategoriesListKey = "medicalSubjectsCategoriesKey";
const String engineeringSubjectsCategoriesListKey = "engineeringSubjectsCategoriesKey";

const String englishTopicsKey = "englishTopicsKey";
const String generalKnowledgeTopicsKey = "generalKnowledgeTopicsKey";
const String pakistanCurrentAffairsTopicsKey = "pakistanCurrentAffairsTopicsKey";
const String worldCurrentAffairsTopicsKey = "worldCurrentAffairsTopicsKey";
const String mathematicsTopicsKey = "mathematicsTopicsKey";
const String physicsTopicsKey = "physicsTopicsKey";
const String chemistryTopicsKey = "chemistryTopicsKey";
const String biologyTopicsKey = "biologyTopicsKey";
const String pedagogyTopicsKey = "pedagogyTopicsKey";
String availableSubjectListKey = "availableSubjectListKey";
String availableTopicsListKey = "availableTopicsListKey";


List<String> mCQSMainCategories =Hive.box(appBox).get(mainCategoriesListKey) != null ? (Hive.box(appBox).get(mainCategoriesListKey) as List<dynamic>).map((e) => e.toString()).toList() : [
  'Common Subjects',
  "Management Subjects",
  "Medical Subjects",
  "Engineering"
];

List<String> commonSubjectsCategories = Hive.box(appBox).get(commonSubjectsCategoriesListKey) != null ? (Hive.box(appBox).get(commonSubjectsCategoriesListKey) as List<dynamic>).map((e) => e.toString()).toList() : [
  'English',
  "Urdu",
  "Physical",
  "Biology",
  "Chemistry",
  "Computer",
  "Maths",
  "Islamic Mcqs",
  "Pak Studies",
  "General Knowledge",
  "Sports",
  "Psychology",
  "Pedagogy",
  "Everyday Science"
];

List<String> managementSubjectsCategories = Hive.box(appBox).get(managementSubjectsCategoriesListKey) != null ? (Hive.box(appBox).get(managementSubjectsCategoriesListKey) as List<dynamic>).map((e) => e.toString()).toList() :[
  'Accounting',
  "Finance",
  "Marketing",
];

List<String> medicalSubjectsCategories = Hive.box(appBox).get(medicalSubjectsCategoriesListKey) != null ? (Hive.box(appBox).get(medicalSubjectsCategoriesListKey) as List<dynamic>).map((e) => e.toString()).toList() :[
  'MicroBiology',
  "BioChemistry",
];

List<String> engineeringSubjectsCategories = Hive.box(appBox).get(engineeringSubjectsCategoriesListKey) != null ? (Hive.box(appBox).get(engineeringSubjectsCategoriesListKey) as List<dynamic>).map((e) => e.toString()).toList() :[
  'Chemical Engineering',
  "Electrical Engineering",
  "Civil Engineering",
  "Mechanical Engineering",
  "Software Engineering",
];


List<String> englishTopics = Hive.box(appBox).get(englishTopicsKey) != null ? (Hive.box(appBox).get(englishTopicsKey) as List<dynamic>).map((e) => e.toString()).toList() :[
  "Idioms",
  "Preposition",
  "Synonyms",
  "Analytical Reasoning",
  "Active and passive",
];

List<String> generalKnowledgeTopics = Hive.box(appBox).get(generalKnowledgeTopicsKey) != null ? (Hive.box(appBox).get(generalKnowledgeTopicsKey) as List<dynamic>).map((e) => e.toString()).toList() : [
  "Geography",
  "Atmosphere",
  "science and Litrature",
  "International Organizations",
  "Current Affairs",
];
List<String> pakistanCurrentAffairsTopics = Hive.box(appBox).get(pakistanCurrentAffairsTopicsKey) != null ? (Hive.box(appBox).get(pakistanCurrentAffairsTopicsKey) as List<dynamic>).map((e) => e.toString()).toList() :[
  "Election",
  "Current Governors",
  "Current Chief Ministers",
  "Current Ig's of Police",
  "Current Ambassadors of Pakistan",
];

List<String> worldCurrentAffairsTopics = Hive.box(appBox).get(worldCurrentAffairsTopicsKey) != null ? (Hive.box(appBox).get(worldCurrentAffairsTopicsKey) as List<dynamic>).map((e) => e.toString()).toList() :[
  "Current Head Of International Organizations",
  "Current world Leaders",
  "world Ambassadors to Pakistan",
  "Current Foreign Ministers",
  "Current World Affairs",
];
List<String> mathematicsTopics = Hive.box(appBox).get(mathematicsTopicsKey) != null ? (Hive.box(appBox).get(mathematicsTopicsKey) as List<dynamic>).map((e) => e.toString()).toList() :[
  "Arthematics",
  "Probability",
  "problem on Numbers",
  "Quadratic Equations",
  "Basic Maths",
];
const List<String> pakStudyTopics = [
  "Mountains and Glaciers",
  "IMP days of Pakistan",
  "Defence and Armed Forces",
  "Pakistan General Knowledge",
  "Sindh",
];
const List<String> islamicStudyTopics = [
  "Quran",
  "Sunnah",
  "Life Of Prophet Muhammad(PBUH)",
  "History of Islam",
  "Islamic World",
];
const List<String> computerTopics = [
  "Ms Office",
  "Ms Word",
  "Ms Excel",
  "Computer Science",
  "Programming",
];
const List<String> everydayScienceTopics = [
  "physics",
  "Chemistry",
  "Biology",
  "Mathematics",
  "Science",
];
const List<String> physicsTopics = [
  "Measurements",
  "Motion and Force",
  "Circular Motion",
  "Waves",
  "Electromagnetism",
];
const List<String> chemistryTopics = [
  "Organic Compound",
  "Quantum Numbers",
  "Atomic Mass of Elements",
  "Salt Analysis",
  "StereoChemistry",
];
const List<String> biologyTopics = [
  "Fossils",
  "Diseases",
  "water pollution",
  "Virus",
  "Antibioptics",
];
const List<String> pedagogyTopics = [
  "Taxonomies",
  "Teacher Character",
  "Teaching techniques",
  "Teaching Strategies",
  "Classroom Management",
];
const List<String> accountingTopics = [
  "Financial Accounting",
  "Cost Acccounting",
  "Managerial Accounting",
  "Tax Accounting",
  "Forensic Accounting",
];
const List<String> financeTopics = [
  "Profit",
  "Cost Of capital",
  "Rates of Return",
  "Cash Flow",
  "Financial Statements",
];
const List<String> marketingTopics = [
  "Brand Strategy",
  "Content Marketing",
  "Inbound Marketing",
  "Product Or Survice Launch",
  "Digital Marketing",
];
const List<String> auditingTopics = [
  "Audit Objectives",
  "Audit Procedure and Scope",
  "Recomendations",
  "Managements Response",
  "Findings and Conclusions",
];


/// for test
const String mainTestListKey = 'testList';
const String ntsTestTopicsKey = "ntsTestTopicsKey";
const String fpscTestTopicsKey = "fpscTestTopicsKey";
const String ppscTestTopicsKey = "ppscTestTopicsKey";
String availableTestTopicsListKey = "availableTestTopicsListKey";


List<String> testMainCategories =  Hive.box(appBox).get(mainTestListKey) != null ? (Hive.box(appBox).get(mainTestListKey) as List<dynamic>).map((e) => e.toString()).toList() : ["NTS", "FPSC", "PPSC"];

List<String> ntsTestTopics = Hive.box(appBox).get(ntsTestTopicsKey) != null ? (Hive.box(appBox).get(ntsTestTopicsKey) as List<dynamic>).map((e) => e.toString()).toList() : [
  "nts 1",
  "nts 2",
  "nts 3",
];

List<String> fpscTestTopics = Hive.box(appBox).get(fpscTestTopicsKey) != null ? (Hive.box(appBox).get(fpscTestTopicsKey) as List<dynamic>).map((e) => e.toString()).toList() : [
  "fpsc 1",
  "fpsc 2",
  "fpsc 3",
];
List<String> ppscTestTopics = Hive.box(appBox).get(ppscTestTopicsKey) != null ? (Hive.box(appBox).get(ppscTestTopicsKey) as List<dynamic>).map((e) => e.toString()).toList() : [
  "ppsc 1",
  "ppsc 2",
  "ppsc 3",
];

