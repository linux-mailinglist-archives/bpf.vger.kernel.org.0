Return-Path: <bpf+bounces-46706-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EDF29EE871
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 15:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E9B22821B5
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 14:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF15218592;
	Thu, 12 Dec 2024 14:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YDkCbds1"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D341E217F48;
	Thu, 12 Dec 2024 14:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734012538; cv=fail; b=mtiC4qP5Km9Z3pLBhFppxFBr0lVE3N3f+Z0bXsVp9D9T7M/3Sk6JYBbacmFuwlE59bfeCTdfPs4w0wSp2VAOU9BjiBYoo1Rh7tBnKi6IvaY25Zh5Z/9GvpcA6MNjfAUpLW1/Di7xAAPXQUg6RRGEPi990S6a3m+Ylj874xGAiIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734012538; c=relaxed/simple;
	bh=AE/4HVNl+pmWhTijMB1BeD8ojhxrVB9jZuoiTWVre60=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rg9HUA3ZT+i3caNuFxQQqMTbgEN9/D33qBVJXSJFXSiQjlhO3VtbB/TSJ9D0dkOnUz+U5NKuZAvdIPDXn+omyybnHFpw9g7KgumNVmnZC7GnAS6PNWuZXA8pIXyFMs6A7RHQlqZ9m6cxZGjzUQmAbZZv2ZBQBzJGA/wHolSo6uo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YDkCbds1; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734012537; x=1765548537;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=AE/4HVNl+pmWhTijMB1BeD8ojhxrVB9jZuoiTWVre60=;
  b=YDkCbds1iSNsFtSwF9SNylac8kb3ZgVfuQd7YCMpt0A1HeHvoaRda6b6
   Qmz0w1wv/IVYxr5qfs/R1AQTTFVLhagvEIPd6zmh4IlRMTH4vd8zvvP9P
   zE7Xv/B5EazcSVtAGiYGGfxTGyoi5qGo0LPXCmfgqAEmdTnQABP6siKkl
   J0IaAe6FMLe4PXqN3P35cgImyjTdYacG1dGMTDGYgIyysbHY81RWMBf9p
   ZmwH10mOAQDJBpvtjBJL0Dvf47p7ypaxXEv0giClfmrt71mbS7eJNgKNP
   ga5qsBhXkqbFz2P4Bz5lv47dHYF3DOwvEw9sqthWCpHbkOhPvyu4RynbK
   A==;
X-CSE-ConnectionGUID: tGt39XwGQ9GmWlUhhwGFqQ==
X-CSE-MsgGUID: pw+QMkW4TSqTtQoUk5KIcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="51957837"
X-IronPort-AV: E=Sophos;i="6.12,228,1728975600"; 
   d="scan'208";a="51957837"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 06:08:56 -0800
