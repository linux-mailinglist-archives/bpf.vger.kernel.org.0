Return-Path: <bpf+bounces-53642-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B7FA578D1
	for <lists+bpf@lfdr.de>; Sat,  8 Mar 2025 07:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 206AB7A6890
	for <lists+bpf@lfdr.de>; Sat,  8 Mar 2025 06:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD3C1922D4;
	Sat,  8 Mar 2025 06:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Xj7Whrz6"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E3618DB2F;
	Sat,  8 Mar 2025 06:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741416540; cv=fail; b=uSS6xUngAvpiG8NSI2gJIxrqBc5aWE+l02q/vQQOc9/whEjAawGgUeBQyj2ZRtv+cSQRNE71isGXDZfY5z7DZ4HW12EJ7REOQDZpM0f/AoZwWZrtFpa+SXC+E/o2DBiZEM9CsiJPLSdvXAMi+vpdGLpQFmALdBEc5GskqXJjSro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741416540; c=relaxed/simple;
	bh=YLQOq/hkQPEeK3raDvcatEv5N/ZVtL7YJP9x+s32B+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UKtp5Mv7yFika8NeMzvbTYE7L3FHxsxYDUO7v+a7DVfooe1mGYLFz1YDXkp0b5jg3a+if4Gacw6twdETnPJO2/gctpswozJn3g9fyY4f2E4/joddrW50QPn++pO6BSpkbFcylT7Xht/CN+mrHlojxvkkSotgu/yDjZGDaIrs770=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Xj7Whrz6; arc=fail smtp.client-ip=40.107.237.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lExt3JMVtlmPhkaVIlTkkKJIWklGWzPAiCxSHwNlfA1tJte+DgoEnU1GNithgCOUe9ekVsNzWoS9FmqhYbPy7MWs3WqOzFYhJmoyMNvm9549LrzmEtHWOsePaPRkVlYNMHGZ6GJG2m7Qpn//etBcMb2E54N+hEfWDpUZRmlnYrHajlngp3FU4UXX988OEfXnIDGSm3avJF39gZ1f4hPJdKeGAJ9TsnhciHlit/LYW7h03BMbgERSAFEmfEP/Q9DYtD9hQfIQ41osLHLb49sWAj5o0jaT5gz0sjEJYVCZBadCgqOxjz+SLKuTsvO/kg98k5bcG2xBNYQO30MhEooNdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LwZOJNlimonMB3ngqetxZA8YJDZiPprjCHKJxWhF9ts=;
 b=hOwmAfiM3MyopwHMQjGZf6kuRl83KZ4uhzK/7bZFYmJ6va0vyuPqlU98zTg18ekv/0MLS48v2eo/7KMFYs7WLd11+mrss2k+6JNbHPNSE+CfyyVWY2s8zw43Zb6B3AzSHd2R/QYOAEH1Jm+WEvJafrNz/HSggTeWMEib1kHiD3R3fItq+Ehnwp5hZAy+wJqQZjvpMyaVTEmtTvq9/3FfOSY9lR8T1E3Xwheuba7LE9B8tu9RCR6olV6yy3fixFmGwZhQPOuftmqqB/FPWuy4+Vbl9ch4N3roQ/eiPDJpFckQNz9n2wJpZkuO0Q904KmOWfd2RYd7zh3GeUs2U4aQ6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LwZOJNlimonMB3ngqetxZA8YJDZiPprjCHKJxWhF9ts=;
 b=Xj7Whrz6Gm2rXAYbCe1CVPbPHCzoPk2GOxjQETIL4+rkLrp3U/CauZLwvk1SK8apnhHz5WWMT3MBRIr1Uid0OWevSbc86suYzFDrr1YZUy+BEhks65fefB2q0O0GQkNKGQGZhbXUoh7ASPMbM2KnpTRp1BYL7TiU1H5YyavTvh25CTE42SO+7BNwF9fhqxeuUsLN82Ox4uuA1LHuJQdBdxgWaqHS54Lbnfy1+gBoofSCPDgngpH4Ro1leGG4FvyTWgCSuLxjrqaqsQANwgpYB2L2MBQNOZrfAwtx8z2FZzyOGqC6VQ8Tp5i/ET4KwnfGBkGRRKAjpEREdqelS5CahA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by MN6PR12MB8516.namprd12.prod.outlook.com (2603:10b6:208:46f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Sat, 8 Mar
 2025 06:48:53 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8511.017; Sat, 8 Mar 2025
 06:48:52 +0000
Date: Sat, 8 Mar 2025 07:48:42 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] sched_ext: idle: Introduce the concept of allowed
 CPUs
