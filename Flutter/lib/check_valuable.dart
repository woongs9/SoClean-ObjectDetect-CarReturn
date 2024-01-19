import 'package:aiffel_thone/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


class CheckValuable extends StatelessWidget {
  const CheckValuable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UploadPageController>();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Get.offAllNamed('/');
                  controller.resetState();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('분실물 찾기', style: TextStyle(fontFamily: 'Pretendard', fontSize: 20.sp, fontWeight: FontWeight.bold),textScaleFactor: 1,),
                  SizedBox(height: 10.h),
                  Text('놓고가신 물건이 맞는지 확인해주세요.',style: TextStyle( fontSize: 13.sp), textScaleFactor: 1),
                  SizedBox(height: 10.h),
                  Center(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        double screenWidth = constraints.maxWidth;
                        double gridSpacing = 5;
                        double gridItemWidth = (screenWidth - gridSpacing) / 2;
                        double gridHeight = gridItemWidth * 2 + gridSpacing;

                        return SizedBox(
                          height: gridHeight,
                          width: double.infinity,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10), // Set the desired border radius
                            child: Obx(() {
                              if (controller.images.isNotEmpty && controller.images.length >= 4) {
                                return GridView.builder(
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2, // Two columns
                                    crossAxisSpacing: gridSpacing,
                                    mainAxisSpacing: gridSpacing,
                                    childAspectRatio: 1, // Set the aspect ratio to 1 for square images
                                  ),
                                  itemCount: 4, // Display only four images
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Get.put(ImageViewerController()).currentIndex.value = index;
                                        showModalBottomSheetForReturn(context, index, controller.images);
                                      },
                                      child: Hero(
                                        tag: 'imageHero$index',
                                        child: Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: controller.images[index].image, // Assuming controller.images[index] is an Image widget
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              } else {
                                return const Text('이미지를 불러올 수 없습니다.');
                              }
                            }),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text('물건을 분실하여 많이 속상하시겠어요.', style: TextStyle(fontFamily: 'Pretendard', fontSize: 15.sp, fontWeight: FontWeight.bold), textScaleFactor: 1,),
                  SizedBox(height: 10.h),
                  Text('도움이 필요하시다면', style: TextStyle(fontSize: 12.sp), textScaleFactor: 1,),
                  Text('앱내 고객지원으로 문의해주시기 바랍니다.',style: TextStyle(fontSize: 12.sp), textScaleFactor: 1,),
                  SizedBox(height: 20.h),
                  SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      child: const Text('문의하기', style: TextStyle(color: Colors.white),textScaleFactor: 1,
                      ),
                      onPressed: () {
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          side: BorderSide(color: Colors.green),
                        ),
                      ),
                      child: const Text('닫기', style: TextStyle(color: Colors.green),textScaleFactor: 1,
                      ),
                      onPressed: () {
                        Get.offAllNamed('/');
                        controller.resetState();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showModalBottomSheetForReturn(BuildContext context, int index, List<Image> images) {
    final ImageViewerController imageController = Get.put(ImageViewerController());
    final UploadPageController uploadPageController = Get.find<UploadPageController>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.8,
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  flex: 1, // 첫 번째 Text 부분의 비율
                  child: Obx(() {
                    String text;
                    switch (imageController.currentIndex.value) {
                      case 0:
                        text = '운전석';
                        break;
                      case 1:
                        text = '조수석';
                        break;
                      case 2:
                        text = '뒷좌석';
                        break;
                      case 3:
                        text = '컵홀더';
                        break;
                      default:
                        text = '이미지';
                        break;
                    }
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        text,
                        style: TextStyle(
                          fontSize: 24.sp, // 글꼴 크기
                          fontWeight: FontWeight.w600, // 굵은 글씨
                        ),
                        textScaleFactor: 1,
                      ),
                    );
                  }),
                ),
                SizedBox(height: 10.h),
                Flexible(
                  flex: 4, // 사진 부분의 비율
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: PageView.builder(
                      scrollDirection: Axis.vertical,
                      controller: PageController(initialPage: imageController.currentIndex.value, keepPage: false),
                      itemCount: images.length,
                      onPageChanged: (index) => imageController.setCurrentIndex(index),
                      itemBuilder: (context, index) {
                        return InteractiveViewer(
                          child: images[index],
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Flexible(
                  flex: 1, // 두 번째 Text 부분의 비율
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Obx((){
                        String text;
                        switch (imageController.currentIndex.value) {
                          case 0:
                            text = 'driver_seat_mat';
                            break;
                          case 1:
                            text = 'passenger_seat_mat';
                            break;
                          case 2:
                            text = 'rear_seat';
                            break;
                          case 3:
                            text = 'cup_holder';
                            break;
                          default:
                            text = 'else';
                            break;
                        }
                        if (uploadPageController.classLabels[text] == 'pending'){
                          return Text('귀중품이 발견되었습니다.', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: Colors.red),textScaleFactor: 1, );
                        } else {
                          return Text('여기서는 발견된 귀중품이 없습니다.', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: Colors.grey), textScaleFactor: 1,);
                        }
                      }),
                    ],
                  ),),
                const Spacer(),
                SizedBox(
                  height: 30.h,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        side: BorderSide(color: Colors.green),
                      ),
                    ),
                    child: const Text('닫기', style: TextStyle(color: Colors.green), textScaleFactor: 1,
                    ),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

