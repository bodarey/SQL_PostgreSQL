# frozen_string_literal: true

module Library
  def self.query(param)
    case param
    when 1 # Создать таблицу teacher с полями
      # teacher_id serial, first_name varchar, last_name varchar, birthday date, phone varchar, title varchar
      return "
        CREATE TABLE teacher
        (
          teacher_id serial,
          first_name varchar,
          last_name varchar,
          birthday date,
          phone varchar,
          title varchar
        )
      "
    when 2 # Добавить в таблицу после создания колонку middle_name varchar
      return "
          alter table teacher
          add column middle_name varchar
     "
    when 3 # Удалить колонку middle_name
      return "
       alter table teacher
       drop column middle_name
     "
    when 4 # Переименовать колонку birthday в birth_date
      return "
       alter table teacher
       rename  column birthday to birthday_date
     "
    when 5 # Изменить тип данных колонки phone на varchar(32)
      return "
       alter table teacher
       alter column phone type varchar(32)
     "
    when 6 # Создать таблицу exam с полями exam_id serial, exam_name varchar(256), exam_date date
      return "
      create table exam
      (
        exam_id serial,
        exam_name varchar(256),
        exam_date date
      )
     "
    when 7 # Вставить три любых записи с автогенерацией идентификатора
      return "
      alter table exam
      add primary key(exam_id);
      insert into exam(exam_name,exam_date)
      values
      ('first exam','2000-01-15'),
      ('second exam','2000-02-15'),
      ('third exam','2000-03-15')

     "
    when 8 # Посредством полной выборки убедиться, что данные были
      # вставлены нормально и идентификаторы были сгенерированы с инкрементом
      return "
      select * from exam;

     "
    when 9 #  Удалить все данные из таблицы со сбросом идентификатор в исходное состояние
      return "
      truncate table exam restart identity;

     "
    end
    'SELECT current_database();'
  end
end
