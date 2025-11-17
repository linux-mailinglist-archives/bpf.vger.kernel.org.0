Return-Path: <bpf+bounces-74721-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8BFC64313
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 13:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 617784F46AC
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 12:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8B232E141;
	Mon, 17 Nov 2025 12:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jdw0gcJE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE0632E140;
	Mon, 17 Nov 2025 12:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763383282; cv=none; b=WrAfUW8EM6AmiXJJgMf867NIgcq+lBOVjtjsN/hYQnTU41iNNibnmid4v6ZO4Sa+qNqMV+lj+zjwLLfbAxmxSdnuqaFpT4LPnqV7Jr3+ttD/8oK1cioSeOLSf+wOT8bBaBGgTsSowxrufOOuIFId59Tk/HcelTOeLQ2TD8RDuhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763383282; c=relaxed/simple;
	bh=yjQSutv+PRPuxVWoLTWx0ZnuJMKaycwr6No20fC2bV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y83XHT4GQ0Hth3ksRsn6JhiXechEISvz0C3IDKlqrssn4cJxRA8j/9EuFJMGSX1nD1ebPUX+asahgaNkLkUH3jjO+gZ3i6xrNDxcZ9FS1lz1Z3DyDMiomOiF3C6xdSdQgmjwcLOsNTHF9jpaJ8ulTHmyqaLgtqHxcTc58pq+Q0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jdw0gcJE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA027C4CEF1;
	Mon, 17 Nov 2025 12:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763383282;
	bh=yjQSutv+PRPuxVWoLTWx0ZnuJMKaycwr6No20fC2bV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jdw0gcJEN6R2llFhQRFnVmahQKHonD/DJHHathwL/BlrSQ1uI/RlVmapHpcqO2Cyo
	 az8zzUI1MZz5tuF/3ooUwKM+1bTfsVg9quavN+wiICkk1OxSn4PDkXkq4WXGq+P6Pz
	 ie0XcArxvgOr8viIisaqTmIGkfNNIsZNOJ6LFwe7ncmKoyTPlRh/VwO+rXFL5dnS2C
	 611B4VjgaSKaBahGGoYyok6FWEawppuGd7cU9Nv6QSFFTvdSAZ14iMIu76IpA9qYUR
	 wZwy/k5SgrwirhcX9e3AbUhlcTV6toDird6zSvBqInITZgS6Ik/erfZYHYMq/+SRE6
	 axOTHhfth2INA==
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
Subject: [RFC PATCH 1/8] uprobe/x86: Introduce struct arch_uprobe_xol object
Date: Mon, 17 Nov 2025 13:40:50 +0100
Message-ID: <20251117124057.687384-2-jolsa@kernel.org>
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

Mov xol data into separate arch_uprobe_xol object so we can
hold more of them in following changes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/include/asm/uprobes.h | 16 ++++---
 arch/x86/kernel/uprobes.c      | 78 +++++++++++++++++-----------------
 2 files changed, 49 insertions(+), 45 deletions(-)

