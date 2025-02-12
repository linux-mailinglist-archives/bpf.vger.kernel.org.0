Return-Path: <bpf+bounces-51281-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04540A32C84
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 17:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22CF23AC063
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 16:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC1E2586C6;
	Wed, 12 Feb 2025 16:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KQ9OIyz6"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE5725D55D;
	Wed, 12 Feb 2025 16:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739379061; cv=fail; b=l5WTcDicVvNgNf4bzKKjTt0QCjTZMGylRGnIdNLaEvk+P5q5xNxpT5bCQRyFBA7gu3fgPj5y5emHsw1uHoIGqs5c1FlRPg0W3Zx18GrIOxN9zPAU2K0LpX7MFy01gj+vETaR5Im8CAaKdCdqGnED2KALbGWk0i9jNLQdhNEiMXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739379061; c=relaxed/simple;
	bh=f7P4YsMA9DG0ZgqxE4kBSE8GQghPxnS/+0mguCbqt2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Bg3WL5nfoExp54QjzoyLf4KwF/jGnbewyAfTfmjVizQPijYAeYPsaPUF43TNtEO/TJt9+n53JbN3Y2UZPDo7clqSRZdwPA+kgeCAibBUIxPHKnsmUVBCV5UffH44T6KTGalN0SjnpFny3aDESN97Gq41Vg+iqJjYxhMorNlU+HA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KQ9OIyz6; arc=fail smtp.client-ip=40.107.243.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CfqRPN+iXyxOFmLzF6ZLaMry/0vkvuQrJHdsohSc2x1Ptmp33Ix0gefvljMFenYd9oMyuwXcDjTnqligKKJk1QXi5S/GoxtKLEhJE48lYXFZL9L+lwXmPmPpvD5Ke8dUS0oOfrobtzUVUutWIZ/c/9DH3cnhiYe0E8SWim8zBvH/BfQZUMz/q87OjxlyjisJ6F7jEBh5KMmRKSfascbbB4wBVgZeYMZYN5FBhnmkHwuEFRkBeo/xUa9xo3z0rjOtPF8mb5YpT/oMvIO8Zr4oNpO3fvFTgwWU8lhowd4yr+N4JnkEW28yjkMkusbd4rZwsPeAMPQC7j6UHx4s2eLinQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/P95eemkoCMeQkTHVpFli+I2Z/x52iw1omsrhj524sU=;
 b=ocC/orYkBOWXCxZpR1rUtOTjWyML+N8NI4Sfs45FFpx+NyRlLTgY3yCO9Hlx78VO6DsvSTnFcZIO7U5pxh/zBV7+mlsRpBkV2zB1ux508f95hW1iCWQe+IUKZ+5/aqNS/HU7a+2g60h3l2NN+CclNZhgcEMK6HNabAH3dS+lo6ElMm+KmmmUBowYenfwUVddR82M6ncqkooZi9XLqJm/rqU2KMFOU6ifVXKClCQOP2h+SpUecwwdZb1VXWqKVa6AGgsNRA8Ao5p3CZpFaOu/nEBAm8mFhQnsL+EgqdxyoRqBi6zBV83Db0z77HSuY9gN8KcO+pqN4Qom9VlMs5EgWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/P95eemkoCMeQkTHVpFli+I2Z/x52iw1omsrhj524sU=;
 b=KQ9OIyz6r2Gg2MVJNorkr0U/sZW7bqYbvJ5Pro8ydmVVHsH/nIY8XcSUISU/q59Psnbl3fBRmrM9NOVIecuebImte4BBPTZdEN5usw1lHJiBGg33rlGJwISVec6jvEWK2V2qI1gB2Gsf7jiY878XwYYWoHzczcVT+0zYcoAExHwC8zu47uIExPfkbH0s3qCIPvY7rByvfGuMlWfPLb1T5R0iiWsF/XIDYxhHZOLhccQlDGZ5PCizNlckChn1F5rQmjNZwmgHgR2ZoBGnJBZKWrBzXvAwRSBOCrGfIHY5H8QsrDpAk8pwCEhv9/epIaX7dbANwOgKt3vj3Rbu0LDNZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by DS0PR12MB8197.namprd12.prod.outlook.com (2603:10b6:8:f1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Wed, 12 Feb
 2025 16:50:57 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8445.013; Wed, 12 Feb 2025
 16:50:57 +0000
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
	Joel Fernandes <joel@joelfernandes.org>,
	Ian May <ianm@nvidia.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 7/7] sched_ext: idle: Introduce node-aware idle cpu kfunc helpers
