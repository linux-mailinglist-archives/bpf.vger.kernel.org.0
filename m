Return-Path: <bpf+bounces-47432-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F29D69F95AD
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 16:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49A331886643
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 15:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A4221C9E5;
	Fri, 20 Dec 2024 15:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TZHzf1dc"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7926218E92;
	Fri, 20 Dec 2024 15:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734709311; cv=fail; b=EhImvicErvO9QBIFpFpu2nKcKFcnBlp7RZ9JrUeNDmoRiNlZPt/JsDbGSaul4feKKoGYqjdhBUH3z6Z6yZQv0c0wAiYBbFa7bX7GvN0DcHvo1p/K/xztj04rjCyCMk6egrML9AQX3Qs+J5FUZb6ntS6YdF2kWMiBy7lTPlGaNW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734709311; c=relaxed/simple;
	bh=uC3p7KjO0G+PjrBaLp7k9ZAEqqZbITu0MhvbymU9r/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cJz2HdHPD9KAbhkAxz0XmOt1h6+n3bl4mSwRE20K0WK4cTk5AI29pyhwLeu+dMrxellmFIMIKgG+W8P4NMC1kYUzPWACgWX78/NSFXl8RG3K55d7fgaEzYSWy6rmDCOrXgUUafoiw9jJvKVDfborxmblFZ4eGZ6fJ1gndVuJ9s4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TZHzf1dc; arc=fail smtp.client-ip=40.107.237.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QWxLcDPxNRLda/9lGIEImHzJscX8g4i239iwgIdzyLiEand9vWwxn7gr4Vx7Ue8VxAfRnRRWXkMYfcPW1pnzuB8qxegpThwXuxS2+bgNtod6aoGjb/QxNRUfQyHoGc5fO1dRlj8otPcmU3xN+tNFkacQgqNbnneF4pu+POD1vZGr6rh/m6VYkpqpzByBzsIiAXjh0gioGYBgrY5IGZIUpMIghXop4rbhuyVAOtyHb7EgHtyeSj/bvGqSmvOBRLjnSNd6Y5Mkg+bpmB45UrqVVFGzF00Kd4l7OBrTbucLUg2JOi8AQ03XzgLnLkJHh4Sup9fLg8uLLjNf/rnYZY2GtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ToXPRNuo+u60dYiobPFH7mXgY/Vc0hefTfWPMc6qNvo=;
 b=saRblrC18f8VP+hmv+fcP01xOQb2oOkpPyXbYjZJ7m68XXYseIGK7GOwvYuPljtHyPKPrQs2kpJOaVxGPY/GvoqJyJzyi4/N54qQ7O1tlAfx4AkAiOoumCvPqNUpnrYp3zVY7rxckwnQT1QpW3/Rm/j9YwUzZQa/OSRoWzBxMZEa956xLWS7W5x/9ogy5WtkU/QsBp4g+cf2f8MLkNONuIWCYaTIPblFVW7+fV/+OpGa1eNCoaNeLdLvgvUwqdLouyji4vfT4N25eXSu3Aca3U24piH7kknVrqLTaZqVzGuqWHm8NO3hJh2pFWkPPfXDCSa1MPLFgQhG/OYLkB44LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ToXPRNuo+u60dYiobPFH7mXgY/Vc0hefTfWPMc6qNvo=;
 b=TZHzf1dcrDgFNGm9qX37pZJCqL3a3SYQmbjWhGzfDxJunhkW0Y1iKwWa4knuEePcxcZKu6OlGLrvs7wMfSZb9NOX+5Dx1JOrbqJdMXQOVBM4hagW7GpWqtYl3Z333fMay4Ggk+qljoKLvswEQt7jO6nDiwLd6L4VDWcKdCNzhKMkHl2nXvczMkq4l801dJuXdY+KlcXDmPBQDZPkFyYDnFKXxz4qM+TMUWoR4IrSoh2Mhku//N2XqMOtkDiywDbGnK2eRJHVikAiijbqQROns2Mr1Rl1o3wL8vq6S/sUEqme3J0GLU+XaKNSe0stCOfV6GQZC61u5soh6uky+63DJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by SA1PR12MB7149.namprd12.prod.outlook.com (2603:10b6:806:29c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Fri, 20 Dec
 2024 15:41:46 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%3]) with mapi id 15.20.8272.005; Fri, 20 Dec 2024
 15:41:46 +0000
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
Subject: [PATCH 07/10] sched_ext: Introduce per-node idle cpumasks
Date: Fri, 20 Dec 2024 16:11:39 +0100
Message-ID: <20241220154107.287478-8-arighi@nvidia.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220154107.287478-1-arighi@nvidia.com>
References: <20241220154107.287478-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR5P281CA0052.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::11) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|SA1PR12MB7149:EE_
X-MS-Office365-Filtering-Correlation-Id: 2002e1fb-37cb-43ad-30eb-08dd210ccf42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kAnO1DlxyuGE5SdjbGc3L3PMy28uy6v32FO/TwmodIrbHnDrf81i+9Jt6qMg?=
 =?us-ascii?Q?wFVb1CYxjTCpsd3XNtXYRwjtXcLPF+cTYEPvNXrbplDVURTg9nvSExwvPtxz?=
 =?us-ascii?Q?ys+EegYRw21MR8onoHsBBwDBoAKHWkACL0v7kzTYbNFa0J5POkvSqWhO449+?=
 =?us-ascii?Q?6C+HfJMk5dz/3dMg8UG8dtKXDE0ln7/5SA4qz2h+ANuyTg8zkMko4o6tqJqr?=
 =?us-ascii?Q?ONQc7uadPqvHcFRtx1/lCBY+v8t4bU3yL5NztaPBLNuv6KVebJK+3R6ZbtF7?=
 =?us-ascii?Q?zUkcfSYz8CNoHROMZ3Uq5oXWJE6y7bk61iHsKReVMzSWzPrJEKRT4SRDy1+9?=
 =?us-ascii?Q?+cWvuuR1k6D0MVteVw2dd+PWAl/Ey9eW4mPcvpIWeuj+70732ZKVAp8zUclP?=
 =?us-ascii?Q?8SCNMRapr/URSvQ3asMTu7WmC5dj09XDdCgxaDEIdhE8Yx/KFDpdb69kyRyf?=
 =?us-ascii?Q?2RgZ0Poohulko1c0ipNAq9aAcY90gvdOXU5VXnG822x3dbYg2OPGGsgmRrGP?=
 =?us-ascii?Q?zNVP2p0bDUFw9+W+bJ2+bFznXLdZw+IwzY7qHj5zs6WXMMBxNhtKirTEe7g7?=
 =?us-ascii?Q?NPUj0xyWhui1xUzyTP/T/ZCRKpPNcogxCyGSkWBR+50gBQilO3Txub46eTWe?=
 =?us-ascii?Q?ntVAfM1/iD+iBXd9qQUZMmopY087b/OkDUBoUgsbtIKURIvaEAQmAjOPoYE7?=
 =?us-ascii?Q?z7dOtBCIoZ/wSiOdjjJNF4oNIO36vvnXliXgVzGoMU5Ek1ywTX1+n/CE2nlB?=
 =?us-ascii?Q?V2tVH74Z647wOuqAeAm2f/nRdR+WP6UNV8gT/4qAyO1c6yooI7+keon0Pf2s?=
 =?us-ascii?Q?//ITbRNt1Rq4Oa6kmrfAVISWR0nJ+GE45B/UEE/TO9KUUc6764aJyOj9aicW?=
 =?us-ascii?Q?T1rzN0tPLAWDeFyn45HMMJS8vJwiUHYxcttCh9sCgqzvhZm318Gpjo3zRKm/?=
 =?us-ascii?Q?8C9gJZhadWG2iJGSxUHBl4T5u7Qr72wABti49I+L447Tr5mZZko5tf+z5QcP?=
 =?us-ascii?Q?Y686FCsokNwlwocT5hbej23yIenCLOfNIBUZrYOE7Kdh8chMGpsEXtgSbvZB?=
 =?us-ascii?Q?n8qjHRcuXMhGao+YunWjPNEi3yZGgn1mtUq+GK/zG2hPPH3jNShHJTthaNEw?=
 =?us-ascii?Q?YeITxapVtLWAZ9Vq4ZbrIwX0Ii2RbEP6k/+0lBhn3uK0Rff/UEzK1qOYf0G/?=
 =?us-ascii?Q?Vic9hXSCUAzzKbeFzDNGIkFSR9vnSI20I05439tnWkPCI+Ts1S8+J6NQFgI8?=
 =?us-ascii?Q?HzKt1mTKen8K05aCckuy5czmeNq6A493GiKD9/CTdEiSsH2v7x7r4kRpNME1?=
 =?us-ascii?Q?2mx0kJFxngTOvLhZX1BGipt6e1gbrWMpjh8zy6IBvrwwGlWeNppyU2BseORF?=
 =?us-ascii?Q?eY7XbW8wjQWoJ8ShmdlZ9fG0xgoM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AV51/DYRACQQnVZjUTeWH+MzJhCQfy+gutdH8lgRH58Jp2Rr7Lx1pFtigYx3?=
 =?us-ascii?Q?V2hy5kZPAnXPIXrehmK1OOPUXXvO30m5I+zcVSzHKtWpVbA0iq8yBWsGJ9Mu?=
 =?us-ascii?Q?mVyRQjoNFALcEMhwMDKCA3hmuVLvBYgW+qNrJHPq0X50iDybEpAgFDRf+c2J?=
 =?us-ascii?Q?0dNlTLYm+z4XYlE9jzco0elENa4nT98cMBDGqCMsLdSapF2/PP46F3VQ8WNe?=
 =?us-ascii?Q?B2dfRQZdBL7IvdwlMJ4cuVlwO0iEW/SXHKcZ90FC2Wfl9B1aVcLSL7c66NQy?=
 =?us-ascii?Q?m3wwyWXXCdi8H0iCQzU0ijIHE8d2Klb2hZSag2zzqSThe2IwsWmCsR8mLe6a?=
 =?us-ascii?Q?T2dsNLhJBeXpJqVUDH1rjO0PSX9opP1LxufJJwXrsif1zglXsH1bWSZH/Ohz?=
 =?us-ascii?Q?Vsb5nHbvv4vGkkvUPl4mnzvTqJO6dTKX5ICbbdtWz8jfL1wa1CqmBRXPmjB7?=
 =?us-ascii?Q?e/U0CjL6AxMKyRbXyqqoNBVa0zFO67jbXzb1xk5Yz5s+dnhJrK1KTwMypmPx?=
 =?us-ascii?Q?v8tSwTXBwdWK73Vqm8Lcaw2Ix/405/fDFREq5lZFy0k5v+n/y9fA+wW8O8yV?=
 =?us-ascii?Q?Mkmw/YGI8KDBHLaJasef1D7aZseBKrYXSqOgMAf6mhoBZJNZTmBUGbLw5VLo?=
 =?us-ascii?Q?N9ZfD/2k5EjJIPVCNlN3jWcAOfSAfGDq83m9YjnCu8GUMZ2LyWWK6x7AHUo/?=
 =?us-ascii?Q?jkpj6zTtdH1yUw1LpYGYKGmQ9d5dIb2L5r/0M0Gq50QEQWCdvU+e7FAa96m+?=
 =?us-ascii?Q?GZQxYZPQ1x983ylpPnTZpgXBb0xFsSyWkbCDByjIwBNbhwM1Oiw8kYVhzXmj?=
 =?us-ascii?Q?/s8IiUon8xRdrsAVl/WyMBYFW5EdSXXAMUuYnFtPSR+83NrdGs8Qc/Ybhe8/?=
 =?us-ascii?Q?eoSr+JjxK+VQMfj9vXcN8UpC5550aiABK4oXHm2WujKUYWtQHt/Plc1WH2az?=
 =?us-ascii?Q?kIZgmyV01p2DjKz40OsKU3AQniVySs6KwhOR28JHEuZcPetjvH96s7EPY/D+?=
 =?us-ascii?Q?LHS2E2Q2+gGdyxYhVIi80uieLzsR7YQQB8rqC8H7ArxNlXUuA2hHKWgbWWN3?=
 =?us-ascii?Q?Ox4SF0dXE0khwvmk2ahRCNaMOMTg+iYKCMiF9dzhsdxv7aOhVJ/ZkMgnJco7?=
 =?us-ascii?Q?OAEu4qaxNHcQngCivXppPypq79zehB+XHFslTgbREz7Gcnf8QJE5lS1QzZiT?=
 =?us-ascii?Q?TlVGCCtVyOTpZQwfti49kmagUkq+mVfaIeE3iyFZ/BkbRanldBw/SLnBqJ5z?=
 =?us-ascii?Q?YghUDcULCWpvHPXkrXJe1sW0EpDFo1GT6GGXEn5MFrU7mfV1lEjAcnEWIkcK?=
 =?us-ascii?Q?LHmuk8+q43+bNIEcKbfPRH/c6ZZwiklqZS3PIiG0ntBbwmTf8uRpxBktI3bJ?=
 =?us-ascii?Q?9q8gVTOSeYE7EEO7ZdnYbo7Rldcca351g2DiH2/l4nXPTo3FmuVu4E3QlqWZ?=
 =?us-ascii?Q?HCDYoZAmbl1AfgvRKz5qWPPmPgTC4wpBAqEhVhEjg4wfHiinY5ADWF9RJH56?=
 =?us-ascii?Q?S6i6VjRl5AXy/3CAY2swNIM0f+TF9EQxp7cqDNJSYgZM5uil4w4ZiI2JJAKo?=
 =?us-ascii?Q?DXC7d1xzofiW/tRqic/m7tu7moEKWuSx4w6oLjQB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2002e1fb-37cb-43ad-30eb-08dd210ccf42
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 15:41:45.9398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 92xhQEEyi8KcAuvk8ncecCl6xw1q4D7OF3zGnZTXpo67O6oOT0+kD7yCK2raGTDrMxVPM2ApNukfnrF6kARpGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7149

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

