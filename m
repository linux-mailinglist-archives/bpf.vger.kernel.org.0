Return-Path: <bpf+bounces-47431-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A7A9F95A4
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 16:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9734B7A25D6
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 15:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D7B21C18A;
	Fri, 20 Dec 2024 15:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hqK6/nj7"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7032821C178;
	Fri, 20 Dec 2024 15:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734709305; cv=fail; b=exNKw6YPsS7mLMEukzBBNpWPGDIufB//fzUCSk03tbxBxy63XbxYwy/CN2mXwt7KatvC+Ep0J/oUW9ePvV5OZByqmwknK4iWFfAJtajM4RuCsY6Tpd0K2QpJehL0u+dZ+r5e/ntSPH8p7jvHBP8ylkqvwujWZIKVvRXP3kdfQGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734709305; c=relaxed/simple;
	bh=S6Zmfb6gpHI2teqnPISLSr5irpWKYo7zBNPrWt9qUCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LtBE2bSh6r7ErWuGsvRjOJMr2CSVIwzEVqvVIFZNQqmaNFs+ihey+p7e0l/3t6qOOogL3WovgKuT5z3CKOlSBnNNSB3+8L4uTkvuD4FXmaG1qKof+3mq5RkLA50oSKeCcaCeGFY/RSQ9SoVMKdNSzGxboyZ6dlhvzKZPJXfubow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hqK6/nj7; arc=fail smtp.client-ip=40.107.237.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g0NPtggjCH3VmUQKRvLSiZ7OIuc4fsnv0OK3h30TWzYK7sB9M6jZSC78sketB7Br8bMBpeEMn5NZKJzXUR+OERLBHf/IotTLRlOdDwFrmXP95L1xziD9YRexLNoof+8K3kWnZ+2/0fFNk0SXYo+uKqkBpnARWXSGVCndXw+CYRaKu1z/B6JMSaCvPTll86aqSi140490Qy9abZym5BtFuHdP4cSs/JTCHLlu5IFOnYQtn50Ncy/sd2On0ldCPoFxp5uc/FMZe01Y2f6ThnMUjSeup8ZjgjhKIMVV+BHDTPmirRjdmpMf4pzUv4fZfqgaH90zMLOypO9IS8iptfAT5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JwGhBsKlpTx7ZGqvODEf/JNDaQwKZ74m5/Q3haVKAsI=;
 b=K1pijaeeXSwSu9U15RfoYA5WKWwbDbwcUj/ZfpmIbZS71xl/L7aawJ4Z6HrkTNeiBRqnqk+XscymGziue6xQuBxBD1fWeNWLi9PYuBzCT+ezs7lwSOVEZlF/OvmBTSIsjAtRrTNWnrO0NeAXm7pmBc5UlvTDnChYHHRC2I70TIUFA5p+Vt4lvdPSaG7ABRAHiJ1HxA0owHkGtrziC2jNiTB+qPs81go3a+ODP9unQoN0Q+OczNcSLpTahCATtV0uwFKa+aq6DEBOe5HR/8DBE6cNd2hKRUMwRkB66eWq3hp1gEJJxGcRSLCOenm4leHF2bF53gkre1bHsKdpWqJVjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JwGhBsKlpTx7ZGqvODEf/JNDaQwKZ74m5/Q3haVKAsI=;
 b=hqK6/nj7h4sHWgaoXD42yjtVSWRrHivUrQAsWykIGnH823snpFtsF5dDerjb+z+0OemTP5fTITku+Tqh70Fok9v59wPg5K8FYP3EE5a2YNxO1r+JHjdSc0UCeB+zjKyGlaC+xSn7G+YV4o4+GhoKcXFyJlsew0WSgvSdU4IUx4Z6FLCPJ1j938oSeQwVbgsoW1QDzckYxrGRQY8WHtv8I32+hGWuxBjWkAOJ4JIdgRnwTXkVZAcQv+SvaI8gMVVqKwRsn0rZ2z9pu733rAqpILY6SeF4S7LfV8CyKlKuJ9tGpErGRIJg14/TRDYrXD/2HiQ11Gv7R6uymUYdLtC9qA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by SA1PR12MB7149.namprd12.prod.outlook.com (2603:10b6:806:29c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Fri, 20 Dec
 2024 15:41:41 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%3]) with mapi id 15.20.8272.005; Fri, 20 Dec 2024
 15:41:41 +0000
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
Subject: [PATCH 06/10] sched_ext: Introduce SCX_OPS_NODE_BUILTIN_IDLE
Date: Fri, 20 Dec 2024 16:11:38 +0100
Message-ID: <20241220154107.287478-7-arighi@nvidia.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220154107.287478-1-arighi@nvidia.com>
References: <20241220154107.287478-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR5P281CA0057.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::15) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|SA1PR12MB7149:EE_
X-MS-Office365-Filtering-Correlation-Id: 619af6a4-5f2b-4176-557c-08dd210cccc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZWaUteLDkwE1CmjwaU74wqQWUJLVaHT2a8LIhu4ZUy2chvEXhRe40DBr2dBj?=
 =?us-ascii?Q?eKs7/rL+Rbwd/afXUbck+CMNy//VuQuYzrFHkJmHYh42bQqci85vUyMrmAg6?=
 =?us-ascii?Q?RuCW5Ab+6pa4OyxShYr2ayG/S9TcNZxLUOGcTynVTvYuJ1QXPvEoukaRSUme?=
 =?us-ascii?Q?AQkTuK+58YnY+XIDyhS/fxW0b2svZglmJwnhahYU+zLCnwNtfFJk1+I81kPE?=
 =?us-ascii?Q?kXD2H6HJFaszC/zCNBTmlksn433VmnHffCOXJ1VEmRuJKukEeVfI+0WaB38i?=
 =?us-ascii?Q?YR98K7kYEZuL00Q/poC39GRNQcxB34q+a9ahdj6QcVuXKvLJUkYE5De5Nq3A?=
 =?us-ascii?Q?cT937/0MssyXXV4rWyYj53uFuhKfJ5zcsOIeBZ2YjlMjFqwX3vbK8sZSZSlx?=
 =?us-ascii?Q?me4QInf7vnXhDse54PmkggwfxjGcxMkhpoLlRut0PfU73KatCl/bI36aykg2?=
 =?us-ascii?Q?hUUfEzK9ryg0okYv+0aDO+E/TwIn/lFacsbtiSXuF1sglJfLwzByt3OLJRSW?=
 =?us-ascii?Q?hHqcT8UrVQZm1lOF35LKxvcd9uzGAxt9kVp6Hpu9VscLrCPGn2vwaoJMJk+B?=
 =?us-ascii?Q?erT2oAv+1KIUIWa0RpzP+KZOPzphKMfTD28XkNXjBOmWcIHhSWQ3H++IL6yy?=
 =?us-ascii?Q?8Xw36aAXctV1YBqyndGzw83AFRKZSjJom6caNsQOPF/5MYp30RcJC8FsTYxd?=
 =?us-ascii?Q?NjftROhLwcNUEfE5LqQ6reZlSLuW1hRiktmLqUe04bxZNA7Y7/p0l+wrAxH6?=
 =?us-ascii?Q?RkuIX89//i+3LIIzyAMX+WGAZB98Hr802Yty+h1ppv4lQWuDPxBo/W1MTio7?=
 =?us-ascii?Q?cgMeU/KDPmt3mako5+u2XqXv6Hzn24MZPhUg2s5L0AuyegkwgTGY78XEaeBs?=
 =?us-ascii?Q?VGxCvy+8t7kOSq9z/yWP6mWe2T+Nme+vpLe5ojVZleDfmTy60KOa4Rjc5ZW2?=
 =?us-ascii?Q?ze6wNK5G3FzUrx8OYGNgvUKiCik8C6Bp4Jg+K6/yYjCiznPyL6YkEw0BWT18?=
 =?us-ascii?Q?u/pv1eYnaDKPwQg3r9azMlWYQlveiOOQY/jy6zPJG0wVv0iBrWohWBbaZxm6?=
 =?us-ascii?Q?K/DW4IWG1j/99id8r0rf66XMti5unJVAURnWecdEUlZHAurOWJ/SrRZbjaBP?=
 =?us-ascii?Q?4cU9ByqsGn/WE3sG3x4qK9dG3wrFNTeTNCtWIJeJWqQcEM2Bi/HQc7R7BS3t?=
 =?us-ascii?Q?XCfrrAlJCzgyuY07JuDSmWTUCyAzqZ4R4WuhMxFkZulbVIMSO7HZVXfE8sO4?=
 =?us-ascii?Q?xLgyKni2bsVKpPY7BRB5UgpxjFevZXBkqMlkWiNavHgtVnewv1gx5OyNBf9O?=
 =?us-ascii?Q?vKywNlCnLrsMtHwQkFJtbu9Ii54K4ttdc2TCk9eF1UI8J69w8ppnfRkHeKNc?=
 =?us-ascii?Q?dTDsUrkLD6jtc7sSOmiZsPe+ZcCM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bf0osG43fzlnp+TjflssIE6LYdGLUcWSWhIZz/p+44GM0++7+orEYohiI0qo?=
 =?us-ascii?Q?mOKU0dDT6dMvJ6AGiacQtWNqVYf3twV94uFL3SSQqvgEYdXum39YvwM+X/AW?=
 =?us-ascii?Q?iy0KBITfnBRkaFfJSGEYEmN2yEC5q9o5rhRR9Pb+lVLE1vyL2trt3NV4UFRX?=
 =?us-ascii?Q?ysLwxbpB6F15vcUh5dSgkHf19p5nq6uYwpnuKFVTaYiV1+rcv6uTP0CDqWEI?=
 =?us-ascii?Q?hGECA4sDge49/4Hjz/3eOBBlU5ZxXbHx4YX2YEEpaMRDF7QAk5eXrxtVZajP?=
 =?us-ascii?Q?jB/wC93ehJkRRwHIKe9ae5KOfemVh8dUQIruCtUP1clG+BdwBoFPokWRxSHi?=
 =?us-ascii?Q?ZVKpxNJxYbkYUL+oyulpaS06YDavoOHPQFAD93YZkgIAs4xyCTRPC8VtZS0o?=
 =?us-ascii?Q?5fP3NRk6veh9Nbn00GAOBRrrr0XdLPdpsrxl0fep2VxCwVa7GhkCaW7MiaWj?=
 =?us-ascii?Q?EljwChCyLiib/BP/K8fR0tT1QntvgR52vEuqRPV3ncpN1s9F5Whrh2jYDC4f?=
 =?us-ascii?Q?WcUDZSHIMSdE1sv9MfOIaB/kG7PeK7DR4X6r3xI3qndHyYFI/QYJNmy2UpQo?=
 =?us-ascii?Q?4JHXO+TMOm2RLY3I1kqdxFhhkHwmc6fa2hpfPYr6l5lDtA6lorEHrSZddELp?=
 =?us-ascii?Q?wg0b9w1lPlLzSvlT+BSvQ1pnAqor/8Gq1lqF9MU18CDoOxiAkT4Mqo2SPqqH?=
 =?us-ascii?Q?3bFxnyjsQJ8uYGW8Na/I7cPXt/jCGotk/mVC+9VevPtr1QVAcAbLdwWtrR/5?=
 =?us-ascii?Q?8eMEBw9Evbby+9RebrXQpNkJXaqQ7+jrNkhUU0vXdWjNRTN8kpoOW/SaxY/K?=
 =?us-ascii?Q?xluNAwMu9QDIG4fSNF3uSFm8xdlGoaCmPHButHKvNPqoTSrwJEc3udiuUMLm?=
 =?us-ascii?Q?bt3bQ+af5zndtfXzBUGnChhairPCKud06/bawzhSkPnoGU5nT1sr58xEecfc?=
 =?us-ascii?Q?NF8yFYlk+ckyeBovF2lrUvM9MbQY8l08KGoBrklnUsWoP/iU+ywpsv6hikCF?=
 =?us-ascii?Q?rf1O/v3hu28WY2vAEOYCXgYpOy5FAro+X5qRpRgdnVbUN3EeIE9vt9ylMqlM?=
 =?us-ascii?Q?Urh2EWkYWlVVpOBe1l71TJRhK8ucbtASl5MmjpzM0FIRnbCRIMgc4RcDy7uw?=
 =?us-ascii?Q?o5ECVGEsHKRL206+dZEcRb81AyQ1AdJCzuws/f0Z83NQFdk+W/8F0J5vIknN?=
 =?us-ascii?Q?bBuEppIziY1VfaBZ1lDxt/Tv4ozzpru+BYvO9QPLOBH8g2sJkW6k/tNI0I3/?=
 =?us-ascii?Q?xl0CoA7rSGNS0qgg7slEhHuK5FbJI1+F4DNtVEG7ifJ96dkVM33ZKMuNPnEU?=
 =?us-ascii?Q?JiE2WGomjc2Eckb+8lBqH8sGzxJV+TCbV/HNtRqbQuhe9KkiLD5QplKf0VUw?=
 =?us-ascii?Q?GLpVyo1vCxCC6DKCEpTQJof/8F5StQE/s6wdkRyjXNgI5KjhrHWpF/0cmqBp?=
 =?us-ascii?Q?FSXe4e20EBs7BdmlY4n0DifKYad0345eb2dZ0rWskc7xSgD1EkMzK1p+SJYI?=
 =?us-ascii?Q?/rwn7XmNlPBq61DzEcGYv/tvylqSKp0jH5GqKZDuFtlh91K9jHXWxdCMz6uw?=
 =?us-ascii?Q?16sq60iq+5JcknFIcAMdusXMMpCl05RmYzDMRHq7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 619af6a4-5f2b-4176-557c-08dd210cccc8
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 15:41:41.6557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: taqc122yK+pBwqii/jTOm7f95a2fE0iL8LMtcZ738HGhq1gEUHcsw9Wz5v7r4aGDVbDpioq2nBg+d09FNH01NQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7149

