import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../../core/configs/assets/app_images.dart';
import '../../../core/configs/themes/app_colors.dart';
import '../../../model/card_details_model.dart';
import '../../../viewmodel/get_card_details.dart';

class CardDetails extends StatefulWidget {
  const CardDetails({super.key});

  @override
  State<CardDetails> createState() => _CardDetailsState();
}

class _CardDetailsState extends State<CardDetails> {
  CardDetailsModel? _card;
  bool _isLoading = true;
  bool _isFreeze = true;
  bool _isCvvVisible = false;
  late List<String> _splittedCardnumbers;

  @override
  void initState() {
    _getData();

    super.initState();
  }

  Future _getData() async {
    _card = await GetCardDetails().getCardDetails();
    if (mounted) {
      setState(() {
        _card;
        _splittedCardnumbers = _card!.number.split('-'); //separating number "-"
        DateTime parsedDate = DateTime.parse(_card!.expDate);
        _card!.expDate =
            DateFormat("MM/yy").format(parsedDate); //covert date into 01/28
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            ),
          )
        : _card == null
            ? Text("Error")
            : Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Positioned.fill(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: SvgPicture.asset(
                            AppImages.cardbg,
                            fit: BoxFit.cover, // Ensures it fills the container
                          ),
                        ),
                      ),
                      //inner
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: MediaQuery.of(context).size.height * 0.44,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: SizedBox.fromSize(
                            child: Image.asset(
                              AppImages.cardinnerShadowBG,
                              fit: BoxFit.fill,
                              opacity: AlwaysStoppedAnimation(0.5),
                              height: 350,
                            ),
                          ),
                        ),
                      ),

                      //nubers column
                      _cardNumber(context, _splittedCardnumbers),
                      //expiry and cvv column
                      _cvvExpiry(context, _card),
                      //copy details
                      _copyDetails(context, _card),

                      //glass effect
                      AnimatedOpacity(
                        opacity: _isFreeze ? 1.0 : 0.0,
                        duration: Duration(milliseconds: 500),
                        child: Visibility(
                          visible: _isFreeze,
                          child: _freezeEffectLayer(context),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  _freezeBtn(),
                ],
              );
  }

  Widget _cvvExpiry(BuildContext context, CardDetailsModel? card) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.1,
      left: MediaQuery.of(context).size.width * 0.3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("expiry",
              style: TextStyle(
                color: AppColors.grey,
                fontWeight: FontWeight.w400,
                letterSpacing: -0.17,
                fontSize: 10,
              )),
          SizedBox(
            height: 5,
          ),
          Text(card!.expDate,
              style: TextStyle(
                fontSize: 14,
                letterSpacing: -0.17,
                fontWeight: FontWeight.w400,
              )),
          SizedBox(
            height: 45,
          ),
          Text("CVV",
              style: TextStyle(
                color: AppColors.grey,
                fontWeight: FontWeight.w400,
                letterSpacing: -0.17,
                fontSize: 10,
              )),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Text(_isCvvVisible ? card.cvv : "***",
                  style: TextStyle(
                    fontSize: 14,
                    letterSpacing: -0.17,
                    fontWeight: FontWeight.w400,
                  )),
              SizedBox(
                width: 5,
              ),
              GestureDetector(
                  onTap: () {
                    setState(() => _isCvvVisible
                        ? _isCvvVisible = false
                        : _isCvvVisible = true);
                  },
                  child: SvgPicture.asset(AppImages.cvvVisible))
            ],
          ),
        ],
      ),
    );
  }

  Widget _freezeBtn() {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() => _isFreeze ? _isFreeze = false : _isFreeze = true);
          },
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white,
                  Colors.white.withAlpha(1),
                ],
              ),
              borderRadius: BorderRadius.circular(40),
            ),
            padding: EdgeInsets.all(1),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Colors.black,
              ),
              padding: EdgeInsets.all(20),
              child: SvgPicture.asset(
                AppImages.freezeIcon,
                colorFilter: ColorFilter.mode(
                    _isFreeze ? AppColors.primary : Colors.white,
                    BlendMode.srcIn),
                width: 25,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text("freeze",
            style: TextStyle(
              color: _isFreeze ? AppColors.primary : Colors.white,
              fontWeight: FontWeight.w500,
              letterSpacing: -0.17,
              fontSize: 14,
            )),
      ],
    );
  }
}

Widget _cardNumber(BuildContext context, List<String> splittedCardnumbers) {
  return Positioned(
    top: MediaQuery.of(context).size.height * 0.1,
    left: MediaQuery.of(context).size.width * 0.08,
    child: Column(
      children: [
        Text(
          splittedCardnumbers[0],
          style: TextStyle(fontSize: 20, fontFamily: "Digital"),
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          splittedCardnumbers[1],
          style: TextStyle(fontSize: 20, fontFamily: "Digital"),
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          splittedCardnumbers[2],
          style: TextStyle(fontSize: 20, fontFamily: "Digital"),
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          splittedCardnumbers[3],
          style: TextStyle(fontSize: 20, fontFamily: "Digital"),
        ),
      ],
    ),
  );
}

Widget _copyDetails(BuildContext context, CardDetailsModel? card) {
  return Positioned(
    top: MediaQuery.of(context).size.height * 0.3,
    left: MediaQuery.of(context).size.width * 0.065,
    child: GestureDetector(
      onTap: () {
        String cardDetails = """
                 Card Number: ${card!.number}
                Expiry Date: ${card.expDate}
                CVV: ${card.cvv}
                          """;
        Clipboard.setData(ClipboardData(text: cardDetails));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Copied!"),
          ),
        );
      },
      child: Row(
        children: [
          SvgPicture.asset(AppImages.copyLogo),
          SizedBox(
            width: 10,
          ),
          Text("copy details",
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w500,
                letterSpacing: -0.17,
                fontSize: 14,
              )),
        ],
      ),
    ),
  );
}

Widget _freezeEffectLayer(BuildContext context) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(16),
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 12.0, sigmaY: 12.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.6,
        height: MediaQuery.of(context).size.height * 0.44,
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(10), // Frosted overlay
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withAlpha(20)),
        ),
      ),
    ),
  );
}
