import 'dart:async';
import 'dart:convert';
import 'dart:developer';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class ServerHelper4466 {
//  static Future<bool> isInternetConnectionGood() async {
//     try {
//       var response = await http.get(
//         Uri.parse('${ServerHelper4466.ip}/health'),
//         headers: {"Content-Type": "application/json", "x-auth-token": ""},
//       );
//       if (response.statusCode == 200) {
//         return true;
//       } else {
//         return false;
//       }

//       // bool trustSelfSigned = true;
//       // HttpClient httpClient = HttpClient()
//       //   ..badCertificateCallback =
//       //       ((X509Certificate cert, String host, int port) => trustSelfSigned);
//       // IOClient ioClient = IOClient(httpClient);

//       // final Stopwatch stopwatch = Stopwatch()..start();
//       // final response = await ioClient
//       //     .get(Uri.parse(ip!))
//       //     .timeout(const Duration(seconds: 10));
//       // stopwatch.stop();
//       // if (response.statusCode == 200) {
//       //   return true;
//       // } else {
//       //   return false;
//       // }
//     } catch (e) {
//       log('checking connection error $e');
//       return false;
//     }
//   }

//   static Future<dynamic> post(String url, Map data) async {
//     // var token = await Preferene6644.getToken();
//     // log(token ?? "");
//     log('${ip! + url} -- $data');
//     var body = json.encode(data);
//     dynamic response;
//     try {
//       // bool trustSelfSigned = true;
//       // HttpClient httpClient = HttpClient()
//       //   ..badCertificateCallback =
//       //       ((X509Certificate cert, String host, int port) => trustSelfSigned);
//       // IOClient ioClient = IOClient(httpClient);
//       response = await http
//           .post(Uri.parse(ip! + url),
//               headers: {
//                 "Content-Type": "application/json",
//                 // "x-auth-token": token ?? ""
//                 "x-auth-token": ""
//               },
//               body: body)
//           .timeout(const Duration(seconds: 20));

//       if (response.statusCode == 200) {
//         Helper.showLog(response.body);
//         return jsonDecode(response.body);
//         // if (jsonDecode(response.body)['msg']
//         //     .contains("Your session has expired")) {
//         //   // await expireCall.makeExpire();
//         //   return {"status": false, "msg": "expired"};
//         // } else {

//         // }
//       } else {
//         var error = {
//           "status": false,
//           "msg": "${response.statusCode} - ${response.reasonPhrase}"
//         };
//         return error;
//       }
//     } on Exception catch (e) {
//       log(e.toString());
//       // Helper.showToast(msg: e.toString());
//       // throw NoHostException();
//     }
//   }

  static Future<dynamic> get(String url) async {
    try {
      // var token = await Preferene6644.getToken();
      // bool trustSelfSigned = true;
      // HttpClient httpClient = HttpClient()
      //   ..badCertificateCallback =
      //       ((X509Certificate cert, String host, int port) => trustSelfSigned);
      // IOClient ioClient = IOClient(httpClient);
      var response = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          // "x-auth-token": token ?? ""
          "x-auth-token": ""
        },
      );
      // log(ip! + url);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
        // if (jsonDecode(response.body)['msg']
        //     .contains("Your session has expired")) {
        //   // await expireCall.makeExpire();
        //   return {"status": false, "msg": "expired"};
        // } else {
        //   return response.body;
        // }
      } else {
        var error = {
          "status": false,
          "msg": "${response.statusCode} - ${response.reasonPhrase}"
        };
        return error;
      }
    } on Exception catch (e) {
      // Helper.showToast(msg: e.toString());
      log(e.toString());
      // throw NoHostException();
    }
  }

  // static Future<dynamic> getDownload(String url) async {
  //   try {
  //     // var token = await Preferene6644.getToken();
  //     // bool trustSelfSigned = true;
  //     // HttpClient httpClient = HttpClient()
  //     //   ..badCertificateCallback =
  //     //       ((X509Certificate cert, String host, int port) => trustSelfSigned);
  //     // IOClient ioClient = IOClient(httpClient);
  //     var response = await http.get(
  //       Uri.parse(ip! + url),
  //       headers: {
  //         "Content-Type": "application/json",
  //         // "x-auth-token": token ?? ""
  //         "x-auth-token": ""
  //       },
  //     );
  //     log(ip! + url);
  //     if (response.statusCode == 200) {
  //       return response.bodyBytes;
  //     } else {
  //       // var error = {
  //       //   "status": false,
  //       //   "msg": "${response.statusCode} - ${response.reasonPhrase}"
  //       // };
  //       // return error;
  //       return null;
  //     }
  //   } on Exception catch (e) {
  //     // Helper.showToast(msg: e.toString());
  //     log(e.toString());
  //     // throw NoHostException();
  //   }
  // }

  // static authenticateGet(String url) async {
  //   try {

  //     // bool trustSelfSigned = true;
  //     // HttpClient httpClient = HttpClient()
  //     //   ..badCertificateCallback =
  //     //       ((X509Certificate cert, String host, int port) => trustSelfSigned);
  //     // IOClient ioClient = IOClient(httpClient);
  //     var response = await http.get(
  //       Uri.parse(ip! + '/attendance/authenticate'),
  //       headers: {
  //         "Content-Type": "application/json",
  //          // "x-auth-token": token ?? ""
  //     "x-auth-token":  ""
  //       },
  //     );
  //     log(ip! + '/attendance/authenticate');
  //     if (response.statusCode == 200) {
  //       if (jsonDecode(response.body)['status']) {
  //         return get(url);
  //       } else {
  //         // BuildContext context = Helper.getContext();
  //         // context.read<AuthBloc>().add(DoLogout());
  //         var error = {"status": false, "msg": "expired"};
  //         return error;
  //       }
  //     } else {
  //       var error = {
  //         "status": false,
  //         "msg": "${response.statusCode} - ${response.reasonPhrase}"
  //       };
  //       return error;
  //     }
  //   } on Exception catch (e) {
  //     Helper.showLog("AuthenticationError $e");
  //   }
  // }

  // static authenticatePost(String url, Map<dynamic, dynamic> data) async {
  //   try {
  //     var token = await Preferene6644.getToken();
  //     // bool trustSelfSigned = true;
  //     // HttpClient httpClient = HttpClient()
  //     //   ..badCertificateCallback =
  //     //       ((X509Certificate cert, String host, int port) => trustSelfSigned);
  //     // IOClient ioClient = IOClient(httpClient);
  //     var response = await http.get(
  //       Uri.parse(ip! + '/attendance/authenticate'),
  //       headers: {
  //         "Content-Type": "application/json",
  //         "x-auth-token": token ?? ""
  //       },
  //     );
  //     if (response.statusCode == 200) {
  //       if (jsonDecode(response.body)['status']) {
  //         return post(url, data);
  //       } else {
  //         BuildContext context = Helper.getContext();
  //         context.read<AuthBloc>().add(DoLogout());
  //         var error = {"status": false, "msg": "expired"};
  //         return error;
  //       }
  //     } else {
  //       var error = {
  //         "status": false,
  //         "msg": "${response.statusCode} - ${response.reasonPhrase}"
  //       };
  //       return error;
  //     }
  //   } on Exception catch (e) {
  //     Helper.showLog("AuthenticationError $e");
  //   }
  // }

  // static uploadMulipleFilesWithStream(dynamic route, List<PlatformFile> files,
  //     String? name, Map<String, String>? data) async {
  //   var token = await LocalStorage.getToken();
  //   Map<String, String> headers = {
  //     "Content-Type": "application/json",
  //     "token": token ?? ""
  //   };
  //   var uri = Uri.parse(ip! + route);
  //   http.MultipartFile multipartFile;
  // }

  // static uploadMulipleFiles(dynamic route, List<PlatformFile> files,
  //     String? name, Map<String, String>? data) async {
  //   try {
  //     var token = await LocalStorage.getToken();
  //     Map<String, String> headers = {
  //       "Content-Type": "application/json",
  //       "token": token ?? ""
  //     };
  //     var uri = Uri.parse(ip! + route);
  //     http.MultipartFile multipartFile;
  //     var request = http.MultipartRequest('POST', uri);
  //     // if (!Misc.isNull(file)) {
  //     for (var e in files) {
  //       multipartFile = http.MultipartFile.fromBytes(
  //           name!, File(e.path!).readAsBytesSync(),
  //           filename: File(e.path!).path);
  //       request.files.add(multipartFile);
  //       // }
  //       request.headers.addAll(headers);
  //     }
  //     request.fields.addAll(data!);
  //     http.Response response =
  //         await http.Response.fromStream(await request.send());
  //     if (jsonDecode(response.body)['status']) {
  //       return jsonDecode(response.body);
  //     } else {
  //       return jsonDecode(response.body);
  //     }
  //   } catch (e) {
  //     log('File upload error: $e');
  //     return {
  //       'status': false,
  //       'msg': 'Invalid Request',
  //     };
  //   }
  // }
  // static uploadMultipleFiles(List<String> files, String route, String? name,
  //     Map<String, String> data) async {
  //   try {
  //     var token = await Preferene6644.getToken();
  //     Map<String, String> headers = {
  //       "Content-Type": "application/json",
  //       "x-auth-token": token ?? ""
  //     };
  //     var uri = Uri.parse(ip! + route);
  //     http.MultipartFile multipartFile;
  //     var request = http.MultipartRequest('POST', uri);
  //     for (var e in files) {
  //       multipartFile = http.MultipartFile.fromBytes(
  //         name!,
  //         File(e).readAsBytesSync(),
  //         filename: e,
  //       );
  //       request.files.add(multipartFile);
  //     }

  //     request.headers.addAll(headers);
  //     request.fields.addAll(data);
  //     http.Response response =
  //         await http.Response.fromStream(await request.send());
  //     if (jsonDecode(response.body)['status']) {
  //       log(jsonDecode(response.body).toString());
  //       return jsonDecode(response.body);
  //     } else {
  //       log(jsonDecode(response.body).toString());
  //       return jsonDecode(response.body);
  //     }
  //   } catch (e) {
  //     log('File upload error: $e');
  //     return {
  //       'status': false,
  //       'msg': 'Invalid Request',
  //     };
  //   }
  // }
}
