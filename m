Return-Path: <bpf+bounces-50803-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B28A2CEDA
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 22:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 937B016CC82
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 21:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5800D1B2182;
	Fri,  7 Feb 2025 21:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K7lrtj16"
X-Original-To: bpf@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2042.outbound.protection.outlook.com [40.107.102.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6941B0406;
	Fri,  7 Feb 2025 21:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738962695; cv=fail; b=cycVPtkuOVFoje+OeZ0DMoopklyuhW71JmhEHUdOYc2dgjrlLdcAhv0G0fUwwiQzBY86dub3WNmU5vhxFWtDXlP++6IOejr3RuqffjPPr3+0eonRM1UlmcOK+ObqI7xG1G71sg9eq/mfZ8eDAAy5gZ8llO2PKaCGkmBfICQybQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738962695; c=relaxed/simple;
	bh=4KKf1PGCiOadWOWrEekrpAV8LWE4UxVYvoraeAmePpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Tr1i1j7uuw1L+6C2WoVsX1XAYnEbAhsKOfxUp5VSWjmI4fGoEXTI9jih8d2OmEFnTksHDZxeIf/8dXqVtDgmVIZ0Z/LLhD1/7cS3kUnyKrmp0xr4ySh+3bDUzTKKBPzi3lzbcd/PLI9Y1XDAzC66iqysq2c7CGem42zR4wYW+u4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K7lrtj16; arc=fail smtp.client-ip=40.107.102.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r1CPhd/Lx0+d/2KM2bZFfpccn4Tqvxh3B6+Duk/sU9+fvCUsngX1zZTRwdf0tMuyP7NhFKqAw9xQeQJGOjvOhsGR5YmoI9a/Hv5LR+1xfi8JtwdGRGWMHxgzHhTKJh6WrH+X8uaEtTNNPRVnJw6ryO5yc09Ki+jmIGvopiN+g2RGb5KCpgpgb/xNXuw0Ix+vUQzvlodMPhk0/t952uZ6f06HT+91TG3NEAPBxyIGGrZ3LE4kQh2njsRFOYH9Ce+UOXLZI9VMvVgNpuMfq67RlZ6Lcq/U2xy2g7Kk3SHC8dKro4QKcXy+JsCGmrUtVVttRNIQuzzjwlBWwYXjRS6YXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7h3/imPYeugGLGjqlch/mf4pSavgICGPxzKjg2B/cYo=;
 b=iAwuPawW1qgLmvSR59p/TksqWOM+xntCKwK/O+f+7/EzKsoXpwC8VE8rJw1gJJWJldAqywunEtBXfzcsmL+jMKnMeVUq0AqBntzgMFgdLlENERJaVUBNPvKnPAdepfdW9OIIxjXqYGKsyfAdHWS7AjTlHRphF2LuKGX5YU4D+UaJmTVaHxt4TJ/Iff/oc3R+ckoUeD0Q/a/mOBe/fqvo1XbtmqgGgtTqaX0zft9sA0o29BQQSIf1JF52kpkbLmoTU/VXU7Q30TSF5grkJtinSXsXG4J7yjmM+nJqjaiGD9Nc1yI7V8UEOMiEUWqVhZmJq7phg2ZJhnNU4geKRXdhqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7h3/imPYeugGLGjqlch/mf4pSavgICGPxzKjg2B/cYo=;
 b=K7lrtj16xWXbVsiKdPNbe82HRWVPV+Y4imS1+ei9YtjlW/u6zYY5ByZvTO14/l/ICfv0sAjTTxepqd7a9ahISj+5MpAGGidVYIVdljG06bhC67/A1gYWCZsWvEHVko3svv5DQyNAlGgy8Ix0UoG5bucJRJq2uTuqohOzNcmbs5hl1diAXZBPNHjJ+qf148rl26br4to50UbXcmmSuTTOt9+q6GlD79E1sdT6C1mGCGYYetHpnFvH4OiuF2W1grPT1+KyztNe1QbnrUp/Dy9/i139MfU5QaSzhYxX9JZLzxkFousKPCHvHfTjZe6YqQbz4nVJSO4zxILEQLq8V7oAdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by PH7PR12MB7380.namprd12.prod.outlook.com (2603:10b6:510:20f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.14; Fri, 7 Feb
 2025 21:11:31 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8422.010; Fri, 7 Feb 2025
 21:11:31 +0000
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
	Ian May <ianm@nvidia.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] sched_ext: idle: Introduce SCX_OPS_BUILTIN_IDLE_PER_NODE
Date: Fri,  7 Feb 2025 21:40:50 +0100
Message-ID: <20250207211104.30009-4-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250207211104.30009-1-arighi@nvidia.com>
References: <20250207211104.30009-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0177.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::14) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|PH7PR12MB7380:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ceabd10-d3ac-4720-28bc-08dd47bbfee2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dFM7TXGiV0/zzsiJUSHhd5dN/s8J9veZI1yqcVC8y0ZJ+fmzSOC3feeC+o81?=
 =?us-ascii?Q?un9ZyQoQtFvbdIkC5oJbPPCmimXdWOhL6wX85xXMGdskmyvy1POLQJqqMPTk?=
 =?us-ascii?Q?MUncbyJAatGKE5TqMzKVsqAO/AUUtXl+nxrjZFdL03QbsrWTpXwl92Ig2+Ds?=
 =?us-ascii?Q?V+xwUvkZG/faSCcjaJp4ziTNv46PVU8x82H/CXPLaBDQ0R7Jawae6TXlGPkX?=
 =?us-ascii?Q?LG7LafY+zTIES5615spg0vnocZ592UUFcGjVURYelqzDtDeyU9rd726EEZfh?=
 =?us-ascii?Q?9fhAGxm+Qi+r5E2TTx2CU/aF/XyWTOkjfZchCbIWPW2WML1O50aDeggyQPlI?=
 =?us-ascii?Q?/wcpWkTh2Ill+DG3zIETsNkbyHcFjX6xy9BRto7Udcs+wFq0v0eXFbP+WWnw?=
 =?us-ascii?Q?W3uQpnnCJpP16YKWlSsYiWF5SyhgkuXoKON43XMt3kEOszpafQ6lSLaD0f9L?=
 =?us-ascii?Q?UOteMEsZb7eB+iMB/YeaJydYHFvIsQCoLq8riFJqxscqd7vIah4Pxn7a409H?=
 =?us-ascii?Q?w+PpouHSHZyN+enVoVwPRvqTHzOIlA3KG66/z2ddUVPlzfejmyXYgg3VcUTd?=
 =?us-ascii?Q?uRpYdedNvDholFPW/iu34Lvu6L56QkHvvis4HpneN22deABfwBJ6ZL42J2ha?=
 =?us-ascii?Q?9/ZZFid001qOkoEu8ZC44s7f03vSUq1xvYiwHOMUPN86uMWB3OWQcZMHmrD3?=
 =?us-ascii?Q?90BDdfHSPHWhPvXBkbbEc1fQ1/9krr5rVm79DVftuLZEl0ZwRRVgxJYa6qAV?=
 =?us-ascii?Q?DD4DCtT7Lf6YUwpbVofztY1iQEA/KIHATKdNcuAbqTVD2IjT7+g/+jDji0DH?=
 =?us-ascii?Q?ZjUNb97osm0Jf+7xyMWfvPBtQOLjtNKyov9y47aPLoqcliGCA+AWfEIlUUED?=
 =?us-ascii?Q?GRp0kkfQHiz4RimutVp4YNMuNsSWd5naEyn/YhSFplravfibr44sfz8cBA7e?=
 =?us-ascii?Q?jS5CfYC177N8KbmmvpRotnh5S9qFi/RmCbYemKKFip5EU+lcnJgndU/oIWEc?=
 =?us-ascii?Q?t1qwNMvnzlNM5zdSiDLHKsw6JrlrTUSasNBSziAOLJD9Y5SzI98gS6eweaza?=
 =?us-ascii?Q?BXJDoEq/XWJUbco7FbECad/FO33UOs2KoaT220900SqePEtju5vqPydr8piD?=
 =?us-ascii?Q?HdGQHLLVlkXTJCd/4o5IppMxeNejO9pMIgm3Wz96r97Wkk15snAYRx/s/GZN?=
 =?us-ascii?Q?EvffABiSx2Sa4Vr7JkaKeR4Emmi9C/06quzA13ELijcp83piqUth+OzEzy5P?=
 =?us-ascii?Q?Z/0Yr4hoDQBg9KVqJWN7nk9E9caCZHX26C2mAvuArivRoWtro1vvtWeSn8H6?=
 =?us-ascii?Q?iPbKueYmgQTkIz6ZRz9VaPGEMNRJYQxGAGvXtoj0/i1hOdd1nMOEjuBJgSMg?=
 =?us-ascii?Q?B9zKGuO9FzET2U7gmfxG6bef9tEU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jiXXM+jEyXK2zoaRiapwmCgd5ljyOU9BAiWElu0FhU8SlpH1c96SxavmeSl8?=
 =?us-ascii?Q?dZowY54CWwqaS3ESMb+Py6byyvZ5fZM5NBjPLsb5pez/SWjvCGFJ1HuSLgAx?=
 =?us-ascii?Q?u1FZfpf7DlDnkC+FnQQSUiDxzCetRd1UU2Am1bEdDyU4vPLBX9PFQ4pic58H?=
 =?us-ascii?Q?BlGY9Rx/SqUwslKteEfXOOGn+HhFAqIQ4dPlLQc+qz1UYBoVYBZUp8kcfesU?=
 =?us-ascii?Q?ptyiNY4IkUUxuHot7khNlmwwP1kWhSYmKj6d7xoUrwgOQARFpxATqk5GQpIc?=
 =?us-ascii?Q?TuXowhbTBnuNMB3FnmoHxJ4ChHT6lHR/PqRr2ZoExmK6VLylic2ZJz8QjG8x?=
 =?us-ascii?Q?MTqC6aZU3NlY7WwpsQzwR8MIxt4635Moa2fL1HUCyOE98/HOxA7jI/XKJpG2?=
 =?us-ascii?Q?aybkYPS3YR/Gwo3IMwytNx1piRBnaN9+0JNdhdrgkEgpuWOBlEOtCpGqZvvQ?=
 =?us-ascii?Q?tdK0eMhronNmUO0DXcMzGAyEIqCZU8KYR3n8WdQVc29bV8R+E4Vzuhpb4MNR?=
 =?us-ascii?Q?i1dBhFoA9YicMRDUfbx8+BDmPSSS28soXEEhuH0yYBpkkrWY4uCRkx1jXC5P?=
 =?us-ascii?Q?VvmDERBy1zGFnO7Zj2qdW2evCUlFgRP3SV2VF+o1miv+SN8fVj159TVbnXrs?=
 =?us-ascii?Q?LzQ0pAKxXMEVsBQwJaMuU8NfYlFKoNnCj+tvetJVWmrch/IcQDMNyk7xn1dN?=
 =?us-ascii?Q?9U0PJ4HN8EDGPz/gvt/OYQnOWgiW8Okf/IMcCyngDZFBSCaEVm96TjD/aYne?=
 =?us-ascii?Q?gA6hUsUh+KAAtEuM/s6RmmdgqvbrHKC357TC8IRkMywRDH+L6rwC+Lb7nMKT?=
 =?us-ascii?Q?D7M7GcvT8XzkLCNKKgeg9E7sV6qD2K3NaUYZJbf/o3awweael9faFi4UOoiy?=
 =?us-ascii?Q?Jm2sIu7U8TLytSrAokOIvQ179KHwayY0nlLm+jsdD1M1AdXY6qluMqNvLQzG?=
 =?us-ascii?Q?fvVSASKC0w8hAj/Sr2EO+UiszyOjqPGq5T2NdtYWt0u4la1d3H7uEL3hmGXE?=
 =?us-ascii?Q?1xbb18lKhixcuqQ4LLapDsbL7R8iblxjYuiu+Rm5B+mn3/qNmepD1Gy9AuMO?=
 =?us-ascii?Q?lDYQMBStomNFUjJpq25ZtXJOc0iZJ7NPK8PwoF70YdX4gt9F+19oPnRD4Bo5?=
 =?us-ascii?Q?5LX+qh6HcSYcfcVXjFyLozfK9IeNtbSPHMu19+DDYpIAqHZnQcQVbXYztBTc?=
 =?us-ascii?Q?i3xUHZ1zTRFZbtqxfKRY912Fp97hRCp0bSYpuPquXZPLUc4sAb0KYxnOXySw?=
 =?us-ascii?Q?2GEehpF8jAG6KaHHBgc4G84tBCj61pzuvbP7uw68NnHGh3nZm4vB7RdEUNK0?=
 =?us-ascii?Q?KQPsOe00F/vQvN6CzKHCsyX18p7Y9N0pHLvvl5Xeky4x0oGoii5StRG2ypE7?=
 =?us-ascii?Q?yaFTfclFKUef9KrpAJ/ECx9wLqJh6qLVeA+QCeLZWQIwAiiHegJICNnbN2Ed?=
 =?us-ascii?Q?tHA70te89G+DpRUwntYn8tyslqGdNA5nGLmwAnbjEcFTVzgG7EJREa121fbn?=
 =?us-ascii?Q?FwSLShWMgFym8POCeHGHh0UGPVYspViTIz+1saK0s+RUBdpsGqAGTD7itbDM?=
 =?us-ascii?Q?U/zgOPm11VI7tP5aORbZS9/fBaZI2Zm3zf5MSAnj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ceabd10-d3ac-4720-28bc-08dd47bbfee2
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 21:11:31.8036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D2O/D5N4bEFyZpNO0e27k9kdxi2rGtCLTk2ZKT8jckrgAa6yxmXFO4Y2Kp0+niaDz+OokkHpQD3efGZgD8iLdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7380

