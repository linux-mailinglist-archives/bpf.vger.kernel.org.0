Return-Path: <bpf+bounces-62196-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 086EBAF63B4
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 23:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE9AF522F46
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 21:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6DF230268;
	Wed,  2 Jul 2025 21:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="SNthrAzI"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1229230BE4
	for <bpf@vger.kernel.org>; Wed,  2 Jul 2025 21:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751490214; cv=none; b=S/XJZCWSRiBmNAZuFJTaUc3RiKphirtDcXc2JKeai0XdSSLS5OMTkpnw9sKIMcbQpv1sDSuIU78TZ3wbN380OqIZYenii/TdVywMKoysZ7QGbZUc5FObivZ6yjZ410N92GYtINtCMJOoWhTGlUqwoRJ8fFNBTLgakMa4tPKQBYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751490214; c=relaxed/simple;
	bh=sHAQN1XO8BYeiy21xEHSvSLLE3PKM8Z6VdTX7v8Grbw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EbqkZpRAPjOV+wekjv7Z4IIyzT/uDey2hDPPkbZFdqpp13wOUd89/BmFaSHmCOQfRpKLPc/BYC2UprplWGHU3itlsRYhLPRGN9Gq75Cx2OIKoAl3I6rNlD6xgcwraDGTMiFrdYEfcEBeTVB5kJGIdLcIef0H/n6cr9WREE0CruA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=SNthrAzI; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562Hwr83021480
	for <bpf@vger.kernel.org>; Wed, 2 Jul 2025 14:03:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	s2048-2025-q2; bh=7JYxZO6OUZgGaTepe2ytp+rULeCYWF+it19fJxFBRAA=; b=
	SNthrAzIVGnqxNsrfUPmi4S9xOiMJPUg+X+hvudd1Rr42SNhZAYmy/UTrUCQzlCR
	s12BqIcYdJGicoKTg3u+eg4mfkrjSHO64ReJmKQnCz5HFKHyLHomz0ftb6T3bpsb
	sEgclHEvUcGP5AVh8EJ35qt4tFDTzOyc/joKpYiDNjsHeM+VzTD4WQaNgMQ34DZl
	epJu0w46cHHVtICIe1yhk2sNDZqRfvKO5hVDkeH8dokEJOB+aT2DL54VjzoFoTfH
	snBkAE10JDXcBsuVqlkVz9BBEUyAuEscSJcL2VIVnVYxZngq8K8DsCoG+KUL5kJ+
	JH5L1HPpPSuIjWP848Hz3A==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 47myx2wdax-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 02 Jul 2025 14:03:31 -0700 (PDT)
Received: from twshared78382.04.prn6.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Wed, 2 Jul 2025 21:03:29 +0000
Received: by devvm7589.cco0.facebook.com (Postfix, from userid 669379)
	id 7EDF61D1F551; Wed,  2 Jul 2025 14:03:15 -0700 (PDT)
From: Ihor Solodrai <isolodrai@meta.com>
To: <bpf@vger.kernel.org>
CC: <andrii@kernel.org>, <ast@kernel.org>, <eddyz87@gmail.com>,
        <mykyta.yatsenko5@gmail.com>, <mykolal@fb.com>, <kernel-team@meta.com>
Subject: [PATCH bpf-next v4 1/2] bpf: add bpf_dynptr_memset() kfunc
Date: Wed, 2 Jul 2025 14:03:08 -0700
Message-ID: <20250702210309.3115903-2-isolodrai@meta.com>
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
X-Authority-Analysis: v=2.4 cv=AZOxH2XG c=1 sm=1 tr=0 ts=68659ea3 cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=Wb1JkmetP80A:10 a=VabnemYjAAAA:8 a=09Va2MswjQcXjQzM8gUA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDE3NCBTYWx0ZWRfXy2prYdnQK7Oi bVxpA0Q/Dg1zNRNaqklgApGO3D6RJtYY2XWGjAmHFoBSvucKu0uSPmQuPXn61m/oqsHnslhW/4O 8Fi2Bu5icNfMMvfRRnyK5PJ1P4DbC5vqmFBMuTlVw2xKKsf38/b7fQMFwGt7NamHBz2TcKx5/He
 utwEpG56AEW3mIxxdY6pHzix8qzJVKMtHz3eTwFSYP2r1ciAVyNyQnizHJc6D9xlKdAx/aZb2f8 mDnnqAXfypt2zpfGnQy4HCiYMI1LC/e8MrZ88yjVn1n/KK3WgGMToFrgfODjKFJOJV8EYecu/Nu FoRIW2ihG9tZ6t+P37Ixq+IsZsXrKE1g/vLqnIC+4ipbD86Q3iWTxd4yizmNUG7pp8gIAa9DEsH
 +pBY9T/ouYQWQ0RRCzyKjA0hHSb1Hs/zuaCl8a02YjWuRlDqA8Q74xcP3f+zEqlbccVXLXsW
X-Proofpoint-GUID: kF7wHbN8CZA-YDo_RXVRC_Oq39Bkn6L7
X-Proofpoint-ORIG-GUID: kF7wHbN8CZA-YDo_RXVRC_Oq39Bkn6L7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_04,2025-07-02_04,2025-03-28_01

Currently there is no straightforward way to fill dynptr memory with a
value (most commonly zero). One can do it with bpf_dynptr_write(), but
a temporary buffer is necessary for that.

Implement bpf_dynptr_memset() - an analogue of memset() from libc.

Signed-off-by: Ihor Solodrai <isolodrai@meta.com>
---
 kernel/bpf/helpers.c | 47 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index f48fa3fe8dec..5269381d6d3d 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2907,6 +2907,52 @@ __bpf_kfunc int bpf_dynptr_copy(struct bpf_dynptr =
*dst_ptr, u32 dst_off,
 	return 0;
 }
=20
+/**
+ * bpf_dynptr_memset() - Fill dynptr memory with a constant byte.
+ * @p: Destination dynptr - where data will be filled
+ * @offset: Offset into the dynptr to start filling from
+ * @size: Number of bytes to fill
+ * @val: Constant byte to fill the memory with
+ *
+ * Fills the @size bytes of the memory area pointed to by @p
+ * at @offset with the constant byte @val.
+ * Returns 0 on success; negative error, otherwise.
+ */
+ __bpf_kfunc int bpf_dynptr_memset(struct bpf_dynptr *p, u32 offset, u32=
 size, u8 val)
+ {
+	struct bpf_dynptr_kern *ptr =3D (struct bpf_dynptr_kern *)p;
+	u32 chunk_sz, write_off;
+	char buf[256];
+	void* slice;
+	int err;
+
+	slice =3D bpf_dynptr_slice_rdwr(p, offset, NULL, size);
+	if (likely(slice)) {
+		memset(slice, val, size);
+		return 0;
+	}
+
+	if (__bpf_dynptr_is_rdonly(ptr))
+		return -EINVAL;
+
+	err =3D bpf_dynptr_check_off_len(ptr, offset, size);
+	if (err)
+		return err;
+
+	/* Non-linear data under the dynptr, write from a local buffer */
+	chunk_sz =3D min_t(u32, sizeof(buf), size);
+	memset(buf, val, chunk_sz);
+
+	for (write_off =3D 0; write_off < size; write_off +=3D chunk_sz) {
+		chunk_sz =3D min_t(u32, sizeof(buf), size - write_off);
+		err =3D __bpf_dynptr_write(ptr, offset + write_off, buf, chunk_sz, 0);
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


