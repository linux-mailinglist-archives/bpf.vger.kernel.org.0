Return-Path: <bpf+bounces-51851-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBC7A3A4E6
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 19:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 747633AABDA
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 18:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A008E270ED8;
	Tue, 18 Feb 2025 18:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UkNAKqgU"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2087.outbound.protection.outlook.com [40.107.236.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B2D26FDB7;
	Tue, 18 Feb 2025 18:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739901894; cv=fail; b=TJMwun27nEo6lBk3nBqAxRQeTLcrGT4MNq0dHmjf6ejBOOjXTkzWFA387jojqW8BfJI6cjzOon9P55GwXOCBnzx/Z71WiRzFJeDz2jHEGC7WX9IAstQG2oL2OANJH88+E2fXvesLv26AqBClJUx12DHYLpZw+hOugM3BaiPjjzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739901894; c=relaxed/simple;
	bh=6ShYuafJORIl1+HVcOYoLMdzbDzjkV50Iclq/lwVFmI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=qlq2jReS3la7Mlbvz6F6Rr1PTeve+H3VPC9QgprNUffHtUu2GJ0RmbRphOeVp9gF1rnOzYeaflX2LtCVRaifBvzTQ0mkoowWfZvKVP8V8wmPd6x/IarkR/b+pSRy7Z+UxOl+2c7FpqIFJJeLXRLyW3UJMPcwByRtsqdRpEJMwRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UkNAKqgU; arc=fail smtp.client-ip=40.107.236.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f6etoSqRSdrRpRe87eMsKgFZfS25MNlI3FOAhOPuyYoC0SCNtnF+E2+Pfp77ksnyIUMYJTvXfWTBhjoKXLoly3/t8Tjmgm+mLKI/VMb+lZrLAA7mdz+MmzDw6R2rxDhI9yp6baWVef5QxYO1QAlQ/a8y9VWb+0IwYi8hwTrJm/ZGOs088o7MNSoIJ4raSJZSJvX4WmYmFECGRTI8SVkUpaajj2X6kUTl2Sl1X6ATdQEazMTWXgvHz7T+u5edTmOCTmEVlsQ2Ez+Pfyapcy3UKY0vm6U2of4HvrXAjKOY3DJEBhifGors+OjdKob4TzB7+u6BhSxdJFoSmbQ/37pRUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wQMg+ve6Q8f0oOKWzq/tQffKhptA0tVs++6iFu9QuDM=;
 b=Z1YIL4w5HsowNXD/uo3pMR6RPCDQhMUvsKyeMuS1saICY57llveJAnP1/LRBNWcG1v1Wn8zE672+UPZg/mHHlOuWLKri+4TNnaysytZUmj1uuznpgfEFwcdkckqdEp9DlMuVoQeyAj5ocmL7+iKTqixLVFcEf8DJSIgonyNI5VRH6IbIjLz4jT2nxTc61BpeCSQ9bhw4A0/Z/w9ZCvKokBu68Kaz1L67hsvb9IurecVDLPiEStYQDrpsetFDeQcIcmcQxksbueA2wBuuiAWoAvLYrT805KWzsZYZ1b9anyY7oMCx4sCSGk0c1eclxG5EJm7SaxcNxeKhbIxcZQRMTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wQMg+ve6Q8f0oOKWzq/tQffKhptA0tVs++6iFu9QuDM=;
 b=UkNAKqgUV+UsCpl52XRHz5ROL2CjB0ewMzzgTnM5rtcRb7Zm9ckZyHUX0z/RT2Se4CKqh6j/r7eizTe7nwoYlQXIZv/xQ9cm82u2Z4MP3wcRGnu8ymeexQILT76sEgXkr9M59biIuk38evZNxVl9GWG5ZN8K5M6m8dcJku4L8HoEuFuZAXfn09HVQz1uXrZo66w2lpsCU4AD/bCRxsWb/isoQi+CgfAtLCcIhnpBhVE762INuSmE/Lk0LbQ8B3qyCj99y/TJg/QQZ13rgiOIhGJqqejtbGeEUSCb6Cn9QQO+ZR1MWxoz17MOdmtRKy2tDIl7AajHMVoQU8IygcZqdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by DM4PR12MB6230.namprd12.prod.outlook.com (2603:10b6:8:a7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.17; Tue, 18 Feb
 2025 18:04:46 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 18:04:46 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Ian May <ianm@nvidia.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-6.15] sched_ext: idle: Introduce node-aware idle cpu kfunc helpers
