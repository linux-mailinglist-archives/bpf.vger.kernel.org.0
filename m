Return-Path: <bpf+bounces-54228-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2BE3A65BBB
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 19:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 532D23B2E1B
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 17:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7311C861B;
	Mon, 17 Mar 2025 17:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QeCjYTEW"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702C21B78F3;
	Mon, 17 Mar 2025 17:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742234296; cv=fail; b=XZrYRZzTooomGxsVkLsE7iQYb9bn3y6fqPtJjl3/dsDz3IeD3OUETee/gnIijoWdJvjViq2oItPkWHV2gA/Iz4ZOjFg2MknHh7LDXVoVIWd7pKyYX5LxRuBg7xaHAtdLWNtUMYpShE+1IpzDTOyeE1snlKzOuSvd/IP5w4/jK10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742234296; c=relaxed/simple;
	bh=4VUlLFaGJiaHMyxhbI1wz4ycpa+Du7CC08Q+Dm5fHv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q0+ojR7VqW6cnz5aD83FmJbNL3ceiseBPEPQKq7Wid1ZvXQKOxbr+E2X+pnLpOC4Igd8/azNE2knpWql6ltltkpkg/oIg8h77TqpOoYSzBx+SrRralnZpid2x/IVh+18AOjW/9dqP2Ss5baOy5GrQHjgVJxGZ9+qFf/UbqV7lRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QeCjYTEW; arc=fail smtp.client-ip=40.107.93.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hvNYK8GrfEDQRwhqjKrnY9GtZenJSKJAedapQFJ1E9sSwOvJdCUBgLx3BKyA0MIqqDvcOQMTWdDpO5grAjgQvjDnOrpHEs0j0+9KXnx2aoNSkhtxz7YbP+YRPzuAYukLyoXAHxVJwjHDxnVBOmS9HAcmIAs/HiWdwrg+lo8q6eh3ZAEGFnFZy6hh0RIJFymPl+3xBzrWsTEpm4kn4YtWHeRsXeRIz5XJz6037yEirGcFVm9C2dbGoZESaM3C/lsMz1a0O3q4q3FdMThAI0IZ3YO+P9q8UnpExY1muBCpB7ViMfzq3kM8pGrlBUUySV/zbTaoWsm1b9q2MtzQdXD5+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5dsoOVM6R9tZdtXR5wfO18r3mWeI34mQkcfl9Plshxo=;
 b=LpkX9QOvSxdXb9+Gw6RExSO90JQIqZiOXMBNrDuc0WO7a9Zpv2bW1nwSMUHdB2IDY4uON4Of4MPMDYD0v3cY0Rn3LZ4F2Dl/t2Q8fogV2tYi3vfPiqM2dSw2FIvqMN9mrRGOYuolp+ENM6aBqXsP0MyR2mzUFaLkMPNJJHtduH8pyaVcJPG4+VHfTLU9a2qdFef7y8bHuRGYYLUL+Eo5Fdloet2ACU544QenfIFhuuouPsFMNNkGao+RcPbUv7qBftPqv/k9Ir5ZGv02u4gPTBV9KKyio5N3agI1jhnvr6ocJJ51BH3g30s0eSOYlzOA6Oko7M3lVyrpVL9a6hcBfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5dsoOVM6R9tZdtXR5wfO18r3mWeI34mQkcfl9Plshxo=;
 b=QeCjYTEWq23+yL9Sasog5cQ8ilZ92Cs2bzrHgIvkh2y4kP2UdltvT6EfhHzv9Z2/J3e+nqcvIUiPRf6UwUfwzYnZ0fNmcbOGHSXwBrEx8RJe1fI2puG0SHMNDwyxFamXCRx0W7tdeC46DgeYIyr0oIrG7hfagvb9fRdAkSx8Li8zf5XwOd53z0dYScONenF2H3laolbbJZ0G+tGKLZf01BoY2me34svn9Mg7XLJPdkNzNARurVo9+L/uvYaJzUC/b29oYD1huhkq2l979tAqgBmYG8CXyyngVjGwnluK5KizTgKHoOBnPXUYvH1C8NSpupDCpl9ZDvfCp4ebMIq//g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by MW4PR12MB6826.namprd12.prod.outlook.com (2603:10b6:303:20c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Mon, 17 Mar
 2025 17:58:11 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 17:58:11 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] sched_ext: idle: Introduce scx_bpf_select_cpu_and()
