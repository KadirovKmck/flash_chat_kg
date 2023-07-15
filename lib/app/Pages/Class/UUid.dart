import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class Yuid extends Equatable {
  final uid = Uuid().v4();
  @override
  // TODO: implement props
  List<Object?> get props => [uid];
}
