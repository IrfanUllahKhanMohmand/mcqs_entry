import 'package:hive/hive.dart';

const String appBox = "hive_box";

const String mainCategoriesListKey = "mainMcqsList";

/// that is for mCQSMainCategories list items
const String commonSubjectsListKey = "commonSubjectsListKey";
const String generalKnowledgeSubjectsListKey =
    "generalKnowledgeSubjectsListKey";
const String managementSubjectsListKey = "managementSubjectsListKey";
const String medicalSubjectsListKey = "medicalSubjectsListKey";
const String engineeringSubjectsListKey = "engineeringSubjectsListKey";
const String generalScienceSubjectListKey = "generalScienceSubjectListKey";
const String educationSubjectListKey = "educationSubjectListKey";
const String aptitudeSubjectListKey = "aptitudeSubjectsListKey";
const String otherSubjectListKey = "otherSubjectListKey";

/// keys for commonSubjects List items
const String englishTopicsListKey = "englishTopicsListKey";
const String pakistanCurrentAffairTopicsListKey =
    "pakistanCurrentAffairTopicsListKey";
const String internationalCurrentAffairsTopicsListKey =
    "internationalCurrentAffairsTopicsListKey";
const String mathsTopicsListKey = "mathsTopicsListKey";
const String pakStudyTopicsListKey = "pakStudyTopicsListKey";
const String islamicStudyTopicListKey = "islamicStudyTopicListKey";
const String computerTopicsListKey = "computerTopicsListKey";
const String everydayScienceTopicsListKey = "everydayScienceTopicsListKey";
const String urduTopicsListKey = "urduTopicsListKey";

/// keys for general Knowledge List items
const String basicGeneralKnowledgeTopicsListKey =
    "basicGeneralKnowledgeTopicsListKey";
// const String Key = "currentGkTopicsListKey";
const String popularInGkTopicsListKey = "popularInGkTopicsListKey";
const String subjectWiseGkTopicsListKey = "subjectWiseGkTopicsListKey";
const String worldGkTopicsListKey = "worldGkTopicsListKey";
const String pakistanGeneralKnowledgeTopicsListKey =
    "pakistanGeneralKnowledgeTopicsListKey";
// const String allTestGeneralKnowledgeTopicsListKey =
//     "allTestGeneralKnowledgeTopicsListKey";

/// keys for Medical Subject List items
const String biologyTopicsListKey = "biologyTopicsListKey";
const String bioChemistryTopicsListKey = "bioChemistryTopicsListKey";
const String oralAnatomyTopicsListKey = "oralAnatomyTopicsListKey";
const String oralPathologyAndMedicineTopicsListKey =
    "oralPathologyAndMedicineTopicsListKey";
const String oralHistologyTopicsListKey = "oralHistologyTopicsListKey";
const String pathologyTopicsListKey = "pathologyTopicsListKey";
const String dentalTopicsListKey = "dentalTopicsListKey";
const String pharmacologyTopicsListKey = "pharmacologyTopicsListKey";
const String physiologyTopicsListKey = "physiologyTopicsListKey";
const String generalAnatomyTopicsListKey = "generalAnatomyTopicsListKey";
const String bioTechnologyTopicsListKey = "bioTechnologyTopicsListKey";
const String bioInformaticsTopicsListKey = "bioInformaticsTopicsListKey";
const String botanyTopicsListKey = "botanyTopicsListKey";
const String zoologyTopicsListKey = "zoologyTopicsListKey";

/// keys for Management Subject List items
const String accountingTopicsListKey = "accountingTopicsListKey";
const String economicsTopicsListKey = "economicsTopicsListKey";
const String auditingTopicsListKey = "auditingTopicsListKey";
const String financeTopicsListKey = "financeTopicsListKey";
const String hRMTopicsListKey = "hRMTopicsListKey";
const String marketingTopicsListKey = "marketingTopicsListKey";

/// keys for Engineering Subject List items
const String chemicalEngineeringTopicListKey =
    "chemicalEngineeringTopicListKey";
const String electricalEngineeringTopicListKey =
    "electricalEngineeringTopicListKey";
const String civilEngineeringTopicListKey = "civilEngineeringTopicListKey";
const String mechanicalEngineeringTopicListKey =
    "mechanicalEngineeringTopicListKey";
const String softwareEngineeringTopicListKey =
    "softwareEngineeringTopicListKey";
const String electronicsTopicListKey = "electronicsTopicListKey";

/// keys for General Science Subject List items
const String physicsTopicsListKey = "physicsTopicsListKey";
const String chemistryTopicsListKey = "chemistryTopicsListKey";
const String biologyGSTopicsListKey = "biologyGSTopicsListKey";

/// keys for Education Subject List items
const String pedagogyTopicsListKey = "pedagogyTopicsListKey";
const String psychologyTopicsListKey = "psychologyTopicsListKey";

/// keys for Aptitude Subject List items
const String verbalReasoningTopicsListKey = "verbalReasoningTopicsListKey";
const String analyticalReasoningTopicsListKey =
    "analyticalReasoningTopicsListKey";
const String quantitativeReasoningListKey = "quantitativeReasoningListKey";

/// keys for Other Subject List items
const String agricultureTopicsListKey = "agricultureTopicsListKey";
const String sociologyTopicsListKey = "sociologyTopicsListKey";
const String englishLiteratureTopicsListKey = "englishLiteratureListKey";
const String judiciaryAndLawTopicsListKey = "judiciaryAndLawTopicsListKey";

/// main list
String availableSubjectListKey = "availableSubjectListKey";
String availableTopicsListKey = "availableTopicsListKey";

List<String> mCQSMainCategories =
    Hive.box(appBox).get(mainCategoriesListKey) != null
        ? (Hive.box(appBox).get(mainCategoriesListKey) as List<dynamic>)
            .map((e) => e.toString())
            .toList()
        : [
            'Common Subjects',
            "General Knowledge",
            "Management Subjects",
            "Medical Subjects",
            "Engineering",
            "General Science",
            "Education",
            "Aptitude",
            "Other Subjects"
          ];

