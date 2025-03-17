Return-Path: <bpf+bounces-54225-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F03A65BB0
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 18:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AF1D17CC16
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 17:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A591C5489;
	Mon, 17 Mar 2025 17:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eFhMl8qc"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761611B21B8;
	Mon, 17 Mar 2025 17:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742234277; cv=fail; b=iESXkXHFBpQu9hGW3lee7A4/VlR3lVZjiJ7lNY5SAB6t8Zh7cXpmt8qGYkgWgYfBGPLun80zMMcnNSNq2kQ1QuQ8fQckJf0JG8nmOqiiIF4Zbu7xx8KkOAjj7zGwnXic2J1ky+fgH5g4EZQfxnDqkdgQY+4sucNK77u3DWU/V4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742234277; c=relaxed/simple;
	bh=1xZ6NuSWEnrcGOl64typlA5iPb9lpll16ImyYgnWWUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ig6/uuOJk5zLYj6bdkWkPg71uZKCAB6GhRjHuxINSaJJ3SJNEEHotUcosDBwEk9dDnEwhU0dOn/7Dfq8yiE2J3bh2+nYq00DYmp9M1DcKaj/cmhK9DCUcAZGRACryl8XtVvBmAyXoT8YDa97ErOdDWS7jTQRhFtszKSSa/jcMDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eFhMl8qc; arc=fail smtp.client-ip=40.107.236.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vla0p5xnwDP9v6jPqoZDkcm3NXIZz+egvqNYNoCDxDXDWSKOIMRL08FJ2MW0Gjd9X+bgnUMB237k/7t6kwoRNhzxDP2w18JpC/52MBRafwXyRfl3MoMnkn+CRUIKgFgkXquCuA76RycJ1b+GV7LYXFyVSkYcUfZerpylpElsU7vy9hro3vpn6R0E/Q1vpgBulIeqXaK1UkxUxMRxaTx580MiAQcfBiIv4IeG3IQXCPQ+RH8CLOhtKpv233BUIBf3AbwGEDNfVBNEmeCARggwpAhhT0DN9421wDn1jdlUMDqjK6urR2xk/fURAgEXLBZwib0H7AOwqBSon0md+Ei2tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YIMO78KURZfbupH0XQxVsrLdbclyiSULczGSHEfJeaA=;
 b=l+chNOTVEnDTFsNZA8lzXeC8QJhXGlJqimuA1qsnPM43gkqcixgedHAHfER14iVFYjxsWQUmW6oWkgrjMSWWwgrIOr7DbY7Klzg/gL3tBlGsH9AO1E2qGa9D7roA1oKeaSafkK9SpChW4vEW2uXMPpQAgnbaBLNYTekZfNSzW24lYyj2y8s24PLLpNair38TPIxQ+gSEQ/aV+ORuSPavecisEPCsmBG1fPPrO0BCwJaBUhDXh21zZ2b966rB4wTvEbHlKgX1XBP0hwaIzCqEJs7HX7EgQfMi/QA90pgyDFwGEVBfRxwMESHr9zWn9WDmQHg/8sLWQP0tozlSYKiS2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YIMO78KURZfbupH0XQxVsrLdbclyiSULczGSHEfJeaA=;
 b=eFhMl8qc7mF1rbuaz9DIJK5/yvDHYtDCeUKmQNIWuETzalECb+9I5Sj9vcSy9p13jMFlTCe+Puf0/FnqPGMDoHmNhCRGaCQ5YgDo2RCbR16h1v5/VDa7tGPqkaDYzGm6CJxctjSiLTo4Ny0fhzuAwMk4knfmRfvyBHUPNzm/c9RuqV4iD0vui9wY1fY3PLAgcKICxmpsafrXv7aCBNV7uUIPqig613X6MwBg4nREObp4AtYN+fmxwnzxiRHPrcx/8oIJBIUgyC3HoeU80EVt9ln2OpCyzyfUeneYM/CyCYQ0I0lCJbTTGF2MLEmjBou4VCw30f+/tvF3o3P6QO1KwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by MW6PR12MB8708.namprd12.prod.outlook.com (2603:10b6:303:242::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 17:57:49 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 17:57:49 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] sched_ext: idle: Extend topology optimizations to all tasks
