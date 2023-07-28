Return-Path: <bpf+bounces-6124-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F94766105
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 03:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B74881C21651
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 01:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CF417CF;
	Fri, 28 Jul 2023 01:12:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F8917C4
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 01:12:17 +0000 (UTC)
Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8941E30E8
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 18:12:14 -0700 (PDT)
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id CF77823C74893; Thu, 27 Jul 2023 18:12:02 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 02/17] bpf: Support new sign-extension mov insns
Date: Thu, 27 Jul 2023 18:12:02 -0700
Message-Id: <20230728011202.3712300-1-yonghong.song@linux.dev>
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

Add interpreter/jit support for new sign-extension mov insns.
The original 'MOV' insn is extended to support reg-to-reg
signed version for both ALU and ALU64 operations. For ALU mode,
the insn->off value of 8 or 16 indicates sign-extension
from 8- or 16-bit value to 32-bit value. For ALU64 mode,
the insn->off value of 8/16/32 indicates sign-extension
from 8-, 16- or 32-bit value to 64-bit value.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 arch/x86/net/bpf_jit_comp.c |  43 +++++++++-
 kernel/bpf/core.c           |  28 ++++++-
 kernel/bpf/verifier.c       | 157 ++++++++++++++++++++++++++++++------
 3 files changed, 197 insertions(+), 31 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 54478a9c93e1..031ef3c4185d 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -701,6 +701,38 @@ static void emit_mov_reg(u8 **pprog, bool is64, u32 =
dst_reg, u32 src_reg)
 	*pprog =3D prog;
 }
