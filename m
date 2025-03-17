Return-Path: <bpf+bounces-54229-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF811A65BC2
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 19:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D33A43BE7E8
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 17:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F023E1E1E10;
	Mon, 17 Mar 2025 17:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L6t+Z9zL"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FDA1DE3CB;
	Mon, 17 Mar 2025 17:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742234300; cv=fail; b=AWqioHT3ucfBNhrTPPdYauuzSJf3bzCtXIzm9eOVGpFgRy7ZtIvRNHwYboKO0KamI4BoMmH+AULPPGTorBVhcz2eB0Gm6Kj4Zt34u+gyXUCXXMtiE/YSwoiAQRrtVt+RKJNNWSRE2xf2i18lIn1b/6mMhe2CcZX+62K+vVVxFi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742234300; c=relaxed/simple;
	bh=jKTxoAxrXvpBn7lWujg+NdqWN89RZk8i/am7nybMWNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XT4+QDHV/Ffvb+14NCLxGg1WMjt1TJEQPSZKCRlnyLBzugOt+zhK2lylAqPXQDV8IW15nAC51IpJvOJ6HnMutQA6nZ6U0+Ksl2aiIYAZC2SmTJWygN6k8DBxi6LL1FexrKAIBOUemC+X/zHq/omIfgsjP8nBOh02IxC9cELP5PQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=L6t+Z9zL; arc=fail smtp.client-ip=40.107.92.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N0Gh5VDrf7o4mX7d+ShlN3HHYujrk2Mjg/DNM6R1E4MB/rn0sRkzNvSRh2Vg3kSxp8t7BI5WtcRJn5R70vijE/kFWR8C4Gfpha6tCQzb1Dltcr/oKQM5n+H9Xnau5N93FUcNRRkaubWNwBUnZbTjRk1V6AuyxrLkjWa+Qv3EbsajQ5oGpC1O/Zy7kc7W9XpBR+d30D7RXMQ9JhcmePqp2loU7PP9GtjsFwyee2+keYUcwiGji2e7xNeDrAlpetTkj3xjpCbXTm2RCHuAGWX6a6xxCXRk66NIEXumpjl+0L+A3V/iuNJOweKmDcpwc+2oucp6eS9Av8S8T7tryhJdrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tz0xGZ8Vq/x5hanX4aF/qX4QQdX3n+4+blVCZDmYCeE=;
 b=pZ+8+88WAat1z+7wfUtSUiXm7gHJ2rl3bgwWbJ/CxVBqLK1Ueyzik3Dr1zlliOgj7op8MevYkEFMM/7UH0DtKVX/cUaFYDGErtaeQjKJYHxLCi/am+q+GGx9K+7SLeCXC0lC/d4FLNFwtg2p0eDj2an4vdrxG2lTyMhDGW/N3lB6EaWuTuXaCwoKCEVfjjg541XQSe7P6y9yusirMWhR2syWTVY773PsPUsFyaaxMCYDnRD5SGe+bKFDf5X8GWYeeX/KqXfVGppyeDtKPenjQj8L0JwRlxtugtRgEh6VAvwIppnhnPEHyCWMl2in2fk14oqpkaXgiyec3eSTbizi3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tz0xGZ8Vq/x5hanX4aF/qX4QQdX3n+4+blVCZDmYCeE=;
 b=L6t+Z9zLZYEk2AFKzjxCBs1CR6depbQ5bJWhgGdVf0M3th9TPs9EeUVSpdZYXaaTkuzQW9ORGTtJFOXIuFFOOpU7VYCyesOvKN8TMLfnziLXYV9B216gVQtQdJS7EW6ME6jNLHDihbmyFXvwEGzAhhacLmozRqI3CJwHK14YOcqkyzoDgoYjDkCKddxj5sJ2ZoJSohOBGbhrnG7eYSp5Q971xONa2TPH1y8aWUobuI73y/i1n8CyxBeBN4KKHI1dqdiL48zdmfEHTCd/FHBL0LgSTyZRR2vVHMHpr52HF313ZW6QH0/0l+iXO6+lrpjv8Oj7tsFGt/hroyCWqu/v5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by MW4PR12MB6826.namprd12.prod.outlook.com (2603:10b6:303:20c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Mon, 17 Mar
 2025 17:58:15 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 17:58:15 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] selftests/sched_ext: Add test for scx_bpf_select_cpu_and()
