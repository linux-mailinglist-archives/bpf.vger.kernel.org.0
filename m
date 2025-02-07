Return-Path: <bpf+bounces-50805-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48429A2CEE1
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 22:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC3043ADC32
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 21:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA371B424E;
	Fri,  7 Feb 2025 21:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ky9uEhFm"
X-Original-To: bpf@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2057.outbound.protection.outlook.com [40.107.100.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C742A1B415B;
	Fri,  7 Feb 2025 21:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738962705; cv=fail; b=TTK91sWDsOwfcHXweAoWjDZPS74gjhldrMmSn6k4+AF6N43pNB4RFdj8npsE0SewbPU5PnQN/C9K1RwLJ2FkZX6A64EHoZOm6cM1Gc4Uqo62Su25/wGNUOrNz/8nHVZ/ZcACNNIGEOlHTJRG6RTIyG31kDR4++XHEepg0b12OEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738962705; c=relaxed/simple;
	bh=68WAxPeVDa4JCnKcWiaH149hP2VakmWn4IiI/0OGzLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TblK4YqeHFivkiDns+udtJmINKBzBV/xnpUFHRibZtBdQMMG5Iz214i2jzYnWcGlDndLoAR7fn0QIUFlu3xX/wvCOLg1J5vRBXOP6/p+GziNWbjI8bVFS/e/6TzjpOa+JnEtphe0d/Ce4hj9VzQS2ouixT3qfz3bwjATeNBEEhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ky9uEhFm; arc=fail smtp.client-ip=40.107.100.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CnKd8kurOjJvqxhgXiCRnbYG7GHyYGuQXFRYIZ1XFwPXjhLqLTgokkcoDA8b5wNzzWiCVtTDXCblxY97HlgBA/jRzyFb6OaXYhpI1VkjuEDyhCN70dPhnyk12aVhWd2dzzEt6asIStVWDoDvNBLw11X9LCXNj6hT0ZaUnoZJnXqFAhnh1mz1EHkg+itRcixqMLr7xPR+AJfEgx36PYJGUqzqZlEELuR/dGLDQjPKxkyWOhW1/HLccE/lskbOxJPJMS3fUg9zlF6dhOvGM0HaburzAWZBdGqpC8VaY6qCyXgzjYW+MdbNKdIKziLViXikYWKRp1ZjGP+JSjzbnaj2Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BQWKnNVX67hZvStXqKeIj9HUzXK7qGpHgtMk1iy4Mpw=;
 b=SnJY+SoYUIbdzkDE0zMyx54P7zhu3AgdCJnvLFGlsDQMWSQ+SND+zPN1J989PdBE62fSEBCI4UN7fOoVcKntFnPtX/KlNN4dIRwHsxUVQSZWPpskAC4jr2Va6WOuXeYMk/eYkjSd0osysiTn6F3XG9sX0YXIZQQJchrLzbfR8h5Voa6UZ9TQyEqFvUyteaZn2318jw6ztj+sAeVoUKH7k0Xm0DODHsDgN6H0UHHdVT/H9GKW+h2eImAt1OHIkuAeqCTiJb5pyQT+4oVspP5JIN6Tu76zIpBj07FJViWl/UsVi6M4AnrnZygsWx/qrAFenHgN5EfrnRYZUsPs8KYUJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BQWKnNVX67hZvStXqKeIj9HUzXK7qGpHgtMk1iy4Mpw=;
 b=Ky9uEhFm4f5dAmhgm1x2GIf9/gP2fuM+vgTlLs4L7ktbQ3fZVdxFmyxdTIFnV2glgM/kwlcoaQijTsnHQu7B6MI5ehOYkqz6MDJ3DKXGII73gUpjI1o7lv94X2h75qF2J4kF+yIb3euzyi+T+JpX16blmEU3EFv8LLB7m1aShEmBIZaLxcai661FSu5dMB3uAuz3Cz6c7RgL69z4PUHuImRv9nsimGRxnTccQZiEWfpXiv0/y1yn/QLMGB6tge5lHY4pz1lCsJf69W80U6StPnfnWHvSOyLsMIpBJx1D1P+ABbs6VMIbGfoSS57+MPsMF/v7MM7us6iHo8O/pqNFvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by PH7PR12MB7380.namprd12.prod.outlook.com (2603:10b6:510:20f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.14; Fri, 7 Feb
 2025 21:11:39 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8422.010; Fri, 7 Feb 2025
 21:11:39 +0000
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
Subject: [PATCH 5/6] sched_ext: idle: Per-node idle cpumasks
Date: Fri,  7 Feb 2025 21:40:52 +0100
Message-ID: <20250207211104.30009-6-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250207211104.30009-1-arighi@nvidia.com>
References: <20250207211104.30009-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0172.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::10) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|PH7PR12MB7380:EE_
X-MS-Office365-Filtering-Correlation-Id: aa0830f8-4a82-426d-826d-08dd47bc0391
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5eqdyvABnDGHfKc8TXy6LsITeRIbknifHOYJzemAKRWwDQXQbknXybGEzo/k?=
 =?us-ascii?Q?JCrb+uXca63ydwafxFg/a+4gHRuTT+759DNM/jjVrMNL11MD6gJ3mEGFRoED?=
 =?us-ascii?Q?4KbFtP603NeMNsEp0cy75Klcgh2j7yYScPccJEKJxIvKdB3XIFO3QRGryvwm?=
 =?us-ascii?Q?YOSmqJWnNtsQxnt7d2rJ14h9pvyJ4hczufCTqZ9rv3SJ10EP/O4VaV1xzrDE?=
 =?us-ascii?Q?Ugbasnl/zbib7wB+HOxhooRhb+1vWOW1QCLuRZwsacrOEP1wWaPUGi4rkWoF?=
 =?us-ascii?Q?9Z4XTFTkQwPDslr1Vkd72lOe9B0U6226bNt6qtW+1UOp4kaxrYm93QgWYThT?=
 =?us-ascii?Q?9v2extNNkBmdPzerNidyfRdYVRuLaRdRmUMtiXvIpp49oUGrSWNqJAHo3QIm?=
 =?us-ascii?Q?LJFT3RfdaWRIAvCMDqO8h6EZ1g7bGJR5G48O6wMSdzJal8xnWLTF6a2k5o4t?=
 =?us-ascii?Q?2Z24sUZeQgDjx1CFQFrTh4oPiCNaEq2xJGTK8mmWIFh6lvhqR696DTkSGxUW?=
 =?us-ascii?Q?CVOQq2tA588QLIT+ae+zcN0hYnWV/FMJn99jssyCgGkqPjTMR7EO8A/QEHMn?=
 =?us-ascii?Q?C+Ox/ts5lhktVIOzFXeq6KUYw0GFGeVOqur5nCnJ5q4mfPYMmDNXkbKimA8K?=
 =?us-ascii?Q?YmHhewv3bDsYJV1ZVxwbf7DPEeIlHWJuKcZQHdYKnx9UXynyDZFj7xmDKsVs?=
 =?us-ascii?Q?gU13fvxmVF6ED7di6FWMwO875FXdAbKlFNhaJCNdoXyCaUYJzaBvfWjjdI91?=
 =?us-ascii?Q?GjyEzlrGTLkO3HQjCEyW/EjcM3oUQU3DtNDqEsnPTecUVssgZ9dSUPmgWfwk?=
 =?us-ascii?Q?cjMIh9b1IF2WqU3SL+cDQTavHELKZKJB1fQqei+9tmScjFLXseX1NL+7vkE+?=
 =?us-ascii?Q?700RBL5Fcs5BhMUrPbRjMm+wPq5UtTSwRjQgqHBVWdL3RikOXX9PlOY4o7ro?=
 =?us-ascii?Q?4OCqZy/PnpJJm7iIGAiFbPUEYpPqKKQsZ7rn21cicPhjQoOzfZmxfhie6bhO?=
 =?us-ascii?Q?4hzIp3l6CHCAuOIdWtf9o5Y3vIzVv1huWFDZ4tTppMFqXFvoHWKP8DdTtgmq?=
 =?us-ascii?Q?R40n+EjPYdU5hZYuVhNTZqF6gfiof71dhASHc7GexK77ieLma69Ud1REqE9n?=
 =?us-ascii?Q?BIem7EBv5u6rZ7Ud2J/+PDZuuwQATtDCI/NTBQDn/8mUl31fdK6dC+WYusyH?=
 =?us-ascii?Q?8vstOmGA83fxZYFhc9zVpN6sCsWW5iMBjAuPjOgmxkxF9pZONjSvvRf94hH2?=
 =?us-ascii?Q?+6KaAVAD7br8tME6VXENkXrtzoj71UJKNm5+nCXgdZl1P+bPQN2kDbhKWuHg?=
 =?us-ascii?Q?FocG+Yiqg/vJNftcepWq48e2b1ScWWglUDgM0scGdTzxqeDeIsZ3X1rQ3lPW?=
 =?us-ascii?Q?XO+GrKH9VRuEH2HwWo+cIVpqcI+G?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mJMTLOAhzXqZXT1YPRQutYKOOGUcm4b4w4T3/nEcRph1eoGTFbKlvWYl5ZT/?=
 =?us-ascii?Q?B1FdCn2JM4d5BMhsqsETHjvtuo7lHNa/XSdlxud94c3b2XTE6dM6aZcSLXNh?=
 =?us-ascii?Q?Quc8epcxoKPBn9kbOuEMNn9sMvEw7A5Ix/eAjvaQRoZ5T3KDExyxQzDJa5WI?=
 =?us-ascii?Q?0iCQS3Od5hJ3Y4D9nBK4EPsloBjzKfvF2/z158PZZWP6bEsFXSQYrF5aPjeV?=
 =?us-ascii?Q?Xg8f/h4hRcXpj9xVDR1rr92kl6+kjOs97uKZ0rT93/e0+vT73avUmy420p76?=
 =?us-ascii?Q?S/5kXtHlNbf5a+AjEWMaEdAElwF124r4/JNFTIdRBnu0SLicnxG8BSqj5GDG?=
 =?us-ascii?Q?g++W715Cuxh47KG23Gx9ONMZjw8DvQLoSTYS0aRUUbfdWs8uYmNvnSc8+GoP?=
 =?us-ascii?Q?TyOn2wYgbhHhBfsQrIaMvo0rSGQVMFCGAd+Cf3NIFL9PcqXIBYrtwX9VMVZp?=
 =?us-ascii?Q?quNl3O7NQoMs12g79CY1g8nhSHNbs98STY1CLhK+F2j3c7nhRNBoWKpwyLBd?=
 =?us-ascii?Q?k08yWi02Y1WwI3wLQ+RUsW2JvsmkRFACNk7YyouMjIJ7OWv7vb8uZi6yQQ9b?=
 =?us-ascii?Q?ZMS5j7eggXjl2pTcKwW1xaPtmDgknCAvXYyaJuKKgmDIeqxVZrsYrr6qcNG6?=
 =?us-ascii?Q?s0Hixe9e9O0jlcBFRGnmNFOVZIIyWVWOf2H4bI2J4ZGiH61KW2H808rPb7KA?=
 =?us-ascii?Q?Iu8uT5+mKqt3Xls5EgcnOYzDRIZnEF5VKsrOZU97IybHORMyiNcyfdU184EU?=
 =?us-ascii?Q?/XouljRJ4b2GZaRMB2WVTPMpU7TyVRXd+phPlL7QrvUr5nMRP3rOVjmvA/1y?=
 =?us-ascii?Q?1McY/GiWPc5vhQlY+LNjS0OPK6u3yqPSdkNuSMWf37GLa6oiPJC6LoX7+fub?=
 =?us-ascii?Q?Z1e18NpoLNpUClDWEKzvzFbmd371xeG7SfEnTIWC/d2BP0yFZNWXjXvkT7Ur?=
 =?us-ascii?Q?96JYCpLKrwkVLBiDIP4PvkPjI6xPh1HcsTBldkYeMgU2BgThFw3E18be+Vh8?=
 =?us-ascii?Q?NiMnbDO+qV88FkYBfci+PSwhg9Aun1BPvwVCSkhm67w4iSfeUAElrPKwj0t9?=
 =?us-ascii?Q?Q5bsJxMEkWpDIr1SzTdGME78F2d3ce5o9jZHtDcfzfiOhnpsrUTk3O1vSlMm?=
 =?us-ascii?Q?Q2AfefQogZb7ZYT6hvFi4m5AJWCtlpBAVjgsM58ixPXBAzLbnbTsdzPaB8bu?=
 =?us-ascii?Q?mDp3BAh6fgs5y5YPEm5iSPGwFwgWJMw2NSBGXZiO2GZc+FQoyj81K4IkPYHC?=
 =?us-ascii?Q?ta1S74WX8KKrhPQ/uoHcADafeEjD7lTP3t5cCJ5dAe+N7+MQ4nFmykidq9k1?=
 =?us-ascii?Q?ymPD07/ZqQJ7OLUVpvRskmnRFc5hfoo9aFzjsqHlQjbwlqtWuUc8u7OOOt8b?=
 =?us-ascii?Q?UiDigm7cB46Zw2uVqLfRkfVJgveR7nsrNT9G2okwcfVHo6TDf/GozITu6Ysl?=
 =?us-ascii?Q?8IxVmtqzwAuQUq6cxnuhwol/D8OUw4Fi6e45VxE3HCr+L/KPK8fNFs5xxY6A?=
 =?us-ascii?Q?IVdM+/KHQoOn7iBxDWZhKNXWUo3OLplqRPDX9gzv5JEbgZRwTC/HX8Npu0E+?=
 =?us-ascii?Q?FiSYb9TJun3DGTSfHRF6OuD08XtJpQW2cMqqh1n+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa0830f8-4a82-426d-826d-08dd47bc0391
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 21:11:39.8346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1NN1h6NaGs0cS2uw8YZezPB3k6zpf3WI+D1ve8vRlBtPzF5XH1rG6S11SdBcdoIbV8Y10C0avItU3ctMv3q7ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7380

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

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext_idle.c | 242 ++++++++++++++++++++++++++++++++--------
 kernel/sched/ext_idle.h |  11 +-
 2 files changed, 203 insertions(+), 50 deletions(-)

diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index a3f2b00903ac2..4b90ec9018c1a 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -18,25 +18,88 @@ DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_enabled);
 DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_per_node);
 
 #ifdef CONFIG_SMP
