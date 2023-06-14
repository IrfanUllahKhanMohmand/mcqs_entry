import 'package:hive/hive.dart';
import 'package:mcqs_entry/pages/data_entry/provider.dart';

class AvailableAdopter extends TypeAdapter<AvailableTopics> {
  @override
  AvailableTopics read(BinaryReader reader) {
    String key = reader.read();
    List<String> list = reader.read();
    String topic = reader.read();
    String category = reader.read();
    return AvailableTopics(
        key: key, list: list, currentTopic: topic, currentCategory: category);
  }

  @override
  int get typeId => 0;

  @override
  void write(BinaryWriter writer, AvailableTopics obj) {
    writer.write(obj.key);
    writer.write(obj.list);
    writer.write(obj.currentTopic);
    writer.write(obj.currentCategory);
  }
}
