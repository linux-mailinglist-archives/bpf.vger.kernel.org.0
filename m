Return-Path: <bpf+bounces-54036-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D80ECA60DD2
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 10:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 687021B60263
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 09:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B05F1F4161;
	Fri, 14 Mar 2025 09:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WAlFgHOP"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18021F3B92;
	Fri, 14 Mar 2025 09:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741945765; cv=fail; b=J/4+VlSLrMRB47GM8n2eQ0MRGRifhKV/plk4XrYyNxH5L1Xe8UMfLMSJStl9k0PIVpey99aRZCqSnistT8B3GUdOc1YIJ5oSByCO+J1YayXRvWjSH3KzRNvvZB745ThfLqBDa/PCO98kd8lHM7xNU+Nu1/uiRDN87Wv+H+hio18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741945765; c=relaxed/simple;
	bh=SfdEfH4cc/aHWCx+Xr3G/UTBrdcTwCgo69aGxQ+pbzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LksvX1aTHo1JbpH7aHIwJnipG4xiz/4wVNA2/OBx++MCt+8wq+6t029ID2OZD+0orxQfdQ/1ZSHhteDEaYkZO5rFdVVX9QK70QB4LqHx2yNzblknCdd/KHF4hbJt1xXYghb+Ny1BLVpXpAsm0+i1rJjGmFc6ZxsJDJNm20ZgtUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WAlFgHOP; arc=fail smtp.client-ip=40.107.243.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qWh6P5kaPA9C9drd/xqsE9naOuWegiq7xRREF/PH3w07RoYUKfkrsUNLtiC7yi5N6W6dC5mKMYFmxWGTvsHr4z/nfWMafcA4h4FLwqzgeXZTmY10G2f1xwZ9OW3VOn+KwsvAy0w9u+3QbTpeKN2l5/ARuCNOXS53mwy13vzwa2g+SzIMxBlcIeFdOTGpaVJ+jk7zM84hVOWMdnOxXtiIt9HWd/LOGceymTLue892F60ujlWXn0utVujanBp+MqyVyurkwKbX+KmA/cAc9CN2jq1LoDoPOlHvHK68CD966fGQi5mPtek/dG/h2N5bYGXuf5UtrcH461X/1g9a7t/enQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tHmoiO9QRf/tJ4qq+cAaLGe76qcC3ppIfupXhwrfpjg=;
 b=pWYlm7GRvNAtxbhL+RwL3W755hmAXL/55hRXHB9yUpkA0QmWaNHIEaU0s8gIeEyA9yJlbLPz48j6TR9+E4asP62LOFjtlI/zJGgcoz52IwucoBWUwpgEL8zEi5mTb/Wwxtz7iSvhdHulfDInzuhMGl9vUAI1Y/pVTWyutFni8yAnXIUKhfP92KZy2oOrs2FxU32P2L7bRM2feqsBlXBo2yHVlDsPPmcaIWLV5JvVjgJAOzDdv30+8Sow8i/jaYuzVC07ybWprGBR+dGTuR7F/v9Evu8nC53YrI9cbii6SrRtfoWVh1/56+LUILzap7xa3aQ6nqW7lULkbdn9jdnq6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tHmoiO9QRf/tJ4qq+cAaLGe76qcC3ppIfupXhwrfpjg=;
 b=WAlFgHOPpG7gq6lCr+uZPxscRGOT7A9cqxm7NzAvSgFulEO11kFeUQLQi2MnjCgsoA31zp2YkFpOC/dwXbXvqPx+48EER1WSZvwwSikMKry3E96o5ncvr9qyCFLmLxjBhnQuOaM6xYSfK1pZwGB8SIy4Wr+Y68B+54/pxaatr+CC/+xgYHtFxr5DBOl1X+Kp7GKrYx9DEmjivK9WqOv/00qBEPSdfILoSvOHtbQDwkCdBtXwAPLI2TlMJ8oAhbHVmy/pNXLbVQYDkWi3z2igKVw4TbvS3r6CJ9JbIg35sWP+izbV3HgNf8QiY+wLw4j+fRg8IAOpWLnUevyn1+9RKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by CY5PR12MB6431.namprd12.prod.outlook.com (2603:10b6:930:39::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Fri, 14 Mar
 2025 09:49:21 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%5]) with mapi id 15.20.8511.031; Fri, 14 Mar 2025
 09:49:21 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] sched_ext: idle: Accept an arbitrary cpumask in scx_select_cpu_dfl()
