Return-Path: <bpf+bounces-61011-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23988ADF978
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 00:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC0CC4A0CD5
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 22:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA9327F00E;
	Wed, 18 Jun 2025 22:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="HmNyprxR"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F4A2192F9
	for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 22:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750286024; cv=none; b=fEJBt23g4O0RI3IudIDT7kBl/m7fA2qBheDrAbG067D5Pjq593WvDYR9S3Qa/w0uUGmhU0dfJvxw7gXhisEBb+A9WYyY1p9IvNTxdTu8E+1lpGnj587zLCTnFGGBC7YLQWHv8Xvf2mODX8CSgc5YpV5NzikGxaNoOOYynKpu6Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750286024; c=relaxed/simple;
	bh=ExJ7Foj838BwvUJSw/lYKj5+MibA5zCtc+kCWh1hXrM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nVTGeTcseIMFDhGpvA1J/QwCmCt3s9bVk3uBajITwM8alt9atw2K2ES1w3dk01/28TNntTh/dCVV34gB1pTgFJLHIBnw3LMm/9YtlaaCRC3ilnPfvd/1p6kVjZL3cUBqeFprqjCxLkKMFZEez4qag0Wp85AbU430XmuBWcV1ATM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=HmNyprxR; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 55ILVKQl029575
	for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 15:33:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:reply-to:subject:to; s=s2048-2021-q4; bh=Y3CgttOi3
	GSF7ecHnQ13t3qdemvSBkSQyQqIikS18q8=; b=HmNyprxR9tLS8tcbalhuR7TeS
	CUcD0KOfLli5uoeRPLBH5mv4YNZf5VnIi631yHqdCl/fgkj15i88hcjty+R3DnGq
	Z+wYWmiGOC4w9hMvtivM5uR7Sr/Y0dr51vMBuwZuCMFWnbGEDPVC9PI9KZ9m2v5H
	Gg4RjLFFoLPgEOWmcDKr+0L5hcGUR/M9qG11/iVWsQv7JroDEaGypky//9j8s953
	I8hArzYpocxaFXfqQldxzouIXpgkqUiHJoJC99qQzB2Xx7nyi1ilbvJ1D2WTwl97
	IkUMppJgi3nO2YRcUmZVysP4stkndlu12N2+icRdIC5njPYY0B2H/NnmtDSSQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 47bf8xj6et-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 15:33:41 -0700 (PDT)
Received: from twshared11388.16.prn3.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Wed, 18 Jun 2025 22:33:38 +0000
Received: by devvm7589.cco0.facebook.com (Postfix, from userid 669379)
	id 0845D10E0AF0; Wed, 18 Jun 2025 15:33:23 -0700 (PDT)
From: Ihor Solodrai <isolodrai@meta.com>
To: <andrii@kernel.org>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <eddyz87@gmail.com>, <mykolal@fb.com>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 1/2] bpf: add bpf_dynptr_memset() kfunc
Date: Wed, 18 Jun 2025 15:33:09 -0700
Message-ID: <20250618223310.3684760-1-isolodrai@meta.com>
X-Mailer: git-send-email 2.47.1
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDE5NCBTYWx0ZWRfX4nsI+RU23M5u JcThQhx6Ew3lslD6y6/qeu8fwOs0ywJECjEeUVSvCR5q+JRCG4Fuxj2N0WgKTYrOsoWke7C/clA CexDWeOSVmU5gfeUQiRhIw5OBiy8ikdfaNOMsondbGmPfvJ2cPTUHGFoTx/oEfz00kXtAXdFL/o
 h6C9ECA92tnTvV/9lN8GTx6XxdCOtXknTcIE8wmeEviOY7x0L7YaYPCvN+TnGNeDVItBo/XvJdH KGeIFfsT4Ggy15eJkxJ8h3wOlw8u5PZAOxvKneAOdBBB1b8ZgedPpzc2NrNknls/QlS76xB0vgE dS2WYvJvqyW5Lw1YtDlu6lB9GLFI0UhJ2treZy+0ooAldA2LHd8iBD1ALTd3hm3HENyqjICSSUA
 +9ccE4+IOc8ftvMAC+7C5mcXndUMhIVbeQDkXLW8dP7EXtj114cWgQkF5FVV5Ne4nnlGalOH
X-Proofpoint-GUID: MP7TymdlDxAN8LyKN9-XwAYJI1B2cHn5
X-Proofpoint-ORIG-GUID: MP7TymdlDxAN8LyKN9-XwAYJI1B2cHn5
X-Authority-Analysis: v=2.4 cv=Q+nS452a c=1 sm=1 tr=0 ts=68533ec5 cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=6IFa9wvqVegA:10 a=VabnemYjAAAA:8 a=Gq9ZQUrsWtQsgNaWWKMA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_06,2025-06-18_03,2025-03-28_01

Currently there is no straightforward way to fill dynptr memory with a
value (most commonly zero). One can do it with bpf_dynptr_write(), but
a temporary buffer is necessary for that.

Implement bpf_dynptr_memset() - an analogue of memset() from libc.

Signed-off-by: Ihor Solodrai <isolodrai@meta.com>
---
 kernel/bpf/helpers.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index b71e428ad936..dfd04628a522 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2906,6 +2906,33 @@ __bpf_kfunc int bpf_dynptr_copy(struct bpf_dynptr =
*dst_ptr, u32 dst_off,
 	return 0;
 }
=20
+/**
+ * bpf_dynptr_memset() - Fill dynptr memory with a constant byte.
+ * @ptr: Destination dynptr - where data will be filled
+ * @val: Constant byte to fill the memory with
+ * @n: Number of bytes to fill
+ *
+ * Fills the first n bytes of the memory area pointed to by ptr
+ * with the constant byte val.
+ * Returns 0 on success; negative error, otherwise.
+ */
+ __bpf_kfunc int bpf_dynptr_memset(struct bpf_dynptr *ptr, u8 val, u32 n=
)
+ {
+	struct bpf_dynptr_kern *p =3D (struct bpf_dynptr_kern *)ptr;
+	int err;
+
+	if (__bpf_dynptr_is_rdonly(p))
+		return -EINVAL;
+
+	err =3D bpf_dynptr_check_off_len(p, 0, n);
+	if (err)
+		return err;
+
+	memset(p->data + p->offset, val, n);
+
+	return 0;
+}
+
 __bpf_kfunc void *bpf_cast_to_kern_ctx(void *obj)
 {
 	return obj;
@@ -3364,6 +3391,7 @@ BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
 BTF_ID_FLAGS(func, bpf_dynptr_size)
 BTF_ID_FLAGS(func, bpf_dynptr_clone)
 BTF_ID_FLAGS(func, bpf_dynptr_copy)
+BTF_ID_FLAGS(func, bpf_dynptr_memset)
 #ifdef CONFIG_NET
 BTF_ID_FLAGS(func, bpf_modify_return_test_tp)
 #endif
--=20
2.47.1


