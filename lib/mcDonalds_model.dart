// To parse this JSON data, do
//
//     final mcDonalds = mcDonaldsFromJson(jsonString);

import 'dart:convert';

// McDonalds mcDonaldsFromJson(String str) => McDonalds.fromJson(json.decode(str));

// String mcDonaldsToJson(McDonalds data) => json.encode(data.toJson());

class McDonalds {
  int id;
  String name;
  String description;
  String marketingName;
  String shortName;
  String menuItemNo;
  String type;
  List<String> keywords;
  String ingredients;
  String additionalIngredientStatement;
  List<NutrientFact> nutrientFacts;

  McDonalds({
    required this.id,
    required this.name,
    required this.description,
    required this.marketingName,
    required this.shortName,
    required this.menuItemNo,
    required this.type,
    required this.keywords,
    required this.ingredients,
    required this.additionalIngredientStatement,
    required this.nutrientFacts,
  });

  factory McDonalds.fromJson(Map<String, dynamic> json) {
    print("from api oops calling $json");
    return McDonalds(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      marketingName: json["marketing_name"],
      shortName: json["short_name"],
      menuItemNo: json["menu_item_no"],
      type: json["type"],
      keywords: List<String>.from(json["keywords"].map((x) => x)),
      ingredients: json["ingredients"],
      additionalIngredientStatement: json["additional_ingredient_statement"],
      nutrientFacts: List<NutrientFact>.from(json["nutrient_facts"].map((x) => NutrientFact.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "marketing_name": marketingName,
    "short_name": shortName,
    "menu_item_no": menuItemNo,
    "type": type,
    "keywords": List<dynamic>.from(keywords.map((x) => x)),
    "ingredients": ingredients,
    "additional_ingredient_statement": additionalIngredientStatement,
    "nutrient_facts": List<dynamic>.from(nutrientFacts.map((x) => x.toJson())),
  };
}

class NutrientFact {
  String name;
  String value;
  String unit;
  String hundredGPerProduct;
  String recommendedDailyValue;

  NutrientFact({
    required this.name,
    required this.value,
    required this.unit,
    required this.hundredGPerProduct,
    required this.recommendedDailyValue,
  });

  factory NutrientFact.fromJson(Map<String, dynamic> json) => NutrientFact(
    name: json["name"],
    value: json["value"],
    unit: json["unit"],
    hundredGPerProduct: json["hundred_g_per_product"],
    recommendedDailyValue: json["recommended_daily_value"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "value": value,
    "unit": unit,
    "hundred_g_per_product": hundredGPerProduct,
    "recommended_daily_value": recommendedDailyValue,
  };
}
