class Filter {
  final String? keyword;
  final List<String>? categories;
  final List<String>? districts;
  final SalaryRange? salaryRange;
  final WorkTimeRange? workTimeRange;
  final List<String>? workDays;
  final bool? immediateApply;
  final double? minRating;

  const Filter({
    this.keyword,
    this.categories,
    this.districts,
    this.salaryRange,
    this.workTimeRange,
    this.workDays,
    this.immediateApply,
    this.minRating,
  });

  Filter copyWith({
    String? keyword,
    List<String>? categories,
    List<String>? districts,
    SalaryRange? salaryRange,
    WorkTimeRange? workTimeRange,
    List<String>? workDays,
    bool? immediateApply,
    double? minRating,
  }) {
    return Filter(
      keyword: keyword ?? this.keyword,
      categories: categories ?? this.categories,
      districts: districts ?? this.districts,
      salaryRange: salaryRange ?? this.salaryRange,
      workTimeRange: workTimeRange ?? this.workTimeRange,
      workDays: workDays ?? this.workDays,
      immediateApply: immediateApply ?? this.immediateApply,
      minRating: minRating ?? this.minRating,
    );
  }
}

class SalaryRange {
  final double? min;
  final double? max;

  const SalaryRange({this.min, this.max});
}

class WorkTimeRange {
  final int? minHours;
  final int? maxHours;

  const WorkTimeRange({this.minHours, this.maxHours});
}

enum SortOption {
  latest, // 최신순
  salary, // 급여순
  distance, // 거리순
  rating, // 평점순
  popularity, // 인기순
}

extension SortOptionExtension on SortOption {
  String get displayName {
    switch (this) {
      case SortOption.latest:
        return '최신순';
      case SortOption.salary:
        return '급여순';
      case SortOption.distance:
        return '거리순';
      case SortOption.rating:
        return '평점순';
      case SortOption.popularity:
        return '인기순';
    }
  }
}
