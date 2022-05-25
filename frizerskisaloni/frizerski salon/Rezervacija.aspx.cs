using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

namespace frizerski_salon
{
    public partial class Rezervacija : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Label1.Text = Korisnik.user_ime + " " + Korisnik.user_prezime;
                FrizerskiSalonPopulate();

                if (Korisnik.user_id == 0)
                {
                    Response.Redirect("Login.aspx");
                }
            }
        }

        protected void Calendar1_DayRender(object sender, DayRenderEventArgs e)
        {
            if (e.Day.Date <= DateTime.Now)
            {
                e.Day.IsSelectable = false;
            }
        }

        private void FrizerskiSalonPopulate()
        {
            SqlConnection veza = Konekcija.Connect();
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT * FROM FrizerskiSalon", veza);
            DataTable dt_frizerskisalon = new DataTable();
            adapter.Fill(dt_frizerskisalon);
            ddl_frizerskisalon.DataSource = dt_frizerskisalon;
            ddl_frizerskisalon.DataValueField = "id";
            ddl_frizerskisalon.DataTextField = "adresa";
            ddl_frizerskisalon.DataBind();
        }

        private void VremePopulate()
        {
            ddl_vreme.Items.Clear();

            string frizerskiSalon = ddl_frizerskisalon.SelectedValue;
            string datum = Calendar1.SelectedDate.ToString("yyyy-MM-dd");
            DateTime vreme = DateTime.Parse("8:30");

            SqlConnection veza = Konekcija.Connect();
            string naredba;
            SqlCommand komanda;

            for (int i = 0; i < 20; i++)
            {
                vreme = vreme.AddMinutes(30);
                naredba = "SELECT dbo.Proveri_Vreme(" + frizerskiSalon + ", '" + datum + "', '" + vreme.ToString("HH:mm") + "')";
                komanda = new SqlCommand(naredba, veza);
                veza.Open();
                int zauzeto = (int)komanda.ExecuteScalar();
                veza.Close();

                if (zauzeto == 0)
                {
                    ddl_vreme.Items.Add(vreme.ToString("HH:mm"));
                }
            }
        }

        protected void Calendar1_SelectionChanged(object sender, EventArgs e)
        {
            VremePopulate();
            FrizerPopulate();
        }

        protected void FrizerPopulate()
        {
            SqlConnection veza = Konekcija.Connect();
            int dan = (int)Calendar1.SelectedDate.DayOfWeek;
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT Frizer.id, ime + ' ' + prezime as naziv FROM Frizer JOIN FrizerRadniDan ON frizer_id = Frizer.id WHERE dan = " + dan, veza);
            DataTable dt_frizer = new DataTable();
            adapter.Fill(dt_frizer);
            ddl_frizer.DataSource = dt_frizer;
            ddl_frizer.DataValueField = "id";
            ddl_frizer.DataTextField = "naziv";
            ddl_frizer.DataBind();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (Calendar1.SelectedDate == null || Calendar1.SelectedDate == Convert.ToDateTime("01/01/0001") || ddl_frizer.SelectedIndex < 0 || ddl_vreme.SelectedIndex < 0 || ddl_frizerskisalon.SelectedIndex < 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Izaberite datum')", true);
            }
            else
            {
                SqlConnection veza = Konekcija.Connect();
                string naredba = "EXEC Dodaj_Rezervacija " + Korisnik.user_id + ", " + ddl_frizerskisalon.SelectedValue + ", " + ddl_frizer.SelectedValue + ", " + "'" + Calendar1.SelectedDate.ToString("yyyy-MM-dd") + "'" + ", '" + ddl_vreme.SelectedValue + "'";
                SqlCommand komanda = new SqlCommand(naredba, veza);
                try
                {
                    veza.Open();
                    komanda.ExecuteNonQuery();
                    veza.Close();
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Uspesno ste rezervisali termin')", true);

                    VremePopulate();
                    
                }
                catch (Exception greska)
                {
                    Console.WriteLine(greska.Message);
                }
            }
        }

        protected void ddl_frizerskisalon_SelectedIndexChanged(object sender, EventArgs e)
        {
            VremePopulate();
        }
    }
}