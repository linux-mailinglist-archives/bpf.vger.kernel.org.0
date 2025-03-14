Return-Path: <bpf+bounces-54035-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFCFAA60DCC
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 10:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32F823A144C
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 09:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3205A1F3BBC;
	Fri, 14 Mar 2025 09:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gHYtc4Og"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95991F30BB;
	Fri, 14 Mar 2025 09:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741945760; cv=fail; b=JpVxDSXVp7nzt27+lPbjCOD1Kk5wWMwHEHdf1q/OzlhTdT7phbmjVF4H9HLUcWSn19yD4xRR3Yz99T5r/T6KFsHERSPemBqneZA4bjP8KBHt6hfBZeCSy2giF0lTNrGA0CgmvEyAICnwHpIJMfErivGRgXXyALe9fUEmFA0b134=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741945760; c=relaxed/simple;
	bh=hlXkbZyUl44Q+iEOLwaldzCyKc1R+CvoSPRbRbt0v7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cp5Z2DMRnVsppLR9QuKaaVYXHrzJDXT+qZZuV2yfJRXP9d5YAT1xr+AkvBqH8k66/1F2doPkZxP8+8IVi0T1yOMIMUoItOnRXTmsOzBrYsxaPq0ZTylReINVwuMdteqV3B0tXZXBtnWRuPB4E2kqaL2PBi6Lpnsjo0KSQsRRBVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gHYtc4Og; arc=fail smtp.client-ip=40.107.243.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j758joNP5Dx6/E3rZQBWDauQsjEd8eeuzayqyOz9xxZIKbl7uGWNLmC6jLqkRjc6BHEy5Gwy2JtcQE6r599B4WOl9ubpJWWpXI7X3nd1NC5jTlL6q+8HBrQ0gY3Kj28dOeuQFVMQA6HMP1qHhgnBRDua8g1ZW4V2vUe6OI8EGEHKUJWGeShZMzGtNMlCMOR9LU+GzDHVOIabkbLorzkcX9gokVdmLX4TbOcBIliIZ4Uo1UNdmgYumpoPGfqfGeoxdS+PV+xaerwQUkb94gUU3S6OwtOKjj3FEcIgF88x1oDYQ2QRrDDoe5ER34Fl/Hxs2VZYuC/2ESP9zi88ct4JOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DMn8rp9O9EwslskOheB3gYvdo2XTrbiXlwMHGYAFQGM=;
 b=rW46T8AUx0Rptz8rs8PrkLI8Jk+wdMOsuMtsspvj7DpvzOgWjWr3D3ymf24amRMSpeX12VcOAOPqd8U1AfBLhXTacwm/tE2Q6Xe7HfS9aTsHlsGnBWtyjX6SrmooLoTE4vS2Y49R5w0W4uPZf/rvnlZzv8LXMIV/ORm3uy/kTpA4xm3l6bBRJMNDzHvJJa08Rw6W+Mnp3kS0ZIUFC8lTUj3Tperqvpn+rTQpeztdScfxDAU02dLdRn+2mj39THS17GdQtUewuVs+IXgRA33rdtdrkXNdSnkZpo5gQRMKzU1mkR5U+/lzgDAo308ve4kOdrVprqInhh+6IadrAt0K8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DMn8rp9O9EwslskOheB3gYvdo2XTrbiXlwMHGYAFQGM=;
 b=gHYtc4OgFj/9yfQdP93p07m7KjB5DDSciN2djnTv9MV2pE5atwot+TNbxiwBV/jvYO89ffQybyVTiyF23waAXy87TIcx8BIQuqsLiuu+OtCp7dgjOD6Jyp6IDIwSqO6DiiAxhkkmDQ0/IwvhSQLynw/kbOjTIZ4fD5264wac5m1Gk7ib2a9BNzbhOrcaKDcrWSln8sr2AT0AmkmlPWl/05+aCI11C+qzo2WVg1ahc80bZviqKK8lSIFQmG+MHKq2T+4rkwQfMncmrR+nAeWwZtUGIpTTErM2AAs8ijS1frMh371g0dx6uf37AMHH4fYtn2/6qWT+Ss9zwFqpyox/7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by CY5PR12MB6431.namprd12.prod.outlook.com (2603:10b6:930:39::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Fri, 14 Mar
 2025 09:49:12 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%5]) with mapi id 15.20.8511.031; Fri, 14 Mar 2025
 09:49:12 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] sched_ext: idle: Explicitly pass allowed cpumask to scx_select_cpu_dfl()
