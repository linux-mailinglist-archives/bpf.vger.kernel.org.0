Return-Path: <bpf+bounces-47435-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A4E9F95AE
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 16:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2931916FDB6
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 15:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46AD821D00E;
	Fri, 20 Dec 2024 15:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rNiV/Kgb"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DFF219A9E;
	Fri, 20 Dec 2024 15:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734709322; cv=fail; b=GEfjLBfNYDr7cL4dqTDsOgSnMeE/flgZWIHGYHNa+X3vgRIxWEwiFTQ9u/g30TAl/y8qycGChDMyIGqjHBMZvAjAtq2/N6ruEIk3lf+Cq1vggzCZPCOLIIeAOOuBeH7AkHingmiGZ8T8VJv10FPbkpLX/cfmaPKl3VsmUSsJQnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734709322; c=relaxed/simple;
	bh=KZeK4ClwTny2/gfLMDMRSxisGEdK47Lg3yaRSXWZTTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GF679X68untl3CmwmcAzRK062iPhpGLUKAtZ/2RhTcL3qIZAhzrwe9Rt+boOaMDxPi2N/AlvoX6vV7uZak6yonbirUIad79puO8NHumms5X4cOQdQ+AI+StLAozxuk1GduZbxerTwcv7IxUTmF7nAXveRS1+YjLyJI0nKZUknGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rNiV/Kgb; arc=fail smtp.client-ip=40.107.237.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V7BzjTKktOtY1B0S2//DxF54DWuPmmyAgd1566xH1WFQsZp5WAdF5Xq5MYloE53DKmphByB41lEfTKsqC+NbiKt/6SxI5eDieb89OmDAZJK3LF8AWwt2c6MGRsqz3quP5gJF9mNI98es4VwjVwL/frPtZhOB15NO9dWgHMU3i7bKZaUev2kmkyBxSIYeMS+vbPDhOqLdWcqeDGnH7bUVnwesC2pSS2X/yXhtr8k++Yq2FzVBzClUIloW0uSDIKcuoeptLyZ9bnSgPXW0lKJnMP/q2X2pYnrZGABLQKDlJUkXbqVmJ14qj/G20q0vLgb7v3yIzEffm7F+/bcQRi2gpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ptBiQ1MawOcrAFmtYivwhcV+dm0PWgiQgldTX5dVmAY=;
 b=oEMof54Y0AUPyW2pSdGGkevn65rrWI7JBiyuOJ7zCCwBnE8dItCO7t4WKShoICxrw1orcBzHdUhpV6mt7skSO3LIAtT88nI9jbDQaU9sTQLVS4/z0/1EfqiPp+zeBRVqZiu5ScOBA7r6YOq2O7quzUKYZo8L9rg+jhlJEJH/Zn8Kfik79giP4VFsm23PKOhLra3Lit88Vpy5cmCBYH/pIO204PkkiJqcKTf2+otnhziUDnRg1pwDbwDc6LpP6r0QR0JeFDM6Kj+BFRZYqTsuejl9vIgO+Y5fnou2/1sZrNoCJ66HjQYjuD82Mact/ssp0FYjNoiL5ZebNmnxs2DyzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ptBiQ1MawOcrAFmtYivwhcV+dm0PWgiQgldTX5dVmAY=;
 b=rNiV/KgbpWYVV3mrHUzt5GQHvfKiPUKnQZ13cOJnCH5Uqe51bB0OGNwD0uQBvyGcJv8x0BtWAq1jAkG4e4FueYbMEGxGvd8JxiO9Df1p7GFl0JfGtTHXPLDJQ/5OWCwOnKKMPyGSw29b1/K+RtNl+RmDODbpJl8cCXMcfHI0XnCbRA7syHtlUhB9M116lQRXfn6ROmPO/riAgfMwDV/95C/cNY3ry6lIpxr86O7wBitd4K/oD2CQsVlwp0qtMxxHTUGbFh36YmryWwON36WTMJPdPA4kLK3JfVoBnPQDy7xrOQqEI8O5LVWmc6u7/jkM3aCUzRL/r+PeAfIQ/r/0VA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by SA1PR12MB7149.namprd12.prod.outlook.com (2603:10b6:806:29c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Fri, 20 Dec
 2024 15:41:58 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%3]) with mapi id 15.20.8272.005; Fri, 20 Dec 2024
 15:41:58 +0000
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
Subject: [PATCH 10/10] sched_ext: idle: Introduce NUMA aware idle cpu kfunc helpers
Date: Fri, 20 Dec 2024 16:11:42 +0100
Message-ID: <20241220154107.287478-11-arighi@nvidia.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220154107.287478-1-arighi@nvidia.com>
References: <20241220154107.287478-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0179.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::16) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|SA1PR12MB7149:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ee63f29-8376-4011-19ca-08dd210cd680
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q2ZkoiwNzu5H4FTLFSPsOQxzehhwHOq4DhQ3VS4JUJMN9JcDcbex3WLUK4tO?=
 =?us-ascii?Q?/OuNQlaBbO1BH+f28cpb8bGrPgItFKAgVLFd6cKzlPokNrviSRg3jgh5ncZ0?=
 =?us-ascii?Q?6eIm5IRBdiXwFygLbhH1c9sdWfn6mhO4IjCd32o6ZDdWqgOFmDa2srfoXqLM?=
 =?us-ascii?Q?vNzHEjWWP9nEwd0tsqG9zTmTJSAiIrEDVDp2qkzC826f0BTQIoyeM3QVz9mN?=
 =?us-ascii?Q?lLkTwAZBwwpceAXvpo+NhrDMCacqDr2K6JraeBY5/Px4WWGtT5itdFisP9Vh?=
 =?us-ascii?Q?Jf5+dzwHaUMwyLJxGeObCLlIAhDQyyWAEkjZ1sNL3tQJSjfClDYqXwbUFp4l?=
 =?us-ascii?Q?mLWQ+CeM6lbD6FnydqzGwZ6d5v0TOSrz4RgcCv8BGP2NQYUBto+AGAEDJwzQ?=
 =?us-ascii?Q?y0z6Z+vkbqmkkmWkTvRqJsLHTr9laqbZew9/856ohMyq0S3wmGwjhulwoVUs?=
 =?us-ascii?Q?pDGUafMGBzrokyBa10AWxXvi94KRn8kxh/z7Jg6PXsmyutI1qejsoFqdeWBe?=
 =?us-ascii?Q?XEP0aTb3a4szZyHxB/RlEWYLZUU/GEpa8/LJ+OS1PneMwwwg3yovBnjFJS/U?=
 =?us-ascii?Q?JPcGxFMOQQgif4H/R+4nE+usj8urQLoKRPrfv+Py47bo/rwNXuK9jQqFgB9b?=
 =?us-ascii?Q?NkWIRQ1U5QSp9SalOxYnuRZiRhzOgRlpCtvv/G2WIkHzP/rbvvXqdexHJ6Or?=
 =?us-ascii?Q?kY7oBvFxsS9JfEpEhMgEMucFQXwhn3le9NFwoZKRhzKozmPrfAg5jncaKxMy?=
 =?us-ascii?Q?gs4kCga58nsCdz2BTxa8owjxNA75wzbDDr8nqNt5ULQWRbGSXwM04ofaBh8+?=
 =?us-ascii?Q?9WJpkY8AUE6+E3fltLaHr4lvKT1oj8deNOzqEr8DZhLU+A6Bfia0X1nAa5nN?=
 =?us-ascii?Q?ddhLIlT+dljkhFh638bwLqya8l2ZRxd1g9OMA5z2/XrKDOF0BnDEH5Xdc/tK?=
 =?us-ascii?Q?AtoIe1gSiBv9MoeVuVmWr3Ir4yZQNdwKXiE1wXzzzVD3wiwuoIU9nYr/49xc?=
 =?us-ascii?Q?WFfqy41G29guFzRLCJYjbkrpOK56Bq2mNTTgTVh3TMM2sUKU7hdwLOeImXJO?=
 =?us-ascii?Q?Oej/kniOnJVvUrMr9IItgKW6KHSlTXVaneJ2YGLi83/lYYt+NdKxenLGhtWE?=
 =?us-ascii?Q?DDCtz6yu82raA4ka0gB3q1wBU8Yv4B8pL6wxZTpeeSTBOA0Xh/9C09Q7bAkB?=
 =?us-ascii?Q?Snhn2v9g40tJvTsv33GZDQrB/F8qdK5rVpYlzhVl4Quc16fKu3Emgrqqkyf8?=
 =?us-ascii?Q?0gXFskBM8IF9zbaXfym8PS+02akoAZYOD5prozbGabzKjnzHU9SbzIKMNSGW?=
 =?us-ascii?Q?K5bX6o26jTqcu0qNJxpWaURlh9r1DGSx2az2ambBiH7ddZ2FHQk7GfhWTqm+?=
 =?us-ascii?Q?ab+vPcwtes7JGcj83p02qhZGzRLz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cYVSP2IXFJLuQfs9ebd34xI/Yw5JI9u1/7RU7+fE5Wos83E7sG+hrH+uYi61?=
 =?us-ascii?Q?yf8DaUWkJUGF6h0vBCv40VBaS0vweYK1Xpt8c09yQiBKnbpCRCbur6Lp9h/l?=
 =?us-ascii?Q?LS9UMugXBnwXZyJ9O/6dkrCkEpEVstBXNk0sOOPhDWykLd84DU3Se2VyUaxM?=
 =?us-ascii?Q?SMvSR6EL9ZGI4wtAVbWEfnQQcZRcgVfMHnJEZAPdXvjlVs+0YNp2unAJ2oKb?=
 =?us-ascii?Q?JByG3d2JVGBSk/rnPpyc1dpHwfuxVWwt5K+bsFYxx5G222w0GVp0HkfLY+Q2?=
 =?us-ascii?Q?0PTiSL0uxorVmnxLmw/4LB5kZDm4Gx6pm7YmwjW3NBS+m03wdgmnHJcsP15p?=
 =?us-ascii?Q?xvUjaMIIvNszexD3eH4hvFNYOh0yft1P/emCXv2/DpyNEcD/WDqL6YZgTuJb?=
 =?us-ascii?Q?ekAFw9toDtuMrcSjnWdciGdKeS39BOuClh/O9RX5qLxDqvfkMxjlepc6nLdF?=
 =?us-ascii?Q?aYViStvKfbYANK+oQB3Jv93tR9T+Iwt9ECztLyMXOjU739wsnyU+RzAdZ/Qa?=
 =?us-ascii?Q?DtBup88DA0GEOQwFPpS0dpDbKVEHm8dtr4jtjPVg4STZxSKSsIB2Q3a+K850?=
 =?us-ascii?Q?Ja8Ha3fbeXPt+5yIgdZhCJEp27Z+sc3qnIL9G+xDiconYCs8hBIOsgkYNk4l?=
 =?us-ascii?Q?pJT80xJ3uJ0sS3rpqo09JLLuUwJrHOfpdAYpsS8GGyE3rK5e82wfxcFWG3F+?=
 =?us-ascii?Q?4qYqErhAu+2ealAAHJGj6QpEx3j2SUpx5S7tOXeOWIXds5uVyVbJr2kFT3iT?=
 =?us-ascii?Q?z/VYLqqDMSWfb6zPySelSFhdZtUEnKT2/lHk6TCvAVUGDRECprLeDK9vx25D?=
 =?us-ascii?Q?G52uBNWiDeVUuB+YJ1237+fHqR+aqDlCKAAAbllY9IPkWJggXineNlZMxybx?=
 =?us-ascii?Q?WWVCIhTwA86oq0EXXPQ9OdPSWQpuc5tGGtE5AWhwlv3sVULbe0N/grVCvq3y?=
 =?us-ascii?Q?lMulgLH8jtG7duTfTaEBbaTVfFP/sjXvNkEhCMFYmilM2AVtjkmcN1xzL/FV?=
 =?us-ascii?Q?PbnhPG4iBV0MAsEXU95sTjYIJA5HTqp6E0v44Z//uW/vLAU+77rUeqgzgxna?=
 =?us-ascii?Q?AHI4Uy1Oayo/V4xHfTrEkYoWx8/wx3q4aQmkRjVTtndAxNtikL+ZKypWN5g0?=
 =?us-ascii?Q?ytttmn7y12Clz60hVk/I6cJqJBFvpqsFMlhHINhD1nsefRilkUZ0SCuMXqS6?=
 =?us-ascii?Q?8DIl3J9L9h+ZIymtJ6sYBiTxUsYGh4297p1T85XXsy2eTH/Eim1yeEv2HQGM?=
 =?us-ascii?Q?PceD6kwBY8ZOD3/PImUM3+VFkMmYhX0T8gqH5/rQ6l4U82MgDyiTIUP4XEvz?=
 =?us-ascii?Q?SDYk4OH7aubIN1SeQ1wxAptR8YveYa8eKY0+mgg3D60vUAF78QRphe4dM2u1?=
 =?us-ascii?Q?80b1RfzOnya9LrKsuLYqEKVrSFBmekZ3qy14FFy4GHLVY+GBBXT+fDkNm5ow?=
 =?us-ascii?Q?HGUJa2bk/HFufuaq7uGlgT14u2rQV6ep8/vqLK5TlNYOsmashDhR++GehVvb?=
 =?us-ascii?Q?Py8S1WUQxGoGU6mp4leOMs20MbqeVqKLzVXGHJ/CiMNJHi5whLd2SgkVgx+j?=
 =?us-ascii?Q?loRWNV2KmfjuaPt/ssXRlh8anZ0i2qc7b/3t1MM8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ee63f29-8376-4011-19ca-08dd210cd680
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 15:41:58.0859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jOMiYvg9Q7YmgrsvlHJpoinQaPs97R8v2/Et1EfAbh3XRMHU/9sXCmigaUw2KhvRlISkgr1qs4///9i2Be7o7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7149

