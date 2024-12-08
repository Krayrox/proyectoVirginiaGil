<?php
session_start();

// Verificar si el usuario está autenticado
if (!isset($_SESSION['username'])) {
    header("Location: ../index.php"); // Redirige al inicio de sesión si no hay sesión activa
    exit();
}

// Conectar a la base de datos
require_once '../conn/db.php';

// Obtener el nombre del administrador
$username = $_SESSION['username'];
$query = "SELECT nombre FROM administradores WHERE username = ?";
$stmt = $pdo->prepare($query);
$stmt->execute([$username]);
$result = $stmt->fetch(PDO::FETCH_ASSOC);

$adminName = $result['nombre'] ?? 'Administrador';
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Panel de Administrador</title>
    <link rel="stylesheet" href="../styles/styles_inicio.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f9;
        }
        .header {
            background-color: #007bff;
            color: white;
            padding: 1rem;
            text-align: center;
        }
        .content {
            padding: 2rem;
            text-align: center;
        }
        .content h2 {
            color: #333;
        }
        .logout-btn {
            background-color: #dc3545;
            color: white;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
            border-radius: 5px;
            font-size: 16px;
        }
        .logout-btn:hover {
            background-color: #c82333;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>Bienvenido, <?= htmlspecialchars($adminName) ?></h1>
    </div>
    <div class="content">
        <h2>Panel de Administración</h2>
        <p>Desde aquí puedes gestionar el sistema.</p>
        <a href="opciones.php"><button class="logout-btn">Ver Opciones</button></a>
        <form method="POST" style="margin-top: 20px;">
            <button type="submit" name="logout" class="logout-btn">Cerrar Sesión</button>
        </form>
    </div>
</body>
</html>

<?php
// Cerrar sesión si el usuario hace clic en "Cerrar Sesión"
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['logout'])) {
    session_destroy();
    header("Location: ../index.php");
    exit();
}
?>
