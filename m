Return-Path: <bpf+bounces-40977-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BCEDD990AE6
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 20:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 237F1B23830
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 18:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1121A1DD888;
	Fri,  4 Oct 2024 18:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OV9djerU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870CB1DD881;
	Fri,  4 Oct 2024 18:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728065915; cv=none; b=KFvffh3WI79TlBPxrTDabJW6x5dQofC6DwwkLtbZs38UVofx20y8nCMznOEsbDBTOj6hi+PSt0UbAKvJrOW5DLtKkld8KKOrZbG9F0W+Y0nSa0cOV9QD8MwIQQx2hlAcJ1gSAaZDBeAnIpKc6wXgVIw/nlEZg8v2blWC41+iNYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728065915; c=relaxed/simple;
	bh=YPf2SJWOGd1pczgm/jYZndHAh5U+TU5yHTJG8jI746s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NLpKnS/DIqNFRMQuUhvNPiDLR7JbmdWxpqLX4HZHc0GcPQwxjOB/fhkoXuGw8lwpxD4T2od5XHZULaRK01fLYIHJHRZDQKcpvMDJ5xxXYHR8XCd9VzPNqBYp4SKFQ4rHoftnvBMqFlpC4jpQTsSvhgFq8P8geNqs/OE+fngV8sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OV9djerU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CDD3C4CECC;
	Fri,  4 Oct 2024 18:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728065915;
	bh=YPf2SJWOGd1pczgm/jYZndHAh5U+TU5yHTJG8jI746s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OV9djerUXDvZ8Qpm6Dx0DT7VyKE4sCgEB6MmoTeUJke2mP8YEP18171Y8YFJtwJ6o
	 nTPknqkwgIVRQgAMwGdslciNUGIKp/EuPZ9sPNunO5/MAqn/eRsjj6Hmdk726IC6d2
	 MVCWU89XhYuY1vJfhvDVZCMHuM3NglEWtu8qmm7Z9HCjUKoXLu10BubaLk8i7Fv4vv
	 UexrROhTpbCgjue5CIzH3Lx+g9YgLwqYi3aIc2nbOs8xTHf/3I/IbWfTuRetgYPxvv
	 HRecG0nrr0guo+/hcP4OrLAQKGhGd6Fc6+iJeSdnCAl93qF5Mawm+s+t3ct0aRa/8Q
	 K7BMTGmt61Xvg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yonghong Song <yonghong.song@linux.dev>,
	Zac Ecob <zacecob@protonmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	daniel@iogearbox.net,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 03/76] bpf: Fix a sdiv overflow issue
Date: Fri,  4 Oct 2024 14:16:20 -0400
Message-ID: <20241004181828.3669209-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004181828.3669209-1-sashal@kernel.org>
References: <20241004181828.3669209-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.2
Content-Transfer-Encoding: 8bit

From: Yonghong Song <yonghong.song@linux.dev>

[ Upstream commit 7dd34d7b7dcf9309fc6224caf4dd5b35bedddcb7 ]

