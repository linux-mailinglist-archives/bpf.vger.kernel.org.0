Return-Path: <bpf+bounces-69380-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94184B958D6
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 13:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C215C19C1DA9
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 11:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E0A32145B;
	Tue, 23 Sep 2025 11:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UNX+yDIl"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3DD321262
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 11:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758625354; cv=none; b=m7gUN2pmOaaKbo4/VQpJ14NbXA4pZMoMWuT1YFvxsSDh+szkEpi+fGY3u63I9JJUzA8h6VrLodZL8yZwVg6iiuJXWOTEpQo0ZNJ14ObChOu66scgABKuixEZibfIs7t2yvLQMtczhLYbSbbUsH2IPQGgivSXj7tWUXYspNu4GRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758625354; c=relaxed/simple;
	bh=PDNgXpiCYkGy0f5PHjFiUVZHOVOh7eQBEYHz4Ml97vU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ihmy2rRi1ln8MyOIEXm96QnR1E7e2JdAeETbPesgyFuPbtL+nYRjU+iK7IcB4p+fTNrPX2Nl4CMo9DAYrOdZXQEQRtDNwcz6v6Yupas832b2mKiFEzF8uRn+El7O6mi4Lb68zyQDLMGYE/Jl8Y45gSBr/e952Xl42DTFnzqN/wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UNX+yDIl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E49FC4CEF5;
	Tue, 23 Sep 2025 11:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758625352;
	bh=PDNgXpiCYkGy0f5PHjFiUVZHOVOh7eQBEYHz4Ml97vU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UNX+yDIlriC2q90XsANWPzH7FZgDpyFqsrKSlQSwEIDw3vLKKqBStCnmOPzv7sF6j
	 voP2segSzlUWjSp3A4reA3whTWmsCM3GNjt4sKvjz01COh1eJKYfmlsUN+7zGyqJ/7
	 jWXyR9Ot7q1AX5zaRCuZ3kE6XvOhUiKjIObe4yd+thW61KKcpWUxRBd9ULj6JN9jwZ
	 XKLUTISbRVgtfblAvVRgo92xQ54SXS4fXJr6w7KlDzosZMmsVLjn8XLZ5davNe8Q0/
	 QS4PoLZ4uBIEW0uddj9awdP4KG9Fb8XKb+85BrwQ0ZAnb1CDe6fN85HqmmfyikaNYf
	 vclcaZFWVsYGA==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCH bpf-next v4 1/3] bpf, x86: Add support for signed arena loads
Date: Tue, 23 Sep 2025 11:01:49 +0000
Message-ID: <20250923110157.18326-2-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250923110157.18326-1-puranjay@kernel.org>
References: <20250923110157.18326-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Currently, signed load instructions into arena memory are unsupported.
The compiler is free to generate these, and on GCC-14 we see a
corresponding error when it happens. The hurdle in supporting them is
deciding which unused opcode to use to mark them for the JIT's own
consumption. After much thinking, it appears 0xc0 / BPF_NOSPEC can be
combined with load instructions to identify signed arena loads. Use
this to recognize and JIT them appropriately, and remove the verifier
side limitation on the program if the JIT supports them.

Co-developed-by: Puranjay Mohan <puranjay@kernel.org>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 arch/arm64/net/bpf_jit_comp.c   |  5 +++++
 arch/riscv/net/bpf_jit_comp64.c |  5 +++++
 arch/s390/net/bpf_jit_comp.c    |  5 +++++
 arch/x86/net/bpf_jit_comp.c     | 40 ++++++++++++++++++++++++++++++---
 include/linux/filter.h          |  3 +++
 kernel/bpf/verifier.c           | 11 ++++++---
 6 files changed, 63 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index e36261c63952..796938b535cd 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -3064,6 +3064,11 @@ bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena)
 		if (!bpf_atomic_is_load_store(insn) &&
 		    !cpus_have_cap(ARM64_HAS_LSE_ATOMICS))
 			return false;
+		break;
+	case BPF_LDX | BPF_MEMSX | BPF_B:
+	case BPF_LDX | BPF_MEMSX | BPF_H:
+	case BPF_LDX | BPF_MEMSX | BPF_W:
+		return false;
 	}
 	return true;
 }
diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 14d7aab61fcb..83672373d026 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -2066,6 +2066,11 @@ bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena)
 		case BPF_STX | BPF_ATOMIC | BPF_DW:
 			if (insn->imm == BPF_CMPXCHG)
 				return rv_ext_enabled(ZACAS);
+			break;
+		case BPF_LDX | BPF_MEMSX | BPF_B:
+		case BPF_LDX | BPF_MEMSX | BPF_H:
+		case BPF_LDX | BPF_MEMSX | BPF_W:
+			return false;
 		}
 	}
 
diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index 8b57d8532f36..cf461d76e9da 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -2967,6 +2967,11 @@ bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena)
 	case BPF_STX | BPF_ATOMIC | BPF_DW:
 		if (bpf_atomic_is_load_store(insn))
 			return false;
+		break;
+	case BPF_LDX | BPF_MEMSX | BPF_B:
+	case BPF_LDX | BPF_MEMSX | BPF_H:
+	case BPF_LDX | BPF_MEMSX | BPF_W:
+		return false;
 	}
 	return true;
 }
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 8d34a9400a5e..fc13306af15f 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1152,11 +1152,38 @@ static void emit_ldx_index(u8 **pprog, u32 size, u32 dst_reg, u32 src_reg, u32 i
 	*pprog = prog;
 }
 
