Return-Path: <bpf+bounces-34541-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BB192E67A
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 13:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 677021F210FF
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 11:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66FB615B98E;
	Thu, 11 Jul 2024 11:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="W8A4zskK"
X-Original-To: bpf@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazolkn19011021.outbound.protection.outlook.com [52.103.32.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DBA15B11D;
	Thu, 11 Jul 2024 11:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720696827; cv=fail; b=ImYWM+I/nxa0kn79SA5OWZ/d+GWq6vcd2amHWsTf39pHZl6lYOFFXGT8aC9vgWVu4KgdmHp5zzjjVrGPZKxZPZy+WFgtaIkHdRsJRSM/qgCijExrZMD6DRbJwX++lY/cuHu4kVc73lRiu9RutqQh5zOJpENg/7LKuqirK+m0vI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720696827; c=relaxed/simple;
	bh=SWCAw0vxxBbwypSNpxzrPoVaZe25u4XvQL4Z9MsWc4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rY5HV8YxZ2l5KkxwqRpx3Tt8G47QjosG8m9b08kUsFKR1MZDHAQHdCyyTlt/6AdUqG3shYMaGnWHetfVUu8ipXr7xeeHF1BbG9ADiWxS5ZC2QLQ0rh6L4VycTRzApjcLZ0+XoSaeBlKGMqjqE/zrKIWeoUCEeWz0030CQRCV4N8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=W8A4zskK; arc=fail smtp.client-ip=52.103.32.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ySLnQ6nfAwVd0Cv+/pRa6ukP8vwX7WyevSrR8W9nIzFFXV9dzG577fCnQZIezM1uDidjkh5MDqPyxSpDHkxpMI/sFB3qIO2xxwrxx2cuSy5z7nB+hjtwrEO1p09z+O3guBLUPtIzOM9WNiap+p6N2FHO4R1SirAyS/L7BeWrfRATkWV+nr6xrpKoMc3iLgHMEoekhX0qH48JLhaGls86y7s/K8E7e84j8ff0kPWl1Bn4NVzEeo+MV4ZmS6+SQWBeX+rWDtxTq4Slxp1NVUC7jGsf3WH8h/b1wXUR+o93FiQgDAtv4KftsorfKeXPmVk+XgdYeZYJRznP4ITrchdYww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hUTTySXX7ENbwFzAPBR/n6DwWWoqRqJO0M+cOB8m4iU=;
 b=s2N0HZzHp9b3xCrqnjQQC1eqtdaho8nApZdrBMpv8fDRXwVnsdcBFoIQU6S3G8sFDGEX/2LLnjnhAfuCL5NhfZfIopIFwgtyCYMP/EGvBYkWRt3WvgGlW2zgNz216GDJxpV0SGCu0B+b7nmVo+JdFPdo6iVXp/YcULIebBwg0iIF2hIQs803n2uMNRXQUPUb8k4ccHZHncK3qNJ/UPGHaYaqErLOdRKl3BUiipWBS32JStochDpTzwi+lxfuo+BqE/udCKORFaVus3VCqCmTX4Pxcwp1HTOX1uPMvx+3aqplsWeIs20OHL+BxTdnwAUOULPebqabsQxrY0PkFI80/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUTTySXX7ENbwFzAPBR/n6DwWWoqRqJO0M+cOB8m4iU=;
 b=W8A4zskKZeFmVrHoIlGPHY7dK4mb7XzUec0VEwlVk0pwt87/3c+tv1DZp7xfMuT3qScnTs0yKeRb3Dx5ci08F/0uShuiTwk8t91niOOSuKHB1EenIHQkIFL5I+KT6erQ8AV6WcjTVq69gHixAHldvqhgFxAvuXwx/gr/XFqCWQzG8SEHaFS/+1c/wirrKmv3CSUwETYHxM+bFea5RPJOQnh62RHkE+6fTCUFb3FuyigNeJ16eCCPoja0qwCRPKKjAGfeTsm8VvvV9KpBp5Y7Xa+Xfs0OyIeTvNHgkVkzaYfdcUJlJHxn5GdbvyeIcJyK4hTRceNSyQ9bHUKyKOhvGA==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by AM7PR03MB6628.eurprd03.prod.outlook.com (2603:10a6:20b:1bf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.22; Thu, 11 Jul
 2024 11:20:21 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7%6]) with mapi id 15.20.7762.020; Thu, 11 Jul 2024
 11:20:21 +0000