Add the new scheduler flag SCX_OPS_BUILTIN_IDLE_PER_NODE, which allows
scx schedulers to select between using a global flat idle cpumask or
multiple per-node cpumasks.

This only introduces the flag and the mechanism to enable/disable this
feature without affecting any scheduling behavior.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c      | 21 +++++++++++++++++++--
 kernel/sched/ext_idle.c | 33 +++++++++++++++++++++++++--------
 kernel/sched/ext_idle.h |  6 ++++--
 3 files changed, 48 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 8a9a30895381a..0063a646124bc 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -125,6 +125,12 @@ enum scx_ops_flags {
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
@@ -134,6 +140,7 @@ enum scx_ops_flags {
 				  SCX_OPS_ENQ_LAST |
 				  SCX_OPS_ENQ_EXITING |
 				  SCX_OPS_SWITCH_PARTIAL |
+				  SCX_OPS_BUILTIN_IDLE_PER_NODE |
 				  SCX_OPS_HAS_CGROUP_WEIGHT,
 };
 
@@ -3344,7 +3351,7 @@ static void handle_hotplug(struct rq *rq, bool online)
 	atomic_long_inc(&scx_hotplug_seq);
 
 	if (scx_enabled())
-		scx_idle_update_selcpu_topology();
+		scx_idle_update_selcpu_topology(&scx_ops);
 
 	if (online && SCX_HAS_OP(cpu_online))
 		SCX_CALL_OP(SCX_KF_UNLOCKED, cpu_online, cpu);
@@ -5116,6 +5123,16 @@ static int validate_ops(const struct sched_ext_ops *ops)
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
 
@@ -5240,7 +5257,7 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 			static_branch_enable_cpuslocked(&scx_has_op[i]);
 
 	check_hotplug_seq(ops);
-	scx_idle_update_selcpu_topology();
+	scx_idle_update_selcpu_topology(ops);
 
 	cpus_read_unlock();
 
diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index cb981956005b4..a3f2b00903ac2 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -14,6 +14,9 @@
 /* Enable/disable built-in idle CPU selection policy */
 DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_enabled);
 