Date: Wed, 12 Feb 2025 17:48:14 +0100
Message-ID: <20250212165006.490130-8-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250212165006.490130-1-arighi@nvidia.com>
References: <20250212165006.490130-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0188.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::9) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|DS0PR12MB8197:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ba6c916-7f5e-4a27-06c4-08dd4b856c00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ddKqmBIQ6SaU3ncB+Ceg2r4PZjOkcJWWXzj5+d3xvU3gKHyvy0KCS2jNIjJa?=
 =?us-ascii?Q?XgXAqY3F29p0u/is5uvGHybMhmcpJ8eitFY8/nksmth5bN1RiPiBxhQzWxls?=
 =?us-ascii?Q?AcSDOlL8OjpXJtPLo3FecDesnzk622BJdzhsOLi9HnDyF3sPSbJleb98D8s6?=
 =?us-ascii?Q?/vrmCxUtuEDC4y0XSqsySg7luX2syI03aL7z+lOWRSmQFfrqAuSPIS3YwCuq?=
 =?us-ascii?Q?n6ADhOF+s+heDUVZz42NymXrVYdxSQkoYD7YzE6XLoid0zE4pWWs0wzH7Yme?=
 =?us-ascii?Q?0+iS52GSsUvdTX/CxnXlyhdxHdyopFlC4PUpmXxqiEnf+VZDQQ2Dblit4f/5?=
 =?us-ascii?Q?v2DT3K3uON9UK6eKTlUUM9m9T+jSh3ZQJ7t+fw8w7UF9/gDIGK4r2VXSCuwo?=
 =?us-ascii?Q?jIBxla71c9r3lM3j5LK5Pnpz+iLWttaUfmmypklQPJ8gRISg+GoMGv5Ch4Av?=
 =?us-ascii?Q?a/kJ9Y/Apbp6Esyl6g5Q2rRdRyGBHy+r/2bvHdDLZpRNLFvhCHA5DSFuuvDa?=
 =?us-ascii?Q?J1naEx2iw5REoW9lTfCwzBtZBX7y9tdOhrFTBhkuPoWfvKBY9WvYxWxfgt7e?=
 =?us-ascii?Q?N2EZoMXItHexchxxD/bAOG4/PgLcRO2zvJIRVC9SEjSx/tt0gOEGUWnTInCv?=
 =?us-ascii?Q?mSH6peaIT/oftwzM7dqBKtXAcfuVQo0cp1j0z2lrWRS2hI/2ewo5nQuxiUme?=
 =?us-ascii?Q?7aWnRnsxa10C8F2tv+e5ADA9C/3MRDK4qfT5c9SP9LcSdltO6lwThjR5o9iw?=
 =?us-ascii?Q?mEIYEA/Ht1r0txv9Vo7oV7blVPXuhfsyFwnrWc7NoJYK8IqqynfM+rjXsV33?=
 =?us-ascii?Q?L3jTjtUebLdNI3oT9EUOCyjD4olSGWqqW7GjGJoqJ72390pYJ5ZLNGY6xXdV?=
 =?us-ascii?Q?DFZ1dL7W4LPk6Kuh/WklwVwWCNyXfX94FRZWXa66WnP7e7fW4eFLR9Duttc+?=
 =?us-ascii?Q?qVgCXTuS25MePf43anFMvrg1ivLLigPKDiqQsp+H1zGAyYkQ48NKN+FwElJz?=
 =?us-ascii?Q?ksj77ji5h8xu+ZJCYOFz+HwKTTx3jLllPCxlco4z4WUAIT5wlEDsv7YgGx0U?=
 =?us-ascii?Q?5fzSGzqZpeAKCg7RhZ87NyQCmmzskyP3hH8LPN17p73TkAgakoQecj5ADlKf?=
 =?us-ascii?Q?Bh4s+HIeccmd8q5FHK1CCWFcqmzaP9+mW02BSK4RTdsHfNDqvc26iJZeQEHe?=
 =?us-ascii?Q?7updFHV2xbsZI6yxfESHk5/jGNbK5WiFRNaCinHiJtpmFEf0UdBPnPgfyeDZ?=
 =?us-ascii?Q?SqZg9+mbsjStHYSSiY+dM/6H1Myk72po+tzfSCXbrQYjYDYyOIhtqHMV8BxD?=
 =?us-ascii?Q?IXWpOA8SXQi2wvUMx6ucNXB3kLixVyeqma5VDDVagHZEh4bMKnmlnRzwWUD+?=
 =?us-ascii?Q?Jj1J+Vy2XEr7PIqTTe7+xgZa3ieL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?juRGAs6h+lcOSbXg0VMlF1xic5lVjhJSo773FfN1ZxlxYhHnwY20nzFW52YH?=
 =?us-ascii?Q?MPXg7V7vswXXbkFCKECKyKSbVS1nFBbjZ09JHXwogwO7GXkP7vakkYO9ZKhu?=
 =?us-ascii?Q?b+5J/5Av86uviJtBuO+92JBDga6Z1Gzu6PgABSsP5v9ALQ7P86YlPzmKNnGw?=
 =?us-ascii?Q?aGfhgEdnTtw8VO4vqKr7osgNtzvyMmquuOlDHW/+nEJrv9PU8RQcIGDvsCP6?=
 =?us-ascii?Q?YiCkwWR8+z82vKka8DwBuRIFsWyeAnZ+S/CXUYurdC/W+7AVQNynRwvf/1wT?=
 =?us-ascii?Q?vthwRxLi0ri1oFlu4W2f3MTCLmAN2nqY1RGr9Y+/j8ZAa6+SGmlZDzTeyB4C?=
 =?us-ascii?Q?xKJr/arKKq2eqD2fWcgq90XPNj3Qh8U1PLoX/6rO4I/SxYRUUXX7VAxGTge9?=
 =?us-ascii?Q?ScyooGYN4YgqykvlNt1cPyCPZuyQ6BuJeplke/C0ItW/5/5xXY4rvurwxY0l?=
 =?us-ascii?Q?qI99EeffaM2Ez+frEIePRe96Jjp0vCXN/HYmfJyJna1OYv7FRqe18oKS6gsT?=
 =?us-ascii?Q?ezvNz5JgKh83aqmUmUx4ZEeBeNWnZukyffppzPt83/cyxYZMM9PLQxKct4tv?=
 =?us-ascii?Q?pHA0KCdGe4nWt2GL8cpC+6dSFxpFbbZD+or4WVA6OdnGnNwbM/qFu6wQAwCX?=
 =?us-ascii?Q?T3v6hUcBLJ3UjW+frta94oxfV9QBdG2DXHmkHh6TechOuaPM+tmIrIaPCB39?=
 =?us-ascii?Q?dyZipm9iEYrBu9iusDsKpK88gXLtvbjpBqqiNPjRop7DcOelT+vhNGqAKLqH?=
 =?us-ascii?Q?ZUXVUm84fJDPv//SkdqYEgHbu+jtSywkgJFmmOI/BicWcPuSKQbPPVOeM56M?=
 =?us-ascii?Q?ayvNQkQyVsBpm3Id21/X2WUJFXCIf3Qqj+rI+ATSpifA1z4YImD5yWX5mcVt?=
 =?us-ascii?Q?4x0iicZvqgzZ/0h+ui9RmbPFzRV2S7aL9gnVXE5IC+LX8v+IUlnCr8ypndnF?=
 =?us-ascii?Q?MqT1J0E5KTx5tZ0j/h0RqX2eCb/TKvbqHG5Y9LoWqWxMon32Ddal/aeqhRNz?=
 =?us-ascii?Q?+VEKlnJPz2MrOc669VlHBIkZRgr0u5nci/JRmLjK7pPWTdN/qZ5MVNMXi5/M?=
 =?us-ascii?Q?RFQ5g/vFVE7NUCC/NvmacM4KkeJCS0wUi9iOOHUN91NSxLpUAuZDAJkyaQGG?=
 =?us-ascii?Q?aEwLFFs21kjg/mdjVqEl5ti36POvSKK1qK1tVZ/A8IOl90qEuAN3NruululI?=
 =?us-ascii?Q?lk+gsWiMQLEE8uA5FoQ2l5asWUWDDKENPeJ9R+eCOqjl7ipSS00OwjHoWUUg?=
 =?us-ascii?Q?UDZzOS0FppwwuQAda7K0rH3oZXhK9i/YclgN4izbADWJTL3BOD3be7eN/w5s?=
 =?us-ascii?Q?frWf1n+5ik5zi5pVnWb8Qo2e8FZnGJgRcRUGEdRG+x1eyf9lLEi3KArvnjdS?=
 =?us-ascii?Q?gxD5r6igV3UqDdS3evIDgDkJseRROAuCgwff7ACGAh1XLl9WnRwmOXT5hdQO?=
 =?us-ascii?Q?uy4In+TGacPmYfyFkfJtERI/IfVxU50iuWJ7OmTRQPK85z6P9l68AN8iy7SL?=
 =?us-ascii?Q?SLHcnQjLISsa3BsspNOiAa5OIS/owWx29U+HnSjdz8eH1ZAESNEtC2Vi8wEi?=
 =?us-ascii?Q?Sap1vxrsJ0tHxIHLLtj1Y20oFFQwgPChKpmZNzBX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ba6c916-7f5e-4a27-06c4-08dd4b856c00
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 16:50:57.3269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1YG0gq8KhA8zvBPZimVP3MzPLcNX0TuuqbBUBWSE38PNvbtD9lh3ZFCSVO2Jokc1un4l19AORXyxn1SydmFc5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8197