From: Juntong Deng <juntong.deng@outlook.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	andrii@kernel.org,
	avagin@gmail.com,
	snorcht@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH bpf-next RESEND 01/16] bpf: Introduce BPF_PROG_TYPE_CRIB
Date: Thu, 11 Jul 2024 12:19:23 +0100
Message-ID:
 <AM6PR03MB58480C75AA57F0B333063D2C99A52@AM6PR03MB5848.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <AM6PR03MB58488045E4D0FA6AEDC8BDE099A52@AM6PR03MB5848.eurprd03.prod.outlook.com>
References: <AM6PR03MB58488045E4D0FA6AEDC8BDE099A52@AM6PR03MB5848.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [fDhjfl4XQ7kxjkOZWf/LUz85FXmek1tg]
X-ClientProxiedBy: SI2P153CA0031.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::7)
 To AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <20240711111938.11722-1-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|AM7PR03MB6628:EE_
X-MS-Office365-Filtering-Correlation-Id: 89691632-7daa-4565-cf05-08dca19b739e
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|8060799006|19110799003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	LlG0ohRQj/HVX6bAYRB4Z6LK/58BQPAGn4U3cBOrFK9LAsG9XvOvPJiz8e0OyG4DftFijCvzq4wwIxyreG49vYw5V7aoAcxy0BqrZeaHu+ZG28VuwNoONTyff1dSGbwQjzitgMf7+744nDJBfkvFd7Eh1/iL5k4qRaIXmeJUgLi+/y9hACNSoWOrMC1QJY5vSF3rq9LihsHGGOVf1BFUffg2I7wDnAMzzMbqEfxaJ5IvFIYsTGLEQA38gjNFJROF9j1cFfGRAfLwOTySwJOiJH4e5wUasqpm/gabWks7bO/qkibBkBfzyVfV/jRQZFIFZv8hI+2VjM9eHBgXbFEEic7ZPwjNDsh/ARonBo/I/0L2/+jWnHA79kPABCYz0/DUQ2T/DZTpcU7uJGJUOlWb7LACLNF7rYq6L/4QNO465u8cAI5uJ26GUGx4XBUZ5jjc24rriLOB6cxlVXqaUohhZd9p9evT1tBRy7j1L3M4fbHqkp7O0y/Ml6CEbyHG9tDEST6ZwxF8N78zOPuH8MaY3ZDfNDo/BxlCOKiDqM9bUn7IRflN6JZ2k5s9eirpvFXak7NWRYCLeXHD6JHOdZk28AK5Sn7DLQ6B2xTW/PZw5sjCsO2JydtaLWHtrRc+qtZ/X3RkqrloG1ls88lKgPqCGQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?79FEAK6SBwr0f10qaSgTwFqAbAq8r4EVIJyNqZRRhZmESq4wAFpIzOpUN8/O?=
 =?us-ascii?Q?1rCpP/pw+w21j7yDw55klUaMZjVhFxRKhLdIWmpdnd49YFhYWlv5P4tyQk73?=
 =?us-ascii?Q?hizIWrtC8hKD42srwK3MBrYsTj4Mx2SgaWKX2fgP8RhdP8pQA+b2WrYgPRTJ?=
 =?us-ascii?Q?CcFRSiJf9tmDCMExLcNtGBEh6BoZXsTuRsSv7bothYga+ftfvQ47kWIRHKJH?=
 =?us-ascii?Q?mbgYgfTtYE7XNhAxM6rutlSdSgdoTz2yskevoZtXaTqt7OFlTkNEuIGgP9/A?=
 =?us-ascii?Q?oHXmB/4Z5XR6Q4x+UgBFAN5gRMTQ36gHiATIo2i1ps31UoQd6I5UYRSG+Vvu?=
 =?us-ascii?Q?mfUxr7Qjej4bmZM3UNHSeFX79u5qBvP56jcgdIOcScKSromjRA4FKYmIyNtv?=
 =?us-ascii?Q?iplXuLkXGzs9c7QTQd6giCaWj3szv5Nnts1zTWrKEHOEt1HIiMkLzkY9NTlV?=
 =?us-ascii?Q?F0RmdYEL3xpWtjlJZF+YjBxiqz2kggNedZyTABqLDlwCiZgMN6c50nFUFanc?=
 =?us-ascii?Q?5N0v7oF893ckztsT7dmT/q7rkLwcusKo5Grj1yxuOdMwvlys07k+gHLSj7Kj?=
 =?us-ascii?Q?gCVcB6ihOrrEKY1JosZ44B2tBDnMo2A4WzYcs3fFHNqMT+ceWHI2zI03AOl5?=
 =?us-ascii?Q?ZNONODdZUYZ1ZrF7B7WGbv3A02rNXlo7rb2rL01x2Ai/dQcmK3umEhL5rug1?=
 =?us-ascii?Q?vs6emizhLhixM/C464F3dG9OJ1VHdDZljkGhbeseodocfPUleYht3NgJv0wV?=
 =?us-ascii?Q?lSzxZuItjTRHFrNOE1t9rQRD+9bNwEgSThQvdGF7ksKKmPpyUW9XNsG26eG3?=
 =?us-ascii?Q?cuBZFHCFlcGp8B4XYOA6hbxghKBmcXiIZQMdBou9fAd9REGty0Y18GyFodkx?=
 =?us-ascii?Q?tcHJPJpU1HGT21dXZ6QYp3jjEZeN8EaDCGE5IN/a+0Bg0U5yA5TGqFjOU2as?=
 =?us-ascii?Q?s9dL3+ItyiOWL9c39DzBWklAv5J4JB5WOEuYy1YyGtSB3lB2yeu1JmN7Hpks?=
 =?us-ascii?Q?S3L9DkBd7Jh4FEbY36lmP337WsbIQCvrUPN2GBWIEpLnlm5LedWHR8HlObEc?=
 =?us-ascii?Q?SnZ0W97m4Z0oLX5i8UjQazE6f6s1gf5+2bzrKieb1MMOQDs7O4r55zm6XGEP?=
 =?us-ascii?Q?54NxpDfWLGqHDx7ah2fcLOfjxWju2Sce2jsy1crqYk0ewunNoy75HNTvDWrR?=
 =?us-ascii?Q?bUmncJYyRX/tlg1IjilykolrhBlmu9t3GHJ+kl3Be8k7F1w551SPCSqtn5I?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89691632-7daa-4565-cf05-08dca19b739e
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 11:20:21.7538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR03MB6628

