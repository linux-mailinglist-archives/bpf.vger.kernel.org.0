Return-Path: <bpf+bounces-33238-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B20B91A23E
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 11:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49ECE1C213A7
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 09:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B4E132494;
	Thu, 27 Jun 2024 09:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TH1M3Cv0"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A7813A87A
	for <bpf@vger.kernel.org>; Thu, 27 Jun 2024 09:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719479369; cv=none; b=ULlLnlnHY5idBmlBXCmzET/i1Y3eqGMu2Dnvf2pbWItwiGv6V+5HweZDPqUJnIYYq4Mks6TympaQBrBWZcjtINW/hRKSjZAeqqCbAKg0WG4aarBrDC+BWd7X4jRBarQiSHsm5NmbumuTErrIEDMDPTysRKlEHNYIdzNtiD/H+Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719479369; c=relaxed/simple;
	bh=Z1h2AR2M5YDStsB7DUl17m3Bh1O/5Fa3CJyg8wKVwDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YnfT54y3WnIWL/AShX4ixEqIadImwb/T2Y7ZoYbthAxJz71n13KKHUF1TQcQ/XKfuTm1SVsPl5D1OCGFUVt87uFqolkLX18UHxVloEtXvo3X19W539aBirLTO56H1yTfXGxfdbLVVwNw6JTHdL0G9bU998FSz+JCB4EdQFhGYNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TH1M3Cv0; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45R6KCvF014930;
	Thu, 27 Jun 2024 09:09:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=1oPwgGHBhQ/OW
	iggrQCY3V6dQp66SGcJdeaxVVguZqg=; b=TH1M3Cv0s+DC1YbbDedO4StfeNlDg
	9Fk5GTq6oHz0w+BvqplnKCuSAQakJb4wn/ajD/Ug+Yf0mG7QI5HWeaGgcs0mW4ks
	0iiHjyEzm5CMUFRshycri9Oek7h0H/qV6FfGY59gnQPia+IeuzcOz9y8kSGty8UV
	H9UvsqR8RUsTz6T0X1zly8IFrtnpkwqBLoFwL1y7EDIIaYCvPaEMJg6NPY58qD6d
	pGROZYaXaFmSxMwsC9I53byol/FQcz5pvKReqj4f2W9VGKzK105ibtaejpkdh3tW
	JGTGFsG0+3nFMbAxTygFy9hjjxdgSexDq9K3k+dhzlzZhr1iT2H0YuCzQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4012dcrfsa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 09:09:15 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45R69NkW032376;
	Thu, 27 Jun 2024 09:09:14 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yxbn3hh29-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 09:09:14 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45R9999Q57803066
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 09:09:11 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 43B802004F;
	Thu, 27 Jun 2024 09:09:09 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B21D02004D;
	Thu, 27 Jun 2024 09:09:08 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.16.175])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Jun 2024 09:09:08 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 09/10] selftests/bpf: Add UAF tests for arena atomics
Date: Thu, 27 Jun 2024 11:07:12 +0200
Message-ID: <20240627090900.20017-10-iii@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240627090900.20017-1-iii@linux.ibm.com>
References: <20240627090900.20017-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: sYqiAsSiYTfdD1lSGj9UjeU9zaW1Ycbd
X-Proofpoint-GUID: sYqiAsSiYTfdD1lSGj9UjeU9zaW1Ycbd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-27_05,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=832
 malwarescore=0 impostorscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406270067

Check that __sync_*() functions don't cause kernel panics when handling
freed arena pages.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 .../selftests/bpf/prog_tests/arena_atomics.c  | 16 +++++++
 .../selftests/bpf/progs/arena_atomics.c       | 43 +++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/arena_atomics.c b/tools/testing/selftests/bpf/prog_tests/arena_atomics.c
index 0807a48a58ee..38eef4cc5c80 100644
--- a/tools/testing/selftests/bpf/prog_tests/arena_atomics.c
+++ b/tools/testing/selftests/bpf/prog_tests/arena_atomics.c
@@ -146,6 +146,20 @@ static void test_xchg(struct arena_atomics *skel)
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
+}
+
 void test_arena_atomics(void)
 {
 	struct arena_atomics *skel;
@@ -180,6 +194,8 @@ void test_arena_atomics(void)
 		test_cmpxchg(skel);
 	if (test__start_subtest("xchg"))
 		test_xchg(skel);
+	if (test__start_subtest("uaf"))
+		test_uaf(skel);
 
 cleanup:
 	arena_atomics__destroy(skel);
diff --git a/tools/testing/selftests/bpf/progs/arena_atomics.c b/tools/testing/selftests/bpf/progs/arena_atomics.c
index 55f10563208d..a86c8cdf1a30 100644
--- a/tools/testing/selftests/bpf/progs/arena_atomics.c
+++ b/tools/testing/selftests/bpf/progs/arena_atomics.c
@@ -176,3 +176,46 @@ int xchg(const void *ctx)
 
 	return 0;
 }
+
+SEC("syscall")
+int uaf(const void *ctx)
+{
+	if (pid != (bpf_get_current_pid_tgid() >> 32))
+		return 0;
+#ifdef ENABLE_ATOMICS_TESTS
+	void __arena *page;
+
+	page = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
+	bpf_arena_free_pages(&arena, page, 1);
+
+	__sync_fetch_and_add((__u32 __arena *)page, 1);
+	__sync_add_and_fetch((__u32 __arena *)page, 1);
+	__sync_fetch_and_sub((__u32 __arena *)page, 1);
+	__sync_sub_and_fetch((__u32 __arena *)page, 1);
+	__sync_fetch_and_and((__u32 __arena *)page, 1);
+	__sync_and_and_fetch((__u32 __arena *)page, 1);
+	__sync_fetch_and_or((__u32 __arena *)page, 1);
+	__sync_or_and_fetch((__u32 __arena *)page, 1);
+	__sync_fetch_and_xor((__u32 __arena *)page, 1);
+	__sync_xor_and_fetch((__u32 __arena *)page, 1);
+	__sync_val_compare_and_swap((__u32 __arena *)page, 0, 1);
+	__sync_lock_test_and_set((__u32 __arena *)page, 1);
+
+	__sync_fetch_and_add((__u64 __arena *)page, 1);
+	__sync_add_and_fetch((__u64 __arena *)page, 1);
+	__sync_fetch_and_sub((__u64 __arena *)page, 1);
+	__sync_sub_and_fetch((__u64 __arena *)page, 1);
+	__sync_fetch_and_and((__u64 __arena *)page, 1);
+	__sync_and_and_fetch((__u64 __arena *)page, 1);
+	__sync_fetch_and_or((__u64 __arena *)page, 1);
+	__sync_or_and_fetch((__u64 __arena *)page, 1);
+	__sync_fetch_and_xor((__u64 __arena *)page, 1);
+	__sync_xor_and_fetch((__u64 __arena *)page, 1);
+	__sync_val_compare_and_swap((__u64 __arena *)page, 0, 1);
+	__sync_lock_test_and_set((__u64 __arena *)page, 1);
+#endif
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.45.2


