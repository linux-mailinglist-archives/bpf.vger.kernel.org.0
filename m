Return-Path: <bpf+bounces-51594-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C2BA36657
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 20:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 870923B26D2
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 19:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C021DC98B;
	Fri, 14 Feb 2025 19:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GhPpzMDs"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F841B532F;
	Fri, 14 Feb 2025 19:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739562145; cv=fail; b=ex6J/z5qxylmMPkKyvCgGYJnyt5UgDt5wogQo9ZLOAtHF8TjSm+YNbVdbsskS9mosu2xHNeEKKEKk+CaCqF+m+kSbfIOHBDvRe9C37PUtzpE79j7KOxQ2rBfLdr549mqMHPfakqf6RZBhNmaH43SDUHiT8STN9A4P+5r7ti+Rzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739562145; c=relaxed/simple;
	bh=jD+9ppsYnmBPN+GWsYn+3+WWXwdqOTOZuKqRWYBiaoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sitWLmFQKUpT68xcVyZOw1GRoM+32oK4GnhCRzgC2VRAvDODfqscK5zBS6AQjQqMVel4BoWLPlJaX/Js3Owkj36/T/Iu3Ey9a0SDyA1bJfjh3L/oAkAbTp6mUk1rUVUZoTFe5GkoSZGhCyXVNTIAuPT5V9+3uWTb1GA5JVHJ49U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GhPpzMDs; arc=fail smtp.client-ip=40.107.94.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZtrdiRBPYXkWpimef5ujFS0Fn6ae0jEAeXqEFWeigl0CArxO+l6IciI/uSudSHWaioWMqgY9LUSdssf8ADlA9UwhSqd/sJcsEz5Wx2VOWTAwRd0KIf45XQElkDyn53F/N99xT02FIPil3bQ2TsjX6cE/NcLqNxjXvvrWyF24nhboUBbzq3Iqm/InuV55V1xdoehpuwSv4ckz4kTfWkTIz2qVTHm+6OjYp0B16icZCinVVbIMZCLjTz4DuxnxAvMxQFgHVJqel3laJpC4RApx6hpUv0gPueZ1b9UXSzlk5T/lkMfYwD1paBGaxVJzdK0oVgLEkGA/4FeKpLPCkxclFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=inNLLHgawdAoU3N+S83EPoOL12tgEPPAO6gkI1ZK0AY=;
 b=s1FMW/pYVeiRHJFn9V7hExgTYt8Yy5psraYNKpvVu0BrtG0B8Xf44eN/9FYKcF7JMHXMHah0pefCTp/UO7MHHdoVY/ripUtci6xSOWNGkUGYDGy4pQCbHGZgTyPfc1I/ZxrvGwTuZcNAmHqE89z5tq7aUyek6VyY+ZNSewrCZw0gSAublqD2eOX6J2LOJ6t9YTODpov0v6kvGZV+p6wG/J++Hv9QtYiJcUNh7iR74FK/8SSpylWGe9T3E7iZ4YbIk+qppls4QfcAJN47Dh8uiQwoyXlNM+AycokgOPPmBZxpslGkSXL/7oUNfG5zXuaFAsvuncGQlo/b0IBJNLTWew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=inNLLHgawdAoU3N+S83EPoOL12tgEPPAO6gkI1ZK0AY=;
 b=GhPpzMDs557ewBiqcczfi1B2zzoyRwYR82wlQuPa2oSeJOAWzNWoI0VpcxFQIu1iJ8WVHhmUeworEXYNNro/k4wdMr6JI0c62k/GXsYHHLHGz7EkszwN2N1U9zGsl+4b0J1HThL1Xco6zFFgqUAiAvg3nsD7FXJb8eXwc9ywjoL4sPu8dKjQsOwt1bh1pOcsXsyKygnIPpBAJSUal+D+XrCSb1ZTQnstb+j0hFd+MIODfe5jDuIR9MJuOnPjg6uIfNuR97canRGgehNe4LsJhLlXdtO/PbRxR5egCwioElm80wVVBYjJ15VHeJ8P26wlQld7ONKHK57Rfr5qR64Ofw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by MN2PR12MB4360.namprd12.prod.outlook.com (2603:10b6:208:266::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Fri, 14 Feb
 2025 19:42:16 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8445.013; Fri, 14 Feb 2025
 19:42:16 +0000
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
Subject: [PATCH 7/8] sched_ext: idle: Per-node idle cpumasks
Date: Fri, 14 Feb 2025 20:40:06 +0100
Message-ID: <20250214194134.658939-8-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250214194134.658939-1-arighi@nvidia.com>
References: <20250214194134.658939-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0141.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::9) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|MN2PR12MB4360:EE_
X-MS-Office365-Filtering-Correlation-Id: 46f92a3b-d300-4821-3e94-08dd4d2fafdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SMv1QMX5MVYyNvBkbltxAuFeLJtPP5KK9/afgytKXUcm0kzVXz3Hj2yL0KUD?=
 =?us-ascii?Q?x2sEtJREEEHjcbvXlZZwk+rQsmfaYhGjLcQt7fY3OfjZgQmCZw2zKSGJbhdf?=
 =?us-ascii?Q?twIs28X7i/QyI7ReFboYjb+c4wix2GrEznRMaUE2/LelA9+YMPUBukVmR5PM?=
 =?us-ascii?Q?YkrAdrwPlE+Hia8pUu8hFBiZVnPvQR9FdcveBind5u0xmylvz0Q/7HjfUu1s?=
 =?us-ascii?Q?qVib5oGRS8hjbhn1oJfvT8eWVIrQuCXlNaanNHEy/4IMlP0hKKdGwzlRCpWW?=
 =?us-ascii?Q?IpICFcDFSfQ1Bmw7hkpMzgADD3c2DHQWvLJVv+eDBft4eUaagXeI4AqI35xt?=
 =?us-ascii?Q?VkR0am5PhbZzG/rH/3g5AO7wmz6K4lmKDKBcb7OKDGqhTIPSgKuxg6Xm8ky+?=
 =?us-ascii?Q?qVBePCQCj1/4+skV7YtBxbFEnvhvvu/e9qugDlzx6y1m4ovy40xOL0hv84GZ?=
 =?us-ascii?Q?15kkgb0fsM6SP9NlcT02LkRGwn8BPwU6l603qZd3FiNlhkAYIYjvbGkcyKjS?=
 =?us-ascii?Q?yGGSptgQzp/GiCMjhyAr42fz2HxeIJZDzK0avZCJkZpVMlJptLZqda9sRAJb?=
 =?us-ascii?Q?lAfHzKdbjHNBaFV6l7AW4oIP/67s1c1PllLUjW0Em0CHpmKmslhxthCCk+Yc?=
 =?us-ascii?Q?zWUGmZzQNqfg4PQuy/ftrFvSPibFrbI1H7nIrM6aqYlH/zSRaNujQI46SzFC?=
 =?us-ascii?Q?EKOHQxeLhOaWUXrcA8xoPTW95f08Bmg32QPYZ6vqXRcwOMF0m8Oq3t6mxyWw?=
 =?us-ascii?Q?QjQCtwLDGHTinUfJxenRngakcrsvAAhNXlw8pncx3RAf4rjsB6ui2RF51fBf?=
 =?us-ascii?Q?RYhi4Wslt3zaicG2jTjFm5/gX6AqAHcaCBslZYgppxKUizzLd4nGdZyOnWf1?=
 =?us-ascii?Q?IaDXlJoxaWO+a4qkjnIki2iOt7eOPPHd2+MLMQELE7bqxy4Yl5BsJfeg1Cls?=
 =?us-ascii?Q?gQcgi8iTwGrXPLOsJQ0p9/wVnhamDyTag2RH07L5GVZnMpD8mnjhwtXQrOlS?=
 =?us-ascii?Q?3u6LemW/+WhR6wHpU2Gz8Qt6j6yetrARJtxtTDViKyTixm5a/heMwn6c/cvl?=
 =?us-ascii?Q?7+3dNy1bcUPs6oYhn6UdOf8hYvleNLRKc31wmv7YUZN1F5Hos/Npwvoefz0Q?=
 =?us-ascii?Q?gUqA1ma3BT6CR5aRGNiLFjSwSaaC9mTD0MC8snF7PaObHrwWO/1NXbtA5QKl?=
 =?us-ascii?Q?bFcy5tRR88HFcdr5MvlzrVs5EW3n5BcNDQ3vpETQD6JVbRz3hfjQlb8VMVM7?=
 =?us-ascii?Q?URlUUTVogbXzJ7gEacV6f2+DfloFnkfTS52PmutNz49M4ntQWz0UX4Ivx4cR?=
 =?us-ascii?Q?OlvjJk8hFfAsay3cBDMgv+LgicDiTbEWsxRv9fNeKaMxZnIUPb3OOtmHFZB8?=
 =?us-ascii?Q?fqkmXjggI3n1Ptlmb1eRQGVWEaze?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PeozNRI3NN5Ma3RiZCnnqzvic7FobdqyiKw4LMTN6nQt9PjA3pzy6D4Zammd?=
 =?us-ascii?Q?szDs0rcMahg/57OPJsv4/BgCVmkO07x/glvoGm7y9eXX4ON+Xqauthh20KHI?=
 =?us-ascii?Q?IlkrmxgMDkNop+w2+IfqKxpLFutTp0/1m/+DyYvquaDxNLy+TUgpZw0y2aZg?=
 =?us-ascii?Q?re9hDKSRGPlr6RntFO+VY69abYxROa6BntUA5yy04/MkRJu1yQ7ikSnM3Rme?=
 =?us-ascii?Q?2uL/5n1A6irlPW4DiMFdA9Yvipvs5bc1AuOFsa0pWPNkvfq4kcRytXs4JLH4?=
 =?us-ascii?Q?TwSCasD+0uo+Rhw+ZiuCd86GapBBr02lA6PsUETkSzAC8UNPn4YSJ9GijceC?=
 =?us-ascii?Q?DuiTMOQZsjh7ZLUGhDEyh24EgS4JK0enoH6IOCGOXY9gUshAPNAdsfQVGMIh?=
 =?us-ascii?Q?zesxF4czPD1vAoxKEDrwnNoMJsMMvjGgdUaen3IEAn4TBNgRt59t8iSH4IhP?=
 =?us-ascii?Q?zoZvGjWZC00mXsMiO+POnLqDDjK1uBfskS9itY+4M4yRSYWqv2r69muR07HG?=
 =?us-ascii?Q?ULAdios2ccy3YI/Yt7IowdkjClr1lKxUViBdYiQw/rwboLFxoSG9rThxkPhx?=
 =?us-ascii?Q?EkwqGs5s938Pfb5xMDAX4QJnJpqgd4NGbcCYWtDp7XQd976qWl9TOP1qvf26?=
 =?us-ascii?Q?A3EDKEx5lTGU6ntaRfBL0R6Qrs6UG3k/bSZWQZ+IkVvy1q9HNNI2XJRRDp6u?=
 =?us-ascii?Q?FcwadszOvHoI5CK1rcRXGo5xU0uc8Q89MKJ5GHMdLaYqZz5YUcLbRITlyf5j?=
 =?us-ascii?Q?MpYwd2vrFYJFnw7ajhU/oTZDxYb3GyaGHfa/xOzXF0IK/y8T6XuldZ4NLaYu?=
 =?us-ascii?Q?L7GGjHuy5QN/VaZevum6USzATZAxeQyFncBKMPUZLXt4tNVxoGPh7FuDowA+?=
 =?us-ascii?Q?uMiL3fIPdhtPFJf4axGlQ5f02gnfphC5c6aDh0iRz2s1MeAh0SwsD2IpCLDk?=
 =?us-ascii?Q?zuX7h5Yi4Bs82Y32soMJbPFiVev70IDBmLb9HMUDFJT5z2/3NO2btwgvXm5e?=
 =?us-ascii?Q?3CeRceuF3YwQS087l6LrfDEj5R/ifaDhUfs+5E9X5LCvPcab3pV0uTeN9HRe?=
 =?us-ascii?Q?Y35LL9xkoj+10JYhJMfQde8P/An6RnlFpgj3Xin7XAewNExIET49IOL1UXPd?=
 =?us-ascii?Q?ei6CMF7fuBPRMR9RARcvXnTubKSS6wE6bOUslbx1ah18tPG70B/3C0ZtgGQ0?=
 =?us-ascii?Q?qEh0+GbQhmU0zx3p/RA1fNf1K9JMwhFi9Hj2b5gTF+uXW3MLs+xvT2Rf67qx?=
 =?us-ascii?Q?7MNormvk2hgiNw2ja4Mxqs60aIzXZtl/idEYeLKVrGI/lWABZXwJ+fC1E4km?=
 =?us-ascii?Q?XSDHGwgzAgNPKFJZva9V8Ey1lj6jYF4zm51tqoHEha2KYceUYv88F3/Pvzem?=
 =?us-ascii?Q?zgmILm98JlNvbDTiPFQcyVRioiTVqAce3Hj49ITltDgVBhfWIM/fv5oNpaUB?=
 =?us-ascii?Q?K5gLd3mQQAnQIuUAXzlOoJMzW3wXs7r11HLQpqpEFER7KvzXPmSKpkFKXWxF?=
 =?us-ascii?Q?G8M+k8sN6ESlP4wVstzgom9a+uhtzGvndKgtr2vvvL1ySPinTgo8CwjhlT/4?=
 =?us-ascii?Q?ZEh7pxD9+/8fZFfKAjQG7FTsArpMLodlwez4odmz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46f92a3b-d300-4821-3e94-08dd4d2fafdd
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 19:42:16.8381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LwiJMeBM4b7khGdxOxoyz2/YjAZ8UD+wHEst1U2AiGZJQWl089vZoFZrSrrZcp+V81KoLyyqyu41s7KekOKgNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4360

