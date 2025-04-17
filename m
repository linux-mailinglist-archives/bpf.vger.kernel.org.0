Return-Path: <bpf+bounces-56154-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 108A0A928BA
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 20:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E98F93A36E8
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 18:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32AC25E81B;
	Thu, 17 Apr 2025 18:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tzcOvmYo"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E392258CF9;
	Thu, 17 Apr 2025 18:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744914641; cv=fail; b=B9n4hqGs6j2LEaU0ElBiU3HCYMdKDA0Bn/v2KRzzttSxRJ/E4Avu9UbzhPbwlJwelGew3n0FgqX8wSxQp+jyikjuyFHz2D6jDLpYZSpuGS39ZleSb+pv9WVmzya4C5zZ4EiTCS3fIl6ZMT/EJSI6w2/fNZjyjn+TXOI3LtmnD3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744914641; c=relaxed/simple;
	bh=Gq6nSOP85+X7rMWYYKrLMr067j2kDinIDyjmLJx24wM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Qvv0UiMFL2ar3zC2xMd+93u+EsW6q0Ydghkglp2xqLv+8vEHg2MDJ8XBVi8tgfphQCiFtBkLepVHZ9hJdcZlHC06TqVnd+7YVaFbhp7ORgFDv1RRkE4pF/XCDkfPpAl3lqa230eY1PJ92gxoD7lPGTXu8ZMQ35jgKm3aRlam/IA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tzcOvmYo; arc=fail smtp.client-ip=40.107.236.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=daF2dFQo3npMkPxXFmOge23tzxBNkMGV4xehdVT0CfYRe4KETlfoWXmlzippUlugWU7rN/w7BywqGG2GJevZIw2vASPJqNPisBajshSxUVs8XARSTEr0zisEHj6b8hcg2tBCryRp9Fa8tKOEZ1aHc47/xpgtx4CBObvW85GuRqWh2JNTxOmSr6/dOtnANFXMgy06uvDkCN/s9v+//bkEw5Y69FjsS4ElfsekiJiYhPbIMt1uuyAuJyC0lcEKV4wWyq9YzMb9fskfqOD911I9eNSst31/vL0Maep3d1e/gyAHHwq1t/lmYj6135n0+zU9K1JQpgXbMnwgpVXt07FaZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NEejaB+ouvOXIkRv83WVjL4DSj63awUBGIGJaauYqqw=;
 b=sviKjG5yH5E+T8iGr6knd8dNwlkCTQOoqtJYE7rapE9KiWhWdQg4tdtLUd9BwZloXSn1wuH3CaXzTYGaLFWrJpGIX2lDH3AsQwJVlNBM326ZKxZjFvMI0RyYVT9IGMArC/3tTmV1OLqWvDqoAN4uZkiQ5lze0G/un37gHdKwIrb/5U6/Y3aSr9hFZV1YKVMVIo9eIUYMevFiLAlfDwZQygC0pFE7De6qar5zpkrRNPgZa7leObEAk8KQhMWhTln02Kbat0wi1D1+5O2UWeE5Nb+awRDeRSEWVvP2FEBOEhbgScmwR37inp/NEEXXyiEUkzf0zdn50qe4aqwNSK9Z7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NEejaB+ouvOXIkRv83WVjL4DSj63awUBGIGJaauYqqw=;
 b=tzcOvmYoDrVukHxZnl97t1QahB3p0qLOpRUs8fRHi6jGhP4eVB/MnnO95RHq3FnyNfJKp2bbIHpZO/khifrbt207V1w8CZkxfpQsBmbU3GeUvW0rMwJruoDIyu/poVB1XgZOtqIfNumNNZsC2fJyi3AS3T6p5ts39FdqR/NrSkgS91BQh6WprlSB+F+cv3GuJGcCwPaTg8G6Upy/s6nKnQUK8X25M0YetiaHZlZxLqNYTFikqwXSiGZNg4FUSEYQmTrAya0BzbL/WS/u2F7dyi1BiwY3MCWFjsguFU9VlnX/sG4MHzqoLkXYtHHZUqLnFiH2s23jd01LNpMvVdOjTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by SA1PR12MB7248.namprd12.prod.outlook.com (2603:10b6:806:2be::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.38; Thu, 17 Apr
 2025 18:30:35 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8655.022; Thu, 17 Apr 2025
 18:30:34 +0000
Date: Thu, 17 Apr 2025 20:30:22 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Honglei Wang <jameshongleiwang@126.com>
Cc: tj@kernel.org, void@manifault.com, changwoo@igalia.com,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, joshdon@google.com, brho@google.com,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 1/2] sched_ext: change the variable name for slice refill
 event
