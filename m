Return-Path: <bpf+bounces-53613-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D82CA572AB
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 21:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AC111793FC
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 20:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D6E255E58;
	Fri,  7 Mar 2025 20:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V31j7mie"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542201A5BBD;
	Fri,  7 Mar 2025 20:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741377960; cv=fail; b=O+Xt3th/yd3J7Ql7lOi5d0cdBo5HQBSPcMApxbEqXvMZMASpd+1eF2SGW69sQuGETWfLMJovRXL/xc6vpDKIUHLni58D3rMmyNbCntUso/b2FcV8BMxk7Z0hUfEwowRoR9dY/LRVCVgIOYjyswA20azJwVe1kcjCVdpYu0Ek97g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741377960; c=relaxed/simple;
	bh=diJvLLM2h75AZE5HWjVx5JzrrtnOIQ6QFAEWxGGho9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W/s1xvRudyEr0bpkX/xGRXAEU6HoLrQqr9GzDTYatvGmm2U+YS5tMlkti3gIF9nfUJXvHY4XGqtmw2XMetQsvAgLyvosjU0xEWWUzciwacJAmIkKCPoUJi5J8cC0F/LDsdONF7ZoWaMb9qOt4PmJbn4q6JMiVxs0mi+yJ16mphM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V31j7mie; arc=fail smtp.client-ip=40.107.92.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fzKB1RkEhI843ApyBHBh+3Z3p6uLZdK8thDv91EWUIJAmfqZeEucsjjtjXOopaNrdw2V1WDF6WR2PahIf6Wn4agyA+ZNUsOpvD9VfutqQ3XS8jMf3YD9UGlvciAN4qwsY8trGqd6xt/pN8zbywgeMDby1lkNrAFJQoMaY1StKCSNZ1HiC3L/NeEb1UoQoM2ANU5qXjrszBIRAHS5P7d9Bu/JI1qCVJpKEhCJ4yWDtQT/pfPL3Nkhkclpb6J/eb5m7y9HxaVYWXdAJqau10sUjpnWda4f5fGFihpds/3NELWAuBoR0MCmdFE+qDqi6NWBHNHoQScUUOmaj53szlP1FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cFXILJ9H7PJi2CzADa5VzNjvtigIKomrOPRUR9xy6q8=;
 b=JjPM4XvEVyoK5q/cuFuZ0eDts5sL4T24oP9C/EkbiuGeCM3QsfSauObCVFtjBy1xVXL8wRNlBEB/YSCk7M7Df6j0XvOh3pV4a/zHkYzdvD9wRSPD9W0M1F1EMCaPjdgV5WKyCH13rnHEwkcxV/wtatl9uOvMM0VLvxPrizpIngu7udGain7uq92d0MvLGtYRMvJHZJyAi55m9ClhAmyFWiv26ijbZoXZrOtisv82yDRZZcU7PaMRL2hMF77Xlt0MHw6KHJiTjm1qe5eu6+RKaEMASoyD4Li8JNKWcFRLj+Zs4VDxglzPC+WSy1xRj5V3Oo0PA+O7PpJnR7PKW91RQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cFXILJ9H7PJi2CzADa5VzNjvtigIKomrOPRUR9xy6q8=;
 b=V31j7mieq0FGxhQ0x5Tm3z9rTRiiJFR5TYGLhU/+wrtxe8scR5ohaLnus2PCUESjtVn2RgUAWuC1v4myEJtQEE0UIpUQequD9VUI0pzgaQWYzR93HXc7wucguMOpMiwhytgwLQoZWbzIbZuECqfGtMqyBBtvtwS7a1fWHm4kwxWMwbpFmWFguKTGxX42Vr25MbMke7N0eykZ2xNAzPvmB1fGfHf35Q89kWhXZhZnBkH0z4/jqMmd0p+q4MkTNIpX/eQ9npDA44xNbiXSWq9/WkJxbWcR9m8Z+xIin5EMxrXz3Kboc17zTpSdcaRnPV1qmsij/5m35F21jrB4vD7deg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by CY3PR12MB9554.namprd12.prod.outlook.com (2603:10b6:930:109::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.20; Fri, 7 Mar
 2025 20:05:51 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 20:05:51 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] selftests/sched_ext: Add test for scx_bpf_select_cpu_and()
