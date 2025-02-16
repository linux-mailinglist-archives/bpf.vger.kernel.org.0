Return-Path: <bpf+bounces-51701-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2683AA3774A
	for <lists+bpf@lfdr.de>; Sun, 16 Feb 2025 20:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0938318866CE
	for <lists+bpf@lfdr.de>; Sun, 16 Feb 2025 19:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424471A238E;
	Sun, 16 Feb 2025 19:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eeTiaYuS"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23028179A3;
	Sun, 16 Feb 2025 19:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739735689; cv=fail; b=C5/ul0rkuHbtc7N3qC1TTnkmMbVBWi7qi4pB2ONhmoZKOGtMIhaPgkkSap4zV0+RwrrSSJgONA9qhxZyP5MolNchJdnj4pmyPjgmPNIE7CiaeAZCdQ2aWYlsC1BqopC5zvq9WTOoFamFfSep+QXJF/8KVCNNNcEXRXlZ3011zPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739735689; c=relaxed/simple;
	bh=oDTa/Gve8jT/obvDXzh09HwN2SSLhDxcrHp1H6Ke/Fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oGzMBlXlqgMrqtYpOR5mNRdQcj77nneLAErFA+E0tDFS8857r6fnyIw6eIubgSMQzGt4AzXprKSlwqpz23iH0fIBKMjWlcWcv8Q5JW15vcjOVPVmmzk/8YDcfahpWunI6uliFxjhaUAXUaCljgM8u0Lgda2ZWhvsx+kbfCdDRtM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eeTiaYuS; arc=fail smtp.client-ip=40.107.94.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q5Q4wIIb10EXayEx7ePblgcb+zOB6lesocijSGRPbWDoK3v3EzKBuIFhq+fqGETnU7bUuwGRHFSRHfam9gXs4SiqksDt9BsyacVA4UVdQqlTs2k1+hJeFg1cRKmgIg9BsSp75T1PAEPlmScM5tcnXIOD9fBfqM+82rCfwiXN6YIaT4h8wN0bbp5I/Ei7zWKQgp89pUnMFSTmnERtUb4D0PxDFBxZ8G4SAffaBfDUWjEf6tFA59KOWDG3jT9zScH14oZDaXINkRTQ6WIlOlDPzbO1cR0Q8JZHw6DbLXB/ig8Svq/q3JbnXkdduFRw6kt5qgD5AZ7N/pv/qR/Ejs1BxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CHwNUInhdzdwznlr3RaoYkLXE7f7l4BunlvQ6Jrb4Xg=;
 b=rbKbxQv7A4G6kgAXAyozhi9QE0+JaR5pjG1Zk9guPtEt6OIG7cJ44BK3HrrqSTMHYKJU8AE65hQyBbVzpxrK1dA+nqzrQ+EKlPBE9rVflQ8nZu20ZIUa3xAD4f6ydgHaFpeUEQ3PraHW/mbopKY+tFPpqCd3qLT+uEyklLNgtbn40gUhGvtCf4QY/GDKs2k+kjMWnIDM+Dbc8V7mTYdP4NhnHDmOAoG+H1zqUAW7Merb53Crb4n0UqI5PbEy2notp9mTtAyIPR08X4luKtN0yffh2VSM1ZvlrlXVSAD0rtvhvOvCNtu3uSBDWsB6+ZfkB9eZovzXewh4BbyRjJOToA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CHwNUInhdzdwznlr3RaoYkLXE7f7l4BunlvQ6Jrb4Xg=;
 b=eeTiaYuSCJN2V3jQLmZ1KfCtqklrX71YyoPrmIXrS/C+1Yx3Ab9Cz5aDXXC0ZVKzBSGDYBWajKqPP81I68jxE+1iG2xYFR/RU2J+oLgGCr0ICYfkMktwALjZgyWQXhtUCU1vWkMb7ZxTJshAkepa6HY3rx308G8OzgXUr48sh8mMMrJSDh6LKmqoI+Arr4c1Z65iCXliIuj5dQmDaSqJ1HoY670osWO37dmNClURhFiLZh/s0Lh5qz1ZlhKeR0aJ/qvTdot3R/0fPFURplWGqpoZJzN7xn+jpzr2AOJ0bvPX+kR7YT3a7lGoPpk1wtVYNUyfVAdEsE3qUtoy4jYpMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by IA1PR12MB8585.namprd12.prod.outlook.com (2603:10b6:208:451::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.17; Sun, 16 Feb
 2025 19:54:42 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8445.017; Sun, 16 Feb 2025
 19:54:42 +0000
Date: Sun, 16 Feb 2025 20:54:34 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Yury Norov <yury.norov@gmail.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joel@joelfernandes.org>, Ian May <ianm@nvidia.com>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] sched_ext: idle: Introduce node-aware idle cpu kfunc
 helpers
