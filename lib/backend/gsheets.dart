import 'package:googleapis/sheets/v4.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:googleapis/sheets/v4.dart' as sheets;

// Create a function to authenticate your app using the Google Sheets API.
Future<AutoRefreshingAuthClient> authenticate() async {
  final credentials = ServiceAccountCredentials.fromJson({
    "type": "service_account",
    "project_id": "servir-sco-assets",
    "private_key_id": "7fd62c5bb61e430630cf1b0f7b9b7e77e0409626",
    "private_key":
        "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDHpyULg5j/1Dpu\nlw+aS7nC6z3rcRV1ITFgIEs2awWMuOZO1suf608BDK4czqKg+bkAFQCpeXHvpJrD\nPQrFfhpBRrfUwuw84BHKdjqy0UkpBQSFZveKDro+GDVYBZtM5MYc8evJ/KrXt8cW\n93F/gn3ESQgeS7iFZQY06+aHn6SLDpERsg17DqT/7NbBKx3cMw1CU7cTYgq6Wrv/\nKcdarxSM87OSwZ7Re7omX1JI3R7gnjqQNCkLZTZkbTJE0ijjq4dczk95dlol+aHC\ngOfU7vnYdz0DpfFIyiek7gGTxEUVQgsGeLxO/72BlUlFaWeg15jquKMvuFte+ebL\nZ9wUKH4nAgMBAAECggEACmoHDicyo2GUHLGngDJkAa1YoP/YkTAGjc+RbMi/VNxO\nMx2UKIbTK6hYKquCoyfzhPQTgUOS9F+fLQDxn2SZBP+l1iTGwtQjSW7KWAp/qPKY\njkbVMa/b+iI0Ih/EvomOZfMei/4wgSkWavXER1Tsr4Dpuf7UJK0k2jzV3QwwPoqP\nwNMJqBe4Hn63azD7U4EdjrOZ2zKAZ2qDQMuoSSQbQiDassNaaryU5ib26dQXFXfI\nqdkrCSX/mTB8KGmMIaGpAW+0UqJ9Q7ne3JvNAUQgQ4UBuZe3pWL7VPhYCiQCp7kR\ns+uNZOdZUl4yE8Bh7eI+NBise3sw9Wr2rpGsXSykEQKBgQD7vVM2CgfcQHSo/Ahd\nqDmay0woB7ve3p4OhOF0bvLwTcNoTc5CobjdC0dO+CNsdUJnDHPxydhuYQuYwvEd\nDd5mBC6tG9VoL5ckf+uUdbpXYfgyIgf3OFAInFUO4DZqu6+q3P+yT78/LasvlgC4\ncAVDiW190T84eS67eFdZ82gjcQKBgQDLCCbKU5r4D2xaaM7WyEqxy5olIinG6tU6\nUP0+dFYUIO0PDTsptMwjtNinaFB83v5bnHneV4bPMDHVWXZd71puXCCk/7KNEvGg\n6F7DIpzMubll+TXw/stRxdw7pGLFXTl0C5LtIa58LWJMKaoVlAiVFUrz7qeIeSOQ\nwYh7Uxy/FwKBgQDedU3lQTP1BNiSxDW4XgKZsfGYpkz1BBD0j6SUOb9hb7awo6ET\n7MnqPB9Fv62+GFkXqz+CeXZTBFs1IX/kxu6zhBqjSydpLDUKQiiyRt7mfWLRGpWj\neBXxpgTcYnJ0G2t/OFCVCDfe4sKWCJ6WXheouPcS6ihOBXiwngXDLX/nYQKBgGre\n6pQ7t+n1LGLWonG6Ul8OPiBnwDfdqsmckgEK+bh0sHPo0gidC4uMCTLtnNhuBNOy\nJRAdYG+0/bZA9iZx9Fb9FY3krlbF7vx09FSg5op5BJchu/wUEnADx255lCgxbymf\nYgKCZTcmKITQtZ/QIUhgQeju6a7TnR34UWAhGpOXAoGBANg37g1j5tEGjBTJeyE3\nPUAj476o3xVB/cn6bQUnqmCMpIRtRYe86Qt85dcQZt6eRJCrz4+Ey+gI2zKy+x6/\nAv7oyh9wAusQvVqpiDlrfrrLqbD+w2tPBPCGxoKtMbX4TigfKh+EfvT47G+V5H3H\nY5nFi0cjZyuJuwluFTNU7pab\n-----END PRIVATE KEY-----\n",
    "client_email": "gsheets@servir-sco-assets.iam.gserviceaccount.com",
    "client_id": "113552485141338729661",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url":
        "https://www.googleapis.com/robot/v1/metadata/x509/gsheets%40servir-sco-assets.iam.gserviceaccount.com"
  });
  print("running authenticate");
  return await clientViaServiceAccount(
      credentials, [sheets.SheetsApi.spreadsheetsScope]);
}

