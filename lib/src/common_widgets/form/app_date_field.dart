import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:transactx/src/constants/app_colors.dart';

import '../../constants/app_sizes.dart';
import 'package:intl/intl.dart';

class AppDateField extends StatefulWidget {
  const AppDateField({
    Key? key,
    required this.labelText,
    required this.hintText,
    required this.controller,
    this.errorList,
    this.keyboardType,
    required this.validator,
    this.focusNode,
    this.inputFormatters,
    this.onChanged,
    this.enabled,
    this.initialValue,
    this.isRequired = false,
    this.readOnly = false,
    this.onFieldSubmitted,
    this.textInputAction,
  }) : super(key: key);

  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final List<dynamic>? errorList;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onChanged;
  final bool? enabled;
  final bool readOnly;
  final bool? isRequired;
  final Function(String)? onFieldSubmitted;
  final String? initialValue;
  @override
  createState() => _AppDateFieldState();
}

class _AppDateFieldState extends State<AppDateField> {
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Visibility(
        visible: !widget.isRequired!,
        child: Text(
          widget.labelText,
          style: const TextStyle(
            fontSize: 16,
            color: btTextColor,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.02,
            fontStyle: FontStyle.normal,
          ),
          textAlign: TextAlign.left,
        ),
      ),
      Visibility(
        visible: widget.isRequired!,
        child: RichText(
          text: TextSpan(
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.02,
              fontFamily: "Degular",
            ),
            children: <TextSpan>[
              TextSpan(
                text: widget.labelText,
                style: const TextStyle(
                  color: btTextColor,
                ),
              ),
              const TextSpan(
                text: '*',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
      gapH4,
      _buildErrorText(widget.errorList),
      gapH8,
      Platform.isIOS
          ? Container(
              color: Colors.white,
              child: CupertinoTextField(
                padding: const EdgeInsets.all(20),
                controller: widget.controller,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                style: const TextStyle(
                  color: btTextColor,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.02,
                  fontStyle: FontStyle.normal,
                ),
                placeholder: 'Select a Date',
                readOnly: true,
                onTap: () {
                  _showDatePicker(context);
                },
              ),
            )
          : TextFormField(
              controller: widget.controller,
              style: const TextStyle(
                color: btTextColor,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.02,
                fontStyle: FontStyle.normal,
              ),
              decoration:
                  _buildInputDecoration(widget.hintText, widget.errorList),
              validator: widget.validator,
              readOnly: widget.readOnly,
              onTap: () async {
                FocusScope.of(context).requestFocus(FocusNode());
                // final date = DateTime.now();
                // final selectedDate = await pickedDate(context, date);
                String formattedDate =
                    DateFormat('yyyy-MM-dd').format(selectedDate);
                widget.controller.text = formattedDate;
                            },
            )
    ]);
  }

  Widget _buildErrorText(List<dynamic>? errorList) {
    if (errorList != null && errorList.isNotEmpty) {
      return Text(
        errorList[0].toString(),
        style: const TextStyle(
          fontSize: 16,
          color: Colors.red,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.02,
          fontStyle: FontStyle.normal,
        ),
        textAlign: TextAlign.left,
      );
    } else {
      return const SizedBox();
    }
  }

  InputDecoration _buildInputDecoration(
      String hintText, List<dynamic>? errorList) {
    return InputDecoration(
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: errorList != null ? btSecondaryColor : Colors.grey,
          width: 2.0,
        ),
      ),
      fillColor: btWhite,
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey, width: 2.0),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: btSecondaryColorOne, width: 2.0),
      ),
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: btv2SecondaryGreetingsIcon, width: 2.0),
      ),
      filled: true,
      hintText: hintText,
      errorStyle: const TextStyle(
        color: btv2SecondaryGreetingsIcon,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Future<void> _showDatePicker(BuildContext context) async {
    return await showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 300.0,
          child: CupertinoDatePicker(
            backgroundColor: btBackgroundColor,
            mode: CupertinoDatePickerMode.date,
            initialDateTime: selectedDate,
            onDateTimeChanged: (DateTime newDate) {
              setState(() {
                selectedDate = newDate;
                widget.controller.text = DateFormat.yMMMd().format(newDate);
              });
            },
          ),
        );
      },
    );
  }
}