This patch adds a new BPF program type CRIB (Checkpoint/Restore In eBPF)
for checkpointing/restoring processes through eBPF.

CRIB BPF programs are not attached to any hooks, run through
BPF_PROG_RUN, and are called by userspace programs as eBPF APIs
for dumping/restoring process information.

CRIB BPF programs dump/restore process information through CRIB
kfunc APIs.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 include/linux/bpf_crib.h         |  16 +++++
 include/linux/bpf_types.h        |   4 ++
 include/uapi/linux/bpf.h         |   1 +
 kernel/bpf/Kconfig               |   2 +
 kernel/bpf/Makefile              |   2 +
 kernel/bpf/btf.c                 |   4 ++
 kernel/bpf/crib/Kconfig          |  14 ++++
 kernel/bpf/crib/Makefile         |   3 +
 kernel/bpf/crib/bpf_checkpoint.c |  13 ++++
 kernel/bpf/crib/bpf_crib.c       | 109 +++++++++++++++++++++++++++++++
 kernel/bpf/crib/bpf_restore.c    |  13 ++++
 kernel/bpf/helpers.c             |   1 +
 kernel/bpf/syscall.c             |   1 +
 tools/include/uapi/linux/bpf.h   |   1 +
 tools/lib/bpf/libbpf.c           |   2 +
 tools/lib/bpf/libbpf_probes.c    |   1 +
 16 files changed, 187 insertions(+)
 create mode 100644 include/linux/bpf_crib.h
 create mode 100644 kernel/bpf/crib/Kconfig
 create mode 100644 kernel/bpf/crib/Makefile
 create mode 100644 kernel/bpf/crib/bpf_checkpoint.c
 create mode 100644 kernel/bpf/crib/bpf_crib.c
 create mode 100644 kernel/bpf/crib/bpf_restore.c

