Return-Path: <bpf+bounces-53687-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 688BDA5856B
	for <lists+bpf@lfdr.de>; Sun,  9 Mar 2025 16:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FBFE3AA741
	for <lists+bpf@lfdr.de>; Sun,  9 Mar 2025 15:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1291DE4EB;
	Sun,  9 Mar 2025 15:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="brEcDF0Z"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33AD2F2A;
	Sun,  9 Mar 2025 15:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741534795; cv=fail; b=P672SyqTHxyaa4qyMYt27YQgCaSY1dCaDwBO12WgRhq4D8Th9hfR2e7nu9c0RGKmJZ/QWQmKXmdnFze3/Eu3H7eMufPANOLTVjm9W7NHnPCWi+ycuA4x/Hfa8egIjn5JAs5QhFehN3lNkzZXYPxzVymWfbnn2m8mCPvTrNsfkcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741534795; c=relaxed/simple;
	bh=b72F3WP6uVmC36N7acs60IUhIebFtEfkHaZMW58hFz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lVQgaCDgJnUa40h4w/RFdUPLT/fp9iXf0u5dr1Jj1L4n7Ng57Icy6RoY+VKE1HE+RaVrhsI8eU/bUBbt1AGBk2I8cIa0nJe0g1QP9+EuNcN3RpMzKFnd+fX/zLEv66wKwTNC4VL1Kn8vVFXiRookI3+etHdnO1DFYt3q+1HQYHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=brEcDF0Z; arc=fail smtp.client-ip=40.107.93.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZkdnFrn1+EhNjrBlB9n548nQhNl9NRU2xhGHPjsO7YpEhBd+1p4HPSMkdXPenmVKuf8ANpG8ksttVHs65fVyjnxBgGPTvjHo6m2pvHb9LJuYhaaxzqwzJxLuxPwk6ru9UOeAH+/eMmwGFkjrKzMMNOjx7atRIczUHto2ls4zt1nZj4RbBjC25R/bMHcDfISBdfm9aNSfwkRMxMMvCxF5U4wDwpiA2o1wgYDqqA3O5MBHQur0+BjhpjeYWKJkGT3Z0wzU+O+leq/u+PlJJkTLuq2AEztleFpQfXs89A+XHawjoL0BafikXA79Ap7xh+LekLkfKayzRzylueS1bAVWdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W21EOus61kqzIvUJhfWak0Zuwguspx3S7AldD3oY9pA=;
 b=hLbJ444Dtlgqw9y1ugqZorCsYSCVkuTGe7oWy8bKyXQDlVtzI+IhLScScYRpjnuIn2WlFQdy0RdoUR+/KlS6jh2naOnwX0tZXZ7oFv7oXsKdtvaHVgOf8RzMiULX8jHIhVU+puHExfvzKDZ20E0Uv9KHpYgzo/VpYVpQ7F/dOxPbG1q9+awh6E3mYguRY3SaS9Gn1NsGl+TS3o75tV4qQzAk4W4N340cp+/svv2pS+ZQfcQLvyRkW7Vdj1MzhgrHX4t8w0Bor8aDwRvNoLtA5yYTJRJN9aNCWNI1AkCj/ePMEZyIBZne2WJRLeD9CzdUNXNTRPHhZps1Lv6/qXfWDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W21EOus61kqzIvUJhfWak0Zuwguspx3S7AldD3oY9pA=;
 b=brEcDF0ZDLtFb50Tgd8N26cF9QNdLcMhokwgY+mh345zm9EGkhKyz76xqN+H4cI0kj3MR38eI7raIsFDmMETNm6JvIWU+LneH7+dCmwxpOfNBaaWREPuCLla43e4ffnzIevp4GSCwhL1rq3cqGJALML6U4Z4ha8YPrXcjUyWLGb6kHpPqQmIaxf+XdUPyy2C8Et8zCf1A/tCCX6kY3tx8YSNu3vSrnQiC/GRfl1pPjWpTpIPnPLUTF2PxOCzgbY9JME31KOB+NEyI95IXKJRmMyNnq1upEN/iB4O9TT9FmF1EVZF+dnE75boU3sGJ69h87UJ+4TYVpskqGPZ1DapVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by PH7PR12MB6787.namprd12.prod.outlook.com (2603:10b6:510:1ad::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Sun, 9 Mar
 2025 15:39:49 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%5]) with mapi id 15.20.8511.025; Sun, 9 Mar 2025
 15:39:48 +0000
