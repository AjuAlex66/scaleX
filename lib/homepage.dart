import 'package:bookapp/bloc/mainbloc.dart';
import 'package:bookapp/utils/changerclass.dart';
import 'package:bookapp/utils/helperclass.dart';
import 'package:bookapp/utils/initializerclass.dart';
import 'package:bookapp/utils/miscclass.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController? controller = TextEditingController();
  bool canPop = false;

  DateTime? currentBackPressTime;
  @override
  void initState() {
    FlutterNativeSplash.remove();
    context.read<MainBloc>().add(FetchBookData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: const Text('ScaleX Book Library'),
          ),
          body: DoubleBackToCloseApp(
            snackBar: const SnackBar(
              content: Text('Tap back again to leave'),
            ),
            child: Column(
              children: [
                Helper.allowHeight(10),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        searchBar(),
                        searchResultsCount(),
                      ],
                    )),
                BlocBuilder<MainBloc, MainState>(
                  buildWhen: (previous, current) =>
                      current is LoadingBookData ||
                      current is BookDataFetched ||
                      current is BookDataNotFound ||
                      current is BookDataNotFetched ||
                      current is SearhcingBooks ||
                      current is BooksFound ||
                      current is BooksNotFound ||
                      current is NoSearch ||
                      current is SearhcingBooksFailed,
                  builder: (context, state) => state is SearhcingBooks
                      ? Helper.showWaiting()
                      : state is BooksFound
                          ? Expanded(
                              child: Scrollbar(
                                thumbVisibility: true,
                                child: ListView.separated(
                                    padding: const EdgeInsets.all(14.0),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) =>
                                        searchListView(index),
                                    separatorBuilder: (context, index) =>
                                        Helper.allowHeight(15),
                                    itemCount: Initializer
                                        .bookSearchModel!.docs!.length),
                              ),
                            )
                          : state is BooksNotFound
                              ? Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Helper.allowHeight(Helper.height / 12),
                                    const Icon(Icons.menu_book_rounded,
                                        size: 90, color: Colors.grey),
                                    Helper.allowHeight(10),
                                    const Text("No results found",
                                        textAlign: TextAlign.center),
                                  ],
                                )
                              : state is LoadingBookData &&
                                      Misc.isEmpty(Initializer
                                          .bookDataModel!.readingLogEntries)
                                  ? Helper.showWaiting()
                                  : state is BookDataFetched ||
                                          state is NoSearch ||
                                          !Misc.isEmpty(Initializer
                                              .bookDataModel!.readingLogEntries)
                                      ? Expanded(
                                          child: Scrollbar(
                                            thumbVisibility: true,
                                            child: ListView.separated(
                                                padding:
                                                    const EdgeInsets.all(14.0),
                                                shrinkWrap: true,
                                                itemBuilder: (context, index) =>
                                                    allBooksView(index),
                                                separatorBuilder:
                                                    (context, index) =>
                                                        Helper.allowHeight(15),
                                                itemCount: Initializer
                                                    .bookDataModel!
                                                    .readingLogEntries!
                                                    .length),
                                          ),
                                        )
                                      : state is BookDataNotFound
                                          ? const Center(
                                              child: Text("No data found"),
                                            )
                                          : const Center(
                                              child:
                                                  Text('Something went wrong'),
                                            ),
                ),
              ],
            ),
          )),
    );
  }

  String getAuthorNames(list) {
    String names = "";
    if (!Misc.isEmpty(list)) {
      for (var e in list) {
        if (names != "") {
          names = '$names, $e';
        } else {
          names = e;
        }
      }
    } else {
      names = "Authors - N/A";
    }

    return names;
  }

  Widget searchResultsCount() => BlocBuilder<MainBloc, MainState>(
        buildWhen: (previous, current) =>
            current is NoSearch ||
            current is BooksFound ||
            current is BooksNotFound,
        builder: (context, state) => state is BooksFound
            ? Align(
                alignment: Alignment.bottomLeft,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Helper.allowHeight(10.0),
                    Text(
                      "${Initializer.bookSearchModel!.numFound!} results found related to '${state.query}'",
                    ),
                    Helper.allowHeight(5.0),
                  ],
                ),
              )
            : Helper.shrink(),
      );

  Widget searchBar() => TextFormField(
      textCapitalization: TextCapitalization.words,
      controller: controller,
      textInputAction: TextInputAction.search,
      onChanged: (value) {
        if (Misc.isEmpty(value)) {
          context.read<MainBloc>().add(SearchBooks(query: value));
        }
      },
      onFieldSubmitted: (value) =>
          context.read<MainBloc>().add(SearchBooks(query: value)),
      decoration: InputDecoration(
        hintStyle: const TextStyle(fontWeight: FontWeight.bold),
        suffixIcon: InkWell(
            onTap: () {
              context.read<MainBloc>().add(SearchBooks(query: ''));
              controller!.clear();
            },
            child: const Icon(Icons.close)),
        prefixIcon: const Icon(Icons.menu_book_rounded),
        hintText: "Search for books",
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        )),
      ));

  Widget searchListView(int index) => Container(
        padding: const EdgeInsets.all(14),
        width: Helper.width,
        height: Helper.height / 4,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 0.2,
              blurRadius: 2,
            )
          ],
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              child: CachedNetworkImage(
                  errorWidget: (context, url, error) =>
                      const Center(child: Icon(Icons.error)),
                  progressIndicatorBuilder: (context, url, progress) =>
                      const Center(child: CupertinoActivityIndicator()),
                  width: Helper.width / 3,
                  fit: BoxFit.contain,
                  imageUrl:
                      'https://covers.openlibrary.org/b/id/${Initializer.bookSearchModel!.docs![index].coverI}-M.jpg'),
            ),
            Helper.allowWidth(10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          Initializer.bookSearchModel!.docs![index].title!,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                        Helper.allowHeight(5),
                        Text(
                            getAuthorNames(Initializer
                                .bookSearchModel!.docs![index].authorName),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2),
                        Helper.allowHeight(5),
                        Text(
                            // "Published - ${Helper.setDateFormat(dateTime: DateTime.parse(Initializer.bookDataModel!.readingLogEntries![index].loggedDate!))}"),
                            "Published year - ${Initializer.bookSearchModel!.docs![index].publishYear!.first}")
                      ],
                    ),
                  ),
                  Consumer<Changer>(
                    builder: (context, value, child) => MaterialButton(
                      shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: Initializer
                                      .bookSearchModel!.docs![index].isRead!
                                  ? Colors.black
                                  : Colors.transparent),
                          borderRadius: BorderRadius.circular(30.0)),
                      color: Initializer.bookSearchModel!.docs![index].isRead!
                          ? Colors.white
                          : Colors.green,
                      minWidth: Helper.width,
                      onPressed: () async {
                        Initializer.bookSearchModel!.docs![index].isRead!
                            ? Initializer.bookSearchModel!.docs![index].isRead =
                                false
                            : Initializer.bookSearchModel!.docs![index].isRead =
                                true;
                        context.read<Changer>().justChange();
                        await Helper.showInfo();
                      },
                      child: Text(
                        Initializer.bookSearchModel!.docs![index].isRead!
                            ? "Unread"
                            : "Read",
                        style: TextStyle(
                          color:
                              Initializer.bookSearchModel!.docs![index].isRead!
                                  ? Colors.black
                                  : Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );

  Widget allBooksView(int index) => Container(
        padding: const EdgeInsets.all(14),
        width: Helper.width,
        height: Helper.height / 4,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 0.2,
              blurRadius: 2,
            )
          ],
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              child: CachedNetworkImage(
                  errorWidget: (context, url, error) =>
                      const Center(child: Icon(Icons.error)),
                  progressIndicatorBuilder: (context, url, progress) =>
                      const Center(child: CupertinoActivityIndicator()),
                  width: Helper.width / 3,
                  fit: BoxFit.contain,
                  imageUrl:
                      'https://covers.openlibrary.org/b/id/${Initializer.bookDataModel!.readingLogEntries![index].work!.coverId}-M.jpg'),
            ),
            Helper.allowWidth(10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          Initializer.bookDataModel!.readingLogEntries![index]
                              .work!.title!,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                        Helper.allowHeight(5),
                        Text(
                            getAuthorNames(Initializer.bookDataModel!
                                .readingLogEntries![index].work!.authorNames!),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2),
                        Helper.allowHeight(5),
                        Text(
                            // "Published - ${Helper.setDateFormat(dateTime: DateTime.parse(Initializer.bookDataModel!.readingLogEntries![index].loggedDate!))}"),
                            "Published year - ${Initializer.bookDataModel!.readingLogEntries![index].work!.firstPublishYear}")
                      ],
                    ),
                  ),
                  Consumer<Changer>(
                    builder: (context, value, child) => MaterialButton(
                      shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: Initializer.bookDataModel!
                                      .readingLogEntries![index].work!.isRead!
                                  ? Colors.black
                                  : Colors.transparent),
                          borderRadius: BorderRadius.circular(30.0)),
                      color: Initializer.bookDataModel!
                              .readingLogEntries![index].work!.isRead!
                          ? Colors.white
                          : Colors.green,
                      minWidth: Helper.width,
                      onPressed: () async {
                        Initializer.bookDataModel!.readingLogEntries![index]
                                .work!.isRead!
                            ? Initializer.bookDataModel!
                                .readingLogEntries![index].work!.isRead = false
                            : Initializer.bookDataModel!
                                .readingLogEntries![index].work!.isRead = true;
                        context.read<Changer>().justChange();
                        await Helper.showInfo();
                      },
                      child: Text(
                        Initializer.bookDataModel!.readingLogEntries![index]
                                .work!.isRead!
                            ? "Unread"
                            : "Read",
                        style: TextStyle(
                          color: Initializer.bookDataModel!
                                  .readingLogEntries![index].work!.isRead!
                              ? Colors.black
                              : Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
}
