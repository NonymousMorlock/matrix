import 'package:matrix/core/extensions/matrix_extensions.dart';
import 'package:matrix/domain/entities/matrix.dart';

void main(List<String> args) {
/*  𝑆 = (
  2 4 1
  0 1 −2
  ) 𝑎𝑛𝑑 𝑇 = (
  3 0 1 −1
  3 1 4 0
  3 −1 2 −2
  )*/

  final A = Matrix([
    [2, 1, 1],
    [-1, -1, 4],
  ]);
  final B = Matrix([
    [2, -3, 4],
    [-3, 1, -2],
  ]);
  final C = Matrix([
    [0, 1, -2],
    [1, -1, -1],
  ]);

  print((A ^ 5) - (B ^ 2));
}

// void main(List<String> arguments) {
//   Matrix matrix = Matrix([
//     [1, 2, 3],
//     [1, 1, 1],
//     [2, 3, 2],
//   ]);
//
//   Matrix matrix2 = Matrix([
//     [2, 1, 2],
//     [1, 2, 1],
//     [3, 1, 2],
//   ]);
//
//   Matrix A = Matrix([
//     [10, 12, 6, 8],
//     [6, 5, 1, 7],
//     [1, 2, 3, 7],
//     [1, 1, 23, 4],
//   ]);
//
//   toMatrix([1, 2, 3, 4, 5], [5, 3, 2, 1, 4]);
//
//   print(A.determinant);
//   print(' _    _');
//   print('|3 3 4|');
//   print('|2 3 1|');
// }
//
// void test1() {
//   Matrix matrix = Matrix([
//     [1, 2, 3],
//     [4, 5, 6],
//     [7, 8, 9],
//   ]);
//
//   Matrix matrix2 = Matrix([
//     [1, 2, 3],
//     [4, 5, 6],
//     [7, 8, 9],
//   ]);
//
//   // print(matrix.rows);
//   // print(matrix.columns);
//   // print(matrix.size);
//   // print(matrix.isSquare);
//   // print(matrix.isZero);
//   //
//   // print(matrix + matrix2);
//   // print(matrix - matrix2);
//
//   Matrix A = Matrix([
//     [1, 2, 3],
//     [4, 5, 6],
//     [7, 8, 9],
//   ]);
//
//   Matrix B = Matrix([
//     [0, 5, 3, 1],
//     [2, 5, 8, 3],
//     [1, 2, 1, 4],
//   ]);
//
//   Matrix C = Matrix([
//     [2, 8, 7],
//     [5, 5, 9],
//   ]);
//
//   Matrix D = Matrix([
//     [5, 9],
//     [2, 2],
//     [3, 5],
//   ]);
//   //
//   // print(A * B);
//   // print(A ^ 10);
//   print(C * D);
// }
//
// void multiplication() {
//   Matrix matrix = Matrix([
//     [0, 1],
//     [2, 2],
//   ]);
//
//   Matrix matrix2 = Matrix([
//     [2, 1],
//     [1, 5],
//   ]);
//
//   print(matrix2 * matrix);
// }
//
// void toMatrix(List<int> i, List<int> j) {
//   /// such that a(subscript i, j)
//
//   final matrix = Matrix(List.generate(i.length, (index) => [i[index], j[index]]));
//   print(matrix);
// }

void cramerRule(List<String> equations) {
  // sample equations
  // 2x + y + z = 9
  // x + y + z = 6
  // z + y + 2z = 7

  // Cramer's Rule
  // x = Dx / D
  // y = Dy / D
  // z = Dz / D

  // D = | 2 1 1 |
  //     | 1 1 1 |
  //     | 1 1 2 |
  //
  // Dx = | 9 1 1 |
  //      | 6 1 1 |
  //      | 7 1 2 |
  //
  // Dy = | 2 9 1 |
  //      | 1 6 1 |
  //      | 1 7 2 |
  //
  // Dz = | 2 1 9 |
  //      | 1 1 6 |
  //      | 1 1 7 |

  // D = 2(1*2 - 1*1) - 1(2*2 - 1*1) + 1(2*1 - 1*1)
  // D = 2(2 - 1) - 1(4 - 1) + 1(2 - 1)
  // D = 2(1) - 1(3) + 1(1)
  // D = 2 - 3 + 1
  // D = 0

  // Dx = 9(1*2 - 1*1) - 1(6*2 - 1*1) + 1(6*1 - 1*1)
  // Dx = 9(2 - 1) - 1(12 - 1) + 1(6 - 1)
  // Dx = 9(1) - 1(11) + 1(5)
  // Dx = 9 - 11 + 5
  // Dx = 3

  // Dy = 2(1*6 - 1*1) - 9(2*2 - 1*1) + 1(2*6 - 1*1)
  // Dy = 2(6 - 1) - 9(4 - 1) + 1(12 - 1)
  // Dy = 2(5) - 9(3) + 1(11)
  // Dy = 10 - 27 + 11
  // Dy = -6

  // Dz = 2(1*1 - 1*6) - 1(2*1 - 1*6) + 9(2*1 - 1*1)
  // Dz = 2(1 - 6) - 1(2 - 6) + 9(2 - 1)
  // Dz = 2(-5) - 1(-4) + 9(1)
  // Dz = -10 + 4 + 9
  // Dz = 3

  // x = Dx / D
  // x = 3 / 0
  // x = undefined

  // y = Dy / D
  // y = -6 / 0
  // y = undefined

  // z = Dz / D
  // z = 3 / 0
  // z = undefined

  // no solution

  // explain why the answers are undefined
  // because the determinant is 0
  // and you can't divide by 0
  // so there is no solution

  // Determinant should not be zero, it should be 1
  // find determinant of this
  // D = | 2 1 1 |
  //     | 1 1 1 |
  //     | 1 1 2 |

  // D = 2(1*2 - 1*1) - 1(1*2 - 1*1) + 1(1*1 - 1*1)
  // D = 2(2 - 1) - 1(2 - 1) + 1(1 - 1)
  // D = 2(1) - 1(1) + 1(0)
  // D = 2 - 1 + 0
  // D = 1

  // resolve the linear equations using cramers rule knowing that the determinant is 1
  // x = Dx / D
  // x = 3 / 1
  // x = 3

  // y = Dy / D
  // y = -6 / 1
  // y = -6

  // z = Dz / D
  // z = 3 / 1
  // z = 3

  // solution is (3, -6, 3)
}
