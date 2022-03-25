using Microsoft.Win32;
using pr.Models;
using pr.ViewModels;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;

namespace pr.Views
{
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }
        public object StringComparsion { get; private set; }

        private void SpecialtiesCollection_Filter(object sender, FilterEventArgs e)
        {
            if (!(e.Item is Specialty specialty)) return;
            if (specialty.SpecialtyName == null) return;
            var filter_text = SpecialtiesFilterTextBox.Text.ToLower().Trim();
            if (filter_text.Length == 0) return;
            if (specialty.SpecialtyName.ToLower().Contains(filter_text)) return;
            if (specialty.SpecialtyReduction.ToLower().Contains(filter_text)) return;
            e.Accepted = false;
        }

        private void SpecialtiesFilterTextBox_TextChanged(object sender, TextChangedEventArgs e)
        {
            var text_box = (TextBox)sender;
            var collection = (CollectionViewSource)text_box.FindResource("SpecialtiesCollection");
            collection.View.Refresh();
        }

        private void GroupsCollection_Filter(object sender, FilterEventArgs e)
        {
            if (!(e.Item is Group group)) return;
            if (group.GroupNumber == null) return;
            var filter_text = GroupsFilterTextBox.Text.ToLower().Trim();
            if (filter_text.Length == 0) return;
            if (group.GroupNumber.ToLower().Contains(filter_text)) return;
            if (group.Specialty.SpecialtyReduction.ToLower().Contains(filter_text)) return;
            e.Accepted = false;
        }

        private void GroupsFilterTextBox_TextChanged(object sender, TextChangedEventArgs e)
        {
            var text_box = (TextBox)sender;
            var collection = (CollectionViewSource)text_box.FindResource("GroupsCollection");
            collection.View.Refresh();
        }

        private void StudentsCollection_Filter(object sender, FilterEventArgs e)
        {
            if (!(e.Item is Student student)) return;
            var filter_text = StudentFilterTextBox.Text.ToLower().Trim();

            if (filter_text.Length == 0 && GPAComboBox.SelectedIndex == -1)
                return;
            if (GPAComboBox.SelectedIndex != -1)
            {
                if (student.GPA > (float)GPAComboBox.SelectedItem) e.Accepted = true;
                else e.Accepted = false;
            }
            if (e.Accepted == true)
            {
                if (filter_text.Length > 0)
                {
                    if (student.Surname.ToLower().StartsWith(filter_text)) return;
                    if (student.FirstName.ToLower().StartsWith(filter_text)) return;
                    if (student.LastName.ToLower().StartsWith(filter_text)) return;
                    if (student.Gender.GenderName.ToLower().StartsWith(filter_text)) return;
                    if (student.Birthday.ToString().Contains(filter_text)) return;
                }
                else return;
            }
            e.Accepted = false;
        }

        private void StudentFilterTextBox_TextChanged(object sender, TextChangedEventArgs e)
        {
            var text_box = (TextBox)sender;
            var collection = (CollectionViewSource)text_box.FindResource("StudentsCollection");
            collection.View.Refresh();
            CountTextBox.Text = (collection.View.Cast<object>().Count() - 1).ToString();
        }

        private void GPAComboBox_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            var combo_box = (ComboBox)sender;
            var collection = (CollectionViewSource)combo_box.FindResource("StudentsCollection");
            collection.View.Refresh();
            CountTextBox.Text = (collection.View.Cast<object>().Count() - 1).ToString();
        }

        private void ResetButton_Click(object sender, RoutedEventArgs e)
        {
            StudentFilterTextBox.Text = string.Empty;
            GPAComboBox.SelectedIndex = -1;
        }
    }
}