# DataMesh dbt Transforms

dbt project for the DataMesh platform medallion architecture.

## Models

```
bronze.orders_partitioned (source — dlt import from PostgreSQL)
  → staging.stg_orders (cleanup, type casting)
    → silver.orders_cleaned (filter cancelled, add year/month)
      → gold.revenue_by_country (aggregate by country + month)
```

## Usage

This project is used by the DataMesh platform's pipeline builder:
1. Create a pipeline with a Transform step (dbt Model mode)
2. Point to this repo and select the model to run
3. The dbt-runner clones this repo and executes against Spark Thrift Server

## Running locally

```bash
docker compose run dbt-runner -e DBT_SELECT=stg_orders
```
