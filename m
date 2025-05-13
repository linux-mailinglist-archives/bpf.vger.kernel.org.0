Return-Path: <bpf+bounces-58150-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2E8AB5F7E
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 00:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEF7419E7A88
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 22:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C809421A433;
	Tue, 13 May 2025 22:35:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB03213E67;
	Tue, 13 May 2025 22:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747175726; cv=none; b=fgLO9+42TF3uuFUTu24G2oUb6tfgItLqHsaHncxSmsnABcpT4HXauS0eM9759M76RTKvxlRCRdrNeoZJ/1+eAcAE3KoDY4uTmDfHSDZ0uKBHZo48F3epNoe/Ncs6OekOG/G6qomyan/TODGsnx0D0ZoT2r517S2ZhUNizoDMIk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747175726; c=relaxed/simple;
	bh=JTFH4J/aPfmXUm6zG2FJR1h1yEhf4M7031l6ypEpMj0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=B7gPDD+6Lfc89tW3JieLaFOvPPaeTC7xtkm5cKzqnXlm5Fq6cTV4ji3Nl5OirZ/aOzfx5Zz6W74UkPPF2sfI15vQ8CLEc/Wr6m5Rvbp4bIZVg+oMNjKpjC9pgcY7wML372BlOcPAE5sC7uUGom03eR+lcLVb9TLouagVUVw1eQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2DCFC4CEEF;
	Tue, 13 May 2025 22:35:25 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uEyE3-00000004sb6-3GTf;
	Tue, 13 May 2025 18:35:51 -0400
Message-ID: <20250513223551.628576711@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 13 May 2025 18:34:39 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org,
 x86@kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v9 04/13] perf/x86: Rename and move get_segment_base() and make it global
References: <20250513223435.636200356@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Josh Poimboeuf <jpoimboe@kernel.org>

get_segment_base() will be used by the unwind_user code, so make it
global and rename it so it doesn't conflict with a KVM function of the
same name.

As the function is no longer specific to perf, move it to ptrace.c as that
seems to be a better location for a generic function like this.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 arch/x86/events/core.c        | 44 ++++-------------------------------
 arch/x86/include/asm/ptrace.h |  2 ++
 arch/x86/kernel/ptrace.c      | 38 ++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 39 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 2e10dcf897c5..cc6329235b68 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -43,6 +43,7 @@
 #include <asm/ldt.h>
 #include <asm/unwind.h>
 #include <asm/uprobes.h>
+#include <asm/ptrace.h>
 #include <asm/ibt.h>
 
 #include "perf_event.h"
@@ -2809,41 +2810,6 @@ valid_user_frame(const void __user *fp, unsigned long size)
 	return __access_ok(fp, size);
 }
 
-static unsigned long get_segment_base(unsigned int segment)
-{
-	struct desc_struct *desc;
-	unsigned int idx = segment >> 3;
-
-	if ((segment & SEGMENT_TI_MASK) == SEGMENT_LDT) {
-#ifdef CONFIG_MODIFY_LDT_SYSCALL
-		struct ldt_struct *ldt;
-
-		/*
-		 * If we're not in a valid context with a real (not just lazy)
-		 * user mm, then don't even try.
-		 */
-		if (!nmi_uaccess_okay())
-			return 0;
-
-		/* IRQs are off, so this synchronizes with smp_store_release */
-		ldt = smp_load_acquire(&current->mm->context.ldt);
-		if (!ldt || idx >= ldt->nr_entries)
-			return 0;
-
-		desc = &ldt->entries[idx];
-#else
-		return 0;
-#endif
-	} else {
-		if (idx >= GDT_ENTRIES)
-			return 0;
-
-		desc = raw_cpu_ptr(gdt_page.gdt) + idx;
-	}
-
-	return get_desc_base(desc);
-}
-
 #ifdef CONFIG_UPROBES
 /*
  * Heuristic-based check if uprobe is installed at the function entry.
@@ -2900,8 +2866,8 @@ perf_callchain_user32(struct pt_regs *regs, struct perf_callchain_entry_ctx *ent
 	if (user_64bit_mode(regs))
 		return 0;
 
-	cs_base = get_segment_base(regs->cs);
-	ss_base = get_segment_base(regs->ss);
+	cs_base = segment_base_address(regs->cs);
+	ss_base = segment_base_address(regs->ss);
 
 	fp = compat_ptr(ss_base + regs->bp);
 	pagefault_disable();
@@ -3020,11 +2986,11 @@ static unsigned long code_segment_base(struct pt_regs *regs)
 		return 0x10 * regs->cs;
 
 	if (user_mode(regs) && regs->cs != __USER_CS)
-		return get_segment_base(regs->cs);
+		return segment_base_address(regs->cs);
 #else
 	if (user_mode(regs) && !user_64bit_mode(regs) &&
 	    regs->cs != __USER32_CS)
-		return get_segment_base(regs->cs);
+		return segment_base_address(regs->cs);
 #endif
 	return 0;
 }
diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
index 50f75467f73d..59357ec98e52 100644
--- a/arch/x86/include/asm/ptrace.h
+++ b/arch/x86/include/asm/ptrace.h
@@ -314,6 +314,8 @@ static __always_inline bool regs_irqs_disabled(struct pt_regs *regs)
 	return !(regs->flags & X86_EFLAGS_IF);
 }
 
+unsigned long segment_base_address(unsigned int segment);
+
 /* Query offset/name of register from its name/offset */
 extern int regs_query_register_offset(const char *name);
 extern const char *regs_query_register_name(unsigned int offset);
diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index 095f04bdabdc..81353a09701b 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -41,6 +41,7 @@
 #include <asm/syscall.h>
 #include <asm/fsgsbase.h>
 #include <asm/io_bitmap.h>
+#include <asm/mmu_context.h>
 
 #include "tls.h"
 
@@ -339,6 +340,43 @@ static int set_segment_reg(struct task_struct *task,
 
 #endif	/* CONFIG_X86_32 */
 
+unsigned long segment_base_address(unsigned int segment)
+{
+	struct desc_struct *desc;
+	unsigned int idx = segment >> 3;
+
+	lockdep_assert_irqs_disabled();
+
+	if ((segment & SEGMENT_TI_MASK) == SEGMENT_LDT) {
+#ifdef CONFIG_MODIFY_LDT_SYSCALL
+		struct ldt_struct *ldt;
+
+		/*
+		 * If we're not in a valid context with a real (not just lazy)
+		 * user mm, then don't even try.
+		 */
+		if (!nmi_uaccess_okay())
+			return 0;
+
+		/* IRQs are off, so this synchronizes with smp_store_release */
+		ldt = smp_load_acquire(&current->mm->context.ldt);
+		if (!ldt || idx >= ldt->nr_entries)
+			return 0;
+
+		desc = &ldt->entries[idx];
+#else
+		return 0;
+#endif
+	} else {
+		if (idx >= GDT_ENTRIES)
+			return 0;
+
+		desc = raw_cpu_ptr(gdt_page.gdt) + idx;
+	}
+
+	return get_desc_base(desc);
+}
+
 static unsigned long get_flags(struct task_struct *task)
 {
 	unsigned long retval = task_pt_regs(task)->flags;
-- 
2.47.2



