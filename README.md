This repository contains an E2E solution architecture on how to use OpenAI to solve common real world enterprise scenarios such as storing,  searching, and summarizing data. 

This sample contains a solution notebook that shows you how easy it is to use Azure OpenAI along with Azure Cognitive Search, Azure Storage and Visual Studio Code to make sense of large amounts of data.

Following are detailed step by step instructions to setup an environment to try out this solution notebook for yourself: 

**Clone Git Repository**

  1. Install - [Git - Downloading Package (git-scm.com)](https://git-scm.com/download/win)
  2. Install - [GitHub Pull Requests and Issues - Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=GitHub.vscode-pull-request-github)
  3. Open VSCode - close all folders and pick Clone Git Repository. Clone [https://github.com/Azure-Samples/summarization-python-openai.git](https://github.com/Azure-S. amples/summarization-python-openai.git). Cloning might take a while since this pulls down a large dataset file.

**Create a Python Virtual Environment**

  1. Ctrl-Shift-P, then type Python: Create Environment
  2. Pick venv and the Python interpreter [Using Python Environments in Visual Studio Code](https://code.visualstudio.com/docs/python/environments#_using-the-create-environment-command). Wait for the environment to get created, this will also take a while (see the bottom right for status)
  3. Open the qbs\_end\_to\_end.ipynb notebook file in the src folder. Change the environment to the above .venv (top right hand corner, might say base). 

**Run azd up to deploy this solution to Azure**
   1. Install - [Azure Developer CLI](]https://learn.microsoft.com/en-us/azure/developer/azure-developer-cli/install-azd?tabs=baremetal%2Cwindows)
   2. In the VSCode Terminal run az bicep upgrade
   3. In the VSCode Terminal run azd up

**Final Step: Go to VSCode and run each of the steps in the Python notebook**
