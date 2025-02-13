Return-Path: <bpf+bounces-51448-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE77A34A3C
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 17:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BEED17322A
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 16:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61C3280A45;
	Thu, 13 Feb 2025 16:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aE4GqxG5"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13DC280A3A;
	Thu, 13 Feb 2025 16:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739463748; cv=fail; b=egOI2q57iP3J6BWg5jnmTH/LPaGh2IsMjkR/+LuBTkdj2O4yCpgxXkaTHKDuZqzSNlYTFQ6Sv4tyrAWCZBsrbGR5wv2abwgxsu9AtzKfkaNptFiNns85PrXyLgLi2A0JKOYsuED5nYGy11nFn4NrJvM4/zPYL9CIwuitsjQvuj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739463748; c=relaxed/simple;
	bh=YM2qLD24y66piQ+GdtGtYu3mACCqVzBE0sMDKS+4wBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=k9rnWvA9akrTnXd8gtRwyb7FcId4s4sqZBI3g8pmiE4JdCLiztNrRHB4NjZNV82am/MMc4K1R9o5t6pEDj/ZrIwYyJi/gb4weCW6ILTJ+EgURqpI9+AOagpiTGYG8KspbkEuqshFB6UQdvlGL4t6jUhzWiAElnR2romOxMtLJh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aE4GqxG5; arc=fail smtp.client-ip=40.107.237.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EFRjeC0TsqhhKSHAWVN0y2cagOerQ29n0kLMiVrM0e0S1MHNDWcO+LyfylLJjPvUKU1YB2fKpZKDvBQw94q+LgAT/IfNcviPKLGQP5pPJLUu8sYqw7N1P9XugOMu25pvDG+n/UmAowIoCeQXfBt30tDy4nIHn6xBP6XSgeS237j0BbwOMoQ89q3Nn+LC6bl6pUKjApwbpm0bujShSsr2q+8EaWLKv+4ryr2hrdOmivDwrBsPXLoVPwMXjwewgRxQ5IIwIvGbSdEfXzj8ekhvT9IeZD7BFUfCAKj6nJNUiWW6fFRH3qBstktvPAC0n7TDUCnFHYYILnsP3pZO2sW/Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SwWhwwiVSKhnxyU4BqpG/Ah5D+xpCqYeiNZ0lSdvjBA=;
 b=Bkfu/NdTAVf+KhrxR3vZMnFzmX8l0JuaEROR1Tu54HVJb1DFL0dT+GLMZYHbq9iK+T9/qfkX0LQ7bhbesuPVS86bpxOtEJ8+fHiYuNkhAqoVDWgFjJfUyjR7Q8sElc7XeWuXBS0QhfxosdlHNqdgoyiL1pJwTJ7cyDTFOrhniDTeOnoiuMH+INXKaka6s9NsSW9pv5lJmF7lxWvq/5PaNACJ4Z8ZFf3Fb1McPV5qZNRETdNT6T2WYWtzcnx9hUQ12MVb0cD0k4C+osVNtgJwNjQ8LJbPK2BOGFZCa50UmGup+6kZ6enr7zy9Kz3pPTju7V9c6ql71wN4P0XoxbEzlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SwWhwwiVSKhnxyU4BqpG/Ah5D+xpCqYeiNZ0lSdvjBA=;
 b=aE4GqxG5Q+FPBbEu3ydPGyJyCi4zvw1TdoVrxpPHaBhX6bOd5gUan63DiY58bwgbO+IIi/NTSjhMOsv4s+1u38oxLrNcjaAjT0E99SaIRzzeHcOPlmLxi8H0FyreO1ibOF3WAaNY/s3ypZrGZL30DZcClmKFVE3vPr9iK23T4ZlYd8//EzMGOrPm9xSdg91HBV/afUw/QUNHDidj+09mU7z5E+R3SKXK/ld7rNL8DCDbiMcgYBzl2WgHf6xi/pXiNiaETvMR/wYK/bpAahHelp+UxRlgjBRUAHj9OTP9YRXJCeDtZbBQo6I46/XbRDDyWqfy9vzD0PeFC5uiC1cvaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by CY8PR12MB8067.namprd12.prod.outlook.com (2603:10b6:930:74::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 16:22:23 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 16:22:23 +0000
