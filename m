Return-Path: <bpf+bounces-51311-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F18A331F2
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 23:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EC283A2270
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 22:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38997203718;
	Wed, 12 Feb 2025 22:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mNSZTm9B"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18EF1EBA0C;
	Wed, 12 Feb 2025 22:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739397880; cv=none; b=BdwQbSg0wScJRJkrhiiHSvxTLe5aBTDSpZvroh/7OOqz9bM3+3td9sV0UVAgPt2SbZZItUx4vFtV8tiNHEe4bul8KwKPubOJg3RwkyA8xUQjVzy8AsL0Hic/SkJlz7sXYNek7zekvjh6+EmjJQ5mcxuO79RTj0nSIYZxFDSF9MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739397880; c=relaxed/simple;
	bh=CcYVxa9xyH1ghrceusX7zFgvExtcGhzL7hteTpBaJGA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZsPSRzj/mPGaMXBOgkCfuhmL6LdxyjYw/VceHxPZtXHS7ySoMHcxrNTlMHZC3AgABab1JoP8oUneLNDfDlp7eCHsNcDz3DVtTCR9yUeIfR00Cw+zEB7dtPJIQLk+uUIxnmQXIQpQc1J1Xxg13Wl4dvT+91fvDw9mHWiGz0bNRGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mNSZTm9B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B002C4CEDF;
	Wed, 12 Feb 2025 22:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739397880;
	bh=CcYVxa9xyH1ghrceusX7zFgvExtcGhzL7hteTpBaJGA=;
	h=From:To:Cc:Subject:Date:From;
	b=mNSZTm9B6IiEXhUT8QVroFXKRMRoNK/RD8891uUZFx6GA/o21oCSsPEmWqKZtrq7e
	 FPwCaxcxmolHuV8wrAgpVMZszhYwJaTlh9FJVVsW/YcplPWn8fY4iRHP14GDd6ewVx
	 DBCE3LSPjfA1Ba2dlq7gY/oiP/zd8F5uMFbAoWtPvdWpQcEsjEcGERLrRuOtjGAubT
	 opNwOQ5slglV6IBmHmxo8isP71YQsBv8jObDYFw7ZmaJTw635q69FGpoYxxGq1PCD/
	 QqoiYWMf7XBBxRJkC7rVaMxZLKl/AW+YFgBbj3Vbosn3mePEC62PPQEOjWtCUZ9pwv
	 kx7o9T7gsFbqg==
From: Jiri Olsa <jolsa@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Eyal Birger <eyal.birger@gmail.com>,
	stable@vger.kernel.org,
	Jann Horn <jannh@google.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	x86@kernel.org,
	bpf@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Deepak Gupta <debug@rivosinc.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCHv3 perf/core] uprobes: Harden uretprobe syscall trampoline check
Date: Wed, 12 Feb 2025 23:04:33 +0100
Message-ID: <20250212220433.3624297-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jann reported [1] possible issue when trampoline_check_ip returns
address near the bottom of the address space that is allowed to
call into the syscall if uretprobes are not set up.

Though the mmap minimum address restrictions will typically prevent
creating mappings there, let's make sure uretprobe syscall checks
for that.

[1] https://lore.kernel.org/bpf/202502081235.5A6F352985@keescook/T/#m9d416df341b8fbc11737dacbcd29f0054413cbbf
Cc: Kees Cook <kees@kernel.org>
Cc: Eyal Birger <eyal.birger@gmail.com>
Cc: stable@vger.kernel.org
Fixes: ff474a78cef5 ("uprobe: Add uretprobe syscall to speed up return probe")
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Reported-by: Jann Horn <jannh@google.com>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Reviewed-by: Kees Cook <kees@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
v3 changes:
 - used ~0UL instead of -1 [Alexei]
 - used UPROBE_NO_TRAMPOLINE_VADDR in uprobe_get_trampoline_vaddr [Masami]
 - added unlikely [Andrii]
 - I kept the review/ack tags, because I think the change is basically
   the same, please scream otherwise

 arch/x86/kernel/uprobes.c | 14 +++++++++-----
 include/linux/uprobes.h   |  2 ++
 kernel/events/uprobes.c   |  2 +-
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 5a952c5ea66b..9194695662b2 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -357,19 +357,23 @@ void *arch_uprobe_trampoline(unsigned long *psize)
 	return &insn;
 }
 
-static unsigned long trampoline_check_ip(void)
+static unsigned long trampoline_check_ip(unsigned long tramp)
 {
-	unsigned long tramp = uprobe_get_trampoline_vaddr();
-
 	return tramp + (uretprobe_syscall_check - uretprobe_trampoline_entry);
 }
 
 SYSCALL_DEFINE0(uretprobe)
 {
 	struct pt_regs *regs = task_pt_regs(current);
-	unsigned long err, ip, sp, r11_cx_ax[3];
+	unsigned long err, ip, sp, r11_cx_ax[3], tramp;
+
+	/* If there's no trampoline, we are called from wrong place. */
+	tramp = uprobe_get_trampoline_vaddr();
+	if (unlikely(tramp == UPROBE_NO_TRAMPOLINE_VADDR))
+		goto sigill;
 
-	if (regs->ip != trampoline_check_ip())
+	/* Make sure the ip matches the only allowed sys_uretprobe caller. */
+	if (unlikely(regs->ip != trampoline_check_ip(tramp)))
 		goto sigill;
 
 	err = copy_from_user(r11_cx_ax, (void __user *)regs->sp, sizeof(r11_cx_ax));
diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index a40efdda9052..2e46b69ff0a6 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -39,6 +39,8 @@ struct page;
 
 #define MAX_URETPROBE_DEPTH		64
 
+#define UPROBE_NO_TRAMPOLINE_VADDR	(~0UL)
+
 struct uprobe_consumer {
 	/*
 	 * handler() can return UPROBE_HANDLER_REMOVE to signal the need to
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 597b9e036e5f..c5d6307bc5bc 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -2156,8 +2156,8 @@ void uprobe_copy_process(struct task_struct *t, unsigned long flags)
  */
 unsigned long uprobe_get_trampoline_vaddr(void)
 {
+	unsigned long trampoline_vaddr = UPROBE_NO_TRAMPOLINE_VADDR;
 	struct xol_area *area;
-	unsigned long trampoline_vaddr = -1;
 
 	/* Pairs with xol_add_vma() smp_store_release() */
 	area = READ_ONCE(current->mm->uprobes_state.xol_area); /* ^^^ */
-- 
2.48.1