List<String> commonSubjectsList =
    Hive.box(appBox).get(commonSubjectsListKey) != null
        ? (Hive.box(appBox).get(commonSubjectsListKey) as List<dynamic>)
            .map((e) => e.toString())
            .toList()
        : [
            "English",
            "Pakistan Current Affairs",
            "International Current Affairs",
            "Mathematics",
            "Pak Study",
            "Islamic Study",
            "Computer",
            "Everyday Science",
            "Urdu"
          ];

List<String> generalKnowledgeSubjectList =
    Hive.box(appBox).get(generalKnowledgeSubjectsListKey) != null
        ? (Hive.box(appBox).get(generalKnowledgeSubjectsListKey)
                as List<dynamic>)
            .map((e) => e.toString())
            .toList()
        : [
            "Basic General Knowledge",
            "Subject wise Gk",
            "World Gk",
            "Pakistan General Knowledge"
          ];

List<String> managementSubjectList =
    Hive.box(appBox).get(managementSubjectsListKey) != null
        ? (Hive.box(appBox).get(managementSubjectsListKey) as List<dynamic>)
            .map((e) => e.toString())
            .toList()
        : [
            "Accounting",
            "Economics",
            "Auditing",
            "Finance",
            "Marketing",
          ];

List<String> medicalSubjectList =
    Hive.box(appBox).get(medicalSubjectsListKey) != null
        ? (Hive.box(appBox).get(medicalSubjectsListKey) as List<dynamic>)
            .map((e) => e.toString())
            .toList()
        : [
            "Biology",
            "Bio Chemistry",
            "Oral Anatomy",
            "Oral Pathology and Medicine",
            "Oral Histology",
            "Pathology",
            "Dental",
            "Pharmacology",
            "Physiology",
            "General Anatomy",
            "Bio Technology",
            "Bio Informatics",
            "Botany",
            "Zoology",
          ];

List<String> engineeringSubjectList =
    Hive.box(appBox).get(engineeringSubjectsListKey) != null
        ? (Hive.box(appBox).get(engineeringSubjectsListKey) as List<dynamic>)
            .map((e) => e.toString())
            .toList()
        : [
            "Chemical Engineering",
            "Electrical Engineering",
            "Civil Engineering",
            "Mechanical Engineering",
            "Software Engineering",
            "Electronics",
          ];

List<String> generalScienceSubjectList =
    Hive.box(appBox).get(generalScienceSubjectListKey) != null
        ? (Hive.box(appBox).get(generalScienceSubjectListKey) as List<dynamic>)
            .map((e) => e.toString())
            .toList()
        : ['Physics', "Chemistry", "Biology"];
List<String> educationSubjectList =
    Hive.box(appBox).get(educationSubjectListKey) != null
        ? (Hive.box(appBox).get(educationSubjectListKey) as List<dynamic>)
            .map((e) => e.toString())
            .toList()
        : [
            "Pedagogy",
            "Psychology",
          ];
List<String> aptitudeSubjectList =
    Hive.box(appBox).get(aptitudeSubjectListKey) != null
        ? (Hive.box(appBox).get(aptitudeSubjectListKey) as List<dynamic>)
            .map((e) => e.toString())
            .toList()
        : [
            "Verbal Reasoning",
            "Analytical Reasoning",
            "Quantitative Reasoning"
          ];

List<String> otherSubjectList = Hive.box(appBox).get(otherSubjectListKey) !=
        null
    ? (Hive.box(appBox).get(otherSubjectListKey) as List<dynamic>)
        .map((e) => e.toString())
        .toList()
    : ["Agriculture", "Sociology", "English Literature", "Judiciary and Law"];

/// all Common Subjects List Start From Here

List<String> englishTopicsList =
    Hive.box(appBox).get(englishTopicsListKey) != null
        ? (Hive.box(appBox).get(englishTopicsListKey) as List<dynamic>)
            .map((e) => e.toString())
            .toList()
        : [
            "Synonyms & Antonyms",
            "Fill in the blanks",
            "One Word substitutes",
            "Idioms & phrases",
            "Direct & Indirect Speech",
            "Active & Passive Voice",
            "Prepositions",
            "Related pair of words",
            "Spelling Test",
            "Read the Passage Mcqs",
            "Verbal Analogies MCQs ",
            "ENGLISH GRAMMAR MCQs",
            "TENSES MCQs",
            "Correct usage of Articles",
            "SYNTAX MCQs",
          ];

List<String> pakistanCurrentAffairsTopicsList =
    Hive.box(appBox).get(pakistanCurrentAffairTopicsListKey) != null
        ? (Hive.box(appBox).get(pakistanCurrentAffairTopicsListKey)
                as List<dynamic>)
            .map((e) => e.toString())
            .toList()
        : [
            "Current Ministers & Governors of Pakistan",
            "Police & Armed Forces",
            "Current Chief Justices & Attorney General of Pakistan",
            "Current Chairman & Presidents of Govt. Department	",
            "Current Ambassadors of Pakistan",
            "Prime Ministerial International Trips",
            "Honors & Awards",
            "Famous Personality Who Visited Pakistan ",
            "Spokesperson ",
            "COVID19",
            "Sports Games",
            "Pakistan Ranking in International Reports",
            "Azad Kashmir (AJK) Govt.",
            "Notable Personality Passed Away",
            "Anniversaries Notable Personality",
            "Terrorist Attacks in Pakistan",
            "Foreign Loan for Pakistan",
            "Federal and Provincial Budget of Pakistan MCQs",
            "Corruption scandal in Pakistan",
            "Investment Policy Pakistan",
            " Pakistan Govt Projects",
            "Bill or Ordinance Passed by Assembly",
            "Pakistan to Host",
            "Elections in Pakistan",
            "Most Repeated MCQs of Pakistan Current Affairs",
            "Monthly Pakistan Current Affairs",
            "Miscellaneous Pakistan Current Affairs",
          ];

