Return-Path: <bpf+bounces-73003-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A45C7C1FF4E
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 13:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 367A119C28B5
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 12:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3CB2C15A8;
	Thu, 30 Oct 2025 12:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Iu4Lu+as"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52BD4964F;
	Thu, 30 Oct 2025 12:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761826537; cv=fail; b=hNFZbNZidlZ9xKGQwIzXc0K/qvNALp4SZh4qDk7K8/Wh9MuuvPpnkCB5+K+/zEcPbXDqJyhI4slRfgvjjDnWK1SvXreVmUmctakvPY41mLS2YsxVBrNX0fJiO/QYmRy+MqA9p4sov/bwqbs2vt+68GtlhwAycqVQvnmlhJ7zHl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761826537; c=relaxed/simple;
	bh=Dd7/lTV+T61l0DAvRGmHskgmVHcLatd20bwai+x74J4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bPEHmceS3PPt+tPxggTzQgL75vWvZ6/cOwSduZ6kF4ezmIZu/EetdjR27WbJYFHMtcJWHE81mrEW5QVdcvAawdOwvbDwUDlHB5fWuIdMsuHGMVCGqs3ilBkJC+77owYA9b7ncczZsBdXLTE/0mTQv7TSf1znp0OH4Lu99Ng2S+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Iu4Lu+as; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761826535; x=1793362535;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Dd7/lTV+T61l0DAvRGmHskgmVHcLatd20bwai+x74J4=;
  b=Iu4Lu+as6HqzgmkE5DOGxLbFBm1W2CwtDkJdx/I1Fjseite0N78TOLOP
   yF3P85Vw3AykKi70vgFSV8HfGlRnXJwdJAzaKd37MS2G7nEvuNzDERmd0
   gBNCZVmi5IxSJEFOvxg4ipXv4n73Ig3ICX8yztQtn/Bjq1HtDsaco3LtD
   9enRRMukZ502UCny4IHhP7E6ev15uC/HtHJASVImm3TNCxqD/1fAHJoUD
   x0WAhyiriox8PEBqVM75XdC9Yt1WKYFom9mBkANyA2EIcrkPmYGU+DXcO
   rEm3EstdBD4bSLJqbCY3BGPJTfQ2pXSXKIY4oubOcoF8n40qgFZt6IOZZ
   w==;
X-CSE-ConnectionGUID: OjsTHc9wRP2vE4KUZSfcUQ==
X-CSE-MsgGUID: /F07l5Q0QB+zs2n/yc9Ltg==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="64062050"
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="64062050"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 05:15:35 -0700
X-CSE-ConnectionGUID: V/VtSNQtQeqJQG/6vi4ZvA==
X-CSE-MsgGUID: /ltYDYcMQZabhgzMrKASsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="190276437"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 05:15:34 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 30 Oct 2025 05:15:34 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 30 Oct 2025 05:15:34 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.28) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 30 Oct 2025 05:15:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BxBZqrHESlnUfsu4ZCP+CKCFVyWX9uLELIq9KDiRZESb528bDeBTl3JsVkssj3v0PY+PRmxySjGYL25z/KmgmcK+pzaT6ls1zk3FcmUDUTccPXH38BhYF1TRv5zKtpps5+Po9dxECMZ4FTatDgrbKH3RX8OA4prgz+5IUT8FEsuF3UjUab+1+J/Qz4AvAEKonSwdoe3nss/LK8VwcHeua3sz00qZz1Quc6B7NmWul7X/98gkllJub7bpDlpd4dSvjbXMx3/YEz+N47JUZadHYTj7Bu0zY7YiescfbC0ExglqSxGtoCHDvXngHMDDmZ5XKnBvDwyM/lWkghLb2GXXYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QJxCgjDWF5p5Nbh/kNGXTK+eukq1WRYsTW/eeYtUnPk=;
 b=Jcb5cibnhccPWcnyQkT7Wdr8G58gW2DvtAH0Z62aSJOc49qZ3GZ3EEXB0UnrWIMP1AcDdEpGV0DIMrSqJ/GQ3FYV48TG06cdTE9CzJn/Jv39E4illia3HGCeoXzWhcE+rcezFb806bX9pl2L/Kwd7m7pPTb8Z462Xqj5w8RYsFgvwyM5QcmTndtvVc8aUY6qYqO213KAERE1taOrY4ZDb4r599kasFo0OXnKejIqukzNvGaCl2QoJ/A4nT5kHhapLuEoyPUxRHaVfCuO2QEomKwFUC+HpXz/7ZqhgAAvDQhUdkQGzLXVlk/XEXDjtFLLKD2ZTZmNnuSKbFQPlLsm8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7969.namprd11.prod.outlook.com (2603:10b6:8:120::12)
 by CY8PR11MB7169.namprd11.prod.outlook.com (2603:10b6:930:90::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 12:15:31 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::682e:6be3:5d05:3d3d]) by DS0PR11MB7969.namprd11.prod.outlook.com
 ([fe80::682e:6be3:5d05:3d3d%5]) with mapi id 15.20.9275.011; Thu, 30 Oct 2025
 12:15:31 +0000
