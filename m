Return-Path: <bpf+bounces-40306-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B13AB985EC4
	for <lists+bpf@lfdr.de>; Wed, 25 Sep 2024 15:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65DE1B26470
	for <lists+bpf@lfdr.de>; Wed, 25 Sep 2024 13:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AAA20F480;
	Wed, 25 Sep 2024 12:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KfLE1/Bw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF14920F46F;
	Wed, 25 Sep 2024 12:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266158; cv=none; b=Ys6u+vbV7HFXrH/1MihItfqbeRNGUVttBm6Is+5i2ky3ZwjyeKyTd4l/UdpkX0qASQf2CJuR3Syp1hfzdQ3nVpkrCoxvD8IQ9nU2+Fuk/27hO7anv5RHSs4RRCpcYo1oghQ4DlbbBNgBoEvhFR83oQednaiXANa/7wvFzONuGgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266158; c=relaxed/simple;
	bh=loYJO/RaPJeM1OklIUynPjd7v+eKV64W9YBNv88pymA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V6Ff3FlV2kQOcJih8Z0Cm0d4AlBIkkMAl6L3UO1ceDsJhFMNvcfgA4vMIJT24EiIC35o+73SqTMRtjNUa9JphdRNGuXGPXDLjZemD/yqDbrF1YpLCVD13s3W4apYEvj2WvDnCwRErB6mm8VqDtGSLpi926pCjtAjDMBSonWEEDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KfLE1/Bw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51979C4CEC3;
	Wed, 25 Sep 2024 12:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266157;
	bh=loYJO/RaPJeM1OklIUynPjd7v+eKV64W9YBNv88pymA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KfLE1/BwaY2xWgO9LLerBJtkOcc178227vcXGZrhWmb967gS35wt3BCWR7yc/YgYb
	 DWV2E6lb/AxrNA4ZEG32adYc3jWrxEZJjHtaNfg8G7sl5poTa9TUfSKesr2u2S7iOE
	 WnMPpfciXEUl3AIg9wWV60sJL6uOLqP0U3UnLZv36P66Gf4aE5ZmkE8QgBkTBF76xB
	 D9uS4B7UqR/chXsF2ZfDFy0YUqUVH8vuYQroXQ1PKjBACbGYHpqV6uES1oZsIB8ekY
	 lnpdSW2+5X+x+sp/HJtGp/YcASzUgokACsLMGU8iI6dkyIXIbh0kZ3KXAF3bGkEs9R
	 5WzYVVdDwCwCA==
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
Subject: [PATCH AUTOSEL 6.10 197/197] bpf: Fix a sdiv overflow issue
Date: Wed, 25 Sep 2024 07:53:36 -0400
Message-ID: <20240925115823.1303019-197-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
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
index 2eff14da6bf16..c713ca32ab046 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19927,13 +19927,46 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
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
@@ -19953,10 +19986,62 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
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


