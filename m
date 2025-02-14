Return-Path: <bpf+bounces-51587-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0436BA36648
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 20:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B003B171FE3
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 19:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D8C1ADC7C;
	Fri, 14 Feb 2025 19:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XESAO/I9"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C312219644B;
	Fri, 14 Feb 2025 19:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739562111; cv=fail; b=bomP/Wz0ms/ft39shRKffWGL3/oUlTYuxmvYMFKWtLo0eQnnRExWm5NFcJW9QjcAzptn5QFPvrKe7znDBHck4mmjohLWXzLlBlyI7wPGuAIujDoUMwpXEu3RUgG1tODGWLWvxbt7MrNTSlz3GRoyB5wHU+2gVBrY0KUZXEK70bQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739562111; c=relaxed/simple;
	bh=madD7b0Noly/fMpcf7wvosvh9UMvZbpRCVhGe1BwW1s=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=bY9Plu3t65ztKr4HdbKkrfhaZAvlv6y2vCPgla2ThU87pPV2oOB2o9zKtFIz/4ewJaUXHLpBAazMH+53zi5aG1vuTyaF1RTKRCtAT41ldFCNlVFUPp2evkHVZqYF8KStBtu+dxWkBdT76b3hz1c8Qm1E30QcpNkgytYj9yGB9SQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XESAO/I9; arc=fail smtp.client-ip=40.107.237.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W4kjFtNUYItVgocK48WZTn5cic87elBEoMiSVdFTOA+VAn7nbVkK9up9AsG23C3k2J9kCHE3MSZTZsH6Bksqs5z6MoqhG4a9zS1ZIs3+jhhCnI+P/F/qwsG4jasyirNXtuF/RaZrQwKTHEtt23yjoBsptkAsvLPa9khI9uoMAfSyz6tclpsDdPA7aX5CubK8bpojupEjNOtYUPfam2wAprz9J4d2NwapL/Cx+eKcInFs6hFpMulQZQabQH7tkmw2GjIiw9f61JGq7wkeM29SbrPXHiCLcaNUPRbqEy9F7xyjZrxxAUmALmYGjMDZ4lP2UAhlWAx270kGT0ahDtOOUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oqTudexbWQh9ciYMGn3FT4DzQKR5HT4K0bBuCPBF7+Y=;
 b=ap1seDACTU8tFfnqvoLIIILBkVYOrD2tLB9ayjro+DusWLmL0pcpIAnkcTIEuo04jEqPpPilF4EifvXVqzsuXpRTf5XUQ9PiDQjDy/hGavQjp6VNqiN/6allLQp9OXZ8+GJ2ajtQ/Wb1iCYVQVqhzscraQbShQ6rg5SU8CvYqaBr2h/ERBjhiI07gfb+QopF0snyI/U52T8/ihCPn8Zbpn5L7U3cX4AEtwARjL+x/gomCgdQ9qUZKJ0uta+txcZtPAS/lziZLS4jOQdd1tKFleexPhDEdLuAITk/qNOa/kSfrndEP3pBqYMOPftXEAVjldD4N8DoZtQpJNMO2lTdLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oqTudexbWQh9ciYMGn3FT4DzQKR5HT4K0bBuCPBF7+Y=;
 b=XESAO/I9TgJQUA2H5FayylkkV2GehGmAzXrSJyZ+H/if3tx+XuHAxRfckL8HoVkaXI0prjcA7/cH4c79MaOZaEXNJqnmYzc9SKLFw82Ghj8x3unBD0smtmU2Sj9k0Rpi7mghvOyWJhhWaKIhD9t321O4wOpkyi58iL2gACYPRiVzTw0yT9UI7fR+DHgJx5mK4yqZBwtoRPngQ5IrLHkqIA4xDuM6OoGMUeUfyWdlW3GFULRwuHDVhvOVUkN+DUvr1mQiDDOB9aBSInK+oUqjDAClvXmr8+eTVAn+VgwFR0m4aegPnhfa1n04aydALHTDDHOWVfQdKiyEEJGaaDxVaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by SN7PR12MB7809.namprd12.prod.outlook.com (2603:10b6:806:34e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Fri, 14 Feb
 2025 19:41:46 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8445.013; Fri, 14 Feb 2025
 19:41:46 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
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
Subject: [PATCHSET v12 sched_ext/for-6.15] sched_ext: split global idle cpumask into per-NUMA cpumasks
Date: Fri, 14 Feb 2025 20:39:59 +0100
Message-ID: <20250214194134.658939-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|SN7PR12MB7809:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d17dc27-fea6-467a-ef81-08dd4d2f9da0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Jy+9yzBED8w9gqT/Edo8ITPxD90VAzm45JTXi2GXfokY1a+VeCRkCvQ9HXET?=
 =?us-ascii?Q?Qbcajq6th4PozTviebfeSPDYET1mtkEm0FL8ODmGsIYExlLMxez1hohN0zca?=
 =?us-ascii?Q?l71EaahNyUNsVhj+7QIx7nBDqxlqE5CzRblSu9cYTcyaupsiXJKryv+ZiCnr?=
 =?us-ascii?Q?z8U+YhCK73aVcV1iA6/+y0dPjXlKYL5CLprz0ildPRAyfDYBCAPO/gyc56vv?=
 =?us-ascii?Q?0E2ELPfHFvxEJvwy0uY97zupIvI+uUpSsES9xmvk2g7jQqf7z4AVW970qs9w?=
 =?us-ascii?Q?SK0tKJnKUIYISqkBxo6ZGYd0eee+oQOX09rnRt7ZCmsFdCo3BXL5xWqefleb?=
 =?us-ascii?Q?2jNCYRyFqiA0hegLtZpwqkmnbjWThBHQJ0ALuveRaQWCYSNjwe8fayLnffoG?=
 =?us-ascii?Q?1rJwyoK3HM800y50fK6R6R8hAqSXeK/Dimf7kTBe9ddTD+TE1UrsFVaEEeB3?=
 =?us-ascii?Q?cgWhzclgYCG/o/R51ifB97GHVh50oaYiVa5bYtTDU8vIlzVlNVCSJgayz09H?=
 =?us-ascii?Q?LnT17Ya5bJas/dqDvhwIF5xl7gJB3DG/3iu5aDPpy4Vmt0+8pq6PSLHd4g37?=
 =?us-ascii?Q?XEdNgsWXJnUr9Z2Wptc0iJtikDeYS9KBgrLAdUKl3degL+KZYqAJ7sAqtOmJ?=
 =?us-ascii?Q?zGL+jnqWtTdHIIsVyxMGO1Pbrd95maXhmvD/1OU38bUULp3m2t5lFbGMXjvJ?=
 =?us-ascii?Q?t/QUDrhiFAm+YQdIWVusFL6xIypyyd/PHYn9u7wJ6F/vDRVrA7mMBu/Dbb7M?=
 =?us-ascii?Q?0XRvADFeWNXIqIgUDjM8mqdjovUt1h9DDuscOyesvFvX1SBBkA6fnlAUUnBo?=
 =?us-ascii?Q?zQjFk78YcyTwp/5nZq4stidpTQz/84884mPpPM8usUu6tUzuXTJ/gMSPemk1?=
 =?us-ascii?Q?WYkpjjqImOXwLqd9hHNNZmEGv0U2HNrt6r6bXcs703BsXeSqaE3LxYArCxHf?=
 =?us-ascii?Q?GuEDvr6EQxwb0qYa08kUaQNRFZ/7pHVjYc1dEGpZBUSnJJNas9oeLShUkq88?=
 =?us-ascii?Q?X23/laWKK6VuRQxyQhzaEidBGbOFnjM3qzA5Brw4icsUVvQarHrxFGn3oE42?=
 =?us-ascii?Q?va6W9/Qyj01Zrr6WfOCcpUb/opRKRAn1UYbCYjT8Ow/AkHIwtstLOTsnDEPQ?=
 =?us-ascii?Q?bvQGBt4OYhaYL4v6f0xdWiph4vmHS06UsdmbR2HYfoxChTan91+JeT9w1zqw?=
 =?us-ascii?Q?DNM1qzHq8o0Tx3UVtD6zcQBee16SzPLUAM/qaRvBgk6p+W6MtSiUOYfudTUb?=
 =?us-ascii?Q?2AvROjskJC3VYvUFZO7+1XVM4LgsHufGeY23jWEZImYMTq3X28MTO1Sa190P?=
 =?us-ascii?Q?DJMaDtKBgpani+g9Xb6f0tnhrLPBIug2tveGJlRbL6pgIpvL0IJj/HIUQrjN?=
 =?us-ascii?Q?YVzZo/WaByLQrU+pr58IHirOuLDK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?svpKbIzYnoG4zQQV4Lz7XMRNCI7DDrY79aCuhISbFIgkd/Ku8lmURy+ccQxP?=
 =?us-ascii?Q?pcUHUGYnltqAPNolR1EipCG7+pj49ok3VTZhbTp/Jn2kb1ActEJ11Z0x39in?=
 =?us-ascii?Q?sWzZ2uUNFdQuJj2g1Ogozrb9XEDRsRAsa0InZj7Fz4idZQyvUsGTlX1+I4a9?=
 =?us-ascii?Q?NXcnRqZteZ2oGUbK+TORW1mZClmDIjtEyJfTDad3/RFrdqNHdpXX04BzuWs2?=
 =?us-ascii?Q?ycZkzCkRMhfXMe5n66DyBA8q5A1MKKJ893vO4MY6/i7p957d7HPKfC0P5by3?=
 =?us-ascii?Q?/VejxYKH+ndFa4h5Hb9jIvoDVdpgeSFhDhgwuGba1r3Qub/uUpLKXzXCZBmj?=
 =?us-ascii?Q?vPMLpFvMm1snbnW4IP/mXG92Kt1snYTdFdksdoyJOJ1wpJAz8oweemNUg1q5?=
 =?us-ascii?Q?L/uyycLKbtw9txxsBVE0qKVAdtD9YslKUfxJ855jrvhdREk/NbRXUbjkDtm+?=
 =?us-ascii?Q?egzW90G/D8LdadAX6TWqDqMnAR88vDQ2dan8clVc+CvXF1ZVyTkMjabMuef9?=
 =?us-ascii?Q?xl2Vm2BvtEQ8IhwJmOHIu1dgkMh9mrz9fmB865XNmlNzP4eUHIkylbswEO1C?=
 =?us-ascii?Q?Y1wN79Dha3cSlL5wiUfYUcA1NriJUNE7TH+EB9RJy2tYXlQVWTFs4Wgpcikc?=
 =?us-ascii?Q?jACKsaT/iI4f8SXDso1eyUPrgJ8/JDRYu48H9Kj6/hSyDBIp3O9n60w585wZ?=
 =?us-ascii?Q?kknYEeDbIjuJS3RZqitz4Ea+Uw88l1KTYBvM8zE8tnkTlE59qxdPBt/RslBu?=
 =?us-ascii?Q?jzZ2Lpb55Jl+MVfQYlTMBd469+S4jR676W9Mg5WfZH3+w9D38u4lxiVIhg+d?=
 =?us-ascii?Q?VfNo85Sv/lW6lxQBc+fu5xX2dfgeEXkqxnrPJj4Ih0mIwwJjXuiuOVmINkGg?=
 =?us-ascii?Q?VtDlRpTxapoiOwXGuyXsxeDORpmMrmtWkpnbcC7OOoMUu5LD4bkdCsEP7sya?=
 =?us-ascii?Q?XBQNxasu+TllH4eBVXZi0xZRUTOsFGap0HHCo0vsf4ayTKvrfTsgLg+HtAG5?=
 =?us-ascii?Q?HHmOTfeEJ+JpGzFa8qlAV2VNLPXE5nO6qjpzXJl2ZfsEvtqYye+Ehqjt6VUD?=
 =?us-ascii?Q?V2a1nV29Mg1Itu1AmqhMcOwPpyZxBsxtREexXxzzdFZm+G9Jkxije7Mq/IZ7?=
 =?us-ascii?Q?65fLbj4EFUrbXCBYwpALab1g6bg3heoYbmscm7Z/nNVNls7696YfuDIh68g2?=
 =?us-ascii?Q?9YnkxMXPCdtT8SC9jxeUyt2K0gtydgq3BPYJLNoRf1UoerClk2kw5RPebSVR?=
 =?us-ascii?Q?e4uI1TG8hTmiz2VbX6wJEaQrt1n6h5hndA+2trJZ5NnmY3Fp2aCMX2ZwQ7ax?=
 =?us-ascii?Q?iHisZTXKYOV29VJ/f0ogUdXIJoMLlE+Ri5W+0xVoPZzRBROv5yUc3c8LO8JX?=
 =?us-ascii?Q?1iZJqsQD7ASSgNsUPhNZvXjgHwCege6Ob/VbEmZvTt53VQaOQdYKtT349NY1?=
 =?us-ascii?Q?rJa5mbqcR8acm2jV0OPQ5p3Zstr01ZjGrhEeIJqRu1nPvC6TCj7ViqvfWilb?=
 =?us-ascii?Q?uwaGlVeMYbD/o8kpPWObxsJImiR3mkn6cPQa9miJ/TIejBZqIp5f3jEIQoxB?=
 =?us-ascii?Q?WNoXh5bAIAH9neHBm+O+n1t7ypqSyMRWO9FRws7w?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d17dc27-fea6-467a-ef81-08dd4d2f9da0
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 19:41:46.0940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TI01bZR7XQP7AKHar/gSQXPCLkXJkU5lana+HJz1fv2CRyO/FiF2laThk2VIVgncHY89O27mGGBjr9xy8sDIgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7809

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

ChangeLog v11 -> v12:
 - introduce nodes_copy()
 - do not handle NUMA_NO_NODE in nearest_node_nodemask()
 - rename pick_idle_cpu_from_other_nodes() to
   pick_idle_cpu_from_online_nodes()
 - fix a build error reported by the kernel test robot
   https://lore.kernel.org/oe-kbuild-all/202502131834.ni8ojoRO-lkp@intel.com/

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

Yury Norov (2):
      nodemask: add nodes_copy()
      nodemask: numa: reorganize inclusion path

 include/linux/nodemask.h                 |   8 +-
 include/linux/nodemask_types.h           |  11 +-
 include/linux/numa.h                     |  17 +-
 include/linux/topology.h                 |  30 ++
 kernel/sched/ext.c                       |  31 +-
 kernel/sched/ext_idle.c                  | 511 +++++++++++++++++++++++++++----
 kernel/sched/ext_idle.h                  |  20 +-
 mm/mempolicy.c                           |  31 ++
 tools/sched_ext/include/scx/common.bpf.h |   5 +
 tools/sched_ext/include/scx/compat.bpf.h |  31 ++
 tools/sched_ext/include/scx/compat.h     |   6 +
 11 files changed, 606 insertions(+), 95 deletions(-)