X-CSE-ConnectionGUID: Odb60tQKSH6zQNQHJYqzrA==
X-CSE-MsgGUID: Yk2R49wqQM2HP26bhb6dRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="133613015"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Dec 2024 06:08:55 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 12 Dec 2024 06:08:55 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 12 Dec 2024 06:08:55 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 12 Dec 2024 06:08:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iCQOlvToMyQhUDOJgRFwpaJrGJHhD9LOJs6jEiZOfmyRiubspLwuJZyZFeaFTSQB2ZCl4M2YFFRwysfIiO4Rq+WYFYC5sfDOVvBKbIt81YAy/ugBE7qg/08ASjQsuuvyFhf8342TSJwo55hB7WLKQZfvuipie3Zyg0hkb5FIYxpZ8IjtwUulzcv0syw4ZvcUBDSHpC3XciID+R5tqMTDSZgaqZnMYUPcTmTVtx+C3S8HAzQWlTVc7YMn7d22rZMc6NL/4dOmKe/lG+xSUFRCVzk6N3bzqh0uQB/D+v+4v7AcNLXN5p2AHdss1X4SVVAUHIR+2XSY0RUNTeTmxd79aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a1L+cu789uAutBaQOBLR3pKdi2w/JdXMcty9FsmheKg=;
 b=Gps8ZvLzewuawJwohfRsUrPwRLCcYnnbszrJeTn5LUg9OV7cpfNSNLtL4z8m0Mq5mNq41ZJRgHC/pNfqZoktkEpBdAyHZtD1Q57QfeCVdRjT/6B1crGLa/4Cf6+RXAr20FMzj0Gt4CObCADIh8BhVKglVktlSa3p/Yj+L9r+OrMCULgs90oxD+1q3o66EwOQLxQLGXtgartlM6GSeoPo/i67bX0gRfKIqMs/gFHeHoR+VyrXf2Fuq1pNqMwdxyKMIr9T+XJao2/aX84fYAs0CknBYg+K2Hsih7IW+vQR0u2ZpfXql+DXgHyKBwjVCbIMVETDwFFgVkF/0Z7BR8K3yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 CY5PR11MB6485.namprd11.prod.outlook.com (2603:10b6:930:33::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15; Thu, 12 Dec 2024 14:08:52 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.8251.015; Thu, 12 Dec 2024
 14:08:52 +0000
Date: Thu, 12 Dec 2024 15:08:39 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Song Yoong Siang <yoong.siang.song@intel.com>
CC: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, "David S . Miller" <davem@davemloft.net>, "Jakub
 Kicinski" <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Vinicius Costa Gomes
	<vinicius.gomes@intel.com>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>
Subject: Re: [PATCH iwl-next v2 1/1] igc: Improve XDP_SETUP_PROG process
Message-ID: <Z1ruZwiTmph3iX9F@boxer>
References: <20241211134532.3489335-1-yoong.siang.song@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241211134532.3489335-1-yoong.siang.song@intel.com>
X-ClientProxiedBy: MI1P293CA0015.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::14) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|CY5PR11MB6485:EE_
X-MS-Office365-Filtering-Correlation-Id: e90208dc-ee1b-4136-9894-08dd1ab681f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6hFn86dIprdolSkvYJjEO7TaLYj8C3EMr3W+Tr91YglwsqhhPNjpPf2iV9B9?=
 =?us-ascii?Q?3eqlr4QioinCL9bZRoLhzykoTs3vRXJzBFGkY3ublLhnE1hv34vSuYQVrxx9?=
 =?us-ascii?Q?aDzXG/EFwjxWegXsT68YwcPgUf3MQe1xhgu1iXu5HR8pgrD73Wy8T2GcOtYF?=
 =?us-ascii?Q?hRb7BTTjODwvvE+tZOjx2sQp3aO0/YCY4gCzFv41yhx6Xk/o9WI14CblxxnO?=
 =?us-ascii?Q?ahojcgHtPCUtwlRLa6kdnd5vKVfHrgSleCtj2k0HlTGgaogq67KnbSAfNZ6s?=
 =?us-ascii?Q?w+xYXoOttfjI+Mvwd+BULKLqeHP+UqEWd50bKRIO+NscmV1bhPg30Lovmzi/?=
 =?us-ascii?Q?0OffpcoFuB+m8p6Ppmg/58KZ4UXDFY3ls+2ICj0eXi7s/8SmfMADUSB7164a?=
 =?us-ascii?Q?qmMTP3OUpo6LunXGktpN87ciCDokdje1rDAGZtHaCNTGLQhai4e3C1ReouUh?=
 =?us-ascii?Q?ySHsK6bGlny5UraVdxPo6QyXxxzmnCnIHkohiY7DPBTmcj4cy0Ycda5cqXIm?=
 =?us-ascii?Q?CBjGFyUCOiMHnAwktxM5BsSkitJOuteOP8sNjOePX9z1CIEHSlpHSjPMi5TL?=
 =?us-ascii?Q?KhmCO+FuzL6sUwJGEz16+iyG/t0nZvpoGlleuVfWNA6WDkcI+RQxkggZWjwG?=
 =?us-ascii?Q?uXBJJdm8S4fOGYYAGnn9Vd25P28UNb9V7ezH/zB+RZauJyo4dKBXs0wkYvzH?=
 =?us-ascii?Q?vt3e7tsUPBfVBAo/F82Yz5e+gq0I0tZH69bUP1CzIjwp2QqjvYbNiB2C0xzr?=
 =?us-ascii?Q?NhwC1V/r4Qm5p1IBHfKS9bzBx5iq5UfKIw2sKjwG5NwgoApZSxKNTe0oO4Ey?=
 =?us-ascii?Q?+LQAdZvEtTGq3g9zkXeUn+7KYNOJx/INIW9pTpSeqhxfCetrj9QuRxEw76xT?=
 =?us-ascii?Q?TxJVRB8G3FtKIuhJTrBpBIPT1ySZ042nm7HOtiqPMoj9uw2154tFq0bmSl7e?=
 =?us-ascii?Q?lFIght37u+YHh9vLyGa5tOFvTZGIQLzfcQaf2ta0CbWcfFP8GiV6zQZZc2/L?=
 =?us-ascii?Q?RVpz8NQYUZKDc8Y/X7ONT8lqbBx7AHzOuhyp9Jrprp/BmrvZCOu5lIgFlhKc?=
 =?us-ascii?Q?GBiA+GjJAnpm2EURtaTKZbuqs+NqtwOf3qrmWMLX5IVpyKMaRa2NlBPLwsNB?=
 =?us-ascii?Q?bMqtLty6GxkfR2AuxzDMu0JXNW3gFh7kzJktUsZg76hhGF9V2gk6js49LRpI?=
 =?us-ascii?Q?yVGallcTcUF4PoBohqr9qNRb3cuva57lKMTRL2gBm+hULb3JZQ+BSJAcpuu8?=
 =?us-ascii?Q?SQcwWEXnZK2GUVJ8qL9FM0gN8oKqrFhbrmw0q/CMnjEx8Pxd3hIM5+S0FwyW?=
 =?us-ascii?Q?J0khB6QZsNRIxGkTeFoA/EasdpfvKSsdNYv6Uo58n6v7Cw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Dslm4YhZNrel4DFSiE20eV+Pl83LtHqnp17kZnQI3J2v4AdI03228BAHBo82?=
 =?us-ascii?Q?cNc2AG49tP09BA+FEIGCTpFECqJBCVdFv6WeFG5Zuw6SSw69OhK/qRlgY0Eu?=
 =?us-ascii?Q?z8DMJ2VDFGop15KyH49kMLkMSnJ2qK/cQFawJArXbfKUp9G/lSuUT75vYLVT?=
 =?us-ascii?Q?YYKZVtpBCEJhooK5FNg52UEoaYQqaj0ujkE9jhdH6din5tVw8z7KMOciVvc/?=
 =?us-ascii?Q?NHkUkf2VYGfXZRwOC4gy8QWWsjd76sLZiF0/CpbkgZDR0eK7bhc89y9tw7sc?=
 =?us-ascii?Q?v0IkUSyRaBZ2ZkeZ2uWvgaacr5ecHzVELiThnGKUSSGiijGLHJ5bOkBxfiP2?=
 =?us-ascii?Q?7HyvEF98VQmddHl67kvsBr0n8YZOJv6wbonJ3xF+Tx9TrTsEi470ya1qk/mA?=
 =?us-ascii?Q?WsdpyeV7UQFAC5nr2L2jEExzUMpFSzb/SQAC3xFsG8bh1+0PntXzPgTbVEvU?=
 =?us-ascii?Q?Cxpvm84nrRLHyLiLWlqK7tDl91kFgOKA+/pKbU362Zm0XURxXqZkEnWQ9pl6?=
 =?us-ascii?Q?2KT0AR4kpLozIHg3/9WLDKSE/cV+Y0bNm+EUEsaXV8/PYeMV1skltxwgQxj3?=
 =?us-ascii?Q?MfdvuZ0tAZLwGixjZC/33oKeJ84OW2dZw+n2Kn8gRmC4TXtwYBFLiwgv5gGf?=
 =?us-ascii?Q?Gaa5BiJe2cajqtAYF8pbiKDW2D74vF1WVPgnU+PbniosP/PEZup1hoLW34Jy?=
 =?us-ascii?Q?fM355Vkyeso87IwjKS/MOX6tx9VeSMkr71j7j5T9mwMOA4442QdyBTWivo7C?=
 =?us-ascii?Q?iC8UXIYl+URkUTposAzSIthL8QGkkOkJeXEPZasyr1B8R/MSupyv46LADkq4?=
 =?us-ascii?Q?BrMJ6Cr1F4IWqiqCMrET8+sNyPyy9neQ18v1FCG4/ButkzfyNkwTesYZQp0i?=
 =?us-ascii?Q?+wyQdP7hWagjcApRt2vWzqCoZACyW7PVtw9QGTYhCwEdDLIwdDf44vvG7tMb?=
 =?us-ascii?Q?u1cxPDS2uLerSN0hQtIjeLEPIhUai4OeC/q18GVMATEWBaXBzBzZRJxU+miW?=
 =?us-ascii?Q?K5N8J6luD0ciKSSczVKkODHFB9bcrfJ4q6VYvLD+xNIXbok8dOEF1MYvQZNI?=
 =?us-ascii?Q?iYdeapnSdMHjP6WAYBxXwNiwfr6Nmd+1wFxeybTi2GJSh2dA47gCSk3Achm6?=
 =?us-ascii?Q?yL4/yIdF6qDHH5XkIPXHVw179UkLW6+SgJR0786kFAOi86xmAen3RxVG7IIW?=
 =?us-ascii?Q?pc4ALE4G1GLmGl61a4cZzY7xvILBsdsQrKdiltoNF97pGnMWZUneYEuGwaTX?=
 =?us-ascii?Q?fOgXCYpG9X/nqdeKaOpaJbxS8JJPFaVpzZXJkqeH6INnb6Pa7Clj/+xuDG8Y?=
 =?us-ascii?Q?oKIDZ0QhIjlv/2jePuz+NLqj0JRiNJ0VmJlgMVo583WibpN4QTarVmNQkGba?=
 =?us-ascii?Q?9Hd78qN13dJ0rsa+URK3QeqF1p3TbH4lnYF3eY+FOmuJusOJnDIxJBzKGi17?=
 =?us-ascii?Q?ZN5gSln5nKmJ5WwmUQ17GOfHDBjDKHFRiyOb7KTYF8GxnuA9decyG/+gmEE9?=
 =?us-ascii?Q?VjgU3PiUObCBnV7PNeu8MDm06m3rfhVpn+Y1/WyRiSFKA8RM6vRw+rkpmYp0?=
 =?us-ascii?Q?oGbncBbGmHjuvxVLP9Q914F1yI4XHqIieQJbod4u6h5WevKxxrkeV5o1PNbQ?=
 =?us-ascii?Q?Yg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e90208dc-ee1b-4136-9894-08dd1ab681f7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 14:08:52.4834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ztXk8CVZWZXVSi/ml1OSEzPltgKH/9lBYXrUfy+TQZIT+eCmpUVHBVH5Qaii+Vc8TXTANmINA+an0Di2kA4quByO/gIBltIW0IE3e9QY3Ew=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6485
