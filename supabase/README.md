# Diecast Radar — merkezi katalog altyapısı

Bu klasör, gerçek Hot Wheels varyasyonları ve piyasa gözlemlerini merkezi olarak saklamak için **Supabase PostgreSQL şemasını** içerir.

## Başlangıç (ücretsiz)

1. Supabase üzerinde **Free** proje oluşturun.
2. SQL Editor üzerinden `supabase/schema.sql` içeriğini çalıştırın.
3. Table Editor'da gerçek kaynakları doğrulayarak `hw_variants` kayıtlarını ekleyin. `source_verified` alanını yalnızca doğruladığınız kayıtlarda `true` yapın.
4. İlan fiyatları için `price_observations` tablosuna durum (`active_listing`, `sold_verified`, `user_reported`) ve kaynak bağlantısı ekleyin. Yalnızca doğruladığınız kayıtların `verified` değerini `true` yapın.

## Güvenlik

RLS etkin; anonim ziyaretçiler yalnızca doğrulanmış kayıtları okuyabilir. Anonim yazma izni yoktur. **Supabase service_role anahtarını veya OpenAI API anahtarını GitHub Pages'e ya da istemci koduna koymayın.** İleride fotoğraf tanıma için sunucu tarafı Edge Function / güvenli backend kurulmalıdır.

## Durum

Henüz bir Supabase projesine bağlanılmadı. Merkezi katalog, fotoğrafla tanıma ve canlı ilan fiyatları **bu aşamada etkin değildir**. Mevcut web arayüzündeki örnek kayıtlar yalnızca demonstrasyon amaçlıdır. Gerçek kayıtlar için telif/lisans ve veri erişim koşulları doğrulanmalıdır.
