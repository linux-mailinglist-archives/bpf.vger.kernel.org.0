Return-Path: <bpf+bounces-39837-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBCC97833B
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 17:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52B98B239FC
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 15:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D5C28366;
	Fri, 13 Sep 2024 15:03:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C3FDDBC
	for <bpf@vger.kernel.org>; Fri, 13 Sep 2024 15:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726239825; cv=none; b=cL9zDTT9PQBJYaH/HQdCaEfNiQ0xz2yZNAnUs1Ex7rRk6AmHYhXCzOTFKWDTg4iII3x8UR7xKTl5eG7JQFH+lewNyC2Nkiyij/2F+PvkceLkxtVgKku7M2k/qyn1M1bbVNtbT0wz0KFct0rEb9JOnKeVpEZdj0BkEex5a4cHsGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726239825; c=relaxed/simple;
	bh=2ZSjwee8J1/0FsGm/v/21JKNq5ZOQlbm6n8DppafOiw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=od/hYiwf42yLomm+FdVrWDvasybUHOb20HSyFQLWMrV8uhr+kY+1O0k4/J3HQ2sfpRf/SAhNaEYxlDIcFeVWD5pke+Ck2WbWK5inSRtFhzc5gzmlfYOUmv2gGZoWKA8wnKv0DmToFCV+PBI6Uug4BUzbAvnaporQSTyvTJT4DM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 049C68EB8AA7; Fri, 13 Sep 2024 08:03:26 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Zac Ecob <zacecob@protonmail.com>
