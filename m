Return-Path: <bpf+bounces-17296-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1489480B141
	for <lists+bpf@lfdr.de>; Sat,  9 Dec 2023 02:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8A201C20D13
	for <lists+bpf@lfdr.de>; Sat,  9 Dec 2023 01:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D467EA2;
	Sat,  9 Dec 2023 01:10:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59EAA1716
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 17:10:17 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B8NNmOp008940
	for <bpf@vger.kernel.org>; Fri, 8 Dec 2023 17:10:17 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3uvcserk2p-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 08 Dec 2023 17:10:16 -0800
Received: from twshared17205.35.frc1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 8 Dec 2023 17:10:15 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 8AC0D3CD4E3F4; Fri,  8 Dec 2023 17:10:03 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: validate fake register spill/fill precision backtracking logic
Date: Fri, 8 Dec 2023 17:09:58 -0800
Message-ID: <20231209010958.66758-2-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231209010958.66758-1-andrii@kernel.org>
References: <20231209010958.66758-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: U9ak4oFO4qMzjzIeMlXKWmZRAh3AHrvw
X-Proofpoint-ORIG-GUID: U9ak4oFO4qMzjzIeMlXKWmZRAh3AHrvw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-08_16,2023-12-07_01,2023-05-22_02

Add two tests validating that verifier's precision backtracking logic
handles BPF_ST_MEM instructions that produce fake register spill into
register slot. This is happening when non-zero constant is written
directly to a slot, e.g., *(u64 *)(r10 -8) =3D 123.

Add both full 64-bit register spill, as well as 32-bit "sub-spill".

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/progs/verifier_spill_fill.c | 154 ++++++++++++++++++
 1 file changed, 154 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/to=
ols/testing/selftests/bpf/progs/verifier_spill_fill.c
index df4920da3472..508f5d6c7347 100644
--- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
+++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
@@ -577,4 +577,158 @@ __naked void partial_stack_load_preserves_zeros(voi=
d)
 	: __clobber_common);
 }
