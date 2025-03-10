# frozen_string_literal: true

module Library
  def self.query(param)
    case param
    when 1 # 1.Выбрать все записи заказов в которых наименование страны отгрузки начинается с 'U'
      return "
      SELECT *
      FROM orders
      WHERE ship_country LIKE 'U%'
      "
    when 2 # Выбрать записи заказов (включить колонки идентификатора заказа, идентификатора заказчика,
      # веса и страны отгузки), которые должны быть отгружены в страны имя которых начинается с 'N',
      # отсортировать по весу (по убыванию) и вывести только первые 10 записей.
      return "
     SELECT order_id, customer_id, freight, ship_country
     FROM orders
     Where ship_country LIKE 'N%'
     ORDER BY freight DESC
     LIMIT 10
     "
    when 3 # Выбрать записи работников (включить колонки имени, фамилии, телефона, региона) в которых регион неизвестен
      return "
     SELECT first_name, last_name, region, home_phone
     FROM employees
     WHERE region is null
     "
    when 4  # Подсчитать кол-во заказчиков регион которых известен
      return "
     SELECT COUNT(customer_id)
     FROM customers
     WHERE region is not null
     "
    when 5  # Подсчитать кол-во поставщиков в каждой из стран и отсортировать результаты группировки по убыванию кол-ва
      return "
     SELECT country, count(country) as number_of_suppliers
     FROM suppliers
     Group by country
     order by count(country) DESC
     "
    when 6  # Подсчитать суммарный вес заказов (в которых известен регион)
      # по странам, затем отфильтровать по суммарному весу (вывести только те записи где
      # суммарный вес больше 2750) и отсортировать по убыванию суммарного веса.
      return "
     SELECT ship_country, SUM(freight) total_freight
     FROM orders
     WHERE ship_region is not null
     group by ship_country
     HAVING sum(freight) > 2750
     order by sum(freight) desc
     "
    when 7 # Выбрать все уникальные страны заказчиков и поставщиков и отсортировать страны по возрастанию
      return "
     SELECT country
     FROM customers
     union
     SELECT country
     FROM suppliers
     order by country
     "
    when 8  # Выбрать такие страны в которых "зарегистированы" одновременно и заказчики и поставщики и работники.
      return "
     SELECT country
     FROM customers
     INTERSECT
     SELECT country
     FROM suppliers
     INTERSECT
     SELECT country
     from employees
     order by country
     "
    when 9  # Выбрать такие страны в которых "зарегистированы"
      # одновременно заказчики и поставщики, но при этом в них не "зарегистрированы" работники.
      return "
     SELECT country
     FROM customers
     INTERSECT
     SELECT country
     FROM suppliers
     EXCEPT
     SELECT country
     from employees
     
     "
    end

    'SELECT current_database();'
  end
end
