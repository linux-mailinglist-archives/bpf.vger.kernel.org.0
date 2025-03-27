Return-Path: <bpf+bounces-54811-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B54A732D3
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 14:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B0E61894357
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 12:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D98214A8C;
	Thu, 27 Mar 2025 12:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ix9NXFWi"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B472139BC;
	Thu, 27 Mar 2025 12:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743080339; cv=fail; b=rbCYeho9DYoHguuM9vVWqxBsaxeHx9QrtDayl15q6ztKk8c65ex96G+9kYQYFYaQnIAgR8yofOmOOkohCz6spaIP2CucT5E5aNOw260rcHY+7Mm/D71YzDsF/0L8jcqX5k+/NYI3NF5q6vf1KI0EEiNwP1X0VLbQyx7XO12zLcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743080339; c=relaxed/simple;
	bh=85v/+NAjA6s2Z3MDSfgx/DCc9tcqdAA8+1xlucbi/uE=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AS6AyQ8sWHpfr0uFOzFx8F7x75y2q90dIedkhgL5RvLOBnzWqzMlkgopGxq/lqTwQC4MfLhA9bugkQKeaat7eMEayj0ZvpRRYQFOux+M5vWRkH71qx0w2hsvEaDm532IpgU82X2ziqyU19E91oF47y6ysfqGynxxwr4kmJpQAVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ix9NXFWi; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743080338; x=1774616338;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=85v/+NAjA6s2Z3MDSfgx/DCc9tcqdAA8+1xlucbi/uE=;
  b=ix9NXFWiukL2K0qMTVFgnbopYdHu/SZK6Tu7K4KdkwnG2kgD48ViCARP
   CxuUQyhADCLWK/XFpLnptJjed9T7FHOFRXpCoPR8GCJX4vx4yeZDkYjwg
   X0GwwrvMHI7S9nS1fwqwC3GkdGVELYZakSaIqLdnZBkC3xXty3uAjV0yj
   1/odAT7Jv7MX90On1Q+8eIlPiKnDfwH+iHOZ2VdzWU/4zVv+OYOQMT95p
   fmkGSThiRzcaussMrfG61eQuenWoaZ0hINSGA0Z7ddaTPp2BVyDBSG8k1
   TyvZe+z2uQxs5cwlz9XsBGmgr3FjPBtAIrNWP8/YesJpsJrVmT4pKEkZG
   g==;
X-CSE-ConnectionGUID: fcOWapv1Rda1siTmMpF7fg==
X-CSE-MsgGUID: WRJLx9ypSRu6GoG1TeQD2g==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="48193159"
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; 
   d="scan'208";a="48193159"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 05:58:57 -0700
