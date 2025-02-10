Return-Path: <bpf+bounces-51003-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC25A2F446
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 17:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E1C83A2409
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 16:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88ACD25743B;
	Mon, 10 Feb 2025 16:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pIqNyUE+"
X-Original-To: bpf@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2066.outbound.protection.outlook.com [40.107.100.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E912257438;
	Mon, 10 Feb 2025 16:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739206303; cv=fail; b=etv2e57XW68tXVZVaglQ7AtgMajxPNYqYbLPE6e8hqdUXoijN71YHJw5q7WkQlbG7IFM30S8LVQwggBXYSelICpmGGTHgowYE6QwcAs2q0f+7M1w2u1hsHnXmCyKRxRvQKYlWqXb4vch6GDn1izMotIv06M+rOIt4fF3nwzSDkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739206303; c=relaxed/simple;
	bh=Js2qsr1/dHFzK+Og3y+sJoqdkOKLHXAaLg52PM0LKBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UMr2n8Q1VGifER9XO+qfVR/hXtXBI0dNVkduQ2Sn1YTK+aUh5v0+lD6YhOue9gCY+Gqs9YX4uIuAyNL/ZJKUrQLtuV0MQsKPtAlPUgtzH/Vv6ggr4B9wj5O8B7ezNCc5Czior1k9Wszrrf97FX+p+9AnK+74fBCz4L1bArUeIGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pIqNyUE+; arc=fail smtp.client-ip=40.107.100.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=arbiTGHgLchkl9PUVVWL8dCvXa0cp4eVKgX75kytwf5PqCFENKfWTOzV9qLKCBWCLQBOodv3HESOVBo021aJGme4bWI/4zi1cjb/ocqGh4q9DxQqrexY0IiUpzKBtzl+imR+5dzPHv5q3xZoFkKX0xsfXaGgfgcUO03cUHID/YTK7E6Rv0bKoyKdFMoQG2t779yV9flGE4kQNpxttig1FRp+XgwBLlND+wVt8GF4J3N/zFWHJ+7e5S8WoiTqqh7YFqERor3XHs1QwhtS6a6wLpIHa9DS4GObhSCqh8kUqazfvieNs6H69CKzdmOZT9FoOvDfVBUFxV0c/Z+hzx8WPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uyC1OAaEz1TdUbTRH542W3LfxwaU91l3ACp0foSvTAg=;
 b=rGcJLA/ni+WWBJHmKG4zCRrOKWKt+7/4/VV7z8jPWirj9tPTKM5bdPHdVuV2hhadxoK2UobSkGd9HWBhFmXeyc2TWw9afsedqOruBQwINUE9LYPnlFmIQbh1gLVOdZo2LhpLb5kxhYumgnupreLFgpF9v9wktwvi+Aw2yPFuAI1yaT3+dEn9jjkTy4B0GlbawMZLh5NVEDgamsMcnuGgzpqHPjshEQDKeR3ngql2sGbMHniSrSTSGjeXQCZcbwrZLVK7f4RllSJtkt7SrGfMJlmrv0hR+0cSMnnNMUcYAMi2BcddldLR+qcqalFceWWoMKqYROveRbhAKbWj3FKkqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uyC1OAaEz1TdUbTRH542W3LfxwaU91l3ACp0foSvTAg=;
 b=pIqNyUE+cPA32f2wtyz9XDv815TQ2o5PZJp2KrSqLKB4uQw4tQlzE7KPVmZHlVRh6t3E4GZohKOi6BB524D5cb+TXt/s4OVltyYtZjyZjKi5YQLkOEVfF1InQs40NbFpr7NRFPZXSwsBEb7JLw+DGDFufmWyYsh3x7DhxO1bBpY0MXbBJJ6YUO0qOGJi7F6C1QO5igvLC3n5787iNdyW5RICwz8VWlmPBobokM/COV8zIKoW9lgB0txkboMWEQS7e/PBNUscldyqbPVrY7bIpl1LoXPScin9zb989W1rLCjhAja77bLu6cNoFAUMORNXwvIbvOv8W0X+MAh9bpcNsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 10 Feb
 2025 16:51:38 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 16:51:38 +0000
Date: Mon, 10 Feb 2025 17:51:31 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Ian May <ianm@nvidia.com>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] mm/numa: Introduce numa_nearest_nodemask()
Message-ID: <Z6ouk-c9mLk6_yVd@gpd3>
References: <20250207211104.30009-1-arighi@nvidia.com>
 <20250207211104.30009-2-arighi@nvidia.com>
 <Z6joYmcjyT8eY32H@thinkpad>
 <Z6m4tEoiUBNBmIjV@gpd3>
 <Z6osTMrXVv54cES9@thinkpad>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6osTMrXVv54cES9@thinkpad>
