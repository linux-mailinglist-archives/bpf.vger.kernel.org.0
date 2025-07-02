Return-Path: <bpf+bounces-62068-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F65CAF0AC1
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 07:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D036D7A29D0
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 05:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C517C1F4622;
	Wed,  2 Jul 2025 05:33:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E9360B8A
	for <bpf@vger.kernel.org>; Wed,  2 Jul 2025 05:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751434427; cv=none; b=g9KjbJYl7OZZglZtqI4bl06nx0gpvxjnKApR/SgrT0UWwCHs+QkAVQZ82YspRnnT8LkiBXp5je/ogvkUQxcnXYnOUn6nPtddNpaOGPjPpkF9bwWut8W9XqoMPYxjUAJ2R5ymYo7ZCby8qtGvImI8Um5G7uLxf9gD+HRiAHCRuvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751434427; c=relaxed/simple;
	bh=DfuQmhcAQu3yoA+1QEI6G+Y81rNa1TXntP+QpmHpwC8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HAz44mAbcfGUIkRleHkwlmxN66htMKBrXlsNeOUzk+fcJIOOF8Pr5Mfefhr/q5DyYRBy4zR80nohdEyqtyHDYiHrti4p22rWGcl1cdWA7JmGC5o4VJXGDhVWQ+PugnA2SPFbH8xGug2aP81BwRJz3Cw6ZO3wqwaFsPPLdnbADq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 205E0AB32034; Tue,  1 Jul 2025 22:33:32 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Arnd Bergmann <arnd@kernel.org>
Subject: [PATCH bpf-next 1/2] bpf: Reduce stack frame size by using env->insn_buf for bpf insns
Date: Tue,  1 Jul 2025 22:33:32 -0700
Message-ID: <20250702053332.1991516-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Arnd Bergmann reported an issue ([1]) where clang compiler (less than
llvm18) may trigger an error where the stack frame size exceeds the limit=
.
I can reproduce the error like below:
  kernel/bpf/verifier.c:24491:5: error: stack frame size (2552) exceeds l=
imit (1280) in 'bpf_check'
      [-Werror,-Wframe-larger-than]
  kernel/bpf/verifier.c:19921:12: error: stack frame size (1368) exceeds =
limit (1280) in 'do_check'
      [-Werror,-Wframe-larger-than]

Use env->insn_buf for bpf insns instead of putting these insns on the
stack. This can resolve the above 'bpf_check' error. The 'do_check' error
will be resolved in the next patch.

  [1] https://lore.kernel.org/bpf/20250620113846.3950478-1-arnd@kernel.or=
g/

Reported-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c | 194 ++++++++++++++++++++----------------------
 1 file changed, 91 insertions(+), 103 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 90e688f81a48..29faef51065d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20939,26 +20939,27 @@ static bool insn_is_cond_jump(u8 code)
 static void opt_hard_wire_dead_code_branches(struct bpf_verifier_env *en=
v)
 {
 	struct bpf_insn_aux_data *aux_data =3D env->insn_aux_data;
-	struct bpf_insn ja =3D BPF_JMP_IMM(BPF_JA, 0, 0, 0);
+	struct bpf_insn *ja =3D env->insn_buf;
 	struct bpf_insn *insn =3D env->prog->insnsi;
 	const int insn_cnt =3D env->prog->len;
 	int i;
=20
+	*ja =3D BPF_JMP_IMM(BPF_JA, 0, 0, 0);
 	for (i =3D 0; i < insn_cnt; i++, insn++) {
 		if (!insn_is_cond_jump(insn->code))
 			continue;
=20
 		if (!aux_data[i + 1].seen)
-			ja.off =3D insn->off;
+			ja->off =3D insn->off;
 		else if (!aux_data[i + 1 + insn->off].seen)
-			ja.off =3D 0;
+			ja->off =3D 0;
 		else
 			continue;
=20
 		if (bpf_prog_is_offloaded(env->prog->aux))
-			bpf_prog_offload_replace_insn(env, i, &ja);
+			bpf_prog_offload_replace_insn(env, i, ja);
=20
-		memcpy(insn, &ja, sizeof(ja));
+		memcpy(insn, ja, sizeof(*ja));
 	}
 }
