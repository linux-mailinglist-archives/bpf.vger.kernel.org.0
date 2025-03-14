Return-Path: <bpf+bounces-54033-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0061CA60DC9
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 10:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3FBC189314E
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 09:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386061F3B89;
	Fri, 14 Mar 2025 09:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MmjghGXz"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAF31F153C;
	Fri, 14 Mar 2025 09:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741945743; cv=fail; b=R0+wnDmZ+V1r49RlcX4g+wcjaFa8nK8YNJtn1VFDP4+wCJHQSLC//8nPtzlf3GelqpG8OOkxq/PQs3CahPjTsdd6FGu5Z79rBz9Aowq5LTMeVbOjykvQYUv//FN9O4lnIKlxMGaoE7hC9NnBuObREjkCqa3BLdfFPuzUS3WwYBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741945743; c=relaxed/simple;
	bh=1D2VheNH1Y0+OcqFatN7IMCF21qzaLMDwgiJEOPIkF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bisPmKQdyPpD3uh+BEYgXxYA4kuhe4aayt0R7UPhd743xauAt9I7kfS0mYEiUg4Dph+XChP6LrzEstDvhUq/WO61tb/G3mEXlCbms1UjYGdRIbhIXb6V+f7YH1jTazX31ORbsEfPeHsoC4PFxeRrzjvai8whDlEDtu03DHLYPcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MmjghGXz; arc=fail smtp.client-ip=40.107.92.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RpmhDvMjZ14APcR6tUb9+1Fk4QDoSjyQ76Q72W9+KNI4NC5yfWQUr4/pbWazj+W5elWLFT+vjXC6erwbJWQGvPDl3nHTqBBWThIiaIdyo9X6eaulnY+ABannsKez+EaqWHv95UMjJcXwzvrHlNAJRfaJbStgBD/O1caxQwPS2BRHYVfBN8XMR7S6KjRtGAWoLZyNyMmyvHbS2K0KJQjGgM95V460HzdGk51I5OBLh1VG94rrYSzIZc6A48iObTPW4671r33kckhupMIatn4p14/kqnaZl/M+CsEO61gROkHdZTwvnZGgKhuSoAbW8oW4UyzM/k349OkdLh30ZsMLFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aMCu3MMj7Y30kvN4Bt88uO3hMhGzCoUcbRVOTlDhLi4=;
 b=f+X/mmdpXn0KIcdEB0+cWvWesRXFjAnt5j8a7bs+O7urLcFvKjiF0VBr2GQ3sKz97MgvPoTqaOOpiLsJe4TIAMSegCYxTgWpfSUvTXVfW3yGjak5vFIjY4lTejv6O3QAT39Ag561QdSgcWM80T+cgkI/qDHeqXrfv46fNNwOMR/eibhydb01yYdBCWqN4a8AOVB3vMgjEmzxDHwLduTfpcWtjmV1anQkRgDtezHHbu4qlCJfETXDaevItH/2Uww9SzfSsua57G1NUpzWF5ZU9Z2jnMNwHAYqfbsvbnVDL0KxJVwnFl8y0hG8WcFKDKuXOP/rJUueTp+oKwrSasWNeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aMCu3MMj7Y30kvN4Bt88uO3hMhGzCoUcbRVOTlDhLi4=;
 b=MmjghGXzsmUvx6KgRSD2Kc+HSmOBHxExY/QZXPLh94eXgavVpaBDMRuBrUbsbCXvOg1oiAtDSOQ5fCFFLQusZ0AhJmAF6o1dzxQKU84qdASbhuJOshS9l/snMmXL1K+bb9NUI04LBXbrkdJe7X0OZuznAMbvyjoQqbdqIOdd58iKNGD8DjShX8Qh77oSIccUGQMXUEzO3g/l3+VU647tIajqG9FdOWRg/YdvCY1n+9ThBR60IM3PklbdE87tEBdDOjbI3t4FNQtbVQWQgcOkInKpOFXFv+bzHK7E3cYYjG+r3NkGDM6a5bhDFFbmlPIjP+zilHBL6Vg9L02SHYAsrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by CY5PR12MB6431.namprd12.prod.outlook.com (2603:10b6:930:39::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Fri, 14 Mar
 2025 09:48:59 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%5]) with mapi id 15.20.8511.031; Fri, 14 Mar 2025
 09:48:59 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] sched_ext: idle: Refactor scx_select_cpu_dfl()
