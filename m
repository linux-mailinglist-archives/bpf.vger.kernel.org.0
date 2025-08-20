Return-Path: <bpf+bounces-66084-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E898B2DCBF
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 14:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BEAD17677E
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 12:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0033B31577B;
	Wed, 20 Aug 2025 12:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jnMRiFZ/"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986F22135CE;
	Wed, 20 Aug 2025 12:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755693358; cv=fail; b=V5B4zlSEaI1OEjHs705AnBBJ9FtAwUZux1MTkxe8ObBR4VYA+fzMbuNR/yu7mZX8dR7eNgYLzuZ/T9n12pRFasXsXXbrOWmUrLCt5le5ZuDtMBX908P7pZVs+vCq1ZzslkzjzSi8fi+JCerI4fzL3e/LsQQ8AETPhlkeLXw8lp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755693358; c=relaxed/simple;
	bh=kl2upSdgrMbtXKqjdHYE9Qtg7/JxKhplfrJUX7FP0zQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RhBN2WMM0wI0+i6pqsLsbOUuImdDGhFrmDpDu6qC1gndgZjX/ZzVtY7B5DlQfGShLH4cm5zuE1qu31hwLtHSvzSCBs8BnmEOqueYEM/GSkvA1Aw69jZRAyp6WSwLzrl+mLytJNOpEK2b8kYv4dlS9xPn/q6F7aaW5nRJMvdjV3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jnMRiFZ/; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755693357; x=1787229357;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=kl2upSdgrMbtXKqjdHYE9Qtg7/JxKhplfrJUX7FP0zQ=;
  b=jnMRiFZ/6cHv/sDlBecSxcAz5i1vtLeQ/UH8LDBz7Llzy+cYTuR0pt1m
   R3/u3HepbJ/UKN51z8j67h+MvGRRoOHp3A4l2Zmba2eIszhXR2/1gkfVK
   EfCo1jGoBBuDVPIWIx2WUSf9T9VHMKSf3l0lpgVmL6BFdm92PB48UTpg8
   IyHXWXd+yibKhXVWGUUBhD1OPvZK6IsfkjwsXqMGj5alUd/UtMtxpOVP0
   U2kPR8tOZkCsV57Q5Sx7ta7iKwLN1Oo4pyZiwoCVUe74a8P2bRa+f2pjk
   Pvm+tgjxpDsM3t27K3et21Yb8/RU09wg2xickzypyl9dgzPbGixNe0Wcv
   w==;
X-CSE-ConnectionGUID: aJjU8uJSQ/++5vNbdNGwsw==
X-CSE-MsgGUID: G100mml2SGyrIZjRMxKvvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="58029731"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="58029731"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 05:35:56 -0700
X-CSE-ConnectionGUID: A/6iwRMvTI+QzymHt/wrLg==
X-CSE-MsgGUID: wxjscTlMSNqT/77QMf58sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="167339251"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 05:35:56 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 20 Aug 2025 05:35:55 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 20 Aug 2025 05:35:55 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.46)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 20 Aug 2025 05:35:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UxvMMmmF4lMTL+ftPSIztIlwH+ssSBysHyLksPdOFmr1lshTt3j4Ap4fKTlUPoFyBxKptehmV7N2sUQ9s4w5nxbD+3mhLa+Udx4qyVWMIQS8PzbyLvMPjyatZQCFU1JCiKHT1FV8ui96fNMAtBMIdeqvJiyFjMZ0jjlbUOp9LXQkbk9aQuFZ3ekC34lqrV24MPrPNJWK4iZ3Une7hWuO91+kXd8X71eh+vBkVXSpbfClFukeCv8gZSVCL+tYuAzLKdZFlhRcT9jYt0k743Nw/G50K3a/ePaMR0FptvJjxpmQ+6D64++cxI+cPMIXY9KsL61P/sD026uBvWgpvl5Fgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zkjf4+BdqWFZILa9oDVTSH8RgEYf5P6IHCQcmbrEZJs=;
 b=MoKFdaZMaTlt0ODbDxS6djyDJilBkHYvohGo1Cy6xjmHn2PD+sJkmmjH1nMjUSQJTzG1TyKGvqu7VgWeTBb6dHtjeHMEhGNI/tKovp52lwoh+NfgpBk74oq8NMhk5+qFKlimiEz8zXY9V+pNLFTmi7p0+yYLy+NQRWBoUUlh7Lpabhg5Emet94TybKbMilPLS6wQFO9tqXu56YUW8AE6ikRBiozj9JvvxyeRBsym9dnrXeB5pNf2jFT/WykqxS/fp7ws/OIXX70FsLHnbpxX6wqqOgfPLnxJCtgHRztEsS23tCQ5AYAIJC+8tte3vvEGvn8wPaT1HgEViIgZsFQMLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by DM4PR11MB6430.namprd11.prod.outlook.com (2603:10b6:8:b6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 12:35:53 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::61e9:afe6:c2c0:722]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::61e9:afe6:c2c0:722%3]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 12:35:52 +0000