=20
@@ -21017,7 +21018,9 @@ static int opt_remove_nops(struct bpf_verifier_en=
v *env)
 static int opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
 					 const union bpf_attr *attr)
 {
-	struct bpf_insn *patch, zext_patch[2], rnd_hi32_patch[4];
+	struct bpf_insn *patch;
+	struct bpf_insn *zext_patch =3D env->insn_buf;
+	struct bpf_insn *rnd_hi32_patch =3D &env->insn_buf[2];
 	struct bpf_insn_aux_data *aux =3D env->insn_aux_data;
 	int i, patch_len, delta =3D 0, len =3D env->prog->len;
 	struct bpf_insn *insns =3D env->prog->insnsi;
@@ -21195,13 +21198,12 @@ static int convert_ctx_accesses(struct bpf_veri=
fier_env *env)
=20
 		if (env->insn_aux_data[i + delta].nospec) {
 			WARN_ON_ONCE(env->insn_aux_data[i + delta].alu_state);
-			struct bpf_insn patch[] =3D {
-				BPF_ST_NOSPEC(),
-				*insn,
-			};
+			struct bpf_insn *patch =3D &insn_buf[0];
=20
-			cnt =3D ARRAY_SIZE(patch);
-			new_prog =3D bpf_patch_insn_data(env, i + delta, patch, cnt);
+			*patch++ =3D BPF_ST_NOSPEC();
+			*patch++ =3D *insn;
+			cnt =3D patch - insn_buf;
+			new_prog =3D bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
 			if (!new_prog)
 				return -ENOMEM;
=20
@@ -21269,13 +21271,12 @@ static int convert_ctx_accesses(struct bpf_veri=
fier_env *env)
 			/* nospec_result is only used to mitigate Spectre v4 and
 			 * to limit verification-time for Spectre v1.
 			 */
-			struct bpf_insn patch[] =3D {
-				*insn,
-				BPF_ST_NOSPEC(),
-			};
+			struct bpf_insn *patch =3D &insn_buf[0];
=20
-			cnt =3D ARRAY_SIZE(patch);
-			new_prog =3D bpf_patch_insn_data(env, i + delta, patch, cnt);
+			*patch++ =3D *insn;
+			*patch++ =3D BPF_ST_NOSPEC();
+			cnt =3D patch - insn_buf;
+			new_prog =3D bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
 			if (!new_prog)
 				return -ENOMEM;
=20
@@ -21945,13 +21946,12 @@ static int do_misc_fixups(struct bpf_verifier_e=
nv *env)
 	u16 stack_depth_extra =3D 0;
=20
 	if (env->seen_exception && !env->exception_callback_subprog) {
-		struct bpf_insn patch[] =3D {
-			env->prog->insnsi[insn_cnt - 1],
-			BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
-			BPF_EXIT_INSN(),
-		};
+		struct bpf_insn *patch =3D &insn_buf[0];
=20
-		ret =3D add_hidden_subprog(env, patch, ARRAY_SIZE(patch));
+		*patch++ =3D env->prog->insnsi[insn_cnt - 1];
+		*patch++ =3D BPF_MOV64_REG(BPF_REG_0, BPF_REG_1);
+		*patch++ =3D BPF_EXIT_INSN();
+		ret =3D add_hidden_subprog(env, insn_buf, patch - insn_buf);
 		if (ret < 0)
 			return ret;
 		prog =3D env->prog;
@@ -21987,20 +21987,18 @@ static int do_misc_fixups(struct bpf_verifier_e=
nv *env)
 		    insn->off =3D=3D 1 && insn->imm =3D=3D -1) {
 			bool is64 =3D BPF_CLASS(insn->code) =3D=3D BPF_ALU64;
 			bool isdiv =3D BPF_OP(insn->code) =3D=3D BPF_DIV;
-			struct bpf_insn *patchlet;
-			struct bpf_insn chk_and_sdiv[] =3D {
-				BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_ALU) |
-					     BPF_NEG | BPF_K, insn->dst_reg,
-					     0, 0, 0),
-			};
-			struct bpf_insn chk_and_smod[] =3D {
-				BPF_MOV32_IMM(insn->dst_reg, 0),
-			};
+			struct bpf_insn *patch =3D &insn_buf[0];
+
+			if (isdiv)
+				*patch++ =3D BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_ALU) |
+							BPF_NEG | BPF_K, insn->dst_reg,
+							0, 0, 0);
+			else
+				*patch++ =3D BPF_MOV32_IMM(insn->dst_reg, 0);
=20
-			patchlet =3D isdiv ? chk_and_sdiv : chk_and_smod;
-			cnt =3D isdiv ? ARRAY_SIZE(chk_and_sdiv) : ARRAY_SIZE(chk_and_smod);
+			cnt =3D patch - insn_buf;
=20
-			new_prog =3D bpf_patch_insn_data(env, i + delta, patchlet, cnt);
+			new_prog =3D bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
 			if (!new_prog)
 				return -ENOMEM;