Date: Fri, 14 Mar 2025 10:45:37 +0100
Message-ID: <20250314094827.167563-6-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250314094827.167563-1-arighi@nvidia.com>
References: <20250314094827.167563-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0054.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:53::17) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|CY5PR12MB6431:EE_
X-MS-Office365-Filtering-Correlation-Id: 608ed469-6547-4876-8551-08dd62dd7eb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1IHDBbG78yx3Jogf8KUS/Z6wU5h2bPH/Yc5JA6wmVudbVWTEuAzjTyXzWpDg?=
 =?us-ascii?Q?cOIKTpxnf1K7VZxPV21lZ2QC7VeQ6QAzm20lFt9y0ubBELbDHdYwZEjocO8+?=
 =?us-ascii?Q?odYjInyBluUlhdnS4iJJVv7IXQCNeZB2S+haX6resGtYKfcTjbb8AyGF2SIt?=
 =?us-ascii?Q?dExcX/dWuzxkeUuwWNW5E9lxzzRykOW4dRSKKRqQR3+6x/VEMdOP2c28echM?=
 =?us-ascii?Q?/GTeHyJj1eFI17E1/dJl2IyIbj+jQL/G1u+oyJ5nSUN/L2IXWyjY1TnyoQjq?=
 =?us-ascii?Q?On8u0zCEYv+N1JBvMlqbzmQvb2UrzBqqERYEOZiIapmILJ96Skv+LU88fK5J?=
 =?us-ascii?Q?c5GZmgmF7gvjDEhYy3I8gPbyPN19NJAda2r+YyMAK63hVNVvjj/V8lVOepwk?=
 =?us-ascii?Q?wQUJ4eYWZ4rvPetPdM+cCEzyWtS5Q8VFwxCla1nT69OLIOrA92yHs/pfvTyO?=
 =?us-ascii?Q?pdOO61kCjL8LspmjMikzFzvnev4akugl62mpy0Y4wlDJG7c9TAxdj1BTOam2?=
 =?us-ascii?Q?CfI6BAUjHSAoi3uH4eO8pe0r7nHG57okxVBLyaZOU7fOFW2cveCSircTigHN?=
 =?us-ascii?Q?fJ9pjjCGyQW4hzVB8u0b5jvAuYOOFlH1ZUZ/mEsGUxfGLbS/E4rv2AIqe/F3?=
 =?us-ascii?Q?Dc4n3AFALMf5XfPuOWoLFyCXWSAXVt6SaMfBh7wnSq6WaQLYqmcqyUTRqvS8?=
 =?us-ascii?Q?CezydHplkOg3LQdYG+GHqYetdn+EkkQIlvrlVL1flUEpQx5B/z9lp3PtKRWh?=
 =?us-ascii?Q?lqCWn9hdtaA6FaMGlnBx7Jt/Z9TgmvyYo2N0EdlWeY8S0QuxpAr7PPc8t/F4?=
 =?us-ascii?Q?GlUAa82dqwEOw4G7DhFzRGjkrAABgBDSgc7QPj8ICP4sO2kJMTdMWuMWFY6P?=
 =?us-ascii?Q?axX8ImC8JsqKbvkXKlQoZzaH2I5qz9DuM5lb8+Y4a9eD6cKsH/Lc7VIOB1nV?=
 =?us-ascii?Q?/YIXrJV1kD97KL1rDf9KHEYlzTDgqD5Qhd8AVs9ZZHai26yAn3bQCp3rYbWy?=
 =?us-ascii?Q?7sm24yxTEUsh/icd3q/L0r7y9NRNOKordXunEm/60Uv7lJ2tKS14N2cbi1cX?=
 =?us-ascii?Q?ZuoyNX+bMbeSJbB8irseHRMbgfbJSYoS1ar7s4bEmhaeYXaszXsEUsew6nQ1?=
 =?us-ascii?Q?1FNh+w8L7IYIJRSq7bjeoncXTUNIU4mtf29Qy3yJkbRWmO5alYota/F+yk5z?=
 =?us-ascii?Q?QOUfXONxTU8kjo/9YsdpobbebkcZLmwSjK1KosqjbrFA7UsvNFK3Ll3jLh8T?=
 =?us-ascii?Q?Dv23PaTLAwvcN35U3ovKvY/JPNgh1dh3L/7V+w+f3NPhyYN7atOxY5a1MtJH?=
 =?us-ascii?Q?RBkX2ZsXREB+gMInVgx0tuZ5yPOR62a3d3snZtupnJt9GhWyAPZorqI1t+YN?=
 =?us-ascii?Q?WPn9ofiEC3mQaVJe8yTDH/uO5+Yn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aIqcJTBS0oi5wSr78KuvAHq/yw9epFe1FT4TC5BxbmLjiy33UYCWxBt/mLSa?=
 =?us-ascii?Q?taEtbWByoQ4hGOfsh/B5UFFCTib6ccLLE4ZhoLL/4387FPjfvKrJvIzNfNi1?=
 =?us-ascii?Q?7xUJeS5pT5l36XVCrGKR5F8kPyP3mEhdbpIKyx37SZGS0vWOLsZnKmYwXLMf?=
 =?us-ascii?Q?oj4cBkl16eN6Cf9zEDMfY69wHal5SXlHDGGyA2Zy0cl7JozUKQoz/Bq7H2pd?=
 =?us-ascii?Q?8o3tBj4epvW01eKjhMSSLWvjRkjRRe9cL+7I00jCKWIwul8qwgKFuaab1Yjy?=
 =?us-ascii?Q?ChcdaVHdc18qPGGfGLiRYB72o7pnCZNKcUUGNDjvkSzglV+HjTKYBLR0lES7?=
 =?us-ascii?Q?daSdt/yPyrGOdXJ71MeidMZ8gmUM7Hl8eYcbVk8aNE17W6lcaYeYlRYBMSSv?=
 =?us-ascii?Q?K5lTINQlt3E1rDlbrnm+QfUu9o2PLmqqh1lFRl3KqTPx0oLdmX36lpvMx8nO?=
 =?us-ascii?Q?Rav/w59Kq3PUZH+opJEBuLMd5yFOlkqWfjmI27XN530GeZc0CiDiZe6+YPu/?=
 =?us-ascii?Q?vpixjoVHLDHhUfBZ3k62i4sfOCgKyQUOJedx8b7JJxxFBsjgtYL9MwZQnfvd?=
 =?us-ascii?Q?4Xpt4adttPhCBxIdQTAFw2ZrhXtbjEJmdEQx5dcjmM/6pGNVMDawvjon1Wuu?=
 =?us-ascii?Q?d9COtUr79GFW623YfolkHuyHzit+9rC9b+n1z++VnsziCQ4ZxQJS4Q05zXyp?=
 =?us-ascii?Q?ihPp+abjkO49s+oW14VTxs51Xk2tedz7MWfPfUGSmauCN1wbgUg7SgK9Hwav?=
 =?us-ascii?Q?taTFMQ7sjgprTbr9eHc6/Fzs2es6VB4pL/aJ701UpDdOs76cBceiMwtYwyNI?=
 =?us-ascii?Q?oTEFQief3z8EOxJLHXdJpdnNuJ9+Pbau/tFB84svvsKFgYXaRlon6nFBKBHV?=
 =?us-ascii?Q?9NdrcAa4dkrWZmvwys5ZBQ7BlfagdRXLZKb/X00Goqt4J1yCzTxr01a3dArl?=
 =?us-ascii?Q?4x8hx0+dpfS11fE5JLMGI3hUIKIcOZp8bx7UkigkEdwhFWVuIcMXyRFh6VkX?=
 =?us-ascii?Q?MYHjOmkg7iGAOlsjFXeB7+12D4l9d0pgA2RT6b41eLmSNrTWJPxhmyqQUVDt?=
 =?us-ascii?Q?p9A+EDrwF5z6HMpKFyklip3BDZqOKgnkljbZkKoBalD4YF941ETG3m7xfblF?=
 =?us-ascii?Q?opKqczcu45LoP2U5Eqm0KkCh1+kPu+9VMBl4GM7sA6VtPr5KMVAfzZWZZhk7?=
 =?us-ascii?Q?CKr2KVq0YOZN48W40UZIds4pZspmUx8gtZLtAr0GNAIKyEGurWVhdqgkICTS?=
 =?us-ascii?Q?fN3IGH7zSykxUqPFHAqo0l1RwOjw0vIrB9wHFjnePGYlMt793BB8D3tcnNfF?=
 =?us-ascii?Q?d0S41b+PTlNlUx7J7XBbiRv+TnuziMADpseJ/moC5hsHayxjvwKZa4ZKxT7k?=
 =?us-ascii?Q?DCjhzlt45i6wT7bGRsJsRzqyCJblZm9PbtjS4bOaoND2jUf79weY/NrPBAjr?=
 =?us-ascii?Q?Bt9rvsKumqalYIzKL5C3iX5ITbZmKAmTm7V/udcRVCrX0EZnuICNEwTP0/jx?=
 =?us-ascii?Q?3ujYer2bwEBAaoJ2n5m8vu7T+RI2J4MDJ4Uf3FcFi6cdbFu0wTbX5V9jxjk2?=
 =?us-ascii?Q?7u7GhJm/epsLdoYN7VEvBxaaCEUcWRo3ROdUgkED?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 608ed469-6547-4876-8551-08dd62dd7eb6
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 09:49:21.0403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Py9egnfFX8n0N18W94YLhgkKgFGS8BRmXB9q0sQWoqn06v7ypEXEabtk6TqVe5HZAamW+0Pt3z8b5KmQ7LfWMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6431

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
 kernel/sched/ext_idle.c | 73 +++++++++++++++++++++++++++++++++--------
 1 file changed, 59 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index 27aaadf14cb44..549551bc97a7b 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -49,6 +49,7 @@ static struct scx_idle_cpus **scx_idle_node_masks;
 /*
  * Local per-CPU cpumasks (used to generate temporary idle cpumasks).
  */
