import 'package:collection/collection.dart';

class Matrix {
  Matrix(this.matrix)
      // assert that each row has the same length
      : assert(matrix.map((row) => row.length).toSet().length == 1,
            'Each row must have the same length'),
        assert(matrix.isNotEmpty, 'Matrix must not be empty');

  // assert(
  //   matrix[0]
  //           .asMap()
  //           .entries
  //           .map((entry) {
  //             return matrix.map((row) => row[entry.key]).length;
  //           })
  //           .toSet()
  //           .length ==
  //       1,
  //   'Each column must have the same length',
  // );

  final List<List<int>> matrix;

  Matrix get transpose {
    return Matrix(matrix[0].asMap().entries.map((entry) {
      // MapEntry(0, 1)
      return matrix.map((row) => row[entry.key]).toList();
    }).toList());
  }

  String get size {
    return '${matrix.length}x${matrix[0].length}';
  }

  bool get isSquare {
    return matrix.length == matrix[0].length;
  }

  bool get isZero {
    return matrix.every((row) => row.every((element) => element == 0));
  }

  bool get hasZeroRowOrColumn {
    // if one entire row or column only contains zeros
    for (int i = 0; i < matrix.length; i++) {
      final row = matrix[i];
      if (row.every((element) => element == 0)) {
        return true;
      }
    }

    for (int i = 0; i < matrix[0].length; i++) {
      final column = matrix.map((row) => row[i]).toList();
      if (column.every((element) => element == 0)) {
        return true;
      }
    }

    return false;
  }

  bool get is1x1 {
    return matrix.length == 1 && matrix[0].length == 1;
  }

  List<int> get rows {
    return matrix.map((row) => row.reduce((a, b) => a + b)).toList();
  }

  List<int> get columns {
    return matrix[0].asMap().entries.map((entry) {
      // MapEntry(0, 1)
      return matrix.map((row) => row[entry.key]).reduce((a, b) => a + b);
    }).toList();
  }

  List<int> get leadingDiagonal {
    assert(isSquare, 'Matrix must be square');
    return matrix.asMap().entries.map((row) => row.value[row.key]).toList();
  }

  @override
  String toString() {
    // increase spacing if there are two digit numbers or 3 and so on
    // final int spacing = matrix.map((row) => row.map((element) => element.toString().length).reduce((a, b) => a > b ? a : b)).reduce((a, b) => a > b ? a : b);
    // return matrix.map((row) => row.map((element) => element.toString().padLeft(spacing)).join(' ')).join('\n');
    return matrix.map((row) => row.join(' ')).join('\n');
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Matrix &&
            runtimeType == other.runtimeType &&
            size == other.size &&
            DeepCollectionEquality().equals(matrix, other.matrix);
  }

  @override
  int get hashCode => matrix.hashCode ^ super.hashCode;

}
