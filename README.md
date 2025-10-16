🌦️ Calculadora Clima — Flutter Web
Una aplicación web interactiva desarrollada en Flutter que combina visualización meteorológica animada con una calculadora contextual. Ideal para mostrar cómo el clima puede influir en decisiones cotidianas, todo con una interfaz elegante, responsiva y sonora.

🚀 Demo en vivo
👉 Ver aplicación desplegada

🧠 Características principales
🎨 Animaciones Lottie según el clima: lluvia, sol, viento, noche, tormenta

🔊 Sonidos ambientales integrados: pájaros, lluvia, viento

📱 Diseño responsivo para móvil y escritorio

🧮 Calculadora integrada con lógica personalizada

🌐 Despliegue en GitHub Pages con assets optimizados

🛠️ Tecnologías utilizadas
Tecnología Uso principal
Flutter Web UI responsiva y lógica interactiva
Dart Lógica de cálculo y control de estado
Lottie Animaciones meteorológicas
GitHub Pages Hosting estático
HTML/CSS Estructura y estilo del build final
📁 Estructura del proyecto
Código
lib/
├── calculator/ # Página y vista de la calculadora
├── home/ # Página principal
├── weather/ # Página y servicio del clima
├── models/ # Modelo de datos meteorológicos
├── utils/ # Lógica de cálculo y clima
├── widgets/ # Fondo animado y controlador de sonido
assets/
├── animations/ # Archivos Lottie
├── sounds/ # Archivos MP3 ambientales
web/
├── index.html # Entrada principal para Flutter Web
📦 Cómo ejecutar localmente
bash
git clone https://github.com/MoisesRuSo2004/calculadora-clima.git
cd calculadora-clima
flutter pub get
flutter run -d chrome
🧪 Pruebas básicas
bash
flutter test
Incluye pruebas unitarias para lógica de cálculo y simulación meteorológica.

📤 Despliegue manual
bash
flutter build web

👨‍💻 Autor
Moisés Ruiz Desarrollador Full-Stack en transición hacia Backend Apasionado por sistemas elegantes, simulaciones realistas y visualizaciones interactivas 📍 Cartagena, Colombia
