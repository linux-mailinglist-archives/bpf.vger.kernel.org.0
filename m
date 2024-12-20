Return-Path: <bpf+bounces-47433-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F719F95AF
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 16:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E72318888C4
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 15:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C7321C9F8;
	Fri, 20 Dec 2024 15:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lRVapCRw"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCBF21C19B;
	Fri, 20 Dec 2024 15:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734709314; cv=fail; b=Ihir2xgW40gmYUdbkjXS7NeQZSmIejLIs2lNg5tye4pillqMGIVNciUCxzZM79FdYjLL+8OIMAwjAkiZnZ8aRTvNwqD7UIkyLhNkIP9yjkqXWnxaN5dlfcWyPEk6n6DrG6KpCE12a5pQ6slUIC93NZX+qV5x6dEI/aAD3h/ZMK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734709314; c=relaxed/simple;
	bh=Qs84QUO7aor9tM46u9EGnQJWA2ngENEZPX20Es/R9FM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pxQAlKZuabh6W0g6kk/vAXbkIUNFzXylHekSNTtrIg666OqTVz0ffyfzkbS9DAH32ZpihJT8ITTySs8S5gWjujyd573EuqSSrP5VwC6LHASaKwp4nDg2sOijYRfde/gAN8nL5u/ztSKzRjA1gGV28U00j4dmXWrwTM7hpY1v9v8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lRVapCRw; arc=fail smtp.client-ip=40.107.244.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D96wQSUEwhrrBalNI+xUQTc9oLXvrKJoLvyibb0+bGMt0pys+tAbPOtjdnvO1l36pw0HXCWMAGzOXjSbhWiOICgCmxc/R8FVJaRMMGOlT9fziW5/YnL2g4j76VcDM+1liCSIo8S8/TfhCZVRSIaFBQvpRPBIZqu5l2abiJIv34o8N04Gxx1tbZba4WEnzQy8RNERRRomSS5RxbcN61HRLVzAdRDijnWDZxXkoa375WStFdFx0SWD8TMR2IkVRLoRcpLv0Q5iGmmsLUkMy564j2PaPq/oZJ3CLHS/x8U4XCwjjpg+PZ4wmXNejdLx1btp1mSoiAXHX0EfnrVKUuCDYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DqwDWV2Mk7iopu6bUJMefBeBRVYvYWXIgOGq+9PlXXo=;
 b=NKC3n2Ti0j3kdwaEAVuwh5c7QM+Wj31RSYsKx581wz/kJ5zgsrJn/cx37sIxMHxe2E4yXBasvGgQQJx57m3nOS00Yfh98cNdZghPbo6UFsyiGgr3GRkqj5qf4wH143LFtrNNT24ds4kCB0xH90N4Au0Sl995d4LRdwp6yJFlqPOA4cwBWJ+9VZskqJJhN6wBW/LVtx0O0ipLm+X00Q/8J+XES1kCYM2iPhjHHp7KD0OysVHxg6IVFCuLWujp+ZBByF24z9Rb/dqLzC+ozHrXzdpnK8wdd1sZams3mnvY/qT/81VaAVXt0WvKM6STORJl4VAsP5CxybfeAmEElWwC3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DqwDWV2Mk7iopu6bUJMefBeBRVYvYWXIgOGq+9PlXXo=;
 b=lRVapCRwri2XqGdpOCrDBMc83yPs8ks8r36za2fAD+GJBZvrNgmfYLdPJchld+00VO4nG1rXKbaORs17LHsZzEa1YGgMVPZVZ0XLcZCynrhazWh5pua7dckHH0xN9rzpt4Fk0XjFNLN7YCUf4+bTrH242HNcbEVbmIQN7mfpAKLkyDEHTn4lAY58Bw/vmkBKwJLXWjLM0ay6YBB5eXWLOlMfcjDRiCmiKMFmGTXD06dQwiOI9WYNjj4quQVL92+VdE/Pm9JZLe5lpPSboIsB4xy4OQIER55bsIcfhXb8imbrEuz2TA0OKncxItpG0DmhHwAZ9GNbetcHMiSuzO4D7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by SA1PR12MB7149.namprd12.prod.outlook.com (2603:10b6:806:29c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Fri, 20 Dec
 2024 15:41:50 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%3]) with mapi id 15.20.8272.005; Fri, 20 Dec 2024
 15:41:50 +0000
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
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 08/10] sched_ext: idle: introduce SCX_PICK_IDLE_NODE
Date: Fri, 20 Dec 2024 16:11:40 +0100
Message-ID: <20241220154107.287478-9-arighi@nvidia.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220154107.287478-1-arighi@nvidia.com>
References: <20241220154107.287478-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0168.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::20) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|SA1PR12MB7149:EE_
X-MS-Office365-Filtering-Correlation-Id: 642c8123-2ee2-41df-0736-08dd210cd1e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6GwpifyQesgPDtQb3awmFMCsWNLwi8UPowz2HdI5pDAuIOj02IsdsNFXilop?=
 =?us-ascii?Q?XTnc/35H0XrQAojMRhV3fnkrDT4ZOC2JGA/ufChK2L6jWxiQyHqasL0WpSZc?=
 =?us-ascii?Q?+nSq96QZ4bVvnNYwMm132cfR209jf8vcIR943M91Q7oXX3Xax3mYjNEk5MHm?=
 =?us-ascii?Q?QebXMUNu3I42GhZCPp4ckHOiHtYNb6qPwvKH0OsCZl8bziu1XBlFbcs9amI7?=
 =?us-ascii?Q?RC7f66cMti6ZyPwNz6i9rAC2Hn3ziClNxMgFCLQLNALqGeKBaGkAaUJEjKgE?=
 =?us-ascii?Q?xf2t+xU+wPgcS7od6iDTV4awBE6o/HDOFFb3K7irpDWFe0KPCjwhSmUecCQK?=
 =?us-ascii?Q?6kengc1QVRkVRjAGVIauJaGtihaaWPuuEOc50zIFxfaoN7pN4/PwQBE7ZugO?=
 =?us-ascii?Q?umzVz+IGTgb0koau3T3ifzcaSkEEZOKRYQl7xy6pz+/R+Emw7g/bf4P7Ipkp?=
 =?us-ascii?Q?GtQWBYGh8QOTwWxV6yF/1PWdBNb8OrHz293Su+upnDM26w/wnrtmUfIOjSYF?=
 =?us-ascii?Q?SFwubQ697GHHz+W5Vqx+zZkc0/Hm2mx8+oWd/3NsbnMXYL+QwMIccwx/x+bJ?=
 =?us-ascii?Q?QAmYIGt1eWkd2KYKM2SSGBLjAAlKporih15hyu2bahsrJhEd5STNnr7+Il7O?=
 =?us-ascii?Q?Lgvx/cY54mVZvc7JhJPn/70a+zF+0hCc6BjBuQ0exCIFn9DZqo3D1/S/p5as?=
 =?us-ascii?Q?fPMyGe6nsMbKV7j/Mt5FzHALMwvchRcAwogvDJl+bPu8PPmlx0TsgZZdf4ZL?=
 =?us-ascii?Q?nlvTSHQW7HahbrkLRCaTt2geGWAgkr/heZV6lCiUKU/n3nHKGyfW82KMA5Or?=
 =?us-ascii?Q?DJink095F85MMLnBgh7/J4CCvhP4G5YRRaHM9wrWCq4ECn2vRKqfmANSqfNN?=
 =?us-ascii?Q?CzhP3UlxL0jwkcqVC3GBK2RQpqvIOLo8NKV6BwIo7nCpEgdiE9YCLVjYzikS?=
 =?us-ascii?Q?+uKzZRyHfqc1g9jviKVOX/ERX3t819PpwPwkSvn3t2YKB/1ZGwzGygUh8YPr?=
 =?us-ascii?Q?2D2vi7WQJ+ote+jf+scTBWpjqEMwofMGdHYvzc1m1YIix0FSjWbi12AQd/AA?=
 =?us-ascii?Q?GgYxUvntsDogXbQipIXAEQW9eN8dQ6HIdM5NPQgfRMSQe7LcSlc3P/roi85W?=
 =?us-ascii?Q?j5FGSybmDmibtK0rNr7AsvzjvSfU4mNtf6WfhxlJ3IHEn84Ek5O3nWKmgC90?=
 =?us-ascii?Q?dKt3GBiu5nGMP9uiQlihubxq7gQtuUCDjflVmaGe/jKeHPLw+g0Sd+EVMOo3?=
 =?us-ascii?Q?KS+euYGVySNWN+m0iASZgxtjW/kcLIyQgVXMKEmyZgt5oAUfr+a4XEQM7teY?=
 =?us-ascii?Q?qvTHCh9+4nrfN6ViHITKTipgPYdq6ngOeaiQquRKfGQqMnbfoZpaGo/aIMHI?=
 =?us-ascii?Q?B59KPFh/Z0QITZ0vgxMQhs5kXrCU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DEwyvehx9DRMrwiGTONwAyG8MUvimr6e/i4EQx3cga3ozHNMF/19I61GZwZt?=
 =?us-ascii?Q?QeT1r3wodx0YI6YMeFxJCtkUaea9qESGmRKQ+NppwipJpwjNjbPTomOdzWrY?=
 =?us-ascii?Q?F2qV6qYzwlY+3Q2Kp+7yVkugvUF3TkBYSWOyjjpMKBaL8ofCRBrHpuodKRMm?=
 =?us-ascii?Q?Xi8h5TnKLVREra6+SJ6lFeefXxjVRk1WJHlbUL4Y3cX9t/lD6Hj0THrgG/9e?=
 =?us-ascii?Q?6YlA2MDtYhXdc+V5cFWYVwYEuvqjfqlwETX38u4b8jdNUx510t2TPafWjeaC?=
 =?us-ascii?Q?0K4H/vvRpfDQJAOIahHjuqqtu94Zdk2dfc87BRfBwQ5P4dfLeXywN4IqXljt?=
 =?us-ascii?Q?US4IBWa6rqSPlq9sLFYgcue/yDQA9gcJzu6e0X7kR7Jqoijyx1fr3zLk1neE?=
 =?us-ascii?Q?XvEXAauRAcHnyDdUuPZShMyE5JNw/b6tfUdQYGLhFa7ii15VjySnjQCE5ZDC?=
 =?us-ascii?Q?rPepcO+Tu1et2uxqSPeYuADdFABdvSr5Ua8hAOzhaTEj6CCqkZ5RAPzr83rs?=
 =?us-ascii?Q?snLmuV1BeD5AmeGFJGgsGVXfhp5df+dvi/IeKI1NLf90z3CLAaKQ6bsXhCzC?=
 =?us-ascii?Q?EwBAI0Dgjmndwa1+5f/OIIaIu/nEFuKH7NeLCHwaA9mPUOgHJmyBQ0BC2s40?=
 =?us-ascii?Q?7yz3zzMXXf/6O7wPJ1irQpR6pEtMM1Zha0mM/RR4+3euMcQTl7sqgPKCsjAg?=
 =?us-ascii?Q?DhTixlzjh3aJOXt++J7DJeygVqVvO2YzE4dIWaWTjXD1JXIROJDlXziceb81?=
 =?us-ascii?Q?lMvTKh3OtUKbMjVz+MNGRjhVpnlEm9fCxicSGOCSAU0qYuvU6DLjTybr33wB?=
 =?us-ascii?Q?JGSpi6IjMWr+M6BA+xrs1ufCJwbYliMuWxQHoWrIF2bOT7QLBzVAf//T2d7g?=
 =?us-ascii?Q?Z05DgBUYXsSA3EYn3iPXsim9mCFC6WHWCMGhspVgoyrn8xmGjQ3rFLnlF8JL?=
 =?us-ascii?Q?3rB3OY7zgXm7tREQIHIx2r1DyuKCBZTy6Yl2o52NpQtl3ybqECo2F+6N91be?=
 =?us-ascii?Q?cXqiCXjj6pco8eLzEP0bLlxjCL0CkoIenHGhoO9YqmD3buwJIYsnQHXxGMbU?=
 =?us-ascii?Q?xpFZxD/D6DVz0+cP+mPvcq9zBqmoPF11DiKkX336pKMbAPr8zWsXd6Wefb+j?=
 =?us-ascii?Q?Dz0wjQG4tH32y6n1jVK4jLxQO+NMeE5hLLZ1nZA3yewmDfsbpswJOrz52k5V?=
 =?us-ascii?Q?4nDH/dWXbmVgzBuHOmC8oJvMiGQF9sx+ItqIVq/2fc3IvHrIlBcqAJnjd6Py?=
 =?us-ascii?Q?sb82sZaoXVjqqrRGcxOX2hFUA6I/V7z0ePD6abVqxXkDNLkyPIJkdr8bVK0o?=
 =?us-ascii?Q?ARXhx377/y1KLhUfhTzSQK9kCs6KOeCcPBotIwF2rBmbbXbzbQj7DF3UtjCw?=
 =?us-ascii?Q?+asv+oBj3/5dXiGMmLWodDmb6Rsb6WFbwIoINaqvYr6QnlN1IpdLbfHHV6sQ?=
 =?us-ascii?Q?oeSET8omtDvcNdONYSt1f89Zp5C0V2WmmbGE9ATKdtPEkzALVlFDI2QE8Shq?=
 =?us-ascii?Q?bNikkCgjHFvBKWYrFnxMFKR2xcSY97yOmtFk/RURYynsiBpK0D4W7AfwvSWY?=
 =?us-ascii?Q?UQ7PsuE9zdvewg3bENGJSNl21LhRbwnSvUXkPwfo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 642c8123-2ee2-41df-0736-08dd210cd1e6
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 15:41:50.2421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TDW3/1kuHQjnJEL+qSrj1xgBVUmvIiXe00/J+IW/5LzVFqHFU2F4j/eMoTI9dpC6Y38Z5bbbRZKGoaLadhEeAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7149

