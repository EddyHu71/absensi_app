class ContentLogin {
  String statusLogin;
  String tokenLogin;
  Users users;

  ContentLogin.fromJson(Map<String, dynamic> parsed) {
    statusLogin = parsed['status_login'].toString();
    tokenLogin = parsed['token_login'];
    users = Users.fromJson(parsed['content']);
  }
}

class Users {
  String idUser;
  String nameUser;
  String emailUser;
  String passUser;

  Users.fromJson(Map<String, dynamic> parsed) {
    idUser = parsed['id_user'].toString();
    nameUser = parsed['name_user'];
    emailUser = parsed['email_user'];
  }
}

class Attendance {
  String nomorAbsen;
  String name;
  String tanggal;
  String absenIn;
  String absenOut;
  String jamLamaKerja;
  String menitLamaKerja;

  Attendance.fromJson(Map<String, dynamic> parsed) {
    nomorAbsen = parsed['nomor_user'].toString();
    name = parsed['nama_user'] == null ? "Nama" : parsed['nama_user'];
    tanggal =
        parsed['tanggal_absen'] == null ? "Tanggal" : parsed['tanggal_absen'];
    absenIn = parsed['absen_in'] == null ? "Absen In" : parsed['absen_in'];
    absenOut = parsed['absen_out'] == null ? "Absen Out" : parsed['absen_out'];
    jamLamaKerja = parsed['jam_lama_kerja'].toString() == null
        ? "Jam Lama Kerja"
        : parsed['jam_lama_kerja'].toString();
    menitLamaKerja = parsed['menit_lama_kerja'].toString() == null
        ? "Menit Lama Kerja"
        : parsed['menit_lama_kerja'].toString();
  }
}
