Return-Path: <bpf+bounces-52783-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D1CA487B4
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 19:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BFCC3A8149
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 18:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E2F1F417F;
	Thu, 27 Feb 2025 18:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VV8uuGfg"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C6A17D355;
	Thu, 27 Feb 2025 18:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740680554; cv=fail; b=sKui4GKEZWJpyTUeZl6PkIkXEf2RQpnuaEupdk0C3Mfw8NUau9RWXlGV2nA7qxHYcDBiMabu2ZByxh2u3ARJaX5uIY4fY5Ja5e/MzJ0lsODya62L0wX7yL2N/tCCk9opSMG5MUie3rk1ejTgTrThq020Dbzsa8M/zWZWyIqFsGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740680554; c=relaxed/simple;
	bh=oO91qGoiB09Ilm6hR3xdyjYd0Ch0ivSiAdU/RUw4uBg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZO48wQceTCRh5ijzmNUmfVmogY627wveOMrC8rEk8bjiDWUKn0RBOjSqtg1a7+orXx7AZk9uYkGACejNqJ6BfCwMNqFATRx/AlsrZ9zkqLE9r/1pMYyEeGoN/EkYAKIyDMqGthCaHB/P01SPrKD1vfZ8TTeOuBSkAx+RAlmxMuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VV8uuGfg; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740680554; x=1772216554;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=oO91qGoiB09Ilm6hR3xdyjYd0Ch0ivSiAdU/RUw4uBg=;
  b=VV8uuGfg04ilOdlbR1/A9hy9QgxZXdTtdTekK3TQQsOssOwBfvVrvEIl
   z0axxhUqbDLjgXPYXvkt+xJqX+dKRPScP6jMdxV7v9F9EihuztaCP5F/7
   Y6k16RW9EqLAfpp+fY4WSus1OOkTJx2DRVBj+CrigW+cJlvil0hZ341FU
   JEY9t+xN00VOwnLhPar3oy6JEAZ8bJP6k4F3zCkoRhCli+0A0j2BtJHOU
   l3gPA7luDJSUrBfuUMWPMCRyGpVaLVYLFOmmNePvu1UbvXBZHuujSMc3A
   T+nd6fCB7yXajFP5bulLppkiBW0ZdrirWxBn64CYONtzHIcpPu6oxA47c
   A==;
X-CSE-ConnectionGUID: zwgSrm5DQSOZcCzGwo3Ciw==
X-CSE-MsgGUID: AxyD3yItRwW3SvOQbRbi5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="51794713"
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="51794713"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 10:22:32 -0800
X-CSE-ConnectionGUID: Xn80YMdWSIa+9TbwJom28g==
X-CSE-MsgGUID: 61fxDIV9QbilPZPnUXwXCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118026219"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 10:22:31 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 27 Feb 2025 10:22:29 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 27 Feb 2025 10:22:29 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 27 Feb 2025 10:22:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TjYUBi2LEiSSg/ruEGY+9Av3kZhgeKx0BLKMDUa60NNS261/r7mPvQYk05JoDQiK6X2d6jhQQZdNdjw7xz+52w5w4RMW3A5Sx+gyb7Y844VVgerFw6ojwt91MtUc34tjehCfmbCjTLbmC81tu2Dz4u6qHVCWNWI4Yop9OjsualuUwMeRAeVknUCXSpDSEe9yAnYaYNjhez3lgN4iyVLFK5wqEKUEjbiVclTw/4/kqKn5q2fCUFnS/Lvq7Yo68G0u6QHlMXlfmN7ZWeEpyD1HAC3669J6jTkROlZyVNdP8gbl4yu4BzRkecH++tWl513XRqwsbBlT8/gWE84YsxDG0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1dId1Kp2vrRTY12Ehc4yGQdLK2khsOblagJrM3rUZHA=;
 b=QYAgHjvMlnS5oghdYlssutgAclRwf6lv9ihZCWo7XUHl5MH7Wv2JqkZUWOj6tSYn7tOJg0sf4ajuAjZPsuEy7as9um9W6cbxVkCgBuiW7oUAv3s67qNpg3wzZyxsuGrqrovIbNCAGe/WZTk9ScD9vW283vB2ZEFKrMufDaEelybykO5YMEMipXyHR+NRq+nMje4eoE+XTE8yhYGhZSvIgr3Ts43pqw91xnFYKNiA/0r8sf0kfqnxh1U3RrH1BdvjMTa7RLuq7mTyIe/9TbVi8QiHUkvDEUImUs8v8HExrxH41zeiHGHfFQA7S/JmEB5AzQ8rRvr22vnFFMLGqEkuQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 PH7PR11MB7718.namprd11.prod.outlook.com (2603:10b6:510:2b6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Thu, 27 Feb
 2025 18:21:59 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%3]) with mapi id 15.20.8466.024; Thu, 27 Feb 2025
 18:21:59 +0000
