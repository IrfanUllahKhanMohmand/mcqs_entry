import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mcqs_entry/common/utills/app_colors.dart';
import 'package:mcqs_entry/pages/data_entry/provider.dart';
import 'package:mcqs_entry/pages/data_entry/widgets/custom_drop_down.dart';
import 'package:provider/provider.dart';

class DataEntryPage extends StatefulWidget {
  const DataEntryPage({Key? key}) : super(key: key);

  @override
  State<DataEntryPage> createState() => _DataEntryPageState();
}

class _DataEntryPageState extends State<DataEntryPage> {
  var question = TextEditingController();
  var option1 = TextEditingController();
  var option2 = TextEditingController();
  var option3 = TextEditingController();
  var option4 = TextEditingController();

  @override
  void initState() {
    super.initState();
    var provider = context.read<DataEntryProvider>();
    Future.delayed(Duration.zero, () => provider.initCategory());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.brandingColor,
        title: const Text('Data Entry'),
        centerTitle: true,
      ),
      body: Consumer<DataEntryProvider>(
        builder: (context, dataEntryProvider, child) {
          return !dataEntryProvider.isUploading
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      buildTypeContainer(dataEntryProvider),
                      buildDivider(),
                      Stack(
                        children: [
                          Container(height: 450),
                          Positioned(
                              top: 10,
                              left: 0,
                              right: 0,
                              bottom: 0,
                              child: buildQuestionEntryForm(dataEntryProvider)),
                          Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              bottom: 0,
                              child: buildDropDownsRow(dataEntryProvider))
                        ],
                      ),
                      InkWell(
                        onTap: () async {
                          if (question.text.isEmpty ||
                              option1.text.isEmpty ||
                              option2.text.isEmpty ||
                              option3.text.isEmpty ||
                              option4.text.isEmpty) {
                            buildErrorDialog();
                          } else {
                            dataEntryProvider.setIsUploading(true);
                            await dataEntryProvider.uploadDataToCPanel(
                                question: question.text,
                                optionOne: option1.text,
                                optionTwo: option2.text,
                                optionThree: option3.text,
                                optionFour: option4.text,
                                onComplete: () {
                                  dataEntryProvider.setIsUploading(false);
                                  Future.delayed(
                                      const Duration(seconds: 1),
                                      () => showSnackBar(
                                          msg:
                                              "Your question is successfully saved. In CPanel",
                                          icon: Icons.check_circle));
                                });
                            await dataEntryProvider.uploadDataToFirebase(
                                question: question.text,
                                optionOne: option1.text,
                                optionTwo: option2.text,
                                optionThree: option3.text,
                                optionFour: option4.text,
                                onComplete: () {
                                  showSnackBar(
                                      msg:
                                          "Your question is successfully saved. In Firebase",
                                      icon: Icons.check_circle);
                                });
                            // NetworkChecker(
                            //   onComplete: (){
                            //     showSnackBar(msg: "Working",icon: Icons.network_check);
                            //   },
                            //   onError: (){
                            //     showSnackBar(msg: "No Internet",icon: Icons.network_check);
                            //   }
                            // ).doRequest();
                          }
                        },
                        child: buildSaveButton(),
                      )
                    ],
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }

  void showSnackBar({required String msg, required IconData icon}) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(
          backgroundColor: Colors.white,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height - 105,
          ),
          duration: const Duration(seconds: 1),
          dismissDirection: DismissDirection.startToEnd,
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Colors.green,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                msg,
                style: const TextStyle(color: Colors.black),
              ),
            ],
          )));
  }

  Divider buildDivider() {
    return Divider(
      thickness: 2.h,
      endIndent: 20.w,
      indent: 20.w,
    );
  }

  Container buildTypeContainer(DataEntryProvider dataEntryProvider) {
    return Container(
      margin: EdgeInsets.only(top: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Type',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 10.w),
            padding: EdgeInsets.only(left: 10.w, right: 10.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1.r),
                color: AppColors.greyColor),
            child: DropdownButton(
                value: dataEntryProvider.type,
                underline: const SizedBox.shrink(),
                items: const [
                  DropdownMenuItem(
                    value: 'MCQS',
                    child: Text('MCQS'),
                  ),
                  DropdownMenuItem(
                    value: 'TEST',
                    child: Text('TEST'),
                  )
                ],
                onChanged: (value) {
                  dataEntryProvider.setType(value!);
                }),
          )
        ],
      ),
    );
  }

  buildDropDownsRow(DataEntryProvider dataEntryProvider) {
    return Container(
      margin: EdgeInsets.only(left: 20.w, right: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin: EdgeInsets.only(top: 20.h, right: 10.w, left: 10.w),
                    child: const Text(
                      'Category',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                const Expanded(child: CategoryDropDown()),
              ],
            ),
          ),
          dataEntryProvider.type == "MCQS"
              ? dataEntryProvider.selectedSubject != "No"
                  ? Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              margin: EdgeInsets.only(
                                  top: 20.h, right: 10.w, left: 10.w),
                              child: const Text(
                                'Subject',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                          const Expanded(child: SubjectsDropDown())
                        ],
                      ),
                    )
                  : const SizedBox.shrink()
              : const SizedBox.shrink(),
          dataEntryProvider.selectedTopic != "No"
              ? Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          margin: EdgeInsets.only(
                              top: 20.h, right: 10.w, left: 10.w),
                          child: const Text(
                            'Topics',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                      const Expanded(child: TopicsDropDown())
                    ],
                  ),
                )
              : const SizedBox.shrink()
        ],
      ),
    );
  }

  buildQuestionEntryForm(DataEntryProvider dataEntryProvider) {
    return Container(
      margin: EdgeInsets.only(top: 8.h, left: 20.w, right: 20.w),
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10.h,
            ),
            const Text(
              "Enter Question:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Container(
              margin: EdgeInsets.only(top: 8.h),
              decoration: BoxDecoration(
                  color: AppColors.greyColor,
                  borderRadius: BorderRadius.circular(2.r)),
              child: TextFormField(
                controller: question,
                maxLines: 5,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 10.w, top: 10.h),
                    hintText: "Enter Question",
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none),
              ),
            ),
            buildOptionRow(
                option1, 1, dataEntryProvider, dataEntryProvider.option1),
            buildOptionRow(
                option2, 2, dataEntryProvider, dataEntryProvider.option2),
            buildOptionRow(
                option3, 3, dataEntryProvider, dataEntryProvider.option3),
            buildOptionRow(
                option4, 4, dataEntryProvider, dataEntryProvider.option4),
          ],
        ),
      ),
    );
  }

  Future<void> buildErrorDialog() async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Row(
            children: [
              Image.asset(
                'assets/images/alert.png',
                height: 50.h,
                width: 50.w,
              ),
              const Text('All Fields should be Fill'),
            ],
          ),
        );
      },
    );
  }
}

buildOptionRow(TextEditingController controller, int optionNumber,
    DataEntryProvider dataEntryProvider, bool isEnable) {
  return Container(
    margin: EdgeInsets.only(top: 10.h),
    decoration: BoxDecoration(
        color: AppColors.greyColor, borderRadius: BorderRadius.circular(2.r)),
    child: Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: controller,
            maxLines: 1,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 10.w),
                hintText: "Option Number $optionNumber",
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none),
          ),
        ),
        CupertinoSwitch(
            value: isEnable,
            onChanged: (value) {
              dataEntryProvider.setOption(value, optionNumber);
            })
      ],
    ),
  );
}

buildSaveButton() {
  return Container(
    width: 300.w,
    alignment: Alignment.center,
    margin: EdgeInsets.only(top: 5.h, bottom: 20.h),
    padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
    decoration: BoxDecoration(
        color: AppColors.brandingColor,
        borderRadius: BorderRadius.circular(15.r)),
    child: const Text(
      'Save',
      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
    ),
  );
}
