# Oto Sanayi Kayit Sistemi Projesi 


##
“Oto Tamir Kayıt Sistemi” projemin amacı bir oto tamiri yapan bir servisin iş
süreçlerini dijitalleştiren ve kolaylaştıran bir veritabanı tasarımıdır. Aşağıda bu sistemin
günlük hayatta çözdüğü genel problemler ve kolaylıklar verilmiştir.

- **Sorun 1 :** Müşteri bilgilerini elle takip etmek zaman alıcıdır ve hata riski yüksektir.
- **Çözüm 1 :** Müşteriler tablosu ile her müşterinin adı, soyadı, iletişim bilgileri ve bakiye durumu
gibi veriler düzenli bir şekilde saklanır.

- **Sorun 2 :** Servise gelen ve işlem gören araçların her birinin kaydını tutmak zor olabilir.
- **Çözüm 2 :** Araçlar Tablosu, araçların plaka, marka, model, kilometre, yakıt tipi gibi özelliklerini
saklayarak araçlarla ilgili bilgilerin her zaman erişilebilir olmasını sağlar.

- **Sorun 3 :** Tamir işlemleri sırasında yapılan işleri ve kullanılan parçaları manuel takip etmek
karmaşıklığa yol açabilir.
- **Çözüm 3 :** Tamir İşlemleri Tablosu sayesinde her tamir işlemi tarih, sorun açıklaması, yapılan
işlem ve maliyet bilgisiyle kaydedilir.

- **Sorun 4 :** Hangi personelin hangi işlemle ilgilendiğinin takibi zor olabilir.
- **Çözüm 4 :** Tamir-Personel İlişkisi, tamir sürecinde görev alan personeli takip etmeyi sağlar.
Personel-Randevu İlişkisi, personelin hangi randevularla ilgilendiğini gösterir.

- **Sorun 5 :** Ödeme süreçlerinde kayıtların eksik veya hatalı tutulması, mali problemlere yol
açabilir.
- **Çözüm 5 :** Ödemeler Tablosu, tamir işlemlerine bağlı ödemelerin kaydını tutarak bu süreci
şeffaf ve düzenli hale getirir.
##
Bu sistem, otomotiv servisleri için süreçleri dijitalleştirerek günlük hayatı kolaylaştırır.
Müşteri bilgileri, araç kayıtları, tamir işlemleri, ödemeler ve yedek parça stokları tek bir
platformda yönetilir.Bu sayede manuel işlem yapma zorunluluğu ortadan kalkar, iş süreçleri
daha hızlı ve düzenli bir şekilde yürütülür. Randevular, tamir işlemleri ve stok bilgileri kolayca
takip edilebilir, insan hataları en aza indirilir. Hem müşteriler hem de çalışanlar için zaman
tasarrufu sağlanırken, işlerin düzenli ve şeffaf bir şekilde ilerlemesi müşteri memnuniyetini
artırır. Bu sistem, servislerin iş yükünü hafifletir ve günlük operasyonları daha verimli hale
getirir.

## ER DİYAGRAMI OLUŞTURMA AŞAMASI
Bir veritabanı tasarımına başlamadan önce ER (Varlık-İlişki) diyagramları oluşturmak,
sistemin yapısını ve işleyişini anlamak için kritik bir adımdır. Bu yüzden ilk aşama olarak
ER diyagramı oluşturdum.

