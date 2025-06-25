Return-Path: <bpf+bounces-61601-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1666BAE916C
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 00:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF2955A3100
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 22:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B7A2F547C;
	Wed, 25 Jun 2025 22:57:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5272F49E1;
	Wed, 25 Jun 2025 22:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750892224; cv=none; b=JlFDOXBGJvOUW+DVnJgC2wf8CBYyfZIv3jBr+ze1sUMzuGClfBX1xylYZC/9pEdKdpBMz0J+yyKVjJr/hcX+NlWDVvu9C+f/F3Kxd8lrcHBEVrrFER1UOeChAlTeT0fL2dhia513c4/y7VPscgGffnXN9tkCIFWSyOWzMf3Ee2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750892224; c=relaxed/simple;
	bh=plmgvh9DxexqvE5oSfk1CgrUU1du4o0wC36oFV+V10M=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=TZWNiVwH4+R9Rg9RlgZXlpd/2/CGeF+ZI8bMfR9MrSnMzHsUwlQ/AyNHIRk+cPz8CEnL/qYyIMg2FP2xDk2IjtBFRTEqxwwiGR2KLHEQ2X29Pb/9ZH+xmO2F4PG2lqGqpVBFhu6ejA5VFcndU6AvD3g2iCaM8tMjdjgU8h2xRlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 3200E80373;
	Wed, 25 Jun 2025 22:56:55 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: nevets@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id 06D7032;
	Wed, 25 Jun 2025 22:56:51 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uUZ3N-000000043jg-1OIi;
	Wed, 25 Jun 2025 18:57:17 -0400
Message-ID: <20250625225717.187191105@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 25 Jun 2025 18:56:14 -0400
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
Subject: [PATCH v11 14/14] unwind_user/x86: Enable compat mode frame pointer unwinding on x86
References: <20250625225600.555017347@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Stat-Signature: hq9xffaaubnaqf4nfcryufwqrr5p7rpm
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 06D7032
X-Session-Marker: 6E657665747340676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18H/aLT0aTz9Z7SxiyFQVCpMoi3/QL93tA=
X-HE-Tag: 1750892211-863523
X-HE-Meta: U2FsdGVkX1/np5NdkGHrmW6L9MBvuYzLqWxQQkiFCdwRUC/n3PUMlPKxVhPQo396BIrmvxdXDjVIHLOA2VUu0FfAvvNaLfOlsS0r8ok1jueMyfy47uIWHlHrf8HJc6Ne2waL3rYvtsbnnPYl64LmLtL62yM1x3cKO4ffZqs2fc9ls4SLVg7gDu1Fu/IRVKuxCf2tmLaHAVfvrabJZAbhxujEySq/kCYhstfOM68gwiMEiVbO4F4O0oWUplhyutg6NLfVJfc//BZw0b3c3QVm+JDkBQtN9DTuFX0ARxTbNDWpeUp2GWRmjcb+hLZTU47u0jrAfVVNewXuspdiettTnQrcvIwP6LbaLNFS3cgShVZchFCRjdiJeS6jzqRcSXHST1qGV4qrYFWMZ0nf0JPF1E8vibwKoEYBU+cz5hY2zLU=

From: Josh Poimboeuf <jpoimboe@kernel.org>

Use ARCH_INIT_USER_COMPAT_FP_FRAME to describe how frame pointers are
unwound on x86, and implement the hooks needed to add the segment base
addresses.  Enable HAVE_UNWIND_USER_COMPAT_FP if the system has compat
mode compiled in.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v10: https://lore.kernel.org/20250611010430.123232579@goodmis.org

- Moved calling the functions arch_unwind_user_init() and
  arch_unwind_user_next() to this commit as it's the first commit to use
  them. (Peter Zijlstra)

 arch/x86/Kconfig                         |  1 +
 arch/x86/include/asm/unwind_user.h       | 49 ++++++++++++++++++++++++
 arch/x86/include/asm/unwind_user_types.h | 17 ++++++++
 include/linux/unwind_user.h              | 20 ++++++++++
 kernel/unwind/user.c                     |  4 ++
 5 files changed, 91 insertions(+)
 create mode 100644 arch/x86/include/asm/unwind_user_types.h

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2cdb5cf91541..3f7bdc9e3cec 100644
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
index 8597857bf896..43f8554c1d70 100644
--- a/arch/x86/include/asm/unwind_user.h
+++ b/arch/x86/include/asm/unwind_user.h
@@ -2,10 +2,59 @@
 #ifndef _ASM_X86_UNWIND_USER_H
 #define _ASM_X86_UNWIND_USER_H
 
+#include <linux/unwind_user_types.h>
+#include <asm/ptrace.h>
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
+static inline void arch_unwind_user_init(struct unwind_user_state *state,
+					 struct pt_regs *regs)
+{
+	unsigned long cs_base, ss_base;
+
+	if (state->type != UNWIND_USER_TYPE_COMPAT_FP)
+		return;
+
+	scoped_guard(irqsave) {
+		cs_base = segment_base_address(regs->cs);
+		ss_base = segment_base_address(regs->ss);
+	}
+
+	state->arch.cs_base = cs_base;
+	state->arch.ss_base = ss_base;
+
+	state->ip += cs_base;
+	state->sp += ss_base;
+	state->fp += ss_base;
+}
+#define arch_unwind_user_init arch_unwind_user_init
+
+static inline void arch_unwind_user_next(struct unwind_user_state *state)
+{
+	if (state->type != UNWIND_USER_TYPE_COMPAT_FP)
+		return;
+
+	state->ip += state->arch.cs_base;
+	state->fp += state->arch.ss_base;
+}
+#define arch_unwind_user_next arch_unwind_user_next
+
+#endif /* CONFIG_IA32_EMULATION */
+
+#include <asm-generic/unwind_user.h>
+
 #endif /* _ASM_X86_UNWIND_USER_H */
diff --git a/arch/x86/include/asm/unwind_user_types.h b/arch/x86/include/asm/unwind_user_types.h
new file mode 100644
index 000000000000..d7074dc5f0ce
--- /dev/null
+++ b/arch/x86/include/asm/unwind_user_types.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_UNWIND_USER_TYPES_H
+#define _ASM_UNWIND_USER_TYPES_H
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
diff --git a/include/linux/unwind_user.h b/include/linux/unwind_user.h
index ac007363820a..46f995cda606 100644
--- a/include/linux/unwind_user.h
+++ b/include/linux/unwind_user.h
@@ -14,6 +14,26 @@
  #define in_compat_mode(regs) false
 #endif
 
+/*
+ * If an architecture needs to initialize the state for a specific
+ * reason, for example, it may need to do something different
+ * in compat mode, it can define arch_unwind_user_init to a
+ * function that will perform this initialization.
+ */
+#ifndef arch_unwind_user_init
+static inline void arch_unwind_user_init(struct unwind_user_state *state, struct pt_regs *reg) {}
+#endif
+
+/*
+ * If an architecture requires some more updates to the state between
+ * stack frames, it can define arch_unwind_user_next to a function
+ * that will update the state between reading stack frames during
+ * the user space stack walk.
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



