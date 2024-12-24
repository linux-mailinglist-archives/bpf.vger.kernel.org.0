Return-Path: <bpf+bounces-47582-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A418A9FBA74
	for <lists+bpf@lfdr.de>; Tue, 24 Dec 2024 09:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 101F8163917
	for <lists+bpf@lfdr.de>; Tue, 24 Dec 2024 08:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE2618C924;
	Tue, 24 Dec 2024 08:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NYynfjpF"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E36C27702;
	Tue, 24 Dec 2024 08:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735028581; cv=fail; b=C6F7h3U4VsCOqAYtYQN9GQN5/nLB1B2Tgqxr4xcBsrpGxEneP6JL5dPpexzwV3a4VQS1GY7G+tVnkGB+VrSW8/pTWHvvfaHjbJI1Of3PTCpLQtAojxacSymPfTBIFtV7E+Ha9LMABoijLyqsR1cd3g6a3yE9zV4rz/MuH0R2Mgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735028581; c=relaxed/simple;
	bh=YuzxZpZS3YxcbIF9l/cSOK9vfFxjUHNCTnSIJudzTHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mK1TkkKzJAXYm39OsPrCO3yx2Kym1XUOJoGgvIl8OB4tILsUsxFgRaPD+zarjzohQIlmNVsQK6xOQQxSqzhtSx86GPX9+Ymp9A2eqXsS2iaElZ55oVhO36RZZ7LRUeSdFRfTbP6r8wS7CuKhA/YXpkmSbqWJhYj3n63or0Kd31A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NYynfjpF; arc=fail smtp.client-ip=40.107.93.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oECh37eEb7tavdcGI6AzZa3okWam4A+R4DEbD3FWwNGFdepCrprKzM5sNH8FEhNd5lRhUMAnYWcuD99pg0CEBjFMtII7n+KZXvyquI6K1Gh3ogRb0jcb2j0kJ0/Ex5MeqrzJGkk8mAFEHH+zWJ5t1yddgzjyfcv//3xU7qeTwrOotKk+3r5aYzB6xMApOq/i41VB4jUsnUO4c/f2pAJgIxQhTU6G8kqAoOOMbty472cFELjcQ2TQzPZw4NT9dbmjplODkYHwK53baUHCxIlMGDyNRS9VEkYNMpAiE4zcXIqZGEkXsYkP5789Z35gjiDUP2HDu2mXIUPa9i1MfsHwrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+5KggWiPhkfaUxXI6jjBBykutziOFfm6hwcq1LWfdi4=;
 b=LDVfNpBs39kr/HhunlCAEjMDuU5+Tl806X+k5a33LofbWaSJnnIt2iWUO9lhI0es5RwJEhjkYN6pfa1vT6Y1bHRWA7u+j2ji/IrEXL03mXT1ulnjJD/9d47K0X64epZWvQMVclH+DtscEuNGT05pMqGxhE3pgeTku2y45R44sXHWBwORhvnzsIkUevQq1mKU4QRXRi7RGlP0uUnsrpGrHdYDCURXNDtLXj84eK4AGwTedldhwlvglPx/bnQAgTqIe7gEHMMx6A/4NIwEQzqzqEWjDSm7RUpH5JS6Kx0Kv1m0q7LZXz4wzh+g+lWsvN4u47OZcoZpLsbxQR/6Zi35KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+5KggWiPhkfaUxXI6jjBBykutziOFfm6hwcq1LWfdi4=;
 b=NYynfjpF/ud2KdBl0rQqlKHdGeMns9U7ELgimD4XbAUqIqduXMGLbAztWWVAYUwepOgLqLUDX6xciTn2/PvVuAX5X2vI6T78tfK9DQZnVIh2HnbjQlHKzgugNO+88mgpHQRahaOzjN1fKrJsabNRX+bVEJ3Q+6xIKxtEn/w1k99H/3i754Y0XrpdvrHeqRFxDrYkKYMRRwELkIrtjTTC5aG8bRMf/U9YBZkKyamdD6+X/T/hq5s3hbpWMYEOiKHLcJLB/dhekZGShJ8H7xURUlNMPX/0pCC40KvTj5rxyqNgtwjQr7n+00gCIUmbqph1aod2E6f/XwpBmvAUXNdvnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by CH2PR12MB4245.namprd12.prod.outlook.com (2603:10b6:610:af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.21; Tue, 24 Dec
 2024 08:22:53 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%3]) with mapi id 15.20.8272.013; Tue, 24 Dec 2024
 08:22:53 +0000
