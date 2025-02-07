Return-Path: <bpf+bounces-50800-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07155A2CED4
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 22:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B2A218899E0
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 21:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D751B0406;
	Fri,  7 Feb 2025 21:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="P7ZuN+Nr"
X-Original-To: bpf@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2042.outbound.protection.outlook.com [40.107.102.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF8A19CC0C;
	Fri,  7 Feb 2025 21:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738962687; cv=fail; b=hrjlZrXyATMMcmvxFJ//mTmXQvRUoHhnhNVlIrq6+sJqyOuDHRIdwqGmidkQIEuVj19j0YGZACPB9w46C/6nJ/dxxIxsyNZjvaqRkIJVtklVbZYZKgrm6gfvH1jNkzK95BcWRf2QrOXdRfddbtK2XNjTt5SDgpzmAn8i5xynBGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738962687; c=relaxed/simple;
	bh=1N7hE+aaw3dan28qwmYcxfszofqYlxjl+1PfvlBDTOI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Rovy1kRF7hfuOrttnAS7BzRqgb3Bk6Kcj6fYd6EfN7Hrtb8AKm8pyrgzLptkK4uhRB/2z74xyF+EGO8qZuv542pdCC/kmrBLATIBaaCBePmKJRTANKaP7yWejKdJMCjGLWe9zDWAZlwTNnnbviaCiJcOdLyKd2gvD/qDO7gxZR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=P7ZuN+Nr; arc=fail smtp.client-ip=40.107.102.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TISueXXUKFMzT4Ac4qZgleKFSkZEacMp2+yAw3XWJMNM1uzMCt5hUv5KrVC4DOdSbCNWzvy3istk36skkbmJEauas9N2ya7igdLMa6l+ejah3/AqcmWl2OsW7+bTqoi+r6R93QWAjER4Xrqxeo5XV4iHaxR92iEHgJvZBCMR8xLmKFLvJazOpTYlMlvIwP71F3AN+VFTLa6jtxXMUabN+hIys2QLVnWk09RAE9/IUGyfYNUk4WUhGJ0tYSj+pGO439/e/DNarju/K1L8O0qZyTD4uQARmnV80U8LOYa7rmK9Cg9R6FTTM9TuWIWhqFcIt0xZ17IHRtv7EOQglYpv3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UnRpUi+brM+vEfZ/jFB7hH/YSCp6XJ9G2zZVsu73Yr4=;
 b=ZrnYHJxiWHdi6sd7stWdAxLTuW2NSMXhEDwbyZ/GbdWAXR2gm8zl5ys24wumrd7CEwRxk9Izv1wEQp6OOhVFoKrAuce/fabLVjtcPyJ7UDDX0+otvYpbWfGDmFIKDBVZFVjxMDW+kyR0kkKIzuYArzlrNiHfSwHNXTluHBQi2hfrcihpE+v7XCbtJOvWvmWpElTdMZT0aq12YmFl/lTDtI3OpLwWIOOdplXX82+NVtHHS/0j2s7XDgvnCMU+tQ2MYl5I60QPQAgr6M+LhsCXGsDn/K/Y8AaXHzxGAxp+h3r5V8D0/V6S2cBn2lNn5TX8gch9RWXSvWFcZW1wztkWng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UnRpUi+brM+vEfZ/jFB7hH/YSCp6XJ9G2zZVsu73Yr4=;
 b=P7ZuN+Nr+hJke+15kKtSS7c2VU+S/GORfuTGKYgiDli5C1mNTONVAV3MTCjze6la5rh+KPtbyuowyAYvhlwGoHwbAf2lNxpVR8fGK4EWyqn2/0YnikV4+S0TLxrow4lExcOUF6njk72nWEcyajJVu2zepsfiPFoXEi6+ZjrEd51HA0BLDL3dfXuawhHTAWSGK0THQCTErWxAnqx/W6BOBqYibze1QbNgNiXmXnVOrLFxuiJj1KFqd3PJO0/ARKm0QZ4rjMPIuQz/6A4BWoA1FRuzq4QCwgXdVC9U6UiQHUH+UI+zO7CE5xtOZ00lb4FGwP3+yWJc6qCsHyUXlJrwKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by PH7PR12MB7380.namprd12.prod.outlook.com (2603:10b6:510:20f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.14; Fri, 7 Feb
 2025 21:11:21 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8422.010; Fri, 7 Feb 2025
 21:11:20 +0000
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
	Ian May <ianm@nvidia.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCHSET v10 sched_ext/for-6.15] sched_ext: split global idle cpumask into per-NUMA cpumasks
Date: Fri,  7 Feb 2025 21:40:47 +0100
Message-ID: <20250207211104.30009-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR5P281CA0017.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::9) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|PH7PR12MB7380:EE_
X-MS-Office365-Filtering-Correlation-Id: e8474d94-83ce-4c91-f7a8-08dd47bbf835
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Vsm0f0DBHZYpMghM37jxHHCkkXoV1KVm2QHbX9pJSkHH8bcnq0e8Igqz1+sT?=
 =?us-ascii?Q?CkopUwq8VEOSeNXqNcqjwFwKIy96LkJVQVw879DSa/TfnZSixjW7aGcrtNuW?=
 =?us-ascii?Q?cRhKUw0tSLyojvbv34meydDjanOAGkbgzTJhXEwwFVQms1ZWjTU6Jw+hNSoj?=
 =?us-ascii?Q?1EpjYcCzavBba+cm+Bq2q8zWFXJLHvJwxFH9UgSeYKj6gW741eHMXHQmS/Ct?=
 =?us-ascii?Q?gDLxd+6xJBjFsB24mIiDA+yufy9EHo2IOpAUBCQGj0nueTXcwX4g5G6yVbRE?=
 =?us-ascii?Q?SKRpYlQsW6szUgjPk/kdSKeCE+UQVHQCX8GuzRNuYQkNVAYRpY9Y7QKGneKb?=
 =?us-ascii?Q?fkYb8yb2aMhJoQwXLRZBFcJQMH62vL4QaijFYvveC9xgNtP6KosQ/ue+nD1j?=
 =?us-ascii?Q?OcGnizY2zRMdiQTCUhunNBtS+ROqIdSnRUomV1bli72ljU3X/DxWGWfdCtQz?=
 =?us-ascii?Q?06DT31dhBBfU857VuQkn6/vc6AYwI9CxYe4Y40aomRp9VWBNG7gI9ABgN8d/?=
 =?us-ascii?Q?Q3k1yi3Wzz9Hva2ZhcyzNRxX5ak1mSZ6TnWh/huZWwTCwnnr1VMCQGUVJV+N?=
 =?us-ascii?Q?s5xgXaGnXE8ZiZfHRKoazjYNaGIjV1rKICOvlxX3JxLByrEJFZBhLepWR1Si?=
 =?us-ascii?Q?fjV4wgwgYg6937L6QOifgjlv0jPKmxpTghF1USG+gkIZOjV73zuxxZjRpIOw?=
 =?us-ascii?Q?HwETo/3dzCdBbHoW7Q6dh+QCwZMPU7+qeK9Jg71OwzvpNNE0CkmbmFN3AY/g?=
 =?us-ascii?Q?QOz84cpFpx+VQLJcZmoXHHgIea78XSQA6gC2IInLWZBFvHLJZsci9eOuAhK5?=
 =?us-ascii?Q?gO4bGhiyC18Jtn6YsanP/IBVj8alklD97thGJJxdLnNtLSbClKCfASbP8uUF?=
 =?us-ascii?Q?fMKbjWyi5/w7hK3o4e7uBdl3MYK/uKavGr1fDMCBS43lAKxsuDDAffwh0UPt?=
 =?us-ascii?Q?KmDVyOPKyA8VV1wA32Ap4WziXXODPL0ZeaeeQEFZASsBOx9Dy1/wOnZh6lC9?=
 =?us-ascii?Q?zOYq/JC8QRTLEYdd2uCckUPo54hQk9V4Plt0V6J1Uzf+Rf3/jmWOcgV2Sj08?=
 =?us-ascii?Q?VhENTwBr/7tM1AoxvN5X9hux+KwBxbd29J7IEVOFtZ1+Qn9igHSpFIJkA5gV?=
 =?us-ascii?Q?bffEPUvn23KzzgYEMaPEU1nJW8PXR/E2UXHCxOXmymyKhSJ+kuq3+12lQLvb?=
 =?us-ascii?Q?QRJRT81A1XcHEA13k1kCA97ulytSFiPMWiJS1KrzF9ZgJrBZte0+za0NjrbR?=
 =?us-ascii?Q?EsZZYwrn65iK84I8zahE/p4FQzxIkXmj01YrlK+fUCLPkIHWQBAJP3zvJKP1?=
 =?us-ascii?Q?oEuJB/y4tg9Eg0WRJsBNrP0gkd6if+w5KG0AWO+iqHTPkDmzapwlybGvycab?=
 =?us-ascii?Q?pFyYKhpLlD1wZGooSdyPqtSEJQEw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i0D2OFWfLLujJVP0WXw1wGKHcSQHWbTF3mG+fZF4tFTCXZB5KVf6scqB7Lbj?=
 =?us-ascii?Q?z1r7zJVTY3B8SL4uZQG4lwWz7XtaNw9DGGv+8XLE1ZZ4rlbbIIZ/nyDWG5tw?=
 =?us-ascii?Q?6wyJ65g3dYKVbo3Rd1Tx5Ifcp6oZKAaItO0dZtiLvMG0ugco160u9QbV7nZn?=
 =?us-ascii?Q?girKTN1NXxmZhHVs6lSYR2+loTWWGGvj8YDZJDxz5Y0a5AkYgFLk7RgfZqFw?=
 =?us-ascii?Q?UlxYsorFvQJvMmH8rzU3HJUHADsgC91aRn7sMVeHFu7xViiW2EuVodC6upYM?=
 =?us-ascii?Q?Er0slGEyR5CizXHBUG3gvdzp+1IGB7/V+a/4Z/HaYWE/frdYN+cAp1mti9PL?=
 =?us-ascii?Q?swAWDsKEkVAkBDcAZQrqrygbnElsxbuJ7Pt68zQjAfx/ix8LFs2sO2FIsxe5?=
 =?us-ascii?Q?lc9piLZZA3/lxKJ0u5MPU2yMzelvUxO/0mghka9Md0oDDjJz+lnA9+ll4evF?=
 =?us-ascii?Q?ljSdGtbwLRnbocFoMVo10QmHT7chfc4+u8d6p6dGmRtTWl3Gn49JL4QkhX0z?=
 =?us-ascii?Q?BDQUowtMtckbvZmCqhnxXSVxH6O+raC9AO8ZPn/m4Cq33Xe4RpgYNBR1cL9Q?=
 =?us-ascii?Q?4TP1rvySIWo03QCcH/aE3KKiX8gy23RFpWBDYjQWPAHOA3M7pfmLvOcrpVcT?=
 =?us-ascii?Q?gmOB6QkDnxmmZfrr+py3Q3JQnSyAE7Xie2g/B+Z3xMVSOwJvv7foljSMrn80?=
 =?us-ascii?Q?BFLsL+zSTDpgO8rd0TGB1bdq1A0FQGSX59KTySrrzPgwdFJjHbeGzcN/HcpI?=
 =?us-ascii?Q?SIUBJEdex2nrg6HBOV/9pI9axtr1op+MH6XsOmOyQt+XCq2/vow2Cckjru9I?=
 =?us-ascii?Q?0x+B2MZiVNLG3OAuXUSAbXj0/Q0n/ho4BJOUb4551/9Q/xywRE1IIPcjo5cB?=
 =?us-ascii?Q?qjhFLHop1QIef4WzNzL7jJ4WDkxmZxB40lbjqD9GZf/YlyldfUjH7Ze9hQ1o?=
 =?us-ascii?Q?j6h5a/Onxo0XrDBhx+Oulg8whsMFG00NFt6QqTz/+lgbVTh0/DBKzTESakje?=
 =?us-ascii?Q?xHf+OFaj+MJ1a31ejd+XGPjbXziPw+U372Dgf61RoWyWOYOZLaQ0oKk2LXQy?=
 =?us-ascii?Q?l34oQp8LpkXWQQo0dzbOFPOi+mkquEFf65ET21JPx9JUbvXAk2y+dGVn8wMp?=
 =?us-ascii?Q?7TZoMYjyuzflEV+2aLEgYkZTxg4x7VVinw/CivlditUk4nnjQyMiBaaPGG1+?=
 =?us-ascii?Q?bDbbO8yFAHeU7Ug4du00tHzhb0CyYTDqvewTIKMge2McHzbrvZ68RUK868w4?=
 =?us-ascii?Q?yvOjN8rEIcoN/DU1W/NDYMigeYbXd2aqEg3T7ZxbvM/dp23toxFab+6IS+i7?=
 =?us-ascii?Q?rSJmJMMFPaqzZi9FxWNja4B3bsr7ahg3BXFwI0sw5mNYcPpiZVK5BxBhrEXD?=
 =?us-ascii?Q?46tfh8NDGEhrb1DjoUhDuTuLQkFqRa1gfM2ja5Wg9rD3pHJ5rNcaolofPFK6?=
 =?us-ascii?Q?9cexRYVo1f604WidsRMWy0SufC+uRRUJP+FzQk7YI7gZf/7Y6JNxFu6rzbAL?=
 =?us-ascii?Q?Ix1+FSdyuq/gMWaodDnqWg8Lv7c8EFFlYzlZCTSc5wOAp5UyGG2zcMPhEjyI?=
 =?us-ascii?Q?nKye45h0vmCROYrYts/a+S0Gcl5b2GHUHuQLR9Sr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8474d94-83ce-4c91-f7a8-08dd47bbf835
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 21:11:20.6904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UOREtAWTDMOc72WC2VYtOrn828r76Pu6w22EaZMbP5b3GSskS7IBENoSjTW1h6tUYJzPruV2TRzC1IfVDsIBCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7380

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
      mm/numa: Introduce numa_nearest_nodemask()
      sched/topology: Introduce for_each_numa_node() iterator
      sched_ext: idle: Introduce SCX_OPS_BUILTIN_IDLE_PER_NODE
      sched_ext: idle: introduce SCX_PICK_IDLE_IN_NODE
      sched_ext: idle: Per-node idle cpumasks
      sched_ext: idle: Introduce node-aware idle cpu kfunc helpers

 include/linux/nodemask_types.h           |   6 +-
 include/linux/numa.h                     |   8 +
 include/linux/topology.h                 |  28 +++
 kernel/sched/ext.c                       |  22 +-
 kernel/sched/ext_idle.c                  | 396 ++++++++++++++++++++++++++-----
 kernel/sched/ext_idle.h                  |  17 +-
 mm/mempolicy.c                           |  38 +++
 tools/sched_ext/include/scx/common.bpf.h |   4 +
 tools/sched_ext/include/scx/compat.bpf.h |  19 ++
 9 files changed, 475 insertions(+), 63 deletions(-)

