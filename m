Return-Path: <bpf+bounces-63516-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B54BB081EB
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 02:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E3557BA32E
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 00:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875B6191F7E;
	Thu, 17 Jul 2025 00:51:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E69381BA;
	Thu, 17 Jul 2025 00:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752713467; cv=none; b=ZRKVZu4bNsHleIYjwPnpl9h27bWcb/rP4RLBnHAVC5JC/YeCRpN/OeIYgPjxO4po+M7q5UF6jac46ZcE+nxywMWY2Y7GMTh59Q7ycXv406Idck91uqjTc+7GV7WlMBcTOmTSze4KHvftKE8u+zGcg/BaaODEH5rPV/LPcNTGzDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752713467; c=relaxed/simple;
	bh=isBKSMYVlR4fXx7yEE5MZFRH75BsGSxNL+9w29T3yFE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DutBMN73FVDzH+pZBVCbbQg2ZjRkbRSBAe7fqthupKH7M7SK64vqDKA07UzNxmitd1dQ6qqK0X6NrjjR8Fg7QusAdM5nvnK7aE0yQE1217Hxh37YzoMGkqiGrV+TNUPPXqIS24NS0Vm5UJboDb3vjrdx8YGUDvFyq4f1QtrQnzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id E87C2C05AD;
	Thu, 17 Jul 2025 00:51:00 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id 53DE418;
	Thu, 17 Jul 2025 00:50:56 +0000 (UTC)
Date: Wed, 16 Jul 2025 20:51:16 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa
 <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, Indu Bhagat
 <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, Beau
 Belgrave <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton
 <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Florian Weimer
 <fweimer@redhat.com>, Sam James <sam@gentoo.org>
Subject: Re: [PATCH v14 00/12] unwind_user: x86: Deferred unwinding
 infrastructure
Message-ID: <20250716205116.30940bb4@gandalf.local.home>
In-Reply-To: <20250717004910.297898999@kernel.org>
References: <20250717004910.297898999@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: xwuqifgsoy5wf6q7qbbbrjtjqxtcyjwr
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 53DE418
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19sU7UTAywRohb0O2BkRN0Np6JDbvP3cCs=
X-HE-Tag: 1752713456-572028
X-HE-Meta: U2FsdGVkX1+BIQXkVtfJFGHV+u7TVq3Abumz7uqCd68FrGQ8tNe4g8aixY4t9Kruh0WNk8B/wyKxGTUzWHZ53HYIUHxFk7HsEg0XyLpZ3Jnnv8HT7wm5cG6xod26eD2pltaWMsXfkT5cF3C5O0AztfIBYMlmXJ+AKi3EDvcY8nze8uY2EFt5yL7MCQdazPc75/Z0MF3Kw8aBE7thy92VfJVhrHY41cr1ee1+fQUxPt1Ay6hTn94vyQJ3o0AsI3k9wN3fxgJy//qzlRpAyhnP8mwFtdWYz9Lj9OcgnsNbSE9+joBe13d5pj+tYCy5XoMtBjIYYLSFurBp8i1crBBiLigP6FZzCOOd

On Wed, 16 Jul 2025 20:49:10 -0400
Steven Rostedt <rostedt@kernel.org> wrote:

> The code for this series is located here:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
> unwind/core
> 
> Head SHA1: f14e91fa8019acefb146869eb465966a88ef6f3b
> 
> Changes since v13: https://lore.kernel.org/linux-trace-kernel/20250708012239.268642741@kernel.org/

Here's a diff between v13 and v14:

diff --git a/arch/Kconfig b/arch/Kconfig
index 2c41d3072910..8e3fd723bd74 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -442,10 +442,6 @@ config HAVE_UNWIND_USER_FP
 	bool
 	select UNWIND_USER
 
-config HAVE_UNWIND_USER_COMPAT_FP
-	bool
-	depends on HAVE_UNWIND_USER_FP
-
 config HAVE_PERF_REGS
 	bool
 	help
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 17d4094c821b..5862433c81e1 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -302,7 +302,6 @@ config X86
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_UACCESS_VALIDATION		if HAVE_OBJTOOL
 	select HAVE_UNSTABLE_SCHED_CLOCK