List<String> internationalCurrentAffairsTopicsList =
    Hive.box(appBox).get(internationalCurrentAffairsTopicsListKey) != null
        ? (Hive.box(appBox).get(internationalCurrentAffairsTopicsListKey)
                as List<dynamic>)
            .map((e) => e.toString())
            .toList()
        : [
            "International - Latest Current Affairs",
            "Head of International Organizations",
            "International Sports Games",
            "Operations Starts Against Terrorist",
            "USA Govt",
            "Current Presidents, Prime Ministers, Ministers, and Speakers Mcqs",
            "Notable Personality Passed Away MCQs",
            "Invention & Creativity",
            "Summits",
            "Ranking, Performance Index",
            "International organizations",
            "World Bad News",
            "World Elections",
            "World Famous & Richest living Personalities",
            "International Days",
            "World Ambassadors to Pakistan",
            "Top Company Owner, CEO",
            "International Awards",
            "Current Govt in the world",
            "Most Repeated MCQs of International Current Affairs	",
            "Nobel Prize Winners & Award",
            "Country Capitals MCQs",
            "Countries Intelligence Agencies",
            "Miscellaneous ",
          ];
List<String> mathematicsTopicsList =
    Hive.box(appBox).get(mathsTopicsListKey) != null
        ? (Hive.box(appBox).get(mathsTopicsListKey) as List<dynamic>)
            .map((e) => e.toString())
            .toList()
        : [
            "Basic Maths MCQs",
            "Arithmetic/Percentage & Average MCQs",
            "Areas , Height , Distance & Volumes MCQs",
            " L.C.M and H.C.F MCQs",
            "Profit , Loss & Interest MCQs",
            " Ratio and Proportion MCQs",
            "Permutations and Combinations MCQs",
            "Probability & Statistics MCQs",
            "Simple & Quadratic Equations MCQs",
            "Simplification and Approximation MCQs",
            "Time , Work & Distance MCQs",
            "Series Completion MCQs",
            "Geometry MCQs ",
          ];
List<String> pakStudyTopicsList =
    Hive.box(appBox).get(pakStudyTopicsListKey) != null
        ? (Hive.box(appBox).get(pakStudyTopicsListKey) as List<dynamic>)
            .map((e) => e.toString())
            .toList()
        : [
            "Indo-Pak History MCQs",
            "Pakistan Affairs MCQs",
            "Books and Authors MCQs",
            "First in Pakistan GK MCQs",
            "Pakistan Geography MCQs",
            "Provinces of Pakistan MCQs",
            "Natural Resources of pakistan MCQs",
            "National Symbols of Pakistan MCQs",
            "National Organizations Headquarters MCQs",
            "Defence  & Armed Forces MCQs",
            "Pakistan history 1947 to 2023 MCQs",
            "Highways & Motorways MCQs",
            "Constitutions & Amendments MCQs",
            "National Assembly & Senate  MCQs",
            "Important days of Pakistan MCQs",
            "Incident in Pakistan MCQs",
            "Culture of Pakistan MCQs",
            "100 Most Repeated MCQs",
            "Miscellaneous MCQs",
          ];
List<String> islamicStudyTopicsList =
    Hive.box(appBox).get(islamicStudyTopicListKey) != null
        ? (Hive.box(appBox).get(islamicStudyTopicListKey) as List<dynamic>)
            .map((e) => e.toString())
            .toList()
        : [
            "World Religions MCQs",
            "Prophets of ALLAH MCQs",
            "Revealed Books MCQs",
            "Names of ALLAH MCQs",
            "Arab before Islam MCQs",
            "Ancestors of Holy Prophet (PBUH) MCQs",
            "Hazrat Muhammad (PBUH) Birth to Prophethood",
            "History of Islam MCQs",
            "Sihah Sitta Books MCQs",
            "100 Most Repeated MCQs",
            "Namaz and Azan",
            "Jihad in Islam ",
            "Most Repeated Past Papers",
            "World Islamic Empires",
            "Quran and Surah",
            " Hajj & Zakat",
            "Khulafa Rashideen",
            "Ghazwat, Battle in Islam",
            "Miscellaneous MCQs",
          ];
List<String> computerTopicsList =
    Hive.box(appBox).get(computerTopicsListKey) != null
        ? (Hive.box(appBox).get(computerTopicsListKey) as List<dynamic>)
            .map((e) => e.toString())
            .toList()
        : [
            "Introduction To Computer",
            "Basic Computer MCQs",
            "Introduction to Programming Mcqs",
            "MS Office MCQs",
            "MS Excel MCQs",
            "MS Word MCQs",
            "MS PowerPoint MCQs",
            "MS Access MCQs",
            "Software Engineering MCQs",
            "Theory of Automata MCQs",
            "Artificial Intelligence MCQs",
            "Object Oriented Programming MCQs",
            "C++ Programming MCQs",
            "Data Structures MCQs",
            "Database MCQs",
            "Digital Logic Design MCQs",
            "Fundamentals of Algorithms MCQs",
            "Networking MCQs",
          ];
List<String> everydayScienceTopicsList =
    Hive.box(appBox).get(everydayScienceTopicsListKey) != null
        ? (Hive.box(appBox).get(everydayScienceTopicsListKey) as List<dynamic>)
            .map((e) => e.toString())
            .toList()
        : [
            "Basics of Every Day Science EDS",
            "Branches of Science MCQs",
            "Universe , Planets & Atmosphere MCQs",
            "Diseases MCQs",
            "Human Body MCQs",
            "Medicine , Vaccines & Treatment MCQs",
            "Vitamins & Cell",
            "Gases & Acids",
            "Discoveries & Invention",
            "Alloy",
            "International System of Units (SI)",
            "Major Elements and Metals",
            "Most Repeated MCQs of EDS PDF",
            "Energy Resources MCQs",
          ];
