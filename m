Return-Path: <bpf+bounces-51595-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DF8A3665A
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 20:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 295483B263C
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 19:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184DC1FBEB0;
	Fri, 14 Feb 2025 19:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DMYqj1se"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915011C8622;
	Fri, 14 Feb 2025 19:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739562147; cv=fail; b=kJA9hbORQFJny0+QK68hjOUzVZ9uoiw7B9fMhW4hiMcmIhrVI3OCA996qHXwJULB0gaGY4XRtEOHcaeO1y9Og6bDV83Z5YxQWn4MaF3QiDjgXw/PPhZA8kSRqUCjUpc6K/L7NQAQ/1sBpPtZWsTMiShOyoWDw0K5vRv84il+OCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739562147; c=relaxed/simple;
	bh=sDGVPfb6up2rSLDcy8cbOnTnN+8t80l7w90UXys48WY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C+O0WBTnzNs1Kn0POX0UM3pRCiwv0rr+V8ek0dgGJUa2UyKQSFxOjzF2CuYDauRVXkj6WHFFUpXt5y88sZma+6vg7TDlL1jzojKTzfqLduPpOIne+s3JyQUd5RkIYw5rIlmW/37G1vX/7uj9XjYmP65bNvRF6wUanTFGiz3cwwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DMYqj1se; arc=fail smtp.client-ip=40.107.94.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pyDsED4gUjz5ljCgV6oGwaOBSl2qHDEyhYRC3Hj40OIpMAZvzRWCjaDfz/xcXJVzVZgc3FN9nlh23IkB3jzsrL+4VIW1kfnk7QWMED6UgY7OTm/l3f/UMQzZCPitnU/pP82ZYNdtCfKZZtWSQLb+n72CUega0977NNQ25j9E8ZY0dWb+nEO3yY/VgaqhFbQCTawl4dgvcc2zL/eT/C4RLhbTWuYRM7Fp+TSQldUJAPxqiPLn7h/2e7M28X9QQZ6lUGF7oeQ8lCvmxdGJ/b8Zm7g8b4mu4Odtor9/5WSasDXxkxLgbSO5/+ROo+D9eHWKUs/0W+UXNUPzlUJ9THKJZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9NTjs8nLjgluBnTMHtJJ1+bXvBbVUWkfPeBqnBtq4gI=;
 b=c/ZJPj2LTuZqKyGj0FjDVWK//U+IhnERoMzIE5YsMSGD2IxUmJ6Nmbw+e2YxvyF93HuuPpNvT2AA7CQutq4/la38EgsbR1MT8m17k8ae27ancytaP5Awm6a+1U4+nOx3uDO0bCIgnn+qQHvNz9I4z9X70A3Rfl/zolXhM9PPssYsU8gQtWkgGBUYGk8Pzvl9IneqrDh3rDmI9DtVfuyKnM0tnUQQjigKrmW4BG/610aVO6fJs0L1wzlsAKI0bDuk4biO16Bxh0r+vY/LfUHVd4DyUNvoSVwk0+zF+EoZwA65RbDFJ3yLTP2vo0ES0LwlYg2tf0zTr7cC1VX2Hz3zcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9NTjs8nLjgluBnTMHtJJ1+bXvBbVUWkfPeBqnBtq4gI=;
 b=DMYqj1sehSDhY/aSFamE7ST57qpoVu2dvtcYzIGznph40DCrB8QZVWp99mmw53SCKNCjcJuZGr4foWvoD9CyiYkdG9JL1CQ+Z3ZlKe4C2dChQRPc9Vj2ey60PZUzAbPSrjbKoPM8t8e1rtNSZZI7Ds10czVJRN/efaxaOIpbuSH5sguPuTvRQ72Mdujdf7rQ61IoIqzFoRlOI3j/p4twEQIu9B33+Ct1JstZ8JM8UvYnMAli1rBiKJOZIYMg+TQjmml7uvOVPdPn9u6TUGIMe+WfpZT3owPTlnxoXw4C+wu8juRUNTFnPtS45xjPSoaD4/DZOfI9L+wNi3qXEMA6Jg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by MN2PR12MB4360.namprd12.prod.outlook.com (2603:10b6:208:266::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Fri, 14 Feb
 2025 19:42:21 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8445.013; Fri, 14 Feb 2025
 19:42:21 +0000
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
Subject: [PATCH 8/8] sched_ext: idle: Introduce node-aware idle cpu kfunc helpers
Date: Fri, 14 Feb 2025 20:40:07 +0100
Message-ID: <20250214194134.658939-9-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250214194134.658939-1-arighi@nvidia.com>
References: <20250214194134.658939-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0008.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::19) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|MN2PR12MB4360:EE_
X-MS-Office365-Filtering-Correlation-Id: 0902b99d-d460-4a0b-7948-08dd4d2fb2b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JXcWRRN6wAKcnx+/p2/8hqUI83ngV39jNZ96qebIMKufUHtOId04U/Pmpnc8?=
 =?us-ascii?Q?zG5ff3Aa5NUkESOMbpib8P7nPczKl/rlTkIpoH67aEVycd0fVg+VK3SbQ/lj?=
 =?us-ascii?Q?sMKZrduHOkApNzcNb6KTCTz9g8XLaugqc3JAT/qz0QSrJmCRf+f8RE7rAQ0i?=
 =?us-ascii?Q?WjvJ2+lb+MMbSYKKQoNtlxoKVmTMznauhC/2j/8np5IGvJzkrYi3h4Ai26t2?=
 =?us-ascii?Q?PqYQA9UMRc+g3CxeU2QAWNv4UIT5T8wK8N4kCXXLLE+QWK/GNwEdPh3J6pkr?=
 =?us-ascii?Q?iOWruHAL82rLOsk2PfGXDXaS/xMNKf1fefnhzGtrmV3BcrMZ4v/+9hgkAdpY?=
 =?us-ascii?Q?7jhVivwXotj1/fE+j5HbeMDNlftmt21Td+RBG/o0zJZTblF305/QVX4IZOCs?=
 =?us-ascii?Q?dqwT88xUhxYNJS61JxQSBYZasjPdq0dFTtwXCbIvwkv3oBWVtscYVNYUJXPw?=
 =?us-ascii?Q?388yLYwkBLuPxlE71Wmg5l+bjfjKJ+l6Mbk2wbueRXKx1i2EEsu23YpjgC7a?=
 =?us-ascii?Q?/uCoYmWWi/yz5EaeTCa0ZU8mqI8CfEMETpUcxCuAzAgQfi+kYqJtO7T4sxL0?=
 =?us-ascii?Q?kDqmwTK2+ZMRaHeI/aIhurrhC6UzHk77sobr6aoZlGQyzYhH3J5bjNsgM+wt?=
 =?us-ascii?Q?pzTMwkKRWC+13TmaByopedAyPwiR1bnrP6szSJtvwFe0xD0KFJBdvAIht3GS?=
 =?us-ascii?Q?KAmk7GkWUfHwVbfFQCIY+pni9RwtyRKNJAlSSChaN1q8XZ8brgONWeuydDkw?=
 =?us-ascii?Q?2eQphWLU+1b6cy4rHgIRybZ8XB/2mACYVOW3guOAsZZNwttkvSuNL3oBmLJz?=
 =?us-ascii?Q?ep7zcACBVRxfKhL14wLKzYAc6SRyfQ8crM1PxbrVlzxiJcMg26Y2xAqP6D2U?=
 =?us-ascii?Q?qrm4V94CZmtZw2CD5gcP8J44zCsjwrH5EonEiQW3S40lfZrydvWUBtfXlGC5?=
 =?us-ascii?Q?Xg9a2V/Nfjowj0f2ZQKUEp9N7FrxcjkKG/PQkFIeo6MXQdmdc0lfoP4RbnbA?=
 =?us-ascii?Q?sNrSC1yayNrvcJUfKmG3tcAqWS1uoNen9Hy3vrLdeW4ykkIwNWzoVb75zwn/?=
 =?us-ascii?Q?XcOvwh27dDmwjAbsmRW9YNEtzz1Za83h9rS0iWwe3WrPeP1kSW5g9S/OjGVn?=
 =?us-ascii?Q?gpXtj7dUqPjf/G1RhevOrBtp22v/aIgheP7e0kzVujBW9T8jWN5DCxRGImjU?=
 =?us-ascii?Q?5QHijZqo/VE7D4X/yi6rijp8V+/Tr8tvuHVI4wtCD7p6e6drrXAQ6Pk8X6qq?=
 =?us-ascii?Q?kDtaHCks5QbXziZwmtoEUm30rOpLxlfP5uGcdyyd1rLjSdgP9PGUVwiDntxA?=
 =?us-ascii?Q?7c26UOz/ACFp4oZJRBvidua1g9JvtDy5p0jMzboYfXdbM5kJ4oM/yZtPLi1d?=
 =?us-ascii?Q?f7FwKWHognfAWH84iRwTcR8IMKtp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tESzkwkbOjECdpuWZItJghw2Cvk353kqpA4N2RiVlMDcssAveoKuswJvUY8p?=
 =?us-ascii?Q?PAciknCps6+xjClU0WIuLlqcGcI3Slde6HmxuFvly9Lirmg6J2sk5c/NUthS?=
 =?us-ascii?Q?sNjDxyIjmPRrs/rlJ7PoIRYcOy+qBBti2zVaJwKfHVjqhRqUTKO/rQDy3nF2?=
 =?us-ascii?Q?L/p/5WGydvgYIk9sbp2E/CXnW0V/DNYDhPtvYjh5/AMNsNXjfhdkqw5bCWhh?=
 =?us-ascii?Q?s4EYQ1c0BB3Np1/zSuxAHX79zhGaW/StCJiB9yGCFIuqm3hEazYLN+hmjVF6?=
 =?us-ascii?Q?MMNtjCBlrQeqvudH2u2+KqiEFxRuTnIPOf8nWQvhXj5IbNaE+FvrcKaAjUBm?=
 =?us-ascii?Q?kPBYFbjPgWEZsyRsWej1Ifxf+nIotjLgwwr5msaTHQTnZXaFoJn35C2HWVod?=
 =?us-ascii?Q?vHctKe+DgXr1NHs3DgfVQwvMfGJaXEpN8QdkKNHDyYnWaolOHQkDFu5JpEuh?=
 =?us-ascii?Q?070rPiHBblx3WmxTtsz//PXzAy5QACd0/dAkVUoLUa3X5n03UZIMc735PWWO?=
 =?us-ascii?Q?1LiIJkGyJRudJnkTFZVXhq4YRLiKeip3fDgtjaI9maYyVH/brwGKxMsT+tH3?=
 =?us-ascii?Q?KwHjkqOSn23gNOEcB4aVWFwAc0CGe2T6ScyLW2etsGcccnISAt2ToxeNP5FK?=
 =?us-ascii?Q?eteXL+2UffN40IeBZ1jFkDpi0WDbxJWp2f0cNsipvMjbgf3Z6xcpqUH1mn2m?=
 =?us-ascii?Q?mJ6KXD84gR2XOjXYSWPzimkVKoXfnokaotUS1LOvljGh5kYoVuFaHSTXlVce?=
 =?us-ascii?Q?ti0+/qw6y3M6CAaWlIu09mcJVPgC9IWGh2eSYWhpzlex8u5t5AvMxfmnP2SB?=
 =?us-ascii?Q?IBJvbV2F1LR/ZPC677Z2fstq9UV7trACIWYV4Bx8WprAoP6P94h5/dlhZdUo?=
 =?us-ascii?Q?GgrxWA7u6ufChOpbNg8quXGL1KKrjrp2y2iSdplqggweIrUc1expQKTZMRwO?=
 =?us-ascii?Q?akidztyjDZf+OdXlYb6gfQYfFhW4BNYqYyA/vO3e0nN7zSN0JhvwEju5aVSi?=
 =?us-ascii?Q?VYm+pPwnDtYiAjp6Ge3NblF1AscLdXrOuHZzU07cgnsRcHDRSC8Vijn/8Mpt?=
 =?us-ascii?Q?JrKCRKIs8bPdkTy7ruTZRjtaYL70P9o2V/m1uElZ+5TsCihRJK9h91wRg1cU?=
 =?us-ascii?Q?bsNnpdVOaut+bKCCnSiVIeOwpRJi5KVLHIahslKRJJ67juicFgz2+G+1Rhu/?=
 =?us-ascii?Q?LKzSKXs5M1Sv+P0vrJFqECsVj2DNTSdciBNBssPjE4BAkyzsDXbq5Z6K9cGK?=
 =?us-ascii?Q?kY2dhnO++6v/mv9CNTe3881np5xYv/MUv7tmN3FrUoG7MQc1oWHBMCnynUOG?=
 =?us-ascii?Q?S7Pbk0/agS1nAXopbyGOUGueWc5hO9tEfYBkZddDtc1z/F4cZ8Rospyv2mLQ?=
 =?us-ascii?Q?/taIfIwv8WfwBbpf1Vg/GGkgV3n6ovV+y5l3inxfcTYObCLSfqmK5rbNtaNV?=
 =?us-ascii?Q?J6KAAsrNieRxVmnLKHHmxiVEEuc5PdSIsK76oM7O4lVh6QGcmHxsgo0jGHlj?=
 =?us-ascii?Q?AMecqNrXYEP+vJ+iZnZViRZdjH/SG4qlzkxExiYAgi9eDEp2rOWlCrLFTiTP?=
 =?us-ascii?Q?jn1+U7RZ2ispRzT3Mgxi5YHU8PEax67k9SqIYoUe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0902b99d-d460-4a0b-7948-08dd4d2fb2b5
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 19:42:21.5651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lAUpyjRK0ZIypzXOTwiIQMnKhTED9uBSIlDL9ylhPcWztT2I0jL7a8f5hy++NGZVVkwUlJzEn1Dr7SCuBCR5jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4360

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

