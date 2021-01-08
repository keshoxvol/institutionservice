from config import API_TOKEN#, MYSQL_HOST, MYSQL_USER, MYSQL_PASSWORD, MYSQL_DB

import MySQLdb

conn = MySQLdb.connect('db', 'one', 'root', 'blue-chips')
conn.autocommit(True)
cursor = conn.cursor()

import logging
from aiogram import Bot, Dispatcher, executor, types

import requests
from bs4 import BeautifulSoup

logging.basicConfig(level=logging.INFO)

bot = Bot(token=API_TOKEN)
dp = Dispatcher(bot)

cursor.execute('SELECT * FROM `stocks`')
names_and_links = {}
rows = cursor.fetchall()
for row in rows:
    names_and_links[row[1]] = { 'link' : row[2], 'current' : row[4] }

# conn.close()

def is_digit(string):
    if string.isdigit():
       return True
    else:
        try:
            float(string)
            return True
        except ValueError:
            return False

def get_price(name):
    link = names_and_links[name]['link']
    page = requests.get(link)
    soup = BeautifulSoup(page.text, 'html.parser')
    soup = soup.find('div', class_='BNeawe iBp4i AP7Wnd')
    return (soup.text).split(" ")[0]

main_menu_btns_text = (
    'узнать цену',
    'установить сигнал',
    'посмотреть сигналы',
)

@dp.message_handler(commands=['start', 'help'])
async def send_welcome(message: types.Message):

    keyboard_markup = types.ReplyKeyboardMarkup(row_width=3, resize_keyboard=True)
    keyboard_markup.add(*(types.KeyboardButton(text) for text in main_menu_btns_text))
    await message.reply('Что вы хотите сделать?', reply_markup=keyboard_markup)