Date: Fri, 14 Mar 2025 10:45:34 +0100
Message-ID: <20250314094827.167563-3-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250314094827.167563-1-arighi@nvidia.com>
References: <20250314094827.167563-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0004.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::15) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|CY5PR12MB6431:EE_
X-MS-Office365-Filtering-Correlation-Id: dc0b05fd-65da-4a92-2d04-08dd62dd7196
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2Dm6dVmpwki8rqDQLCw04NUe6YnsrIdXqUlld9ySouc1KYliSCBMoWL+Y4MZ?=
 =?us-ascii?Q?Jc1qQwvLO92/48FUUyYPUHcPnFAamVLVOl+YREXg6+S+SG0XXysCyKpmA6be?=
 =?us-ascii?Q?rh8e3LNQ8GTAiL5Jwg//fDQS5chlmZyyb3FucpKVG05FVC9U33C4WELqwm+S?=
 =?us-ascii?Q?v8E5TIlx0J75cxL/no/pCqiicwJzQOmz90YOryp8/BYhKBWozcrf8ZZzwVsn?=
 =?us-ascii?Q?dAMBgOhcL48hHTTZNjtn5Y20QUDTz83dtl7tdBjFJHDZ4/hhqJDdiHUCCy0A?=
 =?us-ascii?Q?uDedEYRhPW0Wvb4RXCh7B4OR3WckVAJ8aoSH4KRoG4kRB609hbiTXoizX70q?=
 =?us-ascii?Q?FXL91aE8SeVs/qCOAmCo8/a762JL48wjlpNAg1cPVmnXwnrhpdYvlsJbvauG?=
 =?us-ascii?Q?TnzMMj6WnNSIcdhdZDC4GtBe3ThHTwshASguRmTGrPAKNUTgls4o3CXsDwKj?=
 =?us-ascii?Q?DvTOGiqDt0iie8ZfwjsEoTQZO9kGQVPyUQdymEUqm25A9iPyWOuEYJq8H9vy?=
 =?us-ascii?Q?8ySEFf92RKusyorBcEvOKFDINrwa4P5fCs/aXA1sGXUyyFwH6lMzGwho2dxG?=
 =?us-ascii?Q?AonVrFw8Kof5hDLjAzsZOak6ebL1g5emwfG+tCWJ5CIaOxEWgBuxXqOIuffm?=
 =?us-ascii?Q?RQo7sU7+a4MLFpQ6A5c00SX0kSIpWqg/y/JiGPuobY3mGAUtD2zGWJxyEwr4?=
 =?us-ascii?Q?Kk+zzzYY8X8LATU9/VyMlj8AXYElFHc92delKf5+/cAEbAeKsW8CEikOanyL?=
 =?us-ascii?Q?pvh0sFJXACMXz9ixYeA0kZGcMbhZKujAkMHjhINW8Xg69WXet5QziRvcnclt?=
 =?us-ascii?Q?mMDXoEi72KPqnGAsupta8uoxx/vVNDbl/3tZas5eowEbWz9BRBUqzQlZerKj?=
 =?us-ascii?Q?6GKjTrJ7LFAdu2rKVkVNmpfQb0JzszqTq7W+/URwPJg+l7vV2H81S7uEvAJZ?=
 =?us-ascii?Q?DFXuABDxVfpMJS7Udvo/i1psHLEMEnm2QLvhc9n4HCj9wPPftFrO4CUXVsmw?=
 =?us-ascii?Q?UR6gkWRGq2IiKK4G+cVgnpKR2azWj/OVvjp4bajv/6jYqRihx6vLepsIPEj2?=
 =?us-ascii?Q?FlYmboP8II50GdNDNHaK/zn99VoBs8V5d2ZhyYfI5ADQjTGN682cXCpPscID?=
 =?us-ascii?Q?ItM5KuOr76n41jPMtKWacW4Kmw2sma04b+ymmExogIMxgUp4njIcQo1g3YBA?=
 =?us-ascii?Q?qpM+ahjFiicVZ1ZgkGwX7O6SfmCBBpLmHcUJow9rAz9kpaT0hojh/plfw6FK?=
 =?us-ascii?Q?dTTyPGwXZ3rUovfwGLzEfQ202/9sGj14jMtTQWkx0qHUYVeicqtw5NAKIUci?=
 =?us-ascii?Q?Bp3/S4v3uuWnp01Sehw1kowEh0VBz/5tm+xWUYVcjkyhDU52ko6ODkHlFM/A?=
 =?us-ascii?Q?uyEWVoug1bX4rchvLJ0/j389Z2iO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?noIzzuQUZaPCGOWTI9SV13qHXR1mYhLoJPU0aBbbtvzLkGJEErpu4HUQ3QHF?=
 =?us-ascii?Q?u1MWe7A+8hWxEmAbFucBflxl/QmhsOKTVT+tq8s6WIkcP6ot+9HljyNaiNnV?=
 =?us-ascii?Q?+pc+eKm9OgmXfIqGBg49KssDaUoLZgu8i1XgSMs0zi0LcBaRKLCq3oB3wn5t?=
 =?us-ascii?Q?A7MEVXgOKGdgukYVTKxF0QVfKQWey46pYRL4ti9Z59spIWFWY8imQ7yz+GYC?=
 =?us-ascii?Q?oSzZ3caWwG2DsjyH677hhNtkGNaxVhgBiojQsFZNI5EqEurSPmx12AD4nhqS?=
 =?us-ascii?Q?sRAkyA50jz8fPFCbEct+D6bKrmLoT/hYtivH0Zznc45eehCkpOmOZUOqr/Re?=
 =?us-ascii?Q?ytwI3E7/btX0YCkBKeVixuVfIVmyTVzoGcJAwuB6OextgIHsxrgdr3OAKt3R?=
 =?us-ascii?Q?KWnfAxlsdYhgLaMSGq/Yc905LDKGaCEjhXJTqq9EMB0Y/o1RGno+dPzGvgAb?=
 =?us-ascii?Q?ReYloI3Haxo9rESpkfuRq+iMxVZ9Q7HAxuGVG72FMjiatMm60tM1p7YXEXx4?=
 =?us-ascii?Q?UsRqHGA2d9G7S83tSPZJ4wfTC2XT3kUoFBPO9JjWhLzdbt8lT6E+OYJzqkH+?=
 =?us-ascii?Q?y9bzrG8gLGq4cwZzGKeKWmiH97LXXfU3AHRIBhuH3xRfd8c0QlrU2d4XCpz+?=
 =?us-ascii?Q?C95lEGM7dG6iPdlNoXASn5tQ1zf7ep2H+wXNbXNxbrRlSdaOD21piRZKpSPd?=
 =?us-ascii?Q?FKu8FKdBmcqpAA79/a1zIFW1dCWrW2SuNMo8mJFxtSmMO0RQ7w4cXWrgJTl8?=
 =?us-ascii?Q?MLbzfrlhPaCUIHKIT9qzRo/F8t96SdW87S3uGyX7wH1kFajyS42BAfnFAATM?=
 =?us-ascii?Q?Lmu+EqiGHwf8IXBfXeHcz+49GeBICjO6CdLReizNr6dHHjWUcw1uerNbZW1f?=
 =?us-ascii?Q?+6GXOgRz4aKwLDpfCdjTFr90hja1MJC/uGZMyXNW4xLuOKFzGXhSO9pHiyN5?=
 =?us-ascii?Q?Ykf9g7OSeTOWzxaOVKbq8JC508V/alUhYg4iBvZV+VWjHGMEvUGHQ3qUUrrf?=
 =?us-ascii?Q?eYE/K3ptEN/zJCNHcA5/xN8f0G/a0aMK97gttNlCisJUxMjYSZuWgQYAcQzf?=
 =?us-ascii?Q?nCoZqOXM5d4KEb5vI6xGYt4XuAGePMw1XWtxVEMzuP+Lssn4RpgE8z4RlV5t?=
 =?us-ascii?Q?oJo5cD5HQjACvm75PHUSH1ISv4rNCULsg/frq6ACMBLhJ67sbSTN6t8d6OH+?=
 =?us-ascii?Q?NrnKTsSHOlGr3Mmb1U/HEIhgpWJ35kx8NFEsCliIXh/3FiZ382m8yqSWpZjm?=
 =?us-ascii?Q?kvkpLasWimMGKeBC/oU+WTdyiO0o9XLUhkuxpmn2E5qyJZCJtA0Ws/upTbRN?=
 =?us-ascii?Q?8wvrgjA4K3U3swM/8vHNyOGtJYmsLkcQl8q53i1paMdel8f8RDVC6E4T5nHF?=
 =?us-ascii?Q?XAxdKNZzD8indxxp51Iih0zY9Jh0Kbw+bN9gLi9ggfwvomdmp4rxxa5y5Waj?=
 =?us-ascii?Q?v5AIwIZPR2l2S7Msg8bR8SpoyF1bbDNwmK7nUJqhm/1DPAn8/2CceWqpLjTv?=
 =?us-ascii?Q?4DRSPffxPmpa6qbZIAFBDYLJpZL3kbokAWW/vCpQwnheGcZ/lUdrwaouB+wR?=
 =?us-ascii?Q?+XQOM+2ixu/AUkfkXeF6wmOUkFWEp6175yTabLG1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc0b05fd-65da-4a92-2d04-08dd62dd7196
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 09:48:59.0286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KB5/w0VB3sHcXXkXVGGtByNDlWx2ycxYI83tkMGK/hsgavlqOtKZjkUN+i+Vj+x8LFyn5wtVvl2tn0e0Q8c3jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6431