List<String> urduTopicsList = Hive.box(appBox).get(urduTopicsListKey) != null
    ? (Hive.box(appBox).get(urduTopicsListKey) as List<dynamic>)
        .map((e) => e.toString())
        .toList()
    : [
        "Urdu Vocabulary",
        "Singular Plural in Urdu",
        "Completion of Sentences in Urdu",
        "Choose Right Sentences in Urdu",
        "Urdu Adab",
        "Urdu Zarb ul Misal",
        "Urdu Grammar	",
        "مذکر مونث   Gendering ",
        "مترادف, Antonyms in Urdu",
        "محاورے , Idioms In Urdu",
        "ترجمہ",
        "Afsana",
        "Complete Sentence",
        "Nick Name",
        "Duplicate",
        "Most Repeated MCQs of Urdu ",
        "Urdu Famous Books & Authors",
        "First in Urdu History",
      ];

/// common Subjects End Here
/// General Knowledge Subject Start Here
List<String> basicGeneralKnowledgeTopicsList =
    Hive.box(appBox).get(basicGeneralKnowledgeTopicsListKey) != null
        ? (Hive.box(appBox).get(basicGeneralKnowledgeTopicsListKey)
                as List<dynamic>)
            .map((e) => e.toString())
            .toList()
        : [
            "Section 1",
            "Section 2",
            "Section 3",
            "Section 4",
            "Section 5",
            "Section 6",
            "Section 7",
            "Section 8",
            "Section 9",
            "Section 10",
          ];

// List<String> currentGkTopicsList =
//     Hive.box(appBox).get(currentGkTopicsListKey) != null
//         ? (Hive.box(appBox).get(currentGkTopicsListKey) as List<dynamic>)
//             .map((e) => e.toString())
//             .toList()
//         : [];

List<String> popularInGkTopicsList =
    Hive.box(appBox).get(popularInGkTopicsListKey) != null
        ? (Hive.box(appBox).get(popularInGkTopicsListKey) as List<dynamic>)
            .map((e) => e.toString())
            .toList()
        : [];
List<String> subjectWiseGkTopicsList =
    Hive.box(appBox).get(subjectWiseGkTopicsListKey) != null
        ? (Hive.box(appBox).get(subjectWiseGkTopicsListKey) as List<dynamic>)
            .map((e) => e.toString())
            .toList()
        : [
            "History",
            "Geography",
            "Science",
            "Polity",
            "Environment",
            "Art & Culture",
            "Economy & Countries Currency MCQs",
            "Countries Primary Languages",
            "International Organization Headquarter",
          ];
List<String> worldGkTopicsList =
    Hive.box(appBox).get(worldGkTopicsListKey) != null
        ? (Hive.box(appBox).get(worldGkTopicsListKey) as List<dynamic>)
            .map((e) => e.toString())
            .toList()
        : [
            "World Leaders",
            "Historical Events",
            "Natural Wonders",
            "Global Conflicts",
            "Global Economics",
            "Famous Inventions"
          ];
List<String> pakistanGeneralKnowledgeTopicsList =
    Hive.box(appBox).get(pakistanGeneralKnowledgeTopicsListKey) != null
        ? (Hive.box(appBox).get(pakistanGeneralKnowledgeTopicsListKey)
                as List<dynamic>)
            .map((e) => e.toString())
            .toList()
        : [
            "Set 1",
            "Set 2",
            "Set 3",
            "Set 4",
            "Set 5",
            "Set 6",
            "Set 7",
            "Set 8",
            "Set 9",
            "Set 10"
          ];
// List<String> allTestGeneralKnowledgeTopicsList =
//     Hive.box(appBox).get(allTestGeneralKnowledgeTopicsListKey) != null
//         ? (Hive.box(appBox).get(allTestGeneralKnowledgeTopicsListKey)
//                 as List<dynamic>)
//             .map((e) => e.toString())
//             .toList()
//         : [];

/// General Knowledge Subject end Here

/// Medical Subject Start Here
List<String> biologyTopicList =
    Hive.box(appBox).get(biologyTopicsListKey) != null
        ? (Hive.box(appBox).get(biologyTopicsListKey) as List<dynamic>)
            .map((e) => e.toString())
            .toList()
        : [
            "Cell Biology",
            "Ecology",
            "Human Anatomy and physiology",
            "Microbiology",
            "Plant Biology",
            "Animal Diversity",
            "Astrobiology",
            "Bioengineering",
            "Biogeography",
            "Bioinformatics",
            "Biophysics",
            "Evolutionary Biology"
          ];
List<String> biochemistryTopicList =
    Hive.box(appBox).get(bioChemistryTopicsListKey) != null
        ? (Hive.box(appBox).get(bioChemistryTopicsListKey) as List<dynamic>)
            .map((e) => e.toString())
            .toList()
        : [
            "Organic Chemistry",
            "Metabolism",
            "clinical Chemistry",
            "Immunology",
            "Molecular genetics",
            "Biochemical Pharmacology",
            "ImmunoChemistry",
            "physical Biochemistry",
            "NeuroChemistry",
            "Bio_Organic Chemistry",
            "Metabolic Biochemistry"
          ];
List<String> oralAnatomyTopicList =
    Hive.box(appBox).get(oralAnatomyTopicsListKey) != null
        ? (Hive.box(appBox).get(oralAnatomyTopicsListKey) as List<dynamic>)
            .map((e) => e.toString())
            .toList()
        : [
            "Teeth Anatomy",
            "Periodontium Anatomy",
            "Oral Cavity Anatomy",
            "Salivary Glands",
            "Oral Histology",
            "Oral Physiology",
            "Temporomandibular Joint (TMJ) Anatomy",
            "Oral Embryology"
          ];
List<String> oralPathologyAndMedicinesTopicList =
    Hive.box(appBox).get(oralPathologyAndMedicineTopicsListKey) != null
        ? (Hive.box(appBox).get(oralPathologyAndMedicineTopicsListKey)
                as List<dynamic>)
            .map((e) => e.toString())
            .toList()
        : [
            "Oral and Maxillofacial Pathology",
            "Oral Medicine",
            "Oral Microbiology and Immunology",
            "Oral Radiology",
            "Oral and Maxillofacial Surgery",
            "Oral Oncology",
            "Oral Radiology and Imaging",
            "Oral Medicine",
            "Temporomandibular Disorders (TMD)",
            "Oral Mucosal Diseases",
            "Oral Facial Dysfunctions"
          ];
