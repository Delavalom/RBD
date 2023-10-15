![Banner](/public/RBD_Banner.png)

# Red Bancaria Dominicana

La primera infraestructura bancaria open-source de la Republica Dominicana.

Este proyecto es una iniciativa para tener un standard de desarrollo, construir interoperabilidad e impulsar la tecnología bancaria en la Republica Dominicana.

## Configuración de desarrollo local

### Como generar codigo

- Genera un SQL CRUD con sqlc:

```bash
make sqlc
```

- Genera un mock de la Base de datos con gomock:

```bash
make mock
```

- Crea una nueva migration:

```bash
migrate create -ext sql -dir db/migrations -seq <migration_name>
```

## Contribution
Contribuye al desarrollo de este proyecto abriendo una pull request o reportando un issue.
