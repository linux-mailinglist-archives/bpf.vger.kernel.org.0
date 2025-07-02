Return-Path: <bpf+bounces-62163-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 009B1AF5F93
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 19:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E46607B4F42
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 17:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E91C2FF48C;
	Wed,  2 Jul 2025 17:11:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30482D3745
	for <bpf@vger.kernel.org>; Wed,  2 Jul 2025 17:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751476319; cv=none; b=kUjPwabECOjlG0icygzJmw+l9wsN6BG1tHj6jh6TqYGFc+A/Xj5/tzJHYwmQ0YTn7gIh6IRwpaChygOuIu+T07d28bZsDJg9FF7gSZ3WkI72m3aIb4fhYtlFb6ip9+jHKbA2Uz6LspGB52beyeTDi8/tVaiHKznA6T3bTSM/0lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751476319; c=relaxed/simple;
	bh=H+1+xxzhMfadT9WvPPXqhZjdxJlO4++apE2cx7auzOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z4MAtq02ngTn8LzguEkFPLe4Hh/Lz43Q8zn8VahhIORF8DkxbP7KjT7UXIfx6qsNQzpnIhS9yhA8NkntQscVMyFd0FGokDdjLJBZA8aM2DL4QApvau/acQoKSblG6OnoyPHfdPhaOWMJTIvjBi8sluTJ7M+go2KES28Oj3fRRpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 77C08ABB2E72; Wed,  2 Jul 2025 10:11:44 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Arnd Bergmann <arnd@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH bpf-next v2 2/3] bpf: Reduce stack frame size by using env->insn_buf for bpf insns
Date: Wed,  2 Jul 2025 10:11:44 -0700
Message-ID: <20250702171144.2370681-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250702171134.2370432-1-yonghong.song@linux.dev>
References: <20250702171134.2370432-1-yonghong.song@linux.dev>
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
Tested-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c | 189 ++++++++++++++++++++----------------------
 1 file changed, 91 insertions(+), 98 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8b0a25851089..ef53e313d841 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21010,7 +21010,9 @@ static int opt_remove_nops(struct bpf_verifier_en=
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
@@ -21188,13 +21190,12 @@ static int convert_ctx_accesses(struct bpf_veri=
fier_env *env)
=20
 		if (env->insn_aux_data[i + delta].nospec) {
 			WARN_ON_ONCE(env->insn_aux_data[i + delta].alu_state);
-			struct bpf_insn patch[] =3D {
-				BPF_ST_NOSPEC(),
-				*insn,
-			};
+			struct bpf_insn *patch =3D insn_buf;
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
@@ -21262,13 +21263,12 @@ static int convert_ctx_accesses(struct bpf_veri=
fier_env *env)
 			/* nospec_result is only used to mitigate Spectre v4 and
 			 * to limit verification-time for Spectre v1.
 			 */
-			struct bpf_insn patch[] =3D {
-				*insn,
-				BPF_ST_NOSPEC(),
-			};
+			struct bpf_insn *patch =3D insn_buf;
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
@@ -21938,13 +21938,12 @@ static int do_misc_fixups(struct bpf_verifier_e=
nv *env)
 	u16 stack_depth_extra =3D 0;
=20
 	if (env->seen_exception && !env->exception_callback_subprog) {
-		struct bpf_insn patch[] =3D {
-			env->prog->insnsi[insn_cnt - 1],
-			BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
-			BPF_EXIT_INSN(),
-		};
+		struct bpf_insn *patch =3D insn_buf;
=20
-		ret =3D add_hidden_subprog(env, patch, ARRAY_SIZE(patch));
+		*patch++ =3D env->prog->insnsi[insn_cnt - 1];
+		*patch++ =3D BPF_MOV64_REG(BPF_REG_0, BPF_REG_1);
+		*patch++ =3D BPF_EXIT_INSN();
+		ret =3D add_hidden_subprog(env, insn_buf, patch - insn_buf);
 		if (ret < 0)
 			return ret;
 		prog =3D env->prog;
@@ -21980,20 +21979,18 @@ static int do_misc_fixups(struct bpf_verifier_e=
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
+			struct bpf_insn *patch =3D insn_buf;
=20
-			patchlet =3D isdiv ? chk_and_sdiv : chk_and_smod;
-			cnt =3D isdiv ? ARRAY_SIZE(chk_and_sdiv) : ARRAY_SIZE(chk_and_smod);
+			if (isdiv)
+				*patch++ =3D BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_ALU) |
+							BPF_NEG | BPF_K, insn->dst_reg,
+							0, 0, 0);
+			else
+				*patch++ =3D BPF_MOV32_IMM(insn->dst_reg, 0);
+
+			cnt =3D patch - insn_buf;
=20
-			new_prog =3D bpf_patch_insn_data(env, i + delta, patchlet, cnt);
+			new_prog =3D bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
 			if (!new_prog)
 				return -ENOMEM;
=20
@@ -22012,83 +22009,79 @@ static int do_misc_fixups(struct bpf_verifier_e=
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
+			struct bpf_insn *patch =3D insn_buf;
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
+
+				if (!is64) {
+					*patch++ =3D BPF_JMP_IMM(BPF_JA, 0, 0, 1);
+					*patch++ =3D BPF_MOV32_REG(insn->dst_reg, insn->dst_reg);
+				}
+				cnt =3D patch - insn_buf;
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
+
+				if (!is64) {
+					*patch++ =3D BPF_JMP_IMM(BPF_JA, 0, 0, 1);
+					*patch++ =3D BPF_MOV32_REG(insn->dst_reg, insn->dst_reg);
+				}
+				cnt =3D patch - insn_buf;
 			}
=20
-			new_prog =3D bpf_patch_insn_data(env, i + delta, patchlet, cnt);
+			new_prog =3D bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
 			if (!new_prog)
 				return -ENOMEM;
=20
--=20
2.47.1