Cc: Yury Norov [NVIDIA] <yury.norov@gmail.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext_idle.c                  | 180 +++++++++++++++++++++++
 tools/sched_ext/include/scx/common.bpf.h |   5 +
 tools/sched_ext/include/scx/compat.bpf.h |  31 ++++
 3 files changed, 216 insertions(+)

diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index 8dacccc82ed63..5c062affd622c 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -728,6 +728,33 @@ void scx_idle_disable(void)
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
@@ -739,6 +766,23 @@ static bool check_builtin_idle_enabled(void)
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
@@ -771,6 +815,27 @@ __bpf_kfunc s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
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
@@ -795,6 +860,31 @@ __bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask(void)
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
@@ -859,6 +949,35 @@ __bpf_kfunc bool scx_bpf_test_and_clear_cpu_idle(s32 cpu)
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
@@ -877,16 +996,64 @@ __bpf_kfunc bool scx_bpf_test_and_clear_cpu_idle(s32 cpu)
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
@@ -900,12 +1067,20 @@ __bpf_kfunc s32 scx_bpf_pick_idle_cpu(const struct cpumask *cpus_allowed,
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
@@ -922,11 +1097,16 @@ __bpf_kfunc s32 scx_bpf_pick_any_cpu(const struct cpumask *cpus_allowed,
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
index 77bbe0199a32c..cd1659c5d3f46 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -71,14 +71,19 @@ u32 scx_bpf_cpuperf_cap(s32 cpu) __ksym __weak;
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