List<String> oralHistologyTopicList =
    Hive.box(appBox).get(oralHistologyTopicsListKey) != null
        ? (Hive.box(appBox).get(oralHistologyTopicsListKey) as List<dynamic>)
            .map((e) => e.toString())
            .toList()
        : [
            "Dental Histology",
            "Periodontal Histology",
            "Oral Mucosal Histology",
            "Salivary Gland Histology",
            "Bone Histology",
            "Nerve Histology",
            "Oral Vascular Histology",
            "Temporomandibular Joint (TMJ) Histology",
            "Taste Bud Histology",
            "Dentin Histology",
            "Periodontal Ligament Histology",
            "Odontogenesis",
          ];
List<String> pathologyTopicList =
    Hive.box(appBox).get(pathologyTopicsListKey) != null
        ? (Hive.box(appBox).get(pathologyTopicsListKey) as List<dynamic>)
            .map((e) => e.toString())
            .toList()
        : [
            "Anatomic Pathology",
            "Clinical Pathology",
            "Forensic Pathology",
            "Neuropathology",
            "Pediatric Pathology",
            "Veterinary Pathology",
            "Immunopathology",
            "Molecular Pathology",
            "Pulmonary Pathology",
            "Cytopathology"
          ];
List<String> dentalTopicList = Hive.box(appBox).get(dentalTopicsListKey) != null
    ? (Hive.box(appBox).get(dentalTopicsListKey) as List<dynamic>)
        .map((e) => e.toString())
        .toList()
    : [
        "Orthodontics",
        "Endodontics",
        "Periodontics",
        "Prosthodontics",
        "Oral and Maxillofacial Surgery",
        "Dental Implantology",
        "Geriatric Dentistry",
        "Dental Sleep Medicine",
        "Dental Anesthesiology",
        "Oral Biology",
        "Oral and Maxillofacial Radiology"
      ];
List<String> pharmacologyTopicList =
    Hive.box(appBox).get(pharmacologyTopicsListKey) != null
        ? (Hive.box(appBox).get(pharmacologyTopicsListKey) as List<dynamic>)
            .map((e) => e.toString())
            .toList()
        : [
            "Clinical Pharmacology",
            "Neuropharmacology",
            "Psychopharmacology",
            "Cardiovascular Pharmacology",
            "Pharmacogenomics",
            "Veterinary Pharmacology",
            "Anticoagulant Pharmacology",
            "Analgesic Pharmacology",
            "Endocrine Pharmacology",
            "Respiratory Pharmacology",
            "Gastrointestinal Pharmacology",
            "Antibiotic Pharmacology"
          ];
List<String> physiologyTopicList =
    Hive.box(appBox).get(physiologyTopicsListKey) != null
        ? (Hive.box(appBox).get(physiologyTopicsListKey) as List<dynamic>)
            .map((e) => e.toString())
            .toList()
        : [
            "Neurophysiology",
            "Cardiovascular Physiology",
            "Respiratory Physiology",
            "Renal Physiology",
            "Gastrointestinal Physiology",
            "Biophysical Physiology",
            "Sensory Physiology",
            "Autonomic Physiology",
            "Molecular Physiology",
            "Systems Physiology",
            "Environmental Physiology",
            "Comparative Physiology"
          ];
List<String> generalAnatomyTopicList =
    Hive.box(appBox).get(generalAnatomyTopicsListKey) != null
        ? (Hive.box(appBox).get(generalAnatomyTopicsListKey) as List<dynamic>)
            .map((e) => e.toString())
            .toList()
        : [
            "Gross Anatomy",
            "Microscopic Anatomy",
            "Developmental Anatomy",
            "Artistic Anatomy",
            "Radiographic Anatomy",
            "Anthropological Anatomy",
            "Myology",
            "Regional Anatomy",
            "Sectional Anatomy",
            "Surface Anatomy",
            "Functional Anatomy"
          ];
List<String> bioTechnologyTopicList =
    Hive.box(appBox).get(bioTechnologyTopicsListKey) != null
        ? (Hive.box(appBox).get(bioTechnologyTopicsListKey) as List<dynamic>)
            .map((e) => e.toString())
            .toList()
        : [
            "Medical Biotechnology",
            "Agricultural Biotechnology",
            "Industrial Biotechnology",
            "Environmental Biotechnology",
            "Bioinformatics",
            "Bioethics",
            "Stem Cell Technology",
            "Biomedical Engineering",
            "Veterinary Biotechnology",
            "Biofuels and Bioenergy",
            "Food Biotechnology"
          ];
List<String> bioInformaticsTopicList =
    Hive.box(appBox).get(bioInformaticsTopicsListKey) != null
        ? (Hive.box(appBox).get(bioInformaticsTopicsListKey) as List<dynamic>)
            .map((e) => e.toString())
            .toList()
        : [
            "Genomics",
            "Proteomics",
            "Transcriptomics",
            "Metagenomics",
            "Structural Bioinformatics",
            "Computational Genomics",
            "Functional Annotation",
            "Epigenomics",
            "Comparative Genomics",
            "Pharmacogenomics",
            "Evolutionary Bioinformatics"
          ];
List<String> botanyTopicList = Hive.box(appBox).get(botanyTopicsListKey) != null
    ? (Hive.box(appBox).get(botanyTopicsListKey) as List<dynamic>)
        .map((e) => e.toString())
        .toList()
    : [
        "Plant Taxonomy",
        "Plant Physiology",
        "Plant Ecology",
        "Plant Genetics",
        "Plant Biotechnology",
        "Plant Molecular Biology",
        "Plant Ecophysiology",
        "Plant Biogeography",
        "Plant Reproductive Biology",
        "Plant Cell Biology",
        "Plant Biochemistry",
        "Plant Biophysics"
      ];
