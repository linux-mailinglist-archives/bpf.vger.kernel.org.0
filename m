Return-Path: <bpf+bounces-74723-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1CEC64331
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 13:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8A3784F3050
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 12:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015653314C4;
	Mon, 17 Nov 2025 12:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MXA6wu5w"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D76632E720;
	Mon, 17 Nov 2025 12:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763383304; cv=none; b=WxhiR4wgCuMEvcKRr/WdragPkbW0Jod8p2AFlizo356mvT6wTzCCaK33CytZgI/I+dS69qXjUN/JJq/EC2O+zrd2UfqggZ+nkDt37zfJLE5KopVrCQlySevQ826juwcnPjB1RFQyYVCakApIiAvNCHgWXyFcSqqyEXhmlCTw4jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763383304; c=relaxed/simple;
	bh=EtgjniBI1ey4qVAAv41BTEGXtgpXYBGSNtFMyDswsbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZPE2JZp2L86CCUOoHTutaHhLdl3XS+csyH4bowbx0wL20L+u+QarGlb1oDT6iEfJYufSVYYZjquMFfEfR2TjWUs3ggoNYL65MWNMB74hL/WkM8sNsGNNPCfZHD+iiElsG0Zek3VOm4kZnGD7+FZA6n8ZyD2lcqwML3VNihLY/oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MXA6wu5w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 998AFC4CEF1;
	Mon, 17 Nov 2025 12:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763383304;
	bh=EtgjniBI1ey4qVAAv41BTEGXtgpXYBGSNtFMyDswsbg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MXA6wu5wx2ej8t6FINgPibq+mMXWALYZvYku0YTe4HwG2qlKv/Lo/8XIW8Kvpb0UH
	 xiBvp0q8tHvEGdE+bGEI0KJPl0UPuPIOy8bzVq7ONKaLN7Xml3cHlmGhvnvsZ9+QXV
	 mCwA3RZsYG1zhSUowtWoFoWfLKbtkgZ1B0HwUIPNpgLt5Abvk7VdQ/YEE7aA3kPIjp
	 J3NCl+P6lt17CsOMD4jCRnS/FV0auD16IRpTbscOfmNUQjrQbPmcztrKYhM4jBN+UI
	 T0p4CcPrX5GC6yBwYvmy7jqslB85ulDMdSquVdoodBWHD982zs8r5bRuLNYVeO34WP
	 kuA6IHN+NAZZg==
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
Subject: [RFC PATCH 3/8] uprobe/x86: Add support to emulate mov reg,reg instructions
Date: Mon, 17 Nov 2025 13:40:52 +0100
Message-ID: <20251117124057.687384-4-jolsa@kernel.org>
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

Adding support to emulate mov reg to reg instructions, because it's
often part of the function prologue.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/include/asm/uprobes.h |  5 +++
 arch/x86/kernel/uprobes.c      | 61 ++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/arch/x86/include/asm/uprobes.h b/arch/x86/include/asm/uprobes.h
index 819e35aa61c4..e6fd87a1cbc3 100644
--- a/arch/x86/include/asm/uprobes.h
+++ b/arch/x86/include/asm/uprobes.h
@@ -44,6 +44,11 @@ struct arch_uprobe_xol {
 			u8	reg_offset;	/* to the start of pt_regs */
 			u8	ilen;
 		}			push;
+		struct {
+			u16	src;	/* to the start of pt_regs */
+			u16	dst;    /* to the start of pt_regs */
+			u8	ilen;
+		}			mov;
 	};
 };
 
diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 7d7a5e677472..5c44c4b84e99 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -19,6 +19,7 @@
 #include <asm/insn.h>
 #include <asm/mmu_context.h>
 #include <asm/nops.h>
+#include <asm/insn-eval.h>
 
 /* Post-execution fixups. */
 
@@ -1414,6 +1415,19 @@ static void branch_clear_offset(struct arch_uprobe *auprobe, struct insn *insn)
 		0, insn->immediate.nbytes);
 }
 
+static bool mov_emulate_op(struct arch_uprobe *auprobe, struct arch_uprobe_xol *xol,
+			   struct pt_regs *regs)
+{
+	unsigned long *dst, *src;
+
+	dst = (void *) regs + xol->mov.dst;
+	src = (void *) regs + xol->mov.src;
+	*dst = *src;
+
+	regs->ip += xol->mov.ilen;
+	return true;
+}
+
 static const struct uprobe_xol_ops branch_xol_ops = {
 	.emulate  = branch_emulate_op,
 	.post_xol = branch_post_xol_op,
@@ -1423,6 +1437,10 @@ static const struct uprobe_xol_ops push_xol_ops = {
 	.emulate  = push_emulate_op,
 };
 
+static const struct uprobe_xol_ops mov_xol_ops = {
+	.emulate  = mov_emulate_op,
+};
+
 /* Returns -ENOSYS if branch_xol_ops doesn't handle this insn */
 static int branch_setup_xol_ops(struct arch_uprobe *auprobe, struct insn *insn)
 {
@@ -1560,6 +1578,45 @@ static int push_setup_xol_ops(struct arch_uprobe_xol *xol, struct insn *insn)
 	return 0;
 }
 
+#ifdef CONFIG_X86_64
+/* Returns -ENOSYS if mov_xol_ops doesn't handle this insn */
+static int mov_setup_xol_ops(struct arch_uprobe_xol *xol, struct insn *insn)
+{
+	u8 opc1 = OPCODE1(insn);
+	int off_src, off_dst;
+
+	/* validate opcode */
+	if (opc1 != 0x89)
+		return -ENOSYS;
+	if (insn->rex_prefix.nbytes != 1 ||
+	    insn->rex_prefix.bytes[0] != 0x48)
+		return -ENOSYS;
+
+	/* only register operands */
+	if (X86_MODRM_MOD(insn->modrm.value) != 3)
+		return -ENOSYS;
+
+	/* get registers offset */
+	off_src = insn_get_modrm_reg_off(insn);
+	if (off_src < 0)
+		return off_src;
+	off_dst = insn_get_modrm_rm_off(insn);
+	if (off_dst < 0)
+		return off_dst;
+
+	xol->mov.src = off_src;
+	xol->mov.dst = off_dst;
+	xol->mov.ilen = insn->length;
+	xol->ops = &mov_xol_ops;
+	return 0;
+}
+#else
+static int mov_setup_xol_ops(struct arch_uprobe_xol *xol, struct insn *insn)
+{
+	return -ENOSYS;
+}
+#endif
+
 /**
  * arch_uprobe_analyze_insn - instruction analysis including validity and fixups.
  * @auprobe: the probepoint information.
@@ -1588,6 +1645,10 @@ int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe, struct mm_struct *mm,
 	if (ret != -ENOSYS)
 		return ret;
 
+	ret = mov_setup_xol_ops(&auprobe->xol, &insn);
+	if (ret != -ENOSYS)
+		return ret;
+
 	/*
 	 * Figure out which fixups default_post_xol_op() will need to perform,
 	 * and annotate defparam->fixups accordingly.
-- 
2.51.1


