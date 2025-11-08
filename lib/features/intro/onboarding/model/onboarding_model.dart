import 'package:sa7ety/core/constants/app_images.dart';

class OnBoardingModel {
  final String image;
  final String title;
  final String subtitle;

  OnBoardingModel({
    required this.image,
    required this.title,
    required this.subtitle,
  });

  static List<OnBoardingModel> onBoardingScreens = [
    OnBoardingModel(
      image: AppImages.on1Svg,
      title: 'ابحث عن دكتور متخصص',
      subtitle:
          'اكتشف مجموهة متوسعه من مختلف الاطباء المتخصصين في مختلف المجالات',
    ),
    OnBoardingModel(
      image: AppImages.on2Svg,
      title: 'احجز المواعيد',
      subtitle: 'احجز المواعيد بضغطة زرار في اي وقت و في اي مكان ',
    ),
    OnBoardingModel(
      image: AppImages.on3Svg,
      title: 'اّمن و سري',
      subtitle: "كن مطمئنا لان خصوصيتك و امانك هما اهم اولياتنا",
    ),
  ];
}
