Return-Path: <bpf+bounces-50690-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A133CA2B34A
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 21:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6143316700A
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 20:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228811D5CE3;
	Thu,  6 Feb 2025 20:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Wju8kCjR"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AB61CEAB2;
	Thu,  6 Feb 2025 20:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738873300; cv=fail; b=PUPJYUWWo8MHvdjelM4TX77dFI6DDoAtASs7L+TgJFggxvNgvtNkdeZAKB5BfXaU/sXie7R8cdOz8/EyWExy8kaNhPZ6JywTjurVguzhockW9kdT7aEBOHh2RwOHD5/O7BE7qEwYBx6DkfV+DQQEZbkE+AmY6EGpXKs8ne6RmQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738873300; c=relaxed/simple;
	bh=hr9m/SootlXukRF7vjzTunsbwY6kiAON0Zk5YxDFRic=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Xx8FOqvDX9E+18T/8UW/FxS5lmbOrsdCCyFR9EawMNfL4RocwYWyh+7ccEwH7tvMnsOqLLJ88s1tw+aU0V1JqxH01KkjY+Mtr3qjrdUMZ0w+W1LAyfseO2Gan7vRCGvhgOn6+CcFwCK289U+KPkgrLiPW5fa9lBCak5ISW6/9pw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Wju8kCjR; arc=fail smtp.client-ip=40.107.244.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AziKPhTGTt4sLIpNijcP/o10eEcwUFuTxkFRrNBrBBhLRxArSpQWYOZa8K7E9hkqlHE+YU5/X65ewmt+1jpDCHJP9V9Ju80XodCN6WsSjgIIiK2rqdNuAA4z+GVjSL5AJKDMC2HvfMsNOy8JKJ5NOB2aMqeRYZXi1AKLs+u/10dZl/D4FRE7VyPlX+E1YtrDlJjPAsZGV3XrZ3BD8taoZP9K9e6QS7ouXfMhCgZuCvQ0Zz4vTf9I+ghu9WgajRBUyb+cMB1+TIf2obPQFfz93miwueanl1Fw7WqTjqITwVd3bil/EfDzXEGPMIV9vOshblhOBmtkhcCeDlcBnrkp4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C9zorW54y6KSoe4ZGYSLQmJe/3U9LIRK/tBPE9tQkF8=;
 b=U4faDMpM8E7RetplUW7MxglErvqP/p7EGsWUvgqZajTJ9u1Ws0ClLEm9As2pyyl05k4zuCPHOjGmTWl5i3342CP0HX/TsAKTaWDA6ZLiUadfiLJGj5BFi0obI9BqRU8z05JP8Q8GXS1HjsMnvr26t7nmleLuh3J1E5KjeNIunhBxCrGNiuPLAwQKpSGfLiA32+Cs/DIQmOavn747Qt1Xlw89AjOU1jBAVR2T+XgXN4E2qID89tp8jPp64zVZvOF+T/f0YXvUvm30u1hNa2rQEVlGhqOFW3rsTT7eQ/SF3nW384RcOr21r3oAGfyuPoky1W+2rNBcvAHdXz+svzYA9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9zorW54y6KSoe4ZGYSLQmJe/3U9LIRK/tBPE9tQkF8=;
 b=Wju8kCjRvZbWJDWnJ8iamqpvv2OaZ7ENkLOIa+RnjVUcXWS+SwdKWwT2hNRbTgSFoHf6OkyXgip0Y0c8/jPlEvh4jlXr24pvSpY6kfTGix7evuItRC2ZAdXxPusRSbvA7qAVSWGSkq7vEVFJ3bpVkEhIbTxeswPCK0De1mIUFWI2INbeYdBpu4VWmNmZ+l6Lva/pAxd1BxufXZgs3yR7TRv+SucXK7zrSUrRf9WH/iSsxmbwFcrD2U0TFSHBCUXax7tcbCOJH1NAJarOmFXRZviOBZuJEpKh3jqKelA8+tn7vqi137yxNFJuqsJ69rPoG3Ab0usTAr4vCLrklxYvRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by DS7PR12MB6213.namprd12.prod.outlook.com (2603:10b6:8:97::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Thu, 6 Feb
 2025 20:21:35 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8398.025; Thu, 6 Feb 2025
 20:21:35 +0000
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
Subject: [PATCHSET v9 sched_ext/for-6.15] sched_ext: split global idle cpumask into per-NUMA cpumasks
Date: Thu,  6 Feb 2025 21:15:30 +0100
Message-ID: <20250206202109.384179-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0016.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::26) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|DS7PR12MB6213:EE_
X-MS-Office365-Filtering-Correlation-Id: a87c5812-3443-4754-d117-08dd46ebda78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eqcR+obY3nKLHIuqnOsY66pqoy8QWILXiyjRmRVxdIi1sZyQ7b1RMKt8LcNf?=
 =?us-ascii?Q?Oh28OWkJHknH2bsqxpfunoOVCsp0OwMDZNkMul4ew4GZCoTIcG1TVF7YJihU?=
 =?us-ascii?Q?HOwSyuoDkWAqbTD+qwUvEGDexaM2Hei9wyKEYmUKBgfuTTvdrH7IfqTXG3NN?=
 =?us-ascii?Q?IUxTjwbGXhIEMwkrxWzrP7dMX3iF/vG5GiZDHNj7UtEptJsrxFS33gLbjzEM?=
 =?us-ascii?Q?o6eJ3yvMSQ8TWwzAyI1mK+lkZDu9+cWCEI4zZ8E9SEzPKMo9ntxscQaUHcQ+?=
 =?us-ascii?Q?y8ixV6nXNyO1Ss4h9kKN+V9ma7Xq3U8CjfGzF3Zs0q5tI88qnBH0zMaSHkAK?=
 =?us-ascii?Q?Erwf+ZEu+NuQUW3gCZlZjDnW+N+7GQ2VV8/qvR9+IZ0m0vwoPJB+z0XcI8B+?=
 =?us-ascii?Q?PwG2Xr8lnGUymECxsPNhCU0kq438Y/sVREQJ21pnRnq0uPDAmxwTxJr9a8mf?=
 =?us-ascii?Q?qgqYVF7P7S9DSnEqHndas7LcEJZh6rsSn2p7g1XA6npjYVKKlmjBB/njty3K?=
 =?us-ascii?Q?sqfCGzChNEIl/zl1IRqCg9unQAEtKAslIFrEah1XaAf27Y5cEGeMt04VwMRQ?=
 =?us-ascii?Q?fCTFg6GNbN1oN9jVCZWj5wRLqI7LuZvAmh5HlRphZ/43s0dtrdHdkjuS0diE?=
 =?us-ascii?Q?cyhehHCWoMzDTNMbohrwFCI5fkWYn61Irwr0F0lPaaWYKplCU4dsnzFroIF8?=
 =?us-ascii?Q?Ykt76bs+fG2FOMoYzvdeDvTEVPZIpgeV4PZ7L2IrMNmyaCVCsI3fdsvG8ul1?=
 =?us-ascii?Q?jhdML8c+pln3HjtAjg7TUlRVqSlKLb8+uIJ34d4ne3WXp6sGEdfgaBV9OaXd?=
 =?us-ascii?Q?rbCWCyS9Yy6Q210ZJL5HsSLUTLovHZolsJR58c/3ZMyhtO04Je6pidjo2eTm?=
 =?us-ascii?Q?tZJbqZ9bVQChA8eOZ0jYBJNAAirIm6ItBaAeYBfh/lfOYlfDyd47uFvJTjSA?=
 =?us-ascii?Q?X/L2GGyTYMgmk9e8LmC2XDu8yEnAUmkfy8qsx1rE+hi9GaZMFzICLQaj2KhZ?=
 =?us-ascii?Q?nxv2URGHW6YVaqjfF0OpaRvVoQkU4YgI9ZfmO+xpsozm/8QoEZ1BLHwaMqTX?=
 =?us-ascii?Q?VXpIko5a58v3oied3P1yqIy549k85rpOYGjaHPXo/odu8zeWoC5iwkkXBKPq?=
 =?us-ascii?Q?asp9ooCbKqMrQB+lQE2+VxcEm8WneHo3hO6HgFvevmQFNX7y/kNMd5X2GLrG?=
 =?us-ascii?Q?w4r9OgENZ2pbv4UVfdUfyDdB3+m6e5+68nx5Uw9QvMzKbgTEYxZEotrGQ9Fs?=
 =?us-ascii?Q?cPhnJoxrZ7IFLFFBbER5wZY6trcnI7gqSe+lae9M0JGHp+/rHpEsCG5qlhxD?=
 =?us-ascii?Q?BlgifAoarvydq6+3N2X3S+KWdkYrEUjzwhP81BwwZem+CQkHo8fe4dxmnNUb?=
 =?us-ascii?Q?M4Qu9uItbx1jQVEtRCqgilnRJ3eL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S8XyPMAZQzQ1k62GQSTHCatj0YE6UNmgWsSi2ONT5m+o4xpoJb8r8HIiEtUI?=
 =?us-ascii?Q?sPGYAnM5jaY2w9Djz/DnsgebuKirAoP5eYrqMArkuzlYMLQ9TdudagPqY+Eg?=
 =?us-ascii?Q?ZJW55m1g9Wv6veZclvQGtSw2AW0Tl+R4hNes9YfxC816uPMjRr40ED9ZEA3E?=
 =?us-ascii?Q?DrgRNhoXKWnqKt38J8BAWcVutVMG/gmGC+sjIzhJ2oaiHAy4gcKLmUDPetEe?=
 =?us-ascii?Q?NxgGF1PfTAEUvJKVGoJ8IItosiFlhoclCHpwd1d3GXl0ywDHFwp0tots6GXZ?=
 =?us-ascii?Q?oAWjcYwcmKjgAgxy9jTmNviZsIojSmh5Smqv/p6h2qYnbP9RL/UEuiURrgV0?=
 =?us-ascii?Q?cfw1TZyycH6z4goSd7ULobMKPf7lKb3QxbHT+U1Ht7qfAWqxrCLIoiCkRbgl?=
 =?us-ascii?Q?+Ugptl8XLHiHls28XOSVXbPjhsS00D9gqK01ykokosqW1wyaihyLZfY3Sj1p?=
 =?us-ascii?Q?41+S5yUMGRf7Yc4zx8i1TjYDoesY3+AFpu09TxX9M7Ud2BURzjJ4LihcFP6E?=
 =?us-ascii?Q?tLo9rGxvn22EYul4YxHllVzMrcNlJaWf3ur7ym/2yfGrzfZIM7Skr5b7jT6e?=
 =?us-ascii?Q?6WMs1IQg6wTx14D7JBu+oVIxkOuLqLommSNgAe/iFxSLLJwrN1DM+ajXKCFe?=
 =?us-ascii?Q?bwqhynqAJPiEgW/ErFOTxaKBL5Ihk0q5UtJPGZUI7Z6PuF7JMONKZBTd+1oU?=
 =?us-ascii?Q?NUDSvSFw/ibYZQmv42AXrJQa5mkCDMKANsDBmVX0PRhZTd7x1Y3MPUnjxl7u?=
 =?us-ascii?Q?j4J2HkQ9UBE2CBv6uMeMdyyAT4LC19kL/1o4RzuVfe/gdIhcfMS8Yi2nQn5J?=
 =?us-ascii?Q?T04rYbJA9q2sbakHCIKgABaZEX0Uht665hKxhim7HNxf0q2lu7j71TN6OsIw?=
 =?us-ascii?Q?MQzGWUDwCXbRwzgKsKWTLPuR83HKrpCEehz1T2hJgJU/GHGnPNBOpLrJ4Lzf?=
 =?us-ascii?Q?BbBSkMZ2JHUPI23KMn3uLVTDqJ5y19rWX8GpYQZS5uV4rmLInPP9fYJ662o0?=
 =?us-ascii?Q?cmbe420eXMmWm95t7b2R96R+NvIFTMPTqc3o0h6dvLzBU9S/GcxcMjfx314o?=
 =?us-ascii?Q?A1PDbgBa6ooXtIJwf73wB8ny8q/n4YeqWP+Uxn2RuuWTBMb2E3EL7DKPbUh5?=
 =?us-ascii?Q?2Iqbk7fwezJ7ZfqawI1SbcpILghIrboS01+pPvgEr7d6y3frZX55HWvhUj3J?=
 =?us-ascii?Q?FG2Nwi2UtxlWYq7UkZh7oP2lcgWXkgc+CkPDS+a9+n4pQnvBw2bybZlQEAOd?=
 =?us-ascii?Q?+0p+TXwWEiQHMlkj9xILGpfHKICa5Fw0miYELqFikmTt32DUY/5vyphTA4dv?=
 =?us-ascii?Q?hl2S5bYQdSFM7RdxueASDvrlWjw3N5j2f8yIiZwiiPHelKVo1LP1a8bvXePl?=
 =?us-ascii?Q?HMPcJ3t/KaXQUNRutKyPEgFK7LksqCOUQDqQTE+n1idM9F3Uay9kisG0pSU/?=
 =?us-ascii?Q?pep4U7+6Teq5Ad0VT2VevBJpmxifg3dsOlLbyTGXvzn7z1+tvqf8b6nRITgM?=
 =?us-ascii?Q?HMe99F5icy1ZjqGNVHpuqoGGC1/fb8BMwLUDV5L3H8TSMWkeJuaHKVHLUpF5?=
 =?us-ascii?Q?hbdu/2kPMKayspwMJXWHsnXiAQ9BHUeRZVuG1BYd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a87c5812-3443-4754-d117-08dd46ebda78
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 20:21:35.4142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o77OlMwG7tcqhQ/fE0mkKgI6t0SupEU0GWDspfZIltZ9oFBzZKYk011Ce2oT4uDmHQKng5t3RTYaA+lbIiGv+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6213

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

