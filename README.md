This repository contains an E2E solution architecture on how to use OpenAI to solve common real world enterprise scenarios such as storing,  searching, and summarizing data. 

This sample contains a solution notebook that shows you how easy it is to use Azure OpenAI along with Azure Cognitive Search, Azure Storage and Visual Studio Code to make sense of large amounts of data.

Following are detailed step by step instructions to setup an environment to try out this solution notebook for yourself: 

I Clone Git Repo using VSCode:

  1. Install - [Git - Downloading Package (git-scm.com)](https://git-scm.com/download/win)
  2. Install - [GitHub Pull Requests and Issues - Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=GitHub.vscode-pull-request-github)
  3. Open VSCode - close all folders and pick Clone Git Repository. Clone [https://github.com/Azure-Samples/summarization-python-openai.git](https://github.com/Azure-S. amples/summarization-python-openai.git). Cloning might take a while since this pulls down a large dataset file.

II Create Virtual Environment using VSCode:

  1. Ctrl-Shift-P, then type Python: Create Environment
  2. Pick venv and the Python interpreter [Using Python Environments in Visual Studio Code](https://code.visualstudio.com/docs/python/environments#_using-the-create-environment-command). Wait for the environment to get created, this will also take a while (see the bottom right for status)
  3. Open the qbs\_end\_to\_end.ipynb notebook file in the src folder. Change the environment to the above .venv (top right hand corner, might say base). 

III Create Azure Environment using Bicep:

  1. [On Windows] Install Node.js 6 or later ([https://nodejs.org](https://nodejs.org/)).
  2. Install [Azure Account - Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=ms-vscode.azure-account).
  3. Install - [Bicep - Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-bicep)
  4. [Optional] Edit rg.parameters.json if you don't want to use default names for the resources
  5. Right click on rg.bicep and pick Deploy Bicep File … Enter relevant names and other fields
  6. Monitor the output window and click on link to portal to monitor deployment

IV Store secrets in a .env file:

  1. Create a .env file in the src folder
  2. Add 4 values into it getting them from the Keys section of the portal for the respective resources (use the Query key for search and not the admin key):
    
    OPENAI_API_KEY=
    OPENAI_ENDPOINT=https://<youropenainame>.openai.azure.com/
    SEARCH_API_KEY=
    SEARCH_ENDPOINT=https://<yoursearchname>.search.windows.net/

V Upload dataset to Azure Storage using VSCode:

  1. Ensure the storage account is created with a blob service called _default_ and a blob container called _openaiblob_
  2. Install [Azure Storage - Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azurestorage)
  3. Right click on cnn\_dataset.json (in the data sub-folder) and select Upload to Azure Storage, filling in the required fields.

VIa Import dataset data into Search using the Azure Portal

  1. Go to the search service you created in the portal
  2. Pick Import data and fill in the settings as below

    Data Source: Azure Blob Storage
    Data to extract: Content and metadata
    Parsing mode: JSON array
    Connection string - Choose existing - Storage Account (created above) - Container (created above)

VIb (Skip to) Customize target index -

  1. Check the fields id/article/highlights making the latter 2 searchable.
  2. Make id, article, highlights retrievable
  3. Create indexer
  4. Submit

VII **Final Step: Go to VSCode and run each of the steps in the Python notebook**
