#include <iostream>
#include "nsIMyService.h"

class nsMyService : public nsIMyService
{
public:
    NS_DECL_ISUPPORTS
    NS_DECL_NSIMYSERVICE

    nsMyService() { }

private:
    ~nsMyService() { }
};

NS_IMPL_ISUPPORTS(nsMyService, nsIMyService)

NS_IMETHODIMP nsMyService::Hoge(nsIMyService *otherService)
{
    if (otherService) {
        std::cout << "nsMyService::Hoge(non-nullptr) (native)" << std::endl;
        return otherService->Hoge(this);
    } else {
        std::cout << "nsMyService::Hoge(nullptr) (native)" << std::endl;
        return NS_OK;
    }
}

extern "C" void CLInitialize(nsIMyService **outService)
{
    std::cout << "entering CLInitialize (native)" << std::endl;
    (new nsMyService())->QueryInterface(NS_IMYSERVICE_IID, (void **)outService);
    std::cout << "leaving CLInitialize (native)" << std::endl;
}