+static void emit_ldsx_index(u8 **pprog, u32 size, u32 dst_reg, u32 src_reg, u32 index_reg, int off)
+{
+	u8 *prog = *pprog;
+
+	switch (size) {
+	case BPF_B:
+		/* movsx rax, byte ptr [rax + r12 + off] */
+		EMIT3(add_3mod(0x48, src_reg, dst_reg, index_reg), 0x0F, 0xBE);
+		break;
+	case BPF_H:
+		/* movsx rax, word ptr [rax + r12 + off] */
+		EMIT3(add_3mod(0x48, src_reg, dst_reg, index_reg), 0x0F, 0xBF);
+		break;
+	case BPF_W:
+		/* movsx rax, dword ptr [rax + r12 + off] */
+		EMIT2(add_3mod(0x48, src_reg, dst_reg, index_reg), 0x63);
+		break;
+	}
+	emit_insn_suffix_SIB(&prog, src_reg, dst_reg, index_reg, off);
+	*pprog = prog;
+}
+
 static void emit_ldx_r12(u8 **pprog, u32 size, u32 dst_reg, u32 src_reg, int off)
 {
 	emit_ldx_index(pprog, size, dst_reg, src_reg, X86_REG_R12, off);
 }
 
+static void emit_ldsx_r12(u8 **prog, u32 size, u32 dst_reg, u32 src_reg, int off)
+{
+	emit_ldsx_index(prog, size, dst_reg, src_reg, X86_REG_R12, off);
+}
+
 /* STX: *(u8*)(dst_reg + off) = src_reg */
 static void emit_stx(u8 **pprog, u32 size, u32 dst_reg, u32 src_reg, int off)
 {
@@ -2109,15 +2136,22 @@ st:			if (is_imm8(insn->off))
 		case BPF_LDX | BPF_PROBE_MEM32 | BPF_H:
 		case BPF_LDX | BPF_PROBE_MEM32 | BPF_W:
 		case BPF_LDX | BPF_PROBE_MEM32 | BPF_DW:
+		case BPF_LDX | BPF_PROBE_MEM32SX | BPF_B:
+		case BPF_LDX | BPF_PROBE_MEM32SX | BPF_H:
+		case BPF_LDX | BPF_PROBE_MEM32SX | BPF_W:
 		case BPF_STX | BPF_PROBE_MEM32 | BPF_B:
 		case BPF_STX | BPF_PROBE_MEM32 | BPF_H:
 		case BPF_STX | BPF_PROBE_MEM32 | BPF_W:
 		case BPF_STX | BPF_PROBE_MEM32 | BPF_DW:
 			start_of_ldx = prog;
-			if (BPF_CLASS(insn->code) == BPF_LDX)
-				emit_ldx_r12(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn->off);
-			else
+			if (BPF_CLASS(insn->code) == BPF_LDX) {
+				if (BPF_MODE(insn->code) == BPF_PROBE_MEM32SX)
+					emit_ldsx_r12(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn->off);
+				else
+					emit_ldx_r12(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn->off);
+			} else {
 				emit_stx_r12(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn->off);
+			}
 populate_extable:
 			{
 				struct exception_table_entry *ex;
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 4241a885975f..f5c859b8131a 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -78,6 +78,9 @@ struct ctl_table_header;
 /* unused opcode to mark special atomic instruction */
 #define BPF_PROBE_ATOMIC 0xe0
 
+/* unused opcode to mark special ldsx instruction. Same as BPF_NOSPEC */
+#define BPF_PROBE_MEM32SX 0xc0
+
 /* unused opcode to mark call to interpreter with arguments */
 #define BPF_CALL_ARGS	0xe0
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1d4183bc3cd1..b368e541d1f2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21250,10 +21250,14 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 			continue;
 		case PTR_TO_ARENA:
 			if (BPF_MODE(insn->code) == BPF_MEMSX) {
-				verbose(env, "sign extending loads from arena are not supported yet\n");
-				return -EOPNOTSUPP;
+				if (!bpf_jit_supports_insn(insn, true)) {
+					verbose(env, "sign extending loads from arena are not supported yet\n");
+					return -EOPNOTSUPP;
+				}
+				insn->code = BPF_CLASS(insn->code) | BPF_PROBE_MEM32SX | BPF_SIZE(insn->code);
+			} else {
+				insn->code = BPF_CLASS(insn->code) | BPF_PROBE_MEM32 | BPF_SIZE(insn->code);
 			}
-			insn->code = BPF_CLASS(insn->code) | BPF_PROBE_MEM32 | BPF_SIZE(insn->code);
 			env->prog->aux->num_exentries++;
 			continue;
 		default:
@@ -21459,6 +21463,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 			if (BPF_CLASS(insn->code) == BPF_LDX &&
 			    (BPF_MODE(insn->code) == BPF_PROBE_MEM ||
 			     BPF_MODE(insn->code) == BPF_PROBE_MEM32 ||
+			     BPF_MODE(insn->code) == BPF_PROBE_MEM32SX ||
 			     BPF_MODE(insn->code) == BPF_PROBE_MEMSX))
 				num_exentries++;
 			if ((BPF_CLASS(insn->code) == BPF_STX ||
-- 
2.47.3


