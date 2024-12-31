import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class LanguageTranslationPage extends StatefulWidget {
  const LanguageTranslationPage({super.key});

  @override
  State<LanguageTranslationPage> createState() =>
      _LanguageTranslationPageState();
}

class _LanguageTranslationPageState extends State<LanguageTranslationPage> {
  var languages = [
    'English',
    'Hindi',
    'Spanish',
    'French',
    'German',
    'Urdu',
    'Arabic'
  ];

  var originLang = 'From';
  var targetLang = 'To';

  var result = '';
  TextEditingController languageController = TextEditingController();

  void translate(String src, String dest, String input) async {
    GoogleTranslator translator = GoogleTranslator();

    var translation = await translator.translate(input, from: src, to: dest);

    setState(() {
      result = translation.text.toString();
    });

    if (src == '--' || dest == '--') {
      setState(() {
        result = 'Please select the languages';
      });
    }
  }

  String getLangCode(String language) {
    if (language == 'English') {
      return 'en';
    } else if (language == 'Hindi') {
      return 'hi';
    } else if (language == 'Spanish') {
      return 'es';
    } else if (language == 'French') {
      return 'fr';
    } else if (language == 'German') {
      return 'de';
    } else if (language == 'Urdu') {
      return 'ur';
    } else if (language == 'Arabic') {
      return 'ar';
    } else if (language == 'Russian') {
      return 'ru';
    } else {
      return '--';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff10223d),
      appBar: AppBar(
        title: const Text(
          ' Language Translator',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff10223d),
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButton(
                    focusColor: Colors.white,
                    iconDisabledColor: Colors.white,
                    iconEnabledColor: Colors.white,
                    hint: Text(
                      originLang,
                      style: const TextStyle(color: Colors.white),
                    ),
                    dropdownColor: Colors.white,
                    icon: const Icon(Icons.arrow_drop_down),
                    items: languages.map(
                      (String dropDownStrItem) {
                        return DropdownMenuItem(
                          value: dropDownStrItem,
                          child: Text(dropDownStrItem),
                        );
                      },
                    ).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        originLang = value!;
                      });
                    },
                  ),
                  const SizedBox(width: 40),
                  const Icon(
                    Icons.arrow_right_alt_outlined,
                    color: Colors.white,
                    size: 40,
                  ),
                  const SizedBox(width: 40),
                  DropdownButton(
                    focusColor: Colors.white,
                    iconDisabledColor: Colors.white,
                    iconEnabledColor: Colors.white,
                    hint: Text(
                      targetLang,
                      style: const TextStyle(color: Colors.white),
                    ),
                    dropdownColor: Colors.white,
                    icon: const Icon(Icons.arrow_drop_down),
                    items: languages.map(
                      (String dropDownStrItem) {
                        return DropdownMenuItem(
                          value: dropDownStrItem,
                          child: Text(dropDownStrItem),
                        );
                      },
                    ).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        targetLang = value!;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.all(30),
                child: TextFormField(
                  cursorColor: Colors.white,
                  autofocus: false,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Enter text here...',
                    labelStyle: TextStyle(fontSize: 15, color: Colors.white),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1),
                    ),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: languageController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return " Please enter some text";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff2b3c5a),
                  ),
                  onPressed: () {
                    translate(
                      getLangCode(originLang),
                      getLangCode(targetLang),
                      languageController.text.toString(),
                    );
                  },
                  child: const Text(
                    'Translate',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Text(
                '\n$result',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