Introduce a new kfunc to retrieve the node associated to a CPU:

 int scx_bpf_cpu_node(s32 cpu)

Add the following kfuncs to provide BPF schedulers direct access to
per-node idle cpumasks information:

 const struct cpumask *scx_bpf_get_idle_cpumask_node(int node)
 const struct cpumask *scx_bpf_get_idle_smtmask_node(int node)
 s32 scx_bpf_pick_idle_cpu_in_node(const cpumask_t *cpus_allowed,
 				   int node, u64 flags)
 s32 scx_bpf_pick_any_cpu_node(const cpumask_t *cpus_allowed,
 			       int node, u64 flags)

Moreover, trigger an scx error when any of the non-node aware idle CPU
kfuncs are used when SCX_OPS_BUILTIN_IDLE_PER_NODE is enabled.

Cc: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext_idle.c                  | 180 +++++++++++++++++++++++
 tools/sched_ext/include/scx/common.bpf.h |   5 +
 tools/sched_ext/include/scx/compat.bpf.h |  31 ++++
 3 files changed, 216 insertions(+)

diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index d028fa809fe1d..8196c533c983d 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -721,6 +721,33 @@ void scx_idle_disable(void)
 /********************************************************************************
  * Helpers that can be called from the BPF scheduler.
  */