Date: Mon, 17 Mar 2025 18:53:27 +0100
Message-ID: <20250317175717.163267-5-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250317175717.163267-1-arighi@nvidia.com>
References: <20250317175717.163267-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR16CA0015.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::28) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|MW4PR12MB6826:EE_
X-MS-Office365-Filtering-Correlation-Id: 651c2512-7b7b-4701-c049-08dd657d47f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oad83Q6oHDn1yHEual/B90rcKGFS9snbg9pGMLeGqNkYEjH06y2NL8VK8fNJ?=
 =?us-ascii?Q?iNm+IP54wT+Vw+AmfIhGpwODfI4TuNefnECT9HISKCdnVezmgPu/K3QzFFbq?=
 =?us-ascii?Q?5fA4OoL8fDqbE6O2k3Hsuq487nKjvQ/oh7UJ1jMpRiBtbCImCJ/Y2hTA8CZ7?=
 =?us-ascii?Q?qVOyYxuX2ryF6VOVFnWMUfZEPBJ0r8JVAnxzd3Twoeg03Z9T5k50A+L0wJ/a?=
 =?us-ascii?Q?DKAz9e0Te+jQM9SRJj5kJj0WkaxE4BJji9uxGLB9qVMf5JGX10Q8amKRz2u3?=
 =?us-ascii?Q?1UPwufcxhmLBFKnI7MFYAFsT69F7+uIsMIheBKuQkJ9HUbC+Sqwrt5wIVhzy?=
 =?us-ascii?Q?kOrvNFs8HV8FvfKyfG9UTJS8tMU25E5etTHo63QRGj1S7gavQbOUmG6XbUu+?=
 =?us-ascii?Q?vvO9mxQwB+uzwPNWf3oz6l2W5Kwi2oCZHOZxEhp3ahq5nHMZyVXOOWmkPnRd?=
 =?us-ascii?Q?AnM2lt/RCX09JHxZgJ0nLwYDZp2RL9jaMBVX3vE/lEeTrsh7FeJzftMtiXj5?=
 =?us-ascii?Q?4gCxm2z5H6nD0kjOnMDt//FTzOupUGIdWpZ3H9feT0A54aUVcNVdeEiklMqT?=
 =?us-ascii?Q?kzPC8ceIT4NFCOFNEurBfe6+DyEO0NG8ssgt0dPQEgW/CUjBAnAjx/bTKdZ4?=
 =?us-ascii?Q?3yMDyguADCeBEVUoqfVXZWkIPm3waQiJmsu0ksnflrHQ9Z1cX3DBVP5pNzAO?=
 =?us-ascii?Q?OUTnDjvdTXQmhY+f7xZSUAoBjGOphYq/fqxgrf8u+rlRbwAU56rHqaNjh4yv?=
 =?us-ascii?Q?0HYjzTqxsZX4VZ3u26T/DIGARiQ2WkLAtCO8RCg3247a+/fOgjM9K43nbROU?=
 =?us-ascii?Q?PpmOxXWJbDrwlIhaw2Lp5i9j89U+l5nwQkDCR50Yok3EMho0d0nfJiL5n6bO?=
 =?us-ascii?Q?X+McVWbedk/z+af6Ggn+tJk/Vz2gtXGYi0yUC7NvYwchjYKE8fvwNM7opHnD?=
 =?us-ascii?Q?p8FIsS+aQiZHeM3sDbwwybwEv7um1eCivv7yG6PILaazWodAqd3xvfIH1o+J?=
 =?us-ascii?Q?1hUQDARBDJoJqeWd0JEiTpg0z9QIHJalBw/sWqYmsMJe1ysD9QVc9BR86WmT?=
 =?us-ascii?Q?hePj1WfrVLGFb/hPq8M+SyhtZH999t7CPUGsMS7MvrUlxsTGdqnB20ntzTxT?=
 =?us-ascii?Q?6UARfJVVtfEy371EyetKRLW1Xp2LoZezFtrhEzBJH/0tXG1U7a3BEeXDgrPQ?=
 =?us-ascii?Q?A6HI6M4FVx9lFaYDnS2Tqj8bXWsKGAZwyCXPZO3wXHiNjS766XD6xvOuj+ts?=
 =?us-ascii?Q?LWXKxHd00x6wi0ObhsLEC/qu1Gmaz3olRWSW9VHKJzJdWhOh2X4drPUUYA6F?=
 =?us-ascii?Q?PPs2IR2cCjcHw+xyzevwSPs4i/rla1Mtydv5cDhd14arKFy+e2NmVWo/LeFc?=
 =?us-ascii?Q?yiIefV3lbVcYSLozc0A58DU1B9um?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0j58LHWVF6O1Zwrtxq+VXMDk8voH4wMiOC4jCd6ScygGvWfx0t2soVGICdel?=
 =?us-ascii?Q?6juHLtSeN/BEnGn5/qUSbLYP9UNd4xe0uGJbVZ87l1yFPC0imOEjM4+rImJV?=
 =?us-ascii?Q?QAR56zEj3xoF9LWVieFncYh8ms73O0T5q5RCfp4vsEM/Mo14UB3q4lYGGEEb?=
 =?us-ascii?Q?29IyBWDI0oXl+ADNPqM8hb/as5n7jm+G38CEYH/TlYkGlZqTEVWF4JxdLwnE?=
 =?us-ascii?Q?l0aFp/n8iFFvLkbgmnDFQghuiiNdRD+OTcW1jLyG+qYfNSD9meNNVGr824wY?=
 =?us-ascii?Q?Hd5KtAvXs2R9jsDAaZW/0j4T/odt43ROCD1I8HbBe7ziCzLBHi794W/tOWfq?=
 =?us-ascii?Q?Q6Zj03dCTBEZb6zP4W2uouw0pv4qO0+oVudq2RI5a+u7krTfo5KoaihFSERu?=
 =?us-ascii?Q?l/Ad/CPcyFOph/3BhmHqp2aJdyudZdCERq5vFBU8br1YrJwKaQgXwhy7o85m?=
 =?us-ascii?Q?8CDvBq12OMUQODuguP7iCWzRsueNMJ8Dag4NLvVFHXBt4/HI/Csiy893u9Zv?=
 =?us-ascii?Q?G1KOyGDNniMRE1dchNE8iA/AiecXggrXtSisSCnNmCtzymCc6ThKZ//WA2/v?=
 =?us-ascii?Q?YM/b6ReDmt8RjlH8Hah/EYStJszh6utl57rYVKQ2SbgZnQpjhBdnhw2tjY7p?=
 =?us-ascii?Q?aVlwwc4VnxIlkFfw8JBXf3o44Ar3UrUI04UTrOyL8Q25sHCuaywNZK29dHP5?=
 =?us-ascii?Q?8NhmnQ8Wy5ZhLIbsErUfNMCcPVqEvaJ9xJqAvfC8/7vMl0BJf5P0fwPaSs1d?=
 =?us-ascii?Q?zfBLj9NESvb2tfwGu4Bs8VfEsUOVq/oVmZiKPiZZ2S4y3Zf6ZsykWKgtKY+k?=
 =?us-ascii?Q?i9H0ZBjH/YCYxUU/suNegrdUABOHmjvZKzy1IsfmWpdhPAGPPnWzYY3YNeG7?=
 =?us-ascii?Q?ZrjdtvCmMZYRgzGHUzbqEOz3v4QPw7x5ds5xfSq8FdIsUrOqsrqMLPNJ+nrb?=
 =?us-ascii?Q?uPq/E28u8J3e9O6VBbYjNUKuVLrVaKW4Z/LGiBukVOkWBhvDY/25+c5IBUry?=
 =?us-ascii?Q?w5EW3lYhTA406thLpuxX7SU7zhVes2Zue7wgfDIIcrU5EaFhjCHsubXNcY+/?=
 =?us-ascii?Q?vQEn13XijQyfJL2QI3xtYsqAS1hbda6LT0VN0AyDClcIKjo1W5RDezSvI47b?=
 =?us-ascii?Q?zfiBWs0aSo2kxSz++MklcNoi0GOqgqDiW0BX8oEchljeHpB1OvhLt9amV7Hz?=
 =?us-ascii?Q?L0ESKyZZB21BsxxBaD5XocSlO/VZEHdyXgdcTWEcFfIFxbQyGDLS6qSDJFIH?=
 =?us-ascii?Q?cIl7TNSYrcjlv98rj8BllhmGMvPvKgyGt9eF6vZGSPrQGx/Y66YKzITf2EyW?=
 =?us-ascii?Q?q8lFHX2WmHlgACuQFyu+ZEGY2gPWq1F0NhiQZtVQtdWnAkBdwaGqsAfQglsN?=
 =?us-ascii?Q?x42/jSrGoricg8JsKxAoDPiaYdXsauobO43pVEm12w2nrNH8AUYYiosfrHOk?=
 =?us-ascii?Q?ZBgB2H6D7I5slac/2Iy7ZCuX5YxcPiuWSkQAzmxTzYRsFRPn7lP7hEAvE3fB?=
 =?us-ascii?Q?gCQYVqYMiCswrQGhDJKUfCjCAl6spaotBXMsSDybCtQxyjXPCTOZL8Q+GZ06?=
 =?us-ascii?Q?iGaADW0cM8pi9G8uO+WAbLDG3pnVp8uvQU/MAzDs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 651c2512-7b7b-4701-c049-08dd657d47f8
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 17:58:11.0304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LrPnpK+lr4yKjkig0nIET6J4JScMU9ykKRRodttjNfR+wXSGiakWLAuglkWNQ1elkOa7E+7KcDx4rvjtyMdb6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6826

