import kivy

from kivy import *
from kivy.app import *
# from kivy.core.text import Label
from kivy.uix import *
from kivy.uix.label import *


class App1(App):
    def build(self):
        return Label(text='Hello, world!')
App1().run()