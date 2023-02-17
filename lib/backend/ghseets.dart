import 'package:gsheets/gsheets.dart';

/// Your google auth credentials
///
/// how to get credentials - https://medium.com/@a.marenkov/how-to-get-credentials-for-google-sheets-456b7e88c430
const _credentials = r'''
{
  "type": "service_account",
  "project_id": "servir-sco-assets",
  "private_key_id": "7fd62c5bb61e430630cf1b0f7b9b7e77e0409626",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDHpyULg5j/1Dpu\nlw+aS7nC6z3rcRV1ITFgIEs2awWMuOZO1suf608BDK4czqKg+bkAFQCpeXHvpJrD\nPQrFfhpBRrfUwuw84BHKdjqy0UkpBQSFZveKDro+GDVYBZtM5MYc8evJ/KrXt8cW\n93F/gn3ESQgeS7iFZQY06+aHn6SLDpERsg17DqT/7NbBKx3cMw1CU7cTYgq6Wrv/\nKcdarxSM87OSwZ7Re7omX1JI3R7gnjqQNCkLZTZkbTJE0ijjq4dczk95dlol+aHC\ngOfU7vnYdz0DpfFIyiek7gGTxEUVQgsGeLxO/72BlUlFaWeg15jquKMvuFte+ebL\nZ9wUKH4nAgMBAAECggEACmoHDicyo2GUHLGngDJkAa1YoP/YkTAGjc+RbMi/VNxO\nMx2UKIbTK6hYKquCoyfzhPQTgUOS9F+fLQDxn2SZBP+l1iTGwtQjSW7KWAp/qPKY\njkbVMa/b+iI0Ih/EvomOZfMei/4wgSkWavXER1Tsr4Dpuf7UJK0k2jzV3QwwPoqP\nwNMJqBe4Hn63azD7U4EdjrOZ2zKAZ2qDQMuoSSQbQiDassNaaryU5ib26dQXFXfI\nqdkrCSX/mTB8KGmMIaGpAW+0UqJ9Q7ne3JvNAUQgQ4UBuZe3pWL7VPhYCiQCp7kR\ns+uNZOdZUl4yE8Bh7eI+NBise3sw9Wr2rpGsXSykEQKBgQD7vVM2CgfcQHSo/Ahd\nqDmay0woB7ve3p4OhOF0bvLwTcNoTc5CobjdC0dO+CNsdUJnDHPxydhuYQuYwvEd\nDd5mBC6tG9VoL5ckf+uUdbpXYfgyIgf3OFAInFUO4DZqu6+q3P+yT78/LasvlgC4\ncAVDiW190T84eS67eFdZ82gjcQKBgQDLCCbKU5r4D2xaaM7WyEqxy5olIinG6tU6\nUP0+dFYUIO0PDTsptMwjtNinaFB83v5bnHneV4bPMDHVWXZd71puXCCk/7KNEvGg\n6F7DIpzMubll+TXw/stRxdw7pGLFXTl0C5LtIa58LWJMKaoVlAiVFUrz7qeIeSOQ\nwYh7Uxy/FwKBgQDedU3lQTP1BNiSxDW4XgKZsfGYpkz1BBD0j6SUOb9hb7awo6ET\n7MnqPB9Fv62+GFkXqz+CeXZTBFs1IX/kxu6zhBqjSydpLDUKQiiyRt7mfWLRGpWj\neBXxpgTcYnJ0G2t/OFCVCDfe4sKWCJ6WXheouPcS6ihOBXiwngXDLX/nYQKBgGre\n6pQ7t+n1LGLWonG6Ul8OPiBnwDfdqsmckgEK+bh0sHPo0gidC4uMCTLtnNhuBNOy\nJRAdYG+0/bZA9iZx9Fb9FY3krlbF7vx09FSg5op5BJchu/wUEnADx255lCgxbymf\nYgKCZTcmKITQtZ/QIUhgQeju6a7TnR34UWAhGpOXAoGBANg37g1j5tEGjBTJeyE3\nPUAj476o3xVB/cn6bQUnqmCMpIRtRYe86Qt85dcQZt6eRJCrz4+Ey+gI2zKy+x6/\nAv7oyh9wAusQvVqpiDlrfrrLqbD+w2tPBPCGxoKtMbX4TigfKh+EfvT47G+V5H3H\nY5nFi0cjZyuJuwluFTNU7pab\n-----END PRIVATE KEY-----\n",
  "client_email": "gsheets@servir-sco-assets.iam.gserviceaccount.com",
  "client_id": "113552485141338729661",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gsheets%40servir-sco-assets.iam.gserviceaccount.com"
}
''';

