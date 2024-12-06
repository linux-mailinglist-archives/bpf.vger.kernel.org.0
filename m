Return-Path: <bpf+bounces-46290-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5629E75DE
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 17:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1C2F288FAF
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 16:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7939D2309B7;
	Fri,  6 Dec 2024 16:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AsqOofSI"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1096C2309B1
	for <bpf@vger.kernel.org>; Fri,  6 Dec 2024 16:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733502314; cv=fail; b=e8AbYfmXm6ssvatnJ0mGG/9ukWKyPmTRO3l1WXkKqX1fsb+frjinroYp15Dw06s0mmbWSz7MOjMWAuIMzC2IqnGQ3YD7czj/mm8KuL8lFmduL/inBOl4JfFhq46KJRI5lu8eaUPzXfXZ3+RLruQ6x5WwaRhGoyIPQWkkS/WRTVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733502314; c=relaxed/simple;
	bh=865xUoAbinA20CMvA40rX9TyFUXZm81dDKDC/PBiUpc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=r+T5XALge+WNwMb4g1loh9cSU0bN/pnG75jMeBr/c0bXU+reZ1Cq5mpvanTDTPuFtp2uUruvIW6KjntsS03YQDnaJ506vIeO79OH/0IXIS7GjcRuJe0RsTY4z5AqTKfnWqwzkbCzZ5kI6XmiYjISxlZV1r7BPimOQBBkItOLLqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AsqOofSI; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733502312; x=1765038312;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=865xUoAbinA20CMvA40rX9TyFUXZm81dDKDC/PBiUpc=;
  b=AsqOofSIKm1mZOeFTx3Woq6V4/gfQhqs2FeDMCn3vvnYlhw3/6XJQO6x
   rh4AyxxUlRRzWsR2REWA4imoC+p/wvoIODjeie8+m2DA5th2cUv9UvkfR
   BF5pDhdZJOh2uIpYGkR7GmldU3E+Jo3W2DPuUGxcYYGwYG0tYQBI8lh95
   3bNzWZjYt4aeTI4qRTTbUpUT5nrhHIj6I0zpEWWp1gS5cg3BImgGuVNtD
   r8/CL5IcUpOq9He2BTeDsosRmThiSm0vbB85dtMt8DyAGsg2Tpzr1s0Wx
   hrI9fXc86n4rR+t0bTeD57UZo713nLfkO4fZLHNFXswHVPz8He7dGsxm4
   w==;
X-CSE-ConnectionGUID: HPTznsmgRW64zUICa9Y1yQ==
X-CSE-MsgGUID: jGRGEkH6Rq23iyTYu9spXg==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="45258796"
X-IronPort-AV: E=Sophos;i="6.12,213,1728975600"; 
   d="scan'208";a="45258796"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 08:25:11 -0800
X-CSE-ConnectionGUID: x3qdDGJRTg+7LTIqzrpE4w==
X-CSE-MsgGUID: nFdDAmAJRLei1SDFXDU/Lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,213,1728975600"; 
   d="scan'208";a="99261454"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Dec 2024 08:25:11 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 6 Dec 2024 08:25:10 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 6 Dec 2024 08:25:10 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 6 Dec 2024 08:25:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NZP6KBjZcnZFoEK6hWs1SKpWZlimMqBGGYRT3q7J9FKxJ90+XXlz2fIqhB66y8lpqI1erTxQMOHiTWle4N9tDUE7QtV4V9QlloSqaAh2gFajajowKR3biwOBGXI5p1bP9g015feAvqV+vEw3SFeGrn4Z8yUVhYOlDZbTv8oT0IwUW2lEKzr/SuRHKXOOARn4kFeD+AdfkigCbOzoMy/rtnpHDaB8u1324wDSfJSiJ/veIZcuFAgljw8Jb3DTU3aBZex//br8ynWpZfvJRJrItUYVU1j1BxvDoGy8ExUYAmHqQtTKvglIiRJnMp47QkZYs+Y58suHPZxlBycBrLhdag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kn05TGMNrd0uckQjRfak81f++hNPmvhOvmWDnNqKMNk=;
 b=eYk/5t8hKNCkhxawme5Qupr0mdIZNnrxG+NJ9mBgExNXKA4eXLeN4ilpR8guyAmZ1Bhm2zaN+OuORwblP+nEBLqfo9xtkZ7l++YZorH9DuopJfB91G4vp6YIp5Eo7QpZ1YrXKrLf4LH/ucaG2OprdTIZV0ae5HJxfB5s5gRlq28N/NxdAYa1jRVByeWxrNtE0LDsxbgiHoO5iZd4FvDuMsx9rznJqIx6NZqq7clYRCXjvREeiR9kuk1pJy64BmdZ6Y9/mYWj7xbIQzkf1SkaTt6IrkCRdcdHRNlcf43Q3plsSO1jU3Eut6QzBDDP8vEWowQtelV1oREc1/uqef4BbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SA1PR11MB6685.namprd11.prod.outlook.com (2603:10b6:806:258::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Fri, 6 Dec
 2024 16:25:05 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%5]) with mapi id 15.20.8207.017; Fri, 6 Dec 2024
 16:25:05 +0000