Date: Thu, 13 Feb 2025 17:22:19 +0100
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
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joel@joelfernandes.org>, Ian May <ianm@nvidia.com>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] sched_ext: idle: Introduce
 SCX_OPS_BUILTIN_IDLE_PER_NODE
Message-ID: <Z64cO6Y-aWUT07vN@gpd3>
References: <20250212165006.490130-1-arighi@nvidia.com>
 <20250212165006.490130-6-arighi@nvidia.com>
 <Z64Y4Sgw30Pdj81J@thinkpad>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z64Y4Sgw30Pdj81J@thinkpad>
X-ClientProxiedBy: FR2P281CA0023.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::10) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|CY8PR12MB8067:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e6623ed-08e7-4061-81be-08dd4c4a98c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cD07tkuTlw+FW5zrDIqgxrwjNLYF/6yxzY6wczDYmhlLgzrTynlpt4/clxw0?=
 =?us-ascii?Q?wlv6YAKLqOByza83rl2j8q23fkz8/iMuMg7+VDuAWqG6gQ9tVG69y2ERW64V?=
 =?us-ascii?Q?MgUELS/Wah6OQqPJiZlCgezVXnUO7TwtsorpDrj4CqMKlqGWd0MHhgtyuAR9?=
 =?us-ascii?Q?/e6xG3c38CqjkUfxc2vpD/rsLKj0JCbLtBfMxBphZ3KBywWcfvsob/5p1vVA?=
 =?us-ascii?Q?OLgG0ddd5Nq2nltCPiDWclDnTj+lh2IiiQq63xFFqAy7/9naAs9jK314TFFf?=
 =?us-ascii?Q?WcPPYI56Yv/13wQ/IAFTt7+pzmsjIYvJpfMQcI8hVGfXHC3XkcuZ9l+A/l5K?=
 =?us-ascii?Q?MJm9E+sB7LrwAF0rbSlLpHycPqdDWVIZPi4YCDBTX5fx8NQMzDmMItB91DXy?=
 =?us-ascii?Q?m2tPN0z2JggerQTiax3WWzdx3naZr7n5hh4aQslxJ4GvqlD644iu6IFAMxSa?=
 =?us-ascii?Q?SfoUbfBkOp1AVn99n+ISnpvn/yr1PS/dfQwpafZTmRXEZ6JOvhxOVhndapf5?=
 =?us-ascii?Q?fDdYuUj6kAin6xJ6AVFSs6Oc+BGmn1uSXv0MvL6dL87ptIlMby0MPLNOD+CL?=
 =?us-ascii?Q?qusbRW8+eRe3s2xftd0dGIl5Lbo3oaZboz9mLyFd8odej35FIWsrmUzyLymE?=
 =?us-ascii?Q?801IwpNOapIN/8AxOC2yscnvmrtAs+/SA0MVjJ82bd3NT4b5bVk7WgWWvO9F?=
 =?us-ascii?Q?cQw+aku4WSXZKMkxV6L9uXWxQBTvE8MGQaoS0KmyEyvjPuSqR2gv8yXadiWa?=
 =?us-ascii?Q?RdlWyI65OHNjMRyjFj56aH1dPq/VzVW2lkVtimCjXw4cOp+WTxQaU2CQ6nQK?=
 =?us-ascii?Q?Kad7hcXOXJO7ix14150W07wnnT+hXbZP7mmeji5d7FGwMiLo+41h6OLuecrz?=
 =?us-ascii?Q?7JnlMXB9xccDsyb/+16MrOqDtDVESkiuxz1utKL9BsY67Uh5XdZznW72uPKp?=
 =?us-ascii?Q?j5VJ852UPvaTuGwDhaxqb0qUf1tTCGZCmNlJL0He3CCk7RcNrdsqpY+DRUox?=
 =?us-ascii?Q?A9iN4jUq9f1niepiKipAXIF5z7Mm0ZXMpxYBEqUMvn9DVSasCAmOYh0j8Co7?=
 =?us-ascii?Q?hVGOimMgt72J+FsIpmiBVsMbP4nt6ly+f0uyj9cH/j96P48fwdBCDp/4Xxw8?=
 =?us-ascii?Q?VF9KcWxUEKIgQ95QuFEtsW3mAp+a1tm+S1MJcusx7RV0lp7/G6JFjMYgzI86?=
 =?us-ascii?Q?d3n9cNfVsVHyZYsARdY0DqXn4lt/M2VtXc0NSehu+bD/gAW6C9OVoXuQGeIb?=
 =?us-ascii?Q?YGmjdIHjCnv+JqDRjQuGO4TLCnpmjk9WJQvZxVHQuCkEbT/fd26N0TTgGr4f?=
 =?us-ascii?Q?BJjh0ZoZRuAcmNRNuzOPulLWMwYuSDBTYUeyCTe//+Itaect7BKcn0yI3LzB?=
 =?us-ascii?Q?xGoaD8/vEtMpFXvhERv5kfvQGbbz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bn1OBOEY6TfenvFuSWT743FvU3Lwmcfm9g1Ci4KvUX4ikoJM36vL5nETZdIv?=
 =?us-ascii?Q?JJhSpgMYnANirQ9h/12Hd1ujzsU+YuvM5lEiQhBcS36X5rnBUX/QSjYwPnq9?=
 =?us-ascii?Q?pN+r47Bc2JIU2sjLWP1rqJPJH5pEyg7Y/nFg/mRT4flylX12zAHzwVDKxPGG?=
 =?us-ascii?Q?8lw66oDHEHhbjuNjY5cQhz4KLPXW68CBDWQWoVAJ0UIc1WJcJt3wriX8C6Cs?=
 =?us-ascii?Q?OCD5L5Iz19zF9G08fmYvrRRfnih0x7kxgO3XNPBACObLoNvr/zmqnYR0ZK82?=
 =?us-ascii?Q?OKW148uo4WAiPPc9MkxoyQsH09QAb7ViR93SXLqPxNIABYJjrRVRxP2iFw43?=
 =?us-ascii?Q?z37E0u918vPzERCQLgMzjnV2OOoQfTcfO+v8qMAKHwTOq6Y6m7yhNCtMUsjR?=
 =?us-ascii?Q?oa1sagdUBrM9N1ftcoH7pmeofpTTXLO3yoH1J+VF9qH6cbTZ5xy4Pt1kflg4?=
 =?us-ascii?Q?+rieanfudBvdlwTxsOEJrfFPjAMcczvgaFwtRlD1N62PZ44/WyFgICT02Aes?=
 =?us-ascii?Q?6HYiLBwrsPFgMX4u4Ks2DCyEm43dY4ybL/aNQCh4bjiC/CeYDddB1lV/JH3s?=
 =?us-ascii?Q?U9cZLqCKpR4g/TYmFQOoBkRNfZ+4MeOgveonGWQW1WaM89drw+Uogp7kBC1Y?=
 =?us-ascii?Q?/nRVRYAfmowy8GLJ7PrFz2cywlckuK8GRUABpXE8FLFRsSkw/eUElzeylDOS?=
 =?us-ascii?Q?JAfjSsrDb7g1RXI6jAs/phkbRdZ1pmJBtMG4ywM16zpqvVBjGJKY4qTXVbcr?=
 =?us-ascii?Q?pmoW2+m25Ea5M3TBzrtE6al77vozZGzphdzQh7VFHwSLR422Nw8TuI0NUByD?=
 =?us-ascii?Q?UZqjV5IM8alQgV+WMZTZcUM1pK+9aMljXQ2sF7Gzi1UJtl2AANA+THWr7Jsp?=
 =?us-ascii?Q?7xrJb3QSHfjH7QpeiMUouUDlEBQdnIfmtcaHmo7BeysLQKnwGbfi+m1oHku4?=
 =?us-ascii?Q?lFljOkQQESWbaqz1yMWs8scgAAi+XzMKEwyLVEtd6CWmJdx9h3Imeqw2pHH2?=
 =?us-ascii?Q?wBO/5MhURPg5TWtioIRjXJmNM78OOEtnTK4oKxFf0WIHUXqXPHb+ny2KWR6p?=
 =?us-ascii?Q?K1P2IUjQemzVckN/4Q026UCWzHwJCHaie+FTEvgBF5R9vnu0n1Ol+V77snny?=
 =?us-ascii?Q?R5c1mSQvY4Rw/pn4y/T+drcAQxC8EzdmTCC7ofw3nTJHTAisNheIpmM7ujFJ?=
 =?us-ascii?Q?azhjbfwdphPVT9vtFomSGiOGgFYWiILaY1/azd7g0KPHMuw6WZJnp4i6LCcb?=
 =?us-ascii?Q?zaMcHy3GEtFdrrBz9l6KAIVhG/RoFzEeNVV9k0GdylX+kUOwrbR1DltkKtyC?=
 =?us-ascii?Q?nX6kKaxSmbykyIJJVKylR3dLhZWFwiwHUM73qqiKYGs3DYuj9c2jzffy5Ji3?=
 =?us-ascii?Q?IPFcSdAQf5LhKuZKTIfKiR5XbN9BG0u1vMjmakDigQtkk+2PYFWM5CDt5TsP?=
 =?us-ascii?Q?QJJ32alZG+Ygms40ZiQRqwQwo2Tu1OIBwfuUWSI6Nl1nKESgqQmc58nZ2bjT?=
 =?us-ascii?Q?SjHv1z/KduUBbHLFNlLR44V82TzWjgvv/DQDbFDzWh7xmblI6Ow09s92NEJR?=
 =?us-ascii?Q?mtlrpwMIyNE9mZnEgHtzNrnali044U+Rzlyjp4F5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e6623ed-08e7-4061-81be-08dd4c4a98c2
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 16:22:23.3278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QyxrZ/g2PSNfiOGh1MOQqjoht/KZs6zfwyIGsrkdNPgKoe3vleirlvsZviXVSTe71y6/Q5xhuVu6vV3xrVtq8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8067

