Return-Path: <bpf+bounces-65154-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40864B1CDFD
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 22:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD3CD18C6BD4
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 20:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B632BE629;
	Wed,  6 Aug 2025 20:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mAf/J03Q"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDA0225401;
	Wed,  6 Aug 2025 20:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754512992; cv=fail; b=NxeSaDa+LidQpk4TYeXpyeJghQ1WkDLzVpRoLRNldScTehADPvpBQL/dm/jd/ChTlPofBHmwYdUjMF0GI/9ybB4sFPmE0/v16LRYjvQdJ/I03LQnzjBLRv0FgVXyDtnDv8/8Uk0yzON7PAIBZ55LLUv2tQzUJkLVNQhiuPSI5QE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754512992; c=relaxed/simple;
	bh=l35csp/8VDlOJPiqspdEbZqnwOEJdZlvXqAVcWtvEoQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FMX/mvLdkImP73btSyECMb+mo+lqtYzIJeJ/lIaBPQL7vBGVpLFXal9fjA4IFP3M7ZjX6GYII+rh//elRrHnZVEbXF7eePoSFq685o+YNqMMhrvQLc4j6/YPl4oDozfv/mJ+9qo5I/5/A5SRgNe5BPxFTugaf/ezwku0VrIZvLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mAf/J03Q; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754512990; x=1786048990;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=l35csp/8VDlOJPiqspdEbZqnwOEJdZlvXqAVcWtvEoQ=;
  b=mAf/J03Quy0xC4a/mA28pl3nFSca48IV+xCFk7iuNOwoiaOCarMOalgC
   9bXNHV+3KQCGyvPl4W4+tLF92EBRqt3X3buwGsi9DHDJ1/qgPNIf4RztA
   wfSwT3jGLLVbR8f12abjvQePAp38kAIMFupNrmplr6oNBFNTCYPlOQTK0
   mbkLJ6VpVzR1bDE79WuFSkZyWLz+77FQe/djSA5v9e+nf8Tab8ETASiiR
   T1O/b/jFTTIFr1DMrqfwMqp7s5iBPAldS9FwTK83ZyzWey+PvMFUkl9fG
   zET5uE/wmwzoEbAvr5JuuZ0sSX888BjIdi4KtqzD4JQ9DX49x6g5Ia850
   Q==;
