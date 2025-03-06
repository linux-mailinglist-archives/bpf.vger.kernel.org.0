Return-Path: <bpf+bounces-53500-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8320A554F1
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 19:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D0C5168389
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 18:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D365D2702C5;
	Thu,  6 Mar 2025 18:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VHRMIoGK"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67A726BDA7;
	Thu,  6 Mar 2025 18:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741285595; cv=fail; b=epVxrygaVn+5vR4R+fOKAXoZGeX8hQ6eGDJbN+RbLEnAyteqqRsbPhr49KwsBYj4bn1ctPBwOiD+Verl650Mc6RhvLZpz7o4YpAb8jcjCV0insjJEfo+rIsebxZcX8CgTnJwWqEb5HJ2xqlj2aVw62Wwq0aPjx9svqZi10WpZuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741285595; c=relaxed/simple;
	bh=BioiH9L8yiZe80+SVwtfdeHcg1jDUlPJy+CnZFNmTvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kmIOMtWhE9XZgKgiFVQenDwTwDZ+LrumqaHLuKj51hB+FmFGWHlf2iY6R4LjQKGHpRC39qu6PWzjgbq4c4cOguCkgdzHBEJOhr937/RLvHAZZefTv/Tg+ceqlONtnjDRJOAvebThkL8YG30VDR4+Ly+bSCkuRcf4dnYWo773VUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VHRMIoGK; arc=fail smtp.client-ip=40.107.92.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nt+l/xNNu4LO8ruh36aCK9nCSKz4EIkAw3oh40cTniWYLhYRu233mcS1d5hzhSpS6j/QRbXP74dre5dk0/F2v29wzItPdIquaQITnuz46F5jNVVFYZRrPPGmfqkU4npgWd8BIkXtH1ZglamqoMjGhXlVvrnkwYuPdygvTMYsP5efmYLWQJa/CGTMv8+xoqCcDJGFOfml3bRUPK/jiug1/FxoM8c1mQ+CBasnVR9IiVo5OXeJL23D07aw7C6T5Hqy+Vj5OpVPjukVjjBZgK7xrhnkbokpMliYUlKuAwjf5g+VxbyXvNjw0iGPaT1lNlhVGnhparUGYyWs8+2Fjiz1SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wKPOJJ1UpCtTPyDJ6Gb8lQIZecTV0FM0Fj1RojlCeb0=;
 b=xgwjElpgNZ+6NTS+k8zcilzNuBR9YuHD+gBckjj3g8MisWR8oDy2v11UTSk6247NMc6yVsLPn7i6YoQq+h0yYdPTeyZ9cUC/NOEfy/jkM4RJaeIRlC1bBBKd2xZ3QrhzpXJxOOli0TjjS6C4u3C1CR7pEXbo2zXW2YsSeAXDA8lNLm2nYrnylEMvBh57x4q+kC0ubpnGQWRUaXw3aAhWu0hX0t8D1Xn2GjE7mnVU2M2RpmiPrALMry6VfJhqTIrvXKnKKdSEpSrzXyIQRUvLZHjAoYSloM+LmEw1en4sLl8G5qynvwHwBp2XD1jOMm/nPVkLdNBEtFjgQC1T3DmcqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wKPOJJ1UpCtTPyDJ6Gb8lQIZecTV0FM0Fj1RojlCeb0=;
 b=VHRMIoGKZ/yLFifuj8HD4f3ktwI4Fkx7bW4lXRpYqKJx/SkVp0bZi/AQXULWDVKght1HgwE9tCu7F7JpOnfsVxfNulR/kawF6ZizukafpLF4u0kYeTZlwflquurtZkk+sT5AHFU5vuVbuf+mE05xSMUUjnRVGiuf6IvdLOWyhXj4LM5uVU4mN66aH50bsfqM/6xDi4ZzhKY7iI5+BtqQcQ6gq0qNkUz5b9mB9XygEdzYJPlmXKEM3KBA002gEztLLFxhKWz9CLkrwFa9oBEg2qp9jjOe+7LfONAQ6RB5o4DrVvPNd5QhrIKSYEPFREKByzhm+uh+U6LJaf8u0JMMbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by CYYPR12MB8921.namprd12.prod.outlook.com (2603:10b6:930:c7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.20; Thu, 6 Mar
 2025 18:26:31 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 18:26:31 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] selftests/sched_ext: Add test for scx_bpf_select_cpu_pref()
