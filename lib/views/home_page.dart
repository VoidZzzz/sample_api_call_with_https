import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_super_scaffold/flutter_super_scaffold.dart';
import 'package:http/http.dart' as http;
import 'package:sample_api_call_app/hero_name_text_view.dart';
import '../models/hero_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String uri = "https://mapi.mobilelegends.com/hero/list";
  bool xFetchingData = false;
  List<HeroModel> allHeroList = [];

  @override
  void initState() {
    initLoad();
    super.initState();
  }

  Future<void> initLoad() async {
    await fetchAllHeroes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
      ),
      body: xFetchingData
          ? const Center(child: CircularProgressIndicator())
          : allHeroList.isEmpty
              ? const Center(
                  child: Text("No Data.."),
                )
              : GridView.builder(
                  itemCount: allHeroList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, childAspectRatio: 2),
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.all(5),
                      color: Colors.black.withOpacity(0.1),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  clipBehavior: Clip.antiAlias,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle),
                                  child: Image.network(
                                      "https:${allHeroList[index].image}"),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                  child: HeroNameTextView(
                                    heroName: allHeroList[index].name,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
    );
  }

  Future<void> fetchAllHeroes() async {
    xFetchingData = true;
    setState(() {});
    var response = await http.get(Uri.parse(uri));
    if (response.statusCode == 200 || response.statusCode == 201) {
      var convertedData = json.decode(response.body);
      for (var r in convertedData['data']) {
        allHeroList.add(HeroModel.fromJson(data: r));
      }
      superPrint(allHeroList.first);
    } else {
      superPrint("Error");
    }
    xFetchingData = false;
    setState(() {});
  }
}
