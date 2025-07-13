import 'package:flutter/material.dart';
import 'homepage.dart';

class CardItem extends StatelessWidget {
  final LostFoundItem item;
  final String currentUserId;
  final VoidCallback onDelete;
  const CardItem({required this.item, required this.currentUserId, required this.onDelete, super.key});

  Color tagColor(String tag) {
    switch (tag) {
      case 'LOST':
        return Colors.red;
      case 'FOUND':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: item.image.isNotEmpty && item.image != 'placeholder'
              ? Image.network(
                  item.image,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 80,
                    height: 80,
                    color: Colors.grey[300],
                    child: Icon(Icons.image_not_supported),
                  ),
                )
              : Container(
                  width: 80,
                  height: 80,
                  color: Colors.grey[300],
                  child: Icon(Icons.image_not_supported),
                ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Text(item.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
                  if (item.authorId == currentUserId)
                    IconButton(icon: Icon(Icons.delete, color: Colors.red), onPressed: onDelete),
                ],
              ),
              SizedBox(height: 4),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: tagColor(item.tag).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  item.tag,
                  style: TextStyle(color: tagColor(item.tag), fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 8),
              Text(item.desc, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 16)),
              SizedBox(height: 8),
              Text(item.contact, style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ],
    );
  }
} 