Message-ID: <Z8voSv70QuxuZa5Z@gpd3>
References: <20250307200502.253867-1-arighi@nvidia.com>
 <20250307200502.253867-4-arighi@nvidia.com>
 <Z8twc3pc7I9SyIMC@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8twc3pc7I9SyIMC@slm.duckdns.org>
X-ClientProxiedBy: MI1P293CA0007.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::18) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|MN6PR12MB8516:EE_
X-MS-Office365-Filtering-Correlation-Id: e6640c9d-ff23-4f29-e96a-08dd5e0d4a04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A8lc7I3b8mPd/WekxWzGrv7Pa9Ez4bMvJT2dPs1SG7WfOGwfIvgV1y+xdFLu?=
 =?us-ascii?Q?juyKgT6NE/gsVPJ+Ycv1F+RYTT1Dv5XeuWm+J+Oqm7nO/FL2fECfK5ue1bOC?=
 =?us-ascii?Q?UQkSZPRRu9cLGTSoahqRBjMbNvZaIl5sy3ee7875AruG62sZx6pEXUgM9gmA?=
 =?us-ascii?Q?9NXKO8u0DjSzI421KIkUJvg+ZLEX2rxKnZ0dA1YNcFvJKVeJ1McXnSMKZeTU?=
 =?us-ascii?Q?jmbH07LBLW4bQCTnkr8RHP+ELUPm3CJt52iMz1mTGhxqa25cXA3Sdz4/iOZk?=
 =?us-ascii?Q?QudPvVhnTUNWAujuA5U91jl7M2qDDhLOGKXavgd0ZzDIDuPUZJxjDtjGPPjl?=
 =?us-ascii?Q?KL/TlSybphMtASOS9ibRHTOXlXtA2KDX0T2G/XDa2GvVXvu0ZdKcjuWQ8C5w?=
 =?us-ascii?Q?Vyhc+ob20QV+swqjOtIcdzSkhyMOwKRR28Uub3XxxzP6h3UbYZXfzHtv5wPE?=
 =?us-ascii?Q?EAd4x7gGPbxASVJ/ZxfPAvNY1SC3LlmneDTS5qgfqglKGbVUr+L+3+hK0R/9?=
 =?us-ascii?Q?EV8ancJMHWJszuomiprwgu0QduI1fTRgabCrgmT+tWSzvHNQgi48l4t9BrIJ?=
 =?us-ascii?Q?pFMyPgGTOO0+mmkv/ZYhr9m5hEm+JZao4c86eilQU07otBlY2YBdK2vBhfJb?=
 =?us-ascii?Q?877oSlVMUFo12zWHGfK7pGCbXrbtIoJbCgiTzrZBtID1mZPUc98OehGou5Q2?=
 =?us-ascii?Q?4ACU56GA17EokxRO/SxMXnn5EDIh8VE2KJvU3CQNp5nAcmj1C1HNfng4dci+?=
 =?us-ascii?Q?NlOqL6rdvd6GqHPk7tAZ3fnS+hKgtyqKctAif8Y5pg0DKG8zbPqAcxnf/bC8?=
 =?us-ascii?Q?7L1XxnBwvbKPKBKIA+133dY1//eqC4NjWx/ZDR1Xfbd/yTqE/o0HYhKnzbfx?=
 =?us-ascii?Q?20q16tN6ZxxPj0dQLT7J4CDcSb5GZfi3bq+QpCNliv+2f3UcH9CUmy220CPy?=
 =?us-ascii?Q?f7csR/1zBwE/JNZ1aMyS5GGXzxyheFXgOAIijrSombGFwzW02v5M6lP89ELf?=
 =?us-ascii?Q?iMe5i3raZNFBkDPqWjN/v5CPXJyWz2Koe/rZp1NiHQt22XXOv/qeRGa57tOb?=
 =?us-ascii?Q?Oc+KilDFxQz2OzuM/C1yiRBMLsGhpaQ74mzLYVMQOIzOAnHu7rRmlhtboIfr?=
 =?us-ascii?Q?NU6ScWfipUWrNrwv8z0sqBmh7fxFBNsEiGH21t0lx2iGfJeDaSk8hQyLuCKV?=
 =?us-ascii?Q?9f6D29twVl9EDvGB88PteN204orqkX1XS4UskXmrOdVxD+Q/xfI1rFqQJ0Bd?=
 =?us-ascii?Q?NUMtQgKmsvxTFdKjxNK/qxK8eHWL/i5cof2OkrEgek8uOV6Yh7k98Y8kPK+D?=
 =?us-ascii?Q?IFjBrNPUJPltRvCWAzIeLidlsEhX+d3JT22gsozhf/n98zoH2PLbPBtx/zqv?=
 =?us-ascii?Q?BYXL2LcpMFquoqaIr4oVuPVNivbe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j4LX+jf3QR5HQH2qQmm/QLwyzkiq7PzqPhKwFlLqRLtWlrakurOeTwMyG9uL?=
 =?us-ascii?Q?xQt9JxeCFO7eioAfvNeclz7IO/sO39NZmU9Ck47hO/6sINDvSelunduml5bm?=
 =?us-ascii?Q?M4oCHdEOIp/OPNR/IkTljYPDUjPJS3Pw5Zr57/A1QVUpXT8xV0mjB9By8aUX?=
 =?us-ascii?Q?yCFX/hRV8ur73e9FARDFQ3u4DBksASZLbFyWjUj1nxaBv830i5k1saBgkO3R?=
 =?us-ascii?Q?V4nPOKmvP0QczfdCan0wImDRy6aYRoMZVfBIOhNY0JFGEFVKUPQ6aDyl0g+O?=
 =?us-ascii?Q?v857kGlqLbHnJNYA3Y5ztU3ZWJ0ho2/lm5ncjAYMk2ikeS1rYeHYae3UWjTw?=
 =?us-ascii?Q?9N7Iy/LvRlsb/sOeGGdM7VSaFtP82vXq++2HwC5q/y3/YYnwEr0+i8wfm1iC?=
 =?us-ascii?Q?O4GCcYNqrxIxiPx47qKeYH9YSTQ+TSxj+ZnDtm66K4VvBrkCIRdpe8Ha5IgN?=
 =?us-ascii?Q?3wH7rW9i7XVeO5ATu6rrBuH6SRenU27ZK7Gw0z5852FQuu2M5FoKXWbgC/zs?=
 =?us-ascii?Q?tlS1F/VlkXbVvo6tdEcbbW0Y5FPGLjeIYvKN15m7iHd5EYyo89vNgTiE4erO?=
 =?us-ascii?Q?rJf2eydBSGtxavqY7q3xoA+P/zFNL6FyEjN7jkmkvKzKkOUf916AN0kSuhET?=
 =?us-ascii?Q?FsLQX2hD6kYvL4o/lSkzFl0ao2iZeZz7YIC6V+gxg7WoZXIZP4LPdweh6i5w?=
 =?us-ascii?Q?E8LbaB/0471j2hHnjRAa6au2mKqELndvnou2RrurGZXOi6N35PaImJqOXClQ?=
 =?us-ascii?Q?CzcCFHRdHT1PFNwVql88IVUiOXgq7QjFwJGzfUrJEAZaPEvmsu0Pj3yY7N3O?=
 =?us-ascii?Q?87koP74FQLhbewCR04kBCycrnMu8O8+NsZMUcwfH7e7lppvPyrkIodBCOE0n?=
 =?us-ascii?Q?eQkaabxMFWSQIKRTWYptiHlezuFipCGEOpcLEYKwpeZ3oGVjXEb+E1Pza7YC?=
 =?us-ascii?Q?WoUDjYRImYKFLEb8CCOZYQbb4lbnJNKjo5LyDcjl8XoyfHdDC940F/jwUKte?=
 =?us-ascii?Q?0PC0/s34UpcluTPsLVvhSS7j7/vJc9bTSaK6FuGZtvrQQXIZxTdmauQXZ0Js?=
 =?us-ascii?Q?di9P9XuYzQ+z5VzH0yPCUt1lTsklrEdbz9IiFh0IRL8kpe8xbpJhfSatc9su?=
 =?us-ascii?Q?AjFJ8yHUhOcFWplbGmpkLdEnfhoyd64LZNSCDLgjCrhUUnmHDOeRhnFPRInb?=
 =?us-ascii?Q?d6YgP2c8QzJ02AlEX6zMMv9TwKOckPhGvvPL5LDVoJ2ED/ZRI6o8x7kQxB+p?=
 =?us-ascii?Q?hV4/oiGv1C37jW0f6+RVO7/DpW5OTxR80Oi0QwwOfHycVSuG1PbWxhivYFnV?=
 =?us-ascii?Q?wAMUAKhCJIWCvM+avRFZZEPVx3Izf+6LzfEwcXv14NjO7LdZE8UdVFljLls0?=
 =?us-ascii?Q?hYddUXTU+UKANSj+gCV1PD3Fl83d3RWULPi4nFTBZXPEHfY0asli59XtNtAj?=
 =?us-ascii?Q?8AW67xZOb/Cdv7y4P5z9hEjOtQkZ+mjRtFfrGGHkV4qnBvbVBKPLoECdM1LC?=
 =?us-ascii?Q?c0h8BI4CBv1M1DpIMIXDci/11S2XXaSJb06vUOMKxRr+sIMGt1vYipny/qPV?=
 =?us-ascii?Q?9X2S8+Ovu5K5xBb+6sfJeTp0UyLF9ocppyjfebZA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6640c9d-ff23-4f29-e96a-08dd5e0d4a04
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2025 06:48:52.7762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BLUlqRHjcID7+ix1J1b6+kp5zFNcDGU3PAV11Loql0Zm2791m94KLGn9eKcFojaUO597ezOAINvDuFucueY0Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8516