Provide a new kfunc, scx_bpf_select_cpu_and(), that can be used to apply
the built-in idle CPU selection policy to a subset of allowed CPU.

This new helper is basically an extension of scx_bpf_select_cpu_dfl().
However, when an idle CPU can't be found, it returns a negative value
instead of @prev_cpu, aligning its behavior more closely with
scx_bpf_pick_idle_cpu().

It also accepts %SCX_PICK_IDLE_* flags, which can be used to enforce
strict selection to @prev_cpu's node (%SCX_PICK_IDLE_IN_NODE), or to
request only a full-idle SMT core (%SCX_PICK_IDLE_CORE), while applying
the built-in selection logic.

With this helper, BPF schedulers can apply the built-in idle CPU
selection policy restricted to any arbitrary subset of CPUs.

Example usage
=============

Possible usage in ops.select_cpu():

s32 BPF_STRUCT_OPS(foo_select_cpu, struct task_struct *p,
		   s32 prev_cpu, u64 wake_flags)
{
	const struct cpumask *cpus = task_allowed_cpus(p) ?: p->cpus_ptr;
	s32 cpu;

	cpu = scx_bpf_select_cpu_and(p, prev_cpu, wake_flags, cpus, 0);
	if (cpu >= 0) {
		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL, 0);
		return cpu;
	}

	return prev_cpu;
}

