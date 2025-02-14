Return-Path: <bpf+bounces-51590-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 682ADA3664E
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 20:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFA41189560D
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 19:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5AB1D7E4A;
	Fri, 14 Feb 2025 19:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QBzUUNF9"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE83D1C8637;
	Fri, 14 Feb 2025 19:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739562123; cv=fail; b=Gyib4WG/t3EvFKlNkBLuToVy9etfRoFpFs3kuw+BAwwzgn/XZ3HlfnneyhhzLEvxlfY4VIKOeZwyb5PWi4zS5xIicoIqgUWzW+ohWsABUibQFMFSuGLRTaNdEqQ1hu2tewGYOcYdG9UxIraTj4sdUZvYx3yMEC152B/NG+MaDY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739562123; c=relaxed/simple;
	bh=51OlaCzwGlOAaE1HyiIlI9UKSp9Sqo6BoXksah3f3Rg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dsuScdiZdoUj6DjuUDXAuIGjHzhaehPqo3kM0bV8cRRMpwk9AKAC+z4BsqRb8XdCyqPaP83Rss/PwHVvh9UkgKWCKcbkTA9fqIZSheuGV4MxKQIqq246fCSmQ5A4vjB5yaIuPKH+ebyZIWjT5xyHKEGJeFsgJLC0CxH5lcB6LR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QBzUUNF9; arc=fail smtp.client-ip=40.107.237.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AD1Q2vzfuirizcz/ci7CGFbn9ynljxrs2gtw1zckjB03oPRhu4iOS7raOIjS6rRpfy128WvaKNywV0yx1c7RYlX70YL+MOglPJN9HdPKK+rrn3ObrQ07vuaxwua/sAHu+p6uGGeMH3dUNklsx9YHAuentcuT7pVT7ggFr/zjKX/R1y2hzqlZb/C6QDiBHyeK3Nsjj8eKxgKFniWMH0f6Gp5uu/NZUu7zTtXCncDclPBosStoqwRzkmnUF4PibHRawFtXfxszrqFlysDxkW/be1A0zRhETI11izIJLPT0oKZ8dCGxxupp6NQMLt3D2fUER146xL58ayb5ZxMc3DbyWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bd6VQNRR5xJaWH9XJbyL6g1uRW8Ufqd4Dy2fAhdtZU4=;
 b=GzBGYgW0Ioip/e3cXEX+FQSvyM7t+2gTvda6p9WAz7XXohg2a0CR+8F89TQvdjSbM1jRyakqK+CbMj0xjKO0snIdErVTxCOOOsdNMjYt1v9u3OPkfwXt7I/ROuzcAxuUVkGNLJBYbF6mRE82EBwpJCRbWNpPlEYsd9UG19omnaYbma1RYNGgpFtVN9PKF26wIXmvYMdvOCkTQRR9jpqvsfiF9GYlW39csMD7w48OsNV3PCHU9emRKymntyhZX3xU1zJos24zJUWTB0CIF0xSw+Ah/avdcv79lvPWQVclgauZ/2NIgx+oap09uaDgAwyCDT3Qn+kibqusOPv6OCpLVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bd6VQNRR5xJaWH9XJbyL6g1uRW8Ufqd4Dy2fAhdtZU4=;
 b=QBzUUNF9WpLoqR0V7dCSDgPgKt4hYCM37eEeEKNicV8QsGsHn1j6MwjzqVkEtsUkcXn+eVR4/5aC+Cjr4Hk1SHaVYwm93xmgNeWV8MMRotRDPQHf01Uz4pZQfKB+LjNStFra2e4uwLN/Wq+UYrFtsSHzcTM6j1jGuz34PQsm9GFHjWt3bZlxj/0r+Z1jMmRErCJQUxn2ONa5PR7PzuGKE6ZxPKbz4f9GilpVrARtsTBl8a+cpyeNN5jbHSKt72Tat4w1ZZizcyb2Ua/XhFvWKjIlhs7rIP4fASTbDoS92tGxy5DdcCBGLD6034GvWrQQYKY2zfOLE8KT4a4OvCVjBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by SN7PR12MB7809.namprd12.prod.outlook.com (2603:10b6:806:34e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Fri, 14 Feb
 2025 19:41:59 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8445.013; Fri, 14 Feb 2025
 19:41:58 +0000
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
Subject: [PATCH 3/8] mm/numa: Introduce nearest_node_nodemask()
Date: Fri, 14 Feb 2025 20:40:02 +0100
Message-ID: <20250214194134.658939-4-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250214194134.658939-1-arighi@nvidia.com>
References: <20250214194134.658939-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0287.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::12) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|SN7PR12MB7809:EE_
X-MS-Office365-Filtering-Correlation-Id: 90761c16-f9da-489a-6590-08dd4d2fa547
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8A1hSmfXh8VhH2wcvAE7Qag8iDkmY2co3gziqpjt58HNWP4s6v8Vjz179+t5?=
 =?us-ascii?Q?DKAgCr6ZvlbcUDD5l4JowzKOcOuKP2CAdooILi6VxukIbFm6DxZ3tMlyON15?=
 =?us-ascii?Q?0WOs0iBWTwo6mC7NezPOhMwBDrW9CZPnFz4+sblqZzSbp9RhBZTeXBEmpIfp?=
 =?us-ascii?Q?Z6ZmaarPwmhRt8/7iSAis5eUsgsuajHtw3vXqGVoOv7TG8768OfP2B1AWFWm?=
 =?us-ascii?Q?D8xQfE3/BDD+4yrB28B+tbyOnxuii6VbFJO5CSRuPg93ij1eFlQlG/oSoHON?=
 =?us-ascii?Q?baoIlWE2bVcHOzIP6ZNBIoJX2zXtUjKjlHt2DALiyQjQxYnalGP3Dp7pNVRQ?=
 =?us-ascii?Q?poi9LC6oLbeWwiauVvmCe7qkjMOxnujyknuxw9I1lGVgJLi13xabPKENXn2i?=
 =?us-ascii?Q?Ay/LiPLIAS4R98uVzZPT1aSpEGbkIkAXLwRbM6TgktS4DUO8wfEEKOVTlTAm?=
 =?us-ascii?Q?7hvFlY/bhazg7ffkPcO2zvVd25czTaS+8ZuYDellS2U2Tu9GxYvW19JMmmwx?=
 =?us-ascii?Q?sMIH5rK7YFnTQnUYCDrZp75FwGT1nPJ5eDy6uWa6EHkkbnPn8q5utAACtknr?=
 =?us-ascii?Q?/2cceTzkN62+dpz0cXHLxJSNzLy3GtGAQRQmMfp4ravxsMAwT/jdPXHmfGii?=
 =?us-ascii?Q?0YDACJppsLYkqrtI9Ip/REGgrCoU9VfWq6AgmKnihZT6NzXED/XKhY3ATRrZ?=
 =?us-ascii?Q?GbQJX2pRdAmgw4m+U85cy6S/41E7SerPEzNQaPHhlb/Ta2CM4ZaCXtNgzsHp?=
 =?us-ascii?Q?oZEbWdIVMtBc4S/lGDd0RCH7qYsznNKYCWM06jl5nU4ITtU7/8aH14JQBjMm?=
 =?us-ascii?Q?SW0DcmR9dtnYXtbY6qBhgI1+h8FA2XpEhFSRkY+6zo0gknfA4ksr8kMEC1f4?=
 =?us-ascii?Q?eH1UI5MM7BLFA+tBeIqBchl9zg7zf59qivq3j3hWix5JwhsIVI+IN+TuIJDf?=
 =?us-ascii?Q?XVaxkzB2+tLg/YWPDOBPiE2530h+KzMTkNOVGbuv+T0ce/To+RMTg2zufroR?=
 =?us-ascii?Q?3BfmjQlZ6Gh2Z7ocl+cnclBEbWoDvf0i6wRIPgVa+w+S9tUbqWs3fIvdlPDU?=
 =?us-ascii?Q?fZrcPNNF/WKPBeoQLcMg2Tm3BapGeyxarRox5OVSJx7Um8GkXPueQOFJQfzP?=
 =?us-ascii?Q?NGuAdE/8K/uwNH7LDEkV0qp6O/FHRQgyfpK61IXetr5z8p78V+FH0beubMTX?=
 =?us-ascii?Q?eP5cdFdnqwupQ0YJDIQ918fqwbldMMzmq6QF0UDGJvPxriirW800SQRzd9dN?=
 =?us-ascii?Q?B94SEJZznlDCAaYMafS5iZ/d/2/LQ00my5v7atgep3w0ocHVuC8us1vQIUkJ?=
 =?us-ascii?Q?H/zQtfZV/MabzVJpATPqlx9pp3S6oblUbEdbpPG7Hro35gtWJIv+6I7q7TgY?=
 =?us-ascii?Q?MHipgtNXahg5QYQD+23Cnq041bWA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JzegQ26JQ0qtg0ECdbRpovbVH4Hbl+rWJxGcKE8EOlxCElbOGb07bkfXl4v9?=
 =?us-ascii?Q?kSKP3z0+t6ecA4Z9Ek4LgVcWALqFM78JrLRjOKuFC4aWG2Rj2iKLSPUgvEkZ?=
 =?us-ascii?Q?69fNnyQc1vTyvhCEMf1sLYO/8vICn0sLi17x9x1fYwiwWjmA/xAc9Bxvmkn+?=
 =?us-ascii?Q?ARSh5ml7iJdvWWiKZlmcktIVhXxCtNH3W5jIkRXJeyivIZliGcGWokLRGQ6d?=
 =?us-ascii?Q?uXrhtuwpPeMiYghfnngzKYROh2SKJx+nEnrAD/6PDyYtWU02eRLcmfU8P6wX?=
 =?us-ascii?Q?Q5cajKq4uMGdIufVmxEv3Z9PkVtKMLkFb7n8qacPzkFz1sx4bnO7i4AE6z+j?=
 =?us-ascii?Q?T1QMVIpJC5KsW/8W+MuE1VdsHrL1ygzZ9/oX4e9jNqD6OcagoKijrcHW98HK?=
 =?us-ascii?Q?74+8VJn8fKkDZL9xrre0fKF9olDggcSzxRH9XaTNxUyC1ZYGLJ2icxWup4h3?=
 =?us-ascii?Q?h76SBN1zlKxGLoo0GZdbwmvxOyeKWCFWBT+mgs+EVQ9eaRrkbtX/TN+SyQuR?=
 =?us-ascii?Q?aGk7rUPFjLa17NcrKJz8G51zDQRTS+PQNsYkTXGzlawB/vJ3E9MXH9P79Ojt?=
 =?us-ascii?Q?aVYH7Hj8qfrx+DEAHUTS1NvLiR0a6f6IFJPrcCGEWRNTjrIP0ZUBXzBml90g?=
 =?us-ascii?Q?Gy90RfZsIX8IwDtng5CKutGqdZpsu8kod1n0s6djU0JtfidT+LZoVZTKu214?=
 =?us-ascii?Q?yGZfjihGtFVvT5nx9PK7xwnnVK7ByxYkC3oz02tU/gc6fWEJ6yX9ZXW+9p0v?=
 =?us-ascii?Q?uKHtp0xM48DUebwZGMfI1b8oisnYvn9fQ6wm1l0FIhTejNl8aUXO7zdMijZq?=
 =?us-ascii?Q?BapeoMpRaGQ+CH4wWAFpI//DCr927uhBE26/OVeQwaaY8Qfw1mSYUopP4Vcd?=
 =?us-ascii?Q?mpp2QQESmXqOfjCzoEFhOCQKXraU4yC+jmnoxgRBZQwWT9toDo/Jzexd22R4?=
 =?us-ascii?Q?DROJJP5IFueSbUeRCDbu8NXjbZ2XlV9wxiGcSbf+Dju7QWPf+5QayiaK3HlQ?=
 =?us-ascii?Q?nV6deQy0+F9ZeCD2XBmegZG6ul6t2bZMdN3G/0rWrONHGVO5WBaB3tRFQNtq?=
 =?us-ascii?Q?4c+zN6qovbuaee+emNpGlS6TdfP2nTCwtg60sMHIPAn6nLVlU4+h+xWbRu+b?=
 =?us-ascii?Q?nfH2CfV/eRi2ei9Z/HRQ+tYHcPK/KOclKxqXO62t//COByOGbvBD3EScoeMz?=
 =?us-ascii?Q?FVUxqeBoRniecGmOL2RTG0CnXdwYvN0TVg4YmxDyuQLRi4Z4avO8z2JluHjK?=
 =?us-ascii?Q?keJRjq8qhVo4fpiNQlerTHjoAuTCkRFgZWIHj6jQUDGaFbgpk8Z93wpW21Li?=
 =?us-ascii?Q?J9r+yiJbXwv6iV2HIh5L6hGcghv34rDmEdVu0OimdKyETiWiG/E49Tv4/nBN?=
 =?us-ascii?Q?GWjPqt6oB6cnre7E0uuHVzX6SBoS/B5naPj1wnhAHEqCKmzk3TBchnsT+wjV?=
 =?us-ascii?Q?7ZHE6H5zo1gz8wQBrnyx0tq2BgDeU82GtGGuOz+4/9/KMlo2n3A9C3X8ol4i?=
 =?us-ascii?Q?LYXXfrSpM6fDyPpHsMEtq8qMKLskxTsSqibP3zvINJ9ZxMKkyoYGpFdWOjKq?=
 =?us-ascii?Q?0je3m0tum9c5LnucmRGIt+5Cd2U+5NKg85loi0y/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90761c16-f9da-489a-6590-08dd4d2fa547
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 19:41:58.9054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5AKAhyMejZA/s3k221JgIJrVcWSATHIjTqspLQgNNLweG4Snxwfbw+G7LLR45yfgI70wMzlp06ih+j8/IgOtfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7809

