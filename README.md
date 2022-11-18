This repository contains an E2E solution architecture on how to use OpenAI to solve common real world enterprise scenarios such as storing,  searching, and summarizing data. 

This sample contains a solution notebook that shows you how easy it is to use Azure OpenAI along with Azure Cognitive Search, Azure Storage and Visual Studio Code to make sense of large amounts of data.

Following are detailed step by step instructions to setup an environment to try out this solution notebook for yourself: 

**Clone Git Repository**

  1. Install - [Git - Downloading Package (git-scm.com)](https://git-scm.com/download/win)
  2. Install - [GitHub Pull Requests and Issues - Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=GitHub.vscode-pull-request-github)
  3. Open VSCode - close all folders and pick Clone Git Repository
  4. Clone [https://github.com/Azure-Samples/summarization-python-openai.git](https://github.com/Azure-Samples/summarization-python-openai.git)

**Create a Python Virtual Environment**

  1. Ctrl-Shift-P, then type Python: Create Environment
  2. Pick venv and the Python interpreter
  3. [Using Python Environments in Visual Studio Code](https://code.visualstudio.com/docs/python/environments#_using-the-create-environment-command)
  4. Open the qbs\_end\_to\_end.ipynb notebook file and change the environment to your new venv (top right hand corner).

**Deploy to Azure with azd up**   
  1. [Install Azure Developer CLI](https://learn.microsoft.com/en-us/azure/developer/azure-developer-cli/install-azd?tabs=baremetal%2Cwindows) 
  2. From the VSCode Terminal run az bicep upgrade
  3. run azd up

 **Final Step: Run each of the steps in the Python notebook**