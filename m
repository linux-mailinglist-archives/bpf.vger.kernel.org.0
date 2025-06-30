Return-Path: <bpf+bounces-61900-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81259AEE967
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 23:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D38B217BB72
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 21:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0490226D11;
	Mon, 30 Jun 2025 21:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="hHpwIFwf"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B5D4C6C
	for <bpf@vger.kernel.org>; Mon, 30 Jun 2025 21:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751318489; cv=none; b=Fj4KgmxacsY9JDsf+Bvjac8MmEOz/MYUkGPEbFmVuXgAAR6jY8+4MPv2lo7VxnPjp7Z4nTIMtlehS39VxiLK4Jg/GQqScafwGazxEIbuv6rZEHhpi9OpyNM2IGYRy4X7hkzBWsULTzWR0Qlb0cEa8iElR2KFmNYyFpHI3gk+BbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751318489; c=relaxed/simple;
	bh=5/a63hKg1H8K39ldewoZW9Xy+pWXa+y09n/P69ZrehE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wi/HBC47LchEg3XJxlda2VcoLtk1WC2OfM7s42oygu+rPp08fU9WJWLtLsJakvxlU6bz7B5pRvDQGWZ3Vx7rthfIAgjDycZoeGE0bL7PBulss+hch4d8VkPqKgZEjx3fAK8aprfdXkRViDLq6aMsWwVHYpRt4CZmOdmUpDKwLws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=hHpwIFwf; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55UI7sCZ004719
	for <bpf@vger.kernel.org>; Mon, 30 Jun 2025 14:21:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	s2048-2025-q2; bh=knJ9p1cnC89CFKEfbZ5TfLYRUc1TiHOlH4FLMk+q8us=; b=
	hHpwIFwfOk90aUYdyhnXMR/yIaoEMKbH7ZMk6UQ73bN0hS7qj6yRALw33XclbPHO
	mgPKjX3vh1z0rzUI4/tVdA2j7xhMyMlGjfPQBuS6dFm+rLWy3zhLKcE0+C3oHxZf
	iJDIlCA53X9mFdrx4G/HQpS5HT5vVQSXCHp/L1CkTk6fMvUQQxfEuvsHXzPvR8S5
	wOj12rcha0oXCpGV5mS9+NDsHcpF92BhCbRYQfUksL0eaYay13Uu1O5vb52dcTgH
	ERJHKLPvAlJKYM0WEeCliP3vEjh1HZpsE7yUHXGlbxuOWKQLynKDDSOgRceOmcaV
	WEd0ZmGmKb3ACs1l8NGM9w==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 47krm6mjpr-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 30 Jun 2025 14:21:27 -0700 (PDT)
Received: from twshared28243.32.prn2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Mon, 30 Jun 2025 21:21:26 +0000
Received: by devvm7589.cco0.facebook.com (Postfix, from userid 669379)
	id 0DF2F1B5FA37; Mon, 30 Jun 2025 14:21:22 -0700 (PDT)
From: Ihor Solodrai <isolodrai@meta.com>
To: <bpf@vger.kernel.org>
CC: <andrii@kernel.org>, <ast@kernel.org>, <eddyz87@gmail.com>,
        <mykyta.yatsenko5@gmail.com>, <mykolal@fb.com>, <kernel-team@meta.com>
Subject: [PATCH bpf-next v3 1/2] bpf: add bpf_dynptr_memset() kfunc
Date: Mon, 30 Jun 2025 14:21:12 -0700
Message-ID: <20250630212113.573097-2-isolodrai@meta.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDE3NSBTYWx0ZWRfX9z/LP88H+RC/ PfIh9MRmnHqgVwAbjoOOcAtnCmyB7mFykbJR0vyeUANnw3+fwFjHmZZEsZQZ91cAwEOoesohszg GD0MkttRCHrMYj0MPaXFKX+w6YecsLPp4CiWqkPyyq5J9DY+9OePrbvaRP6GpaJ7h2U7/b/B6p+
 3H5Is+vWlAj/eAS4YwR6cXf2EyDDKeltRRrb0TZdlwIzVtR526gNvt1N1eauwH3FVdCMEMzGj+a iKj7iX287vP4EycfVsWzkQ+1sDPnLQV343ntOsbvkh1TeYHJHJpCXXm2xwSK+DlTg1fnboyNuhw nksQkyA56mEhDMUbeeL9S83oomjGX5qstGyAUIJ8VF4SGfz13GDraTlpGZerk9VqydlaWVWOBed
 y0P8AxJubwl+/z4QDKnODAVnzelcMD3rTbrFzagHutwuzo5gp0XvcscAgO/uR5Dfn836MFzC
