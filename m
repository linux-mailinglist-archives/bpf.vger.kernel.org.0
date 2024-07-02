Return-Path: <bpf+bounces-33655-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35176924533
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 19:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D28211F21EC9
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 17:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418071C2308;
	Tue,  2 Jul 2024 17:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TFYJSQ4j"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29E91BE251;
	Tue,  2 Jul 2024 17:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719940749; cv=none; b=Vo/N9Zfxc6SehcUGNvOYtKVPIHplKwSzd5WLp5XG6Lmg9LTkmNHMsW/OklEDr6l+vTQbQZyDmpsa0HNdYxE8f7Bfv8q7DFgfnk8z2wIpFidfknnZV5O0kVGHpaNwPBXFlbRPhnhDMu86rNxShGsKceC9wVlXLdXFwdCcwASy7ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719940749; c=relaxed/simple;
	bh=VMmtFC7QyTgjRqS+dVEUQxcZspJ6zLcavmMVHtHX44Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hlPBSBZeUlGyusRdqPqu6MXY21huHZlPsvZ7skC2Jq1z44c+e3A1svDuUryDFkAhJiblV4Q4XdNWhBZ9848qwAW+NmWnZC+OxES/IhpEeR9NmlfoEOJjOz0UWR8bmgoXMZYSK6+R75iNt7ft+4Pp+7mz9Wi5bE7lrmCD2YRo7Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TFYJSQ4j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E32BC116B1;
	Tue,  2 Jul 2024 17:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719940749;
	bh=VMmtFC7QyTgjRqS+dVEUQxcZspJ6zLcavmMVHtHX44Y=;
	h=From:To:Cc:Subject:Date:From;
	b=TFYJSQ4jPF3Zvl7KrK7x4szkiQSlzlFE8qv0zNaxt4eFNqqB52qZgWzkjizV453SL
	 iaFlZ9eP7U9wPFYXO/dlvE+CyD/BTF509qON2DtUfMGMG3MlIJwKEc3+yH684k68aN
	 aAYAeJPlzdamCMEGeGIsRV2axI7zfAW0in1r1A+sgDxDks2Cab9eNAfmVSXQiVgwQJ
	 Ps8x6RJznae6etrWuyjmxyMGe5QKqrQJHyknYSywzYSBmywKQrtvFEZQt8vb5G1spv
	 KgaY3VzK+o9mVzDkxW9htJKrSWG9qK4A+kAURZUnUlqu+8nxcwgyfeyjG/fiqscl7J
	 XnamNPloeaX9w==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-trace-kernel@vger.kernel.org,
	peterz@infradead.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: x86@kernel.org,
	mingo@redhat.com,
	tglx@linutronix.de,
	jpoimboe@redhat.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	rihams@fb.com,
	linux-perf-users@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v2] perf,x86: avoid missing caller address in stack traces captured in uprobe
Date: Tue,  2 Jul 2024 10:18:58 -0700
Message-ID: <20240702171858.187562-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When tracing user functions with uprobe functionality, it's common to
install the probe (e.g., a BPF program) at the first instruction of the
function. This is often going to be `push %rbp` instruction in function
preamble, which means that within that function frame pointer hasn't
been established yet. This leads to consistently missing an actual
caller of the traced function, because perf_callchain_user() only
records current IP (capturing traced function) and then following frame
pointer chain (which would be caller's frame, containing the address of
caller's caller).

So when we have target_1 -> target_2 -> target_3 call chain and we are
tracing an entry to target_3, captured stack trace will report
target_1 -> target_3 call chain, which is wrong and confusing.

This patch proposes a x86-64-specific heuristic to detect `push %rbp`
(`push %ebp` on 32-bit architecture) instruction being traced. Given
entire kernel implementation of user space stack trace capturing works
under assumption that user space code was compiled with frame pointer
register (%rbp/%ebp) preservation, it seems pretty reasonable to use
this instruction as a strong indicator that this is the entry to the
function. In that case, return address is still pointed to by %rsp/%esp,
so we fetch it and add to stack trace before proceeding to unwind the
rest using frame pointer-based logic.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
v1->v2:
  - use native unsigned long for ret_addr (Peter);
  - add same logic for compat logic in perf_callchain_user32 (Peter).

 arch/x86/events/core.c  | 33 +++++++++++++++++++++++++++++++++
 include/linux/uprobes.h |  2 ++
 kernel/events/uprobes.c |  2 ++
 3 files changed, 37 insertions(+)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 5b0dd07b1ef1..60821c1ff2f3 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2833,6 +2833,19 @@ perf_callchain_user32(struct pt_regs *regs, struct perf_callchain_entry_ctx *ent
 
 	fp = compat_ptr(ss_base + regs->bp);
 	pagefault_disable();
+
+#ifdef CONFIG_UPROBES
+	/* see perf_callchain_user() below for why we do this */
+	if (current->utask) {
+		struct arch_uprobe *auprobe = current->utask->auprobe;
+		u32 ret_addr;
+
+		if (auprobe && auprobe->insn[0] == 0x55 /* push %ebp */ &&
+		    !__get_user(ret_addr, (const u32 __user *)regs->sp))
+			perf_callchain_store(entry, ret_addr);
+	}
+#endif
+
 	while (entry->nr < entry->max_stack) {
 		if (!valid_user_frame(fp, sizeof(frame)))
 			break;
@@ -2884,6 +2897,26 @@ perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs
 		return;
 
 	pagefault_disable();
+
+#ifdef CONFIG_UPROBES
+	/*
+	 * If we are called from uprobe handler, and we are indeed at the very
+	 * entry to user function (which is normally a `push %rbp` instruction,
+	 * under assumption of application being compiled with frame pointers),
+	 * we should read return address from *regs->sp before proceeding
+	 * to follow frame pointers, otherwise we'll skip immediate caller
+	 * as %rbp is not yet setup.
+	 */
+	if (current->utask) {
+		struct arch_uprobe *auprobe = current->utask->auprobe;
+		unsigned long ret_addr;
+
+		if (auprobe && auprobe->insn[0] == 0x55 /* push %rbp/%ebp */ &&
+		    !__get_user(ret_addr, (const unsigned long __user *)regs->sp))
+			perf_callchain_store(entry, ret_addr);
+	}
+#endif
+
 	while (entry->nr < entry->max_stack) {
 		if (!valid_user_frame(fp, sizeof(frame)))
 			break;
diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index b503fafb7fb3..a270a5892ab4 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -76,6 +76,8 @@ struct uprobe_task {
 	struct uprobe			*active_uprobe;
 	unsigned long			xol_vaddr;
 
+	struct arch_uprobe              *auprobe;
+
 	struct return_instance		*return_instances;
 	unsigned int			depth;
 };
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 99be2adedbc0..6e22e4d80f1e 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -2082,6 +2082,7 @@ static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
 	bool need_prep = false; /* prepare return uprobe, when needed */
 
 	down_read(&uprobe->register_rwsem);
+	current->utask->auprobe = &uprobe->arch;
 	for (uc = uprobe->consumers; uc; uc = uc->next) {
 		int rc = 0;
 
@@ -2096,6 +2097,7 @@ static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
 
 		remove &= rc;
 	}
+	current->utask->auprobe = NULL;
 
 	if (need_prep && !remove)
 		prepare_uretprobe(uprobe, regs); /* put bp at return */
-- 
2.43.0


