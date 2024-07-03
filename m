Return-Path: <bpf+bounces-33726-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8324E92514C
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 06:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69E4AB28260
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 04:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715063A8D2;
	Wed,  3 Jul 2024 04:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQ7hiiGM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AA7173336;
	Wed,  3 Jul 2024 04:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719979331; cv=none; b=kY3qLA30yDqA/pkIINpoZfg0buikrgukpYcaNCxPoJz+/fFIXmGxcSkt+yQ7Co6sK2gVvLhlKR8a6ejtzyChovSscjwhoHuvn0iVbAV9Cs4I4AtJQz6yfn0igLJOFtHMuRYo49iBvFUC41WpAtvvMxsKh+t9XptNWLSi8ZGl74M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719979331; c=relaxed/simple;
	bh=u0iCOuCZAxX0T/vowtgKwsMPutCav4tuU4WhWrKFBaI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kMxhIv/en8y0nrwjSuowctNs+tL9QK1WENi3QRo4pMxt1MYsFanHLL3fEfhWG+9YE7BDgkFWOXq96QVmkJL95diJfb/xN8Vi9foPf3GGldqdtviQQLz7qv3rClwSx51hK0+aJDmPES2ib1RmjfWMKaRmkPsnTpTt0v3QfdMLuos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fQ7hiiGM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D292C32781;
	Wed,  3 Jul 2024 04:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719979330;
	bh=u0iCOuCZAxX0T/vowtgKwsMPutCav4tuU4WhWrKFBaI=;
	h=From:To:Cc:Subject:Date:From;
	b=fQ7hiiGMdOkow255dgSmxQeGn9iW2CynZML9fhABtvjestiY7HKO2jeI3H4SnSjSI
	 F3Yd582XUH2LEpasl8VIjishi5Q+Na8qDT35FjR0JT8jQC8y+adBgRq1hhbDdAboTU
	 xuTAZW7rqLV4FHBHcZhQ5AZ+X0lnXFc9FCL31w/FEO12+pBVzjBq64ZYW8l9+5MOS3
	 VtHplGvN4lfR6TKjhBvSHpKReW8y7JanVpWwO9nNNCfS8pYthk+6Uu2IdoftBi3eWc
	 0mZ4acSzRlnDVOzltyZPF68yWKwavEc3X8N7OywrBIRd1ZE03avSEpn3scmvkxlFAP
	 FQFumobtj/h/w==
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
Subject: [PATCH v3] perf,x86: avoid missing caller address in stack traces captured in uprobe
Date: Tue,  2 Jul 2024 21:02:03 -0700
Message-ID: <20240703040203.3368505-1-andrii@kernel.org>
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

We also check for `endbr64` (for 64-bit modes) as another common pattern
for function entry, as suggested by Josh Poimboeuf. Even if we get this
wrong sometimes for uprobes attached not at the function entry, it's OK
because stack trace will still be overall meaningful, just with one
extra bogus entry. If we don't detect this, we end up with guaranteed to
be missing caller function entry in the stack trace, which is worse
overall.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
v2->v3:
  - added endr64 detection and extracted heuristics into a function (Josh);
v1->v2:
  - use native unsigned long for ret_addr (Peter);
  - add same logic for compat logic in perf_callchain_user32 (Peter).

 arch/x86/events/core.c  | 56 +++++++++++++++++++++++++++++++++++++++++
 include/linux/uprobes.h |  2 ++
 kernel/events/uprobes.c |  2 ++
 3 files changed, 60 insertions(+)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 5b0dd07b1ef1..2174a9d2173e 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2813,6 +2813,31 @@ static unsigned long get_segment_base(unsigned int segment)
 	return get_desc_base(desc);
 }
 
+#ifdef CONFIG_UPROBES
+/*
+ * Heuristic-based check if uprobe is installed at the function entry.
+ *
+ * Under assumption of user code being compiled with frame pointers,
+ * `push %rbp/%ebp` is a good indicator that we indeed are.
+ *
+ * Similarly, `endbr64` (assuming 64-bit mode) is also a common pattern.
+ * If we get this wrong, captured stack trace might have one extra bogus
+ * entry, but the rest of stack trace will still be meaningful.
+ */
+static bool is_uprobe_at_func_entry(struct pt_regs *regs, struct arch_uprobe *auprobe)
+{
+	if (!auprobe)
+		return false;
+	/* push %rbp/%ebp */
+	if (auprobe->insn[0] == 0x55)
+		return true;
+	/* endbr64 (64-bit only) */
+	if (user_64bit_mode(regs) && *(u32 *)auprobe->insn == 0xfa1e0ff3)
+		return true;
+	return false;
+}
+#endif
+
 #ifdef CONFIG_IA32_EMULATION
 
 #include <linux/compat.h>
@@ -2833,6 +2858,18 @@ perf_callchain_user32(struct pt_regs *regs, struct perf_callchain_entry_ctx *ent
 
 	fp = compat_ptr(ss_base + regs->bp);
 	pagefault_disable();
+
+#ifdef CONFIG_UPROBES
+	/* see perf_callchain_user() below for why we do this */
+	if (current->utask) {
+		u32 ret_addr;
+
+		if (is_uprobe_at_func_entry(regs, current->utask->auprobe) &&
+		    !__get_user(ret_addr, (const u32 __user *)regs->sp))
+			perf_callchain_store(entry, ret_addr);
+	}
+#endif
+
 	while (entry->nr < entry->max_stack) {
 		if (!valid_user_frame(fp, sizeof(frame)))
 			break;
@@ -2884,6 +2921,25 @@ perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs
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
+		unsigned long ret_addr;
+
+		if (is_uprobe_at_func_entry(regs, current->utask->auprobe) &&
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