+
+static int validate_node(int node)
+{
+	if (!static_branch_likely(&scx_builtin_idle_per_node)) {
+		scx_ops_error("per-node idle tracking is disabled");
+		return -EOPNOTSUPP;
+	}
+
+	/* Return no entry for NUMA_NO_NODE (not a critical scx error) */
+	if (node == NUMA_NO_NODE)
+		return -ENOENT;
+
+	/* Make sure node is in a valid range */
+	if (node < 0 || node >= nr_node_ids) {
+		scx_ops_error("invalid node %d", node);
+		return -EINVAL;
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
 __bpf_kfunc_start_defs();
 
 static bool check_builtin_idle_enabled(void)
@@ -732,6 +759,23 @@ static bool check_builtin_idle_enabled(void)
 	return false;
 }
 
+/**
+ * scx_bpf_cpu_node - Return the NUMA node the given @cpu belongs to, or
+ *		      trigger an error if @cpu is invalid
+ * @cpu: target CPU
+ */
+__bpf_kfunc int scx_bpf_cpu_node(s32 cpu)
+{
+#ifdef CONFIG_NUMA
+	if (!ops_cpu_valid(cpu, NULL))
+		return NUMA_NO_NODE;
+
+	return cpu_to_node(cpu);
+#else
+	return 0;
+#endif
+}
+
 /**
  * scx_bpf_select_cpu_dfl - The default implementation of ops.select_cpu()
  * @p: task_struct to select a CPU for
@@ -764,6 +808,27 @@ __bpf_kfunc s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 	return prev_cpu;
 }
 
+/**
+ * scx_bpf_get_idle_cpumask_node - Get a referenced kptr to the
+ * idle-tracking per-CPU cpumask of a target NUMA node.
+ *
+ * Returns an empty cpumask if idle tracking is not enabled, if @node is
+ * not valid, or running on a UP kernel. In this case the actual error will
+ * be reported to the BPF scheduler via scx_ops_error().
+ */
+__bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask_node(int node)
+{
+	node = validate_node(node);
+	if (node < 0)
+		return cpu_none_mask;
+
+#ifdef CONFIG_SMP
+	return idle_cpumask(node)->cpu;
+#else
+	return cpu_none_mask;
+#endif
+}
+
 /**
  * scx_bpf_get_idle_cpumask - Get a referenced kptr to the idle-tracking
  * per-CPU cpumask.
@@ -788,6 +853,31 @@ __bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask(void)
 #endif
 }
 
+/**
+ * scx_bpf_get_idle_smtmask_node - Get a referenced kptr to the
+ * idle-tracking, per-physical-core cpumask of a target NUMA node. Can be
+ * used to determine if an entire physical core is free.
+ *
+ * Returns an empty cpumask if idle tracking is not enabled, if @node is
+ * not valid, or running on a UP kernel. In this case the actual error will
+ * be reported to the BPF scheduler via scx_ops_error().
+ */
+__bpf_kfunc const struct cpumask *scx_bpf_get_idle_smtmask_node(int node)
+{
+	node = validate_node(node);
+	if (node < 0)
+		return cpu_none_mask;
+
+#ifdef CONFIG_SMP
+	if (sched_smt_active())
+		return idle_cpumask(node)->smt;
+	else
+		return idle_cpumask(node)->cpu;
+#else
+	return cpu_none_mask;
+#endif
+}
+
 /**
  * scx_bpf_get_idle_smtmask - Get a referenced kptr to the idle-tracking,
  * per-physical-core cpumask. Can be used to determine if an entire physical
@@ -852,6 +942,35 @@ __bpf_kfunc bool scx_bpf_test_and_clear_cpu_idle(s32 cpu)
 		return false;
 }
 
+/**
+ * scx_bpf_pick_idle_cpu_in_node - Pick and claim an idle cpu from @node
+ * @cpus_allowed: Allowed cpumask
+ * @node: target NUMA node
+ * @flags: %SCX_PICK_IDLE_* flags
+ *
+ * Pick and claim an idle cpu in @cpus_allowed from the NUMA node @node.
+ *
+ * Returns the picked idle cpu number on success, or -%EBUSY if no matching
+ * cpu was found.
+ *
+ * The search starts from @node and proceeds to other online NUMA nodes in
+ * order of increasing distance (unless SCX_PICK_IDLE_IN_NODE is specified,
+ * in which case the search is limited to the target @node).
+ *
+ * Always returns an error if ops.update_idle() is implemented and
+ * %SCX_OPS_KEEP_BUILTIN_IDLE is not set, or if
+ * %SCX_OPS_BUILTIN_IDLE_PER_NODE is not set.
+ */
+__bpf_kfunc s32 scx_bpf_pick_idle_cpu_in_node(const struct cpumask *cpus_allowed,
+					      int node, u64 flags)
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
@@ -870,16 +989,64 @@ __bpf_kfunc bool scx_bpf_test_and_clear_cpu_idle(s32 cpu)
  *
  * Unavailable if ops.update_idle() is implemented and
  * %SCX_OPS_KEEP_BUILTIN_IDLE is not set.
+ *
+ * Always returns an error if %SCX_OPS_BUILTIN_IDLE_PER_NODE is set, use
+ * scx_bpf_pick_idle_cpu_in_node() instead.
  */
 __bpf_kfunc s32 scx_bpf_pick_idle_cpu(const struct cpumask *cpus_allowed,
 				      u64 flags)
 {
+	if (static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node)) {
+		scx_ops_error("per-node idle tracking is enabled");
+		return -EBUSY;
+	}
+
 	if (!check_builtin_idle_enabled())
 		return -EBUSY;
 
 	return scx_pick_idle_cpu(cpus_allowed, NUMA_NO_NODE, flags);
 }
 
