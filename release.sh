#!/bin/bash

set -x

# Ustaw katalogi
TOLGY_DIR="."
TOLGY_FRONTEND_DIR="../tolgy-frontend"

# Ustaw plik do skopiowania
SOURCE_APK="$TOLGY_FRONTEND_DIR/android/app/build/outputs/apk/release/app-release-unsigned.apk"
DESTINATION_APK="$TOLGY_DIR/android/tolgy-release.apk"

# Skopiuj plik APK
cp "$SOURCE_APK" "$DESTINATION_APK"

# Przejdź do katalogu tolgy-frontend
cd "$TOLGY_FRONTEND_DIR" || exit

# Pobierz skrócone ID ostatniego commitu
COMMIT_ID=$(git rev-parse --short HEAD)

# Przejdź do katalogu tolgy
cd -

git add .

git commit -m "release $COMMIT_ID"

# Utwórz tag w katalogu tolgy
git tag "release-$COMMIT_ID"

# Wyślij tag do zdalnego repozytorium
git push origin "release-$COMMIT_ID"

echo "Tag 'release-$COMMIT_ID' został utworzony i wypchnięty do zdalnego repozytorium."