/// Your spreadsheet id
///
/// It can be found in the link to your spreadsheet -
/// link looks like so https://docs.google.com/spreadsheets/d/YOUR_SPREADSHEET_ID/edit#gid=0
/// [YOUR_SPREADSHEET_ID] in the path is the id your need
const _spreadsheetId = '1j1Z0bpiNZaAuWPmsfyxH4enPtm1BIVYo';

void main() async {
  // init GSheets
  final gsheets = GSheets(_credentials);
  // fetch spreadsheet by its id
  final ss = await gsheets.spreadsheet(_spreadsheetId);

  print(ss.data.namedRanges.byName.values
      .map((e) => {
            'name': e.name,
            'start':
                '${String.fromCharCode((e.range?.startColumnIndex ?? 0) + 97)}${(e.range?.startRowIndex ?? 0) + 1}',
            'end':
                '${String.fromCharCode((e.range?.endColumnIndex ?? 0) + 97)}${(e.range?.endRowIndex ?? 0) + 1}'
          })
      .join('\n'));

  // get worksheet by its title
  var sheet = ss.worksheetByTitle('example');
  // create worksheet if it does not exist yet
  // sheet ??= await ss.addWorksheet('example');

  // // update cell at 'B2' by inserting string 'new'
  // await sheet.values.insertValue('new', column: 2, row: 2);
  // // prints 'new'
  // print(await sheet.values.value(column: 2, row: 2));
  // // get cell at 'B2' as Cell object
  // final cell = await sheet.cells.cell(column: 2, row: 2);
  // // prints 'new'
  // print(cell.value);
  // // update cell at 'B2' by inserting 'new2'
  // await cell.post('new2');
  // // prints 'new2'
  // print(cell.value);
  // // also prints 'new2'
  // print(await sheet.values.value(column: 2, row: 2));

  // // insert list in row #1
  // final firstRow = ['index', 'letter', 'number', 'label'];
  // await sheet.values.insertRow(1, firstRow);
  // // prints [index, letter, number, label]
  // print(await sheet.values.row(1));

  // // insert list in column 'A', starting from row #2
  // final firstColumn = ['0', '1', '2', '3', '4'];
  // await sheet.values.insertColumn(1, firstColumn, fromRow: 2);
  // // prints [0, 1, 2, 3, 4, 5]
  // print(await sheet.values.column(1, fromRow: 2));

  // // insert list into column named 'letter'
  // final secondColumn = ['a', 'b', 'c', 'd', 'e'];
  // await sheet.values.insertColumnByKey('letter', secondColumn);
  // // prints [a, b, c, d, e, f]
  // print(await sheet.values.columnByKey('letter'));

  // // insert map values into column 'C' mapping their keys to column 'A'
  // // order of map entries does not matter
  // final thirdColumn = {
  //   '0': '1',
  //   '1': '2',
  //   '2': '3',
  //   '3': '4',
  //   '4': '5',
  // };
  // await sheet.values.map.insertColumn(3, thirdColumn, mapTo: 1);
  // // prints {index: number, 0: 1, 1: 2, 2: 3, 3: 4, 4: 5, 5: 6}
  // print(await sheet.values.map.column(3));

  // // insert map values into column named 'label' mapping their keys to column
  // // named 'letter'
  // // order of map entries does not matter
  // final fourthColumn = {
  //   'a': 'a1',
  //   'b': 'b2',
  //   'c': 'c3',
  //   'd': 'd4',
  //   'e': 'e5',
  // };
  // await sheet.values.map.insertColumnByKey(
  //   'label',
  //   fourthColumn,
  //   mapTo: 'letter',
  // );
  // // prints {a: a1, b: b2, c: c3, d: d4, e: e5, f: f6}
  // print(await sheet.values.map.columnByKey('label', mapTo: 'letter'));

  // // appends map values as new row at the end mapping their keys to row #1
  // // order of map entries does not matter
  // final secondRow = {
  //   'index': '5',
  //   'letter': 'f',
  //   'number': '6',
  //   'label': 'f6',
  // };
  // await sheet.values.map.appendRow(secondRow);
  // // prints {index: 5, letter: f, number: 6, label: f6}
  // print(await sheet.values.map.lastRow());

  // // get first row as List of Cell objects
  // final cellsRow = await sheet.cells.row(1);
  // // update each cell's value by adding char '_' at the beginning
  // cellsRow.forEach((cell) => cell.value = '_${cell.value}');
  // // actually updating sheets cells
  // await sheet.cells.insert(cellsRow);
  // // prints [_index, _letter, _number, _label]
  // print(await sheet.values.row(1));
}