List<String> zoologyTopicList =
    Hive.box(appBox).get(zoologyTopicsListKey) != null
        ? (Hive.box(appBox).get(zoologyTopicsListKey) as List<dynamic>)
            .map((e) => e.toString())
            .toList()
        : [
            "Comparative Anatomy",
            "Physiology",
            "Ethology",
            "Evolutionary Biology",
            "Ecology",
            "Animal Physiology",
            "Paleontology",
            "Conservation Biology",
            "Animal Behavior",
            "Animal Ecology",
            "Invertebrate Zoology",
            "Ethology"
          ];

/// Medical Subject End Here

/// Management Subject Start Here
List<String> accountingTopicList =
    Hive.box(appBox).get(accountingTopicsListKey) != null
        ? (Hive.box(appBox).get(accountingTopicsListKey) as List<dynamic>)
            .map((e) => e.toString())
            .toList()
        : [
            "Financial Accounting",
            "Managerial Accounting",
            "Auditing",
            "Tax Accounting",
            "Forensic Accounting"
          ];
List<String> economicsTopicList =
    Hive.box(appBox).get(economicsTopicsListKey) != null
        ? (Hive.box(appBox).get(economicsTopicsListKey) as List<dynamic>)
            .map((e) => e.toString())
            .toList()
        : [
            "Microeconomics",
            "Macroeconomics",
            "International Economics",
            "Development Economics",
            "Econometrics"
          ];
List<String> auditingTopicList =
    Hive.box(appBox).get(auditingTopicsListKey) != null
        ? (Hive.box(appBox).get(auditingTopicsListKey) as List<dynamic>)
            .map((e) => e.toString())
            .toList()
        : [
            "Financial Audit",
            "Internal Audit",
            "External Audit",
            "Compliance Audit",
            "Forensic Audit"
          ];
List<String> financeTopicList =
    Hive.box(appBox).get(financeTopicsListKey) != null
        ? (Hive.box(appBox).get(financeTopicsListKey) as List<dynamic>)
            .map((e) => e.toString())
            .toList()
        : [
            "Corporate Finance",
            "Investment Banking",
            "Financial Markets and Institutions",
            "Financial Planning and Wealth Management",
            "Financial Analysis and Valuation"
          ];
List<String> hRMTopicList = Hive.box(appBox).get(hRMTopicsListKey) != null
    ? (Hive.box(appBox).get(hRMTopicsListKey) as List<dynamic>)
        .map((e) => e.toString())
        .toList()
    : [
        "Recruitment and Selection",
        "Compensation and Benefits",
        "Training and Development",
        "Performance Management",
        "Employee Relations"
      ];
List<String> marketingTopicList =
    Hive.box(appBox).get(marketingTopicsListKey) != null
        ? (Hive.box(appBox).get(marketingTopicsListKey) as List<dynamic>)
            .map((e) => e.toString())
            .toList()
        : [
            "Market Research",
            "Advertising and Promotion",
            "Digital Marketing",
            "Product Management",
            "Brand Management"
          ];

/// Management Subject End Here

/// Engineering Subject Start Here
List<String> electricalEngineeringTopicList =
    Hive.box(appBox).get(electricalEngineeringTopicListKey) != null
        ? (Hive.box(appBox).get(electricalEngineeringTopicListKey)
                as List<dynamic>)
            .map((e) => e.toString())
            .toList()
        : [
            "Power Systems Engineering",
            "Electronics Engineering",
            "Control Systems Engineering",
            "Telecommunications Engineering",
            "Signal Processing",
            "Integrated Circuit Design",
            "Electric Drives and Control",
            "Electromechanical Systems Engineering",
            "Instrumentation and Measurement Engineering",
            "Digital Systems Design",
            "Computer Engineering"
          ];
List<String> civilEngineeringTopicList =
    Hive.box(appBox).get(civilEngineeringTopicListKey) != null
        ? (Hive.box(appBox).get(civilEngineeringTopicListKey) as List<dynamic>)
            .map((e) => e.toString())
            .toList()
        : [
            "Structural Engineering",
            "Geotechnical Engineering",
            "Transportation Engineering",
            "Environmental Engineering",
            "Water Resources Engineering",
            "Risk and Disaster Management",
            "Sustainable Infrastructure Development",
            "Geospatial Engineering",
            "Structural Rehabilitation and Retrofitting",
            "Land Development and Site Planning",
            "Construction Materials Engineering"
          ];
List<String> mechanicalEngineeringTopicList =
    Hive.box(appBox).get(mechanicalEngineeringTopicListKey) != null
        ? (Hive.box(appBox).get(mechanicalEngineeringTopicListKey)
                as List<dynamic>)
            .map((e) => e.toString())
            .toList()
        : [
            "Thermal Engineering",
            "Manufacturing Engineering",
            "Mechanics and Design",
            "Materials Engineering",
            "Materials Engineering",
            "Engineering Management",
            "Computational Mechanics",
            "Nuclear Engineering",
            "Energy Systems Engineering",
            "Design Engineering",
            "Robotics and Automation"
          ];
List<String> chemicalEngineeringTopicList =
    Hive.box(appBox).get(chemicalEngineeringTopicListKey) != null
        ? (Hive.box(appBox).get(chemicalEngineeringTopicListKey)
                as List<dynamic>)
            .map((e) => e.toString())
            .toList()
        : [
            "Process Engineering",
            "Reaction Engineering",
            "Thermodynamics",
            "Separation Processes",
            "Environmental Engineering",
            "Sustainable Process",
            "Process Control and Optimization",
            "Computational Fluid Dynamics",
            "Polymer Engineering",
            "Catalysis",
            "Transport Phenomena"
          ];
List<String> electronicsTopicList =
    Hive.box(appBox).get(electronicsTopicListKey) != null
        ? (Hive.box(appBox).get(electronicsTopicListKey) as List<dynamic>)
            .map((e) => e.toString())
            .toList()
        : [
            "Analog Electronics",
            "Digital Electronics",
            "Integrated Circuit (IC) Design",
            "Embedded Systems",
            "Power Electronics",
            "Electromagnetics",
            "Wireless Communication Systems",
            "Digital Signal Processing",
            "Optoelectronics",
            "Electronic Instrumentation"
          ];
