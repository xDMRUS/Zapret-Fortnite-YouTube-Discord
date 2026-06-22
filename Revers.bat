@echo off
chcp 65001 > nul
setlocal enabledelayedexpansion

title Zapret Reverse Mod Creator
cd /d "%~dp0"

echo ========================================
echo    СОЗДАТЕЛЬ РЕВЕРС-МОДА ZAPRET
echo ========================================
echo.

:main_menu
cls
echo ========================================
echo    ГЛАВНОЕ МЕНЮ РЕВЕРС-МОДА
echo             by DMRUS
echo ========================================
echo.
echo [1] Создать реверс-версию батника
echo [2] Разблокировать сайт/приложение
echo [3] Удалить сайт из разрешённых
echo [4] Показать текущие списки
echo [5] Очистить все списки
echo [6] Игровые лаунчеры
echo [0] Выход
echo.
set /p choice="Выберите действие [0-6]: "

if "%choice%"=="1" goto create_reverse
if "%choice%"=="2" goto allow_site_menu
if "%choice%"=="3" goto remove_site_menu
if "%choice%"=="4" goto show_lists
if "%choice%"=="5" goto clear_lists
if "%choice%"=="6" goto game_launchers_menu
if "%choice%"=="0" exit /b
goto main_menu

:create_reverse
cls
echo ========================================
echo    СОЗДАНИЕ РЕВЕРС-ВЕРСИИ БАТНИКА
echo ========================================
echo.

set "count=0"
for %%f in (*.bat) do (
    set "filename=%%~nxf"
    if /i not "!filename!"=="service.bat" (
        if /i not "!filename!"=="%~nx0" (
            set /a count+=1
            echo [!count!] %%~nf
            set "file!count!=%%f"
        )
    )
)

if "!count!"=="0" (
    echo Нет доступных батников!
    echo.
    pause
    goto main_menu
)

echo.
echo [0] Назад
echo.
set /p config="Выберите батник [1-!count!]: "

if "%config%"=="0" goto main_menu
if "%config%"=="" goto create_reverse

set "selectedFile=!file%config%!"
if not defined selectedFile (
    echo Ошибка: неверный выбор!
    timeout /t 2 >nul
    goto create_reverse
)

echo.
echo Выбран: !selectedFile!
echo.

set "base_name=!selectedFile:~0,-4!"
set "reverse_file=!base_name!_REVERSE.bat"

copy "!selectedFile!" "!reverse_file!" > nul

echo ✓ РЕВЕРС-ВЕРСИЯ СОЗДАНА: !reverse_file!
echo.
pause
goto main_menu

:allow_site_menu
cls
echo ========================================
echo    РАЗБЛОКИРОВАТЬ САЙТ/ПРИЛОЖЕНИЕ
echo ========================================
echo.
echo Выберите что разрешить:
echo.
echo [1] YouTube
echo [2] Discord
echo [3] Telegram
echo [4] Spotify
echo [5] Twitch
echo [6] Facebook
echo [7] Instagram
echo [8] TikTok
echo [9] Все стриминговые сервисы
echo [10] Все соцсети, мессенджеры и стримы
echo [11] Рекламные сети
echo [12] Произвольный сайт
echo.
echo [0] Назад
echo.
set /p site_choice="Выберите [0-12]: "

if "%site_choice%"=="0" goto main_menu
if "%site_choice%"=="" goto allow_site_menu

if "%site_choice%"=="1" call :allow_youtube
if "%site_choice%"=="2" call :allow_discord
if "%site_choice%"=="3" call :allow_telegram
if "%site_choice%"=="4" call :allow_spotify
if "%site_choice%"=="5" call :allow_twitch
if "%site_choice%"=="6" call :allow_facebook
if "%site_choice%"=="7" call :allow_instagram
if "%site_choice%"=="8" call :allow_tiktok
if "%site_choice%"=="9" call :allow_all_streaming
if "%site_choice%"=="10" call :allow_all_services
if "%site_choice%"=="11" call :allow_ads
if "%site_choice%"=="12" call :allow_custom

echo.
pause
goto main_menu

:remove_site_menu
cls
echo ========================================
echo    УДАЛИТЬ САЙТ ИЗ РАЗРЕШЁННЫХ
echo ========================================
echo.
echo Выберите что удалить:
echo.
echo [1] YouTube
echo [2] Discord
echo [3] Telegram
echo [4] Spotify
echo [5] Twitch
echo [6] Facebook
echo [7] Instagram
echo [8] TikTok
echo [9] Все стриминговые сервисы
echo [10] Все соцсети, мессенджеры и стримы
echo [11] Рекламные сети
echo [12] Удалить по ключевому слову
echo.
echo [0] Назад
echo.
set /p remove_choice="Выберите [0-12]: "

if "%remove_choice%"=="0" goto main_menu
if "%remove_choice%"=="" goto remove_site_menu

if "%remove_choice%"=="1" call :remove_youtube
if "%remove_choice%"=="2" call :remove_discord
if "%remove_choice%"=="3" call :remove_telegram
if "%remove_choice%"=="4" call :remove_spotify
if "%remove_choice%"=="5" call :remove_twitch
if "%remove_choice%"=="6" call :remove_facebook
if "%remove_choice%"=="7" call :remove_instagram
if "%remove_choice%"=="8" call :remove_tiktok
if "%remove_choice%"=="9" call :remove_all_streaming
if "%remove_choice%"=="10" call :remove_all_services
if "%remove_choice%"=="11" call :remove_ads
if "%remove_choice%"=="12" call :remove_by_keyword

