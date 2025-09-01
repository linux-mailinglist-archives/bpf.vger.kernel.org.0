Return-Path: <bpf+bounces-67125-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD680B3EE78
	for <lists+bpf@lfdr.de>; Mon,  1 Sep 2025 21:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58AE91A85C6F
	for <lists+bpf@lfdr.de>; Mon,  1 Sep 2025 19:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11833064A1;
	Mon,  1 Sep 2025 19:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZqJz8lV7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781502405ED
	for <bpf@vger.kernel.org>; Mon,  1 Sep 2025 19:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756755465; cv=none; b=ZblsWEGfvW5ot3zJQOrbkaKG4kCXUMkati7ZFqS2pwxInScAUyyu2K3YvVorBGt/wpF/ciDPYCfeQN0PSIB14hNpg+uwGSTp4xMSizSz6qzMNXZKURxxB3ogM9iSQs890TqfEXdGIUc7vkAh/Q7irZCCxPnK4ZzlSwNjD1zAkpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756755465; c=relaxed/simple;
	bh=FxDXXKanwkW7kcmKjVKcwvSOOIvpqWd1CdlZyqD+vqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IKhbu3H1kPtdS7VZdsm1LoO3kOilpuoWK8jHvMq6dE1EWWtODHMsO8bqs91q3d28cmxocfeJyTQaXwOWAambcAn3DiL6XVOyVVAt0Re8kPifIeRVSTU2kDNNBPlOL6W89rqw/0Pusgl46EApc9iHNN+28W4JtnekGpszZuk5QBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZqJz8lV7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B79C8C4CEF0;
	Mon,  1 Sep 2025 19:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756755465;
	bh=FxDXXKanwkW7kcmKjVKcwvSOOIvpqWd1CdlZyqD+vqQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZqJz8lV7e+y7Z5rSOZm3L3iiCmRot6JxMgPWhDrDb1+Sc2K2JJtkdkevGtfGtqMGP
	 Kt1NgjC8T9dtIwcY6ZH8vA4eLnoboxvPAaKLxA5NIgjEHxprZ/MOiO9v2uvtnhgraU
	 icheX5MGT6hVux6rJqlVfiGUM4Ow4IquL2kcncBvmk6O7widtSUWWHJY5AKkyYrf/z
	 jqLcMPqM+k4XJsXc98x22TJqlpYh0sqjY+ovMZB8Ekl3jLsEa67v5jwH9znUAdQyrc
	 unv3SFfkG2d6eNCyx39ritt7j13XOGNIRnD+tUM2kcAk1EzUiFyAnIOjNg4Auqh6xT
	 lWCSs1nLKKD3A==
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
Cc: Xu Kuohai <xukuohai@huawei.com>
Subject: [PATCH bpf-next v5 1/4] bpf: arm64: simplify exception table handling
Date: Mon,  1 Sep 2025 19:37:23 +0000
Message-ID: <20250901193730.43543-2-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250901193730.43543-1-puranjay@kernel.org>
References: <20250901193730.43543-1-puranjay@kernel.org>
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
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Acked-by: Xu Kuohai <xukuohai@huawei.com>
---
 arch/arm64/net/bpf_jit_comp.c | 25 +++----------------------
 1 file changed, 3 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index a98b8132479a7..9b3162ff63e9c 100644
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