+/* Enable/disable per-node idle cpumasks */
+DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_per_node);
+
 #ifdef CONFIG_SMP
 #ifdef CONFIG_CPUMASK_OFFSTACK
 #define CL_ALIGNED_IF_ONSTACK
@@ -204,9 +207,9 @@ static bool llc_numa_mismatch(void)
  * CPU belongs to a single LLC domain, and that each LLC domain is entirely
  * contained within a single NUMA node.
  */
-void scx_idle_update_selcpu_topology(void)
+void scx_idle_update_selcpu_topology(struct sched_ext_ops *ops)
 {
-	bool enable_llc = false, enable_numa = false;
+	bool enable_llc = false, enable_numa = false, enable_idle_node = false;
 	unsigned int nr_cpus;
 	s32 cpu = cpumask_first(cpu_online_mask);
 
@@ -237,13 +240,21 @@ void scx_idle_update_selcpu_topology(void)
 	 * If all CPUs belong to the same NUMA node and the same LLC domain,
 	 * enabling both NUMA and LLC optimizations is unnecessary, as checking
 	 * for an idle CPU in the same domain twice is redundant.
+	 *
+	 * If SCX_OPS_BUILTIN_IDLE_PER_NODE is enabled ignore the NUMA
+	 * optimization, as we would naturally select idle CPUs within
+	 * specific NUMA nodes querying the corresponding per-node cpumask.
 	 */
-	nr_cpus = numa_weight(cpu);
-	if (nr_cpus > 0) {
-		if (nr_cpus < num_online_cpus() && llc_numa_mismatch())
-			enable_numa = true;
-		pr_debug("sched_ext: NUMA=%*pb weight=%u\n",
-			 cpumask_pr_args(numa_span(cpu)), numa_weight(cpu));
+	if (ops->flags & SCX_OPS_BUILTIN_IDLE_PER_NODE) {
+		enable_idle_node = true;
+	} else {
+		nr_cpus = numa_weight(cpu);
+		if (nr_cpus > 0) {
+			if (nr_cpus < num_online_cpus() && llc_numa_mismatch())
+				enable_numa = true;
+			pr_debug("sched_ext: NUMA=%*pb weight=%u\n",
+				 cpumask_pr_args(numa_span(cpu)), numa_weight(cpu));
+		}
 	}
 	rcu_read_unlock();
 
@@ -251,6 +262,8 @@ void scx_idle_update_selcpu_topology(void)
 		 str_enabled_disabled(enable_llc));
 	pr_debug("sched_ext: NUMA idle selection %s\n",
 		 str_enabled_disabled(enable_numa));
+	pr_debug("sched_ext: per-node idle cpumask %s\n",
+		 str_enabled_disabled(enable_idle_node));
 
 	if (enable_llc)
 		static_branch_enable_cpuslocked(&scx_selcpu_topo_llc);
@@ -260,6 +273,10 @@ void scx_idle_update_selcpu_topology(void)
 		static_branch_enable_cpuslocked(&scx_selcpu_topo_numa);
 	else
 		static_branch_disable_cpuslocked(&scx_selcpu_topo_numa);
+	if (enable_idle_node)
+		static_branch_enable_cpuslocked(&scx_builtin_idle_per_node);
+	else
+		static_branch_disable_cpuslocked(&scx_builtin_idle_per_node);
 }
 
 /*
diff --git a/kernel/sched/ext_idle.h b/kernel/sched/ext_idle.h
index 7a13a74815ba7..d005bd22c19a5 100644
--- a/kernel/sched/ext_idle.h
+++ b/kernel/sched/ext_idle.h
@@ -10,19 +10,21 @@
 #ifndef _KERNEL_SCHED_EXT_IDLE_H
 #define _KERNEL_SCHED_EXT_IDLE_H
 
+struct sched_ext_ops;
+
 extern struct static_key_false scx_builtin_idle_enabled;
 
 #ifdef CONFIG_SMP
 extern struct static_key_false scx_selcpu_topo_llc;
 extern struct static_key_false scx_selcpu_topo_numa;
 
-void scx_idle_update_selcpu_topology(void);
+void scx_idle_update_selcpu_topology(struct sched_ext_ops *ops);
 void scx_idle_reset_masks(void);
 void scx_idle_init_masks(void);
 bool scx_idle_test_and_clear_cpu(int cpu);
 s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags);
 #else /* !CONFIG_SMP */
-static inline void scx_idle_update_selcpu_topology(void) {}
+static inline void scx_idle_update_selcpu_topology(struct sched_ext_ops *ops) {}
 static inline void scx_idle_reset_masks(void) {}
 static inline void scx_idle_init_masks(void) {}
 static inline bool scx_idle_test_and_clear_cpu(int cpu) { return false; }
-- 
2.48.1