-	select HAVE_UNWIND_USER_COMPAT_FP	if IA32_EMULATION
 	select HAVE_UNWIND_USER_FP		if X86_64
 	select HAVE_USER_RETURN_NOTIFIER
 	select HAVE_GENERIC_VDSO
diff --git a/arch/x86/include/asm/unwind_user.h b/arch/x86/include/asm/unwind_user.h
index 19634a73612d..220fd0a6e175 100644
--- a/arch/x86/include/asm/unwind_user.h
+++ b/arch/x86/include/asm/unwind_user.h
@@ -2,41 +2,21 @@
 #ifndef _ASM_X86_UNWIND_USER_H
 #define _ASM_X86_UNWIND_USER_H
 
-#include <linux/unwind_user_types.h>
-
-#define ARCH_INIT_USER_FP_FRAME							\
-	.cfa_off	= (s32)sizeof(long) *  2,				\
-	.ra_off		= (s32)sizeof(long) * -1,				\
-	.fp_off		= (s32)sizeof(long) * -2,				\
-	.use_fp		= true,
-
 #ifdef CONFIG_IA32_EMULATION
-
-#define ARCH_INIT_USER_COMPAT_FP_FRAME						\
-	.cfa_off	= (s32)sizeof(u32)  *  2,				\
-	.ra_off		= (s32)sizeof(u32)  * -1,				\
-	.fp_off		= (s32)sizeof(u32)  * -2,				\
-	.use_fp		= true,
-
-#define in_compat_mode(regs) !user_64bit_mode(regs)
-
-void arch_unwind_user_init(struct unwind_user_state *state,
-			   struct pt_regs *regs);
-
-static inline void arch_unwind_user_next(struct unwind_user_state *state)
+/* Currently compat mode is not supported for deferred stack trace */
+static inline bool arch_unwind_can_defer(void)
 {
-	if (state->type != UNWIND_USER_TYPE_COMPAT_FP)
-		return;
+	struct pt_regs *regs = task_pt_regs(current);
 
-	state->ip += state->arch.cs_base;
-	state->fp += state->arch.ss_base;
+	return user_64bit_mode(regs);
 }
-
-#define arch_unwind_user_init arch_unwind_user_init
-#define arch_unwind_user_next arch_unwind_user_next
-
+# define arch_unwind_can_defer	arch_unwind_can_defer
 #endif /* CONFIG_IA32_EMULATION */
 
-#include <asm-generic/unwind_user.h>
+#define ARCH_INIT_USER_FP_FRAME							\
+	.cfa_off	= (s32)sizeof(long) *  2,				\
+	.ra_off		= (s32)sizeof(long) * -1,				\
+	.fp_off		= (s32)sizeof(long) * -2,				\
+	.use_fp		= true,
 
 #endif /* _ASM_X86_UNWIND_USER_H */
diff --git a/arch/x86/include/asm/unwind_user_types.h b/arch/x86/include/asm/unwind_user_types.h
deleted file mode 100644
index f93d535f900e..000000000000
--- a/arch/x86/include/asm/unwind_user_types.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_X86_UNWIND_USER_TYPES_H
-#define _ASM_X86_UNWIND_USER_TYPES_H
-
-#ifdef CONFIG_IA32_EMULATION
-
-struct arch_unwind_user_state {
-	unsigned long ss_base;
-	unsigned long cs_base;
-};
-#define arch_unwind_user_state arch_unwind_user_state
-
-#endif /* CONFIG_IA32_EMULATION */
-
-#include <asm-generic/unwind_user_types.h>
-
-#endif /* _ASM_UNWIND_USER_TYPES_H */
diff --git a/arch/x86/kernel/stacktrace.c b/arch/x86/kernel/stacktrace.c
index 8ef9d8c71df9..ee117fcf46ed 100644
--- a/arch/x86/kernel/stacktrace.c
+++ b/arch/x86/kernel/stacktrace.c
@@ -9,10 +9,7 @@
 #include <linux/stacktrace.h>
 #include <linux/export.h>
 #include <linux/uaccess.h>