![image](https://github.com/user-attachments/assets/17d28414-302f-439d-8824-9a99e4c23e05)
 **Şekil 1.** ER diyagramının ilk hali (Normalizasyon işlemi uygulanmadan önceki)

ER diyagramı sadece bir veritabanı tasarımının görsel temsili olup, sistemdeki
varlıklar (entity), bu varlıkların özellikleri (attributes) ve aralarındaki ilişkiler (relationships)
hakkında bilgi sağlar. Bu diyagram, veritabanı tasarımının temelini oluşturur ve ilişkisel
veritabanının doğru şekilde modellenmesini sağlar.
İlişki Şeması ise ER diyagramından elde edilen, varlıkların ve ilişkilerin daha teknik bir dilde,
tablo yapıları ve anahtarlar ile ifade edildiği bir gösterimdir. Bu yüzden bir sonraki aşamamız
ilişki şemasını çıkartmak olucaktır.
##
## İLİŞKİ ŞEMASI OLUŞTURMA AŞAMASI
- **Musteriler**(MusteriID, Ad, Soyad, TelNo, Email, Adres, MusteriTipi, MusteriBakiye)
- **Araclar**(AracID, MusteriID, Plaka, Marka, Model, Yil, Kilometre, Renk, MotorNo, Tip,
VitesTipi, YakitTipi, SaseNo)
- **Personel**(PersonelID, Ad, Soyad, TelNo, Pozisyon, Maas)
- **TamirIslemleri**(TamirID, AracID, Tarih, SorunAciklama, YapilanIslem, Maliyet)
- **YedekParcalar**(ParcaID, Ad, Tur, Fiyat, StokMiktari)
- **Odemeler**(OdemeID, TamirID, Tarih, Tutar, OdemeYontemi)
- **Randevular**(RandevuID, MusteriID, AracID, RandevuTarihi, Durum)
- **Tamir_Personel**(TamirID, PersonelID)
- **Personel_Randevu**(PersonelID, RandevuID)
- **Yedek_Parca**(PersonelID, ParcaID, Adet)
- **Tamir_Odeme**(OdemeID, TamirID)
- **Tamir_YedekParca**(TamirID, ParcaID, Miktar)
##
## NORMALİZASYON YAPMA AŞAMASI
İlişki şemasının ilk hali oluşturulduktan sonra normalizasyon kurallarına uyarak yeni bir
versiyon oluşturmaya çalışıyoruz.
**1.Adım:** Araclar tablosu 3.Normal Form’da değildir.Marka, model, renk, vites tipi, yakıt tipi,
araç tipi AracID sütununa bağlıdır. Bu yüzden ilk olarak bu 3. normal formu bozan bağlılığı
ortadan kaldırmak için bu sütunları Araclar tablosundan kaldırmamız gerekiyor.Bu yüzden
marka, model, renk, vites tipi, yakıt tipi, araç tipi, gibi niteliklerin her biri için ayrı tablo
oluşturuyoruz.
  

<img width="500" alt=image src="https://github.com/user-attachments/assets/f6ed5240-ec17-4928-a815-4a245b3d660b" />

 **Şekil 2.** Normalizasyon uygulanmadan önce Araclar tablosu

<img width="500" alt=image src="https://github.com/user-attachments/assets/c932fad8-795f-4fdb-bec4-806aa80bba85" />
 
  **Şekil 3.** Normalizasyon işlemi uygulandıktan sonra Araclar tablosu

  **Şekil 2**’de görüldüğü gibi normalizasyon işlemi uygulanmadan önce Araclar tablosunda,
aracın aracın detaylarına ait bilgilerin birçoğu aynı tablo içinde tutulmuştur.(örneğin, marka,
model, renk, vites tipi, yakıt tipi vb.).
Fakat bu durum veri tutarsızlığı ve tekrarlayan veriye neden olabilir.Örneğin:
- Aynı marka veya renk bilgisi farklı araçlar için tekrar tekrar yazılabilir
- Eğer bir markanın adı değiştirilirse, tüm satırların güncellenmesi gerekir, bu da hata
riskini artırır.
- Fazladan depolama alanı tüketilir.
Bu nedenden dolayı biz normalizasyon işlemi yaparız ve Araclar tablosundaki tekrar eden
veya gereksiz bilgiler farklı tablolara böleriz. (örneğin, Markalar, Modeller, Renkler,
VitesTipleri, YakitTipleri, vb.)

**2.Adım:** Musteriler tablosu 3. normal Form’da değildir.Müşteri tipi, telefonlar, email
adresleri gibi nitelikler AracID sütununa bağlıdır. Bu yüzden 3. normal formu bozan bağlılığı
ortadan kaldırmak için bu sütunları Musteriler tablosundan kaldırmam gerekiyor.Bu yüzden
müşteri tipi, telefonlar, email gibi niteliklerin her biri için ayrı tablo oluşturuyoruz.

<img width="500" alt=image src="https://github.com/user-attachments/assets/6096de85-0118-4042-ae74-14342c5973fe" />

**Şekil 4.** Normalizasyon uygulanmadan önce Musteriler tablosu

<img width="500" alt=image src="https://github.com/user-attachments/assets/e4605b39-c37b-4124-9f1b-9ba61fca98f0" />

**Şekil 5.** Normalizasyon uygulandıktan sonra Musteriler tablosu

**3.Adım:** Randevular, Personel, Odemeler tablolarında teker teker 3. normal forma uygun hale
getiriyoruz ve son haldeki ilişki şeması aşağıda verilmiştir.
##
- **Musteriler**(MusteriID, Ad, Soyad, Adres, MusteriTipiID, MusteriBakiye)
- **MusteriTipleri**(MusteriTipiID, TipAdi)
- **Telefonlar**(TelefonID, MusteriID, TelefonNo, TelefonTipi)
- **EmailAdresleri**(EmailID, MusteriID, EmailAdres, EmailTipi)
- **Araclar**(AracID, MusteriID, Plaka, MarkaID, ModelID, Yil, Kilometre, RenkID,
MotorNo, TipID, VitesTipiID, YakitTipiID, SaseNo)
- **Markalar**(MarkaID, MarkaAdi)
- **Modeller**(ModelID, MarkaID)
- **Renkler**(RenkID, RenkAdi)
- **AracTipleri**(TipID, TipAdi)
- **VitesTipleri**(VitesTipiID, VitesTipiAdi)
- **YakitTipleri**(YakitTipiID, YakitTipiAdi)
- **Personel**(PersonelID, Ad, Soyad, TelNo, Maas, PozisyonID)
- **Pozisyonlar**(PozisyonID, PozisyonAdi)
- **TamirIslemleri**(TamirID, AracID, Tarih, SorunAciklama, YapilanIslem, Maliyet)
- **YedekParcalar**(ParcaID, Ad, Tur, Fiyat, StokMiktari, TamirID)
- **Odemeler**(OdemeID, TamirID, Tarih, Tutar, OdemeYontemiID)
- **OdemeYontemleri**(OdemeYontemiID, YontemAdi)
- **Randevular**(RandevuID, MusteriID, AracID, RandevuTarihi, DurumID)
- **RandevuDurumlari**(DurumID, DurumAdi)
- **Tamir_Personel**(TamirID, PersonelID)
- **Personel_Randevu**(PersonelID, RandevuID)
- **Personel_YedekParca**(PersonelID, ParcaID,Adet)
- **Odeme_Tamir**(OdemeID, TamirID)
- **Tamir_YedekParca**(TamirID, ParcaID, Miktar)
##
Bu şekilde elde ederek 3. normal form (3NF)'e oldukça yakın ve bir seviye getiriyoruz.Bu
normalizasyon seviyesi, veri tekrarını en aza indirir, veri tutarlılığını sağlıyor ve veri tabanı
performansını arttırıyor.

![image](https://github.com/user-attachments/assets/66869e42-6b87-4bfd-8f4a-e83649ed6f13)
 **Şekil 6.** ER diyaramın son hali(Normalizasyon işlemi uygulandıktan sonra)

 Raporun Son Hali: 
 [5_230260199_220260081_220260039.docx](https://github.com/user-attachments/files/18320335/5_230260199_220260081_220260039.docx)