Message-ID: <aAFIvndKUQXm_ix5@gpd3>
References: <20250417080708.1333-1-jameshongleiwang@126.com>
 <20250417080708.1333-2-jameshongleiwang@126.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417080708.1333-2-jameshongleiwang@126.com>
X-ClientProxiedBy: ZR2P278CA0077.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:65::6) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|SA1PR12MB7248:EE_
X-MS-Office365-Filtering-Correlation-Id: ebc2dc48-20e6-4228-5f43-08dd7dddf083
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6hEkOFZZJV2L9kVODlXYAT/LUSEFR6yyxqK4etSbsLlFj97C9KUe+XPg3RqO?=
 =?us-ascii?Q?kqAQW4iNeoZLG+fcdH6WkiayboU36/HL/jGycybYcO7IicmTNdU8jUH7W8vR?=
 =?us-ascii?Q?rkzQMfcTpzhFdhshgFbYv0HFHCQiipWm++UIxRZLCW2J+qEqhe1kAywZVEdi?=
 =?us-ascii?Q?zE8yyVOxz6hdi9O3nmjt9dfWB47QCJLQwO6DnAkw76HbIFURGBnQdcVBlyZe?=
 =?us-ascii?Q?X/Q/oXdMkApMkpBMaXjvruerpenONrIfl7X5sgCJREkaLp2QWNBzyDfFmXSf?=
 =?us-ascii?Q?txb8xaUUMfl0tC/fPg02nX3jbr3l3aFAo1wMg3DuzlHV+m4NU+3hixLfVQsq?=
 =?us-ascii?Q?aXrNtStCyFTqgBqXX7nlyOrwSy58uQBXIfIK2m7pg8eOjDYkvi+F0fhJ7P32?=
 =?us-ascii?Q?ssoKezBxUKncoc8cPx8YOY6Eg+xnN1nU23tpv9g+XC+ktxBSPCZbTBEyHDvw?=
 =?us-ascii?Q?vGNBCxS7Ab957PHQM7XvOriscCNDrzXaXUtxfVpC//kfTA2M+Gewx/ujTh6b?=
 =?us-ascii?Q?pm3bjhg+tbuwF5XKMA3X//VKKZ+73m+cdbG3I+oWaprgkOKMBo2avTxLI1SN?=
 =?us-ascii?Q?hyhf1OHZQWAYHpAlfzwW/NcM+tYH1XPFRW5IavbWjF8ufgRI2k7kx4X0xRJR?=
 =?us-ascii?Q?MNSqFSALO6DMt8cJHtHgwQQWXkp3FkgzPjNKahg3IuZ+2cAyI5LYNWSEz/81?=
 =?us-ascii?Q?0o/+rlc1CiNJLkmGYwi1YTbWbNenWGQp5QRBk+U+shsHMNqzVsMac6KXsXdM?=
 =?us-ascii?Q?qcYVh491xrIj94Xfih167SXxwGLZvUxe4bbcJSXOQRm7QAmYb1Hm9DVIL5z7?=
 =?us-ascii?Q?PKZCF9n3QhJct4neiSZxv7k1rlWp6Q2zHF/jiUrR26GSWQfUwWI3ppTkPY51?=
 =?us-ascii?Q?VHBdqfvTPdoX8BYz/ja4DjAwj03liO3QvffcKBQU28ls0MPjZup/IAO93XSk?=
 =?us-ascii?Q?iDFTEtZdSKkMUgEnO3Tl4FWxK7lusuUwVRdDWUhwIuT0ZTPdP0BXH9ZaKNNy?=
 =?us-ascii?Q?XulQVmZnihcIPvJeXYEtP3RjPak13D30W6ID87QmaOJRehj5C57U+BruSeI1?=
 =?us-ascii?Q?bsZBDltmwsWiw+y4KAHBHXQSTdgLM3R5fCv4UqJmcO/qDRNEjYocyHPewZGC?=
 =?us-ascii?Q?djw22pdhm8PyHqfMha2fcdorU/zIL+aH+H6eKA+GPY64dzMYPerho4sPaqWa?=
 =?us-ascii?Q?BJpR7e1SUy8pgfieTdIz/qcgYviIicnsbeIRFXUy/CcEJN80/qN+diHSk1KA?=
 =?us-ascii?Q?d5IhYTiGs1zlj6YNCrvqb4xwASjZwEZ+uKo2yU5ssbJ457TIMMjMVeaePWAG?=
 =?us-ascii?Q?qeXnT3ks6WienFPH/dL+nRK7iH49bflgQFcrriUXpVoTLZl/8/FJgaweXUve?=
 =?us-ascii?Q?fMTZJvAsLE7S1m1CinXpGUhcGz7mSEJwTemx5qI3/Xs9mFlofMoL0XQa2CZG?=
 =?us-ascii?Q?bFzOSEnMJc0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6iTFQsnjCJ7hGuXGI/gAsmtmC3TO8M/mViBYhDMWdeVh3DiAxUi+OoCn6NSB?=
 =?us-ascii?Q?O9Rp/deBv0XbgEN97LIY1EJCV2G3xKBhm88el5Si+tiFJLb1U966ZJwVpOlo?=
 =?us-ascii?Q?nNGHOQXHH1osWgh4mgc5CL0dJCWlzLoWyX9m8hciyuuIbIlH9hlTX4u/WvXJ?=
 =?us-ascii?Q?xjyvN1bmaUWbqiykewWA+2dtx2HvOtsvHNlAioHju+Sy3E1jz8hStGvCe3Gr?=
 =?us-ascii?Q?y9T0o3C/S1Lk0pmv3Wp26q6zo/DarYvJrSyiANWoF67q03DfA3z8gnQbUzea?=
 =?us-ascii?Q?eIPgrpGyrA1OXXQDZ7hxwZNQouVv1wXFLLD0U+FBrOQhRC7ObUTpfxA8EJ2D?=
 =?us-ascii?Q?yh7z6YFdlL+x7nhd3LS+8fidov4F5msT8QB69Sq6TNxifLfWGOJAwl3gzXhC?=
 =?us-ascii?Q?u6+BUQXD6R7wmyumf6GsB6BqRsjpLDamphBSfCTc6nYEUhnDJIuZEAewfB2k?=
 =?us-ascii?Q?l6UlXavn+XxBQmFc01ON67W8NODN4SO9TDXnjUF/fYeV0C9u0gX67GNBsE4T?=
 =?us-ascii?Q?7TWTOPljEJrJep+jCPBn4LonePEyTuDnTM71cgOmBJaN3NrDo1z4G2kValax?=
 =?us-ascii?Q?a2/zGIVoOGpb6BBxXYHJebKfW5nZRbmv5th1ea1/4XuOCbxn9pWCIAy4/Fx4?=
 =?us-ascii?Q?GH8rXOpIt/yKqaKGG7MiieI8FcTRDVAmOuqtfEwyPpe2Zf9uzA6K0S0kLzer?=
 =?us-ascii?Q?Sv7BvXzrRpSI88lPvpLfhzLgRro2g/8RIVV+IHo540rjqGpvhRn6tt5eAPGe?=
 =?us-ascii?Q?VUObxX3MqahAwtN3FUplIzZLL+GqRbhkWWAq6Ull7W/yAit+zwpl3RHuQbNk?=
 =?us-ascii?Q?Q2CsJJvUU7pAuN3QVZjQgL9XIKdTB8j8NDY+hxqhrUHPWdUvhH0EkJVbIeUL?=
 =?us-ascii?Q?Vv4fdnrLPIq1jBpChB/i2gPdRg4mvi9P2AJK5RNOuzk9lg1+Eq308rf8Cl8F?=
 =?us-ascii?Q?RLnBILZnLFfWxSgyNtHOfFx1lbHIUjAiuWOnyFEtOO7z7IV8B60k21O6HdjF?=
 =?us-ascii?Q?rm1Eg4jwAD7TLLdCsIU3E8E0FcgNHmdPaEKzvChIi/1+pWA+MAh6CChBcM4g?=
 =?us-ascii?Q?mWaXhBmxlLf/IOiKFpbTo8K9QXIllcEaWs+VIzCeefm3No53vvrnE23klf3j?=
 =?us-ascii?Q?dje7CZYKPQaO9ZA2lTpj9PSKmmu5lvlodeTJ2Ta+/lmzbRt3ajcQe2Skp4qB?=
 =?us-ascii?Q?yW08Z8EXy5C5LgSSzKQTWBYRgz0Ur4I+FFg7eoaXDLHRxKCLH5IMbckW2Amr?=
 =?us-ascii?Q?bNq8qR2vxLuTEwS/g3T9enJv2BnPX4KSgBDxLi9jaDgUmr/zYP1qm65xDV5Z?=
 =?us-ascii?Q?Gp4sE7/Ys0b6ovEOY2gpwctXR5hJ9I8xl0lGZXSkxanKL33knATKtmrNyyKm?=
 =?us-ascii?Q?7ab+qcGtRc6AuZ/9T9SzNdT3m11113zj2qPlRAfXTTnMy9AzrMpcnXiViaOh?=
 =?us-ascii?Q?RH1ycK2KXkRPKI4nk3Gjs3p2oEvndDctAQwHzMjA1cWzDPkQO/zmO1137DQ8?=
 =?us-ascii?Q?NuViIjJbvUfndStNTdjqhSuoR6XD6IbMHF9FErwDbhLuLd/aX8i2WhiIHUa1?=
 =?us-ascii?Q?6nj+AAwakzHBaZmnHv43c6daDHbie/nup64fZeaO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebc2dc48-20e6-4228-5f43-08dd7dddf083
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 18:30:33.4375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1gYyiGC4/e9QjoKAcl5tz/9pDRCYeD+0qwh3qLtmcGLGA686zJTvjQ+UEocyFtxKPkD40aA0gB/7B1qbazvVxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7248

