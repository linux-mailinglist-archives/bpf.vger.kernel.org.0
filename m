Return-Path: <bpf+bounces-61611-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FE5AE917B
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 00:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A9D8189E211
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 22:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385322FCE37;
	Wed, 25 Jun 2025 22:57:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E495B2F49FC;
	Wed, 25 Jun 2025 22:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750892227; cv=none; b=L7MhCFxLwTAgadMA9Wmi2qmugAJcDkrsx2vPgS3/HPP0iEdCSSUYTI/iNQJPzhCmIX7HyPTnZJtJqx2F3VgTVdVz845Ucy7MSJfIUDy7ogskTQFev6YMTYibDDLyYF/WTKGyQUjCDURVzCE6j/f5SXsaBecMeU5I0Z+GH7o/8SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750892227; c=relaxed/simple;
	bh=4vDOBIoUHUiC3BHSTDobiE9oNjdxoZfAGrZ2BlXpfY4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=kF5tYh8JoVtjd4lFh/5zjS5+joadfKSNuaDzTBGFpiDV5Pda52mBTX/Tbk2JAevN5F+zeCcZSM93WKUUUFG2IHw0Wu071ifElBzgPVRmO5NS2eEou6/08hfn/40PJ6oJv3/y99/sEte7k2GI1bxnSKHTdRgAtopYirHZ5vnoYJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 2BE21C050D;
	Wed, 25 Jun 2025 22:56:55 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: nevets@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id E92FE2E;
	Wed, 25 Jun 2025 22:56:51 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uUZ3N-000000043jC-0hQc;
	Wed, 25 Jun 2025 18:57:17 -0400
Message-ID: <20250625225717.016385736@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 25 Jun 2025 18:56:13 -0400
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
 Andrii Nakryiko <andrii@kernel.org>,
 Indu Bhagat <indu.bhagat@oracle.com>,
 "Jose E. Marchesi" <jemarch@gnu.org>,
 Beau Belgrave <beaub@linux.microsoft.com>,
 Jens Remus <jremus@linux.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v11 13/14] perf/x86: Rename and move get_segment_base() and make it global
References: <20250625225600.555017347@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Stat-Signature: emrupgxgq1rapmeio3dk49kxngjxrbe5
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: E92FE2E
X-Session-Marker: 6E657665747340676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19GfgKJWxcrDJRgBFxTqvaBoBbdblVc8GU=
X-HE-Tag: 1750892211-928430
X-HE-Meta: U2FsdGVkX18KJlGFqh5T1dVmBut0o+O7x3cW0+8YhZ/RxHEb+o7IHnGnIpghDKoHXtxhlpbeeWJx63yi9VX6n68dwQ1wHZj16C+3EV4bHy04IpuMMYur1oqfX583VDymNylXa4rzgNU/Fm5IeiEUu52KUuBQRbRw69VkEZhoY6vTaUHCJuHrTrWBCFVdE9CuodUFIBjokTrqD2Ok4XvRNDFk/qSQX1PBgPTH12/qQiMs4/ozQ6I9rU++g1s9sDSjI+bugBrrJ8OE7nRNJ7VC2oCiSDSEm7N27ihT63qMI5vz8+QIqRbbN9xOMGj69AoYHAD2ia88/o3+TfzdCMU3+HYx/9tjov9vdHFirI1AVniZ4xJxSV+ia5kAmpHuGmHh9RspvdD0kkCfInTNpmbxJOSs0EG81z8AiDOX0v4/U6w=

From: Josh Poimboeuf <jpoimboe@kernel.org>

get_segment_base() will be used by the unwind_user code, so make it
global and rename it to segment_base_address() so it doesn't conflict with
a KVM function of the same name.

As the function is no longer specific to perf, move it to ptrace.c as that
seems to be a better location for a generic function like this.

Also add a lockdep_assert_irqs_disabled() to make sure it's always called
with interrupts disabled.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 arch/x86/events/core.c        | 44 ++++-------------------------------
 arch/x86/include/asm/ptrace.h |  2 ++
 arch/x86/kernel/ptrace.c      | 38 ++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 39 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 7610f26dfbd9..2f2ec84f2a14 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -43,6 +43,7 @@
 #include <asm/ldt.h>
 #include <asm/unwind.h>
 #include <asm/uprobes.h>
+#include <asm/ptrace.h>
 #include <asm/ibt.h>
 
 #include "perf_event.h"
@@ -2808,41 +2809,6 @@ valid_user_frame(const void __user *fp, unsigned long size)
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
@@ -2899,8 +2865,8 @@ perf_callchain_user32(struct pt_regs *regs, struct perf_callchain_entry_ctx *ent
 	if (user_64bit_mode(regs))
 		return 0;
 
-	cs_base = get_segment_base(regs->cs);
-	ss_base = get_segment_base(regs->ss);
+	cs_base = segment_base_address(regs->cs);
+	ss_base = segment_base_address(regs->ss);
 
 	fp = compat_ptr(ss_base + regs->bp);
 	pagefault_disable();
@@ -3019,11 +2985,11 @@ static unsigned long code_segment_base(struct pt_regs *regs)
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



