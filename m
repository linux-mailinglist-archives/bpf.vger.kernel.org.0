Return-Path: <bpf+bounces-35513-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1687B93B384
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 17:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EDC5B214C1
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 15:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF59015B122;
	Wed, 24 Jul 2024 15:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mDNMn3Iz"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B397383A9;
	Wed, 24 Jul 2024 15:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721834516; cv=fail; b=hFql6rLhA7H30LKl88hV0wpqX321NDiPO3TVWJAoCEjsnE3Vv1EC4hsCPC9KNvcnewmuhuNG25RoJB70sHvSkAgVPLF3nLjl6pLJUMVITyTNFJX4AfHZGuRT5D2P8XktPrrVbZ9BaNVX8CuxNnqhmntfZmS6co+auvJr/A+B2xI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721834516; c=relaxed/simple;
	bh=DJemF+GAwtUfmMFjOHfBxsur87LhZ96o0KDBBkhOeB4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QU7Fn5G2h83Cnh7Lj/mLsN5kjzOCIUYcbXmVX4mpX1ixJ43ttmq3jGmIpDW5RzxTy61S458WHeIeAwgzjtDujWLVcagzrMnTbGjRT6gA8p6Ad3f0KynTRwnnEMEBxBV1CmRSRg0NFYEFtO8da89QNR4VrE0BSQSNABGHCzAy4s0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mDNMn3Iz; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721834514; x=1753370514;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=DJemF+GAwtUfmMFjOHfBxsur87LhZ96o0KDBBkhOeB4=;
  b=mDNMn3IzVbLLGirvmwuo43ZkaMfCed0P6MQ3fEkqSU+LAJCYGYMoq/5z
   eutb6zMSmziSGso3JfIGicuuoA/WQp5ER9OKnT37t825cct0aAYephbQg
   nqpbMSfgvOOyMiuwWc9f7JHoPQpW4dXL9+gm+69h/sZ9ugzTGyp/cFHXO
   Cy+y1mGZznQwZDLRu/X7y8xd8z7z2KUuwHOjGyzfGcU6MHGiEED1I3dGL
   Fj7cijT3i6+DhtcIb+Wu0wr/W4VGz4EVyU4Vq97DHzdiS00cejApztPnW
   qu/uJZwwptd7adp13A8Gx/BhF3EbYoFxtLs/Euj97Oz9JwDZDnvEclYrv
   A==;
X-CSE-ConnectionGUID: uRzPYvdGSMSHV8qfJTcCTw==
X-CSE-MsgGUID: Mbc/dJbASiSLknHajpGyKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="30940240"
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; 
   d="scan'208";a="30940240"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 08:21:53 -0700
X-CSE-ConnectionGUID: +HHfIR/wQiCV5EGccCrAag==
X-CSE-MsgGUID: pz6gLKkPTbyRlWl68oGeGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; 
   d="scan'208";a="56764297"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jul 2024 08:21:53 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 24 Jul 2024 08:21:52 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 24 Jul 2024 08:21:52 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 24 Jul 2024 08:21:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AXcRRwltxEn1IcGRT8kC49nASx5nvUPAWMGGuRdjr9eXqMEIl/9QK/0O48CCfEjFGZupSgXbuUJnPLX6phBA6CPg925wv0UvI+raly47UzN58WypqHYB8aOZ1E9SSM9Y5GPXPb2AfWd3mgqzd3HLtnb+GRvH/LYS6h+GhdPuv+ZggGdAkiqCaVO3GEida9FcYPMGY+11EQAIM21CZJIHsorFbMe5zHlzA1QBxkSx7XI5k27ipcQ95whN57FV5BHXUgFoNabHgc5rzkH+YvCmy6hjHL0KLPCjWJ5juWZryieyaut2tawG/oMllYdYs6cZ5/WtAuny2YkC16P2yiopnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qBwZf6NG6UMP8Rd/0OUl33l4r0Lwb4/y5KmPvgd1G+Q=;
 b=UILBhiKL3YaJToytH/GWH2KzWbZjf71OHJvVkbvaUvC2aDV0OVoFOF1Gu6JAhhbNromwvp/x+wYQD1AQvMkS6GBP43RqPG5DbChaXerQraTaL41XqDModiu7RBpQplUALapGvE+nQ93b/fSybROppwVuTJdsCOjhrMe+odZjm+MpWhr2/NRGubklfzxGDSeC3YfypOuOVyG5wl3xX2b5FRvDR7Y155R/rd2ZiztTaaIv1/18ARBUuZjHkZYX+K61EdiQ0fr0PNlrMITWsZ/ytCri37EHsRq9m7nCDs7igdFZTe1IXo15rlrz/iOiF5jpSpMCg3Kvwov4izvfzxjsvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 IA0PR11MB8333.namprd11.prod.outlook.com (2603:10b6:208:491::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Wed, 24 Jul
 2024 15:21:49 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%7]) with mapi id 15.20.7762.027; Wed, 24 Jul 2024
 15:21:49 +0000