Date: Fri, 14 Mar 2025 10:45:36 +0100
Message-ID: <20250314094827.167563-5-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250314094827.167563-1-arighi@nvidia.com>
References: <20250314094827.167563-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0062.namprd08.prod.outlook.com
 (2603:10b6:a03:117::39) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|CY5PR12MB6431:EE_
X-MS-Office365-Filtering-Correlation-Id: 59d545f8-847f-4c6f-9aec-08dd62dd79a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W72TTPr3Bga15BkFY6GHyBQF+rgwIb8fbGsTDO/AGrDDiNDRVyKzADScw2ON?=
 =?us-ascii?Q?1jRFVr47aK/yYHdm7OQIvE5zelIb9rUYYpjxlOEQDbIj217I9IvymYsWbt1y?=
 =?us-ascii?Q?zU6Q2J83Z3UB4oP9jUnkpf7IqDfRRFOpgMClsIkqHaA53m6jw5IADluy31gR?=
 =?us-ascii?Q?X9dVIVjeIjUje0fyAnXQItD9clccUPM58/zf6L6S5iwatBmoyrm5CpjsRAeI?=
 =?us-ascii?Q?MVqOPlYyjNJ7tWFDviXh9YqP8k3hSIT+zv05Mq0W/9FEM6RjClJKXn0Iu0Ew?=
 =?us-ascii?Q?BdJCvFFpTRlfA7jNDfcCy/8vI2gwMrUAQRrEEwEEvXlOgswJvvMvq27VA/SH?=
 =?us-ascii?Q?dzra/KEaFRf5TZeRdFU+L60URgwxmFeAzGi1RLzq79E2xox2I94F014Q4Zpg?=
 =?us-ascii?Q?jeJxwdjHWfE//0tSSGxjNVULmlnuYpH8QXT3GhzzM6ejGkj7YyEuUkbYNX8Y?=
 =?us-ascii?Q?6sAAuebKzC+Ap7ginJlrbxAk5w3XL7+gbUln8Xj7NqyIpfSjEX7Wc/xOpGRR?=
 =?us-ascii?Q?YU8Ow5GDAZ5WjWzx8zOuSA1cb2hzy0H+pNgt7kyPp7V53Z8YXoW/MOjvKuyP?=
 =?us-ascii?Q?6GL9A1VioJaIt8X/FBIZDD+qhHQ5pRX0ac6MsRyPNhPflLeAgAC1hwrjdUDY?=
 =?us-ascii?Q?varuDOCmcmyqfOWMgeuyQMaeEvQWZ8azz0WcKdQh29FB9VnRdLS0tjJgPY7Y?=
 =?us-ascii?Q?QamEasiF3H2dpZgfVFJIJgFhU99I3oCozf6eaXFkG0p6yETlLX1FPrV75SC3?=
 =?us-ascii?Q?jcs3B1Ea3WauYheuuo89bnXbP2zinHvD6BYab301eQdt6AjNTvXrC6zwNaLl?=
 =?us-ascii?Q?gCksT90ScWggVK69epgrDKzyzOnXOXDKo7PZlFMr9aahKSbYUoc2asQbQ0Bj?=
 =?us-ascii?Q?YBDBydUsdgEReCHWguxDWh/kbiHGiXuOIiq9fyZ2Yoq5W4ZpUuuITd7slgsy?=
 =?us-ascii?Q?X0erbsidD+CWqOD+OZYuUt7EzHEjynTJkeATC+W6yqFmfCQjfylt1uFZRhvU?=
 =?us-ascii?Q?aTDmFqj+JjTfeJmravccd4hNQvuQrtdZJdbQ2SLJKjay9m/8QYTVNIvp5s1a?=
 =?us-ascii?Q?OreC79UbTbB3olORrllVqJfhvGUqx72Qyw+pUGLz/3lOMKglp5qub/pXHEeD?=
 =?us-ascii?Q?dTU5I0hoJYafmF71opD924isZ/8C8GjlwFysy82U48wJ3eoeII7NDxev4PYd?=
 =?us-ascii?Q?mdS+d78B2BXv7mzwt34Sbpu03kFQ5nYeTasNJzcd+Dam8Wmi99BtSGFnl+AQ?=
 =?us-ascii?Q?YpKqtIa+PKXaX5Oj82yQDyIl6x3jUE62rqa7nKQgcWPoOKhuIsc73cAm0YX5?=
 =?us-ascii?Q?u54c7/wD0O+B96FImwyUMOyF9r7eFFqh7cuh4RPYfgDxouJ+jycl3rwSENEa?=
 =?us-ascii?Q?UAkOhSR1nhru/uO/N1g7KufeCZ4/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WIVg2QbfgfxJlz10GUHjN28XnAT3uQMQC5pNyYhHc1KvzgS3thY0VcX9W19X?=
 =?us-ascii?Q?UDKatoyZ9TPb62Vsd6pRjChRIcHg5jWXAK9lSVesyxpwekWlzjFfKaq1mcL7?=
 =?us-ascii?Q?Sx0SDQ1U/dMu0OUN+Dl1pzl3RAJMWrSOjMqmAgBPnG/9h2E4cNScVAq+jwpm?=
 =?us-ascii?Q?p3ZssTSvoGA3c2MX91dunxU031mqFGgPP8p03/pWqHLA8l/tz2cSci3dc6nE?=
 =?us-ascii?Q?85/1xmAtj3s8eqyBvem4htHzaZQGzlIcbNGQFEmBZ70ikjHERWXblnqu4Vxq?=
 =?us-ascii?Q?MMYJezemxhrB/VZ2n/hJyNeKJojIDg4Us7yVDoDsKIFRSWEqU36QbUmbxLHM?=
 =?us-ascii?Q?5qUPhUToQKUy6g8Pj2HWxGu6Q87hYABDRaKtsQ2AVvHwQV/O+f9DFakRlrqS?=
 =?us-ascii?Q?x4zRlx1m7APRGIP01bVK/oNreebk8woVNLQZXXhI+YKBnRMwi/BdRN0LKI9Q?=
 =?us-ascii?Q?+N1wBDuvIyR9aA1SjIaWG1WKfAPtVCCUOUIjdXJumEcHb0HTzhj2xrZ2xELz?=
 =?us-ascii?Q?tXuaS+gYPuElVXMY5gYiWcVd8JciC2hKnzJXPyfTgwo+chh/I6KZrSpg+MMN?=
 =?us-ascii?Q?kp+5Hpe76pEyioIS4+WeRbxh7MOTeS2W5WiKn1e0zQVAWBcPTekjzEa4fLfc?=
 =?us-ascii?Q?/tGuK2rHpnn9zO0N9DRvZPZAbDD5EPJ4Jr0qi+9BqR+CrwfgVKvK+Se1+r6N?=
 =?us-ascii?Q?6I1TKj3B1MNmAW1KmKZtr5q7Wj2wngDuFfYgyKHFs7/9rf2J7+WLj0Qwr+Z9?=
 =?us-ascii?Q?Xk2G6nrg/oGRrUKZKxO96iaEtN+KH7HjhAeQW4Ubp89weW2CoUG7Uhs2kObQ?=
 =?us-ascii?Q?jZpyHRd0lBy43gKP17iJvVVefGtIIcjXtPNnwYPOc7KT0C3Zp04+f+xiVcY5?=
 =?us-ascii?Q?SCY2QJHnCfdodMRvXDoBgZMVxCEXEfc19WJDkwyIwSzo8nbpup7NGOm9fQmq?=
 =?us-ascii?Q?LR3glJWiq+Qv8IpqUy7av4ggxhUeJa5XzudHulPX/qUi8HYhS8yjg6/2d58D?=
 =?us-ascii?Q?pWYdbpx5FcchhaeA26Qofwf/Bq+HwXkmVCxWm5pyA8TtEMyzi25rS/wWLvr8?=
 =?us-ascii?Q?PezaayroQIL2V3NXx3MTvK9aYVi+TbxS0BYUhe7PV6szXKj4oJ0/Jhz+mMSN?=
 =?us-ascii?Q?qtBjYTud2lDB2ZtrJffy48+KStFXoUSp2AXF3Vv55zoN7VdGLPetWaeHx1To?=
 =?us-ascii?Q?a7/gO/F87Ea5kvVYszbaYH9HVMBHYACmZJOAL/y3lQ7G3CvBnNoF9BE7yrhX?=
 =?us-ascii?Q?zclUmeUQhdXsg0H2kKJnKztwuhd9+rtinByLd2JIivq5aNAROAu/46JZQYpN?=
 =?us-ascii?Q?FALzE8lNtseeKCSp2GISHVTu3MArKc5EUDJCgbdB4aFrYUQTPq+3bSMFvrCe?=
 =?us-ascii?Q?NYNTGfTcYIppqUO3fmTHvAld/d3T3z2HDQ6f8IVGBaXZkbVeOy5QQTQnXG1y?=
 =?us-ascii?Q?Jd2eLwlL/1Yo5GZssldjEJHAXS9ug5UqrsbEDr7jEslyXkbd3nP1YMqsMKnZ?=
 =?us-ascii?Q?Oh2nF0ZP05WBGSPtMsNhmzjwh7NvDskx2fGsNlvOQBo98q394IIre61xowp9?=
 =?us-ascii?Q?vqXMwQ37ha08RvTXt7Opgw1jbkTu8N2TwFV0Othc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59d545f8-847f-4c6f-9aec-08dd62dd79a0
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 09:49:12.7024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9jNA+ruZNygPJbRj8Zg+g3+5nqwkGbEpFB36TAP/095esRgSQI9+yyCsCdHOnmQa1EvXkvyG6fGwiMEbJf/g7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6431

