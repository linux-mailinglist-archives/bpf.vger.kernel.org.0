Return-Path: <bpf+bounces-65327-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE15B2075C
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 13:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F3D93AFB78
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 11:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702942BEC28;
	Mon, 11 Aug 2025 11:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZCEhCuO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D6A26E16C
	for <bpf@vger.kernel.org>; Mon, 11 Aug 2025 11:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754911118; cv=none; b=pXMzgxWr94NIXnFkdApHLODQ8mwR/Fs3MJaiaifvAmlelKKXWcq07FAcjrFp9KHlRIIa1Y5sQGTgn5bgDpVedlk7lJTKssBZ5dW0s8LA1b2TBp+YsM6u+k/aZ4N+HFmcdwJAUZv49t9NcJQFPEZideHUY/Zy73qZAFNlpIWA5UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754911118; c=relaxed/simple;
	bh=c1HK8y8Qkj11tazD1gE5AMAKVsRU3JmcrIM6sGVm0To=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W/n2UA40okiIMlQ4wfhzUoNJrstLHaD+ElzCVMtksIfTFr8+tFUvGfHQws/ErkKSqqiy/GFeiTOqDkJpjdYhGY+vyR3ZYZ4g0wZpOnQSvgPyS0MPk5ov97Dobu41vZHW/gjaU9zwTvy7btaYXLJyLom0dKpUn00JT9AbywFmx88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZCEhCuO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C057C4CEF1;
	Mon, 11 Aug 2025 11:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754911117;
	bh=c1HK8y8Qkj11tazD1gE5AMAKVsRU3JmcrIM6sGVm0To=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=mZCEhCuOFQawTtvqSz2/8LuEIjp56aMSKFMApBLH/m/2EKaAqY8EuebV30KR33Ysw
	 MSI1I3kTNi35djTvOM08oRVH+gj/4FpZrJ1vGM3x+fuUan/rWmH/97dqaB9bNuOIe+
	 i1WWX0cjfw1OkD8atQaDiMNV8SPJwgJ4bvZolPBj/SE6fvxqX7UUKs5le4+p4Yfjt4
	 gkozpm56a86Nv/khE+lCrU+MZNO7KMI0PHSQiLSd75k7sc3p02IUAV6RnauoucsX77
	 WcuK76BGFZ7gxx8o2Fb98YviLVZMuYrdxwfIkAf0DUOG5RfWFDocj1213oWFQJZpVE
	 PWPLUK9gfZw+g==
From: Puranjay Mohan <puranjay@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
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
	Puranjay Mohan <puranjay@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 1/3] bpf: arm64: simplify exception table handling
Date: Mon, 11 Aug 2025 11:18:22 +0000
Message-ID: <20250811111828.13836-2-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250811111828.13836-1-puranjay@kernel.org>
References: <20250811111828.13836-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BPF loads with BPF_PROBE_MEM(SX) can load from unsafe pointers and the
JIT adds an exception table entry for the JITed instruction which allows
the exeption handler to set the destination register of the load to zero
and continue execution from the next instruction.

As all arm64 instructions are AARCH64_INSN_SIZE size, the exception
handler can just increment the pc by AARCH64_INSN_SIZE without needing
the exact address of the instruction following the the faulting
instruction.

Simplify the exception table usage in arm64 JIT by only saving the
destination register in ex->fixup and drop everything related to
the fixup_offset. The fault handler is modified to add AARCH64_INSN_SIZE
to the pc.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
---
 arch/arm64/net/bpf_jit_comp.c | 25 +++----------------------
 1 file changed, 3 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 52ffe115a8c47..42643fd9168fc 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -1066,19 +1066,18 @@ static void build_epilogue(struct jit_ctx *ctx, bool was_classic)
 	emit(A64_RET(A64_LR), ctx);
 }
 
-#define BPF_FIXUP_OFFSET_MASK	GENMASK(26, 0)
 #define BPF_FIXUP_REG_MASK	GENMASK(31, 27)
 #define DONT_CLEAR 5 /* Unused ARM64 register from BPF's POV */
 
 bool ex_handler_bpf(const struct exception_table_entry *ex,
 		    struct pt_regs *regs)
 {
-	off_t offset = FIELD_GET(BPF_FIXUP_OFFSET_MASK, ex->fixup);
 	int dst_reg = FIELD_GET(BPF_FIXUP_REG_MASK, ex->fixup);
 
 	if (dst_reg != DONT_CLEAR)
 		regs->regs[dst_reg] = 0;
-	regs->pc = (unsigned long)&ex->fixup - offset;
+	/* Skip the faulting instruction */
+	regs->pc += AARCH64_INSN_SIZE;
 	return true;
 }
 
@@ -1088,7 +1087,6 @@ static int add_exception_handler(const struct bpf_insn *insn,
 				 int dst_reg)
 {
 	off_t ins_offset;
-	off_t fixup_offset;
 	unsigned long pc;
 	struct exception_table_entry *ex;
 
@@ -1119,22 +1117,6 @@ static int add_exception_handler(const struct bpf_insn *insn,
 	if (WARN_ON_ONCE(ins_offset >= 0 || ins_offset < INT_MIN))
 		return -ERANGE;
 
-	/*
-	 * Since the extable follows the program, the fixup offset is always
-	 * negative and limited to BPF_JIT_REGION_SIZE. Store a positive value
-	 * to keep things simple, and put the destination register in the upper
-	 * bits. We don't need to worry about buildtime or runtime sort
-	 * modifying the upper bits because the table is already sorted, and
-	 * isn't part of the main exception table.
-	 *
-	 * The fixup_offset is set to the next instruction from the instruction
-	 * that may fault. The execution will jump to this after handling the
-	 * fault.
-	 */
-	fixup_offset = (long)&ex->fixup - (pc + AARCH64_INSN_SIZE);
-	if (!FIELD_FIT(BPF_FIXUP_OFFSET_MASK, fixup_offset))
-		return -ERANGE;
-
 	/*
 	 * The offsets above have been calculated using the RO buffer but we
 	 * need to use the R/W buffer for writes.
@@ -1147,8 +1129,7 @@ static int add_exception_handler(const struct bpf_insn *insn,
 	if (BPF_CLASS(insn->code) != BPF_LDX)
 		dst_reg = DONT_CLEAR;
 
-	ex->fixup = FIELD_PREP(BPF_FIXUP_OFFSET_MASK, fixup_offset) |
-		    FIELD_PREP(BPF_FIXUP_REG_MASK, dst_reg);
+	ex->fixup = FIELD_PREP(BPF_FIXUP_REG_MASK, dst_reg);
 
 	ex->type = EX_TYPE_BPF;
 
-- 
2.47.3