On Fri, Mar 07, 2025 at 12:17:23PM -1000, Tejun Heo wrote:
> Hello,
> 
> On Fri, Mar 07, 2025 at 09:01:05PM +0100, Andrea Righi wrote:
> > Many scx schedulers define their own concept of scheduling domains to
> > represent topology characteristics, such as heterogeneous architectures
> 
> I'm not sure "domain" is a good choice given that sched_domain is already an
> established construct in kernel and means something specific.

Yeah, I agree, we don't want to create ambiguity with sched_domain.
How about CPU groups or CPU partitions?

> 
> > (e.g., big.LITTLE, P-cores/E-cores), or to categorize tasks based on
> > specific properties (e.g., setting the soft-affinity of certain tasks to
> > a subset of CPUs).
> > 
> > Currently, there is no mechanism to share these domains with the
> > built-in idle CPU selection policy. As a result, schedulers often
> > implement their own idle CPU selection policies, which are typically
> > similar to one another, leading to a lot of code duplication.
> > 
> > To address this, introduce the concept of allowed domain (represented as
> > a cpumask) that can be used by the BPF schedulers to apply the built-in
> > idle CPU selection policy to a subset of preferred CPUs.
> 
> We don't need a new term here, do we? All that's being added is an extra
> mask when picking CPUs.

