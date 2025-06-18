Return-Path: <bpf+bounces-61010-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD00FADF977
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 00:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C8C54A0D47
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 22:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F73427EFF2;
	Wed, 18 Jun 2025 22:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="TcDS/h+n"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B762192F9
	for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 22:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750286021; cv=none; b=A60gfsfsRlopDQABusfeVQilnUsbWOyew8HSXUY8R+yAtgCwHl2jRpF9bx3pBBVqHsJ5HVfz+lts80fWhN2qgbloSOZ8FtpJzsG299uT69TOJuS3ty/BKfNH5soVKGcUnstqu1Ja29NTVImZxjB6ynaHVoJ4/jL1VyyqhEvU0+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750286021; c=relaxed/simple;
	bh=M8a2fGQIQgf8ZKh7pArKQ1BUAqV2Nu0wJE2Gqqo4Wl4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fQ8/nYazwlyjJxVtnsruRlvSlJlxPOeCG/o0PYdpk7sgkKNO/NQ9OhT0oePra7N+hiXXH4hZtWYQWGaVYSPMr6xDaoNubyyPiHBBfAK6AQyT+kiddylrnt2JS1RktGAXNkD0i67/ac0ebbx8cnf24c9YMAZYF9HF5X7AyRRL2Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=TcDS/h+n; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55ILVUJg015445
	for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 15:33:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	s2048-2021-q4; bh=azn0ndLaawlbnFZ5YwOLd19ACqhL5xdS74WVLr3c8hs=; b=
	TcDS/h+nxyQE5oxIgmRbsrsM+UIIJ/Qp5/gBioqbX8ZqDa4EZzrxlJ1zmb0m2Qkr
	mHghC4ixPC/9ZHPZ9qW3YcRhcZEhaHSTe6zblW3Ak7UAO7oShtlAt2Z40tzOkXMV
	sgIjUt7+sdcONjfpoM2op4umULdNT2pdAclyvnQknFoEhaSS3af+pWubvQuSL+y3
	lkGl9r4D6f8+hA9S0gAGhri8DU1kvQdUuojp/px/jQJJY0mkKgvgvQNsnV80ptWY
	nPAZV1AIHMbp8eQXK6m3ANmWFYxrHNwBH8JYi17R66m4mp5ruGwIqIxvh43+gbbU
	7xVRw4fokTphMUIcYjb2dA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 47bq0w6x3y-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 15:33:39 -0700 (PDT)
Received: from twshared18532.02.prn5.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Wed, 18 Jun 2025 22:33:37 +0000
Received: by devvm7589.cco0.facebook.com (Postfix, from userid 669379)
	id 0A36610E0AF1; Wed, 18 Jun 2025 15:33:23 -0700 (PDT)
From: Ihor Solodrai <isolodrai@meta.com>
To: <andrii@kernel.org>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <eddyz87@gmail.com>, <mykolal@fb.com>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: add test cases for bpf_dynptr_memset()
Date: Wed, 18 Jun 2025 15:33:10 -0700
Message-ID: <20250618223310.3684760-2-isolodrai@meta.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250618223310.3684760-1-isolodrai@meta.com>
References: <20250618223310.3684760-1-isolodrai@meta.com>
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
X-Proofpoint-GUID: wa0gQD-w9nqcx8xPRkZ_pdZeXItCYDXB
X-Proofpoint-ORIG-GUID: wa0gQD-w9nqcx8xPRkZ_pdZeXItCYDXB
X-Authority-Analysis: v=2.4 cv=B4y50PtM c=1 sm=1 tr=0 ts=68533ec3 cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=6IFa9wvqVegA:10 a=VabnemYjAAAA:8 a=MFolwW6AnDV2iu3axIAA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDE5NCBTYWx0ZWRfX5BSuwyLDoFMv BaUlfHtmJV6p92bwPTHQPvGQvZp5JbgZMcZNn7PrH5YG9hZ+8EH4ASKqR2l10Nv6NkC4YM3j9UB 1iaY5le5wqFy/G3ZOj3u8+Ezlke0p/7s6MyMONQhvHR1hjiZDQigeQJMH29kJalr6RhwgbMxpkx
 5cuj81rtGDt3fJzbrtW60raisrMtN301UlydQGYM+DC/aqZC2V7itz3fRILUw9c7QNo46VG8fll qUazqCCLuYGB+vh4pCR3vKIzQbzzXbtXtXuaMjRwtufSD2oU1btMZ9PrvGmNKP/s+KLageeIVVb 7NrY3LRKnnmbsZcCKL9gE1dLlUU05NugfstpA36Mok8eISXmWB2NOPapwT+P4wHWzWmwCmB4IKZ
 6/McBBcRriEPiRy4Wvi+bn8u/kQ+c2lmPI+W2q//fboK8KJGmH7p6cEEMhb9EOHaGJA3czr7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_06,2025-06-18_03,2025-03-28_01

