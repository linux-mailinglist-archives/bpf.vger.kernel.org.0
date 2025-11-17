Return-Path: <bpf+bounces-74722-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 364B3C642AA
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 13:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B4053B3F2A
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 12:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04ED933121C;
	Mon, 17 Nov 2025 12:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jf8DnQek"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7630432E72C;
	Mon, 17 Nov 2025 12:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763383293; cv=none; b=iyqsFdDZ7NfWQCumdGE4qf6+G4eREpwP5BvllXMTU4v6AnYmEfGv9cR7QtgLQNpeP6RmaLSG6np3oI+LHQ5QkVTl/s+HSUkVa1EEfBP+hbxJKewtSaktxupJhmJet0rAZWlmMfRS2z/3tGfPXiM6JChPsR524Cmoz6dZZ3CH6pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763383293; c=relaxed/simple;
	bh=Pc2GqjM7MdxOb7mFpoyfQ0ABTNPxHcevwQvPSUKgUhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qVl9f7yZuomlBvyvZ/pRPUxxDx9TKxA1DSo3SW16H2PHNjmQqBd8V2ifXK3i9l9XLqXc9j90LiVkR1/gW4DWqZ8FGmu+3relo8RRYwu6qr5c3A55uNdribKbFNMth0cYO8QkCI3rgRq11RSLw/aVsPYxjwE8rv3/aOaz8fauBsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jf8DnQek; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A681C19421;
	Mon, 17 Nov 2025 12:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763383293;
	bh=Pc2GqjM7MdxOb7mFpoyfQ0ABTNPxHcevwQvPSUKgUhI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jf8DnQekLT4UaQQcR6aK3MJ7NRj/Z+9HWHxohGmNBZdhK2MYDsL07DeZAOvgl7siM
	 xXJDie+LqfKek7ZKw2Eu9T+gpXS6k5ZASd2kxSp/3IG7HsDjcws5jLg/IwkuzemCgS
	 jp1k1o7uzGbtkiphUBBFLPEm+PKE9P1oHXclzn3gQNSKZN02Tt3kgovfZDMK8M1xCh
	 QYn7ZBDSWS2WYqa0tkgdwDFpe295V8Mgxjt8kXHyTutZtPr36LIgH37PUxv/BdZ1zz
	 io011Y1NvyTDOJl4KN9uPXLa76zWzkddHNDzJ7Z0vAcFg3D+/FNIIQkiOE0/tu6wF6
	 W4Q8qWHzbwm7w==
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
Subject: [RFC PATCH 2/8] uprobe/x86: Use struct arch_uprobe_xol in emulate callback
Date: Mon, 17 Nov 2025 13:40:51 +0100
Message-ID: <20251117124057.687384-3-jolsa@kernel.org>
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

Using struct arch_uprobe_xol also in emulate callback
which will help in following changes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/kernel/uprobes.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index fb9457b29dbc..7d7a5e677472 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -1212,7 +1212,7 @@ static bool can_optimize(struct insn *insn, unsigned long vaddr)
 #endif /* CONFIG_X86_64 */
 
 struct uprobe_xol_ops {
-	bool	(*emulate)(struct arch_uprobe *, struct pt_regs *);
+	bool	(*emulate)(struct arch_uprobe*, struct arch_uprobe_xol *, struct pt_regs *);
 	int	(*pre_xol)(struct arch_uprobe *, struct pt_regs *);
 	int	(*post_xol)(struct arch_uprobe *, struct pt_regs *);
 	void	(*abort)(struct arch_uprobe *, struct pt_regs *);
@@ -1291,9 +1291,9 @@ static const struct uprobe_xol_ops default_xol_ops = {
 	.abort	  = default_abort_op,
 };
 
-static bool branch_is_call(struct arch_uprobe *auprobe)
+static bool branch_is_call(struct arch_uprobe_xol *xol)
 {
-	return auprobe->xol.branch.opc1 == 0xe8;
+	return xol->branch.opc1 == 0xe8;
 }
 
 #define CASE_COND					\
@@ -1325,11 +1325,11 @@ static bool is_cond_jmp_opcode(u8 opcode)
 	}
 }
 
-static bool check_jmp_cond(struct arch_uprobe *auprobe, struct pt_regs *regs)
+static bool check_jmp_cond(struct arch_uprobe_xol *xol, struct pt_regs *regs)
 {
 	unsigned long flags = regs->flags;
 
-	switch (auprobe->xol.branch.opc1) {
+	switch (xol->branch.opc1) {
 	#define DO(expr)	\
 		return expr;
 	CASE_COND
@@ -1344,12 +1344,13 @@ static bool check_jmp_cond(struct arch_uprobe *auprobe, struct pt_regs *regs)
 #undef	COND
 #undef	CASE_COND
 
-static bool branch_emulate_op(struct arch_uprobe *auprobe, struct pt_regs *regs)
+static bool branch_emulate_op(struct arch_uprobe *auprobe, struct arch_uprobe_xol *xol,
+			      struct pt_regs *regs)
 {
-	unsigned long new_ip = regs->ip += auprobe->xol.branch.ilen;
-	unsigned long offs = (long)auprobe->xol.branch.offs;
+	unsigned long new_ip = regs->ip += xol->branch.ilen;
+	unsigned long offs = (long)xol->branch.offs;
 
-	if (branch_is_call(auprobe)) {
+	if (branch_is_call(xol)) {
 		/*
 		 * If it fails we execute this (mangled, see the comment in
 		 * branch_clear_offset) insn out-of-line. In the likely case
@@ -1361,7 +1362,7 @@ static bool branch_emulate_op(struct arch_uprobe *auprobe, struct pt_regs *regs)
 		 */
 		if (emulate_push_stack(regs, new_ip))
 			return false;
-	} else if (!check_jmp_cond(auprobe, regs)) {
+	} else if (!check_jmp_cond(xol, regs)) {
 		offs = 0;
 	}
 
@@ -1369,19 +1370,20 @@ static bool branch_emulate_op(struct arch_uprobe *auprobe, struct pt_regs *regs)
 	return true;
 }
 
-static bool push_emulate_op(struct arch_uprobe *auprobe, struct pt_regs *regs)
+static bool push_emulate_op(struct arch_uprobe *auprobe, struct arch_uprobe_xol *xol,
+			    struct pt_regs *regs)
 {
-	unsigned long *src_ptr = (void *)regs + auprobe->xol.push.reg_offset;
+	unsigned long *src_ptr = (void *)regs + xol->push.reg_offset;
 
 	if (emulate_push_stack(regs, *src_ptr))
 		return false;
-	regs->ip += auprobe->xol.push.ilen;
+	regs->ip += xol->push.ilen;
 	return true;
 }
 
 static int branch_post_xol_op(struct arch_uprobe *auprobe, struct pt_regs *regs)
 {
-	BUG_ON(!branch_is_call(auprobe));
+	BUG_ON(!branch_is_call(&auprobe->xol));
 	/*
 	 * We can only get here if branch_emulate_op() failed to push the ret
 	 * address _and_ another thread expanded our stack before the (mangled)
@@ -1767,7 +1769,7 @@ void arch_uprobe_abort_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
 static bool __skip_sstep(struct arch_uprobe *auprobe, struct pt_regs *regs)
 {
 	if (auprobe->xol.ops->emulate)
-		return auprobe->xol.ops->emulate(auprobe, regs);
+		return auprobe->xol.ops->emulate(auprobe, &auprobe->xol, regs);
 	return false;
 }
 
-- 
2.51.1