List<String> softwareEngineeringTopicList =
    Hive.box(appBox).get(softwareEngineeringTopicListKey) != null
        ? (Hive.box(appBox).get(softwareEngineeringTopicListKey)
                as List<dynamic>)
            .map((e) => e.toString())
            .toList()
        : [
            "Software Development",
            "Software Testing and Quality Assurance",
            "Software Project Management",
            "Software Requirements Engineering",
            "Software Maintenance and Support",
            "Software Engineering for Cybersecurity",
            "Software Engineering for Big Data",
            "Human-Computer Interaction",
            "Software Engineering for Cloud Computing",
            "Software Engineering for Artificial Intelligence",
            "Software Engineering for Embedded Systems",
            "Software Engineering for Mobile and Web Applications"
          ];

/// Engineering Subject End Here

/// General Science Subject Start Here
List<String> physicsTopicList =
    Hive.box(appBox).get(physicsTopicsListKey) != null
        ? (Hive.box(appBox).get(physicsTopicsListKey) as List<dynamic>)
            .map((e) => e.toString())
            .toList()
        : [
            "Physical Quantities and Mechanics",
            "Matter and its Properties",
            "Electromagnetics Waves & Optics / Light",
            "Heat",
            "Electricity and Magnetism",
            "Modern Physics - Electronics, Nanotechnology",
            "Discoveries, Inventions, and Scientific instruments",
            "Constituents  and  Structure",
            "Process  of  Nature",
            "Natural  Hazards  and  Disasters",
            "Energy  Resources",
            "Atomic Structure",
            "Modern  Materials/Chemicals"
          ];
List<String> chemistryTopicList =
    Hive.box(appBox).get(chemistryTopicsListKey) != null
        ? (Hive.box(appBox).get(chemistryTopicsListKey) as List<dynamic>)
            .map((e) => e.toString())
            .toList()
        : [
            "Nature / State of Matter",
            "Atomic Structure",
            "Radioactivity",
            "Chemical Formula",
            "Element classification",
            "Electrochemistry & Thermochemistry",
            "Acid, base & salt",
            "Metals & Non-metals",
            "Organic Chemistry",
            "Discovery & inventions",
            "Environment",
            "Water Pollution",
            "Atmospheric Pollution"
          ];
List<String> biologyGSTopicList =
    Hive.box(appBox).get(biologyGSTopicsListKey) != null
        ? (Hive.box(appBox).get(biologyGSTopicsListKey) as List<dynamic>)
            .map((e) => e.toString())
            .toList()
        : [
            "Evolution",
            "Cell Biology",
            "Genetics and Blood",
            "Plant Anatomy & Physiology",
            "Kingdom & taxonomy of Plant",
            "Plant Physiology",
            "Animal Kingdom, Taxonomy, Morphology",
            "Diseases",
            "Human Welfare and Economics Biology",
            "Human Digestive system",
            "Ecology"
          ];

/// General Science End Here

/// Education Subject Start Here
List<String> pedagogyTopicList =
    Hive.box(appBox).get(pedagogyTopicsListKey) != null
        ? (Hive.box(appBox).get(pedagogyTopicsListKey) as List<dynamic>)
            .map((e) => e.toString())
            .toList()
        : [
            "Curriculum Development",
            "Instructional Design",
            "Educational Psychology",
            "Assessment and Evaluation",
            "Classroom Management"
          ];
List<String> psychologyTopicList =
    Hive.box(appBox).get(psychologyTopicsListKey) != null
        ? (Hive.box(appBox).get(psychologyTopicsListKey) as List<dynamic>)
            .map((e) => e.toString())
            .toList()
        : [
            "Clinical Psychology",
            "Cognitive Psychology",
            "Developmental Psychology",
            "Social Psychology",
            "Experimental Psychology"
          ];

/// Education Subject End Here

/// Aptitude Subject Start Here
List<String> verbalReasoningTopicList =
    Hive.box(appBox).get(verbalReasoningTopicsListKey) != null
        ? (Hive.box(appBox).get(verbalReasoningTopicsListKey) as List<dynamic>)
            .map((e) => e.toString())
            .toList()
        : [];
List<String> analyticalReasoningTopicList =
    Hive.box(appBox).get(analyticalReasoningTopicsListKey) != null
        ? (Hive.box(appBox).get(analyticalReasoningTopicsListKey)
                as List<dynamic>)
            .map((e) => e.toString())
            .toList()
        : [];
List<String> quantitativeReasoningTopicList =
    Hive.box(appBox).get(quantitativeReasoningListKey) != null
        ? (Hive.box(appBox).get(quantitativeReasoningListKey) as List<dynamic>)
            .map((e) => e.toString())
            .toList()
        : [];

/// Aptitude Subject End Here

/// Other Subject Start Here
List<String> agricultureTopicList =
    Hive.box(appBox).get(agricultureTopicsListKey) != null
        ? (Hive.box(appBox).get(agricultureTopicsListKey) as List<dynamic>)
            .map((e) => e.toString())
            .toList()
        : [
            "Agronomy",
            "Horticulture",
            "Animal Science",
            "Agricultural Engineering",
            "Soil Science"
          ];
List<String> sociologyTopicList =
    Hive.box(appBox).get(sociologyTopicsListKey) != null
        ? (Hive.box(appBox).get(sociologyTopicsListKey) as List<dynamic>)
            .map((e) => e.toString())
            .toList()
        : [
            "Social Stratification",
            "Sociology of Culture",
            "Sociology of Organizations",
            "Sociology of Education",
            "Sociology of Family and Marriage"
          ];
List<String> englishLiteratureTopicList =
    Hive.box(appBox).get(englishLiteratureTopicsListKey) != null
        ? (Hive.box(appBox).get(englishLiteratureTopicsListKey)
                as List<dynamic>)
            .map((e) => e.toString())
            .toList()
        : [
            "Poetry",
            "Prose Fiction",
            "Drama",
            "Literary Criticism",
            "Literary Theory"
          ];
