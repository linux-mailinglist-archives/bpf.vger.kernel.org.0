Return-Path: <bpf+bounces-50883-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BFEA2DB8D
	for <lists+bpf@lfdr.de>; Sun,  9 Feb 2025 09:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D47F71887A55
	for <lists+bpf@lfdr.de>; Sun,  9 Feb 2025 08:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B04143888;
	Sun,  9 Feb 2025 08:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nGLNcTrp"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1D4288DB;
	Sun,  9 Feb 2025 08:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739088691; cv=fail; b=Et7gCpGIZbX8gRfKmySysDJ29tApaNxyh/nv0WUpXCNaPea95/80T9dcWhV5E7GU4mpqgvtTECmpAvrZ0e4ka9sghPak0VVAnQ+uRlLcz3uiqRMYddY1tSe/BXHjfu55xPkhFvdmbzKhVUjMZsF+lv532vScbJthcsosVL2nSeM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739088691; c=relaxed/simple;
	bh=CFKyaQEMOWetICozUflTzIYeUZZ0FTp/6PE9wYAJdD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=u5S4e4A5YO/OFOokJGxsL8kEhZmPVP/MpMFFec0VMcrRLW/z8mHlhQUn3eGGeaahT5hQhV1Cr9q91cVwWfjFuFdgfljBkg2MCXLTbTTJIGiJ+XV8Tnh3DmmscDZynme7qDXzEU20P88Ir4N0ZOquSk00d3yX8sGojRnZAcJrnu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nGLNcTrp; arc=fail smtp.client-ip=40.107.223.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OZj8jDkx0XqzcAy6M/CSvu11MeAgadVocgXtOo84ESHses9hCDXyJzli2smr8bMpf6KcX78k9nEaSjAkvrko9MSYpiCYqyF0KS0oCsr5kcLHGMvjI6c453Ur6A5zfAs2jUDMOfRg38VO7q8gqTd6Q4SFeNnfVN+p3D0I8jrtp98Mvqi0uZesYEWypxP+BJkGYO8uCxJ8H3DOkbBh6wpP76hftxIEHiSqZzcfjNiwyz6hGXQioMhqO2nM1LzoTjCActvEQf9PlB2uLkD2xVFz3IaQUQyA2cJVwna1UoRHRfr5Yq7Ws/Ul2/PmHh3mMn2OoNYLm7EdR3bydPNm45HFRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WiTlyg+j8CDfLSpCRApuNUbmkaoOA0hfFll0dm1U7tI=;
 b=zJbSBYzfaLcEc9NfJtykEF4E5nq5lSOTnrCFhv77TZLnXeq7nN4W9Vzsp0I/ttjcWKYWotiPccvoWUuIb0f+KrUMCwrprzhIJ0dCe39faa1Y0g5ov680S5osrjCgd8i9RBJ7jjUc3pG6SR3v1YKbM+VQJPR9eE02lOSjgBC/eOBumc3gScsRLhnwbGaRnluFIioHvzPSU+FeuHW9fbBce+qE7+qy+LlIS6sc8E3WAwz35hmGmRNw/3Ic93QEv0LXNKJmE5gkfLT8lNH9pq5YPN5+npOU/HOJ6W+xjP3zNCKASbUzVCMHFJc5SUi/SskrOJIFZCriCdlFxXykteqpsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WiTlyg+j8CDfLSpCRApuNUbmkaoOA0hfFll0dm1U7tI=;
 b=nGLNcTrplnBFMrf37mhcncmpls9S/i7vMaCRqLwNA3I47qIIVyZrH5mQYnG8e+R13vE4XEpBE89IGYePGw/juKmP/q/ceycbdpofne6Au6cx9To/anxWCfUR6mBDLLqoLqicIRxemzbfKOUTMJqEVvON6lZNdjr2mAddriKB5nIDi3I1ON4G+Ces9bOD8jUb7ZJwXXo17yalX31HyxYQMF4v4OeAcIrdbx9X4f2ilk9YCqfhywXxrs4Cs3JqGcRj1hJeHsxMsnHEHG7K1stviS+Kxe2cxvlKJrTzMq1a4nzaL6waj1eMe6rRxgHDc5r0xU8HIG07IjeKWTz5ok51bA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by DM3PR12MB9351.namprd12.prod.outlook.com (2603:10b6:8:1ac::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.15; Sun, 9 Feb
 2025 08:11:27 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8422.015; Sun, 9 Feb 2025
 08:11:27 +0000
Date: Sun, 9 Feb 2025 09:11:15 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Ian May <ianm@nvidia.com>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] sched_ext: idle: Introduce node-aware idle cpu kfunc
 helpers