Date: Tue, 24 Dec 2024 09:22:49 +0100
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
	Valentin Schneider <vschneid@redhat.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/10] sched_ext: idle: introduce SCX_PICK_IDLE_NODE
Message-ID: <Z2pvWdwLr86tj_8Q@gpd3>
References: <20241220154107.287478-1-arighi@nvidia.com>
 <20241220154107.287478-9-arighi@nvidia.com>
 <Z2ohDX-F6bvBO3bx@yury-ThinkPad>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2ohDX-F6bvBO3bx@yury-ThinkPad>
X-ClientProxiedBy: FR0P281CA0183.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::12) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|CH2PR12MB4245:EE_
X-MS-Office365-Filtering-Correlation-Id: a382b775-ba3f-4e4f-381a-08dd23f429d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+v1lgkMxH3+NxMrdnNmewo/xk/oH4CHLc/A9R/LuORS+kBeMH8XCtz1rR4Cf?=
 =?us-ascii?Q?xFvsI3tToAKcMykpLaI8spUTMhMCNkVacJNIoUEV7Qu+OLmY1rkWEP7Tglk7?=
 =?us-ascii?Q?f6YdUbWPKG5FKEsG+b/Kh0qeqyh58plp8RNXBkX0cpja/KPBw8ZS7EIV/oXU?=
 =?us-ascii?Q?APjFXwsBTCADCn8f9rOs9euthSA3L/i+l1tdmDBpPQVHYr09OdumDbux1xDn?=
 =?us-ascii?Q?ymwu5T58VcDGrXn2HL/ZXxIHmHr5n/E6dXbINWC7+2BHWa1/2Unl7ka3zxzn?=
 =?us-ascii?Q?+c+x2zTRmrf1GivLQlR1WOZ/VGSxr4iE2FqO16jAqC2Bi74Gt2OFEKbbQjLG?=
 =?us-ascii?Q?lbwj8mRr3atle7j7FmCBA1xsXh9Cn3/zLbiQbnJXI4IgdQGAyMXiRU9U0+yq?=
 =?us-ascii?Q?xTGgGw1ZIqSlWU7z8Ch7XSky8ZJNJeeELlzCknxl+lFdxneuqQdgCd/qJ0cw?=
 =?us-ascii?Q?Tls6AaKFWAxuPkLuWjYKFk2hZBtJvy9HzCvvKRenlerJ+j/bYOIx/XX3Zu2e?=
 =?us-ascii?Q?P01oiHfR1f+OfqQlfAZee3dv4mxsuTEPqVcdn5q/3V68Dn7DQCS0jyKiWO51?=
 =?us-ascii?Q?s64lwtXfVLxYLMGYKeJW5tRDzndFbK4n6GXttqmEJOAU0hy7S47cK0XpX6kU?=
 =?us-ascii?Q?JWAL5Ww9wCzNPNpIeSf5wWQQ/CQ9/YVac11Ey1d04T/npTwvD9v98HBwyM+Y?=
 =?us-ascii?Q?NoC6Z+mumovZCOea8j8dqrCChHgYqfudMmKOsgqJdRsFY8HWZMB6i46r4id1?=
 =?us-ascii?Q?9kXmlF3sH+mlSmJGmoovMSyJo1S5CXoCWj/a4P5dM349aIficifn5UnrZSvH?=
 =?us-ascii?Q?BEvSXJCjgNT8jp/7ydEtKo5yGELhAMA3G2H1VbO4vBX/RYt7JMDYUT8IFoZt?=
 =?us-ascii?Q?M7h8xxZiuSnhtcHvk+DktezD6p1lLm7ChWRuP4Bt/QnSsklCLNxDuwgeCUwc?=
 =?us-ascii?Q?Kg3z+j8RcUbAbFRKUZ4gwlcV57QCAQ4D+ckYAoC6fvNspwAFUQJfLUmJ/TtM?=
 =?us-ascii?Q?/ZruEyRFCLhJubBYqLoU9n/F2KyrIQBjvAGfXERVyrHt//v6Kl8xBUupykdk?=
 =?us-ascii?Q?RsuwAYCUyXFBOglJXRum3GB1zZO/KW3Zxi8Hqj3t80j8ggpUtfnwtIorDKVq?=
 =?us-ascii?Q?3shm8UNS2Z+ha+sGryb3q3aEzYCaE4rebGrFzmiNUrbTOYqBEF+Zi4JhZL1t?=
 =?us-ascii?Q?IfOhMsqpwu59+8pt+40HJYsV3zEKXczucAIA7iWY+dyk6bKX+z8a8mJkdpWP?=
 =?us-ascii?Q?y7G4E97ppB2dheX7Mn6JM6vo/x0YjU0DsHQlx+Kp39j+Fvg+vowwdVyxkWF+?=
 =?us-ascii?Q?kXYfD4jj21ixIuiDISkN5QU6Q/4Fl/zC4tHktHj7Md0w67v8BhvYmMKnWHU4?=
 =?us-ascii?Q?Ai8mquQCg1BsttCIBJDfGEupg+LB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2F63Qm1WSZe6w8ityGYpDGsnKnaBoKtUQbidBtXX4lloXUhXlgLKCgaZl8CT?=
 =?us-ascii?Q?kwGrNc3FgsjuMvSIIKRx0UKAune/m1MthLlUrbVWZdIpWXQoRStOwgSREajF?=
 =?us-ascii?Q?zr4eVTNYLLHsMpCXLt6ndBtwqaQtYZc1av9x1tSiM4d2j3OzMhXfDAyAtB6A?=
 =?us-ascii?Q?caix5vczEkbhT7hYUKCLJphFv2Mtd7aeeryLfw0PO9tZIrSSsgOSl7Vu45TJ?=
 =?us-ascii?Q?M3HTkAKtxc9n769agjdq7Rjv8Xb67tiwrVXtu7LIFtFEPO+2Dvcjk1gzhBMZ?=
 =?us-ascii?Q?n7PzLC4E9JKmYiUcfAnzlaoXMAPGu/Scj/uGJJSOsgurgk6LBirBVkiTidst?=
 =?us-ascii?Q?EtkWzb0m1xPVmIh2qXyIIjquLwzIPeBCjfV4oeGmOjK154sxd323TpqYERhq?=
 =?us-ascii?Q?MeGE6yJ3fF5OMe0y1MuNRPIB3PcBme23rV91CLFUjSs9f/qnrbrgVCYTMJ54?=
 =?us-ascii?Q?vEAFBikCgQP854jni+ZB7g/PCVWubayp083HNbUy4YzAis1RB897YG0+PZGF?=
 =?us-ascii?Q?enG/dcCEzp/i680bOk1Qgus5Pn3IRmDExqOM60f1QNOAmhwzdpc8ypa6JMEG?=
 =?us-ascii?Q?8c4TvZjqH4y5NEg+2cNo9G2zV92yFEEJr0ZTyv5xwyPpCS0d38XRH/cMEgEm?=
 =?us-ascii?Q?rGLGIoI3dDBM36z/+4a2rtsl9CU1m7j647VZwf7j64w1vl7IUvm73n69mw5k?=
 =?us-ascii?Q?buLcDlNezNWcz5N5k1jZZpN8OGup2c9cXuAI8mizzesVRIY7Wb10NVB6er5J?=
 =?us-ascii?Q?m3U1SIqz+bQaPM23+RodxmxvpczBj8OhknaHymKnPXoYnovUeDgRHNS09nEP?=
 =?us-ascii?Q?/LmLe3YJzjtYMGZVQXo+M1liswC/BQSYatypIotxTaKSgHfqGOIw3rczaLlm?=
 =?us-ascii?Q?7ecDr3v4MK9e8DKF/ND9SirUkLoP4EP40DNvfPv2xfpiQ6uIFIE7T2ehqU1B?=
 =?us-ascii?Q?6JkxGXNpk6gdLpS4Xkwa6zz3AXEXdJZLyVLKaP9vtjZCnf+NNfgGWyHcjVEO?=
 =?us-ascii?Q?NEqfNm0E2GQGa7snfTd94FMcBoC1zo+8bOVhHn55zzPQbeqqf3NIS+w8CnkA?=
 =?us-ascii?Q?X7T+6MrfJoZCXfKOOqZMbzX6aPhajMfkEU1G5I4RT+wF98tU3+1ezoWYZzef?=
 =?us-ascii?Q?Cya1AJPJbfmARFB4FTpCxqWdM5l1kREycBzUtdqkrYGxDLCBb06KpdaJwSV5?=
 =?us-ascii?Q?ZbLI0GqSIPN7/ZjZ+R+4GW3x6vLQlEsWwBR8wg0n+hQV736i+vRmPGbo6hks?=
 =?us-ascii?Q?63grASohFUObReQZTVuZtfTRA4XvjGvhy0NxNvUhqlz2gv+BksdxN7Wtk2is?=
 =?us-ascii?Q?HKgDiqXgC96Vc3oVXxOKPspCIJWsK7sYKh4NzhrCInHwvlK7vYGg6HERADfE?=
 =?us-ascii?Q?5LE66wQatg6Hv3ceHpa00ks2I5ToJkIY1lqsbR42o/Zzl6MSVz2m92aCt15q?=
 =?us-ascii?Q?WHdzaOI1CF0Rcg+3ChOCCrgisaW2ReprO7AVS/JPKdcJdLG2S7/gW+CCc2N6?=
 =?us-ascii?Q?K1lbfkTlUkTrduPyuHfS8flMMQaX3nxed/tOChtXQmAbECHTu0ib+U7rKmCQ?=
 =?us-ascii?Q?cSpc3i7dWgjOjgl4hqMB8ehANuiFO/xelmPaPHbj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a382b775-ba3f-4e4f-381a-08dd23f429d1
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2024 08:22:53.7847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YipAk9DfwKWHACwxyxZrq5Vu0W+qS28dvmnrfoUNVH+8i2ebJLEnXphwrWhzo6Zntf5W10gmPa87lp/5BwEhNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4245

