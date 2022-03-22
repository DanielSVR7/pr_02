using pr.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;
using System.Windows.Media;

namespace pr.Views
{
    public partial class AuthorizationWindow : Window
    {
        CollegeEntities db = new CollegeEntities();
        public AuthorizationWindow()
        {
            InitializeComponent();
            WelcomeMessage.Visibility = Visibility.Hidden;
        }
        private async void LoginButton_Click(object sender, RoutedEventArgs e)      //Обработчик события нажатия на конпку войти 
        {
            try         //Попытка авторизоваться
            {
                string _login = loginTextBox.Text;
                string _password = PasswordBox.Password;
                var user = (from _user in db.Users
                            where _login == _user.Login && _password == _user.Password
                            select _user).Single();
                WelcomeMessage.Text += "\n" + user.FullName + '!';
                WelcomeMessage.Visibility = Visibility.Visible;
                LoginButton.IsEnabled = false;
                await Task.Delay(2000);
                MainWindow m = new MainWindow();
                m.Show();
                this.Close();
            }
            catch       //Если пара логина и пароля не найдена в базе данных
            {
                LoginLabel1.Foreground = Brushes.Red;
                LoginLabel2.Foreground = Brushes.Red;
                await Task.Delay(1000);
                LoginLabel1.Foreground = (Brush)new BrushConverter().ConvertFrom("#BF000000");
                LoginLabel2.Foreground = (Brush)new BrushConverter().ConvertFrom("#BF000000");
            }
        }

        private void RegisterLink_MouseUp(object sender, MouseButtonEventArgs e)
        {
            RegistrationWindow r = new RegistrationWindow(db);
            r.ShowDialog();
            db = new CollegeEntities();
        }
    }
}
