
module Library

def self.query param
    if param == 1  #1. Выбрать все данные из таблицы customers
     return "SELECT * FROM customers"
    else
    if param == 2  #Выбрать все записи из таблицы customers, но только колонки "имя контакта" и "город"
     return "
     SELECT contact_name, city FROM customers 
     "
     end
     if param == 3  # Выбрать все записи из таблицы orders, но взять две колонки: идентификатор заказа и колонку, 
        #значение в которой мы рассчитываем как разницу между датой отгрузки и датой формирования заказа.
     return "
     SELECT order_id, shipped_date - order_date AS difference  FROM orders
     "
     end

     if param == 4  # Выбрать все уникальные города в которых "зарегестрированы" заказчики
     return "
     SELECT DISTINCT ship_city FROM orders
     "
     end

     if param == 5  # Выбрать все уникальные сочетания городов и стран в которых "зарегестрированы" заказчики
     return "
     SELECT DISTINCT(ship_city, ship_country) as city_country FROM orders
     "
     end

     if param == 6  # Посчитать кол-во заказчиков
     return "
     SELECT count(customer_id) as count_customers FROM orders
     "
     end

     if param == 7  # Посчитать кол-во уникальных стран в которых "зарегестрированы" заказчики
     return "
     SELECT count(Distinct ship_country) as countries_customers FROM orders
     "
     end

    end
  return 1 
end

end

