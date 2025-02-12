Return-Path: <bpf+bounces-51278-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D46FA32C79
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 17:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAE5A188BD59
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 16:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54AF25D520;
	Wed, 12 Feb 2025 16:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lC4R0U7u"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B02B25B69B;
	Wed, 12 Feb 2025 16:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739379049; cv=fail; b=du3ihEXcMDWyG750ldJH18kBUBfl6aoZcabPdQaHtkVJ0dXvwzBi855m+7tCKyorUuop2Qt29zXsCIH10lAkKYulT77PDvAh4YzcQierVgYYUEbNmYq1Nsox+yOmuqyxIRlRX1ya8XhOuH/B3J66zOmMKK/EVkWMiIzLE0YSyQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739379049; c=relaxed/simple;
	bh=aZXwtw+BTCZt32L1agM6X+ru6LH/c7DtBB3wefcODVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RI97NDnaXAbjAs+vwum9q5U63AgtpqIKgjzNltnabiYX+FyA3oBaktcQhB3J0YkKmXy6jj3iQ++UUIqdbrOISgwHm2VN33aN5A98ZdjVKtBHxNrrcwyaMQc/s/DfWHCKCUHMVdbBDyqK0A4ts3htvR6GetvivcT2ga5VQCG6HOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lC4R0U7u; arc=fail smtp.client-ip=40.107.244.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mwTL84L4yt1tobrZmOY254/GqazNC9beHcwOGnxIlcQJWXtG0/ikl1iYHLMo5iZr3ElGDpalZE+AKyTRpbFg2ZnBs1rpOKlKjbatOOfigl76xlEc1mkEJJfMrfIaV877yqyeCxZASlMd+nQIrihMxHEzXPfF9INuarU5/fZoKcCuiKZKS9XwbDiGs3RVmSML5bpvyRrve3+77F/CwluLx/6qC9pMWJdmpt0Xszx3Fj0K9NMiSgnRRIB7UA3vlJ4d4UPfVStaknrvemqh8rj/YOv2e5XmRZ/KoW2NYadd7vCVh4HL9pcUnqWPB6b5JyyXajOAhMoah1SvMGqf0f3zoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5VyHFtsEIGI4fhHcCLt2Vcqdj8+Q3MfLsDsVAKxOlEs=;
 b=j9O4ffOHTmCDPCwQ+GlHOv07FFJEZVkCmgh8iu5Btrvxd1aQwkRmr5mB37X9Ofb8ZdPqT424FYCtlFw0IDX5TMnxs3M+0Wq9ryuPy8XByzrgSMNZwGOA69ERlRmQbNm9LfjGkBrEnpuT3MDUI89dP7vkLXV29R0fcvIPRz6DiqCNq7JSH7AsaEKc8ujO7tmdawB0ZWwLrbOh+XDrfgXGs+Dj9zcF7AT7i0mbH5vcByRxD/gZLsx44s1EoANSlTF1GPxUQNEkAdcmttQe6UjVf1kutHwp4bx5WkB3Qp58u38IZ3Gv6+FeLZrryItIqjbUuvPYl2hIrIVsw3K1fAQCEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5VyHFtsEIGI4fhHcCLt2Vcqdj8+Q3MfLsDsVAKxOlEs=;
 b=lC4R0U7u+XugoCfwsME9stJn4Zh5B0bLVwYARFqpFr6AFzzxwE798L70iRxnLQby+fEIkGz/mhssg5WgeZ2Ch5RJFKD7fcJVPPYYu2q7cXOvjGCFLMU8goSvgQ54SFzNM4Xq6R5z1BfUtXCo1XxqF04QHkIOsahHueJjXq+AJi+er3B5JTCxv1dHJKr2hvqD9NcwY6ueCkBo5JzoWBeq63xWi2gQY6j1hZBhya7nhYrudR8d89vu3+7x3ZvHZIFlY14mof//9rTX7zS99qI8Dm+oR2EQdybmXYr9R7V1lLvap+UV+lwb4+/63zI62Mba4+JEyRN4ujMHnzN5XbEgfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by SN7PR12MB7177.namprd12.prod.outlook.com (2603:10b6:806:2a5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Wed, 12 Feb
 2025 16:50:44 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8445.013; Wed, 12 Feb 2025
 16:50:44 +0000
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
Subject: [PATCH 4/7] sched_ext: idle: Make idle static keys private
Date: Wed, 12 Feb 2025 17:48:11 +0100
Message-ID: <20250212165006.490130-5-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250212165006.490130-1-arighi@nvidia.com>
References: <20250212165006.490130-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0161.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::20) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|SN7PR12MB7177:EE_
X-MS-Office365-Filtering-Correlation-Id: 5527371e-7e32-4a83-b384-08dd4b856458
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uws8ufg94aU5PrEJDw4tnwAnPgEaVKP8GTWGyJud81751p0o3guOsaT4xkEs?=
 =?us-ascii?Q?QJBdmMuo9HVfcuNDNYr/z6gcd37vjS+ZYqD+fPDXjdQRvC8wXYFYTbuAJBjn?=
 =?us-ascii?Q?EpRLz1jNHjbC8KtAC/YmliIfCuLMfGxxW6rTNxsMh12GizBWFgsKQ+N4EGf5?=
 =?us-ascii?Q?aj6VP0edLrL4hYtj3Gjql8YkYRYcdDa/4iyIF7IOsfQNolIhAz0bdPtXDLlH?=
 =?us-ascii?Q?Pd3P6xFFbSGeJMKz5aU/Ae+8LFMhtAFEi3Sn7FEtyLCJyx2kVLr3r2O4iRmO?=
 =?us-ascii?Q?W1y3QVBUM2G6pUVK6C7w41kIx6n5gXLyk3Cdj0GZLKxacA/5hSRswzT+pVIh?=
 =?us-ascii?Q?tMEBhwrulgKeIYtM9ROBObhuS3FEtzbiU0XhBIN4f34tfZUREtIFbkJ8B2cY?=
 =?us-ascii?Q?eRgPC1IGMD/lLX9SXvG1fvbBOmlujxHbO7D7BxmE1MHYYtIfsdeMo8jJOExU?=
 =?us-ascii?Q?lnCCj/V9khjHu6yVqVMup5WoYN6RDBcFAkL+bM71FLUx+wDJR+axajoR1rZc?=
 =?us-ascii?Q?m2DyTut9PoQXTsGdtQGegUBjZlE3aZXNo9ktGOznrSFL706zbQe3SFqTOvKV?=
 =?us-ascii?Q?2ADpUmeG0/CF+ZPxnYLkJeC7rfsR0kAwwGaJYZgVpumoPWa2hDBPoVOEjGHQ?=
 =?us-ascii?Q?UWFYdwXdYncctYB3ZHVpDRLLAYtZmcvopyL6LYoozxiWF7zDLtwBtMSo/z00?=
 =?us-ascii?Q?7ZRxNXv+osdaH/hxSVSExijn0W7UeCPSTIM6imEsMD2xxd4ErrIC0bxIQe7s?=
 =?us-ascii?Q?Ru+DFQDl6GZ5uG5ASaeM7iqEM/otKxNWns5j/PD1VZ8kZN3WYiEaIdqtkJRe?=
 =?us-ascii?Q?7iQ3duNz3ZGCHR7jDbiXC5jFRSMx9VXj3laddrsGZdJGX+XJolydksB4WMMW?=
 =?us-ascii?Q?iQrS1hEBKxd8J/aM/WBFFpaQWvadnY0C5fJcEirxVGu8fNvSCQA+sLlJSJIZ?=
 =?us-ascii?Q?NBQShi+OZG54/0Vcet4WReC560hDusvXORvz20vRfYazx/ikWp9daIlOT/bL?=
 =?us-ascii?Q?xf5UFtuPCFwZkSVN8+NoYgWyQh0e4fb4HJT1jn1niyXrwaxL760bZaZI5mF+?=
 =?us-ascii?Q?nLG5KpSFQXP10uEl1ZRlHPmjTFbMnBqaSRI3p58dbeJyH+w3lrbpbGPqnERI?=
 =?us-ascii?Q?52RGcaEWRqTTSb+hqzgNv/YzFlkcs+wFwV+HEA6CnX7dK8wVrWmPm6Lr1Row?=
 =?us-ascii?Q?Cj1b7oAzu7bQov5IiRHdPGOmJ7wiNBcj8xLX7iTbhTTAz0Ohe+2otulxBt6Y?=
 =?us-ascii?Q?4wMMHPliZnjWtKiP7ovR428Gif1YDdGby63atSU62ndKjyT08MVoHOT9KuaZ?=
 =?us-ascii?Q?4d6vXq7AXKovKQdVTVLFCFf2RWLb7EWy8eiEAg8B7nlDm3E5apnsmnTV6w8N?=
 =?us-ascii?Q?CTPAiWR/u7iHQFSmQQ4wWG0gwHca?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Tpq8NWeyWyniS1IzFrF5FByvxn30XofBH17mqlhAXSU+NgeNxeFlIL/WBzv+?=
 =?us-ascii?Q?Nl2IA1YlBDk+3Y/HpKVCEMrGm5d+Ok77NI3zuFmGh2fqRuG0nmEBIyx9yrJm?=
 =?us-ascii?Q?5LsmdmSbpurC49FIZ/BYoJTtBaq/YFBJyLjxWnyJbO4h9/DwVnKQ/bxwbLHK?=
 =?us-ascii?Q?bTs+KuLy6vpqVryxDBSQFL/GJpdRrP66UMC9muhXMguzCejs29NRJwyznC1F?=
 =?us-ascii?Q?XqkZcx6Gfoveq/6Rzj4b4jWC03pTd5XDzUE0qyMJ372i3YYuwvI6WzXS1hCt?=
 =?us-ascii?Q?0oI+Sz3mpYkZZ5moXMcxp7VmPAtOzurJGLlTaw93i5e2tTvFXpGsc6Lpi7BN?=
 =?us-ascii?Q?SllUzWwwm9AOBm+tu8nEMzMC2aqFxy05VSGfCHGInEJ2id6LLhzyTw3ruszV?=
 =?us-ascii?Q?WHtHlI+PrN4br78sbKJqNzJQRFnnJEuHCNCmDH/y/Do91UvV2eEzh5VceYaV?=
 =?us-ascii?Q?WgRPOFmu0+ucTGs8MdDmQltAyZZ9pu+hjMUYkAxrZSv3XqLKjQv2/yR3eGtr?=
 =?us-ascii?Q?0pA1rX2kMWrvZ1TaN4Q8BgY4XgHThGxZyG9az6drnuZdlY1beQKvDW/eNmgr?=
 =?us-ascii?Q?s19FakS+gVMwaFhh294AqN3gNOmuAS933HxPUCr+gMyUMyAOpZJhiE35BuH/?=
 =?us-ascii?Q?eQLFM4xkPVrQdVntO4K7vMqH79NFEXGTISdM8l6V5n0slHvHJox36XSq3PzM?=
 =?us-ascii?Q?mQB7ve3z+OpMd6WquVxibAsXXewI97da0YiR5zNlaoPVinMu99PW+VZdZ3Uc?=
 =?us-ascii?Q?azboU1Gvhq1ekNwLIRY7jlOJhcv2BRkRrnmHLyPFLihG25YwI0XNjVGUSCHy?=
 =?us-ascii?Q?sJHbLkYolo0tpq0qz7narLgXf+b+9OqStA5YLwXgTfcMCIj5Jjwku1qrHrDG?=
 =?us-ascii?Q?92PIfxigQsrL9Hv0QnzEo/xxcKSY+kB0dGB9T4CikRRvGY31LXWEOwocSSaD?=
 =?us-ascii?Q?w1xkkpZMTL1AYxTbzAQlAJnW7HNKOXr2akbynfedEfSnFyWiDuCD4vKqp2rc?=
 =?us-ascii?Q?+5OMwWunT5eGkX31k0uwOYkiozyjTjb+c6mUtCPRxn1orGK+BMK3TMRBZH1Q?=
 =?us-ascii?Q?DsTl1e+tkYCn3Zg0jEPFvDVdiElnJTaJ2bgm5AZbt3rRXjSiRQ9zBEqMY+14?=
 =?us-ascii?Q?0cKjugn2mX1lNrspLQXI4jsDyeVWT6yMfHL1rZvMl8v6OWLZfohU4VMPS6qS?=
 =?us-ascii?Q?tc1mKxcgvkC0wZteGcKJdPyU9zgXaZ3IuTjbFtlKJxHSi6/Ut8er8d8U+eTc?=
 =?us-ascii?Q?Wp47MgCMsw1A8flqTd3O2lanJ9a8PQX1CInZTZ2gZ7g6W5y71NNc/eTKh8ir?=
 =?us-ascii?Q?I/HmPLxY0W/87OX71aQaiDiFPbpSCMw03IIna3RgkXeZSLOjCsHzymdokmgj?=
 =?us-ascii?Q?jfhTyiE6LBKPCAqL78kE1zZ+JNNxxVpgkUkYOqy0QwIfg3MLwfhvwx1TIhyN?=
 =?us-ascii?Q?/qNEDVpkn1DZksyNY5hSMkcSnjjosdCEoiQHgt7eETG78FoO3AUzf5PGOifg?=
 =?us-ascii?Q?w0SRmH8X8OvY4/R946Kjh04AeQ53l8bJh4CHYceUWDJzFJzDWy43cfpKApAw?=
 =?us-ascii?Q?89RYmB/DwVBsFzqGbxfNOkdY6Nb/Gtoz/SKjCrV6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5527371e-7e32-4a83-b384-08dd4b856458
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 16:50:44.4033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1zaG1xO+pXy23TCc6Sccz5iV8fIe/z8pYgNLlH8Pj998PI3PerqLPjvWxA8PswdqdnS3Hz5YDCVNdAaTSRYaeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7177

