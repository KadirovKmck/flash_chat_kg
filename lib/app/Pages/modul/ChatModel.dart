import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ChatModels extends Equatable {
  final String? sender;
  final String? senderId;
  final String? sms;
  final String? userName;
  final Timestamp? creattedTime;
  ChatModels(
      {this.sender,
      this.senderId,
      this.sms,
      this.userName = '',
      this.creattedTime});
  Map<String, dynamic> toJson() => {
        'sender': sender,
        'senderId': senderId,
        'sms': sms,
        'userName': userName,
        'time': Timestamp.now(),
      };
  factory ChatModels.fromJson(Map<String, dynamic> json) {
    return ChatModels(
        sender: json['sender'],
        senderId: json['senderId'],
        sms: json['sms'],
        userName: json['userName'],
        creattedTime: json['creattedTime']);
  }

  @override
  List<Object?> get props => [
        sender,
        senderId,
        sms,
        userName,
        creattedTime,
      ];
}
