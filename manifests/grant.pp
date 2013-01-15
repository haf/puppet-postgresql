# Summary
#   Grants permissions on resources to roles
#
define postgresql::grant(
    $privilege = 'ALL',
    $resource,
    $resource_type = 'table',
    $role = 'postgres',
    $psql_db = 'postgres',
    $psql_user='postgres'
) {

  $db = $psql_db ? {
    undef => 'postgres',
    default => $psql_db
  }

  postgresql::psql {"GRANT $privilege ON $resource TO $role":
    db      => $db,
    user    => $psql_user,
    unless  => "SELECT 1 WHERE has_${resource_type}_privilege('$role', '$resource', '$privilege')",
  }
}