X-CSE-ConnectionGUID: 1YLRijpRTKm++vNe9yhkPw==
X-CSE-MsgGUID: SYeDN5OmRFO4VTg5hFzm5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="44434915"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="44434915"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 13:43:10 -0700
X-CSE-ConnectionGUID: ajBUjbp7S9OsnRLSBE8ajw==
X-CSE-MsgGUID: wpcKehcDQfmPSvlJLcvQCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="165208085"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 13:43:10 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 6 Aug 2025 13:43:09 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 6 Aug 2025 13:43:09 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.65)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 6 Aug 2025 13:43:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wUeNpfnPtz9ko/o4gzTKzcDNS5T/lo6zSe9b/8ORCCmCXQAnXxzeHETHp4DIBooPljSkSKhqH1dw5QfHuOkUlqa3Pr6bp4GKqALrmjcA/0sSEXPYVF0J+X/zXzPQri74y1V7xDTDgUwMVH5WPbKab8cF6bNl5hgugjo5QBuoaXYYI8urPx2syqnxW2tO7U3dEMwqOWro70UA76dEIupRwZWk+UMzmNYU66sxWjkFKKc1C/HwTmzRA03SXVLNhg6IjoxGSgngnhec5mkptEO9crBH5cu3+FMZj2NgtePB5uGRRrxnawgF2jVfnr6w6futBCtCsQbrHe87uSai6o/EzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LvpNgB7LTEVEUEOP3ZGz0LM2DYFmU+nD2o9leE8WVfg=;
 b=On5P15ZExHNesWKdPP0QLkLxbBm2C+VLMI5yOYAQU8clByzB8zcNxqeX3jmOIYPoPw+umtAj3OB/Wnxyca/wGRSYdGuD8ymNWZeg+UpOErYGmuXiEafLgp6URekvZZc7PaVO69cHLe09+maNC8D9sJ0F7CQEMlBlJtleEMcRwFjZkZ8RXqUZ/deZF8cAJr1yptAH+YtkMcbg5UNj+JQR7OY9mH43Teu84ejjpvCI9xalpzFECV/BtML2rAkiusUcoaQ+kcSEqSeJq28PsP17FiMdO3yV5TcMre5I/0JTZdGZk/dQ/cmUBbU+ii2v2No4r7A1KuwYVbsJWMiYZdMYVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DS0PR11MB7505.namprd11.prod.outlook.com (2603:10b6:8:153::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.13; Wed, 6 Aug 2025 20:43:04 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 20:43:04 +0000
Date: Wed, 6 Aug 2025 22:42:58 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Stanislav Fomichev <stfomichev@gmail.com>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <netdev@vger.kernel.org>, <magnus.karlsson@intel.com>,
	<aleksander.lobakin@intel.com>, Eryk Kubanski
	<e.kubanski@partner.samsung.com>
Subject: Re: [PATCH v3 bpf] xsk: fix immature cq descriptor production
Message-ID: <aJO+Uq6qNMqTsgtI@boxer>
References: <20250806154127.2161434-1-maciej.fijalkowski@intel.com>
 <aJOGSRsXic53tkH7@mini-arch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aJOGSRsXic53tkH7@mini-arch>
X-ClientProxiedBy: DU2P250CA0027.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:231::32) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DS0PR11MB7505:EE_
X-MS-Office365-Filtering-Correlation-Id: ff8c1c1c-6bf2-4dec-efe5-08ddd529d72e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Y6tO81XifN6hOQnhrHUjjTwbR3Lgk6Rh0uBi+Yyv2yWdRUxobvM1LCwxuBTv?=
 =?us-ascii?Q?pyrI5vYq2a8Lm73cuD19r4AIE1ollDfYvsrVUEstOm5cfMHBwv3khrMID9/Z?=
 =?us-ascii?Q?iKtrgGQz0DtTcfLAE/ByoPyTxoXJTycx8deEG/0yE+JcEQqqdvoO1cQ97kt8?=
 =?us-ascii?Q?VwQgUkXj/ixeV5hnI5gWkLhbPmArygMYuREO0Ac3iJCnw37T1fEDowXd/4l4?=
 =?us-ascii?Q?lz2vYyWgZTGd2pkaQBRRL+YkYYX6v4O3WJ7m7yE1T5SiwGEf58QwDUzGM5uN?=
 =?us-ascii?Q?XZHCxddmBcOtHd433+aoAC7Py0bqaWhKpTzN858Q2IdxoyB9G67AMJ+qekWh?=
 =?us-ascii?Q?fIQ7W9AK6ivf1A59QpBMfDUhfHtWM0+gTbSFX6LHFN6IjAFLhuCeaD47J4pk?=
 =?us-ascii?Q?500mRjPVc5miQh+sKQB5EmgmP3NiT4x647Asn+gAw4KUGTy0N1D9PtU10BbC?=
 =?us-ascii?Q?d8NdCeawUiDpFPA1FDbb9nM6FIQCPaE+o1MrRCP+04pAxXMR4BBZXWTAwVsE?=
 =?us-ascii?Q?8uRVzRe0XPoz37fPhqZuA7MOyPFa6cleA1PppRRR4ahJHfmQMe0D8e5PbiEs?=
 =?us-ascii?Q?Delh/e1gCDJWgeInldbRwKWCAYDrPG1OOpxRgO1QWuJh/GClZZBDuHbgdQOa?=
 =?us-ascii?Q?XJngoNfpP2QDhXOw3LhRTcHKXogEdehKcp8TpsVeUw/cFzRY+Hu9fmkf8hw9?=
 =?us-ascii?Q?AZzw7TeVDZ1joZZUBQ/P1L8X7ccsycAVe8Iebbot37ZBOw4VySwa9rRmBFxq?=
 =?us-ascii?Q?zhqYdPkEvm+kGTjou1VZJbfubito31n9UNCUugTq+R81UgC+oNhDvQJeYJ01?=
 =?us-ascii?Q?KwbV8WuFMeyRgrHAQ4DgOJ42355Yc4yv5syRtg7qzHOmBjW4PXccWmDXGxLZ?=
 =?us-ascii?Q?7aCD3oRAl+n6/AtjCIs39+AA7fZMNvDbSh0synM3TnfYx3t0u1wwCrlgZdja?=
 =?us-ascii?Q?HOVVOrCP6Hv5iQBE4A58iF/vGm2l4bADvGrVTCxW+cNUQmncglF5IK78vLvb?=
 =?us-ascii?Q?KGOS3VW193g1Ey/wTKxc0ao8bJprLCJp04UwbCkS19yXmPUjNxcdluTAMtXY?=
 =?us-ascii?Q?bxUNI/eCDq/URec3Nwoad3NOcpxYEMLVgReuHP4uvW1zF5UTvf2mo55oM3Jl?=
 =?us-ascii?Q?5InZHzmFDG5ytPnyE/Eyz0vgl3I8PeaGmCWAujRhIy9ORX0XsNGtE1QDF0pl?=
 =?us-ascii?Q?FBaoa4RLOIkShWhc5jct2pan7w7QGN7cVhm5BVmtPt7VIXuDy204wGhtcA2y?=
 =?us-ascii?Q?daDrCeTYJHjxE2Mlbvm8mhtfWRmcLaqLp5kvj0vxXWyT2JqJdZRKLiD+Ufzu?=
 =?us-ascii?Q?GBf7RHlltpJ3SVo/LCe5aB+GOsPsHkl+Dkjx6A0Yf1VBzvPIhO91xMm7R+6I?=
 =?us-ascii?Q?OlbBn26xQJoSclJpNjWOF6Qhqj2MPZDy30rEnsEfSMGCPpmbBc0+EX7nFPI0?=
 =?us-ascii?Q?4egadGSmFmE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ji7FMvYUJHHC09l385+4gT92kxuZnlKH4CZjSyhTH1hpBedq8Ogu43JNOSIT?=
 =?us-ascii?Q?6+Ujp7p3TaP9WrRoE199IjPS9SnMC+9iktBLMRjXID2HT5xE8Qc90Hj8iFCD?=
 =?us-ascii?Q?8NLgO4IzMB3DtnBy7P8r3LoMrh23FSiHxbA+sLidrAJW5JcjlfIE+2iyHK4I?=
 =?us-ascii?Q?R27UKBgOjDf927H78BhTeUiLw4YGTV6vW8vTV1pRP9esaW7FM3KFwccIBoNh?=
 =?us-ascii?Q?RGJR07ByAAi+LrKCznxNK9wiJL9XLnoyrl4fltqNss8Koz9h+VCs6WNFeMqG?=
 =?us-ascii?Q?ab9MvJX6m/S1ZfifqDWpUoVxkj0O//IoAvFFJmi2eaQ22KwXJsMGE0A9mWsX?=
 =?us-ascii?Q?mMClGlGXonRNa9BZJ1grvr41qpVUzWCoJWv+Z9m+fBwVmv+FLg/kYHXqE77w?=
 =?us-ascii?Q?NJEKzE1skT2wu8DDj1qktPMBPFLh6x/fMXLxf1bdoFuQtRbuv2GBEldYTuPW?=
 =?us-ascii?Q?JE5EGpJqgST5mxYCQNaBV9GboQtEseWmBM9l5pXKW4OPtF/8KOi4ALat3N5L?=
 =?us-ascii?Q?5AKghEewmzaZWTmRZLtmDQSFFrAn9J0yr6UK/KD1prTck1D93uyvjYterbFw?=
 =?us-ascii?Q?mYlC14Z0SZyBp9JFXj1L0vLD4beQY4b5J0C/dyuNha2qZ8dLjG3WmBVx629i?=
 =?us-ascii?Q?+x+0Nig/YAAwW4L3VEoGiMoulUrHsUnsc13LPh30N+2fMgOTb6Yn2W42qQ0r?=
 =?us-ascii?Q?Yiy693Hrll77NLhBWUGn7nA/uCHBnG+GyJHUkujR33x1Y6m6GZ68I9uqXgRk?=
 =?us-ascii?Q?4rxPK0pWhj9Sm/wHRXbuqiPKGO2oe1hU0IIQBCBSUIk0CzBO6IFfKxBaz4mT?=
 =?us-ascii?Q?lQK3ovmn+XjipQ4L3fCxAWuPnCuP3Dovw+6d/MOnCKkG73iELiTvkpnd+7cp?=
 =?us-ascii?Q?7P8kXcQ7FqdTY28ZuziBfWAxd229zbk/a5h22eIQKSdM4EU8J5CR6IN0wOqX?=
 =?us-ascii?Q?DTsUNSnXMNhxyS41ZQLQf9u4Si4Z4NKSupoLFo/teMRzQ3H6W7yk3efJuDGv?=
 =?us-ascii?Q?ejQxNZQzMbb7wnYAzfcmm77Cc7CYbabxSb0zGU50AeX8GsGORHV+nXoDqHR9?=
 =?us-ascii?Q?oEbWzk/hsD2/pLQqDB4UzhQNLOmHfQBzE+AzSETbpziiUzd35D7O9ItYFVdb?=
 =?us-ascii?Q?lW5nhG8OYa7Frbg9FAkEfr898zysnyYtQLcBNWPmbC3XkOrnkak25HK9wbRW?=
 =?us-ascii?Q?tEJXrzig9MGVAqQGWUe3kYeGeB2lt3f12YYzKybO+VhfAugm6iWS/ONjJcUg?=
 =?us-ascii?Q?ytbxLH8P3Uzs8BJhCVpTZgo6maZTUV3aOUiJIIB66mOM5/05TQDiFYC0AJ6P?=
 =?us-ascii?Q?C7ytP6mP0fqEmUI/79fQXt9VtgDz3u8E9xSBOpOpm1+t0DIAUYAFdhL2l+XT?=
 =?us-ascii?Q?RV/cbooG+e3ryxE8Y6VJqSkKYVimXlAhu8TzW1F6bal8ZZeJh6Awp5eUkwrx?=
 =?us-ascii?Q?6Ud4u34kIxbAChhDoRip4IIdsuTVbP2qFbgETNMScDl9B9G6X21smbEmazmV?=
 =?us-ascii?Q?PnnDmvspiT2amoS1RvHnbGfPA+wxhB5YmS91e2CXSMQaxmZHBF9znUKAvAeW?=
 =?us-ascii?Q?ciq4Kg+m1CreVQ2tb4S52VWKBCfnObUwqwfvlN08adkgsPjcpkFpQqeyq5c2?=
 =?us-ascii?Q?Gg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ff8c1c1c-6bf2-4dec-efe5-08ddd529d72e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 20:43:04.4788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aj6AGFxvCW2Te89iBVCxpY58q+ow+NHC539PT/z7yX9gizWaF6Wi5/y9WPNemEjG404SjYFUvPzrshmO8tNsAvtAMozveCRwGivpDcs3f8M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7505
