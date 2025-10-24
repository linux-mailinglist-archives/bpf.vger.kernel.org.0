Return-Path: <bpf+bounces-72110-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 374F7C06CCE
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 16:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D13EB3AA818
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 14:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B906531619E;
	Fri, 24 Oct 2025 14:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C5xU06UQ"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FDA26A1B6;
	Fri, 24 Oct 2025 14:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761317528; cv=none; b=tOdiZeGUCDbNqm/fLHMeN4b9971isrZUU7ZHb6WZSwsgewJJ6FSYMSWfQ22P5+wqz9bwIlFOnNIsv0qcUG6jyDryW/dHDNe8F0RgBjk/Ge/53cg/zXY5ZmknJqe8MUPm0m/wEmRJ9FoPMp/AnIsvVdvWMO+8VkTyx/Vr1LfSvrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761317528; c=relaxed/simple;
	bh=BCij+Hi25/ydA//h3z3RbncjJoIs3LzuZAEi5NEGqwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BCt9DW+cjBuM9P/4FWLXWkhpWYKgKCUCpTNU45a1CRnGf5eCmYgHpywAVT04fG9up2HDdj9xWocNDjEmrSbs5TtH2IC3l7GXYdaDS5rn7NNL2sLCRtOQPhwmhmkWQbOzYCc6lYzVEpaHX9Mehn5xLhwfShCwbaJZj7pyvUq8i7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=C5xU06UQ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FI/WN7v2RklnKmQzu2cqn+e7+2+5pDjrh+VgvJvLgHY=; b=C5xU06UQuCVdgN/ugSNpkE54me
	XcFfLLPr1zcj6LA5fmeYQS/PY173GVc7Cm/ThcLpCUVkSJsDBk6NUwTh3PUqkwGAAYrd1MEXFxckg
	cLbAF23BNB6M+bY36sLdIcm3BUWvP3ObCSXlCeP0E7fopXV5VnZUO0AuY3PffMxenSVbIhK9nXsOE
	lAUsuVYIBKtsL++NZActDsMKHe/ltbodv1MUALCzCLTeOHkxBr1dshuA8qVUQSGzh6+eYtyAJUqIQ
	xVBoYu/50YdMgUVgtjOybVrFlDOoI7UTxSYKVbpz/EJz7EDuHz/D5nRpDOaR9Ur27EI9/OrGJlaXs
	s2vW9NtA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vCJ92-00000003I0G-1n74;
	Fri, 24 Oct 2025 14:51:57 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9460A30039F; Fri, 24 Oct 2025 16:51:56 +0200 (CEST)
Date: Fri, 24 Oct 2025 16:51:56 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Jens Remus <jremus@linux.ibm.com>
Cc: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrii Nakryiko <andrii@kernel.org>,
	Indu Bhagat <indu.bhagat@oracle.com>,
	"Jose E. Marchesi" <jemarch@gnu.org>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Florian Weimer <fweimer@redhat.com>, Sam James <sam@gentoo.org>,
	Kees Cook <kees@kernel.org>, Carlos O'Donell <codonell@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v16 0/4] perf: Support the deferred unwinding
 infrastructure
Message-ID: <20251024145156.GM4068168@noisy.programming.kicks-ass.net>
References: <20251007214008.080852573@kernel.org>
 <20251023150002.GR4067720@noisy.programming.kicks-ass.net>
 <20251024092926.GI4068168@noisy.programming.kicks-ass.net>
 <20251024104119.GJ4068168@noisy.programming.kicks-ass.net>
 <a59509f0-5888-4663-9e82-98e27fc3e813@linux.ibm.com>
 <20251024140815.GE3245006@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024140815.GE3245006@noisy.programming.kicks-ass.net>

On Fri, Oct 24, 2025 at 04:08:15PM +0200, Peter Zijlstra wrote:

> Yeah, I suppose that should work. Let me rework things accordingly.

---
Subject: unwind_user/x86: Teach FP unwind about start of function
From: Peter Zijlstra <peterz@infradead.org>
Date: Fri Oct 24 12:31:10 CEST 2025