Date: Thu, 27 Feb 2025 19:21:47 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Tushar Vyavahare <tushar.vyavahare@intel.com>
CC: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <bjorn@kernel.org>,
	<magnus.karlsson@intel.com>, <jonathan.lemon@gmail.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <tirthendu.sarkar@intel.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/xsk: Add tail adjustment tests
 and support check
Message-ID: <Z8CtO2enntB/lrnp@boxer>
References: <20250227142737.165268-1-tushar.vyavahare@intel.com>
 <20250227142737.165268-3-tushar.vyavahare@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250227142737.165268-3-tushar.vyavahare@intel.com>
X-ClientProxiedBy: MR1P264CA0144.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:51::8) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|PH7PR11MB7718:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b8b360d-bc5c-4d0c-fd6b-08dd575b9fda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6tvXQTR+j3GRcyf9XmX67iflx96Ei62MfRSlZE7JTbn87T9EQJoYe0RbFkAO?=
 =?us-ascii?Q?t3foucff5lWNWY2O7giZGb+wFP5Rooy2+DLxEwhLRtSpLA4tj9LveVqGdtef?=
 =?us-ascii?Q?hXzTdt99NY7ZHhpycPP7fQ3eJD3zqTg3/ojOecP4IktjS+f2SWG2H0pJe95D?=
 =?us-ascii?Q?XlG16tznt9kZw/kiftT/JvjnJr0Hhv0h3eGFOtYxXspHJV7c9egMOBxpkGA9?=
 =?us-ascii?Q?CG8QCM6hI2JOspPOdJek8Yx6wCBsIX48BvFIdmIyCPuZNlUEynaBgSnz47LO?=
 =?us-ascii?Q?MQCoLQrBl+pjzNKar6RIm+Xc8eToB2k/SbV5u+WKzVZUTF3zm61tkjeQQbje?=
 =?us-ascii?Q?5plhqnR8TfMvddXpMcm+Ug5rn8na3EEh2zKUXCoRuoteDvfNNRoTSx21t3aS?=
 =?us-ascii?Q?uq7w8gDbnm/UA4lTbFvyScSTRIpGE1/Zw3jRInNPIbLyeCOvi7lZX7bmZ+Nz?=
 =?us-ascii?Q?NWSEuQOkyjg+56fZl8HAoLhFafKRaEq1ZH5fh928qPr1VFstxf/X6vpt29Yr?=
 =?us-ascii?Q?z1HnBRslqqrgYULWDfU6sg38AVeZ+5LHB2RMYiUU4xHmZuvYBHsQIiVDZweQ?=
 =?us-ascii?Q?poK+gsQvRNl94YeUJlEKX/X4I3EcWKqYv2FEnH00rh2tPfEBNNF1l1mrf8n4?=
 =?us-ascii?Q?nYqP85PVXaWAqzaQVDVqsvycfynnCQ+HEZ5CfC3RC3AYhUQPb7me3mMDFAXU?=
 =?us-ascii?Q?pJSUYNpL1TskbFzyGhv6bz4Pd8DvBgHxcb7Nd8guttgq5/9JAcJX2sS1NEaE?=
 =?us-ascii?Q?G356PLPOeGcCFpsmuOMBhoPrHzGA5OUBKYZW81ezx4Ad09qTUM/YqkqAs5Nm?=
 =?us-ascii?Q?aibwZjcQoVSlIiXNw8VSblCBVNCuhpstAJ4YPE58dXbE7SA5905pWdh7f5wg?=
 =?us-ascii?Q?5esu6sD94Km7mzaaZepWsmT73s4u6TdT7PzJhFAn6aYnMVL+xupaUQjyup+a?=
 =?us-ascii?Q?Pruhv07cngy1gvROgmHq8bmItgZMNrSqy4BhACdHsg893Ig49CnUfxhrrGHl?=
 =?us-ascii?Q?Tuh8LXtuxAmrptrKl4NksjLduK5WexGfKoLuqzVNDV6w3e3TyYjk9d0JMOGe?=
 =?us-ascii?Q?3s7fyB1OKBwqQZXuYm9cnKUVAqhiFKtKkKPhnfHA236B59Vm2WRL2nhOQE0n?=
 =?us-ascii?Q?hIeENg/n3OKeQxC/ZbLAGHXXRnoFJhxVv03czcvVy+lokP9D9+N2COlPv5v3?=
 =?us-ascii?Q?dfbGFlrRnPlBjxcX7GIoZ2H/6ZnyZkH4dOBYy0N3y2t7jmZd/+VmpqDuCckA?=
 =?us-ascii?Q?XTwonV2Dm0Swm9v92Ywz+DkBZXeM245ZOyQy23pWlarGkJKDMBm9QDrx6w4K?=
 =?us-ascii?Q?YKncxkWu952SSIFP5f0cB5UHwQjLmJwU+zP57a7kR+sZAHH1hH35vp4KKcVT?=
 =?us-ascii?Q?J0odJqpSFQlS++fD8L5I9sWvR2S+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CbmJ+gt4DPS0iRKECv1xxI1Nn0br4QKqrPtrn7rN9pKhfOWWflfd+FdolRDZ?=
 =?us-ascii?Q?84qq10EHst3ZniPJL5RfnaBiDtJsP38k8+EawE6Tlx7qejZ+59ASgiSedIJT?=
 =?us-ascii?Q?QFqvxNXwWrSnBk89CdJnF/A/YOqNmaUuD26EA0wQH2ox09foC0TWTvTi8sJr?=
 =?us-ascii?Q?XVuiO9vtIOJw3OOpMDDjWsWCLgQuE1eDxn0obJzOO6rVSICWJTFf1HkHHMVW?=
 =?us-ascii?Q?EOzBV/aPidsXSiOIg//HVrvGETLCvXSd58CiMqix0mq5t8a5gVff7DwCs1pd?=
 =?us-ascii?Q?IXLLVw+pxnvNEg31mrJNiljL7JJPAOpBQStQUgPDmh2QrtZ/9r9JFQV81xRX?=
 =?us-ascii?Q?vpwI9bqevi9QjrLndC8eVoVCVYKnwn/pLQIWi+IXa3Pd8vVoh/E/TuqEzPaz?=
 =?us-ascii?Q?sD2815UYfTps2xIhez6TKcTaB1qT+9Ic4Sa6MQfbo+BnNFxaRYZW9YDqXfGG?=
 =?us-ascii?Q?gMHTQqz1Znjy8d/KqAOp/WuC1/Y9d5v26t5fkjcMgdR5lDHtRCbeE+pY2kRg?=
 =?us-ascii?Q?zL2kcY6H3a/scFbW9XmOHpEjA2tYQL4WqEq3QTMkcVRwDwFIKfwirGqTg2Xj?=
 =?us-ascii?Q?//YY7tg90fi3WrsgfUqwrdmx79FZmr6MW8GeicVcKBPZsexGDP7gUB40LQF7?=
 =?us-ascii?Q?6ToG5+IrslEmMdT5+5n43kTnbFcijPix36XAtMeyR+jPGRkzPMoNu6u9aaVP?=
 =?us-ascii?Q?NLqCz1hoyd1HEY4JnVwJQBEi6wzvpTB76EyxR+66TQhb8C3faW4EAfHFFFJ1?=
 =?us-ascii?Q?/p7JX1eNTRFIVBEbodUSC3MBYaqPzxQ3jtp+IgBRyu2z7+lyKsReiaFvp15i?=
 =?us-ascii?Q?xsniycSM9BrW4iRB3jw1t8fu+2A7f/Chjf9JxnO5uBbj4eG7m5DP4bHwt8kt?=
 =?us-ascii?Q?6Tjr9csj9wufWUzL6mtMZByKhlsD5W6BA7GAX/nDW786f7QGnkVs2ccEwhBP?=
 =?us-ascii?Q?MBf8dhsdcA//+D14S1ksX677+sl0W1wD318ABAWXvFCSItdBdc9l8OozLFQV?=
 =?us-ascii?Q?Y8UIxQsub2CZkdShViCLrJMQgBbWiteyJNpGgnucZ2KNdf8pDiw8yPf0Iny0?=
 =?us-ascii?Q?aC38dd9/9y2xnSn+IH6mktc3+cyDSNr/kN0eGCPtzaiDHusaA71QGNVgwRoy?=
 =?us-ascii?Q?5Qn5lW9URRD4TmMeE+QXLp6CH+TAN+fjYr3+NmC2IUJ+Fs85h2OmYU/GYnGt?=
 =?us-ascii?Q?jk7jsa4uFx48QxGn8Y4Vwb6sQL/dCKby5gTAWj85e0gqh3vsKRsRetWYOXST?=
 =?us-ascii?Q?4xPYC44xF9D6swie9FJKvD5d/s6lhsfuFV/1Zz2VaLoTGx+e5EPxuT/bHChw?=
 =?us-ascii?Q?8D9kPf9ahSYQI6P9ZZek6mo670KcNmeaFo54C/CnjbD6g+gZ5V5vMR7P1GWE?=
 =?us-ascii?Q?Cn+wdazISCttFWdVHlnrLUD2Bdc/3QwVXlVMODVk5USEuyudDAChV2qc5Gxd?=
 =?us-ascii?Q?lCcNwVkqP6qEsRdbXEDpaw7uSm2lB/y0wGNnRePtPzmDpK9IEJerpAP5umc5?=
 =?us-ascii?Q?ST3SryfElzaC2nqGqg4Joc9DtD5kDhxer0+fDYx91MenYRVIX9XCQFfSWl4m?=
 =?us-ascii?Q?4seq5l1iocsmQrjs426KUgXQ3My1KCaouAYx3zuoV12VTXueHpwMq7nH9ajo?=
 =?us-ascii?Q?Zw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b8b360d-bc5c-4d0c-fd6b-08dd575b9fda
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 18:21:59.4628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z8j2FeQDK9n7+m/6alC0ip3K6po7sdSfp9YBcNZ5YM/hR/rcDpAOX3zApOOnehP1WcKZo6cyRQs8Z4rs/ThnsSWTrxoXqD0R/lLTnNK9agA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7718
X-OriginatorOrg: intel.com