Message-ID: <Z7JCeiLpxoZB7rnl@gpd3>
References: <20250214194134.658939-1-arighi@nvidia.com>
 <20250214194134.658939-9-arighi@nvidia.com>
 <Z7IY3yr1VErsryqw@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7IY3yr1VErsryqw@slm.duckdns.org>
X-ClientProxiedBy: FR4P281CA0355.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::8) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|IA1PR12MB8585:EE_
X-MS-Office365-Filtering-Correlation-Id: 3476fd3d-55d3-43eb-c5ca-08dd4ec3c149
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DI4rhRF6ryklLtkhtPFZk9CmJoMG5ypaGXbMfR6KRg5zFxoymYOc3GI/2POu?=
 =?us-ascii?Q?0C2bnlKkPIQwY4oIxL7kBREv2EVzedQ8I3RIOeymFnGEsNB6SD3ExOHeguFA?=
 =?us-ascii?Q?mghWvRxQlSJHLhG3EkkqC/XkYplcwe2m2zfwVkS4Fvo6iCl3dn1VGPebbWQP?=
 =?us-ascii?Q?zcJPxh0F3zHpBJjWru4Ap/rl5+woXTiJ04S3+/nHl5FHjH41/jaFHZ06ve87?=
 =?us-ascii?Q?rYtqlVB8fm6a9v3rgbayM1AqiZ6YYBQNA1GevJQD843/nN7NkKljYDGkRg+X?=
 =?us-ascii?Q?rE6o5GN5KCPUT27TTVPvbpcCkmCktlog9NIv0z0fAISNcUrf4dG6Xw6cHsM9?=
 =?us-ascii?Q?HU6mrfzEJ876N2YyBD5pZjOaNSuVXBS1+8encHZM3gxVO6G09AFaLyN2HM+n?=
 =?us-ascii?Q?hXWGYsIurbz8lrome0IvdhtW8uZyhSiS/tPPsiXIDgnq5zRWBRoflviI3x2v?=
 =?us-ascii?Q?/xyxcqGCb6D/nKgrVEwyk0aV3BYROxo1cIzfPcyKot/YEpCnHaz0PKKyeBVu?=
 =?us-ascii?Q?hPBnaoNWUMK28BAmhf5EW+wceNfCjNCxZWjyqNcU4oLZzByr1okH97Bi4F3d?=
 =?us-ascii?Q?Luf00yLsWl7ZXlh/Cy7fu0VVdqUgE+6bzAB/H/md5nykX38mQ2XW7pZi3HWo?=
 =?us-ascii?Q?OjpXLrXRBLexxpWuAgLYcWFANxOu2UdMaX8T3g7P7bM9ZWizmV54ClCzujd6?=
 =?us-ascii?Q?uolbZEuu42X6dHaQmVJZ1ruPh9MC5m0SPYEkn5wbQcKJ/u0hwumPqE4Wvg2w?=
 =?us-ascii?Q?yJ9WYPnUFsP3T/L/RTAMxzLbGVgcfePlTVDqy/+nYFLoPVqb61Zp16ibWeCr?=
 =?us-ascii?Q?uRzdyq8B/0KedOIeQlB0tIwTRpTK90sv6NsrVLuVJFKREedgB7cdYNMwSP5W?=
 =?us-ascii?Q?TUzlOO+e8NtOvtH+hXymHVd2Qgm6wEZ45JER/dAqOvk3Zj8KJ5BNCatgd/2W?=
 =?us-ascii?Q?L23wbRP4zN+1BPARvj5/ncoWHgudPuBuBQuEUmN5H+jWaPUfvptu3MR3tj4C?=
 =?us-ascii?Q?gyQ1PIbM+blILJn7uwWlJ5flQIu133lD2mfnDu5Us7p5sM44S1GGFL1WzwNv?=
 =?us-ascii?Q?8E5NvPAmPVw+NysC9iLr/2IIhORsV6ir4aTLucKO4BURQ94kznwenLHGic1o?=
 =?us-ascii?Q?Ca3xxwGyxx5xOzbC/IDKzjyXu4RxW5r+TWBo8P+A77FLUI1raStRGsz0vZ3q?=
 =?us-ascii?Q?tnQRHDzw+84ZV6knln+7JG8xNPvXkYuPG13KW5Crw55ZNztHXBa6z8UlzTpx?=
 =?us-ascii?Q?sIEBScxDIcB3cmqkr4vbKV5EXq5nD7GfuBaiinGVKYLUslBgfLVp000btLkf?=
 =?us-ascii?Q?w4277Vk+SJmFt2d8RWSudr1Uh1ThwOiHH/T3SiGymBTh+IgPVEBHgICHAV/l?=
 =?us-ascii?Q?DNCntfPTpDnZ0Q5jJCVhItalmvVA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ibP6zqlsVywCjAdn/yWDTeHU3TqMBVX8/0lzBNbaN3rpR2q2RHJJVuYxe7tE?=
 =?us-ascii?Q?As3akqPj4m3TK/7XL4RWEJiUX/TIZRGXbDNhKGEJNIPlwQhsZ8/s8oBkGoXe?=
 =?us-ascii?Q?2/CxgrflSikLU9FRy/zgGsvqzTyO2evFFGoYpR0T31dako+NXx08Br3FuV1u?=
 =?us-ascii?Q?YfUxSal6mFdtvwzdUH+lyTcy1A6dg8kPc7LBPtxoo7OfAdTTHTZe1AXCR6b+?=
 =?us-ascii?Q?Xms8KFxB1IYgoSgYPhY3IPw3ISKqQloI11v0QJ5mecQUxfosJLtUQJ448wP6?=
 =?us-ascii?Q?n14xEydSJr3IhnRj9Y6TAWFrSu5I6uvmWRhYCqmrCbUMkjyq+uL76SA1qU3J?=
 =?us-ascii?Q?P+eCxUIVqVzsOWyOls1GvakcuLuXaeGI+/Caeex+YlNlga+QH/GX+5Hzqz6K?=
 =?us-ascii?Q?X3WkUQWmq6C6g2rUfaRraD2IhvlPSvFntiJzHOxDwe5PekQxRAzxSJn04ueW?=
 =?us-ascii?Q?ukSM+Epmc77VsJbEsmVBLtFcwJHtQwEIPDBL4Lq3vqlrjJv9BpxfkXynAstI?=
 =?us-ascii?Q?oFStPnuvCSoATAM8DyFA+vF4nY/evizWM1UqTyz99s2wjBJpl68+hYX34wRm?=
 =?us-ascii?Q?58SgICNBbZGH/7l7UutfBBzwZa/A5Ylm5dmrB3vlZNHFzC6T9JQgY4NoJ6Ut?=
 =?us-ascii?Q?Fe8gmKwPlFs2RS9L2hb6sFt6K5jV8ujM4hNhMJbplysr4DRfE7G/R1XEB0Cw?=
 =?us-ascii?Q?WijdfZIpeRAkNQcmm9cTwbHZDe4zoKs5g+/O01OfHj/3XTQlk90pKfUBV93k?=
 =?us-ascii?Q?DljLDw1p75FMIMYo+3SZFrUnN+hDFvwnF9YK1LoajxtBA4fO3ZvM9+iihgNu?=
 =?us-ascii?Q?aoXZ7Ve4dBbmtPwIdTaQJvuJa/Txs+0byr6ZdJSzPhSbZrzNGJr7L77tAaho?=
 =?us-ascii?Q?saMSIJiN7npEO/sfwfMismh1rZF3G6f06Oj85b+Or5K0jTSvE/1LC2yegxI7?=
 =?us-ascii?Q?lG02KnKOr5sBqBiZxMMTwC+22aOFEdIHQ86+kQf1oPRzNGhz9UNZEwTjZXdN?=
 =?us-ascii?Q?irQ/7Ck6WZNbPkMQUnUSpGuBX/8OTni7IS3jdFPD3ERZIXrJPfB7LWUtcOrB?=
 =?us-ascii?Q?NF+pua/gyKQGC47YdbhISHUky1BnGpXflNYeptq7692+z3PHft2wl4ilQlRY?=
 =?us-ascii?Q?T/+U9O8veROoDyUhUOWQvHPuAMQBC+U8+iEr6Jw7SvB+jxXM6noxNc7xUuFz?=
 =?us-ascii?Q?/xjHt/P9H5uHPeXQM1OBsVAbApaS4QPbVKH+YMmlXoBBEBTb1e/ORV27AdQp?=
 =?us-ascii?Q?fz/jxbF476z5cTniUldQYXbOipd0GzAebkNTDcyxXPlTzdub8mOaDTUZjS+I?=
 =?us-ascii?Q?zIATcZXLXGlWoMosCp8aqUMsQqDNRQHQ4//NJsb9XjWWze8Ml1Wndtvvafqj?=
 =?us-ascii?Q?7CR3cMy7bsChkhQ4pcMfqlZBmS9OYqAY0AUer7OTj8y4H18oNORyKf10s8Xb?=
 =?us-ascii?Q?YQrvERKWah499JfYpL77WUqiUenSPmuXZiDeUfQ6odY3E1t52CRSV+Xzo4JB?=
 =?us-ascii?Q?Mg/WgGHkV4SEk6u6aF+CIcu/zDfBLW2lGGs+x/zDcukESZbPEdgUw55eQfZS?=
 =?us-ascii?Q?lgAPJNVHC+A3aHGXLIrGFF0iQxMBNqB6KtjTnQS7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3476fd3d-55d3-43eb-c5ca-08dd4ec3c149
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2025 19:54:42.6342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B3SvA9PVGFnDGkX0wJGAlUKhK5Q7MH5bkYchT26c31sUh7Ae3EX8Nv8ZUVQey9tu1hoYedVb+XpXgkM3VBj7AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8585