echo.
pause
goto main_menu

:allow_youtube
echo.
echo Добавляю YouTube в разрешённые...
echo.

:: Создаём папку если нет
if not exist "lists\" mkdir lists

:: Добавляем домены YouTube в list-google.txt
(
    echo # YouTube - разрешён
    echo yt3.ggpht.com
    echo yt4.ggpht.com
    echo yt3.googleusercontent.com
    echo googlevideo.com
    echo jnn-pa.googleapis.com
    echo stable.dl2.discordapp.net
    echo wide-youtube.l.google.com
    echo youtube-nocookie.com
    echo youtube-ui.l.google.com
    echo youtube.com
    echo youtubeembeddedplayer.googleapis.com
    echo youtubekids.com
    echo youtubei.googleapis.com
    echo youtu.be
    echo yt-video-upload.l.google.com
    echo ytimg.com
    echo ytimg.l.google.com
    echo *.googlevideo.com
    echo *.ytimg.com
    echo *.youtube.com
    echo *.youtu.be
    echo m.youtube.com
    echo www.youtube.com
) >> "lists\list-google.txt"

:: Также добавляем основные домены в list-general.txt
(
    echo youtube.com
    echo *.youtube.com
    echo youtu.be
    echo *.youtu.be
    echo www.youtube.com
    echo m.youtube.com
    echo youtubei.googleapis.com
    echo *.googlevideo.com
    echo yt3.ggpht.com
    echo *.ytimg.com
    echo i.ytimg.com
    echo s.ytimg.com
    echo *.gvt1.com
    echo *.gvt2.com
    echo *.googleusercontent.com
) >> "lists\list-general.txt"

:: Добавляем IP YouTube
(
    echo # YouTube IP
    echo 142.250.0.0/15
    echo 172.217.0.0/16
    echo 173.194.0.0/16
    echo 209.85.128.0/17
    echo 216.58.0.0/16
    echo 216.239.32.0/19
    echo 74.125.0.0/16
) >> "lists\ipset-all.txt"

echo ✓ YouTube добавлен в разрешённые!
exit /b

:allow_discord
echo.
echo Добавляю Discord в разрешённые...
echo.

if not exist "lists\" mkdir lists

:: Полный список доменов Discord
(
    echo # Discord - разрешён
    echo discord.com
    echo *.discord.com
    echo discord.gg
    echo *.discord.gg
    echo discordapp.com
    echo *.discordapp.com
    echo discordapp.net
    echo *.discordapp.net
    echo discordstatus.com
    echo *.discordstatus.com
    echo discord.media
    echo *.discord.media
    echo dl.discordapp.net
    echo *.dl.discordapp.net
    echo cdn.discordapp.com
    echo *.cdn.discordapp.com
    echo media.discordapp.net
    echo *.media.discordapp.net
    echo images-ext-1.discordapp.net
    echo *.images-ext-1.discordapp.net
    echo images-ext-2.discordapp.net
    echo *.images-ext-2.discordapp.net
    echo voice-js.discordapp.net
    echo *.voice-js.discordapp.net
    echo gateway.discord.gg
    echo *.gateway.discord.gg
    echo status.discord.com
    echo *.status.discord.com
) >> "lists\list-general.txt"

:: IP Discord
(
    echo # Discord IP
    echo 162.159.128.0/17
    echo 162.159.192.0/18
    echo 104.16.0.0/13
    echo 104.24.0.0/14
    echo 172.64.0.0/13
    echo 199.96.56.0/21
    echo 185.176.24.0/22
) >> "lists\ipset-all.txt"

echo ✓ Discord добавлен в разрешённые!
exit /b

:allow_telegram
echo.
echo Добавляю Telegram в разрешённые...
echo.

if not exist "lists\" mkdir lists

(
    echo # Telegram - разрешён
    echo telegram.org
    echo *.telegram.org
    echo t.me
    echo *.t.me
    echo telegra.ph
    echo *.telegra.ph
    echo telesco.pe
    echo *.telesco.pe
    echo core.telegram.org
    echo *.core.telegram.org
    echo web.telegram.org
    echo *.web.telegram.org
    echo desktop.telegram.org
    echo *.desktop.telegram.org
) >> "lists\list-general.txt"

:: IP Telegram
(
    echo # Telegram IP
    echo 91.108.4.0/22
    echo 91.108.8.0/22
    echo 91.108.12.0/22
    echo 91.108.16.0/22
    echo 149.154.160.0/20
    echo 149.154.164.0/22
) >> "lists\ipset-all.txt"

echo ✓ Telegram добавлен в разрешённые!
exit /b

:allow_spotify
echo.
echo Добавляю Spotify в разрешённые...
echo.

if not exist "lists\" mkdir lists

(
    echo # Spotify - разрешён
    echo spotify.com
    echo *.spotify.com
    echo scdn.co
    echo *.scdn.co
    echo spoti.fi
    echo *.spoti.fi
    echo spotifycdn.com
    echo *.spotifycdn.com
    echo spotifycdn.net
    echo *.spotifycdn.net
    echo audio-ak-spotify-com.akamaized.net
    echo *.audio-ak-spotify-com.akamaized.net
    echo audio-akp-quic-spotify-com.akamaized.net
    echo *.audio-akp-quic-spotify-com.akamaized.net
    echo spotifycharts.com
    echo *.spotifycharts.com
    echo spotifyforbrands.com
    echo *.spotifyforbrands.com
    echo spotifyjobs.com
    echo *.spotifyjobs.com
) >> "lists\list-general.txt"

