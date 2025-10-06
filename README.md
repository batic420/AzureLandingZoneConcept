# AzureLandingZoneConcept 🌍

"AzureLandingZoneConcept" is my first demo project that is public.

It helps me to enhance my skills using IaC and to create something that could be useful in the future. If the project helped you to understand Azure Landing Zone or you find it useful in general, please save it by hitting the ⭐

Disclaimer:
The project isn't finished yet, so resources are missing or best practises haven't been established to 100%.

## You're new to Bicep or Infrastructure-as-Code? - Amazing! Getting started with Bicep

1. Download [VSCode](https://code.visualstudio.com/download) as your IDE

2. Install the [Bicep extension](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-bicep) - this can also be done directly in VS Code

3. To deploy Bicep files:
    - Install [AzureCLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli-windows?tabs=azure-cli) **[recommended method]** or
    - [Azure PowerShell](https://learn.microsoft.com/en-us/powershell/azure/install-azure-powershell?view=azps-10.3.0) (must install [Bicep manually](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/install#install-manually) if you want to use with PowerShell)

4. [Fork](https://github.com/batic420/Azure-Landing-Zone-Concept/fork) this repository so you can directly use my codebase

5. In your forked repository you can directly run commands and deploy the infrastructure -> check the parameter files and pipelines for this!

6. Read the README files for further information and explanations about my code

## About the purpose of the project 🔍

I started my cloud journey at the start of 2024, since then, I have been working in the cloud and I absolutely love it!

What scared me at first, was the enormous number of Buzzwords you'll hear once you dive in a bit deeper. Two of them were "IaC" and "Azure Landing Zones"

I researched a bit and after a while I found out that these two parts of "Cloud Computing" are actually not scary or something but essential parts of good infrastructure.

So I decided to combine them together to learn more about IaC and also work on Azure Landing Zones. Sure, the project currently is small and not ready for real-world cloud deployments but thats not a big deal - good things take time and I want to expand the project more and more as I grow into my role as a Cloud Engineer / Architect / Infrastructure Consultant - whatever you want to call it 😉

## About the resources 🛠️

I created the project to be as modular as possible - every "bigger" resource component is a single module. You can build your environment how you want it to be - with the resources you want to deploy.

### Core 👨‍🏭
Everything comes down to the `main.bicep` file which is the "heart" of the project - in it you will find all modules that will be deployed once you run the respective Azure CLI / Azure Powershell or pipeline. 

To find all modules that are currently available, I will create a separate `.md` file that will list them all. You'll just pick your module, add the necessary parameters to the `.bicepparam` file/s and you're good to go!

### Types 🦾
I want to avoid having tons of parameters in the module files, thats why I created user defined types whenever it makes sense. This helps to create a clean codebase that also prevents you from omitting necessary parameters, using wrong formats and so on.

You can have a look at all my custom types (exported or not) inside the `\types` folder. I will create a separate `.md` file for this section also.

### Deployments 🚀
To deploy the resources you can choose multiple approaches. If you followed my *Getting started* block you should have **Azure CLI** or **Azure PowerShell** installed.

Here are the docs for the commands you're going to need to deploy the environment using your local terminal:
- [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/deployment/sub?view=azure-cli-latest)
- [Azure PowerShell](https://learn.microsoft.com/en-us/powershell/module/az.resources/new-azdeployment?view=azps-14.4.0)

If you want to integrate Azure DevOps Pipelines, you can have a look at the `\pipelines` folder to find two pipelines. One of them is just a very simple and basic pipeline that will execute the same command you'll use if you're going to deploy locally.

The other one though, is more advanced. It supports multiple environments and also includes some checks of your current code. This prevents deployments with bad syntax and other common mistakes.

Use `\pipelines\azure-pipelines-simple.yaml` if you want to experiment with Azure Pipelines or want to create an initial deployment. If you're more experienced or want to have a professional pipeline solution, choose `\pipelines\azure-pipelines.yaml`.

For more details about the pipelines, I'll create a separate `.md` file for the `\pipelines` folder.

## Conclusion

This project is a simple demo environment, so please treat it like that. I don't have 5+ years of cloud experience but wanted to share my current progress and also help others that are maybe struggeling with similar cases 😄

If you want to learn more or connect with me on [LinkedIn](https://www.linkedin.com/in/bastian-ludwig-128927311/)