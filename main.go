package main

import (
	"log"
	"database/sql"
	"github.com/rubenv/sql-migrate"
	_ "github.com/lib/pq"
)

func main() {
	migrations := &migrate.AssetMigrationSource {
		Asset:    Asset,
		AssetDir: AssetDir,
		Dir:      "migrations",
	}

	db, err := sql.Open("postgres", "sslmode=disable")

	if err != nil {
		log.Fatal(err)
	}

	migrate.SetTable("migrations")

	n, err := migrate.Exec(db, "postgres", migrations, migrate.Up)

	if err != nil {
		log.Fatal(err)
	}

	log.Print(n)
}
