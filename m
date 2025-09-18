Return-Path: <bpf+bounces-68748-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D73B8399B
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 10:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 433725866CB
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 08:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10CD2FE588;
	Thu, 18 Sep 2025 08:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BiQ9DS9j"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA96E2F2918;
	Thu, 18 Sep 2025 08:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758185550; cv=fail; b=ptD/NicGoeyR91odCcMSmOcTtFeToW1bkqYM6jFOZibeYn2O7gKkpAo+xrQzozJT3cXynS1BwrAzP5ULVsjzw/A920M4ZvsIWbVFaMiH/fGLUnwCVuJYuryM3vwKo3HLZtZHZKeDY4p/9dWqto/+Rrf0UG7GQndojQDF3XL00vQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758185550; c=relaxed/simple;
	bh=RUng57FEIfxez8tkSlsgUNizIRNwwkdrmvoamV5M1wY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XLBZ9Y0M17Pp290DBBdGGAm0WXUvc2zkwvdb/m1G7WAIrOHjnDUwLL0jEuR7DZ3cZyayUlToq7j6Z06ADPMYmQH0pEE0RCiy/9lpJS62u1K2bPSFxb0dxuVd2xAsDbW1XWQS2QFZtPnzhtP8vBgAgbFZOWF6tb6CZyU9E7OymxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BiQ9DS9j; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758185548; x=1789721548;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=RUng57FEIfxez8tkSlsgUNizIRNwwkdrmvoamV5M1wY=;
  b=BiQ9DS9j8t2Ec6dO4bwAIbXE7tcCw9KK5WCNEQ3hDC2Nn84Q08u++3P0
   JfehaBvuduADSAW1K7RKBg6KddYwgU8CrvhQKaEIwTdnklgpJ67xAAWQO
   yjZ+8OUqg4+UuZUB1Snl0MKMO/FfyVhhUMmacx760jil4FffXxSAP5DYx
   sLai+Ahgplz8JJrokj4hbX0r7atTCYgcrc5W+WvUipdYFcSv7+myL3VKD
   dapoU8NY+jQ7LYXMUb1dZ6QW1J9+u97JX8J5Bg6f6b1hH6q/5q6rkBKdC
   Mru08WrEo32IsCuLJO65g6b/UtZetlXfArtbqSkoEiMZWmVaLGqsiSde1
   Q==;
X-CSE-ConnectionGUID: sNoerLNATpOdTKhxcsJVZA==
X-CSE-MsgGUID: b+Nqci5ASxmzTGoaee9hGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11556"; a="71933995"
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; 
   d="scan'208";a="71933995"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 01:52:28 -0700
X-CSE-ConnectionGUID: QncvlS4FTuW8q1jJbbdLkQ==
X-CSE-MsgGUID: HjjiLtNzQCGqB9Y/RqK5GA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; 
   d="scan'208";a="174763292"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 01:52:28 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 18 Sep 2025 01:52:26 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 18 Sep 2025 01:52:26 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.40) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 18 Sep 2025 01:52:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W2tDnrVYiW39d1sba6539UvoSJ0QILvaX6vNV/4vyfzHOOfYrW6MnR3HokVUglEXTBT2Apvw4NV1Xm2Co1lHDPDZTX/EG0YGf3rOo49gW/YR8h1pO9GPP7aJ4O7i4xHmofbXOaq9AYp8E3wUXSEivEElz3oRPSc3BizAh9BWvyZZfK6ZQ/AfpOdeN+9Wv53XkKCyapdQ/nUU/xc0z+qvHUdA9RVl+E0fQUAQJkupzItw+gFCQJkQNhRuG9AS/MuHCfNqddkaH/ovuwckgSN0Kx5ruFmFETOrAMB3GGYA67O9N/cryWEghe1RDwLdW23+ONtg1rV7OgDobr/Gtsivmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2YGoz5bJP//vRhbLKCorCL9cm/zCPKy1dX3tYsDS3FY=;
 b=WrwOixzlPUZDNq1iNOF1jFgLkCNBSx0pFakUpJS9ecxoUmf059COPHhZ4F+3FGAvfpi9RLF+YEHixt3PBxPlYmw7k3U0Nz3Ylqo4kSvbAyPl3vrhJoCkHnkZympYdQ2SYj6tN5gM/3O7rLOOIRkQISHrbZfOMQSjyqjom5PYq9R3RiTzxawaqEjVd6rsnJm/aNZBpeL7tOPOzolipH0zKsJBfv5jGIPTKm6HFZCh5o7iPfNzL0mRaNadkjOTmnzVk2buVAi1xk2Ewkw6FQwDiNS7LgbjUUvQl0Nt6A7QWB77P2E6/T+AxytJEzT1b8p6Zq7OLNSrgzh1qAeDeFfJVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 PH0PR11MB5077.namprd11.prod.outlook.com (2603:10b6:510:3b::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.14; Thu, 18 Sep 2025 08:52:23 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 08:52:23 +0000
Date: Thu, 18 Sep 2025 10:52:08 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Amery Hung <ameryhung@gmail.com>
CC: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
	<alexei.starovoitov@gmail.com>, <andrii@kernel.org>, <daniel@iogearbox.net>,
	<paul.chaignon@gmail.com>, <kuba@kernel.org>, <stfomichev@gmail.com>,
	<martin.lau@kernel.org>, <mohsin.bashr@gmail.com>, <noren@nvidia.com>,
	<dtatulea@nvidia.com>, <saeedm@nvidia.com>, <tariqt@nvidia.com>,
	<mbloch@nvidia.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v4 1/6] bpf: Allow bpf_xdp_shrink_data to shrink
 a frag from head and tail
