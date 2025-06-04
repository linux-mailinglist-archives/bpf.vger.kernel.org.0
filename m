Return-Path: <bpf+bounces-59689-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FD5ACE6A4
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 00:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DF623A8848
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 22:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC97221FBC;
	Wed,  4 Jun 2025 22:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="bx5qwgSN"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED4A1EEA47
	for <bpf@vger.kernel.org>; Wed,  4 Jun 2025 22:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749076126; cv=none; b=rmACtGYM0fYpXM41qJDnUhCAwN4q5v12LPMOqrA1CojA7lL04xcnGuV7AJ7q3nhOES1E0TjGh9sHD1J7Uv8ibsycSnBOgK/krGzesWJdQNdKfUaRu594uvJAz4hAbMfmlg0Q/VhcIfomlHjeRO9KyyRZXF0FOA6WeYCBuTPBLXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749076126; c=relaxed/simple;
	bh=g77+F/9L/hdLiDx9MjZAJxoDKD/hIa2VWgCLKTXDfjk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fhvMR3m7XsyAyvZGTE/ty6amEmSqRaUanzTkGdy3Dz698WiavFioKimebNSlWdFnvW2EpOk8WVRCjwUPptYO46x2COKPfxvFp31XeKtpdnYxLPVJFVu28wsN92x8FuF/Y/4O8emNS7n/rGv6N/eT6lACa3TwTUUB0V/o9CnNlN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=bx5qwgSN; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 554MPElh003313
	for <bpf@vger.kernel.org>; Wed, 4 Jun 2025 15:28:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:reply-to:subject:to; s=s2048-2021-q4; bh=QJ3kaiJ2s
	/+6QS3wVA0z4CUNu9ayRmt3DqsqGnMWoJ0=; b=bx5qwgSNVrinv532HFGnVw0my
	BQcFQejPucb1OBU5DcpAFSqOCSJ4Lj6zOkNIl4HD7bNKWJQutsvcr74BQdUdhiR7
	eYi9RwmK620tEMeRLHKbWkNaRwzIXq7RSUHsWrId6Ywe1EjYb20IBJC900d38vgc
	dbaeRUydwW+WZqu8Zp9In8d8gReuL87Oh0Gv8KWXMAePUCQJ9ZduMMGQ4FbwDnPn
	iYjMLw5FqG3y1RUW9G/zdKhDuAlYAuPGXzniYQAWx5qWbHPM7vMbJzEhQ6+HrIj+
	UQ5Ovpr+NIneZjuXslp44LeDoLy5cP0IMXqWagKLN7Ib3oa+5j17qmLrlxduQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 472mnjw8us-11
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 04 Jun 2025 15:28:43 -0700 (PDT)
Received: from twshared71637.05.prn6.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Wed, 4 Jun 2025 22:28:14 +0000
Received: by devvm7589.cco0.facebook.com (Postfix, from userid 669379)
	id 1C8BC46C87A; Wed,  4 Jun 2025 15:27:59 -0700 (PDT)
From: Ihor Solodrai <isolodrai@meta.com>
To: <andrii@kernel.org>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <eddyz87@gmail.com>, <mykolal@fb.com>, <yonghong.song@linux.dev>,
        <kernel-team@meta.com>
Subject: [PATCH bpf-next v3 1/3] bpf: make reg_not_null() true for CONST_PTR_TO_MAP
Date: Wed, 4 Jun 2025 15:27:27 -0700
Message-ID: <20250604222729.3351946-1-isolodrai@meta.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDE4NSBTYWx0ZWRfX8wtvDamEXXKz uBnONDZrAAwyWEBqlvRiIWYKYEdbVkvQPfUqfg1/nEy6akxY4r2fPUoldNTlAhg7twKa5L9hp02 EZz06FrFt20OAgmnfWtE2KuEYKkxYcH6cqL4rkC28gpeaDdq3ogoLm8zbVO7FfyrS/3+NWHrY1c
 /Ppudty/DPh2a/CVgciWpTdmhjKNNVnJmYJ816mZKhZo1Y3qrybV1YnPO4AZQt4BJxQFG2Dd+aD rxxN79vzUs4vy109Gb+Rvaq3FBHKU8c6XsmHHUiUKe/kvV6SJlSKLq6/IXG/YxIeyZmWpBTbFdp Aoo/M3gCa7uP5oUCUyIZO7jfq5oonBbj0Vb098SQ31nVeBl43JS4+g9i6MMMf6XYbS/8k7IP0/v
 KYHiOOzprX2mHmr14w44FNVxoWm3a5xMIFXWXjvQePHnfFhVjatT55VzQWtUVSGys52Zi4Ey
X-Authority-Analysis: v=2.4 cv=S+zZwJsP c=1 sm=1 tr=0 ts=6840c89b cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=6IFa9wvqVegA:10 a=VabnemYjAAAA:8 a=eyZTgQFGG2VFfHX4qDcA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: rUkeLNYhX8flc3CMFFpyCQ0Nr1g9xmzv
X-Proofpoint-GUID: rUkeLNYhX8flc3CMFFpyCQ0Nr1g9xmzv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_04,2025-06-03_02,2025-03-28_01

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