NOTE: if a scheduler enables the per-node idle cpumasks (via
SCX_OPS_BUILTIN_IDLE_PER_NODE), scx_bpf_get_idle_cpu/smtmask() will
trigger an scx error, since there are no system-wide cpumasks.

By default (when SCX_OPS_BUILTIN_IDLE_PER_NODE is not enabled), only the
cpumask of node 0 is used as a single global flat CPU mask, maintaining
the previous behavior.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c      |   7 +-
 kernel/sched/ext_idle.c | 258 +++++++++++++++++++++++++++++++---------
 2 files changed, 208 insertions(+), 57 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 148ec04d4a0a..143938e935f1 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3228,7 +3228,7 @@ static void handle_hotplug(struct rq *rq, bool online)
 	atomic_long_inc(&scx_hotplug_seq);
 
 	if (scx_enabled())
-		update_selcpu_topology();
+		update_selcpu_topology(&scx_ops);
 
 	if (online && SCX_HAS_OP(cpu_online))
 		SCX_CALL_OP(SCX_KF_UNLOCKED, cpu_online, cpu);
@@ -5107,7 +5107,7 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 
 	check_hotplug_seq(ops);
 #ifdef CONFIG_SMP
-	update_selcpu_topology();
+	update_selcpu_topology(ops);
 #endif
 	cpus_read_unlock();
 