:: IP Spotify
(
    echo # Spotify IP
    echo 35.186.224.0/19
    echo 104.199.64.0/18
    echo 151.101.0.0/16
    echo 199.232.0.0/16
) >> "lists\ipset-all.txt"

echo ✓ Spotify добавлен в разрешённые!
exit /b

:allow_twitch
echo.
echo Добавляю Twitch в разрешённые...
echo.

if not exist "lists\" mkdir lists

(
    echo # Twitch - разрешён
    echo twitch.tv
    echo *.twitch.tv
    echo twitchcdn.net
    echo *.twitchcdn.net
    echo ttvcdn.com
    echo *.ttvcdn.com
    echo jtvnw.net
    echo *.jtvnw.net
    echo twitchsvc.net
    echo *.twitchsvc.net
    echo t2.t.tv
    echo *.t2.t.tv
    echo video-edge-*.ttvnw.net
    echo vod-secure.twitch.tv
    echo *.vod-secure.twitch.tv
    echo vod-storyboards.twitch.tv
    echo *.vod-storyboards.twitch.tv
    echo static-cdn.jtvnw.net
    echo *.static-cdn.jtvnw.net
    echo extensions.twitch.tv
    echo *.extensions.twitch.tv
    echo badges.twitch.tv
    echo *.badges.twitch.tv
) >> "lists\list-general.txt"

:: IP Twitch (Amazon AWS)
(
    echo # Twitch IP (Amazon AWS)
    echo 52.223.0.0/17
    echo 54.240.0.0/18
    echo 99.82.0.0/16
    echo 143.204.0.0/16
    echo 151.101.0.0/16
    echo 205.185.216.0/24
) >> "lists\ipset-all.txt"

echo ✓ Twitch добавлен в разрешённые!
exit /b

:allow_facebook
echo.
echo Добавляю Facebook в разрешённые...
echo.

if not exist "lists\" mkdir lists

(
    echo # Facebook - разрешён
    echo facebook.com
    echo *.facebook.com
    echo fb.com
    echo *.fb.com
    echo fbcdn.net
    echo *.fbcdn.net
    echo fbcdn.com
    echo *.fbcdn.com
) >> "lists\list-general.txt"

(
    echo # IP Facebook - разрешён
    echo 31.13.64.0/18
    echo 157.240.0.0/16
) >> "lists\ipset-all.txt"

echo ✓ Facebook добавлен в разрешённые!
exit /b

:allow_instagram
echo.
echo Добавляю Instagram в разрешённые...
echo.

if not exist "lists\" mkdir lists

(
    echo # Instagram - разрешён
    echo instagram.com
    echo *.instagram.com
    echo cdninstagram.com
    echo *.cdninstagram.com
    echo instagramimages-a.akamaihd.net
    echo *.instagramimages-a.akamaihd.net
) >> "lists\list-general.txt"

echo ✓ Instagram добавлен в разрешённые!
exit /b

:allow_tiktok
echo.
echo Добавляю TikTok в разрешённые...
echo.

if not exist "lists\" mkdir lists

(
    echo # TikTok - разрешён
    echo tiktok.com
    echo *.tiktok.com
    echo tiktokcdn.com
    echo *.tiktokcdn.com
    echo tiktokv.com
    echo *.tiktokv.com
) >> "lists\list-general.txt"

(
    echo # IP TikTok - разрешён
    echo 13.107.42.0/24
    echo 45.57.40.0/22
) >> "lists\ipset-all.txt"

echo ✓ TikTok добавлен в разрешённые!
exit /b

:allow_all_streaming
echo.
echo Добавляю все стриминговые сервисы в разрешённые...
echo.

call :allow_youtube
call :allow_twitch

:: Добавляем другие стриминговые сервисы
(
    echo # Другие стриминговые сервисы
    echo kick.com
    echo *.kick.com
    echo rumble.com
    echo *.rumble.com
    echo dailymotion.com
    echo *.dailymotion.com
    echo vimeo.com
    echo *.vimeo.com
    echo dlive.tv
    echo *.dlive.tv
) >> "lists\list-general.txt"

echo ✓ Все стриминговые сервисы добавлены в разрешённые!
exit /b

:allow_all_services
echo.
echo Добавляю все сервисы в разрешённые...
echo.

call :allow_youtube
call :allow_facebook
call :allow_instagram
call :allow_tiktok
call :allow_discord
call :allow_telegram
call :allow_spotify
call :allow_twitch

:: Добавляем Twitter
(
    echo twitter.com
    echo *.twitter.com
    echo x.com
    echo *.x.com
    echo twimg.com
    echo *.twimg.com
) >> "lists\list-general.txt"

:: Добавляем VK
(
    echo vk.com
    echo *.vk.com
    echo vk.me
    echo *.vk.me
) >> "lists\list-general.txt"

:: Добавляем OK
(
    echo ok.ru
    echo *.ok.ru
    echo odnoklassniki.ru
    echo *.odnoklassniki.ru
) >> "lists\list-general.txt"

:: Добавляем WhatsApp
(
    echo whatsapp.com
    echo *.whatsapp.com
    echo whatsapp.net
    echo *.whatsapp.net
) >> "lists\list-general.txt"

:: Добавляем Signal
(
    echo signal.org
    echo *.signal.org
    echo signalservice.org
    echo *.signalservice.org
) >> "lists\list-general.txt"

