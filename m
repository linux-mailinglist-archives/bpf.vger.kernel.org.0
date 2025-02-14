Return-Path: <bpf+bounces-51593-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E90A36654
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 20:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A53E43B13CD
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 19:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB341DCB0E;
	Fri, 14 Feb 2025 19:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="b1aPd2If"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161961DC98B;
	Fri, 14 Feb 2025 19:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739562136; cv=fail; b=ebHCP1/TWwUUvcD0qVZruqfWVwd9hnOamPhV3mQzNWqNX6tt8By5mwppZGDZyYQqkz1RpvgBbQ8W68aB4PeEG7YsQOZHITZFvNCv/H4bU4GWS1ZVoWzy+KuuBaAunKjDVrdJJHUruCDt1KtbZoPWbBRTqx+0Ngg9zTJUBN0VFKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739562136; c=relaxed/simple;
	bh=eyCBC3PTs9vH9iWT4ZEG18MQN/1V5kGQsOT/6Wnbe+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pQvSLxIimtbizL0VGzByvn2KSfxBpthN9hN/NXY4uRVjEjb6ntRyWr0o9LoddW2GhDWwA/qKGGLLH1j84ki8+mZJ0T+hGaKjMSa3S8XNfOLfMJ6tuvsbhUhuj7eWLaGgXdwCiVHG5dOoGTBEmXRviVtHeJ2l5n4cznIy0UTJo4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=b1aPd2If; arc=fail smtp.client-ip=40.107.93.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=od5FwhcbcqJofOvu3llkzXU7ofUCRYewQEqXmTJTYC1bsen5m7qG5TFsEgVsX/fGQs5kQ51ceWalZjN315AR4Ev5QROFOpBsMNDgQboVTM7HYXBs5SoeTOi9xWCEyDZQPZJg3CKCrkjejbUWKcW0ygQURoLzHOOa8F7g8tfTcxRieLOdk7WKkQDO23GUPISfkP8Tm36wx2OXD18TjDbOajc8wj5N+pO+WzCc8P7ih1fajh9YQXnAnNWHDbasvyLiP0t/EoEIYxI2LOAAndV5e7+1dyKR7dxMh/19GLanXhnAYPteNBtoQRN62B4sbXzMBTa9ElhPqCA4h7OcMHhTNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+hOZsbB52FscI8RKHYq3eciI39scM1aGcO/3NoWBeFk=;
 b=ph1l/P0sGU/MF7rytZ4FbgIVXdTaq4GF+/dZqd0oqs1FL4Aj0Q3L7THMN0qc+d9Psx3X7yXMjLG7Xa7fYYDT8DFOLjYmk95x+3+a+QnktbgLH3K+gikuE3WWLBXzd8G6RmC6s+tUTMSPPjN40NIAz4HuaySD8tTr+ZKmVmyb5makEa3SPARyohortqVDQl7avpJfuDHAt+W+Et9phRTh0DBympdw3w+xWZW5+ul/W1uEaMYNLdJTR2rFUqyyZJ6a4xjGtiweBPM+9ag0gN8ZzgMHewqtFhEs8lBLuygFkTWvJUpRKpNk+g50AHgVjsv8TwbAqbIlhEsJxbQHL9VDWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+hOZsbB52FscI8RKHYq3eciI39scM1aGcO/3NoWBeFk=;
 b=b1aPd2IfAxuPqFGbSz2EfOZpoyBznct9cQl5BN/3/PJ0ojz7u/GCCv6SXRYfcTmx7jbxFz4ECkTjVzTA74Iiom9+X0D1E3KrUW9gKTiURh3mlTC8+1RqEp6xqGxy6u+/UjkqqUvetbEQgn+pMmHbyP72ycCFrTWBS6u6XeAzXN+cZHID4zkbdop2mZZR7u85yiA1sdfxeEH/03tYffUdt/nV9yA5+8j5FHtDnM/VXuvv/J1jO8opmEnPZGA1UFZnZ7Ld/n862atPL+DDjibMMY0lLU3rw2JLF4hBloyd25XGmDkXsHZnB/2ZpFLDWFH8Bq/wHyq64Miw1CguEGDeYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by MN2PR12MB4360.namprd12.prod.outlook.com (2603:10b6:208:266::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Fri, 14 Feb
 2025 19:42:12 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8445.013; Fri, 14 Feb 2025
 19:42:12 +0000
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
Subject: [PATCH 6/8] sched_ext: idle: Introduce SCX_OPS_BUILTIN_IDLE_PER_NODE
Date: Fri, 14 Feb 2025 20:40:05 +0100
Message-ID: <20250214194134.658939-7-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250214194134.658939-1-arighi@nvidia.com>
References: <20250214194134.658939-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0137.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::17) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|MN2PR12MB4360:EE_
X-MS-Office365-Filtering-Correlation-Id: f7ed88ec-66e2-4413-9623-08dd4d2fad44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UbxhyQNku2oKmsJzXFOq2OoDY0skc3k1FUx3KoBnoHEKbjpE/AuN6/V6K7+n?=
 =?us-ascii?Q?rMyuiFlOuBE+So4SPZQL1PYXS/ENwUPMfPeIzz8eOoVhuDZUNYouWvmwV9zH?=
 =?us-ascii?Q?t8sqv265fGLDyw0jZ4HjzPEPNyTKylRsStOwb9YkfP4IB9E7wNwf7C/Wi6Sj?=
 =?us-ascii?Q?Bc7yQUCS9rTln1biNa64XggMM+vhbyYPCSQ5uyvao4cKaqQ35cyRWJVG2nFd?=
 =?us-ascii?Q?getoYVNuhAan2lvVaUH3NySyMBcAKWGsnH2mhMtPRwhwrhqzq/4FI8D+SDeI?=
 =?us-ascii?Q?PPhniQrd/YI+zEfS8jhG1IHOlv1rsInmIolItk6cti5b243BBV845aEOcPyP?=
 =?us-ascii?Q?aw/E3tIt4kLojO+c//YmSOqXifTHvFhbVM+LZZXLz5juE5QNS7N90OgoTtvz?=
 =?us-ascii?Q?7/p2RkrT7EhKx5Bw7jmCG00PvPs2nl/jOum2jhLGS5R9mE6wlxeN5T4hOGTz?=
 =?us-ascii?Q?E6+p7u3yczxhklc9rexC/9OhzAPRqm6bSaSpoLnDPyd/nnhcyvTTWFFzvxDQ?=
 =?us-ascii?Q?0WuSzZ/2rGTyVVQjEG0MfL6FEHTU1W7YT/rTepyVgu+NPPt+RwKsAD55c8iw?=
 =?us-ascii?Q?0f4JcVzJ3y0UuK3uIDV3zhUKn+2rGOh6Q0aUz9RWup/TNW33kh3OOV8IMmWf?=
 =?us-ascii?Q?yRhSEigfVAiYVAqPzcrKGItAY/wHGifeAoXCLIdPMNQUBW5G1wae9IDb1vYO?=
 =?us-ascii?Q?5dTMUfue+9OZOf7gI52wA4yGSPNnc75VC5l/7CrU1RTp/QOHF8Gl1tlM50id?=
 =?us-ascii?Q?9FLINA9TbwbtBCkSlaPy7u9nnCm/EDZMaOAnwAZx9OtYu6/abJ2S4TfghBfz?=
 =?us-ascii?Q?sLoK0DAvooyjdhapMXn073Wy1oPF0jxZ8CrJF3993eRcnGHm8XqDkyDtzB46?=
 =?us-ascii?Q?S8jEAbVA+3/33FBBlxlogEoaCOWA1NIZ479r4NjjUNR2mSXbnxG9sb8saGgJ?=
 =?us-ascii?Q?dbXAzsyAxHiOEoyZrACQ4PWLZloh6Gj6OLCVgjrzbRRY6Pd4BfctRdY1b6FQ?=
 =?us-ascii?Q?40Gwz6F9BY26h6XWzLKhSQVR7p7dgpA0iFOyrXexJiw81axLW5aGxW4RJNxX?=
 =?us-ascii?Q?UluZS2tMq35Jpcj0udszxHynytW220SZH/+L/T4Hli4CYmqa6l0W3Hi/CIHg?=
 =?us-ascii?Q?lZATLfu3YtpOLNEjNwkiuyaiDseZVpVlaxwkW+YfyYJb2WYQKRlXcs6ERBT5?=
 =?us-ascii?Q?wM2SRw+H9Vnjhr5beoQ3jyUeKOc5vN2hnXZQFMElBA8r26KgXa1p3GS24xAv?=
 =?us-ascii?Q?orz2I0oVeZPzpMqZ5D9o84oRS61IWSGNuzQ/NukOPaqi7sYYFxRCdGN3V7h9?=
 =?us-ascii?Q?j4ci8HYm+lE9CIKj2AkwN5R2QnMNOnEosYA9ktuyM+8jvydxvmwy1dpuNSSm?=
 =?us-ascii?Q?V9cPvoYU5+dcYXhBuHHzU04AMNVp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/1+FC4tQnRcBQMH6xc0kPMPtPXg4VqbDlzojI1yw5IV2puur6HkJPXEz2uUK?=
 =?us-ascii?Q?sD7C9PrMKSUFJIXg55pN5UNwCQ5R09t/x+BjxvaD745+BkMlgSK561lK4Fcw?=
 =?us-ascii?Q?yVoQMd5TZ5To9RGUsh1cwfI3rjq8TqCC4nPtLLLmEl/fWTFfPG/W3x9t75dD?=
 =?us-ascii?Q?Br1+8tFCEFuczEhkiHh67ARfRElb7SDZCFOXwICuBjhCG7mF1R3AbFW9nPlG?=
 =?us-ascii?Q?y8CLNUGyDWlhAnutu0HgEpskNLcdJm3BEURe6p/uW1vckFnzzX9jrS4+XUQR?=
 =?us-ascii?Q?7oskDqssNpiEBurOeTx4bu9yhsXu3Fd5bdfHZjCQbR+63cvpq/8KZKHhfG/4?=
 =?us-ascii?Q?lENZXJbzQNFo5HLA83FZ60UeV7AQ1MjTXQ0ObYFrWBVJtFoyltqe9TlfctWI?=
 =?us-ascii?Q?2MM0CmEhuiWGqfcuRKoDL66Ji/XxUT6qODyiADysY6b4sJWgdPtaa/ulW7oy?=
 =?us-ascii?Q?OwVjk3PtW5l4NLV6fZoPDzlJBh0fdbNfVtgSH+idVstNz4XWHnceSXoSPq4Z?=
 =?us-ascii?Q?XB3qlAAo/NYaWK3G0YPPnlXeyayPV8zjmIWwxLRSg7vQ6l5kX2B0DFN+zuDp?=
 =?us-ascii?Q?POEmo3n1f1G4eWDT5rxOoQnuzwMEtm9nkR4AyU3gkir4Uj0ZHyjbLlAo7FMI?=
 =?us-ascii?Q?Yefit+Y2/G2OQ7iU25fczA6boGfkfN/tTZQ+KBvXC09jQYPIFa0g72R5y64R?=
 =?us-ascii?Q?NlByJlb/XaK2E9Z8D+3fxDmMvs34ClgQ6ZgbK+vdv5cBz2A25QeFJskQeKP8?=
 =?us-ascii?Q?ZiOqLvDy9C4zrFztkTSILbqD0/p0z2vhvxPYwXTIkeTPASXL+W2IBD3yl5iV?=
 =?us-ascii?Q?0sMF+PezErdbkHeOPUl1jjkf8cMzE5Jv1dojhrkXlUeZ5FryJJNcRFsyYvyo?=
 =?us-ascii?Q?wbgQeTBha+AGw70xopy94iDVdQwktN7ZhnUWhC9DaypSyu8AsGrT29bUjfNU?=
 =?us-ascii?Q?0EWeV74SutfZts+HKbseP0GKeqgYl2F06P2ZJw00iS2jOCcXvkzxPoHeTZCF?=
 =?us-ascii?Q?+2OGCkybpjbPqhPCilALlbIZgYWWD7AqnK2NJmVcClpLnA9hc+Yilsty/ly9?=
 =?us-ascii?Q?5WN/74eYIBQHe8OxfZovW/S5Z1TviwoBZJEa72kEytIF3vaiO5nTJuR3nvGO?=
 =?us-ascii?Q?uvfi/tXp1gFzJXVtfPGGOE9xyDbIJ8nRFbKNw9Nr95oPu8Wj7rIFW3hs/z+b?=
 =?us-ascii?Q?SqrJVxfNSf9wVqTdJXsIjHsQJWdJRCixvV3zknBD4nmsO7VgFRSeq+ka4Z95?=
 =?us-ascii?Q?euL60Yp/WDyltZ3BBNWDJHlwbJnN58c/8axRh3sEaJFjVWrImPX14wgqkhEo?=
 =?us-ascii?Q?uZaWnM/FOvcO4GV00YLfy2Va0CUbZ4BuzVLZSQuWObzsoTEj+fhnx6Rnp4j6?=
 =?us-ascii?Q?+vwwHfyFWuTftLR88W+nTW8V7Qxnhxcqo1+YgnYcdlpmQ70mm9IMoBI++zRO?=
 =?us-ascii?Q?9nnqnQZwPIKQ8QoN6JK+KWWU3O5qLLdHqp4Tk0we5jhXd1aEzfzWhmsBUqzA?=
 =?us-ascii?Q?6bc1Y3JW6+tnoDd/0FaqLfGXExPV14cgbGXFJhd3cdSkhRMWoOo5ENifkVio?=
 =?us-ascii?Q?dGPIDtpoT1Jczs6MIA9r5/YaejufGmei2Hhlpzks?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7ed88ec-66e2-4413-9623-08dd4d2fad44
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 19:42:12.3067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bT5206bejQ5IacjOyKjajZz1Zdmugll37J59WjXhvBo3VxrILjtIDhRZhFcQ2QhH+26nvHbUs27YffcUV+2Dbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4360