Results
=======

Load distribution on a 4 sockets, 4 cores per socket system, simulated
using virtme-ng, running a modified version of scx_bpfland that uses
scx_bpf_select_cpu_and() with 0xff00 as the allowed subset of CPUs:

 $ vng --cpu 16,sockets=4,cores=4,threads=1
 ...
 $ stress-ng -c 16
 ...
 $ htop
 ...
   0[                         0.0%]   8[||||||||||||||||||||||||100.0%]
   1[                         0.0%]   9[||||||||||||||||||||||||100.0%]
   2[                         0.0%]  10[||||||||||||||||||||||||100.0%]
   3[                         0.0%]  11[||||||||||||||||||||||||100.0%]
   4[                         0.0%]  12[||||||||||||||||||||||||100.0%]
   5[                         0.0%]  13[||||||||||||||||||||||||100.0%]
   6[                         0.0%]  14[||||||||||||||||||||||||100.0%]
   7[                         0.0%]  15[||||||||||||||||||||||||100.0%]

With scx_bpf_select_cpu_dfl() tasks would be distributed evenly across
all the available CPUs.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c                       |  1 +
 kernel/sched/ext_idle.c                  | 43 ++++++++++++++++++++++++
 tools/sched_ext/include/scx/common.bpf.h |  2 ++
 3 files changed, 46 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index f42352e8d889e..343f066c1185d 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -465,6 +465,7 @@ struct sched_ext_ops {
 	 * idle CPU tracking and the following helpers become unavailable:
 	 *
 	 * - scx_bpf_select_cpu_dfl()
+	 * - scx_bpf_select_cpu_and()
 	 * - scx_bpf_test_and_clear_cpu_idle()
 	 * - scx_bpf_pick_idle_cpu()
 	 *
diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index a9755434e88b7..e7aee9aa4841c 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -930,6 +930,48 @@ __bpf_kfunc s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 	return prev_cpu;
 }
 
