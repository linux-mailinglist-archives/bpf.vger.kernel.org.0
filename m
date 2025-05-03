Return-Path: <bpf+bounces-57307-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB843AA7EA3
	for <lists+bpf@lfdr.de>; Sat,  3 May 2025 07:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94BD118953FF
	for <lists+bpf@lfdr.de>; Sat,  3 May 2025 05:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B311A08AB;
	Sat,  3 May 2025 05:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Atdl2ukd"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A2619E7F9;
	Sat,  3 May 2025 05:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746250884; cv=fail; b=mf8RK+HTex/RvqAHXfGkILdG37sWLEdjTc+cfBGweQZn8rtQKrghkUTHYlkfTr7FlnxS3FIffbhE1oy1fQX9UOG+RdYXBuIw73WBtDmJR1EWfEkehm1UXf8a9WuM26Xaq4dh2jxMpcumdaA1TRmhow4EwO56Uy7Kgq7koi+u828=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746250884; c=relaxed/simple;
	bh=+3ewSb2gk43eXNBUL6zd2bBoekiIsYROn/3nTDKZlJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kAa+c1DixkvgzPkNpultE+qKbX2sBkuG8E3DhDiv7D6tusyx1Nm74wzie9gVrPVB4oxSZIvwAS8qk/MZTcT4L0VpgMgH1t1YjkBSZF7xu2/83dJ8cB0CDVwXJ0eRra1k6GoZ4vA/G+jMrHEAUeahhFI3RRnS44c5NS9fiRenZ/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Atdl2ukd; arc=fail smtp.client-ip=40.107.223.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iMVIO+0pXX4AoEgkjInjLe6bRcCLuwriHD0oduzeDUh08495Yg1kU68wT0G2fqLqhKrNWMM+PR5Yd4Zqe25nmOx9rZz+OC6iAKuOoGM4/gvKxSR9WMU9+UNhCgnwFQRoPcNccCxpZKqHSbAuwksF4bGExX5kk2M535yoLoogBlSGJdRG0TR3pUkiXq+E8KH3dWvNKBHsMhfzRYE4BpvEQI6R1VfPSUlgYMiLE3HAeB1wMnxxp5fnJVmMn8S5ewTBflwAGWpQPbe8sOWgGv0giZwjkIFDOEI13reNjKn8SpMl5bBrCwhj1yojfny18aolGtriJO0djLdGGNGWZZ5WYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xU0HlWDNqmf04tVBW9N6vjdJ2NKVa0JBpRjlAbPQF6k=;
 b=PpJhl7RzOs8WWx+74gXYUCh6FlBK3acqo0d50B15U93Jl52ScZPotx6xBroWS6axLQ3Ir0Xpib2qIo0OjWKdC5uJJM19+OtuPGAtQOccFKXowoIFCUBS/6lEYLUFHzVCE4aQScF5zJ4lV5fZVkAHwqQjbND1v4e0eICXBSG/2CttBwGoV+dcp9QPrGEfIzN4wxpgN12l3zIAv58UL9xKACKhve6+rAQKhOgp+HaCH9QIh/Zh1iiEoUxTsNe2SbfKu/oTf4iKSZOQ0GiovYnvGTi451zAN2AEkiY8Qddx199pOS9jJPXhM+9/8b7iSlq/3w+7bcent0jO4zAeuB1A9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xU0HlWDNqmf04tVBW9N6vjdJ2NKVa0JBpRjlAbPQF6k=;
 b=Atdl2ukdvULEeg1b6wKglCMEvvY80MJTJaiFjsMWp4L0RgFKVMHQnrhn2gQsr71I5eYEJBIFT6dkYbC43O+/Cd3o9lP52Ws4wbUFzZ+FKWwfyMBVlyai2OwT0aVewwmusq8+BPs/U/fmWs8uxoP6G9CdazfMKU9f1ZjW/FgGewoU5XkcgNdgz9gySks7QCj3mCfCKwSuKlJ6PagQkJyWLuwldROmPmCW5pEuEM+oFgMInUeZZxCHLry4SSKwYQVYdDmn9/tpqHGcUMrv5Uqde/QBkMP4mU5Z0YUYdi7ps6/2w7A8A4ZXSEM04hu3rjo+wfZdaaCLyy1R/DQ1qYWmJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by PH8PR12MB8431.namprd12.prod.outlook.com (2603:10b6:510:25a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Sat, 3 May
 2025 05:41:16 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8699.024; Sat, 3 May 2025
 05:41:16 +0000
Date: Sat, 3 May 2025 07:41:05 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Tejun Heo <tj@kernel.org>, Changwoo Min <changwoo@igalia.com>,
	Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: selftests/sched_ext: testing on BPF CI
Message-ID: <aBWscQBhh9qRmxAY@gpd3>
References: <3fb44500b87b0f1d8360bc7a1f3ae972d3c5282f@linux.dev>
 <0a039ded-b67d-4a0c-a851-e3aafff57321@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a039ded-b67d-4a0c-a851-e3aafff57321@linux.dev>
X-ClientProxiedBy: MI0P293CA0007.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::10) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|PH8PR12MB8431:EE_
X-MS-Office365-Filtering-Correlation-Id: 50a77b30-197a-4a48-195d-08dd8a051f1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BwlJgjKF4di0VSTZB/D4UfGe8ieOSB9dMG0G3/vgRj77C5ensRNAf779CCZr?=
 =?us-ascii?Q?3ge1qI3LsczIt9wowyGr0t2N2zpo2mAYRH/2Dv2r3U/OpZk3EIlibYFLUXN8?=
 =?us-ascii?Q?xOvSg2/gxiiYRNfeuVWo1gGZDPDN8eHwjISEv9lHQj30ek1W8fCjCTLoRT4Y?=
 =?us-ascii?Q?mgC2OQ92O3p9K/50RZs/gauG3BcsK3MMY0Bxp1hJNCwtAUgV4xCqntxetb6r?=
 =?us-ascii?Q?3XafchNCTwAr4cOPkDFvU+oupNRlDwC70F14CzbEcI9iRcaH09tMRwSVYhGn?=
 =?us-ascii?Q?Hlq33fVNx0K/YBr29iq9fa7X+bqfGohPGLPTcZuMFodRi/g/jouFhl2nNsaS?=
 =?us-ascii?Q?UB6M9xoG2EOIGfUunU/Wq1dIDHIoPqM6SNVEoOghvVr7wcVlYKwwcHUQOOTN?=
 =?us-ascii?Q?cRvL+jB1K67vJaWjiqqmlOLTHF3ce2XX5Y+ziq4SWZfafu3cwfSW/C0l/N+s?=
 =?us-ascii?Q?cjzR/W/gKhYd8Lxryo9Bq6ioXsn1pVLcU7ztPWuhXT3KvwJGVdApGP6rv0QJ?=
 =?us-ascii?Q?7SaXfRxjx47UwLdzf6HiZFtUS1zNoCfchnwH+OdN3p9UgqfEwqiCQO22YpeD?=
 =?us-ascii?Q?UGf8TKurM6uoyzg55sLE+gsudgkQ99HsyD1erN3KI40Y6wQcrUkATHTNKnQM?=
 =?us-ascii?Q?5wiMDhj4x3Z0fpyXKtA2YMhmvETgqL5Zb8HCiyI1tgmq+7ASTq5M3EracZcK?=
 =?us-ascii?Q?8Fk5BJqa07h8g5BISurEc8Dr7h4eZpyVSqKlYUXNm6GS/UvU6GXMt6frA3Gw?=
 =?us-ascii?Q?epaQeHkRYl9o53ddytIJVCLB4UbVSIAkNe6pAVP5LbBmfwG3++hMIgi1o6Oi?=
 =?us-ascii?Q?usv9qXJB673q6Z+jlLJu6DUBK3BDj3hYCwvUXtLwm7KF1HvuKZXsE9Vf16OT?=
 =?us-ascii?Q?4oiTAvAy3HPZLrga9ZRT+V82xzmAst6kjCSiUguu77q09q1yswfy9peznZRM?=
 =?us-ascii?Q?1jcs87hCOi7pr/5Fm33vHRFFifIbmax1u6KuV80LqE2z87iW/dnhFoVeYNlu?=
 =?us-ascii?Q?uJCdacjlBWad+BSXjSKn+wQG5P28VCUn9Cfv7ikCkpm57LKiQSJGGIVbQrhD?=
 =?us-ascii?Q?SXcKGIEuFVg8qI9nq4AHW18QbRPS3vXdE8hEUah4Kj2dPiBagw+4taHn/gbt?=
 =?us-ascii?Q?/ELdJyPde57fGaCGBVo6JhDGsCrciAqLMqYownR7AcrY/r3PqTZd6effn9Aa?=
 =?us-ascii?Q?asZZeWkwEmxXzv73GvnujcnoU+Hc0fvGaBpf+9DTYToqOvu27zSchvgdPrKP?=
 =?us-ascii?Q?gYY4d3cuIeyVP5nqAW8+59Y2YwfD9BuuuExVVbfWYfEpOMfIKt+YH/1rk4jo?=
 =?us-ascii?Q?Fpqp7lyPF5sPOYeFgnR9tPI7wx7b2acjhj9Ubez3mOiJ/dKOPvIlxd4u5bYx?=
 =?us-ascii?Q?2tLidLkE6W7i0MhK5mbQuNTjv4mw7Nd+GUWTieDyBzjfJ36h4N+M4lqi43QM?=
 =?us-ascii?Q?KulKqdHf0SE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?viIb34FNytSNtoxsPTGl0Ar/L1affwVQ1Bbn6r3oix0QRGtSiNz8qJZAMSxt?=
 =?us-ascii?Q?Xvf87VzZGDSy2FJisinqoUWa6cetfx/pOE8uLfyQiP87P75iHdUxgG2EOFty?=
 =?us-ascii?Q?N8xJ6U9wYpRPpS7gduJojXfxyiH2CB2czvcAw1ZBK9j7Z0F3pDCHofEslQrr?=
 =?us-ascii?Q?0CWsmbgRrHfuE/fPxxANP5yItfTrbHlrR8TR4a1OokWe16qgWeuPwOI9CBoF?=
 =?us-ascii?Q?T1eyR4Rl+3q46SaZCMSx7ZkWqv4NM1R0yjk90e3D8hSFs2mPJKq5O5GMClQ/?=
 =?us-ascii?Q?Kz028Df/zhKS5qmEB18wOQBHm8mil1gFeVonfZ2VF1Ap4rsSQ22qf1fin1IM?=
 =?us-ascii?Q?Hgq3idH8ne+y9oouhaaO72Efw2Oxg6Rcx+aNpD01NkKBn4xhu7hX2GuAPDey?=
 =?us-ascii?Q?59DmCYaCCoLzmMyFf3u294VeVYf43JeOs0QuY6iX0xbtJp45LibXiGvp7V5y?=
 =?us-ascii?Q?v5NTQHzjVgIretQJR7ExTTCM1H1KoFbS3aPryRBGpM+grU2iWQhK93pC7YGA?=
 =?us-ascii?Q?TMEtMlsBo7nYebiKqqt9qJfpIFD0UsWZ7N7JSPtCUtenBgQneYlPYCXoZ3zU?=
 =?us-ascii?Q?PzuSU8UHYGpGidpuRc55MpN0pQSxr74a/eOlavMrDRJzGpiZx05rXJPFbX35?=
 =?us-ascii?Q?Q24Y4DD+lUmDKNtU13mPf5zX6j8njjO8qPTYSOqjeTkKx9fhowgY+SNdWr+D?=
 =?us-ascii?Q?JlcZcTyPr/C4DPQ6pAoq9jil2OfQYesfiNXSyObXLZ6haJGIHJPrkeH0oF08?=
 =?us-ascii?Q?a4rfSPexjJ2T0QjnCJg9o3vk6BITgglTFk3sSO1NO75J4UDwon1OyDSHfoY5?=
 =?us-ascii?Q?jMBTft0/TaCi0kCOY/VJuUfCq/k6InBbuH7Fw9q7dXJno1TYOE6LzjuwMOUm?=
 =?us-ascii?Q?tM8gu+kFZOKyYELqKqxUhqriZ/a211nPSJaTmPzbccYMq20C1s4UVIc2QK0p?=
 =?us-ascii?Q?3BLF2WQPyoHFiilsiuFuiD5I7yMgqYII2EGRKvz/Nb1BM9pfeZMV4YHHY7XC?=
 =?us-ascii?Q?ExxZpZo73r4GbF/pal+6sLSyEb0X7EPZM8472Znef69mn6aaYNOyFGrhPSHy?=
 =?us-ascii?Q?X06bumFnRANqjI6pQgoa4a1+vy+qonzwk1MEXVtS/zVpt1QcIsb9z6ic3qLC?=
 =?us-ascii?Q?NW4PLzgGvTJa/OCVqyx5THJzOZnXL7nalUT+jVMl6iXWSR84I77tW7TyyHiA?=
 =?us-ascii?Q?pIj0oJTFfE3LCAwxew+GC9oUdj/9emu4rihg/XkzUhWoUazTsDYXTuDLDs85?=
 =?us-ascii?Q?ZwCKW5dv0HqNo0ccUlaX8X2bm6K9lEVm98MY8IqEPCIopXn1Ld6Zog734h9v?=
 =?us-ascii?Q?F5Cezu3xus5gqSLKtGGUChbWKBvjmH4Tcpom8mSrSOOfHhO/NP4kh+9Kkutc?=
 =?us-ascii?Q?Yd5mAe47+xigRgaPdC2sTiQluqDhGe1+T3ivVtGURbSHYhFOzbJ2078Ln1uH?=
 =?us-ascii?Q?yW7Pg960A6oV4ryJhYFNbhg9nRtaz6Pq3yoKsy0QM8FnkdXE+Q9qd9fVMQDT?=
 =?us-ascii?Q?vgRgBmFa48MFyxkTdhrNxfZaebjBYdkLfeJ/aN7G4m5+iSB3011imI1qwewj?=
 =?us-ascii?Q?+Vg+9RAc4syst45GG2DGJ3fieguTwnzC8kY3Ex5R?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50a77b30-197a-4a48-195d-08dd8a051f1f
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2025 05:41:15.9437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cu1sbbHRbA9mKuGolkWrUtQT9KYVVbo5RcAkpyHqgEC7pV1IKMZzOUGIfPAXBX573ZsmN08EqL1fmnRaIPoxzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8431