Date: Wed, 24 Jul 2024 17:21:36 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Stanislav Fomichev <sdf@fomichev.me>
CC: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <andrii@kernel.org>, <martin.lau@linux.dev>,
	<song@kernel.org>, <yhs@fb.com>, <john.fastabend@gmail.com>,
	<kpsingh@kernel.org>, <sdf@google.com>, <haoluo@google.com>,
	<jolsa@kernel.org>, Julian Schindel <mail@arctic-alpaca.de>, Magnus Karlsson
	<magnus.karlsson@gmail.com>
Subject: Re: [PATCH bpf 3/3] xsk: Try to make xdp_umem_reg extension a bit
 more future-proof
Message-ID: <ZqEcAKWCDp6lyaC9@boxer>
References: <20240713015253.121248-1-sdf@fomichev.me>
 <20240713015253.121248-4-sdf@fomichev.me>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240713015253.121248-4-sdf@fomichev.me>
X-ClientProxiedBy: DUZPR01CA0276.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::25) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|IA0PR11MB8333:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a6715ce-6d89-4e10-97a5-08dcabf456ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UW8Y18FY9DbxAbph3DV1EFSzAE83L37YACw48IvEEz5x32PeQ0gaEPLS5eNQ?=
 =?us-ascii?Q?j5sxwSzvE2lbI/GaqRzbjYEx6CvoLPQgo2ouzw9Jk+ACFde1ex3jDttG+4xy?=
 =?us-ascii?Q?IpbFUeNQOa7A+sUvUaP/cJ60jCk962r7H4XsYzoqhQ3hsu5qzTrcex1tB5q+?=
 =?us-ascii?Q?7pJujFf/C0DUAw+YbeDHOuvee1J5Qw42zt599HjPX40FeGafcVAPtUS9Iaf9?=
 =?us-ascii?Q?tk60dsIYJeDjCjrjbpWTyO6E3PI32KIQPiJhKDsY/VB7Nz4Sjch+GiE8o6Ic?=
 =?us-ascii?Q?Wn2EeRsegauEw5Ojl6YgFJu1X1oBziZLraBhBFxoX8hJmOaOignEVOqAQSis?=
 =?us-ascii?Q?MmpvYe6XO6XiWsbms3DHiUQxUACBqNNwHmayWBAYmi/IPW5XHDm+tRPfa3zb?=
 =?us-ascii?Q?DkM6j4DPcLgonw03aab4I4f5s1hq2GbFpARjjsJ9OkVSR9LFMo714voKHLMl?=
 =?us-ascii?Q?GDyJb9DGlo6eBiFC/BWQkAKp5jN/tKOdPqQPZFxUsB8FtgSkXQmSTF22AB2M?=
 =?us-ascii?Q?V4Dyagt7+ZMEzCZN2xBd+H8jKAzkdqEJc1czvkIRBwGpbvoNopUAHjf7mpGM?=
 =?us-ascii?Q?x0X9m2wFnxONp/AFj/f+uNMmEXO7BCrRLB+IrhCJti2WnRO08bNcy5PHxWKx?=
 =?us-ascii?Q?cX+UbyrDTTEGVYTSJ7lc12hK+86lb2YZimkBn6AVQTUKK2NXfmVCZmDA1d/1?=
 =?us-ascii?Q?G45lNkH7cZJeack3y2xzen/5mB86DAb0KH/wuWda5E8cIP50VLE9CAe3Id8/?=
 =?us-ascii?Q?XOxGTQ/cNoEIzV50efNZHYg4OG6e3RcbdjHOiMvStZfA/2BkncqB/1so16qs?=
 =?us-ascii?Q?HwvLpHwR3moL49+16cdX+m94TliTtl6yfW51pTBbm2JKFVNjwT3xX/45DKAE?=
 =?us-ascii?Q?MZTHy/UJJ2adIL+9n6uICPbOyNHqr8PBcNvH1aslqFMI6msTzZOI/UpdFjC8?=
 =?us-ascii?Q?rMl4P4IRe+wsnXRMsNhJaV/gCnmreLyuPLe+rgQa3i1y59NBl5SUyNHWLKQG?=
 =?us-ascii?Q?VOo4JPEIJ9GLoUlkS4KHdRcDnYLxtZD2ndY+bJpsiHYkQMdP2YhVmV+iMirJ?=
 =?us-ascii?Q?QD5afdUcKmkHiLcdIVSUJ4C1l36ZYZ1VNKTUKRWxTPSHzfzNdN7M+jlX+Q6+?=
 =?us-ascii?Q?5BzMv+IdJVVFFTJjQ32N/MrG/5E4KDwZEqNLPj04aksxy0cM/qqWoeHc7uwN?=
 =?us-ascii?Q?alszeISg+es5d17pXnmBzfERdlrMvuv0JUo6Hv/2Kx9RY84+kf+6rb3QANDx?=
 =?us-ascii?Q?w9hyW6jGPa3JDq9P8joEwHH7fWAx2D2Ol1H7lhDSOdlDDBX1Lit0IHFLAqTT?=
 =?us-ascii?Q?7onzkrOTvoWhfrl8NBZGQ3Aw2i612SeJhN/MfB1tOoREsw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W4jbHHyknrVM39hRsAag/8m+KrB7krTgOCuILRrkntHMWwGjcu8mf3biAWMc?=
 =?us-ascii?Q?2TBDvxgUquocQX9yiwWLi3utaHot9Ux/YXTS5ySzx/wlxLH74lrXN18HRUsk?=
 =?us-ascii?Q?lhW7GEqxSrV0DYK1LnTFIu/p6D4LIH/zswAFoLndGxdBCgpbrzt3VnpMiDsR?=
 =?us-ascii?Q?Vzv5qq0Frkm/KYe6xJ7yfybyx3cCvz+HgODvLbnhKJ40oEdFFSLvVfpcaZjU?=
 =?us-ascii?Q?JcRXc9WKdiiR380Vs4UVMemSRgHydWTxiTw/nXYBwZCu8GWPIp1r/W/wcnyO?=
 =?us-ascii?Q?VqRo/cvpJuFysvj7viqSyPtyaNZmJEb5g6xOFLuKuu/MyZ0/E3F0E8pcmjaw?=
 =?us-ascii?Q?b6+F39qIbVZ9z95oR/UX3s7r6TlXUOg86hJmaPV0u3OporBT051BFoS8I0lW?=
 =?us-ascii?Q?B2cLoQWdzNZHPpSr1UHMnjtNM3+UGLItx2tq5waHDcgVunMb4ipwjpmrocI/?=
 =?us-ascii?Q?Yj7ryDpIgnjFbrXwAZqsXp1V9qUaEi/DE0g5uy7AWMGsRtwm2tE5oMKX/sqv?=
 =?us-ascii?Q?3fA7t289oQCQxq3gNu6UHtmT+GsJWJiK/d5agLwXu/RltRTUB7vLN0Gt5eCI?=
 =?us-ascii?Q?mgK+lQh5kJupi8Buts50odYfrjja7QJFE8PB1BH4vdwDchx/m38cxJxyu2bi?=
 =?us-ascii?Q?iDpROmuWDm+7sNc0r0jJSngezmy4rqGYOfME5tK4VyJGNTDJT65mzGQFBZe7?=
 =?us-ascii?Q?yZ9MQKNUfHVR5Ti1FWcohdvdmnl9XGBEajmEfGS+70hEP/O6HjleEb4OqZV+?=
 =?us-ascii?Q?rjkVKWt3GUfaAvEN7gsIMYFDWa9wodP9e0wFm4HPic3yFm1+LXp+ICheIqka?=
 =?us-ascii?Q?BD56+M3yFlcCkbrVBfPd9YI2a/wVRplCURgF9XGDEb40Wfkju0pHbQ4ngpea?=
 =?us-ascii?Q?PrkLejAY6PVEdO3i7hOfiPyfnZP8uHk7edQfB8FEZab/fMqzUs3ETU8Y/5V7?=
 =?us-ascii?Q?mdpU7dyycJW3mForA3j+OOZwZMwdE2CrHxOGYpMv7Sq8z9HHYs4j+GSts+uL?=
 =?us-ascii?Q?Hy0bb9UY46dRedljNUPToi+xEcFtAtiMqbgS33+Y1LShozpBYIhy+Cf+QK50?=
 =?us-ascii?Q?XXkCFg4IzWuz4m8TEM2GEqXJEX++WtP5QdMyWvcOGQGEeisL2GILnGl0HYtz?=
 =?us-ascii?Q?ueHMyYVxwZJqACrJVYa/xYls2BNImE4c0Sro82QbKqQVFmErqx6uXnvIUdY8?=
 =?us-ascii?Q?SI4iAl7gZqIdjjTIszBl4p0OVUz86acwcx7hDsJFXidiYEeE0ZbKIfiyBwUk?=
 =?us-ascii?Q?q6T9jii7EiuhPcVRCE9Qd6OS9SSUSNalEtKZVbURyZyfrySLzFac8Ud1CwXb?=
 =?us-ascii?Q?BHnoeM5dVTfQoXvYGB21C4rhLq63trg0prfqk04W4zCc68+D1xJo0vO0vUx/?=
 =?us-ascii?Q?dQ8+l2YSqX7S2JXoMZANQrCeTxJzCyRGckuy9Ufx78umV5B5Ul36m0Nzd1kX?=
 =?us-ascii?Q?GTD5DUgpaSglY88a+JVLIvVjsKFT//o9CQ+CwAh6bppMysdJIhSQ6xQ2Z7Km?=
 =?us-ascii?Q?B8/07gkeQc/hri7HYKXzSsKYdN1b8IFjdjPjQLUrjo0ejNqNh9RQ+ZthUIkZ?=
 =?us-ascii?Q?Lq3M5xyvJNxzqUqAB2mXDBbbmqI+VqnlpDJ5fgGfdP42Y64Bda7a+1hCUOgh?=
 =?us-ascii?Q?0A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a6715ce-6d89-4e10-97a5-08dcabf456ac
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 15:21:49.6861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SAM0nOL+kWsOfFctUT3hYGqe4LbkO+lFm4Msz+7aSZkItCRpHwkF/kZIw79hqq8vzFbDxra1rCF5zlZSS/GU4Ser8GSdjPcGchoRI00RHDs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8333
X-OriginatorOrg: intel.com

