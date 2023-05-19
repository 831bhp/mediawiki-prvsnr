# Provisioner for Mediawiki  
## Automate the deployment of MediaWiki  
- This provisioner provisions the Mediawiki using the steps mentioned [here](https://www.mediawiki.org/wiki/Manual:Running_MediaWiki_on_Debian_or_Ubuntu).  

## Prerequisites  
1. Azure subscription (Currently only Azure is supported)  
2. Azure object Identity already created with following details:  
   - Client id  
   - Client secret  
   - Tenant ID  
   - Subscription ID  
3. Linux VM (Ubuntu 18.04), it will be provisioned automatically.  

## Sample deployment  

![mediawiki-rg](https://github.com/831bhp/mediawiki-prvsnr/assets/99785311/d4cd89d7-083d-48a2-a1b1-a9f2d725e738)

# Steps to install  
1. Clone the repo:  
   ```
   git clone https://github.com/831bhp/mediawiki-prvsnr.git  
   cd mediawiki-prvsnr
   ```  
2. Run the master script, that will run everything and provide the IP address of the provisioned VM at the end  
   ```
   bash sudo ./provision_all.sh --client-id "e16dxxx-xxxx-xxxx-8441-3211047xxxxx"\
                                --client-secret "igX8Q~xxxxxxxxxxxxxxxxxxxxmWnVrDjrd4TcfG"\
                                --tenant-id "5938xxxx-xxxx-xxxx-x45x-xxx7254f9dxx"\
                                --subscription-id "xxxxxxx6-x1bx-x2bx-xxxf-f6xxxxxx18xx"
   .
   .
   .
   
   local_file = "linuxkey.pem"
   public_ip_address = "20.192.2.124"
   resource_group_name = "mediawiki-rg"
   ```
   The sample testlogs are uploaded at top of the repo for reference.  

3. As shown, it will give the public IP address of the provisioned VM at the end, copy the IP address and paste it in your browser followed by mediawiki, e.g. http://20.192.2.124/mediawiki  
   Note: Please check the [troubleshooting guidelines](https://www.mediawiki.org/wiki/Manual:Running_MediaWiki_on_Debian_or_Ubuntu) if above URL does not work, also check the logs of the provisioner_all.sh carefully and look for any error.  

4. If everything works fine, you will see following on the webpage:  
    ![Mediawiki_config-1](https://github.com/831bhp/mediawiki-prvsnr/assets/99785311/d73b27fa-1ae7-4c9a-a4ff-fda851085376)

5. Proceed and follow the steps as shown in the screenshots below:  
    ![Mediawiki_config-2](https://github.com/831bhp/mediawiki-prvsnr/assets/99785311/dc3fde09-a3ec-49d3-b6a3-bd0a30bedcf8)
    
    ![Mediawiki_config-3](https://github.com/831bhp/mediawiki-prvsnr/assets/99785311/be14b53c-3654-46d8-aa6c-bb4899a47c0d)
    
    ![Mediawiki_config-4](https://github.com/831bhp/mediawiki-prvsnr/assets/99785311/cb8cfa2e-d52e-40bd-865c-493a7e66fb1f)
    
    ![Mediawiki_config-5](https://github.com/831bhp/mediawiki-prvsnr/assets/99785311/85f4d7cb-615b-47d9-a1b1-e81ffee1f015)
    
    ![Mediawiki_config-6](https://github.com/831bhp/mediawiki-prvsnr/assets/99785311/a1661fd3-62c9-4cee-a604-bbfbd1eaf91b)
    
    ![Mediawiki_config-7](https://github.com/831bhp/mediawiki-prvsnr/assets/99785311/df039a98-c504-4ca2-9a60-249885427f2b)
    
    ![Mediawiki_config-8](https://github.com/831bhp/mediawiki-prvsnr/assets/99785311/a98dff07-65e7-40f9-b40f-56f51707f283)
    
    ![Mediawiki_config-9](https://github.com/831bhp/mediawiki-prvsnr/assets/99785311/123f066d-27bd-4312-baf4-a56f24666e06)
    
    ![Mediawiki_config-10](https://github.com/831bhp/mediawiki-prvsnr/assets/99785311/5d50b445-9dcd-4aff-a789-3b9ecc2377cf)
    
    ![Mediawiki_config-11](https://github.com/831bhp/mediawiki-prvsnr/assets/99785311/2e4e4754-155a-4ea8-a151-15b1ce0d7c44)
    
    ![Mediawiki_config-12](https://github.com/831bhp/mediawiki-prvsnr/assets/99785311/5d62f5d7-b576-4454-aab9-470cd5437f51)
    
    ![Mediawiki_config-13](https://github.com/831bhp/mediawiki-prvsnr/assets/99785311/0d46b50d-81be-4b7c-a22d-e3dec12b5e61)
    
    ![Mediawiki_config-14 -final](https://github.com/831bhp/mediawiki-prvsnr/assets/99785311/bcad9718-62fa-4a6e-80f3-501d9f23e86d)

7. All done, happy "Wikiing"  