+/**
+ * scx_bpf_select_cpu_and - Pick an idle CPU usable by task @p,
+ *			    prioritizing those in @cpus_allowed
+ * @p: task_struct to select a CPU for
+ * @prev_cpu: CPU @p was on previously
+ * @wake_flags: %SCX_WAKE_* flags
+ * @cpus_allowed: cpumask of allowed CPUs
+ * @flags: %SCX_PICK_IDLE* flags
+ *
+ * Can only be called from ops.select_cpu() or ops.enqueue() if the
+ * built-in CPU selection is enabled: ops.update_idle() is missing or
+ * %SCX_OPS_KEEP_BUILTIN_IDLE is set.
+ *
+ * @p, @prev_cpu and @wake_flags match ops.select_cpu().
+ *
+ * Returns the selected idle CPU, which will be automatically awakened upon
+ * returning from ops.select_cpu() and can be used for direct dispatch, or
+ * a negative value if no idle CPU is available.
+ */
+__bpf_kfunc s32 scx_bpf_select_cpu_and(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
+				       const struct cpumask *cpus_allowed, u64 flags)
+{
+	s32 cpu;
+
+	if (!ops_cpu_valid(prev_cpu, NULL))
+		return -EINVAL;
+
+	if (!check_builtin_idle_enabled())
+		return -EBUSY;
+
+	if (!scx_kf_allowed(SCX_KF_SELECT_CPU | SCX_KF_ENQUEUE))
+		return -EPERM;
+
+#ifdef CONFIG_SMP
+	cpu = scx_select_cpu_dfl(p, prev_cpu, wake_flags, cpus_allowed, flags);
+#else
+	cpu = -EBUSY;
+#endif
+
+	return cpu;
+}
+
 /**
  * scx_bpf_get_idle_cpumask_node - Get a referenced kptr to the
  * idle-tracking per-CPU cpumask of a target NUMA node.
@@ -1238,6 +1280,7 @@ static const struct btf_kfunc_id_set scx_kfunc_set_idle = {
 
 BTF_KFUNCS_START(scx_kfunc_ids_select_cpu)
 BTF_ID_FLAGS(func, scx_bpf_select_cpu_dfl, KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_select_cpu_and, KF_RCU)
 BTF_KFUNCS_END(scx_kfunc_ids_select_cpu)
 
 static const struct btf_kfunc_id_set scx_kfunc_set_select_cpu = {
diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index dc4333d23189f..6f1da61cf7f17 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -48,6 +48,8 @@ static inline void ___vmlinux_h_sanity_check___(void)
 
 s32 scx_bpf_create_dsq(u64 dsq_id, s32 node) __ksym;
 s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool *is_idle) __ksym;
+s32 scx_bpf_select_cpu_and(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
+			   const struct cpumask *cpus_allowed, u64 flags) __ksym __weak;
 void scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id, u64 slice, u64 enq_flags) __ksym __weak;
 void scx_bpf_dsq_insert_vtime(struct task_struct *p, u64 dsq_id, u64 slice, u64 vtime, u64 enq_flags) __ksym __weak;
 u32 scx_bpf_dispatch_nr_slots(void) __ksym;
-- 
2.48.1