-#include <asm/unwind_user.h>
 #include <asm/stacktrace.h>
-#include <asm/insn.h>
-#include <asm/insn-eval.h>
 #include <asm/unwind.h>
 
 void arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
@@ -131,28 +128,3 @@ void arch_stack_walk_user(stack_trace_consume_fn consume_entry, void *cookie,
 	}
 }
 
-#ifdef CONFIG_IA32_EMULATION
-void arch_unwind_user_init(struct unwind_user_state *state,
-			   struct pt_regs *regs)
-{
-	unsigned long cs_base, ss_base;
-
-	if (state->type != UNWIND_USER_TYPE_COMPAT_FP)
-		return;
-
-	cs_base = insn_get_seg_base(regs, INAT_SEG_REG_CS);
-	ss_base = insn_get_seg_base(regs, INAT_SEG_REG_SS);
-
-	if (cs_base == -1)
-		cs_base = 0;
-	if (ss_base == -1)
-		ss_base = 0;
-
-	state->arch.cs_base = cs_base;
-	state->arch.ss_base = ss_base;
-
-	state->ip += cs_base;
-	state->sp += ss_base;
-	state->fp += ss_base;
-}
-#endif /* CONFIG_IA32_EMULATION */
diff --git a/include/asm-generic/Kbuild b/include/asm-generic/Kbuild
index b797a2434396..295c94a3ccc1 100644
--- a/include/asm-generic/Kbuild
+++ b/include/asm-generic/Kbuild
@@ -60,7 +60,6 @@ mandatory-y += topology.h
 mandatory-y += trace_clock.h
 mandatory-y += uaccess.h
 mandatory-y += unwind_user.h
-mandatory-y += unwind_user_types.h
 mandatory-y += vermagic.h
 mandatory-y += vga.h
 mandatory-y += video.h
diff --git a/include/asm-generic/unwind_user_types.h b/include/asm-generic/unwind_user_types.h
deleted file mode 100644
index f568b82e52cd..000000000000
--- a/include/asm-generic/unwind_user_types.h
+++ /dev/null
@@ -1,5 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_GENERIC_UNWIND_USER_TYPES_H
-#define _ASM_GENERIC_UNWIND_USER_TYPES_H
-
-#endif /* _ASM_GENERIC_UNWIND_USER_TYPES_H */
diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 900b0d5c05f5..879054b8bf87 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -524,4 +524,8 @@ DEFINE_LOCK_GUARD_1(srcu, struct srcu_struct,
 		    srcu_read_unlock(_T->lock, _T->idx),
 		    int idx)
 
+DEFINE_LOCK_GUARD_1(srcu_lite, struct srcu_struct,
+		    _T->idx = srcu_read_lock_lite(_T->lock),
+		    srcu_read_unlock_lite(_T->lock, _T->idx),
+		    int idx)
 #endif
diff --git a/include/linux/unwind_deferred.h b/include/linux/unwind_deferred.h
index a9d5b100d6b2..0124865aaab4 100644
--- a/include/linux/unwind_deferred.h
+++ b/include/linux/unwind_deferred.h
@@ -16,18 +16,23 @@ struct unwind_work {
 	int				bit;
 };
 
-#ifdef CONFIG_UNWIND_USER
+/* Architectures can add a test to not defer unwinding */
+#ifndef arch_unwind_can_defer
+# define arch_unwind_can_defer()	(true)
+#endif
 
-#define UNWIND_PENDING_BIT	(BITS_PER_LONG - 1)
-#define UNWIND_PENDING		BIT(UNWIND_PENDING_BIT)
+#ifdef CONFIG_UNWIND_USER
 
-/* Set if the unwinding was used (directly or deferred) */
-#define UNWIND_USED_BIT		(UNWIND_PENDING_BIT - 1)
-#define UNWIND_USED		BIT(UNWIND_USED_BIT)
+enum {
+	UNWIND_PENDING_BIT = 0,
+	UNWIND_USED_BIT,
+};
 
 enum {
-	UNWIND_ALREADY_PENDING	= 1,
-	UNWIND_ALREADY_EXECUTED	= 2,
+	UNWIND_PENDING		= BIT(UNWIND_PENDING_BIT),
+
+	/* Set if the unwinding was used (directly or deferred) */
+	UNWIND_USED		= BIT(UNWIND_USED_BIT)
 };
 
 void unwind_task_init(struct task_struct *task);