On Sun, Feb 16, 2025 at 06:57:03AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Fri, Feb 14, 2025 at 08:40:07PM +0100, Andrea Righi wrote:
> ...
> >  const struct cpumask *scx_bpf_get_idle_cpumask_node(int node)
> >  const struct cpumask *scx_bpf_get_idle_smtmask_node(int node)
> >  s32 scx_bpf_pick_idle_cpu_in_node(const cpumask_t *cpus_allowed,
> >  				   int node, u64 flags)
> 
> All other functions have just _node as the suffix. Might as well do the same
> here?

I agree, I'll rename this scx_bpf_pick_idle_cpu_node().

> 
> >  s32 scx_bpf_pick_any_cpu_node(const cpumask_t *cpus_allowed,
> >  			       int node, u64 flags)
> 
> ...
> > +__bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask_node(int node)
> > +{
> > +	node = validate_node(node);
> > +	if (node < 0)
> > +		return cpu_none_mask;
> > +
> > +#ifdef CONFIG_SMP
> > +	return idle_cpumask(node)->cpu;
> > +#else
> > +	return cpu_none_mask;
> 
> Shouldn't the UP case forwarded to scx_bpf_get_idle_cpumask()? Wouldn't a
> NUMA aware scheduler running on a UP kernel end up specifying 0 to these
> calls?

Hm... but scx_bpf_get_idle_cpumask() also returns cpu_none_mask in the UP
case. We also want to validate the node and trigger a failure if an invalid
node is specified (and in the UP case, node 0 is valid, since
nr_node_ids == 1).

> 
> > +__bpf_kfunc const struct cpumask *scx_bpf_get_idle_smtmask_node(int node)
> > +{
> > +	node = validate_node(node);
> > +	if (node < 0)
> > +		return cpu_none_mask;
> > +
> > +#ifdef CONFIG_SMP
> > +	if (sched_smt_active())
> > +		return idle_cpumask(node)->smt;
> > +	else
> > +		return idle_cpumask(node)->cpu;
> > +#else
> > +	return cpu_none_mask;
> 
> Ditto here.
> 
> Thanks.
> 
> -- 
> tejun

-Andrea

