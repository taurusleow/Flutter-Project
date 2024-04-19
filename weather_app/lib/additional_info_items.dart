import 'package:flutter/material.dart';

class AddInfoItems extends StatelessWidget {
  //Initialize widget for pass through
  final IconData icon;
  final String label;
  final String value;
  
  const AddInfoItems({
    super.key, 
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          //Icon
          Icon(
            icon,
            size: 35,
          ),
      
          const SizedBox(height: 8),
          
          //Info Text
          Text(
            label,
            style: const TextStyle(
              fontSize: 15,
            ),
          ),

          const SizedBox(height: 8),

          //Value Text
          Text(
            value,
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}