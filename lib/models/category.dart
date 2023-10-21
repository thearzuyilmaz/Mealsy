import 'package:flutter/material.dart';

class Category {
  const Category({
    required this.id,
    required this.title,
    this.color = const Color(0xFFFFE9E6), // Set the default color here,
  });

  final String id;
  final String title;
  final Color color;
}

// Palette
// ##FFE9E6
// ##FFD2A6
// ##FFE6DA
// ##7D575C
// ##FFF1D9
