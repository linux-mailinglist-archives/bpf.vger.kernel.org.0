Return-Path: <bpf+bounces-63796-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE93B0AEFD
	for <lists+bpf@lfdr.de>; Sat, 19 Jul 2025 11:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3A807AC4B3
	for <lists+bpf@lfdr.de>; Sat, 19 Jul 2025 09:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE0423AB85;
	Sat, 19 Jul 2025 09:14:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301DB21D00D;
	Sat, 19 Jul 2025 09:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752916469; cv=none; b=bOoE3BnkMLOpBmvUCeXUbMDUGgmwaWO7UthLmRi4Vl5T+gGc9ZHRrv53UoDLZWtMKQCO7K2R6zbIGozWzjqWioJ9SB7nFoZ/+4IRvbUEuvWyU0tQhnxol3bBqZYWv4yC5f0k+BrclNA1kQQqySQI8rdmbnyGfWL7Pcdfts49Xrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752916469; c=relaxed/simple;
	bh=FXmBVMTgD/6qn4hhvJoQF6a8hLyc9TG3qp9KRsOL03w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Pjn0W+MDsaC3Yb7M12uM6OBJr57xf9BlnSz9IoI1AELg1Zq4OW9CIz6bC8KxvdEFUPVH2s/PWo7t1r8nyWjpxRDwZ/8k0bCyt0cGnTFmmc7LZnG9uI5vasN1b8E9A0kIwCTcSw2cFMXSb9s+vBFkVf99ax4Q3LteyL4BZfEjvow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bkgw14QzxzYQvFs;
	Sat, 19 Jul 2025 17:14:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 5B8171A0D17;
	Sat, 19 Jul 2025 17:14:24 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP4 (Coremail) with SMTP id gCh0CgCHURLuYXtopCAYAw--.54295S10;
	Sat, 19 Jul 2025 17:14:24 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Pu Lehui <pulehui@huawei.com>
Subject: [PATCH bpf-next 08/10] riscv, bpf: Add ex_insn_off and ex_jmp_off for exception table handling
Date: Sat, 19 Jul 2025 09:17:28 +0000
Message-Id: <20250719091730.2660197-9-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250719091730.2660197-1-pulehui@huaweicloud.com>
References: <20250719091730.2660197-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHURLuYXtopCAYAw--.54295S10
X-Coremail-Antispam: 1UD129KBjvJXoWxtrWxXF4xKF4kZw4rJw48tFb_yoW3ZFyDpr
	yqk3sxA39Yqr4FvFyDtFsrXr1Skw4UCrnrGrn5X3yxJa1Sqr45Ga45Ka4YyFy5Gry8Wr18
	AF4qkrySk3Z3ArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
	AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6r
	W5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuY
	vjxUI-eODUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

Add ex_insn_off and ex_jmp_off fields to struct rv_jit_context so that
add_exception_handler() does not need to be immediately followed by the
instruction to add the exception table. ex_insn_off indicates the offset
of the instruction to add the exception table, and ex_jmp_off indicates
the offset to jump over the faulting instruction. This is to prepare for
adding the exception table to atomic instructions later, because some
atomic instructions need to perform zext or other operations.

Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 arch/riscv/net/bpf_jit.h        |  2 +
 arch/riscv/net/bpf_jit_comp64.c | 84 +++++++++++++++------------------
 2 files changed, 39 insertions(+), 47 deletions(-)

diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
index 0790f40b7e9d..be2915444ce5 100644
--- a/arch/riscv/net/bpf_jit.h
+++ b/arch/riscv/net/bpf_jit.h
@@ -78,6 +78,8 @@ struct rv_jit_context {
 	int epilogue_offset;
 	int *offset;		/* BPF to RV */
 	int nexentries;
+	int ex_insn_off;
+	int ex_jmp_off;
 	unsigned long flags;
 	int stack_size;
 	u64 arena_vm_start;
diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 8e813809d305..56b592af53a6 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -511,57 +511,54 @@ static void emit_stx_insn(u8 rd, s16 off, u8 rs, u8 size, struct rv_jit_context
 	}
 }
 
