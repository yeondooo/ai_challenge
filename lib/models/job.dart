class Job {
  final String id;
  final String title;
  final String companyName;
  final String companyLogo;
  final double rating;
  final Salary salary;
  final WorkSchedule workSchedule;
  final Location location;
  final List<String> requirements;
  final String description;
  final DateTime postedDate;
  final bool isImmediateApply;
  final JobStatus status;

  Job({
    required this.id,
    required this.title,
    required this.companyName,
    required this.companyLogo,
    required this.rating,
    required this.salary,
    required this.workSchedule,
    required this.location,
    required this.requirements,
    required this.description,
    required this.postedDate,
    required this.isImmediateApply,
    required this.status,
  });
}

class Salary {
  final double amount;
  final SalaryType type;
  final String currency;

  Salary({required this.amount, required this.type, required this.currency});
}

class WorkSchedule {
  final String workingDays;
  final String workingHours;
  final int weeklyHours;

  WorkSchedule({
    required this.workingDays,
    required this.workingHours,
    required this.weeklyHours,
  });
}

class Location {
  final String address;
  final double latitude;
  final double longitude;
  final String district;

  Location({
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.district,
  });
}

enum SalaryType { hourly, daily, monthly }

enum JobStatus { active, closed, expired }
