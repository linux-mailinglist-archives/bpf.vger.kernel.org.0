Return-Path: <bpf+bounces-61439-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA25AAE711B
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 22:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A9401BC075B
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 20:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC823595C;
	Tue, 24 Jun 2025 20:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="MbAt+7Vs"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB5D2E8E0B
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 20:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750798399; cv=none; b=AE9SgIPZdfqlDKS9OaT59u/pXDAUDfN+b+bOv4QMt2ubDHTxdtSIeLNwXBMgxjwnWnhhx10m0IjSZVN3grU06lhYR3+ynzDjs9REPAmeQ+BxcvoWYdNLPWyGzP98e7AsecuSeOJnsRrd285qptJViLqX/oN1Q4DIRZI9Py9kDcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750798399; c=relaxed/simple;
	bh=u1CqfJvi2s1YLI+1eGOMKRS+eeyyu3OpIv5ppl17PUw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fOMeG8ACty+5rKERwRjDxwmUtpV0OIr3jqFIyqmtbJk9bklMht46vaqnYTZBwXizwcHW1poZqfrPEWA8EQPbQhjTb7D4nCKM8dlIXYovrLiC27VPWn5FoUlyRreJtxYZHR9yd2dTh/X4EOwef5qbHYQCaZ1UOOC8v0hQFZqh6ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=MbAt+7Vs; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 55OKq6vY020346
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 13:53:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	s2048-2021-q4; bh=Uq8ASCnPUbrjmCBWVC85wKSY7Am2nVY7W7uwDWH9/xc=; b=
	MbAt+7Vs1TEF1JyEa4x7nQbFbHPy2I6/0iJNJeuaUILO/11NqlDCxz/n/N5En4os
	z2tOvm2CoYZvW1RA8mXtPqFodOrZ+KFFaeY42Jmb6ugOONV9QzbEzGoqzaxp7R4t
	HLlqJg3kz++rWgXmBQuKjgQjxJX1lDvin1lcGUEAsH8iCziKYrIrDZgi+wGqQjO/
	7sTqBTAGY0PkLvDG+YEEpUwk/L6RHk8q7yc6LVQJY6NEC8IrzwrJ0/uo1VEQndPV
	E+48z09zOqc5Kn24CLO+Br/7Aw8uqMwtWhsRQL9EmGNAHFHowd+RPWOLLcdDOkRT
	Mt11ouo7PgSgT/BK3R9eMg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 47f0a1q2h2-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 13:53:16 -0700 (PDT)
Received: from twshared91430.14.prn3.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Tue, 24 Jun 2025 20:53:14 +0000
Received: by devvm7589.cco0.facebook.com (Postfix, from userid 669379)
	id 52AD1166AA01; Tue, 24 Jun 2025 13:52:58 -0700 (PDT)
From: Ihor Solodrai <isolodrai@meta.com>
To: <bpf@vger.kernel.org>
CC: <andrii@kernel.org>, <ast@kernel.org>, <eddyz87@gmail.com>,
        <mykyta.yatsenko5@gmail.com>, <mykolal@fb.com>, <kernel-team@meta.com>
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: add test cases for bpf_dynptr_memset()
Date: Tue, 24 Jun 2025 13:52:40 -0700
Message-ID: <20250624205240.1311453-3-isolodrai@meta.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250624205240.1311453-1-isolodrai@meta.com>
References: <20250624205240.1311453-1-isolodrai@meta.com>
Reply-To: <ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: IygD-WJMv6hexTWtDxK0KeOiTZmqbeyT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDE2NiBTYWx0ZWRfXxh4g/GgRRn5Z 0PC9HWOnYO8GJS9OC2Ny/Rlc+BLe/pIb240Uj7HzfjlmDMXQ89THX28Hh6JKFY5s0SzOc5x2Jdj 7wkJj0XzDnzxUHFAhjc5He8fAPvA1Zd5WSOi5xlvhetX3EFhS1T/0xwKwFDVubTjUVTSJ+Mrom6
 WEfAtUe3mnuqmRbxxH0h+ImgbHr2TSqzhoCdG0yqqhdsDC9p8Qe7sQrpXQsM8NxQ6zXbBJN4JEm 5yG07pRdKvNuFBVUjEias4rXhjn0ZBl5oQ0KUZ2n5uA9ghpg9eg2ncr4B/IFKXXFvfsSnJgh/8s aT1bZkQ5u4Hk1fBNdL4bVpOy1RbdURmF8a1OKnnPFyPY1BUXpj0L3sRDgvJYOam4Yeh2WOnC7aN
 qxWiJgHaQfVC4oQuIectNSxDMA0VBgv8eWVFoxzNBkbeeo4Jd3ICU/7tRRcUWAc2eJEVJS/4