=20
@@ -22019,83 +22017,73 @@ static int do_misc_fixups(struct bpf_verifier_e=
nv *env)
 			bool isdiv =3D BPF_OP(insn->code) =3D=3D BPF_DIV;
 			bool is_sdiv =3D isdiv && insn->off =3D=3D 1;
 			bool is_smod =3D !isdiv && insn->off =3D=3D 1;
-			struct bpf_insn *patchlet;
-			struct bpf_insn chk_and_div[] =3D {
-				/* [R,W]x div 0 -> 0 */
-				BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32) |
-					     BPF_JNE | BPF_K, insn->src_reg,
-					     0, 2, 0),
-				BPF_ALU32_REG(BPF_XOR, insn->dst_reg, insn->dst_reg),
-				BPF_JMP_IMM(BPF_JA, 0, 0, 1),
-				*insn,
-			};
-			struct bpf_insn chk_and_mod[] =3D {
-				/* [R,W]x mod 0 -> [R,W]x */
-				BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32) |
-					     BPF_JEQ | BPF_K, insn->src_reg,
-					     0, 1 + (is64 ? 0 : 1), 0),
-				*insn,
-				BPF_JMP_IMM(BPF_JA, 0, 0, 1),
-				BPF_MOV32_REG(insn->dst_reg, insn->dst_reg),
-			};
-			struct bpf_insn chk_and_sdiv[] =3D {
+			struct bpf_insn *patch =3D &insn_buf[0];
+
+			if (is_sdiv) {
 				/* [R,W]x sdiv 0 -> 0
 				 * LLONG_MIN sdiv -1 -> LLONG_MIN
 				 * INT_MIN sdiv -1 -> INT_MIN
 				 */
-				BPF_MOV64_REG(BPF_REG_AX, insn->src_reg),
-				BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_ALU) |
-					     BPF_ADD | BPF_K, BPF_REG_AX,
-					     0, 0, 1),
-				BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32) |
-					     BPF_JGT | BPF_K, BPF_REG_AX,
-					     0, 4, 1),
-				BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32) |
-					     BPF_JEQ | BPF_K, BPF_REG_AX,
-					     0, 1, 0),
-				BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_ALU) |
-					     BPF_MOV | BPF_K, insn->dst_reg,
-					     0, 0, 0),
+				*patch++ =3D BPF_MOV64_REG(BPF_REG_AX, insn->src_reg);
+				*patch++ =3D BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_ALU) |
+							BPF_ADD | BPF_K, BPF_REG_AX,
+							0, 0, 1);
+				*patch++ =3D BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32) |
+							BPF_JGT | BPF_K, BPF_REG_AX,
+							0, 4, 1);
+				*patch++ =3D BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32) |
+							BPF_JEQ | BPF_K, BPF_REG_AX,
+							0, 1, 0);
+				*patch++ =3D BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_ALU) |
+							BPF_MOV | BPF_K, insn->dst_reg,
+							0, 0, 0);
 				/* BPF_NEG(LLONG_MIN) =3D=3D -LLONG_MIN =3D=3D LLONG_MIN */