diff --git a/arch/x86/include/asm/uprobes.h b/arch/x86/include/asm/uprobes.h
index 1ee2e5115955..819e35aa61c4 100644
--- a/arch/x86/include/asm/uprobes.h
+++ b/arch/x86/include/asm/uprobes.h
@@ -27,12 +27,7 @@ enum {
 
 struct uprobe_xol_ops;
 
-struct arch_uprobe {
-	union {
-		u8			insn[MAX_UINSN_BYTES];
-		u8			ixol[MAX_UINSN_BYTES];
-	};
-
+struct arch_uprobe_xol {
 	const struct uprobe_xol_ops	*ops;
 
 	union {
@@ -50,6 +45,15 @@ struct arch_uprobe {
 			u8	ilen;
 		}			push;
 	};
+};
+
+struct arch_uprobe {
+	union {
+		u8			insn[MAX_UINSN_BYTES];
+		u8			ixol[MAX_UINSN_BYTES];
+	};
+
+	struct arch_uprobe_xol		xol;
 
 	unsigned long flags;
 };
diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 845aeaf36b8d..fb9457b29dbc 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -560,14 +560,14 @@ static void riprel_analyze(struct arch_uprobe *auprobe, struct insn *insn)
 	 */
 	if (reg != 6 && reg2 != 6) {
 		reg2 = 6;
-		auprobe->defparam.fixups |= UPROBE_FIX_RIP_SI;
+		auprobe->xol.defparam.fixups |= UPROBE_FIX_RIP_SI;
 	} else if (reg != 7 && reg2 != 7) {
 		reg2 = 7;
-		auprobe->defparam.fixups |= UPROBE_FIX_RIP_DI;
+		auprobe->xol.defparam.fixups |= UPROBE_FIX_RIP_DI;
 		/* TODO (paranoia): force maskmovq to not use di */
 	} else {
 		reg2 = 3;
-		auprobe->defparam.fixups |= UPROBE_FIX_RIP_BX;
+		auprobe->xol.defparam.fixups |= UPROBE_FIX_RIP_BX;
 	}
 	/*
 	 * Point cursor at the modrm byte.  The next 4 bytes are the
@@ -586,9 +586,9 @@ static void riprel_analyze(struct arch_uprobe *auprobe, struct insn *insn)
 static inline unsigned long *
 scratch_reg(struct arch_uprobe *auprobe, struct pt_regs *regs)
 {
-	if (auprobe->defparam.fixups & UPROBE_FIX_RIP_SI)
+	if (auprobe->xol.defparam.fixups & UPROBE_FIX_RIP_SI)
 		return &regs->si;
-	if (auprobe->defparam.fixups & UPROBE_FIX_RIP_DI)
+	if (auprobe->xol.defparam.fixups & UPROBE_FIX_RIP_DI)
 		return &regs->di;
 	return &regs->bx;
 }
@@ -599,18 +599,18 @@ scratch_reg(struct arch_uprobe *auprobe, struct pt_regs *regs)
  */
 static void riprel_pre_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
 {
-	if (auprobe->defparam.fixups & UPROBE_FIX_RIP_MASK) {
+	if (auprobe->xol.defparam.fixups & UPROBE_FIX_RIP_MASK) {
 		struct uprobe_task *utask = current->utask;
 		unsigned long *sr = scratch_reg(auprobe, regs);
 
 		utask->autask.saved_scratch_register = *sr;
-		*sr = utask->vaddr + auprobe->defparam.ilen;
+		*sr = utask->vaddr + auprobe->xol.defparam.ilen;
 	}
 }
 
 static void riprel_post_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
 {
-	if (auprobe->defparam.fixups & UPROBE_FIX_RIP_MASK) {
+	if (auprobe->xol.defparam.fixups & UPROBE_FIX_RIP_MASK) {
 		struct uprobe_task *utask = current->utask;
 		unsigned long *sr = scratch_reg(auprobe, regs);
 
@@ -1265,16 +1265,16 @@ static int default_post_xol_op(struct arch_uprobe *auprobe, struct pt_regs *regs
 	struct uprobe_task *utask = current->utask;
 
 	riprel_post_xol(auprobe, regs);
-	if (auprobe->defparam.fixups & UPROBE_FIX_IP) {
+	if (auprobe->xol.defparam.fixups & UPROBE_FIX_IP) {
 		long correction = utask->vaddr - utask->xol_vaddr;
 		regs->ip += correction;
-	} else if (auprobe->defparam.fixups & UPROBE_FIX_CALL) {
+	} else if (auprobe->xol.defparam.fixups & UPROBE_FIX_CALL) {
 		regs->sp += sizeof_long(regs); /* Pop incorrect return address */
-		if (emulate_push_stack(regs, utask->vaddr + auprobe->defparam.ilen))
+		if (emulate_push_stack(regs, utask->vaddr + auprobe->xol.defparam.ilen))
 			return -ERESTART;
 	}
 	/* popf; tell the caller to not touch TF */
-	if (auprobe->defparam.fixups & UPROBE_FIX_SETF)
+	if (auprobe->xol.defparam.fixups & UPROBE_FIX_SETF)
 		utask->autask.saved_tf = true;
 
 	return 0;
@@ -1293,7 +1293,7 @@ static const struct uprobe_xol_ops default_xol_ops = {
 
 static bool branch_is_call(struct arch_uprobe *auprobe)
 {
-	return auprobe->branch.opc1 == 0xe8;
+	return auprobe->xol.branch.opc1 == 0xe8;
 }
 
 #define CASE_COND					\
@@ -1329,7 +1329,7 @@ static bool check_jmp_cond(struct arch_uprobe *auprobe, struct pt_regs *regs)
 {
 	unsigned long flags = regs->flags;
 
-	switch (auprobe->branch.opc1) {
+	switch (auprobe->xol.branch.opc1) {
 	#define DO(expr)	\
 		return expr;
 	CASE_COND
@@ -1346,8 +1346,8 @@ static bool check_jmp_cond(struct arch_uprobe *auprobe, struct pt_regs *regs)
 
 static bool branch_emulate_op(struct arch_uprobe *auprobe, struct pt_regs *regs)
 {
-	unsigned long new_ip = regs->ip += auprobe->branch.ilen;
-	unsigned long offs = (long)auprobe->branch.offs;
+	unsigned long new_ip = regs->ip += auprobe->xol.branch.ilen;
+	unsigned long offs = (long)auprobe->xol.branch.offs;
 
 	if (branch_is_call(auprobe)) {
 		/*
@@ -1371,11 +1371,11 @@ static bool branch_emulate_op(struct arch_uprobe *auprobe, struct pt_regs *regs)
 
 static bool push_emulate_op(struct arch_uprobe *auprobe, struct pt_regs *regs)
 {
-	unsigned long *src_ptr = (void *)regs + auprobe->push.reg_offset;
+	unsigned long *src_ptr = (void *)regs + auprobe->xol.push.reg_offset;
 
 	if (emulate_push_stack(regs, *src_ptr))
 		return false;
-	regs->ip += auprobe->push.ilen;
+	regs->ip += auprobe->xol.push.ilen;
 	return true;
 }
 
@@ -1469,16 +1469,16 @@ static int branch_setup_xol_ops(struct arch_uprobe *auprobe, struct insn *insn)
 	}
 
 setup:
-	auprobe->branch.opc1 = opc1;
-	auprobe->branch.ilen = insn->length;
-	auprobe->branch.offs = insn->immediate.value;
+	auprobe->xol.branch.opc1 = opc1;
+	auprobe->xol.branch.ilen = insn->length;
+	auprobe->xol.branch.offs = insn->immediate.value;
 
-	auprobe->ops = &branch_xol_ops;
+	auprobe->xol.ops = &branch_xol_ops;
 	return 0;
 }
 
 /* Returns -ENOSYS if push_xol_ops doesn't handle this insn */
-static int push_setup_xol_ops(struct arch_uprobe *auprobe, struct insn *insn)
+static int push_setup_xol_ops(struct arch_uprobe_xol *xol, struct insn *insn)
 {
 	u8 opc1 = OPCODE1(insn), reg_offset = 0;
 
@@ -1552,9 +1552,9 @@ static int push_setup_xol_ops(struct arch_uprobe *auprobe, struct insn *insn)
 		}
 	}
 
-	auprobe->push.reg_offset = reg_offset;
-	auprobe->push.ilen = insn->length;
-	auprobe->ops = &push_xol_ops;
+	xol->push.reg_offset = reg_offset;
+	xol->push.ilen = insn->length;
+	xol->ops = &push_xol_ops;
 	return 0;
 }
 
@@ -1582,7 +1582,7 @@ int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe, struct mm_struct *mm,
 	if (ret != -ENOSYS)
 		return ret;
 
-	ret = push_setup_xol_ops(auprobe, &insn);
+	ret = push_setup_xol_ops(&auprobe->xol, &insn);
 	if (ret != -ENOSYS)
 		return ret;
 
@@ -1592,7 +1592,7 @@ int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe, struct mm_struct *mm,
 	 */
 	switch (OPCODE1(&insn)) {
 	case 0x9d:		/* popf */
-		auprobe->defparam.fixups |= UPROBE_FIX_SETF;
+		auprobe->xol.defparam.fixups |= UPROBE_FIX_SETF;
 		break;
 	case 0xc3:		/* ret or lret -- ip is correct */
 	case 0xcb:
@@ -1618,10 +1618,10 @@ int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe, struct mm_struct *mm,
 		riprel_analyze(auprobe, &insn);
 	}
 
-	auprobe->defparam.ilen = insn.length;
-	auprobe->defparam.fixups |= fix_ip_or_call;
+	auprobe->xol.defparam.ilen = insn.length;
+	auprobe->xol.defparam.fixups |= fix_ip_or_call;
 
-	auprobe->ops = &default_xol_ops;
+	auprobe->xol.ops = &default_xol_ops;
 	return 0;
 }
 
@@ -1634,8 +1634,8 @@ int arch_uprobe_pre_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
 {
 	struct uprobe_task *utask = current->utask;
 
-	if (auprobe->ops->pre_xol) {
-		int err = auprobe->ops->pre_xol(auprobe, regs);
+	if (auprobe->xol.ops->pre_xol) {
+		int err = auprobe->xol.ops->pre_xol(auprobe, regs);
 		if (err)
 			return err;
 	}
@@ -1686,8 +1686,8 @@ int arch_uprobe_post_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
 	WARN_ON_ONCE(current->thread.trap_nr != UPROBE_TRAP_NR);
 	current->thread.trap_nr = utask->autask.saved_trap_nr;
 
-	if (auprobe->ops->post_xol) {
-		err = auprobe->ops->post_xol(auprobe, regs);
+	if (auprobe->xol.ops->post_xol) {
+		err = auprobe->xol.ops->post_xol(auprobe, regs);
 		if (err) {
 			/*
 			 * Restore ->ip for restart or post mortem analysis.
@@ -1754,8 +1754,8 @@ void arch_uprobe_abort_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
 {
 	struct uprobe_task *utask = current->utask;
 
-	if (auprobe->ops->abort)
-		auprobe->ops->abort(auprobe, regs);
+	if (auprobe->xol.ops->abort)
+		auprobe->xol.ops->abort(auprobe, regs);
 
 	current->thread.trap_nr = utask->autask.saved_trap_nr;
 	regs->ip = utask->vaddr;
@@ -1766,8 +1766,8 @@ void arch_uprobe_abort_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
 
 static bool __skip_sstep(struct arch_uprobe *auprobe, struct pt_regs *regs)
 {
-	if (auprobe->ops->emulate)
-		return auprobe->ops->emulate(auprobe, regs);
+	if (auprobe->xol.ops->emulate)
+		return auprobe->xol.ops->emulate(auprobe, regs);
 	return false;
 }
 
-- 
2.51.1