Date: Tue, 18 Feb 2025 19:04:41 +0100
Message-ID: <20250218180441.63349-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0136.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::11) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|DM4PR12MB6230:EE_
X-MS-Office365-Filtering-Correlation-Id: d84dc1e1-45a5-4ffd-f7d7-08dd5046baa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DTUk0aON/XuoleeGZfH9Np1uaO95R3BQTv4C1TK1lhJgtMVd//zl8KGY51Oe?=
 =?us-ascii?Q?tKQ+AdGoZYiedbkCk986JhyFe/1hXNxaTocAoXUTLcjUoXMoBRX8Kg8ESxEv?=
 =?us-ascii?Q?6G/rdXfNkJELRgEq2KGe74cem2w3dfr5jV822Ia+5e8IsqBfMTJiiNlldWA7?=
 =?us-ascii?Q?uz3qpfIAayi+wHcMttrRe/3RAMBc3Md8jzJ/Bq865Wm5SULgYvBwkqJ5dhd/?=
 =?us-ascii?Q?hw06Nl99kseoanZKGnu+lk+qKDbgQDBqpMcsXPYtx1/F3L3aMapovdYspNEB?=
 =?us-ascii?Q?ocLBlCcUfpfwxb+SH9B3rnMC3ZWMxjrz5mk+kJkIxQR5ARNLFhQGoAXhD4Za?=
 =?us-ascii?Q?g92Fjp3cQ0apZi9WfK8SkYvR3nzDh3B7bE/5HbRZFjxERlJ9onoPRMHoMKP2?=
 =?us-ascii?Q?Z+j1r3S/yhCfqD3LmpJ+fSQfWTwuuLWQ3EzI5rULO379PqQgYVM1KUW0Dw/c?=
 =?us-ascii?Q?DCy4CYFZxdV9Tl1XrYQmH1ILYI7vtBoB8VgCuUDheEg4+YVXdUF/FW4wf5S9?=
 =?us-ascii?Q?zZ5VegAtAOsD4I1hPP10m4ZQP9bCAISp49J+MWjHR0LhkLZLd0qk+5ScUdKd?=
 =?us-ascii?Q?KNX/uRQsetJbidi4gPvUQjSfqm08gDEbjQ3Xb6IYOL5jPEGkHrZ6tT0URH+x?=
 =?us-ascii?Q?tXegwOTWfMPiWu6I1Ua+pMpvfv8xWW/XaT4zBgIaWv16iaTuFWSjB0RFgyp6?=
 =?us-ascii?Q?GVkTFFHGshhpyffRPaRBVisL0B6oC6RecZfG71YECQ4i0YEUCTJrDvTNz5hT?=
 =?us-ascii?Q?ujDfugwiE+7NSHab8Y+gZ8q9drRWAdgmP7Mij/hTUnHVSGIsy4tgJbUesMD5?=
 =?us-ascii?Q?7AkvDF+VkjvbHiDzxJmPqWcvI5Zq+Q2nz8nI6EXAncg5vMRyQQA407CpuVkH?=
 =?us-ascii?Q?95IcJzRLS0S1GwnmG7qO51ua3Na7T6i3Lp/ZpKJKyvg/JY+TUgxTZb547KHA?=
 =?us-ascii?Q?XohiSO2+492wU9G/aEj8bMw6iUI4NC3F2QLzNUhb1SARGYb1h+ZWIMdmTT8b?=
 =?us-ascii?Q?EBumHJjMRDSUNQq2I+LOf0fO4LgwGD6L53LIRTRVc0y59Al+ckvT1j6PSUeX?=
 =?us-ascii?Q?066ZPA78qFUZGvhTZelJxtWwM6BnnKTY4Qt7pmdZN+H5wBvnK92E4r8f38QS?=
 =?us-ascii?Q?fNXx6W+wXIaIaV3O5D/OtpwLqhwAwryQeRo4ivSiTX4hBoVElPzMaO5kmAPF?=
 =?us-ascii?Q?VnFM68vUkmYJubxn9et6O88WL6RRluM12Kkjw7ygx0ATiyECvOb3p3+22Osf?=
 =?us-ascii?Q?gFNUtZ6CnAdb43Z15r0GYj2vpad+IuaNXCicEXHHhkL/PlEV7EyJAe1kptC4?=
 =?us-ascii?Q?1+SiH3LmdKj+FEAvkmoinCgrfzQYlDVwwYbTS8T9tLBgS+hn26KHn5Jh4B+7?=
 =?us-ascii?Q?RkWifG290ocUk3N53edJyDKOccsv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Jmrm96R8zWkAEb45jJ1ga4DYkecRGOABJFEx/TEWcM99ZMxPZq8k1xZ19GYw?=
 =?us-ascii?Q?lyQ2b1gTcDKgdbJGsHGbHVCuOqyaihdzRYlroJ1RSXqRZCVQbmnnDD1JPvUO?=
 =?us-ascii?Q?pHKmvFweUoWIZT5hXV5neeTuIlXNtNLV2ot47NJXLf69IrqLmA9PUbbHXqEA?=
 =?us-ascii?Q?yDz6IvmDnlivyCspIbuCXgJQvLzoYNRdVb/WUsdyzvk6SnoTQZsb/q1GyZLg?=
 =?us-ascii?Q?VC2uCisFzy7c7LR1ccTFoZfWpi4Pq6pL3npArfnydgyD0WOj8hiReW2dFDFf?=
 =?us-ascii?Q?lMir5M1rntwvgXopKvzplbrPDHvKlZJMlqDwD11yhKAYu3X7Vf5DkCWH8ZAQ?=
 =?us-ascii?Q?HVHvvjX5TS9i+vMaRy87/VVNqZlQTFsTf4R9fsAf8Yh4Q1eKi9H2hps6pVNl?=
 =?us-ascii?Q?+87VPkYoQVPyTMQ0Anh8fKP5qhnG5VGr+1DOe18EQvgKz4LrEBUNiWX3/f2x?=
 =?us-ascii?Q?SZ101d7ZVAsg1CunuO+4Tl/Hwl98XnLhqvTH2w1zby4X8ZIEH06xav99525q?=
 =?us-ascii?Q?j2Y+ShbrXH+S2Zv78pjzapgPrnnp1kJR9nmv5TVFDhcwyhF9NRA0RgR0VF0V?=
 =?us-ascii?Q?8bAx+d7irtGtA3yhSGmNx+oiFGK33EbVNAr+ZLA1qY3Q0G7c+NDDX70hGFiz?=
 =?us-ascii?Q?Dpq1t/kUxvCxVuSXiusIFPdLmLd52YtmWjaa4sPpzDrnUXLl4sXQ9qFvnFHR?=
 =?us-ascii?Q?QIkj+nBQHJH/0tJzWR6K1bWJzaOnjW73kwfGF9i0OzzPTlJdTJoeDNwUTKj/?=
 =?us-ascii?Q?DiJ0LhIak2217Km7iCA0HliBK4Ylj8GRur46lgGS7NhfXNjZOTKdDMnp+18N?=
 =?us-ascii?Q?MktJMBZItRne1tM9O0tyiD/Fv4zQLEVib7FSt2F5Ay+mKumLJ+gkTzP6uCZJ?=
 =?us-ascii?Q?trl13bunByT/8SY54QUHybnZ4BPKb7+6PX/7TLcRVPUoVcFE8OjZp0TNzw9t?=
 =?us-ascii?Q?j/ZUxvcEgYPed7t5Dn1TSUl29yt3uQmH1XoGb35q/uyqv6jRLAjlwj5RF8oj?=
 =?us-ascii?Q?0qHujbu4HewNJREL0M4jgVHmLjr6ZttgvpbXQRXSitSjspPuuF8gaOTXwi2A?=
 =?us-ascii?Q?eCUELaxZaURHIKHolv6okp1ApWKyyJV08KBxAyOuw2YZLezdoFc2GVWqOLoN?=
 =?us-ascii?Q?jpNd0od+IhlN8hbIlcBTPwaCVZf01/5cv6QIKxApsT6igmzB1TOQFef6dA8P?=
 =?us-ascii?Q?BfrESk8wgThRk/TBFK+5Tqn6/pr5iCkDL9hwvAvJmiUkmEa5DA8FqOxHsPZo?=
 =?us-ascii?Q?Gp/XIovjfY+GnchEAIMsLufme1XpgjzFNeUXNL901JTBgFRgsR4hTmdHcDL0?=
 =?us-ascii?Q?XFSjDR9kO/r4L5pBGzWh0qVg6zMtCUUCV3Ci8ddhflNQ1LQzm3yLr6YI71Tb?=
 =?us-ascii?Q?lBlqSo0C5SMJgQ3XjuB53wpIK+nIXWCo1cKI8oh1/DDH55XIe3whNinLVDQN?=
 =?us-ascii?Q?P6ms+XUuRWe0Lm08prjGJYbG5dSpKskW39Al6FSt5qk3HToLWl6Y6X1oRmYw?=
 =?us-ascii?Q?NmLocY2Jly8WAD0dZJhz8Av4a0E9huVJGJwBOQhtvuRp8C4SRbhHv688iYeu?=
 =?us-ascii?Q?iWAyBeOzvFaqnhA5dEdsUfK+j34gFmaHYjP9SeAA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d84dc1e1-45a5-4ffd-f7d7-08dd5046baa4
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 18:04:46.8398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PYRwvCd0/Pka8QvjZBRnA8My+CUZeb0wsezISzQ7A4uB8WJztQDqFn6n4iwms8Ks7BZ99X/AeStOoAtjjjWDNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6230

