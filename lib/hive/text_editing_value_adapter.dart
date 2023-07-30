import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class TextEditingValueAdapter extends TypeAdapter<TextEditingValue> {
  @override
  final int typeId = 0;

  @override
  TextEditingValue read(BinaryReader reader) {
    final text = reader.readString();
    return TextEditingValue(text: text);
  }

  @override
  void write(BinaryWriter writer, TextEditingValue obj) {
    final text = obj.text;
    writer.writeString(text);
  }
}