<%@page session="false" %><%
%><%@include file="/libs/granite/ui/global.jsp" %>


<%

    com.customer.maintenance.HealthCheckService healthCheckService = sling.getService(com.customer.maintenance.HealthCheckService.class);
	out.println(healthCheckService.getMessage());

%>

