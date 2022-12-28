import 'package:flutter/material.dart';

class Contacts {
   final Widget image;
   final Widget icon;
   final String title;
   final String subtitle;
   final String time;
   final String call;

   Contacts({
     required this.image,
     required this.icon,
     required this.title,
     required this.subtitle,
     required this.time,
     required this.call,
});

   factory Contacts.fromMap({required Map<String , dynamic> data}){
     return Contacts(
         image: data['image'],
         icon: data['icon'],
         title: data['title'],
         subtitle: data['subtitle'],
         time: data['time'],
         call: data['call']);
   }
}