List<String> judiciaryAndLawTopicList =
    Hive.box(appBox).get(judiciaryAndLawTopicsListKey) != null
        ? (Hive.box(appBox).get(judiciaryAndLawTopicsListKey) as List<dynamic>)
            .map((e) => e.toString())
            .toList()
        : [
            "Constitutional Law",
            "Criminal Law",
            "Civil Law",
            "Administrative Law",
            "International Law"
          ];

/// Other Subject End Here

// List<String> generalKnowledgeTopics = Hive.box(appBox).get(generalKnowledgeTopicsKey) != null ? (Hive.box(appBox).get(generalKnowledgeTopicsKey) as List<dynamic>).map((e) => e.toString()).toList() : [
//   "Geography",
//   "Atmosphere",
//   "Science and Literature",
//   "International Organizations",
//   "Current Affairs",
// ];
// List<String> pakistanCurrentAffairsTopics = Hive.box(appBox).get(pakistanCurrentAffairsTopicsKey) != null ? (Hive.box(appBox).get(pakistanCurrentAffairsTopicsKey) as List<dynamic>).map((e) => e.toString()).toList() :[
//   "Election",
//   "Current Governors",
//   "Current Chief Ministers",
//   "Current Ig's of Police",
//   "Current Ambassadors of Pakistan",
// ];
//
// List<String> worldCurrentAffairsTopics = Hive.box(appBox).get(worldCurrentAffairsTopicsKey) != null ? (Hive.box(appBox).get(worldCurrentAffairsTopicsKey) as List<dynamic>).map((e) => e.toString()).toList() :[
//   "Current Head Of International Organizations",
//   "Current world Leaders",
//   "world Ambassadors to Pakistan",
//   "Current Foreign Ministers",
//   "Current World Affairs",
// ];
// List<String> mathematicsTopics = Hive.box(appBox).get(mathematicsTopicsKey) != null ? (Hive.box(appBox).get(mathematicsTopicsKey) as List<dynamic>).map((e) => e.toString()).toList() :[
//   "Arthematics",
//   "Probability",
//   "problem on Numbers",
//   "Quadratic Equations",
//   "Basic Maths",
// ];
// const List<String> pakStudyTopics = [
//   "Mountains and Glaciers",
//   "IMP days of Pakistan",
//   "Defence and Armed Forces",
//   "Pakistan General Knowledge",
//   "Sindh",
// ];
// const List<String> islamicStudyTopics = [
//   "Quran",
//   "Sunnah",
//   "Life Of Prophet Muhammad(PBUH)",
//   "History of Islam",
//   "Islamic World",
// ];
// const List<String> computerTopics = [
//   "Ms Office",
//   "Ms Word",
//   "Ms Excel",
//   "Computer Science",
//   "Programming",
// ];
// const List<String> everydayScienceTopics = [
//   "physics",
//   "Chemistry",
//   "Biology",
//   "Mathematics",
//   "Science",
// ];
// const List<String> physicsTopics = [
//   "Measurements",
//   "Motion and Force",
//   "Circular Motion",
//   "Waves",
//   "Electromagnetism",
// ];
// const List<String> chemistryTopics = [
//   "Organic Compound",
//   "Quantum Numbers",
//   "Atomic Mass of Elements",
//   "Salt Analysis",
//   "StereoChemistry",
// ];
// const List<String> biologyTopics = [
//   "Fossils",
//   "Diseases",
//   "water pollution",
//   "Virus",
//   "Antibioptics",
// ];
// const List<String> pedagogyTopics = [
//   "Taxonomies",
//   "Teacher Character",
//   "Teaching techniques",
//   "Teaching Strategies",
//   "Classroom Management",
// ];
// const List<String> accountingTopics = [
//   "Financial Accounting",
//   "Cost Acccounting",
//   "Managerial Accounting",
//   "Tax Accounting",
//   "Forensic Accounting",
// ];
// const List<String> financeTopics = [
//   "Profit",
//   "Cost Of capital",
//   "Rates of Return",
//   "Cash Flow",
//   "Financial Statements",
// ];
// const List<String> marketingTopics = [
//   "Brand Strategy",
//   "Content Marketing",
//   "Inbound Marketing",
//   "Product Or Survice Launch",
//   "Digital Marketing",
// ];
// const List<String> auditingTopics = [
//   "Audit Objectives",
//   "Audit Procedure and Scope",
//   "Recomendations",
//   "Managements Response",
//   "Findings and Conclusions",
// ];

/// for test
const String mainTestListKey = 'testList';
const String ntsTestTopicsKey = "ntsTestTopicsKey";
const String fpscTestTopicsKey = "fpscTestTopicsKey";
const String ppscTestTopicsKey = "ppscTestTopicsKey";
String availableTestTopicsListKey = "availableTestTopicsListKey";

List<String> testMainCategories = Hive.box(appBox).get(mainTestListKey) != null
    ? (Hive.box(appBox).get(mainTestListKey) as List<dynamic>)
        .map((e) => e.toString())
        .toList()
    : ["NTS", "FPSC", "PPSC"];

List<String> ntsTestTopics = Hive.box(appBox).get(ntsTestTopicsKey) != null
    ? (Hive.box(appBox).get(ntsTestTopicsKey) as List<dynamic>)
        .map((e) => e.toString())
        .toList()
    : [];

List<String> fpscTestTopics = Hive.box(appBox).get(fpscTestTopicsKey) != null
    ? (Hive.box(appBox).get(fpscTestTopicsKey) as List<dynamic>)
        .map((e) => e.toString())
        .toList()
    : [];
List<String> ppscTestTopics = Hive.box(appBox).get(ppscTestTopicsKey) != null
    ? (Hive.box(appBox).get(ppscTestTopicsKey) as List<dynamic>)
        .map((e) => e.toString())
        .toList()
    : [];
