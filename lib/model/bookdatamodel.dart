class BookDataModel {
  int? page;
  int? numFound;
  List<ReadingLogEntries>? readingLogEntries;

  BookDataModel({this.page, this.numFound, this.readingLogEntries});

  BookDataModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    numFound = json['numFound'];
    if (json['reading_log_entries'] != null) {
      readingLogEntries = <ReadingLogEntries>[];
      json['reading_log_entries'].forEach((v) {
        readingLogEntries!.add(ReadingLogEntries.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    data['numFound'] = numFound;
    if (readingLogEntries != null) {
      data['reading_log_entries'] =
          readingLogEntries!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ReadingLogEntries {
  Work? work;
  String? loggedEdition;
  String? loggedDate;

  ReadingLogEntries({this.work, this.loggedEdition, this.loggedDate});

  ReadingLogEntries.fromJson(Map<String, dynamic> json) {
    work = json['work'] != null ? Work.fromJson(json['work']) : null;
    loggedEdition = json['logged_edition'];
    loggedDate = json['logged_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (work != null) {
      data['work'] = work!.toJson();
    }
    data['logged_edition'] = loggedEdition;
    data['logged_date'] = loggedDate;
    return data;
  }
}

class Work {
  bool? isRead;
  String? title;
  String? key;
  List? authorKeys;
  List? authorNames;
  int? firstPublishYear;
  String? lendingEditionS;
  List? editionKey;
  int? coverId;
  String? coverEditionKey;

  Work(
      {this.title,
      this.key,
      this.isRead,
      this.authorKeys,
      this.authorNames,
      this.firstPublishYear,
      this.lendingEditionS,
      this.editionKey,
      this.coverId,
      this.coverEditionKey});

  Work.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    key = json['key'];
    isRead = false;
    authorKeys = json['author_keys'];
    authorNames = json['author_names'];
    firstPublishYear = json['first_publish_year'];
    lendingEditionS = json['lending_edition_s'];
    editionKey = json['edition_key'];
    coverId = json['cover_id'];
    coverEditionKey = json['cover_edition_key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['key'] = key;
    data['author_keys'] = authorKeys;
    data['author_names'] = authorNames;
    data['first_publish_year'] = firstPublishYear;
    data['lending_edition_s'] = lendingEditionS;
    data['edition_key'] = editionKey;
    data['cover_id'] = coverId;
    data['cover_edition_key'] = coverEditionKey;
    return data;
  }
}