Date: Fri,  7 Mar 2025 21:01:07 +0100
Message-ID: <20250307200502.253867-6-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250307200502.253867-1-arighi@nvidia.com>
References: <20250307200502.253867-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0005.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::12) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|CY3PR12MB9554:EE_
X-MS-Office365-Filtering-Correlation-Id: a05d5bab-ff41-42f6-3d68-08dd5db37601
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?78WcJ/89z8rz5fRoJ+U3jKyVtvv5T9nWYt+4VOwJNoLiv2w5M9ucqJtipyp8?=
 =?us-ascii?Q?jswI5uTgZucCgt5M3yjpP+ya3g2aYQ1Oj+peUFIStmtonsgcnRoZkArkzJK7?=
 =?us-ascii?Q?Jpi06OPC+lt0IMpLa6a4kTrNdsfdvZUUAeBYtVY284M7Sd3Gtal+NLwjKhRy?=
 =?us-ascii?Q?xpZ69lFhnfuPCqtaU0sgfQAL3UoGBHIrXzVbsgta5gJpGcquKxQYkMCXv9io?=
 =?us-ascii?Q?194uSy2eIst5bm0yJiaOGT79pdU8cv8n9LJeV/N8y4bcm38d55b8I4ek/y84?=
 =?us-ascii?Q?t9TjXzN/VWmOObmpaiRCUT1UVs7KCuwMoH5TpXLNeQwsyInoWTZ2D4GWg8uM?=
 =?us-ascii?Q?jRlFZdTWbooge8Lmr7DcUHTu0yL18vab95fLG2tl0e5xMKOztrvVq2zR0R6N?=
 =?us-ascii?Q?gm1Y3k2cvKZQxGSKN6Wh1MtkPjOn/hcOecZYPVgi0W26JF/1kkjkhya8zklx?=
 =?us-ascii?Q?ZtsB/JCyIxC84QwfbamJ3eTuse2mQ3H0h3elpvBFg4PaPEqgPH7z1LbaVOBI?=
 =?us-ascii?Q?wjLIwy/uLKjuqD8f9TL+IRH5Wl/zJA+3aS0G/4okLIImNtBJ12q5mNX8Uo3l?=
 =?us-ascii?Q?YdJ8CDnCjFqV20Tqa86UYJo9+5tJft+3iGJ27CzTsaW7yvzphdJxGIqwDLJm?=
 =?us-ascii?Q?7JyVdDFgaTYSVBAlBkKM/E43/+gmgjufOQrErxFMn5+OAw8mkl61g8HzcyQr?=
 =?us-ascii?Q?iD2jDjGFSBpicjnWIKTo4UGdqeGd8GwimlgraRGhhpy+LGcKLTZu0QQrBCC5?=
 =?us-ascii?Q?TSkbYVfAj0MwMhjk8/stI8fGNk4/dLfCYbAVNMdQ0ykmvhVwx9vnpjH3Tvdv?=
 =?us-ascii?Q?P0kY9enAmzsCSHxz8aFk/7LCYy6AYYZi2pMcGQlOZ6zrM/jJgdOUfNwTipE/?=
 =?us-ascii?Q?qMHbxUBcjKz3OGsQuH3w8veWiAF1n0kr5qeg1bwEFgjzpgA/7mToKk5vDXvu?=
 =?us-ascii?Q?h38fL8qjc6UY33JOMZEnerkVtG5Xkvo1ZS7D04YwWzLkexbMA7w2rn1tuNIV?=
 =?us-ascii?Q?jm7UYOEWivPhwaeOu1pbsADoybvhH44C9R901sUtaq9dgPFNM8j1iUlJd8jw?=
 =?us-ascii?Q?83mLXEBPC4uTIMDM0tsGpTxsW0kHYj1oE4WSskPt5Hi6I7Em7kOT+ASCcgEi?=
 =?us-ascii?Q?ShzoYhO6xFOIAQ7QfBX32JpVTyZe15p7zmJKZ6gN9AXGZmcfu9F9l4ZkWlzq?=
 =?us-ascii?Q?nKp+apDbejL13HNnYO2Na1mGQJPJIKZjMY9ABGkCCno3xJESjpkbAX4pnAU3?=
 =?us-ascii?Q?VBaQe/LxwBly6OTPH8T42SAiFFg42pf+d/KsH3KuSxkLjDmABW+h5xU5EgoL?=
 =?us-ascii?Q?b0ZjvZTTbjM/Xbqp1c8EFXbphTRkSuQKOC2BBymiNMysVtrQSWP+9muXZSL6?=
 =?us-ascii?Q?egAigSBk0r+wZgv6hCQf4aqXg6sS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lkJmedtNDS4l/LyL6PL2mGsLhxGsPl334t+dpCxWMN9uduH1GXTXJUrmWJoT?=
 =?us-ascii?Q?2n2x87vyxHim7eZq0gGgJJAmOqFBNUWIA8JjhPf76BnCPzA2UovcMkca1MD8?=
 =?us-ascii?Q?So+5QxsJUJhHawI37I1ZKLeklCfjHsoj2LgR8po90sqwg40v42+TNL2MhftI?=
 =?us-ascii?Q?7DT940pSPk8GmOUgoLWOZdi5fpmvMkFUI9ygAhmmIkhvh3PVxY/jYpKj+R6z?=
 =?us-ascii?Q?6R+PmWoGGFExIeW4mTt+PdgAppaeDUxmh3vZCDpHGreOa50mhhHAmgwStIVx?=
 =?us-ascii?Q?IdJ1wSd/igIpjypuWrYIHVS8TbFQlmTJxCAic89gKz7uqs+SyV5Td44Rv6GJ?=
 =?us-ascii?Q?lQehTLmP9C/bnELk1yLq4b1VMXroZYKYGSpUSD5EKerLkNCMuPRk/iRmgkXV?=
 =?us-ascii?Q?pKcqek9SIcQPatK+DWj2nSvssLM6e2yYWI7Cd+oMQorFDdJMYqN2Y/kQxA0F?=
 =?us-ascii?Q?Gnks+rB0iHtvpLVX7ghqbAX6+NuwNCTvxV976nvM6urHdUyUAZvLIjG798hf?=
 =?us-ascii?Q?ODEATK7xk+WJNMmyBFbVY6JbYLJIy2ECE93ERC+1+rhTI6GZoNfZ+xc4uwWM?=
 =?us-ascii?Q?sTLXifRNSOjJgh8Lz1Mirs01I3tgqS4LNI5TXSe4gJRb/LIQp8urmNVUcP6x?=
 =?us-ascii?Q?rYn7ufCEJspyW5ea9wJMyyyZwkDZh7qS50BqFfVFWBhVnBdah8u7NolxWtwR?=
 =?us-ascii?Q?am91J7HErXe301O/wtm0rdsXg/gG1kZm25XmQBxkVnwdADdzoSfsxrvooB/B?=
 =?us-ascii?Q?MZc71xIojexaQybLfUkkEX9anw64GoU6LooibeSXZFiXZVBxaEp3oab3Z3LG?=
 =?us-ascii?Q?6A50qVKToPTix9Xzy8+uptXMCLV6CmMCPBfCom3q2yifbBa74BPDUgPoLkwM?=
 =?us-ascii?Q?clInP2de144rsvom2AZKBZPKjD63wxV8fQ6S7ihxoUqYWrcpkAc1P+3gAiDn?=
 =?us-ascii?Q?iGtlk2zIFAO5kyw5t29yDJv2O/rDaaKQtkpLCMvTI4jGHd3v49aA30KN1yzZ?=
 =?us-ascii?Q?LEml59GaSDYK1fZpkvRiivQXSBpbZMCHy7TskfXfWWEK6+8UDlkB6DNiHPFe?=
 =?us-ascii?Q?tKBeG3zA80SuzBofMNDCoulLU5ckBiQugeJpUaH0LTq/OaH1Ll7f35XPxFoM?=
 =?us-ascii?Q?kEhe0bp2UAgr27sB/sPGXz4XHN2vlCfIZz7s18SoPvOARFiPmNEBOCvwIx1r?=
 =?us-ascii?Q?xefO9YWXZDytc13IGQp4lOigww/AX1zOlcUDLbcdAaj4/OJtazoYUBom1WrO?=
 =?us-ascii?Q?gK3sKHoFuaLD4lPbaS372Bm6noMcqGGh63OH/DVAWk3O7HZlIiuDYN9OnnPR?=
 =?us-ascii?Q?CF8HqILb/ufVzHaHwtu0mR6vU2L1luA72BSyA3HvZSwy0OcCYjZMTKayY+7F?=
 =?us-ascii?Q?hbf7C9YJTV5rYioPM0tEHZtaCQLKtu+Nu2+8OQwdun9fFarA0JrS69SUAwgw?=
 =?us-ascii?Q?Y4Q27JzZdZIPFqe11w9kvEbhtAbSip6ZdjhUEdyIu46nSCBN8WB/b7DosvGY?=
 =?us-ascii?Q?3XiFYw0ImDBkC2MYo+4gBhYEoXD/cuA9Xowc0KdRsJHTwLc2kvqN3HOVHIOi?=
 =?us-ascii?Q?K55rbTemFHQSqMKh2sbJzZHzpgVzC/dKk2ia1UQd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a05d5bab-ff41-42f6-3d68-08dd5db37601
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 20:05:51.7581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GLyD+YhI0j5rcXbLyphAWQHoSH5ng8g5GgDgcNDj060zb4dHWDxfdTPHDwJ+3rC/XXlcpgIXbmzqu46QGkfDpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9554

Add a selftest to validate the behavior of the built-in idle CPU
selection policy applied to a subset of allowed CPUs, using
scx_bpf_select_cpu_and().

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 tools/testing/selftests/sched_ext/Makefile    |  1 +
 .../selftests/sched_ext/allowed_cpus.bpf.c    | 91 +++++++++++++++++++
 .../selftests/sched_ext/allowed_cpus.c        | 57 ++++++++++++
 3 files changed, 149 insertions(+)
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
index 0000000000000..5c4d330a8d0a5
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/allowed_cpus.bpf.c
@@ -0,0 +1,91 @@
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
+	cpu = scx_bpf_select_cpu_and(p, allowed, prev_cpu, wake_flags, 0);
+	if (cpu >= 0) {
+		if (scx_bpf_test_and_clear_cpu_idle(cpu))
+			scx_bpf_error("CPU %d should be marked as busy", cpu);
+
+		if (bpf_cpumask_subset(allowed, p->cpus_ptr) &&
+		    !bpf_cpumask_test_cpu(cpu, allowed))
+			scx_bpf_error("CPU %d not in the allowed domain for %d (%s)",
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


