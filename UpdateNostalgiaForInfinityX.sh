#!/bin/bash

DIR_USER_DATA="/home/ubuntu/ft_userdata/user_data"
DIR_STRATEGIES="/home/ubuntu/ft_userdata/user_data/strategies"
DIR_NFI="/home/ubuntu/ft_userdata/NFI"
TG_TOKEN="5143699327:AAFlqZnB8wSlN40uKjUMCKjB5QRmnV-ZEiY"
TG_CHAT_ID="5111144935"
UPDATE=0

cp $DIR_NFI/blacklist-binance.json $DIR_NFI/blacklist-binance.old
curl -o $DIR_NFI/blacklist-binance.json https://raw.githubusercontent.com/iterativv/NostalgiaForInfinity/main/configs/blacklist-binance.json
BL_BIN_GIT=$(md5sum $DIR_NFI/blacklist-binance.json | awk '{print $1}')

cp $DIR_NFI/blacklist-kucoin.json $DIR_NFI/blacklist-kucoin.old
curl -o $DIR_NFI/blacklist-kucoin.json https://raw.githubusercontent.com/iterativv/NostalgiaForInfinity/main/configs/blacklist-kucoin.json
BL_KUC_GIT=$(md5sum $DIR_NFI/blacklist-kucoin.json | awk '{print $1}')

cp $DIR_NFI/pairlist-volume-binance-busd.json $DIR_NFI/pairlist-volume-binance-busd.old
curl -o $DIR_NFI/pairlist-volume-binance-busd.json https://raw.githubusercontent.com/iterativv/NostalgiaForInfinity/main/configs/pairlist-volume-binance-busd.json
PL_BIN_GIT=$(md5sum $DIR_NFI/pairlist-volume-binance-busd.json | awk '{print $1}')

cp $DIR_NFI/pairlist-volume-binance-usdt.json $DIR_NFI/pairlist-volume-binance-usdt.old
curl -o $DIR_NFI/pairlist-volume-binance-usdt.json https://raw.githubusercontent.com/iterativv/NostalgiaForInfinity/main/configs/pairlist-volume-binance-usdt.json
PLUSDT_BIN_GIT=$(md5sum $DIR_NFI/pairlist-volume-binance-usdt.json | awk '{print $1}')

cp $DIR_NFI/NostalgiaForInfinityX.py $DIR_NFI/NostalgiaForInfinityX.old
curl -o $DIR_NFI/NostalgiaForInfinityX.py https://raw.githubusercontent.com/iterativv/NostalgiaForInfinity/main/NostalgiaForInfinityX.py
NFIX_BIN_GIT=$(md5sum $DIR_NFI/NostalgiaForInfinityX.py | awk '{print $1}')

BL_BIN_FT=$(md5sum $DIR_USER_DATA/blacklist-binance.json | awk '{print $1}')
BL_KUC_FT=$(md5sum $DIR_USER_DATA/blacklist-kucoin.json | awk '{print $1}')
PL_BIN_FT=$(md5sum $DIR_USER_DATA/pairlist/pairlist-volume-binance-busd.json | awk '{print $1}')
PLUSDT_BIN_FT=$(md5sum $DIR_USER_DATA/pairlist/pairlist-volume-binance-usdt.json | awk '{print $1}')
NFIX_BIN_FT=$(md5sum $DIR_STRATEGIES/NostalgiaForInfinityX.py | awk '{print $1}')

if [ $BL_BIN_GIT != $BL_BIN_FT ]; then

  UPDATE=1

  cp $DIR_NFI/blacklist-binance.json $DIR_USER_DATA/blacklist-binance.json

  curl -s --data "text=✅ AP Binance blacklist has been updated." \
	--data "parse_mode=markdown" \
	--data "chat_id=$TG_CHAT_ID" \
	"https://api.telegram.org/bot${TG_TOKEN}/sendMessage"

fi

sleep 2

if [ $BL_KUC_GIT != $BL_KUC_FT ]; then

  UPDATE=1

  cp $DIR_NFI/blacklist-kucoin.json $DIR_USER_DATA/blacklist-kucoin.json

  curl -s --data "text=✅ AP Kucoin blacklist has been updated." \
	--data "parse_mode=markdown" \
	--data "chat_id=$TG_CHAT_ID" \
	"https://api.telegram.org/bot${TG_TOKEN}/sendMessage"

fi

sleep 2

if [ $PL_BIN_GIT != $PL_BIN_FT ]; then

  UPDATE=1

  cp $DIR_NFI/pairlist-volume-binance-busd.json $DIR_USER_DATA/pairlist/pairlist-volume-binance-busd.json

  curl -s --data "text=✅ AP Binance pairlist has been updated." \
	--data "parse_mode=markdown" \
	--data "chat_id=$TG_CHAT_ID" \
	"https://api.telegram.org/bot${TG_TOKEN}/sendMessage"

fi

sleep 2

if [ $PLUSDT_BIN_GIT != $PLUSDT_BIN_FT ]; then

  UPDATE=1

  cp $DIR_NFI/pairlist-volume-binance-usdt.json $DIR_USER_DATA/pairlist/pairlist-volume-binance-usdt.json

  curl -s --data "text=✅ AP Binance USDT pairlist has been updated." \
	--data "parse_mode=markdown" \
	--data "chat_id=$TG_CHAT_ID" \
	"https://api.telegram.org/bot${TG_TOKEN}/sendMessage"

fi

sleep 2

if [ $NFIX_BIN_GIT != $NFIX_BIN_FT ]; then

  UPDATE=1

  cp $DIR_NFI/NostalgiaForInfinityX.py $DIR_STRATEGIES/NostalgiaForInfinityX.py

  curl -s --data "text=✅ AP NostalgiaForInfinityX strategy has been updated." \
	--data "parse_mode=markdown" \
	--data "chat_id=$TG_CHAT_ID" \
	"https://api.telegram.org/bot${TG_TOKEN}/sendMessage"

fi

sleep 5

if [ $UPDATE = 1 ]; then

  docker restart ZynatBinanceLive APZyBin01
  #docker-compose exec -T freqtrade python3 scripts/rest_client.py --config /freqtrade/user_data/config.json reload_config

  curl -s --data "text=🔃 AP Freqtrade docker will restart. 💵🚀" \
	--data "parse_mode=markdown" \
	--data "chat_id=$TG_CHAT_ID" \
	"https://api.telegram.org/bot${TG_TOKEN}/sendMessage"

fi
