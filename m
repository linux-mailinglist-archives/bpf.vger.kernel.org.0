Return-Path: <bpf+bounces-61922-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67255AEEB80
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 02:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DCE6443572
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 00:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130A8245022;
	Tue,  1 Jul 2025 00:54:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CA91F4285;
	Tue,  1 Jul 2025 00:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751331270; cv=none; b=AKeB+mLcxirAu75Cx7jvoCrrQ3xziyjOc+O3TSRFGE+oJEYMMAXbqT6nch6xptQ599+xHPb53gjXED3PGqEqaEB7evjRhN0jgc1SrsJHKNHR0Spqqq4CLnMtcmcE2Gj1BlotZdso7UEOI7Bii9V++lWGluyk0ZqsUrnRrczYFKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751331270; c=relaxed/simple;
	bh=op+FuZOzazd2dtQp7uMh4eI4DQXFaxXx36SQU+aaXy0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=SnrBccTc3X3X/EgBCD+oeQ/BdJZWNdgidsRNz2efAMf9hmHD/Kc9zfLpoLnuBnC5iwnYSswVhBEC1qREDzIcIGcuiEBITp997cdvj9RNTuW+WAN5ir2WuwwMwKjGhbllJHol/r/YIT/U9ImADG52zb3C8QhTWpjSmDJn2X+HNg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id A3E881A0201;
	Tue,  1 Jul 2025 00:54:19 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: nevets@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id 4397017;
	Tue,  1 Jul 2025 00:54:16 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uWPGv-00000007Nl6-0Kb1;
	Mon, 30 Jun 2025 20:54:53 -0400
Message-ID: <20250701005452.929734016@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 30 Jun 2025 20:53:35 -0400
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
 Jens Axboe <axboe@kernel.dk>,
 Florian Weimer <fweimer@redhat.com>
Subject: [PATCH v12 14/14] unwind_user/x86: Enable compat mode frame pointer unwinding on x86
References: <20250701005321.942306427@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Queue-Id: 4397017
X-Stat-Signature: b9jgaho3hjmz3kfbnskcmpzacmze3c33
X-Rspamd-Server: rspamout06
X-Session-Marker: 6E657665747340676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18AXorUSuczDz+HuuRMhJGSPJTxiyn5tq8=
X-HE-Tag: 1751331256-670172
X-HE-Meta: U2FsdGVkX1887Dux80qxXj7AM9ibFWbSB2Heg7j56D8F6xHlHUduXfoD0xR0W+1sgaEd60fN9TqzYkb+fJeT6YGFw++fUs2vDNHCVe4Uqwsf7i+TZBQty9rx4lcz++RN40H/AlzxM/lBhGWdQIxrRVrsSyTbCatVMRkkvPXvjwIdlvf6L8SVZe/kq9zjefrknJk0pugzujRl1Vz4j+MNuZVlxg0d1x5JatC0xaRomvr8JxZQCwuNfPScdOo8yXsp4cXk2bTZOe8oMe6QRkCSmx5hj0Dqv5ZdfJ5/ATM6HZ9RR2SIBwUnpkIf0JVaYbd19XA9+220H1EnB8GU6BqOhYhIHI+pGYtHTEtlPkCN6U0xm7EdQiroycjWm0oPz2ho8DElRN5A2tOsV/mTtVEGGapUxsUMcj74qTnWLSAeXp4=

From: Josh Poimboeuf <jpoimboe@kernel.org>

Use ARCH_INIT_USER_COMPAT_FP_FRAME to describe how frame pointers are
unwound on x86, and implement the hooks needed to add the segment base
addresses.  Enable HAVE_UNWIND_USER_COMPAT_FP if the system has compat
mode compiled in.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v11: https://lore.kernel.org/20250625225717.187191105@goodmis.org

- Fix header macro protection name to include X86 (Ingo Molnar)

- Use insn_get_seg_base() to get segment registers instead of using the
  function perf uses and making it global. Also as that function doesn't
  look to have a requirement to disable interrupts, the scoped_guard(irqsave)
  is removed.