X-CSE-ConnectionGUID: de661iPHT1qRIClALInd+g==
X-CSE-MsgGUID: oIj7PXe+R3+K/zpIw4Kkvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; 
   d="scan'208";a="125053909"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 05:58:56 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 27 Mar 2025 05:58:56 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 27 Mar 2025 05:58:56 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 27 Mar 2025 05:58:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P+xNdojObJrXcgtvqj7d5o4D4b8u6lDTbIEHP3anG9o2qb6diN0omFBBTB6bU+c7H4TIGI/w1YFGF26uQEv3x0ZHm9bPXzUL3zzc8p+sB1kQhgP/Ls0CCTqHqcspZyy/XHXAODcA/G+APxxG6bg6nWU/GRCz6Ej3JVk8lmuTJuCowoCuACMQPjXCNl0uxjiztSAlENq/n3BqVCoyZzXo8/PLCwCmwBaM8zeGzx5rCehOicmuOwQyyfV3x+/QyQnrWdzxnJ0QjCpGpQYPBi7cYMQwUnPp6yLcqcKKObVhczwFefDXZKz7duRMrDczWCaoVIdyvTm0P+QcK3Djn6GMQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cI5ZwtjnaYBM7h6LFgyTQETLrxVI5Tw9YB91UzZzu6Q=;
 b=ZwJAHIZ2rHvrhQAUjL04oIcV2h6J4C0Dv6XnOSSpKsss5lLIC1fjQf/1llnHdFPa68EnApEGWfESXbkhcPgBEDGpNuiFJOC9FBKQaV/NhaGv2uADTakTjNg/2XbKB27nDMdyw9udA+baD0LsnSdSx7jqjZS4PZfSzwfqHAFF9VcQGnWe3MqA61wD16xYl2jWnONnxCzGX+yaYbzYyGOHB8GyFkpXPlGA23fHjnBl93OxVBn4qV6e7s3dZrnvR8W7pkfk3mv6pDsAo1bjK+9xmhsRxQvAogXF+OMkhG4qaxp0SjSUCU/S86UNuD1pd7/4LEETRmxdWfGebkjOiOTXXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6307.namprd11.prod.outlook.com (2603:10b6:930:21::20)
 by DS0PR11MB8719.namprd11.prod.outlook.com (2603:10b6:8:1a8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 12:58:52 +0000
Received: from CY5PR11MB6307.namprd11.prod.outlook.com
 ([fe80::1fa2:d2f9:5904:2a14]) by CY5PR11MB6307.namprd11.prod.outlook.com
 ([fe80::1fa2:d2f9:5904:2a14%6]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 12:58:52 +0000
Message-ID: <d82ee882-99f6-403c-8231-8a577fd0c571@intel.com>
Date: Thu, 27 Mar 2025 14:58:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v10 07/14] igc: optimize TX
 packet buffer utilization for TSN mode
To: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Simon Horman <horms@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	Russell King <linux@armlinux.org.uk>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer
	<hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Furong Xu
	<0x1207@gmail.com>, Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Russell King <rmk+kernel@armlinux.org.uk>, Hariprasad Kelam
	<hkelam@marvell.com>, Xiaolei Wang <xiaolei.wang@windriver.com>, "Suraj
 Jaiswal" <quic_jsuraj@quicinc.com>, Kory Maincent
	<kory.maincent@bootlin.com>, Gal Pressman <gal@nvidia.com>, Jesper Nilsson
	<jesper.nilsson@axis.com>, <linux-arm-kernel@lists.infradead.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>,
	<linux-stm32@st-md-mailman.stormreply.com>, Chwee-Lin Choong
	<chwee.lin.choong@intel.com>, Vinicius Costa Gomes
	<vinicius.gomes@intel.com>, Kunihiko Hayashi
	<hayashi.kunihiko@socionext.com>, Serge Semin <fancer.lancer@gmail.com>
References: <20250318030742.2567080-1-faizal.abdul.rahim@linux.intel.com>
 <20250318030742.2567080-8-faizal.abdul.rahim@linux.intel.com>
Content-Language: en-US
From: Mor Bar-Gabay <morx.bar.gabay@intel.com>
In-Reply-To: <20250318030742.2567080-8-faizal.abdul.rahim@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::16) To CY5PR11MB6307.namprd11.prod.outlook.com
 (2603:10b6:930:21::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6307:EE_|DS0PR11MB8719:EE_
X-MS-Office365-Filtering-Correlation-Id: 85be808f-b2fb-4e22-f69f-08dd6d2f2008
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?amM5bWJIM2tlc1dsWWlnb3Rpc3U0Uy8wR3Y2dGhBTWdTNnowbnphNVRlS0Yx?=
 =?utf-8?B?MVZLLzJCSDNLT3pNWHhSWkEyNEdIUDRiZFdHZmpFQlJnd2ZkS2laNThEQ2o3?=
 =?utf-8?B?bzZDOG9nc1pRMzdsZFJ6ZEhVNEZrWFFwaXBaWTZPcDNmZ1UwRUZpZW5rTzdN?=
 =?utf-8?B?MUpVM09uNEpVbGZrcnVIZTROSGZ3SUh3WXQ4Z2o1clArZzExbVpsOUZqZjAx?=
 =?utf-8?B?U2hvam9HOFRXZDVvUE11VXF4bmd1Y084WFlIT2R5SXdCcmdnaTlPQVh2TDNM?=
 =?utf-8?B?alNmc2E4VkZISHVWNzgwZFVNUEJhSlRLL3ozYUdYUUhSU21HcldnSGhReStC?=
 =?utf-8?B?M1BWYUhPWGVUUk8xdFNRZWhCUVNhd1pNNTJLUFpYdXFiclM4YTRvdGtvMDE4?=
 =?utf-8?B?VmI2MDUrUUsyUHhES1B5TFloeUdXeGZKTEhJT1ZsdkJGMVAzaWFMK0tRWWFC?=
 =?utf-8?B?czMwaDc1V1RRV2t5MmpaaHArbVBzMDIzS2VFNy9JRUpKc0FuUStKQ1dselFz?=
 =?utf-8?B?UmEwb3NzR2V6akc0WlZWV1gyZjBqUjZIM0FqMHpuVGIzWkxGV0pIZjd2b1Av?=
 =?utf-8?B?ZU1URzV1SlJSUmkrOHFLY01RZGMraVlXRUdaUUZVNE9FVWgrN0dvRnBZZGNP?=
 =?utf-8?B?aDRGQ3hYdnd0VHZxc0xnTGQwWDloS1BGUjhVNjI0N2R5bDNzcFFsN2Y5NHVL?=
 =?utf-8?B?RklXc0dYUW11aW1kR3ZDaW5ScG8yNCttSnEvWVdxaUZIb29OaEV2dGR5UHhL?=
 =?utf-8?B?TTEzeGNKVm1tYjRBWkpUN3dhS1hINGhuS0QrYlAxWlV6ZzRCOERScWpRSnRt?=
 =?utf-8?B?MEZoWE1JSW9CYmFsZXNFaXVYTTdvRFVnYUUyNjJhVjF3SXFJalpqeVNRcnlt?=
 =?utf-8?B?c1BtTVdXdjlmc1ZpTjBmakdhbTcxMHZQVURZaytLd0ZVS0VKbHRjalBDZ3dm?=
 =?utf-8?B?NXJTSkFKbjlDTjF0eUQ4ZXlFZ0R3K3h0dzZUVDBicVUzNkIrbXMyRmk3Y0ZD?=
 =?utf-8?B?bzIwVHU5ZmNyVlFBMWRxbkZwZFR5WVNyb0tHN0Z0OVlDUWdkRkhtV0kyczJk?=
 =?utf-8?B?ekErUlZyYTNzUExpWkRkMGI3VUoyU3h6YTQrWHcxSit6Z00zSmt3dFQrdEox?=
 =?utf-8?B?OWJGcmJLTUo4UXVoNnhBcE9yZHI2dHJaY3RKR3ZjOUZ4eXVqbko1VzFUM0w2?=
 =?utf-8?B?TEJQSk1BWW1oT2RzRk95cXVFV2JzODhSSjQwbUlFSzVzUDJzUEFWNWkwekZw?=
 =?utf-8?B?N0ltTHpZMzgzR09EZHJhSWN5TWFkUUNsTXo1bHkwNWRNb095Z1pIVEhDbUp2?=
 =?utf-8?B?MDluWkZObjI3cVRETlV3MGxndzV5U3p1RHlLd2lIYS9PV2pMV0ZnQmg2VXBM?=
 =?utf-8?B?Qmlra3luSnRHbkVhN0dyRnRTNDRNTjNhZ0M0VTJOTzk1RHBNQVBrN0ExK3ZO?=
 =?utf-8?B?MGJ2QTR5Q2I3dFJKZ3hLbWpYS2QrenNkOS9MRjBVdjR6TExyV2gyODAySkZy?=
 =?utf-8?B?S3V4V2dwZUg2WWxYdUFpNHRTWDdGU2VSTEVJZHJTNytHYW1BUVIvT0loS1pv?=
 =?utf-8?B?TEdOZUdOT0l3TlZnZU11VVVjUWc3bEROS3EzTlpFTU9DRG1GQ2xnL1RxUEZK?=
 =?utf-8?B?TG44V2tsdDFGS09CZ3AzSkNPa21xSnRKMFJ0RkRyVElTL3FmWElJdnJ6bjh4?=
 =?utf-8?B?QWVYSFJHczg0am15enBnMmMvQ2JIMEFjcTRKaCszendpaWkzbUR4M3kzbStR?=
 =?utf-8?B?ZTFGaXIzMmluOEFLSlgrSzFyaXNoaWFQRU9HY01mL3ZXdDZnKzdHdXFFRFV0?=
 =?utf-8?B?eURQYkhCdU5qSlV5SUJ1bWpDK1hKdHMwNmFpWnM1NkRRNDM1amFIUTBVeDFE?=
 =?utf-8?B?OFRNdXY5cnRiL0praTI2L3NWaE81Q2FtR1Q5Umx4TGpXcE1wUlpQbVMxcmV1?=
 =?utf-8?Q?xoMD9AQVoG0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6307.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkJNVFVkajdFdUFlMTNiU3pLMnVvcUQrZGJlc1FKR0srMjBSdmRZSFF4Znk4?=
 =?utf-8?B?QXl0WE8rWVNURFlaMS9wVGVkQzBFTXgrSDBIUzBCbzBsV2FWdStLVnEzeCtT?=
 =?utf-8?B?N2tKcExmYTd5NUZNTEt5b0h4TTZsZklRRFhQSmcxMHVya2NWNWZOdmtoVEF1?=
 =?utf-8?B?bnBjNDBjVmg0ZFNpM2FwRlVSUEg5RDBGRVBmN0s2azJUY0F2MzU2ck9zQ3RK?=
 =?utf-8?B?L0FnTjFuUEpocDRGb2hCMVNxckU3T0tsS0ZaQ2RscDZ2THRTTjM5V0xqKzRk?=
 =?utf-8?B?YVM0TVZMaWoxU2xVNEhJaTNJVFFiYURVVWJGZTRYWlpJTjdaaEJiaVdsNXRk?=
 =?utf-8?B?OFZPUHlFTTdGdTFMUCtjeHhpajducDdRbVJkemhSWjFySUlSemFZUzgySFZF?=
 =?utf-8?B?UVRoUDVjTGh1SnBoTnJzMVNUNWZqaDgvR3FkUWhOa0JtZzhHRjU0T2JRSFNP?=
 =?utf-8?B?VEY4UUZOeTJVSUpyYVlERTFGb2JaQ2NSVFJONXM1c0F6d2JOeDVSNU9zY2Z1?=
 =?utf-8?B?Y1RJaTVVZk1YVExXZ0kzKzlHOFdONGY3RytqTDZ1RlNMUjZ4WFZYNnBYNm1n?=
 =?utf-8?B?azVzMGNVV2FaZlUxblNPUmVickJ3TGZ2cG0rU3paWExEQ3grK0ZBdFh6UXp0?=
 =?utf-8?B?d3B2R1RIZUdDTVVva3FmNjIwQXFjcEk4Uy9OVTJWVFdVZTlwQ1VxL0tBZ2pp?=
 =?utf-8?B?VHZIbU1Bblc2MXlDT1lvSnAydkdwTVA5R3lkbDlteXhsQnRuNnhBL05kYllJ?=
 =?utf-8?B?MUtWc2dhMjdhT3c0Y0hsY1p1bWlPbzJGMEFYbkhYbUJnTnFrR1lCdngraGx0?=
 =?utf-8?B?UElHRE5Oc0Qvdkd6M1hUd28xUWwrRlMrWUJENUp1S2VVeXEzZmsyR1EwNUl3?=
 =?utf-8?B?L1NMaG4reWFoMFcxcWRzNTQ0WGFNc2Mvb0VWelAva1pSKy9TdTcyVDVUZkox?=
 =?utf-8?B?aCtYTVdGai9CTE10L0dmbEd5aHMyY29SZ1JTTDRNMFBWL3U1eWlMNHpZUVI0?=
 =?utf-8?B?eDNIMjhMcnY2eUVlV3F5cU04RjdvMUxQaWpXbkpPMGJNbVc3U3FjOFJrNi94?=
 =?utf-8?B?QmduM0xmRjUrUjJjdU1GNVEyK05oYWxTR2tDcFhQanVLQ1F1TjJHeWZkanhP?=
 =?utf-8?B?K2h2d1ZGWUVxa0drMnNvUE1yemljYUFtRHd3NThCTmFQM25ydXhiTWx1eXBD?=
 =?utf-8?B?ZDRxZ3BZQzE3OGNDZ0N6NE1wR0ZCa2hlWG52azdYS1A2VWk2aGp3SlNWdFhR?=
 =?utf-8?B?azdLK0F4R1ladW1obVJjUDhYUi9OSXdTK25YaUJqamRvajFRVHBvN3dCOHR1?=
 =?utf-8?B?Z3k2ekZuS0R3SFczM1VyNWN1a0c4TGVHdDhDSVhLSjJWU1QrR3JwRWY4SjRU?=
 =?utf-8?B?WTB0QTMzY1BoVW90YVdTNGJXSk9ZcXBqQUVlTnppVCtHb3BlalM1VzNIaWVv?=
 =?utf-8?B?a1NaUGZRQmZqOG8zamdZRkhCMGxnR2ZHd0M4MElMY2dIWE5ScjNZZVQybmRB?=
 =?utf-8?B?UmhsNlh3LzVLSS84QzZWRVlhRVZ6WTVsQzVjOWQvbjMyb3A4SlV6NGs4VitL?=
 =?utf-8?B?UGxRTVlzUGRBVnNYSkxTTS8ycE9JVkIxYW5NMGU5SjYvZ2hYbUdRWkt4Vlo3?=
 =?utf-8?B?RTVTQ2hUK2UxMnVIemR5dTRibXZ5RXhORnZvUVVIcGVnTWNBZFpBNjZaWG0v?=
 =?utf-8?B?eGlZZjJoSWN1U3BVWjBzczVzais4ZmxmdjJmWDJ5NnZrTitZZHRWZHJ5c2h4?=
 =?utf-8?B?OEJPSHBHblNJM3dHK3FBaFE0MWZxTEdEZnhGNHZXeXNNUDd2Z3cwUlhwRlJD?=
 =?utf-8?B?bW5EaDQ4M2gwTmFXeDN0MXoraFJyR0l3d2o5QkFJa2JkT2tzQ1REbUpCaEMz?=
 =?utf-8?B?emhrSUtMQ3dGQVFXVmNFLyt6TXNtQ0RNaDNJZTFsNnQvNTBsVVZBT2xZMUhy?=
 =?utf-8?B?dVFacXljVlRPV2d2VmZHSWJ1NGRPLzdwNXRKMGRYWU1GRHZDVHlsTmdwbSs4?=
 =?utf-8?B?NTNjYStsQ0VMOXFBdXFzQmhXUUVFcFo0K1hmZUhXOVFRWnNHa1A2R3dZZzdO?=
 =?utf-8?B?NXE0cmdESVM0TEUvaDhCSnJ3SngyM1A0WXRwdWM4cEd3dG1qajA1Mml0RTJV?=
 =?utf-8?B?b2c4R3lIZWt6SXJ1aE1WdHlpMmlsdnlQSm9VODdCSHNYK3JiVmVlS25vSHRm?=
 =?utf-8?B?Mnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 85be808f-b2fb-4e22-f69f-08dd6d2f2008
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6307.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 12:58:52.7441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AoIYxENHfcT+lEj+RFxXYyboUO7HXoZ9VO/ijWFeOriH0a+B9f18eiP/JE4ApPcS4ASSGg3436s244BcXtQESY5a9yeMMozl1g4ealOPoHM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8719
X-OriginatorOrg: intel.com

On 18/03/2025 5:07, Faizal Rahim wrote:
> In preparation for upcoming frame preemption patches, optimize the TX
> packet buffer size. The total packet buffer size (RX + TX) is 64KB, with
> a maximum of 34KB for either RX or TX. Split the buffer evenly,
> allocating 32KB to each.
> 
> For TX, assign 7KB to each of the four TX packet buffers (total 28KB)
> and reserve 4KB for BMC.
> 
> References:
> I225/I226 SW User Manual Section 4.7.9, Section 8.3.2
> 
> Co-developed-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_defines.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
Tested-by: Mor Bar-Gabay <morx.bar.gabay@intel.com>

