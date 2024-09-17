import 'package:daily_supplications_app/modules/prayer_screen.dart';
import 'package:daily_supplications_app/shared/cubit/status.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../shared/cubit/cubit.dart';

class SupplicationsScreen extends StatelessWidget {
  SupplicationsScreen({super.key});

  var form = GlobalKey<FormState>();
  var supplication = TextEditingController();
  var numberOfSupplications = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Stack(
          alignment: Alignment.topRight,
          children: [
            Scaffold(
              floatingActionButton: Container(
                height: 60.h,
                width: 60.h,
                child: FloatingActionButton(
                  onPressed: () {
                    _showBottomSheet(context);
                  },
                  backgroundColor: Colors.blue,
                  child:  Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 30.h,
                  ),
                ),
              ),
              appBar: AppBar(
                toolbarHeight: 80.h,
                centerTitle: false,


                title:  Row(
                  children: [
                    Text(
                      "ادعيتي",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.sp,
                      ),
                    ),
          Spacer(),
          Center(
            child: Container(height: 70.w,width: 70.w,child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [


                Center(child: Image.asset("assets/image/imageThree.png",width: 45.w,height: 45.w,fit: BoxFit.cover,)),
              ],
            )),
          )
                  ],
                ),
                backgroundColor: Colors.blue,
              ),
              body: Padding(
                padding:  EdgeInsets.symmetric(vertical: 10.h),
                child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) => Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 10.w),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PrayerScreen(
                                      AppCubit.get(context)
                                          .supplications[index]['title'],
                                      AppCubit.get(context)
                                          .supplications[index][
                                      'number'],AppCubit.get(context).supplications[index]['id']))); // Close the modal sheet
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10.r)),
                          child: Padding(
                            padding:
                             EdgeInsets.symmetric(horizontal: 20.w,vertical: 5.h),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${AppCubit.get(context).supplications[index]['title']}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.sp,
                                        ),
                                      ),
                                      Text(
                                        " عدد التسبيح : ${AppCubit.get(context).supplications[index]['number']}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.sp,

                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    // Show the bottom sheet with pre-filled data
                                    supplication.text = AppCubit.get(context)
                                        .supplications[index]['title'];
                                    numberOfSupplications.text = AppCubit.get(context)
                                        .supplications[index]['number']
                                        .toString();
                                    _showBottomSheet(context, id: AppCubit.get(context)
                                        .supplications[index]['id']);
                                    AppCubit.get(context).updatesDataForElement(supplication.text,  int.parse(numberOfSupplications.text.toString()), AppCubit.get(context)
                                        .supplications[index]['id']);
                                  },
                                  icon: Icon(
                                    Icons.mode_rounded,
                                    color: Colors.grey[200],
                                    size: 25.h,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    AppCubit.get(context).deleteElement(
                                        AppCubit.get(context)
                                            .supplications[index]['id']);
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    size: 25.h,

                                    color: Colors.grey[200],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    separatorBuilder: (context, index) => SizedBox(
                      height: 10.h,
                    ),
                    itemCount: AppCubit.get(context).supplications.length),
              ),
            ),
            Positioned(
              bottom: 14,
              right: 20.w,
              child: Container(
                height: 60.h,
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 2.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "المجموع:",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      Text(
                        "${AppCubit.get(context).sum}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue,
                ),
                width: 150.w,
              ),
            ),
          ],
        );
      },
    );
  }

  void _showBottomSheet(BuildContext context, {int? id}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Make the bottom sheet scrollable
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom, // Adjust padding when keyboard appears
          ),
          child: Container(
            padding:  EdgeInsets.all(16.h),
            child: Form(
              key: form,
              child: SingleChildScrollView( // Wrap with SingleChildScrollView
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Text(
                      "إضافة الدعاء",
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                     SizedBox(height: 20.h),
                    TextFormField(
                      controller: supplication,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "من فضلك اكتب دعاء";
                        }
                        return null;
                      },
style: TextStyle(
    fontSize: 14.sp

),

                      decoration:  InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'أدخل دعاءك',
                        errorStyle: TextStyle(
                            fontSize: 14.sp

                        ),
                        labelStyle: TextStyle(
                          fontSize: 14.sp
                        )
                      ),
                    ),
                     SizedBox(height: 20.h),
                    TextFormField(
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "الرجاء كتابة رقم المرات التي تريده بها  الدعاء";
                        }
                        return null;
                      },style: TextStyle(
                      fontSize: 14.sp
                    ),
                      controller: numberOfSupplications,
                      keyboardType: TextInputType.number,
                      decoration:  InputDecoration(
                          errorStyle: TextStyle(
                              fontSize: 14.sp

                          ),
                          labelStyle: TextStyle(
                              fontSize: 14.sp
                          ),
                        border: OutlineInputBorder(),
                        labelText: 'ادخل رقم المرات التي تريده بها  الدعاء',
                      ),
                    ),
                     SizedBox(height: 20.h),
                    Container(
                      width: double.infinity,
                      height: 50.h,
                      color: Colors.blue,
                      child: MaterialButton(
                        onPressed: () {
                          if (form.currentState!.validate()) {
                            if (id == null) {
                              // Insert new supplication
                              AppCubit.get(context)
                                  .insertToDb(
                                  title: supplication.text,
                                  number: int.parse(numberOfSupplications.text.toString()))
                                  .then((value) {
                                Navigator.pop(context); // Close the modal sheet
                              });
                            } else {
                              // Update existing supplication
                              AppCubit.get(context).updatesDataForElement(
                                  supplication.text,
                                  int.parse(numberOfSupplications.text.toString()),
                                  id);
                              numberOfSupplications.text="";
                              supplication.text='';
                              Navigator.pop(context); // Close the modal sheet
                            }
                          }
                        },
                        child:  Text(
                          'حفظ الدعاء',
                          style: TextStyle(
                              color: Colors.white, fontSize: 20.sp),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