Add the new scheduler flag SCX_OPS_NODE_BUILTIN_IDLE, which allows each
scx scheduler to select between using a global flat idle cpumask or
multiple per-node cpumasks.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 769e43fdea1e..148ec04d4a0a 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -124,6 +124,12 @@ enum scx_ops_flags {
 	 */
 	SCX_OPS_SWITCH_PARTIAL	= 1LLU << 3,
 
+	/*
+	 * If set, enable per-node idle cpumasks. If clear, use a single global
+	 * flat idle cpumask.
+	 */
+	SCX_OPS_BUILTIN_IDLE_PER_NODE = 1LLU << 4,
+
 	/*
 	 * CPU cgroup support flags
 	 */
@@ -133,6 +139,7 @@ enum scx_ops_flags {
 				  SCX_OPS_ENQ_LAST |
 				  SCX_OPS_ENQ_EXITING |
 				  SCX_OPS_SWITCH_PARTIAL |
+				  SCX_OPS_BUILTIN_IDLE_PER_NODE |
 				  SCX_OPS_HAS_CGROUP_WEIGHT,
 };
 
@@ -4974,6 +4981,16 @@ static int validate_ops(const struct sched_ext_ops *ops)
 		return -EINVAL;
 	}
 
+	/*
+	 * SCX_OPS_BUILTIN_IDLE_PER_NODE requires built-in CPU idle
+	 * selection policy to be enabled.
+	 */
+	if ((ops->flags & SCX_OPS_BUILTIN_IDLE_PER_NODE) &&
+	    (ops->update_idle && !(ops->flags & SCX_OPS_KEEP_BUILTIN_IDLE))) {
+		scx_ops_error("SCX_OPS_BUILTIN_IDLE_PER_NODE requires CPU idle selection enabled");
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
-- 
2.47.1


