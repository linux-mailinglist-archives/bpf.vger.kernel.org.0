Return-Path: <bpf+bounces-53754-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9C6A59CDA
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 18:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C8611888DD8
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 17:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB75233141;
	Mon, 10 Mar 2025 17:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gY7h4zhx"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACB62309B0;
	Mon, 10 Mar 2025 17:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741626939; cv=fail; b=bY9r6Ve0tLF6iyV/7FIP6a859glZX5SRvQAUji1+bLcK9iEpQiHPmsoz1RpeWisjL8T6leOpJ9pmFLXp19J2DEumore5r94XSkaacLiIYWT2ajPMZIkUyxk3/fCahUCBJK6oJKkQKgpiEGhWULdD+VEDqqpk2QbZ6BgDbRZQqro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741626939; c=relaxed/simple;
	bh=VMlrmcanXRJ2qpJDwUi9ismHx/WHtFn6KQXO8OBGDo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=J5WJrILuCVVlODludxwgaEWnmHZ2daE0lhCjtBnlpsm7Y7nNppwBviy/ZbvEOwIJLH9+2ZHv05l1mk8xJiRn6sd4g2iWPjHvrMVxVTSTFxO2D1veo9vuY71U5I0E6trfCBFBhmlJPKIIKq2hHJJGlwT7OVEVSU/T1SbZ+758tcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gY7h4zhx; arc=fail smtp.client-ip=40.107.223.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c3FkaHYQCTTN+mfdNvdbpYL/n2/w37syvwtjymonG7sWr7kfZtePrszB27m/irhrIceSyJhRRwoCSZ4KAyc/c+Vv2LghWWD7cuaPudO3lAjDOM0IFJptzJCnmbX/eg5XqPeZ/f0Kf4JQVJbKkfn/W+FJrxxvb/2YPiRC/5MrO8926PYU3EO5QVLiWbf3sHIY1OBjBBB+YNXn1R5HH92YLfPMUknYSESXG2MeU0QRnihNAchfLitNIor0xuTthJQXmb+anIZE6+Cyz4Wcd94yiYj4Kwz1RlHLC8pW84r2CYYg4C3cmAB53yU2r0IKl055ual4vVemZCIqkcOIxWML8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z4fsCCE9Xr1dyIrS9JUxLF5zYFyTubTRESSINUmKUh8=;
 b=qWAx0DuQlocCTa9FM9KBA2lP92Yb0EOtkEuydNQTLUU3mtVkfpdKx7F7ETfQWvOF29uPShRIo+QBHVSFmWYpXFbUnxq5CyiroHlb2PE2w5GmQ3HZ3E/z4yJJ1bG3WSGCeae4vuIE/0AjwWx3ySiL0n1mJ+JhGYYQ/wWuK3T8iQ9EqvuLlp07aGh6jNcc3iuqLkSxEVTXnIPdvii7vihfFDQ+/F9NftQB9diKSx0W4nmMeCx7BRLRKaqBTexa+tChPqhN2PmRO7zKMC//mbx4W/W3f+jlA4wQojFG5P3MUx+HqB6SgTHDzkcD04ce9Uy+qPVJ11Mg5AmoV5N2SAkw9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4fsCCE9Xr1dyIrS9JUxLF5zYFyTubTRESSINUmKUh8=;
 b=gY7h4zhxY8fkZ3R100zCXB2R9T3l28oyxdcEy8zxA4eqD6dBqRC/exQDVqoh/EWJJ842frZtz+YIBG62PoqULWf21Zj6xu5dJBnbc1PVmDcY8M/84FkV36kmMBoQUsDVtGh3Qf7x448Izh/YOOs5eRJWY4UD++T0qiJq+RDh88k1eNtjtF9xzqciA+WYiMbIS8UuMHQVN044mnSUAnSNEJKSXVkoVN22+F/pozE79NWuCio89hkZj0LO/U71mLAKxVm9w/jo9Hk1NDbIhn6NUNjewhII+T/YqLCxLJuLp5OSy/FZ+x8sMu8KFaF4/nWikojDl8RB1xhaIvQkfkMalg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by CH1PR12MB9646.namprd12.prod.outlook.com (2603:10b6:610:2af::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 17:15:36 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%5]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 17:15:36 +0000