Make scx_select_cpu_dfl() more consistent with the other idle-related
APIs by returning a negative value when an idle CPU isn't found.

No functional changes, this is purely a refactoring.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c      |  9 ++++----
 kernel/sched/ext_idle.c | 50 +++++++++++++++++++++++------------------
 kernel/sched/ext_idle.h |  2 +-
 3 files changed, 34 insertions(+), 27 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 1756fbb8a668f..06561d6717c9a 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3393,16 +3393,17 @@ static int select_task_rq_scx(struct task_struct *p, int prev_cpu, int wake_flag
 		else
 			return prev_cpu;
 	} else {
-		bool found;
 		s32 cpu;
 
-		cpu = scx_select_cpu_dfl(p, prev_cpu, wake_flags, 0, &found);
-		p->scx.selected_cpu = cpu;
-		if (found) {
+		cpu = scx_select_cpu_dfl(p, prev_cpu, wake_flags, 0);
+		if (cpu >= 0) {
 			p->scx.slice = SCX_SLICE_DFL;
 			p->scx.ddsp_dsq_id = SCX_DSQ_LOCAL;
 			__scx_add_event(SCX_EV_ENQ_SLICE_DFL, 1);
+		} else {
+			cpu = prev_cpu;
 		}
+		p->scx.selected_cpu = cpu;
 
 		if (rq_bypass)
 			__scx_add_event(SCX_EV_BYPASS_DISPATCH, 1);
diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index 16981456ec1ed..52c36a70a3d04 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -411,22 +411,26 @@ void scx_idle_update_selcpu_topology(struct sched_ext_ops *ops)
  *
  * 5. Pick any idle CPU usable by the task.
  *
- * Step 3 and 4 are performed only if the system has, respectively, multiple
- * LLC domains / multiple NUMA nodes (see scx_selcpu_topo_llc and
- * scx_selcpu_topo_numa).
+ * Step 3 and 4 are performed only if the system has, respectively,
+ * multiple LLCs / multiple NUMA nodes (see scx_selcpu_topo_llc and
+ * scx_selcpu_topo_numa) and they don't contain the same subset of CPUs.
+ *
+ * If %SCX_OPS_BUILTIN_IDLE_PER_NODE is enabled, the search will always
+ * begin in @prev_cpu's node and proceed to other nodes in order of
+ * increasing distance.
+ *
+ * Return the picked CPU if idle, or a negative value otherwise.
  *
  * NOTE: tasks that can only run on 1 CPU are excluded by this logic, because
  * we never call ops.select_cpu() for them, see select_task_rq().
  */
-s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64 flags, bool *found)
+s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64 flags)
 {
 	const struct cpumask *llc_cpus = NULL;
 	const struct cpumask *numa_cpus = NULL;
 	int node = scx_cpu_node_if_enabled(prev_cpu);
 	s32 cpu;
 
-	*found = false;
-
 	/*
 	 * This is necessary to protect llc_cpus.
 	 */
@@ -465,7 +469,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64
 		if (cpus_share_cache(cpu, prev_cpu) &&
 		    scx_idle_test_and_clear_cpu(prev_cpu)) {
 			cpu = prev_cpu;
-			goto cpu_found;
+			goto out_unlock;
 		}
 
 		/*
@@ -487,7 +491,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64
 		    (!(flags & SCX_PICK_IDLE_IN_NODE) || (waker_node == node)) &&
 		    !cpumask_empty(idle_cpumask(waker_node)->cpu)) {
 			if (cpumask_test_cpu(cpu, p->cpus_ptr))
-				goto cpu_found;
+				goto out_unlock;
 		}
 	}
 
@@ -502,7 +506,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64
 		if (cpumask_test_cpu(prev_cpu, idle_cpumask(node)->smt) &&
 		    scx_idle_test_and_clear_cpu(prev_cpu)) {
 			cpu = prev_cpu;
-			goto cpu_found;
+			goto out_unlock;
 		}
 
 		/*
@@ -511,7 +515,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64
 		if (llc_cpus) {
 			cpu = pick_idle_cpu_in_node(llc_cpus, node, SCX_PICK_IDLE_CORE);
 			if (cpu >= 0)
-				goto cpu_found;
+				goto out_unlock;
 		}
 
 		/*
@@ -520,7 +524,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64
 		if (numa_cpus) {
 			cpu = pick_idle_cpu_in_node(numa_cpus, node, SCX_PICK_IDLE_CORE);
 			if (cpu >= 0)
-				goto cpu_found;
+				goto out_unlock;
 		}
 
 		/*
@@ -533,7 +537,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64
 		 */
 		cpu = scx_pick_idle_cpu(p->cpus_ptr, node, flags | SCX_PICK_IDLE_CORE);
 		if (cpu >= 0)
-			goto cpu_found;
+			goto out_unlock;
 
 		/*
 		 * Give up if we're strictly looking for a full-idle SMT
@@ -550,7 +554,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64
 	 */
 	if (scx_idle_test_and_clear_cpu(prev_cpu)) {
 		cpu = prev_cpu;
-		goto cpu_found;
+		goto out_unlock;
 	}
 
 	/*
@@ -559,7 +563,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64
 	if (llc_cpus) {
 		cpu = pick_idle_cpu_in_node(llc_cpus, node, 0);
 		if (cpu >= 0)
-			goto cpu_found;
+			goto out_unlock;
 	}
 
 	/*
@@ -568,7 +572,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64
 	if (numa_cpus) {
 		cpu = pick_idle_cpu_in_node(numa_cpus, node, 0);
 		if (cpu >= 0)
-			goto cpu_found;
+			goto out_unlock;
 	}
 
 	/*
@@ -581,13 +585,8 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64
 	 */
 	cpu = scx_pick_idle_cpu(p->cpus_ptr, node, flags);
 	if (cpu >= 0)
-		goto cpu_found;
-
-	cpu = prev_cpu;
-	goto out_unlock;
+		goto out_unlock;
 
-cpu_found:
-	*found = true;
 out_unlock:
 	rcu_read_unlock();
 
@@ -819,6 +818,9 @@ __bpf_kfunc int scx_bpf_cpu_node(s32 cpu)
 __bpf_kfunc s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 				       u64 wake_flags, bool *is_idle)
 {
+#ifdef CONFIG_SMP
+	s32 cpu;
+#endif
 	if (!ops_cpu_valid(prev_cpu, NULL))
 		goto prev_cpu;
 
@@ -829,7 +831,11 @@ __bpf_kfunc s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 		goto prev_cpu;
 
 #ifdef CONFIG_SMP
-	return scx_select_cpu_dfl(p, prev_cpu, wake_flags, 0, is_idle);
+	cpu = scx_select_cpu_dfl(p, prev_cpu, wake_flags, 0);
+	if (cpu >= 0) {
+		*is_idle = true;
+		return cpu;
+	}
 #endif
 
 prev_cpu:
diff --git a/kernel/sched/ext_idle.h b/kernel/sched/ext_idle.h
index 5c1db6b315f7a..511cc2221f7a8 100644
--- a/kernel/sched/ext_idle.h
+++ b/kernel/sched/ext_idle.h
@@ -27,7 +27,7 @@ static inline s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, int node
 }
 #endif /* CONFIG_SMP */
 
-s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64 flags, bool *found);
+s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64 flags);
 void scx_idle_enable(struct sched_ext_ops *ops);
 void scx_idle_disable(void);
 int scx_idle_init(void);
-- 
2.48.1


