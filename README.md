# テーブル設計

## usersテーブル

| Column             | Type   | Options                    |
|--------------------|--------|----------------------------|
| nickname           | string | null: false                |
| email              | string | null: false, unique: true  |
| encrypted_password | string | null: false                |
| last_name          | string | null: false                |
| first_name         | string | null: false                |
| last_name_kana     | string | null: false                |
| first_name_kana    | string | null: false                |
| birthday           | string | null: false                |

## Association
- has_many : orders
- has_many : items
----------------------------------------------------------------------

## itemsテーブル

| Column            | Type       | Options                            |
|-------------------|------------|------------------------------------|
| image             | string     | null: false                        |
| item_name         | string     | null: false                        |
| item_description  | text       | null: false                        |
| category          | string     | null: false                        |
| item_status       | string     | null: false                        |
| delivery_cost     | string     | null: false                        |
| delivery_date     | string     | null: false                        |
| prefecture        | string     | null: false                        |
| item_price        | string     | null: false                        |
| user              | references | null: false, foreign_key: true     |

## Association
- has_one: order
- belongs_to :user
-------------------------------------------------------------------------

## deliveriesテーブル

| Column          | Type       | Options                        |
|-----------------|------------|--------------------------------|
| postcode        | string     | null: false                    |
| city            | string     | null: false                    |
| address         | string     | null: false                    |
| building        | string     | null: false                    |
| tell_number     | string     | null: false                    |
| prefecture      | string     | null: false                    |
| order           | references | null: false, foreign_key: true |


## Association
- belongs_to : order
-------------------------------------------------------------------------

## ordersテーブル

| Column          | Type       | Options                        |
|-----------------|------------|--------------------------------|
| user            | references | null: false, foreign_key: true |
| item            | references | null: false, foreign_key: true |


## Association
- has_one : deliveries
- belongs_to : user
- belongs_to : item