Date: Thu,  6 Mar 2025 19:18:07 +0100
Message-ID: <20250306182544.128649-5-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250306182544.128649-1-arighi@nvidia.com>
References: <20250306182544.128649-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0014.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::13) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|CYYPR12MB8921:EE_
X-MS-Office365-Filtering-Correlation-Id: b2aa4c6d-4f68-4244-1292-08dd5cdc6a95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A7UKsaNlMbyaAJROQYFC+mgcjk5fJQG8OpW/zSNvLv8QILcktYcM0RXJTdn0?=
 =?us-ascii?Q?oJkaMdIuRousthcfC+FE+UeFF0bIDSIDtfLp9rCloLHxQLymv1uMOM9SsYUW?=
 =?us-ascii?Q?BYBTajn5VYWOf0ZV+KRWHIWpCq34sySxQFnLRfX2ztAUwPVJoSsJ0citXxB6?=
 =?us-ascii?Q?75N9tL5nVEETkEZSJnknvB61NyHOacNhjRV8Ldbm4abLn1rd4GQdovj7jP5m?=
 =?us-ascii?Q?fyYO8z//hIAlHtnmTy4sq3Usnpu+OCXduFf6c7WUUQFmShyeLHwExHDL2R4y?=
 =?us-ascii?Q?mwQkUpsvsDc5oausAn6KAws+Xfk/xjdOPW6ozdMrjjXFYswSvsyV5iuC1iei?=
 =?us-ascii?Q?ih8eVo7UbfwvHUSt57dukOpECj2xHOt24UCGADXvehGHCZsRAooXafSTUqEJ?=
 =?us-ascii?Q?t7sDlecfjKUtb9F69KHq6E5hfQuOIWu40ypVRdORSQlkEiA8BLGaetBofx/R?=
 =?us-ascii?Q?Oul3yJsSoFHPpBr9AjnaESZUbpyAWxhOAvOtED47sISUGj9JfSQ6z8YpwZQ4?=
 =?us-ascii?Q?4ysxKvrPKngLNKrHaIm2Gm6+5C/xNtJKaxlFbrYP1tcMFq/zY3gG3vArbh01?=
 =?us-ascii?Q?yzhNqACg8HpRuponjjK4EDznh3sng9/DbEHzZtLdyTqpSB8kjO6jS59H17sC?=
 =?us-ascii?Q?yl4oHnD7A1UOKBvzYYZYQYsyvUAzvsQqNg8t1TEMK5NuKYN0Nse0XmhS6418?=
 =?us-ascii?Q?UUhoksskZ4HdTx9Xowz56+LXX+amUYQ5TkDDlkTBc4YFeu8slT2J8y0cjDEP?=
 =?us-ascii?Q?Qq4qAboyfYHa7dOEsrbDJDd8u/pgvb9IvWH4zY/w2nzppXwGrMqdHkbKOppZ?=
 =?us-ascii?Q?krrQGywYH+w2glxVo1HNhcPfQelnAaAUTJf6GmsBAQLdTr9h/3NBKVtB2HXl?=
 =?us-ascii?Q?L4H9eUHoRwf95rzYSYVVyoVREPUJ7+i+1B2cg3kmqzN197qUh//ih22gGQXj?=
 =?us-ascii?Q?jd9h1VC45i3jhTFcgSEjO09/DtLZ8egmCzeFcqGYHk8DWHa/GKmkhTLnqYD5?=
 =?us-ascii?Q?Bab3fywL1R/Pr8bVwTu5bwAH+cXJncN/SBjL42s0JRXV1QRZsT7fLelOiuGH?=
 =?us-ascii?Q?CIC+sw+oolnH/sizJplt2Esvtmb3DQDxffDoJbHcWsbneK1YqJo6tsFJV3DD?=
 =?us-ascii?Q?fFhOx85axLj2ORq3kSrQJK0ZE70xwenc6GVqhhdsTzaJregncOqkEgGCP7jI?=
 =?us-ascii?Q?tbTYLmmQFHaxGErE2Ibux30k97+SLwVBGxeO5sC5rj1LpdOUutvUv1Gf8Z01?=
 =?us-ascii?Q?QoWHgnuLw8pP3ic7HPxKcA6pNUzYKNtcjYATdaSqZd3JkbQyNqrzy9o/WdC2?=
 =?us-ascii?Q?vS2+XhWKa7nkuWr8UvDH/IX85OMJFuSqi2JTDHQtn3YoXmOK317B7MM7fO7V?=
 =?us-ascii?Q?opWB7YV29fzw6TLb1w6taFKTi3Jx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zzR6vHs00r9tMItQJF2DbyXFxtjdBFhrio0Q4ul9WWRne3EHNI2wSUx8Prln?=
 =?us-ascii?Q?sCbUSLdvsintdVwq2IKdIPqRFh/5P/6SS9FvFApBMaXwMwkeJpoRad8ftmFV?=
 =?us-ascii?Q?+wzjXbSy6OD7BaGsaNIrxoJO9J3p7FLKfQLgPflNkppTA3n/vt/q6iGizlTQ?=
 =?us-ascii?Q?7SuDdR/FjyDZjeEiwHQA733+uxZ5tKZiVCM3vOahP44HwQDyqyvv8uQYRzlt?=
 =?us-ascii?Q?kFimPix6vn/1Uh889XI+WnhaXk522Z/FReA+diuTa3fDnMPW9+dZgxmgPS8Q?=
 =?us-ascii?Q?JmwD2ZmXY1+01F30C2vu6qpef4VsLUtl5MPty80mr135s/t1KMrqQrGvwfAj?=
 =?us-ascii?Q?p/isxDDxrCRLkmdVd21Z58RPVLIwL0WHwP0QTTF/SmuChWzwvrOzPeIM6N8B?=
 =?us-ascii?Q?xQDfffgz9SSOODAjhbIRq5i10bzltLCSlQzZ4FIpyCruJrAJ3Q5nkzWPMwMC?=
 =?us-ascii?Q?c7xT3Ts00k60QqVWOz0jzPCwegGB4LzeMK6Vju0nL1vZ/VQD7jeUOf3bAGcA?=
 =?us-ascii?Q?kLsxXBM5PzDAR/H2aG4LbeoWK58bC5Fgd/3VVfN+sRSq7xR4MEcgraHIWuEG?=
 =?us-ascii?Q?ixdODEJzXdq999Mjes/kjVEmDKhbY48fKdQwKdzxqv1dtN45GtazbN7VyszY?=
 =?us-ascii?Q?bj8r08DAFf1gvgAKw1a2s4Gto8SJYERHAjYBNrqzBY1Pc5Sw7Ok/kxrb8oK6?=
 =?us-ascii?Q?xx1BFIsHkZz3O/Ixm34Bg/Pytl1vs/FAhRbzuBe/QpFOw0PEJwAFMZOx9krI?=
 =?us-ascii?Q?Bdv6ulc3OCZ9HrtZaKR2FsC3PVuORWVkM5uQdlYySl+FXFY6yf8r6YSTiVZz?=
 =?us-ascii?Q?4DqMs3R/3cSmPbQwEr5Kh6ZM38wL5+th5NpGZ2kxswL4pI3skp0FbRRwmDmz?=
 =?us-ascii?Q?ybwxhUZo6omrNWRtgJZIjD+XxdcUoHsYaV+BVksj2QOhJGHxosR/36MIf1mq?=
 =?us-ascii?Q?GCIlM95ljrGjyNVX5AB7cZSmm62kJ90hPtTTF5AR93n930DTjXaMFH8M20aU?=
 =?us-ascii?Q?l1OHuaOxg7efZwEn4XkXpi8q2nZxZ80UEKbnkZi4TKC/m/cGAFIMGUqFpCkI?=
 =?us-ascii?Q?D06XfSB5wwtycpNcim6ecJv0L3logCeOMTdz11iTC0gD0D5B9SPNMrIH6vei?=
 =?us-ascii?Q?xEToIo+QvaJKup9FIWxsZy33ASnXZMUH13y6SFaviE17YC/Yv7HCDF6ood/l?=
 =?us-ascii?Q?DyiYTO+51dKGmmd1TzKHxPe4ZrVAJ0jISuwtZtufJms0C/ueYubP71qLgZ2Q?=
 =?us-ascii?Q?el+sEPKOEKKbjNh07ijBFCLn7pvhrPTBBwQIJxQQkfrCC8FC2aJs2FW357xE?=
 =?us-ascii?Q?Lok8nnByMM85e0pDIYSwFZzRy2CpcbnOtGxq/BbMMUMNNCARHy2QosW633rC?=
 =?us-ascii?Q?ez77Zj76z87PveAs0BG1iBrP98V4ZENUYyv7Ge1pVGynQJbredLZBauENGlT?=
 =?us-ascii?Q?2l8K8eHwbrHwlkXqlMcLNNO9U7iuTJt5lgYYsyIST4nMa5EdCCZPq733JMZ7?=
 =?us-ascii?Q?pxBOKPSuCF/jVFkSytHm4NMjNT6gpSAGnSQdBIrHbLO+5TUhUAV0P+oJsssr?=
 =?us-ascii?Q?qXmE4G182/XwZ//ACQ46mIs6+B6vyAMhk1Ra/Urs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2aa4c6d-4f68-4244-1292-08dd5cdc6a95
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 18:26:31.0133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j3wcdqRuzOJ5M1fThVnjSGwpW27xPqcMTY5mj0kwPEChe7/FMYYSzR9pAAOawTu8E2gwTBf4MLwnz09QOSovIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8921

