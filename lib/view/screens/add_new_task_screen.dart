import 'package:flutter/material.dart';
import 'package:task_manager/core/app_route.dart';
import 'package:task_manager/data/model/network_response.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/utils/api_url.dart';
import 'package:task_manager/utils/app_color.dart';
import 'package:task_manager/view/widgets/custom_text_form_field.dart';
import 'package:task_manager/view/widgets/custom_toast.dart';
import 'package:task_manager/view/widgets/elevated_icon_button.dart';
import 'package:task_manager/view/widgets/loading_dialog.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _subjectTextEditingController = TextEditingController();
  final TextEditingController _descriptionTextEditingController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _addNewTaskInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        title: const Text("Add Task"),
        leading: IconButton(
          icon: const Icon(
            Icons.close,
            size: 25,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                Text(
                  "Add New Task",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextFormField(
                        textEditingController: _subjectTextEditingController,
                        textInputType: TextInputType.text,
                        titleText: "Title",
                        hintText: "Enter title",
                        bottomPadding: 10,
                        topPadding: 20,
                        validator: (value) {
                          if (value?.trim().isEmpty ?? true) {
                            return "Enter subject";
                          }
                          return null;
                        },
                      ),
                      CustomTextFormField(
                        textEditingController: _descriptionTextEditingController,
                        textInputType: TextInputType.text,
                        titleText: "Description",
                        hintText: "Enter description",
                        bottomPadding: 20,
                        maxLine: 4,
                        validator: (value) {
                          if (value?.trim().isEmpty ?? true) {
                            return "Enter description";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                ElevatedIconButton(
                  icon: Icons.arrow_circle_right_outlined,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _addNewTask();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _addNewTask() async {
    _addNewTaskInProgress = true;

    if (mounted) {
      setState(() {});
    }

    loadingDialog(context);

    Map<String, dynamic> requestData = {
      "title": _subjectTextEditingController.text.trim(),
      "description": _descriptionTextEditingController.text.trim(),
      "status": "New",
    };

    NetworkResponse response =
        await NetworkCaller.postResponse(ApiUrl.createTask, body: requestData);

    _addNewTaskInProgress = false;
    if (mounted) {
      setState(() {});
    }

    if (mounted) {
      Navigator.pop(context);
    }

    if (response.isSuccess) {
      if (mounted) {
        setCustomToast(
          "New task added!",
          Icons.done,
          AppColor.themeColor,
          AppColor.white,
        ).show(context);
        Navigator.pushNamedAndRemoveUntil(
            context, AppRoute.mainBottomBar, (Route<dynamic> route) => false);
      }
    } else {
      _clearTextField();
      if (mounted) {
        setCustomToast(
          "New task add failed!",
          Icons.error_outline,
          AppColor.red,
          AppColor.white,
        ).show(context);
      }
    }
  }

  void _clearTextField() {
    _subjectTextEditingController.clear();
    _descriptionTextEditingController.clear();
  }

  @override
  void dispose() {
    _subjectTextEditingController.dispose();
    _descriptionTextEditingController.dispose();
    super.dispose();
  }
}
