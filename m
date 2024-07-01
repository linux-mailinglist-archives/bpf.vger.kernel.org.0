Return-Path: <bpf+bounces-33561-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F011991EB77
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 01:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E2CE1F224EF
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 23:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205AF17332B;
	Mon,  1 Jul 2024 23:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PldZ5wJr"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D85172BAB
	for <bpf@vger.kernel.org>; Mon,  1 Jul 2024 23:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719877413; cv=none; b=UE4hTmEnj6c5E1rWXRTv22PR9QF7HGmuxnaOCknBeW2YV7KMIZ18dm4f1cTd4Rvx+CHfzQpFTAqZG9E94SYQj/OBhMB/ZFU5IACR6XDIXjD/uis5QfqhqE6B4OZvDGKcIUfJejXsvVLpw5rUTphHntsBDUr7kVTVTptH6xuLJms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719877413; c=relaxed/simple;
	bh=OXH/4zT+LIxU89nhQfA6cdIHpGuxysLNE4wjmlUJVVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=orBCxn9eIOkh+mChPLmuk+/WukYR06SvuqvkTtvfZnPSZaMA66582rd/UHlYU1UgXpq9ADKZ1Mjw9SOkL70tDoqP8ip0VbCYW041YC1Hl6GqFMFoqV2E1RIkAsBFRf7tcJ6cmVY+tSmw5otzWGksAe2lD/vvFN7B7TxfSKIDwuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PldZ5wJr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 461NUf2N009594;
	Mon, 1 Jul 2024 23:43:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=NiikpQ8rU7LPY
	HFcJaEFvAGriKGJRfBX0N+D93H/VBU=; b=PldZ5wJrTpQ1Yqe8bpIaot6tc6fe3
	I6Yg1FbXEJZiUfSw0RtMlCKi2JBTBkPxCYb0qDokCNyBP1RZ2LkJyUel2DDsz/ak
	OLSb/jKOYlbRIXhPZW7okqTvVH+zrMptgChsNHQalGg6L7UyL93xdd2AZj+tYP3N
	mWmlsW452dKm1tbq+JGtkDncuFjpHk3xycnxkpzyGY24/oGgBZyMAcMHgUErKcPn
	WIrCO5dwv2TBnhtBO9ZIexi9iXjGitShyte5QyV+XrQvFenRPA/lM6EoluIzv+fd
	4QrNAnfHRDJs53/JwEeIA1c8HkIQlcxwgtR/OQn4PF6UnvgNQUnnnSh/Q==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40465hg0np-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 23:43:18 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 461LLbh9005985;
	Mon, 1 Jul 2024 23:43:18 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 402vku24ev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 23:43:18 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 461NhCY646727582
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jul 2024 23:43:15 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D931F2004B;
	Mon,  1 Jul 2024 23:43:12 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6AF1D20043;
	Mon,  1 Jul 2024 23:43:12 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.65.243])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Jul 2024 23:43:12 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v3 10/12] selftests/bpf: Introduce __arena_global
Date: Tue,  2 Jul 2024 01:40:28 +0200
Message-ID: <20240701234304.14336-11-iii@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240701234304.14336-1-iii@linux.ibm.com>
References: <20240701234304.14336-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 62ebFTczhijfkxAyj34iWyOAv_ElimBw
X-Proofpoint-GUID: 62ebFTczhijfkxAyj34iWyOAv_ElimBw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_21,2024-07-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 spamscore=0 phishscore=0
 mlxscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2407010174

While clang uses __attribute__((address_space(1))) both for defining
arena pointers and arena globals, GCC requires different syntax for
both. While __arena covers the first use case, introduce __arena_global
to cover the second one.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 .../testing/selftests/bpf/bpf_arena_common.h  |  2 +
 .../selftests/bpf/progs/arena_atomics.c       | 67 +++++++++----------
 2 files changed, 32 insertions(+), 37 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_arena_common.h b/tools/testing/selftests/bpf/bpf_arena_common.h
index 567491f3e1b5..68a51dcc0669 100644
--- a/tools/testing/selftests/bpf/bpf_arena_common.h
+++ b/tools/testing/selftests/bpf/bpf_arena_common.h
@@ -34,10 +34,12 @@
 
 #if defined(__BPF_FEATURE_ADDR_SPACE_CAST) && !defined(BPF_ARENA_FORCE_ASM)
 #define __arena __attribute__((address_space(1)))
+#define __arena_global __attribute__((address_space(1)))
 #define cast_kern(ptr) /* nop for bpf prog. emitted by LLVM */
 #define cast_user(ptr) /* nop for bpf prog. emitted by LLVM */
 #else
 #define __arena
+#define __arena_global SEC(".addr_space.1")
 #define cast_kern(ptr) bpf_addr_space_cast(ptr, 0, 1)
 #define cast_user(ptr) bpf_addr_space_cast(ptr, 1, 0)
 #endif