Date: Mon, 17 Mar 2025 18:53:24 +0100
Message-ID: <20250317175717.163267-2-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250317175717.163267-1-arighi@nvidia.com>
References: <20250317175717.163267-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR10CA0014.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dc::18) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|MW6PR12MB8708:EE_
X-MS-Office365-Filtering-Correlation-Id: 0692229a-a8f3-4b8c-370f-08dd657d3af3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?COl0ZoYcZJ7sp6Ngqet6CKcZ2G9Ser0P8jRoG6YyUZXvwxAe/oUgHnsveD8f?=
 =?us-ascii?Q?W2VAH/7Z+721N6XO6BKVyF8TELyD36SUNj42/Pske1XRBQ91JLQr8haVzWtR?=
 =?us-ascii?Q?n8KUJ7qcVzPsNz62N1x1uwiBS8oWxbwV5o5MrP51lsD2VONrPZoqNMx9j8Mc?=
 =?us-ascii?Q?wlX67s3JmobDD8sXo5BIomnMtVcAOAeLfjlCz2WqXkQv9uWKgja5IDwTi9on?=
 =?us-ascii?Q?GCjiPqVook/L6olfwEd5KVgGp3RXK8DseG+/DCGwB05tTzj4WxPGZg7fB+Go?=
 =?us-ascii?Q?2Ep4qfWi3XZ5rrAUx0ac+1LYgacN1UmK+FjGifZEp12G/D0AJiTsYtOcMElS?=
 =?us-ascii?Q?ahRkObYfa5hJYUScwpB0ke+OXPjPWr2MZBHTUtK4bfP9r8Vl1sk1w/q+6WW8?=
 =?us-ascii?Q?B8aQJNW8xHppLkL/4VOOQn+v6KYsMiH/MVN1r1xYq158mbAanADbbRMoLj0N?=
 =?us-ascii?Q?rXgssDo30P1AhjsRylSbOCsXYOqklmkvqOakQoGciKpEklIWc9VF309HGCoF?=
 =?us-ascii?Q?3KMCp7/tY+rtKb48/4kFeZWZM49W1Hcb0XWoExUubQOADjMOQkEEg03HLGIl?=
 =?us-ascii?Q?CInnClSK6xXm9cdShC837oHc2+KC+WfNimy2sDuiYlvA3YuPhhsgsMJ6DjXf?=
 =?us-ascii?Q?l4HMf6AZTrcEs1FzS0No5Z3DuPkiQRAnZLWB9BNTv3rxZReolhq2vOhVuFgu?=
 =?us-ascii?Q?SfDEcDwZE7M0M0YiTcrZ9aFBxMzezS7nmZkyEmcTzeNiKV8tAQsdqi+yyr9p?=
 =?us-ascii?Q?TiC/DAXgznqVxWXLz3ws/m6SrC29kFmChFWow5c9Jn5/rEB9FoyhF7FDLqr6?=
 =?us-ascii?Q?P3+/Lh9TPfMlAGc7DhCut8r6R/ISRmae1cTtdFd07Ao3MqHmCsyCXXmUpULu?=
 =?us-ascii?Q?f6a4z+mwqNXuypuRmM+RUa3cWgHbffB6N5PrtxhJNkbTNKPFF9P6+yUCpr1O?=
 =?us-ascii?Q?eYp42ERcrl2MhYCpoF8CW2uQEdq3qkMBpL8DUE1MzLN/EI2TstvLgM6XmO5S?=
 =?us-ascii?Q?b65xxlEPM3qgNhb0kdTZZA+SGZ1eLRKpQx6KrZ1QyAGzq0g574Tq8+Fpb/UB?=
 =?us-ascii?Q?0AMXs7ZarD7DzAoDpiuwbsfSB7t4MjaPQ3YmJFLk7toO8WZjKFL2aSIo0Krx?=
 =?us-ascii?Q?y3rzQ2hoaj3ldbEH5SToukpZW3jO/i565sPdt0YEFI4KLSMkQ7CAU8Ujk2p+?=
 =?us-ascii?Q?sPDsDEKph6u0Jyhf8JtkVpQLUXXOnvvxlaO3lc9X+p0NE5+ZunlTundaEOW9?=
 =?us-ascii?Q?QcuKlu3Xjt6CtdubAXoaMXoOP6k3/kZLj7LjJr7DOOKVG0+y8Ys17oi8ShrO?=
 =?us-ascii?Q?VTrYLphJJOL5b9CoPJkIH5RvB90IoK5A0YC3PTRUWZkZ0Rv0vpKaLhzeK/Wq?=
 =?us-ascii?Q?B2CJ4GU+OKxYgXJCX1JUUlGhD6pv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cJlRpInQPQ2PLSZ3HVIhZJcdmNXwv/EgvdmGAXu3iHMZozw4Alw08xyO/cUM?=
 =?us-ascii?Q?F0I3Os3IZ7VaX+TjdQMkyuptt+3pbGWoX7V+vKDbe/d4s8Glk6W5OItkSYQE?=
 =?us-ascii?Q?bAkuWyQB0yr4Pi9zbZfuGojLB6y05Ob/p6UZewZUlYZ8ak1N8l7eLXP15PqS?=
 =?us-ascii?Q?RPdQ1HGCK+W4UIOaJf3FwYX/d/7ERYlAT4bnsf8rSmFojoyj/YxMRRpsEppW?=
 =?us-ascii?Q?uLZxAArAOdpc9Kl5uB1HZMJDrFGZqTfYHES0E1s3MEBKtreaWtQ/hIevUN7U?=
 =?us-ascii?Q?1EUNeCqu8SNPTLUyq4qoZ3a3jVc95ZybRU6aJwuIZSlmu6PEp1+1l+mxqzll?=
 =?us-ascii?Q?4r1DmhdUkVynJFabjyCpKUeOztU+eddX89257DgwdZ4GGQ/OjOrJ4Vk4rBkR?=
 =?us-ascii?Q?m0I2CLrnoo3Se7Wd+qKUpg58tcN7DTwi+7dBVsVVVUhOGnkSrablY0W/bQRC?=
 =?us-ascii?Q?l9Dlx7Crs15eWx+2dy/dJY3ABo84gCrbXSl1Wdao1mR+MoKKJNdqdNYrJBnp?=
 =?us-ascii?Q?sR+WWD7B2KHquQHB+xFWqXgftb9QoLts+WKS3fPUvd+yiX7i/mf7+jO0CB6F?=
 =?us-ascii?Q?uVMMv6LHHqkufFcfNKwJwnd7kFqzyyWXMyw57ZjSyXfvua4FEPYpjdhKK66x?=
 =?us-ascii?Q?XjKusMmhhvoe0Je76t04pL1J5KS2SB41iJb3JprkQFlf6a1hrweSkJJzHTMN?=
 =?us-ascii?Q?qxMks35ONoHVf6YAQRa6BvwKd2bSFUqWwP8n8qo9F/V1PSrlhf0zpsq0RIhx?=
 =?us-ascii?Q?wyGkFQxnhBkocpVmNyk6kflAgMfre0eWnip1wO/HqUQPhX7zYlS2l0CCWbfQ?=
 =?us-ascii?Q?FheqTvoQCN1srfZSorjyq9BPxWnoUTiJ8VwMIjjlpfLu5/IOYJ/jtaITkCk5?=
 =?us-ascii?Q?0uwJAwo41i++tsXytsRLxElZuiXMjmZz8uEweADPQhtgznI6DXFepEvg7Djd?=
 =?us-ascii?Q?oMNZ+stohM9EyhcNZUuk5u1pTMPAnjJT1+w2AUH/d0vhqyqyZQIGyzsPi8Pl?=
 =?us-ascii?Q?gAkhjIqs9nHj5wDu98wa0D/3jfmisGfXFlCcPQNpvOlFKmIUQ7OUScIbjnm7?=
 =?us-ascii?Q?LKNXxJsfAaWgulrz9u+rHcmJjsPJ/Q92JDNTF+mj1thNlra2mh1c3hk05rPu?=
 =?us-ascii?Q?Djqbu3SkS5aFaKuDo7ebp7/MChxMWemR6YLlm9mR4yKSH4SmusPsYSwuhxds?=
 =?us-ascii?Q?WnaCD7vmtntXzkwEYs3lSEvaTRF72hVifbiMWAuO9fibgZlVdCuk/Z50e5C0?=
 =?us-ascii?Q?nl455pdJ5d+drqVZHKsv5mDQGpTZrw/UNo7ytPFzKoa3AxA7JT/ZkPR/VALg?=
 =?us-ascii?Q?tCVNK3e1phcolULuMzJLVbBjlmYC40U3gMtDkiXli38d52eE+AazJdyCWly3?=
 =?us-ascii?Q?NoiVPxiVxEfmCFlQdImPe1aUCUIDVV8ou6EzbMzvb/yy5nd4KLS5NIBRgb98?=
 =?us-ascii?Q?iEEQNCUYvkkDeiADjfR4H7B1M0deGATor3eOZvF0Gd0yYlnE+r5zUbbzQMJN?=
 =?us-ascii?Q?yY1KJ+yxE44qShYOmU5Eat1TAcSxNSb9G91HE9pOb6tAPrIMf+z9bKy7Fmtf?=
 =?us-ascii?Q?nJVZ8cmCP18GDLqk/qECf818lHWIqDEKsZqQZR6b?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0692229a-a8f3-4b8c-370f-08dd657d3af3
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 17:57:49.6101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yz78qIH8ZVG71YJymM62UnbIiOfSG5XaJE5MZzXiQjLLjWYC3uhmqHUrRyTUuvhaVXfgT9nPXSAqK7YPwNnDHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8708

