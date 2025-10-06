# Landing Zone Concept
To get a feeling for designing and building corporate infrastructure following the best practises like the Cloud-Adoption-Frameworks and others, I created this repo to exactly do what mentioned - build this using Infrastructure-as-Code (IaC) - in this case using Bicep which is specifically created for Azure.

# Components
The whole repo will be deployed to one subscription (not usual but ok for testing/learning) and contains multiple resource groups with specific resources in them. Core components are a hub-and-spoke-network with public accessibility (using public ips) and security aspects (firewalling) presented by a dedicated hub network. Around this hub network a few spokes are created that host some applications like web apps.

### Platform landing zone resources:
- Azure Firewall
- Public Accessibility
- Management Options
- Policy
- Storage

### Application landing zone resources:
- Azure Web Apps
- Azure Bot Service
- Azure Machine Learning
- Azure Virtual Desktop
- Azure Kubernetes Service

These are some services/concepts that are regularly used in Azure and are located on both sides of the landing zone architecture. Some of them are also a part of this Concept to create real-world-scenarios, like accessing a website from the outside.