When userspace is interrupted at the start of a function, before we
get a chance to complete the frame, unwind will miss one caller.

X86 has a uprobe specific fixup for this, add bits to the generic
unwinder to support this.

Suggested-by: Jens Remus <jremus@linux.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/events/core.c             |   40 -------------------------------------
 arch/x86/include/asm/unwind_user.h |   12 +++++++++++
 arch/x86/include/asm/uprobes.h     |    9 ++++++++
 arch/x86/kernel/uprobes.c          |   32 +++++++++++++++++++++++++++++
 include/linux/unwind_user_types.h  |    1 
 kernel/unwind/user.c               |   35 ++++++++++++++++++++++++--------
 6 files changed, 80 insertions(+), 49 deletions(-)

--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2845,46 +2845,6 @@ static unsigned long get_segment_base(un
 	return get_desc_base(desc);
 }
 
-#ifdef CONFIG_UPROBES
-/*
- * Heuristic-based check if uprobe is installed at the function entry.
- *
- * Under assumption of user code being compiled with frame pointers,
- * `push %rbp/%ebp` is a good indicator that we indeed are.
- *
- * Similarly, `endbr64` (assuming 64-bit mode) is also a common pattern.
- * If we get this wrong, captured stack trace might have one extra bogus
- * entry, but the rest of stack trace will still be meaningful.
- */
-static bool is_uprobe_at_func_entry(struct pt_regs *regs)
-{
-	struct arch_uprobe *auprobe;
-
-	if (!current->utask)
-		return false;
-
-	auprobe = current->utask->auprobe;
-	if (!auprobe)
-		return false;
-
-	/* push %rbp/%ebp */
-	if (auprobe->insn[0] == 0x55)
-		return true;
-
-	/* endbr64 (64-bit only) */
-	if (user_64bit_mode(regs) && is_endbr((u32 *)auprobe->insn))
-		return true;
-
-	return false;
-}
-
-#else
-static bool is_uprobe_at_func_entry(struct pt_regs *regs)
-{
-	return false;
-}
-#endif /* CONFIG_UPROBES */
-
 #ifdef CONFIG_IA32_EMULATION
 
 #include <linux/compat.h>
--- a/arch/x86/include/asm/unwind_user.h
+++ b/arch/x86/include/asm/unwind_user.h
@@ -3,6 +3,7 @@
 #define _ASM_X86_UNWIND_USER_H
 
 #include <asm/ptrace.h>
+#include <asm/uprobes.h>
 
 #define ARCH_INIT_USER_FP_FRAME(ws)			\
 	.cfa_off	=  2*(ws),			\
@@ -10,6 +11,12 @@
 	.fp_off		= -2*(ws),			\
 	.use_fp		= true,
 
