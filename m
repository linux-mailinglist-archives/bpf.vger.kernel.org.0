Return-Path: <bpf+bounces-70134-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C51BB190D
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 21:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0A8B194420F
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 19:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E252D7DD7;
	Wed,  1 Oct 2025 19:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K/qOFkvd"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC56417A305;
	Wed,  1 Oct 2025 19:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759345588; cv=fail; b=AKWy7lTk2rPPp5bUkvx15YP8phSl2HWCJ7+lhoTCM6/6Vu4+F97BdTeszOEqdaSi4z3LVT2lp95z87WuqF5/WQVtS+/TMBfhmoCu8vlHPOJRMlHsXVd94P0IyCiZOthTT7FnsnO7BwkBV3ZJdNpMbcRcPgeDAr3SFvj+8ybvjkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759345588; c=relaxed/simple;
	bh=ZKGjao4Cfa1VTI2ffJs40m6XqNUHJHXYRS65ceuPbKk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JMwWZ757VXQbphANsrAaFxDhZyVPC7AktHIz6Nz4sxv0kEydbmeTV9UYP7Ls9+hPThNKGS7F7rzWUnPJMt+4WEMYLN4gMg018iVj6EA8SPD44CvKfQaXMUN3JBZtAa/5lDsZCr6IMbR8mY6tc7DMsw2gPUB+H2GhE8+RxRaq97o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K/qOFkvd; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759345587; x=1790881587;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ZKGjao4Cfa1VTI2ffJs40m6XqNUHJHXYRS65ceuPbKk=;
  b=K/qOFkvdqV2GxnVBMtirMdvuorRKBRlJoYqXmtvGs7/v0dS8Y2sjF/Yv
   q/7+bvraE+0R5Gv6mHQC/dQQlpZ6KEp5bsrlHJ68DYWxPmjsm2k4AqbDU
   4Bdm60BazR/d8PMmZZ598r7+P/V455wd4WEuGUD0WssY2s1raIosxgmJO
   fW2Oqw3cAqB7LYSAkc/uDKC6AOKWU6ygT2mACUAZ+5f+OYbvjN6mnnWiL
   7AV0MDdmS2CdT+1kWYhmkWVzGFS7vyPNNZbDOsqMNw498atMRbZ9ghUP3
   lgGwmWY81neM9eyF3n4O106uUXtG+4iOWego9BESciNChH4bPCmD2NpvE
   Q==;
X-CSE-ConnectionGUID: D0w7B3tNSqC1u7nBAFElvg==
X-CSE-MsgGUID: +XnMu8XzSXuXgbPd2FVESw==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="61732659"
X-IronPort-AV: E=Sophos;i="6.18,307,1751266800"; 
   d="scan'208";a="61732659"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2025 12:06:26 -0700
