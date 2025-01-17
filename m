Return-Path: <bpf+bounces-49214-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB59A155F3
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 18:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B51B3188CA0D
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 17:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703331A23A5;
	Fri, 17 Jan 2025 17:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YzxN9nQZ"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B8519E99C;
	Fri, 17 Jan 2025 17:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737136086; cv=fail; b=l3fLY3w19ymQFfkl3z1WYTYZLFYF6KxGrhd3uPyBDuOeb7EsomHOnDmlXzVSAQJZ+Uh550cbayquL2RFhTCLTllN3zCSx7v6mBw4RrmrWOYSSdwGdxfevd3mlPf6YRzkttvs2BHdST7uV5zstu+Q3GZ04n9/yPRhuLKXDiHefwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737136086; c=relaxed/simple;
	bh=a2XldxCvaxxqEUFzoK+FMofXyy1fR7uXrFJKJkXodUo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bKiOiPvVcY6LjQA5opJKbfWdjIi3/q+96EUZwiDTfg5MG7cBXO1ShHjrHPJ8dpswBpFBQo2fuZUst4A9XGw2x53NRl6Rzy7/rbcFZmQtpSmNuu+xAW2/iOnBWZSGn5Gieh4frSfr5azw/K33H61bjgysxwYydQhsTjOl3QyK9Dg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YzxN9nQZ; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737136085; x=1768672085;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=a2XldxCvaxxqEUFzoK+FMofXyy1fR7uXrFJKJkXodUo=;
  b=YzxN9nQZDRD2yU39dUHCWQzR9wa9L1SarFuX6hzn5GTZfu3eTc3Z1OdD
   +N4A3h5gq7paYAK4jJTkRUlJPpZpgBgkGW+8sKLeAUkakW6O+WqeMEuhw
   AStb53kRuaqWDVIZP/oA9S3d/zlxrJ73y1BbVXCy8SE18UW3thBAIslqP
   v0L54ieJGixdb6TDk+9egM4m22b5AfEjDzsdtnggPdVQdTYvGCipSGuO2
   FT66nT/9ofzco2mt8E35uaKAUxwXakBbW4Y7FBw3lIBvt6ayB8i51gZ4K
   Unze8jkFOBcVd5Gg2HxW4tHy3lcwYWj/ZmHivrZMChpIMduMsQUn4Eqgh
   Q==;
X-CSE-ConnectionGUID: JeSRWtKHTw6Wx6fzFGOQyQ==
X-CSE-MsgGUID: 26DAVPutTp+Pgy4lJveTRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11318"; a="41248859"
X-IronPort-AV: E=Sophos;i="6.13,212,1732608000"; 
   d="scan'208";a="41248859"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 09:48:04 -0800
X-CSE-ConnectionGUID: dvgVrHzZRQ62tniEWtEqHQ==
X-CSE-MsgGUID: 66NX/tNoRmed/mFoOspm8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="129122735"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jan 2025 09:48:03 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 17 Jan 2025 09:48:02 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 17 Jan 2025 09:48:02 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 17 Jan 2025 09:48:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vEXSbm+XkT5l1NHs+AHfQj4ayLVfg4c9wqV4867ZLyoHnkveEDBx6F0c+2KWV/i3M/fBhYNrGTBgO9DlX34tfHUDkTf7VA9uoGmJeITyokeA0at4Ls34vdOeScCGtVORUg4K4bsqLvGD2EQVkZ7bsFSr48dk95W3F4AUocpn+V4m3E+I/HIrymkzhuiB7TVz0VpCb4w8QyKUlM6P9D96c3eCHWE3Z0wTSUDC32UX7ZFpk+AhSAu4FrGhBeZ6Tw5CXBv9o4VXi72LP1OgGe2NiXiau6z361P3G2ol1xcsImVBg5aGRO7x4KNhLOvsRVrz+ZQxtZvghj1hSL+9ivmsHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zVGMqpHQgwAI/F3qV1U9coqIS+4BUtILwIBlcZw2a1o=;
 b=pfEuP5dnMD/8/gbWVSp1TgUlm0Mi5M58hwgnV66OkIgiLv5/zN7LSC1hKpNKDqLCCF91NPbKbikTCanbTdC4ySECAd19XzgH3gRwoGzCdwJHhsWrgsby/jRH0ia9aYU0uYzG6Cpj0lCLr/M1P5gfbsW3x/5Xc9yPUV89xSAW3zNA1pnj17D/1lI4IHWwbGHueq4Z+Ks5Nonz+kNKTL70m9oC9cc5gTnUW7f4rsHnk2ZEFwdvfChC+UjcOFsf/ti6BuNmHBfZtAq7SiYAoBCzhtMjO2F6QWM99vXjGxiIdJBLf0x/uslHZR0lznJpDr1t95Fp0M9SJN+INGwQ0YWwew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by PH0PR11MB5143.namprd11.prod.outlook.com (2603:10b6:510:3f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.17; Fri, 17 Jan
 2025 17:48:00 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29%6]) with mapi id 15.20.8356.010; Fri, 17 Jan 2025
 17:48:00 +0000