+#define ARCH_INIT_USER_FP_ENTRY_FRAME(ws)		\
+	.cfa_off	=  1*(ws),			\
+	.ra_off		= -1*(ws),			\
+	.fp_off		= 0,				\
+	.use_fp		= false,
+
 static inline int unwind_user_word_size(struct pt_regs *regs)
 {
 	/* We can't unwind VM86 stacks */
@@ -22,4 +29,9 @@ static inline int unwind_user_word_size(
 	return sizeof(long);
 }
 
+static inline bool unwind_user_at_function_start(struct pt_regs *regs)
+{
+	return is_uprobe_at_func_entry(regs);
+}
+
 #endif /* _ASM_X86_UNWIND_USER_H */
--- a/arch/x86/include/asm/uprobes.h
+++ b/arch/x86/include/asm/uprobes.h
@@ -62,4 +62,13 @@ struct arch_uprobe_task {
 	unsigned int			saved_tf;
 };
 
+#ifdef CONFIG_UPROBES
+extern bool is_uprobe_at_func_entry(struct pt_regs *regs);
+#else
+static bool is_uprobe_at_func_entry(struct pt_regs *regs)
+{
+	return false;
+}
+#endif /* CONFIG_UPROBES */
+
 #endif	/* _ASM_UPROBES_H */
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -1791,3 +1791,35 @@ bool arch_uretprobe_is_alive(struct retu
 	else
 		return regs->sp <= ret->stack;
 }
+
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
+bool is_uprobe_at_func_entry(struct pt_regs *regs)
+{
+	struct arch_uprobe *auprobe;
+
+	if (!current->utask)
+		return false;
+
+	auprobe = current->utask->auprobe;
+	if (!auprobe)
+		return false;
+
+	/* push %rbp/%ebp */
+	if (auprobe->insn[0] == 0x55)
+		return true;
+
+	/* endbr64 (64-bit only) */
+	if (user_64bit_mode(regs) && is_endbr((u32 *)auprobe->insn))
+		return true;
+
+	return false;
+}
--- a/include/linux/unwind_user_types.h
+++ b/include/linux/unwind_user_types.h
@@ -39,6 +39,7 @@ struct unwind_user_state {
 	unsigned int				ws;
 	enum unwind_user_type			current_type;
 	unsigned int				available_types;
+	bool					topmost;
 	bool					done;
 };
 
--- a/kernel/unwind/user.c
+++ b/kernel/unwind/user.c
@@ -26,14 +26,12 @@ get_user_word(unsigned long *word, unsig
 	return get_user(*word, addr);
 }
 
-static int unwind_user_next_fp(struct unwind_user_state *state)
+static int unwind_user_next_common(struct unwind_user_state *state,
+				   const struct unwind_user_frame *frame)
 {
-	const struct unwind_user_frame frame = {
-		ARCH_INIT_USER_FP_FRAME(state->ws)
-	};
 	unsigned long cfa, fp, ra;
 
-	if (frame.use_fp) {
+	if (frame->use_fp) {
 		if (state->fp < state->sp)
 			return -EINVAL;
 		cfa = state->fp;
@@ -42,7 +40,7 @@ static int unwind_user_next_fp(struct un
 	}
 
 	/* Get the Canonical Frame Address (CFA) */
-	cfa += frame.cfa_off;
+	cfa += frame->cfa_off;
 
 	/* stack going in wrong direction? */
 	if (cfa <= state->sp)
@@ -53,19 +51,37 @@ static int unwind_user_next_fp(struct un
 		return -EINVAL;
 
 	/* Find the Return Address (RA) */
-	if (get_user_word(&ra, cfa, frame.ra_off, state->ws))
+	if (get_user_word(&ra, cfa, frame->ra_off, state->ws))
 		return -EINVAL;
 
-	if (frame.fp_off && get_user_word(&fp, cfa, frame.fp_off, state->ws))
+	if (frame->fp_off && get_user_word(&fp, cfa, frame->fp_off, state->ws))
 		return -EINVAL;
 
 	state->ip = ra;
 	state->sp = cfa;
-	if (frame.fp_off)
+	if (frame->fp_off)
 		state->fp = fp;
+	state->topmost = false;
 	return 0;
 }
 
+static int unwind_user_next_fp(struct unwind_user_state *state)
+{
+	struct pt_regs *regs = task_pt_regs(current);
+
+	const struct unwind_user_frame fp_frame = {
+		ARCH_INIT_USER_FP_FRAME(state->ws)
+	};
+	const struct unwind_user_frame fp_entry_frame = {
+		ARCH_INIT_USER_FP_ENTRY_FRAME(state->ws)
+	};
+
+	if (state->topmost && unwind_user_at_function_start(regs))
+		return unwind_user_next_common(state, &fp_entry_frame);
+
+	return unwind_user_next_common(state, &fp_frame);
+}
+
 static int unwind_user_next(struct unwind_user_state *state)
 {
 	unsigned long iter_mask = state->available_types;
@@ -118,6 +134,7 @@ static int unwind_user_start(struct unwi
 		state->done = true;
 		return -EINVAL;
 	}
+	state->topmost = true;
 
 	return 0;
 }

