#!/bin/bash
echo "🚀 Сборка RimWorld Mobile для Android"

# Проверка Termux
if [ ! -d "$PREFIX" ]; then
    echo "❌ Установи Termux с F-Droid!"
    exit 1
fi

# Установка зависимостей
pkg update -y
pkg install -y git cmake ninja clang openjdk-17 aapt apksigner

# Установка NDK
if [ ! -d "$PREFIX/lib/android-ndk" ]; then
    echo "📦 Устанавливаю Android NDK..."
    cd $PREFIX/lib
    wget https://dl.google.com/android/repository/android-ndk-r26c-linux.zip
    unzip android-ndk-r26c-linux.zip
    mv android-ndk-r26c android-ndk
    rm android-ndk-r26c-linux.zip
fi

export ANDROID_NDK_HOME=$PREFIX/lib/android-ndk

# Клонирование проекта
cd ~
git clone https://github.com/YOUR_USERNAME/rimworld-mobile.git
cd rimworld-mobile

# Сборка
mkdir build && cd build
cmake -DCMAKE_TOOLCHAIN_FILE=$ANDROID_NDK_HOME/build/cmake/android.toolchain.cmake \
      -DANDROID_ABI=arm64-v8a \
      -DANDROID_PLATFORM=android-24 \
      -DCMAKE_BUILD_TYPE=Release ..
make -j$(nproc)

echo "✅ Готово! APK в build/outputs/apk/"