Introduce a flag to restrict the selection of an idle CPU to a specific
NUMA node.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c      |  1 +
 kernel/sched/ext_idle.c | 11 +++++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 143938e935f1..da5c15bd3c56 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -773,6 +773,7 @@ enum scx_deq_flags {
 
 enum scx_pick_idle_cpu_flags {
 	SCX_PICK_IDLE_CORE	= 1LLU << 0,	/* pick a CPU whose SMT siblings are also idle */
+	SCX_PICK_IDLE_NODE	= 1LLU << 1,	/* pick a CPU in the same target NUMA node */
 };
 
 enum scx_kick_flags {
diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index 444f2a15f1d4..013deaa08f12 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -199,6 +199,12 @@ static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, int node, u64 f
 		cpu = pick_idle_cpu_from_node(cpus_allowed, n, flags);
 		if (cpu >= 0)
 			break;
+		/*
+		 * Check if the search is restricted to the same core or
+		 * the same node.
+		 */
+		if (flags & SCX_PICK_IDLE_NODE)
+			break;
 	}
 
 	return cpu;
@@ -495,7 +501,8 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 		 * Search for any fully idle core in the same LLC domain.
 		 */
 		if (llc_cpus) {
-			cpu = pick_idle_cpu_from_node(llc_cpus, node, SCX_PICK_IDLE_CORE);
+			cpu = scx_pick_idle_cpu(llc_cpus, node,
+						SCX_PICK_IDLE_CORE | SCX_PICK_IDLE_NODE);
 			if (cpu >= 0)
 				goto cpu_found;
 		}
@@ -533,7 +540,7 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 	 * Search for any idle CPU in the same LLC domain.
 	 */
 	if (llc_cpus) {
-		cpu = pick_idle_cpu_from_node(llc_cpus, node, 0);
+		cpu = scx_pick_idle_cpu(llc_cpus, node, SCX_PICK_IDLE_NODE);
 		if (cpu >= 0)
 			goto cpu_found;
 	}
-- 
2.47.1