:: Добавляем другие музыкальные сервисы
(
    echo soundcloud.com
    echo *.soundcloud.com
    echo deezer.com
    echo *.deezer.com
    echo apple.com
    echo *.apple.com
    echo itunes.com
    echo *.itunes.com
) >> "lists\list-general.txt"

:: Добавляем другие стриминговые сервисы
(
    echo kick.com
    echo *.kick.com
    echo rumble.com
    echo *.rumble.com
    echo dailymotion.com
    echo *.dailymotion.com
) >> "lists\list-general.txt"

echo ✓ Все сервисы добавлены в разрешённые!
exit /b

:allow_ads
echo.
echo Добавляю рекламные сети в разрешённые...
echo.

if not exist "lists\" mkdir lists

(
    echo # Рекламные сети - разрешены
    echo *.doubleclick.net
    echo *.googleadservices.com
    echo *.googlesyndication.com
    echo *.adsrvr.org
    echo *.adnxs.com
    echo *.facebook.com/tr/
    echo *.facebook.com/ads/
    echo *.amazon-adsystem.com
    echo *.scorecardresearch.com
    echo *.outbrain.com
    echo *.taboola.com
) >> "lists\list-general.txt"

echo ✓ Рекламные сети добавлены в разрешённые!
exit /b

:allow_custom
echo.
set /p custom_domain="Введите домен для разрешения (например: example.com): "
if "%custom_domain%"=="" exit /b

echo.
echo Добавляю !custom_domain! в разрешённые...
echo.

if not exist "lists\" mkdir lists
if not exist "lists\list-general.txt" echo. > "lists\list-general.txt"
if not exist "lists\ipset-all.txt" echo. > "lists\ipset-all.txt"

echo !custom_domain! >> "lists\list-general.txt"
echo *.!custom_domain! >> "lists\list-general.txt"

echo ✓ Сайт !custom_domain! добавлен в разрешённые!
exit /b

:remove_youtube
echo.
echo Удаляю YouTube из разрешённых...
echo.

if exist "lists\list-google.txt" (
    findstr /v "youtube youtu.be googlevideo ytimg ggpht" "lists\list-google.txt" > "lists\list-google.tmp"
    move /y "lists\list-google.tmp" "lists\list-google.txt" > nul
)

if exist "lists\list-general.txt" (
    findstr /v "youtube youtu.be googlevideo ytimg" "lists\list-general.txt" > "lists\list-general.tmp"
    move /y "lists\list-general.tmp" "lists\list-general.txt" > nul
)

if exist "lists\ipset-all.txt" (
    findstr /v "142.250 172.217 173.194 216.58 74.125 209.85 216.239" "lists\ipset-all.txt" > "lists\ipset-all.tmp"
    move /y "lists\ipset-all.tmp" "lists\ipset-all.txt" > nul
)

echo ✓ YouTube удалён из разрешённых!
exit /b

:remove_discord
echo.
echo Удаляю Discord из разрешённых...
echo.

if exist "lists\list-general.txt" (
    findstr /v "discord discordapp" "lists\list-general.txt" > "lists\list-general.tmp"
    move /y "lists\list-general.tmp" "lists\list-general.txt" > nul
)

if exist "lists\ipset-all.txt" (
    findstr /v "162.159 104.16 104.24 172.64 199.96 185.176" "lists\ipset-all.txt" > "lists\ipset-all.tmp"
    move /y "lists\ipset-all.tmp" "lists\ipset-all.txt" > nul
)

echo ✓ Discord удалён из разрешённых!
exit /b

:remove_telegram
echo.
echo Удаляю Telegram из разрешённых...
echo.

if exist "lists\list-general.txt" (
    findstr /v "telegram t\.me telegra telesco" "lists\list-general.txt" > "lists\list-general.tmp"
    move /y "lists\list-general.tmp" "lists\list-general.txt" > nul
)

if exist "lists\ipset-all.txt" (
    findstr /v "91.108 149.154" "lists\ipset-all.txt" > "lists\ipset-all.tmp"
    move /y "lists\ipset-all.tmp" "lists\ipset-all.txt" > nul
)

echo ✓ Telegram удалён из разрешённых!
exit /b

:remove_spotify
echo.
echo Удаляю Spotify из разрешённых...
echo.

if exist "lists\list-general.txt" (
    findstr /v "spotify scdn spoti" "lists\list-general.txt" > "lists\list-general.tmp"
    move /y "lists\list-general.tmp" "lists\list-general.txt" > nul
)

if exist "lists\ipset-all.txt" (
    findstr /v "35.186 104.199 151.101 199.232" "lists\ipset-all.txt" > "lists\ipset-all.tmp"
    move /y "lists\ipset-all.tmp" "lists\ipset-all.txt" > nul
)

echo ✓ Spotify удалён из разрешённых!
exit /b

:remove_twitch
echo.
echo Удаляю Twitch из разрешённых...
echo.

if exist "lists\list-general.txt" (
    findstr /v "twitch ttvcdn jtvnw" "lists\list-general.txt" > "lists\list-general.tmp"
    move /y "lists\list-general.tmp" "lists\list-general.txt" > nul
)

if exist "lists\ipset-all.txt" (
    findstr /v "52.223 54.240 99.82 143.204 151.101 205.185" "lists\ipset-all.txt" > "lists\ipset-all.tmp"
    move /y "lists\ipset-all.tmp" "lists\ipset-all.txt" > nul
)

echo ✓ Twitch удалён из разрешённых!
exit /b

:remove_facebook
echo.
echo Удаляю Facebook из разрешённых...
echo.

