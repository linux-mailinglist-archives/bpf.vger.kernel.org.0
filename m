Return-Path: <bpf+bounces-33493-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D993391E0D2
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 15:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BD071F21F90
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 13:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FAD15EFAF;
	Mon,  1 Jul 2024 13:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fWxHMbL0"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11AC15ECE4
	for <bpf@vger.kernel.org>; Mon,  1 Jul 2024 13:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719840901; cv=none; b=CRV5o4qD3vD0o4yQvgEE0d5QU0ati98O/zmGedMk0HkYN9C3UnRR7NsMpJrG9JWefXulJME2VGOi9cIvk8R2dzq6ygV7dbxZjcVzLmSA3cEDQKrcxYbf+M56jzuOwRSDYZ8k5xe2QcZSoz+Kb+IY2vl8eO/jB1wVFAVELYUAS2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719840901; c=relaxed/simple;
	bh=tzv64ZERevu1OP2l2WPzpC78NXf2qWItRvq4AK0eN84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NtxUUDGGHiBFuuYj9uWZOV9oMPQvsISKdG3NK5ohHNadSC9C1Kn++/hxFWF/KLDtBcwdT+StYJRHnKJqp3lMrjVwwoc2xKcZdmRYCaizkcQeo8B8x/pLG48zFwIxXsTmRpD5v+fFavuewPAt2WS0vTRF19M3EneZDnDjAk/tzXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fWxHMbL0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 461Cwf9O032397;
	Mon, 1 Jul 2024 13:34:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=szTacbeH7HM99
	30d5VOHCT4Xm5l7xMw/OoGX7KvOIFc=; b=fWxHMbL0LBmFTPgEtxW9hPRMAopTm
	WQrxR7Nel91do7cbS6zwve+/3OvMByTevlO2kTDu2rdmX0G2HbmhBWZN54Ff80oU
	yZGgRQc58CZQFHhUaflbMbBjirggBuB7eai9z14z85tVB1vgX5NxadgGQPImANEo
	azvIUyilVX6/VqGFlDcg3ZsKWRgNvl3rTZbC5iaYkbmOWfG50A+LNrwQJ7eW3K5M
	tV2fdSFdCKd950KC8OV3y7DRsR++UQaKurvgOy1+kQpg+COLqnAGnWBWIxM2vEXF
	2SNrv80AOUQTbdQH9ghmL7BdV884/pN4VTGty5+ppXB1dwp1cwW1LBR5g==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 403vx6r2x7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 13:34:47 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 461DKCfY024095;
	Mon, 1 Jul 2024 13:34:46 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 402ya372ts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 13:34:46 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 461DYeDw46137748
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jul 2024 13:34:42 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A3DEA2004D;
	Mon,  1 Jul 2024 13:34:40 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2AA4020040;
	Mon,  1 Jul 2024 13:34:40 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.179.5.21])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Jul 2024 13:34:40 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2 10/11] selftests/bpf: Add UAF tests for arena atomics
Date: Mon,  1 Jul 2024 15:24:48 +0200
Message-ID: <20240701133432.3883-11-iii@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240701133432.3883-1-iii@linux.ibm.com>
References: <20240701133432.3883-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MQsBPplyJMign7iSksT2YJqOYRVN5MYy
X-Proofpoint-ORIG-GUID: MQsBPplyJMign7iSksT2YJqOYRVN5MYy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_12,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 mlxlogscore=909 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407010103

Check that __sync_*() functions don't cause kernel panics when handling
freed arena pages.

x86_64 does not support some arena atomics yet, and aarch64 may or may
not support them, based on the availability of LSE atomics at run time.
Do not enable this test for these architectures for simplicity.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 .../selftests/bpf/prog_tests/arena_atomics.c  | 18 +++++
 .../selftests/bpf/progs/arena_atomics.c       | 76 +++++++++++++++++++
 2 files changed, 94 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/arena_atomics.c b/tools/testing/selftests/bpf/prog_tests/arena_atomics.c
index 0807a48a58ee..26e7c06c6cb4 100644
--- a/tools/testing/selftests/bpf/prog_tests/arena_atomics.c
+++ b/tools/testing/selftests/bpf/prog_tests/arena_atomics.c
@@ -146,6 +146,22 @@ static void test_xchg(struct arena_atomics *skel)
 	ASSERT_EQ(skel->arena->xchg32_result, 1, "xchg32_result");
 }
 
