Return-Path: <bpf+bounces-61437-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B3DAE7117
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 22:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 498F77A6555
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 20:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9442C2E6D22;
	Tue, 24 Jun 2025 20:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Gs0RuuVU"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971404C9F
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 20:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750798389; cv=none; b=R35nLKRrGipmC5awomfqZqSlE7dvNZrpZszhqsA4NycIl7OaPGWFwtNqS7MO36cf1s+LZpthVglKu+ZViGC14URrVsferM7lEungPu6nqItBQg7a9w1lHZHYhGGLJJ4LZa0smw73YlNYUY6oG+gt61lA5LDf9rcyKIuvTjRqGA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750798389; c=relaxed/simple;
	bh=6tG1/+hvDDK61Bn+FPdMg3XlqfSy7Ct10jVjxK4SetY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KOojWaEjbDfTDDTqRV9FWcGq+R/pOfUO/BXlUbl0CFVzETFy0Pq6trCCIo+HQo2RgyF5VBbsWdgf21Yo61P52OEVKDke08VI3YLNYbfT0933gTByfmKUwgWBn1jhqen3Dwxvv4Jqor+1CVEMyhsRIBXku1K/rG14ddxC4/4Q00I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Gs0RuuVU; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 55OKqQjb031276
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 13:53:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	s2048-2021-q4; bh=v33L2ORKYtSY58N/WSZpMqfN03BC1dXIJsRgyAvMIq0=; b=
	Gs0RuuVUtVOd+K/YDG3+HQtFw7FfPE0/hvK91HVUIIvhJ5Y2mSWHq1oY1QbV9+EV
	z/59Ys+AaNaDCf+S6U5FyoBX1QRctsmxbJd1YAbBPG7OREoErnm7XlztegY/atmN
	3l7RGp1l3fl16J/ItpP1hUQfUhm8rVa1ksiMo40AnrHv+hXFqFsxdzg3zkpDR78O
	btSXT3u36mz8O8uyq+E9kt0RZGeauh1ckjH+RdV6occ2vB+pBm2nhsmLji6IEHuu
	TpCqLaH4O6tUFX2xoyYhL1N3boz4ZADHgaZOQKCRVjJCIoPbnw7bknEmZJSlTMhV
	hPF2clHK+pvruDUOQjbN5g==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 47dre7fafw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 13:53:06 -0700 (PDT)
Received: from twshared2972.04.prn6.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Tue, 24 Jun 2025 20:53:05 +0000
Received: by devvm7589.cco0.facebook.com (Postfix, from userid 669379)
	id 51961166AA00; Tue, 24 Jun 2025 13:52:58 -0700 (PDT)
From: Ihor Solodrai <isolodrai@meta.com>
To: <bpf@vger.kernel.org>
CC: <andrii@kernel.org>, <ast@kernel.org>, <eddyz87@gmail.com>,
        <mykyta.yatsenko5@gmail.com>, <mykolal@fb.com>, <kernel-team@meta.com>
Subject: [PATCH bpf-next v2 1/2] bpf: add bpf_dynptr_memset() kfunc
Date: Tue, 24 Jun 2025 13:52:39 -0700
Message-ID: <20250624205240.1311453-2-isolodrai@meta.com>
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
X-Proofpoint-GUID: w0xZRkoTdGXiTBfR8BD9dNDnqQGUbhYo
X-Authority-Analysis: v=2.4 cv=Vbv3PEp9 c=1 sm=1 tr=0 ts=685b1032 cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=6IFa9wvqVegA:10 a=VabnemYjAAAA:8 a=09Va2MswjQcXjQzM8gUA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: w0xZRkoTdGXiTBfR8BD9dNDnqQGUbhYo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDE2NiBTYWx0ZWRfX7ZemZquZj4uJ xlFALfJbceDxQbNWuyFQWfJy5vO7g4L7/Y8xur2R9sLStuTA+Yz2QS7Ivd7Ks2E/z93I3MN6M2q CJLLWpFTcrIFlbqah2ygDacPNbGpb0xpVAndE8HCCN24czuSGr9H8aA/iyJSuUqbrieteAQLiG2
 5LsCfX8dW9sT253E3aEapO+UCiePySChMC6G/qudazx1t++ECp984cMecqyUiFen6Ax+W30rcj+ 4CiQiqKmcGTlKD0pYIhMDTqPzH9hXVSqvSHiXiafLccxOSsS2+1QsOOufOVHkW/mfH1cB3bGPin R1w6QL8/JFDqGJMjXGqKR7OQhoMErD8GdepxjB72oEq4uxyQ8fggwQEflJKqf87NI/XEBNA1a+T
 HSckqsWMeOtiDBpwoE4zzM6gLlNLD62rA6Sapm5AsnNmzUi+m+3/MOP5MFqhYe8FuakiMqf3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_06,2025-06-23_07,2025-03-28_01