Make all the static keys used by the idle CPU selection policy private
to ext_idle.c. This avoids unnecessary exposure in headers and improves
code encapsulation.

Cc: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c      |  9 ++-------
 kernel/sched/ext_idle.c | 39 ++++++++++++++++++++++++++-------------
 kernel/sched/ext_idle.h | 12 ++++--------
 3 files changed, 32 insertions(+), 28 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 98d5f2f68f38c..c47e7e2024a94 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4721,7 +4721,7 @@ static void scx_ops_disable_workfn(struct kthread_work *work)
 	static_branch_disable(&scx_ops_enq_exiting);
 	static_branch_disable(&scx_ops_enq_migration_disabled);
 	static_branch_disable(&scx_ops_cpu_preempt);
-	static_branch_disable(&scx_builtin_idle_enabled);
+	scx_idle_disable();
 	synchronize_rcu();
 
 	if (ei->kind >= SCX_EXIT_ERROR) {
@@ -5358,12 +5358,7 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	if (scx_ops.cpu_acquire || scx_ops.cpu_release)
 		static_branch_enable(&scx_ops_cpu_preempt);
 
-	if (!ops->update_idle || (ops->flags & SCX_OPS_KEEP_BUILTIN_IDLE)) {
-		scx_idle_reset_masks();
-		static_branch_enable(&scx_builtin_idle_enabled);
-	} else {
-		static_branch_disable(&scx_builtin_idle_enabled);
-	}
+	scx_idle_enable(ops);
 
 	/*
 	 * Lock out forks, cgroup on/offlining and moves before opening the
diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index cb981956005b4..ed1804506585b 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -12,7 +12,7 @@
 #include "ext_idle.h"
 
 /* Enable/disable built-in idle CPU selection policy */
-DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_enabled);
+static DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_enabled);
 
 #ifdef CONFIG_SMP
 #ifdef CONFIG_CPUMASK_OFFSTACK