Introduce a new kfunc to retrieve the node associated to a CPU:

 int scx_bpf_cpu_node(s32 cpu)

Add the following kfuncs to provide BPF schedulers direct access to
per-node idle cpumasks information:

 const struct cpumask *scx_bpf_get_idle_cpumask_node(int node)
 const struct cpumask *scx_bpf_get_idle_smtmask_node(int node)
 s32 scx_bpf_pick_idle_cpu_node(const cpumask_t *cpus_allowed,
 				int node, u64 flags)
 s32 scx_bpf_pick_any_cpu_node(const cpumask_t *cpus_allowed,
 			       int node, u64 flags)

Moreover, trigger an scx error when any of the non-node aware idle CPU
kfuncs are used when SCX_OPS_BUILTIN_IDLE_PER_NODE is enabled.

Cc: Yury Norov [NVIDIA] <yury.norov@gmail.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
Changes (this was part of a previous patch set, already applied):
 - rename scx_bpf_pick_idle_cpu_in_node() -> scx_bpf_pick_idle_cpu_node()
 - rename scx_bpf_pick_any_cpu_in_node() -> scx_bpf_pick_idle_cpu_node()

 kernel/sched/ext_idle.c                  | 182 +++++++++++++++++++++++
 tools/sched_ext/include/scx/common.bpf.h |   5 +
 tools/sched_ext/include/scx/compat.bpf.h |  31 ++++
 3 files changed, 218 insertions(+)

diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index 8dacccc82ed63..759a06774b5b3 100644
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
@@ -771,6 +815,28 @@ __bpf_kfunc s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 	return prev_cpu;
 }
 
+/**
+ * scx_bpf_get_idle_cpumask_node - Get a referenced kptr to the
+ * idle-tracking per-CPU cpumask of a target NUMA node.
+ * @node: target NUMA node
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
@@ -795,6 +861,32 @@ __bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask(void)
 #endif
 }
 
+/**
+ * scx_bpf_get_idle_smtmask_node - Get a referenced kptr to the
+ * idle-tracking, per-physical-core cpumask of a target NUMA node. Can be
+ * used to determine if an entire physical core is free.
+ * @node: target NUMA node
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
@@ -859,6 +951,35 @@ __bpf_kfunc bool scx_bpf_test_and_clear_cpu_idle(s32 cpu)
 		return false;
 }
 
+/**
+ * scx_bpf_pick_idle_cpu_node - Pick and claim an idle cpu from @node
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
@@ -877,16 +998,64 @@ __bpf_kfunc bool scx_bpf_test_and_clear_cpu_idle(s32 cpu)
  *
  * Unavailable if ops.update_idle() is implemented and
  * %SCX_OPS_KEEP_BUILTIN_IDLE is not set.
+ *
+ * Always returns an error if %SCX_OPS_BUILTIN_IDLE_PER_NODE is set, use
+ * scx_bpf_pick_idle_cpu_node() instead.
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
+ * scx_bpf_pick_any_cpu_node - Pick and claim an idle cpu if available
+ *			       or pick any CPU from @node
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
+__bpf_kfunc s32 scx_bpf_pick_any_cpu_node(const struct cpumask *cpus_allowed,
+					  int node, u64 flags)
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
@@ -900,12 +1069,20 @@ __bpf_kfunc s32 scx_bpf_pick_idle_cpu(const struct cpumask *cpus_allowed,
  * If ops.update_idle() is implemented and %SCX_OPS_KEEP_BUILTIN_IDLE is not
  * set, this function can't tell which CPUs are idle and will always pick any
  * CPU.
+ *
+ * Always returns an error if %SCX_OPS_BUILTIN_IDLE_PER_NODE is set, use
+ * scx_bpf_pick_any_cpu_node() instead.
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
@@ -922,11 +1099,16 @@ __bpf_kfunc s32 scx_bpf_pick_any_cpu(const struct cpumask *cpus_allowed,
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(scx_kfunc_ids_idle)
+BTF_ID_FLAGS(func, scx_bpf_cpu_node)
+BTF_ID_FLAGS(func, scx_bpf_get_idle_cpumask_node, KF_ACQUIRE)
 BTF_ID_FLAGS(func, scx_bpf_get_idle_cpumask, KF_ACQUIRE)
+BTF_ID_FLAGS(func, scx_bpf_get_idle_smtmask_node, KF_ACQUIRE)
 BTF_ID_FLAGS(func, scx_bpf_get_idle_smtmask, KF_ACQUIRE)
 BTF_ID_FLAGS(func, scx_bpf_put_idle_cpumask, KF_RELEASE)
 BTF_ID_FLAGS(func, scx_bpf_test_and_clear_cpu_idle)
+BTF_ID_FLAGS(func, scx_bpf_pick_idle_cpu_node, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_pick_idle_cpu, KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_pick_any_cpu_node, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_pick_any_cpu, KF_RCU)
 BTF_KFUNCS_END(scx_kfunc_ids_idle)
 
diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index 77bbe0199a32c..ca7cc4108b45f 100644
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
+s32 scx_bpf_pick_idle_cpu_node(const cpumask_t *cpus_allowed, int node, u64 flags) __ksym __weak;
 s32 scx_bpf_pick_idle_cpu(const cpumask_t *cpus_allowed, u64 flags) __ksym;
+s32 scx_bpf_pick_any_cpu_node(const cpumask_t *cpus_allowed, int node, u64 flags) __ksym __weak;
 s32 scx_bpf_pick_any_cpu(const cpumask_t *cpus_allowed, u64 flags) __ksym;
 bool scx_bpf_task_running(const struct task_struct *p) __ksym;
 s32 scx_bpf_task_cpu(const struct task_struct *p) __ksym;
diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
index e5fa72f9bf22b..2d9273f604ff7 100644
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
+#define __COMPAT_scx_bpf_pick_idle_cpu_node(cpus_allowed, node, flags)		\
+	(bpf_ksym_exists(scx_bpf_pick_idle_cpu_node) ?				\
+	 scx_bpf_pick_idle_cpu_node(cpus_allowed, node, flags) :		\
+	 scx_bpf_pick_idle_cpu(cpus_allowed, flags))
+
+#define __COMPAT_scx_bpf_pick_any_cpu_node(cpus_allowed, node, flags)		\
+	(bpf_ksym_exists(scx_bpf_pick_any_cpu_node) ?				\
+	 scx_bpf_pick_any_cpu_node(cpus_allowed, node, flags) :			\
+	 scx_bpf_pick_any_cpu(cpus_allowed, flags))
+
 /*
  * Define sched_ext_ops. This may be expanded to define multiple variants for
  * backward compatibility. See compat.h::SCX_OPS_LOAD/ATTACH().
-- 
2.48.1