Add the following kfunc's to provide scx schedulers direct access to
per-node idle cpumasks information:

 const struct cpumask *scx_bpf_get_idle_cpumask_node(int node)
 const struct cpumask *scx_bpf_get_idle_smtmask_node(int node)
 s32 scx_bpf_pick_idle_cpu_node(const cpumask_t *cpus_allowed,
				int node, u64 flags)
 int scx_bpf_cpu_to_node(s32 cpu)

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext_idle.c                  | 163 ++++++++++++++++++++---
 tools/sched_ext/include/scx/common.bpf.h |   4 +
 tools/sched_ext/include/scx/compat.bpf.h |  19 +++
 3 files changed, 170 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index b36e93da1b75..0f8ccc1e290e 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -28,6 +28,60 @@ static bool check_builtin_idle_enabled(void)
 	return false;
 }
 
+static bool check_builtin_idle_per_node_enabled(void)
+{
+	if (static_branch_likely(&scx_builtin_idle_per_node))
+		return true;
+
+	scx_ops_error("per-node idle tracking is disabled");
+	return false;
+}
+
+/*
+ * Validate and resolve a NUMA node.
+ *
+ * Return the resolved node ID on success or a negative value otherwise.
+ */
+static int validate_node(int node)
+{
+	if (!check_builtin_idle_per_node_enabled())
+		return -EINVAL;
+
+	/* If no node is specified, use the current one */
+	if (node == NUMA_NO_NODE)
+		return numa_node_id();
+
+	/* Make sure node is in a valid range */
+	if (node < 0 || node >= nr_node_ids) {
+		scx_ops_error("invalid node %d", node);
+		return -ENOENT;
+	}
+
+	/* Make sure the node is part of the set of possible nodes */
+	if (!node_possible(node)) {
+		scx_ops_error("unavailable node %d", node);
+		return -EINVAL;
+	}
+
+	return node;
+}
+
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
 #ifdef CONFIG_SMP
 struct idle_cpumask {
 	cpumask_var_t cpu;
@@ -83,22 +137,6 @@ static void idle_masks_init(void)
 
 static DEFINE_STATIC_KEY_FALSE(scx_selcpu_topo_llc);
 
-/*
- * Return the node id associated to a target idle CPU (used to determine
- * the proper idle cpumask).
- */
-static int idle_cpu_to_node(int cpu)
-{
-	int node;
-
-	if (static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node))
-		node = cpu_to_node(cpu);
-	else
-		node = NUMA_FLAT_NODE;
-
-	return node;
-}
-
 static bool test_and_clear_cpu_idle(int cpu)
 {
 	int node = idle_cpu_to_node(cpu);
@@ -613,6 +651,17 @@ static void reset_idle_masks(void) {}
  */
 __bpf_kfunc_start_defs();
 
+/**
+ * scx_bpf_cpu_to_node - Return the NUMA node the given @cpu belongs to
+ */
+__bpf_kfunc int scx_bpf_cpu_to_node(s32 cpu)
+{
+	if (cpu < 0 || cpu >= nr_cpu_ids)
+		return -EINVAL;
+
+	return idle_cpu_to_node(cpu);
+}
+
 /**
  * scx_bpf_select_cpu_dfl - The default implementation of ops.select_cpu()
  * @p: task_struct to select a CPU for
@@ -645,6 +694,28 @@ __bpf_kfunc s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 	return prev_cpu;
 }
 
+/**
+ * scx_bpf_get_idle_cpumask_node - Get a referenced kptr to the idle-tracking
+ * per-CPU cpumask of a target NUMA node.
+ *
+ * NUMA_NO_NODE is interpreted as the current node.
+ *
+ * Returns an empty cpumask if idle tracking is not enabled, if @node is not
+ * valid, or running on a UP kernel.
+ */
+__bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask_node(int node)
+{
+	node = validate_node(node);
+	if (node < 0)
+		return cpu_none_mask;
+
+#ifdef CONFIG_SMP
+	return get_idle_cpumask(node);
+#else
+	return cpu_none_mask;
+#endif
+}
+
 /**
  * scx_bpf_get_idle_cpumask - Get a referenced kptr to the idle-tracking
  * per-CPU cpumask.
@@ -664,6 +735,32 @@ __bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask(void)
 	return get_idle_cpumask(NUMA_FLAT_NODE);
 }
 
+/**
+ * scx_bpf_get_idle_smtmask_node - Get a referenced kptr to the idle-tracking,
+ * per-physical-core cpumask of a target NUMA node. Can be used to determine
+ * if an entire physical core is free.
+ *
+ * NUMA_NO_NODE is interpreted as the current node.
+ *
+ * Returns an empty cpumask if idle tracking is not enabled, if @node is not
+ * valid, or running on a UP kernel.
+ */
+__bpf_kfunc const struct cpumask *scx_bpf_get_idle_smtmask_node(int node)
+{
+	node = validate_node(node);
+	if (node < 0)
+		return cpu_none_mask;
+
+#ifdef CONFIG_SMP
+	if (sched_smt_active())
+		return get_idle_smtmask(node);
+	else
+		return get_idle_cpumask(node);
+#else
+	return cpu_none_mask;
+#endif
+}
+
 /**
  * scx_bpf_get_idle_smtmask - Get a referenced kptr to the idle-tracking,
  * per-physical-core cpumask. Can be used to determine if an entire physical
@@ -722,6 +819,36 @@ __bpf_kfunc bool scx_bpf_test_and_clear_cpu_idle(s32 cpu)
 		return false;
 }
 
+/**
+ * scx_bpf_pick_idle_cpu_node - Pick and claim an idle cpu from a NUMA node
+ * @cpus_allowed: Allowed cpumask
+ * @node: target NUMA node
+ * @flags: %SCX_PICK_IDLE_CPU_* flags
+ *
+ * Pick and claim an idle cpu in @cpus_allowed from the NUMA node @node.
+ * Returns the picked idle cpu number on success. -%EBUSY if no matching cpu
+ * was found.
+ *
+ * If @node is NUMA_NO_NODE, the search is restricted to the current NUMA
+ * node. Otherwise, the search starts from @node and proceeds to other
+ * online NUMA nodes in order of increasing distance (unless
+ * SCX_PICK_IDLE_NODE is specified, in which case the search is limited to
+ * the target @node).
+ *
+ * Unavailable if ops.update_idle() is implemented and
+ * %SCX_OPS_KEEP_BUILTIN_IDLE is not set or if %SCX_OPS_KEEP_BUILTIN_IDLE is
+ * not set.
+ */
+__bpf_kfunc s32 scx_bpf_pick_idle_cpu_node(const struct cpumask *cpus_allowed,
+					   int node, u64 flags)
+{
+	node = validate_node(node);
+	if (node < 0)
+		return node;
+
+	return scx_pick_idle_cpu(cpus_allowed, node, flags);
+}
+
 /**
  * scx_bpf_pick_idle_cpu - Pick and claim an idle cpu
  * @cpus_allowed: Allowed cpumask
@@ -785,11 +912,15 @@ __bpf_kfunc s32 scx_bpf_pick_any_cpu(const struct cpumask *cpus_allowed,
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(scx_kfunc_ids_select_cpu)
+BTF_ID_FLAGS(func, scx_bpf_cpu_to_node)
 BTF_ID_FLAGS(func, scx_bpf_select_cpu_dfl, KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_get_idle_cpumask_node, KF_ACQUIRE)
 BTF_ID_FLAGS(func, scx_bpf_get_idle_cpumask, KF_ACQUIRE)
+BTF_ID_FLAGS(func, scx_bpf_get_idle_smtmask_node, KF_ACQUIRE)
 BTF_ID_FLAGS(func, scx_bpf_get_idle_smtmask, KF_ACQUIRE)
 BTF_ID_FLAGS(func, scx_bpf_put_idle_cpumask, KF_RELEASE)
 BTF_ID_FLAGS(func, scx_bpf_test_and_clear_cpu_idle)
+BTF_ID_FLAGS(func, scx_bpf_pick_idle_cpu_node, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_pick_idle_cpu, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_pick_any_cpu, KF_RCU)
 BTF_KFUNCS_END(scx_kfunc_ids_select_cpu)
diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index 858ba1f438f6..fe0433f7c4d9 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -63,13 +63,17 @@ u32 scx_bpf_cpuperf_cap(s32 cpu) __ksym __weak;
 u32 scx_bpf_cpuperf_cur(s32 cpu) __ksym __weak;
 void scx_bpf_cpuperf_set(s32 cpu, u32 perf) __ksym __weak;
 u32 scx_bpf_nr_cpu_ids(void) __ksym __weak;
+int scx_bpf_cpu_to_node(s32 cpu) __ksym __weak;
 const struct cpumask *scx_bpf_get_possible_cpumask(void) __ksym __weak;
 const struct cpumask *scx_bpf_get_online_cpumask(void) __ksym __weak;
 void scx_bpf_put_cpumask(const struct cpumask *cpumask) __ksym __weak;
+const struct cpumask *scx_bpf_get_idle_cpumask_node(int node) __ksym __weak;
 const struct cpumask *scx_bpf_get_idle_cpumask(void) __ksym;
+const struct cpumask *scx_bpf_get_idle_smtmask_node(int node) __ksym __weak;
 const struct cpumask *scx_bpf_get_idle_smtmask(void) __ksym;
 void scx_bpf_put_idle_cpumask(const struct cpumask *cpumask) __ksym;
 bool scx_bpf_test_and_clear_cpu_idle(s32 cpu) __ksym;
+s32 scx_bpf_pick_idle_cpu_node(const cpumask_t *cpus_allowed, int node, u64 flags) __ksym __weak;
 s32 scx_bpf_pick_idle_cpu(const cpumask_t *cpus_allowed, u64 flags) __ksym;
 s32 scx_bpf_pick_any_cpu(const cpumask_t *cpus_allowed, u64 flags) __ksym;
 bool scx_bpf_task_running(const struct task_struct *p) __ksym;
diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
index d56520100a26..dfc329d5a91e 100644
--- a/tools/sched_ext/include/scx/compat.bpf.h
+++ b/tools/sched_ext/include/scx/compat.bpf.h
@@ -125,6 +125,25 @@ bool scx_bpf_dispatch_vtime_from_dsq___compat(struct bpf_iter_scx_dsq *it__iter,
 	false;									\
 })
 
+#define __COMPAT_scx_bpf_cpu_to_node(cpu)					\
+	(bpf_ksym_exists(scx_bpf_cpu_to_node) ?					\
+	 scx_bpf_cpu_to_node(cpu) : 0)
+
+#define __COMPAT_scx_bpf_get_idle_cpumask_node(node)				\
+	(bpf_ksym_exists(scx_bpf_get_idle_cpumask_node) ?			\
+	 scx_bpf_get_idle_cpumask_node(node) :					\
+	 scx_bpf_get_idle_cpumask())						\
+
+#define __COMPAT_scx_bpf_get_idle_smtmask_node(node)				\
+	(bpf_ksym_exists(scx_bpf_get_idle_smtmask_node) ?			\
+	 scx_bpf_get_idle_smtmask_node(node) :					\
+	 scx_bpf_get_idle_smtmask())
+
+#define __COMPAT_scx_bpf_pick_idle_cpu_node(cpus_allowed, node, flags)		\
+	(bpf_ksym_exists(scx_bpf_pick_idle_cpu_node) ?				\
+	 scx_bpf_pick_idle_cpu_node(cpus_allowed, node, flags) :		\
+	 scx_bpf_pick_idle_cpu(cpus_allowed, flags))
+
 /*
  * Define sched_ext_ops. This may be expanded to define multiple variants for
  * backward compatibility. See compat.h::SCX_OPS_LOAD/ATTACH().
-- 
2.47.1


