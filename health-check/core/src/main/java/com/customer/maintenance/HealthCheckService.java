package com.customer.maintenance;


import org.apache.felix.scr.annotations.*;
import org.osgi.service.component.ComponentContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Service(value = HealthCheckService.class)
@Component(immediate = true, metatype = true, label = "Customer Health check service")
@Properties(
        {
                @Property(name = "status.message",
                        options = {
                                @PropertyOption(name = "normal", value = "normal"),
                                @PropertyOption(name = "maintenance", value = "maintenance")
                        })
        }
)
public class HealthCheckService {

    private String message;
    private Logger LOG = LoggerFactory.getLogger(HealthCheckService.class);

    public String getMessage() {
        
        return message != null ? message : "normal";

    }

    @Activate
    public void activate(ComponentContext ctx) {
        message = (String) ctx.getProperties().get("status.message");
    }

    @Deactivate
    public void deactivate() {
        //Nothing to do.
    }

}