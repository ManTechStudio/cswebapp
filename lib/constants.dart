import 'package:flutter/material.dart';
import 'package:cswebapp/bloc/bloc.dart';

String link = "https://www.industrialempathy.com/img/remote/ZiClJf-1920w.jpg";
Bloc PAGENOBLOC = Bloc();
Color? buttonColor = Color.fromARGB(255, 95, 212, 247);
Color? buttonselectColor = Color.fromARGB(255, 4, 136, 197);

List SECTIONS = [
  "होम",
  "नेशनल",
  "ग्लोबल",
  "कोटा",
  "राजस्थान",
  "एजुकेशन",
  "स्पोर्ट्स",
  "मनोरंजन",
  "बिज़नेस",
  "दिल्ली",
  "उत्तर प्रदेश",
  "कर्नाटक",
  "गुजरात",
  "छत्तीसगढ",
  "जम्मू-कश्मीर",
  "हरियाणा",
  "हिमाचल प्रदेश",
  "पंजाब",
  "महाराष्ट्र",
  "Startups"
];
Map S1 = {
  "Uncategorized": 1,
  "नेशनल": 68,
  "उत्तर प्रदेश": 13,
  "एजुकेशन": 183,
  "कर्नाटक": 60,
  "बिज़नेस": 182,
  "कोटा": 5,
  "स्पोर्ट्स": 3,
  "मनोरंजन": 172,
  "गुजरात": 62,
  "महाराष्ट्र": 542,
  "ग्लोबल": 64,
  "छत्तीसगढ": 65,
  "जम्मू-कश्मीर": 18,
  "पंजाब": 237,
  "मध्यप्रदेश": 127,
  "राजस्थान": 181,
  "हरियाणा": 75,
  "हिमाचल प्रदेश": 76,
  "दिल्ली": 67
};

List DATA = [
  for (int i = 1; i < 10; i++)
    {
      "data": [
        for (int j = 1; j < 5; j++)
          {"image": link, "title": "Title $i $j", "content": "Content $i $j"}
      ]
    }
];
