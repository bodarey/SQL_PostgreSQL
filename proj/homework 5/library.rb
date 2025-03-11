# frozen_string_literal: true

module Library
  def self.query(param)
    case param
    when 1 # 1 Вывести продукты количество которых в продаже меньше самого малого среднего
      # количества продуктов в деталях заказов (группировка по product_id). Результирующая
      # таблица должна иметь колонки product_name и units_in_stock.
      return "
        select product_name, units_in_stock
        from products
        where products.units_in_stock < any(select min(q)
        from (
        select AVG(quantity) as q
        from order_details
        group by product_id
        order by product_id) as avgq)
      "
    when 2 # Напишите запрос, который выводит общую сумму фрахтов заказов для компаний-заказчиков для заказов,
      # стоимость фрахта которых больше или равна средней величине стоимости фрахта всех заказов, а также дата
      # отгрузки заказа должна находится во второй половине июля 1996 года. Результирующая таблица должна иметь
      # колонки customer_id и freight_sum, строки которой должны быть отсортированы по сумме фрахтов заказов.
      return "
          SELECT
              customer_id,
              SUM(freight) AS freight_sum
          FROM
              orders
          WHERE
              freight >= (SELECT AVG(freight) FROM orders) -- Фильтруем заказы с фрахтом >= среднего
              AND shipped_date >= '1996-07-16' -- Вторая половина июля 1996 года
              AND shipped_date <= '1996-07-31'
          GROUP BY
              customer_id
          ORDER BY
              freight_sum DESC; -- Сортировка по сумме фрахтов в порядке убывания
     "
    when 3 # Напишите запрос, который выводит 3 заказа с наибольшей стоимостью, которые были созданы
      # после 1 сентября 1997 года включительно и были доставлены в страны Южной Америки. Общая стоимость
      # рассчитывается как сумма стоимости деталей заказа с учетом дисконта. Результирующая таблица должна
      # иметь колонки customer_id, ship_country и order_price, строки которой должны быть отсортированы по
      # стоимости заказа в обратном порядке.
      return "
       select customer_id, ship_country, order_price
        from orders
        join (
            select SUM(unit_price * quantity * (1 - discount)) as order_price, order_id
            from order_details
            group by order_id
        ) as table_sum_orders_id
        using(order_id)
        where order_date >= '1997-09-01'
        and ship_country in ('Venezuela', 'Brazil','Argentina','Colombia','Peru','Chile','Ecuador','Bolivia','Paraguay','Uruguay','Guyana','Suriname','French Guiana','Falkland Islands')
        order by order_price desc
        limit 3
     "
    when 4 # Вывести все товары (уникальные названия продуктов),
      # которых заказано ровно 10 единиц (конечно же, это можно решить и без подзапроса).
      return "
       select product_name
       from products
       where product_id in (
          select product_id
          from order_details
          where order_details.quantity=10
)
     "

    end

    'SELECT current_database();'
  end
end
