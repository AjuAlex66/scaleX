class BookSearchModel {
  int? numFound;
  int? start;
  bool? numFoundExact;
  List<Docs>? docs;
  String? q;
  Null offset;

  BookSearchModel(
      {this.numFound,
      this.start,
      this.numFoundExact,
      this.docs,
      this.q,
      this.offset});

  BookSearchModel.fromJson(Map<String, dynamic> json) {
    numFound = json['numFound'];
    start = json['start'];
    numFoundExact = json['numFoundExact'];
    if (json['docs'] != null) {
      docs = <Docs>[];
      json['docs'].forEach((v) {
        docs!.add(Docs.fromJson(v));
      });
    }
    numFound = json['num_found'];
    q = json['q'];
    offset = json['offset'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['numFound'] = numFound;
    data['start'] = start;
    data['numFoundExact'] = numFoundExact;
    if (docs != null) {
      data['docs'] = docs!.map((v) => v.toJson()).toList();
    }
    data['num_found'] = numFound;
    data['q'] = q;
    data['offset'] = offset;
    return data;
  }
}

class Docs {
  List? authorAlternativeName;
  List? authorKey;
  List? authorName;
  List? contributor;
  String? coverEditionKey;
  bool? isRead;
  int? coverI;
  String? ebookAccess;
  int? ebookCountI;
  int? editionCount;
  List? editionKey;
  int? firstPublishYear;
  List? format;
  bool? hasFulltext;
  List? ia;
  List? iaCollection;
  String? iaCollectionS;
  List? isbn;
  String? key;
  List? language;
  int? lastModifiedI;
  List? lcc;
  List? lccn;
  int? numberOfPagesMedian;
  List? oclc;
  int? ospCount;
  String? printdisabledS;
  bool? publicScanB;
  List? publishDate;
  List? publishPlace;
  List? publishYear;
  List? publisher;
  List? seed;
  String? subtitle;
  String? title;
  String? titleSuggest;
  String? titleSort;
  String? type;
  List? idGoodreads;
  List? idLibrarything;
  List? idOverdrive;
  List? idAmazon;
  List? subject;
  List? iaLoadedId;
  List? iaBoxId;
  int? ratingsCount1;
  int? ratingsCount2;
  int? ratingsCount3;
  int? ratingsCount4;
  int? ratingsCount5;
  double? ratingsAverage;
  double? ratingsSortable;
  int? ratingsCount;
  int? readinglogCount;
  int? wantToReadCount;
  int? currentlyReadingCount;
  int? alreadyReadCount;
  List? publisherFacet;
  List? subjectFacet;
  int? iVersion;
  String? lccSort;
  List? authorFacet;
  List? subjectKey;
  List? idWikidata;
  List? ddc;
  List? person;
  List? personKey;
  List? personFacet;
  String? ddcSort;

  Docs(
      {this.authorAlternativeName,
      this.authorKey,
      this.authorName,
      this.contributor,
      this.isRead,
      this.coverEditionKey,
      this.coverI,
      this.ebookAccess,
      this.ebookCountI,
      this.editionCount,
      this.editionKey,
      this.firstPublishYear,
      this.format,
      this.hasFulltext,
      this.ia,
      this.iaCollection,
      this.iaCollectionS,
      this.isbn,
      this.key,
      this.language,
      this.lastModifiedI,
      this.lcc,
      this.lccn,
      this.numberOfPagesMedian,
      this.oclc,
      this.ospCount,
      this.printdisabledS,
      this.publicScanB,
      this.publishDate,
      this.publishPlace,
      this.publishYear,
      this.publisher,
      this.seed,
      this.subtitle,
      this.title,
      this.titleSuggest,
      this.titleSort,
      this.type,
      this.idGoodreads,
      this.idLibrarything,
      this.idOverdrive,
      this.idAmazon,
      this.subject,
      this.iaLoadedId,
      this.iaBoxId,
      this.ratingsCount1,
      this.ratingsCount2,
      this.ratingsCount3,
      this.ratingsCount4,
      this.ratingsCount5,
      this.ratingsAverage,
      this.ratingsSortable,
      this.ratingsCount,
      this.readinglogCount,
      this.wantToReadCount,
      this.currentlyReadingCount,
      this.alreadyReadCount,
      this.publisherFacet,
      this.subjectFacet,
      this.iVersion,
      this.lccSort,
      this.authorFacet,
      this.subjectKey,
      this.idWikidata,
      this.ddc,
      this.person,
      this.personKey,
      this.personFacet,
      this.ddcSort});

  Docs.fromJson(Map<String, dynamic> json) {
    authorAlternativeName = json['author_alternative_name'];
    authorKey = json['author_key'];
    authorName = json['author_name'];
    isRead = false;
    contributor = json['contributor'];
    coverEditionKey = json['cover_edition_key'];
    coverI = json['cover_i'];
    ebookAccess = json['ebook_access'];
    ebookCountI = json['ebook_count_i'];
    editionCount = json['edition_count'];
    editionKey = json['edition_key'];
    firstPublishYear = json['first_publish_year'];
    format = json['format'];
    hasFulltext = json['has_fulltext'];
    ia = json['ia'];
    iaCollection = json['ia_collection'];
    iaCollectionS = json['ia_collection_s'];
    isbn = json['isbn'];
    key = json['key'];
    language = json['language'];
    lastModifiedI = json['last_modified_i'];
    lcc = json['lcc'];
    lccn = json['lccn'];
    numberOfPagesMedian = json['number_of_pages_median'];
    oclc = json['oclc'];
    ospCount = json['osp_count'];
    printdisabledS = json['printdisabled_s'];
    publicScanB = json['public_scan_b'];
    publishDate = json['publish_date'];
    publishPlace = json['publish_place'];
    if (json['publish_year'] != null) {
      publishYear = json['publish_year'];
    } else {
      publishYear = ['N/A'];
    }

    publisher = json['publisher'];
    seed = json['seed'];
    subtitle = json['subtitle'];
    title = json['title'];
    titleSuggest = json['title_suggest'];
    titleSort = json['title_sort'];
    type = json['type'];
    idGoodreads = json['id_goodreads'];
    idLibrarything = json['id_librarything'];
    idOverdrive = json['id_overdrive'];
    idAmazon = json['id_amazon'];
    subject = json['subject'];
    iaLoadedId = json['ia_loaded_id'];
    iaBoxId = json['ia_box_id'];
    ratingsCount1 = json['ratings_count_1'];
    ratingsCount2 = json['ratings_count_2'];
    ratingsCount3 = json['ratings_count_3'];
    ratingsCount4 = json['ratings_count_4'];
    ratingsCount5 = json['ratings_count_5'];
    ratingsAverage = json['ratings_average'];
    ratingsSortable = json['ratings_sortable'];
    ratingsCount = json['ratings_count'];
    readinglogCount = json['readinglog_count'];
    wantToReadCount = json['want_to_read_count'];
    currentlyReadingCount = json['currently_reading_count'];
    alreadyReadCount = json['already_read_count'];
    publisherFacet = json['publisher_facet'];
    subjectFacet = json['subject_facet'];
    iVersion = json['_version_'];
    lccSort = json['lcc_sort'];
    authorFacet = json['author_facet'];
    subjectKey = json['subject_key'];
    idWikidata = json['id_wikidata'];
    ddc = json['ddc'];
    person = json['person'];
    personKey = json['person_key'];
    personFacet = json['person_facet'];
    ddcSort = json['ddc_sort'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['author_alternative_name'] = authorAlternativeName;
    data['author_key'] = authorKey;
    data['author_name'] = authorName;
    data['contributor'] = contributor;
    data['cover_edition_key'] = coverEditionKey;
    data['cover_i'] = coverI;
    data['ebook_access'] = ebookAccess;
    data['ebook_count_i'] = ebookCountI;
    data['edition_count'] = editionCount;
    data['edition_key'] = editionKey;
    data['first_publish_year'] = firstPublishYear;
    data['format'] = format;
    data['has_fulltext'] = hasFulltext;
    data['ia'] = ia;
    data['ia_collection'] = iaCollection;
    data['ia_collection_s'] = iaCollectionS;
    data['isbn'] = isbn;
    data['key'] = key;
    data['language'] = language;
    data['last_modified_i'] = lastModifiedI;
    data['lcc'] = lcc;
    data['lccn'] = lccn;
    data['number_of_pages_median'] = numberOfPagesMedian;
    data['oclc'] = oclc;
    data['osp_count'] = ospCount;
    data['printdisabled_s'] = printdisabledS;
    data['public_scan_b'] = publicScanB;
    data['publish_date'] = publishDate;
    data['publish_place'] = publishPlace;
    data['publish_year'] = publishYear;
    data['publisher'] = publisher;
    data['seed'] = seed;
    data['subtitle'] = subtitle;
    data['title'] = title;
    data['title_suggest'] = titleSuggest;
    data['title_sort'] = titleSort;
    data['type'] = type;
    data['id_goodreads'] = idGoodreads;
    data['id_librarything'] = idLibrarything;
    data['id_overdrive'] = idOverdrive;
    data['id_amazon'] = idAmazon;
    data['subject'] = subject;
    data['ia_loaded_id'] = iaLoadedId;
    data['ia_box_id'] = iaBoxId;
    data['ratings_count_1'] = ratingsCount1;
    data['ratings_count_2'] = ratingsCount2;
    data['ratings_count_3'] = ratingsCount3;
    data['ratings_count_4'] = ratingsCount4;
    data['ratings_count_5'] = ratingsCount5;
    data['ratings_average'] = ratingsAverage;
    data['ratings_sortable'] = ratingsSortable;
    data['ratings_count'] = ratingsCount;
    data['readinglog_count'] = readinglogCount;
    data['want_to_read_count'] = wantToReadCount;
    data['currently_reading_count'] = currentlyReadingCount;
    data['already_read_count'] = alreadyReadCount;
    data['publisher_facet'] = publisherFacet;
    data['subject_facet'] = subjectFacet;
    data['_version_'] = iVersion;
    data['lcc_sort'] = lccSort;
    data['author_facet'] = authorFacet;
    data['subject_key'] = subjectKey;
    data['id_wikidata'] = idWikidata;
    data['ddc'] = ddc;
    data['person'] = person;
    data['person_key'] = personKey;
    data['person_facet'] = personFacet;
    data['ddc_sort'] = ddcSort;
    return data;
  }
}
