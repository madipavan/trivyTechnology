import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;

import '../model/card_details_model.dart';

class GetCardDetailsService {
  Future<CardDetailsModel?> getCardDetailsFromServer() async {
    CardDetailsModel? card;
    try {
      final url = 'https://random-data-api.com/api/v2/credit_cards';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        card = CardDetailsModel(
            number: data['credit_card_number'],
            expDate: data['credit_card_expiry_date'],
            cvv: (100 + Random().nextInt(900)).toString());
      } else {
        throw ("${response.statusCode} Error While Fetching Card Details");
      }
    } catch (e) {
      throw ("${e.toString()} Error While Fetching Card Details");
    }
    return card;
  }
}
