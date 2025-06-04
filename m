Return-Path: <bpf+bounces-59573-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BE0ACD0B9
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 02:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8FEA3A4E7E
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 00:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFD21804A;
	Wed,  4 Jun 2025 00:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="bqYCu2vH"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189E6C2FA
	for <bpf@vger.kernel.org>; Wed,  4 Jun 2025 00:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748997521; cv=none; b=oaXJ0ETjmf2IB1TnFo/E/rKCm64XS4z4gCpr5padkGF8HzYVU7iTNai424VxIvWPwLSqvDtcnU+08zR4qW0nK6JTuqk7bVFLf7sgh3zI0GFaPADrJbrK808ZUR4roOBwMolE/Ry8Kc6WIsSOVOIka1GzGgGBG6nyQqsrZpu54+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748997521; c=relaxed/simple;
	bh=g77+F/9L/hdLiDx9MjZAJxoDKD/hIa2VWgCLKTXDfjk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JWaEGyExZdZjn6G6/xEX7QhqYlxDOD3dNUH2rsSyQlkxp5bM+TMQUp1j5ZIfi008aoCmJynblezFlZTtv9ot71RKkHL6Xw0+lfGHb+oGtV2WxbDW5k1/MYqZBO7mYiJK09/j+KUk31p+KSuQPEQ9GPKiK4fXQrLr5glQm5ggq/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=bqYCu2vH; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 553MunI4023549
	for <bpf@vger.kernel.org>; Tue, 3 Jun 2025 17:38:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:reply-to:subject:to; s=s2048-2021-q4; bh=QJ3kaiJ2s
	/+6QS3wVA0z4CUNu9ayRmt3DqsqGnMWoJ0=; b=bqYCu2vHTZ/Uycyabg+5xLcH0
	9XLRP7BPwqXcJTBFFeg8jJrxvWURNrXukykw6ggu8RsbXS4FJHbAUQplGd9ZT1pw
	eS7Y+/uf1f4H/jTTsaeFD2YXH43bUamBksdDCZmW3XkARqkeHbW0GoFcE3j+tZ7g
	hdOiC/DAfwsun2sxUSXuHs092K9rQ+YGR1qzlJ8zcZ71T1hxrqbmv9fT+Q4x28EM
	q8eQNZ65q7zNpLYcnC6y8Uhi4bIB3k33jCJvAfUS/uYKdfslfQikXMJWCJTGvm7l
	kqBYItyxMyWYkhF1LgYyP3By/M7sutTLl2pwqNN3U+JNvbJXhj1sJt6Ps+HDQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 471x0pxgp8-13
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 03 Jun 2025 17:38:38 -0700 (PDT)
Received: from twshared4652.28.prn2.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Wed, 4 Jun 2025 00:38:34 +0000
Received: by devvm7589.cco0.facebook.com (Postfix, from userid 669379)
	id AB728343F60; Tue,  3 Jun 2025 17:38:18 -0700 (PDT)
From: Ihor Solodrai <isolodrai@meta.com>
To: <andrii@kernel.org>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <eddyz87@gmail.com>, <mykolal@fb.com>, <kernel-team@meta.com>
Subject: [PATCH bpf-next v2 1/3] bpf: make reg_not_null() true for CONST_PTR_TO_MAP
Date: Tue, 3 Jun 2025 17:37:57 -0700
Message-ID: <20250604003759.1020745-1-isolodrai@meta.com>
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
X-Authority-Analysis: v=2.4 cv=UrljN/wB c=1 sm=1 tr=0 ts=683f958e cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=6IFa9wvqVegA:10 a=VabnemYjAAAA:8 a=eyZTgQFGG2VFfHX4qDcA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDAwMiBTYWx0ZWRfX/klim3DrEKlL Y+OQ6IZXbSWeb3L0B2wZi8qyBdq5FHdYxFaJ+Z+3mbw9hnHUATqwjG0oNMn/3Telg1YJYXHUZdJ bXksdbcyaB4onYEnez1r24wbm5ZE2UK5sXUeZtGXZ/mwz5VRe3aZn6GENcXeLLuMNLSDmkFfek1
 KpBUoMOxzuuEC6i6xT5IFc8jb7HjaDgAyTXL69BrNfTwp4iKXewTU5a4Q090/yYzPPMNPL+HG/t F918Umik3ukhlNrx981DgjuiQ61VCZAp1fy0nFj8ZJUK7s2PSh/jmv94UuTXNZ/+hrRfBZN2B+L VsLyjC9RkQKpjTykGTm4FVXfEvJYpzHnkbP1DSOi3jTf0o6YW2VaDt8hrQNivW9bz1q2dMiCBdf
 xbJoNw+nFRiLxEZgPkyDMz2+hyP6vf9Q42Lf7/jRG6ReSsRA+mWI5JJxncP+5jqHv2qQ8+V7
X-Proofpoint-ORIG-GUID: tftTYhkqJsRd3sh6EXXPuGR2q3DhU14y
X-Proofpoint-GUID: tftTYhkqJsRd3sh6EXXPuGR2q3DhU14y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-03_03,2025-06-03_02,2025-03-28_01

When reg->type is CONST_PTR_TO_MAP, it can not be null. However the
verifier explores the branches under rX =3D=3D 0 in check_cond_jmp_op()
even if reg->type is CONST_PTR_TO_MAP, because it was not checked for
in reg_not_null().

Fix this by adding CONST_PTR_TO_MAP to the set of types that are
considered non nullable in reg_not_null().

An old "unpriv: cmp map pointer with zero" selftest fails with this
change, because now early out correctly triggers in
check_cond_jmp_op(), making the verification to pass.

In practice verifier may allow pointer to null comparison in unpriv,
since in many cases the relevant branch and comparison op are removed
as dead code. So change the expected test result to __success_unpriv.

Signed-off-by: Ihor Solodrai <isolodrai@meta.com>
---
 kernel/bpf/verifier.c                               | 3 ++-
 tools/testing/selftests/bpf/progs/verifier_unpriv.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a7d6e0c5928b..0c100e430744 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -405,7 +405,8 @@ static bool reg_not_null(const struct bpf_reg_state *=
reg)
 		type =3D=3D PTR_TO_MAP_KEY ||
 		type =3D=3D PTR_TO_SOCK_COMMON ||
 		(type =3D=3D PTR_TO_BTF_ID && is_trusted_reg(reg)) ||
-		type =3D=3D PTR_TO_MEM;
+		type =3D=3D PTR_TO_MEM ||
+		type =3D=3D CONST_PTR_TO_MAP;
 }
=20
 static struct btf_record *reg_btf_record(const struct bpf_reg_state *reg=
)
diff --git a/tools/testing/selftests/bpf/progs/verifier_unpriv.c b/tools/=
testing/selftests/bpf/progs/verifier_unpriv.c
index a4a5e2071604..28200f068ce5 100644
--- a/tools/testing/selftests/bpf/progs/verifier_unpriv.c
+++ b/tools/testing/selftests/bpf/progs/verifier_unpriv.c
@@ -619,7 +619,7 @@ __naked void pass_pointer_to_tail_call(void)
=20
 SEC("socket")
 __description("unpriv: cmp map pointer with zero")
-__success __failure_unpriv __msg_unpriv("R1 pointer comparison")
+__success __success_unpriv
 __retval(0)
 __naked void cmp_map_pointer_with_zero(void)
 {
--=20
2.47.1


