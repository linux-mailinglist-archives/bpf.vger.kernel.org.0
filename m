Return-Path: <bpf+bounces-54226-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD77A65BB1
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 18:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 318A27A907F
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 17:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C761CEAA3;
	Mon, 17 Mar 2025 17:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="n8cHgCeo"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8686D1B425C;
	Mon, 17 Mar 2025 17:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742234284; cv=fail; b=WJ0hi1A7lVxHFnUFCOdtCGNHb1hBBQe+d5khNALGj2nh2lRo2JQG9euRLTw/tQxtN9L2o4RY+vjJruKCw1Vrb2SPglTFfxh20Dy4l6Nn6G9IR4Hcx0AYmJJTLGAprJw5eKf11LYbjW7hWDStrJbN3r/5vfXT86YQgV2dQb0zvh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742234284; c=relaxed/simple;
	bh=C18IDofFdxJlzTJGnqI1t1Kou0Dou+RB4yI5AnN5j0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lKcDpyLsFL001esaf7RtDB4SAsujGSfo7KwYlKgf/1sYPqVLNQKAh9aZ6KAbC+LdbXGhpb/oqyx4JnUq4ikjCTsgjeGOP6rTcYUww3nlNYs/Mj/5+uKw4nL2AyABBa/dVAXlm+glpB5ISbcHMTD4ZnNmd93NNyYAx91pA065YvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=n8cHgCeo; arc=fail smtp.client-ip=40.107.92.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gNDA74g92/QG7Vwyg2Dq0MU4oTbKnhF9JylJ0qw0Mr51Jbsb96bmbvh4TljE8H6qU/kgjgq+itx8kiRo9KlfIqV+Evwf9h6Af2cFOq0aCOcsTDvG51p1PMNXmGGATglk3yJgOP5aWSOEpq7ZRL1j9msfM1HvLmIhJMDRw3hPvvq8yQMOTZK6gDUgMwHFHgWZYQ5XGo4xPcGnri/CYhs08AwWNthix3znZ5oD5As3V1GmrJU/vikcDwCUbqCAvKEE+hYqgfbRJBZLGugJ/+KvWZj6OJ+l6/zsLVI8OAQdZHzLXajcXMUoxMdjhl2eQplp3j/ZCBmsI8UTWANWkrS+QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bMBkb7XPindwCOEeRAoNCIAGYbWO7etKW1KjxfGW1w4=;
 b=XO72etA2noSSdXpsAsMUfMgjGNqiqb8uvpPDktMOBG2uHkutgu8IGmqiy3H7dQMz2sQDRRkKkFDOdZXKb3cfVVqYt/nXHcAqn36jeTPxnSGcePOLBrHDD3O5wWfZswk9tKAeZYSOqP+qVTA+XMWu1FQwP0uDxT+cGsjbwJc30oob3d3sY1D/ige4OnehgWsCItHQMUyQs6BGnXmKZRT9VO/3WEu1NY+qTiIj8E/edZW3kWzx/NCsGSYoVR/yoJDfyo3XxOIYdJtaOXPIjCsf+p5jrN+U79che+6zl6we7s3NFlL42hN9DwK2yDzqxXvX+byU+Ip9tNjyDLH3YxL3og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bMBkb7XPindwCOEeRAoNCIAGYbWO7etKW1KjxfGW1w4=;
 b=n8cHgCeogOyljjy14fXdeIf5HrxoZnhuwCZR2rnLOs0BhgIt5ZWZ5khHPgOWlrpyOs4SAIL9ywRlJbPA9FMxJ8VhfszD6URe7Sp1aXvrJfRPy1z3zkpucO/37JSBEA31L9F7FZI3RWYDN3yQbXL/3N14v5Vjs0Y7J3q2J4aZmIMHX1le4YgKwPtGqrcTWqXwgIAQx8XUuNNo0cO2Q4X7xme/U+eQIrSwwsYqx7bwzHI9mOiQMHbayl6oUnESwnIpy9Tp2A0jplKZuwqQZZZovw8kMP6vnl/qGtYfbLSdKULFiRA3YyQ5YVWhwFF1gOkiQ5o9HA5Ay/zqo8rU0bvYHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by MW4PR12MB6826.namprd12.prod.outlook.com (2603:10b6:303:20c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Mon, 17 Mar
 2025 17:57:58 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 17:57:58 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] sched_ext: idle: Explicitly pass allowed cpumask to scx_select_cpu_dfl()
