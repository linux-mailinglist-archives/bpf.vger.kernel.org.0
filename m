Return-Path: <bpf+bounces-51274-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8260DA32C71
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 17:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17026188C49A
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 16:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B37253F0A;
	Wed, 12 Feb 2025 16:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KlrPoGZp"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653FF253B4B;
	Wed, 12 Feb 2025 16:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739379037; cv=fail; b=WfuroiItxdVj2CuhGevNqnT5ckJ9OqR/67INx4kpywL52rZHE5mHbRGOcbhvqY++pk1W/EXB2bgLiNxaJ9+wxnLVnm8++K02AMB5pul+QNBvAoMbQy00Ftk1vbxr1iYQfCTbvmDo1/Bna1PcbjssyLGZ3hvTSSKlvP1gaKu6lM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739379037; c=relaxed/simple;
	bh=lWucKejBs1Lm4z74Gljw96+nGzwFTJN9BWQfjzT+zW0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=pAd30utJKGzEiC6KBmnDnMPGJ/jGFdEo3uF5tiwbf2oU2aBBCS3aL8ggkweyG4OiB0Ok+IM88yt7dpSYzGP1vvQvy4GiAtoUSTIs7P6DMLsFLqH5GyZCq7X0I8Hv5hGRAKvd04mb8W8MHs8zEXd78jCGeFtA1EN310U8Evn2QxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KlrPoGZp; arc=fail smtp.client-ip=40.107.243.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C0sc85wu6X8s7m0wV74FycrveMMFhSeWZXOoL5FylCi0c9oM9MoOtJvzchrVxHQuWDMoqGJAYjTOSYeEl+eLakd+mksyU3yfmW0ZrS85dFlMRyH/BbCL4yA2OQ47om3sAUY2IZcjAaNhCVILOKKT6/r84qkcb//QIr2Uu9AjTSZHWKPXiReEGleFBVf1hxS4axRw8ioGcF8avwGhdMJQX8+Z/2gMJITq7USoNibMuYBD1HGBTUXpjMODrqGY2Dw/Rqhw7sk8Tp/Ly2DsAhkadMO4YGIqDrPVnyheOg+e2QhfCPKOoC1SM8AtX49AVjfJqSVXULK0FcVcIuNYgx60Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8GmhcK041D9yHoJrL9s451HcSI1UCE3IKQNVViwGhDw=;
 b=ODlEz7/F/RVTNOXuoR2tTQCNhf7OmYD/B0vg1c0S442PMGEVjjmRdrv4wNWJ8noZPzBOJqqubY7/aaS8KTAZQc/N6/X4ZVfvklY0lPYDzz6NSdUmiLd6opYnlD1ntaTZkCl8b5QGjj6nZWSEsJgskB3KT3/t/KSLRfmo1xtH9Z0z2G6aRb10DnW2qJCoOHQH45knqNj0UBKKOncrewmKEf5P6sO0Wt28LI1H9wB5b74imabu/fMefz+RuNvc8E3KlFbQQcgyT9j/aR1UHwtC0sc/HPPxz1Y0MyuLqKYFmEYwOWYkq4qDo6QsKbv61r1VRm+/NypZk678RXXwHXHbVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8GmhcK041D9yHoJrL9s451HcSI1UCE3IKQNVViwGhDw=;
 b=KlrPoGZpEeWWhWg03Ag+sEyO+iqHIqHL72Lf08pQ70cAZJcssPLNfkEera8Se4XazBWlJs8Dw7z8Rfu/mRdzb63mVBSCwXOyhK2JCzCx1QyVMkLh5igoTvSbycnRv/boV7rTA/p+bBZ5NL1bTphGkx37PD/JNgcw6MSdqrE50E6tiOl/IK+9fGSG/EfllgjR6zoKp94Dr5mST2CcIceA5yYkSZJwuAXAheIilbdPHdSXdd5JdlHsdyEv+7K5AczwoM81/ZTRJTamMV0JQWYnwmpWsfYp3Y6+MUfm+xS5gXeiFmbQ/DZfwuqHatt+vW4B0jnGmqxWxZWQWw4R/+OcVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by SN7PR12MB7177.namprd12.prod.outlook.com (2603:10b6:806:2a5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Wed, 12 Feb
 2025 16:50:29 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8445.013; Wed, 12 Feb 2025
 16:50:28 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Ian May <ianm@nvidia.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCHSET v11 sched_ext/for-6.15] sched_ext: split global idle cpumask into per-NUMA cpumasks