X-ClientProxiedBy: FR3P281CA0124.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::15) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|DS7PR12MB9473:EE_
X-MS-Office365-Filtering-Correlation-Id: ca868854-c616-42dd-fc99-08dd49f32f55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F/yH5s20HGTBp/ofL7Xemvv/gAYlz7wOxy72HnJqiJ74eZOS3rUObbUuUZmA?=
 =?us-ascii?Q?TnAeVu5hJCyarZgomuLJTCqDqJrp3oX4jfbN0SrWdAgiq1ZPKXis6QQ/JGVQ?=
 =?us-ascii?Q?NUVKKZ2JFvfXfmYUMaUU2Nq/vzYN82WBg8M0HkoRlgYqnWfYcFbEcCzavi3g?=
 =?us-ascii?Q?gDs3JR4ELHePTHi+v0EvgaeR64z8Ia6PPQzlqpZNLMyH5J50vc2tFuenuCe0?=
 =?us-ascii?Q?No9zKYjUGVnEsD7uDu/9r/sfcPIMMhgu6mSo7cm2KfKO0d7PLO0cPVvy1FeE?=
 =?us-ascii?Q?QB63PvjB8F92exP6O0PWi3eQ3BMwQlXjfbwfQy9BKlOZoNbxtlEgEJNEKmlO?=
 =?us-ascii?Q?Ned13jJbiYQ8QP4R16QHs18dvv2T36Z3FRJicjzPxBFVFq2iqB96XpJqAGH7?=
 =?us-ascii?Q?6J7QXoJV0PMyEHr6EjhjEWJ+ohpV5k0olfQucjeYC5lIboPWIuCHeO6E2d8i?=
 =?us-ascii?Q?5cKwkQaB7+f23LArKaYpJNjUt9BdC9tlZH/Xzjivjm8o5IHNJUbGCchGwPhD?=
 =?us-ascii?Q?LympcziyoO9AbPbiRAcd5vTttK87IAP1oPbXI3dLIYg7i+e0e6Vpi3GWLnMc?=
 =?us-ascii?Q?2oa8QGKJu2AsBXG309fwTdiO4g0Ji2raC/msUjKrgz18MxgN4GyZFIXJQp9I?=
 =?us-ascii?Q?ncjb5Qne4lABBCDZxPUsK8v2K2X/2PV5+wnS/IT8aryrkCLnSCNOzgjFw4CD?=
 =?us-ascii?Q?jfgyOPmh/Q/eXagE7/lYXrb/PGkOePNg9SPSZdiVIwu0DNhR/9M5Kvjk+iX5?=
 =?us-ascii?Q?BxEgQsk8dCymjGKm9FPhwl5vU+cxwX01hVVUL+6PzHMEVSjG9TzMRjzNoweB?=
 =?us-ascii?Q?Qh5ucjerFmweC8ZgU85qg4IMJ7xSi1kTKDcdoBKRKF8iQElHLZefiy20JF6X?=
 =?us-ascii?Q?n+4Kpdk0Nm3Onuj+wRyhsMclCGvmLupX5UlCA+ZXATyoPYrALyz4h8luEEei?=
 =?us-ascii?Q?s2t+GlRvR3QfBTQvXAwfdrprpct+4z53H7YCweAsKDUa2A3lCNoVQX0ycAip?=
 =?us-ascii?Q?3jOBXCzFl8kNIV3GqecX78+VvL9KIXOQFy+5AFXhvhfDNP+DuFJ/vTaVCbc1?=
 =?us-ascii?Q?3nx6iAL7bCJycqR2Ldca12V4rIa+NNEtiWFdu3xoNOw0hsOb/DKQEe4PYbB8?=
 =?us-ascii?Q?KDuoqP1p594GuRWuSk+OAofKv51oAxTzb8obiEbWxo6KmTx9qyvbBKN/K9O/?=
 =?us-ascii?Q?/kduwC5QuSuQG//LB5APV/P/zbSfg+8O+ErPCxulxzcSUBwWg5dPKoUmpiK+?=
 =?us-ascii?Q?8dczMR1wZf/gCIdRVpKdULnYgGyPx39XnOY6HL8nKzqQzrvktDs91bsCo4x3?=
 =?us-ascii?Q?UBNjrIm7VNAUgSG/sAFTrvN1fWGZ38yBE3CMAC/dLxKF9tIPrMoMsiHa7Vm8?=
 =?us-ascii?Q?Nzw7Jcs7qGe471GfpeqaeS9FU+J5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Yu7XDPs8TBpstJy6ZI7c4MiCIOEVo7RG9picZWoQDWe5zEqJfxKEUwzND1PY?=
 =?us-ascii?Q?SMSP1fnOaOlaVu3RvM3/kl3LR58Iw5EdNOyVo7y6Zh3JV+qO7KmzLbCXCkut?=
 =?us-ascii?Q?/GRV+UVv/RRNrpRu7hib8DQZnCQMahzCflviCqaUF66xGAM0J8dtmKIhJ5uR?=
 =?us-ascii?Q?cSM61ySXAeP3JIQ0YTVYcDsRzkvsuM0rAFfDfXZIPrcwrOmVXtHr6Y1G3wQV?=
 =?us-ascii?Q?wPcEwkfG1uGrxPuyisiGsZgn5w/o2NplOBEBrdUce5SDshOgljXGUeK3xg7l?=
 =?us-ascii?Q?SAzN9qXMVUBk1lImqbHyes9K1f/9V6JFf6nuJAR7Ml8GuMxMDgLV15pcUQtg?=
 =?us-ascii?Q?TDODwJB85dNUCJqRSVqUeeMgrnP02g0SMsPwH8Bh1LZ35IXLAV9GDNPPIffa?=
 =?us-ascii?Q?Vbqp6/e9pkTsuaD4LE2cPID6zsHWDxrsFhQNmVbTyf++s6rNfUpFqCaUIf74?=
 =?us-ascii?Q?yhtXoS4IjWTvQamTwxifZJwuse+p+ARJPDhyfQwgxe1PuiTNqWvDabgufIWc?=
 =?us-ascii?Q?oaJ+fkNZfbWeZcgIsmelCmHZaMCOACQLjL9cu2l2wptqw7D9tB8SKNi2OZOC?=
 =?us-ascii?Q?uGyNUe++e8xdwKmE+oo7ITaEpTF9wVHZayMF67ASoNNI7KhngetKepS5CodF?=
 =?us-ascii?Q?yfNT1wHZRyMECVblo8c3BZsmgPmIxLjJR8baanKk/eQlTC2H61jVVJov2pQ1?=
 =?us-ascii?Q?HuuNc/5rw0nNOPhKxZmoyBIO1yBKqn7hvImepQ3oBCWkw1hO+Mt7rMeBIxUv?=
 =?us-ascii?Q?M3H1Ykt41b7xjeTSgJTx94SGImhHOXn6Ee6kII98eaZWFFzOFrvFbrhG1445?=
 =?us-ascii?Q?ZoF3oOIjNA8gz5lfj3iYlkaYg4o9/2rg68Ckf4cumGjEal26JOCbaZfKCki1?=
 =?us-ascii?Q?JCgMIUAq6qKHLfDI7O4ypkQ0yl6BNw2j9zV7BOL3riRvR3iF7srflBL3phmq?=
 =?us-ascii?Q?e+azPd+35nK4Niz/fGkKt0QuM4xJQaRZL/vLRuVDwInRNnyQ5QRkcyCACm8u?=
 =?us-ascii?Q?lYYp8pDpPo1noAsLheotlBVuN0QeMRxgBk/bm38FAhOmrSba81djah9IKZey?=
 =?us-ascii?Q?6DshTwgqVPLTHeE/8SWwvwv5vvQ75OUDM3Y2qdddREPRY7poJDxoQ41QPeJL?=
 =?us-ascii?Q?vpb4gvNZi7R959+txd5ZOvB0sBEDKenOzz0cbd3fNS91hrSx5U1QlWCcqy+K?=
 =?us-ascii?Q?0vxYr/woSu+c7aa4q7vRc7mJs940hM7robd1fEM+iBTYcGRg1kGTM2SNJaDG?=
 =?us-ascii?Q?CRy0FVxC+bZNIjENLy4kfpPz8is4+4b3vD0DBqUdWbzg6207egN9H1wGJNkr?=
 =?us-ascii?Q?FT1BrnfWeI2mBPLtUccvUHBpUHqM30nbu7CBwhmrMgEL9SBFPLn8y6ZEgs8N?=
 =?us-ascii?Q?Wyvp9gEhFkBExn3PdT3NOqOxfD/zQtEc7BJy4u2nc2t46R1fkUG9+qAdXite?=
 =?us-ascii?Q?ZV01GBaE6gCRrqX+JkecLLIa/YPJiMxJ/IgGOfMr6/ccPFBhFn3Ijj+kHQlr?=
 =?us-ascii?Q?8apzHkpzoUMSV0f1VFRVrmIm1qiT4s9ipBjLr0U1G7XU2Nne3adrI7wA/3ZV?=
 =?us-ascii?Q?tZoKA1t7pCjSHYCm+to+wF4GZuaTEdIpKd820rqS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca868854-c616-42dd-fc99-08dd49f32f55
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 16:51:38.0101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SBylDH0WZry4b5WMhF7DUMiMYJqdTnBdRZqgZIOZ4Yv76NKTIitCpBSjw6Or5C2VLR4lo/d4lmqublFlk9tGaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9473