Date: Wed, 20 Aug 2025 14:35:40 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Stanislav Fomichev <stfomichev@gmail.com>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <netdev@vger.kernel.org>, <magnus.karlsson@intel.com>,
	<aleksander.lobakin@intel.com>, Eryk Kubanski
	<e.kubanski@partner.samsung.com>
Subject: Re: [PATCH v5 bpf] xsk: fix immature cq descriptor production
Message-ID: <aKXBHGPxjpBDKOHq@boxer>
References: <20250819115518.2240942-1-maciej.fijalkowski@intel.com>
 <aKTjACALTDMrzuxJ@mini-arch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aKTjACALTDMrzuxJ@mini-arch>
X-ClientProxiedBy: DB7PR05CA0031.eurprd05.prod.outlook.com
 (2603:10a6:10:36::44) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|DM4PR11MB6430:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fbd56d3-1177-458e-b9ac-08dddfe6194b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0wuTJ8AGg3UrBY9kudPSxwveUN8GGxyHszvhpC+OEQ2Av/MH5Hl13qL0R8uH?=
 =?us-ascii?Q?WjQit8jAxHaz/udkTknu2g/4pMMgcEcSAZgCVxYzRs5KsY3EwSmP1NJ9F1V4?=
 =?us-ascii?Q?2MVzlyMU3wi9DfMkkGvQVGm8gP2rqgrf9YaFveGoq/IYW+crMq9saYRwa0wv?=
 =?us-ascii?Q?q52RxrVpsiYGjQEN3hNeeX5b1b8AStXZG/YtZn0uAY3yN6o2A3av61gxOnps?=
 =?us-ascii?Q?mHgwcHCh40jgzCeOcJEnNPDamIYGNz8Pwoc8fdd9Qoayj0Tygfc56iLO8tm7?=
 =?us-ascii?Q?bfb7AYif179s1Vui4UC9qvnsSdjE7VgsrUYVzRxEQzsd9v9RB45vURWrmOSc?=
 =?us-ascii?Q?MBY6BuhixvBmWjipPmFWxY1mzmrIv/CSio/UpWx+wmsnmP1KoseCgfEGMB3z?=
 =?us-ascii?Q?sdO/o7CHVePO1fkPkg9zUyqhuHbqcsDV8AsbXKzOvkDobZ4IUXP6l5qh5hTr?=
 =?us-ascii?Q?d1VsVNDgiO+3TgBH9kAYPjn42Q6YUQf6k9jQPYNMNC88ih1myI6LhLbt+c5+?=
 =?us-ascii?Q?85uuAeJtj5SPxGuVVo4sZeUPbHgCnufRqMXbCbe3HxkvRB2LHNa62A4T7KG4?=
 =?us-ascii?Q?j5d/QmRvYNbfPklSk99gqHGkoCmFvy1P4danVhkVJd2+exgajCLdFcfqAw3m?=
 =?us-ascii?Q?NDBEsYRlby43jMqqqQ0bH0K2ZyRudsF8EQ4OlNVEkEDoMSF3oRjekdmwMG+M?=
 =?us-ascii?Q?3dZfvxaomrDUcCpRQtjIdEcYnj+9AsIqBBoTNzZyLt1JSQKbro3bCdBbdhGn?=
 =?us-ascii?Q?k6OTAe1ydDaESrnPBI5K4PwFtz8g+vWOka7ea6OB/fIstdMXfmgIRz7bypMC?=
 =?us-ascii?Q?7tGRZRXEoInEYbX1LA3EHkHmmFFjcjR1EATy+/p2CVbdyutVWO2/sXxuetNh?=
 =?us-ascii?Q?aZRTncqhOGU/PsIv1sz30+v7EjtgcLwevICMNNHImicHe41LevEgm8T+WAmj?=
 =?us-ascii?Q?Dq2QLpp5VSh7RhzB56fcxO251bWxS9W441J3pVjRkI2u0x+JPQeW39qv5NoT?=
 =?us-ascii?Q?qUMKOLrTKOfeTv6clal552X7RwqkqFuq4cvGojtlIpqoJ/AeIROxoBCOxSP/?=
 =?us-ascii?Q?g0baEHdz6U/zQWlmUsLJkckh081kuvgQ0K9XrBQ213/GnQI98b/ukkDwNl6s?=
 =?us-ascii?Q?QT5cbjSsgjxahetcrKpo8n2YPsJOSWcHhaje23NokPQdgS7MHQa/gpD/oc3I?=
 =?us-ascii?Q?pDpSf29cPNLfheCNw743FdTcxyC3l8wFhe2ghbJzriECoAhPv0k0ccShlGHx?=
 =?us-ascii?Q?ceh+/sm8n1sVBBfiHYmWdX3fiA/iOJLm3nOVk9fkqGD3fdqRGUK6e6n4uJUm?=
 =?us-ascii?Q?TZ7cPw/wfh/Eu9U0THFUMg+sXAVphtvO5v1L/s9tiEMoOax/O6gIfiCzXIO/?=
 =?us-ascii?Q?7ElHMr7zZDAeYqmG72d20gs1Xt7TMGX48RM0ejFfhmL2aHDpjw6LDrwT0xLD?=
 =?us-ascii?Q?ubyCKwH+gRg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Mn/Zwjm3z6zPmNf1xnolB6H4jtPpnTzposhtavk0fTsryJgPBXLcD/PkcXB+?=
 =?us-ascii?Q?WpixviPkHE4fmL33F+3gLda4rxrf/z/vG7vPRX4D7ym3ZE0FbaseEL6Tz4JV?=
 =?us-ascii?Q?Py+IXv5d0hjQ2o+1CVSAT7XCTOtAsol7hphMh5HlPHv8LfQaBx033KAdXs/n?=
 =?us-ascii?Q?HG9sPZ2EyTjd1I3Z8ZlajXjF/EcPKjnNR8cI/qQimrJpz6B+Qlsn9u7noJG3?=
 =?us-ascii?Q?g1FAjUXeMnq6k1uNUt3/oxP5Nha5Ik3Byu9OEEhrKOLIXZqPoT2+j6HvT8bN?=
 =?us-ascii?Q?eIH8tKjuKX/VJhY21J0/srfElI0bBuDHmh8dWaRKsxi53X5Fjc7MkpoXhq8B?=
 =?us-ascii?Q?lFsTHCw9GPKd8nFeQDgSA8UeGcK1AcC082PmN8PHG1CYXSq6Unb0UIqYXRhG?=
 =?us-ascii?Q?CTTwFkl7Zxkxi/rnA6NQsYq1F8nUMKRk3SEvAtIAKi0/bUGnZXYp/kXaJz6T?=
 =?us-ascii?Q?qMTVXwSi8MIkpZ7w/kIGUThc4t17rWnb0qeBGSZ2yV7GUfBdeaiwyXG/j1en?=
 =?us-ascii?Q?mXZU25w524V6JxQkRNj30A+eaHIQwf5HCF19aHHdOuvBldPD9X4mY0QypDfx?=
 =?us-ascii?Q?lgvvhK37pTv5m1di9i8m4IWinh/uFrU4hdSpNn2G66PUG+l9Kw5V0DW2Q+wB?=
 =?us-ascii?Q?u7dfj0Y29NiZnxooflGsaGeGkObxtlbmkvDs5uyS4QznGnN0QuZ5eUFZmC3j?=
 =?us-ascii?Q?f+LSmDTj49nS1M2FleZMMyf+ef8asqFQDYadG79GzpBBGtOj65yw5txGf/x4?=
 =?us-ascii?Q?rDrKTW3PbITmr4rCAgL5U2kayXqJyG77fIRWu3E6SIQg0hRVV+trOFAKJwsQ?=
 =?us-ascii?Q?PxGHceNZVGQWBe4YXqf0GE//PHWSTmKTqoMsrZ7zr6rnNcdSqi0i1BHUKKGR?=
 =?us-ascii?Q?y92drpPmvq4ElOi/BbyGpPcftxpy++Uyz9kzyNwgW4NHejTVkea27BAupF1r?=
 =?us-ascii?Q?ueTMzoOSi7ZiA+8Dvf8pzSurnqGNNHD2ZKCJlHcscGEIWESXvrLKDvUOgPfw?=
 =?us-ascii?Q?fmGiC+ZYRytiuBRXV5sFdCMWyMWYSijYBalES2MIQSpTjwXuySj8WjuUlqzu?=
 =?us-ascii?Q?Y/1NexA41GLmKNxdjex1yKpw26UECsVr7pID6tEpnXDZOH5oPDa2y+1N1Png?=
 =?us-ascii?Q?jdeeOa/dt8dl3J8G74wxJxixrC9g7AyPioJ2pMIw18N81QIkCoeilk90dpgO?=
 =?us-ascii?Q?K9dUavlnEZfG5vri9nEb3UsrZtrcKeo8fiABq0iffyyjGaPgL0TuBOxqwPRo?=
 =?us-ascii?Q?hYWv4C5vjl1WKxixr/2D0/yovjQYbOhNIL/3rkqqQV9PnJ5wML4e7vXQguJL?=
 =?us-ascii?Q?oshJuvXjSX7zz/nBdWwcGmb46EE8xOIC6BNnWznpaoSV7K2ZE/zrt18F8LtG?=
 =?us-ascii?Q?PdXwuw9cvrkjtnAI9IGXIN8AHwU3p+WNnc32fckPE7Dau6dW8TTpXt9d0FgJ?=
 =?us-ascii?Q?PJQubVKcf0zohvXbihfCPvpUrrA8sNfD+MW+nPKF2copFdr86KFnXGQTpud5?=
 =?us-ascii?Q?cJa2YyJMnnwPD8dWQ0LUcRq7AfgtWCsTVny5p7BwpLDSf+w5OsMgBAVgfQtJ?=
 =?us-ascii?Q?Ue5MZ8ySP9iz0Qlw8k1hCC0vv4gZoijsVgXH5iEg7sfxy3t08pNeDwgIQIgL?=
 =?us-ascii?Q?cQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fbd56d3-1177-458e-b9ac-08dddfe6194b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 12:35:52.8898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1gfa52pgdnAikb8oVzrQp3IIVtbnweqdC1+Xu2hEeNrzpsEdGFf12ToE4tY+N5NTkgB0YQsoTg2zIBq2PdMNFuI+IhziFMD1ctMxgHUOlro=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6430