Add the new scheduler flag SCX_OPS_BUILTIN_IDLE_PER_NODE, which allows
BPF schedulers to select between using a global flat idle cpumask or
multiple per-node cpumasks.

This only introduces the flag and the mechanism to enable/disable this
feature without affecting any scheduling behavior.

Cc: Yury Norov [NVIDIA] <yury.norov@gmail.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c                   | 21 ++++++++++++++++++--
 kernel/sched/ext_idle.c              | 29 +++++++++++++++++++++-------
 kernel/sched/ext_idle.h              |  4 ++--
 tools/sched_ext/include/scx/compat.h |  3 +++
 4 files changed, 46 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 7c17e05ed15b1..330a359d79301 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -154,6 +154,12 @@ enum scx_ops_flags {
 	 */
 	SCX_OPS_ALLOW_QUEUED_WAKEUP	= 1LLU << 5,
 
+	/*
+	 * If set, enable per-node idle cpumasks. If clear, use a single global
+	 * flat idle cpumask.
+	 */
+	SCX_OPS_BUILTIN_IDLE_PER_NODE	= 1LLU << 6,
+
 	/*
 	 * CPU cgroup support flags
 	 */
@@ -165,6 +171,7 @@ enum scx_ops_flags {
 				  SCX_OPS_ENQ_MIGRATION_DISABLED |
 				  SCX_OPS_ALLOW_QUEUED_WAKEUP |
 				  SCX_OPS_SWITCH_PARTIAL |
+				  SCX_OPS_BUILTIN_IDLE_PER_NODE |
 				  SCX_OPS_HAS_CGROUP_WEIGHT,
 };
 
@@ -3427,7 +3434,7 @@ static void handle_hotplug(struct rq *rq, bool online)
 	atomic_long_inc(&scx_hotplug_seq);
 
 	if (scx_enabled())
-		scx_idle_update_selcpu_topology();
+		scx_idle_update_selcpu_topology(&scx_ops);
 
 	if (online && SCX_HAS_OP(cpu_online))
 		SCX_CALL_OP(SCX_KF_UNLOCKED, cpu_online, cpu);
@@ -5228,6 +5235,16 @@ static int validate_ops(const struct sched_ext_ops *ops)
 		return -EINVAL;
 	}
 