Date: Mon, 17 Mar 2025 18:53:28 +0100
Message-ID: <20250317175717.163267-6-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250317175717.163267-1-arighi@nvidia.com>
References: <20250317175717.163267-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0230.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::25) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|MW4PR12MB6826:EE_
X-MS-Office365-Filtering-Correlation-Id: 5759792d-9e55-4da8-ea9c-08dd657d4aba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TcF+9suC3BYxAKrTnxH0ai8XfKXbyEw96uDZMHhSE7K2b027pjMVaItTKIoL?=
 =?us-ascii?Q?UljEBNIc70hVS7+E00k+seNAmcJ9uEEn8C16H+10WPJKKRdREuzkYOkcHet5?=
 =?us-ascii?Q?SXoSBLJzqXT/uv7GYuUH8B6H4FLb69gWCdP2k/fhb2nIHrbuVOXyQr01bWa8?=
 =?us-ascii?Q?c7ubcRtVzwqydNfnzBeDtT1y3u1xtq6OCAm9FzNoUy/9woGYmMXnrGMojlNt?=
 =?us-ascii?Q?K5CpPMdP4jAAPYE8v3vBPDlnFW6hwoHxRiufVfodTZEakdw+5G4Bz7YTNuKV?=
 =?us-ascii?Q?qaqnBzQP1jgeXwVFfd7jN6J/26VgSfdMUPUACh3cZycMAJ3kXMU7wFvWRhyk?=
 =?us-ascii?Q?nAGDtZY0ArQi/p0lTZC4PT1tLohPpK0LCYrpApcwxNE/0iCn1wYAqQgaXSwF?=
 =?us-ascii?Q?JoNOI4CPwJbIQiyQdz85AGUWIzBocQyx76AaCvWxc6+bI+uFMVvmG80UgD+L?=
 =?us-ascii?Q?Gj89AN7aBujqP3puQHPfYOkVg5/9mWQNI4AI+XgZbvJ7Z38rL4Z9ShSTdL6t?=
 =?us-ascii?Q?xvBX6YGfFUlPeBllvN+8Mbg4ghDKYTCD9r/XE1zSL/wJyZbiGCswVJekzeqG?=
 =?us-ascii?Q?hKLK52aptafNf20SpIs4njwnT1EEWASH7P/a8s48BA67sUowiwB6xUEK9QcT?=
 =?us-ascii?Q?d0hZSsKjWMhs9UhPbrK4BhZbocd2YP51RDa9mFAQOLFyXj8+vpTxxGShnclZ?=
 =?us-ascii?Q?wSr/G9xaB4G4v+s0NVlv8mIytdhE4Y8zuEtNkXdRmjsIyptMOMmNw1tDIkEp?=
 =?us-ascii?Q?vMIH/2QEadpyw+AMdDG8D9oQ4REMia9WkvdMUrTWtOt6QTqiaFCL1B/8+QNF?=
 =?us-ascii?Q?l2+JACrYonHykaaJdch/tLh2FrDdXCg1dSZjkrG4p4aps+cDr7pgSyyGlDm+?=
 =?us-ascii?Q?DrpoWb4TevBwmZl3S6DjAXmGRo9fXKQItRCdq7jzs1lm8HArhFtwaLtgHn8v?=
 =?us-ascii?Q?zw1G+4FVpi1rvOe3Nc1AoLBR7ZlGw8khqEyZ+Mj1kfTWC2Reqt1kMB/so1EN?=
 =?us-ascii?Q?ZLYBWszBiemwsvk9UdQTbY115J4uvq6/X4M+cJVaCpRzKp9d+Vj6QQv+f8+y?=
 =?us-ascii?Q?LRYT5e/1s8QaUDEdbeYSEFI/80xWYZ2AptBpeBLQ9vHDpnoaCY2c53V/C9rg?=
 =?us-ascii?Q?8kVbMc8Yv7H3DP6zTOnnJMMe25/sOcWNd7hHrOMm6AQeqapnukANwrmzC5L4?=
 =?us-ascii?Q?P74FMAawVbvFFGel+WJWuqeyTJpLQyNuUnI10c4aHGt5k7zXrmletJOmKRMq?=
 =?us-ascii?Q?grc8NOrIbIuo3I/xX2sM/Q87jcK06cWF+ZjkpXZjSK2jcA2DiCqAfvW5isJ8?=
 =?us-ascii?Q?IMHjIFX1z3EdCnyyxkv1FFMzvNrZGYOE+rK1UYQjSUlOEbRc9riCM+lBYCGK?=
 =?us-ascii?Q?UTP3yDDNuFOfqrOachkkNz4Nia52?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GYpEu2682+lqkHnZB0IvGwiBUWBNY4Ht3s6RtY7VmzOIyCcgcW8IlYLu/uFQ?=
 =?us-ascii?Q?SYKgrmSRxsKLhSCOI9jd/b5pe6KxfNJYViX5pJTR8HAJBeA0aRyr2T3Oith+?=
 =?us-ascii?Q?bIYo7btVjZkqoeOAfz/7kw9Fn8Ns7CE06wSVe9TfxB7R7+VaLn6a2v1iJzM/?=
 =?us-ascii?Q?jP6m+Lcu33daAAVUaWg/Nk0y9iek671MuuzrSNx+vqO6wyntN5o6zU010kXR?=
 =?us-ascii?Q?h84NFnebdIvKY/jelZSudqjxiDYp29m1t9w2Qbn2jjsv6pLioZoMbrrgRJ4y?=
 =?us-ascii?Q?eHWSzhKSUOKOTaJg5zOVZ8ZV1Gfo/tS5VfYr3yFkoaxJ0lxoum6nvsXdVo0f?=
 =?us-ascii?Q?6IhEhrwqCMiRKsAApNxbp61maSZVjz9PmcDKCDeojTKFWxsshwDdIIsBzJLr?=
 =?us-ascii?Q?UjN+q5xneUmGuQQ+e6PdFaneIIjvVCCK8XiYIxhH77zF3cZvHWkl3/uqC8r7?=
 =?us-ascii?Q?5SZoADklY1WqqYuE1fn0CTgYUgs9gi0K1gfalWwtPTUzqVFz8yPo+KXr+X/M?=
 =?us-ascii?Q?9oNeA9ezXnaucsukckGnjDSPdzSeaSY901+miGO+goBI+PM/oKLSzHaDpJN4?=
 =?us-ascii?Q?TmdOXrbpj/RDc+odDfTZ0eWXi2EyAa35z6VmkABpzlbNczQAzRvmgVZ0qNvB?=
 =?us-ascii?Q?NvNI61wEf8Cr1Bsa9nb6gYwKg9M42knIylNIoOoumIGLDg25782MeSLvGgh0?=
 =?us-ascii?Q?Ytfqtmy1T6A4jmeMDgv7eaJA/j7vtXPUeVv+wLWAJUJr7ZnbA2CFTq+YVHZ2?=
 =?us-ascii?Q?KUhXyLrD9cbfYUAae9LRJH9pnGjRvl8uW47ubNWHh3EeiuG4mrQZbWvsXsma?=
 =?us-ascii?Q?z1d+GRRrQ2H2Vwj3R35U+Mup0AeheimTt866p4JT6bT0ioQ9UOkYoTS7EVQK?=
 =?us-ascii?Q?SKzEWezLA7uOBlACUF6HTc5Zy9vRrZi0x6QO/cmaz4H6Ai7XKuzfVOu634nX?=
 =?us-ascii?Q?YT6lAxnsZw+brdO/EW6JbS0KrjRVo7+wLy0v79DTqx2cfTzOK3tkjoA61jwN?=
 =?us-ascii?Q?0lH53TRBOeJBw+3qhw7FWNh2vZfZCptFiADvsSa+Dzo3XwuyZ2B91/s08J4e?=
 =?us-ascii?Q?MAG48pwa0TPnXd8XNVX7ffi0WSicMTsljB+1FuttccnZEBTxCGunKtVLkbm4?=
 =?us-ascii?Q?cscskrYKND5EcSXTpOteD0y+Kzx2u1wgtZbt503p0olsfMpVVjPKvqmJ7Y3C?=
 =?us-ascii?Q?dFJh6OmAimVXr5ichvFBe+6jOt/9A1ZcO9mOLY85YgqP4IZZqonXfSXfQ9kG?=
 =?us-ascii?Q?RR6pLdsBi6ONXv3POlMo0vZj5YRrjEiy6NkPLfvG4RPDaEKEXUKLsoul3doj?=
 =?us-ascii?Q?04QuZeDXruvG16S60hoVIyCNEeuqAJYEhgVlvYT/d62+/pVelZReRL+UOKUM?=
 =?us-ascii?Q?CUeMnSfM/NztfNU0UDmYo3umA6yVtxmKF6EnRf2bkgNZoVC2fwoCzQVgn5zm?=
 =?us-ascii?Q?qUjm4nSlc6+DkivdKC6UctNtajCRZCXccQXee9DGhgynD+sVOx+LfpAgzDQT?=
 =?us-ascii?Q?UkM4PfBSE0Y+BpOSre/mlBwW2V+UX2MRRGwD5Yb/h8odET/DCmlSR+6sTDEn?=
 =?us-ascii?Q?Wb27mNtXqzSG3/cQjof+jcijr0thbXlcZP9lSXPS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5759792d-9e55-4da8-ea9c-08dd657d4aba
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 17:58:15.6664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R4XgnTOjGyBw1Kqg/xKoFQTfSXOEKnaWvH4Th3yS47ZjiW6q3d3YyKVOXIrc9c4zNEyaJ1zpFeKS1iyEtZvlyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6826

