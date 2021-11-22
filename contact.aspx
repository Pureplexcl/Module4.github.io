using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Mail;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;


public partial class Contact : System.Web.UI.Page
{
protected void Page_Load(object sender, EventArgs e)
{

}

//Code for the Reset event (will reset form data):

protected void Reset(object s, EventArgs e)
{
    fname.Text = "";
    lname.Text = "";
    email.Text = "";
    phone.Text = "";
    comments.Text = "";
}

//Code for the SendMail Event; will send email and write info in email into database:

protected void SendMail(object sender, EventArgs e)
{
    MailMessage mail = new MailMessage();
    mail.From = new MailAddress(email.Text);
    mail.To.Add("amobley123@outlook.com");
    mail.Subject = "Contact Me";
    mail.IsBodyHtml = true;
    mail.Body += "First Name: " + fname.Text + "<br />";
    mail.Body += "Last Name: " + lname.Text + "<br />";
    mail.Body += "Comments: " + comments.Text + "<br />";
    mail.Body += "Phone Number: " + phone.Text + "<br />";

    SmtpClient smtp = new SmtpClient();
    smtp.Host = "NAME OF SMTP RELAY SERVER";
    smtp.Send(mail);
}

protected void insertInfo(object sender, EventArgs e)
{
    SqlConnection myConnection = new SqlConnection             (ConfigurationManager.ConnectionStrings["WEB.CONFIG CONNECTION STRING NAME"].ToString());

    System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand();
    cmd.CommandType = System.Data.CommandType.Text;
    cmd.CommandText = "INSERT INTO TABLE NAME (fname, lname, email, phone, comment)    
VALUES (@fname, @lname, @email, @phone, @comments)";
    cmd.Connection = myConnection;

    cmd.Parameters.Add("@fname", fname.Text);
    cmd.Parameters.Add("@lname", lname.Text);
    cmd.Parameters.Add("@email", email.Text);
    cmd.Parameters.Add("@phone", phone.Text);
    cmd.Parameters.Add("@comments", comments.Text);


    myConnection.Open();
    cmd.ExecuteNonQuery();
    myConnection.Close();
}

}
