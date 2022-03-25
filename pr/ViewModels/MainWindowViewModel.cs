using Microsoft.Win32;
using pr.Infrastructure.Commands;
using pr.Models;
using pr.ViewModels.Base;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Input;

namespace pr.ViewModels
{
    class MainWindowViewModel : ViewModel
    {
        public CollegeEntities db = new CollegeEntities();
        #region Коллекции

        private ObservableCollection<Specialty> _Specialties;
        private ObservableCollection<Gender> _Genders;
        public ObservableCollection<Specialty> Specialties { get => _Specialties; set => Set(ref _Specialties, value); }
        public ObservableCollection<Gender> Genders { get => _Genders; set => Set(ref _Genders, value); }
        #endregion

        private Specialty _SelectedSpecialty;
        private Group _SelectedGroup;
        private Student _SelectedStudent;
        public Specialty SelectedSpecialty { get => _SelectedSpecialty; set => Set(ref _SelectedSpecialty, value); }
        public Group SelectedGroup { get => _SelectedGroup; set => Set(ref _SelectedGroup, value); }
        public Student SelectedStudent { get => _SelectedStudent; set => Set(ref _SelectedStudent, value); }

        private List<float> _GPAFilter = new List<float>() { 2, 3, 4 };
        public List<float> GPAFilter { get => _GPAFilter; set => Set(ref _GPAFilter, value); }

        private int _NumberOfFilteredStudents;
        public int NumberOfFilteredStudents { get => _NumberOfFilteredStudents; set => Set(ref _NumberOfFilteredStudents, value); }
        public MainWindowViewModel()
        {
            #region Комманды 
            LoadImageCommand = new LambdaCommand(OnLoadImageCommandExecuted, CanLoadImageCommandExecute);
            SaveStudentsCommand = new LambdaCommand(OnSaveStudentsCommandExecuted, CanSaveStudentsCommandExecute);
            DeleteStudentCommand = new LambdaCommand(OnDeleteStudentCommandExecuted, CanDeleteStudentCommandExecute);
            AddGroupCommand = new LambdaCommand(OnAddGroupCommandExecuted, CanAddGroupCommandExecute);
            SaveGroupCommand = new LambdaCommand(OnSaveGroupCommandExecuted, CanSaveGroupCommandExecute);
            DeleteGroupCommand = new LambdaCommand(OnDeleteGroupCommandExecuted, CanDeleteGroupCommandExecute);
            #endregion

            Specialties = new ObservableCollection<Specialty>(db.Specialties.ToList());
            Genders = new ObservableCollection<Gender>(db.Genders.ToList());

        }
        #region AddGroupCommand
        public ICommand AddGroupCommand { get; }
        private bool CanAddGroupCommandExecute(object p)
        {
            if (SelectedSpecialty == null)
                return false;
            else return true;
        }
        private void OnAddGroupCommandExecuted(object p)
        {
            SelectedGroup = new Group() { Specialty = SelectedSpecialty };
        }
        #endregion

        #region SaveGroupCommand
        public ICommand SaveGroupCommand { get; }
        private bool CanSaveGroupCommandExecute(object p)
        {
            if (SelectedGroup == null || SelectedGroup.GroupNumber == null || SelectedGroup.GroupNumber == string.Empty)
                return false;
            else return true;
        }
        private void OnSaveGroupCommandExecuted(object p)
        {
            if (!SelectedSpecialty.Groups.Contains(SelectedGroup))
                db.Groups.Add(SelectedGroup);
            db.SaveChanges();
            Specialties = new ObservableCollection<Specialty>(db.Specialties.ToList());
            MessageBox.Show(
                "Внесенные изменения успешно сохранены", "Успешное сохранение",
                MessageBoxButton.OK, MessageBoxImage.Information);
        }
        #endregion

        #region DeleteGroupCommand
        public ICommand DeleteGroupCommand { get; }
        private bool CanDeleteGroupCommandExecute(object p)
        {
            if (SelectedGroup == null)
                return false;
            else return true;
        }
        private void OnDeleteGroupCommandExecuted(object p)
        {
            MessageBoxResult result = MessageBox.Show(
                "Будет удалено записей: " + SelectedGroup.Students.Count + ".\nПродолжить?",
                "Подтвердите каскадное удаление",
                MessageBoxButton.YesNo, MessageBoxImage.Warning);
            if (result != MessageBoxResult.Yes) return;
            else
            {
                List<Student> slist = SelectedGroup.Students.ToList();
                foreach (var item in slist)
                    db.Students.Remove(item);
                db.Groups.Remove(SelectedGroup);
                db.SaveChanges();
                Specialties = new ObservableCollection<Specialty>(db.Specialties.ToList());
            }
        }
        #endregion

        #region LoadImageCommand
        public ICommand LoadImageCommand { get; }
        private bool CanLoadImageCommandExecute(object p)
        {
            if (p is Student student && SelectedGroup.Students.Contains(student))
                return true;
            else return false;
        }
        private void OnLoadImageCommandExecuted(object p)
        {
            if (!(p is Student student)) return;
            OpenFileDialog openDialog = new OpenFileDialog();
            openDialog.Filter = "Файлы изображений|*.bmp;*.png;*.jpg";
            if (openDialog.ShowDialog() != true)
                return;
            string path = openDialog.FileName;
            student.PhotoPath = path;
            Specialties = new ObservableCollection<Specialty>(db.Specialties.ToList());
        }
        #endregion

        #region SaveStudentsCommand
        public ICommand SaveStudentsCommand { get; }
        private bool CanSaveStudentsCommandExecute(object p)
        {
            if (SelectedGroup == null)
                return false;
            else return true;
        }
        private void OnSaveStudentsCommandExecuted(object p)
        {
            try
            {
                db.SaveChanges();
                Specialties = new ObservableCollection<Specialty>(db.Specialties.ToList());
                MessageBox.Show(
                    "Внесенные изменения успешно сохранены", "Успешное сохранение",
                    MessageBoxButton.OK, MessageBoxImage.Information);
            }
            catch
            {
                MessageBox.Show("Заполните все обязательные поля", "Ошибка",
                    MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }
        #endregion

        #region DeleteStudentCommand
        public ICommand DeleteStudentCommand { get; }
        private bool CanDeleteStudentCommandExecute(object p)
        {
            if (p is Student student && SelectedGroup.Students.Contains(student))
                return true;
            else return false;
        }
        private void OnDeleteStudentCommandExecuted(object p)
        {
            if (!(p is Student student)) return;
            MessageBoxResult result = MessageBox.Show(
                "Вы действительно хотите удалить запись студента " + student.Surname + ' ' + student.FirstName + '?',
                "Подтвердите действие", MessageBoxButton.YesNo, MessageBoxImage.Warning);
            if (result == MessageBoxResult.No) return;
            else
            {
                db.Students.Remove(student);
                db.SaveChanges();
            }
        }
        #endregion


    }
}
