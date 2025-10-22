Return-Path: <bpf+bounces-71842-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DECCBFE050
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 21:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34C741A03AC3
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 19:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1472FD699;
	Wed, 22 Oct 2025 19:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VvZiK+/o"
X-Original-To: bpf@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012027.outbound.protection.outlook.com [52.101.48.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A794E2F1FCF;
	Wed, 22 Oct 2025 19:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761161166; cv=fail; b=J3kxKoddDOgrXKTTyNrcMDc/dG4CCQ5BDSRu5HvSUFdTJV6D6UYW5rnlkTs3fKkvRle816DQLctS6AD6XvyOpB94or1mIDeJPxIhfaD+Ms74HyyXeiq+be+K0msKu064yUPQ/9MvZGDTmQ5Ex85hKecSY45RG9D8Y0ZTlBrP4oU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761161166; c=relaxed/simple;
	bh=6sD7JSAClqDEyzmgyDKIZAcBh43pVX0nca2P7lNxDvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QNK6RF4R9aKBuiVJSC4h3Gn9QjOuiYoZWk8skwsEtFcyr545EIf/8A8veTAU2uhmNk0qhEeyL1IZ5h1ynFofseQUEqFamTIRAsJcdRD+pVxupJxajHNtpOzbzgr2vLzpyh9J1DkyOWJ8M6vFTMFVFTswkO7uhOBZse4rkLcYc+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VvZiK+/o; arc=fail smtp.client-ip=52.101.48.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b8UBl7T/teQaAhuvjMiC0mEWfmm4vPfJm8D1WiSF+ZkMKXZAUcW79jpu4jxaS4R5AjvVHoeO84GIohX0gjNKM763eu6krwQaF0Oy4+AaCoAbSOZVkrozLLRRHPv7Ff9STVpHsL6ciTi4Z6lKlfUBlkD6sT+bOhM6lpVwSBR12lCqdkbVRZ0k838vHcKqAhkO0M0UtYT/5yEEc0HhkMB0mxbYNohDyw4INbswmhaelyvZ4ZeDq4zPsoDCDn3cXt4RmdBBipYgfnR0AjssMsVPVX/OZkc51OG5lUXBPLZgfTQQyhbgnMj3NhG3O5XDVAvydzRZWMsWJCMYFCKeblb3lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZWM2HCKu2nahawTnP7z2f0WyFC0CnR6ZClhTos2eArU=;
 b=cX560wu4jTwZYiISjTKu1UTl2B+OUEz6WH/JEo6am75sDXJSfQsIhMgohhgROYA2kSmc5DBRrRaGkgJTqg5kDAli8OsTP1a6uMcaE7MYMoP4L9D0gQqGOSJs7SfPyaZHtTeTk6Tv4yk8OgqzH6Ti/2U2kvwfApIWkEE71T/ZlENBXt293cvG611d3IfwmSfAWMVAGNsn2b5kIYSNikn4KHjYVtMNkdRzID6ps/Dky5n1g+LIwJDQlezo+XOdPVVS7ftYKlxlu324TPc605kSqFKLiHqoj4uG4z7fon7tE04084rC+NKkfRAWKNoEMvPnG2M3QcUVWjD3X1iPyvc+Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZWM2HCKu2nahawTnP7z2f0WyFC0CnR6ZClhTos2eArU=;
 b=VvZiK+/oR4PwNAZDltFsrOQLN12oFeZni730+zaTPIfGZUQ9S/4nNBZv2Kat6a77+GCJ3b0NHtPhd3SvhccIZJ0bSf/s0hscOi1o6oBXMvMtoHSSDSJKHhuYPMgiWsr4ivVzo0UKCNnvPOvPARDCoEGNqJIiecuU0G9z2zghsBRBI72cx9e7aeMateTp0w05SJmo5CH8eCk9WV2mP5AceP+3hlNh1L4xsOlNf+O6ZoqF74FrKk97rmzeWpDBhMG7lva4QIKf29VwAUOTuSrMDraBl7QTWn4eGJgNZrhLXhwMWqrcI+EPL5g0/3VDBFERQz4ewSC3smMnJRAOhBZrEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.13; Wed, 22 Oct 2025 19:25:59 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 19:25:57 +0000
Date: Wed, 22 Oct 2025 21:25:47 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev, bpf@vger.kernel.org,
	Wen-Fang Liu <liuwenfang@honor.com>
Subject: Re: sched_ext: Fix SCX_KICK_WAIT to work reliably
Message-ID: <aPkvuynnGhbI6gpH@gpd4>
References: <20251021210354.89570-1-tj@kernel.org>
 <20251021210354.89570-3-tj@kernel.org>
 <aPiLHWVf0Vp1qUzV@gpd4>
 <aPkkftTJndFx1CEy@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPkkftTJndFx1CEy@slm.duckdns.org>
X-ClientProxiedBy: MI1P293CA0018.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::12) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS0PR12MB6390:EE_
X-MS-Office365-Filtering-Correlation-Id: 698c710f-626f-42f8-4f92-08de11a0d367
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?txhRFl/jlJXKVUvjdJ0qezjAgcJHdxJ2OKMgyBA6yAZdmg66ihR0TV55FHZt?=
 =?us-ascii?Q?KTQqf/X2UsZb7cK3XwIsYm29OU89CUVce1q8Buf6cWEx3b2zCejkHlyekpwg?=
 =?us-ascii?Q?kGcm9663mYKKYV5DMBhyRsgp8X3rPrcA2RfRozC37CYG5ZXP26APdcabpRgP?=
 =?us-ascii?Q?7zIcRv/rHoZTxwsBFJ5/j8/eGQ9MWjy6WbQyQ792G8E6zdEiC3caYzW7CWca?=
 =?us-ascii?Q?unhtOQf/HL4IFA7uW/Ou2Au5AxOt3ftaHQkS2sKaZKyx6vcGtSMpDq4zJMoU?=
 =?us-ascii?Q?PsLi/g2zbxKhP1PdSkUippWPYMl2as8PGh/6yiJch6SsIrZJi4zhEbjwnnOr?=
 =?us-ascii?Q?BJDg2yRHym/Gewa80WDNcQJmahMdAE5g9pm7uoMehN5TvzZI4qPpbzgvlgDj?=
 =?us-ascii?Q?XlcHDaZ3Gv/iJ5BdmPjyp1fhua9EvWBGTba+Fi/+3A0r+NY2FlhXPXzo4Szi?=
 =?us-ascii?Q?62Vkr9IURK0G61cTDjklV/mXKatl0dWrxRknP0LfAoAMLoeaXc7tboMW0xjF?=
 =?us-ascii?Q?RNFvB6wIMXEfdKLTVhc/T369wNgCNsrge15ds9C94i7ImyDTFq2if/SGg1+r?=
 =?us-ascii?Q?rfnD4WDOE3M0NyzPmgHZIpscUQH2nCefb9WfWFYQxuTh47fXzzPbm62JZcM0?=
 =?us-ascii?Q?Qgnv9OBtPr7XZkgrTRRTNt6E0zXqyWuBsgUgNe7WtmpVxBZQVPNQTPH+Lg6Z?=
 =?us-ascii?Q?O3vZkzlBt3tGDA31Y1o3L+5TVRhpuKFDyIEW6daxZUSQ0YQPQ/Fp5wOTg6wf?=
 =?us-ascii?Q?7FFvPm+lnsjzWKjC0yojCxUn6GcWbrZ4HmyDUGf+ems8fL9u4o122UEiVhq4?=
 =?us-ascii?Q?y614lzsVHIg2oCizjjAWoM+k9w36RmRI4xDi/5Rh8P5p/rGC1DQzXvyn+a92?=
 =?us-ascii?Q?SauM7IJTpmU5eS5jmwakpd4p5Qc+Z8+/ZJVQiwnsoLD9tK/Gx4dvd3B9V/cX?=
 =?us-ascii?Q?SC/IU/dAFDPSaO88xOLE+Ew4zgJR6BpEV83d3UuHom1H1qNIFKAhx2yhtXHA?=
 =?us-ascii?Q?39YKlwkRlU76156/DQpStkE9+yCMxczFNDHOGiNNI0857UTv60vpf1izFjX9?=
 =?us-ascii?Q?4aOgvYeiLrzQwZ62ULM1Zck6ewhmTWOuwLt6Vt9qmHfF3bAxOPR3Jmltw67O?=
 =?us-ascii?Q?rzgPaw2GOt0CfdEwF4OXJoJ2P+4L1Rw4EVn7zSfJHggjkeND5hxROK0WykUT?=
 =?us-ascii?Q?hUMYyP8Z3lU/N/6Y5weUiAmJIwll1KE6LF98yC7OOSvgvv9WWWZKMndSOXVN?=
 =?us-ascii?Q?XrSUjJXASpYT8ckXSby2e4wFPHk3z7SG8p0C28Bg37D/7tI/AUxyzq+PsrF4?=
 =?us-ascii?Q?O2wveB32cTnZO8Wbeg/9xz8GDV+SieSuwsXLT6vGEg5DzTU4keCnHydPV1Ie?=
 =?us-ascii?Q?uzt6m7xlNoao1fsAA0zYzmm6Y+EC44zJUJzG4PDHgv2ZesE/7fhqCFd2H+Kf?=
 =?us-ascii?Q?Gu2NhKU3RZIGCbt4mzHdt0ATozPsxeqA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OrDDlWy4MOooPyicKwvhVGakz6zbLJpcG8L7lOrfKzvvikLsMxkit4UkujLP?=
 =?us-ascii?Q?V9nbrTsh+wKKigB1tzjwskU5kDuJdY+XEVg3UVeAK3V3U6DHnIVir9GQXjAz?=
 =?us-ascii?Q?h/3+hqFSPBkUhBuo6Z4ELsgqgZOBVnvL9GoDA/DTeUslZVFkFltt+cDihjYM?=
 =?us-ascii?Q?lCSs/rTD3bjELjFk2pavFjZnWy/u3PMHXQyS2j8rr77FcETgiMDu+uwTQsL0?=
 =?us-ascii?Q?aZD2T+hLv9lR7uR7b5hN5xLL+O9QMKIvpLTLQ93EXPKWfEVEc4JRz9HI9+EZ?=
 =?us-ascii?Q?CBmCdQDDpCybpP6od8dc52VoOG95x0cPMvWoG7xG7Ubn8LbThWsfC6mAcrOe?=
 =?us-ascii?Q?5CPviMXMCHaZt5XUfzLNPLxPSBYQDNQLtL7SIncQujSddd0Bj6KFyTm5fKx9?=
 =?us-ascii?Q?F+HYvCguS5tKTzW4lMgWlsRcNsMs6es6D6yMKUbrA4zh33c1TRCEGcbh6gwn?=
 =?us-ascii?Q?6R075WOHJ5mMiXi0ti2/c8WXv1dZbFcPzxSVzFrcyXVj2a+e3LBPeU65xDix?=
 =?us-ascii?Q?/KM0k5YMoKxL2cJQBntvAD73+hb/7aCCyZTe+4A7xn5RVR7E+gbucFfCsy9e?=
 =?us-ascii?Q?b05LPc6E02+eEGAMnBNrWsmZbbQv435Coh2IMbq82EJVVEjqU8XQ8jZgR4UA?=
 =?us-ascii?Q?7+69MurshmmwOuQe76ipW5vkusRWIjiIrMMRJWTAwFjq3mSqoqAWqOyyYs57?=
 =?us-ascii?Q?+1RvBV2oCuTx83YqgztV0RbA379Dfb8RC2wCfDcbWpde5yGcetw9fe7ulRk5?=
 =?us-ascii?Q?pBbtox0fbpqCaG9DOHFyrVMaO0ANzfv/F28Aw5P7i4YLVpGd1wCm0mEV2syD?=
 =?us-ascii?Q?ZInGNAUMDddQMddX9RWPKOS9+6bbTUnmmxIhzucrp1mmuNQNtTKGd9sRHq8L?=
 =?us-ascii?Q?KVrWSt36TRB6kkb0zNChWJf66O4YKAsldiT1Sbt6C3HNJXtnZVjAlZf3YDph?=
 =?us-ascii?Q?gpeurhBPCtNaTmzrRTrx0OlO+MXyLe2CX6TAzwcxzONmoqfHXCDt3/uQEviB?=
 =?us-ascii?Q?rG/WyWB0/ePIcgAewnONqpM5t+fgeqDOlwAdCWDeBgxrIeL1RDNFYKXTLmbe?=
 =?us-ascii?Q?8w4e0wOcQmeWHow1/9IL5jA0blfHsn9OKKDcnyKcXF/ks6IGZ6Mq7EH2oxVc?=
 =?us-ascii?Q?fK0AcFVb05kUYZJi9L8Wn0qVpltZQFZb5AkukpLlRn+m9tAYXvgEmws22za+?=
 =?us-ascii?Q?vuEB3QeS/7wcuuZv5c/LNASp2qLLoP33N0wc7NrXzuSGmbu/0Z201opJHmR3?=
 =?us-ascii?Q?453zwjFU7IwJYFvSm3kgiR5DBzk0jcsoP8CB9WjyERGhLSsO2ZfdMe4BUkJ5?=
 =?us-ascii?Q?gzho8lOFF4rxq84U6hKIieN0mhFXxfpE9lrueTxQ6ALUzhkR9HSAZRTgfcZI?=
 =?us-ascii?Q?RXpo0f4SxnTbQ0SrDwskXBDj2veJFYU1VQeBniQuUI5ph4hpV+GP7DuTGsio?=
 =?us-ascii?Q?wKkmrhXLIU3IOq0z1ZietD19+G8Papfvypof4ulUy2H9mV7V4METiykJzb84?=
 =?us-ascii?Q?Plm0vF4BNVI6bY1Y9LaRCFldkiISOlumum7QoNhVI+mNq0DgaLa23kLqZkR9?=
 =?us-ascii?Q?IqruegjHV1Dof+FjErxR/ESN5Q1GvpO0KobOIoTw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 698c710f-626f-42f8-4f92-08de11a0d367
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 19:25:57.4067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CrfOuY5Y/dEqjUsxYbRHZG4lebU7pdA/2rMxGi2pLvKOVONTdbVsyiZ6rKk5v9RKAl8X86yuLHPWUH+0TqoShw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6390