@@ -5800,8 +5800,7 @@ void __init init_sched_ext_class(void)
 
 	BUG_ON(rhashtable_init(&dsq_hash, &dsq_hash_params));
 #ifdef CONFIG_SMP
-	BUG_ON(!alloc_cpumask_var(&idle_masks.cpu, GFP_KERNEL));
-	BUG_ON(!alloc_cpumask_var(&idle_masks.smt, GFP_KERNEL));
+	idle_masks_init();
 #endif
 	scx_kick_cpus_pnt_seqs =
 		__alloc_percpu(sizeof(scx_kick_cpus_pnt_seqs[0]) * nr_cpu_ids,
diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index 4952e2793304..444f2a15f1d4 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -10,7 +10,14 @@
  * Copyright (c) 2024 Andrea Righi <arighi@nvidia.com>
  */
 
+/*
+ * If NUMA awareness is disabled consider only node 0 as a single global
+ * NUMA node.
+ */
+#define NUMA_FLAT_NODE	0
+
 static DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_enabled);
+static DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_per_node);
 
 static bool check_builtin_idle_enabled(void)
 {
@@ -22,22 +29,82 @@ static bool check_builtin_idle_enabled(void)
 }
 
 #ifdef CONFIG_SMP
-#ifdef CONFIG_CPUMASK_OFFSTACK
-#define CL_ALIGNED_IF_ONSTACK
-#else
-#define CL_ALIGNED_IF_ONSTACK __cacheline_aligned_in_smp
-#endif
-
-static struct {
+struct idle_cpumask {
 	cpumask_var_t cpu;
 	cpumask_var_t smt;
-} idle_masks CL_ALIGNED_IF_ONSTACK;
+};
+
+/*
+ * cpumasks to track idle CPUs within each NUMA node.
+ *
+ * If SCX_OPS_BUILTIN_IDLE_PER_NODE is not specified, a single flat cpumask
+ * from node 0 is used to track all idle CPUs system-wide.
+ */
+static struct idle_cpumask **scx_idle_masks;
+
+static struct idle_cpumask *get_idle_mask(int node)
+{
+	if (node == NUMA_NO_NODE)
+		node = numa_node_id();
+	else if (WARN_ON_ONCE(node < 0 || node >= nr_node_ids))
+		return NULL;
+	return scx_idle_masks[node];
+}
+
+static struct cpumask *get_idle_cpumask(int node)
+{
+	struct idle_cpumask *mask = get_idle_mask(node);
+
+	return mask ? mask->cpu : cpu_none_mask;
+}
+
+static struct cpumask *get_idle_smtmask(int node)
+{
+	struct idle_cpumask *mask = get_idle_mask(node);
+
+	return mask ? mask->smt : cpu_none_mask;
+}
+
+static void idle_masks_init(void)
+{
+	int node;
+
+	scx_idle_masks = kcalloc(num_possible_nodes(), sizeof(*scx_idle_masks), GFP_KERNEL);
+	BUG_ON(!scx_idle_masks);
+
+	for_each_node_state(node, N_POSSIBLE) {
+		scx_idle_masks[node] = kzalloc_node(sizeof(**scx_idle_masks), GFP_KERNEL, node);
+		BUG_ON(!scx_idle_masks[node]);
+
+		BUG_ON(!alloc_cpumask_var_node(&scx_idle_masks[node]->cpu, GFP_KERNEL, node));
+		BUG_ON(!alloc_cpumask_var_node(&scx_idle_masks[node]->smt, GFP_KERNEL, node));
+	}
+}
 
 static DEFINE_STATIC_KEY_FALSE(scx_selcpu_topo_llc);
 static DEFINE_STATIC_KEY_FALSE(scx_selcpu_topo_numa);
 
