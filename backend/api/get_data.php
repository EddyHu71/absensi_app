<?php
	include "../db/db.php";
	include "../db/action.php";
	date_default_timezone_set("Asia/Jakarta");
	$now = date("Y-m-d H:i");
	$tanggal = date("Y-m-d");
	$waktu = date("H:i");
	$url = "http://127.0.0.1/";
	
	$db = new Crud();
	
	if (isset($_POST['get_api'])) {
		$get = $_POST['get_api'];
		$tokenLogin = $_POST['get_token_login'];
		
		$cektoken = $db->fetchwhere("table_user", "token_login_user = '$tokenLogin'");
		
		if ($cektoken) {
			if ($get == "auth_absen") {
				$idUser = $_POST['id_user'];
				$cekabsen = $db->fetchwhere("table_absent", "date_absent = '$tanggal' && id_user_absent = '$idUser'");
				if ($cekabsen) {
					$cekAbsenIn = $db->fetchwhere("table_absent", "absen_in_absent IS NULL && absen_out_absent IS NULL");
					$cekAbsenInnotNull = $db->fetchwhere("table_absent", "absen_in_absent IS NOT NULL && absen_out_absent IS NOT NULL");
					if ($cekAbsenIn || $cekAbsenInnotNull) {
						$datas = array(
							"status" => "no_absen"
						);
						echo json_encode($datas);
						exit();
					} else {
						$datas = array(
							"status" => "absen_in"
						);
						echo json_encode($datas);
						exit();
					}
				} else {
					$datas = array(
						"status" => "no_absen",
					);
					echo json_encode($datas);
					exit();
				}
			}
			
			if ($get == "get_list") {
				$checkDateIn = $_POST['check_date_in'];
				$checkDateOut = $_POST['check_date_out'];
				$dataAbsen = [];
				$number = "";
				
				if ($checkDateIn == "" || $checkDateOut == "") {
					$arr = array(
						"status" => "404",
						"data" => "not found",
					);
					echo json_encode($arr);
					exit();
				} else {
					$absensi = $db->fetchwhereorder("table_absent", "date_absent >= '$checkDateIn' && date_absent <= '$checkDateOut'", "id_absent ASC");
					if (count($absensi)> 0) {
						foreach ($absensi as $absen) {
							$number++;
							$idUser = $absen['id_user_absent'];
							$namaUser = $db->fetchwhere("table_user", "id_user='$idUser'");
							foreach ($namaUser as $namas) {
								$nama = $namas['name_user'];
							}
							$dates = $absen['date_absent'];
							$absenIn = $absen['absen_in_absent'];
							$absenOut = $absen['absen_out_absent'];
							// $diff = intval(strtotime($absenOut) - strtotime($absenIn));
							$conabsenin = strtotime($absenIn);
							$conabsenout = strtotime($absenOut);
							$interval = $conabsenout - $conabsenin;
							$jam = floor($interval / 3600);
							$menit = floor(($interval - ($jam * 3600)) / 60);
							$datas = array(
								"nomor_user" => $number,
								"nama_user" => $nama,
								"tanggal_absen" => $dates,
								"jam_lama_kerja" => $jam,
								"menit_lama_kerja" => $menit,
								"absen_in" => substr($absenIn, 11),
								"absen_out" => substr($absenOut, 11),
							);
							
							array_push($dataAbsen, $datas);
						}
						
						$arrAbsen = array(
							"status" => "200",
							"data" => $dataAbsen,
						);
						echo json_encode($arrAbsen);
						exit();
					} else {
						$arr = array(
							"status" => "404",
							"data" => "not found",
						);
						echo json_encode($arr);
						exit();
					}
				}
			}
		}
	}
?>