if exist "lists\list-general.txt" (
    findstr /v "facebook fb fbcdn" "lists\list-general.txt" > "lists\list-general.tmp"
    move /y "lists\list-general.tmp" "lists\list-general.txt" > nul
)

if exist "lists\ipset-all.txt" (
    findstr /v "31.13 157.240" "lists\ipset-all.txt" > "lists\ipset-all.tmp"
    move /y "lists\ipset-all.tmp" "lists\ipset-all.txt" > nul
)

echo ✓ Facebook удалён из разрешённых!
exit /b

:remove_instagram
echo.
echo Удаляю Instagram из разрешённых...
echo.

if exist "lists\list-general.txt" (
    findstr /v "instagram cdninstagram" "lists\list-general.txt" > "lists\list-general.tmp"
    move /y "lists\list-general.tmp" "lists\list-general.txt" > nul
)

echo ✓ Instagram удалён из разрешённых!
exit /b

:remove_tiktok
echo.
echo Удаляю TikTok из разрешённых...
echo.

if exist "lists\list-general.txt" (
    findstr /v "tiktok" "lists\list-general.txt" > "lists\list-general.tmp"
    move /y "lists\list-general.tmp" "lists\list-general.txt" > nul
)

if exist "lists\ipset-all.txt" (
    findstr /v "13.107 45.57" "lists\ipset-all.txt" > "lists\ipset-all.tmp"
    move /y "lists\ipset-all.tmp" "lists\ipset-all.txt" > nul
)

echo ✓ TikTok удалён из разрешённых!
exit /b

:remove_all_streaming
echo.
echo Удаляю все стриминговые сервисы из разрешённых...
echo.

call :remove_youtube
call :remove_twitch

if exist "lists\list-general.txt" (
    findstr /v "kick rumble dailymotion vimeo dlive" "lists\list-general.txt" > "lists\list-general.tmp"
    move /y "lists\list-general.tmp" "lists\list-general.txt" > nul
)

echo ✓ Все стриминговые сервисы удалены из разрешённых!
exit /b

:remove_all_services
echo.
echo Удаляю все сервисы из разрешённых...
echo.

call :remove_youtube
call :remove_facebook
call :remove_instagram
call :remove_tiktok
call :remove_discord
call :remove_telegram
call :remove_spotify
call :remove_twitch

if exist "lists\list-general.txt" (
    findstr /v "twitter x\.com twimg vk ok\.ru odnoklassniki whatsapp signal soundcloud deezer apple itunes kick rumble dailymotion" "lists\list-general.txt" > "lists\list-general.tmp"
    move /y "lists\list-general.tmp" "lists\list-general.txt" > nul
)

echo ✓ Все сервисы удалены из разрешённых!
exit /b

:remove_ads
echo.
echo Удаляю рекламные сети из разрешённых...
echo.

if exist "lists\list-general.txt" (
    findstr /v "doubleclick adservices adsrvr adnxs amazon-adsystem scorecardresearch outbrain taboola" "lists\list-general.txt" > "lists\list-general.tmp"
    move /y "lists\list-general.tmp" "lists\list-general.txt" > nul
)

echo ✓ Рекламные сети удалены из разрешённых!
exit /b

:remove_by_keyword
echo.
set /p keyword="Введите ключевое слово для удаления (например: youtube): "
if "%keyword%"=="" exit /b

echo.
echo Удаляю записи с ключевым словом: !keyword!
echo.

set "removed_count=0"

if exist "lists\list-general.txt" (
    for /f %%i in ('type "lists\list-general.txt" ^| find /i "!keyword!" ^| find /c /v ""') do set "count1=%%i"
    findstr /v /i "!keyword!" "lists\list-general.txt" > "lists\list-general.tmp"
    move /y "lists\list-general.tmp" "lists\list-general.txt" > nul
    set /a removed_count+=!count1!
)

if exist "lists\list-google.txt" (
    for /f %%i in ('type "lists\list-google.txt" ^| find /i "!keyword!" ^| find /c /v ""') do set "count2=%%i"
    findstr /v /i "!keyword!" "lists\list-google.txt" > "lists\list-google.tmp"
    move /y "lists\list-google.tmp" "lists\list-google.txt" > nul
    set /a removed_count+=!count2!
)

if exist "lists\ipset-all.txt" (
    for /f %%i in ('type "lists\ipset-all.txt" ^| find "!keyword!" ^| find /c /v ""') do set "count3=%%i"
    findstr /v "!keyword!" "lists\ipset-all.txt" > "lists\ipset-all.tmp"
    move /y "lists\ipset-all.tmp" "lists\ipset-all.txt" > nul
    set /a removed_count+=!count3!
)

echo ✓ Удалено !removed_count! записей с ключевым словом "!keyword!"
exit /b

:show_lists
cls
echo ========================================
echo    ТЕКУЩИЕ РАЗРЕШЁННЫЕ САЙТЫ
echo ========================================
echo.

if not exist "lists\" (
    echo Папка lists не существует!
    echo.
    pause
    goto main_menu
)

echo ДОМЕНЫ (list-general.txt):
echo ----------------------------------------
if exist "lists\list-general.txt" (
    type "lists\list-general.txt"
) else (
    echo Файл пуст
)
echo.

echo GOOGLE-ДОМЕНЫ (list-google.txt):
echo ----------------------------------------
if exist "lists\list-google.txt" (
    type "lists\list-google.txt"
) else (
    echo Файл пуст
)
echo.

