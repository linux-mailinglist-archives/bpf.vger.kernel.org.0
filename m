Return-Path: <bpf+bounces-60079-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B148AD25A0
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 20:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB14F16F1C5
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 18:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D973B21CFF4;
	Mon,  9 Jun 2025 18:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="lUc3Glzd"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B0F18DB1E
	for <bpf@vger.kernel.org>; Mon,  9 Jun 2025 18:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749493856; cv=none; b=qaDbwjEuct83+ZwhMKdo3/PTPtv9ZnSGsDn69fO131zwA88cMJNCn94/nHQ8BxVN1CBKAQDTWBfQ8iomK0QuLVhHVuT54YcIDNQmyKqBd/Em9uABcuv46qKkXVg3rGQZitvGvAE8Wj2IxDcNgXOjkLsRs2z+IupsMw0AcWJjP18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749493856; c=relaxed/simple;
	bh=Ta6CfFiM3ROqzH5t0Od4UMf+qs8xwYDnpuo3WrYlEn8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uOIc4w6P7X4sK8t/Oey0b7J0r/LpqEWUh7s17Qgz3p+UMnWm/KAYM1AP7scdyBEaG+hMCYLvQU6qlhB+sk6eGN7Xu9/+fYdEm+id5KArKes6Y6caQobzN1c2DKBl8KsowaWqJxZxCoQ/0ZW0EvREbnMxyhAlxNIVK5PEUCfSDsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=lUc3Glzd; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 559HV2At009026
	for <bpf@vger.kernel.org>; Mon, 9 Jun 2025 11:30:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	s2048-2021-q4; bh=PzsTDYbhkMBhQ1DaSijt6C50F2hWkVTGWNN/9c+M4Po=; b=
	lUc3GlzdsqDyFIMbvH2jHs5ewpAJNe3FlDBgU+Xtu2TXS3QCq1AU0piOdDEozrpL
	o9edXZwblbW2CpBMozxPj7IYC5l0CuFepxLFz+Qtbks7C6kGVAlIe/rdw2rM2ocW
	OoLFEJYA/aGqiMdWLT8ClYApujDvYvNWJlkuh3y9V9k3njxFehbKKS5kMpgo5uYt
	xcIJwdKmKYU0hS52zn9r1HC8wPpoSiIqbc32w8/BAGszyPekKlKSoL/QTJSyWotd
	HpsJG2uJQieV8PJFHFVnZ1lTfiewr5bf7ErvxTHdm7MbInmVVDMtqAc/sq9kb6Gg
	kKMu2W5/OOWSZx0bPslLaQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 475hncww6p-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 09 Jun 2025 11:30:52 -0700 (PDT)
Received: from twshared18532.02.prn5.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Mon, 9 Jun 2025 18:30:50 +0000
Received: by devvm7589.cco0.facebook.com (Postfix, from userid 669379)
	id D185994A1E0; Mon,  9 Jun 2025 11:30:43 -0700 (PDT)
From: Ihor Solodrai <isolodrai@meta.com>
To: <andrii@kernel.org>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <eddyz87@gmail.com>, <mykolal@fb.com>, <yonghong.song@linux.dev>,
        <kernel-team@meta.com>
Subject: [PATCH bpf-next v4 2/3] selftests/bpf: add cmp_map_pointer_with_const test
Date: Mon, 9 Jun 2025 11:30:23 -0700
Message-ID: <20250609183024.359974-3-isolodrai@meta.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250609183024.359974-1-isolodrai@meta.com>
References: <20250609183024.359974-1-isolodrai@meta.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDE0MCBTYWx0ZWRfXyfID67949wEz Xjh+aD6OQ7JrxKZbG1OLXq92odReOroGVcgWPINBX8mTb6EO58oQqT5c9Et+dTN90xMWaz23XF3 AfWkdbku3Q8pXdVyd3KZo4yv0pKQoBO75tWbFjQsDwVMWwolYWwT2G02dsWsmZ7Gxli+wihtLXQ
 0XhGCaG8M2+/RBoBQM6ymlUV78JMob699B0EfLOGo7BRrnJ8lYCspdK1B2C96FxMyJ7KyKKcLwW wbz2xjfniNkifrvQAc4ds+nCa1tWSrwG5rZyWMVxotvac918d5Yc9bwpBEbNjIpijp0GGP7Oq2m WD7MubFryef+i7u8xOhoisfEMgJhtvHo68NeQ0Fqg9Tc+vHFouAh0r1T3WrpfCDXehKyjhZSQ1n
 ODogo4ww1ODqkLmfrK56j+bhGWKOyYNDwkl4H94s1fXQQv71i/wiElPZBMGSz2vluMZ+8cUy
X-Proofpoint-ORIG-GUID: Z9lGKdCin6rIhYw-2vIhFQAWaR5LbCJZ
X-Authority-Analysis: v=2.4 cv=SoKQ6OO0 c=1 sm=1 tr=0 ts=6847285c cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=6IFa9wvqVegA:10 a=VabnemYjAAAA:8 a=ucs8h2RCo5JdfC4RZmEA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: Z9lGKdCin6rIhYw-2vIhFQAWaR5LbCJZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_07,2025-06-09_02,2025-03-28_01

Add a test for CONST_PTR_TO_MAP comparison with a non-0 constant. A
BPF program with this code must not pass verification in unpriv.

Signed-off-by: Ihor Solodrai <isolodrai@meta.com>
---
 .../selftests/bpf/progs/verifier_unpriv.c       | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_unpriv.c b/tools/=
testing/selftests/bpf/progs/verifier_unpriv.c
index 28200f068ce5..db52ba66e880 100644
--- a/tools/testing/selftests/bpf/progs/verifier_unpriv.c
+++ b/tools/testing/selftests/bpf/progs/verifier_unpriv.c
@@ -624,7 +624,6 @@ __retval(0)
 __naked void cmp_map_pointer_with_zero(void)
 {
 	asm volatile ("					\
-	r1 =3D 0;						\
 	r1 =3D %[map_hash_8b] ll;				\
 	if r1 =3D=3D 0 goto l0_%=3D;				\
 l0_%=3D:	r0 =3D 0;						\
@@ -634,6 +633,22 @@ l0_%=3D:	r0 =3D 0;						\
 	: __clobber_all);
 }
=20
+SEC("socket")
+__description("unpriv: cmp map pointer with const")
+__success __failure_unpriv __msg_unpriv("R1 pointer comparison prohibite=
d")
+__retval(0)
+__naked void cmp_map_pointer_with_const(void)
+{
+	asm volatile ("					\
+	r1 =3D %[map_hash_8b] ll;				\
+	if r1 =3D=3D 0x0000beef goto l0_%=3D;			\
+l0_%=3D:	r0 =3D 0;						\
+	exit;						\
+"	:
+	: __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
 SEC("socket")
 __description("unpriv: write into frame pointer")
 __failure __msg("frame pointer is read only")
--=20
2.47.1