X-Authority-Analysis: v=2.4 cv=BuudwZX5 c=1 sm=1 tr=0 ts=685b103c cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=6IFa9wvqVegA:10 a=VabnemYjAAAA:8 a=kz5PBBbPer8UiGpu3bUA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: IygD-WJMv6hexTWtDxK0KeOiTZmqbeyT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_06,2025-06-23_07,2025-03-28_01

Add tests to verify the behavior of bpf_dynptr_memset():
  * normal memset 0
  * normal memset non-0
  * memset with an offset
  * memset in dynptr that was adjusted
  * error: size overflow
  * error: offset+size overflow
  * error: readonly dynptr
  * memset into non-linear xdp dynptr

Signed-off-by: Ihor Solodrai <isolodrai@meta.com>
---
 .../testing/selftests/bpf/prog_tests/dynptr.c |   8 +
 .../selftests/bpf/progs/dynptr_success.c      | 164 ++++++++++++++++++
 2 files changed, 172 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/dynptr.c b/tools/test=
ing/selftests/bpf/prog_tests/dynptr.c
index 62e7ec775f24..f2b65398afce 100644
--- a/tools/testing/selftests/bpf/prog_tests/dynptr.c
+++ b/tools/testing/selftests/bpf/prog_tests/dynptr.c
@@ -21,6 +21,14 @@ static struct {
 	{"test_dynptr_data", SETUP_SYSCALL_SLEEP},
 	{"test_dynptr_copy", SETUP_SYSCALL_SLEEP},
 	{"test_dynptr_copy_xdp", SETUP_XDP_PROG},
+	{"test_dynptr_memset_zero", SETUP_SYSCALL_SLEEP},
+	{"test_dynptr_memset_notzero", SETUP_SYSCALL_SLEEP},
+	{"test_dynptr_memset_zero_offset", SETUP_SYSCALL_SLEEP},
+	{"test_dynptr_memset_zero_adjusted", SETUP_SYSCALL_SLEEP},
+	{"test_dynptr_memset_overflow", SETUP_SYSCALL_SLEEP},
+	{"test_dynptr_memset_overflow_offset", SETUP_SYSCALL_SLEEP},
+	{"test_dynptr_memset_readonly", SETUP_SKB_PROG},
+	{"test_dynptr_memset_xdp_chunks", SETUP_XDP_PROG},
 	{"test_ringbuf", SETUP_SYSCALL_SLEEP},
 	{"test_skb_readonly", SETUP_SKB_PROG},
 	{"test_dynptr_skb_data", SETUP_SKB_PROG},
diff --git a/tools/testing/selftests/bpf/progs/dynptr_success.c b/tools/t=
esting/selftests/bpf/progs/dynptr_success.c
index a0391f9da2d4..61d9ae2c6a52 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_success.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
@@ -681,6 +681,170 @@ int test_dynptr_copy_xdp(struct xdp_md *xdp)
 	return XDP_DROP;
 }
