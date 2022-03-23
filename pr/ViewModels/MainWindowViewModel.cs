using pr.Models;
using pr.ViewModels.Base;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace pr.ViewModels
{
    internal class MainWindowViewModel : ViewModel
    {
        public CollegeEntities db = new CollegeEntities();
        #region

        private ObservableCollection<Specialty> _Specialties;
        public ObservableCollection<Specialty> Specialties { get => _Specialties; set => Set(ref _Specialties, value); }

        private ObservableCollection<Group> _Groups;
        public ObservableCollection<Group> Groups { get => _Groups; set => Set(ref _Groups, value); }

        private ObservableCollection<Student> _Students;
        public ObservableCollection<Student> Students { get => _Students; set => Set(ref _Students, value); }
        #endregion

        private Specialty _SelectedSpecialty;
        public Specialty SelectedSpecialty { get => _SelectedSpecialty; set => Set(ref _SelectedSpecialty, value); }

        private Group _SelectedGroup;
        public Group SelectedGroup { get => _SelectedGroup; set => Set(ref _SelectedGroup, value); }
        public MainWindowViewModel()
        {

        }

    }
}
