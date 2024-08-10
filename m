Return-Path: <bpf+bounces-36839-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B620F94DD33
	for <lists+bpf@lfdr.de>; Sat, 10 Aug 2024 16:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB01A1C20DBC
	for <lists+bpf@lfdr.de>; Sat, 10 Aug 2024 14:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C88E15FA92;
	Sat, 10 Aug 2024 14:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XNnF/bqY"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D82A381C2;
	Sat, 10 Aug 2024 14:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723299139; cv=fail; b=oxtrA5IWuyFCosSKSxs3bsdKEqlctjHe2fOedZg/kPudP0UZ4/oSEhkamoC4PNCVb1m9rp1Lhb2PQpV02IUv2FCCDXMcPPCI+QueWDFtkdcDtyfuW7leacXdLRPCXkqcxQ6fcLpeaXUnvzK+ZB3swmn2RZN9U5rhbkFK9uI7Osc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723299139; c=relaxed/simple;
	bh=6KMo3/wSqcy4qe2CjpyaTzMX43vkECQnrk2ke66rUcE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ux9rqJAmVITm+ub5RjcE2jRbIGFb3Votb4Pg46ndE2+nflIA177Ngez5iyCrHXKWuCR3g8nYhwrOpNDEW864m++O2rzLHkFVG+Ndk2pYjCyO49KTyKFpBXgAhK9Yl5taZasAup6mUZKJe1f8085m6i3iSUHhqqvJilnfeiahv3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XNnF/bqY; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723299138; x=1754835138;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=6KMo3/wSqcy4qe2CjpyaTzMX43vkECQnrk2ke66rUcE=;
  b=XNnF/bqYWUKfhzTiWbMeMzC3tnZLeKHSZIt2kquqdJ3HJ1R7iKdM0kOi
   S7CLI5fTIYyD9vFx/oUiF8Rd7LwPjUoEUdIp+jpSbfqSXx2O5c2EMkCaW
   nVeffyVG+cdwlSs8t2N9Bzrk7fUsnqKG399O/Y8ABOdFDE48KvxAN0Yyl
   YyyHMDLiM0s4bk3vi6PVgwtydW7Jb+y/W1kqPJO+/GxJA6lxbwR2T2iWf
   p2/hHHQMfTWUdSiBcOVIcLzdYXNrFaAcSW3NL6V+HhI1nHuJQjY6ESpVE
   SYH7WmQLC3V4IAq47+AYZ+waR45DJvJvzkNqSE5y/UO61rS8MLYR1lE9s
   Q==;
X-CSE-ConnectionGUID: AeXzlb+LQ0GCa353nqkDzw==
X-CSE-MsgGUID: uRKQQBc2SiaEw2ub6W03kQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11160"; a="21122815"
X-IronPort-AV: E=Sophos;i="6.09,279,1716274800"; 
   d="scan'208";a="21122815"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2024 07:12:17 -0700
