using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Collections.ObjectModel;
using net.openstack.Core.Providers;
using net.openstack.Core.Exceptions.Response;
using net.openstack.Core.Domain;

namespace NebulaTest1
{
	class Program
	{
		static void Main(string[] args)
		{
			Program p = new Program();
			p.Run3();

		}
		private void Run3()
		{
			CloudIdentityWithProject cloudIdentity = new CloudIdentityWithProject();
			cloudIdentity.Username = "USERNAME";
			cloudIdentity.Password = "PASSWORD";
            cloudIdentity.ProjectName = "PROJECT NAME";
            cloudIdentity.ProjectId = new ProjectId("PROJECT ID");

			OpenStackIdentityProvider openStackIdentityProvider = new OpenStackIdentityProvider(new Uri("https://proxy.eagle.nebula.com:8770"));			
			UserAccess userAccess = openStackIdentityProvider.Authenticate(cloudIdentity);
            IdentityToken token = userAccess.Token;

		}
	}
}