Message-ID: <Z6hjI3ul5E0BBtjp@gpd3>
References: <20250207211104.30009-1-arighi@nvidia.com>
 <20250207211104.30009-7-arighi@nvidia.com>
 <Z6aLvYaYlQ3KRZQM@slm.duckdns.org>
 <Z6chqn0Xf6xhL5gA@gpd3>
 <Z6hLvxEKFlgmIeOQ@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6hLvxEKFlgmIeOQ@slm.duckdns.org>
X-ClientProxiedBy: FR4P281CA0142.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::6) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|DM3PR12MB9351:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d24a22e-c439-4ef5-99ff-08dd48e15a21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8IbcfMzQ9d5B73JCuaSBTIME3+lLkgGypUzWh0nQBgi7MV+9BseRRJMry+Ly?=
 =?us-ascii?Q?urNjlctUfZNhmr6MWjKhUTK45uJqNudIWvNOZAE1xDDtwRxJaIOu2+CEs2ld?=
 =?us-ascii?Q?Oj/ful13cPOOzeTk2sV8giyMLn6UpyOQCnsTxnFVTNxAOeD/nxCHru3/3lb7?=
 =?us-ascii?Q?XDUEPg9A6fiBVM5zMKA9Ox58WNR8RvDJggAluU9t8LfQoSvfSnRSq4Nug1ub?=
 =?us-ascii?Q?PkyGkRBAIgK1g8Z11yRMxhRQC4XpMe25HDqRCkHlr12RhS7gLBdyG00bQ7Pp?=
 =?us-ascii?Q?VIzR5sIKn36MxTQS5uXqrHYg1Jdi+ee0rck0gnfYC6l0pfcMcKqOBTknppgi?=
 =?us-ascii?Q?7v9WwkXXCDw8oGO8T13xdAzuTmwcrlIgPHB3wK8icQlPNYrlpfkvUVdK0Bi9?=
 =?us-ascii?Q?fmsFSaEMoILwehCRWC/R4jgLfecuA7iGeG3nO8gEcsxvZxmfO8g0TpghGYAk?=
 =?us-ascii?Q?YGXeSvazR9ujWjJj6nJPWLxMmc0JAID9bQHNkuscFyVTf0y/43+wZA2OQmab?=
 =?us-ascii?Q?MAZmswL1B6ryqh2YXV9R6td1/6BJiRFMTZIQu5Noy0ToNM4fDURLzdTukuho?=
 =?us-ascii?Q?OQnDUY96Bffh6tmPiY4EPy0Vzmw/6QufqwZOcnblm8teNkaaSEZot3dnI7Sq?=
 =?us-ascii?Q?HVZL9N+yCcC0W6ghTPEKc+wR3t5QvLn/L60/6s44W4yk/KqQ/DLv14q4LRZY?=
 =?us-ascii?Q?oF5ei/Sww64bw5WDiYM4KwGIHkwJDTAdtCcO1UJmCRv/bfzYviZCSBXHAlPn?=
 =?us-ascii?Q?dTZYC/6MShTKlggvVF24hyOfM3RiHF+jp7S+tY09jPgXPzvW6WkdZR0cTfya?=
 =?us-ascii?Q?WbMBxjta85fAxVhPoPD4hIUV8GkDOFlhAa4vcQlSVMm1P5Uht4DBgQRsFmr+?=
 =?us-ascii?Q?dqbhP06XVlj3eODc3ZUGb4Ue+JKYy/RfCYzZMH2GC6VZoPAf2RdUac+T0xn2?=
 =?us-ascii?Q?zYPjKjwZQDKcl0b9cxKG0/ZygB/58rWDX0kdGRaQUsw0ZSK6jmA08xxcUPGg?=
 =?us-ascii?Q?ZEO7HcOzKQ1R1EE6yk5CdYqxE3TLO+meagNs+oX1UFbLv3YHFDwQyf0Mu5Q0?=
 =?us-ascii?Q?IKWjBR+tEyMVQXSuut9V4Qkub1QR+CUlMhC+8c60BKh/sf2zgsQFbhHzDjbX?=
 =?us-ascii?Q?Nj9C5OL5Lbxq8aiPtU8Bmjl6teG5ZPZbGGhV3wP7+P5OlUIlRj4jL7bZh/PF?=
 =?us-ascii?Q?iL40fdvpo6dcaHLlKXrN4SnSt/HsSjCF9oiJXTpu8m95FngCFBmrkf+kViKc?=
 =?us-ascii?Q?YRNeq86lhD/SLevrYmESCaj/bAOzU8PE95v4NN6hwfst0QWRyC5tcF3qRqsM?=
 =?us-ascii?Q?6du97f/EYh35PrB5JOjKPjZSlNXKOjT7qND72aqhGrYDATiSf0MsWtCl/E3I?=
 =?us-ascii?Q?Zs9908DCFyAvV9Bb7NMSjcwjp/ig?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6QEmNV+ViVRoqvAp+5gXV2Nku1KoO0p2GbHZ3BHiWj1Bqg8K0VmoHr0jLqEy?=
 =?us-ascii?Q?Cv4tTbch6eL8/hYkoadkkUEGAKJDa0vapWMTSov7Kn1NlFNM1z4pVCLC/0uH?=
 =?us-ascii?Q?qJEUQukaCnI3T3RtPn8jzUaZwih0C6yr0aBt9goBs2PmCZn/2ry8yoOUq8oW?=
 =?us-ascii?Q?O5TBLu+BaKazPUK0nHYzTRgiGkc+b0TSRX34eHQ8P75m5aNxRe/k1/9AV7M0?=
 =?us-ascii?Q?G1EdmmQR7MPxjGfr1r+yEZr698oQn73wDnyGenwSHTHgdIzaxxgWJT3z1riP?=
 =?us-ascii?Q?phcl+/2iCiDa5ZA8SSGR28mOYMamyaed3UtokIQkZOvNYWXw8mXUeq6fUP3C?=
 =?us-ascii?Q?xJJAmvaqLPFY73BsAYQ9CKELlTJ43XkNXCGDLgOdEKYYFdjwsR3kJl2HTLAP?=
 =?us-ascii?Q?bV8pa+lKCrVbn7Vz31MX99t9aHHTHGRE2hdwNtf9yQKcgCP15L3Do26X3SVd?=
 =?us-ascii?Q?zwM9N9BOlPdC9ROZGXaJ92dGPAbRIq/IaKwJMgdudLQ6SZXF6MlfCYbu9EdR?=
 =?us-ascii?Q?08tvdmGgJGtAuXUzvZsWd+STlBcooatXbrGO71LQ33BrjbArQggrrlMzcmX7?=
 =?us-ascii?Q?zjBTHw/HDzJ99L6NRExltiyrr9eXkJuP4XdpePFbVcJ+S+43qrHObTfTdiiR?=
 =?us-ascii?Q?qvPZ4YXDVyzdSIFzHEAikUptg0Y/+YyWTgzyQGkNOEi+1GXwLRsSWLmK1y0D?=
 =?us-ascii?Q?wDKt/8uvcMJA5d4AoW1TgS7uER48BekO9JXWUaAMf2V9f5mJfoQbRAHj1w6G?=
 =?us-ascii?Q?clmnDadHiQb3p+tB4BR6C15yUlljaeAavt52Mj15rac0huj4RPWf5GHGDqBV?=
 =?us-ascii?Q?ZssfYuVDcE3F08ElpYZ5RbY0QcKnsfbhj3qWrsDMFefU5vN80nyJxh5xqCDm?=
 =?us-ascii?Q?vNMdQwEBRvualMn6dkj1HylUNIXaxuCf7dDi2e/dCmrsYSzVHmK1AOaadBKi?=
 =?us-ascii?Q?krukSt/WjUQBSipHIGVjVGwK8thypxaebmH2qSU0Ywj5fzVPizT80ZuGGYR3?=
 =?us-ascii?Q?84gm91za1tlfH9wSPsAd9y6neleqIbwjVH1P9bRKM50wcJ202DUa1Ye/unAE?=
 =?us-ascii?Q?lD4XdraU6L1lpf10cju3JNpPN/l9TH8vss/zhm3MdcY3QrpBc8z2bWeGv51F?=
 =?us-ascii?Q?HoIzajDppZ6Jsu9UYlL85uu4ZpzHR835QCWkeX1vj3aKEHxczYC12x284yN6?=
 =?us-ascii?Q?PFf2pWUDu7C6A2Jd9RuOiRbjUBDRumaGMYMsdOV2ZkZhmsh7YLTKw7WrN20g?=
 =?us-ascii?Q?tZThC2ERA4DZ7hSJmOrwmUaf41NU8g8Kh+kP6NQlxOj2tzdW/XV04d/SbQor?=
 =?us-ascii?Q?6ASgEXkVaLCdv3DCV5n33BBeSLPrgl2j2aicHtVsl+NRI+3UNq4FCMUz6vd1?=
 =?us-ascii?Q?LPShgU2bUluDCKOAUDxgm9ug9yPFmcGQQbeH41TLAyZeExDYH7qypUBdHgx0?=
 =?us-ascii?Q?QXnnYJ3JJw8vSxRoFAJg5Qu6VJYKcz7BymA5krbkeDiEXJ+KgDDH+2xNGzkT?=
 =?us-ascii?Q?KAj8yagAqnZs+4CtEmNhoofLnI8BCSX0BqQ6cUJS1Auuzc55q3NsEtlv863L?=
 =?us-ascii?Q?kIYJvjxx0G/En+jsPVCy06vZKnnKck8VnnhgZXqb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d24a22e-c439-4ef5-99ff-08dd48e15a21
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2025 08:11:27.4784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: quOybYODOHwkTPbv2veNqFM41CTGgS0AQJ4sQrIQuwyCGoYe9A8gIZHG8S9oZOu6ume1LV7UyUi1XJ+8IUMNOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9351

