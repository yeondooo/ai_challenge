import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/job_search_provider.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/filter_button_widget.dart';
import '../widgets/sort_menu_widget.dart';
import '../widgets/job_list_widget.dart';

class JobSearchScreen extends ConsumerStatefulWidget {
  const JobSearchScreen({super.key});

  @override
  ConsumerState<JobSearchScreen> createState() => _JobSearchScreenState();
}

class _JobSearchScreenState extends ConsumerState<JobSearchScreen> {
  @override
  void initState() {
    super.initState();
    // 초기 검색 실행
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(jobSearchNotifierProvider.notifier).searchJobs(isRefresh: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final searchState = ref.watch(jobSearchNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('알바 찾기'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Column(
        children: [
          // 검색바
          SearchBarWidget(
            onSearch: (keyword) {
              ref
                  .read(jobSearchNotifierProvider.notifier)
                  .searchJobs(keyword: keyword, isRefresh: true);
            },
          ),

          // 필터 및 정렬 영역
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
            ),
            child: Row(
              children: [
                // 필터 버튼
                Expanded(
                  child: FilterButtonWidget(
                    onFilterChanged: (filter) {
                      ref
                          .read(jobSearchNotifierProvider.notifier)
                          .updateFilter(filter);
                    },
                  ),
                ),
                const SizedBox(width: 16),
                // 정렬 메뉴
                SortMenuWidget(
                  onSortChanged: (sort) {
                    ref
                        .read(jobSearchNotifierProvider.notifier)
                        .updateSort(sort);
                  },
                ),
              ],
            ),
          ),

          // 검색 결과 목록
          Expanded(
            child:
                searchState.isLoading && searchState.jobs.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : searchState.error != null
                    ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('오류가 발생했습니다: ${searchState.error}'),
                          ElevatedButton(
                            onPressed: () {
                              ref
                                  .read(jobSearchNotifierProvider.notifier)
                                  .searchJobs(isRefresh: true);
                            },
                            child: const Text('다시 시도'),
                          ),
                        ],
                      ),
                    )
                    : JobListWidget(
                      jobs: searchState.jobs,
                      onLoadMore: () {
                        ref
                            .read(jobSearchNotifierProvider.notifier)
                            .searchJobs();
                      },
                      hasReachedMax: searchState.hasReachedMax,
                    ),
          ),
        ],
      ),
    );
  }
}