Date: Fri, 6 Dec 2024 17:24:53 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
CC: Amery Hung <amery.hung@bytedance.com>, <bpf@vger.kernel.org>,
	<magnus.karlsson@intel.com>, <sreedevi.joshi@intel.com>, <ast@kernel.org>
Subject: Re: [External] Storing sk_buffs as kptrs in map
Message-ID: <Z1MlVa3OXQJw0VXm@boxer>
References: <Z0X/9PhIhvQwsgfW@boxer>
 <CAONe225n=HosL1vBOOkzaOnG9jTYpQwDH6hwyQRAu0Cb=NBymA@mail.gmail.com>
 <d854688a-9d2d-4fed-9cb8-3e5c4498f165@linux.dev>
 <Z0dt/wZZhigcgGPI@boxer>
 <d1e95498-4613-43e0-bc6b-6f6157802649@linux.dev>
 <Z09uQ48lKEsORsS1@boxer>
 <ecd47c2c-7b34-4649-ad97-3988c7644317@linux.dev>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ecd47c2c-7b34-4649-ad97-3988c7644317@linux.dev>
X-ClientProxiedBy: WA2P291CA0035.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::11) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SA1PR11MB6685:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a5a07a9-f505-47d2-7e30-08dd16128ad1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?A0OmTuxUKB4Qq20Lmrmzkw1fZgvF23TvwjEDMQu0h46lfP/r//J6GBV91ca0?=
 =?us-ascii?Q?f0c3TQCmDmxbfGn0ifukKrY8pllN6hDpTWETInM+/QXB0sQqyjV31AY3HQGG?=
 =?us-ascii?Q?3DntSn5+2oqOUdzmYebpbEPkVcn4gD0LWb+NXZDLmeMpnI4b6IIDMbTio3Vk?=
 =?us-ascii?Q?z/66XNI+JZVvvrGNXr9XyeI4wYifuJmCiB59XNH60Ww5Tgmwfxzi99zhZkmR?=
 =?us-ascii?Q?/QfhCbkLmtSjfd/MAIa+eUNoqeTIXulN0Z/5ZbnU5NX60gISwTjBnN5mQxu3?=
 =?us-ascii?Q?eLoLMMnMb9Dag2HqASMcr3pr1UBOQXQxQg4ZJTtzD4XxiHQCss1zbWB6bjxo?=
 =?us-ascii?Q?3XdK0TBtf9dj83bGrmCMlYH5n//G0XtwvMrKArOHXzSzqNDIhEF3vGzjGdxJ?=
 =?us-ascii?Q?r+2l1tnl4NHsYfanGxqysX2t7yWhw1bCvQ4RLsIQ4V9v8jaw6yIQTBaJas0l?=
 =?us-ascii?Q?2geQsVXwxFU3B54nwP/DYZmMS7ta1vZ2PBuaEashGL0dkKX0p8O6ca2LbowT?=
 =?us-ascii?Q?gQ7UyYOLNaAT/YHvfqwfxEg2cTd28fisWrWJnMKL980OuePNSM5/+mk4nDOL?=
 =?us-ascii?Q?xqHpXPfF+L+z7H6N+IiNtQslhkJg0USugJ545aTf7ThB7x2o66kQwqL/mvsy?=
 =?us-ascii?Q?U290ceBWS+3CzEN4UVgS9o3Z1Sl5RCi//XMnjMpDwCurfNcWoSECzlhxqC6g?=
 =?us-ascii?Q?Eujg6jCGbNA87IeugLWvn7ewqa9gQNun8zX0SuN8rV+R6rHTe/erwZjmJg9t?=
 =?us-ascii?Q?TfCvocqehYHQOhBbFeeSCvP+7JfX1DWByDzTu00rO1APCjkRNSfQItVrt/iY?=
 =?us-ascii?Q?2wlFx5LVzQ3IQ1xMXOBVhz2K0wfct8l2ZeJlIWh2Uj5Pq/zxZacVfCGmcjVa?=
 =?us-ascii?Q?R6TU5jIODkEzk08YLQUyKT7gbwcKy+6QFvqJctaJKEpSgkgqVFhhX/bQb48R?=
 =?us-ascii?Q?B2ktYaOTN8EhcOT3Y+fb4eh9TwynzuuDTVCbxBWQMobp/Aqgn24JCnTuElay?=
 =?us-ascii?Q?RxLm8H/8gY0WGapZleWmpRld+nRTy2OpjUBNowoG2mmGYxai1/R0Qhbw3O0w?=
 =?us-ascii?Q?DmG/Yw6IgzgGryAQUymxd+4aFu4plBF+6Td6rrvnh85/VUUIA6Pe1bOR5A85?=
 =?us-ascii?Q?4wL9xP16HHyZh4JifadG9Z4kIYYkfaNDqcpOIBP6xYKUqDXJR+nC6I9TFYZh?=
 =?us-ascii?Q?gXGzNejIf0ilwAIq/Tir8UN/JPdU13pqEDh0HPwYJLk4/boNsIqWq+jFnR7O?=
 =?us-ascii?Q?UnjQ2yvuYAROy85mJ1qFhzBSH1P+nEz9r5slreXvEA4a0j66B/ES6zT6CP6U?=
 =?us-ascii?Q?pcpIqNUtGYtJMd275NceC2WXagzdA7OqpHEU7s9eFJZx2g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Cc3hDDm15ExvlQeIb0Jq2JpvPf+5r+Z6yDLJl9s2FjxPY2RPtQYFOusQQ8Vk?=
 =?us-ascii?Q?unI37KQWyVu02eNUDvHbNsYHh82+kYA2zsTyYdSYdmhfgLo1RxrNHGlBNX+W?=
 =?us-ascii?Q?8awJ7lMeN8oYKzQsu0aKtwHnQVeB52Ae+IzmdRCMcVxOV/5QpBFLQIQ0vX0o?=
 =?us-ascii?Q?Y3/QMXzcvLAm3c+TtO7k/l89w1DCKyLfi6uBMXZWkndilu5Y4HjRyPBKYRFd?=
 =?us-ascii?Q?8Qef/u8OhDqS3iNuH+ulcRpIw8rsdO33v3/3+npBgRbkcaBtxMgUiMC967ah?=
 =?us-ascii?Q?P0Awl5De64PV9b2jKWoN9OG4rvECrvxmJFXpiz2QMN7sD/0T3QkwZnLm0rGp?=
 =?us-ascii?Q?LNXfJMlgh1QPGQqc7v350uC7rI9uokrTWgvg/5efjY30qAUcZmFNBucJXAxR?=
 =?us-ascii?Q?57yNvzn1M3z53HNnSGWzG9nOen/+ORS/2rQpz968BRg1MHwqX/E1PERl+DTT?=
 =?us-ascii?Q?+6Gnf1nJ8zIj0t+QmaK4ytALpoVijH9ZR/dUCnHUhWjjxepow7xXTqJolxHC?=
 =?us-ascii?Q?jGhBVS+Ifb/oyUsoZzB8EKGg9P52J+bd+ZjQEErvpvclPbH3f1dijSKniVt+?=
 =?us-ascii?Q?+jTQbh2kupqSDVQuCshTRoLvU/8A3e1RbDTE5T2mZM3LEqqGPycdGbOMwGsL?=
 =?us-ascii?Q?RknX+ZJEkLDOo/7ijO959RuZ9K7a5KngmhQ35SZ+j4gd1H/qy1SCSDLrd2Us?=
 =?us-ascii?Q?4D3XJhE6Cm429nzrCXMWyto4RThsjL1el5txJcywM+THdFy3gR+pkY9nqY6+?=
 =?us-ascii?Q?GKp6O9ewugqBl5uaq46rsNGUXvznQZmSRKOlUH5L0vInv0sBGRK/1TETUr+7?=
 =?us-ascii?Q?N/jb2e4hOALYKfcZPnApgsXmLorZ1eRCYCaZASFMohOiuLbTqeYe/je3Ceot?=
 =?us-ascii?Q?PnWcefk9ueMWJZam53agBpy9Z/JEVaSDA9V5DUVSknkvCCtMBe+5m596ABQ3?=
 =?us-ascii?Q?yQ/+NT/b65fqhPMBC19s98FCOcs5iiTrPzEbZ8KtOB461jAO8uM7RQOsry0x?=
 =?us-ascii?Q?lzX/Z3671+soGB0iH9ilQ9P9MXB9Pz8PsVVWQBNviZwYuhKSJ7fb5Z3T2p4L?=
 =?us-ascii?Q?eBMLTgEkk0JV6hODsMI22KD4sb5BNTILwwwIw4Ssm4mURCQ5/6rO+oR/XlDT?=
 =?us-ascii?Q?XToxOD5VUUTFSg0aynLkBGPZZ5xLu6m76gDxKwdEVPX/xcUzJDk5C1AUoJ2U?=
 =?us-ascii?Q?JTyq2u1pBJgn41jWKO2guzVjYYTqjjS2A33iluHZKYpZOpZ/xegrqzie/Hic?=
 =?us-ascii?Q?XRKBLta6UISUjAt92auLomVk2CqmF67T+3ck/VK9RRaIEDhQ2vu9uogcSjHj?=
 =?us-ascii?Q?p4ySZU+1EVIfvZQVRfct6glmP12mAJzNwggKUieNX+W+34E3spTmh6zDB3hc?=
 =?us-ascii?Q?6JEz3pj2GiTDnzAJADcv7bokQF5UGkod8J2MSjLjwzBfPmC13aTJ5lRssRec?=
 =?us-ascii?Q?wKr4bdcZ7ewD+wtrpW57iZXRWxaibWNHXqnUOGp+JF2f5KuHFOVV/9H+ExXn?=
 =?us-ascii?Q?kkyXfNoe4HsgWc2/wDi8DYHDO0IlbGjvYFy1oIY/BvamEP8SdB0XBwYZWtYa?=
 =?us-ascii?Q?p8JK0pXUdW1UaaaSi5+2vDkrEOV65JLKntSvjc2fJ0WDG1wfxSdKt15vhTV1?=
 =?us-ascii?Q?Jw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a5a07a9-f505-47d2-7e30-08dd16128ad1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 16:25:05.3049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e+9T0e4Xn07uVoF2IFzmj5Q9quwpi4pmrV8ypCaDAv3Pjkre+k3ppop3ZquxtRcdbscHDIISawwK6Q0XROlQ/r3ktW3gMBHNBrfv2L5BBVw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6685