X-OriginatorOrg: intel.com

On Tue, Aug 19, 2025 at 01:48:00PM -0700, Stanislav Fomichev wrote:
> On 08/19, Maciej Fijalkowski wrote:
> > Eryk reported an issue that I have put under Closes: tag, related to
> > umem addrs being prematurely produced onto pool's completion queue.
> > Let us make the skb's destructor responsible for producing all addrs
> > that given skb used.
> > 
> > Introduce struct xsk_addrs which will carry descriptor count with array
> > of addresses taken from processed descriptors that will be carried via
> > skb_shared_info::destructor_arg. This way we can refer to it within
> > xsk_destruct_skb(). In order to mitigate the overhead that will be
> > coming from memory allocations, let us introduce kmem_cache of
> > xsk_addrs. There will be a single kmem_cache for xsk generic xmit on the
> > system.
> > 
> > Commit from fixes tag introduced the buggy behavior, it was not broken
> > from day 1, but rather when xsk multi-buffer got introduced.
> > 
> > Fixes: b7f72a30e9ac ("xsk: introduce wrappers and helpers for supporting multi-buffer in Tx path")
> > Reported-by: Eryk Kubanski <e.kubanski@partner.samsung.com>
> > Closes: https://lore.kernel.org/netdev/20250530103456.53564-1-e.kubanski@partner.samsung.com/
> > Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>
> > Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > ---
> > 
> > v1:
> > https://lore.kernel.org/bpf/20250702101648.1942562-1-maciej.fijalkowski@intel.com/
> > v2:
> > https://lore.kernel.org/bpf/20250705135512.1963216-1-maciej.fijalkowski@intel.com/
> > v3:
> > https://lore.kernel.org/bpf/20250806154127.2161434-1-maciej.fijalkowski@intel.com/
> > v4:
> > https://lore.kernel.org/bpf/20250813171210.2205259-1-maciej.fijalkowski@intel.com/
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
> > v3->v4:
> > * have kmem_cache as percpu vars
> > * don't drop unnecessary braces (unrelated) (Stan)
> > * use idx + i in xskq_prod_write_addr (Stan)
> > * alloc kmem_cache on bind (Stan)
> > * keep num_descs as first member in xsk_addrs (Magnus)
> > * add ack from Magnus
> > v4->v5:
> > * have a single kmem_cache per xsk subsystem (Stan)
> > 
> > ---
> >  net/xdp/xsk.c       | 91 +++++++++++++++++++++++++++++++++++++--------
> >  net/xdp/xsk_queue.h | 12 ++++++
> >  2 files changed, 87 insertions(+), 16 deletions(-)
> > 
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index 9c3acecc14b1..012991de9df2 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> > @@ -36,6 +36,13 @@
> >  #define TX_BATCH_SIZE 32
> >  #define MAX_PER_SOCKET_BUDGET 32
> >  
> > +struct xsk_addrs {
> > +	u32 num_descs;
> > +	u64 addrs[MAX_SKB_FRAGS + 1];
> > +};
> > +
> > +static struct kmem_cache *xsk_tx_generic_cache;
> > +
> >  void xsk_set_rx_need_wakeup(struct xsk_buff_pool *pool)
> >  {
> >  	if (pool->cached_need_wakeup & XDP_WAKEUP_RX)
> > @@ -532,25 +539,39 @@ static int xsk_wakeup(struct xdp_sock *xs, u8 flags)
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
> > +	for (i = 0; i < num_desc; i++)
> > +		xskq_prod_write_addr(pool->cq, idx + i, xsk_addrs->addrs[i]);
> > +	xskq_prod_submit_n(pool->cq, num_desc);
> > +
> >  	spin_unlock_irqrestore(&pool->cq_lock, flags);
> > +	kmem_cache_free(xsk_tx_generic_cache, xsk_addrs);
> >  }
> >  
> >  static void xsk_cq_cancel_locked(struct xsk_buff_pool *pool, u32 n)
> > @@ -562,11 +583,6 @@ static void xsk_cq_cancel_locked(struct xsk_buff_pool *pool, u32 n)
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
> > @@ -576,21 +592,37 @@ static void xsk_destruct_skb(struct sk_buff *skb)
> >  		*compl->tx_timestamp = ktime_get_tai_fast_ns();
> >  	}
> >  
> > -	xsk_cq_submit_locked(xdp_sk(skb->sk)->pool, xsk_get_num_desc(skb));
> > +	xsk_cq_submit_addr_locked(xdp_sk(skb->sk), skb);
> >  	sock_wfree(skb);
> >  }
> >  
> > -static void xsk_set_destructor_arg(struct sk_buff *skb)
> > +static u32 xsk_get_num_desc(struct sk_buff *skb)
> >  {
> > -	long num = xsk_get_num_desc(xdp_sk(skb->sk)->skb) + 1;
> > +	struct xsk_addrs *addrs;
> >  
> > -	skb_shinfo(skb)->destructor_arg = (void *)num;
> > +	addrs = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
> > +	return addrs->num_descs;
> > +}
> > +
> > +static void xsk_set_destructor_arg(struct sk_buff *skb, struct xsk_addrs *addrs)
> > +{
> > +	skb_shinfo(skb)->destructor_arg = (void *)addrs;
> > +}
> > +
> > +static void xsk_inc_skb_descs(struct sk_buff *skb)
> > +{
> > +	struct xsk_addrs *addrs;
> > +
> > +	addrs = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
> > +	addrs->num_descs++;
> >  }
> >  
> >  static void xsk_consume_skb(struct sk_buff *skb)
> >  {
> >  	struct xdp_sock *xs = xdp_sk(skb->sk);
> >  
> > +	kmem_cache_free(xsk_tx_generic_cache,
> > +			(struct xsk_addrs *)skb_shinfo(skb)->destructor_arg);
> >  	skb->destructor = sock_wfree;
> >  	xsk_cq_cancel_locked(xs->pool, xsk_get_num_desc(skb));
> >  	/* Free skb without triggering the perf drop trace */
> > @@ -609,6 +641,7 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
> >  {
> >  	struct xsk_buff_pool *pool = xs->pool;
> >  	u32 hr, len, ts, offset, copy, copied;
> > +	struct xsk_addrs *addrs = NULL;
> >  	struct sk_buff *skb = xs->skb;
> >  	struct page *page;
> >  	void *buffer;
> > @@ -623,6 +656,12 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
> >  			return ERR_PTR(err);
> >  
> >  		skb_reserve(skb, hr);
> > +
> > +		addrs = kmem_cache_zalloc(xsk_tx_generic_cache, GFP_KERNEL);
> > +		if (!addrs)
> > +			return ERR_PTR(-ENOMEM);
> 
> Do we need to kfree the skb that we allocated on line 621 above? (maybe
> not because I always get confused by the mb/overflow handling here)

Awesome catches Stan. I'm fed up with these changes and I manage to
introduce these two bugs you're pointing out:)

My reasoning was that even if we write the errno for skb, I assumed that
branch below:

free_err:
	if (first_frag && skb)
		kfree_skb(skb);

will be taken, but the thing is we don't set @first_frag = true for
xsk_build_skb_zerocopy().

I will explicitly free skb where you're suggesting and of course
unregister the netdev notifier.

Thanks!

> 
> > +
> > +		xsk_set_destructor_arg(skb, addrs);
> >  	}
> >  

(...)