-#ifdef CONFIG_CPUMASK_OFFSTACK
-#define CL_ALIGNED_IF_ONSTACK
-#else
-#define CL_ALIGNED_IF_ONSTACK __cacheline_aligned_in_smp
-#endif
-
 /* Enable/disable LLC aware optimizations */
 DEFINE_STATIC_KEY_FALSE(scx_selcpu_topo_llc);
 
 /* Enable/disable NUMA aware optimizations */
 DEFINE_STATIC_KEY_FALSE(scx_selcpu_topo_numa);
 
-static struct {
+/*
+ * cpumasks to track idle CPUs within each NUMA node.
+ *
+ * If SCX_OPS_BUILTIN_IDLE_PER_NODE is not enabled, a single global cpumask
+ * from is used to track all the idle CPUs in the system.
+ */
+struct idle_cpus {
 	cpumask_var_t cpu;
 	cpumask_var_t smt;
-} idle_masks CL_ALIGNED_IF_ONSTACK;
+};
+
+/*
+ * Global host-wide idle cpumasks (used when SCX_OPS_BUILTIN_IDLE_PER_NODE
+ * is not enabled).
+ */
+static struct idle_cpus scx_idle_global_masks;
+
+/*
+ * Per-node idle cpumasks.
+ */
+static struct idle_cpus **scx_idle_node_masks;
+
+/*
+ * Initialize per-node idle cpumasks.
+ *
+ * In case of a single NUMA node or if NUMA support is disabled, only a
+ * single global host-wide cpumask will be initialized.
+ */
+void scx_idle_init_masks(void)
+{
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
+}
+
+/*
+ * Return the idle masks associated to a target @node.
+ */
+static struct idle_cpus *idle_cpumask(int node)
+{
+	return node == NUMA_NO_NODE ? &scx_idle_global_masks : scx_idle_node_masks[node];
+}
+
+/*
+ * Return the node id associated to a target idle CPU (used to determine
+ * the proper idle cpumask).
+ */
+static int idle_cpu_to_node(int cpu)
+{
+	if (!static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node))
+		return NUMA_NO_NODE;
+
+	return cpu_to_node(cpu);
+}
 
 bool scx_idle_test_and_clear_cpu(int cpu)
 {
+	int node = idle_cpu_to_node(cpu);
+	struct cpumask *idle_cpus = idle_cpumask(node)->cpu;
+
 #ifdef CONFIG_SCHED_SMT
 	/*
 	 * SMT mask should be cleared whether we can claim @cpu or not. The SMT
@@ -45,33 +108,38 @@ bool scx_idle_test_and_clear_cpu(int cpu)
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
+s32 pick_idle_cpu_from_node(const struct cpumask *cpus_allowed, int node, u64 flags)
 {
 	int cpu;
 
 retry:
 	if (sched_smt_active()) {
-		cpu = cpumask_any_and_distribute(idle_masks.smt, cpus_allowed);
+		cpu = cpumask_any_and_distribute(idle_cpumask(node)->smt, cpus_allowed);
 		if (cpu < nr_cpu_ids)
 			goto found;
 
@@ -79,7 +147,7 @@ s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags)
 			return -EBUSY;
 	}
 
-	cpu = cpumask_any_and_distribute(idle_masks.cpu, cpus_allowed);
+	cpu = cpumask_any_and_distribute(idle_cpumask(node)->cpu, cpus_allowed);
 	if (cpu >= nr_cpu_ids)
 		return -EBUSY;
 
@@ -90,6 +158,55 @@ s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags)
 		goto retry;
 }
 
+/*
+ * Find the best idle CPU in the system, relative to @node.
+ */
+s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, int node, u64 flags)
+{
+	nodemask_t unvisited = NODE_MASK_ALL;
+	s32 cpu = -EBUSY;
+
+	if (!static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node))
+		return pick_idle_cpu_from_node(cpus_allowed, NUMA_NO_NODE, flags);
+
+	/*
+	 * If an initial node is not specified, start with the current
+	 * node.
+	 */
+	if (node == NUMA_NO_NODE)
+		node = numa_node_id();
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
+	 * As a future optimization we may want to cache the list of hop
+	 * nodes in a per-node array, instead of actually traversing them
+	 * every time.
+	 */
+	for_each_numa_node(node, unvisited, N_POSSIBLE) {
+		cpu = pick_idle_cpu_from_node(cpus_allowed, node, flags);
+		if (cpu >= 0)
+			break;
+
+		/*
+		 * Check if the search is restricted to the same core or
+		 * the same node.
+		 */
+		if (flags & SCX_PICK_IDLE_IN_NODE)
+			break;
+	}
+
+	return cpu;
+}
+
 /*
  * Return the amount of CPUs in the same LLC domain of @cpu (or zero if the LLC
  * domain is not defined).
@@ -310,6 +427,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool
 {
 	const struct cpumask *llc_cpus = NULL;
 	const struct cpumask *numa_cpus = NULL;
+	int node = idle_cpu_to_node(prev_cpu);
 	s32 cpu;
 
 	*found = false;
@@ -367,9 +485,9 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool
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
@@ -383,7 +501,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool
 		/*
 		 * Keep using @prev_cpu if it's part of a fully idle core.
 		 */