diff --git a/include/linux/bpf_crib.h b/include/linux/bpf_crib.h
new file mode 100644
index 000000000000..f667b740fcc2
--- /dev/null
+++ b/include/linux/bpf_crib.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Checkpoint/Restore In eBPF (CRIB)
+ *
+ * Author:
+ *	Juntong Deng <juntong.deng@outlook.com>
+ */
+#ifndef _BPF_CRIB_H
+#define _BPF_CRIB_H
+
+#include <linux/bpf.h>
+#include <linux/btf.h>
+#include <linux/btf_ids.h>
+#include <linux/filter.h>
+
+#endif /* _BPF_CRIB_H */
diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
index 9f2a6b83b49e..a6feddfd17e2 100644
--- a/include/linux/bpf_types.h
+++ b/include/linux/bpf_types.h
@@ -83,6 +83,10 @@ BPF_PROG_TYPE(BPF_PROG_TYPE_SYSCALL, bpf_syscall,
 BPF_PROG_TYPE(BPF_PROG_TYPE_NETFILTER, netfilter,
 	      struct bpf_nf_ctx, struct bpf_nf_ctx)
 #endif
+#ifdef CONFIG_BPF_CRIB
+BPF_PROG_TYPE(BPF_PROG_TYPE_CRIB, bpf_crib,
+	      void *, void *)
+#endif /* CONFIG_BPF_CRIB */
 
 BPF_MAP_TYPE(BPF_MAP_TYPE_ARRAY, array_map_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_PERCPU_ARRAY, percpu_array_map_ops)
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 35bcf52dbc65..cb67a9cad8c6 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1055,6 +1055,7 @@ enum bpf_prog_type {
 	BPF_PROG_TYPE_SK_LOOKUP,
 	BPF_PROG_TYPE_SYSCALL, /* a program that can execute syscalls */
 	BPF_PROG_TYPE_NETFILTER,
+	BPF_PROG_TYPE_CRIB,
 	__MAX_BPF_PROG_TYPE
 };
 
diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
index 17067dcb4386..a129677a03e3 100644
--- a/kernel/bpf/Kconfig
+++ b/kernel/bpf/Kconfig
@@ -101,4 +101,6 @@ config BPF_LSM
 
 	  If you are unsure how to answer this question, answer N.
 
+source "kernel/bpf/crib/Kconfig"
+
 endmenu # "BPF subsystem"
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 0291eef9ce92..8c350d159d3c 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -58,3 +58,5 @@ vpath %.c $(srctree)/kernel/bpf:$(srctree)/tools/lib/bpf
 
 $(obj)/%.o: %.c FORCE
 	$(call if_changed_rule,cc_o_c)
+
+obj-$(CONFIG_BPF_CRIB) += crib/
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 4ff11779699e..306349ee3d6a 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -219,6 +219,7 @@ enum btf_kfunc_hook {
 	BTF_KFUNC_HOOK_LWT,
 	BTF_KFUNC_HOOK_NETFILTER,
 	BTF_KFUNC_HOOK_KPROBE,
+	BTF_KFUNC_HOOK_CRIB,
 	BTF_KFUNC_HOOK_MAX,
 };
 
@@ -6037,6 +6038,7 @@ static int btf_validate_prog_ctx_type(struct bpf_verifier_log *log, const struct
 	case BPF_PROG_TYPE_TRACEPOINT:
 	case BPF_PROG_TYPE_SYSCALL:
 	case BPF_PROG_TYPE_EXT:
+	case BPF_PROG_TYPE_CRIB:
 		return 0; /* anything goes */
 	default:
 		break;
@@ -8326,6 +8328,8 @@ static int bpf_prog_type_to_kfunc_hook(enum bpf_prog_type prog_type)
 		return BTF_KFUNC_HOOK_NETFILTER;
 	case BPF_PROG_TYPE_KPROBE:
 		return BTF_KFUNC_HOOK_KPROBE;
+	case BPF_PROG_TYPE_CRIB:
+		return BTF_KFUNC_HOOK_CRIB;
 	default:
 		return BTF_KFUNC_HOOK_MAX;
 	}
diff --git a/kernel/bpf/crib/Kconfig b/kernel/bpf/crib/Kconfig
new file mode 100644
index 000000000000..346304f65db6
--- /dev/null
+++ b/kernel/bpf/crib/Kconfig
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config BPF_CRIB
+	bool "Checkpoint/Restore In eBPF (CRIB)"
+	depends on BPF_SYSCALL
+	depends on BPF_JIT
+	depends on DEBUG_INFO_BTF
+	help
+	  Enable CRIB (Checkpoint/Restore In eBPF), which allows
+	  checkpointing/restoring of processes through BPF programs.
+
+	  Compared to procfs and system call interfaces, CRIB achieves
+	  higher performance and supports dumping/restoring more
+	  comprehensive process status information.
diff --git a/kernel/bpf/crib/Makefile b/kernel/bpf/crib/Makefile
new file mode 100644
index 000000000000..abd43c76140b
--- /dev/null
+++ b/kernel/bpf/crib/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_BPF_CRIB) += bpf_crib.o bpf_checkpoint.o bpf_restore.o
diff --git a/kernel/bpf/crib/bpf_checkpoint.c b/kernel/bpf/crib/bpf_checkpoint.c
new file mode 100644
index 000000000000..efaca6bcdfe4
--- /dev/null
+++ b/kernel/bpf/crib/bpf_checkpoint.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Checkpoint/Restore In eBPF (CRIB): Checkpoint
+ *
+ * Author:
+ *	Juntong Deng <juntong.deng@outlook.com>
+ */
+
+#include <linux/bpf_crib.h>
+
+__bpf_kfunc_start_defs();
+
+__bpf_kfunc_end_defs();
diff --git a/kernel/bpf/crib/bpf_crib.c b/kernel/bpf/crib/bpf_crib.c
new file mode 100644
index 000000000000..9ef2d61955bf
--- /dev/null
+++ b/kernel/bpf/crib/bpf_crib.c
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Checkpoint/Restore In eBPF (CRIB): Common
+ *
+ * Author:
+ *	Juntong Deng <juntong.deng@outlook.com>
+ */
+
+#include <linux/bpf_crib.h>
+#include <linux/init.h>
+
+__bpf_kfunc_start_defs();
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(bpf_crib_kfuncs)
+
+BTF_KFUNCS_END(bpf_crib_kfuncs)
+
+static int bpf_prog_run_crib(struct bpf_prog *prog,
+			      const union bpf_attr *kattr,
+			      union bpf_attr __user *uattr)
+{
+	void __user *ctx_in = u64_to_user_ptr(kattr->test.ctx_in);
+	__u32 ctx_size_in = kattr->test.ctx_size_in;
+	void *ctx = NULL;
+	u32 retval;
+	int err = 0;
+
+	/* doesn't support data_in/out, ctx_out, duration, or repeat or flags */
+	if (kattr->test.data_in || kattr->test.data_out ||
+	    kattr->test.ctx_out || kattr->test.duration ||
+	    kattr->test.repeat || kattr->test.flags ||
+	    kattr->test.batch_size)
+		return -EINVAL;
+
+	if (ctx_size_in < prog->aux->max_ctx_offset ||
+	    ctx_size_in > U16_MAX)
+		return -EINVAL;
+
+	if (ctx_size_in) {
+		ctx = memdup_user(ctx_in, ctx_size_in);
+		if (IS_ERR(ctx))
+			return PTR_ERR(ctx);
+	}
+
+	rcu_read_lock_trace();
+	retval = bpf_prog_run_pin_on_cpu(prog, ctx);
+	rcu_read_unlock_trace();
+
+	if (copy_to_user(&uattr->test.retval, &retval, sizeof(u32))) {
+		err = -EFAULT;
+		goto out;
+	}
+out:
+	if (ctx_size_in)
+		kfree(ctx);
+
+	return err;
+}
+
+static const struct bpf_func_proto *
+bpf_crib_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
+{
+	switch (func_id) {
+	default:
+		return bpf_base_func_proto(func_id, prog);
+	}
+}
+
+static bool bpf_crib_is_valid_access(int off, int size,
+					 enum bpf_access_type type,
+					 const struct bpf_prog *prog,
+					 struct bpf_insn_access_aux *info)
+{
+	/*
+	 * Changing the context is not allowed, and all dumped data
+	 * is returned to userspace via ringbuf.
+	 */
+	if (type != BPF_READ)
+		return false;
+	if (off < 0 || off >= U16_MAX)
+		return false;
+	if (off % size != 0)
+		return false;
+
+	return true;
+}
+
+const struct bpf_prog_ops bpf_crib_prog_ops = {
+	.test_run = bpf_prog_run_crib,
+};
+
+const struct bpf_verifier_ops bpf_crib_verifier_ops = {
+	.get_func_proto		= bpf_crib_func_proto,
+	.is_valid_access	= bpf_crib_is_valid_access,
+};
+
+static const struct btf_kfunc_id_set bpf_crib_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set   = &bpf_crib_kfuncs,
+};
+
+static int __init bpf_crib_init(void)
+{
+	return register_btf_kfunc_id_set(BPF_PROG_TYPE_CRIB, &bpf_crib_kfunc_set);
+}
+
+late_initcall(bpf_crib_init);
diff --git a/kernel/bpf/crib/bpf_restore.c b/kernel/bpf/crib/bpf_restore.c
new file mode 100644
index 000000000000..6bbb4b01e34b
--- /dev/null
+++ b/kernel/bpf/crib/bpf_restore.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Checkpoint/Restore In eBPF (CRIB): Restore
+ *
+ * Author:
+ *	Juntong Deng <juntong.deng@outlook.com>
+ */
+
+#include <linux/bpf_crib.h>
+
+__bpf_kfunc_start_defs();
+
+__bpf_kfunc_end_defs();
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 5241ba671c5a..bcd3ce9da00c 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2986,6 +2986,7 @@ static int __init kfunc_init(void)
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &generic_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &generic_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &generic_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CRIB, &generic_kfunc_set);
 	ret = ret ?: register_btf_id_dtor_kfuncs(generic_dtors,
 						  ARRAY_SIZE(generic_dtors),
 						  THIS_MODULE);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 0719192a3482..faf99e53d706 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2633,6 +2633,7 @@ bpf_prog_load_check_attach(enum bpf_prog_type prog_type,
 		return -EINVAL;
 	case BPF_PROG_TYPE_SYSCALL:
 	case BPF_PROG_TYPE_EXT:
+	case BPF_PROG_TYPE_CRIB:
 		if (expected_attach_type)
 			return -EINVAL;
 		fallthrough;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 35bcf52dbc65..cb67a9cad8c6 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1055,6 +1055,7 @@ enum bpf_prog_type {
 	BPF_PROG_TYPE_SK_LOOKUP,
 	BPF_PROG_TYPE_SYSCALL, /* a program that can execute syscalls */
 	BPF_PROG_TYPE_NETFILTER,
+	BPF_PROG_TYPE_CRIB,
 	__MAX_BPF_PROG_TYPE
 };
 
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 30f121754d83..4e1451901b7d 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -224,6 +224,7 @@ static const char * const prog_type_name[] = {
 	[BPF_PROG_TYPE_SK_LOOKUP]		= "sk_lookup",
 	[BPF_PROG_TYPE_SYSCALL]			= "syscall",
 	[BPF_PROG_TYPE_NETFILTER]		= "netfilter",
+	[BPF_PROG_TYPE_CRIB]			= "crib",
 };
 
 static int __base_pr(enum libbpf_print_level level, const char *format,
@@ -9449,6 +9450,7 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("struct_ops.s+",	STRUCT_OPS, 0, SEC_SLEEPABLE),
 	SEC_DEF("sk_lookup",		SK_LOOKUP, BPF_SK_LOOKUP, SEC_ATTACHABLE),
 	SEC_DEF("netfilter",		NETFILTER, BPF_NETFILTER, SEC_NONE),
+	SEC_DEF("crib",			CRIB, 0, SEC_NONE),
 };
 
 int libbpf_register_prog_handler(const char *sec,
diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index 9dfbe7750f56..2e087280c5f0 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -180,6 +180,7 @@ static int probe_prog_load(enum bpf_prog_type prog_type,
 	case BPF_PROG_TYPE_SK_REUSEPORT:
 	case BPF_PROG_TYPE_FLOW_DISSECTOR:
 	case BPF_PROG_TYPE_CGROUP_SYSCTL:
+	case BPF_PROG_TYPE_CRIB:
 		break;
 	case BPF_PROG_TYPE_NETFILTER:
 		opts.expected_attach_type = BPF_NETFILTER;
-- 
2.39.2