@@ -22,10 +22,10 @@ DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_enabled);
 #endif
 
 /* Enable/disable LLC aware optimizations */
-DEFINE_STATIC_KEY_FALSE(scx_selcpu_topo_llc);
+static DEFINE_STATIC_KEY_FALSE(scx_selcpu_topo_llc);
 
 /* Enable/disable NUMA aware optimizations */
-DEFINE_STATIC_KEY_FALSE(scx_selcpu_topo_numa);
+static DEFINE_STATIC_KEY_FALSE(scx_selcpu_topo_numa);
 
 static struct {
 	cpumask_var_t cpu;
@@ -441,16 +441,6 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool
 	return cpu;
 }
 
-void scx_idle_reset_masks(void)
-{
-	/*
-	 * Consider all online cpus idle. Should converge to the actual state
-	 * quickly.
-	 */
-	cpumask_copy(idle_masks.cpu, cpu_online_mask);
-	cpumask_copy(idle_masks.smt, cpu_online_mask);
-}
-
 void scx_idle_init_masks(void)
 {
 	BUG_ON(!alloc_cpumask_var(&idle_masks.cpu, GFP_KERNEL));
@@ -532,6 +522,29 @@ void __scx_update_idle(struct rq *rq, bool idle, bool do_notify)
 }
 #endif	/* CONFIG_SMP */
 