echo IP АДРЕСА (ipset-all.txt):
echo ----------------------------------------
if exist "lists\ipset-all.txt" (
    type "lists\ipset-all.txt"
) else (
    echo Файл пуст
)
echo.
pause
goto main_menu

:clear_lists
cls
echo ========================================
echo    ОЧИСТКА ВСЕХ СПИСКОВ
echo ========================================
echo.
set /p confirm="Очистить все списки? (Y/N): "

if /i not "!confirm!"=="Y" goto main_menu

if exist "lists\" (
    echo. > "lists\list-general.txt"
    echo. > "lists\ipset-all.txt"
    echo. > "lists\list-google.txt"
)

echo ✓ Все списки очищены!
echo.
pause
goto main_menu

:game_launchers_menu
cls
echo ========================================
echo    ИГРОВЫЕ ЛАУНЧЕРЫ
echo ========================================
echo.
echo Выберите действие:
echo.
echo [1] Разрешить игровые лаунчеры
echo [2] Удалить игровые лаунчеры из разрешённых
echo [3] Показать разрешённые лаунчеры
echo.
echo [0] Назад
echo.
set /p game_choice="Выберите [0-3]: "

if "%game_choice%"=="0" goto main_menu
if "%game_choice%"=="1" goto allow_game_launchers_menu
if "%game_choice%"=="2" goto remove_game_launchers_menu
if "%game_choice%"=="3" goto show_game_launchers
goto game_launchers_menu

:allow_game_launchers_menu
cls
echo ========================================
echo    РАЗРЕШИТЬ ИГРОВЫЕ ЛАУНЧЕРЫ
echo ========================================
echo.
echo Выберите лаунчеры для разрешения:
echo.
echo [1] Steam
echo [2] Epic Games Store
echo [3] Origin / EA App
echo [4] Ubisoft Connect
echo [5] Battle.net
echo [6] GOG Galaxy
echo [7] Все лаунчеры
echo.
echo [0] Назад
echo.
set /p launcher_choice="Выберите [0-7]: "

if "%launcher_choice%"=="0" goto game_launchers_menu

if "%launcher_choice%"=="1" call :allow_steam
if "%launcher_choice%"=="2" call :allow_epic
if "%launcher_choice%"=="3" call :allow_origin
if "%launcher_choice%"=="4" call :allow_ubisoft
if "%launcher_choice%"=="5" call :allow_battlenet
if "%launcher_choice%"=="6" call :allow_gog
if "%launcher_choice%"=="7" (
    call :allow_steam
    call :allow_epic
    call :allow_origin
    call :allow_ubisoft
    call :allow_battlenet
    call :allow_gog
    echo ✓ Все игровые лаунчеры добавлены в разрешённые!
)

echo.
pause
goto allow_game_launchers_menu

:allow_steam
echo.
echo Добавляю Steam в разрешённые...
echo.

if not exist "lists\" mkdir lists

(
    echo # Steam - разрешён
    echo steamcommunity.com
    echo *.steamcommunity.com
    echo steamstatic.com
    echo *.steamstatic.com
    echo steampowered.com
    echo *.steampowered.com
    echo steamgames.com
    echo *.steamgames.com
    echo steamusercontent.com
    echo *.steamusercontent.com
    echo steamstore-a.akamaihd.net
    echo *.steamstore-a.akamaihd.net
    echo steamcdn-a.akamaihd.net
    echo *.steamcdn-a.akamaihd.net
    echo steamuserimages-a.akamaihd.net
    echo *.steamuserimages-a.akamaihd.net
    echo steambroadcast.akamaized.net
    echo *.steambroadcast.akamaized.net
    echo steam.tv
    echo *.steam.tv
    echo s.team
    echo *.s.team
    echo steam-chat.com
    echo *.steam-chat.com
    echo steam-api.com
    echo *.steam-api.com
    echo steamcontent.com
    echo *.steamcontent.com
    echo valvesoftware.com
    echo *.valvesoftware.com
) >> "lists\list-general.txt"

:: IP Steam
(
    echo # Steam IP
    echo 104.96.0.0/12
    echo 162.254.192.0/18
    echo 192.69.96.0/20
    echo 205.196.6.0/24
) >> "lists\ipset-all.txt"

echo ✓ Steam добавлен в разрешённые!
exit /b

:allow_epic
echo.
echo Добавляю Epic Games Store в разрешённые...
echo.

if not exist "lists\" mkdir lists

(
    echo # Epic Games - разрешён
    echo epicgames.com
    echo *.epicgames.com
    echo epicgames.net
    echo *.epicgames.net
    echo unrealengine.com
    echo *.unrealengine.com
    echo egs.launcher-public-service-prod06.ol.epicgames.com
    echo *.egs.launcher-public-service-prod06.ol.epicgames.com
    echo ecommerceintegration-public-service-ecomprod02.ol.epicgames.com
    echo *.ecommerceintegration-public-service-ecomprod02.ol.epicgames.com
    echo download.epicgames.com
    echo *.download.epicgames.com
    echo epicgames-download1.akamaized.net
    echo *.epicgames-download1.akamaized.net
    echo file.epicgames.com
    echo *.file.epicgames.com
    echo cdn2.unrealengine.com
    echo *.cdn2.unrealengine.com
    echo static-assets-prod.epicgames.com
    echo *.static-assets-prod.epicgames.com
) >> "lists\list-general.txt"

:: IP Epic Games
(
    echo # Epic Games IP
    echo 34.107.0.0/16
    echo 34.117.0.0/16
    echo 34.118.0.0/16
    echo 34.120.0.0/16
    echo 35.186.224.0/19
) >> "lists\ipset-all.txt"