Date: Mon, 17 Mar 2025 18:53:25 +0100
Message-ID: <20250317175717.163267-3-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250317175717.163267-1-arighi@nvidia.com>
References: <20250317175717.163267-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0151.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::18) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|MW4PR12MB6826:EE_
X-MS-Office365-Filtering-Correlation-Id: cefc6b3b-aa5e-45b9-831e-08dd657d4081
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2sjsS6Qvx7enySmZDiPk3vV+rKdVUhIztG6HWE+leYdD0RQzfQpCN17VbsH7?=
 =?us-ascii?Q?3RI0KVzqRBBVRNsUh2lA+Qh61BdRMsgpnwuqNee1vSzLqhJyIHZcVKSq7Y6m?=
 =?us-ascii?Q?xltDvNxynL10G7r67O+ugPUJdJviGOOUL7SsNFuynwng4nEFeJrA6lG1C0Ol?=
 =?us-ascii?Q?FMekSMPnvJcPVVufxlq2W2NHu7IGJtMLPu6hBehksqBxassdFjy7zCv62fUZ?=
 =?us-ascii?Q?Cs4kkKRT98EUl2BQDQmyZ26xc0v0afXjBkF8ejyRUDP3n/zL9BzeeB89ojyp?=
 =?us-ascii?Q?Qzlk9BalDJBiJQCOFIofoWcepLZRyYibX9nrGaFZTmxpPHL7wn2ERdGP6amI?=
 =?us-ascii?Q?9kB1Gtq1qyHaAZXeTqn3o7x/76lnYaF7g8B2yp6Jx8X06oH3GMDhQi0WDmZj?=
 =?us-ascii?Q?rjqJC0rrwvgRfPJ3TAsWmvTjO5yz1ma59c2C4qPkFMhyYwEwR1ff3aZamKx9?=
 =?us-ascii?Q?Aonz/sWNQ+sD4ntLz+T5atRcXELQNoQ4FhbNgRLgqqRQdfxeG8peUY09lgUF?=
 =?us-ascii?Q?kW7RjGlZL7UwUftmQXCtQcKC0j1oEJj5QHq9fzUein80vPv2bIGpGPejSEQX?=
 =?us-ascii?Q?xbvbW6pKo57havRUK0dRPsBCK8zqrV7MfOybbGso2OCJzEZXM6KqmKXsAi+s?=
 =?us-ascii?Q?r8/TM0Hp5V+6+6YoGOMLBZRSqXeqHr+Qn+heGopq59ZoaULlmFBV2YRAjvwK?=
 =?us-ascii?Q?E2lbZ3IdaqOkN/6xuObsSNR8SpMlGFWX50VfUMcCQo/v39BnMuIXXRLgtq8Y?=
 =?us-ascii?Q?tq0xELbwxUvJr8xlsyyrCX1JZOUujcZcdl5svrhMFuNdxaOPkViTqw04WHY5?=
 =?us-ascii?Q?if7j5ZBhfd0NrStY+1cG1OdPEOpRkYNxquV1KyDAhO7qHsTL/qTZCIuGaQ7Z?=
 =?us-ascii?Q?gvjXZzrKqXtTErBKzI4/sDdonY/v9C+fEJqIP3YwOr0BivNr4hEojFi7aggg?=
 =?us-ascii?Q?r0wjNGgcqTSsWvKRtAMkSnnn1gJGAQDF60OlmbQCNaI76yRxSX+m1YBXR428?=
 =?us-ascii?Q?IUv9CFcl8miteC5ZVgCHnwP13xhZkPCLLijnEq+kUuGtGAoilhF4f35YLlqz?=
 =?us-ascii?Q?IMJZ8y4JP15/jU+43TcvBIASE/Xouu+o3K6DPKZ1IuXE8rX4gBuYlRQUzvQK?=
 =?us-ascii?Q?/wWnJMwuW0l/yZLiFIabDRUIdy1Z81itDo6UrWTFIjwlyKZBQmBDIYcL/kr8?=
 =?us-ascii?Q?W/7+espuCOt+6JelEWkcd1tG0OigZAPGpK+nTiH5C42eY12eSyHeifNoPGz9?=
 =?us-ascii?Q?cuVC4bkEZrq8phXsKbBeHOMsLVpuGPKOEXIaAeJDXwSMlsqof1ncsuM9rbdY?=
 =?us-ascii?Q?aeZq7cbtkC94NJIihvNlTj5BUvfuRQfUjSwYkhcQeVAha+3Tbl60fsHFbyRK?=
 =?us-ascii?Q?swrty2SzeHt/frxp3LqOx0wZETNp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y66AcUIA1zVDL9OMAy/xgbKSytkQ3qq85ypq02mkLQjskOa0A9pNMBvYxbB4?=
 =?us-ascii?Q?5B5K5jFaljzBR8ExJtW09LOk1yJaeX1UL/ptkmBLfgrLDiTWdCTJqc6R8Yw/?=
 =?us-ascii?Q?gzLq0awygUHsdScQdt2NBHoyl6GodzL1X7w5mlp6ojnkDD15QWFy0JQQ5Vx2?=
 =?us-ascii?Q?72sXvaemamfJ42sqqwk4WUKSMkhcd+qf3qjxopxxMubCME34pux/oE4XSC0J?=
 =?us-ascii?Q?PTn2BfuhercaviEU3Z9c/FwEN3p7iM+w3zKqPTNqFL4ssKv3VL8EzdJj/9J8?=
 =?us-ascii?Q?EVozbrjhwCUVUy2PgjW/XxrColoPGXFlUovxxJX43nt4avsnQlVC6sfOqnug?=
 =?us-ascii?Q?0RhiqbyWo1jCjf1ahXOb5SUpa/vgSf3SbF/tZp51orHfSUl8GQhTL7Ro5oHB?=
 =?us-ascii?Q?V6oy205AXKJOKu5O/DZaHqCNLEjj4vDTKPOQc0R0ttz/bilfCvFbkRhlhmvv?=
 =?us-ascii?Q?HTZdgJIlOM8Kx6ZpjMpLsV8r4iozT3FeEJDfo43M+9aOcBsAwPEtmfJPqzOm?=
 =?us-ascii?Q?nQOl35dYNWdZpkDJtrz/H07cgCKU3gwiWv13aDVBYxv5SRTMQHtcYc70KW8h?=
 =?us-ascii?Q?UCgWeDllbiYHIQ6+wKSbj98XisIYR4iDP3mIxdZ8vRdzvN4kFsEx7BjyTp10?=
 =?us-ascii?Q?Wgaca+P3ptAM1kbmzrz4Cj3IpCnBoBNre32CS/2u75ItQHPrq3mQt7GiRnT6?=
 =?us-ascii?Q?xlVR/6ER/Bs9KAJ0qgb/BBT+q2pr34pSed28k4ygsvVxuavp+VwUwLm+4FE1?=
 =?us-ascii?Q?bl94De8xA85UjR6IaikSgiqUjEbPEvM5OpuHJhyKjXi285qC48yjL81PujV7?=
 =?us-ascii?Q?qWLFn4cU1pJ8y+T4kpSMlRWBqB7dmz+HI+SogTJHEgwzVvfWg84NQir44PZD?=
 =?us-ascii?Q?XDF3P5edksAwmed3LDndRls6uW/OvPzBaYMNhfBhCJd27VZe31H6ZeytlCem?=
 =?us-ascii?Q?caJNCadgI/nq7gOR3tHHt7RTCr2qjV0XxhaDBSf9K4aQLVgQ7RMn4doS8K0U?=
 =?us-ascii?Q?qVsMgHn3rO82DRIn+PdUCx0jVSrLhxjO06z8gH5hucxFGjjPovGOgaf0phyF?=
 =?us-ascii?Q?ISgLBqyb5wTJLC48SWN3oG2JXiyiGcLEiTettq2rvWnt8OSy1Lwlnzj4gvSf?=
 =?us-ascii?Q?UvdbtTVhg6AnJf75hRJPwS/DaWHem1zGo/+E1uDvpMlaPUejs4MS8ahEtE9e?=
 =?us-ascii?Q?qjqsq54YNx34QV6mPfw8v25QOJGPzd+DcvE67QYVEPi7IvoZ83MDdQv0zsWI?=
 =?us-ascii?Q?DSfo8iA/KvGEHMxiQlqKLiVgPm0d98n+DRY3NcHRI0GD4ihj+8NvexskYBYk?=
 =?us-ascii?Q?zkfppU6BKyQjTqtzqJwGkzbwkSlQ8K7RTdvZdICD4KPe8jJefQ4BTFir9oJ9?=
 =?us-ascii?Q?gDyh0VpD/ZFIrNujZLllLfxKx0N25ItUTDY+Yzn15D0g+n9o1QGlmcGHgw5C?=
 =?us-ascii?Q?cl+IJHGQS/F1zg0Wnl3foxf5z1g/WasJvV1ys2P9XnuZaxCyu6VCZllAVMyo?=
 =?us-ascii?Q?EAMPS+Fy49k8/YH2Bhz3Oa3OYrkD25NWDdsc5SuKMq27LjAdsnplL9B9QrgK?=
 =?us-ascii?Q?m/YunCRnYm3mS3brUsDid0aTwwfYZ4kdLD0YT8Uo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cefc6b3b-aa5e-45b9-831e-08dd657d4081
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 17:57:58.4891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hhipP7iaa5lngHFHH+WF0FtrB3MbiVWXjOikLQZCTAqhxlsil2CA6w87uuaOa+BnTjI0UFd0H1yy4Mx/SftUzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6826

