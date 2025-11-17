Return-Path: <bpf+bounces-74724-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BCAC6437D
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 13:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E36C0382895
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 12:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C664B331A46;
	Mon, 17 Nov 2025 12:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S34H/Dr4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4370B32E12B;
	Mon, 17 Nov 2025 12:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763383315; cv=none; b=rIhKVLsEJuBLSXToODLIcrN18dOhDk/Y/7PYWymmbguNNog10E1kVYtXDEoH1Cs3BtTIx2uDEnKgZ7XRvhKa1xfrJFto8F9aY7ikCgW2DjROwf5GIhoLYw5xoHHXFkKZ17M75ucCmLnRsh55u3E4rzhu8oyASv9CrjLTGgPNPgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763383315; c=relaxed/simple;
	bh=cmWhLOteajP81U9DPJ+I9fRrSgTXE1zBKNwdychnGC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KYBkHQr2ReB6kMd2vSBSqn7DyXqEIjGybqRgwEkXkpVI31kyZH5PNvHdARNCt3r6wEnzp+XGvxiFl32KpBEMXdQ33eek3CmFGQw9MBlzXgyq40OC1PwFNVSTlWtNKiMVeYp6YeLr0iZvVx2twvKryF28LbZta6Ubj3QOA+Bsar8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S34H/Dr4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FC1BC2BC86;
	Mon, 17 Nov 2025 12:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763383314;
	bh=cmWhLOteajP81U9DPJ+I9fRrSgTXE1zBKNwdychnGC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S34H/Dr4l/HldrRWfxf+yg1T9Y43kGHQ/vFAkAtP/tQmA9N5vBeMlaEe9lcLKt9jQ
	 M80Yi4ZynbSNmvP2dKHvtNqBu31nKWY10NLNwmN84Uv8FSsaSdUuirKrhCMNb130cw
	 hs88Pd5vVmstyUvxGFKuVCp+Lz08IILMT29jZozaHHkW3XSku26Z21HKUzr0chULGb
	 JjK0ikibryIDoYhKrpjx0VF7PcOfuWNWh7HL+FongikgHtYjRR85GgVWg2gNFJkDOw
	 inNl8dDgfbI1WZ7+wackqH7ZoY4/OeXpgSCFBQ/c7WGVna95DHoy19K0bYx5/As3VB
	 CfDGGlCWJpODQ==
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
Subject: [RFC PATCH 4/8] uprobe/x86: Add support to emulate sub imm,reg instructions
Date: Mon, 17 Nov 2025 13:40:53 +0100
Message-ID: <20251117124057.687384-5-jolsa@kernel.org>
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

Adding support to emulate sub reg, imm instructions, because it's
often part of the function prologue.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/include/asm/uprobes.h |  5 +++
 arch/x86/kernel/uprobes.c      | 73 ++++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+)

diff --git a/arch/x86/include/asm/uprobes.h b/arch/x86/include/asm/uprobes.h
index e6fd87a1cbc3..e09aab82b8c1 100644
--- a/arch/x86/include/asm/uprobes.h
+++ b/arch/x86/include/asm/uprobes.h
@@ -49,6 +49,11 @@ struct arch_uprobe_xol {
 			u16	dst;    /* to the start of pt_regs */
 			u8	ilen;
 		}			mov;
+		struct {
+			s32	val;
+			u16	reg;	/* to the start of pt_regs */
+			u8	ilen;
+		}			sub;
 	};
 };
 
diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 5c44c4b84e99..904c423ea81d 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -1428,6 +1428,40 @@ static bool mov_emulate_op(struct arch_uprobe *auprobe, struct arch_uprobe_xol *
 	return true;
 }
 
+#define EFLAGS_MASK (X86_EFLAGS_OF|X86_EFLAGS_SF|X86_EFLAGS_ZF|X86_EFLAGS_AF|\
+		     X86_EFLAGS_PF|X86_EFLAGS_CF)
+
+static bool sub_emulate_op(struct arch_uprobe *auprobe, struct arch_uprobe_xol *xol,
+			   struct pt_regs *regs)
+{
+	unsigned long dst, flags = regs->flags, val = xol->sub.val;
+	unsigned long *reg = (void *) regs + xol->sub.reg;
+
+	dst = *reg;
+
+	/*
+	 * Emulate sub with 'sub reg,reg' and get result value and
+	 * flags register change. Not sure it's completely equivalent
+	 * to sub reg,imm so perhaps there's better way.
+	 */
+	asm volatile (
+		"pushf \n\t"
+		"push %[flags]; popf \n\t"
+		"subq %[src], %[dst] \n\t"
+		"pushf; popq %[flags] \n\t"
+		"popf \n\t"
+		: [flags] "+D" (flags), [dst] "+r" (dst)
+		: [src] "r" (val)
+	);
+
+	*reg = dst;
+	regs->flags = (regs->flags & ~EFLAGS_MASK) | (flags & EFLAGS_MASK);
+	regs->ip += xol->sub.ilen;
+	return true;
+}
+
+#undef EFLAGS_MASK
+
 static const struct uprobe_xol_ops branch_xol_ops = {
 	.emulate  = branch_emulate_op,
 	.post_xol = branch_post_xol_op,
@@ -1441,6 +1475,10 @@ static const struct uprobe_xol_ops mov_xol_ops = {
 	.emulate  = mov_emulate_op,
 };
 
+static const struct uprobe_xol_ops sub_xol_ops = {
+	.emulate  = sub_emulate_op,
+};
+
 /* Returns -ENOSYS if branch_xol_ops doesn't handle this insn */
 static int branch_setup_xol_ops(struct arch_uprobe *auprobe, struct insn *insn)
 {
@@ -1610,11 +1648,42 @@ static int mov_setup_xol_ops(struct arch_uprobe_xol *xol, struct insn *insn)
 	xol->ops = &mov_xol_ops;
 	return 0;
 }
+
+static int sub_setup_xol_ops(struct arch_uprobe_xol *xol, struct insn *insn)
+{
+	u8 opc1 = OPCODE1(insn);
+	int off;
+
+	if (opc1 != 0x81)
+		return -ENOSYS;
+	if (insn->rex_prefix.nbytes != 1 ||
+	    insn->rex_prefix.bytes[0] != 0x48)
+		return -ENOSYS;
+	if (X86_MODRM_MOD(insn->modrm.value) != 3)
+		return -ENOSYS;
+	if (X86_MODRM_REG(insn->modrm.value) != 5)
+		return -ENOSYS;
+
+	/* get register offset */
+	off = insn_get_modrm_rm_off(insn);
+	if (off < 0)
+		return off;
+
+	xol->sub.reg = off;
+	xol->sub.val = insn->immediate.value;
+	xol->sub.ilen = insn->length;
+	xol->ops = &sub_xol_ops;
+	return 0;
+}
 #else
 static int mov_setup_xol_ops(struct arch_uprobe_xol *xol, struct insn *insn)
 {
 	return -ENOSYS;
 }
+static int sub_setup_xol_ops(struct arch_uprobe_xol *xol, struct insn *insn)
+{
+	return -ENOSYS;
+}
 #endif
 
 /**
@@ -1649,6 +1718,10 @@ int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe, struct mm_struct *mm,
 	if (ret != -ENOSYS)
 		return ret;
 
+	ret = sub_setup_xol_ops(&auprobe->xol, &insn);
+	if (ret != -ENOSYS)
+		return ret;
+
 	/*
 	 * Figure out which fixups default_post_xol_op() will need to perform,
 	 * and annotate defparam->fixups accordingly.
-- 
2.51.1