Date: Thu, 30 Oct 2025 13:14:16 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <netdev@vger.kernel.org>, <magnus.karlsson@intel.com>,
	<aleksander.lobakin@intel.com>, <ilias.apalodimas@linaro.org>,
	<toke@redhat.com>, <lorenzo@kernel.org>,
	<syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com>, Ihor Solodrai
	<ihor.solodrai@linux.dev>, Octavian Purdila <tavip@google.com>
Subject: Re: [PATCH v5 bpf 1/2] xdp: introduce xdp_convert_skb_to_buff()
Message-ID: <aQNWlB5UL+rK8ZE5@boxer>
References: <20251029221315.2694841-1-maciej.fijalkowski@intel.com>
 <20251029221315.2694841-2-maciej.fijalkowski@intel.com>
 <20251029165020.26b5dd90@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251029165020.26b5dd90@kernel.org>
X-ClientProxiedBy: VIZP296CA0021.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:2a8::7) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7969:EE_|CY8PR11MB7169:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cda8da2-5f89-4311-2a4d-08de17ade0ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?n9R3Mkg4an/HMqLXyB8BS+zOvYpnKmOlyr8C6UEMUAVMEKZJzBBUBmiNRQ+T?=
 =?us-ascii?Q?nL6EIwZAYxF6lJzu2p19vWH0H7K4qrhOAGW5TWiC+r3zQjmV3Q2DvMMJ8Jpw?=
 =?us-ascii?Q?eU6vnJcj1PaauC76cpvqlPrz7gbr51oSqc0MjqDuIAjnhDpjYyKU9EAvxwyn?=
 =?us-ascii?Q?vZVZPMW4pxVfNhuiu9/EoIDDEFm6HkLF9lOQWBjV4OaCT88C17xZK6uCgeLH?=
 =?us-ascii?Q?gTz8YPoxeDZldDrHYmd7ecuY6qoai9eOPWQQemreX7vdqEGTBNafKYmvuDLS?=
 =?us-ascii?Q?6ujHTwotej5QHW6GIO4+jQhbikdWbmO1SwZGOwWUYHJtCNb+Nhr7P0rp5s+O?=
 =?us-ascii?Q?ZfiVojkLLTzFKKIR/86kiOaEXLBPSLl0bmjcNDEF9OWlqGhElQbUZ1yAHwxt?=
 =?us-ascii?Q?vLM5Exmwx/vkQnKKGp7jFumjHFS0iGW2nOgwi7UbWl2aC5yKMwBybdrES3JV?=
 =?us-ascii?Q?V3hb0dx9NO1MNYNiu6n4EkILSpZy1Xyc8AegxXBj6B4EibXGdu49F82s1cZk?=
 =?us-ascii?Q?8c77/YfMDGEkMKLGPU9NNPgwBBl+FEtKUtLBlLKOIIXrGxjDHLNr7q8oQzHG?=
 =?us-ascii?Q?3lGTMy+1DQE3/Hmc8yaeg5SUfk0zgt8NnfB7RBcNBZVO7A633nbw7aFxl0WF?=
 =?us-ascii?Q?7ayFOQ9NwJiwfPupgi1YHuGIZZplA1SPBJQtIsOo4KC444PW3gkG3qxPi56W?=
 =?us-ascii?Q?7Jav1rGpzvWILFUQ5IOch/PSYYc5x4bJFdghvaRSPkwuOg3V32qviFcOjVJf?=
 =?us-ascii?Q?LLakCxNj0vOVxhFPk5AOtremdpAHb3IL7V/VvGA0yYL1055mOXVJ/Fg1wzmk?=
 =?us-ascii?Q?WynmctvS+qNwPRl4O/bvm/pfM5cKq7S9dgrHR8S14Ss2LlnfxqOyV5QOYp1s?=
 =?us-ascii?Q?wGbOvJKkcgX5Q2GAwoVMu0tknKRKVt5AkS9oLEIwFpAVaqkdvrkyVSlqQcSW?=
 =?us-ascii?Q?me7BUacdjC82DvvXo1bt9fM+WrL32OBpV/k4LOY335guOgqOO7uMw6ptqaMw?=
 =?us-ascii?Q?i9vDCYE7/e4GBeh+qrwiS1vZVywOK1WF0Nojh5FKcwYNsmxDhnrfyPw2lRvk?=
 =?us-ascii?Q?p13/14Afh/ei6E3iYG0iMqclgP6bAhHlBlmdT3aPllBOj6vclbP63yflRYQR?=
 =?us-ascii?Q?YaIC733a6rabUJTziRx8dHNdnOu6ogAUM8we7yRnNEij5zbMEv1S2qEH4QBO?=
 =?us-ascii?Q?4UIqmQK7TZNdqSKzwDAeQR5bBFB5UWKKSAFToJcTuCu1UiCfcY86PQ7doNzc?=
 =?us-ascii?Q?zhbLZ4enifX87xUgZuc0XX97K+1yP14wxrBwBoQvqidN73wU7tB5GAvVkFJW?=
 =?us-ascii?Q?7yTNZBhFXHtF0akk2udEzy0vUojrpnT3rsoRPTsOmGmNqPrvzVAjX4MxLMNm?=
 =?us-ascii?Q?Qa9B7wDllMCTD2/fs2Ax1H7P0YEsVn9Arkl/vUJB6/yF/5lWNKAX4np1bYm2?=
 =?us-ascii?Q?p7H0rgIc71mP7mLtBlA7biNe5JGK1Otl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7969.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BW6KvriH9NU8SZP2/IA/u4h/n9DAIGOarJWih+U5xtrAsE0xU2gohbH7ZGiO?=
 =?us-ascii?Q?GNyzWl+ItuRunCydau2E8BJRN3vksatpEUVFmzotPYfszOw+Mq6o4yErt7kY?=
 =?us-ascii?Q?iWtnHdScbcGZvvkMCX/ADw/SPUAIiTSNYb8qFR9Nhwb6xB6WsFTVvqhu4EY/?=
 =?us-ascii?Q?ADA25lK0ZrTW1EGjStvB+uKu9/vTGyM+R0DVj/+X1cUu8lfdnJ6mmT710E1y?=
 =?us-ascii?Q?A097lvTipO9xwmW8Lt7fb9MKLW2DX9yDenP1yNAB2AkXCI4U/xAKYuYMGqfE?=
 =?us-ascii?Q?EbF+XPd8Sl5h4v3I6hzw9kn4cfTp4i3a5BR5gbw3EQzQnDAd8JxcRAqbzaQk?=
 =?us-ascii?Q?jC1dwpb+wH9WczEUvtsWcb4LMAJOLRfc6E7O934x7zRXA7uypi5+FXnLD7sp?=
 =?us-ascii?Q?HoHn9Fr8BY8qHV93/7gtq5T0kQ1/1V5scyOFcuk2sY7vmo4ILiTYdZHJVk+v?=
 =?us-ascii?Q?zrsnMg85ecgpsLyPq8hhiudlRsFD9Fp60S4JPQwCHgdWqbOjdII4GforB3eI?=
 =?us-ascii?Q?icfpTGMaDpLyPp74eJk46QgruHyonFP19ZzB/KuF+mr0b+gCmo9eRUNrzuVk?=
 =?us-ascii?Q?tFpMAFGeTTvmmOxVVxxixNRA13UZp1YIUQF9er5afSJBankxJEKpazg2LkCy?=
 =?us-ascii?Q?Qm76MRvrqFmgHjwGUdTJMov2AjU6GtBFiQWJPvbYZQ1RfKvGLVICqV2lF9nB?=
 =?us-ascii?Q?h/yBSQTIjBXMXyMaBhBIt0QhQ5Y6MBu27rbSN7jL/0pkq01gMl2PQuqAZwef?=
 =?us-ascii?Q?0eymjdubS/kYP7z2LwjdCLyOBpazZOKtOGGbvOh+rYZg9V6UIlCIkkAMJFBb?=
 =?us-ascii?Q?QVFXUlUxBZcGcSS9+1EymAHPE7se/+DpN3fDjc7bOkKBN8x7y7QcjWuivh2i?=
 =?us-ascii?Q?XeQvlDUeOIbpTcT34QjzCZCzzBFQDRibxTwwBKCXtvC+fe4jwoWgsH2eSk6D?=
 =?us-ascii?Q?mhopSISVmynVvPe/UZocmvoWA8kJp7CWZZ7s2S9YNonL7CaYBpLfvrBIH0HR?=
 =?us-ascii?Q?donIJ8A2uVxiMGPj5A44HToHiMmTiVYBKYfaChbBnp1ti/AO7LMJIrL12wqR?=
 =?us-ascii?Q?ppE+IDylwvuKzp2vml+9eunECgYwa4djeSHpeTYINXINcPMR79kLrH0cZTQZ?=
 =?us-ascii?Q?A4hyYcLFCVpG8MVFa9LEMXrpgewhLVjCq2opdyTSO03THxLwW+hvCqN0UXcB?=
 =?us-ascii?Q?C30Mbx2lExp0lFcvvQ8W9J6sMKvpcTp1EWxlIBWuFoKeq04Me1RDqJ0T+t5w?=
 =?us-ascii?Q?ZMumvjrOEXRYIMRptvvVKg199Bq/XTesLYI9cpEfwyyT7QwfBis3Kawjmwbh?=
 =?us-ascii?Q?kgil3nAyTZdR8JsTX3Qv5LW5BFDGvT63n7s6lH2CG8tHBNKlX8Lc6XPkfdXn?=
 =?us-ascii?Q?hOKs/ob8UTqX9ZgaNNAIyeOCm46F+aSJNcgE8o0gG7Rkjwdv14MAp3SdJGU9?=
 =?us-ascii?Q?LpT55gQxll2lrTFPwl7ajIXBDf1iF5b6derc9ZTiuhYR20sbmFFKudW9hU2s?=
 =?us-ascii?Q?FTpDeeTrOneHuc7HvB1Tmf0vLp6277K6gXNySvrywxCs18I28o0Y61omhdcv?=
 =?us-ascii?Q?s+TKqy2y7b++j27F1vxeIQMTKdy45lfQROwrejo/FxSYImCBrnzF+JnlFk56?=
 =?us-ascii?Q?FA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cda8da2-5f89-4311-2a4d-08de17ade0ac
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 12:14:30.1080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 17ufWtZ8nNw7HsN0kJYUatLfYYQ+OMhqbXig3zDvKHFh1BSGnC6UbmNYxv44ddeG6EkIdLg1XJkYShVotzDWWex6IU1v1WWzdaIQZSvY4GY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7169
X-OriginatorOrg: intel.com

On Wed, Oct 29, 2025 at 04:50:20PM -0700, Jakub Kicinski wrote:
> On Wed, 29 Oct 2025 23:13:14 +0100 Maciej Fijalkowski wrote:
> > +	xdp->rxq->mem.type = skb->pp_recycle ? MEM_TYPE_PAGE_POOL :
> > +					       MEM_TYPE_PAGE_SHARED;
> 
> You really need to stop sending patches before I had a chance 
> to reply :/ And this is wrong.

Why do you say so?

netif_receive_generic_xdp()
	netif_skb_check_for_xdp()
	skb_cow_data_for_xdp() failed
		go through skb linearize path
			returned skb data is backed by kmalloc, not page_pool,
			means mem type for this particular xdp_buff has to be
			MEM_TYPE_PAGE_SHARED

Are we on the same page now?

> -- 
> pw-bot: cr