Date: Wed, 12 Feb 2025 17:48:07 +0100
Message-ID: <20250212165006.490130-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR5P281CA0009.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::8) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|SN7PR12MB7177:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ce01dde-9a63-42fd-ff35-08dd4b855afa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tbKGJAzCooh2uP9ABTWjf6qC0a7PVh9OyE+DxBfOY8BNajae1eqrCO38aR8X?=
 =?us-ascii?Q?pwAFj9Z6a4NsoUk+NPLOlED6VY79+ue/cn88hKZfZxJTBJC6Lp6j1C6fM6Zm?=
 =?us-ascii?Q?jmQeSoJ5pQrccjW1MN7kP1FoOLNPglkxgqY/Z6vV+n/+ZWUVaApCv7jzgLeE?=
 =?us-ascii?Q?Mg+qoCajPqnW9TryILLO/XND2G8cKjFvelSMaKi7hYp+mZKxEjCSTazNEZxs?=
 =?us-ascii?Q?vwfcRUxe3/UMGafiq6nXCGFTNGLQxklqX4Kj0SIweob9hQeP4+Ld/48f8spB?=
 =?us-ascii?Q?ytawCOIsM7rs8Lrm4F2Yo411ZxSPNccal52lfYiyvxhg+9k2ZhCm2OMuYiMf?=
 =?us-ascii?Q?BParJDbHlqmRXsWa1mz17eq5w+6dctMKc7zuC5E7lut/SOv5ssKhW8w6ZIaD?=
 =?us-ascii?Q?EO+BihtBY3TSw33HxpOhPjJgGe2jZJAUw4thi4hlRTAnGlDiMq0G/KemWg80?=
 =?us-ascii?Q?yzpj5FZXayBrZeVo6WDlySDu0x3YM1yoxdFrLixYOxEYvHmxNktTRUZUUsnx?=
 =?us-ascii?Q?hGrypNNJUjBClGaSInxoH16VVJormv2Odg8jn5pMLhIafkVBzyytzAWP1JmB?=
 =?us-ascii?Q?mjEriQDhpri1CBMc/fsVOR5DJRlkEcL+zXswhrcwaeiTo9Dn6YcM+WjSez6m?=
 =?us-ascii?Q?qqCZ3oGFAkWN+F1kshS2VknrCZd+/QFF/AGf4kcFBFkG3YVgxTJOP/1LsAL3?=
 =?us-ascii?Q?Wd0HuFw5PMZXFoY4WEICgA3SF1AqBcGrO/8+H1NT38YHQuWJktADts0fgdme?=
 =?us-ascii?Q?tJklGWy61JhDe2OJJfOU+xpY3aqFagu4g07SzUfUqIoM/XrcbLeEljryIkD0?=
 =?us-ascii?Q?ZkGUY7N5oHLMDodInDETYE5tRAG0Q4I+JqS726XgcoZW2QtCJy+2Xab4FklX?=
 =?us-ascii?Q?6fVz0fbBKhn4ZaiAKNBMYsWtbRIitD4QCgykvG1oZ0JhEBHbi5Oi13ewLd4f?=
 =?us-ascii?Q?wmvLSBElwCQCbwChxDw3JjJQ8pdj04YaTeLd1Hy633fGZTI7TqRbluAY1eMg?=
 =?us-ascii?Q?iLyxLtuAWCnzEE1xAYCRO8yZm5/Z6/92yq8OazZ9HxK/T76450oH3LnxmhZC?=
 =?us-ascii?Q?EUk60EmZZZtAPHAP86/I1rCUTYw89+fyPUF0dqH2r2kfxJ3STx827DmovaS9?=
 =?us-ascii?Q?9CCcPe4fc1IyHcYHe//boUhOotPh/LFviuW28LhzoZu4ltaKlFGGdCBOeNa+?=
 =?us-ascii?Q?umh+8oNk/UUDut2L2ZArfg+mfN+7aMzVNwFYV9LgcIHs/E+4GNN0hFiZZP4k?=
 =?us-ascii?Q?T5evVvmeKWa29DrXpRXqDch6ileP2LQoWJ4cdGUg42Q4nAW7piR5zos3JBW4?=
 =?us-ascii?Q?cdYlLTAKl+8/rXqrOYc0oycqT2oHwsF6VadlhzRFhh/aHzu+GzTLIOeZ1/IJ?=
 =?us-ascii?Q?Ss1tTeuyoUSL9Z5FsEhUkLzHy1Ig?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AgNusAMUL5iwnhDjjjfe0C9LoiuNf25DjdusPVMA+N+KEvlwm+CAzUhwdX98?=
 =?us-ascii?Q?N0H0JaDxMwjiIF/tECrrUDW2UftZxl/BZCWgN+Vg6+TFMeQJXYS0UFOQj4OX?=
 =?us-ascii?Q?eHHhw8oG1IYGPMgFrL9ohaORDD0EK5Qoy2IqxKScx8OjO0u4S4TT2LHfUdZY?=
 =?us-ascii?Q?7wNs5OlPrVwgUrZTfkwPeKrgnUIc4dUu3SJnynNuvP3dRuxjCR41U4HojIfA?=
 =?us-ascii?Q?KphIRvNFYuPTaOqmBHwzboFpJLwcJukEVamW3uHvWPkCtpPTRrwGTFlDW4hd?=
 =?us-ascii?Q?vTmAEA/EwYHaPSImsg9VqyFq0g2n9Qw1PL6HDncbkGoi5EKZg0wEjz/kn/sT?=
 =?us-ascii?Q?v5gdl5wo0v18ZQ/8cUY3sjV+xSqhro3WcO0AN9LzPI8gAj1AVJGjEM8arR0R?=
 =?us-ascii?Q?oVIRekvSyehrF8maoo3DzQmAW+IiLd/l5PpYgE3ikp50rXQEX5jLLO5aAHaA?=
 =?us-ascii?Q?IhDQ2Ya9o7yDwxN75fTdY3gjwn55VijSGFknORA8tRkuqSNAAECb1P6ak1zC?=
 =?us-ascii?Q?Jm33zbwc1zvhsWK9fC6JUxvFjsdZS6+lAsZLoysm358H0zD6+kJ/hfpbMPQf?=
 =?us-ascii?Q?dPbW3+vDoDLMsusAZCvOdcSaZRozqJFkd6sun2kgRdek/8bftx7blLEe1stW?=
 =?us-ascii?Q?EJd+HLjeE/ekZyhHVPjshYfsZq+CVFWUPwMyth9qf9lMI2Fk1PwImFggY3mt?=
 =?us-ascii?Q?1SXgjcdeBJxUETFIHoatoFgbej2Mhzkg6ZKh9t9qsKVdUWwSE575LLxcO0mo?=
 =?us-ascii?Q?xpNHBg7zkPZGvpbSmYroe3yJo27J0rp/TWOnyMaSgP402DV2wu1hGptdFNSR?=
 =?us-ascii?Q?dm5nXx3mfTP82vhQxtw4qfWCFzihdKPCA40/sbykHPJ329KQnlXWZixkny41?=
 =?us-ascii?Q?7lWIrYMfYHb1fW9NjmILafvpRb5z87CBifu+HmH4iWkdDF87cDQm1EnL5Rde?=
 =?us-ascii?Q?S5frp032RC79syajsebXtx0VizX9uwfT6sThJpeDJTlhmL7mgjwqClbjA0rQ?=
 =?us-ascii?Q?RUlBeG/7j37NgtcFuOomk2mScOsCZTEoOiZ5w+FlqG0ANLqb/Zi1W0iFJGwL?=
 =?us-ascii?Q?g7JzvzGHVKlwwhkCl/YuV7YuN1B3hryysboL3a/5Lbek2+/z2NkVLnnkf47i?=
 =?us-ascii?Q?tn1d9aN3iW7daGn3F0vOurIPrIBvfoGO3YbIY5QlGU4yTq7nVxko5Z7yuYGG?=
 =?us-ascii?Q?dOBzTZ3XZEWAj6osiC02xFV81XS72JJfTNe6QkVYl8YIclgNrvts5eCnMKzn?=
 =?us-ascii?Q?C/QPnz9xxqUG0VO1/eRtgctNwbMXPLYPQHcil6zhzZS/j0GFjQbX71mHRSic?=
 =?us-ascii?Q?XlNxIbzhgoMC8LgN3bm25n1uWDKMXp0vCt2Sg2FPAXItX1EW+UGjLxkVWohW?=
 =?us-ascii?Q?grCw4CvSbx1VfMTto6pWSU7SBkR4XgkXhA6QSYcJlTzk0P90oyKmuwzO3RVX?=
 =?us-ascii?Q?9fySEeFs7pBR1YuGO6/QXijT+7wslV8zVZ3fWNjpVuYlNOd6PVwTHE6xuiAA?=
 =?us-ascii?Q?lPT703UXc/i6JH/kwMe0vZH1t4M9UZygimhOl5zDWL+H3+QcJ5G2chwWpDc1?=
 =?us-ascii?Q?Bua9IjA+jkvQr03h6iIj8AJgl33LlMk7UT2r4jX5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ce01dde-9a63-42fd-ff35-08dd4b855afa
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 16:50:28.6734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sPBpihrcHrl5zPAA+xNmqDB7ewMJfqtpqmF+WZxgify6uPUFLCNL5fqBAzMWCMGUB9JYMsZFJvbExPLlXXSCtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7177

