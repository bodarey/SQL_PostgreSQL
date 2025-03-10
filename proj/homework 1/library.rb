# frozen_string_literal: true

module Library
  def self.query(param)
    case param
    when 1 # 1. Выбрать все данные из таблицы customers
      return 'SELECT * FROM customers'
    when 2
      return "
     SELECT contact_name, city FROM customers
     "
    when 3 # Выбрать все записи из таблицы orders, но взять две колонки: идентификатор заказа и колонку,
      # значение в которой мы рассчитываем как разницу между датой отгрузки и датой формирования заказа.
      return "
     SELECT order_id, shipped_date - order_date AS difference  FROM orders
     "
    when 4  # Выбрать все уникальные города в которых "зарегестрированы" заказчики
      return "
     SELECT DISTINCT ship_city FROM orders
     "
    when 5  # Выбрать все уникальные сочетания городов и стран в которых "зарегестрированы" заказчики
      return "
     SELECT DISTINCT(ship_city, ship_country) as city_country FROM orders
     "
    when 6  # Посчитать кол-во заказчиков
      return "
     SELECT count(customer_id) as count_customers FROM orders
     "
    when 7  # Посчитать кол-во уникальных стран в которых "зарегестрированы" заказчики
      return "
     SELECT count(Distinct ship_country) as countries_customers FROM orders
     "
    end

    'SELECT current_database();'
  end
end