X-OriginatorOrg: intel.com

On Wed, Dec 04, 2024 at 03:24:33PM -0800, Martin KaFai Lau wrote:
> On 12/3/24 12:46 PM, Maciej Fijalkowski wrote:
> > ; bpf_skb_release((struct __sk_buff *)tmp); @ bpf_bpf.c:161
> > 36: (bf) r1 = r6                      ; R1_w=ptr_sk_buff(ref_obj_id=3) R6=ptr_sk_buff(ref_obj_id=3) refs=3
> > 37: (85) call bpf_skb_release#102037
> > arg#0 expected pointer to ctx, but got ptr_
> 
> ic. The bpf_skb_release() is hitting the KF_ARG_PTR_TO_CTX again.
> 
> > processed 34 insns (limit 1000000) max_states_per_insn 0 total_states 3 peak_states 3 mark_read 1
> > -- END PROG LOAD LOG --
> > 
> > 
> > Still the same problem. Also even it would work it was not very convenient
> > to cast these types back and forth...I then tried to store __sk_buff as
> > kptr but I ended up with:
> > 
> > "map 'skb_map' has to have BTF in order to use bpf_kptr_xchg"
> > 
> > which got me lost:) I have a solution though which I'd like to discuss.
> > 
> > > 
> > > Please share the patch and the test case. It will be easier for others to help.
> > 
> > I have come up with rather simple way of achieving what I desired when
> > starting this thread, how about something like this:
> > 
> >  From 0df7760330cccfe71235b56018d0a33d4a3b9863 Mon Sep 17 00:00:00 2001
> > From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > Date: Tue, 3 Dec 2024 21:00:44 +0100
> > Subject: [PATCH RFC bpf-next] bpf: add __ctx_ref kfunc argument suffix
> > 
> > The use case is when user wants to use sk_buff pointers as kptrs against
> > program types that take in __sk_buff struct as context.
> > 
> > A pair of kfuncs for acquiring and releasing skb would look as follows:
> > 
> > __bpf_kfunc struct sk_buff *bpf_skb_acquire(struct sk_buff *skb__ctx_ref)
> > __bpf_kfunc void bpf_skb_release(struct sk_buff *skb__ctx_ref)
> > 
> > Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > ---
> >   kernel/bpf/verifier.c | 8 ++++++++
> >   1 file changed, 8 insertions(+)
> > 
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 60938b136365..b16a39d28f8a 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -11303,6 +11303,11 @@ static bool is_kfunc_arg_const_str(const struct btf *btf, const struct btf_param
> >   	return btf_param_match_suffix(btf, arg, "__str");
> >   }
> > +static bool is_kfunc_arg_ctx_ref(const struct btf *btf, const struct btf_param *arg)
> > +{
> > +	return btf_param_match_suffix(btf, arg, "__ctx_ref");
> 
> imo, new tagging is not needed. It does not give new information to
> the ptr type. I still think the verifier can be taught to handle
> it better.
> 
> I took a closer look. I think the issue is btf_is_prog_ctx_type() selectively
> treating some kfunc arg type as the uapi prog ctx instead of honoring what
> has been written in the kernel source code.
> 
> The projection_of test was first added in
> commit 2f4643934670 ("bpf: Support "sk_buff" and "xdp_buff" as valid kfunc arg types").
> It was originally added to allow the kfunc to accept reg->type == PTR_TO_CTX
> as its "struct sk_buff/xdp_buff *" argument.
> 
> After commit cce4c40b9606 ("bpf: treewide: Align kfunc signatures to prog point-of-view"),
> the need of projection_of in btf_is_prog_ctx_type() should be gone.
> However, this projection_of check has an unintentional side effect
> for the other btf_is_prog_ctx_type() callers. It treats subprog
> (in the bpf prog code) taking the "struct sk_buff *skb" arg as the uapi
> prog ctx also. I don't think the bpf prog should do this though. I have a
> "call_dynptr_skb" subprog to show this.

Nice that's what I wanted to say from the very beginning but didn't have a
good justification in terms of getting rid of projection_of() call :)

