import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:mcdonaldsapp/mcDonalds_model.dart';

class McDonaldsFoodScreen extends StatefulWidget {
  const McDonaldsFoodScreen({super.key});

  @override
  State<McDonaldsFoodScreen> createState() => _McDonaldsFoodScreenState();
}

class _McDonaldsFoodScreenState extends State<McDonaldsFoodScreen> {
  bool isLoading = true;
  late McDonalds mcDonalds;
  Future getFoodFromApi() async {
    Logger logger = Logger();
    Dio dio = Dio();
    Response response = await dio.get(
      "https://mcdonald-s-products-api.p.rapidapi.com/us/products/200426",
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "x-rapidapi-host": "mcdonald-s-products-api.p.rapidapi.com",
          "x-rapidapi-key":
              "fa1e134807msh7db3c185f348abbp166e6cjsn96c33a712066",
        },
      ),
    );
    if (response.statusCode == 200) {
      logger.d("data from api response:${response.data}");
      logger.d("headers from api response:${response.headers}");
      logger.d("status message from api response:${response.statusMessage}");
      logger.d("request options  from api response:${response.requestOptions}");
      mcDonalds = McDonalds.fromJson(
        JsonDecoder(response.data) as Map<String,dynamic>
      );
      isLoading=false;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getFoodFromApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mac Donalds Food Menu")),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.separated(
              itemCount: mcDonalds.nutrientFacts.length,
              itemBuilder: (context, index) {
                if (mcDonalds.name.isNotEmpty) {
                  var nutritionFacts = mcDonalds.nutrientFacts[index];
                  return Card(
                    child: ListTile(
                      leading: Text(nutritionFacts.unit),
                      title: Text(nutritionFacts.name),
                      subtitle: Text(nutritionFacts.value),
                      trailing: Text(nutritionFacts.hundredGPerProduct),
                    ),
                  );
                }
                return SizedBox();
              },
              separatorBuilder: (context, index) => SizedBox(height: 30),
            ),
    );
  }
}
