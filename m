Return-Path: <bpf+bounces-54227-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B9CA65BB9
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 18:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F1E23A8FA4
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 17:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839011DC9BE;
	Mon, 17 Mar 2025 17:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="l95qzlXg"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AF11D89FA;
	Mon, 17 Mar 2025 17:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742234291; cv=fail; b=DT2O8MFRlgFfiwzXbVVVARL/uAWXGjkG8NI5nAExrjV8irsMjUTsSAj03tIm/dYfOxYLDU4DCkcGzli0D7nQASKLT+qZ+LDT4NZWMpapiMZ4rAudTJxe7M03xPcf5iUAp0zda3XilSNHhzH0b3TXWLfKKL7S94SSUoV7HxXRsI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742234291; c=relaxed/simple;
	bh=rIZvUBSKZFeWuKtJbnQLGdpD0kPRGfPAmQkTx9ecXmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IC7hH6OUaI1rQBRgQm3NXYMI2eQZh2w859sWsPV2LAzBjUsNR3tCcin7/me/1p+CEmySoM+Z8WWxdlcTu3mTUOsPkm6BWqvis7E/Y3wE1j+nEzDoJ782/6VLJhhpBuu6I0NWwLqWH4XLLmXrqLqluKQbL3nBv6klhCshvEhU2+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=l95qzlXg; arc=fail smtp.client-ip=40.107.94.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h/yCXWaRl4IWyxsrUrhs395PbBUjLWCG7erD67I8qcHQXcLxx3H4eHrw+n4bsOqOvgcfS66QfSq93RJC1gUS05xCMTJmvAp3aFx+69DXMDOzoolW8fxPebBCNBFIngRvN/0HF7jETdS00/ykUCduwDA8rEuy2AI0BLD5hT5sAjYoWqMsM6bAgxddgnBwZShlOaQYbpvL0ioeasUQ/ax/ul/FcaeJs0xOwV7kli18kNRgZkE0vwX5yqjlc0naD7vxDqh34lo3KJq1a5bD5HmhKDRMvIaVEi+WAr+R/Xbn9NV+Uh6XuivEklbLhXYbbLRq8PNK/2j3bd1/hXBnwIRF2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lRpqPZHFG2SenqK4OWDqIXgCeNlwQYzKErq5TpYPak4=;
 b=O/4uaTWoVRsM0d8pEx6uW4eES+FNqyy8DIQeKWJ1YaLFSh33Yj8DztlbrBYE8UJmhVBlKmROUd0LrExokWI4NHPdknx78f9TLkjQypZcO5XFxWRjdxMnEAEU4UkrtiM/s0Hpfp4YoE/5l7cgHzPMdbe99i54yfjKHHNi8PQFQ45GKcKMPIaPPouFMknHeyfHkXezsuZk/YBQFwu800qqQw5ECMd74lXMJx0FJiDXys/+Q/rZfH2vpps0g1xWpEoajzrflmOkPvCCf+RDZMFNVjyRdhaPizUO4FprdjqqRNXYVweNFDSSefUIsHggwcMbQ2kGx+TvEd3WgZsFi0r4dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lRpqPZHFG2SenqK4OWDqIXgCeNlwQYzKErq5TpYPak4=;
 b=l95qzlXgvlEGUdiVjIxIldHMv37kgF0A49fgqlk4b6mXT/8A8aUSQonXSo2UVtBVJZohT0N23JZzFWTzqFGWyWz2eVeyDOZMjTmAJKSH8+bAe03YtujP57d9bpqKtsmX1u54Gh3xRQ5hhr5qoa3LxhD8Ca3rmSCxcCTrYhMg0FwznSaBY2uKY16n3RTD6GKuvmOsGIe/jLkxlJ1wjpyPL4Qx9HWGUG3ICs7jCzCNLJObmrZDr/MKYKJiYh5P4ZRiLYJVN4g4JtjjCBT+of4Li28/svfXysflzCruL0XghoDjDyzFo83ITE+Bu5lFbZiCnqNnpvSqFFDsxxXt1z1itg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by MW4PR12MB6826.namprd12.prod.outlook.com (2603:10b6:303:20c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Mon, 17 Mar
 2025 17:58:06 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 17:58:06 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] sched_ext: idle: Accept an arbitrary cpumask in scx_select_cpu_dfl()