X-CSE-ConnectionGUID: Hd+lcr1TRC2cUp8xwqK9Eg==
X-CSE-MsgGUID: 8xhEKSq9Rd+zr5AN41uZ1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,307,1751266800"; 
   d="scan'208";a="182897131"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2025 12:06:25 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 1 Oct 2025 12:06:24 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 1 Oct 2025 12:06:24 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.44) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 1 Oct 2025 12:06:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eoaa1Mmt8H7xgeVxf5PaEkUFj4zcBD/AqFW9PeoSdYou9QqshKY9zg2tqs8UbHgSvzpyctc+4cUo/rpVUlnH5f3TUF/kelML4Mj4Tuq6sgV4KTev9KLawQcHjQvZmUC7qOF1Yl34qjIt7x4fwTKfVm7FfzuXY4pr/COD751vv2y1rn+1P1ZGOxpKMy42dgTVz594TgRvSmmnEqlynVF4Nsi5UoRNaLgdERlPZiAku9kZnRkUzyFk3fbklevNPm8gaCx5GQKLzmV3csKYOJOSW4+d2K+D1dawdugQ49SGnJkGX2JEWGX/t+Otv6bzU2aHUsCrKp21eeriiuCXrMOQDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7YzIfBuzGTRzepYkXPapoCc8NKtB56+3ipmkcMcVow8=;
 b=kAQ0fdAOEg8DHREQe62VDuNCE867ple01vAD2oYU4f5ZMyPFG/9HNrPLdkBiee4n6J2r1ZfkqZ4SUZOVY0c3eZpN9Q51xrNVaVvVEVtOmcYnuva0S/8CDuBWfIStmI+ChRHHEprWyeF0lS3TCL3D1M9hOY4fnpg8o8ckW+uYCw8SJkucmtwGPSvQteawSWMFaqiXnh6SdlgIqrWJCMS1llTd1sUy8af2yGdO9S655R89Xdlnixy6Z1rljwyOrV6niKSuQhZolgRKttBi3l1j0UaEONJOBvOCkl9vTd2cCYJ2I2s+eixQ6WsJ5fkFcIpiKEwPFrDnEyRA9hQrR3zt9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DS0PR11MB7804.namprd11.prod.outlook.com (2603:10b6:8:f3::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.17; Wed, 1 Oct 2025 19:06:21 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.9160.017; Wed, 1 Oct 2025
 19:06:21 +0000
Date: Wed, 1 Oct 2025 21:06:13 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Octavian Purdila <tavip@google.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <pabeni@redhat.com>, <horms@kernel.org>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <hawk@kernel.org>,
	<john.fastabend@gmail.com>, <sdf@fomichev.me>, <kuniyu@google.com>,
	<aleksander.lobakin@intel.com>, <toke@redhat.com>, <lorenzo@kernel.org>,
	<netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com>
Subject: Re: [PATCH net v2] xdp: update mem type when page pool is used for
 generic XDP
Message-ID: <aN17pc5/ZBQednNi@boxer>
References: <20251001074704.2817028-1-tavip@google.com>
 <aN091c4VZRtZwZDZ@boxer>
 <20251001082737.23f5037f@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251001082737.23f5037f@kernel.org>
X-ClientProxiedBy: DUZPR01CA0111.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::12) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DS0PR11MB7804:EE_
X-MS-Office365-Filtering-Correlation-Id: 10546da8-23f0-45fb-2c2c-08de011d9b6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZEaOruAGISzDvpeieXJgFKkEDHkTLbE3x3eYcUfxU1hPbnEbHs4g6atrJ1zs?=
 =?us-ascii?Q?/BdWA95C+p/I/FwO3YIsYaR6lToHrRi1VyqSMF9LJzTnjCNXkMDu+5pZhlCE?=
 =?us-ascii?Q?6iwJZXSNZgeNoWxw0D1trxaOCd9CVW36zkd+OoGP1mjDI8LZs5SDMvaIck1C?=
 =?us-ascii?Q?5bsSN0JObp9udMi14WW4CdsbnwTksaAUgjxL6eBEle5bIr8vhdyAQiK2ePFH?=
 =?us-ascii?Q?Vmbwj9VGqGOgOCJIP7GFA2LeJZuRcJabMpFT9U2Nh4XyRUNyorzs44wjye5P?=
 =?us-ascii?Q?IX065buSxUjM66Os3aWBK63mmxIGN1TywFcezCZq7Ek9ubai1bBNbpXbiXSn?=
 =?us-ascii?Q?aYC6z5w5TFCyGRG2+orkK/eW80T88qEEfE0EMDwoFWJzwJMUlnXISVTQIfRq?=
 =?us-ascii?Q?XxvDFnEU8ZNMTXdAZ0qS/2sQinYSw77TIhKh8MrkU249h+KxIpCQx04Z4cst?=
 =?us-ascii?Q?4LcIkIkV7n6MFt8eQFNqgNUBigHtdo2gklNhrsdN/DiX2q+KNJuE3LYFpB2U?=
 =?us-ascii?Q?QFutGuMGCIZB8dvB60dteg1vhb8a6kHr1855dJ7Y2Ulb9nEVilu4Rj2HLK15?=
 =?us-ascii?Q?vGZouLX432Ve7K7WtlRPMYdt5nWA5jJJUrW3KDuhZ6ZhOXYYs4OT3A0HIYp4?=
 =?us-ascii?Q?Lcz4pP3lM+zfGg4ezpsuwT/4rkHWgxfHc896ExyrZdJGoKSBXjAY1GfNN/nx?=
 =?us-ascii?Q?LhGMQME9dupZsDjrXfoLLyaGIg1/n1KaPrnB/lGMvXmCNZ8OkbdJcxICE27R?=
 =?us-ascii?Q?RzSzQy9ojjyUspg9S/P3lMidaWPF1ufFK4C729xT6XHyVxP54JCRC9HzYKWS?=
 =?us-ascii?Q?lUDEP3iKl1ctN2ylsSEpFyistVdsWtl/oNQifXovFTq1BmgVa0fAeTnnoqTD?=
 =?us-ascii?Q?8+EPxVHnG3ILu6LTuD9LZ6jCYokQjrmJOdXW9Gd87owf+vAopjCNZ7PLZ1mH?=
 =?us-ascii?Q?Z4m87Dd+zplQDR026KEzzBWfFd7vOFdIQS6tpoJGwg5X8p+yQitq1UbwV2c1?=
 =?us-ascii?Q?Gk5USrrvvlofETFpemvxWCaZU/r1kZbcODrRPTSpEKHE77N0xt+lajgJXEID?=
 =?us-ascii?Q?hdo8HWHl3sQ0p1Clvo0AcEitABb98rRj7bsLjwOkXHFhm76YrBRndYDf0CKr?=
 =?us-ascii?Q?F+sJm7brcc63SJxIlZz78/hQrhQVmx3t70HcW4TOG9RjmALSiVK+Qz6Wmy64?=
 =?us-ascii?Q?U4q61oJ/ncVPR3iumV1d7hlT/7ZCXUQKNjp8X4oKsTs5KeSjIW5ulxFp8nUm?=
 =?us-ascii?Q?gu0KiOqi/RTuyLk9WR8yaGaNRlzR+8yl0gcdgO0uDUHjdmOCh5eA+lqF2EyW?=
 =?us-ascii?Q?Qoyw8ZxaiE4HDh5aO92DvHEXdp9a8oxqMY1dq9mjebXhimeFftMf3DSUCGaw?=
 =?us-ascii?Q?n7QX6g4Se2sCupf0RQvud1F7fpTRddknTpN+notYBbgQPh3WEoZUNF04WNMS?=
 =?us-ascii?Q?+1vjnS2vj5ZMInVfTUlmeGGYvzl0f/SM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ydxPQc4gUFhJ/MEnoTXhFsq7F7uOkeaizlqywUYaerVczTdj8X9NKTl79St5?=
 =?us-ascii?Q?NMMZHeL+mrkhna6Tf8o90Nj7dpTgxk8MVOcv1kxPkybvqtSVHiQp4qrYMV6Y?=
 =?us-ascii?Q?3cQ2gLkemTm4j401Yq1sIWGBD4PSS1YYrP1F0faN7bTaOg5BNkqjL0wvhvHx?=
 =?us-ascii?Q?svgYb5CQ4eGVZjQGClLaVc9G4Ea4G/vEUioc7ISRirk9yCsIOKF8XKNTHKBj?=
 =?us-ascii?Q?7rmotmR7JeFHUrdg5FJXX2NOCy5HdPHxrGMzVIn6FeJdYYkhU1Jk4CiV+n7K?=
 =?us-ascii?Q?zfE8N/iAcAxhs6dhdp1Z0nzVW0OyxB67SDls+fcm7VSI4ofr221cJgsrh8Yi?=
 =?us-ascii?Q?EPLJbvB/S3ZsCReLKlwqffYUsxsrynfs0cueAGmvgwycCpD/cmU7n7EQkeRP?=
 =?us-ascii?Q?ShOI6we0L0g2TLmwY3UNJxdR2A77hM+vupmP9FLqvrWJNfNQt6GGGYWxw18l?=
 =?us-ascii?Q?4t15K2v3ZSjs72KSstNcFLJS1smEQ/+3V1SvZTFBuGkW6DD7O6ziXSTEgzKD?=
 =?us-ascii?Q?ONKiRPWjsLyiGDT5/Bmju9Yc9vgYTdgBrRqVVQphi93ebABBxeqZq+Ky6ePX?=
 =?us-ascii?Q?PID5e/B8w3Vpr4bCGiG2aYR8sIrjDXsaXBm4u4cyYqhW7H81GDOZFTVY5dIM?=
 =?us-ascii?Q?frrXoCSebMeSSXxBzAqi2MHtUYra1VyczAy28awFMD4cikDARPGmQoF+/P7G?=
 =?us-ascii?Q?BDCCGmCT2iW2XrIdPcKzcSbeoeCqXL8ZsAe8OeQrQgZ8sHi3XekPqmbgkUdC?=
 =?us-ascii?Q?y+PKoGo/W495pI3UqMCNuyYsGLwKVR/82W50uZuByGXFxdOBZgvX48w0RDrS?=
 =?us-ascii?Q?Yu0d0MsSt5ucCOJaD0YPavhqMRpwhM3jWpEfWvBWhP60IXRoH2qfLJHh2RpG?=
 =?us-ascii?Q?EYgKa1jxZhoz94qvuYa8c/0iq7Z4fjEnZdNMkZS0Xzm9JvmmgoynjhhqJmOz?=
 =?us-ascii?Q?DUWTXPR15JeHRM1NwABwqx+mOVFOCsbMZrJ2FjMMB6G6mmUt7YG7hXHa0qKk?=
 =?us-ascii?Q?sdpv85DQBykfHn2y3MCqAPXztb5osAllNW79r/qeW/zZWZbipK/zVwiATXli?=
 =?us-ascii?Q?AfMlcHBCflSt5AoGGnaBR0aBs61aKnXwqQD9VfS8CtRpU8oypoYZjF6/5+LC?=
 =?us-ascii?Q?6enabh+9vaHfhPK8YAmBu3ypBPwDWBuLzerotdDXwsPu7Y+a+CleXmLEp2iO?=
 =?us-ascii?Q?7qhZcwpBIHYZUQCjZQE0vuRQKdTh9Rcfc3MDm8caklpwe1AT37G7HzG3XMGu?=
 =?us-ascii?Q?LoEHrV0909iQDBWgp7DeYA9ebWJ/9pnOY0QSaBEdqCaVMjd3a2wZlJ4zJwJD?=
 =?us-ascii?Q?Yjak1U4Is4AsG5XHXRcn+pNTRO49wgMAZM00h+s5YsDe/gkkExoxGZ5MnRXi?=
 =?us-ascii?Q?ekt8ZCsq4mbX6aMM6aIZtbRUkJ5rvYOlBPcu8NKbJgpEEwtcppBqyTtmgaIM?=
 =?us-ascii?Q?4zBhMzrGnLbaO0ClN4/ebx+mBp4KBdDU4PcfF7BmSm2NLNpiqImOLGsce8Tk?=
 =?us-ascii?Q?Zjh+RZEZCrObqasZIDB7Z3YiFSEYEohwR5cHxAO3oF8ttq6AmFMrN60pebV4?=
 =?us-ascii?Q?k5VW4ievMQl+BPM+/R8XEuYFrBnj3R5o5S5KwZF+sFMbItHiOIFvm7YTmERo?=
 =?us-ascii?Q?Xg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 10546da8-23f0-45fb-2c2c-08de011d9b6e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 19:06:20.9661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: agMx72wdFUSBayEhIvbAX0HxGAC69TSsXoSlDxHAQ7TJVgTqOFfY0FwNTf3AyYEFuEHY10rNKGNk3OItzoXD11PwqP1E70m9fvIMiP3PDKg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7804
