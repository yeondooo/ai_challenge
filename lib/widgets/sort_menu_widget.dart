import 'package:flutter/material.dart';
import '../models/filter.dart';

class SortMenuWidget extends StatelessWidget {
  final Function(SortOption) onSortChanged;

  const SortMenuWidget({super.key, required this.onSortChanged});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<SortOption>(
      onSelected: onSortChanged,
      itemBuilder:
          (context) =>
              SortOption.values.map((sort) {
                return PopupMenuItem(
                  value: sort,
                  child: Text(sort.displayName),
                );
              }).toList(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('정렬'),
            const SizedBox(width: 4),
            const Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }
}