-		if (cpumask_test_cpu(prev_cpu, idle_masks.smt) &&
+		if (cpumask_test_cpu(prev_cpu, idle_cpumask(node)->smt) &&
 		    scx_idle_test_and_clear_cpu(prev_cpu)) {
 			cpu = prev_cpu;
 			goto cpu_found;
@@ -393,7 +511,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool
 		 * Search for any fully idle core in the same LLC domain.
 		 */
 		if (llc_cpus) {
-			cpu = scx_pick_idle_cpu(llc_cpus, SCX_PICK_IDLE_CORE);
+			cpu = pick_idle_cpu_from_node(llc_cpus, node, SCX_PICK_IDLE_CORE);
 			if (cpu >= 0)
 				goto cpu_found;
 		}
@@ -402,15 +520,19 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool
 		 * Search for any fully idle core in the same NUMA node.
 		 */
 		if (numa_cpus) {
-			cpu = scx_pick_idle_cpu(numa_cpus, SCX_PICK_IDLE_CORE);
+			cpu = pick_idle_cpu_from_node(numa_cpus, node, SCX_PICK_IDLE_CORE);
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
@@ -427,7 +549,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool
 	 * Search for any idle CPU in the same LLC domain.
 	 */
 	if (llc_cpus) {
-		cpu = scx_pick_idle_cpu(llc_cpus, 0);
+		cpu = pick_idle_cpu_from_node(llc_cpus, node, 0);
 		if (cpu >= 0)
 			goto cpu_found;
 	}
@@ -436,7 +558,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool
 	 * Search for any idle CPU in the same NUMA node.
 	 */
 	if (numa_cpus) {
-		cpu = scx_pick_idle_cpu(numa_cpus, 0);
+		cpu = pick_idle_cpu_from_node(numa_cpus, node, 0);
 		if (cpu >= 0)
 			goto cpu_found;
 	}
@@ -444,7 +566,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool
 	/*
 	 * Search for any idle CPU usable by the task.
 	 */
-	cpu = scx_pick_idle_cpu(p->cpus_ptr, 0);
+	cpu = scx_pick_idle_cpu(p->cpus_ptr, node, 0);
 	if (cpu >= 0)
 		goto cpu_found;
 
@@ -460,38 +582,50 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool
 
 void scx_idle_reset_masks(void)
 {
+	int node;
+
+	if (!static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node)) {
+		cpumask_copy(idle_cpumask(NUMA_NO_NODE)->cpu, cpu_online_mask);
+		cpumask_copy(idle_cpumask(NUMA_NO_NODE)->smt, cpu_online_mask);
+		return;
+	}
+
 	/*
 	 * Consider all online cpus idle. Should converge to the actual state
 	 * quickly.
 	 */
-	cpumask_copy(idle_masks.cpu, cpu_online_mask);
-	cpumask_copy(idle_masks.smt, cpu_online_mask);
-}
+	for_each_node(node) {
+		const struct cpumask *node_mask = cpumask_of_node(node);
+		struct cpumask *idle_cpus = idle_cpumask(node)->cpu;
+		struct cpumask *idle_smts = idle_cpumask(node)->smt;
 
-void scx_idle_init_masks(void)
-{
-	BUG_ON(!alloc_cpumask_var(&idle_masks.cpu, GFP_KERNEL));
-	BUG_ON(!alloc_cpumask_var(&idle_masks.smt, GFP_KERNEL));
+		cpumask_and(idle_cpus, cpu_online_mask, node_mask);
+		cpumask_copy(idle_smts, idle_cpus);
+	}
 }
 
 static void update_builtin_idle(int cpu, bool idle)
 {
-	assign_cpu(cpu, idle_masks.cpu, idle);
+	int node = idle_cpu_to_node(cpu);
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
@@ -599,15 +733,21 @@ __bpf_kfunc s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
  * scx_bpf_get_idle_cpumask - Get a referenced kptr to the idle-tracking
  * per-CPU cpumask.
  *
- * Returns NULL if idle tracking is not enabled, or running on a UP kernel.
+ * Returns an empty mask if idle tracking is not enabled, or running on a
+ * UP kernel.
  */
 __bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask(void)
 {
 	if (!check_builtin_idle_enabled())
 		return cpu_none_mask;
 
+	if (static_branch_unlikely(&scx_builtin_idle_per_node)) {
+		scx_ops_error("SCX_OPS_BUILTIN_IDLE_PER_NODE enabled");
+		return cpu_none_mask;
+	}
+
 #ifdef CONFIG_SMP
-	return idle_masks.cpu;
+	return idle_cpumask(NUMA_NO_NODE)->cpu;
 #else
 	return cpu_none_mask;
 #endif
@@ -618,18 +758,24 @@ __bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask(void)
  * per-physical-core cpumask. Can be used to determine if an entire physical
  * core is free.
  *
- * Returns NULL if idle tracking is not enabled, or running on a UP kernel.
+ * Returns an empty mask if idle tracking is not enabled, or running on a
+ * UP kernel.
  */
 __bpf_kfunc const struct cpumask *scx_bpf_get_idle_smtmask(void)
 {
 	if (!check_builtin_idle_enabled())
 		return cpu_none_mask;
 
+	if (static_branch_unlikely(&scx_builtin_idle_per_node)) {
+		scx_ops_error("SCX_OPS_BUILTIN_IDLE_PER_NODE enabled");
+		return cpu_none_mask;
+	}
+
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
@@ -696,7 +842,7 @@ __bpf_kfunc s32 scx_bpf_pick_idle_cpu(const struct cpumask *cpus_allowed,
 	if (!check_builtin_idle_enabled())
 		return -EBUSY;
 
-	return scx_pick_idle_cpu(cpus_allowed, flags);
+	return scx_pick_idle_cpu(cpus_allowed, NUMA_NO_NODE, flags);
 }
 
 /**
@@ -719,7 +865,7 @@ __bpf_kfunc s32 scx_bpf_pick_any_cpu(const struct cpumask *cpus_allowed,
 	s32 cpu;
 
 	if (static_branch_likely(&scx_builtin_idle_enabled)) {
-		cpu = scx_pick_idle_cpu(cpus_allowed, flags);
+		cpu = scx_pick_idle_cpu(cpus_allowed, NUMA_NO_NODE, flags);
 		if (cpu >= 0)
 			return cpu;
 	}
diff --git a/kernel/sched/ext_idle.h b/kernel/sched/ext_idle.h
index d005bd22c19a5..b00ed5ad48e89 100644
--- a/kernel/sched/ext_idle.h
+++ b/kernel/sched/ext_idle.h
@@ -13,6 +13,7 @@
 struct sched_ext_ops;
 
 extern struct static_key_false scx_builtin_idle_enabled;
+extern struct static_key_false scx_builtin_idle_per_node;
 
 #ifdef CONFIG_SMP
 extern struct static_key_false scx_selcpu_topo_llc;
@@ -22,13 +23,18 @@ void scx_idle_update_selcpu_topology(struct sched_ext_ops *ops);
 void scx_idle_reset_masks(void);
 void scx_idle_init_masks(void);
 bool scx_idle_test_and_clear_cpu(int cpu);
-s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags);
+s32 pick_idle_cpu_from_node(const struct cpumask *cpus_allowed, int node, u64 flags);
+s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, int node, u64 flags);
 #else /* !CONFIG_SMP */
 static inline void scx_idle_update_selcpu_topology(struct sched_ext_ops *ops) {}
 static inline void scx_idle_reset_masks(void) {}
 static inline void scx_idle_init_masks(void) {}
 static inline bool scx_idle_test_and_clear_cpu(int cpu) { return false; }
-static inline s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags)
+static inline s32 pick_idle_cpu_from_node(const struct cpumask *cpus_allowed, int node, u64 flags)
+{
+	return -EBUSY;
+}
+static inline s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, int node, u64 flags)
 {
 	return -EBUSY;
 }
@@ -36,6 +42,7 @@ static inline s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flag
 
 s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool *found);
 
+extern void scx_idle_init_masks(void);
 extern int scx_idle_init(void);
 
 #endif /* _KERNEL_SCHED_EXT_IDLE_H */
-- 
2.48.1