Zac Ecob reported a problem where a bpf program may cause kernel crash due
to the following error:
  Oops: divide error: 0000 [#1] PREEMPT SMP KASAN PTI

The failure is due to the below signed divide:
  LLONG_MIN/-1 where LLONG_MIN equals to -9,223,372,036,854,775,808.
LLONG_MIN/-1 is supposed to give a positive number 9,223,372,036,854,775,808,
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
  - LLONG_MIN/-1 = LLONG_MIN
  - INT_MIN/-1 = INT_MIN
  - LLONG_MIN%-1 = 0
  - INT_MIN%-1 = 0
where -1 can be an immediate or in a register.

Insn patching is needed to handle the above cases and the patched codes
produced results aligned with above arm64 result. The below are pseudo
codes to handle sdiv/smod exceptions including both divisor -1 and divisor 0
and the divisor is stored in a register.

sdiv:
      tmp = rX
      tmp += 1 /* [-1, 0] -> [0, 1]
      if tmp >(unsigned) 1 goto L2
      if tmp == 0 goto L1
      rY = 0
  L1:
      rY = -rY;
      goto L3
  L2:
      rY /= rX
  L3:

smod:
      tmp = rX
      tmp += 1 /* [-1, 0] -> [0, 1]
      if tmp >(unsigned) 1 goto L1
      if tmp == 1 (is64 ? goto L2 : goto L3)
      rY = 0;
      goto L2
  L1:
      rY %= rX
  L2:
      goto L4  // only when !is64
  L3:
      wY = wY  // only when !is64
  L4:

  [1] https://lore.kernel.org/bpf/tPJLTEh7S_DxFEqAI2Ji5MBSoZVg7_G-Py2iaZpAaWtM961fFTWtsnlzwvTbzBzaUzwQAoNATXKUlt0LZOFgnDcIyKCswAnAGdUF3LBrhGQ=@protonmail.com/

Reported-by: Zac Ecob <zacecob@protonmail.com>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/r/20240913150326.1187788-1-yonghong.song@linux.dev
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c | 93 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 89 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d8520095ca030..f3e6b0c17a8b9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19911,13 +19911,46 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			/* Convert BPF_CLASS(insn->code) == BPF_ALU64 to 32-bit ALU */
 			insn->code = BPF_ALU | BPF_OP(insn->code) | BPF_SRC(insn->code);
 
-		/* Make divide-by-zero exceptions impossible. */
+		/* Make sdiv/smod divide-by-minus-one exceptions impossible. */
+		if ((insn->code == (BPF_ALU64 | BPF_MOD | BPF_K) ||
+		     insn->code == (BPF_ALU64 | BPF_DIV | BPF_K) ||
+		     insn->code == (BPF_ALU | BPF_MOD | BPF_K) ||
+		     insn->code == (BPF_ALU | BPF_DIV | BPF_K)) &&
+		    insn->off == 1 && insn->imm == -1) {
+			bool is64 = BPF_CLASS(insn->code) == BPF_ALU64;
+			bool isdiv = BPF_OP(insn->code) == BPF_DIV;
+			struct bpf_insn *patchlet;
+			struct bpf_insn chk_and_sdiv[] = {
+				BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_ALU) |
+					     BPF_NEG | BPF_K, insn->dst_reg,
+					     0, 0, 0),
+			};
+			struct bpf_insn chk_and_smod[] = {
+				BPF_MOV32_IMM(insn->dst_reg, 0),
+			};
+
+			patchlet = isdiv ? chk_and_sdiv : chk_and_smod;
+			cnt = isdiv ? ARRAY_SIZE(chk_and_sdiv) : ARRAY_SIZE(chk_and_smod);
+
+			new_prog = bpf_patch_insn_data(env, i + delta, patchlet, cnt);
+			if (!new_prog)
+				return -ENOMEM;
+
+			delta    += cnt - 1;
+			env->prog = prog = new_prog;
+			insn      = new_prog->insnsi + i + delta;
+			goto next_insn;
+		}
+
+		/* Make divide-by-zero and divide-by-minus-one exceptions impossible. */
 		if (insn->code == (BPF_ALU64 | BPF_MOD | BPF_X) ||
 		    insn->code == (BPF_ALU64 | BPF_DIV | BPF_X) ||
 		    insn->code == (BPF_ALU | BPF_MOD | BPF_X) ||
 		    insn->code == (BPF_ALU | BPF_DIV | BPF_X)) {
 			bool is64 = BPF_CLASS(insn->code) == BPF_ALU64;
 			bool isdiv = BPF_OP(insn->code) == BPF_DIV;
+			bool is_sdiv = isdiv && insn->off == 1;
+			bool is_smod = !isdiv && insn->off == 1;
 			struct bpf_insn *patchlet;
 			struct bpf_insn chk_and_div[] = {
 				/* [R,W]x div 0 -> 0 */
@@ -19937,10 +19970,62 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 				BPF_JMP_IMM(BPF_JA, 0, 0, 1),
 				BPF_MOV32_REG(insn->dst_reg, insn->dst_reg),
 			};
+			struct bpf_insn chk_and_sdiv[] = {
+				/* [R,W]x sdiv 0 -> 0
+				 * LLONG_MIN sdiv -1 -> LLONG_MIN
+				 * INT_MIN sdiv -1 -> INT_MIN
+				 */
+				BPF_MOV64_REG(BPF_REG_AX, insn->src_reg),
+				BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_ALU) |
+					     BPF_ADD | BPF_K, BPF_REG_AX,
+					     0, 0, 1),
+				BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32) |
+					     BPF_JGT | BPF_K, BPF_REG_AX,
+					     0, 4, 1),
+				BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32) |
+					     BPF_JEQ | BPF_K, BPF_REG_AX,
+					     0, 1, 0),
+				BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_ALU) |
+					     BPF_MOV | BPF_K, insn->dst_reg,
+					     0, 0, 0),
+				/* BPF_NEG(LLONG_MIN) == -LLONG_MIN == LLONG_MIN */
+				BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_ALU) |
+					     BPF_NEG | BPF_K, insn->dst_reg,
+					     0, 0, 0),
+				BPF_JMP_IMM(BPF_JA, 0, 0, 1),
+				*insn,
+			};
+			struct bpf_insn chk_and_smod[] = {
+				/* [R,W]x mod 0 -> [R,W]x */
+				/* [R,W]x mod -1 -> 0 */
+				BPF_MOV64_REG(BPF_REG_AX, insn->src_reg),
+				BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_ALU) |
+					     BPF_ADD | BPF_K, BPF_REG_AX,
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
 
-			patchlet = isdiv ? chk_and_div : chk_and_mod;
-			cnt = isdiv ? ARRAY_SIZE(chk_and_div) :
-				      ARRAY_SIZE(chk_and_mod) - (is64 ? 2 : 0);
+			if (is_sdiv) {
+				patchlet = chk_and_sdiv;
+				cnt = ARRAY_SIZE(chk_and_sdiv);
+			} else if (is_smod) {
+				patchlet = chk_and_smod;
+				cnt = ARRAY_SIZE(chk_and_smod) - (is64 ? 2 : 0);
+			} else {
+				patchlet = isdiv ? chk_and_div : chk_and_mod;
+				cnt = isdiv ? ARRAY_SIZE(chk_and_div) :
+					      ARRAY_SIZE(chk_and_mod) - (is64 ? 2 : 0);
+			}
 
 			new_prog = bpf_patch_insn_data(env, i + delta, patchlet, cnt);
 			if (!new_prog)
-- 
2.43.0