The built-in idle selection policy, scx_select_cpu_dfl(), always
prioritizes picking idle CPUs within the same LLC or NUMA node, but
these optimizations are currently applied only when a task has no CPU
affinity constraints.

This is done primarily for efficiency, as it avoids the overhead of
updating a cpumask every time we need to select an idle CPU (which can
be costly in large SMP systems).

However, this approach limits the effectiveness of the built-in idle
policy and results in inconsistent behavior, as affinity-restricted
tasks don't benefit from topology-aware optimizations.

To address this, modify the policy to apply LLC and NUMA-aware
optimizations even when a task is constrained to a subset of CPUs.

We can still avoid updating the cpumasks by checking if the subset of
LLC and node CPUs are contained in the subset of allowed CPUs usable by
the task (which is true in most of the cases - for tasks that don't have
affinity constratints).

Moreover, use temporary local per-CPU cpumasks to determine the LLC and
node subsets, minimizing potential overhead even on large SMP systems.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext_idle.c | 78 ++++++++++++++++++++++++++++-------------
 1 file changed, 54 insertions(+), 24 deletions(-)

diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index 52c36a70a3d04..e1e020c27c07c 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -46,6 +46,12 @@ static struct scx_idle_cpus scx_idle_global_masks;
  */
 static struct scx_idle_cpus **scx_idle_node_masks;
 