Message-ID: <aMvIONMZ9CFqyNnM@boxer>
References: <20250917225513.3388199-1-ameryhung@gmail.com>
 <20250917225513.3388199-2-ameryhung@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250917225513.3388199-2-ameryhung@gmail.com>
X-ClientProxiedBy: TLZP290CA0008.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::20) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|PH0PR11MB5077:EE_
X-MS-Office365-Filtering-Correlation-Id: b2cf8efb-dc4a-46ec-8dea-08ddf690af43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IE+D49G9JNRlrkWASDJnbcAQVXsXAczYRjzGgMgdK8cQbiNZwNS8wD+cUDZA?=
 =?us-ascii?Q?gNAMvUWGE2ELE6zG6bTJEvHcJ6IFlvsjubYMsEbxvED2NL2v1LXZPRMfx3Ie?=
 =?us-ascii?Q?0mbgcH2sw5+m3aIxasF0kLrteW4ZLKaBF74wG05ROpHvaQUVkB8Cbas07349?=
 =?us-ascii?Q?PO0hvZMGGKEA6hywlG/uU0RMSPOGLYwKU5WKGywAO0l1XLMhE00Teckwm+mX?=
 =?us-ascii?Q?vevtgm2j7B5HKBp1vgyqvAjfIIw9HGGNjjCP8j7JyG4hNDONWandt4OrdPKm?=
 =?us-ascii?Q?azlG8HNzuHj8a8713/LRPqw6rTjE7tikzNWjFy/BrPucZ4TzlzI21fZswP06?=
 =?us-ascii?Q?8am7R7S7U4WRg5XvoBEA1yGki25s2VJJ7EUk7vcKbJ6rRLjv8hyMPLyWBmFn?=
 =?us-ascii?Q?eSwJSvSxdQtv2xVY89/A7ghiDU99EdLTDEczpXOq+VgtYfBPg3j6YI0jqwNW?=
 =?us-ascii?Q?FaSKwdIM1w7YwFe2fIIgsLUD6f+U2yIzkekZdetUGiPuMhW+osdfBZXDhpoE?=
 =?us-ascii?Q?XeAvgZX4A2CKBStqfslCC5WPv/NVStpGjzNDSApYcD/8rX1g7nUufGagn8Ac?=
 =?us-ascii?Q?8eA792pfXSHewptGgpzvPtpmW0hCgJ8OeIjCcuy+0r7fOX+hxT4eHThl5of2?=
 =?us-ascii?Q?33KJpIwD5AuT7mNaImdRruzxZC04HCgkXq2mvo8pxy/SrxF8ng0Ya98zUai4?=
 =?us-ascii?Q?8GJ4EozqlsbM/DZqX9YQlqyIsL5lAHHt+ycHSCtb3yXm5EeqZEZ7+w04Lf+y?=
 =?us-ascii?Q?fx/c+eH5tH9/rblf/P8aM52GfkUSNvovZN48tPAQtyp6/8SoAcpHFISUSTEr?=
 =?us-ascii?Q?nQRCuWLu/ONatxIj9CjnqgBh9j3D31dvAiaJPqWEQ6nzj5LwbijGTbKCy47o?=
 =?us-ascii?Q?DWvDboeujfDJbwyYBIrZ9oE0HR/jiWMwo4LL4o+10E+4mOabzCxcEJCkLZAJ?=
 =?us-ascii?Q?qFNyFjd62yu7hTg5dSwsyCWOnWGdcm9s+Gmd+sm3tVFt+gc7znxUh4fqca11?=
 =?us-ascii?Q?R8gCq2d+ub58Ty44ykq1xUH6u635Q4ZZm2+RLI2WdnlI6ptYSOEY06sfB0aS?=
 =?us-ascii?Q?rLrac0FWHQjGXhKuLKdZPMT5jy210HujGznGmB/1Kz1oN6Sn5zSMWIyrfWpF?=
 =?us-ascii?Q?0PjpApAeSD3yPVOWXDoJ3RmNGTIO5m9HlCR/XPOa7jkUeMDo99eCEf/pZx1K?=
 =?us-ascii?Q?MPUMtNUNI66Abawsoy7RFUM4U0QHnn7lthrvVEnYwfiOkHHxERlHtw+NS2pk?=
 =?us-ascii?Q?3AduPJSQB55wl62SgYsNo/jLEUWt9sUw9ECzbHveUoUxVEk7q3xI01B8uQ65?=
 =?us-ascii?Q?5KYgUtUoYqQgk7D2rZQsJuzcC3U2aGjMHlWW/lMHpyTlIDdG/mbYJ+a/EV11?=
 =?us-ascii?Q?7N7tfrnofnFIqohXdt0WVVB+OcMFCb7AwndfByWEUniq1sNNhGAXjCY3RwvH?=
 =?us-ascii?Q?T1a4drWLyoY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?atrtga0V1NZLHfcPGlRmoCrDVS/OYk1W0L3DirNbCn/k0fiBK79BvurUTbjF?=
 =?us-ascii?Q?S0IkwPRJ1QsC2ZNwj2yrxvqzsAQSG80BF5nJiMKkXcWG78EwVqc09QY+eDao?=
 =?us-ascii?Q?WnMPu1/RTp6zIADetUoqHLMqN8FuOB0dDTNaDhiKvg0KclIzNfkLO/nC4C6a?=
 =?us-ascii?Q?P5flJsyD/bZwPKWy2VrzG3IaZ5BM3ZscyeC5F1T4VKAEOoTJIs2k+OcKjL4M?=
 =?us-ascii?Q?L+ZPEejCzG7V5fApQipwoPxtVbRYxTwCmjWF36QQeizB1T1z2TJ+LOdl6rUW?=
 =?us-ascii?Q?v1EztKPdRQeOELCkUmhVB88v4m1Mxk8be/m0SKZMH2HaFgxE1OxbBc0Co/yi?=
 =?us-ascii?Q?qxIaKgXKqZ1b2qCe+0JQeEgW4UObnrzjq8ZEfY0dRcD0YaIEWcCEVSf9A/rU?=
 =?us-ascii?Q?4XhZWbCalaEgh+2NrcZr8f7UdT17e4VpQihCMCP0WE5FIkQFHhHtPZRpUXdp?=
 =?us-ascii?Q?XsOvwdh3SnLBcAoAXLBJi1rNpJ/SCCN5E+D2yg7d6B0VuByW1RTPys73knMi?=
 =?us-ascii?Q?hY1Pv1Fk+g1wxtug/1FyVNulfO7lAZ+GX94p/sr0QPxM2QR4WZ4iXxY2oVmY?=
 =?us-ascii?Q?KnqbTAa43NAFrCtvV5/HfiBABHAcGq87ngLtu9O7/2OqMHsmTe2z/s238xrZ?=
 =?us-ascii?Q?8b1fM9fycGpdBfwzkfpgwYKfBJF1HDVoCfawKV7+6kIy12QHk0dNYvv76Bgj?=
 =?us-ascii?Q?j7vGlfSRHS0K8s5w2BptgO/ZxJEb2jn97dccDLgopmHHbRDR7yhNACdk/5uc?=
 =?us-ascii?Q?ZMsdNXqwgTtr4ZL7X2F4lltIBXD4tVtyHTi8lub8GvH7dnlhtphW94tJzhSB?=
 =?us-ascii?Q?x1wRNoD+MEUlbKTGH3I8QfXp14PZaLr41gPpAe3/5M7r26YyP3eIZn7CLle8?=
 =?us-ascii?Q?agqScGhbC1pex7d7/x5dIVAuY7QLk7qFoznYbhtAFoUS+RCkSW/i0AjvOsuy?=
 =?us-ascii?Q?gyOApV7CVoySufFMwEREUOGEfHd5gwMGxIGkayUovCCBW7PCqSDNzQV02WGr?=
 =?us-ascii?Q?rlwd5Hri1ctq9Dn28vz/z29Vr0X1IDCzmdPAj67cYy50I6MFByCHkeWTsf0T?=
 =?us-ascii?Q?/BVE0/ojviQ/BPJh9LQEzmV97eWJx9q2O7EWuqX8ISFdBN0V1DcEQh9MMQYr?=
 =?us-ascii?Q?clDvjOYxJ8UoMxJWTncTSTygqmVm5uhBY4spd8/qTj1jTqwf//ahlLHFSAJf?=
 =?us-ascii?Q?fPc9pojwicndgp+7mQBZJlxDMczGJdgBGj2Z82rRlAPWHNU5vyKEc1n7gU5k?=
 =?us-ascii?Q?GnwiBbO8TJbty0KT4kFrlAwAyD0sYKIK4GZvKGh0bufCfJoxZfs+GjUsrQV0?=
 =?us-ascii?Q?CJhUw9NXqFh4LGZ7yunonp3hAtpYpVvlJPmZmM+0AdC5Fv9axh82QbXrWMUZ?=
 =?us-ascii?Q?KufIdfCNQIJDC3jQQqXXiGGGbvffHLRtM2fMDww1ZDZOB6VUzu/6xB2CP/ly?=
 =?us-ascii?Q?J/oa2sJzMT/avGx2mnTjc6GTBxjeg5fNJyRSfWgCCbMTkRZkb06GoJfIbhJu?=
 =?us-ascii?Q?47SJ41wl0qcS2w6wEGZot8yFtFB+hxB3O/iMSyDuw0u8nsXDlvXX1jv8ccv4?=
 =?us-ascii?Q?IQf/d46aFd/cHstj2LM53kaB6Zf61YCuxXJh6DIspzJIeoYjw7KXnqGP3wQX?=
 =?us-ascii?Q?cw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b2cf8efb-dc4a-46ec-8dea-08ddf690af43
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 08:52:23.4218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y/lXNeTgEKRv//mM4JB84kWxYsTHSzaXugzsk1gKAv6mDOXPdof7NA7nrxbbcPbbyUyY+O2o+T1MsY0SmcrLEysHyakEq9e+WKf0xe8viqc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5077
X-OriginatorOrg: intel.com

