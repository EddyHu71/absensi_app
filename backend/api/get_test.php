<?php
	include "../db/db.php";
	include "../db/action.php";
	date_default_timezone_set("Asia/Jakarta");
	$now = date("Y-m-d H:i");
	$tanggal = date("Y-m-d");
	$url = "http://127.0.0.1/";
	
	$db = new Crud();


	if (isset($_POST['post'])) {
		$post = $_POST['post'];

		if ($post == "cek_login") {
			$tokens = $_POST['token_login'];
			$ceklogin = $db->fetchwhere("table_user", "token_login_user = '$tokens'");
			if (count($ceklogin) > 0) {
				foreach ($ceklogin as $ceks) {
					$idUser = $ceks['id_user'];
					$nameUser = $ceks['name_user'];
					$emailUser = $ceks['email_user'];
					$tokenLogin = $ceks['token_login_user'];
					$lastLogin = $ceks['last_login_user'];
				}
				
				if ($lastLogin != "banned") {
					if ($tokenLogin != "0") {
						$arrayuser = array(
							"id_user" =>  $idUser,
							"name_user" => $nameUser,
							"email_user" => $emailUser,
						);
						$data = array(
							"token_login" => $tokenLogin,
							"status_login" => "200",
							"content" => $arrayuser,
						);
						echo json_encode($data);
						exit();
					} else {
						$data = array(
							"status_login" => "banned",
						);
						echo json_encode($data);
						exit();
					}
				}
			} else {
				$data = array(
					"status_login" => "0",
				);
				echo json_encode($data);
				exit();
			}
		}
		if ($post == "login_user") {
			$email = $_POST['email_login'];
			$password = $_POST['pass_login'];
			$pass = hash('sha256', $password);
			$validasi = filter_var($email, FILTER_VALIDATE_EMAIL);
			if ($validasi) {
				$ceklogin = $db->fetchwhere("table_user", "email_user ='$email' && pass_user = '$pass'");
				if (count($ceklogin) > 0) {
					foreach ($ceklogin as $login) {
						$idUser = $login['id_user'];
						$nameUser = $login['name_user'];
						$emailUser = $login['email_user'];
						$passUser = $login['pass_user'];
						$tokenLogin = $login['token_login_user'];
						$lastLogin = $login['last_login_user'];
					}
					
					if ($lastLogin != "banned") {
						if ($tokenLogin == "0") {
							$rand1 = rand(100, 999);
							$rand2 = rand(999, 9999);
							$tokennumber = $rand1.$rand2;
							$encryptoken = md5($tokennumber);
							$wheres = array(
								"id_user" => $idUser,
							);
							$updateData = array(
								"last_login_user" => $now,
								"token_login_user" => $encryptoken,
								"last_login_user" => $now,
							);
							$updates = $db->update("table_user", $wheres, $updateData);
							if ($updates) {
								$arrayuser = array(
									"id_user" =>  $idUser,
									"name_user" => $nameUser,
									"email_user" => $emailUser,
								);
								$data = array(
									"token_login" => $encryptoken,
									"status_login" => "200",
									"content" => $arrayuser,
								);
								echo json_encode($data);
								exit();
							}
						} else {
							$data = array(
								"status_login" => "invalid_user",
							);
							echo json_encode($data);
							exit();
						}
					} else {
						$data = array(
							"status_login" => "banned",
						);
						echo json_encode($data);
						exit();
					}
				} else {
					$data = array(
						"status_login" => "invalid_user"
					);
					echo json_encode($data);
					exit();
				}
			}
		}
	
		if ($post == "register_user") {
			$name = $_POST['register_name'];
			$email = $_POST['register_email'];
			$pass = hash('sha256', $_POST['register_pass']);
			$validasiEmail = filter_var($email, FILTER_VALIDATE_EMAIL);
			
			if ($validasiEmail) {
				$cek = $db->fetchwhere("table_user", "email_user='$email'");
				if ($cek) {
					$data = array(
						"status" => "email_taken",
					);
					echo json_encode($data);
					exit();
				} else {
					$arraydata = array(
						"name_user" => $name,
						"email_user" => $email,
						"pass_user" => $pass,
						"last_login_user" => "0",
						"token_login_user" => "0",
					);
					
					$newuser = $db->insert("table_user", $arraydata);
					if ($newuser) {
						$data = array(
							"status" => "register_berhasil",
						);
						echo json_encode($data);
						exit();
					} else {
						$data = array(
							"status" => "register_gagal",
						);
						echo json_encode($data);
						exit();
					}
				}
			} else {
				$data = array(
					"status" => "email_invalid",
				);
				echo json_encode($data);
				exit();
			}
			
		}
		
		if ($post == "logout_user") {
			$idUser = $_POST['logout_id_user'];
			$tokenUser = $_POST['logout_token_user'];
			$ceklogout = $db->fetchwhere("table_user", "token_login_user = '$tokenUser' && id_user = '$idUser'");
			if ($ceklogout) {
				$data = array(
					"token_login_user" => "0",
				);
				$wheres = array(
					"id_user" => $idUser,
				);
				$logout = $db->update("table_user", $wheres, $data);
				if ($logout) {
					echo json_encode("logout_success");
					exit();
				} else {
					echo json_encode("logout_gagal");
					exit();
				}
			} else {
				echo json_encode("logout_gagal");
				exit();
			}
		}
		
	}
?>