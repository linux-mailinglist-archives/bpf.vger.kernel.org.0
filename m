Return-Path: <bpf+bounces-54034-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC76FA60DCA
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 10:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A164172125
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 09:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41E71F236B;
	Fri, 14 Mar 2025 09:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hHCzZtae"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D06D1F3BAD;
	Fri, 14 Mar 2025 09:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741945752; cv=fail; b=tMRh+PoZ+yc7+s/fBcoivhptpNvlvYSa5qhxvkYuKmSyeiG8g4i1lFgIJILVf4iOJ7maQ2iRob33ivIr4hRpThHn2biscbJdsASv0qns53V0rLi2LrSIlex9gskZ2XahkUhWcKSzef5PH+WXdLnqqxf69QmpyL96I8dkb0b6CgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741945752; c=relaxed/simple;
	bh=elTVn+LGVLe4c4BDxDiA0RbqpurMmETKvQpXmXyYBQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=clZWNliH2GYeRacQtsgBjx3wFbLxQWiNxyIeoLrGYWi32xHJtLnEVsCxZ+l8+vRpi5VmjJCO20Z8qqG60VDv6u1xK8fPpAV5+ki+g1ZVVw59/RAR+O6ZphXtts3gGnEaAGFAo4Xw79/xtrIMOL9xfAAFk2iQoxuftt0RnE6Kx9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hHCzZtae; arc=fail smtp.client-ip=40.107.243.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h/KJPmrHhM3pFCarJQZr5OIxY2PVcXgJ2JxHQfHatvkprfd1PwT53YdFLd9fvw9j59r92f2IhUk/PQOCaA7LvnwCDIU06JXR/5EpFblDSZeOdWFUQSak17NrhQip09KMPMrXONZqrVSO3sm54i1vzHUrqLcqNln684NrLKYAcf2q2ueoTI/5hM9rX/pyayvxGgl2nTAUVt+Kn0PT4xOqtoGg5J6+57X3F/qXvOE/BstAafKV+vV7UtzEbkpBwjPUKIZLvrtURgkK/1UhkxEv+k47pz24/eOlcvEi5drL6TorHIBZrPo1gUhpQx/JmZuKrEnBb2W16PlFJgoAh1fwFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YPm/U4270S6e++2WO+Sw7SXsT8WrGZ1yMKmTeOvebvQ=;
 b=gaGbnpy/ss2oyIuvNss8IxSYB+Mku9DYUoquv2Inm6FIVeJ86TMqKSyZ6BAg3cHxvOYsej3ltbZn6AdcFHDXPAHnfYvERmXHW4mgHx+vJzz0EXQqrYckdPNDfKWcZ6OOlmtjfDbSeyMcomjAUbpNScwtdQBz4AaBp7YxD6cxpjRD+LRE+wS4Eqb4Xw2okouD/CoCULMsIm89VRQp7h+iCbDeVeby80yKzVnR1ETkL72uTgTIFmEZkpR3FMPTbkcsYz0uZngeVDAuLdBhvTRPh9tR9u3d7j/Ap1BRUB/lamoH0tpnyaZfIznpgOJwYBdQpr+S4nRwGE9W1RfOKLTSsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YPm/U4270S6e++2WO+Sw7SXsT8WrGZ1yMKmTeOvebvQ=;
 b=hHCzZtaeg9DgoNCPxaPXFb0xvu9Kx1RCJdbsPr4NwR16BnetMENNSXIvm0sJcjUXkLAEsRXxaoPDpeQ9rpoSl7UxY5WsrEaJD7fYfM4nvIjbfm1vNl0W/yLG8+jd/E3lQezR0mQLwKh3xSSNqXUKdhJDCpxH9ZPi0jP1U65+UJ76piXeAX48jW4y7s4GsjCZAjlNaeMI5+3xWvdqK11zagfYq86VxY3aH41zde9U/yZh54dRzsivj8gWY+8T5WLhsHVf1NqQyeOqXUnKQ6wGHPjbRpDLuCUpm6kh33UOCRST+Sa2oX5PaPHVml0vjUOwK7J5QHZr5SyGNNu1/u5Ijw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by CY5PR12MB6431.namprd12.prod.outlook.com (2603:10b6:930:39::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Fri, 14 Mar
 2025 09:49:08 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%5]) with mapi id 15.20.8511.031; Fri, 14 Mar 2025
 09:49:07 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] sched_ext: idle: Extend topology optimizations to all tasks