On Thu, Feb 27, 2025 at 02:27:37PM +0000, Tushar Vyavahare wrote:
> Introduce tail adjustment functionality in xskxceiver using
> bpf_xdp_adjust_tail(). Add `xsk_xdp_adjust_tail` to modify packet sizes
> and drop unmodified packets. Implement `is_adjust_tail_supported` to check
> helper availability. Develop packet resizing tests, including shrinking
> and growing scenarios, with functions for both single-buffer and
> multi-buffer cases. Update the test framework to handle various scenarios
> and adjust MTU settings. These changes enhance the testing of packet tail
> adjustments, improving AF_XDP framework reliability.
> 
> Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
> ---
>  .../selftests/bpf/progs/xsk_xdp_progs.c       |  48 +++++++
>  tools/testing/selftests/bpf/xsk_xdp_common.h  |   1 +
>  tools/testing/selftests/bpf/xskxceiver.c      | 118 +++++++++++++++++-
>  tools/testing/selftests/bpf/xskxceiver.h      |   2 +
>  4 files changed, 167 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c b/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c
> index ccde6a4c6319..2e8e2faf17e0 100644
> --- a/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c
> +++ b/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c
> @@ -4,6 +4,8 @@
>  #include <linux/bpf.h>
>  #include <bpf/bpf_helpers.h>
>  #include <linux/if_ether.h>
> +#include <linux/ip.h>
> +#include <linux/errno.h>
>  #include "xsk_xdp_common.h"
>  
>  struct {
> @@ -70,4 +72,50 @@ SEC("xdp") int xsk_xdp_shared_umem(struct xdp_md *xdp)
>  	return bpf_redirect_map(&xsk, idx, XDP_DROP);
>  }
>  
> +SEC("xdp.frags") int xsk_xdp_adjust_tail(struct xdp_md *xdp)
> +{
> +	__u32 buff_len, curr_buff_len;
> +	int ret;
> +
> +	buff_len = bpf_xdp_get_buff_len(xdp);
> +	if (buff_len == 0)
> +		return XDP_DROP;
> +
> +	ret = bpf_xdp_adjust_tail(xdp, count);
> +	if (ret < 0) {
> +		/* Handle unsupported cases */
> +		if (ret == -EOPNOTSUPP) {
> +			/* Set count to -EOPNOTSUPP to indicate to userspace that this case is
> +			 * unsupported
> +			 */
> +			count = -EOPNOTSUPP;
> +			return bpf_redirect_map(&xsk, 0, XDP_DROP);

is this whole eopnotsupp dance worth the hassle?

this basically breaks down to underlying driver not supporting xdp
multi-buffer. we already store this state in ifobj->multi_buff_supp.

could we just check for that and skip the test case instead of using the
count global variable to store the error code which is counter intuitive?

> +		}
> +
> +		return XDP_DROP;
> +	}
> +
> +	curr_buff_len = bpf_xdp_get_buff_len(xdp);
> +	if (curr_buff_len != buff_len + count)
> +		return XDP_DROP;
> +
> +	if (curr_buff_len > buff_len) {
> +		__u32 *pkt_data = (void *)(long)xdp->data;
> +		__u32 len, words_to_end, seq_num;
> +
> +		len = curr_buff_len - PKT_HDR_ALIGN;
> +		words_to_end = len / sizeof(*pkt_data) - 1;
> +		seq_num = words_to_end;
> +
> +		/* Convert sequence number to network byte order. Store this in the last 4 bytes of
> +		 * the packet. Use 'count' to determine the position at the end of the packet for
> +		 * storing the sequence number.
> +		 */
> +		seq_num = __constant_htonl(words_to_end);
> +		bpf_xdp_store_bytes(xdp, curr_buff_len - count, &seq_num, sizeof(seq_num));
> +	}
> +
> +	return bpf_redirect_map(&xsk, 0, XDP_DROP);
> +}
> +
>  char _license[] SEC("license") = "GPL";
> diff --git a/tools/testing/selftests/bpf/xsk_xdp_common.h b/tools/testing/selftests/bpf/xsk_xdp_common.h
> index 5a6f36f07383..45810ff552da 100644
> --- a/tools/testing/selftests/bpf/xsk_xdp_common.h
> +++ b/tools/testing/selftests/bpf/xsk_xdp_common.h
> @@ -4,6 +4,7 @@
>  #define XSK_XDP_COMMON_H_
>  
>  #define MAX_SOCKETS 2
> +#define PKT_HDR_ALIGN (sizeof(struct ethhdr) + 2) /* Just to align the data in the packet */
>  
>  struct xdp_info {
>  	__u64 count;
> diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
> index d60ee6a31c09..ee196b638662 100644
> --- a/tools/testing/selftests/bpf/xskxceiver.c
> +++ b/tools/testing/selftests/bpf/xskxceiver.c
> @@ -524,6 +524,8 @@ static void __test_spec_init(struct test_spec *test, struct ifobject *ifobj_tx,
>  	test->nb_sockets = 1;
>  	test->fail = false;
>  	test->set_ring = false;
> +	test->adjust_tail = false;
> +	test->adjust_tail_support = false;
>  	test->mtu = MAX_ETH_PKT_SIZE;
>  	test->xdp_prog_rx = ifobj_rx->xdp_progs->progs.xsk_def_prog;
>  	test->xskmap_rx = ifobj_rx->xdp_progs->maps.xsk;
> @@ -992,6 +994,31 @@ static bool is_metadata_correct(struct pkt *pkt, void *buffer, u64 addr)
>  	return true;
>  }
>  
> +static bool is_adjust_tail_supported(struct xsk_xdp_progs *skel_rx)
> +{
> +	struct bpf_map *data_map;
> +	int value = 0;
> +	int key = 0;
> +	int ret;
> +
> +	data_map = bpf_object__find_map_by_name(skel_rx->obj, "xsk_xdp_.bss");
> +	if (!data_map || !bpf_map__is_internal(data_map)) {
> +		ksft_print_msg("Error: could not find bss section of XDP program\n");
> +		exit_with_error(errno);
> +	}
> +
> +	ret = bpf_map_lookup_elem(bpf_map__fd(data_map), &key, &value);
> +	if (ret) {
> +		ksft_print_msg("Error: bpf_map_lookup_elem failed with error %d\n", ret);
> +		return false;
> +	}
> +
> +	/* Set the 'count' variable to -EOPNOTSUPP in the XDP program if the adjust_tail helper is
> +	 * not supported. Skip the adjust_tail test case in this scenario.
> +	 */
> +	return value != -EOPNOTSUPP;
> +}
> +
>  static bool is_frag_valid(struct xsk_umem_info *umem, u64 addr, u32 len, u32 expected_pkt_nb,
>  			  u32 bytes_processed)
>  {
> @@ -1768,8 +1795,13 @@ static void *worker_testapp_validate_rx(void *arg)
>  
>  	if (!err && ifobject->validation_func)
>  		err = ifobject->validation_func(ifobject);
> -	if (err)
> -		report_failure(test);
> +
> +	if (err) {
> +		if (test->adjust_tail && !is_adjust_tail_supported(ifobject->xdp_progs))
> +			test->adjust_tail_support = false;
> +		else
> +			report_failure(test);
> +	}
>  
>  	pthread_exit(NULL);
>  }
> @@ -2516,6 +2548,84 @@ static int testapp_hw_sw_max_ring_size(struct test_spec *test)
>  	return testapp_validate_traffic(test);
>  }
>  
> +static int testapp_xdp_adjust_tail(struct test_spec *test, int count)
> +{
> +	struct xsk_xdp_progs *skel_rx = test->ifobj_rx->xdp_progs;
> +	struct xsk_xdp_progs *skel_tx = test->ifobj_tx->xdp_progs;
> +	struct bpf_map *data_map;
> +	int key = 0;
> +
> +	test_spec_set_xdp_prog(test, skel_rx->progs.xsk_xdp_adjust_tail,
> +			       skel_tx->progs.xsk_xdp_adjust_tail,
> +			       skel_rx->maps.xsk, skel_tx->maps.xsk);
> +
> +	data_map = bpf_object__find_map_by_name(skel_rx->obj, "xsk_xdp_.bss");
> +	if (!data_map || !bpf_map__is_internal(data_map)) {
> +		ksft_print_msg("Error: could not find bss section of XDP program\n");
> +		return TEST_FAILURE;
> +	}
> +
> +	if (bpf_map_update_elem(bpf_map__fd(data_map), &key, &count, BPF_ANY)) {
> +		ksft_print_msg("Error: could not update count element\n");
> +		return TEST_FAILURE;
> +	}
> +
> +	return testapp_validate_traffic(test);
> +}
> +
> +static int testapp_adjust_tail(struct test_spec *test, u32 value, u32 pkt_len)
> +{
> +	u32 pkt_cnt = DEFAULT_BATCH_SIZE;
> +	int ret;
> +
> +	test->adjust_tail_support = true;
> +	test->adjust_tail = true;
> +	test->total_steps = 1;
> +
> +	pkt_stream_replace_ifobject(test->ifobj_tx, pkt_cnt, pkt_len);
> +	pkt_stream_replace_ifobject(test->ifobj_rx, pkt_cnt, pkt_len + value);
> +
> +	ret = testapp_xdp_adjust_tail(test, value);
> +	if (ret)
> +		return ret;
> +
> +	if (!test->adjust_tail_support) {
> +		ksft_test_result_skip("%s %sResize pkt with bpf_xdp_adjust_tail() not supported\n",
> +				      mode_string(test), busy_poll_string(test));
> +	return TEST_SKIP;
> +	}
> +
> +	return 0;
> +}
> +
> +static int testapp_adjust_tail_common(struct test_spec *test, int adjust_value, u32 len,
> +				      bool set_mtu)
> +{
> +	if (set_mtu)
> +		test->mtu = MAX_ETH_JUMBO_SIZE;

couldn't we base this on BPF_F_XDP_HAS_FRAGS in some way instead of
boolean var?

> +	return testapp_adjust_tail(test, adjust_value, len);
> +}
> +
> +static int testapp_adjust_tail_shrink(struct test_spec *test)
> +{
> +	return testapp_adjust_tail_common(test, -4, MIN_PKT_SIZE, false);
> +}
> +
> +static int testapp_adjust_tail_shrink_mb(struct test_spec *test)
> +{
> +	return testapp_adjust_tail_common(test, -4, XSK_RING_PROD__DEFAULT_NUM_DESCS * 3, true);
> +}
> +
> +static int testapp_adjust_tail_grow(struct test_spec *test)
> +{
> +	return testapp_adjust_tail_common(test, 4, MIN_PKT_SIZE, false);
> +}
> +
> +static int testapp_adjust_tail_grow_mb(struct test_spec *test)
> +{
> +	return testapp_adjust_tail_common(test, 4, XSK_RING_PROD__DEFAULT_NUM_DESCS * 3, true);
> +}
> +
>  static void run_pkt_test(struct test_spec *test)
>  {
>  	int ret;
> @@ -2622,6 +2732,10 @@ static const struct test_spec tests[] = {
>  	{.name = "TOO_MANY_FRAGS", .test_func = testapp_too_many_frags},
>  	{.name = "HW_SW_MIN_RING_SIZE", .test_func = testapp_hw_sw_min_ring_size},
>  	{.name = "HW_SW_MAX_RING_SIZE", .test_func = testapp_hw_sw_max_ring_size},
> +	{.name = "XDP_ADJUST_TAIL_SHRINK", .test_func = testapp_adjust_tail_shrink},
> +	{.name = "XDP_ADJUST_TAIL_SHRINK_MULTI_BUFF", .test_func = testapp_adjust_tail_shrink_mb},
> +	{.name = "XDP_ADJUST_TAIL_GROW", .test_func = testapp_adjust_tail_grow},
> +	{.name = "XDP_ADJUST_TAIL_GROW_MULTI_BUFF", .test_func = testapp_adjust_tail_grow_mb},
>  	};
>  
>  static void print_tests(void)
> diff --git a/tools/testing/selftests/bpf/xskxceiver.h b/tools/testing/selftests/bpf/xskxceiver.h
> index e46e823f6a1a..67fc44b2813b 100644
> --- a/tools/testing/selftests/bpf/xskxceiver.h
> +++ b/tools/testing/selftests/bpf/xskxceiver.h
> @@ -173,6 +173,8 @@ struct test_spec {
>  	u16 nb_sockets;
>  	bool fail;
>  	bool set_ring;
> +	bool adjust_tail;
> +	bool adjust_tail_support;
>  	enum test_mode mode;
>  	char name[MAX_TEST_NAME_SIZE];
>  };
> -- 
> 2.34.1
> 

