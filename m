Return-Path: <bpf+bounces-62194-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B203AF63B1
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 23:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BE937B3D67
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 21:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E499F238C1A;
	Wed,  2 Jul 2025 21:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="rZboG4Ss"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B9B2DE711
	for <bpf@vger.kernel.org>; Wed,  2 Jul 2025 21:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751490206; cv=none; b=CcmcW7nZYdSSheaipcCf1Ihe+POSGNNBC2gR9aHcCxRmVv7xnM4/wrdRnmmLCZWxD9lHQ9lSOihebe+1Dj+vUu1nfS1fUzaYWWtnvcYJF/nMpDOBn7x1ZS/JfDzxww4s3rilTKc78rI2vhJkxlKFzBwU/TwqJriWFAXTxBuSmwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751490206; c=relaxed/simple;
	bh=L6hKSJDZisT1LZaNrk9Ks8UANMtBypNuAEw/+RP/1V0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B8os1ZXI/cSaDVpF4zU5s6ntgbDi7nGS2wx8Y+uGlTwpHINJEWvv6ESxEd/9prlyBsCaLWN7Dk570pGc+lCpqDn0DvbeLxDD+/Q6gOMuAZ8ZXD7JbLCMUUmxSmokOVWiS/0xw4yvExeFIDuXGQhWzwiYEApgBZ5v9xKcaXzqzOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=rZboG4Ss; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562HwrOn021459
	for <bpf@vger.kernel.org>; Wed, 2 Jul 2025 14:03:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	s2048-2025-q2; bh=QiJxDljqsqXgQsXEszXPkK5Ie+1olocEUlkZLamRA3s=; b=
	rZboG4Ssk58VF4GK4Gl+M+ejqIDyFQjizwB3xCRWd8dBgWndseIGcgZ6I4bz1xpS
	Zu6DuljxgC1afGYa2327MM0g/y3wE9eDs+qEEmaAP0bsC0OSY0kKx4KvG5sHKDLQ
	AcC6brUrri3UnBlniP9ypB6oLWEXzljFEwBYcoQ+K0aLHgUe3szE5fOGWK1yEt7b
	DGH61pMuC3yTOqV0SDDN+f49vqS4qfLBFZJKcwn5xUYF5Mg7/6KbI1+PsYoXXygo
	KwREhArdbBxNW69wJlpnhkWb/x22ltKMFKTpZHV/YBCaUPR34epoJw84mTOVt5ve
	j+pzym9JPHDMx91qqLaQgw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 47myx2wda6-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 02 Jul 2025 14:03:23 -0700 (PDT)
Received: from twshared57752.46.prn1.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Wed, 2 Jul 2025 21:03:22 +0000
Received: by devvm7589.cco0.facebook.com (Postfix, from userid 669379)
	id 7FEBF1D1F552; Wed,  2 Jul 2025 14:03:15 -0700 (PDT)
From: Ihor Solodrai <isolodrai@meta.com>
To: <bpf@vger.kernel.org>
CC: <andrii@kernel.org>, <ast@kernel.org>, <eddyz87@gmail.com>,
        <mykyta.yatsenko5@gmail.com>, <mykolal@fb.com>, <kernel-team@meta.com>
Subject: [PATCH bpf-next v4 2/2] selftests/bpf: add test cases for bpf_dynptr_memset()
Date: Wed, 2 Jul 2025 14:03:09 -0700
Message-ID: <20250702210309.3115903-3-isolodrai@meta.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250702210309.3115903-1-isolodrai@meta.com>
References: <20250702210309.3115903-1-isolodrai@meta.com>
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
X-Authority-Analysis: v=2.4 cv=AZOxH2XG c=1 sm=1 tr=0 ts=68659e9b cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=Wb1JkmetP80A:10 a=VabnemYjAAAA:8 a=kz5PBBbPer8UiGpu3bUA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDE3NCBTYWx0ZWRfXz+uk/M0yzxGd qVLjUsG2AQR9+r51rMyGjH/NxF6JZOBsEMA9587QBulNRT3lfiADvpHBOgCcnuWZaJu9pI2ntDq w3zFIiQ8zpNdoiZcCu3NgReoQs3vaStbF613qPvll9riFSrVn2s5FuIeUeeKO2ozXDUA2aNgQtK
 Xw2TJW4+CTqRxRz1+NW5pfW8laBlG2Hq1qxYrJvdI3iqsVdIc+pI+XkMxam5jWDH2JvqJZueDZ3 9pn1w7sZaxJtcOLbQCm9MWumSqvJ/c68jLnnPargbNgN1n6Oi4JEbeXOI9bN4bxbTVu2+s337RD IF8fEhtSlBYYSvtXmbv0dFQRCgguc2C1oGA0somODAI7IP0E3erPN+tBJB980Lw65eUGDSso5wy
 DjH9lbNywmgS1DfyPYMNpyPHH+Et/unmK23KCXBnIOCXA+k4AejVe2yZgRu380e7wKrVEAwG
X-Proofpoint-GUID: oOb8b9cWCE5KewH4Ed7XiFttkOLzYSb3
X-Proofpoint-ORIG-GUID: oOb8b9cWCE5KewH4Ed7XiFttkOLzYSb3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_04,2025-07-02_04,2025-03-28_01

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