Hi Ihor,

On Fri, May 02, 2025 at 02:40:45PM -0700, Ihor Solodrai wrote:
> On 2025-01-28 4:21 p.m., Ihor Solodrai wrote:
> > Hi Tejun, Andrea.
> > 
> > I tested a couple of variants of bpf-next + sched_ext source tree,
> > just sharing the results.
> > 
> > I found a working state: BPF CI pipeline ran successfully twice
> > (that's 8 build + run of selftests/sched_ext/runner in total).
> > 
> > Working state requires most patches between sched_ext/master and
> > sched_ext/for-6.14-fixes [1], and also the patch
> >    "tools/sched_ext: Receive updates from SCX repo" [2]
> > 
> > On plain bpf-next the dsp_local_on test fails [3].
> > Without the patch [2] there is a build error [4]: missing
> > SCX_ENUM_INIT definition.
> > 
> > We probably don't want to enable selftests/sched_ext on BPF CI with
> > that many "temporary" patches. I suggest to wait until all of this is
> > merged upstream.
> > 
> 
> Hi everyone. I tried enabling sched_ext selftests on CI today, and there
> are no issues on bpf-next tip (f263336a41da).
> 
> https://github.com/kernel-patches/vmtest/actions/runs/14802453691
> 
> If there are no objections, I'm going to push this to BPF CI on Monday.
> 
> As a reminder, this means that selftests/sched_ext test runner will be built
> and executed for pending BPF patches, and BPF CI pipeline will fail in case
> of problems there.

I don't have any objection. The sched_ext selftests are in a stable state
now and I think it's a good idea to run them periodically against the
latest BPF patches to catch potential breakages early.

Thanks,
-Andrea

> 
> > You can check the full list of patches here:
> > https://github.com/kernel-patches/vmtest/pull/332/files
> > 
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git/log/?h=for-6.14-fixes
> > [2] https://lore.kernel.org/all/Z1ucTqJP8IeIXZql@slm.duckdns.org/
> > [3] https://github.com/kernel-patches/vmtest/actions/runs/13019837022
> > [4] https://github.com/kernel-patches/vmtest/actions/runs/13020458479
> 

