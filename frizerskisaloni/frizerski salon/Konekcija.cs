using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Configuration;

namespace frizerski_salon
{
    public class Konekcija
    {
        static public SqlConnection Connect()
        {
            string cs = ConfigurationManager.ConnectionStrings["veza"].ConnectionString;
            SqlConnection veza = new SqlConnection(cs);
            return veza;
        }
    }
}