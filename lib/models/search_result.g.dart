// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_result.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SearchResultAdapter extends TypeAdapter<SearchResult> {
  @override
  final int typeId = 0;

  @override
  SearchResult read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SearchResult(
      placeId: fields[0] as int,
      licence: fields[1] as String,
      osmType: fields[2] as String,
      osmId: fields[3] as int,
      boundingBox: (fields[4] as List).cast<String>(),
      lat: fields[5] as String,
      lon: fields[6] as String,
      displayName: fields[7] as String,
      placeClass: fields[8] as String,
      type: fields[9] as String,
      importance: fields[10] as double,
      icon: fields[11] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SearchResult obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.placeId)
      ..writeByte(1)
      ..write(obj.licence)
      ..writeByte(2)
      ..write(obj.osmType)
      ..writeByte(3)
      ..write(obj.osmId)
      ..writeByte(4)
      ..write(obj.boundingBox)
      ..writeByte(5)
      ..write(obj.lat)
      ..writeByte(6)
      ..write(obj.lon)
      ..writeByte(7)
      ..write(obj.displayName)
      ..writeByte(8)
      ..write(obj.placeClass)
      ..writeByte(9)
      ..write(obj.type)
      ..writeByte(10)
      ..write(obj.importance)
      ..writeByte(11)
      ..write(obj.icon);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SearchResultAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