Right, at the end it's just a cpumask, I'll rephrase this part.

> 
> > With this concept the idle CPU selection policy becomes the following:
> >  - always prioritize CPUs from fully idle SMT cores (if SMT is enabled),
> >  - select the same CPU if it's idle and in the allowed domain,
> >  - select an idle CPU within the same LLC domain, if the LLC domain is a
> >    subset of the allowed domain,
> 
> Why not select from the intersection of the same LLC domain and the cpumask?

We could do that, but to guarantee the intersection we need to introduce
other temporary cpumasks (one for the LLC intersection and another for the
NUMA), which is not a big problem, but it can introduce overhead. And most
of the time the LLC group is either a subset of the allowed CPUs or
vice-versa, so in this case the current logic already works.

The extra cpumask work is needed only when the allowed cpumask spans
multiple partial LLCs, which should be rare. So maybe in such cases, we
could tolerate the additional overhead of updating an additional temporary
cpumask to ensure proper hierarchical semantics (maintaining consistency
with the topology hierarchy). WDYT?

> 
> >  - select an idle CPU within the same node, if the node domain is a
> >    subset of the allowed domain,
> 
> Ditto.
> 
> >  - select an idle CPU within the allowed domain.
> > 
> > If the allowed domain is empty or NULL, the behavior of the built-in
> > idle CPU selection policy remains unchanged.
> > 
> > This only introduces the core concept of allowed domain. This
> > functionality will be exposed through a dedicated kfunc in a separate
> > patch.
> ...
> > -s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64 flags)
> > +s32 scx_select_cpu_dfl(struct task_struct *p, const struct cpumask *cpus_allowed,
> > +		       s32 prev_cpu, u64 wake_flags, u64 flags)
> 
> Maybe rearrange them (p, prev_cpu, wake_flags, and_cpumask, pick_idle_flags)
> so that the first three args align with select_task_rq() and we don't have
> three consecutive integer arguments? Two back-to-back flag args increase the
> chance of subtle bugs.

Good idea. I even introduced a bug while I was updating the kselftests,
because I switched wake_flags and idle flags... so yeah, will definitely do
that.

Thanks!
-Andrea