ChangeLog v8 -> v9:
 - drop some preliminary refactoring patches that are now applied to
   sched_ext/for-6.15
 - rename SCX_PICK_IDLE_NODE -> SCX_PICK_IDLE_IN_NODE
 - use NUMA_NO_NODE to reference to the global idle cpumask (and drop
   NUMA_FLAT_NODE)
 - do not implicitly translate NUMA_NO_NODE to the current node
 - rename struct idle_cpumask -> idle_cpus
 - drop "get_" prefix from the idle cpumask helpers
 - rename for_each_numa_hop_node() -> for_each_numa_node()
 - return MAX_NUMNODES from for_each_numa_node() at the end of the loop
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

Andrea Righi (5):
      sched/topology: Introduce for_each_numa_node() iterator
      sched_ext: idle: Introduce SCX_OPS_BUILTIN_IDLE_PER_NODE
      sched_ext: idle: introduce SCX_PICK_IDLE_IN_NODE
      sched_ext: idle: Per-node idle cpumasks
      sched_ext: idle: Introduce node-aware idle cpu kfunc helpers

 include/linux/topology.h                 |  31 ++-
 kernel/sched/ext.c                       |  22 +-
 kernel/sched/ext_idle.c                  | 390 ++++++++++++++++++++++++++-----
 kernel/sched/ext_idle.h                  |  17 +-
 kernel/sched/topology.c                  |  42 ++++
 tools/sched_ext/include/scx/common.bpf.h |   4 +
 tools/sched_ext/include/scx/compat.bpf.h |  19 ++
 7 files changed, 462 insertions(+), 63 deletions(-)