> 
> For the skb acquire/release kfunc, I think it is better to begin with
> the "struct sk_buff *" as its arg type and return type
> instead of "struct __sk_buff *" because it is the __kptr type stored
> in the map. The kptr_xchg will also return the PTR_TO_BTF_ID.

Yep that's also what I stumbled upon, that __sk_buff as kptr will not
work.

> It will need another cast call for acquire, like
> "bpf_skb_acauire(bpf_cast_to_kern_ctx(ctx))" but this should be fine.
> The "struct sk_buff __kptr *skb" stored in the map cannot
> be passed to the bpf_dynptr_from_skb() also. It shouldn't be
> allowed because bpf_dynptr_from_skb will allow skb write
> in the tc bpf prog. The same goes for other tc bpf helpers which
> takes ARG_PTR_TO_CTX.
> 
> I think we can remove the projection_of call from the
> bpf_is_prog_ctx_type() such that it honors the exact argument
> type written in the kernel source code. Add this particular projection_of
> check (renamed to bpf_is_kern_ctx in the diff) to the other callers for
> backward compat such that the caller can selectively translate
> the argument of a subprog to the corresponding prog ctx type.
> 
> Lightly tested only:

I tried the kernel diff on my side and it addressed my needs. Will you
send a patch?

> 
> diff --git i/kernel/bpf/btf.c w/kernel/bpf/btf.c
> index e7a59e6462a9..2d39f91617fb 100644
> --- i/kernel/bpf/btf.c
> +++ w/kernel/bpf/btf.c
> @@ -5914,6 +5914,26 @@ bool btf_is_projection_of(const char *pname, const char *tname)
>  	return false;
>  }
> +static bool btf_is_kern_ctx(const struct btf *btf,
> +			    const struct btf_type *t,
> +			    enum bpf_prog_type prog_type)
> +{
> +	const struct btf_type *ctx_type;
> +	const char *tname, *ctx_tname;
> +
> +	t = btf_type_skip_modifiers(btf, t->type, NULL);
> +	if (!btf_type_is_struct(t))
> +		return false;
> +
> +	tname = btf_name_by_offset(btf, t->name_off);
> +	if (!tname)
> +		return false;
> +
> +	ctx_type = find_canonical_prog_ctx_type(prog_type);
> +	ctx_tname = btf_name_by_offset(btf_vmlinux, ctx_type->name_off);
> +	return btf_is_projection_of(ctx_tname, tname);

We're sort of doubling the work that btf_is_prog_ctx_type() is doing also,
maybe add a flag to btf_is_prog_ctx_type() that will allow us to skip
btf_is_projection_of() call when needed? e.g. in get_kfunc_ptr_arg_type().

Thanks for helping here and I look forward for patch submission:)

