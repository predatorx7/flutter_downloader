/// Defines a set of possible statuses of a download task.
class DownloadTaskStatus {
  final int _value;

  const DownloadTaskStatus(int value) : _value = value;

  int get value => _value;

  static DownloadTaskStatus from(int value) => DownloadTaskStatus(value);

  static const undefined = DownloadTaskStatus(0);
  static const enqueued = DownloadTaskStatus(1);
  static const running = DownloadTaskStatus(2);
  static const complete = DownloadTaskStatus(3);
  static const failed = DownloadTaskStatus(4);
  static const canceled = DownloadTaskStatus(5);
  static const paused = DownloadTaskStatus(6);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DownloadTaskStatus && other._value == _value;
  }

  @override
  int get hashCode => _value.hashCode;

  @override
  String toString() => 'DownloadTaskStatus($_value)';
}

/// Encapsulates all information of a single download task.
///
/// This is also the structure of the record saved in the SQLite database.
class DownloadTask {
  /// Unique identifier of this task.
  final String taskId;

  /// Status of this task.
  final DownloadTaskStatus status;

  /// Progress between 0 (inclusive) and 100 (inclusive).
  final int progress;

  /// URL from which the file is downloaded.
  final String url;

  /// Local file name of the downloaded file.
  final String? filename;

  /// The label for this download. (Only used on Android.)
  final String? label;

  /// Absolute path to the directory where the downloaded file will saved.
  final String savedDir;

  /// Timestamp when the task was created.
  final int timeCreated;

  DownloadTask({
    required this.taskId,
    required this.status,
    required this.progress,
    required this.url,
    required this.filename,
    required this.label,
    required this.savedDir,
    required this.timeCreated,
  });

  @override
  String toString() =>
      "DownloadTask(taskId: $taskId, status: $status, progress: $progress, url: $url, filename: $filename, label: $label, savedDir: $savedDir, timeCreated: $timeCreated)";

  factory DownloadTask.fromMap(dynamic item) {
    return DownloadTask(
      taskId: item['task_id'],
      status: DownloadTaskStatus(item['status']),
      progress: item['progress'],
      label: item['label'],
      url: item['url'],
      filename: item['file_name'],
      savedDir: item['saved_dir'],
      timeCreated: item['time_created'],
    );
  }
}