+/*
+ * Return the node id associated to a target idle CPU (used to determine
+ * the proper idle cpumask).
+ */
+static int idle_cpu_to_node(int cpu)
+{
+	int node;
+
+	if (static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node))
+		node = cpu_to_node(cpu);
+	else
+		node = NUMA_FLAT_NODE;
+
+	return node;
+}
+
 static bool test_and_clear_cpu_idle(int cpu)
 {
+	int node = idle_cpu_to_node(cpu);
+	struct cpumask *idle_cpus = get_idle_cpumask(node);
+
 #ifdef CONFIG_SCHED_SMT
 	/*
 	 * SMT mask should be cleared whether we can claim @cpu or not. The SMT
@@ -46,33 +113,37 @@ static bool test_and_clear_cpu_idle(int cpu)
 	 */
 	if (sched_smt_active()) {
 		const struct cpumask *smt = cpu_smt_mask(cpu);
+		struct cpumask *idle_smts = get_idle_smtmask(node);
 
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
+	return cpumask_test_and_clear_cpu(cpu, idle_cpus);
 }
 
-static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags)
+/*
+ * Pick an idle CPU in a specific NUMA node.
+ */
+static s32 pick_idle_cpu_from_node(const struct cpumask *cpus_allowed, int node, u64 flags)
 {
 	int cpu;
 
 retry:
 	if (sched_smt_active()) {
-		cpu = cpumask_any_and_distribute(idle_masks.smt, cpus_allowed);
+		cpu = cpumask_any_and_distribute(get_idle_smtmask(node), cpus_allowed);
 		if (cpu < nr_cpu_ids)
 			goto found;
 
@@ -80,15 +151,57 @@ static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags)
 			return -EBUSY;
 	}
 
