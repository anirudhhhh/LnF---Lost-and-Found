import 'package:flutter/material.dart';
import 'homepage.dart';

class LostFoundDetailPage extends StatelessWidget {
  final LostFoundItem item;
  const LostFoundDetailPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(item.title)),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (item.image.isNotEmpty)
              Image.network(
                item.image,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: double.infinity,
                  height: 200,
                  color: Colors.grey[300],
                  child: Icon(Icons.image_not_supported),
                ),
              ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: (item.tag == 'LOST' ? Colors.red : Colors.green).withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                item.tag,
                style: TextStyle(
                  color: item.tag == 'LOST' ? Colors.red : Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(item.desc, style: TextStyle(fontSize: 16)),
            SizedBox(height: 16),
            Text(item.contact, style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
} 