On Sat, Feb 08, 2025 at 08:31:27PM -1000, Tejun Heo wrote:
> Hello,
> 
> On Sat, Feb 08, 2025 at 10:19:38AM +0100, Andrea Righi wrote:
> ...
> > > This is contingent on scx_builtin_idle_per_node, right? It's confusing for
> > > CPU -> node mapping function to return NUMA_NO_NODE depending on an ops
> > > flag. Shouldn't this be a generic mapping function?
> > 
> > The idea is that BPF schedulers can use this kfunc to determine the right
> > idle cpumask to use, for example a typical usage could be:
> > 
> >   int node = scx_bpf_cpu_node(prev_cpu);
> >   s32 cpu = scx_bpf_pick_idle_cpu_in_node(p->cpus_ptr, node, SCX_PICK_IDLE_IN_NODE);
> > 
> > Or:
> > 
> >   int node = scx_bpf_cpu_node(prev_cpu);
> >   const struct cpumask *idle_cpumask = scx_bpf_get_idle_cpumask_node(node);
> > 
> > When SCX_OPS_BUILTIN_IDLE_PER_NODE is disabled, we need to point to the
> > global idle cpumask, that is identified by NUMA_NO_NODE, so this is why we
> > can return NUMA_NO_NODE fro scx_bpf_cpu_node().
> > 
> > Do you think we should make this more clear / document this better. Or do
> > you think we should use a different API?
> 
> I think this is too error-prone. It'd be really easy for users to assume
> that scx_bpf_cpu_node() always returns the NUMA node for the given CPU which
> can lead to really subtle surprises. Why even allow e.g.
> scx_bpf_get_idle_cpumask_node() if IDLE_PER_NODE is not enabled?

Ok, for the kfuncs I agree that we should just trigger an scx_ops_error()
if any of the scx_*_node() are used when SCX_OPS_BUILTIN_IDLE_PER_NODE is
disabled (will change this).

About scx_cpu_node(), which is used internally, I think it's convenient to
return NUMA_NO_NODE when idle-per-node is disabled, just to avoid repeating
the same check for scx_builtin_idle_per_node everywhere, and NUMA_NO_NODE
internally always means "use the global cpumask".

Do you think this is still error-prone? Or should I try to refactor the
code to get rid of this NUMA_NO_NODE == global cpumask logic?

Thanks,
-Andrea

