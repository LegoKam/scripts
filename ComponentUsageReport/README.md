This program generates a Component Usage report: 

#Give Scripts access
chmod 775 ./componentUsageReport.sh

#Component Usage Report for Geometrixx Components
./componentUsageReport.sh "/apps/geometrixx" "/content/geometrixx" "admin:admin" "localhost" "4502"

What happens:

* Run a query and get a list of all Component on the Project.
* Loop though each component, and find the no. of pages using it.
* Also finds out if the page has been activated / deactivated / not-activated.