# frozen_string_literal: true

module Library
  def self.query(param)
    case param
    when 1 # 1 Найти заказчиков и обслуживающих их заказы сотрудников таких, что и заказчики и сотрудники из города London,
           # а доставка идёт компанией Speedy Express. Вывести компанию заказчика и ФИО сотрудника.
      return "
      SELECT customers.company_name AS customer_company, employees.first_name as employees_first_name, employees.last_name as employees_last_name
      FROM orders
      join employees USING(employee_id) 
      join customers on orders.customer_id = customers.customer_id
      join shippers on shippers.shipper_id = orders.ship_via 
      where customers.city like '%London%' and employees.city like '%London%'
      AND shippers.company_name Like '%Speedy Express%'
      "
    when 2 # Найти активные (см. поле discontinued) продукты из категории Beverages и Seafood, которых в продаже менее 
         # 20 единиц.Вывести наименование продуктов, кол-во единиц в продаже, имя контакта поставщика и его телефонный номер.
     return "
       SELECT product_name, units_in_stock, contact_name, phone
     FROM products 
     join categories Using(category_id)
     join suppliers USING(supplier_id)
     where (category_name  like 'Beverages' or category_name like 'Seafood') and (units_in_stock < 20 and discontinued <> 1)
     order by units_in_stock     
     "
    when 3 #Найти заказчиков, не сделавших ни одного заказа. Вывести имя заказчика и order_id.
      return "
     SELECT company_name, order_id
     FROM customers
     LEFT JOIN orders using(customer_id)
     WHERE order_id is null
     "
    when 4  # Переписать предыдущий запрос, использовав симметричный вид джойна (подсказка: речь о LEFT и RIGHT).
      return "
     SELECT company_name, order_id
     FROM orders
     RIGHT JOIN customers using(customer_id)
     WHERE order_id is null
     "
   
    end

    'SELECT current_database();'
  end
end
