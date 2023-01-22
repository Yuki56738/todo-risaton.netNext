from datetime import datetime

from kivymd.app import *
from kivymd.uix.boxlayout import *
from kivymd.uix.dialog import *
from kivymd.uix.pickers import *

class DialogContent(MDBoxLayout):
    """OPENS A DIALOG BOX THAT GETS THE TASK FROM THE USER"""
    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        # set the date_text label to today's date when useer first opens dialog box
        self.ids.date_text.text = str(datetime.now().strftime('%A %d %B %Y'))


    def show_date_picker(self):
        """Opens the date picker"""
        date_dialog = MDDatePicker()
        date_dialog.bind(on_save=self.on_save)
        date_dialog.open()

    def on_save(self, instance, value, date_range):
        """This functions gets the date from the date picker and converts its it a
        more friendly form then changes the date label on the dialog to that"""

        date = value.strftime('%A %d %B %Y')
        self.ids.date_text.text = str(date)
class TwoLineAvaterIconListItem:
    pass


class ListItemWithCheckbox(TwoLineAvaterIconListItem):
    def __init__(self, pk=None, **kwargs):
        super().__init__(self, **kwargs)
        # state a pk which we shall use link the list items with the database primary keys
        self.pk = pk

    def mark(self, check, the_list_item):
        '''mark the task as complete or incomplete'''
        if check.active == True:
            # add strikethrough to the text if the checkbox is active
            the_list_item.text = '[s]' + the_list_item.text + '[/s]'
        else:
            # we shall add code to remove the strikethrough later
            pass

    def delete_item(self, the_list_item):
        '''Delete the task'''
        self.parent.remove_widget(the_list_item)


# class DialogContent(MDBoxLayout):
#     """OPENS A DIALOG BOX THAT GETS THE TASK FROM THE USER"""
#
#     def __init__(self, **kwargs):
#         super().__init__(self, **kwargs)
#         # set the date_text label to today's date when useer first opens dialog box
#         self.ids.date_text.text = str(datetime.now().strftime('%A %d %B %Y'))
#
#     def show_date_picker(self):
#         """Opens the date picker"""
#         date_dialog = MDDatePicker()
#         date_dialog.bind(on_save=self.on_save)
#         date_dialog.open()
#
#     def on_save(self, instance, value, date_range):
#         """This functions gets the date from the date picker and converts its it a
#         more friendly form then changes the date label on the dialog to that"""
#
#         date = value.strftime('%A %d %B %Y')
#         self.ids.date_text.text = str(date)
#

class MainApp(MDApp):
    task_list_dialog = None

    def build(self):
        # Setting theme to my favorite theme
        self.theme_cls.primary_palette = "DeepPurple"

    # def add_task(self, task, task_date):
    #     print("on add_task:", task, task_date)

    def show_task_dialog(self):
        if not self.task_list_dialog:
            self.task_list_dialog = MDDialog(
                title="Create Task",
                type="custom",
                content_cls=DialogContent(),
            )

        self.task_list_dialog.open()

    def close_dialog(self, *args):
        self.task_list_dialog.dismiss()

    def add_task(self, task, task_date):
        # '''Add task to the list of tasks'''

        print(task.text, task_date)
        self.root.ids['container'].add_widget(
            ListItemWithCheckbox(text='[b]' + task.text + '[/b]', secondary_text=task_date))
        task.text = ''
        print(self.root.ids['container'])


if __name__ == '__main__':
    app = MainApp()
    app.run()