X-CSE-ConnectionGUID: Op4vycL3RJWa5NxIbMXtbw==
X-CSE-MsgGUID: mrol5LtiRMyaObYF6gZkMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,279,1716274800"; 
   d="scan'208";a="88682232"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Aug 2024 07:12:17 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 10 Aug 2024 07:12:16 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 10 Aug 2024 07:12:16 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 10 Aug 2024 07:12:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PbViILpf7Xex3XPyqGXtpw+jaWeb/rp1fnRxO1+pwtlmEH9WUyjJJFLYgFZLBcDA4ixh0v8UGgHae0FZOlQ38g9pgITTr3wdVsvgn2+tGbVth54ZGlvDZqqwvvYMokJ7alEmoVkEqvQX+XrMaZmywy9rnPxWG4YJ7TdYP1UTFQ/t+6837qYaFYj1q4ARfakjXByLRO7VgcLPVVUZ+cSYSkc+Iau7UgdtbvaUqTnoDE2y0VX24mlriPATr0C6fwWApIt38qIWHViKIUCjoplNHo/pJfxL+86J/cjjaUXRLs2a8/q1l4Il/sGrnL6otQxPmrkSRG2jNgtExP0KFtLYHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a95yl1Zrtvhfv1J4V+ZVEP0+cu84dX4G4e6vrVwK014=;
 b=QZiEkXthZB7on2BBObvWglpIF+DwG8fiPeKGKlQXwLPvXF8PAL57gE0XpQHPBIQY+cf8yZ4v+Cqu/xMcfbJ3fF2UPuRVnAQfidV2xEv/k5xmHQz5pNPhQ16B47G5ykzIAGRp9vyAAoY1GR7LGMhgAqEWk8ShyWP65C77sluV08ZL+45iUSraNFlMGOcc6oT5/f3QtSzPkLvXmIISmW8kDZfknmmNhJgfFemedeK+pMaMRiB1mf0ux8m/EFstnMERCB8cF1fVGZ6MBXwNqe3oBN8NjkhC1L8JHsh5E+ROGFfPxX1xvVxzCwcvkAe+F2nSFgnbPfTTVTRSqBxmRlyLzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SN7PR11MB6679.namprd11.prod.outlook.com (2603:10b6:806:269::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.31; Sat, 10 Aug
 2024 14:12:14 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.7828.023; Sat, 10 Aug 2024
 14:12:14 +0000
Date: Sat, 10 Aug 2024 16:12:07 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <netdev@vger.kernel.org>, Sriram Yagnaraman
	<sriram.yagnaraman@est.tech>, <magnus.karlsson@intel.com>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <hawk@kernel.org>, <john.fastabend@gmail.com>,
	<bpf@vger.kernel.org>, <kurt@linutronix.de>,
	<sriram.yagnaraman@ericsson.com>, <richardcochran@gmail.com>,
	<benjamin.steinke@woks-audio.com>, <bigeasy@linutronix.de>, "Chandan Kumar
 Rout" <chandanx.rout@intel.com>
Subject: Re: [PATCH net-next 3/4] igb: add AF_XDP zero-copy Rx support
Message-ID: <Zrd1N4Bqh93eLfee@boxer>
References: <20240808183556.386397-1-anthony.l.nguyen@intel.com>
 <20240808183556.386397-4-anthony.l.nguyen@intel.com>
 <ZrdxPgcqLdzCXCAS@boxer>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZrdxPgcqLdzCXCAS@boxer>
X-ClientProxiedBy: MI1P293CA0027.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:3::7)
 To DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SN7PR11MB6679:EE_