On Thu, Feb 13, 2025 at 11:08:01AM -0500, Yury Norov wrote:
...
> > @@ -237,13 +240,19 @@ void scx_idle_update_selcpu_topology(void)
> >  	 * If all CPUs belong to the same NUMA node and the same LLC domain,
> >  	 * enabling both NUMA and LLC optimizations is unnecessary, as checking
> >  	 * for an idle CPU in the same domain twice is redundant.
> > +	 *
> > +	 * If SCX_OPS_BUILTIN_IDLE_PER_NODE is enabled ignore the NUMA
> > +	 * optimization, as we would naturally select idle CPUs within
> > +	 * specific NUMA nodes querying the corresponding per-node cpumask.
> >  	 */
> > -	nr_cpus = numa_weight(cpu);
> > -	if (nr_cpus > 0) {
> > -		if (nr_cpus < num_online_cpus() && llc_numa_mismatch())
> > -			enable_numa = true;
> > -		pr_debug("sched_ext: NUMA=%*pb weight=%u\n",
> > -			 cpumask_pr_args(numa_span(cpu)), numa_weight(cpu));
> > +	if (!(ops->flags & SCX_OPS_BUILTIN_IDLE_PER_NODE)) {
> > +		nr_cpus = numa_weight(cpu);
> > +		if (nr_cpus > 0) {
> > +			if (nr_cpus < num_online_cpus() && llc_numa_mismatch())
> > +				enable_numa = true;
> > +			pr_debug("sched_ext: NUMA=%*pb weight=%u\n",
> > +				 cpumask_pr_args(numa_span(cpu)), numa_weight(cpu));
> 
> No need to call numa_weight(cpu) for the 2nd time, right?

Ah good catch, will fix that.

Thanks,
-Andrea