Using a single global idle mask can lead to inefficiencies and a lot of
stress on the cache coherency protocol on large systems with multiple
NUMA nodes, since all the CPUs can create a really intense read/write
activity on the single global cpumask.

Therefore, split the global cpumask into multiple per-NUMA node cpumasks
to improve scalability and performance on large systems.

The concept is that each cpumask will track only the idle CPUs within
its corresponding NUMA node, treating CPUs in other NUMA nodes as busy.
In this way concurrent access to the idle cpumask will be restricted
within each NUMA node.

The split of multiple per-node idle cpumasks can be controlled using the
SCX_OPS_BUILTIN_IDLE_PER_NODE flag.

By default SCX_OPS_BUILTIN_IDLE_PER_NODE is not enabled and a global
host-wide idle cpumask is used, maintaining the previous behavior.

NOTE: if a scheduler explicitly enables the per-node idle cpumasks (via
SCX_OPS_BUILTIN_IDLE_PER_NODE), scx_bpf_get_idle_cpu/smtmask() will
trigger an scx error, since there are no system-wide cpumasks.

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

Moreover, with a modified scx_bpfland that uses the new NUMA-aware APIs
I observed an additional +2-2.5% performance improvement with the same
test.

[1] https://github.com/sched-ext/scx/blob/main/scheds/c/scx_simple.bpf.c

