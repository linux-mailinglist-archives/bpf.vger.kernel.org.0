Return-Path: <bpf+bounces-74725-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D667DC6433D
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 13:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6FEFB4F3B32
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 12:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FDB331A69;
	Mon, 17 Nov 2025 12:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9mfgLS7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D73632ED22;
	Mon, 17 Nov 2025 12:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763383326; cv=none; b=GxeaygP0PtDYANeNYt0Thu0nyjsjuKZ3IIOOVdq1c4f41JDMb1M5RhxR8B7UKXeW0n+djhL+9o7yCTHm4/GUbWwSmXU4sFl7EfbtOYBVtXxW7D1DPMgJ/xTSh2gsnFeHFn6vtLSFs4J1PKKB8Ys71SA7TdXVqZPj0H8IyUNoq64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763383326; c=relaxed/simple;
	bh=0JwRosMMEiVc+YmndSTGpdLxVuq150xOzaXsDrrF6NM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ivtoPc1Axldb8UmXNPxX+4wFnfSyqjkOQ7NwjNRLorkHTYA2Wd5zfNLU8AyRomCeBue6UAQfDFqxRTkewfpRPF1tP/gNhkoIXu9XuQ/LFj8FmLzQqRRUC1+55d/stoAVIpzZoSTLlWZy8L3+RzPdj0th6hqM7EK38wAPaZToRxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I9mfgLS7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57396C113D0;
	Mon, 17 Nov 2025 12:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763383325;
	bh=0JwRosMMEiVc+YmndSTGpdLxVuq150xOzaXsDrrF6NM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I9mfgLS7wfC2dMHfs8VjRTiMOJ71iCJetQjJnjlYL/4W+iKnen7Rg1oiK4uCXVKKD
	 TfamWIZ5q9FjilQi2lvClKh2gGiOYWoT1MWhR2AxzJAYaiN7Du7D5GPHSm3yS4LXg4
	 JKW6mMCZYHWG2RVEBZp7nKk3yH5P20S4aTck11A77J5TgdnYgg5cnO/SKUPRYSAts1
	 s9wxvW9P0X/dbSISPrrgJ2ILXTYUS6UYh3upaFNJtd3C5DRs95z/dnF8zFLT2dnzN7
	 hdPw8rOIJRCdLsmRB4cL7DtcBPfedrf8kMD0uH7BqEFutXbDnsDAr70Mlyufy+8rAw
	 WtOQdBcLVTA9A==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	x86@kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	David Laight <David.Laight@ACULAB.COM>
Subject: [RFC PATCH 5/8] uprobe/x86: Add support to optimize on top of emulated instructions
Date: Mon, 17 Nov 2025 13:40:54 +0100
Message-ID: <20251117124057.687384-6-jolsa@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251117124057.687384-1-jolsa@kernel.org>
References: <20251117124057.687384-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding support to optimize uprobe on top of instructions that can
be emulated.

The idea is to store instructions on underlying 5 bytes and emulate
them during the int3 and uprobe syscall execution:

  - install 'call trampoline' through standard int3 update
  - if int3 is hit before we finish optimizing we emulate
    all underlying instructions
  - when call is installed the uprobe syscall will emulate
    all underlying instructions

Adding opt_xol_ops that emulate instructions that are replaced
by 5 bytes call instruction used to optimize the uprobe.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/include/asm/uprobes.h |  13 ++--
 arch/x86/kernel/uprobes.c      | 106 ++++++++++++++++++++++++++++++++-
 include/linux/uprobes.h        |   1 +
 kernel/events/uprobes.c        |   6 ++
 4 files changed, 120 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/uprobes.h b/arch/x86/include/asm/uprobes.h
index e09aab82b8c1..eaa80dc1c836 100644
--- a/arch/x86/include/asm/uprobes.h
+++ b/arch/x86/include/asm/uprobes.h
@@ -21,8 +21,9 @@ typedef u8 uprobe_opcode_t;
 #define UPROBE_SWBP_INSN_SIZE		   1
 
 enum {
-	ARCH_UPROBE_FLAG_CAN_OPTIMIZE   = 0,
-	ARCH_UPROBE_FLAG_OPTIMIZE_FAIL  = 1,
+	ARCH_UPROBE_FLAG_CAN_OPTIMIZE     = 0,
+	ARCH_UPROBE_FLAG_OPTIMIZE_FAIL    = 1,
+	ARCH_UPROBE_FLAG_OPTIMIZE_EMULATE = 2,
 };
 
 struct uprobe_xol_ops;