X-MS-Office365-Filtering-Correlation-Id: f0e23f67-9bab-42c5-a9d2-08dcb9466f3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?B5yW08MLJw2ah32A0LdhMIeIA98L7QeiCz7hK2sxhExDj9QZoi+G7xNsja32?=
 =?us-ascii?Q?MuEA0Iz5Snl97Hr6bEkBilLXGxyrkKJv0fNtCHvuw3KPWoguAleuWGJsWnpn?=
 =?us-ascii?Q?Dnce4BySm+SzV0ajnIpl8Wwn5ToFIkukKImflsYBt6nuavQ3CiUyxVAP7Pph?=
 =?us-ascii?Q?DZbZmvztiqWF+5cCuxNLzjEX2v5+r+qTv19TG6lQhbJQFnEnqdtpI/fEq7+m?=
 =?us-ascii?Q?yb1LHwYzm+2ClhysuOqheNA4dilEqutvqGemVKFdmi5xemtV0KqSthsAtrnZ?=
 =?us-ascii?Q?lUAloum/YEqZj3TslSEgBX/81K74ECaJb6A5IwxLwiPiuE3kKPK/w5wdPVZv?=
 =?us-ascii?Q?zQZV8snwhqzu501RnBWI84XhLjCpVjWhDA8p+gPqNTYkeRRyPWWKoso1o02K?=
 =?us-ascii?Q?jTZOMdTN1dgfstT7zee56GiGhPZnRDn6mFTReU+7cjN4Hg0i1SlJuRMnhM16?=
 =?us-ascii?Q?PFMqmkGnUH/qk4riY5BXQnhz1KK1WWIOhd+PssDDI93s0kTHCHwxPol3XxYE?=
 =?us-ascii?Q?JvZGSzt2nTzwhI8hVLbPnQoV2PH06MKhX50XZFX6V+xMhIme/BoSegOuDjmC?=
 =?us-ascii?Q?wgRDw14+sqaryakDuO/CIMR1w/imcNp0yA58wC+yz9DohHmVafnW6f8xZ/I7?=
 =?us-ascii?Q?WFX6LLzllUiattZA16uVAcAGAnos+jJiMwGoqz9Ld6pPAvvz4BeFmicujQ9N?=
 =?us-ascii?Q?rloh6nHUudx8hGNhP3/j0fyHwaMomUIb4mfEODidg9YQoAWvIpyZlp0T0n4F?=
 =?us-ascii?Q?RFiNca2wLtgmTLxzYJwX0/fpJqb4n3ijRmN54gntYJpgztN+doIaAljEG38e?=
 =?us-ascii?Q?meV9/XA1RdxZ0OlaeY9YbNHRcZXpz++OW1CBt/QKd2zm6c1Nu7fvqtQFFNpZ?=
 =?us-ascii?Q?6f+XWAE2RWHi/2iQTJ4KAW2S6peefX+nJx9JFSlTSR5xUx+yRJPninSKIBwx?=
 =?us-ascii?Q?1v6/xCtO73b2D8ZZqtVKO7uZKGal4IJ88EgPfk3E8MafYnH/7BjEaWFvWRIm?=
 =?us-ascii?Q?+vnxq4joPJbY4e5TImaeHwygkR6Cxc1qJuZNFJYO6R813QNX3qaYY0feQWjp?=
 =?us-ascii?Q?zjSKDDoAY8e5Qw7wLW/gui6VbshOum2gjynLNi5tiEb+T7uhqI0QKN236oSi?=
 =?us-ascii?Q?3TvK2YDbJUH0wGelP0rO1joNg4U+7kfza6zA9Cv/pMZ7LPXvotIe+rzGumjA?=
 =?us-ascii?Q?wYRP9OeNWbEHi8pqL0ic2/EzRMmU597obsvtxw5UXo1VScomPy6qearexer9?=
 =?us-ascii?Q?+5PNfAnZoV4mby6M+6VPzpCc/8UftEpIMoE7/43axYn9D/aFFrKWMrZbvd3A?=
 =?us-ascii?Q?/GqqB5I1bHqWGGUjy+mGP321LtqcDhgnz6e9udJiKvFHkg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GQ7jnTdrbavjbzbl7+52m8G+nzvL6DY0wsN0kPz8LK1u96yvSQBsop2Hr7qz?=
 =?us-ascii?Q?93D37BTwHphIPUzt0vPqfF1FqC22yaoY8gfo+LHhPWv7qiGMODUGu4OH1SRE?=
 =?us-ascii?Q?CUe8u+wJH8v/4Tn8yuArb3QyqQcDb0GULyWVpJIZ89kaGRXLPToUos7qLCwr?=
 =?us-ascii?Q?1hhKPemlfDiLJJX5m6w4mhX+LrNt+MQo1O7pLbdAzWqSdO54Wty77SNwVyq6?=
 =?us-ascii?Q?jEPRO1cd0mmnhw1MXW1jBJHlrSz/6veaJ+s/taMscWF5MfyCi3YQK7/Q0J9d?=
 =?us-ascii?Q?4JN9PfrcU7lRXpnC9PGEko0hb0sfVf88+faaLJLMLDmpT0kvqkFkw9fVLjsL?=
 =?us-ascii?Q?0EGzKkw9eSeDjx13AOAQ24jW7EPHtdHXnn03fG1wnqrUbZE/cXxmQ4jWdLZn?=
 =?us-ascii?Q?3ylesmGFgj/+F9BNnuGJR8I0a0OAlBG3LfnkTxe8EBCKhWKrJxeGOXYXSFRE?=
 =?us-ascii?Q?X3Cdw/HkJjmQ5+QL7AtIgFDprlsYFWSTzOwg/iDR/np0HQC+L1Y6zFPfbrHi?=
 =?us-ascii?Q?kq1Vfui2QPSgRCW0ADaRyZYgNIfX3QPe/Tmc0Ddfnstzf4zWfL2LQP7QbvKY?=
 =?us-ascii?Q?BIvReKPRlrBWb5Eula9BdUm56dNNTcKIC5/Z1kjsMR+y8xvyo4EFs/uO3eD5?=
 =?us-ascii?Q?fAa4g6wDOfxrkpl6R6KuL0yR8X/gNEDciomj2iObqxKRH/Io86maunttI5xo?=
 =?us-ascii?Q?5W35Tk8OpT8TmYiiUYp8ZzZ1Pi9UwSy/qtcvF76hk7Ed8duyRh2zeei/5lcL?=
 =?us-ascii?Q?2vy7624on11we5vE36c91ZxrkIoiu05NEijzGJGC7ongGOAzH526QugqU5zI?=
 =?us-ascii?Q?01FZugdzuQtcJISeZ7/7Cfk0aLAZp7FfpzLHH59YUG9Q4qiss/uZeaAGWTpB?=
 =?us-ascii?Q?VQAKfgFhTdA7h/dJ8tDlJT6FJoMSPcw39f42uw6wwMugn/9HGw9Eze6Yv9g3?=
 =?us-ascii?Q?vbkpRQukg4LPjpTlN28OOzK2RCD38Mo/gQqzAU0jo+GahUre1m201xXyglRc?=
 =?us-ascii?Q?XxU6X4PU4SrTE0I0QfaFZcb7AC5oiGoy/MPJhAwA4Q5H9IuQ3di2Z3q2YX9t?=
 =?us-ascii?Q?iHawg7pWqHIZ0nvIo6bEZW4M/jc9Opkcn9qzhyBH7ONancDoEo8CS0uNexsO?=
 =?us-ascii?Q?fngTeP2I9T9esbK2m/7Icj/jp9KGZ3uMOpeYvCx0Bd95zRBQi6xj0qxLTHEu?=
 =?us-ascii?Q?8YVovJCZsSIeB/vt2y5VjLB3xTvevCF/ZTCfkONdq9IQKSLh9uvH905XvxxG?=
 =?us-ascii?Q?ie6URhWpMfYGLKZXWatc/IiAjaBFxsdS5TfdcPF89QkvhH1pliuCsyyARqmg?=
 =?us-ascii?Q?UgvFetB0F5Uaby9YvNYWi3Zd/GxgoM0kW9GcBreY4/LJjbu3oH+9lDfYsP5x?=
 =?us-ascii?Q?+zvmD/6/D2KF9xQJzS3d5v7xSl3CpYZo4VDli969DFq1SdZsbQDUKjJ5J45z?=
 =?us-ascii?Q?iW3eVzXmltjMX10dnSBTSIaxkNDCQkdjNz+QXbNhQiX/a6w56ty9zI57aTYf?=
 =?us-ascii?Q?PizpL2ap03oTsqKQFw8hu5Nr36iMW5uVVI/LgEDKJ96xt0uegZgTzH6w20Ui?=
 =?us-ascii?Q?gZSLpWXUciPmsNxxpRzwbqcAuGhnCrlPUH8yU4C9rEG8/xoiXnesH1JyKgXF?=
 =?us-ascii?Q?bg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f0e23f67-9bab-42c5-a9d2-08dcb9466f3d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2024 14:12:14.5820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HzyLegP+tndcgCVOXTBGfPRFfbZ2Bh8LC2ejV2WhjnQcqGCsuow+888tfayTvhIGHXNSSLPIssuB8mkYNh9v3QVphlWPQmLE+RGhXDQMan0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6679
X-OriginatorOrg: intel.com

On Sat, Aug 10, 2024 at 03:55:10PM +0200, Maciej Fijalkowski wrote:
> On Thu, Aug 08, 2024 at 11:35:53AM -0700, Tony Nguyen wrote:
> > From: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
> > 
> > Add support for AF_XDP zero-copy receive path.
> > 
> > When AF_XDP zero-copy is enabled, the rx buffers are allocated from the
> > xsk buff pool using igb_alloc_rx_buffers_zc.
> > 
> > Use xsk_pool_get_rx_frame_size to set SRRCTL rx buf size when zero-copy
> > is enabled.
> > 
> > Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
> > [Kurt: Port to v6.10 and provide napi_id for xdp_rxq_info_reg()]
> > Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> > Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com> (A Contingent Worker at Intel)
> > Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> > ---

> >  	netdev->priv_flags |= IFF_UNICAST_FLT;
> > -	netdev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT;
> > +	netdev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
> > +			       NETDEV_XDP_ACT_XSK_ZEROCOPY;
> >  

Also please set this on last patch as this opens us to a state where
AF_XDP ZC is enabled but there is no Tx ZC yet.

