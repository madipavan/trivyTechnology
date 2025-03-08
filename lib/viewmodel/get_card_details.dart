import 'package:trivytech/model/card_details_model.dart';

import '../service/get_card_details_service.dart';

class GetCardDetails {
  Future<CardDetailsModel?> getCardDetails() async {
    CardDetailsModel? card;
    try {
      card = await GetCardDetailsService().getCardDetailsFromServer();
    } catch (e) {
      throw ("${e.toString()} Error While Fetching Card Details");
    }
    return card;
  }
}
