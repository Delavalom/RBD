![Banner](/public/RBD_Banner.png)

# Red Bancaria Dominicana

La primera infraestructura bancaria open-source de la Republica Dominicana.

Este proyecto es una iniciativa para tener un standard de desarrollo, construir interoperabilidad e impulsar la tecnología bancaria en la Republica Dominicana.

## Configuración de desarrollo local

### Configuración de la infraestructura

- Crear la red del banco

```bash
make network
```

- Iniciar el contenedor de PostgreSQL:

```bash
make postgres
```

- Crear la base de datos simple_bank:

```bash
make createdb
```

- Ejecutar la migración de la base de datos a todas las versiones:

```bash
make migrateup
```

- Ejecutar la migración de la base de datos a 1 versión:

```bash
make migrateup1
```

- Revertir la migración de la base de datos en todas las versiones:

```bash
make migratedown
```

- Revertir la migración de la base de datos en 1 versión:

```bash
    make migratedown1
```

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

### Cómo ejecutar

- Ejecutar el servidor:

```bash
    make server
```

- Ejecutar pruebas:

```bash
    make test
```

## Implementar en un clúster de Kubernetes

- [Instalar el controlador de ingreso nginx](https://kubernetes.github.io/ingress-nginx/deploy/#aws):

```bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.48.1/deploy/static/provider/aws/deploy.yaml
```

- [Instalar cert-manager](https://cert-manager.io/docs/installation/kubernetes/):

```bash
kubectl apply -f https://github.com/jetstack/cert-manager/releases/download/v1.4.0/cert-manager.yaml
```

## Contribution

Contribuye al desarrollo de este proyecto abriendo una pull request o reportando un issue.