-	cpu = cpumask_any_and_distribute(idle_masks.cpu, cpus_allowed);
+	cpu = cpumask_any_and_distribute(get_idle_cpumask(node), cpus_allowed);
 	if (cpu >= nr_cpu_ids)
 		return -EBUSY;
 
 found:
 	if (test_and_clear_cpu_idle(cpu))
 		return cpu;
-	else
-		goto retry;
+	goto retry;
+}
+
+/*
+ * Find the best idle CPU in the system, relative to @node.
+ *
+ * If @node is NUMA_NO_NODE, start from the current node.
+ */
+static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, int node, u64 flags)
+{
+	nodemask_t hop_nodes = NODE_MASK_NONE;
+	s32 cpu = -EBUSY;
+
+	if (!static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node))
+		return pick_idle_cpu_from_node(cpus_allowed, NUMA_FLAT_NODE, flags);
+
+	/*
+	 * If a NUMA node was not specified, start with the current one.
+	 */
+	if (node == NUMA_NO_NODE)
+		node = numa_node_id();
+
+	/*
+	 * Traverse all nodes in order of increasing distance, starting
+	 * from prev_cpu's node.
+	 *
+	 * This loop is O(N^2), with N being the amount of NUMA nodes,
+	 * which might be quite expensive in large NUMA systems. However,
+	 * this complexity comes into play only when a scheduler enables
+	 * SCX_OPS_BUILTIN_IDLE_PER_NODE and it's requesting an idle CPU
+	 * without specifying a target NUMA node, so it shouldn't be a
+	 * bottleneck is most cases.
+	 *
+	 * As a future optimization we may want to cache the list of hop
+	 * nodes in a per-node array, instead of actually traversing them
+	 * every time.
+	 */
+	for_each_numa_hop_node(n, node, hop_nodes, N_POSSIBLE) {
+		cpu = pick_idle_cpu_from_node(cpus_allowed, n, flags);
+		if (cpu >= 0)
+			break;
+	}
+
+	return cpu;
 }
 
 /*
@@ -208,7 +321,7 @@ static bool llc_numa_mismatch(void)
  * CPU belongs to a single LLC domain, and that each LLC domain is entirely
  * contained within a single NUMA node.
  */