= Overview =

As discussed during the sched_ext office hours, using a global cpumask to
keep track of the idle CPUs can be inefficient and it may not scale really
well on large NUMA systems.

Therefore, split the idle cpumask into multiple per-NUMA node cpumasks to
improve scalability and performance on such large systems.

Scalability issues seem to be more noticeable on Intel Sapphire Rapids
dual-socket architectures.

= Test =

Hardware:
 - System: DGX B200
    - CPUs: 224 SMT threads (112 physical cores)
    - Processor: INTEL(R) XEON(R) PLATINUM 8570
    - 2 NUMA nodes

Scheduler:
 - scx_simple [1] (so that we can focus at the built-in idle selection
   policy and not at the scheduling policy itself)

Test:
 - Run a parallel kernel build `make -j $(nproc)` and measure the average
   elapsed time over 10 runs:

          avg time | stdev
          ---------+------
 before:   52.431s | 2.895
  after:   50.342s | 2.895

= Conclusion =

Splitting the global cpumask into multiple per-NUMA cpumasks helped to
achieve a speedup of approximately +4% with this particular architecture
and test case.

The same test on a DGX-1 (40 physical cores, Intel Xeon E5-2698 v4 @
2.20GHz, 2 NUMA nodes) shows a speedup of around 1.5-3%.

