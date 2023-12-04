Return-Path: <bpf+bounces-16623-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9084803E5A
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 20:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24976B20B4F
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 19:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDF331757;
	Mon,  4 Dec 2023 19:26:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50055AC
	for <bpf@vger.kernel.org>; Mon,  4 Dec 2023 11:26:37 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 3B4JDxos002969
	for <bpf@vger.kernel.org>; Mon, 4 Dec 2023 11:26:36 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 3us79gnupp-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 04 Dec 2023 11:26:36 -0800
Received: from twshared34392.14.frc2.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 4 Dec 2023 11:26:34 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id B70E83C94B904; Mon,  4 Dec 2023 11:26:25 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>,
        Eduard Zingerman
	<eddyz87@gmail.com>
Subject: [PATCH v3 bpf-next 09/10] selftests/bpf: validate precision logic in partial_stack_load_preserves_zeros
Date: Mon, 4 Dec 2023 11:26:00 -0800
Message-ID: <20231204192601.2672497-10-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231204192601.2672497-1-andrii@kernel.org>
References: <20231204192601.2672497-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: dsg9vjFIPwVxShwNkCT4NlL2LsSXtnhz
X-Proofpoint-GUID: dsg9vjFIPwVxShwNkCT4NlL2LsSXtnhz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_18,2023-12-04_01,2023-05-22_02

Enhance partial_stack_load_preserves_zeros subtest with detailed
precision propagation log checks. We know expect fp-16 to be spilled,
initially imprecise, zero const register, which is later marked as
precise even when partial stack slot load is performed, even if it's not
a register fill (!).

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/progs/verifier_spill_fill.c | 40 +++++++++++++++----
 1 file changed, 32 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/to=
ols/testing/selftests/bpf/progs/verifier_spill_fill.c
index 7c1f1927f01a..f7bebc79fec4 100644
--- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
+++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
@@ -492,6 +492,22 @@ char single_byte_buf[1] SEC(".data.single_byte_buf")=
;
 SEC("raw_tp")
 __log_level(2)
 __success
+/* make sure fp-8 is all STACK_ZERO */
+__msg("2: (7a) *(u64 *)(r10 -8) =3D 0          ; R10=3Dfp0 fp-8_w=3D0000=
0000")
+/* but fp-16 is spilled IMPRECISE zero const reg */
+__msg("4: (7b) *(u64 *)(r10 -16) =3D r0        ; R0_w=3D0 R10=3Dfp0 fp-1=
6_w=3D0")
+/* and now check that precision propagation works even for such tricky c=
ase */
+__msg("10: (71) r2 =3D *(u8 *)(r10 -9)         ; R2_w=3DP0 R10=3Dfp0 fp-=
16_w=3D0")
+__msg("11: (0f) r1 +=3D r2")
+__msg("mark_precise: frame0: last_idx 11 first_idx 0 subseq_idx -1")
+__msg("mark_precise: frame0: regs=3Dr2 stack=3D before 10: (71) r2 =3D *=
(u8 *)(r10 -9)")
+__msg("mark_precise: frame0: regs=3D stack=3D-16 before 9: (bf) r1 =3D r=
6")
+__msg("mark_precise: frame0: regs=3D stack=3D-16 before 8: (73) *(u8 *)(=
r1 +0) =3D r2")
+__msg("mark_precise: frame0: regs=3D stack=3D-16 before 7: (0f) r1 +=3D =
r2")
+__msg("mark_precise: frame0: regs=3D stack=3D-16 before 6: (71) r2 =3D *=
(u8 *)(r10 -1)")
+__msg("mark_precise: frame0: regs=3D stack=3D-16 before 5: (bf) r1 =3D r=
6")
+__msg("mark_precise: frame0: regs=3D stack=3D-16 before 4: (7b) *(u64 *)=
(r10 -16) =3D r0")
+__msg("mark_precise: frame0: regs=3Dr0 stack=3D before 3: (b7) r0 =3D 0"=
)
 __naked void partial_stack_load_preserves_zeros(void)
 {
 	asm volatile (
@@ -505,42 +521,50 @@ __naked void partial_stack_load_preserves_zeros(voi=
d)
 		/* load single U8 from non-aligned STACK_ZERO slot */
 		"r1 =3D %[single_byte_buf];"
 		"r2 =3D *(u8 *)(r10 -1);"
-		"r1 +=3D r2;" /* this should be fine */
+		"r1 +=3D r2;"
+		"*(u8 *)(r1 + 0) =3D r2;" /* this should be fine */
=20
 		/* load single U8 from non-aligned ZERO REG slot */
 		"r1 =3D %[single_byte_buf];"
 		"r2 =3D *(u8 *)(r10 -9);"
-		"r1 +=3D r2;" /* this should be fine */
+		"r1 +=3D r2;"
+		"*(u8 *)(r1 + 0) =3D r2;" /* this should be fine */
=20
 		/* load single U16 from non-aligned STACK_ZERO slot */
 		"r1 =3D %[single_byte_buf];"
 		"r2 =3D *(u16 *)(r10 -2);"
-		"r1 +=3D r2;" /* this should be fine */
+		"r1 +=3D r2;"
+		"*(u8 *)(r1 + 0) =3D r2;" /* this should be fine */
=20
 		/* load single U16 from non-aligned ZERO REG slot */
 		"r1 =3D %[single_byte_buf];"
 		"r2 =3D *(u16 *)(r10 -10);"
-		"r1 +=3D r2;" /* this should be fine */
+		"r1 +=3D r2;"
+		"*(u8 *)(r1 + 0) =3D r2;" /* this should be fine */
=20
 		/* load single U32 from non-aligned STACK_ZERO slot */
 		"r1 =3D %[single_byte_buf];"
 		"r2 =3D *(u32 *)(r10 -4);"
-		"r1 +=3D r2;" /* this should be fine */
+		"r1 +=3D r2;"
+		"*(u8 *)(r1 + 0) =3D r2;" /* this should be fine */
=20
 		/* load single U32 from non-aligned ZERO REG slot */
 		"r1 =3D %[single_byte_buf];"
 		"r2 =3D *(u32 *)(r10 -12);"
-		"r1 +=3D r2;" /* this should be fine */
+		"r1 +=3D r2;"
+		"*(u8 *)(r1 + 0) =3D r2;" /* this should be fine */
=20
 		/* for completeness, load U64 from STACK_ZERO slot */
 		"r1 =3D %[single_byte_buf];"
 		"r2 =3D *(u64 *)(r10 -8);"
-		"r1 +=3D r2;" /* this should be fine */
+		"r1 +=3D r2;"
+		"*(u8 *)(r1 + 0) =3D r2;" /* this should be fine */
=20
 		/* for completeness, load U64 from ZERO REG slot */
 		"r1 =3D %[single_byte_buf];"
 		"r2 =3D *(u64 *)(r10 -16);"
-		"r1 +=3D r2;" /* this should be fine */
+		"r1 +=3D r2;"
+		"*(u8 *)(r1 + 0) =3D r2;" /* this should be fine */
=20
 		"r0 =3D 0;"
 		"exit;"
--=20
2.34.1


