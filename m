Return-Path: <bpf+bounces-47430-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8F89F95A5
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 16:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF5AD16F85C
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 15:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E43421B1BC;
	Fri, 20 Dec 2024 15:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GQnNt9uD"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E28C21A953;
	Fri, 20 Dec 2024 15:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734709301; cv=fail; b=umJdk/x+mcCuz7vWiFuD6IrUkfhb8lnfV/zrr8v5eRK/32rL4Bp4iXOovTDMM4NG25C3Uby/agXuTjtbwDZBwDjajCnu4YvCuetpt+HCFFrCeId7VMC+ANALD0SG9hUfIHfvW7XubFMIrU2FxHsLanqFAyeJ/1Rmo8YvxIFPVSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734709301; c=relaxed/simple;
	bh=+yzNxU5hWGYrNTloY1OLbYTTzkPrAhIlK6icyAUQFzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hq60LI605ML/OpImMj/MHB9ua0El0jZ08BGTLbdBvjttAHsRoBxWmxNVslgbCIc24mh8iOPvv2hP3nvQ5HyhC4hfuNzH+8L0WdvDbSjKJsSna4BQUbfHeMxKtqnhHotWKkC1io4t+HplziQJ0CNUJIb+PePgf80qlFAVEvvjA7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GQnNt9uD; arc=fail smtp.client-ip=40.107.244.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MplauQk9AHfmr9AcegfAuI18PXCmj/a/kFq/jMvXu3lOwKlAUlDVGabnwI3I9QW1NvaNf0geG8VwweoeRIZAWA2KhKb2jbFpZ+KTU05e7PHtyVG3ZXS4XzjCEiWkQCIMEVVBOkKJuvEQvmz4JhImddfugey6AhuBKsI1nJRAakINBCJ5J7bdof3VUMdcEtGC0bv1ws5zIFLfmfMSkU4R4ZhBXsURnw9kqvK0urzkj16temHMq6Pf+kKUNUf71HeHP7d/C7yJeKyvtH7i9Mjjeqhnnfz7aIXNn8Q2axZ43oaGzwCXpWqZmvwPqDE2h0oVuMLam6v5KNE7PNhLNMhK/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YUw3coJ170tiKppqaO3qmAbuKUSzWHNxy7WYwCgYkPM=;
 b=rU0sJ1Ml5pCCJIZz7UTGs1a3w7gvztKTyHR/24NVbN5OcNJEivyU8Ed4ZHuXXo0HwLT+3IrKLVhEzdXXp9V28ShabbAG+mqj+y8mE1iMc82LIUspc/XBRIqcuard0bPYbxuZtyT4WhuugQaJLb8d2kIqKsdfuYARicHfezPXqVNxZGQx22iG6oNmFl84qiW2IGNgrY3xNE7t4RhSyAKDPlXi2Fp5nECIzzT15X75wEifaSEFTdCYQZ1hJJs8rDUZOGnO/g5YLwgfGa0e2ADrUt4V1D6Qnn1TjCSdGUYSsgomBeTz9q4Jks9yFTH7GbAZ05gCPsGrXXZ5Z51eYIv7zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YUw3coJ170tiKppqaO3qmAbuKUSzWHNxy7WYwCgYkPM=;
 b=GQnNt9uDZPqCmF6V6xA5JECe0PyQcyclzdRFUN+yQ4pgyEsmwhYI0TfLoTciNCMwdJ68DQ8Q8wsngJ0IODp63EDhhq+btmXqWCeziOTSOFyunXysv28ZkzLtUgkeQiEhpTn10KBw2iTcrMsKHmv7d3Z6EicxgVKsMWeQ4nD8/edErgdq6xk5ePVw/lahOQTDvN4edPqV+b2VpsLUoSH0c8aOwsn9lSwMUdiBopQZYZmgfX6dsPeV2AJxGqzbN3vWSHe7w1w/vuScDqq2WLHWyvwUgKNyphe7lzEIufc2pf6ZOniUt7pvcJryIQzy8fkQDCz9/XlcJ8aK1Duu6KTIAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by SA1PR12MB7149.namprd12.prod.outlook.com (2603:10b6:806:29c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Fri, 20 Dec
 2024 15:41:37 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%3]) with mapi id 15.20.8272.005; Fri, 20 Dec 2024
 15:41:37 +0000
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
Subject: [PATCH 05/10] sched_ext: idle: clarify comments
Date: Fri, 20 Dec 2024 16:11:37 +0100
Message-ID: <20241220154107.287478-6-arighi@nvidia.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220154107.287478-1-arighi@nvidia.com>
References: <20241220154107.287478-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0103.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::19) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|SA1PR12MB7149:EE_
X-MS-Office365-Filtering-Correlation-Id: 0edb63ec-53e4-4638-2157-08dd210cca40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6RFiVLLnUrE87pyAC4lsncXVXVx4RuKuazTnj4FEU0F+9VWpHPhAXXh7iTz/?=
 =?us-ascii?Q?h21tuYFSq9U0fcvHt0XmMp/Nri4TGkzhJaFMQDKhCfyBMKcn5WpwE5ZUmnq5?=
 =?us-ascii?Q?gVvR/3UYqIq1FbCZRWE8Xv4AwYei7NNVm43Uzn0qVgbRk5tL/SVofT9zSPOC?=
 =?us-ascii?Q?XdZ22tiXZ46Efs6JeV/tpLpA60WrwmC6DBH6fWJB+antTPSQ4BTAZEHU0KXo?=
 =?us-ascii?Q?CcCuUY5rzP8qF+PHwPmznjEfTrrqgNkDmRzu1aXiAHhmizeibIGAD6f+z8tO?=
 =?us-ascii?Q?qUOOK03fYugHcVt5CQ6ZX5g2Ur75cU2oM3fC9FUM6wTSonlZkgvCvAU4e9iR?=
 =?us-ascii?Q?/fA5txHfciDwrKRCk/BCj9CPdMicBEBaYnYnSl1F3myRfNi5tVl65Cailhss?=
 =?us-ascii?Q?SMD7hoK0+v8WtSwUnGErCSK+5rmF2vlkV7+FTMv5X5PXc615ZRfWBfYw4XMY?=
 =?us-ascii?Q?3oPA/In2/rEfSoRraeIyZ2YS5XkULjqCL1M7hGSf6aGmylvsWvjJBoBWX0MN?=
 =?us-ascii?Q?vENpUg7jE6vM1uaCeLxnk/shntp5MHyUmvBgN0uKaZofDk35lUrKCZ6VhdQw?=
 =?us-ascii?Q?gT0psN9J/QxU7nk2gkU7FQkXVkU+ZEpVBBpi4ognGi1d3qUyA1/89DHFS7WJ?=
 =?us-ascii?Q?TZAn8bagQbcufvxWIjK40yR8mXzrKlzephvf0tUtHxRvqvS5M5COJm+GtGZ0?=
 =?us-ascii?Q?d61v5HaGjVQGFyRVChRsxzceVitW4bt/o3i0f3jt9VXsvwMY5o+6e7F/wDUn?=
 =?us-ascii?Q?m/VWQI5XWKM4HSSCKH5RkkXOPYKtkHnNAbtMiVEWZsW3Es0t6vVZjOv8yfT+?=
 =?us-ascii?Q?CEkU/KdPffd68wQzPW9pZmZqUY3PEuqftQXXsLnVL2rxQ2T8cYLhNjRxGItO?=
 =?us-ascii?Q?CNh8xcnyjCJ3FpNKijrFhIUZW+rcijV7AYN0rIwUY0SjYaIE0jFkSwOhn4sA?=
 =?us-ascii?Q?u81M7SwNjaPYScZ0PvRXSwjYjBctleO2XHSmoU4BPLofnslacimP11J0bpXt?=
 =?us-ascii?Q?KfPmdopVIhpw51sGTVi1KVh8Ii6ZzqiHThV1l/NsH7AEg2Ceb1S4yMojGYpX?=
 =?us-ascii?Q?UX2juNpazZZCywRLge6X3tVTnkyWxF1V45QhIn/Ty64cP4AjbTnzNDhQvrbu?=
 =?us-ascii?Q?vMdd/IFSA8t77BwC4G0wEuW4xQxTDthrG1ics6AWR9Xi1WPs6dXNXqYjtmS6?=
 =?us-ascii?Q?8y10e6obXCBKoD6shchuQsnrKDyqikqKAQ5HTMK7S5tmrArxExwPBE9Elqv1?=
 =?us-ascii?Q?SBnBSLeHO5/8eQVFFaDpgawEFNyjRBSNXR2J1FQZDViQ8dwYtxxoRGngZ4H6?=
 =?us-ascii?Q?1B5APwjEDjCy4ZHN00HeB3Qx0NINj/bymg2XGPfKBUme5/mT2/xpnFl+ZjZv?=
 =?us-ascii?Q?N6b+WLpMaDv0b6K39RdXBEA2fgiU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wc3d0dUEwRTyydz0Ttpz2wVZ//TGSCmoqZR5WqSLwTpSHUAJiAneNWHsTxoI?=
 =?us-ascii?Q?afmh6Y4u5Bdpp2RO81jSPs3k8if5yUf7YpgWaO9Q1IDZTnlMKM62cvjv6oDI?=
 =?us-ascii?Q?2WoBF1+KN85g9SpVw5k0GxR2hjcRy+MtQNzdVO/6xDh+7ebZcQ3gLZH54KTV?=
 =?us-ascii?Q?oXaBG38Wh4mMOhU5CztM0K8Cd+R+m2u0ZtmBvEM80ThWdLMasCNFtGX4zllq?=
 =?us-ascii?Q?ywW716ttlb0IvO7K1BfTki7EJftxKnyFvfmjzhH/03CPfxSLHEzugbR9XQ8i?=
 =?us-ascii?Q?7/kU6vdiclPbaIH6M38ekZ19V+aKtEteQzQNB6Bh3VW8x6/TEWE+jCQaeAxG?=
 =?us-ascii?Q?WngC4FHn9MX55hfbJWuXZAcuW8SEsalrM10lbgZqSsd98VWh/6INRiuSp+Jt?=
 =?us-ascii?Q?Ln7Pq9jXR1XyZHhxU8Nqcs7CaKtvLVnYmcglfJ0ZkeBOIp9N4++JfZJNG0+8?=
 =?us-ascii?Q?hFZ9vYS8Q/W4NZ157sj6YdDKvBPa5x0Xpm/RlY3OKKnZW54zdOEndUHyJP39?=
 =?us-ascii?Q?zBleoOriEwitTFMGDhsV/76toOZGArByEd3XZRuhnrRMbfAqOuOd1i0hPvp7?=
 =?us-ascii?Q?QLb6LzSkUvLSoWwzslBmhLz45M4lmrO+34Q0fr8kZQxsKlKJ1cPQL2zZfJ94?=
 =?us-ascii?Q?TM21U2ynnC7R4q25MvIdmhNVA8l4Y0WVA6HcTUiuiBMlYRQCDN4XhYNOwfHh?=
 =?us-ascii?Q?d15EwLApSSK+/0YY7QMm7SGvIhaJ0xeN3pY+n98EbHJIag9Na7MQ4UMg3+Dj?=
 =?us-ascii?Q?KoUR7aJ7uydZK522ctho8TBck7IzxkkaqOIsK2kigeJROteFPejdf9tQX5BV?=
 =?us-ascii?Q?6elPp8x6doKC5oWSQuucwVcfRJCGVmfkOK1hhJLX2qUKFh31Uc1Jbf0ja7XD?=
 =?us-ascii?Q?TLBCykVrKMBFcis3sKYu3cFRYyGtC8zsvQxZ6bgi8wbgFM3ww8IA5CkIYxti?=
 =?us-ascii?Q?ddtjmclEBbcPqYsr/x1R7asvL05dnf0s/pjWLCGp+gXhBhH5GxPsw/K05YF2?=
 =?us-ascii?Q?jkoNo74VA3MHnCrJaxGYZs3nrZtbXxFRDVyO5WypD2dhXteF2VqFuol7P4xh?=
 =?us-ascii?Q?FFO2m9hLPezny0iSsVLhpzQaeJ83VJn0hJcxb0Qu3r30HT+OpF8YLSkb+GsX?=
 =?us-ascii?Q?7LKpskRYp9pCcjl/UiUqNnLtJ9iY68bPSFB1cOq43t5ObGektvgmtjiuPHTy?=
 =?us-ascii?Q?iOs685u5wNKdUFR2x4Rg3PjhbhnHx0a0zNCEAOqYiPqfRjFz9gaM3z4UJlUC?=
 =?us-ascii?Q?Rm76yduPqya9XmWbzN2+3Dw27+k5MJoKJ2ZYrzKU+nnlC02RgpQG0x0TWpyr?=
 =?us-ascii?Q?9GfO0Etm8X7UspVwQJccOY2N87B08pkk51q2g9oeFHiknA6SMhBg8nubEs4D?=
 =?us-ascii?Q?EUSyI+6lZ7Axf4knCwRYf7Ccmzu3j4OSjFh2YAp6VGJnNBBKDim9KM1/tWTN?=
 =?us-ascii?Q?J0XRznzpaMg6m3kIv+GSNuoMJ9PkmPOdxRCkex98XaDpvpug8JdiRN883ocF?=
 =?us-ascii?Q?pIzr7ZD87cNH+4mgPwVb+6GOOkm0MpkZt/L66Ab1IPUYCFig7zDNV19Z+Q0L?=
 =?us-ascii?Q?yt1elQjUS0YM6ga+uC67wnjSqqIxBsZiShf/c6rB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0edb63ec-53e4-4638-2157-08dd210cca40
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 15:41:37.3991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Exg385wsr/xPuYtQ2oKQlCaxAFkTjUZnLh6gXYcn/nLu/9pYKfWOG1C/7rQJR+w+EJKtyxnNthPSugB7r/cWtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7149