Currently there is no straightforward way to fill dynptr memory with a
value (most commonly zero). One can do it with bpf_dynptr_write(), but
a temporary buffer is necessary for that.

Implement bpf_dynptr_memset() - an analogue of memset() from libc.

Signed-off-by: Ihor Solodrai <isolodrai@meta.com>
---
 kernel/bpf/helpers.c | 48 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index b71e428ad936..b8a7dbc971b4 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2906,6 +2906,53 @@ __bpf_kfunc int bpf_dynptr_copy(struct bpf_dynptr =
*dst_ptr, u32 dst_off,
 	return 0;
 }
=20
+/**
+ * bpf_dynptr_memset() - Fill dynptr memory with a constant byte.
+ * @ptr: Destination dynptr - where data will be filled
+ * @ptr_off: Offset into the dynptr to start filling from
+ * @size: Number of bytes to fill
+ * @val: Constant byte to fill the memory with
+ *
+ * Fills the size bytes of the memory area pointed to by ptr
+ * at offset ptr_off with the constant byte val.
+ * Returns 0 on success; negative error, otherwise.
+ */
+ __bpf_kfunc int bpf_dynptr_memset(struct bpf_dynptr *ptr, u32 ptr_off, =
u32 size, u8 val)
+ {
+	struct bpf_dynptr_kern *p =3D (struct bpf_dynptr_kern *)ptr;
+	char buf[256];
+	u32 chunk_sz;
+	void* slice;
+	u32 offset;
+	int err;
+
+	if (__bpf_dynptr_is_rdonly(p))
+		return -EINVAL;
+
+	err =3D bpf_dynptr_check_off_len(p, ptr_off, size);
+	if (err)
+		return err;
+
+	slice =3D bpf_dynptr_slice_rdwr(ptr, ptr_off, NULL, size);
+	if (likely(slice)) {
+		memset(slice, val, size);
+		return 0;
+	}
+
+	/* Non-linear data under the dynptr, write from a local buffer */
+	chunk_sz =3D min_t(u32, sizeof(buf), size);
+	memset(buf, val, chunk_sz);
+
+	for (offset =3D ptr_off; offset < ptr_off + size; offset +=3D chunk_sz)=
 {
+		chunk_sz =3D min_t(u32, sizeof(buf), size - offset);
+		err =3D __bpf_dynptr_write(p, offset, buf, chunk_sz, 0);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 __bpf_kfunc void *bpf_cast_to_kern_ctx(void *obj)
 {
 	return obj;
@@ -3364,6 +3411,7 @@ BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
 BTF_ID_FLAGS(func, bpf_dynptr_size)
 BTF_ID_FLAGS(func, bpf_dynptr_clone)
 BTF_ID_FLAGS(func, bpf_dynptr_copy)
+BTF_ID_FLAGS(func, bpf_dynptr_memset)
 #ifdef CONFIG_NET
 BTF_ID_FLAGS(func, bpf_modify_return_test_tp)
 #endif
--=20
2.47.1