+static void test_uaf(struct arena_atomics *skel)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	int err, prog_fd;
+
+	/* No need to attach it, just run it directly */
+	prog_fd = bpf_program__fd(skel->progs.uaf);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	if (!ASSERT_OK(err, "test_run_opts err"))
+		return;
+	if (!ASSERT_OK(topts.retval, "test_run_opts retval"))
+		return;
+
+	ASSERT_EQ(skel->arena->uaf_recovery_fails, 0, "uaf_recovery_fails");
+}
+
 void test_arena_atomics(void)
 {
 	struct arena_atomics *skel;
@@ -180,6 +196,8 @@ void test_arena_atomics(void)
 		test_cmpxchg(skel);
 	if (test__start_subtest("xchg"))
 		test_xchg(skel);
+	if (test__start_subtest("uaf"))
+		test_uaf(skel);
 
 cleanup:
 	arena_atomics__destroy(skel);
diff --git a/tools/testing/selftests/bpf/progs/arena_atomics.c b/tools/testing/selftests/bpf/progs/arena_atomics.c
index 55f10563208d..0ea310713fe6 100644
--- a/tools/testing/selftests/bpf/progs/arena_atomics.c
+++ b/tools/testing/selftests/bpf/progs/arena_atomics.c
@@ -176,3 +176,79 @@ int xchg(const void *ctx)
 
 	return 0;
 }
+
+__u64 __arena uaf_sink;
+volatile __u64 __arena uaf_recovery_fails;
+
+SEC("syscall")
+int uaf(const void *ctx)
+{
+	if (pid != (bpf_get_current_pid_tgid() >> 32))
+		return 0;
+#if defined(ENABLE_ATOMICS_TESTS) && !defined(__TARGET_ARCH_arm64) && \
+    !defined(__TARGET_ARCH_x86)
+	__u32 __arena *page32;
+	__u64 __arena *page64;
+	void __arena *page;
+
+	page = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
+	bpf_arena_free_pages(&arena, page, 1);
+	uaf_recovery_fails = 24;
+
+	page32 = (__u32 __arena *)page;
+	uaf_sink += __sync_fetch_and_add(page32, 1);
+	uaf_recovery_fails -= 1;
+	__sync_add_and_fetch(page32, 1);
+	uaf_recovery_fails -= 1;
+	uaf_sink += __sync_fetch_and_sub(page32, 1);
+	uaf_recovery_fails -= 1;
+	__sync_sub_and_fetch(page32, 1);
+	uaf_recovery_fails -= 1;
+	uaf_sink += __sync_fetch_and_and(page32, 1);
+	uaf_recovery_fails -= 1;
+	__sync_and_and_fetch(page32, 1);
+	uaf_recovery_fails -= 1;
+	uaf_sink += __sync_fetch_and_or(page32, 1);
+	uaf_recovery_fails -= 1;
+	__sync_or_and_fetch(page32, 1);
+	uaf_recovery_fails -= 1;
+	uaf_sink += __sync_fetch_and_xor(page32, 1);
+	uaf_recovery_fails -= 1;
+	__sync_xor_and_fetch(page32, 1);
+	uaf_recovery_fails -= 1;
+	uaf_sink += __sync_val_compare_and_swap(page32, 0, 1);
+	uaf_recovery_fails -= 1;
+	uaf_sink += __sync_lock_test_and_set(page32, 1);
+	uaf_recovery_fails -= 1;
+
+	page64 = (__u64 __arena *)page;
+	uaf_sink += __sync_fetch_and_add(page64, 1);
+	uaf_recovery_fails -= 1;
+	__sync_add_and_fetch(page64, 1);
+	uaf_recovery_fails -= 1;
+	uaf_sink += __sync_fetch_and_sub(page64, 1);
+	uaf_recovery_fails -= 1;
+	__sync_sub_and_fetch(page64, 1);
+	uaf_recovery_fails -= 1;
+	uaf_sink += __sync_fetch_and_and(page64, 1);
+	uaf_recovery_fails -= 1;
+	__sync_and_and_fetch(page64, 1);
+	uaf_recovery_fails -= 1;
+	uaf_sink += __sync_fetch_and_or(page64, 1);
+	uaf_recovery_fails -= 1;
+	__sync_or_and_fetch(page64, 1);
+	uaf_recovery_fails -= 1;
+	uaf_sink += __sync_fetch_and_xor(page64, 1);
+	uaf_recovery_fails -= 1;
+	__sync_xor_and_fetch(page64, 1);
+	uaf_recovery_fails -= 1;
+	uaf_sink += __sync_val_compare_and_swap(page64, 0, 1);
+	uaf_recovery_fails -= 1;
+	uaf_sink += __sync_lock_test_and_set(page64, 1);
+	uaf_recovery_fails -= 1;
+#endif
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.45.2