- Check return code of insn_get_seg_base() for the unlikely event that it
  returns invalid (-1).

- Moved arch_unwind_user_init() into stacktrace.c as to use
  insn_get_seg_base(), it must include insn-eval.h that defines
  pt_regs_offset(), but that is also used in the perf generic code as an
  array and if it is included in the header file, it causes a build
  conflict.

- Update the comments that explain arch_unwind_user_init/next that a macro
  needs to be defined with those names if they are going to be used.

 arch/x86/Kconfig                         |  1 +
 arch/x86/include/asm/unwind_user.h       | 31 ++++++++++++++++++++++++
 arch/x86/include/asm/unwind_user_types.h | 17 +++++++++++++
 arch/x86/kernel/stacktrace.c             | 28 +++++++++++++++++++++
 include/linux/unwind_user.h              | 20 +++++++++++++++
 kernel/unwind/user.c                     |  4 +++
 6 files changed, 101 insertions(+)
 create mode 100644 arch/x86/include/asm/unwind_user_types.h

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 5862433c81e1..17d4094c821b 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -302,6 +302,7 @@ config X86
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_UACCESS_VALIDATION		if HAVE_OBJTOOL
 	select HAVE_UNSTABLE_SCHED_CLOCK
+	select HAVE_UNWIND_USER_COMPAT_FP	if IA32_EMULATION
 	select HAVE_UNWIND_USER_FP		if X86_64
 	select HAVE_USER_RETURN_NOTIFIER
 	select HAVE_GENERIC_VDSO
diff --git a/arch/x86/include/asm/unwind_user.h b/arch/x86/include/asm/unwind_user.h
index 8597857bf896..19634a73612d 100644
--- a/arch/x86/include/asm/unwind_user.h
+++ b/arch/x86/include/asm/unwind_user.h
@@ -2,10 +2,41 @@
 #ifndef _ASM_X86_UNWIND_USER_H
 #define _ASM_X86_UNWIND_USER_H
 
+#include <linux/unwind_user_types.h>
+
 #define ARCH_INIT_USER_FP_FRAME							\
 	.cfa_off	= (s32)sizeof(long) *  2,				\
 	.ra_off		= (s32)sizeof(long) * -1,				\
 	.fp_off		= (s32)sizeof(long) * -2,				\
 	.use_fp		= true,
 
+#ifdef CONFIG_IA32_EMULATION
+
+#define ARCH_INIT_USER_COMPAT_FP_FRAME						\
+	.cfa_off	= (s32)sizeof(u32)  *  2,				\
+	.ra_off		= (s32)sizeof(u32)  * -1,				\
+	.fp_off		= (s32)sizeof(u32)  * -2,				\
+	.use_fp		= true,
+
+#define in_compat_mode(regs) !user_64bit_mode(regs)
+
+void arch_unwind_user_init(struct unwind_user_state *state,
+			   struct pt_regs *regs);
+
+static inline void arch_unwind_user_next(struct unwind_user_state *state)
+{
+	if (state->type != UNWIND_USER_TYPE_COMPAT_FP)
+		return;
+
+	state->ip += state->arch.cs_base;
+	state->fp += state->arch.ss_base;
+}
+
+#define arch_unwind_user_init arch_unwind_user_init
+#define arch_unwind_user_next arch_unwind_user_next
+
+#endif /* CONFIG_IA32_EMULATION */
+
+#include <asm-generic/unwind_user.h>
+
 #endif /* _ASM_X86_UNWIND_USER_H */
