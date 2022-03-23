using Microsoft.Win32;
using pr.Models;
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
        public ObservableCollection<Gender> Genders { get; }
        CollegeEntities db = new CollegeEntities();
        Group SelectedGroup = null;
        Specialty SelectedSpecialty = null;

        public MainWindow()
        {
            InitializeComponent();
            Genders = new ObservableCollection<Gender>(db.Genders.ToList());
            DataContext = this;
            ChangeSpecialtiesButtonsVisibility(false);
            ChangeGroupsButtonsVisibility(false);
            Start();
        }
        private void Start()
        {
            SpecialtiesListBox.ItemsSource = db.Specialties.ToList();
        }
        private void ChangeSpecialty()
        {
            SelectedSpecialty = SpecialtiesListBox.SelectedItem as Specialty;
            bool isVisible;
            if (SelectedSpecialty != null)
            {
                GroupsListBox.ItemsSource = SelectedSpecialty.Groups.ToList();
                isVisible = true;
                StudentsDataGrid.ItemsSource = null;
            }
            else
                isVisible = false;
            ChangeSpecialtiesButtonsVisibility(isVisible);
        }
        private void ChangeGroup()
        {
            SelectedGroup = GroupsListBox.SelectedItem as Group;
            bool isVisible;
            if (SelectedGroup != null)
            {
                StudentsDataGrid.ItemsSource = SelectedGroup.Students.ToList();
                isVisible = true;
            }
            else
                isVisible = false;
            ChangeGroupsButtonsVisibility(isVisible);
        }
        private void ChangeSpecialtiesButtonsVisibility(bool isVisible)
        {
            if(isVisible)
            {
                AddSpecialtyButton.Visibility = Visibility.Visible;
                EditSpecialtyButton.Visibility = Visibility.Visible;
                DeleteSpecialtyButton.Visibility = Visibility.Visible;
            }
            else
            {
                AddSpecialtyButton.Visibility=Visibility.Collapsed;
                EditSpecialtyButton.Visibility=Visibility.Collapsed;
                DeleteSpecialtyButton.Visibility=Visibility.Collapsed;
            }
        }
        private void ChangeGroupsButtonsVisibility(bool isVisible)
        {
            if(isVisible)
            {
                AddGroupButton.Visibility = Visibility.Visible;
                EditGroupButton.Visibility = Visibility.Visible;  
                DeleteGroupButton.Visibility=Visibility.Visible;
                SaveStudentsButton.Visibility = Visibility.Visible;
                DeleteStudentButton.Visibility = Visibility.Visible;
            }
            else
            {
                SaveStudentsButton.Visibility=Visibility.Collapsed;
                DeleteStudentButton.Visibility=Visibility.Collapsed;

                AddGroupButton.Visibility = Visibility.Collapsed;
                EditGroupButton.Visibility = Visibility.Collapsed;
                DeleteGroupButton.Visibility = Visibility.Collapsed;
            }
        }
        
        private void SaveStudentsButton_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                db.SaveChanges();
                MessageBox.Show("Данные успешно сохранены.", "Успешно", MessageBoxButton.OK, MessageBoxImage.Information);
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString(), ex.Message, MessageBoxButton.OK, MessageBoxImage.Error); 
            }
        }

        private void DeleteStudentButton_Click(object sender, RoutedEventArgs e)
        {
            var selectedStudent = StudentsDataGrid.SelectedItem as Student;
            if (selectedStudent != null)
            {
                if (MessageBox.Show(
                    "Вы действительно хотите удалить запись о студенте " + selectedStudent.Surname + ' ' + selectedStudent.FirstName + '?',
                    "Подтвердите действие",
                    MessageBoxButton.YesNo, MessageBoxImage.Warning
                    ) == MessageBoxResult.No) return;
                else
                {
                    db.Students.Remove(selectedStudent);
                    db.SaveChanges();
                    ChangeGroup();
                }
            }
        }


        private void LoadImageButton_Click(object sender, RoutedEventArgs e)
        {
            var selectedStudent = StudentsDataGrid.SelectedItem as Student;
                OpenFileDialog openDialog = new OpenFileDialog();
                openDialog.Filter = "Файлы изображений|*.bmp;*.png;*.jpg";
                if (openDialog.ShowDialog() != true)
                    return;
                string path = openDialog.FileName;
                selectedStudent.PhotoPath = path;
                ChangeGroup();
            
            
        }
        #region Обработчики событий
        private void SpecialtiesListBox_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            ChangeSpecialty();
        }

        private void GroupsListBox_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            ChangeGroup();
        }

        #endregion
    }
}