On Mon, Feb 10, 2025 at 11:41:48AM -0500, Yury Norov wrote:
...
> > > Numa should include this via linux/nodemask_types.h, or maybe
> > > nodemask.h.
> > 
> > Hm... nodemask_types.h needs to include numa.h to resolve MAX_NUMNODES,
> > Maybe we can move numa_nearest_nodemask() to linux/nodemask.h?
> 
> Maybe yes, but it's generally wrong. nodemask.h is a library, and
> numa.h (generally, NUMA code) is one user. The right way to go is when
> client code includes all necessary libs, not vise-versa.

Ok, makes sense.

> 
> Regarding MAX_NUMNODES, it's a natural property of nodemasks, and
> should be declared in nodemask.h. The attached patch reverts the
> inclusion paths dependency. I build-tested it against today's master
> and x86_64 defconfig. Can you consider taking it and prepending your
> series?

Sure, I'll test it and include it in the next version.

>  
> > > >  #ifdef CONFIG_NUMA
> > > >  #include <asm/sparsemem.h>
> > > >  
> > > > @@ -38,6 +40,7 @@ void __init alloc_offline_node_data(int nid);
> > > >  
> > > >  /* Generic implementation available */
> > > >  int numa_nearest_node(int node, unsigned int state);
> > > > +int numa_nearest_nodemask(int node, unsigned int state, struct nodemask *mask);
> > > >  
> > > >  #ifndef memory_add_physaddr_to_nid
> > > >  int memory_add_physaddr_to_nid(u64 start);
> > > > @@ -55,6 +58,11 @@ static inline int numa_nearest_node(int node, unsigned int state)
> > > >  	return NUMA_NO_NODE;
> > > >  }
> > > >  
> > > > +static inline int numa_nearest_nodemask(int node, unsigned int state, struct nodemask *mask)
> > > > +{
> > > > +	return NUMA_NO_NODE;
> > > > +}
> > > > +
> > > >  static inline int memory_add_physaddr_to_nid(u64 start)
> > > >  {
> > > >  	return 0;
> > > > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > > > index 162407fbf2bc7..1cfee509c7229 100644
> > > > --- a/mm/mempolicy.c
> > > > +++ b/mm/mempolicy.c
> > > > @@ -196,6 +196,44 @@ int numa_nearest_node(int node, unsigned int state)
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(numa_nearest_node);
> > > >  
> > > > +/**
> > > > + * numa_nearest_nodemask - Find the node in @mask at the nearest distance
> > > > + *			   from @node.
> > > > + *
> > > 
> > > So, I have a feeling about this whole naming scheme. At first, this
> > > function (and the existing numa_nearest_node()) searches for something,
> > > but doesn't begin with find_, search_ or similar. Second, the naming
> > > of existing numa_nearest_node() doesn't reflect that it searches
> > > against the state. Should we always include some state for search? If
> > > so, we can skip mentioning the state, otherwise it should be in the
> > > name, I guess...
> > > 
> > > The problem is that I have no idea for better naming, and I have no
> > > understanding about the future of this functions family. If it's just
> > > numa_nearest_node() and numa_nearest_nodemask(), I'm OK to go this
> > > way. If we'll add more flavors similarly to find_bit() family, we
> > > could probably discuss a naming scheme.
> > > 
> > > Also, mm/mempolicy.c is a historical place for them, but maybe we need
> > > to move it somewhere else?
> > > 
> > > Any thoughts appreciated.
> > 
> > Personally I think adding "find_" to the name would be a bit redundant, as
> > it seems quite obvious that it's finding the nearest node. It sounds a bit
> > like the get_something() discussion and we can just use something().
> > 
> > About adding "_state" to the name, it'd make sense since we have
> > for_each_node_state/for_each_node(), but we would need to change
> > numa_nearest_node() -> numa_nearest_node_state((), that is beyond the scope
> > of this patch set.
> > 
> > If I had to design this completely from scratch I'd probably propose
> > something like this:
> >  - nearest_node_state(node, state)
> >  - nearest_node(node) -> nearest_node_state(node, N_POSSIBLE)
> >  - nearest_node_nodemask(node, nodemask) -> here the state can be managed
> >    with the nodemask (as you suggested below)
> > 
> > But again, this is probably a more generic discussion that can be addressed
> > in a separate thread.
> 
> Yes, it's not related to your series. Please just introduce
> nearest_node_nodemask(node, nodemask) as your minimal required change.
> I will do a necessary cleanup later, if needed.

Ok, thanks!

-Andrea