+void scx_idle_enable(struct sched_ext_ops *ops)
+{
+	if (ops->update_idle && !(ops->flags & SCX_OPS_KEEP_BUILTIN_IDLE)) {
+		static_branch_disable(&scx_builtin_idle_enabled);
+		return;
+	}
+	static_branch_enable(&scx_builtin_idle_enabled);
+
+#ifdef CONFIG_SMP
+	/*
+	 * Consider all online cpus idle. Should converge to the actual state
+	 * quickly.
+	 */
+	cpumask_copy(idle_masks.cpu, cpu_online_mask);
+	cpumask_copy(idle_masks.smt, cpu_online_mask);
+#endif
+}
+
+void scx_idle_disable(void)
+{
+	static_branch_disable(&scx_builtin_idle_enabled);
+}
+
 /********************************************************************************
  * Helpers that can be called from the BPF scheduler.
  */
diff --git a/kernel/sched/ext_idle.h b/kernel/sched/ext_idle.h
index 7a13a74815ba7..bbac0fd9a5ddd 100644
--- a/kernel/sched/ext_idle.h
+++ b/kernel/sched/ext_idle.h
@@ -10,20 +10,15 @@
 #ifndef _KERNEL_SCHED_EXT_IDLE_H
 #define _KERNEL_SCHED_EXT_IDLE_H
 
-extern struct static_key_false scx_builtin_idle_enabled;
+struct sched_ext_ops;
 
 #ifdef CONFIG_SMP
-extern struct static_key_false scx_selcpu_topo_llc;
-extern struct static_key_false scx_selcpu_topo_numa;
-
 void scx_idle_update_selcpu_topology(void);
-void scx_idle_reset_masks(void);
 void scx_idle_init_masks(void);
 bool scx_idle_test_and_clear_cpu(int cpu);
 s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags);
 #else /* !CONFIG_SMP */
 static inline void scx_idle_update_selcpu_topology(void) {}
-static inline void scx_idle_reset_masks(void) {}
 static inline void scx_idle_init_masks(void) {}
 static inline bool scx_idle_test_and_clear_cpu(int cpu) { return false; }
 static inline s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags)
@@ -33,7 +28,8 @@ static inline s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flag
 #endif /* CONFIG_SMP */
 
 s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool *found);
-
-extern int scx_idle_init(void);
+void scx_idle_enable(struct sched_ext_ops *ops);
+void scx_idle_disable(void);
+int scx_idle_init(void);
 
 #endif /* _KERNEL_SCHED_EXT_IDLE_H */
-- 
2.48.1