+static DEFINE_PER_CPU(cpumask_var_t, local_idle_cpumask);
 static DEFINE_PER_CPU(cpumask_var_t, local_llc_idle_cpumask);
 static DEFINE_PER_CPU(cpumask_var_t, local_numa_idle_cpumask);
 
@@ -397,6 +398,21 @@ void scx_idle_update_selcpu_topology(struct sched_ext_ops *ops)
 		static_branch_disable_cpuslocked(&scx_selcpu_topo_numa);
 }
 
+static const struct cpumask *
+task_allowed_cpumask(const struct task_struct *p, const struct cpumask *cpus_allowed, s32 prev_cpu)
+{
+	struct cpumask *allowed;
+
+	if (cpus_allowed == p->cpus_ptr || p->nr_cpus_allowed >= num_possible_cpus())
+		return cpus_allowed;
+
+	allowed = this_cpu_cpumask_var_ptr(local_idle_cpumask);
+	if (!cpumask_and(allowed, p->cpus_ptr, cpus_allowed))
+		return NULL;
+
+	return allowed;
+}
+
 /*
  * Built-in CPU idle selection policy:
  *
@@ -409,13 +425,15 @@ void scx_idle_update_selcpu_topology(struct sched_ext_ops *ops)
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
@@ -434,9 +452,32 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
 		       const struct cpumask *cpus_allowed, u64 flags)
 {
 	struct cpumask *llc_cpus = NULL, *numa_cpus = NULL;
-	int node = scx_cpu_node_if_enabled(prev_cpu);
+	const struct cpumask *allowed;
+	int node;
 	s32 cpu;
 
+	preempt_disable();
+
+	/*
+	 * Determine the allowed scheduling domain of the task.
+	 */
+	allowed = task_allowed_cpumask(p, cpus_allowed, prev_cpu);
+	if (!allowed) {
+		cpu = -EBUSY;
+		goto out_enable;
+	}
+
+	/*
+	 * If @prev_cpu is not in the allowed domain, try to assign a new
+	 * arbitrary CPU in the allowed domain.
+	 */
+	if (!cpumask_test_cpu(prev_cpu, allowed)) {
+		cpu = cpumask_any_and_distribute(p->cpus_ptr, allowed);
+		if (cpu < nr_cpu_ids)
+			prev_cpu = cpu;
+	}
+	node = scx_cpu_node_if_enabled(prev_cpu);
+
 	/*
 	 * This is necessary to protect llc_cpus.
 	 */