Cc: Yury Norov [NVIDIA] <yury.norov@gmail.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c                   |   1 +
 kernel/sched/ext_idle.c              | 283 ++++++++++++++++++++++-----
 kernel/sched/ext_idle.h              |   4 +-
 tools/sched_ext/include/scx/compat.h |   3 +
 4 files changed, 236 insertions(+), 55 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 330a359d79301..95603db36f043 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -806,6 +806,7 @@ enum scx_deq_flags {
 
 enum scx_pick_idle_cpu_flags {
 	SCX_PICK_IDLE_CORE	= 1LLU << 0,	/* pick a CPU whose SMT siblings are also idle */
+	SCX_PICK_IDLE_IN_NODE	= 1LLU << 1,	/* pick a CPU in the same target NUMA node */
 };
 
 enum scx_kick_flags {
diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index 0912f94b95cdc..8dacccc82ed63 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -18,25 +18,61 @@ static DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_enabled);
 static DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_per_node);
 
 #ifdef CONFIG_SMP
-#ifdef CONFIG_CPUMASK_OFFSTACK
-#define CL_ALIGNED_IF_ONSTACK
-#else
-#define CL_ALIGNED_IF_ONSTACK __cacheline_aligned_in_smp
-#endif
-
 /* Enable/disable LLC aware optimizations */
 static DEFINE_STATIC_KEY_FALSE(scx_selcpu_topo_llc);
 
 /* Enable/disable NUMA aware optimizations */
 static DEFINE_STATIC_KEY_FALSE(scx_selcpu_topo_numa);
 
