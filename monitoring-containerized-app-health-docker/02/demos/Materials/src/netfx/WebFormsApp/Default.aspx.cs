using Prometheus;
using System;
using System.Net;
using System.Web.UI;

namespace WebFormsApp
{
    public partial class _Default : Page
    {
        private static string _Host = Environment.MachineName;
        private static Counter _SessionCounter = Metrics.CreateCounter("HomePage_SessionStatus", "Count", "host", "status");
        private static Gauge _SessionGauge = Metrics.CreateGauge("HomePage_ActiveSessions", "Count", "host");
        
        private string SessionId
        {
            get
            {
                var sessionId = Session["Id"] as string;
                if (string.IsNullOrEmpty(sessionId))
                {
                    sessionId = Guid.NewGuid().ToString().Substring(0, 6);
                    Session["Id"] = sessionId;
                    _SessionGauge.Labels(_Host).Inc();
                    _SessionCounter.Labels(_Host, "started").Inc();
                }
                return sessionId;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            lblServer.Text = _Host;
            if (!Page.IsPostBack)
            {
                listLog.Items.Add($"Session started - ID: {SessionId}");                
            }
        }

        protected void BtnAddToCart_Click(object sender, EventArgs e)
        {
            listLog.Items.Add($"Added item to cart - session ID: {SessionId}");
            _SessionCounter.Labels(_Host, "added-to-cart").Inc();
        }

        protected void BtnCheckout_Click(object sender, EventArgs e)
        {
            listLog.Items.Add($"Checked out - session ID: {SessionId}");
            Session.Remove("ID");
            _SessionCounter.Labels(_Host, "checked-out").Inc();
            _SessionGauge.Labels(_Host).Dec();
    }
    }
}