Date: Mon, 10 Mar 2025 18:15:25 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] sched_ext: idle: Introduce the concept of allowed
 CPUs
Message-ID: <Z88eLdtwNzpkde02@gpd3>
References: <20250307200502.253867-1-arighi@nvidia.com>
 <20250307200502.253867-4-arighi@nvidia.com>
 <Z8twc3pc7I9SyIMC@slm.duckdns.org>
 <Z8voSv70QuxuZa5Z@gpd3>
 <Z82sImYF7jOgPGbL@slm.duckdns.org>
 <Z822PGZLYl1Vima4@gpd3>
 <Z88OOena_fucXLVl@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z88OOena_fucXLVl@slm.duckdns.org>
X-ClientProxiedBy: MI0P293CA0002.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::7) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|CH1PR12MB9646:EE_
X-MS-Office365-Filtering-Correlation-Id: 75e98f1b-b578-485e-a5eb-08dd5ff72c41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ING1VYjVcWertUvejkm6mSVEVf5qoe4tNcxbyNp20hxb6Z1U+EXRNL99HptY?=
 =?us-ascii?Q?X+JQUBSUrWmReDwWclJC17g/pBFLnPFh7d8JNYXKVVf1wXLhOMepz5HPzCLV?=
 =?us-ascii?Q?Jj9rB/v9DqnnmqahYTkkDl9+ce7U8XNx/7jgIB7Eqs2M6+zUPzull8L3aunx?=
 =?us-ascii?Q?w/a31t+oBSsH+sbfwmd2A/eQcKuLQYtCt4rn0mYtSpkef6Y+oHFnygwekugw?=
 =?us-ascii?Q?oeEWc9HufMrnNpp6NoIPqp95Bg7updttoBl4sUkyVkBDeEYIbIuBD4FU2F6G?=
 =?us-ascii?Q?Og3IIsjOW0mwzl9I7wBtWyvHs/kPDeofijoE8cgDHCkORFfOsnXEe9LvI79D?=
 =?us-ascii?Q?eORjh/VJoKLQppJtm7SK4fLs0pOpfNB9xTQgQtGHWFHVxOHro/H7fH/+ifP7?=
 =?us-ascii?Q?d+boKJ2opEXRNd02jYzZIIyChgRCeFZScCr5ZjJSd2oMETcZAiw7aE/XO8SV?=
 =?us-ascii?Q?xpiYbMTy5jFwk4DnkU76VNCfVvyT7uM+5AhThcIFwaqFYurHJmX8ZqpagKuB?=
 =?us-ascii?Q?wdLtLxQ8rAbRgK55u0yVXdcd6XYamoGUAvx5/TYCapkMr6v0uAZ7wu7ryYlz?=
 =?us-ascii?Q?gQI4OG4fJvq2vVeEaQavVUA46mLhfMbxRPWeT9UowTkIfbXj67ldmnfxMTEU?=
 =?us-ascii?Q?ZGbJ2iXfugBPG3+8ZSfhj7N3vQt2IR+5LnyO4TQ9RM2eklswKV/h90oWSMN7?=
 =?us-ascii?Q?BycM2E++IPX2Mpu5EDXUB++NyrqeOxVX0nLHmTsZ+7Wjp7ACGJfJwe9m5Qj0?=
 =?us-ascii?Q?rjFaYgWebe4T7y7omtkaGV/CWx/7b8IY+0ndq11Okkr9+RmP7TqTF29s4PbB?=
 =?us-ascii?Q?aSHiwbc4bIa3M9d2If7bKam0FiEyhfW+t2xrQodfA9suxladdLKTKdOKMQup?=
 =?us-ascii?Q?F+TiXB2Oi6lWdHuAEzbk+KETgcYlUnXKRAfPZSFvbobLhwip6J9FgI3zbBCR?=
 =?us-ascii?Q?36PB/JR+X96aYLKtkcjeBdBytcXkfo7gJz0AEF/1opxCcSNhdeH1eCWewxq4?=
 =?us-ascii?Q?EyCW3jE19U6pztsNFYEp/di3wmnxQO4Kb41LKOCvtRh1YCwcDDYRgEPTRNWC?=
 =?us-ascii?Q?yrvBjTLgAF94pDWiRIKUOiWRBNjqOCbzStmLOl8uw2OlDh7PtDdr31Bqcs7B?=
 =?us-ascii?Q?aATi/mxQ7GKJFGOJb8Fddb6+69HWMnDl+dcmJkHCC1XvB1ZueyvQxeowYB/w?=
 =?us-ascii?Q?lNABSdTBmtCczsTrlh0prYzCjyvmQZCOdKQeJHAsIyl4SBMOPFutw1stxurT?=
 =?us-ascii?Q?DVNJzimtJIc4oNbY89b2DfW4LvGkLvqUxO8v4ldjTOKnv+2DfbjntTCYU3eN?=
 =?us-ascii?Q?UNJbCreF7G/GUUYOSo5r2WTwOF2PMeConjkc+QgCr3Pjv3BM/06W7rbtOk9M?=
 =?us-ascii?Q?SuXDEnYvSk5jmy52H4J/cbFGokfm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L2X67L2BAvdSZHyjQZpwwvYy9X7RIpcDALS2XwK4SANWj77z+pR0mnGdnyrC?=
 =?us-ascii?Q?iGrfkqIitEv5pEMZsRz4RZHdLQuvwTKaHp9mKinQlnCc7STI5oCtCb12Xmtv?=
 =?us-ascii?Q?j6CMg2aEHlWqeuO1oSmfBB7SiLkw6yYOiOL2ZFzcQQ5cFoGvh5buqtxOjbg5?=
 =?us-ascii?Q?jQKYSraa9yC3q06rynA4YYG0rUmHrN2DLH3tP64DK+w/XuAtxShKZgcKeXUI?=
 =?us-ascii?Q?p9jZ6AfpY+mHL2DDbeKj329Cwa4suSnsWE0dxvEBGcN2VZp8nmZT3RQmvsyY?=
 =?us-ascii?Q?iV1XR74FfmmcZe+mZleXqV0kP7QjTcNftbkzTkzEYrAw7NV0oqZcM4cEwunt?=
 =?us-ascii?Q?rpbL5P5WGGKO7J7tCGBrA4sghzkXSkQzormjBAAXBHkETqZvXJIFK/B/2VT1?=
 =?us-ascii?Q?/sN33ohBAWR9ecUZvHt6BqG308nz27lUGoQz6qf81wz42ovsLDMqF5b3xUbS?=
 =?us-ascii?Q?qwow6Rt++KKlqszlIUOqd5X6h6aDixXBY02pjP0LPOPdnQwsYBvY1w9iJOGg?=
 =?us-ascii?Q?jnyJxCPQiWdErJ11Z7mdb47HHWzdqTM19iAORuWTQtqNiHUEUwUH/GtRTtED?=
 =?us-ascii?Q?cZyu8blzHBQW0M7jPFxI64OQKmvNbhrXNlHjJDGtgVxbgNt5WXmuakcQZrTW?=
 =?us-ascii?Q?3fZvDDnbqyNYt6rIUWPNMUDeQvGGqRI86ij77ium8Wtfg1jz8SJAdKh6n04R?=
 =?us-ascii?Q?P1MQvqOnoINDqyPh72iqOJFvCAVp94MKoQGWAjKcLI3Dlz4YWNu3wP9nek37?=
 =?us-ascii?Q?rc4ginQ3y6moep8wm9OK5nNYpEuDSnclUWqBA5EMLkniZXKcr7KJY0/6B1TC?=
 =?us-ascii?Q?LhI6WfvV9MpBX0s8FVPghSGbSK9YuxNly6YSvV/HOXhGCSJpK9KkOUhTLE/S?=
 =?us-ascii?Q?vg9xgyZ6es4ilsueR7Zbf8tvCk5WGZ5CnGbn726uc+ikK9kBBhz+fN/UIgj7?=
 =?us-ascii?Q?YnemHNKua9HEMTJOpzCatkBM2pFjarWE1yxdOPyBhjsVEQ8fuch5A8MDqCvE?=
 =?us-ascii?Q?Rw5BppUrWnys9wX9P+2N6HCgxtW/1pRysNSrOJ9DtxZN2wcLO9uLvsjRzUKX?=
 =?us-ascii?Q?t6TaYPWbA1g5mwStiGnwSqrWIDwKm8n4WjSC9iZ1vOOWVO3zbd/MmY2xQzZ9?=
 =?us-ascii?Q?X1f5ef292RZbAqAUZEXxOaEf9MeSj2Xvz211AXLvPRfC6PCPOTa700DXp4hB?=
 =?us-ascii?Q?FZ3HpY8UezJdJG+wHmwSmKmPuuYmi+12whak3ZinL0u0pB6frMoR5o5VL2WO?=
 =?us-ascii?Q?5miO+AO93DgavhaqaE7gvPLuKzndbYXwl0gUDutTs8x/ZpH285CeOCxoWWla?=
 =?us-ascii?Q?WK/xjgzeQuBwNhr36SVfe8Wb29LslZhoF4jBKRGMKRW+ZADtAwfhljgw3Mdm?=
 =?us-ascii?Q?sui29UU5v2N75uj6bNFxWy8fwZxtfkiN8/gwrJdRosMwNY3z1wqRv++gvEEu?=
 =?us-ascii?Q?89b9TBtv5WzV6iHOTtDHzzj/3m3e/K9/ZcEJTLLOdwLhzMoPfbkm2bVelNka?=
 =?us-ascii?Q?hEsUum1qSshminEqJtdDPmXyVIcHx68H12fPS1l8HHX2yvDtu1t7cRllYHM2?=
 =?us-ascii?Q?YFhlJ3yEds8visk5rZkE0/GHzOVrzCbNC4cWYdWW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75e98f1b-b578-485e-a5eb-08dd5ff72c41
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 17:15:36.1701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 76pg3x/KS2dJRt6zdVoC/fjUHTascJg0291a88l3rAuiqteJONquZaZal0M0FAjp1P0iElnqShXewoSSYqJzTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9646

