Return-Path: <bpf+bounces-15459-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6DC97F220D
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 01:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 726582827EF
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 00:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8369180B;
	Tue, 21 Nov 2023 00:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A20BB
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 16:22:50 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 3AL0FPoG005059
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 16:22:49 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
	by m0001303.ppops.net (PPS) with ESMTPS id 3ugh9g075b-12
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 16:22:49 -0800
Received: from twshared29647.38.frc1.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 16:22:42 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id C6C733BD942C5; Mon, 20 Nov 2023 16:22:37 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v2 bpf-next 07/10] selftests/bpf: validate zero preservation for sub-slot loads
Date: Mon, 20 Nov 2023 16:22:18 -0800
Message-ID: <20231121002221.3687787-8-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231121002221.3687787-1-andrii@kernel.org>
References: <20231121002221.3687787-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: XOelS7e4ODI85h1jKXhejxMBnB_X3_Jd
X-Proofpoint-GUID: XOelS7e4ODI85h1jKXhejxMBnB_X3_Jd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_22,2023-11-20_01,2023-05-22_02

Validate that 1-, 2-, and 4-byte loads from stack slots not aligned on
8-byte boundary still preserve zero, when loading from all-STACK_ZERO
sub-slots, or when stack sub-slots are covered by spilled register with
known constant zero value.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/progs/verifier_spill_fill.c | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/to=
ols/testing/selftests/bpf/progs/verifier_spill_fill.c
index 899a74ac9093..60ad2e0247b4 100644
--- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
+++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
@@ -486,4 +486,66 @@ __naked void spill_subregs_preserve_stack_zero(void)
 	: __clobber_all);
 }
=20
+char single_byte_buf[1] SEC(".data.single_byte_buf");
+
+SEC("raw_tp")
+__log_level(2)
+__success
+__naked void partial_stack_load_preserves_zeros(void)
+{
+	asm volatile (
+		/* fp-8 is all STACK_ZERO */
+		"*(u64 *)(r10 -8) =3D 0;"
+
+		/* fp-16 is const zero register */
+		"r0 =3D 0;"
+		"*(u64 *)(r10 -16) =3D r0;"
+
+		/* load single U8 from non-aligned STACK_ZERO slot */
+		"r1 =3D %[single_byte_buf];"
+		"r2 =3D *(u8 *)(r10 -1);"
+		"r1 +=3D r2;" /* this should be fine */
+
+		/* load single U8 from non-aligned ZERO REG slot */
+		"r1 =3D %[single_byte_buf];"
+		"r2 =3D *(u8 *)(r10 -9);"
+		"r1 +=3D r2;" /* this should be fine */
+
+		/* load single U16 from non-aligned STACK_ZERO slot */
+		"r1 =3D %[single_byte_buf];"
+		"r2 =3D *(u16 *)(r10 -2);"
+		"r1 +=3D r2;" /* this should be fine */
+
+		/* load single U16 from non-aligned ZERO REG slot */
+		"r1 =3D %[single_byte_buf];"
+		"r2 =3D *(u16 *)(r10 -10);"
+		"r1 +=3D r2;" /* this should be fine */
+
+		/* load single U32 from non-aligned STACK_ZERO slot */
+		"r1 =3D %[single_byte_buf];"
+		"r2 =3D *(u32 *)(r10 -4);"
+		"r1 +=3D r2;" /* this should be fine */
+
+		/* load single U32 from non-aligned ZERO REG slot */
+		"r1 =3D %[single_byte_buf];"
+		"r2 =3D *(u32 *)(r10 -12);"
+		"r1 +=3D r2;" /* this should be fine */
+
+		/* for completeness, load U64 from STACK_ZERO slot */
+		"r1 =3D %[single_byte_buf];"
+		"r2 =3D *(u64 *)(r10 -8);"
+		"r1 +=3D r2;" /* this should be fine */
+
+		/* for completeness, load U64 from ZERO REG slot */
+		"r1 =3D %[single_byte_buf];"
+		"r2 =3D *(u64 *)(r10 -16);"
+		"r1 +=3D r2;" /* this should be fine */
+
+		"r0 =3D 0;"
+		"exit;"
+	:
+	: __imm_ptr(single_byte_buf)
+	: __clobber_common);
+}
+
 char _license[] SEC("license") =3D "GPL";
--=20
2.34.1