@@ -56,8 +61,10 @@ static __always_inline void unwind_reset_info(void)
 		} while (!try_cmpxchg(&info->unwind_mask, &bits, 0UL));
 		current->unwind_info.id.id = 0;
 
-		if (unlikely(info->cache))
+		if (unlikely(info->cache)) {
 			info->cache->nr_entries = 0;
+			info->cache->unwind_completed = 0;
+		}
 	}
 }
 
diff --git a/include/linux/unwind_deferred_types.h b/include/linux/unwind_deferred_types.h
index db6c65daf185..33b62ac25c86 100644
--- a/include/linux/unwind_deferred_types.h
+++ b/include/linux/unwind_deferred_types.h
@@ -3,11 +3,24 @@
 #define _LINUX_UNWIND_USER_DEFERRED_TYPES_H
 
 struct unwind_cache {
+	unsigned long		unwind_completed;
 	unsigned int		nr_entries;
 	unsigned long		entries[];
 };
 
-
+/*
+ * The unwind_task_id is a unique identifier that maps to a user space
+ * stacktrace. It is generated the first time a deferred user space
+ * stacktrace is requested after a task has entered the kerenl and
+ * is cleared to zero when it exits. The mapped id will be a non-zero
+ * number.
+ *
+ * To simplify the generation of the 64 bit number, 32 bits will be
+ * the CPU it was generated on, and the other 32 bits will be a per
+ * cpu counter that gets incremented by two every time a new identifier
+ * is generated. The LSB will always be set to keep the value
+ * from being zero.
+ */
 union unwind_task_id {
 	struct {
 		u32		cpu;
@@ -17,9 +30,9 @@ union unwind_task_id {
 };
 
 struct unwind_task_info {
+	unsigned long		unwind_mask;
 	struct unwind_cache	*cache;
 	struct callback_head	work;
-	unsigned long		unwind_mask;
 	union unwind_task_id	id;
 };
 
diff --git a/include/linux/unwind_user.h b/include/linux/unwind_user.h
index 8a4af0214ecb..7f7282516bf5 100644
--- a/include/linux/unwind_user.h
+++ b/include/linux/unwind_user.h
@@ -9,31 +9,6 @@
  #define ARCH_INIT_USER_FP_FRAME
 #endif
 
-#ifndef ARCH_INIT_USER_COMPAT_FP_FRAME
- #define ARCH_INIT_USER_COMPAT_FP_FRAME
- #define in_compat_mode(regs) false
-#endif
-
-/*
- * If an architecture needs to initialize the state for a specific
- * reason, for example, it may need to do something different
- * in compat mode, it can define a macro named arch_unwind_user_init
- * with the name of the function that will perform this initialization.
- */
-#ifndef arch_unwind_user_init
-static inline void arch_unwind_user_init(struct unwind_user_state *state, struct pt_regs *reg) {}
-#endif
-
-/*
- * If an architecture requires some more updates to the state between
- * stack frames, it can define a macro named arch_unwind_user_next
- * with the name of the function that will update the state between
- * reading stack frames during the user space stack walk.
- */
-#ifndef arch_unwind_user_next
-static inline void arch_unwind_user_next(struct unwind_user_state *state) {}
-#endif
-
 int unwind_user(struct unwind_stacktrace *trace, unsigned int max_entries);
 
 #endif /* _LINUX_UNWIND_USER_H */
diff --git a/include/linux/unwind_user_types.h b/include/linux/unwind_user_types.h
index 0b6563951ca4..a449f15be890 100644
--- a/include/linux/unwind_user_types.h
+++ b/include/linux/unwind_user_types.h
@@ -3,16 +3,21 @@
 #define _LINUX_UNWIND_USER_TYPES_H
 
 #include <linux/types.h>
-#include <asm/unwind_user_types.h>
 
-#ifndef arch_unwind_user_state
-struct arch_unwind_user_state {};
-#endif
+/*
+ * Unwind types, listed in priority order: lower numbers are attempted first if
+ * available.
+ */
+enum unwind_user_type_bits {
+	UNWIND_USER_TYPE_FP_BIT =		0,
+
+	NR_UNWIND_USER_TYPE_BITS,
+};
 
 enum unwind_user_type {
-	UNWIND_USER_TYPE_NONE,
-	UNWIND_USER_TYPE_FP,
-	UNWIND_USER_TYPE_COMPAT_FP,
+	/* Type "none" for the start of stack walk iteration. */
+	UNWIND_USER_TYPE_NONE =			0,
+	UNWIND_USER_TYPE_FP =			BIT(UNWIND_USER_TYPE_FP_BIT),
 };
 
 struct unwind_stacktrace {
@@ -28,12 +33,12 @@ struct unwind_user_frame {
 };
 
 struct unwind_user_state {
-	unsigned long ip;
-	unsigned long sp;
-	unsigned long fp;
-	struct arch_unwind_user_state arch;
-	enum unwind_user_type type;
-	bool done;
+	unsigned long				ip;
+	unsigned long				sp;
+	unsigned long				fp;
+	enum unwind_user_type			current_type;
+	unsigned int				available_types;
+	bool					done;
 };
 
 #endif /* _LINUX_UNWIND_USER_TYPES_H */
diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c
index 039e12700d49..9972096e93e8 100644
--- a/kernel/unwind/deferred.c
+++ b/kernel/unwind/deferred.c
@@ -44,7 +44,11 @@ static inline bool try_assign_cnt(struct unwind_task_info *info, u32 cnt)
 /* Guards adding to or removing from the list of callbacks */
 static DEFINE_MUTEX(callback_mutex);
 static LIST_HEAD(callbacks);
-static unsigned long unwind_mask;
+
+#define RESERVED_BITS	(UNWIND_PENDING | UNWIND_USED)
+
+/* Zero'd bits are available for assigning callback users */
+static unsigned long unwind_mask = RESERVED_BITS;
 DEFINE_STATIC_SRCU(unwind_srcu);
 
 static inline bool unwind_pending(struct unwind_task_info *info)
@@ -73,19 +77,16 @@ static DEFINE_PER_CPU(u32, unwind_ctx_ctr);
  */
 static u64 get_cookie(struct unwind_task_info *info)
 {
-	u32 cpu_cnt;
-	u32 cnt;
+	u32 cnt = 1;
 
 	if (info->id.cpu)
 		return info->id.id;
 
-	cpu_cnt = __this_cpu_read(unwind_ctx_ctr);
-	cpu_cnt += 2;
-	cnt = cpu_cnt | 1; /* Always make non zero */
-
+	/* LSB is always set to ensure 0 is an invalid value */
+	cnt |= __this_cpu_read(unwind_ctx_ctr) + 2;
 	if (try_assign_cnt(info, cnt)) {
 		/* Update the per cpu counter */
-		__this_cpu_write(unwind_ctx_ctr, cpu_cnt);
+		__this_cpu_write(unwind_ctx_ctr, cnt);
 	}
 	/* Interrupts are disabled, the CPU will always be same */
 	info->id.cpu = smp_processor_id() + 1; /* Must be non zero */
@@ -153,16 +154,13 @@ static void process_unwind_deferred(struct task_struct *task)
 	struct unwind_work *work;
 	unsigned long bits;
 	u64 cookie;
-	int idx;
 
 	if (WARN_ON_ONCE(!unwind_pending(info)))
 		return;
 
 	/* Clear pending bit but make sure to have the current bits */
-	bits = READ_ONCE(info->unwind_mask);
-	while (!try_cmpxchg(&info->unwind_mask, &bits, bits & ~UNWIND_PENDING))
-		;
-
+	bits = atomic_long_fetch_andnot(UNWIND_PENDING,
+				  (atomic_long_t *)&info->unwind_mask);
 	/*
 	 * From here on out, the callback must always be called, even if it's
 	 * just an empty trace.
@@ -172,15 +170,20 @@ static void process_unwind_deferred(struct task_struct *task)
 
 	unwind_user_faultable(&trace);
 
+	if (info->cache)
+		bits &= ~(info->cache->unwind_completed);
+
 	cookie = info->id.id;
 
-	idx = srcu_read_lock(&unwind_srcu);
+	guard(srcu_lite)(&unwind_srcu);
 	list_for_each_entry_srcu(work, &callbacks, list,
 				 srcu_read_lock_held(&unwind_srcu)) {
-		if (test_bit(work->bit, &bits))
+		if (test_bit(work->bit, &bits)) {
 			work->func(work, &trace, cookie);
+			if (info->cache)
+				info->cache->unwind_completed |= BIT(work->bit);
+		}
 	}
-	srcu_read_unlock(&unwind_srcu, idx);
 }
 
 static void unwind_deferred_task_work(struct callback_head *head)
@@ -201,7 +204,7 @@ void unwind_deferred_task_exit(struct task_struct *task)
 }
 
 /**
- * unwind_deferred_request - Request a user stacktrace on task exit
+ * unwind_deferred_request - Request a user stacktrace on task kernel exit
  * @work: Unwind descriptor requesting the trace
  * @cookie: The cookie of the first request made for this task
  *
@@ -221,9 +224,7 @@ void unwind_deferred_task_exit(struct task_struct *task)
  * it will be called again with the same stack trace and cookie.
  *
  * Return: 0 if the callback successfully was queued.
- *         UNWIND_ALREADY_PENDING if the the callback was already queued.
- *         UNWIND_ALREADY_EXECUTED if the callback was already called
- *                (and will not be called again)
+ *         1 if the callback is pending or was already executed.
  *         Negative if there's an error.
  *         @cookie holds the cookie of the first request by any user
  */
@@ -231,17 +232,24 @@ int unwind_deferred_request(struct unwind_work *work, u64 *cookie)
 {
 	struct unwind_task_info *info = &current->unwind_info;
 	unsigned long old, bits;
-	int bit;
+	unsigned long bit;
 	int ret;
 
 	*cookie = 0;
 
+	if (!arch_unwind_can_defer())
+		return -EINVAL;
+
 	if ((current->flags & (PF_KTHREAD | PF_EXITING)) ||
 	    !user_mode(task_pt_regs(current)))
 		return -EINVAL;
 
-	/* NMI requires having safe cmpxchg operations */
-	if (!CAN_USE_IN_NMI && in_nmi())
+	/*
+	 * NMI requires having safe cmpxchg operations.
+	 * Trigger a warning to make it obvious that an architecture
+	 * is using this in NMI when it should not be.
+	 */
+	if (WARN_ON_ONCE(!CAN_USE_IN_NMI && in_nmi()))
 		return -EINVAL;
 
 	/* Do not allow cancelled works to request again */
@@ -249,44 +257,34 @@ int unwind_deferred_request(struct unwind_work *work, u64 *cookie)
 	if (WARN_ON_ONCE(bit < 0))
 		return -EINVAL;
 
+	/* Only need the mask now */
+	bit = BIT(bit);
+
 	guard(irqsave)();
 
 	*cookie = get_cookie(info);
 
 	old = READ_ONCE(info->unwind_mask);
 
-	/* Is this already queued */
-	if (test_bit(bit, &old)) {
-		/*
-		 * If pending is not set, it means this work's callback
-		 * was already called.
-		 */
-		return old & UNWIND_PENDING ? UNWIND_ALREADY_PENDING :
-			UNWIND_ALREADY_EXECUTED;
-	}
-
-	if (unwind_pending(info))
-		goto out;
-
-	/*
-	 * This is the first to enable another task_work for this task since
-	 * the task entered the kernel, or had already called the callbacks.
-	 * Set only the bit for this work and clear all others as they have
-	 * already had their callbacks called, and do not need to call them
-	 * again because of this work.
-	 */
-	bits = UNWIND_PENDING | BIT(bit);
+	/* Is this already queued or executed */
+	if (old & bit)
+		return 1;
 
 	/*
-	 * If the cmpxchg() fails, it means that an NMI came in and set
-	 * the pending bit as well as cleared the other bits. Just
-	 * jump to setting the bit for this work.
+	 * This work's bit hasn't been set yet. Now set it with the PENDING
+	 * bit and fetch the current value of unwind_mask. If ether the
+	 * work's bit or PENDING was already set, then this is already queued
+	 * to have a callback.
 	 */
-	if (CAN_USE_IN_NMI) {
-		if (!try_cmpxchg(&info->unwind_mask, &old, bits))
-			goto out;
-	} else {
-		info->unwind_mask = bits;
+	bits = UNWIND_PENDING | bit;
+	old = atomic_long_fetch_or(bits, (atomic_long_t *)&info->unwind_mask);
+	if (old & bits) {
+		/*
+		 * If the work's bit was set, whatever set it had better
+		 * have also set pending and queued a callback.
+		 */
+		WARN_ON_ONCE(!(old & UNWIND_PENDING));
+		return old & bit;
 	}
 
 	/* The work has been claimed, now schedule it. */
@@ -296,9 +294,6 @@ int unwind_deferred_request(struct unwind_work *work, u64 *cookie)
 		WRITE_ONCE(info->unwind_mask, 0);
 
 	return ret;
- out:
-	return test_and_set_bit(bit, &info->unwind_mask) ?
-		UNWIND_ALREADY_PENDING : 0;
 }
 
 void unwind_deferred_cancel(struct unwind_work *work)
@@ -309,9 +304,14 @@ void unwind_deferred_cancel(struct unwind_work *work)
 	if (!work)
 		return;
 
+	bit = work->bit;
+
+	/* No work should be using a reserved bit */
+	if (WARN_ON_ONCE(BIT(bit) & RESERVED_BITS))
+		return;
+
 	guard(mutex)(&callback_mutex);
 	list_del_rcu(&work->list);
-	bit = work->bit;
 
 	/* Do not allow any more requests and prevent callbacks */
 	work->bit = -1;
@@ -324,6 +324,8 @@ void unwind_deferred_cancel(struct unwind_work *work)
 	/* Clear this bit from all threads */
 	for_each_process_thread(g, t) {
 		clear_bit(bit, &t->unwind_info.unwind_mask);
+		if (t->unwind_info.cache)
+			clear_bit(bit, &t->unwind_info.cache->unwind_completed);
 	}
 }
 
@@ -334,7 +336,7 @@ int unwind_deferred_init(struct unwind_work *work, unwind_callback_t func)
 	guard(mutex)(&callback_mutex);
 
 	/* See if there's a bit in the mask available */
-	if (unwind_mask == ~(UNWIND_PENDING|UNWIND_USED))
+	if (unwind_mask == ~0UL)
 		return -EBUSY;
 
 	work->bit = ffz(unwind_mask);
diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
index 249d9e32fad7..85b8c764d2f7 100644
--- a/kernel/unwind/user.c
+++ b/kernel/unwind/user.c
@@ -12,54 +12,18 @@ static struct unwind_user_frame fp_frame = {
 	ARCH_INIT_USER_FP_FRAME
 };
 
-static struct unwind_user_frame compat_fp_frame = {
-	ARCH_INIT_USER_COMPAT_FP_FRAME
-};
-
-static inline bool fp_state(struct unwind_user_state *state)
-{
-	return IS_ENABLED(CONFIG_HAVE_UNWIND_USER_FP) &&
-	       state->type == UNWIND_USER_TYPE_FP;
-}
-
 #define for_each_user_frame(state) \
 	for (unwind_user_start(state); !(state)->done; unwind_user_next(state))
 
-static inline bool compat_fp_state(struct unwind_user_state *state)
+static int unwind_user_next_fp(struct unwind_user_state *state)
 {
-	return IS_ENABLED(CONFIG_HAVE_UNWIND_USER_COMPAT_FP) &&
-	       state->type == UNWIND_USER_TYPE_COMPAT_FP;
-}
-
-#define unwind_get_user_long(to, from, state)				\
-({									\
-	int __ret;							\
-	if (compat_fp_state(state))					\
-		__ret = get_user(to, (u32 __user *)(from));		\
-	else								\
-		__ret = get_user(to, (unsigned long __user *)(from));	\
-	__ret;								\
-})
-
-static int unwind_user_next(struct unwind_user_state *state)
-{
-	struct unwind_user_frame *frame;
-	unsigned long cfa = 0, fp, ra = 0;
+	struct unwind_user_frame *frame = &fp_frame;
+	unsigned long cfa, fp, ra = 0;
 	unsigned int shift;
 
-	if (state->done)
-		return -EINVAL;
-
-	if (compat_fp_state(state))
-		frame = &compat_fp_frame;
-	else if (fp_state(state))
-		frame = &fp_frame;
-	else
-		goto done;
-
 	if (frame->use_fp) {
 		if (state->fp < state->sp)
-			goto done;
+			return -EINVAL;
 		cfa = state->fp;
 	} else {
 		cfa = state->sp;
@@ -70,30 +34,53 @@ static int unwind_user_next(struct unwind_user_state *state)
 
 	/* stack going in wrong direction? */
 	if (cfa <= state->sp)
-		goto done;
+		return -EINVAL;
 
 	/* Make sure that the address is word aligned */
-	shift = sizeof(long) == 4 || compat_fp_state(state) ? 2 : 3;
-	if ((cfa + frame->ra_off) & ((1 << shift) - 1))
-		goto done;
+	shift = sizeof(long) == 4 ? 2 : 3;
+	if (cfa & ((1 << shift) - 1))
+		return -EINVAL;
 
 	/* Find the Return Address (RA) */
-	if (unwind_get_user_long(ra, cfa + frame->ra_off, state))
-		goto done;
+	if (get_user(ra, (unsigned long *)(cfa + frame->ra_off)))
+		return -EINVAL;
 
-	if (frame->fp_off && unwind_get_user_long(fp, cfa + frame->fp_off, state))
-		goto done;
+	if (frame->fp_off && get_user(fp, (unsigned long __user *)(cfa + frame->fp_off)))
+		return -EINVAL;
 
 	state->ip = ra;
 	state->sp = cfa;
 	if (frame->fp_off)
 		state->fp = fp;
+	return 0;
+}
+
+static int unwind_user_next(struct unwind_user_state *state)
+{
+	unsigned long iter_mask = state->available_types;
+	unsigned int bit;
 
-	arch_unwind_user_next(state);
+	if (state->done)
+		return -EINVAL;
 
-	return 0;
+	for_each_set_bit(bit, &iter_mask, NR_UNWIND_USER_TYPE_BITS) {
+		enum unwind_user_type type = BIT(bit);
+
+		state->current_type = type;
+		switch (type) {
+		case UNWIND_USER_TYPE_FP:
+			if (!unwind_user_next_fp(state))
+				return 0;
+			continue;
+		default:
+			WARN_ONCE(1, "Undefined unwind bit %d", bit);
+			break;
+		}
+		break;
+	}
 
-done:
+	/* No successful unwind method. */
+	state->current_type = UNWIND_USER_TYPE_NONE;
 	state->done = true;
 	return -EINVAL;
 }
@@ -109,19 +96,13 @@ static int unwind_user_start(struct unwind_user_state *state)
 		return -EINVAL;
 	}
 
-	if (IS_ENABLED(CONFIG_HAVE_UNWIND_USER_COMPAT_FP) && in_compat_mode(regs))
-		state->type = UNWIND_USER_TYPE_COMPAT_FP;
-	else if (IS_ENABLED(CONFIG_HAVE_UNWIND_USER_FP))
-		state->type = UNWIND_USER_TYPE_FP;
-	else
-		state->type = UNWIND_USER_TYPE_NONE;
+	if (IS_ENABLED(CONFIG_HAVE_UNWIND_USER_FP))
+		state->available_types |= UNWIND_USER_TYPE_FP;
 
 	state->ip = instruction_pointer(regs);
 	state->sp = user_stack_pointer(regs);
 	state->fp = frame_pointer(regs);
 
-	arch_unwind_user_init(state, regs);
-
 	return 0;
 }
 
-- Steve