On Wed, Oct 22, 2025 at 08:37:50AM -1000, Tejun Heo wrote:
> Hello, Andrea.
> 
> On Wed, Oct 22, 2025 at 09:43:25AM +0200, Andrea Righi wrote:
> > > @@ -5208,12 +5214,11 @@ static void kick_cpus_irq_workfn(struct
> > >  
> > >  		if (cpu != cpu_of(this_rq)) {
> > 
> > It's probably fine anyway, but should we check for cpu_online(cpu) here?
> 
> This block gets activated iff kick_one_cpu() returns true and that is gated
> by the CPU being online && the current task being on SCX. For the CPU to go
> offline, that task has to go off CPU and thus increment the sequence
> counter.

I was thinking if the CPU goes offline after kick_one_cpu() returns and
before reaching this loop, but even in this case we're not accessing
anything unsafe, so we should be fine.

> 
> > >  			while (smp_load_acquire(wait_pnt_seq) == pseqs[cpu])
> > >  				cpu_relax();
> > 
> > I'm wondering if we can break the semantic if cpu_rq(cpu)->curr->scx.slice
> > is refilled concurrently between kick_one_cpu() and this busy wait. In this
> > case we return, because wait_pnt_seq is incremented, but we keep running
> > the same task.
> > 
> > Should we introduce a flag (or something similar) to force the re-enqueue
> > of the prev task in this case?
> 
> Ah, right, that's a hole. There's another hole. The BPF scheduler can choose
> to run the same task and put_prev_task_scx() won't be called. I think we
> need to bump the seq count on entry to pick_task_scx() too. That should
> solve both problems. All that we're guaranteeing is that we wait until the
> task enters scheduling path. If a higher class task gets picked,
> put_prev_task_scx() will be called. Otherwise, we break the wait when
> pick_task_scx() is entered.

Yeah, that sounds reasonable to me.

Thanks,
-Andrea