X-OriginatorOrg: intel.com

On Wed, Dec 11, 2024 at 09:45:32PM +0800, Song Yoong Siang wrote:
> Improve XDP_SETUP_PROG process by avoiding unnecessary link down event.
> 
> This patch is tested by using ip link set xdpdrv command to attach a simple
> XDP program which always return XDP_PASS.
> 
> Before this patch, attaching xdp program will cause ptp4l to lost sync for
> few seconds, as shown in ptp4l log below:
>   ptp4l[198.082]: rms    4 max    8 freq   +906 +/-   2 delay    12 +/-   0
>   ptp4l[199.082]: rms    3 max    4 freq   +906 +/-   3 delay    12 +/-   0
>   ptp4l[199.536]: port 1 (enp2s0): link down
>   ptp4l[199.536]: port 1 (enp2s0): SLAVE to FAULTY on FAULT_DETECTED (FT_UNSPECIFIED)
>   ptp4l[199.600]: selected local clock 22abbc.fffe.bb1234 as best master
>   ptp4l[199.600]: port 1 (enp2s0): assuming the grand master role
>   ptp4l[199.600]: port 1 (enp2s0): master state recommended in slave only mode
>   ptp4l[199.600]: port 1 (enp2s0): defaultDS.priority1 probably misconfigured
>   ptp4l[202.266]: port 1 (enp2s0): link up
>   ptp4l[202.300]: port 1 (enp2s0): FAULTY to LISTENING on INIT_COMPLETE
>   ptp4l[205.558]: port 1 (enp2s0): new foreign master 44abbc.fffe.bb2144-1
>   ptp4l[207.558]: selected best master clock 44abbc.fffe.bb2144
>   ptp4l[207.559]: port 1 (enp2s0): LISTENING to UNCALIBRATED on RS_SLAVE
>   ptp4l[208.308]: port 1 (enp2s0): UNCALIBRATED to SLAVE on MASTER_CLOCK_SELECTED
>   ptp4l[208.933]: rms  742 max 1303 freq   -195 +/- 682 delay    12 +/-   0
>   ptp4l[209.933]: rms  178 max  274 freq   +387 +/- 243 delay    12 +/-   0
> 
> After this patch, attaching xdp program no longer cause ptp4l to lost sync,
> as shown on ptp4l log below:
>   ptp4l[201.183]: rms    1 max    3 freq   +959 +/-   1 delay     8 +/-   0
>   ptp4l[202.183]: rms    1 max    3 freq   +961 +/-   2 delay     8 +/-   0
>   ptp4l[203.183]: rms    2 max    3 freq   +958 +/-   2 delay     8 +/-   0
>   ptp4l[204.183]: rms    3 max    5 freq   +961 +/-   3 delay     8 +/-   0
>   ptp4l[205.183]: rms    2 max    4 freq   +964 +/-   3 delay     8 +/-   0
> 
> Besides, before this patch, attaching xdp program will cause flood ping to
> loss 10 packets, as shown in ping statistics below:
>   --- 169.254.1.2 ping statistics ---
>   100000 packets transmitted, 99990 received, +6 errors, 0.01% packet loss, time 34001ms
>   rtt min/avg/max/mdev = 0.028/0.301/3104.360/13.838 ms, pipe 10, ipg/ewma 0.340/0.243 ms
> 
> After this patch, attaching xdp program no longer cause flood ping to loss
> any packets, as shown in ping statistics below:
>   --- 169.254.1.2 ping statistics ---
>   100000 packets transmitted, 100000 received, 0% packet loss, time 32326ms
>   rtt min/avg/max/mdev = 0.027/0.231/19.589/0.155 ms, pipe 2, ipg/ewma 0.323/0.322 ms
> 
> On the other hand, this patch is also tested with tools/testing/selftests/
> bpf/xdp_hw_metadata app to make sure XDP zero-copy is working fine with
> XDP Tx and Rx metadata. Below is the result of last packet after received
> 10000 UDP packets with interval 1 ms:
>   poll: 1 (0) skip=0 fail=0 redir=10000
>   xsk_ring_cons__peek: 1
>   0x55881c7ef7a8: rx_desc[9999]->addr=8f110 addr=8f110 comp_addr=8f110 EoP
>   rx_hash: 0xFB9BB6A3 with RSS type:0x1
>   HW RX-time:   1733923136269470866 (sec:1733923136.2695) delta to User RX-time sec:0.0000 (43.280 usec)
>   XDP RX-time:   1733923136269482482 (sec:1733923136.2695) delta to User RX-time sec:0.0000 (31.664 usec)
>   No rx_vlan_tci or rx_vlan_proto, err=-95
>   0x55881c7ef7a8: ping-pong with csum=ab19 (want 315b) csum_start=34 csum_offset=6
>   0x55881c7ef7a8: complete tx idx=9999 addr=f010
>   HW TX-complete-time:   1733923136269591637 (sec:1733923136.2696) delta to User TX-complete-time sec:0.0001 (108.571 usec)
>   XDP RX-time:   1733923136269482482 (sec:1733923136.2695) delta to User TX-complete-time sec:0.0002 (217.726 usec)
>   HW RX-time:   1733923136269470866 (sec:1733923136.2695) delta to HW TX-complete-time sec:0.0001 (120.771 usec)
>   0x55881c7ef7a8: complete rx idx=10127 addr=8f110
> 
> Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
> ---
> V2 changelog:
>  - show some examples of problem in commit msg. (Vinicius)
>  - igc_close()/igc_open() are too big a hammer for installing a new XDP
>    program. Only do we we really need. (Vinicius)
> ---
>  drivers/net/ethernet/intel/igc/igc_xdp.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_xdp.c b/drivers/net/ethernet/intel/igc/igc_xdp.c
> index 869815f48ac1..64b04aad614c 100644
> --- a/drivers/net/ethernet/intel/igc/igc_xdp.c
> +++ b/drivers/net/ethernet/intel/igc/igc_xdp.c
> @@ -14,6 +14,7 @@ int igc_xdp_set_prog(struct igc_adapter *adapter, struct bpf_prog *prog,
>  	bool if_running = netif_running(dev);
>  	struct bpf_prog *old_prog;
>  	bool need_update;
> +	int i;
>  
>  	if (dev->mtu > ETH_DATA_LEN) {
>  		/* For now, the driver doesn't support XDP functionality with
> @@ -24,8 +25,13 @@ int igc_xdp_set_prog(struct igc_adapter *adapter, struct bpf_prog *prog,
>  	}
>  
>  	need_update = !!adapter->xdp_prog != !!prog;
> -	if (if_running && need_update)
> -		igc_close(dev);
> +	if (if_running && need_update) {
> +		for (i = 0; i < adapter->num_rx_queues; i++) {
> +			igc_disable_rx_ring(adapter->rx_ring[i]);
> +			igc_disable_tx_ring(adapter->tx_ring[i]);
> +			napi_disable(&adapter->rx_ring[i]->q_vector->napi);
> +		}
> +	}
>  
>  	old_prog = xchg(&adapter->xdp_prog, prog);
>  	if (old_prog)
> @@ -36,8 +42,13 @@ int igc_xdp_set_prog(struct igc_adapter *adapter, struct bpf_prog *prog,
>  	else
>  		xdp_features_clear_redirect_target(dev);
>  
> -	if (if_running && need_update)
> -		igc_open(dev);
> +	if (if_running && need_update) {
> +		for (i = 0; i < adapter->num_rx_queues; i++) {
> +			napi_enable(&adapter->rx_ring[i]->q_vector->napi);
> +			igc_enable_tx_ring(adapter->tx_ring[i]);
> +			igc_enable_rx_ring(adapter->rx_ring[i]);

I agree we could do better than igc_close/igc_open pair, but have you
tried igc_down/igc_open instead?

> +		}
> +	}
>  
>  	return 0;
>  }
> -- 
> 2.34.1
> 