@@ -59,11 +60,15 @@ struct arch_uprobe_xol {
 
 struct arch_uprobe {
 	union {
-		u8			insn[MAX_UINSN_BYTES];
+		u8			insn[5*MAX_UINSN_BYTES];
 		u8			ixol[MAX_UINSN_BYTES];
 	};
 
-	struct arch_uprobe_xol		xol;
+	struct arch_uprobe_xol	xol;
+	struct {
+		struct arch_uprobe_xol	xol[5];
+		int			cnt;
+	} opt;
 
 	unsigned long flags;
 };
diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 904c423ea81d..7f3f537a6425 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -277,13 +277,14 @@ static bool is_prefix_bad(struct insn *insn)
 	return false;
 }
 
-static int uprobe_init_insn(struct arch_uprobe *auprobe, struct insn *insn, bool x86_64)
+static int uprobe_init_insn_offset(struct arch_uprobe *auprobe, unsigned long offset,
+				   struct insn *insn, bool x86_64)
 {
 	enum insn_mode m = x86_64 ? INSN_MODE_64 : INSN_MODE_32;
 	u32 volatile *good_insns;
 	int ret;
 
-	ret = insn_decode(insn, auprobe->insn, sizeof(auprobe->insn), m);
+	ret = insn_decode(insn, auprobe->insn + offset, sizeof(auprobe->insn) - offset, m);
 	if (ret < 0)
 		return -ENOEXEC;
 
@@ -310,6 +311,11 @@ static int uprobe_init_insn(struct arch_uprobe *auprobe, struct insn *insn, bool
 	return -ENOTSUPP;
 }
 
+static int uprobe_init_insn(struct arch_uprobe *auprobe, struct insn *insn, bool x86_64)
+{
+	return uprobe_init_insn_offset(auprobe, 0, insn, x86_64);
+}
+
 #ifdef CONFIG_X86_64
 
 struct uretprobe_syscall_args {
@@ -1462,6 +1468,23 @@ static bool sub_emulate_op(struct arch_uprobe *auprobe, struct arch_uprobe_xol *
 
 #undef EFLAGS_MASK
 
+static bool optimized_emulate(struct arch_uprobe *auprobe, struct arch_uprobe_xol *xol,
+			      struct pt_regs *regs)
+{
+	int i;
+
+	for (i = 0; i < auprobe->opt.cnt; i++) {
+		WARN_ON(!auprobe->opt.xol[i].ops->emulate(auprobe, &auprobe->opt.xol[i], regs));
+	}
+	return true;
+}
+
+void arch_uprobe_optimized_emulate(struct arch_uprobe *auprobe, struct pt_regs *regs)
+{
+	if (test_bit(ARCH_UPROBE_FLAG_OPTIMIZE_EMULATE, &auprobe->flags))
+		optimized_emulate(auprobe, NULL, regs);
+}
+
 static const struct uprobe_xol_ops branch_xol_ops = {
 	.emulate  = branch_emulate_op,
 	.post_xol = branch_post_xol_op,
@@ -1479,6 +1502,10 @@ static const struct uprobe_xol_ops sub_xol_ops = {
 	.emulate  = sub_emulate_op,
 };
 
+static const struct uprobe_xol_ops opt_xol_ops = {
+	.emulate  = optimized_emulate,
+};
+
 /* Returns -ENOSYS if branch_xol_ops doesn't handle this insn */
 static int branch_setup_xol_ops(struct arch_uprobe *auprobe, struct insn *insn)
 {
@@ -1675,6 +1702,73 @@ static int sub_setup_xol_ops(struct arch_uprobe_xol *xol, struct insn *insn)
 	xol->ops = &sub_xol_ops;
 	return 0;
 }
+
+static int opt_setup_xol_insns(struct arch_uprobe *auprobe, struct arch_uprobe_xol *xol,
+			       struct insn *insn)
+{
+	int ret;
+
+	/*
+	 * TODO somehow separate nop emulation out of branch_xol_ops,
+	 * so we could emulate nop instructions in here.
+	 */
+	ret = push_setup_xol_ops(xol, insn);
+	if (ret != -ENOSYS)
+		return ret;
+	ret = mov_setup_xol_ops(xol, insn);
+	if (ret != -ENOSYS)
+		return ret;
+	ret = sub_setup_xol_ops(xol, insn);
+	if (ret != -ENOSYS)
+		return ret;
+
+	return -1;
+}
+
+static int opt_setup_xol_ops(struct arch_uprobe *auprobe, struct insn *insn)
+{
+	unsigned long offset = insn->length;
+	struct insn insnX;
+	int i, ret;
+
+	if (test_bit(ARCH_UPROBE_FLAG_CAN_OPTIMIZE, &auprobe->flags))
+		return -ENOSYS;
+
+	ret = opt_setup_xol_insns(auprobe, &auprobe->opt.xol[0], insn);
+	if (ret)
+		return -ENOSYS;
+
+	auprobe->opt.cnt = 1;
+	if (offset >= 5)
+		goto optimize;
+
+	for (i = 1; i < 5; i++) {
+		ret = uprobe_init_insn_offset(auprobe, offset, &insnX, true);
+		if (ret)
+			break;
+		ret = opt_setup_xol_insns(auprobe, &auprobe->opt.xol[i], &insnX);
+		if (ret)
+			break;
+		offset += insnX.length;
+		auprobe->opt.cnt++;
+		if (offset >= 5)
+			goto optimize;
+	}
+
+	return -ENOSYS;
+
+optimize:
+	set_bit(ARCH_UPROBE_FLAG_CAN_OPTIMIZE, &auprobe->flags);
+	set_bit(ARCH_UPROBE_FLAG_OPTIMIZE_EMULATE, &auprobe->flags);
+	auprobe->xol.ops = &opt_xol_ops;
+
+	/*
+	 * TODO perhaps we could 'emulate' nop, so there would be no need for
+	 * ARCH_UPROBE_FLAG_OPTIMIZE_EMULATE flag, because we would emulate
+	 * allways.
+	 */
+	return 0;
+}
 #else
 static int mov_setup_xol_ops(struct arch_uprobe_xol *xol, struct insn *insn)
 {
@@ -1684,6 +1778,10 @@ static int sub_setup_xol_ops(struct arch_uprobe_xol *xol, struct insn *insn)
 {
 	return -ENOSYS;
 }
+static int opt_setup_xol_ops(struct arch_uprobe *auprobe, struct insn *insn)
+{
+	return -ENOSYS;
+}
 #endif
 
 /**
@@ -1706,6 +1804,10 @@ int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe, struct mm_struct *mm,
 	if (can_optimize(&insn, addr))
 		set_bit(ARCH_UPROBE_FLAG_CAN_OPTIMIZE, &auprobe->flags);
 
+	ret = opt_setup_xol_ops(auprobe, &insn);
+	if (ret != -ENOSYS)
+		return ret;
+
 	ret = branch_setup_xol_ops(auprobe, &insn);
 	if (ret != -ENOSYS)
 		return ret;
diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index ee3d36eda45d..4b9f81ad8316 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -242,6 +242,7 @@ extern void arch_uprobe_clear_state(struct mm_struct *mm);
 extern void arch_uprobe_init_state(struct mm_struct *mm);
 extern void handle_syscall_uprobe(struct pt_regs *regs, unsigned long bp_vaddr);
 extern void arch_uprobe_optimize(struct arch_uprobe *auprobe, unsigned long vaddr);
+extern void arch_uprobe_optimized_emulate(struct arch_uprobe *auprobe, struct pt_regs *regs);
 #else /* !CONFIG_UPROBES */
 struct uprobes_state {
 };
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index f11ceb8be8c4..dd893030e32e 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -2701,6 +2701,10 @@ void __weak arch_uprobe_optimize(struct arch_uprobe *auprobe, unsigned long vadd
 {
 }
 
+void __weak arch_uprobe_optimized_emulate(struct arch_uprobe *auprobe, struct pt_regs *regs)
+{
+}
+
 /*
  * Run handler and ask thread to singlestep.
  * Ensure all non-fatal signals cannot interrupt thread while it singlesteps.
@@ -2801,6 +2805,8 @@ void handle_syscall_uprobe(struct pt_regs *regs, unsigned long bp_vaddr)
 	if (arch_uprobe_ignore(&uprobe->arch, regs))
 		return;
 	handler_chain(uprobe, regs);
+
+	arch_uprobe_optimized_emulate(&uprobe->arch, regs);
 }
 
 /*
-- 
2.51.1


