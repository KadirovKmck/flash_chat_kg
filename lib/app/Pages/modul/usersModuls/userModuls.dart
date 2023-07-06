import 'package:equatable/equatable.dart';

class UrModels extends Equatable {
  final String? name;
  final String? email;
  final String? id;

  UrModels({this.name, this.email, this.id});
  // UrModels fromJson(){}
  Map<String, dynamic> toJson() {
    return {'name': name, 'email': email, 'id': id};
  }

  factory UrModels.fromJson(Map<String, dynamic> json) => UrModels(
        email: json['email'],
        id: json['id'],
        name: json['name'],
      );

  @override
  // TODO: implement props
  List<Object?> get props => [name, email, id];
}
