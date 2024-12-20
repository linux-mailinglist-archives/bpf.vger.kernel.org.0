Return-Path: <bpf+bounces-47427-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFE89F959C
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 16:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75F79188DD9E
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 15:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4785219E9E;
	Fri, 20 Dec 2024 15:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JmPLjOzs"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE261219A8F;
	Fri, 20 Dec 2024 15:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734709293; cv=fail; b=B/GL/wN7yJooJAgUQ6XJ89PiuFzRtlp7mgQO6fhAwMB+hVPCDfLgkGKwNomQ/r5ia6USRL1Knv+k3l3npdQjlMPzbhg/ZOaPHLlRiCoswH+Yc1zckfxfavusV4I7vjSuqjvUImc8v25SNHYHVhcbaaNEwveONQcl4rpUoZkT+Lo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734709293; c=relaxed/simple;
	bh=rd1KLkv6/KG16obzT3mVY7o4zIbTwBv90ueReM766wE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ay7MtJzJ64oqg1C7dGUgVVgqsnGllO+90pd6WXDdOTB7MDJMJlCbylbBKyofOt7wY2C5yr7Fcwg4kzl91EFz8KbgJP5BMTW2NME0quHiMNuk3XhWqkigFBP1aotssb5m5i8IL+F34hc9RZppX1La71Wi28atj3Zs1NYsX1yjZGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JmPLjOzs; arc=fail smtp.client-ip=40.107.244.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oM6lZshcLBW9FoDMN74RVksAZIVkwZ8LqHOhNQDJB6Ovn8NX9l4qAB7fI8eGroM5i7w9c/lewDy46e3y4Uqifb13IJ07czSzpBruaXtYyfHN0HWaupdARNOGdtZNLX1nbYM/5qoK0b2Ydt1MOrSDBtCe3Ew6WMLiwkZOX1KuxboeIjitEn95i/T1DaQWDFcz6I5sZO8O2uvvKrW/OdAhDaJ9Xhszu92iCA2SXKX1XP+aJ3WOuwfBq8G7QJyTlAxFsKzZaPrTlPhmPWGHz5DwiLiCvFcvIKj8Ug1zkz00w8jk69UFpaS6Y11jqAmj7QoKEngQ/LEeVPbHdNqEVvdUtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MSAf/5oeljZeD2slGVutVoZN1cVbQQFKEBFtPdfHCcg=;
 b=Vh5ZKD52HlnMS4bHXXeIeddbI/VhZq8aDLXS98ld//5oe1KOvB8GpMjpsREZkPTvozwW7Gpe+B39i1zOL+uSegnSa7+Ouha3l3rdUm7I1EzzGU5g2xGqYyUlxmhtpgFPcg3fJxD4sRW0tWnnPS/TwNq1p5C0JlrX337z/7c8iZpFL774vDObXJF0Q6i1lhSQcCOQBuI6E0Kp+Re+I28by+2MVoHYQDLheyAb5ajQq/dxiVF/wYcIyROXAu12CNhHSWBz+VYA77WZDKPjiPg8fkeUQOKs4xx10DvLglm0FZIeMYvEpMGP8M2LzOumErkEWMD1J95pV0KOQ9DkFYx+oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MSAf/5oeljZeD2slGVutVoZN1cVbQQFKEBFtPdfHCcg=;
 b=JmPLjOzsbP0hEzYvfzW0FvghxfEaW/0NYb51PBHbU+xmt1z/0yhP1/YO0RByeDfDFjW3oPvoXGPohMV+uOGZVHnYCm7/pHRRitVEkd55pN+VzgcBJkZBKsHx7/+rHge+AAgIvz1TyNDgSNrDeFCWuYg2t/tNWRWCSWoSzFrYtc2yrH3liTFQRameSP13MA7YgBA7BMgFGQqdwnYqAhVAaWzQJ9mj68a+qa7mgTge0j4gBY/Q8q3SS3ECR1mHpKappTENYg7e8I+n9tWvfEXhvNwWyg0BTkMt5FhwMvQ9WqXSP3y62l3rD9fOyx+6sUKo9q76JMYWpp6q+CeX5lfPgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by SA1PR12MB7149.namprd12.prod.outlook.com (2603:10b6:806:29c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Fri, 20 Dec
 2024 15:41:28 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%3]) with mapi id 15.20.8272.005; Fri, 20 Dec 2024
 15:41:28 +0000
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
Subject: [PATCH 03/10] sched_ext: idle: introduce check_builtin_idle_enabled() helper
Date: Fri, 20 Dec 2024 16:11:35 +0100
Message-ID: <20241220154107.287478-4-arighi@nvidia.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220154107.287478-1-arighi@nvidia.com>
References: <20241220154107.287478-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0281.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::14) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|SA1PR12MB7149:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e06a7fe-e3f0-4e76-47f3-08dd210cc50f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZtnGpCYbYuEFNOO6WhlTIo9zPEgq9kBKETOk/C0eT3hf83ERzkN/D7vTGk6t?=
 =?us-ascii?Q?zgZwP7pMxIL2HfSlDDiBZHgiDgNPJ77vzhgZoaWlcnufjbdhFGvpE4udNlX5?=
 =?us-ascii?Q?v0GUixqqNgJx6ar8ZrzwT82QgfN8tCeVokvYHeehSA8fvH26w7FrjvnBH52u?=
 =?us-ascii?Q?bqeIOSC3Vgh57gIRYhD7191qOVpNDWEIPV4GZJJy2r50DpW87NvnybFGqtdV?=
 =?us-ascii?Q?4QRk0OW0dYMLvHPosBEfSTNacptVW4FuzrBQhmY0yQunRbG9MUC6kOSkS1As?=
 =?us-ascii?Q?33B1K5XHOKX9kRID4o4oyku/Twz502IPtecEtgqdXlpTIcIfQffcReh7XGul?=
 =?us-ascii?Q?+HAoVDjv/xLbZG1J9i3uujcOV4sSm5MWEHJHPa/oeOH6PX7mMIPlHCbYGp/Y?=
 =?us-ascii?Q?aZ3nkF7hDlhmAbiiQSl266TCjPE4X3hjpTcXxIO2kuNVTssX0UUVjb4x7VnD?=
 =?us-ascii?Q?hqCkOZgCj6NPDl0mkhi69gkKHpxootm1YtI/h8Xoqx30WPR1LnQ3LRpgwU1H?=
 =?us-ascii?Q?kHYzXUguKAEqBAV0GSKbs49Oe+MSAeMG/HzPaz2HTgI5tbDWS0lQ+cPrPac5?=
 =?us-ascii?Q?yVfnzINq0jMTZTQtyjaayQgcECc823+ZcpvRkBx+G2pmf+Tbf3G+/pSBeclG?=
 =?us-ascii?Q?VjnjcisazYBFGB9NWhrsWbHD0xCP6QWn6ebkpNMPP9/V9UhJbf/SEMruxc2U?=
 =?us-ascii?Q?wp22IRZ8uVqh0KRiKO4KbkFfwh5DTk2j6us05VuDiPAQT2p/dO1IGNCJJ9p6?=
 =?us-ascii?Q?0PVhDMC78iw+4DZwHg32ihVTnhBVIGAK+cZu3GE6bmw1EnWBskU+yjoBJRA2?=
 =?us-ascii?Q?4thtpoLBc2bGOK3D5ziQ4OuQEL1nB1oZESYIImDwnsr1I6WViZi0pXl3Ihjr?=
 =?us-ascii?Q?b4DfbejQenMtSd2kpaLHMfd+ns0+AuqErp4PnhUzd/jjWSjXvReTskuLTwMl?=
 =?us-ascii?Q?WsteD62STld6Py6eGn6SlFDRyw5SDoNcFkOSiTxKoRy3HXZ4Xske84bWP6mo?=
 =?us-ascii?Q?0RU8D0JV+pB+gdaGL1igVGxdzZGMWqW2UdmsOesFQg0bjBVUgDHfEZ/MQ9Tp?=
 =?us-ascii?Q?4Hdc6+GEmqjdEeGktA2BV3g8phZ5QChrJN/ahMe2UhIgKmjEH7fuiC2rXfND?=
 =?us-ascii?Q?0E9ge9zETseR20mJyPHnU0f7EfktKJVYw/aBGYwfapCt9n7a1+EBGetdvrJ4?=
 =?us-ascii?Q?+1/U+PHgfdPKDKC4a4M78GZfQ0dSGbSIPvwwdUwhLfpCsJlcZ5CP1A3sOj9E?=
 =?us-ascii?Q?kAryzZSPCwnLp6adk2yi0QF3niWS5rSd9mIN1K2CgaU6+f1oPPSKmjU3YEgw?=
 =?us-ascii?Q?DZQ4XDBY1S1zWG9nlSmvklCPuiKTnFpA6wNtADRdjQVettPe40WL58l29A3/?=
 =?us-ascii?Q?vNnyGj+OEiqNF6bZ0If4ZFZ3WxE4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PrI8qMo5usMejigqRvxbb76TjDHvK0MAmC2msC0Wy6EwmAp466IguVp8JAjj?=
 =?us-ascii?Q?Im44MOle2Gn6BjAa3KXJcieEuVrvyEpBzsUwkfG81Pm94MYcyxgwgvvgzV02?=
 =?us-ascii?Q?e9Iv+xeSN/O7du5QQpidf1juArAXt0mvdey5E3Xvz883I/4WcCi3WTPyTI/3?=
 =?us-ascii?Q?xuKjSH3/t+bMGfYxEWPQBNUF/+hguUsrwYXd40GdW2LUd/z5t46dOr22lX5x?=
 =?us-ascii?Q?hwlmJo+iNW0T0bcr/nVjvvwnSqZ/lW8NWDq/7OACeJOM+Cxgxih2RkkkHIgO?=
 =?us-ascii?Q?2+a9qGMl90O92P0NYLzIo0DhjWpQZsJuYBDkzvbOiw8x2iX22yl4169BonL+?=
 =?us-ascii?Q?BrBn23TRHfAfoL6QqSyrnGbOTP2ZmOcT9vQsiWaKxrPZqlRLKMKa3Z7TAoGi?=
 =?us-ascii?Q?6VxQdqo+SEbgNbhS8G16AxRERF7g9oIFSTvjMDCfvigTOEmYhO2ZWb3K16ip?=
 =?us-ascii?Q?Iov4TZpz9xs4JT8XkgNcRrnGol8AGZNMS09dm7x1azizpsYeSgMG1fzpfJxS?=
 =?us-ascii?Q?XXRF9qIje4mtIdNNSP1St490Gcqtcln9hx2vdYyNjxGdhwNkthc5hxq4Dpfo?=
 =?us-ascii?Q?K6/Vs+STNzFzFcXqI61WMXM2VuBbfMde6zSDtQYw+2lZOjwuD5Fn0s66TC7H?=
 =?us-ascii?Q?8nGIUnoIGb4oXiGFDXaRXuTiM91HolRChWIRvxyY8mB9om/wtY7SzFs1xAGc?=
 =?us-ascii?Q?fqknvnvGhIiZu7ktoSzSZUgYupaIS4EUPa/lElXDwp107Q3CH3YZ8n2SzQy3?=
 =?us-ascii?Q?h1lPrBGJaVCIyrxRRj1MmjL/lROxL+KMbt8oqarf1hHgJLQTwjp1t7//y8rG?=
 =?us-ascii?Q?B/pwmklAYjcRLgVyUofs3qQTBcF/C+GBX61mCcZoRaquQHwKGh8CVLHxB18Q?=
 =?us-ascii?Q?IiprkuUWUmLx3/TggINgR6Iw/XLadsjkYL/34KZf7KeQEyOWOXKUR6ziBJye?=
 =?us-ascii?Q?Hm8vicHAjzXpMZhxR8xXoxE+YBN5h/TdyALMjP0UGauOPDXDIx9/inWnSg08?=
 =?us-ascii?Q?0miuayhISMdJRs7ep7NYcIdKS/Bp2fgtv1CVmDFim2ecDC8jabPcMXzbuRVb?=
 =?us-ascii?Q?Bq56H00HIParZWK/Pj2/5nR+I/Fl9gPzICRkq8vKjfIvJIi95YqfMD8iUF25?=
 =?us-ascii?Q?fiGlEd00uwYgCtishKa76K1ONApx+Q3MXHXb1e5qO6FyeFuLFqGO0zKp9MtJ?=
 =?us-ascii?Q?N6aoJH19iXS38ZRvyWgpxMYFXCicOfd2lZ/96+gK3buT6phQS6kr7b6f45QY?=
 =?us-ascii?Q?1Gq/jH5SdFf9uzt6qlDdE4qizUZs81lmmgnl3zCR6DstoKHzTpXI3ltZe5YS?=
 =?us-ascii?Q?N5zygxFO2szDduXVP5L0rrtc2q3ZquyEJlm9HXxcH5hEl8KqVk6MdLsbEk3M?=
 =?us-ascii?Q?+Hsj2ZrJbb4dbtXBPwNgVEuxk9c67y+1QJfQx4sL6dqa3xWoeeNsa7Ptlxk8?=
 =?us-ascii?Q?MnFikDpHD3DzbpTknb7bKfHcQGlXxCO6TzTwEFgMJisg4loLlbrOJ47XOEW4?=
 =?us-ascii?Q?9QO23dV4XpoB1FNm66oN+wa+7O94R29gxjFnyZyaHMV6fP5WhbWB0Y9SSB/b?=
 =?us-ascii?Q?1rFc8bG5xhBtpp9JRUqcid6zI8cL5DXhG0wmleRf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e06a7fe-e3f0-4e76-47f3-08dd210cc50f
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 15:41:28.6843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iuJi//y/MrSryQ0bqVyFf/WsPG+bCmNjmUMPtZyRACcuUIEKH5qzeVx6j/nQVYdBwzS7QBsO+ZwGGcLs4icrJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7149