// Create a function to create a new worksheet in your Google spreadsheet file.
Future<void> createNewRow(sin, dairy_collected) async {
  print("creating new row");
  // Authenticate your app.
  final client = await authenticate();
  print("authenticated");
  final sheetsApi = SheetsApi(client);
  // Set the spreadsheet ID and range of the sheet you want to write to.
  final spreadsheetId = '1iHLSVZJ3uFUQgbQtviB-hjZBGE1_CSfu0xLwNpfMdFc';

  // get date
  List date = getDate();
  String worksheetID = getSheetId(date);
  final range = worksheetID;
  final sinRange = "$worksheetID!C:C";

  final response =
      await sheetsApi.spreadsheets.values.get(spreadsheetId, range);
  // .append(
  //     request, spreadsheetId, range,
  //     valueInputOption: 'USER_ENTERED', insertDataOption: 'INSERT_ROWS');
  final sinResponse =
      await sheetsApi.spreadsheets.values.get(spreadsheetId, sinRange);
  String colLetter = getColumnLetter(date, response);
  print("column letter: $colLetter");
  final values = sinResponse.values;
  int rowIndex = 0;
  print(values);
  for (var i = 0; i < values!.length; i++) {
    if (values[i][0] == sin) {
      // Row found!
      rowIndex = i;
      print("Row found at index $i");
      break;
    }
  }

  if (rowIndex != -1) {
    final rangeToUpdate =
        "$worksheetID!${colLetter}${rowIndex + 1}:${colLetter}${rowIndex + 1}";
    final valuesToUpdate = [
      [dairy_collected],
    ];
    final updateValuesRequest = ValueRange.fromJson({"values": valuesToUpdate});

    final updateResponse = await sheetsApi.spreadsheets.values.update(
      updateValuesRequest,
      spreadsheetId,
      rangeToUpdate,
      valueInputOption: "USER_ENTERED",
    );

    print(updateResponse.updatedCells);
  }
}

List getDate() {
  DateTime today = DateTime.now();
  int year = today.year;
  int month = today.month;
  int day = today.day;
  print("month $month");
  print("year $year");
  print("today $day");
  return [year, month, day];
}

String monthAsString(month) {
  Map<int, String> monthToString = {
    1: "January",
    2: "February",
    3: "March",
    4: "April",
    5: "May",
    6: "June",
    7: "July",
    8: "August",
    9: "September",
    10: "October",
    11: "November",
    12: "December",
  };
  // String out = "";

  // if (monthToString.keys.contains(month)) {
  //   out =
  //   return monthToString[month];
  // }
  return monthToString[month] ?? "";
}

String getSheetId(date) {
  int month = date[1];
  String sYear = date[0].toString();
  String sMonth = monthAsString(month);
  return "${sMonth}_$sYear";
}

String getColumnLetter(date, response) {
  String year = date[0].toString();
  String month = date[1].toString();
  String day = date[2].toString();
  String frmt = "${month}/${day}";
  print("format $frmt");
  final values = response.values[0];
  int colIndex = -1;

  for (var i = 0; i < values.length; i++) {
    print(values[i]);
    if (values[i] == frmt) {
      colIndex = i;
      print(colIndex);

      break;
    }
  }

  if (colIndex != -1) {
    var rangeAlphabet = "";
    final rem = 26 % colIndex;
    if (colIndex <= 26) {
      rangeAlphabet = String.fromCharCode('A'.codeUnitAt(0) + colIndex);
    } else {
      for (var i = 0; i < (26 / (colIndex - rem)); i++) {
        rangeAlphabet += "A";
      }
      rangeAlphabet += String.fromCharCode('A'.codeUnitAt(0) + rem);
    }
    print(rangeAlphabet);
    return rangeAlphabet;
  }
  return "fail";
}