Add a selftest to validate the behavior of the built-in idle CPU
selection policy applied to a subset of allowed CPUs, using
scx_bpf_select_cpu_and().

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 tools/testing/selftests/sched_ext/Makefile    |   1 +
 .../selftests/sched_ext/allowed_cpus.bpf.c    | 121 ++++++++++++++++++
 .../selftests/sched_ext/allowed_cpus.c        |  57 +++++++++
 3 files changed, 179 insertions(+)
 create mode 100644 tools/testing/selftests/sched_ext/allowed_cpus.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/allowed_cpus.c

diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/selftests/sched_ext/Makefile
index f4531327b8e76..e9d5bc575f806 100644
--- a/tools/testing/selftests/sched_ext/Makefile
+++ b/tools/testing/selftests/sched_ext/Makefile
@@ -173,6 +173,7 @@ auto-test-targets :=			\
 	maybe_null			\
 	minimal				\
 	numa				\
+	allowed_cpus			\
 	prog_run			\
 	reload_loop			\
 	select_cpu_dfl			\
diff --git a/tools/testing/selftests/sched_ext/allowed_cpus.bpf.c b/tools/testing/selftests/sched_ext/allowed_cpus.bpf.c
new file mode 100644
index 0000000000000..39d57f7f74099
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/allowed_cpus.bpf.c
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A scheduler that validates the behavior of scx_bpf_select_cpu_and() by
+ * selecting idle CPUs strictly within a subset of allowed CPUs.
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
+private(PREF_CPUS) struct bpf_cpumask __kptr * allowed_cpumask;
+
+static void
+validate_idle_cpu(const struct task_struct *p, const struct cpumask *allowed, s32 cpu)
+{
+	if (scx_bpf_test_and_clear_cpu_idle(cpu))
+		scx_bpf_error("CPU %d should be marked as busy", cpu);
+
+	if (bpf_cpumask_subset(allowed, p->cpus_ptr) &&
+	    !bpf_cpumask_test_cpu(cpu, allowed))
+		scx_bpf_error("CPU %d not in the allowed domain for %d (%s)",
+			      cpu, p->pid, p->comm);
+}
+
+s32 BPF_STRUCT_OPS(allowed_cpus_select_cpu,
+		   struct task_struct *p, s32 prev_cpu, u64 wake_flags)
+{
+	const struct cpumask *allowed;
+	s32 cpu;
+
+	allowed = cast_mask(allowed_cpumask);
+	if (!allowed) {
+		scx_bpf_error("allowed domain not initialized");
+		return -EINVAL;
+	}
+
+	/*
+	 * Select an idle CPU strictly within the allowed domain.
+	 */
+	cpu = scx_bpf_select_cpu_and(p, prev_cpu, wake_flags, allowed, 0);
+	if (cpu >= 0) {
+		validate_idle_cpu(p, allowed, cpu);
+		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL, 0);
+
+		return cpu;
+	}
+
+	return prev_cpu;
+}
+
+void BPF_STRUCT_OPS(allowed_cpus_enqueue, struct task_struct *p, u64 enq_flags)
+{
+	const struct cpumask *allowed;
+	s32 prev_cpu = scx_bpf_task_cpu(p), cpu;
+
+	scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, 0);
+
+	allowed = cast_mask(allowed_cpumask);
+	if (!allowed) {
+		scx_bpf_error("allowed domain not initialized");
+		return;
+	}
+
+	/*
+	 * Use scx_bpf_select_cpu_and() to proactively kick an idle CPU
+	 * within @allowed_cpumask, usable by @p.
+	 */
+	cpu = scx_bpf_select_cpu_and(p, prev_cpu, 0, allowed, 0);
+	if (cpu >= 0) {
+		validate_idle_cpu(p, allowed, cpu);
+		scx_bpf_kick_cpu(cpu, SCX_KICK_IDLE);
+	}
+}
+
+s32 BPF_STRUCT_OPS_SLEEPABLE(allowed_cpus_init)
+{
+	struct bpf_cpumask *mask;
+
+	mask = bpf_cpumask_create();
+	if (!mask)
+		return -ENOMEM;
+
+	mask = bpf_kptr_xchg(&allowed_cpumask, mask);
+	if (mask)
+		bpf_cpumask_release(mask);
+
+	bpf_rcu_read_lock();
+
+	/*
+	 * Assign the first online CPU to the allowed domain.
+	 */
+	mask = allowed_cpumask;
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
+void BPF_STRUCT_OPS(allowed_cpus_exit, struct scx_exit_info *ei)
+{
+	UEI_RECORD(uei, ei);
+}
+
+SEC(".struct_ops.link")
+struct sched_ext_ops allowed_cpus_ops = {
+	.select_cpu		= (void *)allowed_cpus_select_cpu,
+	.enqueue		= (void *)allowed_cpus_enqueue,
+	.init			= (void *)allowed_cpus_init,
+	.exit			= (void *)allowed_cpus_exit,
+	.name			= "allowed_cpus",
+};
diff --git a/tools/testing/selftests/sched_ext/allowed_cpus.c b/tools/testing/selftests/sched_ext/allowed_cpus.c
new file mode 100644
index 0000000000000..a001a3a0e9f1f
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/allowed_cpus.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Andrea Righi <arighi@nvidia.com>
+ */
+#include <bpf/bpf.h>
+#include <scx/common.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include "allowed_cpus.bpf.skel.h"
+#include "scx_test.h"
+
+static enum scx_test_status setup(void **ctx)
+{
+	struct allowed_cpus *skel;
+
+	skel = allowed_cpus__open();
+	SCX_FAIL_IF(!skel, "Failed to open");
+	SCX_ENUM_INIT(skel);
+	SCX_FAIL_IF(allowed_cpus__load(skel), "Failed to load skel");
+
+	*ctx = skel;
+
+	return SCX_TEST_PASS;
+}
+
+static enum scx_test_status run(void *ctx)
+{
+	struct allowed_cpus *skel = ctx;
+	struct bpf_link *link;
+
+	link = bpf_map__attach_struct_ops(skel->maps.allowed_cpus_ops);
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
+	struct allowed_cpus *skel = ctx;
+
+	allowed_cpus__destroy(skel);
+}
+
+struct scx_test allowed_cpus = {
+	.name = "allowed_cpus",
+	.description = "Verify scx_bpf_select_cpu_and()",
+	.setup = setup,
+	.run = run,
+	.cleanup = cleanup,
+};
+REGISTER_SCX_TEST(&allowed_cpus)
-- 
2.48.1