Hi Honglei,

On Thu, Apr 17, 2025 at 04:07:07PM +0800, Honglei Wang wrote:
> SCX_EV_ENQ_SLICE_DFL gives the impression that the event only occurs
> when the tasks were enqueued, which seems not accurate. What it actually
> means is the refilling with defalt slice, and this can occur either when
> enqueue or pick_task. Let's change the variable to
> SCX_EV_REFILL_SLICE_DFL.
> 
> Signed-off-by: Honglei Wang <jameshongleiwang@126.com>
> ---
>  kernel/sched/ext.c             | 22 +++++++++++-----------
>  tools/sched_ext/scx_qmap.bpf.c |  4 ++--
>  2 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 66bcd40a28ca..594087ac4c9e 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -1517,10 +1517,10 @@ struct scx_event_stats {
>  	s64		SCX_EV_ENQ_SKIP_MIGRATION_DISABLED;
>  
>  	/*
> -	 * The total number of tasks enqueued (or pick_task-ed) with a
> -	 * default time slice (SCX_SLICE_DFL).
> +	 * The total number of tasks slice refill with default time slice
> +	 * (SCX_SLICE_DFL).

Nit, how about:

Total number of times a task's time slice was refilled with the default
value (SCX_SLICE_DFL).

Thanks,
-Andrea

