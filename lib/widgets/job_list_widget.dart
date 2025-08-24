import 'package:flutter/material.dart';
import '../models/job.dart';

class JobListWidget extends StatelessWidget {
  final List<Job> jobs;
  final VoidCallback onLoadMore;
  final bool hasReachedMax;

  const JobListWidget({
    super.key,
    required this.jobs,
    required this.onLoadMore,
    required this.hasReachedMax,
  });

  @override
  Widget build(BuildContext context) {
    if (jobs.isEmpty) {
      return const Center(child: Text('검색 결과가 없습니다.'));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: jobs.length + (hasReachedMax ? 0 : 1),
      itemBuilder: (context, index) {
        if (index == jobs.length) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: ElevatedButton(
                onPressed: onLoadMore,
                child: const Text('더 보기'),
              ),
            ),
          );
        }

        final job = jobs[index];
        return JobCard(job: job);
      },
    );
  }
}

class JobCard extends StatelessWidget {
  final Job job;

  const JobCard({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 회사 정보 및 평점
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(job.companyLogo),
                  radius: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        job.companyName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 16),
                          Text(' ${job.rating}'),
                        ],
                      ),
                    ],
                  ),
                ),
                if (job.isImmediateApply)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      '즉시지원',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 16),

            // 공고 제목
            Text(
              job.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            // 급여 정보
            Row(
              children: [
                Icon(Icons.attach_money, color: Colors.green, size: 20),
                const SizedBox(width: 8),
                Text(
                  '${job.salary.amount.toStringAsFixed(0)}원/${_getSalaryTypeText(job.salary.type)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // 근무 조건
            Row(
              children: [
                Icon(Icons.access_time, color: Colors.grey, size: 20),
                const SizedBox(width: 8),
                Text(
                  '${job.workSchedule.workingDays} ${job.workSchedule.workingHours}',
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // 근무 지역
            Row(
              children: [
                Icon(Icons.location_on, color: Colors.grey, size: 20),
                const SizedBox(width: 8),
                Text(
                  job.location.district,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // 지원 버튼
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // 지원 로직 (추후 구현)
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('지원 기능은 추후 구현 예정입니다.')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text('지원하기'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getSalaryTypeText(SalaryType type) {
    switch (type) {
      case SalaryType.hourly:
        return '시급';
      case SalaryType.daily:
        return '일급';
      case SalaryType.monthly:
        return '월급';
    }
  }
}
