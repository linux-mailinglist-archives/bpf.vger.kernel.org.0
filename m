Return-Path: <bpf+bounces-18963-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED86982391E
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 00:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BC2E1F254B9
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 23:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7515F1F609;
	Wed,  3 Jan 2024 23:26:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8932C1EB2D
	for <bpf@vger.kernel.org>; Wed,  3 Jan 2024 23:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id D4E5E2C478AF2; Wed,  3 Jan 2024 15:26:22 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Add a selftest with not-8-byte aligned BPF_ST
Date: Wed,  3 Jan 2024 15:26:22 -0800
Message-Id: <20240103232622.3771107-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240103232617.3770727-1-yonghong.song@linux.dev>
References: <20240103232617.3770727-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add a selftest with a 4 bytes BPF_ST of 0 where the store is not
8-byte aligned. The goal is to ensure that STACK_ZERO is properly
marked for the spill and the STACK_ZERO value can propagate
properly during the load.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/progs/verifier_spill_fill.c | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/to=
ols/testing/selftests/bpf/progs/verifier_spill_fill.c
index d4b3188afe07..6017b26d957d 100644
--- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
+++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
@@ -583,6 +583,50 @@ __naked void partial_stack_load_preserves_zeros(void=
)
 	: __clobber_common);
 }
=20
+SEC("raw_tp")
+__log_level(2)
+__success
+/* fp-4 is STACK_ZERO */
+__msg("2: (62) *(u32 *)(r10 -4) =3D 0          ; R10=3Dfp0 fp-8=3D0000??=
??")
+/* validate that assigning R2 from STACK_ZERO with zero value doesn't ma=
rk register
+ * precise immediately; if necessary, it will be marked precise later
+ */
+__msg("4: (71) r2 =3D *(u8 *)(r10 -1)          ; R2_w=3D0 R10=3Dfp0 fp-8=
=3D0000????")
+__msg("5: (0f) r1 +=3D r2")
+__msg("mark_precise: frame0: last_idx 5 first_idx 0 subseq_idx -1")
+__msg("mark_precise: frame0: regs=3Dr2 stack=3D before 4: (71) r2 =3D *(=
u8 *)(r10 -1)")
+__naked void partial_stack_load_preserves_partial_zeros(void)
+{
+	asm volatile (
+		/* fp-4 is value zero */
+		".8byte %[fp4_st_zero];" /* LLVM-18+: *(u32 *)(r10 -4) =3D 0; */
+
+		/* load single U8 from non-aligned stack zero slot */
+		"r1 =3D %[single_byte_buf];"
+		"r2 =3D *(u8 *)(r10 -1);"
+		"r1 +=3D r2;"
+		"*(u8 *)(r1 + 0) =3D r2;" /* this should be fine */
+
+		/* load single U16 from non-aligned stack zero slot */
+		"r1 =3D %[single_byte_buf];"
+		"r2 =3D *(u16 *)(r10 -2);"
+		"r1 +=3D r2;"
+		"*(u8 *)(r1 + 0) =3D r2;" /* this should be fine */
+
+		/* load single U32 from non-aligned stack zero slot */
+		"r1 =3D %[single_byte_buf];"
+		"r2 =3D *(u32 *)(r10 -4);"
+		"r1 +=3D r2;"
+		"*(u8 *)(r1 + 0) =3D r2;" /* this should be fine */
+
+		"r0 =3D 0;"
+		"exit;"
+	:
+	: __imm_ptr(single_byte_buf),
+	  __imm_insn(fp4_st_zero, BPF_ST_MEM(BPF_W, BPF_REG_FP, -4, 0))
+	: __clobber_common);
+}
+
 char two_byte_buf[2] SEC(".data.two_byte_buf");
=20
 SEC("raw_tp")
--=20
2.34.1