On Mon, Dec 23, 2024 at 06:48:45PM -0800, Yury Norov wrote:
> On Fri, Dec 20, 2024 at 04:11:40PM +0100, Andrea Righi wrote:
> > Introduce a flag to restrict the selection of an idle CPU to a specific
> > NUMA node.
> > 
> > Signed-off-by: Andrea Righi <arighi@nvidia.com>
> > ---
> >  kernel/sched/ext.c      |  1 +
> >  kernel/sched/ext_idle.c | 11 +++++++++--
> >  2 files changed, 10 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> > index 143938e935f1..da5c15bd3c56 100644
> > --- a/kernel/sched/ext.c
> > +++ b/kernel/sched/ext.c
> > @@ -773,6 +773,7 @@ enum scx_deq_flags {
> >  
> >  enum scx_pick_idle_cpu_flags {
> >  	SCX_PICK_IDLE_CORE	= 1LLU << 0,	/* pick a CPU whose SMT siblings are also idle */
> > +	SCX_PICK_IDLE_NODE	= 1LLU << 1,	/* pick a CPU in the same target NUMA node */
> 
> SCX_FORCE_NODE or SCX_FIX_NODE?

Ok, I like SCX_FORCE_NODE.

> 
> >  };
> >  
> >  enum scx_kick_flags {
> > diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
> > index 444f2a15f1d4..013deaa08f12 100644
> > --- a/kernel/sched/ext_idle.c
> > +++ b/kernel/sched/ext_idle.c
> > @@ -199,6 +199,12 @@ static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, int node, u64 f
> >  		cpu = pick_idle_cpu_from_node(cpus_allowed, n, flags);
> >  		if (cpu >= 0)
> >  			break;
> > +		/*
> > +		 * Check if the search is restricted to the same core or
> > +		 * the same node.
> > +		 */
> > +		if (flags & SCX_PICK_IDLE_NODE)
> > +			break;
> 
> Yeah, if you will give a better name for the flag, you'll not have to
> comment the code.
> 
> >  	}
> >  
> >  	return cpu;
> > @@ -495,7 +501,8 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
> >  		 * Search for any fully idle core in the same LLC domain.
> >  		 */
> >  		if (llc_cpus) {
> > -			cpu = pick_idle_cpu_from_node(llc_cpus, node, SCX_PICK_IDLE_CORE);
> > +			cpu = scx_pick_idle_cpu(llc_cpus, node,
> > +						SCX_PICK_IDLE_CORE | SCX_PICK_IDLE_NODE);
> 
> You change it from scx_pick_idle_cpu() to pick_idle_cpu_from_node()
> in patch 7 just to revert it back in patch 8...
> 
> You can use scx_pick_idle_cpu() in patch 7 already because
> scx_builtin_idle_per_node is always disabled, and you always
> follow the NUMA_FLAT_NODE path.  Here you will just add the
> SCX_PICK_IDLE_NODE flag. 
> 
> That's the point of separating functionality and control patches. In
> patch 7 you may need to mention explicitly that your new per-node
> idle masks are unconditionally disabled, and will be enabled in the
> last patch of the series, so some following patches will detail the
> implementation.

Ok.

Thanks,
-Andrea