On Mon, Mar 10, 2025 at 06:07:21AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Sun, Mar 09, 2025 at 04:39:40PM +0100, Andrea Righi wrote:
> > > Would just using a pre-allocated cpumask to do pre-and on @cpus_allowed
> > > work? This won't only be used for topology support (e.g. soft partitioning
> > > in scx_layered and scx_mitosis may want to use multi-topology-unit spanning
> > > subsets) and I'm not sure assuming and optimizing for that is a good idea
> > > for generic API.
> > 
> > We can pre-allocate two additional (per-cpu) cpumasks to do:
> >  - cpumask_and(numa_cpus, numa_span(cpu), cpus_allowed)
> >  - cpumask_and(llc_cpus, llc_span(cpu), cpus_allowed)
> > 
> > And update/use them only when it's needed. In this way the API would be
> > generic without making any implicit assumption about @cpus_allowed.
> 
> I'm not quite following why two masks would be necessary. The user is
> providing two masks and and'ing those two masks result in a single
> cpus_allowed mask which can then be passed down to the existing pick
> functions, no?

When you say the user is providing two masks, you mean p->cpus_ptr
and @cpus_allowed, right? Or am I missing something?

So, internally we have three levels of cpumasks, used in this order:
 1) p->cpus_ptr & cpus_allowed & llc_span(prev_cpu)
 2) p->cpus_ptr & cpus_allowed & numa_span(prev_cpu)
 3) p->cpus_ptr & cpus_allowed

The current logic (without @cpus_allowed) is applying LLC and NUMA
optimization only for tasks that can run on all CPUs (p->cpus_ptr == all),
to avoid doing extra "and" operations internally and simply use
llc_span(prev_cpu) and numa_span(prev_cpu).

With @cpus_allowed this optimization doesn't work anymore and we can't
just re-apply the current logic to "p->cpus_ptr & cpus_allowed", since it
would result in ignoring the LLC and NUMA cpumasks.

Maybe we could use a single pre-allocated temporary cpumask and do the
"and" at each step when it's needed, instead of using two separate cpumasks
to evaluate "cpus_allowed & llc_span(prev_cpu)" and "cpus_allowed &
numa_span(prev_cpu). Is this what you mean?

Thanks,
-Andrea

