Return-Path: <bpf+bounces-6125-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D86A1766109
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 03:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E21521C2169C
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 01:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4521B15C3;
	Fri, 28 Jul 2023 01:12:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD237C
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 01:12:38 +0000 (UTC)
Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C4B30DE
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 18:12:35 -0700 (PDT)
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id D019323C74902; Thu, 27 Jul 2023 18:12:19 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>
Cc: David Faust <david.faust@oracle.com>,
	Fangrui Song <maskray@google.com>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v5 05/17] bpf: Support new signed div/mod instructions.
Date: Thu, 27 Jul 2023 18:12:19 -0700
Message-Id: <20230728011219.3714605-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230728011143.3710005-1-yonghong.song@linux.dev>
References: <20230728011143.3710005-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
	SPF_HELO_PASS,SPF_SOFTFAIL,TVD_RCVD_IP,T_SCC_BODY_TEXT_LINE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add interpreter/jit support for new signed div/mod insns.
The new signed div/mod instructions are encoded with
unsigned div/mod instructions plus insn->off =3D=3D 1.
Also add basic verifier support to ensure new insns get
accepted.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 arch/x86/net/bpf_jit_comp.c |  27 ++++++---
 kernel/bpf/core.c           | 110 ++++++++++++++++++++++++++++++------
 kernel/bpf/verifier.c       |   6 +-
 3 files changed, 117 insertions(+), 26 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 4942a4c188b9..a89b62eb2b40 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1194,15 +1194,26 @@ static int do_jit(struct bpf_prog *bpf_prog, int =
*addrs, u8 *image, u8 *rw_image
 				/* mov rax, dst_reg */
 				emit_mov_reg(&prog, is64, BPF_REG_0, dst_reg);
=20
-			/*
-			 * xor edx, edx
-			 * equivalent to 'xor rdx, rdx', but one byte less
-			 */
-			EMIT2(0x31, 0xd2);
+			if (insn->off =3D=3D 0) {
+				/*
+				 * xor edx, edx
+				 * equivalent to 'xor rdx, rdx', but one byte less
+				 */
+				EMIT2(0x31, 0xd2);
=20
-			/* div src_reg */
-			maybe_emit_1mod(&prog, src_reg, is64);
-			EMIT2(0xF7, add_1reg(0xF0, src_reg));
+				/* div src_reg */
+				maybe_emit_1mod(&prog, src_reg, is64);
+				EMIT2(0xF7, add_1reg(0xF0, src_reg));
+			} else {
+				if (BPF_CLASS(insn->code) =3D=3D BPF_ALU)
+					EMIT1(0x99); /* cdq */
+				else
+					EMIT2(0x48, 0x99); /* cqo */
+
+				/* idiv src_reg */
+				maybe_emit_1mod(&prog, src_reg, is64);
+				EMIT2(0xF7, add_1reg(0xF8, src_reg));
+			}
=20
 			if (BPF_OP(insn->code) =3D=3D BPF_MOD &&
 			    dst_reg !=3D BPF_REG_3)
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index ad58697cec4b..3fe895199f6e 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1792,36 +1792,114 @@ static u64 ___bpf_prog_run(u64 *regs, const stru=
ct bpf_insn *insn)
 		(*(s64 *) &DST) >>=3D IMM;
 		CONT;
 	ALU64_MOD_X:
-		div64_u64_rem(DST, SRC, &AX);
-		DST =3D AX;
+		switch (OFF) {
+		case 0:
+			div64_u64_rem(DST, SRC, &AX);
+			DST =3D AX;
+			break;
+		case 1:
+			AX =3D div64_s64(DST, SRC);
+			DST =3D DST - AX * SRC;
+			break;
+		}
 		CONT;
 	ALU_MOD_X:
-		AX =3D (u32) DST;
-		DST =3D do_div(AX, (u32) SRC);
+		switch (OFF) {
+		case 0:
+			AX =3D (u32) DST;
+			DST =3D do_div(AX, (u32) SRC);
+			break;
+		case 1:
+			AX =3D abs((s32)DST);
+			AX =3D do_div(AX, abs((s32)SRC));
+			if ((s32)DST < 0)
+				DST =3D (u32)-AX;
+			else
+				DST =3D (u32)AX;
+			break;
+		}
 		CONT;
 	ALU64_MOD_K:
-		div64_u64_rem(DST, IMM, &AX);
-		DST =3D AX;
+		switch (OFF) {
+		case 0:
+			div64_u64_rem(DST, IMM, &AX);
+			DST =3D AX;
+			break;
+		case 1:
+			AX =3D div64_s64(DST, IMM);
+			DST =3D DST - AX * IMM;
+			break;
+		}
 		CONT;
 	ALU_MOD_K:
-		AX =3D (u32) DST;
-		DST =3D do_div(AX, (u32) IMM);
+		switch (OFF) {
+		case 0:
+			AX =3D (u32) DST;
+			DST =3D do_div(AX, (u32) IMM);
+			break;
+		case 1:
+			AX =3D abs((s32)DST);
+			AX =3D do_div(AX, abs((s32)IMM));
+			if ((s32)DST < 0)
+				DST =3D (u32)-AX;
+			else
+				DST =3D (u32)AX;
+			break;
+		}
 		CONT;
 	ALU64_DIV_X:
-		DST =3D div64_u64(DST, SRC);
+		switch (OFF) {
+		case 0:
+			DST =3D div64_u64(DST, SRC);
+			break;
+		case 1:
+			DST =3D div64_s64(DST, SRC);
+			break;
+		}
 		CONT;
 	ALU_DIV_X:
-		AX =3D (u32) DST;
-		do_div(AX, (u32) SRC);
-		DST =3D (u32) AX;
+		switch (OFF) {
+		case 0:
+			AX =3D (u32) DST;
+			do_div(AX, (u32) SRC);
+			DST =3D (u32) AX;
+			break;
+		case 1:
+			AX =3D abs((s32)DST);
+			do_div(AX, abs((s32)SRC));
+			if ((s32)DST < 0 =3D=3D (s32)SRC < 0)
+				DST =3D (u32)AX;
+			else
+				DST =3D (u32)-AX;
+			break;
+		}
 		CONT;
 	ALU64_DIV_K:
-		DST =3D div64_u64(DST, IMM);
+		switch (OFF) {
+		case 0:
+			DST =3D div64_u64(DST, IMM);
+			break;
+		case 1:
+			DST =3D div64_s64(DST, IMM);
+			break;
+		}
 		CONT;
 	ALU_DIV_K:
-		AX =3D (u32) DST;
-		do_div(AX, (u32) IMM);
-		DST =3D (u32) AX;
+		switch (OFF) {
+		case 0:
+			AX =3D (u32) DST;
+			do_div(AX, (u32) IMM);
+			DST =3D (u32) AX;
+			break;
+		case 1:
+			AX =3D abs((s32)DST);
+			do_div(AX, abs((s32)IMM));
+			if ((s32)DST < 0 =3D=3D (s32)IMM < 0)
+				DST =3D (u32)AX;
+			else
+				DST =3D (u32)-AX;
+			break;
+		}
 		CONT;
 	ALU_END_TO_BE:
 		switch (IMM) {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a3dcaeed8217..c0aceedfcb9c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13237,7 +13237,8 @@ static int check_alu_op(struct bpf_verifier_env *=
env, struct bpf_insn *insn)
 	} else {	/* all other ALU ops: and, sub, xor, add, ... */
=20
 		if (BPF_SRC(insn->code) =3D=3D BPF_X) {
-			if (insn->imm !=3D 0 || insn->off !=3D 0) {
+			if (insn->imm !=3D 0 || insn->off > 1 ||
+			    (insn->off =3D=3D 1 && opcode !=3D BPF_MOD && opcode !=3D BPF_DIV=
)) {
 				verbose(env, "BPF_ALU uses reserved fields\n");
 				return -EINVAL;
 			}
@@ -13246,7 +13247,8 @@ static int check_alu_op(struct bpf_verifier_env *=
env, struct bpf_insn *insn)
 			if (err)
 				return err;
 		} else {
-			if (insn->src_reg !=3D BPF_REG_0 || insn->off !=3D 0) {
+			if (insn->src_reg !=3D BPF_REG_0 || insn->off > 1 ||
+			    (insn->off =3D=3D 1 && opcode !=3D BPF_MOD && opcode !=3D BPF_DIV=
)) {
 				verbose(env, "BPF_ALU uses reserved fields\n");
 				return -EINVAL;
 			}
--=20
2.34.1


