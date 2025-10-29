import 'dart:io'; 

void main() {
  print('=== Aplikasi Pengonversi Suhu Interaktif ===');
  print('Skala yang didukung: Celsius (C), Fahrenheit (F), Reamur (R), Kelvin (K)');
  
  // 1. Ambil Input Suhu Awal
  double suhu = _getInputSuhu();
  
  // 2. Ambil Skala Awal
  String skalaAwal = _getInputSkala('Masukkan skala suhu awal (C/F/R/K): ');

  // 3. Ambil Skala Tujuan
  String skalaTujuan = _getInputSkala('Masukkan skala suhu tujuan (C/F/R/K): ');
  
  if (skalaAwal == skalaTujuan) {
    print('\nHasil: ${suhu.toStringAsFixed(2)} $skalaAwal');
    print('Skala awal dan tujuan sama. Tidak ada konversi yang dilakukan.');
    return;
  }

  // --- Proses Konversi ---
  
  // Langkah 1: Konversi ke basis Celsius
  double suhuDalamC = _convertToCelsius(suhu, skalaAwal);

  // Langkah 2: Konversi dari Celsius ke skala tujuan
  double hasilAkhir = _convertFromCelsius(suhuDalamC, skalaTujuan);

  print('\n--- Hasil Konversi ---');
  print('Suhu Awal: ${suhu.toStringAsFixed(2)} $skalaAwal');
  print('Suhu Akhir: ${hasilAkhir.toStringAsFixed(2)} $skalaTujuan');
  print('----------------------');
}

double _getInputSuhu() {
  double? suhu;
  while (suhu == null) {
    stdout.write('Masukkan nilai suhu: ');
    String? input = stdin.readLineSync();
    try {
      if (input != null) {
        suhu = double.parse(input);
      }
    } catch (e) {
      print('❌ Input tidak valid. Harap masukkan angka.');
    }
  }
  return suhu;
}

/// Meminta input skala suhu (C/F/R/K) dari pengguna dengan validasi
String _getInputSkala(String prompt) {
  String? skala;
  List<String> validSkala = ['C', 'F', 'R', 'K'];
  while (skala == null || !validSkala.contains(skala)) {
    stdout.write(prompt);
    // Membaca input, mengubah ke huruf kapital, dan menghapus spasi
    skala = stdin.readLineSync()?.trim().toUpperCase(); 
    if (skala == null || !validSkala.contains(skala)) {
      print('❌ Skala tidak valid. Harap masukkan C, F, R, atau K.');
    }
  }
  return skala;
}

/// Mengkonversi suhu dari skala manapun ke Celsius
double _convertToCelsius(double suhu, String skala) {
  switch (skala) {
    case 'C':
      return suhu; 
    case 'F':
      // C = (F - 32) * 5/9
      return (suhu - 32) * 5 / 9;
    case 'R':
      // C = R * 5/4
      return suhu * 5 / 4;
    case 'K':
      // C = K - 273.15
      return suhu - 273.15;
    default:
      return 0.0; 
  }
}

/// Mengkonversi suhu dari Celsius ke skala tujuan
double _convertFromCelsius(double suhuC, String skalaTujuan) {
  switch (skalaTujuan) {
    case 'C':
      return suhuC; 
    case 'F':
      // F = C * 9/5 + 32
      return (suhuC * 9 / 5) + 32;
    case 'R':
      // R = C * 4/5
      return suhuC * 4 / 5;
    case 'K':
      // K = C + 273.15
      return suhuC + 273.15;
    default:
      return 0.0; 
  }
}