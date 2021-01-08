from config import API_TOKEN, MYSQL_HOST, MYSQL_USER, MYSQL_PASSWORD, MYSQL_DB

import MySQLdb

conn = MySQLdb.connect(MYSQL_HOST, MYSQL_USER, MYSQL_PASSWORD, MYSQL_DB)
conn.autocommit(True)
cursor = conn.cursor()

import requests
from bs4 import BeautifulSoup

  
import asyncio
import logging

logging.basicConfig(level=logging.INFO)
log = logging.getLogger('broadcast')

from aiogram import Bot, Dispatcher
from aiogram.utils import exceptions, executor

bot = Bot(token=API_TOKEN)
dp = Dispatcher(bot)

def get_price(link):
    page = requests.get(link)
    soup = BeautifulSoup(page.text, 'html.parser')
    soup = soup.find('div', class_='BNeawe iBp4i AP7Wnd')
    return (soup.text).split(" ")[0]

cursor.execute('SELECT * FROM `stocks`')
rows = cursor.fetchall()
for row in rows:
    cursor.execute('UPDATE `stocks` SET `last_price` = `current_price`, `current_price` = %s WHERE `stock_id` = %s', [ ''.join(get_price(row[2]).replace(',', '.').split()), row[0] ])

async def send_message(user_id: int, text: str, disable_notification: bool = False) -> bool:
    try:
        await bot.send_message(user_id, text, disable_notification=disable_notification)
    except exceptions.BotBlocked:
        log.error(f"Target [ID:{user_id}]: blocked by user")
    except exceptions.ChatNotFound:
        log.error(f"Target [ID:{user_id}]: invalid user ID")
    except exceptions.RetryAfter as e:
        log.error(f"Target [ID:{user_id}]: Flood limit is exceeded. Sleep {e.timeout} seconds.")
        await asyncio.sleep(e.timeout)
        return await send_message(user_id, text)  # Recursive call
    except exceptions.UserDeactivated:
        log.error(f"Target [ID:{user_id}]: user is deactivated")
    except exceptions.TelegramAPIError:
        log.exception(f"Target [ID:{user_id}]: failed")
    else:
        log.info(f"Target [ID:{user_id}]: success")
        return True
    return False

async def broadcaster() -> int:
    
    cursor.execute(' SELECT * FROM `signals`, `stocks` WHERE `value` < ( SELECT `current_price` FROM `stocks` WHERE `stock_id` = `signals`.`stock_id` ) AND `signals`.`stock_id` = `stocks`.`stock_id` AND `last_price` != `current_price` ')
    rows = cursor.fetchall()

    count = 0
    try:
        for row in rows:
            if await send_message( user_id=row[1], text='Цена отслеживаемой Вами акции «' + row[4] + '» изменилась! Текущее значение акции — ' + str(row[7]) ):
                count += 1
            await asyncio.sleep(.05)
    finally:
        log.info(f"{count} messages successful sent.")

    return count

if __name__ == '__main__':
    executor.start(dp, broadcaster())