=20
+char two_byte_buf[2] SEC(".data.two_byte_buf");
+
+SEC("raw_tp")
+__log_level(2) __flag(BPF_F_TEST_STATE_FREQ)
+__success
+/* make sure fp-8 is IMPRECISE fake register spill */
+__msg("3: (7a) *(u64 *)(r10 -8) =3D 1          ; R10=3Dfp0 fp-8_w=3D1")
+/* and fp-16 is spilled IMPRECISE const reg */
+__msg("5: (7b) *(u64 *)(r10 -16) =3D r0        ; R0_w=3D1 R10=3Dfp0 fp-1=
6_w=3D1")
+/* validate load from fp-8, which was initialized using BPF_ST_MEM */
+__msg("8: (79) r2 =3D *(u64 *)(r10 -8)         ; R2_w=3D1 R10=3Dfp0 fp-8=
=3D1")
+__msg("9: (0f) r1 +=3D r2")
+__msg("mark_precise: frame0: last_idx 9 first_idx 7 subseq_idx -1")
+__msg("mark_precise: frame0: regs=3Dr2 stack=3D before 8: (79) r2 =3D *(=
u64 *)(r10 -8)")
+__msg("mark_precise: frame0: regs=3D stack=3D-8 before 7: (bf) r1 =3D r6=
")
+/* note, fp-8 is precise, fp-16 is not yet precise, we'll get there */
+__msg("mark_precise: frame0: parent state regs=3D stack=3D-8:  R0_w=3D1 =
R1=3Dctx() R6_r=3Dmap_value(map=3D.data.two_byte_,ks=3D4,vs=3D2) R10=3Dfp=
0 fp-8_rw=3DP1 fp-16_w=3D1")
+__msg("mark_precise: frame0: last_idx 6 first_idx 3 subseq_idx 7")
+__msg("mark_precise: frame0: regs=3D stack=3D-8 before 6: (05) goto pc+0=
")
+__msg("mark_precise: frame0: regs=3D stack=3D-8 before 5: (7b) *(u64 *)(=
r10 -16) =3D r0")
+__msg("mark_precise: frame0: regs=3D stack=3D-8 before 4: (b7) r0 =3D 1"=
)
+__msg("mark_precise: frame0: regs=3D stack=3D-8 before 3: (7a) *(u64 *)(=
r10 -8) =3D 1")
+__msg("10: R1_w=3Dmap_value(map=3D.data.two_byte_,ks=3D4,vs=3D2,off=3D1)=
 R2_w=3D1")
+/* validate load from fp-16, which was initialized using BPF_STX_MEM */
+__msg("12: (79) r2 =3D *(u64 *)(r10 -16)       ; R2_w=3D1 R10=3Dfp0 fp-1=
6=3D1")
+__msg("13: (0f) r1 +=3D r2")
+__msg("mark_precise: frame0: last_idx 13 first_idx 7 subseq_idx -1")
+__msg("mark_precise: frame0: regs=3Dr2 stack=3D before 12: (79) r2 =3D *=
(u64 *)(r10 -16)")
+__msg("mark_precise: frame0: regs=3D stack=3D-16 before 11: (bf) r1 =3D =
r6")
+__msg("mark_precise: frame0: regs=3D stack=3D-16 before 10: (73) *(u8 *)=
(r1 +0) =3D r2")
+__msg("mark_precise: frame0: regs=3D stack=3D-16 before 9: (0f) r1 +=3D =
r2")
+__msg("mark_precise: frame0: regs=3D stack=3D-16 before 8: (79) r2 =3D *=
(u64 *)(r10 -8)")
+__msg("mark_precise: frame0: regs=3D stack=3D-16 before 7: (bf) r1 =3D r=
6")
+/* now both fp-8 and fp-16 are precise, very good */
+__msg("mark_precise: frame0: parent state regs=3D stack=3D-16:  R0_w=3D1=
 R1=3Dctx() R6_r=3Dmap_value(map=3D.data.two_byte_,ks=3D4,vs=3D2) R10=3Df=
p0 fp-8_rw=3DP1 fp-16_rw=3DP1")
+__msg("mark_precise: frame0: last_idx 6 first_idx 3 subseq_idx 7")
+__msg("mark_precise: frame0: regs=3D stack=3D-16 before 6: (05) goto pc+=
0")
+__msg("mark_precise: frame0: regs=3D stack=3D-16 before 5: (7b) *(u64 *)=
(r10 -16) =3D r0")
+__msg("mark_precise: frame0: regs=3Dr0 stack=3D before 4: (b7) r0 =3D 1"=
)
+__msg("14: R1_w=3Dmap_value(map=3D.data.two_byte_,ks=3D4,vs=3D2,off=3D1)=
 R2_w=3D1")
+__naked void stack_load_preserves_const_precision(void)
+{
+	asm volatile (
+		/* establish checkpoint with state that has no stack slots;
+		 * if we bubble up to this state without finding desired stack
+		 * slot, then it's a bug and should be caught
+		 */
+		"goto +0;"
+
+		/* fp-8 is const 1 *fake* register */
+		".8byte %[fp8_st_one];" /* LLVM-18+: *(u64 *)(r10 -8) =3D 1; */
+
+		/* fp-16 is const 1 register */
+		"r0 =3D 1;"
+		"*(u64 *)(r10 -16) =3D r0;"
+
+		/* force checkpoint to check precision marks preserved in parent state=
s */
+		"goto +0;"
+
+		/* load single U64 from aligned FAKE_REG=3D1 slot */
+		"r1 =3D %[two_byte_buf];"
+		"r2 =3D *(u64 *)(r10 -8);"
+		"r1 +=3D r2;"
+		"*(u8 *)(r1 + 0) =3D r2;" /* this should be fine */
+
+		/* load single U64 from aligned REG=3D1 slot */
+		"r1 =3D %[two_byte_buf];"
+		"r2 =3D *(u64 *)(r10 -16);"
+		"r1 +=3D r2;"
+		"*(u8 *)(r1 + 0) =3D r2;" /* this should be fine */
+
+		"r0 =3D 0;"
+		"exit;"
+	:
+	: __imm_ptr(two_byte_buf),
+	  __imm_insn(fp8_st_one, BPF_ST_MEM(BPF_DW, BPF_REG_FP, -8, 1))
+	: __clobber_common);
+}
+
+SEC("raw_tp")
+__log_level(2) __flag(BPF_F_TEST_STATE_FREQ)
+__success
+/* make sure fp-8 is 32-bit FAKE subregister spill */
+__msg("3: (62) *(u32 *)(r10 -8) =3D 1          ; R10=3Dfp0 fp-8=3D????1"=
)
+/* but fp-16 is spilled IMPRECISE zero const reg */
+__msg("5: (63) *(u32 *)(r10 -16) =3D r0        ; R0_w=3D1 R10=3Dfp0 fp-1=
6=3D????1")
+/* validate load from fp-8, which was initialized using BPF_ST_MEM */
+__msg("8: (61) r2 =3D *(u32 *)(r10 -8)         ; R2_w=3D1 R10=3Dfp0 fp-8=
=3D????1")
+__msg("9: (0f) r1 +=3D r2")
+__msg("mark_precise: frame0: last_idx 9 first_idx 7 subseq_idx -1")
+__msg("mark_precise: frame0: regs=3Dr2 stack=3D before 8: (61) r2 =3D *(=
u32 *)(r10 -8)")
+__msg("mark_precise: frame0: regs=3D stack=3D-8 before 7: (bf) r1 =3D r6=
")
+__msg("mark_precise: frame0: parent state regs=3D stack=3D-8:  R0_w=3D1 =
R1=3Dctx() R6_r=3Dmap_value(map=3D.data.two_byte_,ks=3D4,vs=3D2) R10=3Dfp=
0 fp-8_r=3D????P1 fp-16=3D????1")
+__msg("mark_precise: frame0: last_idx 6 first_idx 3 subseq_idx 7")
+__msg("mark_precise: frame0: regs=3D stack=3D-8 before 6: (05) goto pc+0=
")
+__msg("mark_precise: frame0: regs=3D stack=3D-8 before 5: (63) *(u32 *)(=
r10 -16) =3D r0")
+__msg("mark_precise: frame0: regs=3D stack=3D-8 before 4: (b7) r0 =3D 1"=
)
+__msg("mark_precise: frame0: regs=3D stack=3D-8 before 3: (62) *(u32 *)(=
r10 -8) =3D 1")
+__msg("10: R1_w=3Dmap_value(map=3D.data.two_byte_,ks=3D4,vs=3D2,off=3D1)=
 R2_w=3D1")
+/* validate load from fp-16, which was initialized using BPF_STX_MEM */
+__msg("12: (61) r2 =3D *(u32 *)(r10 -16)       ; R2_w=3D1 R10=3Dfp0 fp-1=
6=3D????1")
+__msg("13: (0f) r1 +=3D r2")
+__msg("mark_precise: frame0: last_idx 13 first_idx 7 subseq_idx -1")
+__msg("mark_precise: frame0: regs=3Dr2 stack=3D before 12: (61) r2 =3D *=
(u32 *)(r10 -16)")
+__msg("mark_precise: frame0: regs=3D stack=3D-16 before 11: (bf) r1 =3D =
r6")
+__msg("mark_precise: frame0: regs=3D stack=3D-16 before 10: (73) *(u8 *)=
(r1 +0) =3D r2")
+__msg("mark_precise: frame0: regs=3D stack=3D-16 before 9: (0f) r1 +=3D =
r2")
+__msg("mark_precise: frame0: regs=3D stack=3D-16 before 8: (61) r2 =3D *=
(u32 *)(r10 -8)")
+__msg("mark_precise: frame0: regs=3D stack=3D-16 before 7: (bf) r1 =3D r=
6")
+__msg("mark_precise: frame0: parent state regs=3D stack=3D-16:  R0_w=3D1=
 R1=3Dctx() R6_r=3Dmap_value(map=3D.data.two_byte_,ks=3D4,vs=3D2) R10=3Df=
p0 fp-8_r=3D????P1 fp-16_r=3D????P1")
+__msg("mark_precise: frame0: last_idx 6 first_idx 3 subseq_idx 7")
+__msg("mark_precise: frame0: regs=3D stack=3D-16 before 6: (05) goto pc+=
0")
+__msg("mark_precise: frame0: regs=3D stack=3D-16 before 5: (63) *(u32 *)=
(r10 -16) =3D r0")
+__msg("mark_precise: frame0: regs=3Dr0 stack=3D before 4: (b7) r0 =3D 1"=
)
+__msg("14: R1_w=3Dmap_value(map=3D.data.two_byte_,ks=3D4,vs=3D2,off=3D1)=
 R2_w=3D1")
+__naked void stack_load_preserves_const_precision_subreg(void)
+{
+	asm volatile (
+		/* establish checkpoint with state that has no stack slots;
+		 * if we bubble up to this state without finding desired stack
+		 * slot, then it's a bug and should be caught
+		 */
+		"goto +0;"
+
+		/* fp-8 is const 1 *fake* SUB-register */
+		".8byte %[fp8_st_one];" /* LLVM-18+: *(u32 *)(r10 -8) =3D 1; */
+
+		/* fp-16 is const 1 SUB-register */
+		"r0 =3D 1;"
+		"*(u32 *)(r10 -16) =3D r0;"
+
+		/* force checkpoint to check precision marks preserved in parent state=
s */
+		"goto +0;"
+
+		/* load single U32 from aligned FAKE_REG=3D1 slot */
+		"r1 =3D %[two_byte_buf];"
+		"r2 =3D *(u32 *)(r10 -8);"
+		"r1 +=3D r2;"
+		"*(u8 *)(r1 + 0) =3D r2;" /* this should be fine */
+
+		/* load single U32 from aligned REG=3D1 slot */
+		"r1 =3D %[two_byte_buf];"
+		"r2 =3D *(u32 *)(r10 -16);"
+		"r1 +=3D r2;"
+		"*(u8 *)(r1 + 0) =3D r2;" /* this should be fine */
+
+		"r0 =3D 0;"
+		"exit;"
+	:
+	: __imm_ptr(two_byte_buf),
+	  __imm_insn(fp8_st_one, BPF_ST_MEM(BPF_W, BPF_REG_FP, -8, 1)) /* 32-bi=
t spill */
+	: __clobber_common);
+}
+
 char _license[] SEC("license") =3D "GPL";
--=20
2.34.1


