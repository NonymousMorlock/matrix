import 'dart:collection';

import 'package:matrix/domain/entities/matrix.dart';


extension MatrixExt on Matrix {
  /// addition operator
  Matrix operator +(Matrix other) {
    if (size != other.size) {
      throw Exception('Addition Undefined for matrices of different sizes');
    }

    return Matrix(matrix.asMap().entries.map((initialEntry) {
      // MapEntry(0, [1, 2, 3])
      return initialEntry.value.asMap().entries.map((finalEntry) {
        // MapEntry(0, 1)
        return finalEntry.value +
            other.matrix[initialEntry.key][finalEntry.key];
      }).toList();
    }).toList());
  }

  /// subtraction operator
  Matrix operator -(Matrix other) {
    if (size != other.size) {
      throw Exception('Subtraction Undefined for matrices of different sizes');
    }

    /// implicit functionality
    // final finalTrix = [];
    // for(int i = 0; i < matrix.length; i++) {
    //   final row = matrix[i];
    //   final newRow = [];
    //
    //   for(int j = 0; j < row.length; j++) {
    //     final element = row[j];
    //     newRow.add(element - other.matrix[i][j]);
    //   }
    //
    //   finalTrix.add(newRow);
    // }

    return Matrix(matrix.asMap().entries.map((initialEntry) {
      // MapEntry(0, [1, 2, 3])
      return initialEntry.value.asMap().entries.map((finalEntry) {
        // MapEntry(0, 1)
        return finalEntry.value -
            other.matrix[initialEntry.key][finalEntry.key];
      }).toList();
    }).toList());
  }

  /// multiplication operator
  Matrix operator *(Matrix other) {
    if (matrix[0].length != other.matrix.length) {
      throw Exception(
          'Multiplication Undefined for matrices of different sizes');
    }

    return Matrix(matrix.asMap().entries.map((initialEntry) {
      // MapEntry(0, [1, 2, 3])
      return other.columns.asMap().entries.map((finalEntry) {
        // MapEntry(0, 12)
        return initialEntry.value.asMap().entries.map((middleEntry) {
          // MapEntry(0, 1)
          return initialEntry.value[middleEntry.key] *
              other.matrix[middleEntry.key][finalEntry.key];
        }).reduce((a, b) => a + b);
      }).toList();
    }).toList());
  }

  ///   Matrix operator *(Matrix other) {
  //     if (matrix[0].length != other.matrix.length) {
  //       throw Exception('Undefined for this operation');
  //     }
  //
  //     final result = <List<int>>[];
  // /*    '''
  //     0 0 0    0 0 0 0
  //     0 0 0    0 0 0 0
  //     0 0 0    0 0 0 0
  //     0 0 0
  //     '''*/
  //
  //     for (int i = 0; i < matrix.length; i++) {
  //       final row = matrix[i];
  //       final newRow = <int>[];
  //       for (int j = 0; j < other.matrix[0].length; j++) {
  //         final otherMatrixColumn = other.matrix.map((row) => row[j]).toList();
  //         final productListToBeSummed = [];
  //         for (int k = 0; k < row.length; k++) {
  //           final rowElement = row[k];
  //           final columnElement = otherMatrixColumn[k];
  //           productListToBeSummed.add(rowElement * columnElement);
  //         }
  //         final sum =
  //         productListToBeSummed.reduce((current, next) => current + next);
  //         newRow.add(sum);
  //       }
  //       result.add(newRow);
  //     }
  //     return Matrix(result);
  //   }

  /// scalar multiplication operator
  Matrix operator ^(int scalar) {
    return Matrix(matrix.asMap().entries.map((initialEntry) {
      // MapEntry(0, [1, 2, 3])
      return initialEntry.value.asMap().entries.map((finalEntry) {
        // MapEntry(0, 1)
        return finalEntry.value * scalar;
      }).toList();
    }).toList());
  }

  /// scalar division operator
  Matrix operator %(int scalar) {
    return Matrix(matrix.asMap().entries.map((initialEntry) {
      // MapEntry(0, [1, 2, 3])
      return initialEntry.value.asMap().entries.map((finalEntry) {
        // MapEntry(0, 1)
        return finalEntry.value ~/ scalar;
      }).toList();
    }).toList());
  }

  /// division operator
  Matrix operator /(Matrix other) {
    if (size != other.size) {
      throw Exception('Division Undefined for matrices of different sizes');
    }

    return Matrix(matrix.asMap().entries.map((initialEntry) {
      // MapEntry(0, [1, 2, 3])
      return initialEntry.value.asMap().entries.map((finalEntry) {
        // MapEntry(0, 1)
        return finalEntry.value ~/
            other.matrix[initialEntry.key][finalEntry.key];
      }).toList();
    }).toList());
  }

  /// determinant operator |A|
  int get determinant {
    if (!isSquare) {
      throw Exception('Determinant Undefined for non-square matrices');
    }
    if (hasZeroRowOrColumn) {
      return 0;
    }
    if (is1x1) {
      return matrix[0][0];
    }
    if (size == '2x2') {
      return _determinant2x2;
    }
    return expansion;
  }

  /// laplace expansion
  int get laplaceExpansion {
    int sum = 0;
    for (int i = 0; i < matrix[0].length; i++) {
      final minor = Matrix(matrix.asMap().entries.map((initialEntry) {
        // MapEntry(0, [1, 2, 3])
        return initialEntry.value.asMap().entries.map((finalEntry) {
          // MapEntry(0, 1)
          if (initialEntry.key == 0 || finalEntry.key == i) {
            return 0;
          }
          return finalEntry.value;
        }).toList();
      }).toList());
      sum += matrix[0][i] * minor.determinant * (i % 2 == 0 ? 1 : -1);
    }
    return sum;
  }

  int get expansion {
    final workingMatrix =
        UnmodifiableListView(matrix.getRange(1, matrix.length).toList());
    final operands = <int>[];
    for (int i = 0; i < matrix[0].length; i++) {
      final leading = matrix[0][i];
      final copyWorkingMatrix = List<List<int>>.from(workingMatrix);
      // the reason for mapping each row is to not directly edit the reference
      // of the row from the main working matrix
      final minorMatrix = copyWorkingMatrix
          .map((row) => row.map((e) => e).toList()..removeAt(i))
          .toList();
      final newMatrix = Matrix(minorMatrix);
      operands.add(leading * newMatrix.determinant);
    }
    var sum = 0;
    for (int j = 0; j < operands.length; j++) {
      if (j % 2 == 0) {
        sum += operands[j];
      } else {
        sum -= operands[j];
      }
    }
    return sum;
  }

  int get _determinant2x2 {
    return (matrix[0][0] * matrix[1][1]) - (matrix[0][1] * matrix[1][0]);
  }
}

extension NumExt on int {
  Matrix multiply(Matrix matrix) {
    return Matrix(matrix.matrix.asMap().entries.map((initialEntry) {
      // MapEntry(0, [1, 2, 3])
      return matrix.matrix[initialEntry.key].map((finalEntry) {
        // MapEntry(0, 1)
        return finalEntry * this;
      }).toList();
    }).toList());
  }
}
