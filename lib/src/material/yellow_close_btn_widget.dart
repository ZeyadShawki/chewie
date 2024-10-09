import 'package:chewie/src/material/app_colors.dart';
import 'package:chewie/src/material/asset_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class YellowCloseBtnWidget extends StatelessWidget {
  const YellowCloseBtnWidget({super.key, this.isArrow, this.onTap});
  final bool? isArrow;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: 
      (onTap),
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.ellinewPurple,
            borderRadius: BorderRadius.circular(15)),
        padding: EdgeInsets.all(15),
        child: isArrow != null && isArrow!
            ? SvgPicture.asset(AssetManger.arrowLeft)
            : SvgPicture.asset(AssetManger.closeAddMed),
      ),
    );
  }
}