@dp.message_handler()
async def echo(message: types.Message):

    keyboard_markup = types.ReplyKeyboardMarkup(row_width=3, resize_keyboard=True)
    button_text = message.text

    cursor.execute('SELECT `action` FROM `users` WHERE `user_id` = ' + str(message.from_user.id))
    dialog_action = cursor.fetchone()

    if dialog_action:
        dialog_action = dialog_action[0]

    # 861791417

    if button_text in names_and_links:

        if dialog_action == None:
            await bot.send_chat_action(message.chat.id, 'typing')
            keyboard_markup.add(*(types.KeyboardButton(text) for text in names_and_links))
            keyboard_markup.add('Вернуться в главное меню')

            cursor.execute('SELECT `current_price` FROM `stocks` WHERE `name` = %s', [ button_text ])

            price = cursor.fetchone()[0]
            reply_text = 'Цена акции «' + button_text + '» — ' + str(price)
            return await message.reply(reply_text, reply_markup=keyboard_markup)
        else:
            if dialog_action == 'del_signal':
                cursor.execute('DELETE FROM `users` WHERE `action` = %s AND `user_id` = %s', ['del_signal', str(message.from_user.id)])
                cursor.execute('DELETE FROM `signals` WHERE `user_id` = %s AND `stock_id` = (SELECT `stock_id` FROM `stocks` WHERE `name` = %s)', [str(message.from_user.id), button_text])
                reply_text = 'Сигнал «' + button_text + '» был успешно удален!'
                keyboard_markup.add(*(types.KeyboardButton(text) for text in main_menu_btns_text))
                return await message.reply(reply_text, reply_markup=keyboard_markup)
            elif dialog_action == 'set_signal':
                cursor.execute('SELECT `current_price` FROM `stocks` WHERE `name` = %s', [ button_text ])
                price = cursor.fetchone()[0]
                cursor.execute('INSERT INTO `users` SET `action` = %s, `user_id` = %s, `extra_data` = %s ON DUPLICATE KEY UPDATE `action` = %s, `extra_data` = %s', ['set_signal_last_step', str(message.from_user.id), button_text, 'set_signal_last_step', button_text])
                reply_text = 'Текущее значение акции «' + button_text + '» — ' + str(price) + '\nОтправьте минимальное значение акции, с которого будут приходить уведомления об изменении:'
                keyboard_markup.add('Вернуться в главное меню')
                return await message.reply(reply_text, reply_markup=keyboard_markup)

    elif button_text == 'узнать цену':
        
        keyboard_markup.add(*(types.KeyboardButton(text) for text in names_and_links))
        keyboard_markup.add('Вернуться в главное меню')
        return await message.reply('Выберите необходимую акцию', reply_markup=keyboard_markup)

    elif button_text == 'установить сигнал':

        reply_text = 'Выберите, на какую акцию хотите установить сигнал и нажмите на соответствующую кнопку:'
        cursor.execute('INSERT INTO `users` SET `action` = %s, `user_id` = %s ON DUPLICATE KEY UPDATE `action` = %s', ['set_signal', str(message.from_user.id), 'set_signal'])
        keyboard_markup.add(*(types.KeyboardButton(text) for text in names_and_links))
        keyboard_markup.add('Вернуться в главное меню')
        return await message.reply(reply_text, reply_markup=keyboard_markup)

    elif button_text == 'посмотреть сигналы':

        cursor.execute('SELECT * FROM `signals` JOIN `stocks` ON `signals`.`stock_id` = `stocks`.`stock_id` WHERE `user_id` = %s', [str(message.from_user.id)])
        rows = cursor.fetchall()

        if not rows:
            reply_text = 'У Вас нет установленных сигналов!'
        else:
            cursor.execute('INSERT INTO `users` SET `action` = \'del_signal\', `user_id` = ' + str(message.from_user.id) + ' ON DUPLICATE KEY UPDATE `action` = \'del_signal\'')

            reply_text = 'Установленные Вами сигналы:\n\n'
            for row in rows:
                reply_text += row[4] + ' - ' + str(row[2]) + '\n'
            reply_text += '\nЧтобы удалить ненужный сигнал, нажмите на соответствующую кнопку!'
            keyboard_markup.add(*(types.KeyboardButton(row[4]) for row in rows))
            keyboard_markup.add('Вернуться в главное меню')
            return await message.reply(reply_text, reply_markup=keyboard_markup)

    else:

        if dialog_action == 'set_signal_last_step' and button_text != 'Вернуться в главное меню':

            if is_digit(button_text):

                cursor.execute('SELECT `stock_id`, `name` FROM `stocks` WHERE `name` = (SELECT `extra_data` FROM `users` WHERE `user_id` = %s)', [str(message.from_user.id)])
                stock = cursor.fetchone()

                signal = None

                if stock:
                    stock_id = stock[0]
                    stock_name = stock[1]
                    cursor.execute('SELECT * FROM `signals` WHERE `stock_id` = %s', [ stock_id ])
                    signal = cursor.fetchone()
                else:
                    keyboard_markup.add(*(types.KeyboardButton(text) for text in main_menu_btns_text))
                    return await message.reply('Произошла непредвиденная ошибка, возвращаем Вас в главное меню!', reply_markup=keyboard_markup)

                if signal:
                    reply_text = 'Вы успешно обновили сигнал акции «' + stock_name + '» на ' + str(button_text) + '!'
                    cursor.execute('DELETE FROM `users` WHERE `action` = %s AND `user_id` = %s', ['set_signal_last_step', str(message.from_user.id)])
                    cursor.execute('UPDATE `signals` SET `value` = %s WHERE `stock_id` = %s AND `user_id` = %s', [button_text, stock_id, str(message.from_user.id)])
                    keyboard_markup.add(*(types.KeyboardButton(text) for text in main_menu_btns_text))
                else:
                    reply_text = 'Вы успешно установили сигнал акции «' + stock_name + '» на ' + str(button_text) + '!'
                    cursor.execute('DELETE FROM `users` WHERE `action` = %s AND `user_id` = %s', ['set_signal_last_step', str(message.from_user.id)])
                    cursor.execute('INSERT INTO `signals` SET `stock_id` = %s, `user_id` = %s, `value` = %s', [ stock_id, str(message.from_user.id), button_text])
                    keyboard_markup.add(*(types.KeyboardButton(text) for text in main_menu_btns_text))

                cursor.execute('DELETE FROM `users` WHERE `user_id` = %s', [ str(message.from_user.id) ])

                return await message.reply(reply_text, reply_markup=keyboard_markup)
            else:
                reply_text = 'Значением может быть только число!'
                return await message.reply(reply_text, reply_markup=keyboard_markup)

        elif button_text == 'Вернуться в главное меню':

            cursor.execute('DELETE FROM `users` WHERE `user_id` = %s', [ str(message.from_user.id) ])
            keyboard_markup.add(*(types.KeyboardButton(text) for text in main_menu_btns_text))
            return await message.reply('Что Вы хотите сделать?', reply_markup=keyboard_markup)

        else:
            cursor.execute('DELETE FROM `users` WHERE `user_id` = %s', [ str(message.from_user.id) ])
            keyboard_markup.add(*(types.KeyboardButton(text) for text in main_menu_btns_text))
            return await message.reply('К сожалению, я не знаю такой команды, возвращаю Вас в главное меню!', reply_markup=keyboard_markup)

    # if reply_text:
    #     await message.answer(reply_text)

# conn.close()

if __name__ == '__main__':
    executor.start_polling(dp, skip_updates=True)