=20
+static void emit_movsx_reg(u8 **pprog, int num_bits, bool is64, u32 dst_=
reg,
+			   u32 src_reg)
+{
+	u8 *prog =3D *pprog;
+
+	if (is64) {
+		/* movs[b,w,l]q dst, src */
+		if (num_bits =3D=3D 8)
+			EMIT4(add_2mod(0x48, src_reg, dst_reg), 0x0f, 0xbe,
+			      add_2reg(0xC0, src_reg, dst_reg));
+		else if (num_bits =3D=3D 16)
+			EMIT4(add_2mod(0x48, src_reg, dst_reg), 0x0f, 0xbf,
+			      add_2reg(0xC0, src_reg, dst_reg));
+		else if (num_bits =3D=3D 32)
+			EMIT3(add_2mod(0x48, src_reg, dst_reg), 0x63,
+			      add_2reg(0xC0, src_reg, dst_reg));
+	} else {
+		/* movs[b,w]l dst, src */
+		if (num_bits =3D=3D 8) {
+			EMIT4(add_2mod(0x40, src_reg, dst_reg), 0x0f, 0xbe,
+			      add_2reg(0xC0, src_reg, dst_reg));
+		} else if (num_bits =3D=3D 16) {
+			if (is_ereg(dst_reg) || is_ereg(src_reg))
+				EMIT1(add_2mod(0x40, src_reg, dst_reg));
+			EMIT3(add_2mod(0x0f, src_reg, dst_reg), 0xbf,
+			      add_2reg(0xC0, src_reg, dst_reg));
+		}
+	}
+
+	*pprog =3D prog;
+}
+
 /* Emit the suffix (ModR/M etc) for addressing *(ptr_reg + off) and val_=
reg */
 static void emit_insn_suffix(u8 **pprog, u32 ptr_reg, u32 val_reg, int o=
ff)
 {
@@ -1051,9 +1083,14 @@ static int do_jit(struct bpf_prog *bpf_prog, int *=
addrs, u8 *image, u8 *rw_image
=20
 		case BPF_ALU64 | BPF_MOV | BPF_X:
 		case BPF_ALU | BPF_MOV | BPF_X:
-			emit_mov_reg(&prog,
-				     BPF_CLASS(insn->code) =3D=3D BPF_ALU64,
-				     dst_reg, src_reg);
+			if (insn->off =3D=3D 0)
+				emit_mov_reg(&prog,
+					     BPF_CLASS(insn->code) =3D=3D BPF_ALU64,
+					     dst_reg, src_reg);
+			else
+				emit_movsx_reg(&prog, insn->off,
+					       BPF_CLASS(insn->code) =3D=3D BPF_ALU64,
+					       dst_reg, src_reg);
 			break;
=20
 			/* neg dst */
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 01b72fc001f6..c37c454b09eb 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -61,6 +61,7 @@
 #define AX	regs[BPF_REG_AX]
 #define ARG1	regs[BPF_REG_ARG1]
 #define CTX	regs[BPF_REG_CTX]
+#define OFF	insn->off
 #define IMM	insn->imm
=20
 struct bpf_mem_alloc bpf_global_ma;
@@ -1739,13 +1740,36 @@ static u64 ___bpf_prog_run(u64 *regs, const struc=
t bpf_insn *insn)
 		DST =3D -DST;
 		CONT;
 	ALU_MOV_X:
-		DST =3D (u32) SRC;
+		switch (OFF) {
+		case 0:
+			DST =3D (u32) SRC;
+			break;
+		case 8:
+			DST =3D (u32)(s8) SRC;
+			break;
+		case 16:
+			DST =3D (u32)(s16) SRC;
+			break;
+		}
 		CONT;
 	ALU_MOV_K:
 		DST =3D (u32) IMM;
 		CONT;
 	ALU64_MOV_X:
-		DST =3D SRC;
+		switch (OFF) {
+		case 0:
+			DST =3D SRC;
+			break;
+		case 8:
+			DST =3D (s8) SRC;
+			break;
+		case 16:
+			DST =3D (s16) SRC;
+			break;
+		case 32:
+			DST =3D (s32) SRC;
+			break;
+		}
 		CONT;
 	ALU64_MOV_K:
 		DST =3D IMM;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b154854034e0..2f3eebcd962f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3421,7 +3421,7 @@ static int backtrack_insn(struct bpf_verifier_env *=
env, int idx, int subseq_idx,
 			return 0;
 		if (opcode =3D=3D BPF_MOV) {
 			if (BPF_SRC(insn->code) =3D=3D BPF_X) {
-				/* dreg =3D sreg
+				/* dreg =3D sreg or dreg =3D (s8, s16, s32)sreg
 				 * dreg needs precision after this insn
 				 * sreg needs precision before this insn
 				 */
@@ -5905,6 +5905,69 @@ static void coerce_reg_to_size_sx(struct bpf_reg_s=
tate *reg, int size)
 	set_sext64_default_val(reg, size);
 }
=20
+static void set_sext32_default_val(struct bpf_reg_state *reg, int size)
+{
+	if (size =3D=3D 1) {
+		reg->s32_min_value =3D S8_MIN;
+		reg->s32_max_value =3D S8_MAX;
+	} else {
+		/* size =3D=3D 2 */
+		reg->s32_min_value =3D S16_MIN;
+		reg->s32_max_value =3D S16_MAX;
+	}
+	reg->u32_min_value =3D 0;
+	reg->u32_max_value =3D U32_MAX;
+}
+
+static void coerce_subreg_to_size_sx(struct bpf_reg_state *reg, int size=
)
+{
+	s32 init_s32_max, init_s32_min, s32_max, s32_min, u32_val;
+	u32 top_smax_value, top_smin_value;
+	u32 num_bits =3D size * 8;
+
+	if (tnum_is_const(reg->var_off)) {
+		u32_val =3D reg->var_off.value;
+		if (size =3D=3D 1)
+			reg->var_off =3D tnum_const((s8)u32_val);
+		else
+			reg->var_off =3D tnum_const((s16)u32_val);
+
+		u32_val =3D reg->var_off.value;
+		reg->s32_min_value =3D reg->s32_max_value =3D u32_val;
+		reg->u32_min_value =3D reg->u32_max_value =3D u32_val;
+		return;
+	}
+
+	top_smax_value =3D ((u32)reg->s32_max_value >> num_bits) << num_bits;
+	top_smin_value =3D ((u32)reg->s32_min_value >> num_bits) << num_bits;
+
+	if (top_smax_value !=3D top_smin_value)
+		goto out;
+
+	/* find the s32_min and s32_min after sign extension */
+	if (size =3D=3D 1) {
+		init_s32_max =3D (s8)reg->s32_max_value;
+		init_s32_min =3D (s8)reg->s32_min_value;
+	} else {
+		/* size =3D=3D 2 */
+		init_s32_max =3D (s16)reg->s32_max_value;
+		init_s32_min =3D (s16)reg->s32_min_value;
+	}
+	s32_max =3D max(init_s32_max, init_s32_min);
+	s32_min =3D min(init_s32_max, init_s32_min);
+
+	if (s32_min >=3D 0 =3D=3D s32_max >=3D 0) {
+		reg->s32_min_value =3D s32_min;
+		reg->s32_max_value =3D s32_max;
+		reg->u32_min_value =3D (u32)s32_min;
+		reg->u32_max_value =3D (u32)s32_max;
+		return;
+	}
+
+out:
+	set_sext32_default_val(reg, size);
+}
+
 static bool bpf_map_is_rdonly(const struct bpf_map *map)
 {
 	/* A map is considered read-only if the following condition are true:
@@ -13038,11 +13101,24 @@ static int check_alu_op(struct bpf_verifier_env=
 *env, struct bpf_insn *insn)
 	} else if (opcode =3D=3D BPF_MOV) {
=20
 		if (BPF_SRC(insn->code) =3D=3D BPF_X) {
-			if (insn->imm !=3D 0 || insn->off !=3D 0) {
+			if (insn->imm !=3D 0) {
 				verbose(env, "BPF_MOV uses reserved fields\n");
 				return -EINVAL;
 			}
=20
+			if (BPF_CLASS(insn->code) =3D=3D BPF_ALU) {
+				if (insn->off !=3D 0 && insn->off !=3D 8 && insn->off !=3D 16) {
+					verbose(env, "BPF_MOV uses reserved fields\n");
+					return -EINVAL;
+				}
+			} else {
+				if (insn->off !=3D 0 && insn->off !=3D 8 && insn->off !=3D 16 &&
+				    insn->off !=3D 32) {
+					verbose(env, "BPF_MOV uses reserved fields\n");
+					return -EINVAL;
+				}
+			}
+
 			/* check src operand */
 			err =3D check_reg_arg(env, insn->src_reg, SRC_OP);
 			if (err)
@@ -13066,18 +13142,33 @@ static int check_alu_op(struct bpf_verifier_env=
 *env, struct bpf_insn *insn)
 				       !tnum_is_const(src_reg->var_off);
=20
 			if (BPF_CLASS(insn->code) =3D=3D BPF_ALU64) {
-				/* case: R1 =3D R2
-				 * copy register state to dest reg
-				 */
-				if (need_id)
-					/* Assign src and dst registers the same ID
-					 * that will be used by find_equal_scalars()
-					 * to propagate min/max range.
+				if (insn->off =3D=3D 0) {
+					/* case: R1 =3D R2
+					 * copy register state to dest reg
 					 */
-					src_reg->id =3D ++env->id_gen;
-				copy_register_state(dst_reg, src_reg);
-				dst_reg->live |=3D REG_LIVE_WRITTEN;
-				dst_reg->subreg_def =3D DEF_NOT_SUBREG;
+					if (need_id)
+						/* Assign src and dst registers the same ID
+						 * that will be used by find_equal_scalars()
+						 * to propagate min/max range.
+						 */
+						src_reg->id =3D ++env->id_gen;
+					copy_register_state(dst_reg, src_reg);
+					dst_reg->live |=3D REG_LIVE_WRITTEN;
+					dst_reg->subreg_def =3D DEF_NOT_SUBREG;
+				} else {
+					/* case: R1 =3D (s8, s16 s32)R2 */
+					bool no_sext;
+
+					no_sext =3D src_reg->umax_value < (1ULL << (insn->off - 1));
+					if (no_sext && need_id)
+						src_reg->id =3D ++env->id_gen;
+					copy_register_state(dst_reg, src_reg);
+					if (!no_sext)
+						dst_reg->id =3D 0;
+					coerce_reg_to_size_sx(dst_reg, insn->off >> 3);
+					dst_reg->live |=3D REG_LIVE_WRITTEN;
+					dst_reg->subreg_def =3D DEF_NOT_SUBREG;
+				}
 			} else {
 				/* R1 =3D (u32) R2 */
 				if (is_pointer_value(env, insn->src_reg)) {
@@ -13086,19 +13177,33 @@ static int check_alu_op(struct bpf_verifier_env=
 *env, struct bpf_insn *insn)
 						insn->src_reg);
 					return -EACCES;
 				} else if (src_reg->type =3D=3D SCALAR_VALUE) {
-					bool is_src_reg_u32 =3D src_reg->umax_value <=3D U32_MAX;
-
-					if (is_src_reg_u32 && need_id)
-						src_reg->id =3D ++env->id_gen;
-					copy_register_state(dst_reg, src_reg);
-					/* Make sure ID is cleared if src_reg is not in u32 range otherwise
-					 * dst_reg min/max could be incorrectly
-					 * propagated into src_reg by find_equal_scalars()
-					 */
-					if (!is_src_reg_u32)
-						dst_reg->id =3D 0;
-					dst_reg->live |=3D REG_LIVE_WRITTEN;
-					dst_reg->subreg_def =3D env->insn_idx + 1;
+					if (insn->off =3D=3D 0) {
+						bool is_src_reg_u32 =3D src_reg->umax_value <=3D U32_MAX;
+
+						if (is_src_reg_u32 && need_id)
+							src_reg->id =3D ++env->id_gen;
+						copy_register_state(dst_reg, src_reg);
+						/* Make sure ID is cleared if src_reg is not in u32
+						 * range otherwise dst_reg min/max could be incorrectly
+						 * propagated into src_reg by find_equal_scalars()
+						 */
+						if (!is_src_reg_u32)
+							dst_reg->id =3D 0;
+						dst_reg->live |=3D REG_LIVE_WRITTEN;
+						dst_reg->subreg_def =3D env->insn_idx + 1;
+					} else {
+						/* case: W1 =3D (s8, s16)W2 */
+						bool no_sext =3D src_reg->umax_value < (1ULL << (insn->off - 1));
+
+						if (no_sext && need_id)
+							src_reg->id =3D ++env->id_gen;
+						copy_register_state(dst_reg, src_reg);
+						if (!no_sext)
+							dst_reg->id =3D 0;
+						dst_reg->live |=3D REG_LIVE_WRITTEN;
+						dst_reg->subreg_def =3D env->insn_idx + 1;
+						coerce_subreg_to_size_sx(dst_reg, insn->off >> 3);
+					}
 				} else {
 					mark_reg_unknown(env, regs,
 							 insn->dst_reg);
--=20
2.34.1