Date: Mon, 17 Mar 2025 18:53:26 +0100
Message-ID: <20250317175717.163267-4-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250317175717.163267-1-arighi@nvidia.com>
References: <20250317175717.163267-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0168.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::11) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|MW4PR12MB6826:EE_
X-MS-Office365-Filtering-Correlation-Id: 6147f03a-ee6c-4d7b-3808-08dd657d4507
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fHAty/G6h8QPtgKP/811yqzSxb1HDQRtvXQj9s/Vq/7DIQfDnVUGWUGemuZA?=
 =?us-ascii?Q?9Z3kbSjMXSCS3of0c9fZ8xuNn6Vj2Bp+KAoVMPpIkm8cekWVNXL0aJBjGQhY?=
 =?us-ascii?Q?ma473n4Z4vR/R+h6b2AHqlqGUhCyFkSowkfTvf6aGaMEPWPM8fm9g1ImpXZm?=
 =?us-ascii?Q?20wFeHxttf3Hy4VGJWX3eZ4vNuGWFl40jEwatJSUGfHtQG+ELb/a1fOBdKWB?=
 =?us-ascii?Q?KhTsCdOpbVxp0mmRQkU7kN00e/HSAnvvMdooxH6u3ZDLuQK8MuNWMlBa7AQd?=
 =?us-ascii?Q?dGqvDcEH/aUumAGY/SlD2ss+27PE8GzUonQthfu4a/rIAuccTSsfXgDnHtNc?=
 =?us-ascii?Q?o+jL1whXS0/EfKSkt2+izW6G40XMtaJW0cNBqqH9e1+uNQTLGSl1o7ylfTFE?=
 =?us-ascii?Q?+0otGzWNFflgJuRop/ykwU2LuZlgBl8jtlB0H3yc8Glp9jmQA6AImbnyj6wc?=
 =?us-ascii?Q?AbYaeQr+GdBpbZtU7xaRloUpXceJ/R097tz6HViLbu0E/FTUk7EY36DHm9dE?=
 =?us-ascii?Q?lXZUyC7Jkm1wcHJONp3ibyFrOZ/0V2buPAgRnXMRJ/i1zolEx4znnehwo6zu?=
 =?us-ascii?Q?3D3fcAptZQ6LmNWZeei0GmyGqQrCPdUQagGG1C2xP/4thdSh7dmbG7TIiX3J?=
 =?us-ascii?Q?McFn3lMsfiQkxilS9yFtZCwxvHMry4F6kfubg/HdgKwAWNWDOWF0KtNOFeOl?=
 =?us-ascii?Q?swfTp5i1U0rsMX6S757LooMDe/RAZVjzrKVZu4phq2Z3LGUHGzs2s4FHtbXR?=
 =?us-ascii?Q?78rdgBWDllDe5RdttX7b2VqHaZcApgPWeVldtRMMmbOV6sLay98Z118BB4k7?=
 =?us-ascii?Q?nQM2FwccPJAt9JPMUTDSOdVV5cWaOGDoew88ZcplPrxJbYy8b5YndhyfBxe+?=
 =?us-ascii?Q?u6L3QffLC4m7gysDcxoq0JE17wBFEG3N5glzkZvCe2mIrJr0AdGUKLUl/JKm?=
 =?us-ascii?Q?CFFKjPJXAoDHkbRPrU5TCRR2r72zC6pNkBX2Vf76/W6nnmeOOluQyGD/1PaG?=
 =?us-ascii?Q?XKOdK9/QW2Oj5N4e2EuRREBIo2XoQqfTgqc/7HoQOhaAM5T0Uu/MFvcGa+55?=
 =?us-ascii?Q?4lETJ887Iep8X4TztpD6Y+YlLdDzJ5s4C5sEwvRN/2XVU7Z7SAnIPEfpxmO8?=
 =?us-ascii?Q?4k84APCEHCY+mtfwxQ4MsBZZc7vprjKbhTFH4PNVh7a+BmH0P7szhqHxY6Vx?=
 =?us-ascii?Q?f1rtvwSDMNfARnRWgPv6QY1JCfqSO9Ir5DK4KCSjkWo2qKsU12Zu4j33W6MR?=
 =?us-ascii?Q?kokIsIaHZFRLwJ6KqARFL/N1+maylamLtg/fMxSDKHkgqxZRvR/kSkU8XDNM?=
 =?us-ascii?Q?J5HFAWfXIRFCXhicVrk/kj49Zo1GToodLOxTjwIZjJ4oCOC+MA7JjnjImI0l?=
 =?us-ascii?Q?ySKXx/gLwCjpCv2tPTOV2fueNiAq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U89M5tDfE1NPhFx2zxBOM/Eda20+WQOAikiRgvnG5qTuwnLcOsuUd4OGv30J?=
 =?us-ascii?Q?YIWdR90/PZ8Z21Od5cyOhu6ufElbTkQJ5Sx4YhBKQWxmVwoYLuezPF3/qtZ1?=
 =?us-ascii?Q?+crvyj0pOrN42D8pS5XukYNDva4zssc11BotUV/npIicpfDrgBAZlrZQ1NIX?=
 =?us-ascii?Q?byC4rgu67or/ci1rHHW7YmMPRoZrApLLC0X7fHr5mf38/RZRLeFYd48kHacK?=
 =?us-ascii?Q?10PHNfxMBN9JHHcixYZUGq/QoSV4TZ3USEz5QwyMDr4Jnq354Gcr4qFI6uyG?=
 =?us-ascii?Q?+9cj5AwQ7rFa4bQ6/0iwJVgh/fzSk0NovFHEYX4RA5AY6+nMquVU3fjxVeW4?=
 =?us-ascii?Q?5KcHuh8U7KuUuv0NdiiFbf7ElszO5x61j5rI+L4paRSshRYWGxk4sSLOPS9i?=
 =?us-ascii?Q?xVBFVL9h0gxm1CIQYZ2K0M/MnlnjP5omJyjSp/isoEbc7HUkEojUs8rn+OIr?=
 =?us-ascii?Q?+PtKK5UBTt6Ui3yCSFm4KRKIBHoFfObTvgrL0HZPUA8NzXvwU9YF+vMhEz2t?=
 =?us-ascii?Q?HcmTaJJF4fy1bFdv/rVEwx7nxPoxOJwKWZs0HD6SKLI3J2M8kmRfQp/vpeyj?=
 =?us-ascii?Q?UNMBGcqcKx+Ji6GgASuUOQxDQj2ohfxZAJodaxPU2FBwJJIQmsS01iJMZve2?=
 =?us-ascii?Q?gGGaz96bzIZAHteX1oOvAleK6nNGZKRCSkytd5fOZk+0bxjShvNwo5tEAfqT?=
 =?us-ascii?Q?bq6LmClj+l4//sqQCZY08+C4Ek5eAkLE7KFTFYPHIxXmnTALqxCtHUvlVZWl?=
 =?us-ascii?Q?p0BWlMms1EKwpZADQbQxCHmt3Q4zra6I4rV23o0tfvg9Tz8U3WMVHtbLOAN6?=
 =?us-ascii?Q?ger4wres5AyrOPtwFW+LF+UkQeGUn8/pR5klYkaTQDZd2HfZG7qlgqesN9k6?=
 =?us-ascii?Q?DAjHYvkspy8xFUEjR/Q41pOcf3hqZhZFX/gVVjuh3WCtmtbe95tQm0CV/dgv?=
 =?us-ascii?Q?SAQP/o+eF5ZO21AuDlHnptqF8cSerYZ0PyQd6ou3TuFtv8+FhyIGt4UCvNTY?=
 =?us-ascii?Q?c2qMgn8OmpdLloZTvWS1Yz2r/oq0hjSXAE1xK769JexxhhQb5WSo3lccdq/h?=
 =?us-ascii?Q?mnVxWnrkU7v5T4AyB0gE/+VeJhtNzygQV3K+JshiCcgLiDNVtGgZiSCH/J4k?=
 =?us-ascii?Q?HIRkrC12OQUK23CC08Q43OAb3gA/GeEtdc+U++lTcIv+Gwi520O6zCqW07Vj?=
 =?us-ascii?Q?muTObFuAM2RbyyvX8D1aYeQFOvTDJWul7D0Hq25VFsMfnkgadWYjgR0MISNd?=
 =?us-ascii?Q?w3x0QjGznQ7+gthtCoe/1zWhFgl5P9cGIpIMcbcU2kalfLRE7sqoBb586/sy?=
 =?us-ascii?Q?vuMSyWD98V4GksTdtclRFcwEHF+YaEUX4a85iHXZo7CB4NCRu4HvjC6RVzi8?=
 =?us-ascii?Q?/lF+jUjjtcRp/X/eaHNNZKdXa2pCZ7oIZpy3gZ1EyzQ9EVifNd2yA/o5rQ8t?=
 =?us-ascii?Q?bn7Mz3etLGEKUnuREFQyOV9YUPtsu0aSBw7KfEXfpEuqh3TMT3bwTo4fhPOH?=
 =?us-ascii?Q?VnQvfh6ZK72Ghp1LnH395t7QOhVUTvY2SBldhtZqcsaYolp0e4DfAVTQl1SP?=
 =?us-ascii?Q?87RrWDyiXg0Uur16t6L7D2GKHE1O4IxbprJY7/Sx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6147f03a-ee6c-4d7b-3808-08dd657d4507
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 17:58:06.6083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vEaDVeOjYs4g+4LE7vAsd4Pbjx9K5CyVt7vts+isiHoNxkiYQh5BUyhEzA19qLeQuxQICT6le/36ABlVxzEmLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6826

