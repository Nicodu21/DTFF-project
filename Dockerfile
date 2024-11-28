# Use the official Python base image
FROM python:3.10-slim
 

# Set the working directory
WORKDIR /app
 
# Copy requirements if needed (optional)
# If you have a requirements.txt file, uncomment the next lines and make sure to include it in the same directory as the Dockerfile
COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt
COPY DTFF_project.ipynb /app/main.ipynb
COPY announcements.xlsx /app/
COPY Stock_Prices.xlsx /app/ 
# Install Jupyter
RUN pip install --no-cache-dir jupyter
 
# Expose the default Jupyter Notebook port
EXPOSE 8888
 
# Start Jupyter Notebook
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]