X-Proofpoint-GUID: ojBG-0Ly12E8VJxS2DPjY3oi12bbDwah
X-Authority-Analysis: v=2.4 cv=b4Cy4sGx c=1 sm=1 tr=0 ts=6862ffd7 cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=6IFa9wvqVegA:10 a=VabnemYjAAAA:8 a=09Va2MswjQcXjQzM8gUA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: ojBG-0Ly12E8VJxS2DPjY3oi12bbDwah
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_05,2025-06-27_01,2025-03-28_01

Currently there is no straightforward way to fill dynptr memory with a
value (most commonly zero). One can do it with bpf_dynptr_write(), but
a temporary buffer is necessary for that.

Implement bpf_dynptr_memset() - an analogue of memset() from libc.

Signed-off-by: Ihor Solodrai <isolodrai@meta.com>
---
 kernel/bpf/helpers.c | 47 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index f48fa3fe8dec..415b50415598 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2907,6 +2907,52 @@ __bpf_kfunc int bpf_dynptr_copy(struct bpf_dynptr =
*dst_ptr, u32 dst_off,
 	return 0;
 }
=20
+/**
+ * bpf_dynptr_memset() - Fill dynptr memory with a constant byte.
+ * @ptr: Destination dynptr - where data will be filled
+ * @offset: Offset into the dynptr to start filling from
+ * @size: Number of bytes to fill
+ * @val: Constant byte to fill the memory with
+ *
+ * Fills the size bytes of the memory area pointed to by ptr
+ * at offset with the constant byte val.
+ * Returns 0 on success; negative error, otherwise.
+ */
+ __bpf_kfunc int bpf_dynptr_memset(struct bpf_dynptr *ptr, u32 offset, u=
32 size, u8 val)
+ {
+	struct bpf_dynptr_kern *p =3D (struct bpf_dynptr_kern *)ptr;
+	u32 chunk_sz, write_off;
+	char buf[256];
+	void* slice;
+	int err;
+
+	if (__bpf_dynptr_is_rdonly(p))
+		return -EINVAL;
+
+	err =3D bpf_dynptr_check_off_len(p, offset, size);
+	if (err)
+		return err;
+
+	slice =3D bpf_dynptr_slice_rdwr(ptr, offset, NULL, size);
+	if (likely(slice)) {
+		memset(slice, val, size);
+		return 0;
+	}
+
+	/* Non-linear data under the dynptr, write from a local buffer */
+	chunk_sz =3D min_t(u32, sizeof(buf), size);
+	memset(buf, val, chunk_sz);
+
+	for (write_off =3D 0; write_off < size; write_off +=3D chunk_sz) {
+		chunk_sz =3D min_t(u32, sizeof(buf), size - write_off);
+		err =3D __bpf_dynptr_write(p, offset + write_off, buf, chunk_sz, 0);
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
@@ -3735,6 +3781,7 @@ BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
 BTF_ID_FLAGS(func, bpf_dynptr_size)
 BTF_ID_FLAGS(func, bpf_dynptr_clone)
 BTF_ID_FLAGS(func, bpf_dynptr_copy)
+BTF_ID_FLAGS(func, bpf_dynptr_memset)
 #ifdef CONFIG_NET
 BTF_ID_FLAGS(func, bpf_modify_return_test_tp)
 #endif
--=20
2.47.1