Subject: [PATCH bpf-next v3 1/2] bpf: Fix a sdiv overflow issue
Date: Fri, 13 Sep 2024 08:03:26 -0700
Message-ID: <20240913150326.1187788-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Zac Ecob reported a problem where a bpf program may cause kernel crash du=
e
to the following error:
  Oops: divide error: 0000 [#1] PREEMPT SMP KASAN PTI

The failure is due to the below signed divide:
  LLONG_MIN/-1 where LLONG_MIN equals to -9,223,372,036,854,775,808.
LLONG_MIN/-1 is supposed to give a positive number 9,223,372,036,854,775,=
808,
but it is impossible since for 64-bit system, the maximum positive
number is 9,223,372,036,854,775,807. On x86_64, LLONG_MIN/-1 will
cause a kernel exception. On arm64, the result for LLONG_MIN/-1 is
LLONG_MIN.

Further investigation found all the following sdiv/smod cases may trigger
an exception when bpf program is running on x86_64 platform:
  - LLONG_MIN/-1 for 64bit operation
  - INT_MIN/-1 for 32bit operation
  - LLONG_MIN%-1 for 64bit operation
  - INT_MIN%-1 for 32bit operation
where -1 can be an immediate or in a register.

On arm64, there are no exceptions:
  - LLONG_MIN/-1 =3D LLONG_MIN
  - INT_MIN/-1 =3D INT_MIN
  - LLONG_MIN%-1 =3D 0
  - INT_MIN%-1 =3D 0
where -1 can be an immediate or in a register.

Insn patching is needed to handle the above cases and the patched codes
produced results aligned with above arm64 result. The below are pseudo
codes to handle sdiv/smod exceptions including both divisor -1 and diviso=
r 0
and the divisor is stored in a register.

sdiv:
      tmp =3D rX
      tmp +=3D 1 /* [-1, 0] -> [0, 1]
      if tmp >(unsigned) 1 goto L2
      if tmp =3D=3D 0 goto L1
      rY =3D 0
  L1:
      rY =3D -rY;
      goto L3
  L2:
      rY /=3D rX
  L3:

smod:
      tmp =3D rX
      tmp +=3D 1 /* [-1, 0] -> [0, 1]
      if tmp >(unsigned) 1 goto L1
      if tmp =3D=3D 1 (is64 ? goto L2 : goto L3)
      rY =3D 0;
      goto L2
  L1:
      rY %=3D rX
  L2:
      goto L4  // only when !is64
  L3:
      wY =3D wY  // only when !is64
  L4:

  [1] https://lore.kernel.org/bpf/tPJLTEh7S_DxFEqAI2Ji5MBSoZVg7_G-Py2iaZp=
AaWtM961fFTWtsnlzwvTbzBzaUzwQAoNATXKUlt0LZOFgnDcIyKCswAnAGdUF3LBrhGQ=3D@p=
rotonmail.com/

Reported-by: Zac Ecob <zacecob@protonmail.com>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c | 93 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 89 insertions(+), 4 deletions(-)

Changelogs:
  v2 -> v3:
    - Change sdiv/smod (r/r, r%r) patched insn to be more efficient
      for default case.
  v1 -> v2:
    - Handle more crash cases like 32bit operation and modules.
    - Add more tests to test new cases.

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f35b80c16cda..69b8d91f5136 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20499,13 +20499,46 @@ static int do_misc_fixups(struct bpf_verifier_e=
nv *env)
 			/* Convert BPF_CLASS(insn->code) =3D=3D BPF_ALU64 to 32-bit ALU */
 			insn->code =3D BPF_ALU | BPF_OP(insn->code) | BPF_SRC(insn->code);
=20
-		/* Make divide-by-zero exceptions impossible. */
+		/* Make sdiv/smod divide-by-minus-one exceptions impossible. */
+		if ((insn->code =3D=3D (BPF_ALU64 | BPF_MOD | BPF_K) ||
+		     insn->code =3D=3D (BPF_ALU64 | BPF_DIV | BPF_K) ||
+		     insn->code =3D=3D (BPF_ALU | BPF_MOD | BPF_K) ||
+		     insn->code =3D=3D (BPF_ALU | BPF_DIV | BPF_K)) &&
+		    insn->off =3D=3D 1 && insn->imm =3D=3D -1) {
+			bool is64 =3D BPF_CLASS(insn->code) =3D=3D BPF_ALU64;
+			bool isdiv =3D BPF_OP(insn->code) =3D=3D BPF_DIV;
+			struct bpf_insn *patchlet;
+			struct bpf_insn chk_and_sdiv[] =3D {
+				BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_ALU) |
+					     BPF_OP(BPF_NEG) | BPF_K, insn->dst_reg,
+					     0, 0, 0),
+			};
+			struct bpf_insn chk_and_smod[] =3D {
+				BPF_MOV32_IMM(insn->dst_reg, 0),
+			};
+
+			patchlet =3D isdiv ? chk_and_sdiv : chk_and_smod;
+			cnt =3D isdiv ? ARRAY_SIZE(chk_and_sdiv) : ARRAY_SIZE(chk_and_smod);
+
+			new_prog =3D bpf_patch_insn_data(env, i + delta, patchlet, cnt);
+			if (!new_prog)
+				return -ENOMEM;
+
+			delta    +=3D cnt - 1;
+			env->prog =3D prog =3D new_prog;
+			insn      =3D new_prog->insnsi + i + delta;
+			goto next_insn;
+		}
+
+		/* Make divide-by-zero and divide-by-minus-one exceptions impossible. =
*/
 		if (insn->code =3D=3D (BPF_ALU64 | BPF_MOD | BPF_X) ||
 		    insn->code =3D=3D (BPF_ALU64 | BPF_DIV | BPF_X) ||
 		    insn->code =3D=3D (BPF_ALU | BPF_MOD | BPF_X) ||
 		    insn->code =3D=3D (BPF_ALU | BPF_DIV | BPF_X)) {
 			bool is64 =3D BPF_CLASS(insn->code) =3D=3D BPF_ALU64;
 			bool isdiv =3D BPF_OP(insn->code) =3D=3D BPF_DIV;
+			bool is_sdiv =3D isdiv && insn->off =3D=3D 1;
+			bool is_smod =3D !isdiv && insn->off =3D=3D 1;
 			struct bpf_insn *patchlet;
 			struct bpf_insn chk_and_div[] =3D {
 				/* [R,W]x div 0 -> 0 */
@@ -20525,10 +20558,62 @@ static int do_misc_fixups(struct bpf_verifier_e=
nv *env)
 				BPF_JMP_IMM(BPF_JA, 0, 0, 1),
 				BPF_MOV32_REG(insn->dst_reg, insn->dst_reg),
 			};
+			struct bpf_insn chk_and_sdiv[] =3D {
+				/* [R,W]x sdiv 0 -> 0
+				 * LLONG_MIN sdiv -1 -> LLONG_MIN
+				 * INT_MIN sdiv -1 -> INT_MIN
+				 */
+				BPF_MOV64_REG(BPF_REG_AX, insn->src_reg),
+				BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_ALU) |
+					     BPF_OP(BPF_ADD) | BPF_K, BPF_REG_AX,
+					     0, 0, 1),
+				BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32) |
+					     BPF_JGT | BPF_K, BPF_REG_AX,
+					     0, 4, 1),
+				BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32) |
+					     BPF_JEQ | BPF_K, BPF_REG_AX,
+					     0, 1, 0),
+				BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_ALU) |
+					     BPF_OP(BPF_MOV) | BPF_K, insn->dst_reg,
+					     0, 0, 0),
+				/* BPF_NEG(LLONG_MIN) =3D=3D -LLONG_MIN =3D=3D LLONG_MIN */
+				BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_ALU) |
+					     BPF_OP(BPF_NEG) | BPF_K, insn->dst_reg,
+					     0, 0, 0),
+				BPF_JMP_IMM(BPF_JA, 0, 0, 1),
+				*insn,
+			};
+			struct bpf_insn chk_and_smod[] =3D {
+				/* [R,W]x mod 0 -> [R,W]x */
+				/* [R,W]x mod -1 -> 0 */
+				BPF_MOV64_REG(BPF_REG_AX, insn->src_reg),
+				BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_ALU) |
+					     BPF_OP(BPF_ADD) | BPF_K, BPF_REG_AX,
+					     0, 0, 1),
+				BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32) |
+					     BPF_JGT | BPF_K, BPF_REG_AX,
+					     0, 3, 1),
+				BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32) |
+					     BPF_JEQ | BPF_K, BPF_REG_AX,
+					     0, 3 + (is64 ? 0 : 1), 1),
+				BPF_MOV32_IMM(insn->dst_reg, 0),
+				BPF_JMP_IMM(BPF_JA, 0, 0, 1),
+				*insn,
+				BPF_JMP_IMM(BPF_JA, 0, 0, 1),
+				BPF_MOV32_REG(insn->dst_reg, insn->dst_reg),
+			};
=20
-			patchlet =3D isdiv ? chk_and_div : chk_and_mod;
-			cnt =3D isdiv ? ARRAY_SIZE(chk_and_div) :
-				      ARRAY_SIZE(chk_and_mod) - (is64 ? 2 : 0);
+			if (is_sdiv) {
+				patchlet =3D chk_and_sdiv;
+				cnt =3D ARRAY_SIZE(chk_and_sdiv);
+			} else if (is_smod) {
+				patchlet =3D chk_and_smod;
+				cnt =3D ARRAY_SIZE(chk_and_smod) - (is64 ? 2 : 0);
+			} else {
+				patchlet =3D isdiv ? chk_and_div : chk_and_mod;
+				cnt =3D isdiv ? ARRAY_SIZE(chk_and_div) :
+					      ARRAY_SIZE(chk_and_mod) - (is64 ? 2 : 0);
+			}
=20
 			new_prog =3D bpf_patch_insn_data(env, i + delta, patchlet, cnt);
 			if (!new_prog)
--=20
2.43.5


