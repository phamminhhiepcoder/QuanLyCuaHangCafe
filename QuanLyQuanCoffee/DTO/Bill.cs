using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanLyQuanCoffee.DTO
{
    public class Bill
    {
        

        public Bill(DataRow row) { 
            this.ID = (int)row["id"];
            this.DateCheckIn = (DateTime?)row["dateCheckin"];

            var DateCheckOutTemp = row["dateCheckOut"];
            if (DateCheckOutTemp.ToString() != "" )
            
                this.DateCheckOut = (DateTime?)DateCheckOutTemp;
            
            
            this.Status = (int)row["status"];
        }

        private int iD;
        private DateTime? dateCheckIn;
        private DateTime? dateCheckOut;
        private int status;

        public int ID { get => iD; set => iD = value; }
        public DateTime? DateCheckIn { get => dateCheckIn; set => dateCheckIn = value; }
        public DateTime? DateCheckOut { get => dateCheckOut; set => dateCheckOut = value; }
        public int Status { get => status; set => status = value; }
    }
}
