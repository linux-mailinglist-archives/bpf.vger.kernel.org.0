Return-Path: <bpf+bounces-11362-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3317B7EB5
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 14:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id E09C4281CF2
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 12:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBCD13AE9;
	Wed,  4 Oct 2023 12:07:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104E8134C2;
	Wed,  4 Oct 2023 12:07:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29373C433CB;
	Wed,  4 Oct 2023 12:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696421241;
	bh=FcFliYtfyClr234Bg/rnUbyn6yhoW+Ofj/60M8uTrGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OLUaEbOvU1kBTFb7wZoed/Rv0qLtoGKvSyOsVygiWjcfUAlkint7h1M+DWCNXvjwe
	 NrOjlZcCRicZLfg2m2aFCTHDLXOb1HZmzUloc6WzK2rByf6Y7AXPNgSI6s+hdkR8Uo
	 jK7yKdsGC9NY3PefxgD4iW5Sjdx3HNymiCYr/WU+GEjSkIdjVGakdiM7J+aM41wb+B
	 A0yVL2c+P/TIxuXVK7RkpFjgT68TWPekSQM8B6fRS6RdmxBrAC/kQh3IU01ufgAMTq
	 lPgpZzVbkka4E+2Q3OiyhlmxKCOcuk9ogp2Qm6QHS5D+vHqv8io7C8PWt7WwySB7ZC
	 f1SMAfjxoZ2Dg==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Pu Lehui <pulehui@huawei.com>
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	linux-kernel@vger.kernel.org,
	Luke Nelson <luke.r.nels@gmail.com>,
	Xi Wang <xi.wang@gmail.com>,
	linux-riscv@lists.infradead.org
Subject: [PATCH bpf 1/2] riscv, bpf: Sign-extend return values
Date: Wed,  4 Oct 2023 14:07:05 +0200
Message-Id: <20231004120706.52848-2-bjorn@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231004120706.52848-1-bjorn@kernel.org>
References: <20231004120706.52848-1-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Björn Töpel <bjorn@rivosinc.com>

The RISC-V architecture does not expose sub-registers, and hold all
32-bit values in a sign-extended format [1] [2]:

  | The compiler and calling convention maintain an invariant that all
  | 32-bit values are held in a sign-extended format in 64-bit
  | registers. Even 32-bit unsigned integers extend bit 31 into bits
  | 63 through 32. Consequently, conversion between unsigned and
  | signed 32-bit integers is a no-op, as is conversion from a signed
  | 32-bit integer to a signed 64-bit integer.

While BPF, on the other hand, exposes sub-registers, and use
zero-extension (similar to arm64/x86).

This has led to some subtle bugs, where a BPF JITted program has not
sign-extended the a0 register (return value in RISC-V land), passed
the return value up the kernel, e.g.:

  | int from_bpf(void);
  |
  | long foo(void)
  | {
  |    return from_bpf();
  | }

Here, a0 would be 0xffff_ffff, instead of the expected
0xffff_ffff_ffff_ffff.

Internally, the RISC-V JIT uses a5 as a dedicated register for BPF
return values.

Keep a5 zero-extended, but explicitly sign-extend a0 (which is used
outside BPF land). Now that a0 (RISC-V ABI) and a5 (BPF ABI) differs,
a0 is only moved to a5 for non-BPF native calls (BPF_PSEUDO_CALL).

Link: https://github.com/riscv/riscv-isa-manual/releases/download/riscv-isa-release-056b6ff-2023-10-02/unpriv-isa-asciidoc.pdf # [2]
Link: https://github.com/riscv-non-isa/riscv-elf-psabi-doc/releases/download/draft-20230929-e5c800e661a53efe3c2678d71a306323b60eb13b/riscv-abi.pdf # [2]
Fixes: 2353ecc6f91f ("bpf, riscv: add BPF JIT for RV64G")
Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 arch/riscv/net/bpf_jit_comp64.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index ecd3ae6f4116..de4c9957d223 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -245,7 +245,7 @@ static void __build_epilogue(bool is_tail_call, struct rv_jit_context *ctx)
 	emit_addi(RV_REG_SP, RV_REG_SP, stack_adjust, ctx);
 	/* Set return value. */
 	if (!is_tail_call)
-		emit_mv(RV_REG_A0, RV_REG_A5, ctx);
+		emit_addiw(RV_REG_A0, RV_REG_A5, 0, ctx);
 	emit_jalr(RV_REG_ZERO, is_tail_call ? RV_REG_T3 : RV_REG_RA,
 		  is_tail_call ? (RV_FENTRY_NINSNS + 1) * 4 : 0, /* skip reserved nops and TCC init */
 		  ctx);
@@ -1515,7 +1515,8 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		if (ret)
 			return ret;
 
-		emit_mv(bpf_to_rv_reg(BPF_REG_0, ctx), RV_REG_A0, ctx);
+		if (insn->src_reg != BPF_PSEUDO_CALL)
+			emit_mv(bpf_to_rv_reg(BPF_REG_0, ctx), RV_REG_A0, ctx);
 		break;
 	}
 	/* tail call */
-- 
2.39.2