diff --git a/tools/testing/selftests/bpf/progs/arena_atomics.c b/tools/testing/selftests/bpf/progs/arena_atomics.c
index 55f10563208d..77a4dfa9cdf9 100644
--- a/tools/testing/selftests/bpf/progs/arena_atomics.c
+++ b/tools/testing/selftests/bpf/progs/arena_atomics.c
@@ -25,20 +25,13 @@ bool skip_tests = true;
 
 __u32 pid = 0;
 
-#undef __arena
-#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
-#define __arena __attribute__((address_space(1)))
-#else
-#define __arena SEC(".addr_space.1")
-#endif
-
-__u64 __arena add64_value = 1;
-__u64 __arena add64_result = 0;
-__u32 __arena add32_value = 1;
-__u32 __arena add32_result = 0;
-__u64 __arena add_stack_value_copy = 0;
-__u64 __arena add_stack_result = 0;
-__u64 __arena add_noreturn_value = 1;
+__u64 __arena_global add64_value = 1;
+__u64 __arena_global add64_result = 0;
+__u32 __arena_global add32_value = 1;
+__u32 __arena_global add32_result = 0;
+__u64 __arena_global add_stack_value_copy = 0;
+__u64 __arena_global add_stack_result = 0;
+__u64 __arena_global add_noreturn_value = 1;
 
 SEC("raw_tp/sys_enter")
 int add(const void *ctx)
@@ -58,13 +51,13 @@ int add(const void *ctx)
 	return 0;
 }
 
-__s64 __arena sub64_value = 1;
-__s64 __arena sub64_result = 0;
-__s32 __arena sub32_value = 1;
-__s32 __arena sub32_result = 0;
-__s64 __arena sub_stack_value_copy = 0;
-__s64 __arena sub_stack_result = 0;
-__s64 __arena sub_noreturn_value = 1;
+__s64 __arena_global sub64_value = 1;
+__s64 __arena_global sub64_result = 0;
+__s32 __arena_global sub32_value = 1;
+__s32 __arena_global sub32_result = 0;
+__s64 __arena_global sub_stack_value_copy = 0;
+__s64 __arena_global sub_stack_result = 0;
+__s64 __arena_global sub_noreturn_value = 1;
 
 SEC("raw_tp/sys_enter")
 int sub(const void *ctx)
@@ -84,8 +77,8 @@ int sub(const void *ctx)
 	return 0;
 }
 
-__u64 __arena and64_value = (0x110ull << 32);
-__u32 __arena and32_value = 0x110;
+__u64 __arena_global and64_value = (0x110ull << 32);
+__u32 __arena_global and32_value = 0x110;
 
 SEC("raw_tp/sys_enter")
 int and(const void *ctx)
@@ -101,8 +94,8 @@ int and(const void *ctx)
 	return 0;
 }
 
-__u32 __arena or32_value = 0x110;
-__u64 __arena or64_value = (0x110ull << 32);
+__u32 __arena_global or32_value = 0x110;
+__u64 __arena_global or64_value = (0x110ull << 32);
 
 SEC("raw_tp/sys_enter")
 int or(const void *ctx)
@@ -117,8 +110,8 @@ int or(const void *ctx)
 	return 0;
 }
 
-__u64 __arena xor64_value = (0x110ull << 32);
-__u32 __arena xor32_value = 0x110;
+__u64 __arena_global xor64_value = (0x110ull << 32);
+__u32 __arena_global xor32_value = 0x110;
 
 SEC("raw_tp/sys_enter")
 int xor(const void *ctx)
@@ -133,12 +126,12 @@ int xor(const void *ctx)
 	return 0;
 }
 
-__u32 __arena cmpxchg32_value = 1;
-__u32 __arena cmpxchg32_result_fail = 0;
-__u32 __arena cmpxchg32_result_succeed = 0;
-__u64 __arena cmpxchg64_value = 1;
-__u64 __arena cmpxchg64_result_fail = 0;
-__u64 __arena cmpxchg64_result_succeed = 0;
+__u32 __arena_global cmpxchg32_value = 1;
+__u32 __arena_global cmpxchg32_result_fail = 0;
+__u32 __arena_global cmpxchg32_result_succeed = 0;
+__u64 __arena_global cmpxchg64_value = 1;
+__u64 __arena_global cmpxchg64_result_fail = 0;
+__u64 __arena_global cmpxchg64_result_succeed = 0;
 
 SEC("raw_tp/sys_enter")
 int cmpxchg(const void *ctx)
@@ -156,10 +149,10 @@ int cmpxchg(const void *ctx)
 	return 0;
 }
 
-__u64 __arena xchg64_value = 1;
-__u64 __arena xchg64_result = 0;
-__u32 __arena xchg32_value = 1;
-__u32 __arena xchg32_result = 0;
+__u64 __arena_global xchg64_value = 1;
+__u64 __arena_global xchg64_result = 0;
+__u32 __arena_global xchg32_value = 1;
+__u32 __arena_global xchg32_result = 0;
 
 SEC("raw_tp/sys_enter")
 int xchg(const void *ctx)
-- 
2.45.2