Date: Fri, 14 Mar 2025 10:45:35 +0100
Message-ID: <20250314094827.167563-4-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250314094827.167563-1-arighi@nvidia.com>
References: <20250314094827.167563-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0015.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::25) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|CY5PR12MB6431:EE_
X-MS-Office365-Filtering-Correlation-Id: 19d6974d-a277-469f-5b08-08dd62dd76d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JP3qVEQoz9h59JjnIAXrxTNdl0ZNWWsC0+o8Ihi00DgY+9GOxa7XWXzPxOge?=
 =?us-ascii?Q?6meUkob+Mi9DW+HcYFtkvETvtPRDSoYlLlc1uxzhHGJglDnucylp00X4+Q13?=
 =?us-ascii?Q?scXcBL+xefe7jGFtigmaZB8CwDulvk2zvuAsIX+vvL1ixC5NpaZWFYs5BtQI?=
 =?us-ascii?Q?gXnlUtDgDW8R5mssmjjwV8AHDICaIh7JOPchTcfB0QLzUS9O114BTWNPs5lN?=
 =?us-ascii?Q?th25cn57nCRfcbWz3XsFqRXmKTbjmT8aAanYBv9QGsarbTfXhOyr7rOMPF6K?=
 =?us-ascii?Q?EpRqO9WEUtn+Dhhjb5y3qxTrAH1jijLyOn1PqeTaVDygidcMUybRsRZ4HLsB?=
 =?us-ascii?Q?CxYkHH/J2IoWnbhHtV+sfNCFN+IxYHMG7aiBpLrXZ5aZzC0IpOy7SDWJSlsB?=
 =?us-ascii?Q?Mk94SfMDLHVG1q462Jhe2mxtcamvbiHECAyvrSyjnFm8yT0lxpaejAYASLpN?=
 =?us-ascii?Q?mXEc8cHvFUHGw/3kDWcRw2VqIkMP+zsEhD0BvPo7AE/cZtvvvR9Yuzp6rc6E?=
 =?us-ascii?Q?3CukIAmiZ74QQG2Gjh/qj8pJyo1l3/OJ5x6z/EETiqF1dj2cwNJ5NUmO59X1?=
 =?us-ascii?Q?oDJRBOAW1aIQcskJA3CebxlSUZk/2YY2Aae5XvUifr4czoM7vxbm5fGAzvrH?=
 =?us-ascii?Q?VTed/4btVdJrVfaRy4GuoAWGEPopxfBa4LsSOSpFzd+l4TtnwP3wWet0iMGU?=
 =?us-ascii?Q?ttWfmVAwAEJFUq6J7sN+ZdnlqEcPNNicRJuGbplZERjuYVIlVMyFTrSSBHCd?=
 =?us-ascii?Q?JlZ66zLxSWUH1ZZc4W1EvhPcFnPl7kweKdBi2rDGQD6MyyK/j+cWHpkXYuUZ?=
 =?us-ascii?Q?Yg70Y50SEq0EDpLAhI5LYuKBW5GDEU/36gR+I0srUwUSJKjUCT/mdgDNLf10?=
 =?us-ascii?Q?JMloMWH7p3OEpwXjUn3RO825jmzXbZ8M21LnQ1TaLXVDSGiNPuMoWTVnFtxj?=
 =?us-ascii?Q?or2OfBrz7jJdmqfP5vPnBv2q9+L93Rf8338vKIXno1bn3a5hDoftyZd9rSZ/?=
 =?us-ascii?Q?ciZknn6djgRXv/IDtqszJl7IHzsgWbbRFKJMa6+ftUpE8CwykmA1iuEdNZVB?=
 =?us-ascii?Q?jPWhsQsxTxbCs9QL6oXLEyBbOi1ZgKI+PIz6pkFZUzxZ0WwUVEGS0g+baGVj?=
 =?us-ascii?Q?uQoThC9aVk0wioeZZERnO6Lyv4vz6wfLVY1B6Q77OGuRszYukTICP8fTsetO?=
 =?us-ascii?Q?XKWrd96dEfuUrvwRKvNXL06MnjL8iYStXnV2MoAkLOS/iJWKFmx2xAX0R01E?=
 =?us-ascii?Q?EtYnXTRFQI5EoN9BvSWO8iP35lDwJrOGOjP/vZbe1W+CqLYbzqh+KGGqMwfW?=
 =?us-ascii?Q?VAUJK3MrGlkJY4pqNr58rEQ0mH6yuZ+pCvNcg5jDQN6WQ+kLUfcscj1hXKMB?=
 =?us-ascii?Q?t6U5/y9P7RvXoV/SDJig/qepTpS+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ULigGzKBW8Re2l2aoc1YgVnCZYx39ecZ1KIsZFOzWOcN2lgtGPkZF7lRxndr?=
 =?us-ascii?Q?qiPNTEkLfBZsTRfx3zra5PNLnljwmsua8IfihLI9ow76s99erpo6lOeGZeTZ?=
 =?us-ascii?Q?KRYppR0F+0W0carvgdTdDo1eV49PdEnkBk40iqML6VYYc5pEFBicB7ezbdtH?=
 =?us-ascii?Q?3m5lLE7TnFv1kcrYffbxCzewGiX0VmIbM2DgB4Jf/sj7C2xktlKOjKEtPyXJ?=
 =?us-ascii?Q?p50DjNeWZdV2Y9iMoS6z4aqEGPekhpC4TKSzK+2FjLlLWhsJQJOT4hmzGOwQ?=
 =?us-ascii?Q?757RREdCOXoHBXIAcHgFjb+r/pCIkLqr3QJjPnfk5bwRAnougI5CXvf/AGja?=
 =?us-ascii?Q?ghau1qU21WEG6srEgs4E5fx0wmerQpMQhXf8Pzy4Sviz0KUKqpkFtD91Ey0o?=
 =?us-ascii?Q?O1pnNQJCAiJikmsuzZIwIwV4UYCoe8DO86rXZifEIYNazm/9O9CxQsQZCRj7?=
 =?us-ascii?Q?lw+BeJUZgAqGuzM5n4IPHiKDmOhONlP1RmIotY0V5Ez0o72iGWoDghLPjPH/?=
 =?us-ascii?Q?ZLZ7O/9ymEyP573mH0tVTopxLYM2Deic1feEbKidEa9iyWAthgSuekDroNcx?=
 =?us-ascii?Q?zchuqt6FHGmUosfzoW1+b6Mr2y3z9NJIdzjC21rFR6/PoKDOQaE2BRXRj2zH?=
 =?us-ascii?Q?7CZSSO2CnxOUokOcyc0AB0eaoVGQH9SmJotxAwxdi2Y0nXy6QtHnYunVhQj5?=
 =?us-ascii?Q?NNOfmbS//1shFPtzjfHg2Tm2SKHbNWGaT5mX4L6RhGAcprDfZ0WPcRKdZxIN?=
 =?us-ascii?Q?ODp1IBSx4IG0iULubIXpkNjseJV5dIxPRJdPfYwxp+yvARsV81hloMbZQQNk?=
 =?us-ascii?Q?T46kIotlM9NgtahcyDVfS8gd92BXplduvxOLUe9sgVYJkfSeUm4MEHVksVD8?=
 =?us-ascii?Q?50a20yCLeuSnFVA7mbu1DUjCGP1Xyi4Y0bh/D7wR5msYnTuFKvy3XfWstz1K?=
 =?us-ascii?Q?Y9IyurHXsjbAsqtZ8MIGCsODmrVvzPGFBbRu4276MOzanJvCsVLRfYpLjsia?=
 =?us-ascii?Q?n/1s53lePZK6J0rk7vhnp3o7MVELaMx4pxNgVBBd7TAA5UbzYjcw4qUUUNVh?=
 =?us-ascii?Q?o0+3nZVj8FzicnjicWWODCDynltgIARginSwngnIn/gOpKPbpCXSW1zM+2RH?=
 =?us-ascii?Q?nZTqaTQR4jQB0is7/8J+RNgx0GwFCgGDDG7WuX558fsxOsQNs3NMcjc6EGG0?=
 =?us-ascii?Q?DPsDp1CPDV7AAQW67YoXOetBh4P3wHLZym97OleRUdz6HDB4qVuSupplJBoW?=
 =?us-ascii?Q?XLnWkL+Q3kma86e/TxZOT+HUeLaa/wCPWCCkV9FW4vyypOjQkAIJowjr7fSd?=
 =?us-ascii?Q?bwW7b42g0PwyTIuRvbBth5wMip8d4+186JwdcjxPz0uaZ0Ivc/ohB3I2Qx10?=
 =?us-ascii?Q?ZwvlzNjO0PQELL0PU8BbcF7rmN/YJ2JcWekzYUS+TYjVtSH8heRtlb4X6ro2?=
 =?us-ascii?Q?LJX5bwP9WbDyQUDbKSm89kHdXOYXLgrZhqXIaVVLkS9E3LAOc8DyesgpPB2A?=
 =?us-ascii?Q?wT+wAdDTuq9IeWUPg9T2NINQdmrlCFS263/J1pZ/4zFJPFraKcn2922TocJi?=
 =?us-ascii?Q?Qf3U6adqy9kX+dsS8v7aZkjfFxHeBNlpVb2H5Tp5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19d6974d-a277-469f-5b08-08dd62dd76d6
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 09:49:07.8335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DlvlXBdn/gxWhkF+5jDDEnA9fMKc8TJUOEWeqURR2s5hvM6InqAzlucAm4Rbi9VZEuXEBKs7uVohFePMiq5LRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6431

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
 kernel/sched/ext_idle.c | 73 +++++++++++++++++++++++++++--------------
 1 file changed, 49 insertions(+), 24 deletions(-)

diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index 52c36a70a3d04..1940baedde157 100644
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
@@ -426,8 +432,7 @@ void scx_idle_update_selcpu_topology(struct sched_ext_ops *ops)
  */
 s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64 flags)
 {
-	const struct cpumask *llc_cpus = NULL;
-	const struct cpumask *numa_cpus = NULL;
+	struct cpumask *llc_cpus = NULL, *numa_cpus = NULL;
 	int node = scx_cpu_node_if_enabled(prev_cpu);
 	s32 cpu;
 
@@ -437,22 +442,34 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64
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
-
-		if (static_branch_maybe(CONFIG_SCHED_MC, &scx_selcpu_topo_llc))
-			llc_cpus = llc_span(prev_cpu);
+	if (static_branch_maybe(CONFIG_NUMA, &scx_selcpu_topo_numa)) {
+		struct cpumask *cpus = numa_span(prev_cpu);
+
+		if (cpus && !cpumask_equal(cpus, p->cpus_ptr)) {
+			if (cpumask_subset(cpus, p->cpus_ptr)) {
+				numa_cpus = cpus;
+			} else {
+				numa_cpus = this_cpu_cpumask_var_ptr(local_numa_idle_cpumask);
+				if (!cpumask_and(numa_cpus, cpus, p->cpus_ptr))
+					numa_cpus = NULL;
+			}
+		}
+	}
+	if (static_branch_maybe(CONFIG_SCHED_MC, &scx_selcpu_topo_llc)) {
+		struct cpumask *cpus = llc_span(prev_cpu);
+
+		if (cpus && !cpumask_equal(cpus, p->cpus_ptr)) {
+			if (cpumask_subset(cpus, p->cpus_ptr)) {
+				llc_cpus = cpus;
+			} else {
+				llc_cpus = this_cpu_cpumask_var_ptr(local_llc_idle_cpumask);
+				if (!cpumask_and(llc_cpus, cpus, p->cpus_ptr))
+					llc_cpus = NULL;
+			}
+		}
 	}
 
 	/*
@@ -598,7 +615,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64
  */
 void scx_idle_init_masks(void)
 {
-	int node;
+	int i;
 
 	/* Allocate global idle cpumasks */
 	BUG_ON(!alloc_cpumask_var(&scx_idle_global_masks.cpu, GFP_KERNEL));
@@ -609,13 +626,21 @@ void scx_idle_init_masks(void)
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


