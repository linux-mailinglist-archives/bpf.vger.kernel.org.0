Return-Path: <bpf+bounces-67726-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C43CB495B0
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 18:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B68B21898507
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 16:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C631CBEAA;
	Mon,  8 Sep 2025 16:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FsmuRivk"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F65831063C
	for <bpf@vger.kernel.org>; Mon,  8 Sep 2025 16:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757349417; cv=none; b=t4SQBuE16eWNuXLiNfDWN4aRkIM6hvgU8pKw7cX7pX89pu/9LkkuTWiOlIiqi/qihGvdJC9uqM3Uv7DwODxS7t4IMSRDh6NOZp0dYysVQVZSA9NKeFBCx+PmTqWMJJw1rIEq72LCT9Bz6o3gR7uYVQGEfLAL7MemiAW4UveKmO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757349417; c=relaxed/simple;
	bh=hClYAMjDahvVyU3lIom3BLL5dfb2JOmiB0zo9QK4YaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cRszTHp3jYGf2VF774xl/2F+dmWED+SW+lo+Rgll1EjzPZ31kd3XoQtOTDcSQ1+wodpn0SeYPH3G4FP8xnZ39I2/h3accY6fZcL7WW14jebN63PBXaIDzm2XMqgb3eZNLJ4wY89rQhueyfYY2zPSJGtVTcNRvWYV5lqy0OJN7cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FsmuRivk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FEC0C4CEF1;
	Mon,  8 Sep 2025 16:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757349416;
	bh=hClYAMjDahvVyU3lIom3BLL5dfb2JOmiB0zo9QK4YaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FsmuRivk++ewYUHn7jBwSx/8JYRe2CdwaeyDdeTRiH3q4SlDOALLix2TTUEZiEMdE
	 en8iVMVzq5kYTuqlpznYaqRO+5abXBYoOYG2/DAcB7hk8mfPdrW5vt6G9xApxqYJft
	 GOIqyldsDWnjfsL/XrPUvxCw9bvPei41yU1BFrDxLwpsSgH2AUZQEi8UeVlW7fWMz0
	 rfElsck0nkLuN2uqvoV48CnJ6fYQ6Q3Foaae32fscFhWGiQGz5wItEKznmKPlW9kIJ
	 WL9OpNojx/t4VfHl/SK3dD845mgwaySZV1YTNvSmU1ZK31B18jzk3EWnQSqRXGZutg
	 hmviV+SOlKjcg==
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
Subject: [PATCH bpf-next v6 1/5] bpf: arm64: simplify exception table handling
Date: Mon,  8 Sep 2025 16:36:30 +0000
Message-ID: <20250908163638.23150-2-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250908163638.23150-1-puranjay@kernel.org>
References: <20250908163638.23150-1-puranjay@kernel.org>
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
index f0b1cb2c3bc48..e6d1fdc1e6f52 100644
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