-				BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_ALU) |
-					     BPF_NEG | BPF_K, insn->dst_reg,
-					     0, 0, 0),
-				BPF_JMP_IMM(BPF_JA, 0, 0, 1),
-				*insn,
-			};
-			struct bpf_insn chk_and_smod[] =3D {
+				*patch++ =3D BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_ALU) |
+							BPF_NEG | BPF_K, insn->dst_reg,
+							0, 0, 0);
+				*patch++ =3D BPF_JMP_IMM(BPF_JA, 0, 0, 1);
+				*patch++ =3D *insn;
+				cnt =3D patch - insn_buf;
+			} else if (is_smod) {
 				/* [R,W]x mod 0 -> [R,W]x */
 				/* [R,W]x mod -1 -> 0 */
-				BPF_MOV64_REG(BPF_REG_AX, insn->src_reg),
-				BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_ALU) |
-					     BPF_ADD | BPF_K, BPF_REG_AX,
-					     0, 0, 1),
-				BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32) |
-					     BPF_JGT | BPF_K, BPF_REG_AX,
-					     0, 3, 1),
-				BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32) |
-					     BPF_JEQ | BPF_K, BPF_REG_AX,
-					     0, 3 + (is64 ? 0 : 1), 1),
-				BPF_MOV32_IMM(insn->dst_reg, 0),
-				BPF_JMP_IMM(BPF_JA, 0, 0, 1),
-				*insn,
-				BPF_JMP_IMM(BPF_JA, 0, 0, 1),
-				BPF_MOV32_REG(insn->dst_reg, insn->dst_reg),
-			};
-
-			if (is_sdiv) {
-				patchlet =3D chk_and_sdiv;
-				cnt =3D ARRAY_SIZE(chk_and_sdiv);
-			} else if (is_smod) {
-				patchlet =3D chk_and_smod;
-				cnt =3D ARRAY_SIZE(chk_and_smod) - (is64 ? 2 : 0);
+				*patch++ =3D BPF_MOV64_REG(BPF_REG_AX, insn->src_reg);
+				*patch++ =3D BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_ALU) |
+							BPF_ADD | BPF_K, BPF_REG_AX,
+							0, 0, 1);
+				*patch++ =3D BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32) |
+							BPF_JGT | BPF_K, BPF_REG_AX,
+							0, 3, 1);
+				*patch++ =3D BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32) |
+							BPF_JEQ | BPF_K, BPF_REG_AX,
+							0, 3 + (is64 ? 0 : 1), 1);
+				*patch++ =3D BPF_MOV32_IMM(insn->dst_reg, 0);
+				*patch++ =3D BPF_JMP_IMM(BPF_JA, 0, 0, 1);
+				*patch++ =3D *insn;
+				*patch++ =3D BPF_JMP_IMM(BPF_JA, 0, 0, 1);
+				*patch++ =3D BPF_MOV32_REG(insn->dst_reg, insn->dst_reg);
+				cnt =3D (patch - insn_buf) - (is64 ? 2 : 0);
+			} else if (isdiv) {
+				/* [R,W]x div 0 -> 0 */
+				*patch++ =3D BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32) |
+							BPF_JNE | BPF_K, insn->src_reg,
+							0, 2, 0);
+				*patch++ =3D BPF_ALU32_REG(BPF_XOR, insn->dst_reg, insn->dst_reg);
+				*patch++ =3D BPF_JMP_IMM(BPF_JA, 0, 0, 1);
+				*patch++ =3D *insn;
+				cnt =3D patch - insn_buf;
 			} else {
-				patchlet =3D isdiv ? chk_and_div : chk_and_mod;
-				cnt =3D isdiv ? ARRAY_SIZE(chk_and_div) :
-					      ARRAY_SIZE(chk_and_mod) - (is64 ? 2 : 0);
+				/* [R,W]x mod 0 -> [R,W]x */
+				*patch++ =3D BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32) |
+							BPF_JEQ | BPF_K, insn->src_reg,
+							0, 1 + (is64 ? 0 : 1), 0);
+				*patch++ =3D *insn;
+				*patch++ =3D BPF_JMP_IMM(BPF_JA, 0, 0, 1);
+				*patch++ =3D BPF_MOV32_REG(insn->dst_reg, insn->dst_reg);
+				cnt =3D (patch - insn_buf) - (is64 ? 2 : 0);
 			}
=20
-			new_prog =3D bpf_patch_insn_data(env, i + delta, patchlet, cnt);
+			new_prog =3D bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
 			if (!new_prog)
 				return -ENOMEM;
=20
--=20
2.47.1