echo ✓ Epic Games Store добавлен в разрешённые!
exit /b

:allow_origin
echo.
echo Добавляю Origin / EA App в разрешённые...
echo.

if not exist "lists\" mkdir lists

(
    echo # Origin / EA - разрешён
    echo origin.com
    echo *.origin.com
    echo ea.com
    echo *.ea.com
    echo eaassets-a.akamaihd.net
    echo *.eaassets-a.akamaihd.net
    echo origin-a.akamaihd.net
    echo *.origin-a.akamaihd.net
    echo secure.download.dm.origin.com
    echo *.secure.download.dm.origin.com
    echo accounts.ea.com
    echo *.accounts.ea.com
    echo signin.ea.com
    echo *.signin.ea.com
    echo api.origin.com
    echo *.api.origin.com
    echo image.dm.origin.com
    echo *.image.dm.origin.com
    echo secure.api.origin.com
    echo *.secure.api.origin.com
) >> "lists\list-general.txt"

:: IP EA/Origin
(
    echo # EA / Origin IP
    echo 159.153.0.0/16
    echo 205.185.208.0/23
    echo 208.75.76.0/22
    echo 216.98.48.0/20
) >> "lists\ipset-all.txt"

echo ✓ Origin / EA App добавлен в разрешённые!
exit /b

:allow_ubisoft
echo.
echo Добавляю Ubisoft Connect в разрешённые...
echo.

if not exist "lists\" mkdir lists

(
    echo # Ubisoft - разрешён
    echo ubisoft.com
    echo *.ubisoft.com
    echo ubisoftconnect.com
    echo *.ubisoftconnect.com
    echo uplay.com
    echo *.uplay.com
    echo static-dm.akamaized.net
    echo *.static-dm.akamaized.net
    echo ubistatic-a.akamaihd.net
    echo *.ubistatic-a.akamaihd.net
    echo ubisoft-orbit-savegames.s3.amazonaws.com
    echo *.ubisoft-orbit-savegames.s3.amazonaws.com
    echo uplaypc-s-ubisoft.cdn.ubionline.com.cn
    echo *.uplaypc-s-ubisoft.cdn.ubionline.com.cn
    echo club-ubisoft.com
    echo *.club-ubisoft.com
) >> "lists\list-general.txt"

:: IP Ubisoft
(
    echo # Ubisoft IP
    echo 23.32.0.0/19
    echo 104.87.0.0/17
    echo 185.56.64.0/22
    echo 192.229.232.0/24
) >> "lists\ipset-all.txt"

echo ✓ Ubisoft Connect добавлен в разрешённые!
exit /b

:allow_battlenet
echo.
echo Добавляю Battle.net в разрешённые...
echo.

if not exist "lists\" mkdir lists

(
    echo # Battle.net - разрешён
    echo battle.net
    echo *.battle.net
    echo blizzard.com
    echo *.blizzard.com
    echo blzddist1-a.akamaihd.net
    echo *.blzddist1-a.akamaihd.net
    echo blzmedia-a.akamaihd.net
    echo *.blzmedia-a.akamaihd.net
    echo blizzard.gcdn.cloudn.co.kr
    echo *.blizzard.gcdn.cloudn.co.kr
    echo level3.blizzard.com
    echo *.level3.blizzard.com
    echo edgecast.blizzard.com
    echo *.edgecast.blizzard.com
) >> "lists\list-general.txt"

:: IP Battle.net
(
    echo # Battle.net IP
    echo 24.105.0.0/17
    echo 137.221.0.0/16
    echo 199.108.0.0/16
) >> "lists\ipset-all.txt"

echo ✓ Battle.net добавлен в разрешённые!
exit /b

:allow_gog
echo.
echo Добавляю GOG Galaxy в разрешённые...
echo.

if not exist "lists\" mkdir lists

(
    echo # GOG - разрешён
    echo gog.com
    echo *.gog.com
    echo galaxy.gog.com
    echo *.galaxy.gog.com
    echo gog-statics.com
    echo *.gog-statics.com
    echo cdpr.cloud
    echo *.cdpr.cloud
    echo gogcdn.net
    echo *.gogcdn.net
    echo images-1.gog.com
    echo *.images-1.gog.com
    echo images-2.gog.com
    echo *.images-2.gog.com
    echo images-3.gog.com
    echo *.images-3.gog.com
    echo images-4.gog.com
    echo *.images-4.gog.com
) >> "lists\list-general.txt"

:: IP GOG
(
    echo # GOG IP
    echo 52.16.0.0/15
    echo 99.80.0.0/15
    echo 185.60.112.0/22
) >> "lists\ipset-all.txt"

echo ✓ GOG Galaxy добавлен в разрешённые!
exit /b

:remove_game_launchers_menu
cls
echo ========================================
echo    УДАЛИТЬ ИГРОВЫЕ ЛАУНЧЕРЫ
echo ========================================
echo.
echo Выберите лаунчеры для удаления:
echo.
echo [1] Steam
echo [2] Epic Games Store
echo [3] Origin / EA App
echo [4] Ubisoft Connect
echo [5] Battle.net
echo [6] GOG Galaxy
echo [7] Все лаунчеры
echo.
echo [0] Назад
echo.
set /p remove_launcher_choice="Выберите [0-7]: "

if "%remove_launcher_choice%"=="0" goto game_launchers_menu

