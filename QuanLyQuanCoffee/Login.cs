using QuanLyQuanCoffee.DAO;

namespace QuanLyQuanCoffee
{
    public partial class Login : Form
    {
        public Login()
        {
            InitializeComponent();
        }

        private void btnLogin_Click(object sender, EventArgs e)
        {
            string userName = txbUserName.Text;
            string passWord = txbPassword.Text;
            if (login(userName, passWord))
            {
                TableManager a = new TableManager();
                this.Hide();
                a.ShowDialog();
                this.Show();
            }
            else
            {
                MessageBox.Show("Sai tên tào khoản hoặc mật khẩu! ");
            }
            

        }

        bool login(string userName, string passWord)
        {
            return AccountDAO.Instance.Login(userName, passWord);
        }

        private void btnExit_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

        private void Login_FormClosing(object sender, FormClosingEventArgs e)
        {
            if(MessageBox.Show("Bạn có thật sự muốn thoát chương trình?", "Thông báo",MessageBoxButtons.OKCancel)!=System.Windows.Forms.DialogResult.OK)
                e.Cancel = true;
        }
    }
}