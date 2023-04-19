using QuanLyQuanCoffee.DTO;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanLyQuanCoffee.DAO
{
    public class Bill_InfoDAO
    {
        private static Bill_InfoDAO instance;

        public static Bill_InfoDAO Instance {
            get { if (instance == null) instance = new Bill_InfoDAO(); return instance; }
            private set => instance = value;
        }
        private Bill_InfoDAO() { }

        public List<Bill_Info> GetListBillInfo(int id)
        {
            List<Bill_Info> listBillInfo = new List<Bill_Info>();
            DataTable data = DataProvider.Instance.ExcuteQuery("Select * From dbo.BillInfo where idBill = " + id);
            foreach (DataRow item in data.Rows)
            {
                Bill_Info info = new Bill_Info(item);
                listBillInfo.Add(info);
            }
            return listBillInfo;
        }
    }
}