+	/*
+	 * SCX_OPS_BUILTIN_IDLE_PER_NODE requires built-in CPU idle
+	 * selection policy to be enabled.
+	 */
+	if ((ops->flags & SCX_OPS_BUILTIN_IDLE_PER_NODE) &&
+	    (ops->update_idle && !(ops->flags & SCX_OPS_KEEP_BUILTIN_IDLE))) {
+		scx_ops_error("SCX_OPS_BUILTIN_IDLE_PER_NODE requires CPU idle selection enabled");
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
@@ -5352,7 +5369,7 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 			static_branch_enable_cpuslocked(&scx_has_op[i]);
 
 	check_hotplug_seq(ops);
-	scx_idle_update_selcpu_topology();
+	scx_idle_update_selcpu_topology(ops);
 
 	cpus_read_unlock();
 
diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index ed1804506585b..0912f94b95cdc 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -14,6 +14,9 @@
 /* Enable/disable built-in idle CPU selection policy */
 static DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_enabled);
 
+/* Enable/disable per-node idle cpumasks */
+static DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_per_node);
+
 #ifdef CONFIG_SMP
 #ifdef CONFIG_CPUMASK_OFFSTACK
 #define CL_ALIGNED_IF_ONSTACK
@@ -204,7 +207,7 @@ static bool llc_numa_mismatch(void)
  * CPU belongs to a single LLC domain, and that each LLC domain is entirely
  * contained within a single NUMA node.
  */
