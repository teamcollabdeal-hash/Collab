# Collabdeal: лендінг з реєстрацією (крок 1)

Файли:
- index.html: сайт (англійська, польська, українська; мова визначається автоматично)
- config.js: сюди вставляєте ключі Supabase
- privacy.html: політика конфіденційності (заповніть поля в [дужках])
- schema.sql: таблиця для реєстрацій

## Запуск за 10 хвилин

1. Supabase: створіть новий проєкт "collabdeal" (регіон Frankfurt, eu-central-1).
2. Supabase → SQL Editor → New query → вставте весь schema.sql → Run.
3. Supabase → Project Settings → API: скопіюйте Project URL і publishable (anon) key.
4. Відкрийте config.js і вставте їх у SUPABASE_URL і SUPABASE_KEY.
5. GitHub: створіть репозиторій collabdeal → Add file → Upload files → перетягніть усі файли.
6. Vercel → Add New → Project → оберіть репозиторій → Deploy (налаштування не потрібні).
7. Відкрийте сайт, зареєструйтесь тестово, перевірте в Supabase → Table Editor → signups.

## Як дивитися заявки
Supabase → Table Editor → signups. Або SQL:
select created_at, role, name, email, country, city, works_online, platforms, handle, creator_type
from public.signups order by created_at desc;

## Корисне
- Посилання з міткою джерела: ?ref=instagram, ?ref=zakordonom, ?ref=rowerexpress.
  Мітка зберігається в колонці ref, і видно, звідки прийшли люди.
- Мова примусово: ?lang=pl, ?lang=uk, ?lang=en.
- Лічильник "X з 500 місць" з'являється сам, коли підключено Supabase.
