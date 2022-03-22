using pr.Models;
using System;
using System.Linq;
using System.Windows;

namespace pr.Views
{
    public partial class RegistrationWindow : Window
    {
        CollegeEntities db;
        public RegistrationWindow(CollegeEntities context)
        {
            InitializeComponent();
            db = context;
        }

        private void regButton_Click(object sender, RoutedEventArgs e)
        {
            if (FullNameTB.Text == string.Empty || LoginTB.Text == string.Empty || PasswordTB.Password == string.Empty)
                MessageBox.Show("Заполните необходимые поля", "Обязательные поля не заполнены", MessageBoxButton.OK, MessageBoxImage.Error);
            else
            {
                try
                {
                    User user = (from _user in db.Users where _user.Login == LoginTB.Text select _user).Single();
                    MessageBox.Show
                        ("Аккаунт существует", 
                        "Аккаунт с данным логином уже существует. Измените логин или авторизуйтесь в существующий аккаунт.",
                        MessageBoxButton.OK, MessageBoxImage.Error);
                }
                catch
                {
                    try
                    {
                        var user = new User
                        {
                            FullName = FullNameTB.Text,
                            Login = LoginTB.Text,
                            Password = PasswordTB.Password
                        };
                        db.Users.Add(user);
                        db.SaveChanges();
                        this.Close();
                    }
                    catch (Exception ex)
                    {
                        MessageBox.Show(ex.ToString(), ex.Message);
                    }
                }
            }
        }
    }
}
