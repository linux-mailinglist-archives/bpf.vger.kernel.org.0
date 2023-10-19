Return-Path: <bpf+bounces-12637-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4577CED3C
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 03:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8784FB212DD
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 01:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F50F642;
	Thu, 19 Oct 2023 01:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TUVz44Ez"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900EF391;
	Thu, 19 Oct 2023 01:11:09 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0261A113;
	Wed, 18 Oct 2023 18:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697677868; x=1729213868;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=7/wWhp5WZzNZkPgaV7hrekuTzYgsc1/Vjk365oAFFsg=;
  b=TUVz44Ezmc19Y9sE5sPre+im5bX4/7wLLZFdhkEV47gvSYxYoOKHkL+v
   aUKo4jayGjAQwKJe5r8Rsgp61RlquEHFKPViNzsmi+CiVTupx/nKzUg9t
   6yc5ccr5xFVc/xG3kzhzyLCI36TZdQJoQloDL7xFdiqRpzLh45AlsGcLh
   Sc7ZxZGGlC4UDiPGvr4gDvaJC/LSWrVgw5BjF2mDVVPigu+udk1NPj5Ua
   lP0Lhpuw8MRF8E4Of6ZGf1c+DXsyYxy/66hnMAfgxYXT2M1Ckde3+XOsA
   aogMx+N3LaZz+TuSZIejCmFZV1r2sbULzTSLk16tjnECzvc+vnZvTPBPW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="385972853"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="385972853"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 18:11:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="930414261"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="930414261"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Oct 2023 18:11:07 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 18 Oct 2023 18:11:06 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 18 Oct 2023 18:11:06 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 18 Oct 2023 18:11:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nAoqJ4rK/MpC7onMJK3QG0Ma2LsYddLskflHfj56lNTH/Mi9PorCHMvq77dKWVlb+zGMMHNQF+MTlBlq6xxLNChb2NqaKBs5RamtEyIFGk0IGJEn2nfwayjuNUjU+DAGNKY3wv4MREhMH0Pw47Z7Mn/B2PZzWGCYmyMYr49knEKH5uzeoRu/6FWnNKVgs8YS0098wwuqFkx6S7I3rY3qG2gC9hOQbsfdsTiFQe6zBKubYHi19MovxWCzs7Hon4AWt9nh4LnONYkPYHImE5roxlH8h7TV0mLQ+4iVX3GjVTA3CzYxxXeghWnkWw/s+VFhVudKPHzjbn41GOyTjY00tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jj6cD4W4BRp9U9iPcpiL6QM6Sy6uZ6e0do5bvHeVB4o=;
 b=Gtn85rQC1imIlKb4ujXzIkVxvrJ/RfxbYHSlGBbAqyryuykfEul1XtTY/of4PKnhI9I1u6idxGsv5FNkXG1WyS3ZhzO4GcJ9eqYaILM9AGVeLYfagOour3SZsrzGtUWZTls1eLubICimXFXKS458NnNnbJWNntGBJn4dAX9FQuF7C+zBa2S0jvGiTZdoqiuGDfpM+29ffoa3rm7/mu33qzH7+CbmPlG1VRSlGCqlLSWo6HekQGrs9ibGKQHgisyVXdFYammhI2IETwKE6WaVLuc2siO5Zgh2uhDkTU+VNh9yyqdmKwtqucQTexS1SOJH4bkpFCpuaL2Btd/5xpoWEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by SA2PR11MB4923.namprd11.prod.outlook.com (2603:10b6:806:fa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Thu, 19 Oct
 2023 01:11:03 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::21f8:775f:a94d:e1c0]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::21f8:775f:a94d:e1c0%4]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 01:11:03 +0000
Date: Thu, 19 Oct 2023 09:06:10 +0800
From: kernel test robot <yujie.liu@intel.com>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>, <bhelgaas@google.com>
CC: <oe-kbuild-all@lists.linux.dev>, <linux-pm@vger.kernel.org>,
	<linux-mmc@vger.kernel.org>, Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Ricky Wu <ricky_wu@realtek.com>, Kees Cook <keescook@chromium.org>, Tony Luck
	<tony.luck@intel.com>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>, "Lukas
 Wunner" <lukas@wunner.de>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
	<bpf@vger.kernel.org>
Subject: Re: [PATCH] PCI: pciehp: Prevent child devices from doing RPM on
 PCIe Link Down
Message-ID: <202310171955.hlish6FZ-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231016040132.23824-1-kai.heng.feng@canonical.com>
X-ClientProxiedBy: KL1PR01CA0139.apcprd01.prod.exchangelabs.com
 (2603:1096:820:4::31) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|SA2PR11MB4923:EE_
