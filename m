Return-Path: <bpf+bounces-62599-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E61F6AFBFE2
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 03:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEE6A4A6A5F
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 01:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9727D225A24;
	Tue,  8 Jul 2025 01:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j0lUt9uB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13955221FC4;
	Tue,  8 Jul 2025 01:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751937840; cv=none; b=uTeSqSfe/tDvTFAzOyDOZeXx70xJBR2Jt5LZw9zvkGZrhIvUDphDrQR0LTkHwB2XihpSmVdNx+RlXX1ReZNeu9ZEZJR3ADSIazY1TzdknE14RjI4hvza91x623fHrsST8wc+6Jy9VTCySoycThDJmESgwovMijWGAt+y2W+M2yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751937840; c=relaxed/simple;
	bh=OTmEBmEDwwr+5i50GFjKWiFV3nOMPMB1tKCDHYcguyM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=CpotaNiH1ihIVN/XWKu1MZW1dwBeWWm1DcXQl7v6tv/u3A0cEs37bBGsggvddVCIl//jBpTNQ+5zHM6ZgKcvnJiQUy8J3C4QUpTZ0ryjzt/acITqe+/Y/41GPBIVFil2X4/3n1tK+pUduKhujVKaOXBa5B72vhzrOBFVgm1CRD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j0lUt9uB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4DC6C4CEF6;
	Tue,  8 Jul 2025 01:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751937840;
	bh=OTmEBmEDwwr+5i50GFjKWiFV3nOMPMB1tKCDHYcguyM=;
	h=Date:From:To:Cc:Subject:References:From;
	b=j0lUt9uBCmNalZZgXZn6WUMBYzGKP9DZ90y8WUfzcQ4pA+oQY/jQghRiohCMVKb3k
	 NUjXRT7HRxdlw5ZhIi6KYvsVRd5huvOrY3EXTvQa8pMmv6NsxvKHCRGIeWLrbQ3MS6
	 bthybsKKnI0m+XCdULIPyohXCbRIT4Rq2KjN4wmM8pc7udhUMDpoGEE8xpIsJlTF5g
	 jy9hjHEV+KfnrN2ksOF7RrI1Wgk4cJe3sh/fH9fikCNg+p7Pr+s1L83qbJywEQuW1+
	 SVuhg97ikp43TNmAlOM2hZtp/ZV3AeN1Hfpy9ephNxzwWlcOQ2tjXVH22DDyRvIJJs
	 +ho2Yv50vsVcA==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uYx3w-00000000Bvx-0ivC;
	Mon, 07 Jul 2025 21:24:00 -0400
Message-ID: <20250708012400.023290498@kernel.org>
User-Agent: quilt/0.68
Date: Mon, 07 Jul 2025 21:22:53 -0400
From: Steven Rostedt <rostedt@kernel.org>
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
 Florian Weimer <fweimer@redhat.com>,
 Sam James <sam@gentoo.org>
Subject: [PATCH v13 14/14] unwind_user/x86: Enable compat mode frame pointer unwinding on x86
References: <20250708012239.268642741@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Josh Poimboeuf <jpoimboe@kernel.org>

Use ARCH_INIT_USER_COMPAT_FP_FRAME to describe how frame pointers are
unwound on x86, and implement the hooks needed to add the segment base
addresses.  Enable HAVE_UNWIND_USER_COMPAT_FP if the system has compat
mode compiled in.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
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
index 834b643afd3a..8a4af0214ecb 100644
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
 int unwind_user(struct unwind_stacktrace *trace, unsigned int max_entries);
 
 #endif /* _LINUX_UNWIND_USER_H */
diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
index 03775191447c..249d9e32fad7 100644
--- a/kernel/unwind/user.c
+++ b/kernel/unwind/user.c
@@ -89,6 +89,8 @@ static int unwind_user_next(struct unwind_user_state *state)
 	if (frame->fp_off)
 		state->fp = fp;
 
+	arch_unwind_user_next(state);
+
 	return 0;
 
 done:
@@ -118,6 +120,8 @@ static int unwind_user_start(struct unwind_user_state *state)
 	state->sp = user_stack_pointer(regs);
 	state->fp = frame_pointer(regs);
 
+	arch_unwind_user_init(state, regs);
+
 	return 0;
 }
 
-- 
2.47.2