+/*
+ * Local per-CPU cpumasks (used to generate temporary idle cpumasks).
+ */
+static DEFINE_PER_CPU(cpumask_var_t, local_llc_idle_cpumask);
+static DEFINE_PER_CPU(cpumask_var_t, local_numa_idle_cpumask);
+
 /*
  * Return the idle masks associated to a target @node.
  *
@@ -391,6 +397,30 @@ void scx_idle_update_selcpu_topology(struct sched_ext_ops *ops)
 		static_branch_disable_cpuslocked(&scx_selcpu_topo_numa);
 }
 
+/*
+ * Return the subset of @cpus that task @p can use or NULL if none of the
+ * CPUs in the @cpus cpumask can be used.
+ */
+static const struct cpumask *task_cpumask(const struct task_struct *p, const struct cpumask *cpus,
+					  struct cpumask *local_cpus)
+{
+	/*
+	 * If the task is allowed to run on all CPUs, simply use the
+	 * architecture's cpumask directly. Otherwise, compute the
+	 * intersection of the architecture's cpumask and the task's
+	 * allowed cpumask.
+	 */
+	if (!cpus || p->nr_cpus_allowed >= num_possible_cpus() ||
+	    cpumask_subset(cpus, p->cpus_ptr))
+		return cpus;
+
+	if (!cpumask_equal(cpus, p->cpus_ptr) &&
+	    cpumask_and(local_cpus, cpus, p->cpus_ptr))
+		return local_cpus;
+
+	return NULL;
+}
+
 /*
  * Built-in CPU idle selection policy:
  *
@@ -426,8 +456,7 @@ void scx_idle_update_selcpu_topology(struct sched_ext_ops *ops)
  */
 s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64 flags)
 {
-	const struct cpumask *llc_cpus = NULL;
-	const struct cpumask *numa_cpus = NULL;
+	const struct cpumask *llc_cpus = NULL, *numa_cpus = NULL;
 	int node = scx_cpu_node_if_enabled(prev_cpu);
 	s32 cpu;
 
@@ -437,23 +466,16 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64
 	rcu_read_lock();
 
 	/*
-	 * Determine the scheduling domain only if the task is allowed to run
-	 * on all CPUs.
-	 *
-	 * This is done primarily for efficiency, as it avoids the overhead of
-	 * updating a cpumask every time we need to select an idle CPU (which
-	 * can be costly in large SMP systems), but it also aligns logically:
-	 * if a task's scheduling domain is restricted by user-space (through
-	 * CPU affinity), the task will simply use the flat scheduling domain
-	 * defined by user-space.
+	 * Determine the subset of CPUs that the task can use in its
+	 * current LLC and node.
 	 */
-	if (p->nr_cpus_allowed >= num_possible_cpus()) {
-		if (static_branch_maybe(CONFIG_NUMA, &scx_selcpu_topo_numa))
-			numa_cpus = numa_span(prev_cpu);
+	if (static_branch_maybe(CONFIG_NUMA, &scx_selcpu_topo_numa))
+		numa_cpus = task_cpumask(p, numa_span(prev_cpu),
+					 this_cpu_cpumask_var_ptr(local_numa_idle_cpumask));
 
-		if (static_branch_maybe(CONFIG_SCHED_MC, &scx_selcpu_topo_llc))
-			llc_cpus = llc_span(prev_cpu);
-	}
+	if (static_branch_maybe(CONFIG_SCHED_MC, &scx_selcpu_topo_llc))
+		llc_cpus = task_cpumask(p, llc_span(prev_cpu),
+					this_cpu_cpumask_var_ptr(local_llc_idle_cpumask));
 
 	/*
 	 * If WAKE_SYNC, try to migrate the wakee to the waker's CPU.
@@ -598,7 +620,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64
  */
 void scx_idle_init_masks(void)
 {
-	int node;
+	int i;
 
 	/* Allocate global idle cpumasks */
 	BUG_ON(!alloc_cpumask_var(&scx_idle_global_masks.cpu, GFP_KERNEL));
@@ -609,13 +631,21 @@ void scx_idle_init_masks(void)
 				      sizeof(*scx_idle_node_masks), GFP_KERNEL);
 	BUG_ON(!scx_idle_node_masks);
 
-	for_each_node(node) {
-		scx_idle_node_masks[node] = kzalloc_node(sizeof(**scx_idle_node_masks),
-							 GFP_KERNEL, node);
-		BUG_ON(!scx_idle_node_masks[node]);
+	for_each_node(i) {
+		scx_idle_node_masks[i] = kzalloc_node(sizeof(**scx_idle_node_masks),
+							 GFP_KERNEL, i);
+		BUG_ON(!scx_idle_node_masks[i]);
+
+		BUG_ON(!alloc_cpumask_var_node(&scx_idle_node_masks[i]->cpu, GFP_KERNEL, i));
+		BUG_ON(!alloc_cpumask_var_node(&scx_idle_node_masks[i]->smt, GFP_KERNEL, i));
+	}
 
-		BUG_ON(!alloc_cpumask_var_node(&scx_idle_node_masks[node]->cpu, GFP_KERNEL, node));
-		BUG_ON(!alloc_cpumask_var_node(&scx_idle_node_masks[node]->smt, GFP_KERNEL, node));
+	/* Allocate local per-cpu idle cpumasks */
+	for_each_possible_cpu(i) {
+		BUG_ON(!alloc_cpumask_var_node(&per_cpu(local_llc_idle_cpumask, i),
+					       GFP_KERNEL, cpu_to_node(i)));
+		BUG_ON(!alloc_cpumask_var_node(&per_cpu(local_numa_idle_cpumask, i),
+					       GFP_KERNEL, cpu_to_node(i)));
 	}
 }
 
-- 
2.48.1