On Wed, Sep 17, 2025 at 03:55:08PM -0700, Amery Hung wrote:
> Move skb_frag_t adjustment into bpf_xdp_shrink_data() and extend its
> functionality to be able to shrink an xdp fragment from both head and
> tail. In a later patch, bpf_xdp_pull_data() will reuse it to shrink an
> xdp fragment from head.
> 
> Additionally, in bpf_xdp_frags_shrink_tail(), breaking the loop when
> bpf_xdp_shrink_data() returns false (i.e., not releasing the current
> fragment) is not necessary as the loop condition, offset > 0, has the
> same effect. Remove the else branch to simplify the code.
> 
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>  include/net/xdp_sock_drv.h | 21 ++++++++++++++++++---
>  net/core/filter.c          | 28 +++++++++++++++++-----------
>  2 files changed, 35 insertions(+), 14 deletions(-)
> 
> diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
> index 513c8e9704f6..4f2d3268a676 100644
> --- a/include/net/xdp_sock_drv.h
> +++ b/include/net/xdp_sock_drv.h
> @@ -160,13 +160,23 @@ static inline struct xdp_buff *xsk_buff_get_frag(const struct xdp_buff *first)
>  	return ret;
>  }
>  
> -static inline void xsk_buff_del_tail(struct xdp_buff *tail)
> +static inline void xsk_buff_del_frag(struct xdp_buff *xdp)
>  {
> -	struct xdp_buff_xsk *xskb = container_of(tail, struct xdp_buff_xsk, xdp);
> +	struct xdp_buff_xsk *xskb = container_of(xdp, struct xdp_buff_xsk, xdp);
>  
>  	list_del(&xskb->list_node);
>  }
>  
> +static inline struct xdp_buff *xsk_buff_get_head(struct xdp_buff *first)
> +{
> +	struct xdp_buff_xsk *xskb = container_of(first, struct xdp_buff_xsk, xdp);
> +	struct xdp_buff_xsk *frag;
> +
> +	frag = list_first_entry(&xskb->pool->xskb_list, struct xdp_buff_xsk,
> +				list_node);
> +	return &frag->xdp;
> +}
> +
>  static inline struct xdp_buff *xsk_buff_get_tail(struct xdp_buff *first)
>  {
>  	struct xdp_buff_xsk *xskb = container_of(first, struct xdp_buff_xsk, xdp);
> @@ -389,8 +399,13 @@ static inline struct xdp_buff *xsk_buff_get_frag(const struct xdp_buff *first)
>  	return NULL;
>  }
>  
> -static inline void xsk_buff_del_tail(struct xdp_buff *tail)
> +static inline void xsk_buff_del_frag(struct xdp_buff *xdp)
> +{
> +}
> +
> +static inline struct xdp_buff *xsk_buff_get_head(struct xdp_buff *first)
>  {
> +	return NULL;
>  }
>  
>  static inline struct xdp_buff *xsk_buff_get_tail(struct xdp_buff *first)
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 63f3baee2daf..0b82cb348ce0 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -4153,27 +4153,31 @@ static int bpf_xdp_frags_increase_tail(struct xdp_buff *xdp, int offset)
>  	return 0;
>  }
>  
> -static void bpf_xdp_shrink_data_zc(struct xdp_buff *xdp, int shrink,
> +static void bpf_xdp_shrink_data_zc(struct xdp_buff *xdp, int shrink, bool tail,
>  				   enum xdp_mem_type mem_type, bool release)
>  {
> -	struct xdp_buff *zc_frag = xsk_buff_get_tail(xdp);
> +	struct xdp_buff *zc_frag = tail ? xsk_buff_get_tail(xdp) :
> +					  xsk_buff_get_head(xdp);
>  
>  	if (release) {
> -		xsk_buff_del_tail(zc_frag);
> +		xsk_buff_del_frag(zc_frag);
>  		__xdp_return(0, mem_type, false, zc_frag);
>  	} else {
> -		zc_frag->data_end -= shrink;
> +		if (tail)
> +			zc_frag->data_end -= shrink;
> +		else
> +			zc_frag->data += shrink;
>  	}
>  }
>  
>  static bool bpf_xdp_shrink_data(struct xdp_buff *xdp, skb_frag_t *frag,
> -				int shrink)
> +				int shrink, bool tail)
>  {
>  	enum xdp_mem_type mem_type = xdp->rxq->mem.type;
>  	bool release = skb_frag_size(frag) == shrink;
>  
>  	if (mem_type == MEM_TYPE_XSK_BUFF_POOL) {
> -		bpf_xdp_shrink_data_zc(xdp, shrink, mem_type, release);
> +		bpf_xdp_shrink_data_zc(xdp, shrink, tail, mem_type, release);
>  		goto out;
>  	}
>  
> @@ -4181,6 +4185,12 @@ static bool bpf_xdp_shrink_data(struct xdp_buff *xdp, skb_frag_t *frag,
>  		__xdp_return(skb_frag_netmem(frag), mem_type, false, NULL);
>  
>  out:
> +	if (!release) {
> +		if (!tail)
> +			skb_frag_off_add(frag, shrink);
> +		skb_frag_size_sub(frag, shrink);
> +	}

Hi Amery,

it feels a bit off to have separate conditions around @release. How about
something below?


diff --git a/net/core/filter.c b/net/core/filter.c
index 0b82cb348ce0..b1fca279c1de 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4175,20 +4175,17 @@ static bool bpf_xdp_shrink_data(struct xdp_buff *xdp, skb_frag_t *frag,
 {
 	enum xdp_mem_type mem_type = xdp->rxq->mem.type;
 	bool release = skb_frag_size(frag) == shrink;
+	bool zc = mem_type == MEM_TYPE_XSK_BUFF_POOL;
 
-	if (mem_type == MEM_TYPE_XSK_BUFF_POOL) {
+	if (zc)
 		bpf_xdp_shrink_data_zc(xdp, shrink, tail, mem_type, release);
-		goto out;
-	}
-
-	if (release)
-		__xdp_return(skb_frag_netmem(frag), mem_type, false, NULL);
 
-out:
 	if (!release) {
 		if (!tail)
 			skb_frag_off_add(frag, shrink);
 		skb_frag_size_sub(frag, shrink);
+	} else if (!zc) {
+		__xdp_return(skb_frag_netmem(frag), mem_type, false, NULL);
 	}
 
 	return release;

> +
>  	return release;
>  }
>  
> @@ -4198,12 +4208,8 @@ static int bpf_xdp_frags_shrink_tail(struct xdp_buff *xdp, int offset)
>  
>  		len_free += shrink;
>  		offset -= shrink;
> -		if (bpf_xdp_shrink_data(xdp, frag, shrink)) {
> +		if (bpf_xdp_shrink_data(xdp, frag, shrink, true))
>  			n_frags_free++;
> -		} else {
> -			skb_frag_size_sub(frag, shrink);
> -			break;
> -		}
>  	}
>  	sinfo->nr_frags -= n_frags_free;
>  	sinfo->xdp_frags_size -= len_free;
> -- 
> 2.47.3
> 

