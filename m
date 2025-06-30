Return-Path: <bpf+bounces-61901-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F31B2AEE96B
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 23:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 011833AF6D7
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 21:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BEF61A0BE0;
	Mon, 30 Jun 2025 21:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="jkcjUWPJ"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01420224240
	for <bpf@vger.kernel.org>; Mon, 30 Jun 2025 21:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751318504; cv=none; b=Q/XhhLHw+R92Or2hGfwizPqvHULrCsjXKrlTCoL78h8OBDoD+AsCCubAleGB8/ohhm4f4OxV017jRPxTTSK+bfJfmkifGPDTJNjmT2xkCvx3NMb83tE95afdDTsOEvyH6krknoWRXz1qxhInjaMkFmwDS2IUfqcJ+sPK1c/LC2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751318504; c=relaxed/simple;
	bh=L6hKSJDZisT1LZaNrk9Ks8UANMtBypNuAEw/+RP/1V0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EQFPLqns705eXqlNxlarPLY3VjkFidHTWNqdw0H5JV0iBKudzAGuQE3mhuY8J2Gqt9HR8z6n3dlT7c4qDalMbiV+Mj3ZjdhjqdXWh8kb+qq7pR6cwBmkB83V/Zv4xuVH4Yv5ygsPrOJs7XDGUHnlM9Dl7ZO+nloChWSeZq9VXDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=jkcjUWPJ; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55UI8IG6001351
	for <bpf@vger.kernel.org>; Mon, 30 Jun 2025 14:21:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	s2048-2025-q2; bh=QiJxDljqsqXgQsXEszXPkK5Ie+1olocEUlkZLamRA3s=; b=
	jkcjUWPJA8eb2DUodeMjNKJ3ZQxEUwFFxEhq1lzxKOMrd2zPVIXJKltoNmn6rLTc
	wAaiYexYWoB6s7CooobNkrARkvYx+McPOcfRR4CkGUe6O0UvrkU6nQBwRUyn6T5k
	2D+5bXfoFBIZC2rDlCme+hZr4iLzKee4J6P2GSm3a/siJIreGZqMPKeHbuztqXmX
	D73g80yEfJ377i3GrqJt0cCIvtkGOS75fdkFKwJ0e27EXrktCF7k6Uk7si/fHQZj
	IuqkSwSRMOU/4VNyFM3IYJIoZZMAUDC1KiajeVCbqIw0AbXBSEuuwnv9lykI+l2N
	goTt5VzHWuIMO3Q4jl89KQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 47kxhphs31-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 30 Jun 2025 14:21:40 -0700 (PDT)
Received: from twshared57752.46.prn1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Mon, 30 Jun 2025 21:21:37 +0000
Received: by devvm7589.cco0.facebook.com (Postfix, from userid 669379)
	id 0F0451B5FA38; Mon, 30 Jun 2025 14:21:22 -0700 (PDT)
From: Ihor Solodrai <isolodrai@meta.com>
To: <bpf@vger.kernel.org>
CC: <andrii@kernel.org>, <ast@kernel.org>, <eddyz87@gmail.com>,
        <mykyta.yatsenko5@gmail.com>, <mykolal@fb.com>, <kernel-team@meta.com>
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: add test cases for bpf_dynptr_memset()
Date: Mon, 30 Jun 2025 14:21:13 -0700
Message-ID: <20250630212113.573097-3-isolodrai@meta.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250630212113.573097-1-isolodrai@meta.com>
References: <20250630212113.573097-1-isolodrai@meta.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDE3NSBTYWx0ZWRfX7qLV7FoL+3Pw aSfG2sw0GkOTymf1G5no+hYOcsEwxXnihPphrhFf2+6OIb1QgueL2pYR9V3IgvqmuEU2UPjkRbN KJKKI412ptoH2KGlknhd1b8oRHC2cmUcCr5FEqytVwWiB/ZZLRttnXdBcxnaAJLFS3ZO1x3lw6G
 yAS8K8zg26trMfYSduO11GOxM3LE4GwZ1GFUpvF/HwMOU0ez13VR6N19A8vOygRS+Uv15jAK0HK bo5fN9v8hx1u4TEcHUEeDhDur8l0gin8dPV00XVOrO3aNCroSDq/Vz3exFQVC6lcjqMeB7l80pS VRWLcAE6za3KqHGMsrCcnH24XuarVUdmlxlLDgdec2U9/YrKTgtr3Cvt0g8T9pLLT64IwmLld0v
 Znho70Gvd6VNbwpoNlEUTN3BPSbjereguF/ZIQR3zUzxi6saz39VdgIGq/nuD5rTNoBNV5M7
X-Proofpoint-ORIG-GUID: ib5Eqb7pvJXSxY29V8_si3Ffp3J6vwQJ
X-Authority-Analysis: v=2.4 cv=TcOWtQQh c=1 sm=1 tr=0 ts=6862ffe4 cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=6IFa9wvqVegA:10 a=VabnemYjAAAA:8 a=kz5PBBbPer8UiGpu3bUA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: ib5Eqb7pvJXSxY29V8_si3Ffp3J6vwQJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_05,2025-06-27_01,2025-03-28_01

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
 .../selftests/bpf/progs/dynptr_success.c      | 158 ++++++++++++++++++
 2 files changed, 166 insertions(+)

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
index a0391f9da2d4..7d7081d05d47 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_success.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
@@ -681,6 +681,164 @@ int test_dynptr_copy_xdp(struct xdp_md *xdp)
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
+#define min_t(type, x, y) ({		\
+	type __x =3D (x);			\
+	type __y =3D (y);			\
+	__x < __y ? __x : __y; })
+
+SEC("xdp")
+int test_dynptr_memset_xdp_chunks(struct xdp_md *xdp)
+{
+	u32 data_sz, chunk_sz, offset =3D 0;
+	const int max_chunks =3D 200;
+	struct bpf_dynptr ptr_xdp;
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
+		if (offset >=3D data_sz)
+			goto out;
+		chunk_sz =3D min_t(u32, sizeof(buf), data_sz - offset);
+		err =3D bpf_dynptr_read(&buf, chunk_sz, &ptr_xdp, offset, 0);
+		if (err)
+			goto out;
+		err =3D bpf_memcmp(buf, expected_buf, sizeof(buf));
+		if (err)
+			goto out;
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