On Fri, Jul 12, 2024 at 06:52:53PM -0700, Stanislav Fomichev wrote:
> Add a couple of things:
> 1. Remove xdp_umem_reg_v2 since its sizeof is the same as xdp_umem_reg

So thing here is that adding __attribute__((packed)) on kernel side
wouldn't help because we wouldn't fix old uapi with this, correct? old
uapi would still yield 32 bytes for xdp_umem_reg without tx_metadata_len.

Just explaining here to myself.

> 2. Add BUILD_BUG_ON that checks that the size of xdp_umem_reg_v1 is less
>    than xdp_umem_reg; presumably, when we get to v2, there is gonna
>    be a similar line to enforce that sizeof(v2) > sizeof(v1)
> 3. Add BUILD_BUG_ON to make sure the last field plus its size matches
>    the overall struct size. The intent is to demonstrate that we don't
>    have any lingering padding.

This is good stuff but I wonder wouldn't it be more feasible to squash
this with 1/3 ? And have it backported. Regarding the patch logistics, you
did not provide fixes tag here for some reason, but still include the
patch routed via bpf tree.

> 
> Reported-by: Julian Schindel <mail@arctic-alpaca.de>
> Cc: Magnus Karlsson <magnus.karlsson@gmail.com>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  net/xdp/xsk.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 7d1c0986f9bb..1d951d7e3797 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -1331,14 +1331,6 @@ struct xdp_umem_reg_v1 {
>  	__u32 headroom;
>  };
>  
> -struct xdp_umem_reg_v2 {
> -	__u64 addr; /* Start of packet data area */
> -	__u64 len; /* Length of packet data area */
> -	__u32 chunk_size;
> -	__u32 headroom;
> -	__u32 flags;
> -};
> -
>  static int xsk_setsockopt(struct socket *sock, int level, int optname,
>  			  sockptr_t optval, unsigned int optlen)
>  {
> @@ -1382,10 +1374,19 @@ static int xsk_setsockopt(struct socket *sock, int level, int optname,
>  
>  		if (optlen < sizeof(struct xdp_umem_reg_v1))
>  			return -EINVAL;
> -		else if (optlen < sizeof(struct xdp_umem_reg_v2))
> -			mr_size = sizeof(struct xdp_umem_reg_v1);
>  		else if (optlen < sizeof(mr))
> -			mr_size = sizeof(struct xdp_umem_reg_v2);
> +			mr_size = sizeof(struct xdp_umem_reg_v1);
> +
> +		BUILD_BUG_ON(sizeof(struct xdp_umem_reg_v1) >= sizeof(struct xdp_umem_reg));
> +
> +		/* Make sure the last field of the struct doesn't have
> +		 * uninitialized padding. All padding has to be explicit
> +		 * and has to be set to zero by the userspace to make
> +		 * struct xdp_umem_reg extensible in the future.
> +		 */
> +		BUILD_BUG_ON(offsetof(struct xdp_umem_reg, tx_metadata_len) +
> +			     sizeof_field(struct xdp_umem_reg, tx_metadata_len) !=
> +			     sizeof(struct xdp_umem_reg));
>  
>  		if (copy_from_sockptr(&mr, optval, mr_size))
>  			return -EFAULT;
> -- 
> 2.45.2
> 
> 

