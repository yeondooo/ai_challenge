import 'package:flutter/material.dart';
import '../models/filter.dart';

class FilterButtonWidget extends StatelessWidget {
  final Function(Filter) onFilterChanged;

  const FilterButtonWidget({super.key, required this.onFilterChanged});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        _showFilterDialog(context);
      },
      icon: const Icon(Icons.filter_list),
      label: const Text('필터'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey.shade100,
        foregroundColor: Colors.black87,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('필터 설정'),
            content: const Text('필터 기능은 추후 구현 예정입니다.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('확인'),
              ),
            ],
          ),
    );
  }
}
