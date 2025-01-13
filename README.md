## usersテーブル (ユーザー情報)

| Column             | Type   | Options             |
|--------------------|--------|---------------------|
| nickname           | string | null: false         |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false         |
| last_name          | string | null: false         |
| first_name         | string | null: false         |
| last_name_kana     | string | null: false         |
| first_name_kana    | string | null: false         |
| birth_date         | date   | null: false         |

### Association
- has_many :items
- has_many :purchases

---

## itemsテーブル (商品情報)

| Column                    | Type       | Options                         |
|---------------------------|------------|---------------------------------|
| product_name              | string     | null: false                     |
| product_description       | text       | null: false                     |
| category_id               | integer    | null: false                     |
| item_status_id            | integer    | null: false                     |
| shipping_cost_burden_id   | integer    | null: false                     |
| shipping_from_id          | integer    | null: false                     |
| shipping_day_id           | integer    | null: false                     |
| price                     | integer    | null: false                     |
| user                      | references | null: false, foreign_key: true  |

### Association
- belongs_to :user
- has_one :purchase

---

## purchasesテーブル (購入情報)

| Column    | Type       | Options                        |
|-----------|------------|--------------------------------|
| user      | references | null: false, foreign_key: true |
| item      | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item
- has_one :address

---

## addressesテーブル (配送先情報)

| Column         | Type       | Options                         |
|----------------|------------|---------------------------------|
| purchase       | references | null: false, foreign_key: true  |
| postal_code    | string     | null: false                     |
| shipping_from_id | integer    | null: false                     |
| city           | string     | null: false                     |
| street_address | string     | null: false                     |
| building_name  | string     |                                 |
| phone_number   | string     | null: false                     |

### Association
- belongs_to :purchase