Add a selftest to validate the behavior of the built-in idle CPU
selection policy with preferred CPUs, using scx_bpf_select_cpu_pref().

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 tools/testing/selftests/sched_ext/Makefile    |  1 +
 .../selftests/sched_ext/pref_cpus.bpf.c       | 95 +++++++++++++++++++
 tools/testing/selftests/sched_ext/pref_cpus.c | 58 +++++++++++
 3 files changed, 154 insertions(+)
 create mode 100644 tools/testing/selftests/sched_ext/pref_cpus.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/pref_cpus.c

diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/selftests/sched_ext/Makefile
index f4531327b8e76..44fd180111389 100644
--- a/tools/testing/selftests/sched_ext/Makefile
+++ b/tools/testing/selftests/sched_ext/Makefile
@@ -173,6 +173,7 @@ auto-test-targets :=			\
 	maybe_null			\
 	minimal				\
 	numa				\
+	pref_cpus			\
 	prog_run			\
 	reload_loop			\
 	select_cpu_dfl			\
diff --git a/tools/testing/selftests/sched_ext/pref_cpus.bpf.c b/tools/testing/selftests/sched_ext/pref_cpus.bpf.c
new file mode 100644
index 0000000000000..460f5a54f9749
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/pref_cpus.bpf.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A scheduler that validates the behavior of scx_bpf_select_cpu_pref() by
+ * selecting idle CPUs strictly within a subset of preferred CPUs.
+ *
+ * Copyright (c) 2025 Andrea Righi <arighi@nvidia.com>
+ */
+
+#include <scx/common.bpf.h>
+
+char _license[] SEC("license") = "GPL";
+
+UEI_DEFINE(uei);
+
+const volatile unsigned int __COMPAT_SCX_PICK_IDLE_IN_PREF;
+
+private(PREF_CPUS) struct bpf_cpumask __kptr * preferred_cpumask;
+
+s32 BPF_STRUCT_OPS(pref_cpus_select_cpu,
+		   struct task_struct *p, s32 prev_cpu, u64 wake_flags)
+{
+	const struct cpumask *preferred;
+	s32 cpu;
+
+	preferred = cast_mask(preferred_cpumask);
+	if (!preferred) {
+		scx_bpf_error("preferred domain not initialized");
+		return -EINVAL;
+	}
+
+	/*
+	 * Select an idle CPU strictly within the preferred domain.
+	 */
+	cpu = scx_bpf_select_cpu_pref(p, preferred, prev_cpu, wake_flags,
+				      __COMPAT_SCX_PICK_IDLE_IN_PREF);
+	if (cpu >= 0) {
+		if (scx_bpf_test_and_clear_cpu_idle(cpu))
+			scx_bpf_error("CPU %d should be marked as busy", cpu);
+
+		if (__COMPAT_SCX_PICK_IDLE_IN_PREF &&
+		    bpf_cpumask_subset(preferred, p->cpus_ptr) &&
+		    !bpf_cpumask_test_cpu(cpu, preferred))
+			scx_bpf_error("CPU %d not in the preferred domain for %d (%s)",
+				      cpu, p->pid, p->comm);
+
+		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL, 0);
+
+		return cpu;
+	}
+
+	return prev_cpu;
+}
+
+s32 BPF_STRUCT_OPS_SLEEPABLE(pref_cpus_init)
+{
+	struct bpf_cpumask *mask;
+
+	mask = bpf_cpumask_create();
+	if (!mask)
+		return -ENOMEM;
+
+	mask = bpf_kptr_xchg(&preferred_cpumask, mask);
+	if (mask)
+		bpf_cpumask_release(mask);
+
+	bpf_rcu_read_lock();
+
+	/*
+	 * Assign the first online CPU to the preferred domain.
+	 */
+	mask = preferred_cpumask;
+	if (mask) {
+		const struct cpumask *online = scx_bpf_get_online_cpumask();
+
+		bpf_cpumask_set_cpu(bpf_cpumask_first(online), mask);
+		scx_bpf_put_cpumask(online);
+	}
+
+	bpf_rcu_read_unlock();
+
+	return 0;
+}
+
+void BPF_STRUCT_OPS(pref_cpus_exit, struct scx_exit_info *ei)
+{
+	UEI_RECORD(uei, ei);
+}
+
+SEC(".struct_ops.link")
+struct sched_ext_ops pref_cpus_ops = {
+	.select_cpu		= (void *)pref_cpus_select_cpu,
+	.init			= (void *)pref_cpus_init,
+	.exit			= (void *)pref_cpus_exit,
+	.name			= "pref_cpus",
+};
diff --git a/tools/testing/selftests/sched_ext/pref_cpus.c b/tools/testing/selftests/sched_ext/pref_cpus.c
new file mode 100644
index 0000000000000..75a09a355e1db
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/pref_cpus.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Andrea Righi <arighi@nvidia.com>
+ */
+#include <bpf/bpf.h>
+#include <scx/common.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include "pref_cpus.bpf.skel.h"
+#include "scx_test.h"
+
+static enum scx_test_status setup(void **ctx)
+{
+	struct pref_cpus *skel;
+
+	skel = pref_cpus__open();
+	SCX_FAIL_IF(!skel, "Failed to open");
+	SCX_ENUM_INIT(skel);
+	skel->rodata->__COMPAT_SCX_PICK_IDLE_IN_PREF = SCX_PICK_IDLE_IN_PREF;
+	SCX_FAIL_IF(pref_cpus__load(skel), "Failed to load skel");
+
+	*ctx = skel;
+
+	return SCX_TEST_PASS;
+}
+
+static enum scx_test_status run(void *ctx)
+{
+	struct pref_cpus *skel = ctx;
+	struct bpf_link *link;
+
+	link = bpf_map__attach_struct_ops(skel->maps.pref_cpus_ops);
+	SCX_FAIL_IF(!link, "Failed to attach scheduler");
+
+	/* Just sleeping is fine, plenty of scheduling events happening */
+	sleep(1);
+
+	SCX_EQ(skel->data->uei.kind, EXIT_KIND(SCX_EXIT_NONE));
+	bpf_link__destroy(link);
+
+	return SCX_TEST_PASS;
+}
+
+static void cleanup(void *ctx)
+{
+	struct pref_cpus *skel = ctx;
+
+	pref_cpus__destroy(skel);
+}
+
+struct scx_test pref_cpus = {
+	.name = "pref_cpus",
+	.description = "Verify scx_bpf_select_cpu_pref()",
+	.setup = setup,
+	.run = run,
+	.cleanup = cleanup,
+};
+REGISTER_SCX_TEST(&pref_cpus)
-- 
2.48.1