On smaller systems, I haven't noticed any measurable regressions or
improvements with the same test (parallel kernel build) and scheduler
(scx_simple).

Moreover, with a modified scx_bpfland that uses the new NUMA-aware APIs I
observed an additional +2-2.5% performance improvement in the same test.

NOTE: splitting the global cpumask into multiple cpumasks may increase the
overhead of scx_bpf_pick_idle_cpu() or ops.select_cpu() (for schedulers
relying on the built-in CPU idle selection policy) in presence of multiple
NUMA nodes, particularly under high system load, since we may have to
access multiple cpumasks to find an idle CPU.

However, this increased overhead seems to be highly compensated by a lower
overhead when updating the idle state and by the fact that CPUs are more
likely operating within their local idle cpumask, reducing the stress on
the cache coherency protocol.

= References =

[1] https://github.com/sched-ext/scx/blob/main/scheds/c/scx_simple.bpf.c

ChangeLog v10 -> v11:
 - drop state from numa_nearest_nodemask() and rename it to
   nearest_node_nodemask()
 - rename for_each_numa_node() to for_each_node_numadist()
 - rename pick_idle_cpu_from_node() to pick_idle_cpu_in_node() for better
   coherency with SCX_PICK_IDLE_IN_NODE
 - rename idle_cpu_to_node() to scx_cpu_node_if_enabled()
 - rename scx_bpf_cpu_to_node() to scx_bpf_cpu_node() and trigger an scx
   error when an invalid CPU is specified
 - provide compatibility macros for SCX_OPS_BUILTIN_IDLE_PER_NODE and
   SCX_PICK_IDLE_IN_NODE
 - always trigger an scx error when a non-numa aware kfunc is used with
   SCX_OPS_BUILTIN_IDLE_PER_NODE enabled
 - make all static keys local to ext_idle.c (no need to expose them
   publicly)

ChangeLog v9 -> v10:
 - introduce for_each_numa_node() and numa_nearest_nodemask() helpers

