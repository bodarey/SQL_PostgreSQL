# frozen_string_literal: true

module Library
  def self.query(param)
    case param
    when 1 # 1. Выбрать все заказы из стран France, Austria, Spain
      return "
      SELECT *
      FROM orders
      WHERE ship_country IN ('France', 'Austria', 'Spain')
      "
    when 2  # Выбрать все заказы, отсортировать по required_date 
      #(по убыванию) и отсортировать по дате отгрузке (по возрастанию)
      return "
     SELECT * 
     FROM orders
     ORDER BY required_date DESC, shipped_date ASC 
     "
    when 3 # Выбрать минимальное кол-во  единиц товара среди тех продуктов, которых в продаже более 30 единиц.
      return "
     SELECT MIN(units_on_order) 
     FROM products  
     WHERE units_on_order > 30
     "
    when 4  # Выбрать максимальное кол-во единиц товара среди тех продуктов, которых в продаже более 30 единиц.
      return "
     SELECT MAX(units_on_order) 
     FROM products  
     WHERE units_on_order > 30
     "
    when 5  # Найти среднее значение дней уходящих на доставку с даты формирования заказа в USA
      return "
     SELECT AVG(required_date - shipped_date)
     FROM orders
     WHERE ship_country ='USA'
     "
    when 6  # Найти сумму, на которую имеется товаров (кол-во * цену)
            # причём таких, которые планируется продавать и в будущем (см. на поле discontinued)
      return "
     SELECT SUM(unit_price * units_in_stock)
     FROM products  
     WHERE discontinued <> 1
     "
    
    end

    'SELECT current_database();'
  end
end
