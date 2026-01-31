import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HistoryController extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Striim, mis loeb andmeid ja kontrollib, et need on Sinu omad
  Stream<QuerySnapshot> get historyStream {
    String uid = _auth.currentUser?.uid ?? "unknown";
    return _db.collection('history')
        .where('ownerId', isEqualTo: uid) // Turvalisuse kontroll
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  // Lisab uue arvutuse pilve
  Future<void> addEntry(String calculation) async {
    try {
      String uid = _auth.currentUser?.uid ?? "unknown";
      
      await _db.collection('history').add({
        'calculation': calculation,
        'createdAt': FieldValue.serverTimestamp(),
        'ownerId': uid, // See on vajalik +5 punkti turvareegli jaoks!
      });
      notifyListeners();
    } catch (e) {
      debugPrint("Viga salvestamisel: $e");
    }
  }
}