diff --git a/arch/x86/include/asm/unwind_user_types.h b/arch/x86/include/asm/unwind_user_types.h
new file mode 100644
index 000000000000..f93d535f900e
--- /dev/null
+++ b/arch/x86/include/asm/unwind_user_types.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_UNWIND_USER_TYPES_H
+#define _ASM_X86_UNWIND_USER_TYPES_H
+
+#ifdef CONFIG_IA32_EMULATION
+
+struct arch_unwind_user_state {
+	unsigned long ss_base;
+	unsigned long cs_base;
+};
+#define arch_unwind_user_state arch_unwind_user_state
+
+#endif /* CONFIG_IA32_EMULATION */
+
+#include <asm-generic/unwind_user_types.h>
+
+#endif /* _ASM_UNWIND_USER_TYPES_H */
diff --git a/arch/x86/kernel/stacktrace.c b/arch/x86/kernel/stacktrace.c
index ee117fcf46ed..8ef9d8c71df9 100644
--- a/arch/x86/kernel/stacktrace.c
+++ b/arch/x86/kernel/stacktrace.c
@@ -9,7 +9,10 @@
 #include <linux/stacktrace.h>
 #include <linux/export.h>
 #include <linux/uaccess.h>
+#include <asm/unwind_user.h>
 #include <asm/stacktrace.h>
+#include <asm/insn.h>
+#include <asm/insn-eval.h>
 #include <asm/unwind.h>
 
 void arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
@@ -128,3 +131,28 @@ void arch_stack_walk_user(stack_trace_consume_fn consume_entry, void *cookie,
 	}
 }
 
+#ifdef CONFIG_IA32_EMULATION
+void arch_unwind_user_init(struct unwind_user_state *state,
+			   struct pt_regs *regs)
+{
+	unsigned long cs_base, ss_base;
+
+	if (state->type != UNWIND_USER_TYPE_COMPAT_FP)
+		return;
+
+	cs_base = insn_get_seg_base(regs, INAT_SEG_REG_CS);
+	ss_base = insn_get_seg_base(regs, INAT_SEG_REG_SS);
+
+	if (cs_base == -1)
+		cs_base = 0;
+	if (ss_base == -1)
+		ss_base = 0;
+
+	state->arch.cs_base = cs_base;
+	state->arch.ss_base = ss_base;
+
+	state->ip += cs_base;
+	state->sp += ss_base;
+	state->fp += ss_base;
+}
+#endif /* CONFIG_IA32_EMULATION */
diff --git a/include/linux/unwind_user.h b/include/linux/unwind_user.h
index ac007363820a..b57b68215c6f 100644
--- a/include/linux/unwind_user.h
+++ b/include/linux/unwind_user.h
@@ -14,6 +14,26 @@
  #define in_compat_mode(regs) false
 #endif
 
+/*
+ * If an architecture needs to initialize the state for a specific
+ * reason, for example, it may need to do something different
+ * in compat mode, it can define a macro named arch_unwind_user_init
+ * with the name of the function that will perform this initialization.
+ */
+#ifndef arch_unwind_user_init
+static inline void arch_unwind_user_init(struct unwind_user_state *state, struct pt_regs *reg) {}
+#endif
+
+/*
+ * If an architecture requires some more updates to the state between
+ * stack frames, it can define a macro named arch_unwind_user_next
+ * with the name of the function that will update the state between
+ * reading stack frames during the user space stack walk.
+ */
+#ifndef arch_unwind_user_next
+static inline void arch_unwind_user_next(struct unwind_user_state *state) {}
+#endif
+
 int unwind_user_start(struct unwind_user_state *state);
 int unwind_user_next(struct unwind_user_state *state);
 
diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
index 3a0ac4346f5b..2bb7995c3f23 100644
--- a/kernel/unwind/user.c
+++ b/kernel/unwind/user.c
@@ -72,6 +72,8 @@ int unwind_user_next(struct unwind_user_state *state)
 	if (frame->fp_off)
 		state->fp = fp;
 
+	arch_unwind_user_next(state);
+
 	return 0;
 
 done:
@@ -101,6 +103,8 @@ int unwind_user_start(struct unwind_user_state *state)
 	state->sp = user_stack_pointer(regs);
 	state->fp = frame_pointer(regs);
 
+	arch_unwind_user_init(state, regs);
+
 	return 0;
 }
 
-- 
2.47.2



