Return-Path: <bpf+bounces-33554-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2922591EB44
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 01:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7C0A28343F
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 23:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08EA4172798;
	Mon,  1 Jul 2024 23:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yy9SPmkY"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0DD4779E;
	Mon,  1 Jul 2024 23:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719875444; cv=none; b=UKGsTiDnnDhp/cLtuQ1F4IpJQR/wl2yK5itHqNAfRBwyWF0DQdpfxbmF94hX+kxzSWmx60eulPTVo0izvgsALbOH6ZsMr/NbhVTZSPwzm/GUNtGo1WctWXEQYqd472du09q3KNH/G4OveN4FHBqvfzpwtpoYK/xPSVdMcHTi3TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719875444; c=relaxed/simple;
	bh=Ez+L9dBMWPaMgY0ZHn8Ku3SGrDn4jJArONet3i7gJ3k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qYUQGk2IDzDpwhLZjoZy83aX8Ks892GfR+5m5ACGnF5yZQliWxqkxiJpKapDL3Xoj3JhP6ULRsCx4IWcRtVRDorNEcALlmYpys1B0LOgSGcdLBODgeundM+zDHHfVGNBsQ9r7f1txkf420YjtFHcK/5KdDy/wDZ0Ty8biBW4Eyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yy9SPmkY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E971FC116B1;
	Mon,  1 Jul 2024 23:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719875444;
	bh=Ez+L9dBMWPaMgY0ZHn8Ku3SGrDn4jJArONet3i7gJ3k=;
	h=From:To:Cc:Subject:Date:From;
	b=Yy9SPmkY/k/FYCAWcqf0wAlZgFxQfJUFZGQ0VgOoZDCVJ1uibzumULSmGQUhMPzVH
	 ISPY8I7lwxluNjsGsSWdWRrdJOJZglkwlEtfFWZQitGsETpQmWVV6VzgLQ9cfx7Fid
	 CRVO98oXdQjWGuFwN8LXAc9fwQ2+oL7ZrvtiSykU8pAYzE75bOZqK549pB1y49P8dF
	 O8tuVznKEKVFrFtj+hOp9Fdavmpe9StZMWifeXjyUCHN0HMyRs3+adknQwO54Aud65
	 dUblxjP35TnrDZOKBw82On7TDxWjxDIF/zWFhlZUjs64XguktAicdWs98Ngz6CtyTa
	 3HaafwsT9Kpog==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-trace-kernel@vger.kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: x86@kernel.org,
	peterz@infradead.org,
	mingo@redhat.com,
	tglx@linutronix.de,
	bpf@vger.kernel.org,
	rihams@fb.com,
	linux-perf-users@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH] perf,x86: avoid missing caller address in stack traces captured in uprobe
Date: Mon,  1 Jul 2024 16:10:27 -0700
Message-ID: <20240701231027.61930-1-andrii@kernel.org>
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
instruction being traced. Given entire kernel implementation of user
space stack trace capturing works under assumption that user space code
was compiled with frame pointer register (%rbp) preservation, it seems
pretty reasonable to use this instruction as a strong indicator that
this is the entry to the function. In that case, return address is still
pointed to by %rsp, so we fetch it and add to stack trace before
proceeding to unwind the rest using frame pointer-based logic.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 arch/x86/events/core.c  | 20 ++++++++++++++++++++
 include/linux/uprobes.h |  2 ++
 kernel/events/uprobes.c |  2 ++
 3 files changed, 24 insertions(+)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 5b0dd07b1ef1..82d5570b58ff 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2884,6 +2884,26 @@ perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs
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
+		u64 ret_addr;
+
+		if (auprobe && auprobe->insn[0] == 0x55 /* push %rbp */ &&
+		    !__get_user(ret_addr, (const u64 __user *)regs->sp))
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