=20
+char memset_zero_data[] =3D "data to be zeroed";
+
+SEC("?tp/syscalls/sys_enter_nanosleep")
+int test_dynptr_memset_zero(void *ctx)
+{
+	__u32 data_sz =3D sizeof(memset_zero_data);
+	char zeroes[32] =3D {'\0'};
+	struct bpf_dynptr ptr;
+
+	err =3D bpf_dynptr_from_mem(memset_zero_data, data_sz, 0, &ptr);
+	err =3D err ?: bpf_dynptr_memset(&ptr, 0, data_sz, 0);
+	err =3D err ?: bpf_memcmp(zeroes, memset_zero_data, data_sz);
+
+	return 0;
+}
+
+#define DYNPTR_MEMSET_VAL 42
+
+char memset_notzero_data[] =3D "data to be overwritten";
+
+SEC("?tp/syscalls/sys_enter_nanosleep")
+int test_dynptr_memset_notzero(void *ctx)
+{
+	u32 data_sz =3D sizeof(memset_notzero_data);
+	struct bpf_dynptr ptr;
+	char expected[32];
+
+	__builtin_memset(expected, DYNPTR_MEMSET_VAL, data_sz);
+
+	err =3D bpf_dynptr_from_mem(memset_notzero_data, data_sz, 0, &ptr);
+	err =3D err ?: bpf_dynptr_memset(&ptr, 0, data_sz, DYNPTR_MEMSET_VAL);
+	err =3D err ?: bpf_memcmp(expected, memset_notzero_data, data_sz);
+
+	return 0;
+}
+
+char memset_zero_offset_data[] =3D "data to be zeroed partially";
+
+SEC("?tp/syscalls/sys_enter_nanosleep")
+int test_dynptr_memset_zero_offset(void *ctx)
+{
+	char expected[] =3D "data to \0\0\0\0eroed partially";
+	__u32 data_sz =3D sizeof(memset_zero_offset_data);
+	struct bpf_dynptr ptr;
+
+	err =3D bpf_dynptr_from_mem(memset_zero_offset_data, data_sz, 0, &ptr);
+	err =3D err ?: bpf_dynptr_memset(&ptr, 8, 4, 0);
+	err =3D err ?: bpf_memcmp(expected, memset_zero_offset_data, data_sz);
+
+	return 0;
+}
+
+char memset_zero_adjusted_data[] =3D "data to be zeroed partially";
+
+SEC("?tp/syscalls/sys_enter_nanosleep")
+int test_dynptr_memset_zero_adjusted(void *ctx)
+{
+	char expected[] =3D "data\0\0\0\0be zeroed partially";
+	__u32 data_sz =3D sizeof(memset_zero_adjusted_data);
+	struct bpf_dynptr ptr;
+
+	err =3D bpf_dynptr_from_mem(memset_zero_adjusted_data, data_sz, 0, &ptr=
);
+	err =3D err ?: bpf_dynptr_adjust(&ptr, 4, 8);
+	err =3D err ?: bpf_dynptr_memset(&ptr, 0, bpf_dynptr_size(&ptr), 0);
+	err =3D err ?: bpf_memcmp(expected, memset_zero_adjusted_data, data_sz)=
;
+
+	return 0;
+}
+
+char memset_overflow_data[] =3D "memset overflow data";
+
+SEC("?tp/syscalls/sys_enter_nanosleep")
+int test_dynptr_memset_overflow(void *ctx)
+{
+	__u32 data_sz =3D sizeof(memset_overflow_data);
+	struct bpf_dynptr ptr;
+	int ret;
+
+	err =3D bpf_dynptr_from_mem(memset_overflow_data, data_sz, 0, &ptr);
+	ret =3D bpf_dynptr_memset(&ptr, 0, data_sz + 1, 0);
+	if (ret !=3D -E2BIG)
+		err =3D 1;
+
+	return 0;
+}
+
+SEC("?tp/syscalls/sys_enter_nanosleep")
+int test_dynptr_memset_overflow_offset(void *ctx)
+{
+	__u32 data_sz =3D sizeof(memset_overflow_data);
+	struct bpf_dynptr ptr;
+	int ret;
+
+	err =3D bpf_dynptr_from_mem(memset_overflow_data, data_sz, 0, &ptr);
+	ret =3D bpf_dynptr_memset(&ptr, 1, data_sz, 0);
+	if (ret !=3D -E2BIG)
+		err =3D 1;
+
+	return 0;
+}
+
+SEC("?cgroup_skb/egress")
+int test_dynptr_memset_readonly(struct __sk_buff *skb)
+{
+	struct bpf_dynptr ptr;
+	int ret;
+
+	err =3D bpf_dynptr_from_skb(skb, 0, &ptr);
+
+	/* cgroup skbs are read only, memset should fail */
+	ret =3D bpf_dynptr_memset(&ptr, 0, bpf_dynptr_size(&ptr), 0);
+	if (ret !=3D -EINVAL)
+		err =3D 1;
+
+	return 0;
+}
+
+SEC("xdp")
+int test_dynptr_memset_xdp_chunks(struct xdp_md *xdp)
+{
+	const int max_chunks =3D 200;
+	struct bpf_dynptr ptr_xdp;
+	u32 data_sz, offset =3D 0;
+	char expected_buf[32];
+	char buf[32];
+	int i;
+
+	__builtin_memset(expected_buf, DYNPTR_MEMSET_VAL, sizeof(expected_buf))=
;
+
+	/* ptr_xdp is backed by non-contiguous memory */
+	bpf_dynptr_from_xdp(xdp, 0, &ptr_xdp);
+	data_sz =3D bpf_dynptr_size(&ptr_xdp);
+
+	err =3D bpf_dynptr_memset(&ptr_xdp, 0, data_sz, DYNPTR_MEMSET_VAL);
+	if (err)
+		goto out;
+
+	bpf_for(i, 0, max_chunks) {
+		offset =3D i * sizeof(buf);
+		err =3D bpf_dynptr_read(&buf, sizeof(buf), &ptr_xdp, offset, 0);
+		switch (err) {
+		case 0:
+			break;
+		case -E2BIG:
+			goto handle_tail;
+		default:
+			goto out;
+		}
+		err =3D bpf_memcmp(buf, expected_buf, sizeof(buf));
+		if (err)
+			goto out;
+	}
+
+handle_tail:
+	if (data_sz - offset < sizeof(buf)) {
+		err =3D bpf_dynptr_read(&buf, data_sz - offset, &ptr_xdp, offset, 0);
+		if (err)
+			goto out;
+		err =3D bpf_memcmp(buf, expected_buf, data_sz - offset);
+	}
+out:
+	return XDP_DROP;
+}
+
 void *user_ptr;
 /* Contains the copy of the data pointed by user_ptr.
  * Size 384 to make it not fit into a single kernel chunk when copying
--=20
2.47.1