Add a comments to clarify about the usage of cpumask_intersects().

Moreover, update scx_select_cpu_dfl() description clarifying that the
final step of the idle selection logic involves searching for any idle
CPU in the system that the task can use.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext_idle.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index dedd39febc88..4952e2793304 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -52,6 +52,10 @@ static bool test_and_clear_cpu_idle(int cpu)
 		 * scx_pick_idle_cpu() can get caught in an infinite loop as
 		 * @cpu is never cleared from idle_masks.smt. Ensure that @cpu
 		 * is eventually cleared.
+		 *
+		 * NOTE: Use cpumask_intersects() and cpumask_test_cpu() to
+		 * reduce memory writes, which may help alleviate cache
+		 * coherence pressure.
 		 */
 		if (cpumask_intersects(smt, idle_masks.smt))
 			cpumask_andnot(idle_masks.smt, idle_masks.smt, smt);
@@ -280,6 +284,8 @@ static void update_selcpu_topology(void)
  * 4. Pick a CPU within the same NUMA node, if enabled:
  *   - choose a CPU from the same NUMA node to reduce memory access latency.
  *
+ * 5. Pick any idle CPU usable by the task.
+ *
  * Step 3 and 4 are performed only if the system has, respectively, multiple
  * LLC domains / multiple NUMA nodes (see scx_selcpu_topo_llc and
  * scx_selcpu_topo_numa).
-- 
2.47.1


