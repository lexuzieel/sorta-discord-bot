import os
import discord
from dotenv import load_dotenv

load_dotenv(verbose=True)


class Client(discord.Client):
    async def on_ready(self):
        print('Logged on as {0}!'.format(self.user))

    async def on_message(self, message):
        print('Message from {0.author}: {0.content}'.format(message))


client = Client()
client.run(os.getenv('DISCORD_BOT_TOKEN'))
