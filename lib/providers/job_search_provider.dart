import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/job.dart';
import '../models/filter.dart';
import '../data/dummy_data.dart';

part 'job_search_provider.g.dart';

class JobSearchState {
  final List<Job> jobs;
  final Filter currentFilter;
  final SortOption currentSort;
  final bool isLoading;
  final String? error;
  final bool hasReachedMax;
  final int currentPage;

  const JobSearchState({
    this.jobs = const [],
    this.currentFilter = const Filter(),
    this.currentSort = SortOption.latest,
    this.isLoading = false,
    this.error,
    this.hasReachedMax = false,
    this.currentPage = 1,
  });

  JobSearchState copyWith({
    List<Job>? jobs,
    Filter? currentFilter,
    SortOption? currentSort,
    bool? isLoading,
    String? error,
    bool? hasReachedMax,
    int? currentPage,
  }) {
    return JobSearchState(
      jobs: jobs ?? this.jobs,
      currentFilter: currentFilter ?? this.currentFilter,
      currentSort: currentSort ?? this.currentSort,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}

@riverpod
class JobSearchNotifier extends _$JobSearchNotifier {
  @override
  JobSearchState build() {
    return const JobSearchState();
  }

  Future<void> searchJobs({
    String? keyword,
    Filter? filter,
    SortOption? sort,
    bool isRefresh = false,
  }) async {
    if (isRefresh) {
      state = state.copyWith(currentPage: 1, hasReachedMax: false, jobs: []);
    }

    state = state.copyWith(isLoading: true, error: null);

    // 더미 데이터 사용 (실제로는 API 호출)
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      List<Job> newJobs = dummyJobs;

      // 키워드 필터링
      if (keyword != null && keyword.isNotEmpty) {
        newJobs =
            newJobs
                .where(
                  (job) =>
                      job.title.toLowerCase().contains(keyword.toLowerCase()) ||
                      job.companyName.toLowerCase().contains(
                        keyword.toLowerCase(),
                      ),
                )
                .toList();
      }

      // 정렬 적용
      newJobs = _sortJobs(newJobs, sort ?? state.currentSort);

      if (isRefresh) {
        state = state.copyWith(jobs: newJobs, currentPage: 1, isLoading: false);
      } else {
        state = state.copyWith(
          jobs: [...state.jobs, ...newJobs],
          currentPage: state.currentPage + 1,
          isLoading: false,
          hasReachedMax: newJobs.isEmpty,
        );
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  List<Job> _sortJobs(List<Job> jobs, SortOption sort) {
    switch (sort) {
      case SortOption.latest:
        jobs.sort((a, b) => b.postedDate.compareTo(a.postedDate));
        break;
      case SortOption.salary:
        jobs.sort((a, b) => b.salary.amount.compareTo(a.salary.amount));
        break;
      case SortOption.rating:
        jobs.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case SortOption.distance:
        // 거리 정렬 로직 (더미 데이터에서는 기본 정렬)
        break;
      case SortOption.popularity:
        // 인기도 정렬 로직 (더미 데이터에서는 기본 정렬)
        break;
    }
    return jobs;
  }

  void updateFilter(Filter filter) {
    state = state.copyWith(currentFilter: filter);
    searchJobs(filter: filter, isRefresh: true);
  }

  void updateSort(SortOption sort) {
    state = state.copyWith(currentSort: sort);
    searchJobs(sort: sort, isRefresh: true);
  }
}