Add tests to verify the behavior of bpf_dynptr_memset():
  * normal memset 0
  * memset in dynptr that was adjusted
  * error: size overflow
  * error: readonly dynptr

Signed-off-by: Ihor Solodrai <isolodrai@meta.com>
---
 .../testing/selftests/bpf/prog_tests/dynptr.c |  4 ++
 .../selftests/bpf/progs/dynptr_success.c      | 66 +++++++++++++++++++
 2 files changed, 70 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/dynptr.c b/tools/test=
ing/selftests/bpf/prog_tests/dynptr.c
index 62e7ec775f24..423e95755aa0 100644
--- a/tools/testing/selftests/bpf/prog_tests/dynptr.c
+++ b/tools/testing/selftests/bpf/prog_tests/dynptr.c
@@ -21,6 +21,10 @@ static struct {
 	{"test_dynptr_data", SETUP_SYSCALL_SLEEP},
 	{"test_dynptr_copy", SETUP_SYSCALL_SLEEP},
 	{"test_dynptr_copy_xdp", SETUP_XDP_PROG},
+	{"test_dynptr_memset_zero", SETUP_SYSCALL_SLEEP},
+	{"test_dynptr_memset_zero_offset", SETUP_SYSCALL_SLEEP},
+	{"test_dynptr_memset_overflow", SETUP_SYSCALL_SLEEP},
+	{"test_dynptr_memset_readonly", SETUP_SKB_PROG},
 	{"test_ringbuf", SETUP_SYSCALL_SLEEP},
 	{"test_skb_readonly", SETUP_SKB_PROG},
 	{"test_dynptr_skb_data", SETUP_SKB_PROG},
diff --git a/tools/testing/selftests/bpf/progs/dynptr_success.c b/tools/t=
esting/selftests/bpf/progs/dynptr_success.c
index a0391f9da2d4..204e02816947 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_success.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
@@ -681,6 +681,72 @@ int test_dynptr_copy_xdp(struct xdp_md *xdp)
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
+	err =3D err ?: bpf_dynptr_memset(&ptr, 0, data_sz);
+	err =3D err ?: bpf_memcmp(zeroes, memset_zero_data, data_sz);
+
+	return 0;
+}
+
+char memset_zero_offset_data[] =3D "data to be zeroed partially";
+
+SEC("?tp/syscalls/sys_enter_nanosleep")
+int test_dynptr_memset_zero_offset(void *ctx)
+{
+	char expected[] =3D "data\0\0\0\0be zeroed partially";
+	__u32 data_sz =3D sizeof(memset_zero_offset_data);
+	struct bpf_dynptr ptr;
+
+	err =3D bpf_dynptr_from_mem(memset_zero_offset_data, data_sz, 0, &ptr);
+	err =3D err ?: bpf_dynptr_adjust(&ptr, 4, 8);
+	err =3D err ?: bpf_dynptr_memset(&ptr, 0, bpf_dynptr_size(&ptr));
+	err =3D err ?: bpf_memcmp(expected, memset_zero_offset_data, data_sz);
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
+	ret =3D bpf_dynptr_memset(&ptr, 0, data_sz + 1);
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
+	ret =3D bpf_dynptr_memset(&ptr, 0, bpf_dynptr_size(&ptr));
+	if (ret !=3D -EINVAL)
+		err =3D 1;
+
+	return 0;
+}
+
 void *user_ptr;
 /* Contains the copy of the data pointed by user_ptr.
  * Size 384 to make it not fit into a single kernel chunk when copying
--=20
2.47.1