-static struct {
+/*
+ * cpumasks to track idle CPUs within each NUMA node.
+ *
+ * If SCX_OPS_BUILTIN_IDLE_PER_NODE is not enabled, a single global cpumask
+ * from is used to track all the idle CPUs in the system.
+ */
+struct scx_idle_cpus {
 	cpumask_var_t cpu;
 	cpumask_var_t smt;
-} idle_masks CL_ALIGNED_IF_ONSTACK;
+};
+
+/*
+ * Global host-wide idle cpumasks (used when SCX_OPS_BUILTIN_IDLE_PER_NODE
+ * is not enabled).
+ */
+static struct scx_idle_cpus scx_idle_global_masks;
+
+/*
+ * Per-node idle cpumasks.
+ */
+static struct scx_idle_cpus **scx_idle_node_masks;
+
+/*
+ * Return the idle masks associated to a target @node.
+ *
+ * NUMA_NO_NODE identifies the global idle cpumask.
+ */
+static struct scx_idle_cpus *idle_cpumask(int node)
+{
+	return node == NUMA_NO_NODE ? &scx_idle_global_masks : scx_idle_node_masks[node];
+}
+
+/*
+ * Returns the NUMA node ID associated with a @cpu, or NUMA_NO_NODE if
+ * per-node idle cpumasks are disabled.
+ */
+static int scx_cpu_node_if_enabled(int cpu)
+{
+	if (!static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node))
+		return NUMA_NO_NODE;
+
+	return cpu_to_node(cpu);
+}
 
 bool scx_idle_test_and_clear_cpu(int cpu)
 {
+	int node = scx_cpu_node_if_enabled(cpu);
+	struct cpumask *idle_cpus = idle_cpumask(node)->cpu;
+
 #ifdef CONFIG_SCHED_SMT
 	/*
 	 * SMT mask should be cleared whether we can claim @cpu or not. The SMT
@@ -45,33 +81,38 @@ bool scx_idle_test_and_clear_cpu(int cpu)
 	 */
 	if (sched_smt_active()) {
 		const struct cpumask *smt = cpu_smt_mask(cpu);
+		struct cpumask *idle_smts = idle_cpumask(node)->smt;
 
 		/*
 		 * If offline, @cpu is not its own sibling and
 		 * scx_pick_idle_cpu() can get caught in an infinite loop as
-		 * @cpu is never cleared from idle_masks.smt. Ensure that @cpu
-		 * is eventually cleared.
+		 * @cpu is never cleared from the idle SMT mask. Ensure that
+		 * @cpu is eventually cleared.
 		 *
 		 * NOTE: Use cpumask_intersects() and cpumask_test_cpu() to
 		 * reduce memory writes, which may help alleviate cache
 		 * coherence pressure.
 		 */
-		if (cpumask_intersects(smt, idle_masks.smt))
-			cpumask_andnot(idle_masks.smt, idle_masks.smt, smt);
-		else if (cpumask_test_cpu(cpu, idle_masks.smt))
-			__cpumask_clear_cpu(cpu, idle_masks.smt);
+		if (cpumask_intersects(smt, idle_smts))
+			cpumask_andnot(idle_smts, idle_smts, smt);
+		else if (cpumask_test_cpu(cpu, idle_smts))
+			__cpumask_clear_cpu(cpu, idle_smts);
 	}
 #endif
-	return cpumask_test_and_clear_cpu(cpu, idle_masks.cpu);
+
+	return cpumask_test_and_clear_cpu(cpu, idle_cpus);
 }
 