> +}
> +
>  bool btf_is_prog_ctx_type(struct bpf_verifier_log *log, const struct btf *btf,
>  			  const struct btf_type *t, enum bpf_prog_type prog_type,
>  			  int arg)
> @@ -5976,8 +5996,6 @@ bool btf_is_prog_ctx_type(struct bpf_verifier_log *log, const struct btf *btf,
>  	 * int socket_filter_bpf_prog(struct __sk_buff *skb)
>  	 * { // no fields of skb are ever used }
>  	 */
> -	if (btf_is_projection_of(ctx_tname, tname))
> -		return true;
>  	if (strcmp(ctx_tname, tname)) {
>  		/* bpf_user_pt_regs_t is a typedef, so resolve it to
>  		 * underlying struct and check name again
> @@ -6140,7 +6158,8 @@ static int btf_translate_to_vmlinux(struct bpf_verifier_log *log,
>  				     enum bpf_prog_type prog_type,
>  				     int arg)
>  {
> -	if (!btf_is_prog_ctx_type(log, btf, t, prog_type, arg))
> +	if (!btf_is_prog_ctx_type(log, btf, t, prog_type, arg) &&
> +	    !btf_is_kern_ctx(btf, t, prog_type))
>  		return -ENOENT;
>  	return find_kern_ctx_type_id(prog_type);
>  }
> @@ -7505,7 +7524,8 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
>  		if (!btf_type_is_ptr(t))
>  			goto skip_pointer;
> -		if ((tags & ARG_TAG_CTX) || btf_is_prog_ctx_type(log, btf, t, prog_type, i)) {
> +		if ((tags & ARG_TAG_CTX) || btf_is_prog_ctx_type(log, btf, t, prog_type, i) ||
> +		    btf_is_kern_ctx(btf, t, prog_type)) {
>  			if (tags & ~ARG_TAG_CTX) {
>  				bpf_log(log, "arg#%d has invalid combination of tags\n", i);
>  				return -EINVAL;
> 
> diff --git a/tools/testing/selftests/bpf/progs/skb_acquire.c b/tools/testing/selftests/bpf/progs/skb_acquire.c
> new file mode 100644
> index 000000000000..65d62fd97905
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/skb_acquire.c
> @@ -0,0 +1,59 @@
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
> +#include "bpf_kfuncs.h"
> +#include "bpf_tracing_net.h"
> +
> +struct sk_buff *dummy_skb;
> +
> +struct sk_buff *bpf_skb_acquire(struct sk_buff *skb) __ksym;
> +void bpf_skb_release(struct sk_buff *skb) __ksym;
> +void *bpf_cast_to_kern_ctx(void *) __ksym;
> +
> +struct map_value {
> +	int a;
> +	struct sk_buff __kptr *skb;
> +};
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_ARRAY);
> +	__type(key, int);
> +	__type(value, struct map_value);
> +	__uint(max_entries, 16);
> +} skb_map SEC(".maps");
> +
> +__noinline int call_dynptr_skb(struct sk_buff *skb)
> +{
> +	struct bpf_dynptr ptr;
> +
> +	bpf_dynptr_from_skb((struct __sk_buff *)skb, 0, &ptr);
> +
> +	return 0;
> +}
> +
> +__success
> +SEC("tc")
> +int bpf_tc_egress(struct __sk_buff *ctx)
> +{
> +	struct sk_buff *skb;
> +	struct map_value *map_entry;
> +	u32 zero = 0;
> +
> +	call_dynptr_skb((struct sk_buff *)ctx);
> +
> +	map_entry = bpf_map_lookup_elem(&skb_map, &zero);
> +	if (!map_entry)
> +		return TC_ACT_SHOT;
> +
> +	skb = bpf_skb_acquire(bpf_cast_to_kern_ctx(ctx));
> +	if (!skb)
> +		return TC_ACT_SHOT;
> +
> +	skb = bpf_kptr_xchg(&map_entry->skb, skb);
> +	if (skb)
> +		bpf_skb_release(skb);
> +
> +	return TC_ACT_OK;
> +}
> +
> +char LICENSE[] SEC("license") = "GPL";