ChangeLog v8 -> v9:
 - drop some preliminary refactoring patches that are now applied to
   sched_ext/for-6.15
 - rename SCX_PICK_IDLE_NODE -> SCX_PICK_IDLE_IN_NODE
 - use NUMA_NO_NODE to reference to the global idle cpumask and drop
   NUMA_FLAT_NODE (which was quite confusing)
 - NUMA_NO_NODE is not implicitly translated to the current node
 - rename struct idle_cpumask -> idle_cpus
 - drop "get_" prefix from the idle cpumask helpers
 - rename for_each_numa_hop_node() -> for_each_numa_node()
 - for_each_numa_node() returns MAX_NUMNODES at the end of the loop
   (for coherency with other node iterators)
 - do not get rid of the scx_selcpu_topo_numa logic (since it can still be
   used when per-node cpumasks are not enabled)

ChangeLog v7 -> v8:
 - patch set refactoring: move ext_idle.c as first patch and introduce more
   preparation patches
 - introduce SCX_PICK_IDLE_NODE to restrict idle CPU selection to a single
   specified node
 - trigger scx_ops_error() when the *_node() kfunc's are used without
   enbling SCX_OPS_NODE_BUILTIN_IDLE
 - check for node_possible() in validate_node()
 - do node validation in the kfunc's (instead of the internal kernel
   functions) and trigger scx_ops_error in case of failure
 - rename idle_masks -> scx_idle_masks
 - drop unused CL_ALIGNED_IF_ONSTACK
 - drop unnecessary rcu_read_lock/unlock() when iterating NUMA nodes

ChangeLog v6 -> v7:
 - addressed some issues based on Yury's review (thanks!)
 - introduced a new iterator to navigate the NUMA nodes in order of
   increasing distance

ChangeLog v5 -> v6:
 - refactor patch set to introduce SCX_OPS_NODE_BUILTIN_IDLE before
   the per-node cpumasks
 - move idle CPU selection policy to a separate file (ext_idle.c)
   (no functional change, just some code shuffling)

ChangeLog v4 -> v5:
 - introduce new scx_bpf_cpu_to_node() kfunc
 - provide __COMPAT_*() helpers for the new kfunc's

ChangeLog v3 -> v4:
 - introduce SCX_OPS_NODE_BUILTIN_IDLE to select multiple per-node
   cpumasks or single flat cpumask
 - introduce new kfuncs to access per-node idle cpumasks information
 - use for_each_numa_hop_mask() to traverse NUMA nodes in increasing
   distance
 - dropped nodemask helpers (not needed anymore)
 - rebase to sched_ext/for-6.14

ChangeLog v2 -> v3:
  - introduce for_each_online_node_wrap()
  - re-introduce cpumask_intersects() in test_and_clear_cpu_idle() (to
    reduce memory writes / cache coherence pressure)
  - get rid of the redundant scx_selcpu_topo_numa logic
  [test results are pretty much identical, so I haven't updated them from v2]

ChangeLog v1 -> v2:
  - renamed for_each_node_mask|state_from() -> for_each_node_mask|state_wrap()
  - misc cpumask optimizations (thanks to Yury)

Andrea Righi (6):
      mm/numa: Introduce nearest_node_nodemask()
      sched/topology: Introduce for_each_node_numadist() iterator
      sched_ext: idle: Make idle static keys private
      sched_ext: idle: Introduce SCX_OPS_BUILTIN_IDLE_PER_NODE
      sched_ext: idle: Per-node idle cpumasks
      sched_ext: idle: Introduce node-aware idle cpu kfunc helpers

Yury Norov (1):
      nodemask: numa: reorganize inclusion path

 include/linux/nodemask.h                 |   1 -
 include/linux/nodemask_types.h           |  11 +-
 include/linux/numa.h                     |  17 +-
 include/linux/topology.h                 |  30 ++
 kernel/sched/ext.c                       |  31 +-
 kernel/sched/ext_idle.c                  | 504 +++++++++++++++++++++++++++----
 kernel/sched/ext_idle.h                  |  20 +-
 mm/mempolicy.c                           |  32 ++
 tools/sched_ext/include/scx/common.bpf.h |   5 +
 tools/sched_ext/include/scx/compat.bpf.h |  31 ++
 tools/sched_ext/include/scx/compat.h     |   6 +
 11 files changed, 593 insertions(+), 95 deletions(-)