X-OriginatorOrg: intel.com

On Wed, Aug 06, 2025 at 09:43:53AM -0700, Stanislav Fomichev wrote:
> On 08/06, Maciej Fijalkowski wrote:
> > Eryk reported an issue that I have put under Closes: tag, related to
> > umem addrs being prematurely produced onto pool's completion queue.
> > Let us make the skb's destructor responsible for producing all addrs
> > that given skb used.
> > 
> > Introduce struct xsk_addrs which will carry descriptor count with array
> > of addresses taken from processed descriptors that will be carried via
> > skb_shared_info::destructor_arg. This way we can refer to it within
> > xsk_destruct_skb(). In order to mitigate the overhead that will be
> > coming from memory allocations, let us introduce kmem_cache of xsk_addrs
> > onto xdp_sock. Utilize the existing struct hole in xdp_sock for that.
> > 
> > Commit from fixes tag introduced the buggy behavior, it was not broken
> > from day 1, but rather when xsk multi-buffer got introduced.
> > 
> > Fixes: b7f72a30e9ac ("xsk: introduce wrappers and helpers for supporting multi-buffer in Tx path")
> > Reported-by: Eryk Kubanski <e.kubanski@partner.samsung.com>
> > Closes: https://lore.kernel.org/netdev/20250530103456.53564-1-e.kubanski@partner.samsung.com/
> > Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > ---
> > v1:
> > https://lore.kernel.org/bpf/20250702101648.1942562-1-maciej.fijalkowski@intel.com/
> > v2:
> > https://lore.kernel.org/bpf/20250705135512.1963216-1-maciej.fijalkowski@intel.com/
> > 
> > v1->v2:
> > * store addrs in array carried via destructor_arg instead having them
> >   stored in skb headroom; cleaner and less hacky approach;
> > v2->v3:
> > * use kmem_cache for xsk_addrs allocation (Stan/Olek)
> > * set err when xsk_addrs allocation fails (Dan)
> > * change xsk_addrs layout to avoid holes
> > * free xsk_addrs on error path
> > * rebase
> > ---
> >  include/net/xdp_sock.h |  1 +
> >  net/xdp/xsk.c          | 94 ++++++++++++++++++++++++++++++++++--------
> >  net/xdp/xsk_queue.h    | 12 ++++++
> >  3 files changed, 89 insertions(+), 18 deletions(-)
> > 
> > diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> > index ce587a225661..5ba9ad4c110f 100644
> > --- a/include/net/xdp_sock.h
> > +++ b/include/net/xdp_sock.h
> > @@ -61,6 +61,7 @@ struct xdp_sock {
> >  		XSK_BOUND,
> >  		XSK_UNBOUND,
> >  	} state;
> > +	struct kmem_cache *xsk_addrs_cache;
> >  
> >  	struct xsk_queue *tx ____cacheline_aligned_in_smp;
> >  	struct list_head tx_list;
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index 9c3acecc14b1..d77cde0131be 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> > @@ -36,6 +36,11 @@
> >  #define TX_BATCH_SIZE 32
> >  #define MAX_PER_SOCKET_BUDGET 32
> >  
> > +struct xsk_addrs {
> > +	u64 addrs[MAX_SKB_FRAGS + 1];
> > +	u32 num_descs;
> > +};
> > +
> >  void xsk_set_rx_need_wakeup(struct xsk_buff_pool *pool)
> >  {
> >  	if (pool->cached_need_wakeup & XDP_WAKEUP_RX)
> > @@ -532,25 +537,39 @@ static int xsk_wakeup(struct xdp_sock *xs, u8 flags)
> >  	return dev->netdev_ops->ndo_xsk_wakeup(dev, xs->queue_id, flags);
> >  }
> >  
> > -static int xsk_cq_reserve_addr_locked(struct xsk_buff_pool *pool, u64 addr)
> > +static int xsk_cq_reserve_locked(struct xsk_buff_pool *pool)
> >  {
> >  	unsigned long flags;
> >  	int ret;
> >  
> >  	spin_lock_irqsave(&pool->cq_lock, flags);
> > -	ret = xskq_prod_reserve_addr(pool->cq, addr);
> > +	ret = xskq_prod_reserve(pool->cq);
> >  	spin_unlock_irqrestore(&pool->cq_lock, flags);
> >  
> >  	return ret;
> >  }
> >  
> > -static void xsk_cq_submit_locked(struct xsk_buff_pool *pool, u32 n)
> > +static void xsk_cq_submit_addr_locked(struct xdp_sock *xs,
> > +				      struct sk_buff *skb)
> >  {
> > +	struct xsk_buff_pool *pool = xs->pool;
> > +	struct xsk_addrs *xsk_addrs;
> >  	unsigned long flags;
> > +	u32 num_desc, i;
> > +	u32 idx;
> > +
> > +	xsk_addrs = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
> > +	num_desc = xsk_addrs->num_descs;
> >  
> >  	spin_lock_irqsave(&pool->cq_lock, flags);
> > -	xskq_prod_submit_n(pool->cq, n);
> > +	idx = xskq_get_prod(pool->cq);
> > +
> > +	for (i = 0; i < num_desc; i++, idx++)
> > +		xskq_prod_write_addr(pool->cq, idx, xsk_addrs->addrs[i]);
> 
> optional nit: maybe do xskq_prod_write_addr(, idx+i, ) instead of 'idx++'
> in the loop? I got a bit confused here until I spotted that idx++..
> But up to you, feel free to ignore, maybe it's just me.
> 
> > +	xskq_prod_submit_n(pool->cq, num_desc);
> > +
> >  	spin_unlock_irqrestore(&pool->cq_lock, flags);
> > +	kmem_cache_free(xs->xsk_addrs_cache, xsk_addrs);
> >  }
> >  
> >  static void xsk_cq_cancel_locked(struct xsk_buff_pool *pool, u32 n)
> > @@ -562,35 +581,45 @@ static void xsk_cq_cancel_locked(struct xsk_buff_pool *pool, u32 n)
> >  	spin_unlock_irqrestore(&pool->cq_lock, flags);
> >  }
> >  
> > -static u32 xsk_get_num_desc(struct sk_buff *skb)
> > -{
> > -	return skb ? (long)skb_shinfo(skb)->destructor_arg : 0;
> > -}
> > -
> >  static void xsk_destruct_skb(struct sk_buff *skb)
> >  {
> >  	struct xsk_tx_metadata_compl *compl = &skb_shinfo(skb)->xsk_meta;
> >  
> 
> [..]
> 
> > -	if (compl->tx_timestamp) {
> > +	if (compl->tx_timestamp)
> >  		/* sw completion timestamp, not a real one */
> >  		*compl->tx_timestamp = ktime_get_tai_fast_ns();
> > -	}
> 
> Seems to be unrelated, can probably drop if you happen to respin?
> 
> > -	xsk_cq_submit_locked(xdp_sk(skb->sk)->pool, xsk_get_num_desc(skb));
> > +	xsk_cq_submit_addr_locked(xdp_sk(skb->sk), skb);
> >  	sock_wfree(skb);
> >  }
> >  
> > -static void xsk_set_destructor_arg(struct sk_buff *skb)
> > +static u32 xsk_get_num_desc(struct sk_buff *skb)
> > +{
> > +	struct xsk_addrs *addrs;
> > +
> > +	addrs = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
> > +	return addrs->num_descs;
> > +}
> > +
> > +static void xsk_set_destructor_arg(struct sk_buff *skb, struct xsk_addrs *addrs)
> >  {
> > -	long num = xsk_get_num_desc(xdp_sk(skb->sk)->skb) + 1;
> > +	skb_shinfo(skb)->destructor_arg = (void *)addrs;
> > +}
> > +
> > +static void xsk_inc_skb_descs(struct sk_buff *skb)
> > +{
> > +	struct xsk_addrs *addrs;
> >  
> > -	skb_shinfo(skb)->destructor_arg = (void *)num;
> > +	addrs = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
> > +	addrs->num_descs++;
> >  }
> >  
> >  static void xsk_consume_skb(struct sk_buff *skb)
> >  {
> >  	struct xdp_sock *xs = xdp_sk(skb->sk);
> >  
> > +	kmem_cache_free(xs->xsk_addrs_cache,
> > +			(struct xsk_addrs *)skb_shinfo(skb)->destructor_arg);
> >  	skb->destructor = sock_wfree;
> >  	xsk_cq_cancel_locked(xs->pool, xsk_get_num_desc(skb));
> >  	/* Free skb without triggering the perf drop trace */
> > @@ -609,6 +638,7 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
> >  {
> >  	struct xsk_buff_pool *pool = xs->pool;
> >  	u32 hr, len, ts, offset, copy, copied;
> > +	struct xsk_addrs *addrs = NULL;
> >  	struct sk_buff *skb = xs->skb;
> >  	struct page *page;
> >  	void *buffer;
> > @@ -623,6 +653,12 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
> >  			return ERR_PTR(err);
> >  
> >  		skb_reserve(skb, hr);
> > +
> > +		addrs = kmem_cache_zalloc(xs->xsk_addrs_cache, GFP_KERNEL);
> > +		if (!addrs)
> > +			return ERR_PTR(-ENOMEM);
> > +
> > +		xsk_set_destructor_arg(skb, addrs);
> >  	}
> >  
> >  	addr = desc->addr;
> > @@ -662,6 +698,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
> >  {
> >  	struct xsk_tx_metadata *meta = NULL;
> >  	struct net_device *dev = xs->dev;
> > +	struct xsk_addrs *addrs = NULL;
> >  	struct sk_buff *skb = xs->skb;
> >  	bool first_frag = false;
> >  	int err;
> > @@ -694,6 +731,15 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
> >  			err = skb_store_bits(skb, 0, buffer, len);
> >  			if (unlikely(err))
> >  				goto free_err;
> > +
> > +			addrs = kmem_cache_zalloc(xs->xsk_addrs_cache, GFP_KERNEL);
> > +			if (!addrs) {
> > +				err = -ENOMEM;
> > +				goto free_err;
> > +			}
> > +
> > +			xsk_set_destructor_arg(skb, addrs);
> > +
> >  		} else {
> >  			int nr_frags = skb_shinfo(skb)->nr_frags;
> >  			struct page *page;
> > @@ -759,7 +805,9 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
> >  	skb->mark = READ_ONCE(xs->sk.sk_mark);
> >  	skb->destructor = xsk_destruct_skb;
> >  	xsk_tx_metadata_to_compl(meta, &skb_shinfo(skb)->xsk_meta);
> > -	xsk_set_destructor_arg(skb);
> > +
> > +	addrs = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
> > +	addrs->addrs[addrs->num_descs++] = desc->addr;
> >  
> >  	return skb;
> >  
> > @@ -769,7 +817,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
> >  
> >  	if (err == -EOVERFLOW) {
> >  		/* Drop the packet */
> > -		xsk_set_destructor_arg(xs->skb);
> > +		xsk_inc_skb_descs(xs->skb);
> >  		xsk_drop_skb(xs->skb);
> >  		xskq_cons_release(xs->tx);
> >  	} else {
> > @@ -812,7 +860,7 @@ static int __xsk_generic_xmit(struct sock *sk)
> >  		 * if there is space in it. This avoids having to implement
> >  		 * any buffering in the Tx path.
> >  		 */
> > -		err = xsk_cq_reserve_addr_locked(xs->pool, desc.addr);
> > +		err = xsk_cq_reserve_locked(xs->pool);
> >  		if (err) {
> >  			err = -EAGAIN;
> >  			goto out;
> > @@ -1122,6 +1170,7 @@ static int xsk_release(struct socket *sock)
> >  	xskq_destroy(xs->tx);
> >  	xskq_destroy(xs->fq_tmp);
> >  	xskq_destroy(xs->cq_tmp);
> > +	kmem_cache_destroy(xs->xsk_addrs_cache);
> >  
> >  	sock_orphan(sk);
> >  	sock->sk = NULL;
> > @@ -1765,6 +1814,15 @@ static int xsk_create(struct net *net, struct socket *sock, int protocol,
> >  
> >  	sock_prot_inuse_add(net, &xsk_proto, 1);
> >  
> 
> [..]
> 
> > +	xs->xsk_addrs_cache = kmem_cache_create("xsk_generic_xmit_cache",
> > +						sizeof(struct xsk_addrs), 0,
> > +						SLAB_HWCACHE_ALIGN, NULL);
> > +
> > +	if (!xs->xsk_addrs_cache) {
> > +		sk_free(sk);
> > +		return -ENOMEM;
> > +	}
> 
> Should we move this up to happen before sk_add_node_rcu? Otherwise we
> also have to do sk_del_node_init_rcu on !xs->xsk_addrs_cache here?
> 
> Btw, alternatively, why not make this happen at bind time when we know
> whether the socket is gonna be copy or zc? And do it only for the copy
> mode?

thanks for quick review Stan. makes sense to do it for copy mode only.
i'll send next revision tomorrow.

Maciej