-static int emit_ldx(u8 rd, s16 off, u8 rs, u8 size, bool sign_ext,
+static void emit_ldx(u8 rd, s16 off, u8 rs, u8 size, bool sign_ext,
 		    struct rv_jit_context *ctx)
 {
-	int insns_start;
-
 	if (is_12b_int(off)) {
-		insns_start = ctx->ninsns;
+		ctx->ex_insn_off = ctx->ninsns;
 		emit_ldx_insn(rd, off, rs, size, sign_ext, ctx);
-		return ctx->ninsns - insns_start;
+		ctx->ex_jmp_off = ctx->ninsns;
+		return;
 	}
 
 	emit_imm(RV_REG_T1, off, ctx);
 	emit_add(RV_REG_T1, RV_REG_T1, rs, ctx);
-	insns_start = ctx->ninsns;
+	ctx->ex_insn_off = ctx->ninsns;
 	emit_ldx_insn(rd, 0, RV_REG_T1, size, sign_ext, ctx);
-	return ctx->ninsns - insns_start;
+	ctx->ex_jmp_off = ctx->ninsns;
 }
 
-static int emit_st(u8 rd, s16 off, s32 imm, u8 size, struct rv_jit_context *ctx)
+static void emit_st(u8 rd, s16 off, s32 imm, u8 size, struct rv_jit_context *ctx)
 {
-	int insns_start;
-
 	emit_imm(RV_REG_T1, imm, ctx);
 	if (is_12b_int(off)) {
-		insns_start = ctx->ninsns;
+		ctx->ex_insn_off = ctx->ninsns;
 		emit_stx_insn(rd, off, RV_REG_T1, size, ctx);
-		return ctx->ninsns - insns_start;
+		ctx->ex_jmp_off = ctx->ninsns;
+		return;
 	}
 
 	emit_imm(RV_REG_T2, off, ctx);
 	emit_add(RV_REG_T2, RV_REG_T2, rd, ctx);
-	insns_start = ctx->ninsns;
+	ctx->ex_insn_off = ctx->ninsns;
 	emit_stx_insn(RV_REG_T2, 0, RV_REG_T1, size, ctx);
-	return ctx->ninsns - insns_start;
+	ctx->ex_jmp_off = ctx->ninsns;
 }
 
-static int emit_stx(u8 rd, s16 off, u8 rs, u8 size, struct rv_jit_context *ctx)
+static void emit_stx(u8 rd, s16 off, u8 rs, u8 size, struct rv_jit_context *ctx)
 {
-	int insns_start;
-
 	if (is_12b_int(off)) {
-		insns_start = ctx->ninsns;
+		ctx->ex_insn_off = ctx->ninsns;
 		emit_stx_insn(rd, off, rs, size, ctx);
-		return ctx->ninsns - insns_start;
+		ctx->ex_jmp_off = ctx->ninsns;
+		return;
 	}
 
 	emit_imm(RV_REG_T1, off, ctx);
 	emit_add(RV_REG_T1, RV_REG_T1, rd, ctx);
-	insns_start = ctx->ninsns;
+	ctx->ex_insn_off = ctx->ninsns;
 	emit_stx_insn(RV_REG_T1, 0, rs, size, ctx);
-	return ctx->ninsns - insns_start;
+	ctx->ex_jmp_off = ctx->ninsns;
 }
 
 static int emit_atomic_ld_st(u8 rd, u8 rs, const struct bpf_insn *insn,
@@ -700,9 +697,8 @@ bool ex_handler_bpf(const struct exception_table_entry *ex,
 }
 
 /* For accesses to BTF pointers, add an entry to the exception table */
-static int add_exception_handler(const struct bpf_insn *insn,
-				 struct rv_jit_context *ctx,
-				 int dst_reg, int insn_len)
+static int add_exception_handler(const struct bpf_insn *insn, int dst_reg,
+				 struct rv_jit_context *ctx)
 {
 	struct exception_table_entry *ex;
 	unsigned long pc;
@@ -710,21 +706,22 @@ static int add_exception_handler(const struct bpf_insn *insn,
 	off_t fixup_offset;
 
 	if (!ctx->insns || !ctx->ro_insns || !ctx->prog->aux->extable ||
-	    (BPF_MODE(insn->code) != BPF_PROBE_MEM && BPF_MODE(insn->code) != BPF_PROBE_MEMSX &&
-	     BPF_MODE(insn->code) != BPF_PROBE_MEM32))
+	    ctx->ex_insn_off <= 0 || ctx->ex_jmp_off <= 0)
 		return 0;
 
-	if (WARN_ON_ONCE(ctx->nexentries >= ctx->prog->aux->num_exentries))
-		return -EINVAL;
+	if (BPF_MODE(insn->code) != BPF_PROBE_MEM &&
+	    BPF_MODE(insn->code) != BPF_PROBE_MEMSX &&
+	    BPF_MODE(insn->code) != BPF_PROBE_MEM32)
+		return 0;
 
-	if (WARN_ON_ONCE(insn_len > ctx->ninsns))
+	if (WARN_ON_ONCE(ctx->nexentries >= ctx->prog->aux->num_exentries))
 		return -EINVAL;
 
-	if (WARN_ON_ONCE(!rvc_enabled() && insn_len == 1))
+	if (WARN_ON_ONCE(ctx->ex_insn_off > ctx->ninsns || ctx->ex_jmp_off > ctx->ninsns))
 		return -EINVAL;
 
 	ex = &ctx->prog->aux->extable[ctx->nexentries];
-	pc = (unsigned long)&ctx->ro_insns[ctx->ninsns - insn_len];
+	pc = (unsigned long)&ctx->ro_insns[ctx->ex_insn_off];
 
 	/*
 	 * This is the relative offset of the instruction that may fault from
@@ -748,7 +745,7 @@ static int add_exception_handler(const struct bpf_insn *insn,
 	 * that may fault. The execution will jump to this after handling the
 	 * fault.
 	 */
-	fixup_offset = (long)&ex->fixup - (pc + insn_len * sizeof(u16));
+	fixup_offset = (long)&ex->fixup - (long)&ctx->ro_insns[ctx->ex_jmp_off];
 	if (!FIELD_FIT(BPF_FIXUP_OFFSET_MASK, fixup_offset))
 		return -ERANGE;
 
@@ -765,6 +762,8 @@ static int add_exception_handler(const struct bpf_insn *insn,
 		FIELD_PREP(BPF_FIXUP_REG_MASK, dst_reg);
 	ex->type = EX_TYPE_BPF;
 
+	ctx->ex_insn_off = 0;
+	ctx->ex_jmp_off = 0;
 	ctx->nexentries++;
 	return 0;
 }
@@ -1774,7 +1773,6 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 	case BPF_LDX | BPF_PROBE_MEM32 | BPF_DW:
 	{
 		bool sign_ext;
-		int insn_len;
 
 		sign_ext = BPF_MODE(insn->code) == BPF_MEMSX ||
 			   BPF_MODE(insn->code) == BPF_PROBE_MEMSX;
@@ -1784,9 +1782,9 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 			rs = RV_REG_T2;
 		}
 
-		insn_len = emit_ldx(rd, off, rs, BPF_SIZE(code), sign_ext, ctx);
+		emit_ldx(rd, off, rs, BPF_SIZE(code), sign_ext, ctx);
 
-		ret = add_exception_handler(insn, ctx, rd, insn_len);
+		ret = add_exception_handler(insn, rd, ctx);
 		if (ret)
 			return ret;
 
@@ -1809,21 +1807,17 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 	case BPF_ST | BPF_PROBE_MEM32 | BPF_H:
 	case BPF_ST | BPF_PROBE_MEM32 | BPF_W:
 	case BPF_ST | BPF_PROBE_MEM32 | BPF_DW:
-	{
-		int insn_len;
-
 		if (BPF_MODE(insn->code) == BPF_PROBE_MEM32) {
 			emit_add(RV_REG_T3, rd, RV_REG_ARENA, ctx);
 			rd = RV_REG_T3;
 		}
 
-		insn_len = emit_st(rd, off, imm, BPF_SIZE(code), ctx);
+		emit_st(rd, off, imm, BPF_SIZE(code), ctx);
 
-		ret = add_exception_handler(insn, ctx, REG_DONT_CLEAR_MARKER, insn_len);
+		ret = add_exception_handler(insn, REG_DONT_CLEAR_MARKER, ctx);
 		if (ret)
 			return ret;
 		break;
-	}
 
 	/* STX: *(size *)(dst + off) = src */
 	case BPF_STX | BPF_MEM | BPF_B:
@@ -1835,21 +1829,17 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 	case BPF_STX | BPF_PROBE_MEM32 | BPF_H:
 	case BPF_STX | BPF_PROBE_MEM32 | BPF_W:
 	case BPF_STX | BPF_PROBE_MEM32 | BPF_DW:
-	{
-		int insn_len;
-
 		if (BPF_MODE(insn->code) == BPF_PROBE_MEM32) {
 			emit_add(RV_REG_T2, rd, RV_REG_ARENA, ctx);
 			rd = RV_REG_T2;
 		}
 
-		insn_len = emit_stx(rd, off, rs, BPF_SIZE(code), ctx);
+		emit_stx(rd, off, rs, BPF_SIZE(code), ctx);
 
-		ret = add_exception_handler(insn, ctx, REG_DONT_CLEAR_MARKER, insn_len);
+		ret = add_exception_handler(insn, REG_DONT_CLEAR_MARKER, ctx);
 		if (ret)
 			return ret;
 		break;
-	}
 
 	case BPF_STX | BPF_ATOMIC | BPF_B:
 	case BPF_STX | BPF_ATOMIC | BPF_H:
-- 
2.34.1


