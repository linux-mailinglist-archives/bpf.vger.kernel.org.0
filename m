Return-Path: <bpf+bounces-60276-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC76CAD47B1
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 03:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBCAE3A9B89
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 01:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1221A9B4C;
	Wed, 11 Jun 2025 01:03:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF41A1B808;
	Wed, 11 Jun 2025 01:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749603790; cv=none; b=VUVVkseYC6Szss/6bE1zxZM2sSw69qXnjhVSb1HOlHf2dKZBvyu4/14ilU+lHuoqlDcqf2tO7RUrFoWSvMhf0bkJfdWANbLo0FXFiFRf/fgXv6lBvfH6hu3qRO/jZ7bFMwGKHT8ocg5QW+1FsOVlTgkacnxGZTJhpivZjSgX7Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749603790; c=relaxed/simple;
	bh=4vDOBIoUHUiC3BHSTDobiE9oNjdxoZfAGrZ2BlXpfY4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=pFuPkZk/QEF387nCAOJ9mCyk2FwLJZX7omSjRIlI/UiFaski38QcMVjgEx/jfNPT/f9Zh49SwvPPTLlNHwFtL+7pdjYlpVYWkyIaEcZ/zoP8SMovF6GUbFQP2emUnfl8He02s+oJ2/ExRTGwEUMkojp9swQqeiFJWPD2cJOrCe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 276CD121505;
	Wed, 11 Jun 2025 01:03:01 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: nevets@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id 0EA2C2F;
	Wed, 11 Jun 2025 01:02:58 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uP9tG-00000000vDc-0QqN;
	Tue, 10 Jun 2025 21:04:30 -0400
Message-ID: <20250611010429.957013350@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 10 Jun 2025 20:54:34 -0400
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
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v10 13/14] perf/x86: Rename and move get_segment_base() and make it global
References: <20250611005421.144238328@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 0EA2C2F
X-Stat-Signature: 3am47d7tteeu7iiet7kfxk6jwxybttkb
X-Session-Marker: 6E657665747340676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18DlY18f07S9uesh6GrlFyqx0guSIaJxXw=
X-HE-Tag: 1749603778-889697
X-HE-Meta: U2FsdGVkX1/vbJZAAHLOO3kSSGwV5V40UnVUbMFMNya1p047qc4+gHPfm/V68yyGPRGU94TRlCOLCUl0jh/obqixATiwzlq858R/nS1pTIaangx0T5Yb2APEoN/GRz+5V+Eqhn9IbYNIDlrQZh95YIHAFjmtfusgMzDdgoFp3WxqmSV2BshcyF6g6tcq5VZuy/KbXix71gZrRMOXMGxqfA+a/1hhU16OGSU69t+zE8pJo9eIj3hc3eA2Z/prRUTj2ForrQatQgKu6TkRP0lQsys3D6gHiTL/npKA+Z6Gc6H9lPxTRaTrBPqQBKEvGnyn+fh0qhINfKMiAD89yqEwq6L0JPw2O2V4z4mxVNwhfIfQ4UcE1+sQU8v1a2lNGYb5nZp9G2v2of4DDtfd68gU74yocOMuAQjRIu4BOBzWsqA=

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