-s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags)
+/*
+ * Pick an idle CPU in a specific NUMA node.
+ */
+static s32 pick_idle_cpu_in_node(const struct cpumask *cpus_allowed, int node, u64 flags)
 {
 	int cpu;
 
 retry:
 	if (sched_smt_active()) {
-		cpu = cpumask_any_and_distribute(idle_masks.smt, cpus_allowed);
+		cpu = cpumask_any_and_distribute(idle_cpumask(node)->smt, cpus_allowed);
 		if (cpu < nr_cpu_ids)
 			goto found;
 
@@ -79,7 +120,7 @@ s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags)
 			return -EBUSY;
 	}
 
-	cpu = cpumask_any_and_distribute(idle_masks.cpu, cpus_allowed);
+	cpu = cpumask_any_and_distribute(idle_cpumask(node)->cpu, cpus_allowed);
 	if (cpu >= nr_cpu_ids)
 		return -EBUSY;
 
@@ -90,6 +131,85 @@ s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags)
 		goto retry;
 }
 
+/*
+ * Tracks nodes that have not yet been visited when searching for an idle
+ * CPU across all available nodes.
+ */
+static DEFINE_PER_CPU(nodemask_t, per_cpu_unvisited);
+
+/*
+ * Search for an idle CPU across all nodes, excluding @node.
+ */
+static s32 pick_idle_cpu_from_online_nodes(const struct cpumask *cpus_allowed, int node, u64 flags)
+{
+	nodemask_t *unvisited;
+	s32 cpu = -EBUSY;
+
+	preempt_disable();
+	unvisited = this_cpu_ptr(&per_cpu_unvisited);
+
+	/*
+	 * Restrict the search to the online nodes (excluding the current
+	 * node that has been visited already).
+	 */
+	nodes_copy(*unvisited, node_states[N_ONLINE]);
+	node_clear(node, *unvisited);
+
+	/*
+	 * Traverse all nodes in order of increasing distance, starting
+	 * from @node.
+	 *
+	 * This loop is O(N^2), with N being the amount of NUMA nodes,
+	 * which might be quite expensive in large NUMA systems. However,
+	 * this complexity comes into play only when a scheduler enables
+	 * SCX_OPS_BUILTIN_IDLE_PER_NODE and it's requesting an idle CPU
+	 * without specifying a target NUMA node, so it shouldn't be a
+	 * bottleneck is most cases.
+	 *
+	 * As a future optimization we may want to cache the list of nodes
+	 * in a per-node array, instead of actually traversing them every
+	 * time.
+	 */
+	for_each_node_numadist(node, *unvisited) {
+		cpu = pick_idle_cpu_in_node(cpus_allowed, node, flags);
+		if (cpu >= 0)
+			break;
+	}
+	preempt_enable();
+
+	return cpu;
+}
+
+/*
+ * Find an idle CPU in the system, starting from @node.
+ */
+s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, int node, u64 flags)
+{
+	s32 cpu;
+
+	/*
+	 * Always search in the starting node first (this is an
+	 * optimization that can save some cycles even when the search is
+	 * not limited to a single node).
+	 */
+	cpu = pick_idle_cpu_in_node(cpus_allowed, node, flags);
+	if (cpu >= 0)
+		return cpu;
+
+	/*
+	 * Stop the search if we are using only a single global cpumask
+	 * (NUMA_NO_NODE) or if the search is restricted to the first node
+	 * only.
+	 */
+	if (node == NUMA_NO_NODE || flags & SCX_PICK_IDLE_IN_NODE)
+		return -EBUSY;
+
+	/*
+	 * Extend the search to the other online nodes.
+	 */
+	return pick_idle_cpu_from_online_nodes(cpus_allowed, node, flags);
+}
+
 /*
  * Return the amount of CPUs in the same LLC domain of @cpu (or zero if the LLC
  * domain is not defined).
@@ -302,6 +422,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool
 {
 	const struct cpumask *llc_cpus = NULL;
 	const struct cpumask *numa_cpus = NULL;
+	int node = scx_cpu_node_if_enabled(prev_cpu);
 	s32 cpu;
 
 	*found = false;
@@ -359,9 +480,9 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool
 		 * piled up on it even if there is an idle core elsewhere on
 		 * the system.
 		 */