Minor refactoring to add a helper function for checking if the built-in
idle CPU selection policy is enabled.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext_idle.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index 9e8479dd7277..0e57830072e4 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -12,6 +12,15 @@
 
 static DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_enabled);
 
+static bool check_builtin_idle_enabled(void)
+{
+	if (static_branch_likely(&scx_builtin_idle_enabled))
+		return true;
+
+	scx_ops_error("built-in idle tracking is disabled");
+	return false;
+}
+
 #ifdef CONFIG_SMP
 #ifdef CONFIG_CPUMASK_OFFSTACK
 #define CL_ALIGNED_IF_ONSTACK
@@ -508,10 +517,8 @@ __bpf_kfunc_start_defs();
 __bpf_kfunc s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 				       u64 wake_flags, bool *is_idle)
 {
-	if (!static_branch_likely(&scx_builtin_idle_enabled)) {
-		scx_ops_error("built-in idle tracking is disabled");
+	if (!check_builtin_idle_enabled())
 		goto prev_cpu;
-	}
 
 	if (!scx_kf_allowed(SCX_KF_SELECT_CPU))
 		goto prev_cpu;
@@ -533,10 +540,8 @@ __bpf_kfunc s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
  */
 __bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask(void)
 {
-	if (!static_branch_likely(&scx_builtin_idle_enabled)) {
-		scx_ops_error("built-in idle tracking is disabled");
+	if (!check_builtin_idle_enabled())
 		return cpu_none_mask;
-	}
 
 #ifdef CONFIG_SMP
 	return idle_masks.cpu;
@@ -554,10 +559,8 @@ __bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask(void)
  */
 __bpf_kfunc const struct cpumask *scx_bpf_get_idle_smtmask(void)
 {
-	if (!static_branch_likely(&scx_builtin_idle_enabled)) {
-		scx_ops_error("built-in idle tracking is disabled");
+	if (!check_builtin_idle_enabled())
 		return cpu_none_mask;
-	}
 
 #ifdef CONFIG_SMP
 	if (sched_smt_active())
@@ -595,10 +598,8 @@ __bpf_kfunc void scx_bpf_put_idle_cpumask(const struct cpumask *idle_mask)
  */
 __bpf_kfunc bool scx_bpf_test_and_clear_cpu_idle(s32 cpu)
 {
-	if (!static_branch_likely(&scx_builtin_idle_enabled)) {
-		scx_ops_error("built-in idle tracking is disabled");
+	if (!check_builtin_idle_enabled())
 		return false;
-	}
 
 	if (ops_cpu_valid(cpu, NULL))
 		return test_and_clear_cpu_idle(cpu);
@@ -628,10 +629,8 @@ __bpf_kfunc bool scx_bpf_test_and_clear_cpu_idle(s32 cpu)
 __bpf_kfunc s32 scx_bpf_pick_idle_cpu(const struct cpumask *cpus_allowed,
 				      u64 flags)
 {
-	if (!static_branch_likely(&scx_builtin_idle_enabled)) {
-		scx_ops_error("built-in idle tracking is disabled");
+	if (!check_builtin_idle_enabled())
 		return -EBUSY;
-	}
 
 	return scx_pick_idle_cpu(cpus_allowed, flags);
 }
-- 
2.47.1


