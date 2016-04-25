# Mysql filter plugin for Embulk

Mysql filter plugin for Embulk. Execute prepared statements query.

## Overview

* **Plugin type**: filter

## Configuration

- **host**: host(string, default: 'localhost')
- **user**: user(string, required)
- **password**: password(string, required)
- **database**: database(string, required)
- **port**: port(integer, default: 3306)
- **query**: query(string, required)
- **params**: params(array, required)
- **keep_input**: keep_input(bool, default: true)

## Example

```yaml
in:
  type: s3
  bucket: machine-learning-production
  path_prefix: customer-approval/batch-prediction/result/
  endpoint: s3.amazonaws.com
  auth_method: {{ env.EMBULK_S3_AUTH_METHOD }}
  decoders:
  - {type: gzip}
  parser:
    type: csv
    delimiter: ","
    skip_header_lines: 1
    allow_extra_columns: true
    allow_optional_columns: true
    columns:
      - {name: user_id, type: long}
      - {name: trueLabel, type: string}
      - {name: bestAnswer, type: string}
      - {name: score, type: double}
filters:
  - type: mysql
    host: {{ env.DATABASE_HOST | default: "localhost" }}
    user: {{ env.APPLICATION_USERNAME }}
    password: {{ env.APPLICATION_DATABASE_PASS }}
    database: {{ env.APPLICATION_DATABASE }}
    keep_input: true
    query: |
      select 
        id,
        last_name,
        first_name,
        company_name
      from
        user
      where id = ?
    params:
      - user_id
out:
  type: stdout
```

#### input CSV
```
user_id,trueLabel,bestAnswer,score
1,0,0,1.5
2,0,0,1.5
3,0,0,1.5
```

#### Running query
```
  select 
    id,
    last_name,
    first_name,
    company_name
  from
    user
  where id = 1;

  select 
    id,
    last_name,
    first_name,
    company_name
  from
    user
  where id = 2;

  select 
    id,
    last_name,
    first_name,
    company_name
  from
    user
  where id = 3;
```


## Build

```
$ rake
```