Date: Fri, 17 Jan 2025 18:47:49 +0100
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Suman Ghosh <sumang@marvell.com>
CC: <horms@kernel.org>, <sgoutham@marvell.com>, <gakula@marvell.com>,
	<sbhatta@marvell.com>, <hkelam@marvell.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lcherian@marvell.com>, <jerinj@marvell.com>, <john.fastabend@gmail.com>,
	<bbhushan2@marvell.com>, <hawk@kernel.org>, <andrew+netdev@lunn.ch>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <bpf@vger.kernel.org>
Subject: Re: [net-next PATCH v4 1/6] octeontx2-pf: Don't unmap page pool
 buffer
Message-ID: <Z4qXxaOm1iih4xWl@lzaremba-mobl.ger.corp.intel.com>
References: <20250116191116.3357181-1-sumang@marvell.com>
 <20250116191116.3357181-2-sumang@marvell.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250116191116.3357181-2-sumang@marvell.com>
X-ClientProxiedBy: MI1P293CA0012.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::10) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|PH0PR11MB5143:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cfef689-0c32-440c-4d6a-08dd371f15d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?scRzJfXw1rqO7T7k9FurcqCnpgCvXrjGJPEgYr/yRUnja3bKYa3laSbelUI6?=
 =?us-ascii?Q?KdFwpLPaTukevQoqOzy/i4WojTNrd3AlnxV6eXRhihvTpnbK277t3KRPuSej?=
 =?us-ascii?Q?22VouWKtq6WcoAjBWnW0r9JzP4ZqUh634UXpnIonaGfNrnWgxUI9F3/oQMC/?=
 =?us-ascii?Q?TDx4+UI7fLtNJaG1Xq40FIl3csfdK37DK/yCVaH14Y3IwocFhlT4dkrWD3QX?=
 =?us-ascii?Q?dWmuzj6wGuyoYK4TgOeDxdP4AzBKY4LMlmHq+pl/xbg3oKfR66Mza+TqXhYP?=
 =?us-ascii?Q?oAf9bThLu25eUGww+So4ZbcgJmeV27jSeqzHwuCL7LtzBStx4ynjuibhUcgd?=
 =?us-ascii?Q?9QIe2d76j1HllqjC7E/ViAzzcQ1tBmZ3wlyixAb41H52yJn/j9uNCFXd49LD?=
 =?us-ascii?Q?LT3rdOMqYH2qRsVl4ZUYQmAYkCjPOTUw0XdF93hSzu9FmDQYwXU5qW01kigm?=
 =?us-ascii?Q?ZDDB+mKsC74cV+nGsDjHPZ3ArEX529qXC74vTJT4PIvJGu/zvlw1BLTHetEk?=
 =?us-ascii?Q?s/jPXq4oOc3P0McZRkol6EMhxHLLtu8EJHC/6EHPAfYlqzuUyl2PyoO6OzmG?=
 =?us-ascii?Q?xEtTJGrv4zZ3JDmrgaa0zHg1ABUaSBsBa5h6GUwZpl5B5gAEdJG47eS/Fkm+?=
 =?us-ascii?Q?jzx3/dJPxnlZjlJL0dcVphkFpALakH84ppVrdFJe2GCJQxZ1BfB6NPX5Iqyg?=
 =?us-ascii?Q?G8t/zPcOj8/r3eViMNardATrcHiBcAAlbMllNdQLZh7tZSgCmr2DNZoxtx8V?=
 =?us-ascii?Q?yU//biMtGF5y0IA0hNit1WR3qz8sBR60f174Xbpd6/vKOJVtEd71oAxX5Wgq?=
 =?us-ascii?Q?Hah6RNmkg7QHM1rv6tGADKa+Ddu9k0VqxHwDD+WB/ykCYwZLtDadrQHcBInn?=
 =?us-ascii?Q?KEPQ+KtmIJFCsev5EcUuNWBZ7BfzfMrwV/Bhp6qRNa1E1nqEDIX6NPI84az8?=
 =?us-ascii?Q?nvbKUSrnT9jAwqx62KjkGdEAJCBhb0ruYkPKGV1WMIDEIco1L8XXszCNuggh?=
 =?us-ascii?Q?BTGHE23ZuIp1Tzt4JuOIZ/MFpEYR4Uk0bmFqgnN7iK/CpAhD8oUMRYVgW22O?=
 =?us-ascii?Q?hEM+/6zpKtuxSReSA9qb0lqtttN8nwmj2E7+ymnNAdNXYXAASFLeNKLZEe8H?=
 =?us-ascii?Q?WiA7BpTfvE8JUOmpSQfVqxHib6RywfYEyUO6ZxMDCeM0aSmFb8IepSCITm+7?=
 =?us-ascii?Q?x1TV5LYSzdAEft1eeMWYJCxFdcOx9+ExnDE71nC48YuAJV2zI/qkbsEzKfAR?=
 =?us-ascii?Q?DCDc9wgoplW80bP3pyNTIWt5MgfzxZzxkMj3GcURkrlQqHLKfjrxIFE6rK9N?=
 =?us-ascii?Q?KxHXkr0TsvqMZSVSmtJELeEBWAMncyRUIejYdMmX43Fm1Iji+gu+RsuLnrMW?=
 =?us-ascii?Q?08YJ48JrLsvPMh7Q/AKPNr9vBd45?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9Dfdrn4geK6d2SLD/DHT2IrGIZrpUfnqkwO1PS++wmpp1YuZc2YmYtQQKFkP?=
 =?us-ascii?Q?SMe3nsQ6W9Y/wG5MkGxMJk6yc6ubxnxAZu8Kp/rxQUU9DiYnVgRbX9xZYExO?=
 =?us-ascii?Q?bNaBnyDBGI9ZsUNNLdphliblM4DDAwlIyhUfi7t4/iplm+32m2fOU+RiKQ9c?=
 =?us-ascii?Q?TrmuFKIZahzOprXeKh6SG6tJzP9zGnh1nA6UMJIYV1UGWBlEOaMUtHA/qeDW?=
 =?us-ascii?Q?+wIFRHBxXPEZGSap25JkYshdHA0QJdSvqOH2qKFAewPLqyr6Fg0liN7r926c?=
 =?us-ascii?Q?HF2GoxxJtsR/JI1I/MbCGS4S4Dhd4O0peCS5OsljfsH/MhdTt+f9yUG2c/Os?=
 =?us-ascii?Q?4PoRGacuIyZSCl53Oc1iYC21ReRbbDXU8XL+/Uvq5OSXNr1cRUdjXg4aL1sw?=
 =?us-ascii?Q?WxxM2FjwgSvrLh8PdA/ovAj6XWkhOWLR8cf3EHuRK3iwAtoLt5McSHjnAL4l?=
 =?us-ascii?Q?PLUdIbBl8vFqg3RXtjyeldO9mspsXP3mB4qnev51wNaxiO/bBmAQey4LnQMG?=
 =?us-ascii?Q?eJkTfzRaheMwK1qEt395j167eIXD1yvyh1vH4PBOF9GGxZV2RkGywkTPSUv+?=
 =?us-ascii?Q?4I6Grd2coIwG1tYxxt/0A0DgKntSPaczLiEY25V/S8aOLGQSoIojbLzG+J5V?=
 =?us-ascii?Q?vnVdCXYNEBud01+bOK24hoiwkGdkE27jnztt/0Y70V+k9yQxZm9yXRsGz90I?=
 =?us-ascii?Q?6B+I7NEj2jeLMFxNf4pMqFuU6Yhb8bhOcUumW8n21orF1wzxqLSbBeo5W23m?=
 =?us-ascii?Q?loGFYoNhSQpaulcFD0hLaHHlBQIuqP8TUkkHe81EcbLVO+VQolqWNwkD4WmE?=
 =?us-ascii?Q?AatFYJkpLB0l/LxE+UpnWzOVdgyJOW3XpHiJOyMzPNeptdYetnxNXOBNPzVl?=
 =?us-ascii?Q?qWkPXZPQad+Rf3KbM429oI7DntNeW1VEdgfq/d1yw8qBE4MnqhpeThiFEh8H?=
 =?us-ascii?Q?fqlzn7k4oIDHYaGAhjNgQHfXyimMFQszlUTslbZwUoEsCMBn5dDNXX8K1hhD?=
 =?us-ascii?Q?uI6heqN5Djohib6+GiEBS+Q+cOtsfQrBcd1UqOXTJIi5qsh6DZVA3n6Pc4I8?=
 =?us-ascii?Q?OzNO2x6T0F7NPm4190d8i3TLBqvSUwr2CeIg6I4AaG/QH5i6U/gdXSvB6rGZ?=
 =?us-ascii?Q?O4fr/Z6OdN5cP87H5g9wKYy31tUdK1IXZUpwlXRVrNy/PmiLKLwWMMQRGcbm?=
 =?us-ascii?Q?we1mXk71pzRyQYaIfTW8glscQS0AGOqHqA/xdhk3JFoVkFFZupFJ7+XEMhxU?=
 =?us-ascii?Q?lxhXglgTqAywD1jLAoWFgPA9L+kahGT8YKbjbJsQT5ZIH3SBGAeZOGAifRJh?=
 =?us-ascii?Q?O7coWLAyYH3OOQnClp1mdpHyYxMNTAmaOfjIUoYhrHQgWOXbW5XDBYlwAsJ+?=
 =?us-ascii?Q?5dYEF6W7t42wu3VUBC0/5Xp3Zad+VtDxQRcviGdz7T3URtHPU842fvprJX9P?=
 =?us-ascii?Q?c7eBKisCWXdT+S9KABk1h0OWoDPsovV2mk+uB6NF/ZlxTB5Zdb4I3gI4uq/S?=
 =?us-ascii?Q?vyjEssuIoYU+RtX8KB+qNCxtjTBqPQ40KAVswTX5+tzAxLlsi8FqxZboaig7?=
 =?us-ascii?Q?quDs1rF0RWeKpPKndJTeY/BZ/JUr0oMtywtpP/5srBDGpahj2q1ia8NhfzQY?=
 =?us-ascii?Q?RQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cfef689-0c32-440c-4d6a-08dd371f15d3
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 17:48:00.7223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DNrMZIrcbRLkg97xboFoB3zNRQ0szK9pTA1FhWOmIYeJizfSWjQTqkbB4g4ELFA6VzhNeiLX2VaQmdeuyzF0pAmwBqwJK/nUaITDvud4+YQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5143
X-OriginatorOrg: intel.com