@@ -449,12 +490,12 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
 	if (static_branch_maybe(CONFIG_NUMA, &scx_selcpu_topo_numa)) {
 		struct cpumask *cpus = numa_span(prev_cpu);
 
-		if (cpus && !cpumask_equal(cpus, cpus_allowed)) {
-			if (cpumask_subset(cpus, cpus_allowed)) {
+		if (cpus && !cpumask_equal(cpus, allowed)) {
+			if (cpumask_subset(cpus, allowed)) {
 				numa_cpus = cpus;
 			} else {
 				numa_cpus = this_cpu_cpumask_var_ptr(local_numa_idle_cpumask);
-				if (!cpumask_and(numa_cpus, cpus, cpus_allowed))
+				if (!cpumask_and(numa_cpus, cpus, allowed))
 					numa_cpus = NULL;
 			}
 		}
@@ -462,12 +503,12 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
 	if (static_branch_maybe(CONFIG_SCHED_MC, &scx_selcpu_topo_llc)) {
 		struct cpumask *cpus = llc_span(prev_cpu);
 
-		if (cpus && !cpumask_equal(cpus, cpus_allowed)) {
-			if (cpumask_subset(cpus, cpus_allowed)) {
+		if (cpus && !cpumask_equal(cpus, allowed)) {
+			if (cpumask_subset(cpus, allowed)) {
 				llc_cpus = cpus;
 			} else {
 				llc_cpus = this_cpu_cpumask_var_ptr(local_llc_idle_cpumask);
-				if (!cpumask_and(llc_cpus, cpus, cpus_allowed))
+				if (!cpumask_and(llc_cpus, cpus, allowed))
 					llc_cpus = NULL;
 			}
 		}
@@ -508,7 +549,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
 		    cpu_rq(cpu)->scx.local_dsq.nr == 0 &&
 		    (!(flags & SCX_PICK_IDLE_IN_NODE) || (waker_node == node)) &&
 		    !cpumask_empty(idle_cpumask(waker_node)->cpu)) {
-			if (cpumask_test_cpu(cpu, cpus_allowed))
+			if (cpumask_test_cpu(cpu, allowed))
 				goto out_unlock;
 		}
 	}
@@ -553,7 +594,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
 		 * begin in prev_cpu's node and proceed to other nodes in
 		 * order of increasing distance.
 		 */
-		cpu = scx_pick_idle_cpu(cpus_allowed, node, flags | SCX_PICK_IDLE_CORE);
+		cpu = scx_pick_idle_cpu(allowed, node, flags | SCX_PICK_IDLE_CORE);
 		if (cpu >= 0)
 			goto out_unlock;
 
@@ -601,12 +642,14 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
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
@@ -638,6 +681,8 @@ void scx_idle_init_masks(void)
 
 	/* Allocate local per-cpu idle cpumasks */
 	for_each_possible_cpu(i) {
+		BUG_ON(!alloc_cpumask_var_node(&per_cpu(local_idle_cpumask, i),
+					       GFP_KERNEL, cpu_to_node(i)));
 		BUG_ON(!alloc_cpumask_var_node(&per_cpu(local_llc_idle_cpumask, i),
 					       GFP_KERNEL, cpu_to_node(i)));
 		BUG_ON(!alloc_cpumask_var_node(&per_cpu(local_numa_idle_cpumask, i),
-- 
2.48.1