X-OriginatorOrg: intel.com

On Wed, Oct 01, 2025 at 08:27:37AM -0700, Jakub Kicinski wrote:
> On Wed, 1 Oct 2025 16:42:29 +0200 Maciej Fijalkowski wrote:
> > Here we piggy back on sk_buff::pp_recycle setting as it implies underlying
> > memory is backed by page pool.
> 
> skb->pp_recycle means that if the pages of the skb came from a pp then
> the skb is holding a pp reference not a full page reference on those
> pages. It does not mean that all pages of an skb came from pp.
> In practice it may be equivalent, especially here. But I'm slightly
> worried that checking pp_recycle will lead to confusion..

Mmm ok - maybe that's safer and straight-forward?

diff --git a/net/core/dev.c b/net/core/dev.c
index 93a25d87b86b..7707a95ca8ed 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5269,6 +5269,9 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
 	orig_bcast = is_multicast_ether_addr_64bits(eth->h_dest);
 	orig_eth_type = eth->h_proto;
 
+	xdp->rxq->mem.type = page_pool_page_is_pp(virt_to_page(xdp->data)) ?
+		MEM_TYPE_PAGE_POOL : MEM_TYPE_PAGE_SHARED;
+
 	act = bpf_prog_run_xdp(xdp_prog, xdp);
 
 	/* check if bpf_xdp_adjust_head was used */

As you know we do not have that kind of granularity within xdp_buff where
we could distinguish the memory provider per linear part and each frag...