-static void update_selcpu_topology(void)
+static void update_selcpu_topology(struct sched_ext_ops *ops)
 {
 	bool enable_llc = false, enable_numa = false;
 	unsigned int nr_cpus;
@@ -298,6 +411,7 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 {
 	const struct cpumask *llc_cpus = NULL;
 	const struct cpumask *numa_cpus = NULL;
+	int node = idle_cpu_to_node(prev_cpu);
 	s32 cpu;
 
 	*found = false;
@@ -355,9 +469,9 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 		 * piled up on it even if there is an idle core elsewhere on
 		 * the system.
 		 */
-		if (!cpumask_empty(idle_masks.cpu) &&
-		    !(current->flags & PF_EXITING) &&
-		    cpu_rq(cpu)->scx.local_dsq.nr == 0) {
+		if (!(current->flags & PF_EXITING) &&
+		    cpu_rq(cpu)->scx.local_dsq.nr == 0 &&
+		    !cpumask_empty(get_idle_cpumask(idle_cpu_to_node(cpu)))) {
 			if (cpumask_test_cpu(cpu, p->cpus_ptr))
 				goto cpu_found;
 		}
@@ -371,7 +485,7 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 		/*
 		 * Keep using @prev_cpu if it's part of a fully idle core.
 		 */
-		if (cpumask_test_cpu(prev_cpu, idle_masks.smt) &&
+		if (cpumask_test_cpu(prev_cpu, get_idle_smtmask(node)) &&
 		    test_and_clear_cpu_idle(prev_cpu)) {
 			cpu = prev_cpu;
 			goto cpu_found;
@@ -381,7 +495,7 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 		 * Search for any fully idle core in the same LLC domain.
 		 */
 		if (llc_cpus) {
-			cpu = scx_pick_idle_cpu(llc_cpus, SCX_PICK_IDLE_CORE);
+			cpu = pick_idle_cpu_from_node(llc_cpus, node, SCX_PICK_IDLE_CORE);
 			if (cpu >= 0)
 				goto cpu_found;
 		}
@@ -390,15 +504,19 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 		 * Search for any fully idle core in the same NUMA node.
 		 */
 		if (numa_cpus) {
-			cpu = scx_pick_idle_cpu(numa_cpus, SCX_PICK_IDLE_CORE);
+			cpu = scx_pick_idle_cpu(numa_cpus, node, SCX_PICK_IDLE_CORE);
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
@@ -415,7 +533,7 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 	 * Search for any idle CPU in the same LLC domain.
 	 */
 	if (llc_cpus) {
-		cpu = scx_pick_idle_cpu(llc_cpus, 0);
+		cpu = pick_idle_cpu_from_node(llc_cpus, node, 0);
 		if (cpu >= 0)
 			goto cpu_found;
 	}
@@ -424,7 +542,7 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 	 * Search for any idle CPU in the same NUMA node.
 	 */
 	if (numa_cpus) {
-		cpu = scx_pick_idle_cpu(numa_cpus, 0);
+		cpu = pick_idle_cpu_from_node(numa_cpus, node, 0);
 		if (cpu >= 0)
 			goto cpu_found;
 	}
@@ -432,7 +550,7 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 	/*
 	 * Search for any idle CPU usable by the task.
 	 */
-	cpu = scx_pick_idle_cpu(p->cpus_ptr, 0);
+	cpu = scx_pick_idle_cpu(p->cpus_ptr, node, 0);
 	if (cpu >= 0)
 		goto cpu_found;
 
@@ -448,17 +566,33 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 
 static void reset_idle_masks(void)
 {
+	int node;
+
+	if (!static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node)) {
+		cpumask_copy(get_idle_cpumask(NUMA_FLAT_NODE), cpu_online_mask);
+		cpumask_copy(get_idle_smtmask(NUMA_FLAT_NODE), cpu_online_mask);
+		return;
+	}
+
 	/*
 	 * Consider all online cpus idle. Should converge to the actual state
 	 * quickly.
 	 */
-	cpumask_copy(idle_masks.cpu, cpu_online_mask);
-	cpumask_copy(idle_masks.smt, cpu_online_mask);
+	for_each_node_state(node, N_POSSIBLE) {
+		const struct cpumask *node_mask = cpumask_of_node(node);
+		struct cpumask *idle_cpu = get_idle_cpumask(node);
+		struct cpumask *idle_smt = get_idle_smtmask(node);
+
+		cpumask_and(idle_cpu, cpu_online_mask, node_mask);
+		cpumask_copy(idle_smt, idle_cpu);
+	}
 }
 
 void __scx_update_idle(struct rq *rq, bool idle)
 {
 	int cpu = cpu_of(rq);
+	int node = idle_cpu_to_node(cpu);
+	struct cpumask *idle_cpu = get_idle_cpumask(node);
 
 	if (SCX_HAS_OP(update_idle) && !scx_rq_bypassing(rq)) {
 		SCX_CALL_OP(SCX_KF_REST, update_idle, cpu_of(rq), idle);
@@ -466,24 +600,25 @@ void __scx_update_idle(struct rq *rq, bool idle)
 			return;
 	}
 
-	assign_cpu(cpu, idle_masks.cpu, idle);
+	assign_cpu(cpu, idle_cpu, idle);
 
 #ifdef CONFIG_SCHED_SMT
 	if (sched_smt_active()) {
 		const struct cpumask *smt = cpu_smt_mask(cpu);
+		struct cpumask *idle_smt = get_idle_smtmask(node);
 
 		if (idle) {
 			/*
-			 * idle_masks.smt handling is racy but that's fine as
-			 * it's only for optimization and self-correcting.
+			 * idle_smt handling is racy but that's fine as it's
+			 * only for optimization and self-correcting.
 			 */
 			for_each_cpu(cpu, smt) {
-				if (!cpumask_test_cpu(cpu, idle_masks.cpu))
+				if (!cpumask_test_cpu(cpu, idle_cpu))
 					return;
 			}
-			cpumask_or(idle_masks.smt, idle_masks.smt, smt);
+			cpumask_or(idle_smt, idle_smt, smt);
 		} else {
-			cpumask_andnot(idle_masks.smt, idle_masks.smt, smt);
+			cpumask_andnot(idle_smt, idle_smt, smt);
 		}
 	}
 #endif
@@ -491,8 +626,23 @@ void __scx_update_idle(struct rq *rq, bool idle)
 
 #else	/* !CONFIG_SMP */
 
+static struct cpumask *get_idle_cpumask(int node)
+{
+	return cpu_none_mask;
+}
+
+static struct cpumask *get_idle_smtmask(int node)
+{
+	return cpu_none_mask;
+}
+
 static bool test_and_clear_cpu_idle(int cpu) { return false; }
-static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags) { return -EBUSY; }
+
+static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, int node, u64 flags)
+{
+	return -EBUSY;
+}
+
 static void reset_idle_masks(void) {}
 
 #endif	/* CONFIG_SMP */
@@ -546,11 +696,12 @@ __bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask(void)
 	if (!check_builtin_idle_enabled())
 		return cpu_none_mask;
 
-#ifdef CONFIG_SMP
-	return idle_masks.cpu;
-#else
-	return cpu_none_mask;
-#endif
+	if (static_branch_unlikely(&scx_builtin_idle_per_node)) {
+		scx_ops_error("SCX_OPS_BUILTIN_IDLE_PER_NODE enabled");
+		return cpu_none_mask;
+	}
+
+	return get_idle_cpumask(NUMA_FLAT_NODE);
 }
 
 /**
@@ -565,14 +716,15 @@ __bpf_kfunc const struct cpumask *scx_bpf_get_idle_smtmask(void)
 	if (!check_builtin_idle_enabled())
 		return cpu_none_mask;
 
-#ifdef CONFIG_SMP
+	if (static_branch_unlikely(&scx_builtin_idle_per_node)) {
+		scx_ops_error("SCX_OPS_BUILTIN_IDLE_PER_NODE enabled");
+		return cpu_none_mask;
+	}
+
 	if (sched_smt_active())
-		return idle_masks.smt;
+		return get_idle_smtmask(NUMA_FLAT_NODE);
 	else
-		return idle_masks.cpu;
-#else
-	return cpu_none_mask;
-#endif
+		return get_idle_cpumask(NUMA_FLAT_NODE);
 }
 
 /**
@@ -635,7 +787,7 @@ __bpf_kfunc s32 scx_bpf_pick_idle_cpu(const struct cpumask *cpus_allowed,
 	if (!check_builtin_idle_enabled())
 		return -EBUSY;
 
-	return scx_pick_idle_cpu(cpus_allowed, flags);
+	return scx_pick_idle_cpu(cpus_allowed, NUMA_NO_NODE, flags);
 }
 
 /**
@@ -658,7 +810,7 @@ __bpf_kfunc s32 scx_bpf_pick_any_cpu(const struct cpumask *cpus_allowed,
 	s32 cpu;
 
 	if (static_branch_likely(&scx_builtin_idle_enabled)) {
-		cpu = scx_pick_idle_cpu(cpus_allowed, flags);
+		cpu = scx_pick_idle_cpu(cpus_allowed, NUMA_NO_NODE, flags);
 		if (cpu >= 0)
 			return cpu;
 	}
-- 
2.47.1