Date: Sun, 9 Mar 2025 16:39:40 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] sched_ext: idle: Introduce the concept of allowed
 CPUs
Message-ID: <Z822PGZLYl1Vima4@gpd3>
References: <20250307200502.253867-1-arighi@nvidia.com>
 <20250307200502.253867-4-arighi@nvidia.com>
 <Z8twc3pc7I9SyIMC@slm.duckdns.org>
 <Z8voSv70QuxuZa5Z@gpd3>
 <Z82sImYF7jOgPGbL@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z82sImYF7jOgPGbL@slm.duckdns.org>
X-ClientProxiedBy: MI0P293CA0009.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::6) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|PH7PR12MB6787:EE_
X-MS-Office365-Filtering-Correlation-Id: 80547edd-2c67-4a8d-2205-08dd5f209fdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PhH9SMlSXQxvVHkREu5kX29gpGeLGAI6JDH7BuPksQLQ7dvszQ00c2YHG9VZ?=
 =?us-ascii?Q?+B7hvAkl2PQTsHQxhIcP/ZbW4Z/ZVPPNnEU+r+5JpiXl4CY9NaMEi8+w1WNM?=
 =?us-ascii?Q?bTtjgV8WZZZReo++bceezYkw/rkTaECgKmpQT30vztt33EHjR3wgUCHYILkX?=
 =?us-ascii?Q?ltcjMdG6eXYoyfAavkD5+5T6euLAwFxKBCflB89a9/U0/2uSTrfXHc6+M9WL?=
 =?us-ascii?Q?74S1qaKweZShNv56ndPCNOLHHps7sNF37Kef3UFOrtTATj9oi3Kw715BC4En?=
 =?us-ascii?Q?OI22mTg/D6hV4djdctF/VFqt/rDKS0aY/4E2T9zzN7/+2oVWbClHg1C9oNhd?=
 =?us-ascii?Q?lBWm43HFN6/Lx3UVwr6B4KnwSg5SK67VJ651ybRhaWwDBusiFQ964o+nGb9W?=
 =?us-ascii?Q?iR2Wsqh1tZqlkc2vRWAK5VHjKTrlk02Q11J7dCxRls1pqN93yOdG8GSKcEhR?=
 =?us-ascii?Q?ryWj5V08lLEUfLRMQtB1s0L3EQRAugbjFider2ss19s0QBFOnjcfOSSSj6kg?=
 =?us-ascii?Q?KEZjYMjH9ZUY4w377ZOQXafL7qRzZoRacu0YhhOFJP5bymZdJb38aPcm1Z8S?=
 =?us-ascii?Q?gl8KO7fnxzRbA/hw0qtjg362OJNiPnp4sFpdVtYQaWk5pzvmeRZPZHPY9+M8?=
 =?us-ascii?Q?hXRMlo2tACXleAtXs2TJ/CM38V2WfvC46Ns2ubujU7PnAKiV/m+KsU0qKJhb?=
 =?us-ascii?Q?Vuqi+e4aA2BOvXJKdInJ8guTBVC5pkaivxL4FUmvSlP34+VHRCyd8KawKl20?=
 =?us-ascii?Q?IZjbPVQVUaKUZ3WbBf2MEdWT0k933FC26wIquTtGaUOuPXIgD5UFtUey4RIn?=
 =?us-ascii?Q?YC0aJo4q78+bRDwfTpL9ErVMDW+m1g7cILUtYJUoHev8MSAhxUB+a1DsTwNB?=
 =?us-ascii?Q?kr8wREJNR/kY9YM95pPp9+67GuycHVofFlK0ACHapefziq07b6RFn4kO4Z6h?=
 =?us-ascii?Q?cfH68sh+U0AJYcKe2aoBj83IXAZal3FtoB2sb4SDUzu8c9PbJm5CTYKNJOMT?=
 =?us-ascii?Q?bbjo5V1snqftu8L1rrzMXvX36C25xOxSEr3ZP1rvBWDGfsdPDb/rfvQuAMNi?=
 =?us-ascii?Q?5Exwx3iGmgQEZAtsHn/uhNfCv4t7MHLzmPpcfHms2Z2PeQWilREdFL6QgQo/?=
 =?us-ascii?Q?/dzFvMBLyN1p9R1q1yRRwppnn7gXXlHscwQu9qp0TW62HftYtpqfMTwVmALn?=
 =?us-ascii?Q?4ZBd13iQYoXGfhrONzGp1Usxfpc2Fsqs424ctXIC+PZIbJ8Doi8b5+lj5dXN?=
 =?us-ascii?Q?HrDQ6RdyYERc0ciDQxrckxMj4YcDSyiy29bHq4jh8StCi/qY+DWVGZOv9Din?=
 =?us-ascii?Q?2uyeexU7qVCnM/baSXBtS/KUkFcGJoE5jqS0rywiR7lT3qpwjWyaCLQL/YZJ?=
 =?us-ascii?Q?gYdl++HMUCSCLuKD3V3xUMVLEdbM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pbcjpMoO6OsYDGqavmazitm6RCaWJhWwI/PZRCyVwrgECayNE2xqPkxDuBUn?=
 =?us-ascii?Q?fVQI3mhCrFrIB1gAxBHMwNw/BKPhKh0l0QuHVjCZnCpeRnAz1gk5x8Lqyyzu?=
 =?us-ascii?Q?9Pt47WkYQHl9QI2DjHA2evZ/zEJ9f/b2puJMYfFiOmYe65K2Q7a9hLVjylJJ?=
 =?us-ascii?Q?tmUU1LGsSlN3B11sVNJzLGpnicyxZGvWGdxe2CMLKcuVBlw3Nzu5+aKDdNDt?=
 =?us-ascii?Q?qqtoNnkqxi9uPC3O0qpqZzzD+wBFGqJXTN4pyF8sLNbRsYent5HzZf9DKlE+?=
 =?us-ascii?Q?ZHLZ5yRkGy/u04jfPam3/cDx2T+AE4TPaTCCHIyxmtdTsuG4Pbaj/IAh1bP4?=
 =?us-ascii?Q?77ORsGrbnPpBxztbGA2e0d5vEU4cv4hkusMLvfBUAWLYczJJGPgKSAqz6v82?=
 =?us-ascii?Q?3eRWCZ37g+vx/3CyAfUTOE3fbpuPx1+tVW1RMN4G6QNJr0i52q8mcQZwR94d?=
 =?us-ascii?Q?UUPb9dBMnlXIyAUL/rYWc1/cYMDGcN77nXRI5XQ5d8IZAhjdetEdnB98D8qw?=
 =?us-ascii?Q?gcHPnxJlx5Aexjftwh+QrVhCpeL02YU7z+BcHsTrNRNh2YALuZmmPjBWSwTo?=
 =?us-ascii?Q?4Bynki+9hxUKcWzRIDU7+haGxIpRFJRTc5MnrRrs7O0dBDkoiZs+PneLaOev?=
 =?us-ascii?Q?TCzLsBo5b3lOsBOXXg5UDJ96Sa6qBhAjDXqSjknLE5vofTAomCOP1zfqr0nl?=
 =?us-ascii?Q?4SRzDI7XS2p2Det6520GAI7tN2eHNxykFGZl8oQUQIWKhybt+oKMxeZzIUsP?=
 =?us-ascii?Q?vCWJzhfaScT3gcbVQAi7ydNHiC5sjMmRFfuXh+Y7BgvJ4duozoZGvvGMav5p?=
 =?us-ascii?Q?DL9+PmQffTKdJRJ46e1NCJ92WkQj9YMrp4i3XsSzF4rSPxHUVY8QNDLehj3e?=
 =?us-ascii?Q?rzSNnXa9HaSIUAqHEuulBiGSCI030qhQNBLGl6cziYqLf08AWUgu+5cs/moK?=
 =?us-ascii?Q?OWSBVGDPMu8rtS0k7hf2AYN/XOLdRkvL1EW9sJWBJovObCGd9yQd0dya8yz9?=
 =?us-ascii?Q?KwEd/1rVvJ0/2rPVNK+QrmvGdHjz0VfBB6bTGZPkOeSVenRKw+NolOzlrhmP?=
 =?us-ascii?Q?pnmD0arZgqPUsGZLZNXGtmg93OvgQK2i44P+vCh0v8kHSOoJnBWw+QIV3bX0?=
 =?us-ascii?Q?BlgcG8Q0JIXckM8V4RR4FIFci5RabjdLIeohi/8HiSCfRlI+dHgH061+6f3E?=
 =?us-ascii?Q?Un2HnWnwujE9BCgNMYyPgpnG7evXNBagDLkrOWNro5K/apG4z1bQhLLAoJoC?=
 =?us-ascii?Q?FSlAxIp17Ue5VYF4iTySfb0Gawt0aA9GGJZ3H3kVaD1agkBMrd8LSEy2uYQI?=
 =?us-ascii?Q?aSLGs3s6gUlmtWGrUjfa16Q/C6bxGoQpP86e+rnZVDA7WalENiLlCrmPZa52?=
 =?us-ascii?Q?H1O77g/4THBVXm6MDyGpV68vRpnthSnVu0pA3xCY8zl/RKZzZ79uZ2ltIlSb?=
 =?us-ascii?Q?tnstHTVofAv088fBC9BYw2DXtwgFp7icEpJB19Py+YYAQ7TlPwP0DcKgnd9f?=
 =?us-ascii?Q?BZQwWXQ6EnUClYI1RyK6qV+zXIjzmP4ODzpOlaLvEFajL+IFWQTS03GkGdqs?=
 =?us-ascii?Q?micNWzetTvYpnxc4PMpGQnUYSZfsK8PIh+J4uzCM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80547edd-2c67-4a8d-2205-08dd5f209fdc
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2025 15:39:48.3375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yVsDGHnAzQ4EX6qEnUugmGEq6mwdygbp4o41fZKAnbb5FnjASafRdc8CKqA1HwigTZeU1FMOPK4NEVfpo/YiYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6787

