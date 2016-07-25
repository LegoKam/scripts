This program generates a Component Usage report: 

#Give Scripts access
chmod 775 ./componentUsageReport.sh

#Example run: Replicate all nodes that were modified between 10-June-2016 to 14-june-2016.
./componentUsageReport.sh "/apps/geometrixx" "/content/geometrixx" "admin:admin" "localhost" "4502"

What happens:

1) Run a query and get a list of all Component on the Project.
2) Loop though each component, and find the no. of pages using it.
3) Also finds out if the page has been activated / deactivated / not-activated.