Introduce the new helper nearest_node_nodemask() to find the closest
node in a specified nodemask from a given starting node.

Returns MAX_NUMNODES if no node is found.

Suggested-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 include/linux/numa.h |  7 +++++++
 mm/mempolicy.c       | 31 +++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/include/linux/numa.h b/include/linux/numa.h
index 31d8bf8a951a7..e6baaf6051bcf 100644
--- a/include/linux/numa.h
+++ b/include/linux/numa.h
@@ -31,6 +31,8 @@ void __init alloc_offline_node_data(int nid);
 /* Generic implementation available */
 int numa_nearest_node(int node, unsigned int state);
 
+int nearest_node_nodemask(int node, nodemask_t *mask);
+
 #ifndef memory_add_physaddr_to_nid
 int memory_add_physaddr_to_nid(u64 start);
 #endif
@@ -47,6 +49,11 @@ static inline int numa_nearest_node(int node, unsigned int state)
 	return NUMA_NO_NODE;
 }
 
+static inline int nearest_node_nodemask(int node, nodemask_t *mask)
+{
+	return NUMA_NO_NODE;
+}
+
 static inline int memory_add_physaddr_to_nid(u64 start)
 {
 	return 0;
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 162407fbf2bc7..488cad280efb3 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -196,6 +196,37 @@ int numa_nearest_node(int node, unsigned int state)
 }
 EXPORT_SYMBOL_GPL(numa_nearest_node);
 
+/**
+ * nearest_node_nodemask - Find the node in @mask at the nearest distance
+ *			   from @node.
+ *
+ * @node: a valid node ID to start the search from.
+ * @mask: a pointer to a nodemask representing the allowed nodes.
+ *
+ * This function iterates over all nodes in @mask and calculates the
+ * distance from the starting @node, then it returns the node ID that is
+ * the closest to @node, or MAX_NUMNODES if no node is found.
+ *
+ * Note that @node must be a valid node ID usable with node_distance(),
+ * providing an invalid node ID (e.g., NUMA_NO_NODE) may result in crashes
+ * or unexpected behavior.
+ */
+int nearest_node_nodemask(int node, nodemask_t *mask)
+{
+	int dist, n, min_dist = INT_MAX, min_node = MAX_NUMNODES;
+
+	for_each_node_mask(n, *mask) {
+		dist = node_distance(node, n);
+		if (dist < min_dist) {
+			min_dist = dist;
+			min_node = n;
+		}
+	}
+
+	return min_node;
+}
+EXPORT_SYMBOL_GPL(nearest_node_nodemask);
+
 struct mempolicy *get_task_policy(struct task_struct *p)
 {
 	struct mempolicy *pol = p->mempolicy;
-- 
2.48.1


