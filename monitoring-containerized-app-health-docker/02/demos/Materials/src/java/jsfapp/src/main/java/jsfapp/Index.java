package jsfapp;

import io.prometheus.client.Counter;
import io.prometheus.client.Gauge;

import java.net.InetAddress;
import java.net.UnknownHostException;

import javax.annotation.PostConstruct;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.SessionScoped;

@ManagedBean(name = "index", eager = true)
@SessionScoped
public class Index {
	
	private static String _Host; 
	
    private static final Counter _SessionCounter = Counter.build()
												    	  .name("StockManagement_SessionStatus")
												    	  .help("Count")
												    	  .labelNames("host", "status")
												    	  .register();
    
    private static final Gauge _SessionGauge = Gauge.build()
										    		.name("StockManagement_ActiveSessions")
										    		.help("Count")
										    		.labelNames("host")
										    		.register();   
        
    @PostConstruct
    public void sessionInit() {
    	try {
    		_Host = InetAddress.getLocalHost().getHostName();
    	}
    	catch (UnknownHostException ex) {
    		_Host = "";
    	}
    	_SessionGauge.labels(_Host).inc();
        _SessionCounter.labels(_Host, "started").inc();
    }
		
	private int _orderCount = 0;
	
	   public String getServerName() throws UnknownHostException {
	      return _Host;
	   }
	   
	   public String getOrderLog() {
		   return "Submitted: " + _orderCount + " orders.";
	   }
	   
	   public void submitOrder() {
		   _orderCount++;
		   _SessionCounter.labels(_Host, "order-submitted").inc();
	   }
}
