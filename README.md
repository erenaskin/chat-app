# Flutter Real-time Chat Uygulaması

Bu proje, Flutter ve Firebase kullanılarak geliştirilmiş modern bir gerçek zamanlı sohbet uygulamasıdır. Kullanıcı kimlik doğrulama, profil yönetimi, gerçek zamanlı mesajlaşma, medya (resim/GIF) mesajları ve kullanıcı çevrimiçi/çevrimdışı durumu gibi temel özellikleri sunar. Uygulamanın tasarımı, Material 3 prensiplerine uygun olarak temiz ve minimalist bir UI/UX deneyimi sağlamayı hedefler.

## ✨ Özellikler

*   **Kullanıcı Kimlik Doğrulama:** Email/Şifre ile kayıt ve giriş yapma.
*   **Şifre Sıfırlama:** Giriş ekranından şifre sıfırlama e-postası gönderme.
*   **Profil Yönetimi:** Kullanıcı adını, durumu ve profil fotoğrafını güncelleyebilir.
*   **Gerçek Zamanlı Mesajlaşma:** Firebase Firestore üzerinden anlık, tekil kullanıcılar arası mesajlaşma.
*   **Medya Mesajları:** Galeriden resim ve GIF gönderme desteği.
*   **Çevrimiçi/Çevrimdışı Durumu:** Kullanıcıların çevrimiçi durumunu ve son görülme zamanını gösterir.
*   **Sohbet Listesi:** Tüm kayıtlı kullanıcıları listeleyen ana sayfa.
*   **Modern UI/UX:** Material 3 tasarım prensipleri ve Google Fonts (`Urbanist`) ile estetik arayüz.
*   **Dark Mode Desteği:** Sistem temasına göre otomatik karanlık/aydınlık mod geçişi.

## 🚀 Teknolojiler

*   **Flutter:** Mobil uygulama geliştirme çerçevesi.
*   **Firebase Authentication:** Kullanıcı kimlik doğrulama.
*   **Firebase Firestore:** Gerçek zamanlı veritabanı (mesajlar, kullanıcı profilleri).
*   **Firebase Storage:** Medya dosyalarının (profil fotoğrafları, resimler) depolanması.
*   **Provider:** Flutter için durum yönetimi.
*   **Image Picker:** Cihaz galerisinden resim seçimi.
*   **intl:** Uluslararasılaşma ve tarih/saat biçimlendirme.
*   **google_fonts:** Uygulama genelinde özel font kullanımı.

## 🛠️ Kurulum

Uygulamayı yerel geliştirme ortamınızda çalıştırmak için aşağıdaki adımları izleyin.

### Ön Gereksinimler

*   [Flutter SDK](https://flutter.dev/docs/get-started/install) yüklü olmalı.
*   [Firebase CLI](https://firebase.google.com/docs/cli) yüklü olmalı (`npm install -g firebase-tools`).

### Adımlar

1.  **Projeyi Klonlayın:**
2.  **Firebase Projesi Oluşturun:**
    *   [Firebase Console](https://console.firebase.google.com/) adresine gidin ve yeni bir proje oluşturun.
    *   Projenizde **Authentication**, **Firestore Database** ve **Cloud Storage** servislerini etkinleştirin.
        *   Authentication için Email/Password oturum açma yöntemini aktif edin.
        *   Firestore Database'i "test mode"da başlatın (geliştirme aşaması için).
        *   Cloud Storage'ı aktif edin.

3.  **FlutterFire Yapılandırması:**
    *   Flutter projenizi Firebase ile yapılandırın. Terminalde proje kök dizinindeyken aşağıdaki komutu çalıştırın:
  
### 🚀 Kullanım

1.  Uygulama başladığında, Giriş Yap veya Kayıt Ol ekranı ile karşılaşacaksınız.
2.  Email ve şifre kullanarak yeni bir hesap oluşturun veya mevcut hesabınızla giriş yapın.
3.  Başarılı giriş/kayıt sonrası, uygulamanın ana sayfası (kullanıcı listesi) görüntülenecektir.
4.  Bir kullanıcıya dokunarak o kullanıcıyla sohbet etmeye başlayabilirsiniz.
5.  Sohbet ekranında metin mesajları gönderebilir, galeri ikonuna tıklayarak resim veya GIF gönderebilirsiniz.
6.  Profil ikonuna tıklayarak kendi profilinizi görüntüleyebilir ve bilgilerinizi güncelleyebilirsiniz.
7.  Giriş ekranındaki "Şifremi Unuttum?" bağlantısını kullanarak şifre sıfırlama işlemi yapabilirsiniz.
         
