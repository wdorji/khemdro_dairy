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

  return await clientViaServiceAccount(
      credentials, [sheets.SheetsApi.spreadsheetsScope]);
}

// Create a function to create a new worksheet in your Google spreadsheet file.
Future<void> createNewRow() async {
  print("creating new row");
  // Authenticate your app.
  final client = await authenticate();
  print("authenticated");
  final sheetsApi = SheetsApi(client);
  // Set the spreadsheet ID and range of the sheet you want to write to.
  final spreadsheetId = '1iHLSVZJ3uFUQgbQtviB-hjZBGE1_CSfu0xLwNpfMdFc';
  final range = 'January!A1:E';

  // Create a list of values to write to the row.
  final newRow = [
    'John',
    'Doe',
    'john.doe@example.com',
    '555-555-5555',
    'New York'
  ];

  // Call the `spreadsheets.values.append` method of the Sheets API client to append the row.
  final request = ValueRange()
    ..values = [newRow.map((value) => value.toString()).toList()];
  final response = await sheetsApi.spreadsheets.values.append(
      request, spreadsheetId, range,
      valueInputOption: 'USER_ENTERED', insertDataOption: 'INSERT_ROWS');
}