-		if (!cpumask_empty(idle_masks.cpu) &&
-		    !(current->flags & PF_EXITING) &&
-		    cpu_rq(cpu)->scx.local_dsq.nr == 0) {
+		if (!(current->flags & PF_EXITING) &&
+		    cpu_rq(cpu)->scx.local_dsq.nr == 0 &&
+		    !cpumask_empty(idle_cpumask(cpu_to_node(cpu))->cpu)) {
 			if (cpumask_test_cpu(cpu, p->cpus_ptr))
 				goto cpu_found;
 		}
@@ -375,7 +496,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool
 		/*
 		 * Keep using @prev_cpu if it's part of a fully idle core.
 		 */
-		if (cpumask_test_cpu(prev_cpu, idle_masks.smt) &&
+		if (cpumask_test_cpu(prev_cpu, idle_cpumask(node)->smt) &&
 		    scx_idle_test_and_clear_cpu(prev_cpu)) {
 			cpu = prev_cpu;
 			goto cpu_found;
@@ -385,7 +506,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool
 		 * Search for any fully idle core in the same LLC domain.
 		 */
 		if (llc_cpus) {
-			cpu = scx_pick_idle_cpu(llc_cpus, SCX_PICK_IDLE_CORE);
+			cpu = pick_idle_cpu_in_node(llc_cpus, node, SCX_PICK_IDLE_CORE);
 			if (cpu >= 0)
 				goto cpu_found;
 		}
@@ -394,15 +515,19 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool
 		 * Search for any fully idle core in the same NUMA node.
 		 */
 		if (numa_cpus) {
-			cpu = scx_pick_idle_cpu(numa_cpus, SCX_PICK_IDLE_CORE);
+			cpu = pick_idle_cpu_in_node(numa_cpus, node, SCX_PICK_IDLE_CORE);
 			if (cpu >= 0)
 				goto cpu_found;
 		}
 
 		/*
 		 * Search for any full idle core usable by the task.
+		 *
+		 * If NUMA aware idle selection is enabled, the search will
+		 * begin in prev_cpu's node and proceed to other nodes in
+		 * order of increasing distance.
 		 */
-		cpu = scx_pick_idle_cpu(p->cpus_ptr, SCX_PICK_IDLE_CORE);
+		cpu = scx_pick_idle_cpu(p->cpus_ptr, node, SCX_PICK_IDLE_CORE);
 		if (cpu >= 0)
 			goto cpu_found;
 	}
@@ -419,7 +544,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool
 	 * Search for any idle CPU in the same LLC domain.
 	 */
 	if (llc_cpus) {
-		cpu = scx_pick_idle_cpu(llc_cpus, 0);
+		cpu = pick_idle_cpu_in_node(llc_cpus, node, 0);
 		if (cpu >= 0)
 			goto cpu_found;
 	}
@@ -428,7 +553,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool
 	 * Search for any idle CPU in the same NUMA node.
 	 */
 	if (numa_cpus) {
-		cpu = scx_pick_idle_cpu(numa_cpus, 0);
+		cpu = pick_idle_cpu_in_node(numa_cpus, node, 0);
 		if (cpu >= 0)
 			goto cpu_found;
 	}
@@ -436,7 +561,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool
 	/*
 	 * Search for any idle CPU usable by the task.
 	 */
-	cpu = scx_pick_idle_cpu(p->cpus_ptr, 0);
+	cpu = scx_pick_idle_cpu(p->cpus_ptr, node, 0);
 	if (cpu >= 0)
 		goto cpu_found;
 
@@ -450,30 +575,54 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool
 	return cpu;
 }
 
+/*
+ * Initialize global and per-node idle cpumasks.
+ */
 void scx_idle_init_masks(void)
 {
-	BUG_ON(!alloc_cpumask_var(&idle_masks.cpu, GFP_KERNEL));
-	BUG_ON(!alloc_cpumask_var(&idle_masks.smt, GFP_KERNEL));
+	int node;
+
+	/* Allocate global idle cpumasks */
+	BUG_ON(!alloc_cpumask_var(&scx_idle_global_masks.cpu, GFP_KERNEL));
+	BUG_ON(!alloc_cpumask_var(&scx_idle_global_masks.smt, GFP_KERNEL));
+
+	/* Allocate per-node idle cpumasks */
+	scx_idle_node_masks = kcalloc(num_possible_nodes(),
+				      sizeof(*scx_idle_node_masks), GFP_KERNEL);
+	BUG_ON(!scx_idle_node_masks);
+
+	for_each_node(node) {
+		scx_idle_node_masks[node] = kzalloc_node(sizeof(**scx_idle_node_masks),
+							 GFP_KERNEL, node);
+		BUG_ON(!scx_idle_node_masks[node]);
+
+		BUG_ON(!alloc_cpumask_var_node(&scx_idle_node_masks[node]->cpu, GFP_KERNEL, node));
+		BUG_ON(!alloc_cpumask_var_node(&scx_idle_node_masks[node]->smt, GFP_KERNEL, node));
+	}
 }
 
 static void update_builtin_idle(int cpu, bool idle)
 {
-	assign_cpu(cpu, idle_masks.cpu, idle);
+	int node = scx_cpu_node_if_enabled(cpu);
+	struct cpumask *idle_cpus = idle_cpumask(node)->cpu;
+
+	assign_cpu(cpu, idle_cpus, idle);
 
 #ifdef CONFIG_SCHED_SMT
 	if (sched_smt_active()) {
 		const struct cpumask *smt = cpu_smt_mask(cpu);
+		struct cpumask *idle_smts = idle_cpumask(node)->smt;
 
 		if (idle) {
 			/*
-			 * idle_masks.smt handling is racy but that's fine as
-			 * it's only for optimization and self-correcting.
+			 * idle_smt handling is racy but that's fine as it's
+			 * only for optimization and self-correcting.
 			 */
-			if (!cpumask_subset(smt, idle_masks.cpu))
+			if (!cpumask_subset(smt, idle_cpus))
 				return;
-			cpumask_or(idle_masks.smt, idle_masks.smt, smt);
+			cpumask_or(idle_smts, idle_smts, smt);
 		} else {
-			cpumask_andnot(idle_masks.smt, idle_masks.smt, smt);
+			cpumask_andnot(idle_smts, idle_smts, smt);
 		}
 	}
 #endif
@@ -529,15 +678,36 @@ void __scx_update_idle(struct rq *rq, bool idle, bool do_notify)
 		if (do_notify || is_idle_task(rq->curr))
 			update_builtin_idle(cpu, idle);
 }
+
+static void reset_idle_masks(struct sched_ext_ops *ops)
+{
+	int node;
+
+	/*
+	 * Consider all online cpus idle. Should converge to the actual state
+	 * quickly.
+	 */
+	if (!(ops->flags & SCX_OPS_BUILTIN_IDLE_PER_NODE)) {
+		cpumask_copy(idle_cpumask(NUMA_NO_NODE)->cpu, cpu_online_mask);
+		cpumask_copy(idle_cpumask(NUMA_NO_NODE)->smt, cpu_online_mask);
+		return;
+	}
+
+	for_each_node(node) {
+		const struct cpumask *node_mask = cpumask_of_node(node);
+
+		cpumask_and(idle_cpumask(node)->cpu, cpu_online_mask, node_mask);
+		cpumask_and(idle_cpumask(node)->smt, cpu_online_mask, node_mask);
+	}
+}
 #endif	/* CONFIG_SMP */
 
 void scx_idle_enable(struct sched_ext_ops *ops)
 {
-	if (ops->update_idle && !(ops->flags & SCX_OPS_KEEP_BUILTIN_IDLE)) {
+	if (!ops->update_idle || (ops->flags & SCX_OPS_KEEP_BUILTIN_IDLE))
+		static_branch_enable(&scx_builtin_idle_enabled);
+	else
 		static_branch_disable(&scx_builtin_idle_enabled);
-		return;
-	}
-	static_branch_enable(&scx_builtin_idle_enabled);
 
 	if (ops->flags & SCX_OPS_BUILTIN_IDLE_PER_NODE)
 		static_branch_enable(&scx_builtin_idle_per_node);
@@ -545,12 +715,7 @@ void scx_idle_enable(struct sched_ext_ops *ops)
 		static_branch_disable(&scx_builtin_idle_per_node);
 
 #ifdef CONFIG_SMP
-	/*
-	 * Consider all online cpus idle. Should converge to the actual state
-	 * quickly.
-	 */
-	cpumask_copy(idle_masks.cpu, cpu_online_mask);
-	cpumask_copy(idle_masks.smt, cpu_online_mask);
+	reset_idle_masks(ops);
 #endif
 }
 
@@ -610,15 +775,21 @@ __bpf_kfunc s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
  * scx_bpf_get_idle_cpumask - Get a referenced kptr to the idle-tracking
  * per-CPU cpumask.
  *
- * Returns NULL if idle tracking is not enabled, or running on a UP kernel.
+ * Returns an empty mask if idle tracking is not enabled, or running on a
+ * UP kernel.
  */
 __bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask(void)
 {
+	if (static_branch_unlikely(&scx_builtin_idle_per_node)) {
+		scx_ops_error("SCX_OPS_BUILTIN_IDLE_PER_NODE enabled");
+		return cpu_none_mask;
+	}
+
 	if (!check_builtin_idle_enabled())
 		return cpu_none_mask;
 
 #ifdef CONFIG_SMP
-	return idle_masks.cpu;
+	return idle_cpumask(NUMA_NO_NODE)->cpu;
 #else
 	return cpu_none_mask;
 #endif
@@ -629,18 +800,24 @@ __bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask(void)
  * per-physical-core cpumask. Can be used to determine if an entire physical
  * core is free.
  *
- * Returns NULL if idle tracking is not enabled, or running on a UP kernel.
+ * Returns an empty mask if idle tracking is not enabled, or running on a
+ * UP kernel.
  */
 __bpf_kfunc const struct cpumask *scx_bpf_get_idle_smtmask(void)
 {
+	if (static_branch_unlikely(&scx_builtin_idle_per_node)) {
+		scx_ops_error("SCX_OPS_BUILTIN_IDLE_PER_NODE enabled");
+		return cpu_none_mask;
+	}
+
 	if (!check_builtin_idle_enabled())
 		return cpu_none_mask;
 
 #ifdef CONFIG_SMP
 	if (sched_smt_active())
-		return idle_masks.smt;
+		return idle_cpumask(NUMA_NO_NODE)->smt;
 	else
-		return idle_masks.cpu;
+		return idle_cpumask(NUMA_NO_NODE)->cpu;
 #else
 	return cpu_none_mask;
 #endif
@@ -707,7 +884,7 @@ __bpf_kfunc s32 scx_bpf_pick_idle_cpu(const struct cpumask *cpus_allowed,
 	if (!check_builtin_idle_enabled())
 		return -EBUSY;
 
-	return scx_pick_idle_cpu(cpus_allowed, flags);
+	return scx_pick_idle_cpu(cpus_allowed, NUMA_NO_NODE, flags);
 }
 
 /**
@@ -730,7 +907,7 @@ __bpf_kfunc s32 scx_bpf_pick_any_cpu(const struct cpumask *cpus_allowed,
 	s32 cpu;
 
 	if (static_branch_likely(&scx_builtin_idle_enabled)) {
-		cpu = scx_pick_idle_cpu(cpus_allowed, flags);
+		cpu = scx_pick_idle_cpu(cpus_allowed, NUMA_NO_NODE, flags);
 		if (cpu >= 0)
 			return cpu;
 	}
diff --git a/kernel/sched/ext_idle.h b/kernel/sched/ext_idle.h
index 339b6ec9c4cb7..68c4307ce4f6f 100644
--- a/kernel/sched/ext_idle.h
+++ b/kernel/sched/ext_idle.h
@@ -16,12 +16,12 @@ struct sched_ext_ops;
 void scx_idle_update_selcpu_topology(struct sched_ext_ops *ops);
 void scx_idle_init_masks(void);
 bool scx_idle_test_and_clear_cpu(int cpu);
-s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags);
+s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, int node, u64 flags);
 #else /* !CONFIG_SMP */
 static inline void scx_idle_update_selcpu_topology(struct sched_ext_ops *ops) {}
 static inline void scx_idle_init_masks(void) {}
 static inline bool scx_idle_test_and_clear_cpu(int cpu) { return false; }
-static inline s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags)
+static inline s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, int node, u64 flags)
 {
 	return -EBUSY;
 }
diff --git a/tools/sched_ext/include/scx/compat.h b/tools/sched_ext/include/scx/compat.h
index d63cf40be8eee..03e06bd15c738 100644
--- a/tools/sched_ext/include/scx/compat.h
+++ b/tools/sched_ext/include/scx/compat.h
@@ -112,6 +112,9 @@ static inline bool __COMPAT_struct_has_field(const char *type, const char *field
 #define SCX_OPS_BUILTIN_IDLE_PER_NODE						\
 	__COMPAT_ENUM_OR_ZERO("scx_ops_flags", "SCX_OPS_BUILTIN_IDLE_PER_NODE")
 
+#define SCX_PICK_IDLE_IN_NODE \
+	__COMPAT_ENUM_OR_ZERO("scx_pick_idle_cpu_flags", "SCX_PICK_IDLE_IN_NODE")
+
 static inline long scx_hotplug_seq(void)
 {
 	int fd;
-- 
2.48.1


