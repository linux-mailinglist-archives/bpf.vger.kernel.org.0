Return-Path: <bpf+bounces-66667-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61573B3859A
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 17:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF18D17D64F
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 15:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745311C5D72;
	Wed, 27 Aug 2025 15:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pcEF5kLP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD89B1B0420
	for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 15:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756306887; cv=none; b=KASh2k5Y0+Q/tmYVs+X/moQTD73DkdZQIoSMXOQqQ0HL0FchR+C28Mts8MEOW1ayNAKmr2VdiWaPXheCf7d3S0fSCcvsv59QfHMIWxuddg8s95Oi0IJLYF2hExUrkdKtcn606nHh6Ej8nfqQntx1LM2mwVFKGIAD+ZlNXQhck6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756306887; c=relaxed/simple;
	bh=c1HK8y8Qkj11tazD1gE5AMAKVsRU3JmcrIM6sGVm0To=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PVn4h+RiSbqvc7EZMmg5+5RzrwEl1lJqBaeqzBB8fkfH+vc6TThbt4ldFS6wTzQSeLLIeOw/swsvmk3+lPHljJtQRU6yEp2KndYpcD7c70OCvY7I1l1dhaUksStEuPt5zy71Rs3plP/8Kh9nMVz3eoxxaOCJA1YBD10u4Y1TKcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pcEF5kLP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F26FDC4CEEB;
	Wed, 27 Aug 2025 15:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756306887;
	bh=c1HK8y8Qkj11tazD1gE5AMAKVsRU3JmcrIM6sGVm0To=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=pcEF5kLPjXYlUqQKXeKyHPru3hWgFzOg4ir1R5BbKVGlQ7b2yE8YKER7igwPG+cC2
	 4NFLH5c6PO5krGg/xR1lDw+1n1ktdnJKVkU4A97rXpjI03M88kXsXKTzgcIKdE6ilz
	 nbwjCNZjGOVuqu94aePdMlDwYPNnAiaNV5OrO39AqAWhS0MZ3OV9dghfCoqHMPU50i
	 hYaFiNY5GVPgsBzKaWVF14PeiE/5c7El4zEElP/jgpUAd9e2n0INmADNr7cbPI5wuY
	 wvsNw40g6QWOuqajyoY29wZV9FtZvloYtI9pBDh1eEVIOl2/UHVZMZ+hIy0BInlod6
	 iApYtxaiVPpEw==
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
Subject: [PATCH bpf-next v3 1/3] bpf: arm64: simplify exception table handling
Date: Wed, 27 Aug 2025 15:00:37 +0000
Message-ID: <20250827150113.15763-2-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250827150113.15763-1-puranjay@kernel.org>
References: <20250827150113.15763-1-puranjay@kernel.org>
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