Many scx schedulers implement their own hard or soft-affinity rules
to support topology characteristics, such as heterogeneous architectures
(e.g., big.LITTLE, P-cores/E-cores), or to categorize tasks based on
specific properties (e.g., running certain tasks only in a subset of
CPUs).

Currently, there is no mechanism that allows to use the built-in idle
CPU selection policy to an arbitrary subset of CPUs. As a result,
schedulers often implement their own idle CPU selection policies, which
are typically similar to one another, leading to a lot of code
duplication.

To address this, modify scx_select_cpu_dfl() to accept an arbitrary
cpumask, that can be used by the BPF schedulers to apply the existent
built-in idle CPU selection policy to a subset of allowed CPUs.

With this concept the idle CPU selection policy becomes the following:
 - always prioritize CPUs from fully idle SMT cores (if SMT is enabled),
 - select the same CPU if it's idle and in the allowed CPUs,
 - select an idle CPU within the same LLC, if the LLC cpumask is a
   subset of the allowed CPUs,
 - select an idle CPU within the same node, if the node cpumask is a
   subset of the allowed CPUs,
 - select an idle CPU within the allowed CPUs.

This functionality will be exposed through a dedicated kfunc in a
separate patch.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext_idle.c | 96 ++++++++++++++++++++++++++++++-----------
 1 file changed, 70 insertions(+), 26 deletions(-)

diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index a90d85bce1ccb..a9755434e88b7 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -49,6 +49,7 @@ static struct scx_idle_cpus **scx_idle_node_masks;
 /*
  * Local per-CPU cpumasks (used to generate temporary idle cpumasks).
  */
+static DEFINE_PER_CPU(cpumask_var_t, local_idle_cpumask);
 static DEFINE_PER_CPU(cpumask_var_t, local_llc_idle_cpumask);
 static DEFINE_PER_CPU(cpumask_var_t, local_numa_idle_cpumask);
 
@@ -397,15 +398,18 @@ void scx_idle_update_selcpu_topology(struct sched_ext_ops *ops)
 		static_branch_disable_cpuslocked(&scx_selcpu_topo_numa);
 }
 
-static inline bool task_allowed_all_cpus(const struct task_struct *p)
+/*
+ * Return true if @p can run on all possible CPUs, false otherwise.
+ */
+static inline bool task_affinity_all(const struct task_struct *p)
 {
 	return p->nr_cpus_allowed >= num_possible_cpus();
 }
 
 /*
  * Return the subset of @cpus that task @p can use, according to
- * @cpus_allowed, or NULL if none of the CPUs in the @cpus cpumask can be
- * used.
+ * @cpus_allowed, or NULL if none of the CPUs in the target cpumask @cpus
+ * can be used.
  */
 static const struct cpumask *task_cpumask(const struct task_struct *p,
 					  const struct cpumask *cpus_allowed,
@@ -414,14 +418,20 @@ static const struct cpumask *task_cpumask(const struct task_struct *p,
 {
 	/*
 	 * If the task is allowed to run on all CPUs, simply use the
-	 * architecture's cpumask directly. Otherwise, compute the
-	 * intersection of the architecture's cpumask and the task's
-	 * allowed cpumask.
+	 * target cpumask directly (@cpus). Otherwise, compute the
+	 * intersection of the target cpumask and the task's allowed
+	 * cpumask.
 	 */
-	if (!cpus || task_allowed_all_cpus(p) || cpumask_subset(cpus, cpus_allowed))
+	if (!cpus || ((cpus_allowed == p->cpus_ptr) && task_affinity_all(p)) ||
+	    cpumask_subset(cpus, cpus_allowed))
 		return cpus;
 
-	if (cpumask_and(local_cpus, cpus, cpus_allowed))
+	/*
+	 * Compute the intersection and return NULL if the result is empty
+	 * or if it perfectly overlaps with the subset of allowed CPUs.
+	 */
+	if (cpumask_and(local_cpus, cpus, cpus_allowed) &&
+	    !cpumask_equal(local_cpus, cpus_allowed))
 		return local_cpus;
 
 	return NULL;
@@ -439,13 +449,15 @@ static const struct cpumask *task_cpumask(const struct task_struct *p,
  *     branch prediction optimizations.
  *
  * 3. Pick a CPU within the same LLC (Last-Level Cache):
- *   - if the above conditions aren't met, pick a CPU that shares the same LLC
- *     to maintain cache locality.
+ *   - if the above conditions aren't met, pick a CPU that shares the same
+ *     LLC, if the LLC domain is a subset of @cpus_allowed, to maintain
+ *     cache locality.
  *
  * 4. Pick a CPU within the same NUMA node, if enabled:
- *   - choose a CPU from the same NUMA node to reduce memory access latency.
+ *   - choose a CPU from the same NUMA node, if the node cpumask is a
+ *     subset of @cpus_allowed, to reduce memory access latency.
  *
- * 5. Pick any idle CPU usable by the task.
+ * 5. Pick any idle CPU within the @cpus_allowed domain.
  *
  * Step 3 and 4 are performed only if the system has, respectively,
  * multiple LLCs / multiple NUMA nodes (see scx_selcpu_topo_llc and
@@ -464,9 +476,43 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
 		       const struct cpumask *cpus_allowed, u64 flags)
 {
 	const struct cpumask *llc_cpus = NULL, *numa_cpus = NULL;
-	int node = scx_cpu_node_if_enabled(prev_cpu);
+	const struct cpumask *allowed = p->cpus_ptr;
+	int node;
 	s32 cpu;
 
+	preempt_disable();
+
+	/*
+	 * Determine the subset of CPUs usable by @p within @cpus_allowed.
+	 */
+	if (cpus_allowed != p->cpus_ptr) {
+		struct cpumask *local_cpus = this_cpu_cpumask_var_ptr(local_idle_cpumask);
+
+		if (task_affinity_all(p) || cpumask_subset(cpus_allowed, p->cpus_ptr)) {
+			allowed = cpus_allowed;
+		} else if (cpumask_and(local_cpus, cpus_allowed, p->cpus_ptr)) {
+			allowed = local_cpus;
+		} else {
+			cpu = -EBUSY;
+			goto out_enable;
+		}
+	}
+
+	/*
+	 * If @prev_cpu is not in the allowed domain, try to assign a new
+	 * arbitrary CPU usable by the task in the allowed domain.
+	 */
+	if (!cpumask_test_cpu(prev_cpu, allowed)) {
+		cpu = cpumask_any_and_distribute(p->cpus_ptr, allowed);
+		if (cpu < nr_cpu_ids) {
+			prev_cpu = cpu;
+		} else {
+			cpu = -EBUSY;
+			goto out_enable;
+		}
+	}
+	node = scx_cpu_node_if_enabled(prev_cpu);
+
 	/*
 	 * This is necessary to protect llc_cpus.
 	 */
@@ -476,19 +522,13 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
 	 * Determine the subset of CPUs that the task can use in its
 	 * current LLC and node.
 	 */
-	if (static_branch_maybe(CONFIG_NUMA, &scx_selcpu_topo_numa)) {
-		numa_cpus = task_cpumask(p, cpus_allowed, numa_span(prev_cpu),
+	if (static_branch_maybe(CONFIG_NUMA, &scx_selcpu_topo_numa))
+		numa_cpus = task_cpumask(p, allowed, numa_span(prev_cpu),
 					 this_cpu_cpumask_var_ptr(local_numa_idle_cpumask));
-		if (cpumask_equal(numa_cpus, cpus_allowed))
-			numa_cpus = NULL;
-	}
 
-	if (static_branch_maybe(CONFIG_SCHED_MC, &scx_selcpu_topo_llc)) {
-		llc_cpus = task_cpumask(p, cpus_allowed, llc_span(prev_cpu),
+	if (static_branch_maybe(CONFIG_SCHED_MC, &scx_selcpu_topo_llc))
+		llc_cpus = task_cpumask(p, allowed, llc_span(prev_cpu),
 					this_cpu_cpumask_var_ptr(local_llc_idle_cpumask));
-		if (cpumask_equal(llc_cpus, cpus_allowed))
-			llc_cpus = NULL;
-	}
 
 	/*
 	 * If WAKE_SYNC, try to migrate the wakee to the waker's CPU.
@@ -525,7 +565,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
 		    cpu_rq(cpu)->scx.local_dsq.nr == 0 &&
 		    (!(flags & SCX_PICK_IDLE_IN_NODE) || (waker_node == node)) &&
 		    !cpumask_empty(idle_cpumask(waker_node)->cpu)) {
-			if (cpumask_test_cpu(cpu, cpus_allowed))
+			if (cpumask_test_cpu(cpu, allowed))
 				goto out_unlock;
 		}
 	}
@@ -570,7 +610,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
 		 * begin in prev_cpu's node and proceed to other nodes in
 		 * order of increasing distance.
 		 */
-		cpu = scx_pick_idle_cpu(cpus_allowed, node, flags | SCX_PICK_IDLE_CORE);
+		cpu = scx_pick_idle_cpu(allowed, node, flags | SCX_PICK_IDLE_CORE);
 		if (cpu >= 0)
 			goto out_unlock;
 
@@ -618,12 +658,14 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
 	 * in prev_cpu's node and proceed to other nodes in order of
 	 * increasing distance.
 	 */
-	cpu = scx_pick_idle_cpu(cpus_allowed, node, flags);
+	cpu = scx_pick_idle_cpu(allowed, node, flags);
 	if (cpu >= 0)
 		goto out_unlock;
 
 out_unlock:
 	rcu_read_unlock();
+out_enable:
+	preempt_enable();
 
 	return cpu;
 }
@@ -655,6 +697,8 @@ void scx_idle_init_masks(void)
 
 	/* Allocate local per-cpu idle cpumasks */
 	for_each_possible_cpu(i) {
+		BUG_ON(!alloc_cpumask_var_node(&per_cpu(local_idle_cpumask, i),
+					       GFP_KERNEL, cpu_to_node(i)));
 		BUG_ON(!alloc_cpumask_var_node(&per_cpu(local_llc_idle_cpumask, i),
 					       GFP_KERNEL, cpu_to_node(i)));
 		BUG_ON(!alloc_cpumask_var_node(&per_cpu(local_numa_idle_cpumask, i),
-- 
2.48.1