On Sun, Mar 09, 2025 at 04:56:34AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Sat, Mar 08, 2025 at 07:48:42AM +0100, Andrea Righi wrote:
> > > > With this concept the idle CPU selection policy becomes the following:
> > > >  - always prioritize CPUs from fully idle SMT cores (if SMT is enabled),
> > > >  - select the same CPU if it's idle and in the allowed domain,
> > > >  - select an idle CPU within the same LLC domain, if the LLC domain is a
> > > >    subset of the allowed domain,
> > > 
> > > Why not select from the intersection of the same LLC domain and the cpumask?
> > 
> > We could do that, but to guarantee the intersection we need to introduce
> > other temporary cpumasks (one for the LLC intersection and another for the
> > NUMA), which is not a big problem, but it can introduce overhead. And most
> > of the time the LLC group is either a subset of the allowed CPUs or
> > vice-versa, so in this case the current logic already works.
> > 
> > The extra cpumask work is needed only when the allowed cpumask spans
> > multiple partial LLCs, which should be rare. So maybe in such cases, we
> > could tolerate the additional overhead of updating an additional temporary
> > cpumask to ensure proper hierarchical semantics (maintaining consistency
> > with the topology hierarchy). WDYT?
> 
> Would just using a pre-allocated cpumask to do pre-and on @cpus_allowed
> work? This won't only be used for topology support (e.g. soft partitioning
> in scx_layered and scx_mitosis may want to use multi-topology-unit spanning
> subsets) and I'm not sure assuming and optimizing for that is a good idea
> for generic API.

We can pre-allocate two additional (per-cpu) cpumasks to do:
 - cpumask_and(numa_cpus, numa_span(cpu), cpus_allowed)
 - cpumask_and(llc_cpus, llc_span(cpu), cpus_allowed)

And update/use them only when it's needed. In this way the API would be
generic without making any implicit assumption about @cpus_allowed.

If you don't see any issues, I'll go ahead with this approach.

> 
> We can do something simple now. Note that if we want to optimize it, we can
> introduce cpumask_any_and_and_distribute(). There already is
> cpumask_first_and_and(), so the pattern isn't new and the only extra bitops
> we need to add is find_next_and_and_bit_wrap(). There's already
> find_first_and_and_bit(), so I don't think it will be all that difficult to
> add.

Yes, it'd be really nice to have cpumask_any_and_and_distribute(), but I
agree that we can start simple and provide this as a separate improvement
later on. Looks like a good plan.

Thanks,
-Andrea