-void scx_idle_update_selcpu_topology(void)
+void scx_idle_update_selcpu_topology(struct sched_ext_ops *ops)
 {
 	bool enable_llc = false, enable_numa = false;
 	unsigned int nr_cpus;
@@ -237,13 +240,19 @@ void scx_idle_update_selcpu_topology(void)
 	 * If all CPUs belong to the same NUMA node and the same LLC domain,
 	 * enabling both NUMA and LLC optimizations is unnecessary, as checking
 	 * for an idle CPU in the same domain twice is redundant.
+	 *
+	 * If SCX_OPS_BUILTIN_IDLE_PER_NODE is enabled ignore the NUMA
+	 * optimization, as we would naturally select idle CPUs within
+	 * specific NUMA nodes querying the corresponding per-node cpumask.
 	 */
-	nr_cpus = numa_weight(cpu);
-	if (nr_cpus > 0) {
-		if (nr_cpus < num_online_cpus() && llc_numa_mismatch())
-			enable_numa = true;
-		pr_debug("sched_ext: NUMA=%*pb weight=%u\n",
-			 cpumask_pr_args(numa_span(cpu)), numa_weight(cpu));
+	if (!(ops->flags & SCX_OPS_BUILTIN_IDLE_PER_NODE)) {
+		nr_cpus = numa_weight(cpu);
+		if (nr_cpus > 0) {
+			if (nr_cpus < num_online_cpus() && llc_numa_mismatch())
+				enable_numa = true;
+			pr_debug("sched_ext: NUMA=%*pb weight=%u\n",
+				 cpumask_pr_args(numa_span(cpu)), nr_cpus);
+		}
 	}
 	rcu_read_unlock();
 
@@ -530,6 +539,11 @@ void scx_idle_enable(struct sched_ext_ops *ops)
 	}
 	static_branch_enable(&scx_builtin_idle_enabled);
 
+	if (ops->flags & SCX_OPS_BUILTIN_IDLE_PER_NODE)
+		static_branch_enable(&scx_builtin_idle_per_node);
+	else
+		static_branch_disable(&scx_builtin_idle_per_node);
+
 #ifdef CONFIG_SMP
 	/*
 	 * Consider all online cpus idle. Should converge to the actual state
@@ -543,6 +557,7 @@ void scx_idle_enable(struct sched_ext_ops *ops)
 void scx_idle_disable(void)
 {
 	static_branch_disable(&scx_builtin_idle_enabled);
+	static_branch_disable(&scx_builtin_idle_per_node);
 }
 
 /********************************************************************************
diff --git a/kernel/sched/ext_idle.h b/kernel/sched/ext_idle.h
index bbac0fd9a5ddd..339b6ec9c4cb7 100644
--- a/kernel/sched/ext_idle.h
+++ b/kernel/sched/ext_idle.h
@@ -13,12 +13,12 @@
 struct sched_ext_ops;
 
 #ifdef CONFIG_SMP
-void scx_idle_update_selcpu_topology(void);
+void scx_idle_update_selcpu_topology(struct sched_ext_ops *ops);
 void scx_idle_init_masks(void);
 bool scx_idle_test_and_clear_cpu(int cpu);
 s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags);
 #else /* !CONFIG_SMP */
-static inline void scx_idle_update_selcpu_topology(void) {}
+static inline void scx_idle_update_selcpu_topology(struct sched_ext_ops *ops) {}
 static inline void scx_idle_init_masks(void) {}
 static inline bool scx_idle_test_and_clear_cpu(int cpu) { return false; }
 static inline s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags)
diff --git a/tools/sched_ext/include/scx/compat.h b/tools/sched_ext/include/scx/compat.h
index b50280e2ba2ba..d63cf40be8eee 100644
--- a/tools/sched_ext/include/scx/compat.h
+++ b/tools/sched_ext/include/scx/compat.h
@@ -109,6 +109,9 @@ static inline bool __COMPAT_struct_has_field(const char *type, const char *field
 #define SCX_OPS_SWITCH_PARTIAL							\
 	__COMPAT_ENUM_OR_ZERO("scx_ops_flags", "SCX_OPS_SWITCH_PARTIAL")
 
+#define SCX_OPS_BUILTIN_IDLE_PER_NODE						\
+	__COMPAT_ENUM_OR_ZERO("scx_ops_flags", "SCX_OPS_BUILTIN_IDLE_PER_NODE")
+
 static inline long scx_hotplug_seq(void)
 {
 	int fd;
-- 
2.48.1