if "%remove_launcher_choice%"=="1" call :remove_steam
if "%remove_launcher_choice%"=="2" call :remove_epic
if "%remove_launcher_choice%"=="3" call :remove_origin
if "%remove_launcher_choice%"=="4" call :remove_ubisoft
if "%remove_launcher_choice%"=="5" call :remove_battlenet
if "%remove_launcher_choice%"=="6" call :remove_gog
if "%remove_launcher_choice%"=="7" (
    call :remove_steam
    call :remove_epic
    call :remove_origin
    call :remove_ubisoft
    call :remove_battlenet
    call :remove_gog
    echo ✓ Все игровые лаунчеры удалены из разрешённых!
)

echo.
pause
goto remove_game_launchers_menu

:remove_steam
echo.
echo Удаляю Steam из разрешённых...
echo.

if exist "lists\list-general.txt" (
    findstr /v "steam steamcommunity steamstatic steampowered steamusercontent valvesoftware s\.team" "lists\list-general.txt" > "lists\list-general.tmp"
    move /y "lists\list-general.tmp" "lists\list-general.txt" > nul
)

if exist "lists\ipset-all.txt" (
    findstr /v "104.96 162.254 192.69 205.196" "lists\ipset-all.txt" > "lists\ipset-all.tmp"
    move /y "lists\ipset-all.tmp" "lists\ipset-all.txt" > nul
)

echo ✓ Steam удалён из разрешённых!
exit /b

:remove_epic
echo.
echo Удаляю Epic Games из разрешённых...
echo.

if exist "lists\list-general.txt" (
    findstr /v "epicgames unrealengine egs\.launcher" "lists\list-general.txt" > "lists\list-general.tmp"
    move /y "lists\list-general.tmp" "lists\list-general.txt" > nul
)

if exist "lists\ipset-all.txt" (
    findstr /v "34.107 34.117 34.118 34.120 35.186" "lists\ipset-all.txt" > "lists\ipset-all.tmp"
    move /y "lists\ipset-all.tmp" "lists\ipset-all.txt" > nul
)

echo ✓ Epic Games удалён из разрешённых!
exit /b

:remove_origin
echo.
echo Удаляю Origin / EA из разрешённых...
echo.

if exist "lists\list-general.txt" (
    findstr /v "origin ea\.com accounts\.ea signin\.ea" "lists\list-general.txt" > "lists\list-general.tmp"
    move /y "lists\list-general.tmp" "lists\list-general.txt" > nul
)

if exist "lists\ipset-all.txt" (
    findstr /v "159.153 205.185 208.75 216.98" "lists\ipset-all.txt" > "lists\ipset-all.tmp"
    move /y "lists\ipset-all.tmp" "lists\ipset-all.txt" > nul
)

echo ✓ Origin / EA удалён из разрешённых!
exit /b

:remove_ubisoft
echo.
echo Удаляю Ubisoft из разрешённых...
echo.

if exist "lists\list-general.txt" (
    findstr /v "ubisoft uplay ubiconnect ubistatic" "lists\list-general.txt" > "lists\list-general.tmp"
    move /y "lists\list-general.tmp" "lists\list-general.txt" > nul
)

if exist "lists\ipset-all.txt" (
    findstr /v "23.32 104.87 185.56 192.229" "lists\ipset-all.txt" > "lists\ipset-all.tmp"
    move /y "lists\ipset-all.tmp" "lists\ipset-all.txt" > nul
)

echo ✓ Ubisoft удалён из разрешённых!
exit /b

:remove_battlenet
echo.
echo Удаляю Battle.net из разрешённых...
echo.

if exist "lists\list-general.txt" (
    findstr /v "battle\.net blizzard blzddist blzmedia" "lists\list-general.txt" > "lists\list-general.tmp"
    move /y "lists\list-general.tmp" "lists\list-general.txt" > nul
)

if exist "lists\ipset-all.txt" (
    findstr /v "24.105 137.221 199.108" "lists\ipset-all.txt" > "lists\ipset-all.tmp"
    move /y "lists\ipset-all.tmp" "lists\ipset-all.txt" > nul
)

echo ✓ Battle.net удалён из разрешённых!
exit /b

:remove_gog
echo.
echo Удаляю GOG из разрешённых...
echo.

if exist "lists\list-general.txt" (
    findstr /v "gog\.com galaxy\.gog gog-statics cdpr\.cloud gogcdn" "lists\list-general.txt" > "lists\list-general.tmp"
    move /y "lists\list-general.tmp" "lists\list-general.txt" > nul
)

if exist "lists\ipset-all.txt" (
    findstr /v "52.16 99.80 185.60" "lists\ipset-all.txt" > "lists\ipset-all.tmp"
    move /y "lists\ipset-all.tmp" "lists\ipset-all.txt" > nul
)

echo ✓ GOG удалён из разрешённых!
exit /b

:show_game_launchers
cls
echo ========================================
echo    РАЗРЕШЁННЫЕ ИГРОВЫЕ ЛАУНЧЕРЫ
echo ========================================
echo.

if not exist "lists\list-general.txt" (
    echo Нет разрешённых лаунчеров.
    echo.
    pause
    goto game_launchers_menu
)

echo Ищем разрешённые игровые лаунчеры...
echo.

set "found=0"

for %%i in (steam epic origin ubisoft battle gog uplay ea blizzard unreal) do (
    findstr /i "%%i" "lists\list-general.txt" >nul
    if !errorlevel! equ 0 (
        echo ✓ %%i
        set "found=1"
    )
)

if "!found!"=="0" (
    echo Нет разрешённых игровых лаунчеров.
)

echo.
pause
goto game_launchers_menu