On Fri, Jan 17, 2025 at 12:41:11AM +0530, Suman Ghosh wrote:
> When xdp buffers are from page pool do not dma unmap
> the buffers. DMA map/unmap are handled by the page_pool
> APIs.
>

Overall, the change makes sense. However, it would be better to consider using 
xdp_return_frame when handling the packets XDP_REDIRECTed from another 
interface, you can look up its implementation to see how much more cases it 
handles.

Also, a question below.

> Signed-off-by: Geetha sowjanya <gakula@marvell.com>
> Signed-off-by: Suman Ghosh <sumang@marvell.com>
> ---
>  .../marvell/octeontx2/nic/otx2_common.h       |  4 +-
>  .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |  8 +++-
>  .../marvell/octeontx2/nic/otx2_txrx.c         | 43 +++++++++++++------
>  .../marvell/octeontx2/nic/otx2_txrx.h         |  1 +
>  4 files changed, 41 insertions(+), 15 deletions(-)
> 

[...]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> index 224cef938927..2859f397f99e 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> @@ -101,14 +101,20 @@ static void otx2_xdp_snd_pkt_handler(struct otx2_nic *pfvf,
>  	struct nix_send_comp_s *snd_comp = &cqe->comp;
>  	struct sg_list *sg;
>  	struct page *page;
> -	u64 pa;
> +	u64 pa, iova;
>  
>  	sg = &sq->sg[snd_comp->sqe_id];
>  
> -	pa = otx2_iova_to_phys(pfvf->iommu_domain, sg->dma_addr[0]);
> -	otx2_dma_unmap_page(pfvf, sg->dma_addr[0],
> -			    sg->size[0], DMA_TO_DEVICE);
> +	iova = sg->dma_addr[0] - OTX2_HEAD_ROOM;
> +	pa = otx2_iova_to_phys(pfvf->iommu_domain, iova);

Why change the address calculation? I would like the answer to be in the commit 
message.

>  	page = virt_to_page(phys_to_virt(pa));
> +	if (sg->flags & XDP_REDIRECT)
> +		otx2_dma_unmap_page(pfvf, sg->dma_addr[0], sg->size[0], DMA_TO_DEVICE);
> +
> +	if (page->pp) {
> +		page_pool_recycle_direct(page->pp, page);
> +		return;
> +	}
>  	put_page(page);
>  }
>  
> @@ -1360,7 +1366,7 @@ void otx2_free_pending_sqe(struct otx2_nic *pfvf)
>  }
>  
>  static void otx2_xdp_sqe_add_sg(struct otx2_snd_queue *sq, u64 dma_addr,
> -				int len, int *offset)
> +				int len, int *offset, u16 flags)
>  {
>  	struct nix_sqe_sg_s *sg = NULL;
>  	u64 *iova = NULL;

[...]

