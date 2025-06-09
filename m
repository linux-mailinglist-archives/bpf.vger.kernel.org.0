Return-Path: <bpf+bounces-60082-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA54AD25A4
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 20:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 038AA16F25E
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 18:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713C421D594;
	Mon,  9 Jun 2025 18:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="E+d/2knc"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BFB21E0AD
	for <bpf@vger.kernel.org>; Mon,  9 Jun 2025 18:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749493863; cv=none; b=rL8vn7XkooY8mOPs9DH/qBvf9h59kXy6VdKnS1raUTLvn8lP36KqcaM5kPshGoVXVu8kT+UGj4yWTZ4LGrOgvniZFf6z6y0kUKuVXds6dR75cy8lXUqVabdqDTbMnqRR565V0l/odmY2qFE6PecssPtZVCAppEOSLKyczLTvSDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749493863; c=relaxed/simple;
	bh=5Evca0RhB0byDAJ2hptWAaaop+n2KYIXTIQNfYrPgyI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U+2hy6FLjDCvtI2o+DXTxsT6R1TsRHDddhIYVcrJfV5iqicUESCAK3BKYNq5fVivCT4TikbIotbRHem9eKKQHXx8IEKMbyTNyIwhQqUC4Rvw08nqPujkOFwOe6xzt3oK8JXpqdkKzQVJdJNZdqq/yDktPhTsnPxHR81vDIm8PCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=E+d/2knc; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 559HV3dn006907
	for <bpf@vger.kernel.org>; Mon, 9 Jun 2025 11:31:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	s2048-2021-q4; bh=EWpymFEb6MVHWqaGyShtHnqpMq6nM2bySiTZsWFb/nA=; b=
	E+d/2knc82OZrQH/9sYy/zstocN6IRr5cPAym4oCYxpfOTnKUM3gYtT4hlAiJVus
	o11heaS6NYxDB2oOTy76EiWZkcfgnQ5PDF8HqIKxXq8g3XbcnQG2IKl/hvou3Vdr
	8LrM0lo2vfJUTJWS3LaScFNhBy7Xh0yAnUFeyIt10/opGBVF0yS3VNMVNIKLF3LW
	8yrRXFL6CCar6bLbhThU1D3mxhCxzKqTYROr3TY18vIdbd5uMj3henDrOuF6E//R
	4ncw5/JTo3X/yLHd+YEcj/5jMqsQBu/AsfcJAqUNOTZ3AqVLsiaR0F7Qo1ywz0Hx
	xM3kDFYnL1fX+aXTsvXZTg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4755c0ywn7-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 09 Jun 2025 11:31:01 -0700 (PDT)
Received: from twshared33022.03.prn6.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Mon, 9 Jun 2025 18:30:59 +0000
Received: by devvm7589.cco0.facebook.com (Postfix, from userid 669379)
	id D05ED94A1DE; Mon,  9 Jun 2025 11:30:43 -0700 (PDT)
From: Ihor Solodrai <isolodrai@meta.com>
To: <andrii@kernel.org>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <eddyz87@gmail.com>, <mykolal@fb.com>, <yonghong.song@linux.dev>,
        <kernel-team@meta.com>
Subject: [PATCH bpf-next v4 1/3] bpf: make reg_not_null() true for CONST_PTR_TO_MAP
Date: Mon, 9 Jun 2025 11:30:22 -0700
Message-ID: <20250609183024.359974-2-isolodrai@meta.com>
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
X-Authority-Analysis: v=2.4 cv=fNE53Yae c=1 sm=1 tr=0 ts=68472865 cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=6IFa9wvqVegA:10 a=VabnemYjAAAA:8 a=VwQbUJbxAAAA:8 a=eyZTgQFGG2VFfHX4qDcA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: slWLNUjYF3EyM96xNkJFS9nWOpSmNbY5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDE0MCBTYWx0ZWRfXwzSACHdJbOS9 OMlwYe7Bv/yvfvJOzmLQ3da/miGGXzrsYtUtDSz1df4pkd9BOTil7ZkS+ySs9LP4A76GS61gVEs 19G19fD3KQ3NoCs0Ba2YGPFdObd11n5Ghr80dc0R5lY/IrNuL3/LD7hGKO0/wKWqzw/gIQKEl4P
 amfLIEhmSXgxF4tg8NBNi5/5temfY13acWTPfQUz5b3FPeoV0Xf4KeII3ExtQ0O3guzM2Ub/2my pd85PzLCnEsSo4C/jyxr5yPGkQOFMFehMUly3JlpphQtSRs490Lb3OpY7xAGjpO3mIkpOidnpkG nKYkd+1sDRYX9rt+bVEu0RmkPiACaSzARt8YOViO/6jGwbbxH+HMDNUhB1druXfIoJQMIdnkYU1
 JNdP8TmFknXMOy0e52eyVJeoGuh9v+p0HMO0dBcXjRtUU2bCMYJ/0ZwdA3r1CyUpZSjajiJA
X-Proofpoint-GUID: slWLNUjYF3EyM96xNkJFS9nWOpSmNbY5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_07,2025-06-09_02,2025-03-28_01

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
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c                               | 3 ++-
 tools/testing/selftests/bpf/progs/verifier_unpriv.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e31f6b0ccb30..48a3241cda0f 100644
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


