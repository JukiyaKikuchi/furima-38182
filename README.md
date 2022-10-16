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
| birthday           | date   | null: false                |

## Association
- has_many : orders
- has_many : items
----------------------------------------------------------------------

## itemsテーブル

| Column               | Type        | Options                            |
|----------------------|-------------|------------------------------------|
| item_name            | string      | null: false                        |
| item_description     | text        | null: false                        |
| category_id          | integer     | null: false                        |
| item_status_id       | integer     | null: false                        |
| delivery_cost_id     | integer     | null: false                        |
| delivery_date_id     | integer     | null: false                        |
| prefecture_id        | integer     | null: false                        |
| item_price           | integer     | null: false                        |
| user                 | references  | null: false, foreign_key: true     |

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
| building        | string     |                                |
| tell_number     | string     | null: false                    |
| prefecture_id   | integer    | null: false                    |
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
- has_one : delivery
- belongs_to : user
- belongs_to : item