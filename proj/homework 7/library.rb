# frozen_string_literal: true

module Library
  def self.query(param)
    case param
    when 1 
      # Создать таблицу exam с полями:
      #- идентификатора экзамена - автоинкрементируемый, уникальный, запрещает NULL;
      #- наименования экзамена
      #- даты экзамена
      return "
      create table exam
      (
      exam_id int generated always as identity not null,
      exam_name varchar(32),
      exam_date date
      constraint exam_pkey Unique
      )
      "
    when 2 # Удалить ограничение уникальности с поля идентификатора
      return "
         alter table exam
         drop constraint exam_pkey
     "
    when 3 # Добавить ограничение первичного ключа на поле идентификатора
      return "
      alter table exam
      add constraint exam_pkey primary key(exam_id)
     "
    when 4 # Создать таблицу person с полями
           #- идентификатора личности (простой int, первичный ключ)
           #- имя
           #- фамилия
      return "
       create table person
        (
        person_id int,
        first_name varchar(30),
        last_name varchar(30),
        constraint person_pkid primary key(person_id)
        )
     "
    when 5  # Создать таблицу паспорта с полями:
            #- идентификатора паспорта (простой int, первичный ключ)
            #- серийный номер (простой int, запрещает NULL)
            #- регистрация
            #- ссылка на идентификатор личности (внешний ключ)
      return "
      create table passport
      (
      passport_id int,
      serial_number int not null,
      registration varchar(64),
      person_id int
      );
      alter table passport
      add constraint passport_kpid primary key(passport_id);
      alter table passport
      add constraint person_kpid foreign key(person_id) references person(person_id)
     "
    when 6 # Добавить колонку веса в таблицу book (создавали ранее) 
           #с ограничением, проверяющим вес (больше 0 но меньше 100)
      return "
        create table book
        (
        book_id int primary key,
        book_name varchar(64)
        );
        alter table book
        add column weight int;
        alter table book
        add constraint weight_kp check(weight>0 and weight<100)
     "
    when 7 # Убедиться в том, что ограничение на вес работает (попробуйте вставить невалидное значение)
      return "
      insert into book(book_id,book_name, weight) 
      values 
      (1,'Garry potter', 50);
      insert into book(book_id,book_name, weight) 
      values 
      (1,'Lord of the Rings', 100)
     "
    when 8 # Создать таблицу student с полями:
           #- идентификатора (автоинкремент)
           #- полное имя
           #- курс (по умолчанию 1)
      return "
      create table student
      (
      student_id int generated always as identity unique,
      full_name varchar(100),
      course int default  1
      )
     "
    when 9 # Вставить запись в таблицу студентов и убедиться, 
           #что ограничение на вставку значения по умолчанию работает
      return "
      insert into student(full_name) 
      values ('test full name');
      insert into student(full_name,course) 
      values ('test full name',2);
     "
        when 10 # Удалить ограничение "по умолчанию" из таблицы студентов
      return "
      alter table student 
      alter column course drop default
     "
        when 11 # Подключиться к БД northwind и добавить ограничение 
                #на поле unit_price таблицы products (цена должна быть больше 0)
      return "
      alter table products 
      add constraint unit_kpprice  check(unit_price >0)
      "
      when 12 # "Навесить" автоинкрементируемый счётчик на поле product_id таблицы products
      # (БД northwind). Счётчик должен начинаться с числа следующего за максимальным значением по этому столбцу
      return "
      DO $$
      DECLARE
          seq_count INTEGER;
      BEGIN
          -- Check if the sequence exists
          IF NOT EXISTS (SELECT 1 FROM pg_sequences WHERE sequencename = 'sequence_products') THEN
              -- Get the count of product_id from the products table
              SELECT COUNT(product_id) INTO seq_count FROM products;

              -- Create the sequence with the starting value
              EXECUTE format('CREATE SEQUENCE sequence_products START WITH %s', seq_count);

              -- Optionally, associate the sequence with the product_id column
              ALTER SEQUENCE sequence_products OWNED BY products.product_id;
          END IF;
      END $$;
      alter table products 
      alter column product_id set default nextval('sequence_products')
      "
      when 13 # Произвести вставку в products (не вставляя идентификатор явно) и убедиться, 
        #что автоинкремент работает. Вставку сделать так, чтобы в результате команды вернулось значение, 
        #сгенерированное в качестве идентификатора.
      return "
      insert into products(product_name,supplier_id,category_id,quantity_per_unit,unit_price, units_in_stock,units_on_order, reorder_level,discontinued)
      values 
      (1,1,1,1,1,1,1,1,0) returning product_id
      "
    end
    'SELECT current_database();'
  end
end