Modify scx_select_cpu_dfl() to take the allowed cpumask as an explicit
argument, instead of implicitly using @p->cpus_ptr.

This prepares for future changes where arbitrary cpumasks may be passed
to the built-in idle CPU selection policy.

This is a pure refactoring with no functional changes.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c      |  2 +-
 kernel/sched/ext_idle.c | 45 ++++++++++++++++++++++++++---------------
 kernel/sched/ext_idle.h |  3 ++-
 3 files changed, 32 insertions(+), 18 deletions(-)

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
index e1e020c27c07c..a90d85bce1ccb 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -397,11 +397,19 @@ void scx_idle_update_selcpu_topology(struct sched_ext_ops *ops)
 		static_branch_disable_cpuslocked(&scx_selcpu_topo_numa);
 }
 
+static inline bool task_allowed_all_cpus(const struct task_struct *p)
+{
+	return p->nr_cpus_allowed >= num_possible_cpus();
+}
+
 /*
- * Return the subset of @cpus that task @p can use or NULL if none of the
- * CPUs in the @cpus cpumask can be used.
+ * Return the subset of @cpus that task @p can use, according to
+ * @cpus_allowed, or NULL if none of the CPUs in the @cpus cpumask can be
+ * used.
  */
-static const struct cpumask *task_cpumask(const struct task_struct *p, const struct cpumask *cpus,
+static const struct cpumask *task_cpumask(const struct task_struct *p,
+					  const struct cpumask *cpus_allowed,
+					  const struct cpumask *cpus,
 					  struct cpumask *local_cpus)
 {
 	/*
@@ -410,12 +418,10 @@ static const struct cpumask *task_cpumask(const struct task_struct *p, const str
 	 * intersection of the architecture's cpumask and the task's
 	 * allowed cpumask.
 	 */
-	if (!cpus || p->nr_cpus_allowed >= num_possible_cpus() ||
-	    cpumask_subset(cpus, p->cpus_ptr))
+	if (!cpus || task_allowed_all_cpus(p) || cpumask_subset(cpus, cpus_allowed))
 		return cpus;
 
-	if (!cpumask_equal(cpus, p->cpus_ptr) &&
-	    cpumask_and(local_cpus, cpus, p->cpus_ptr))
+	if (cpumask_and(local_cpus, cpus, cpus_allowed))
 		return local_cpus;
 
 	return NULL;
@@ -454,7 +460,8 @@ static const struct cpumask *task_cpumask(const struct task_struct *p, const str
  * NOTE: tasks that can only run on 1 CPU are excluded by this logic, because
  * we never call ops.select_cpu() for them, see select_task_rq().
  */
-s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64 flags)
+s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
+		       const struct cpumask *cpus_allowed, u64 flags)
 {
 	const struct cpumask *llc_cpus = NULL, *numa_cpus = NULL;
 	int node = scx_cpu_node_if_enabled(prev_cpu);
@@ -469,13 +476,19 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64
 	 * Determine the subset of CPUs that the task can use in its
 	 * current LLC and node.
 	 */
-	if (static_branch_maybe(CONFIG_NUMA, &scx_selcpu_topo_numa))
-		numa_cpus = task_cpumask(p, numa_span(prev_cpu),
+	if (static_branch_maybe(CONFIG_NUMA, &scx_selcpu_topo_numa)) {
+		numa_cpus = task_cpumask(p, cpus_allowed, numa_span(prev_cpu),
 					 this_cpu_cpumask_var_ptr(local_numa_idle_cpumask));
+		if (cpumask_equal(numa_cpus, cpus_allowed))
+			numa_cpus = NULL;
+	}
 
-	if (static_branch_maybe(CONFIG_SCHED_MC, &scx_selcpu_topo_llc))
-		llc_cpus = task_cpumask(p, llc_span(prev_cpu),
+	if (static_branch_maybe(CONFIG_SCHED_MC, &scx_selcpu_topo_llc)) {
+		llc_cpus = task_cpumask(p, cpus_allowed, llc_span(prev_cpu),
 					this_cpu_cpumask_var_ptr(local_llc_idle_cpumask));
+		if (cpumask_equal(llc_cpus, cpus_allowed))
+			llc_cpus = NULL;
+	}
 
 	/*
 	 * If WAKE_SYNC, try to migrate the wakee to the waker's CPU.
@@ -512,7 +525,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64
 		    cpu_rq(cpu)->scx.local_dsq.nr == 0 &&
 		    (!(flags & SCX_PICK_IDLE_IN_NODE) || (waker_node == node)) &&
 		    !cpumask_empty(idle_cpumask(waker_node)->cpu)) {
-			if (cpumask_test_cpu(cpu, p->cpus_ptr))
+			if (cpumask_test_cpu(cpu, cpus_allowed))
 				goto out_unlock;
 		}
 	}
@@ -557,7 +570,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64
 		 * begin in prev_cpu's node and proceed to other nodes in
 		 * order of increasing distance.
 		 */
-		cpu = scx_pick_idle_cpu(p->cpus_ptr, node, flags | SCX_PICK_IDLE_CORE);
+		cpu = scx_pick_idle_cpu(cpus_allowed, node, flags | SCX_PICK_IDLE_CORE);
 		if (cpu >= 0)
 			goto out_unlock;
 
@@ -605,7 +618,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64
 	 * in prev_cpu's node and proceed to other nodes in order of
 	 * increasing distance.
 	 */
-	cpu = scx_pick_idle_cpu(p->cpus_ptr, node, flags);
+	cpu = scx_pick_idle_cpu(cpus_allowed, node, flags);
 	if (cpu >= 0)
 		goto out_unlock;
 
@@ -861,7 +874,7 @@ __bpf_kfunc s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
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