+/**
+ * scx_bpf_pick_any_cpu_in_node - Pick and claim an idle cpu if available
+ *				  or pick any CPU from @node
+ * @cpus_allowed: Allowed cpumask
+ * @node: target NUMA node
+ * @flags: %SCX_PICK_IDLE_CPU_* flags
+ *
+ * Pick and claim an idle cpu in @cpus_allowed. If none is available, pick any
+ * CPU in @cpus_allowed. Guaranteed to succeed and returns the picked idle cpu
+ * number if @cpus_allowed is not empty. -%EBUSY is returned if @cpus_allowed is
+ * empty.
+ *
+ * The search starts from @node and proceeds to other online NUMA nodes in
+ * order of increasing distance (unless SCX_PICK_IDLE_IN_NODE is specified,
+ * in which case the search is limited to the target @node).
+ *
+ * If ops.update_idle() is implemented and %SCX_OPS_KEEP_BUILTIN_IDLE is not
+ * set, this function can't tell which CPUs are idle and will always pick any
+ * CPU.
+ */
+__bpf_kfunc s32 scx_bpf_pick_any_cpu_in_node(const struct cpumask *cpus_allowed,
+				     int node, u64 flags)
+{
+	s32 cpu;
+
+	node = validate_node(node);
+	if (node < 0)
+		return node;
+
+	cpu = scx_pick_idle_cpu(cpus_allowed, node, flags);
+	if (cpu >= 0)
+		return cpu;
+
+	cpu = cpumask_any_distribute(cpus_allowed);
+	if (cpu < nr_cpu_ids)
+		return cpu;
+	else
+		return -EBUSY;
+}
+
 /**
  * scx_bpf_pick_any_cpu - Pick and claim an idle cpu if available or pick any CPU
  * @cpus_allowed: Allowed cpumask
@@ -893,12 +1060,20 @@ __bpf_kfunc s32 scx_bpf_pick_idle_cpu(const struct cpumask *cpus_allowed,
  * If ops.update_idle() is implemented and %SCX_OPS_KEEP_BUILTIN_IDLE is not
  * set, this function can't tell which CPUs are idle and will always pick any
  * CPU.
+ *
+ * Always returns an error if %SCX_OPS_BUILTIN_IDLE_PER_NODE is set, use
+ * scx_bpf_pick_any_cpu_in_node() instead.
  */
 __bpf_kfunc s32 scx_bpf_pick_any_cpu(const struct cpumask *cpus_allowed,
 				     u64 flags)
 {
 	s32 cpu;
 
+	if (static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node)) {
+		scx_ops_error("per-node idle tracking is enabled");
+		return -EBUSY;
+	}
+
 	if (static_branch_likely(&scx_builtin_idle_enabled)) {
 		cpu = scx_pick_idle_cpu(cpus_allowed, NUMA_NO_NODE, flags);
 		if (cpu >= 0)
@@ -915,11 +1090,16 @@ __bpf_kfunc s32 scx_bpf_pick_any_cpu(const struct cpumask *cpus_allowed,
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(scx_kfunc_ids_idle)
+BTF_ID_FLAGS(func, scx_bpf_cpu_node)
+BTF_ID_FLAGS(func, scx_bpf_get_idle_cpumask_node, KF_ACQUIRE)
 BTF_ID_FLAGS(func, scx_bpf_get_idle_cpumask, KF_ACQUIRE)
+BTF_ID_FLAGS(func, scx_bpf_get_idle_smtmask_node, KF_ACQUIRE)
 BTF_ID_FLAGS(func, scx_bpf_get_idle_smtmask, KF_ACQUIRE)
 BTF_ID_FLAGS(func, scx_bpf_put_idle_cpumask, KF_RELEASE)
 BTF_ID_FLAGS(func, scx_bpf_test_and_clear_cpu_idle)
+BTF_ID_FLAGS(func, scx_bpf_pick_idle_cpu_in_node, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_pick_idle_cpu, KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_pick_any_cpu_in_node, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_pick_any_cpu, KF_RCU)
 BTF_KFUNCS_END(scx_kfunc_ids_idle)
 
diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index f1caf9fc8f8cc..0acc0f4c087e5 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -64,14 +64,19 @@ u32 scx_bpf_cpuperf_cap(s32 cpu) __ksym __weak;
 u32 scx_bpf_cpuperf_cur(s32 cpu) __ksym __weak;
 void scx_bpf_cpuperf_set(s32 cpu, u32 perf) __ksym __weak;
 u32 scx_bpf_nr_cpu_ids(void) __ksym __weak;
+int scx_bpf_cpu_node(s32 cpu) __ksym __weak;
 const struct cpumask *scx_bpf_get_possible_cpumask(void) __ksym __weak;
 const struct cpumask *scx_bpf_get_online_cpumask(void) __ksym __weak;
 void scx_bpf_put_cpumask(const struct cpumask *cpumask) __ksym __weak;
+const struct cpumask *scx_bpf_get_idle_cpumask_node(int node) __ksym __weak;
 const struct cpumask *scx_bpf_get_idle_cpumask(void) __ksym;
+const struct cpumask *scx_bpf_get_idle_smtmask_node(int node) __ksym __weak;
 const struct cpumask *scx_bpf_get_idle_smtmask(void) __ksym;
 void scx_bpf_put_idle_cpumask(const struct cpumask *cpumask) __ksym;
 bool scx_bpf_test_and_clear_cpu_idle(s32 cpu) __ksym;
+s32 scx_bpf_pick_idle_cpu_in_node(const cpumask_t *cpus_allowed, int node, u64 flags) __ksym __weak;
 s32 scx_bpf_pick_idle_cpu(const cpumask_t *cpus_allowed, u64 flags) __ksym;
+s32 scx_bpf_pick_any_cpu_in_node(const cpumask_t *cpus_allowed, int node, u64 flags) __ksym __weak;
 s32 scx_bpf_pick_any_cpu(const cpumask_t *cpus_allowed, u64 flags) __ksym;
 bool scx_bpf_task_running(const struct task_struct *p) __ksym;
 s32 scx_bpf_task_cpu(const struct task_struct *p) __ksym;
diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
index e5fa72f9bf22b..617ed0ec85dc4 100644
--- a/tools/sched_ext/include/scx/compat.bpf.h
+++ b/tools/sched_ext/include/scx/compat.bpf.h
@@ -182,6 +182,37 @@ static inline bool __COMPAT_is_enq_cpu_selected(u64 enq_flags)
 	 scx_bpf_now() :							\
 	 bpf_ktime_get_ns())
 
+/*
+ *
+ * v6.15: Introduce NUMA-aware kfuncs to operate with per-node idle
+ * cpumasks.
+ *
+ * Preserve the following __COMPAT_scx_*_node macros until v6.17.
+ */
+#define __COMPAT_scx_bpf_cpu_node(cpu)						\
+	(bpf_ksym_exists(scx_bpf_cpu_node) ?					\
+	 scx_bpf_cpu_node(cpu) : 0)
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
+#define __COMPAT_scx_bpf_pick_idle_cpu_in_node(cpus_allowed, node, flags)	\
+	(bpf_ksym_exists(scx_bpf_pick_idle_cpu_in_node) ?			\
+	 scx_bpf_pick_idle_cpu_in_node(cpus_allowed, node, flags) :		\
+	 scx_bpf_pick_idle_cpu(cpus_allowed, flags))
+
+#define __COMPAT_scx_bpf_pick_any_cpu_in_node(cpus_allowed, node, flags)	\
+	(bpf_ksym_exists(scx_bpf_pick_any_cpu_in_node) ?			\
+	 scx_bpf_pick_any_cpu_in_node(cpus_allowed, node, flags) :		\
+	 scx_bpf_pick_any_cpu(cpus_allowed, flags))
+
 /*
  * Define sched_ext_ops. This may be expanded to define multiple variants for
  * backward compatibility. See compat.h::SCX_OPS_LOAD/ATTACH().
-- 
2.48.1