X-MS-Office365-Filtering-Correlation-Id: 956edf23-e6cb-4789-1101-08dbd040435c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z+Sg8aILu9u/J9+OBib5/MF5mtCDYQJ5XnKTWFWonx0SJrIWzHdwLCdom5YL5mzkKqIpLhR9jFs+LGGKkohEuQXaIiYJM+uK26jIRuOoZ6P8fpnORuq6c1kqf53QjETHYL60AQ3npZEGNYTzmDWIu9drj2MpDmKrP181wzHqLcwnsqWBJpPG5Gf+kD+LGCM1pBhozBobsOmco8BKtQLlv77rBHrUFE1B7jfKksR8+JmowhF2SBfaBJLVneo+ZwGWzd3DTfqCX1521Fkp7iT6irPIZYZemRyHGJKD29XLdFQfRh48Ty1QWuTsexMhGlVpaZKR7NxicCoJ7kED6BZ5Zj52icEL4fUahfP1Ej6bv5kA/XFZ5NNSQ8oGMNhixYw4deLDQxBfsussVHzctf8+dKI3i4r9XuLQX0kAHrG7oP4b6JdlOq+nem1pvhNPFTrMjKWQR71j3HTPMLyeM+u9/2AemG7TiqU9wApPVfrQOhPWNA+rmA3RvAeZxBzAXvUg8fV/wFgbZhQ2/QY4UwycmRZum9xt5u5vt+SP2eesrGEWaooDr7BQT6v69eSq9lAFCbNYWf1OQvKCgS0MdR+P5Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(136003)(366004)(396003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(2616005)(26005)(6666004)(6512007)(6506007)(83380400001)(4001150100001)(5660300002)(8676002)(8936002)(4326008)(41300700001)(7416002)(2906002)(966005)(6486002)(316002)(478600001)(66476007)(66556008)(66946007)(54906003)(1076003)(86362001)(82960400001)(38100700002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e3kWUdarVcUqybapBbJnlu1d3nIlTjyoBlhpXUP+lRqpGu/bivZNEnfdsKVd?=
 =?us-ascii?Q?XK8mGmejbrG6CnSrJgGkyKcnCGoV0cChg5j8TOiNSUUxhZKZgcN0GsCzb8iu?=
 =?us-ascii?Q?KWJMrHKQwdWM6pmsgSfJLqY/MOFhqasDNv0VxYJTlK7eSHyupEipftpYk0NB?=
 =?us-ascii?Q?iwLr1mfRVH4QEICnou9CKPVRyo26hBdWLdcCBdTmgQ+sa/agc17rXuOTMZuZ?=
 =?us-ascii?Q?oMSmtRjuvzRV4Pstyiqa29HVz8e8dbAxj18G3yf11w2qxk+paCUmC+DQo35+?=
 =?us-ascii?Q?+OnKdpQNMHdlKeNJhprzfiA88/qM3IrABXqKPvyJ+NBKjlkKb59js17oLdM+?=
 =?us-ascii?Q?kMg7d+aZlEwcqZSssZVHOXzc6micQE0xij8rYSOQMT4id5A6SQrPaRTE9CQL?=
 =?us-ascii?Q?aLfllEsM4pqe/LIWoWTUovRipOaZP7S5c42iKbtP4paVghRNyocy7R0LkEFq?=
 =?us-ascii?Q?uqTi0CFJaO3mTrXScYw4PQzCq5OuvNmIXOmyFgJfFwZow1AIMjNqVguGvKIb?=
 =?us-ascii?Q?8E8yV2k3Fdxp2rZdj7Qv/zKc6v4ftUy27yaMtIWgl4Q3mCH8IxaMscKxKMZI?=
 =?us-ascii?Q?SRLGjPgwjynKxSKfvSs3oIEOn0m9p7pzj61w8ZhRwZ8F6TzWQRTHmMNwhj8J?=
 =?us-ascii?Q?9KxDCwu1OkZi8qm9xLbdSkxkdcnquftnH20W7F4aykW9WWDQBxfCBxGAPPL1?=
 =?us-ascii?Q?aRDIAPvUg2QEP7snkU7zDT0ISLkoOnD/w1V1Uxmw0ks0JTQ8koQFSQBJHMzU?=
 =?us-ascii?Q?WnHGr/w8Tsmr7qj0QEz/L90+GKycGP9RVsvW2xr7c42yAdqEujDEHGHf8tfI?=
 =?us-ascii?Q?ln0WBQ9/qgz/MwscNr90884Wi6pgw/UmYwuwK2esH7gVeW6d9hLPZtlzjXK6?=
 =?us-ascii?Q?Fbzz4TKlrL3a1Bh2OzDrQyyLF+Negi1ro0WLtMp9ET2WoRMUOepJDH4hPBLi?=
 =?us-ascii?Q?sjIOOkehY1qyhjiE2DAJ7kfb9h3ERcj3kC5RkNUbBRUTDYFh7fjFpjwqCCZe?=
 =?us-ascii?Q?fC/hTa2dry29JnHrl6LJnQaYZjH4opzKR1EstvST4+6PjNxPfLGBRS74dVeH?=
 =?us-ascii?Q?FoUdDtGsCApdSMez4qD4SOweJNFoB/KB4TI8E10yauYcRZ8Z/a6J7xsCIFJ6?=
 =?us-ascii?Q?0WAxoi/OuS62qNJznECW23Sa+jVRBxOf1FfJyzo1puiW96oaSIL8aw/exNb0?=
 =?us-ascii?Q?BFWmjAXZOF7jBI7GR31MlI+tf5pJiz9tP4GPxyEJXxOx+MF1r3V/RE1HSbRj?=
 =?us-ascii?Q?sEn88TDGmc/Jja3kJt5lzqVDZGFrB9zj9BqGpC3MOpjoB4s8WjA1BGcIz9bQ?=
 =?us-ascii?Q?wME2epNA7zF7EtEZFYuMrnGwozJmA4/XwkGaoj5I4J6y7Gmjq270NO5x/QVx?=
 =?us-ascii?Q?ipBqmXWBWxb1U4ZXZJHkGmwMXq1CLTZnDaVH8lEgoLms6+UpRV+lL6RrqfDN?=
 =?us-ascii?Q?RR1JriEgk19bvICk+XXc/OQZ71bOM1pmO6jyOm3fx3RwzWlK4bvJVIFrFNTG?=
 =?us-ascii?Q?vt86wtgAZyGVWhTTSPEg9BCFt81ghEvkuPsVvm9P413FemB4OduafN69bMmi?=
 =?us-ascii?Q?mURfwyHq+28lPBkKMKXpHRQ/w1qFBhyeHLhnzW8I?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 956edf23-e6cb-4789-1101-08dbd040435c
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 01:11:03.1101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: okgbq8PFLaYwqWb6n4eq/o4z+hNRyzhqnY5rdj3UI3xslnVROdzo0roBb95rtCQMRPscEiUWYA8qTtA0UwGTpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4923
X-OriginatorOrg: intel.com

Hi Kai-Heng,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus linus/master v6.6-rc6 next-20231017]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kai-Heng-Feng/PCI-pciehp-Prevent-child-devices-from-doing-RPM-on-PCIe-Link-Down/20231017-142208
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20231016040132.23824-1-kai.heng.feng%40canonical.com
patch subject: [PATCH] PCI: pciehp: Prevent child devices from doing RPM on PCIe Link Down
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20231017/202310171955.hlish6FZ-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231017/202310171955.hlish6FZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yujie.liu@intel.com>
| Closes: https://lore.kernel.org/r/202310171955.hlish6FZ-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/pci/hotplug/pciehp_pci.c:25:5: warning: no previous prototype for 'pci_dev_disconnect' [-Wmissing-prototypes]
      25 | int pci_dev_disconnect(struct pci_dev *pdev, void *unused)
         |     ^~~~~~~~~~~~~~~~~~


vim +/pci_dev_disconnect +25 drivers/pci/hotplug/pciehp_pci.c

^1da177e4c3f41 Linus Torvalds 2005-04-16  24  
2bd1cb5c4e6711 Kai-Heng Feng  2023-10-16 @25  int pci_dev_disconnect(struct pci_dev *pdev, void *unused)
2bd1cb5c4e6711 Kai-Heng Feng  2023-10-16  26  {
2bd1cb5c4e6711 Kai-Heng Feng  2023-10-16  27  	pm_runtime_barrier(&pdev->dev);
2bd1cb5c4e6711 Kai-Heng Feng  2023-10-16  28  	pci_dev_set_disconnected(pdev, NULL);
2bd1cb5c4e6711 Kai-Heng Feng  2023-10-16  29  
2bd1cb5c4e6711 Kai-Heng Feng  2023-10-16  30  	return 0;
2bd1cb5c4e6711 Kai-Heng Feng  2023-10-16  31  }
2bd1cb5c4e6711 Kai-Heng Feng  2023-10-16  32  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


