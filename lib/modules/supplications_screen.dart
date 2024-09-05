import 'package:daily_supplications_app/modules/prayer_screen.dart';
import 'package:daily_supplications_app/shared/cubit/status.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  _showBottomSheet(context);
                },
                backgroundColor: Colors.blue,
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
              appBar: AppBar(
                title: const Text(
                  "ادعيتي",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
                backgroundColor: Colors.blue,
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
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
                                      'number']))); // Close the modal sheet
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 20),
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
                                          fontSize: 20,
                                        ),
                                      ),
                                      Text(
                                        "${AppCubit.get(context).supplications[index]['number']}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
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
                      height: 10,
                    ),
                    itemCount: AppCubit.get(context).supplications.length),
              ),
            ),
            Positioned(
              bottom: 14,
              right: 20,
              child: Container(
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "المجموع:",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      Text(
                        "${AppCubit.get(context).sum}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
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
                width: 150,
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
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom, // Adjust padding when keyboard appears
          ),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: form,
              child: SingleChildScrollView( // Wrap with SingleChildScrollView
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "إضافة الدعاء",
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: supplication,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "من فضلك اكتب دعاء";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'أدخل دعاءك',
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "الرجاء كتابة رقم المرات التي تريده بها  الدعاء";
                        }
                        return null;
                      },
                      controller: numberOfSupplications,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'ادخل رقم المرات التي تريده بها  الدعاء',
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      height: 50,
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
                              Navigator.pop(context); // Close the modal sheet
                            }
                          }
                        },
                        child: const Text(
                          'حفظ الدعاء',
                          style: TextStyle(
                              color: Colors.white, fontSize: 20),
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
