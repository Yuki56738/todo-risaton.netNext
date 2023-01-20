import kivy

from kivy import *
from kivy.app import *
from kivy.properties import StringProperty
# from kivy.core.text import Label
from kivy.uix import *
from kivy.uix.boxlayout import *
from kivy.uix.button import *
from kivy.uix.label import *


class BoxLayout1(BoxLayout):

    def build(self, **kwargs):
        button1 = Button
        button1.text = 'aaaaa'

    # def clicked1(self):
    #     self.button1 = 'bbbb'
    # button1.text = 'bbbb'


class App1(App):
    def __init__(self, **kwargs):
        super(App1, self).__init__(**kwargs)
        BoxLayout1()


    # def build(self):
    #     return BoxLayout1().button1
    # text = StringProperty()

    # text = StringProperty()

    # def build(self):
    #     return Label(text='Hello, world!')


App1().run()
