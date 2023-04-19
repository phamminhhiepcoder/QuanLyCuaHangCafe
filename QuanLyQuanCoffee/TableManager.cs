using QuanLyQuanCoffee.DAO;
using QuanLyQuanCoffee.DTO;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace QuanLyQuanCoffee
{
    public partial class TableManager : Form
    {
        public TableManager()
        {
            InitializeComponent();

            LoadTable();
        }

        #region     Method
        void LoadTable()
        {
            List<Table> tableList = TableDAO.Instance.LoadTableList();
            foreach (Table item in tableList)
            {
                Button btn = new Button() { Width = TableDAO.TableWidth, Height = TableDAO.TableHeigh };
                btn.Text = item.Name+ Environment.NewLine + item.Status;
                btn.Click += btn_Click;
                btn.Tag = item;

                switch (item.Status)
                {
                    case "TRỐNG":
                        btn.BackColor= Color.AliceBlue;
                        break;
                    default:
                        btn.BackColor= Color.Red; break;
                }

                flbTable.Controls.Add(btn);

            }
            
        }

        void ShowBill(int id)
        {
            lsvBill.Items.Clear();
            List<Bill_Info> listBillInfo = Bill_InfoDAO.Instance.GetListBillInfo(BillDAO.Instance.GetUncheckBillIDByTableID(id));

            foreach (Bill_Info item in listBillInfo)
            {
                ListViewItem lsvItem = new ListViewItem(item.FoodId.ToString());
                lsvItem.SubItems.Add(item.Count.ToString());

                lsvBill.Items.Add(lsvItem);
            }
        }

        #endregion


        #region Events
         void btn_Click(object? sender, EventArgs e)
        {
            int tableID = ((sender as Button).Tag as Table).ID;
            ShowBill(tableID);
        }
        private void đăngXuấtToolStripMenuItem_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void thôngTinCáNhânToolStripMenuItem_Click(object sender, EventArgs e)
        {
            AccountProfile f = new AccountProfile();
            f.ShowDialog();
        }

        private void adminToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Admin f = new Admin();
            f.ShowDialog();
        }
        #endregion
    }
}
