<?php
// Auto-update Joomla manager email to dynamic flag on container start

$maxWaitSeconds = 180;
$start = time();

$dbHost = getenv('JOOMLA_DB_HOST') ?: 'mysql';
$dbUser = getenv('JOOMLA_DB_USER') ?: 'root';
$dbPass = getenv('JOOMLA_DB_PASSWORD') ?: '';
$dbName = getenv('JOOMLA_DB_NAME') ?: 'joomla';

$flag = @file_get_contents('/tmp/flag.txt');
if ($flag === false) {
    $flag = 'flag{missing_flag_txt}';
}
$flag = trim($flag);

function findUsersTable(mysqli $mysqli): ?string {
    $sql = "SELECT t.table_name
            FROM information_schema.tables t
            JOIN information_schema.columns c1
              ON c1.table_schema = t.table_schema AND c1.table_name = t.table_name AND c1.column_name = 'username'
            JOIN information_schema.columns c2
              ON c2.table_schema = t.table_schema AND c2.table_name = t.table_name AND c2.column_name = 'email'
            WHERE t.table_schema = DATABASE() AND t.table_name LIKE '%\\_users'
            LIMIT 1";
    if ($res = $mysqli->query($sql)) {
        if ($row = $res->fetch_row()) {
            return $row[0];
        }
    }
    return null;
}

while (time() - $start < $maxWaitSeconds) {
    $mysqli = @new mysqli($dbHost, $dbUser, $dbPass, $dbName);
    if ($mysqli && !$mysqli->connect_errno) {
        $usersTable = findUsersTable($mysqli);
        if ($usersTable) {
            $stmt = $mysqli->prepare("UPDATE `{$usersTable}` SET email=? WHERE username='manager'");
            if ($stmt) {
                $stmt->bind_param('s', $flag);
                $stmt->execute();
                echo "init-update: updated {$usersTable} manager email to flag\n";
                exit(0);
            }
        }
    }
    sleep(2);
}

echo "init-update: timeout, update not applied\n";
exit(0);