Modify scx_select_cpu_dfl() to take the allowed cpumask as an explicit
argument, instead of implicitly using @p->cpus_ptr.

This prepares for future changes where arbitrary cpumasks may be passed
to the built-in idle CPU selection policy.

This is a pure refactoring with no functional changes.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c      |  2 +-
 kernel/sched/ext_idle.c | 23 ++++++++++++-----------
 kernel/sched/ext_idle.h |  3 ++-
 3 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 06561d6717c9a..f42352e8d889e 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3395,7 +3395,7 @@ static int select_task_rq_scx(struct task_struct *p, int prev_cpu, int wake_flag
 	} else {
 		s32 cpu;
 
-		cpu = scx_select_cpu_dfl(p, prev_cpu, wake_flags, 0);
+		cpu = scx_select_cpu_dfl(p, prev_cpu, wake_flags, p->cpus_ptr, 0);
 		if (cpu >= 0) {
 			p->scx.slice = SCX_SLICE_DFL;
 			p->scx.ddsp_dsq_id = SCX_DSQ_LOCAL;
diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index 1940baedde157..27aaadf14cb44 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -430,7 +430,8 @@ void scx_idle_update_selcpu_topology(struct sched_ext_ops *ops)
  * NOTE: tasks that can only run on 1 CPU are excluded by this logic, because
  * we never call ops.select_cpu() for them, see select_task_rq().
  */
-s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64 flags)
+s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
+		       const struct cpumask *cpus_allowed, u64 flags)
 {
 	struct cpumask *llc_cpus = NULL, *numa_cpus = NULL;
 	int node = scx_cpu_node_if_enabled(prev_cpu);
@@ -448,12 +449,12 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64
 	if (static_branch_maybe(CONFIG_NUMA, &scx_selcpu_topo_numa)) {
 		struct cpumask *cpus = numa_span(prev_cpu);
 
-		if (cpus && !cpumask_equal(cpus, p->cpus_ptr)) {
-			if (cpumask_subset(cpus, p->cpus_ptr)) {
+		if (cpus && !cpumask_equal(cpus, cpus_allowed)) {
+			if (cpumask_subset(cpus, cpus_allowed)) {
 				numa_cpus = cpus;
 			} else {
 				numa_cpus = this_cpu_cpumask_var_ptr(local_numa_idle_cpumask);
-				if (!cpumask_and(numa_cpus, cpus, p->cpus_ptr))
+				if (!cpumask_and(numa_cpus, cpus, cpus_allowed))
 					numa_cpus = NULL;
 			}
 		}
@@ -461,12 +462,12 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64
 	if (static_branch_maybe(CONFIG_SCHED_MC, &scx_selcpu_topo_llc)) {
 		struct cpumask *cpus = llc_span(prev_cpu);
 
-		if (cpus && !cpumask_equal(cpus, p->cpus_ptr)) {
-			if (cpumask_subset(cpus, p->cpus_ptr)) {
+		if (cpus && !cpumask_equal(cpus, cpus_allowed)) {
+			if (cpumask_subset(cpus, cpus_allowed)) {
 				llc_cpus = cpus;
 			} else {
 				llc_cpus = this_cpu_cpumask_var_ptr(local_llc_idle_cpumask);
-				if (!cpumask_and(llc_cpus, cpus, p->cpus_ptr))
+				if (!cpumask_and(llc_cpus, cpus, cpus_allowed))
 					llc_cpus = NULL;
 			}
 		}
@@ -507,7 +508,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64
 		    cpu_rq(cpu)->scx.local_dsq.nr == 0 &&
 		    (!(flags & SCX_PICK_IDLE_IN_NODE) || (waker_node == node)) &&
 		    !cpumask_empty(idle_cpumask(waker_node)->cpu)) {
-			if (cpumask_test_cpu(cpu, p->cpus_ptr))
+			if (cpumask_test_cpu(cpu, cpus_allowed))
 				goto out_unlock;
 		}
 	}
@@ -552,7 +553,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64
 		 * begin in prev_cpu's node and proceed to other nodes in
 		 * order of increasing distance.
 		 */
-		cpu = scx_pick_idle_cpu(p->cpus_ptr, node, flags | SCX_PICK_IDLE_CORE);
+		cpu = scx_pick_idle_cpu(cpus_allowed, node, flags | SCX_PICK_IDLE_CORE);
 		if (cpu >= 0)
 			goto out_unlock;
 
@@ -600,7 +601,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64
 	 * in prev_cpu's node and proceed to other nodes in order of
 	 * increasing distance.
 	 */
-	cpu = scx_pick_idle_cpu(p->cpus_ptr, node, flags);
+	cpu = scx_pick_idle_cpu(cpus_allowed, node, flags);
 	if (cpu >= 0)
 		goto out_unlock;
 
@@ -856,7 +857,7 @@ __bpf_kfunc s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 		goto prev_cpu;
 
 #ifdef CONFIG_SMP
-	cpu = scx_select_cpu_dfl(p, prev_cpu, wake_flags, 0);
+	cpu = scx_select_cpu_dfl(p, prev_cpu, wake_flags, p->cpus_ptr, 0);
 	if (cpu >= 0) {
 		*is_idle = true;
 		return cpu;
diff --git a/kernel/sched/ext_idle.h b/kernel/sched/ext_idle.h
index 511cc2221f7a8..37be78a7502b3 100644
--- a/kernel/sched/ext_idle.h
+++ b/kernel/sched/ext_idle.h
@@ -27,7 +27,8 @@ static inline s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, int node
 }
 #endif /* CONFIG_SMP */
 
-s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64 flags);
+s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
+		       const struct cpumask *cpus_allowed, u64 flags);
 void scx_idle_enable(struct sched_ext_ops *ops);
 void scx_idle_disable(void);
 int scx_idle_init(void);
-- 
2.48.1


