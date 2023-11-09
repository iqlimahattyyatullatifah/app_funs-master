import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:funs_app/pages/detect.dart';
import 'package:funs_app/pages/testhome.dart';
import 'package:funs_app/utils/utils.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:translator/translator.dart';

class HomePage extends StatefulWidget {
  String? sourceText;
  HomePage({super.key, this.sourceText});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? result;

  @override
  void initState() {
    translator();
    super.initState();
  }

  Future<void> translator() async {
    if (Utils.isEnglishtoIndonesia == true) {
      final translator = GoogleTranslator();
      await translator
          .translate(widget.sourceText ?? '', from: 'en', to: 'id')
          .then((value) {
        setState(() {
          result = value.toString();
        });

        print('VALUE TRANSLATE ENG-IND: ${value.toString()}');
        print('RESULT SAAT INI : $result');
      });
    } else {
      final translator = GoogleTranslator();
      await translator
          .translate(widget.sourceText ?? '', from: 'id', to: 'en')
          .then((value) {
        setState(() {
          result = value.toString();
        });

        print('VALUE TRANSLATE IND-ENG: ${value.toString()}');
        print('RESULT SAAT INI : $result');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        padding: EdgeInsets.only(left: 30, right: 30),
        children: [
          Image.asset(
            'assets/img/logo-horizontal.png',
            height: 100,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  Utils.isEnglishtoIndonesia
                      ? 'English - Indonesia'
                      : 'Indonesia - English',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold)),
              SizedBox(
                width: 5,
              ),
              IconButton(
                  onPressed: () {
                    setState(() {
                      Utils.isEnglishtoIndonesia = !Utils.isEnglishtoIndonesia;
                      print('ENG TO IND ?${Utils.isEnglishtoIndonesia}');
                    });
                  },
                  icon: Icon(
                    Icons.compare_arrows_rounded,
                    color: Colors.blue,
                    size: 40,
                  ))
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Detected Text',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue)),
                  Container(
                    alignment: Alignment.center,
                    height: 28,
                    width: 100,
                    child: Text(
                      Utils.isEnglishtoIndonesia ? 'English' : 'Indonesia',
                      style: TextStyle(fontSize: 16, color: Colors.blue),
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.blue)),
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 190,
                width: double.maxFinite,
                padding: EdgeInsets.all(10),
                child: Scrollbar(
                  thumbVisibility: true,
                  child: ListView(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    children: [
                      Text(
                        widget.sourceText ?? '',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade700,
                            shadows: [Shadow(offset: Offset(0.5, 0.5))]),
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 5,
                          spreadRadius: 3,
                          offset: Offset(2, 2),
                          color: Colors.grey.withOpacity(0.4))
                    ],
                    color: Colors.blue.shade200),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Translated Text',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue)),
                    Container(
                      alignment: Alignment.center,
                      height: 28,
                      width: 100,
                      child: Text(
                        Utils.isEnglishtoIndonesia ? 'Indonesia' : 'English',
                        style: TextStyle(fontSize: 16, color: Colors.blue),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.blue)),
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 190,
                  width: double.maxFinite,
                  padding: EdgeInsets.all(10),
                  child: Scrollbar(
                    thumbVisibility: true,
                    child: ListView(
                      children: [
                        Text(result ?? '',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.shade700,
                                shadows: [Shadow(offset: Offset(0.5, 0.5))]))
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 5,
                            spreadRadius: 3,
                            offset: Offset(2, 2),
                            color: Colors.grey.withOpacity(0.4))
                      ],
                      color: Colors.blue.shade200),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: ConstrainedBox(
                constraints: BoxConstraints.tightFor(width: 200, height: 35),
                child: ElevatedButton(
                    onPressed: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Detect(),
                          ));
                      // if (isEnglishtoIndonesia == true) {
                      //   final translator = GoogleTranslator();
                      //   await translator
                      //       .translate(widget.sourceTxt ?? '',
                      //           from: 'en', to: 'id')
                      //       .then((value) {
                      //     result = value.toString();
                      //     print('VALUE TRANSLATE: ${value.toString()}');
                      //   });
                      // } else {
                      //   final translator = GoogleTranslator();
                      //   await translator
                      //       .translate(widget.sourceTxt ?? '',
                      //           from: 'id', to: 'en')
                      //       .then((value) {
                      //     result = value.toString();
                      //     print('VALUE TRANSLATE: ${value.toString()}');
                      //   });
                      // }

                      setState(() {});
                    },
                    child: Text('Detect and Translate',
                        style: TextStyle(fontWeight: FontWeight.bold)))),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: ConstrainedBox(
                constraints: BoxConstraints.tightFor(width: 100, height: 35),
                child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        result = '';
                        widget.sourceText = '';
                      });
                    },
                    child: Text(
                      'Delete',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ))),
          ),
        ],
      )),
    );
  }
}
