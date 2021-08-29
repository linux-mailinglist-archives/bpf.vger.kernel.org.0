Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3567A3FAC31
	for <lists+bpf@lfdr.de>; Sun, 29 Aug 2021 16:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235393AbhH2OXU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 29 Aug 2021 10:23:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:39196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235380AbhH2OXT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 29 Aug 2021 10:23:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CD44360F42;
        Sun, 29 Aug 2021 14:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630246947;
        bh=sesodM3ISW0LfOFdpy++xR/0vGngMKUSW+DQuU7zUEo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=siTti+tkcloBUypNu7rDI9Pt7DyyLRZuscKpFxSTtY3tZicZUGIhHRcdaWVwysVXK
         8rbC9QaVuainpD9wtJuNeQ8yU/48/8RoQvXU9hKBW4KwSauN8FJPlC77OUQyUxhUaf
         Zop6aJzX8LY22b/hfaNg9W5wbw1aBKXI2j5WdTHt6JDvWQMFAzY3L9TdMiZxXEa7FQ
         T+3v4SkqSql3QPwRgMYCBbK46+0eObVIoLySx2IaNhAAc0XU3rA4Da2pcHg/ROZcv9
         SB2Ww2LP05asPMPMZdH8uk/lsBtHtn02wh32LrqFndc/69l1aJDx2Qs852OtSCJICu
         H9RyNlZnbQ8bQ==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>
Cc:     X86 ML <x86@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>, kernel-team@fb.com,
        yhs@fb.com, linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: [RFC PATCH 1/1] [PoC] tracing: kprobe: Add non-stack intrusion return probe event
Date:   Sun, 29 Aug 2021 23:22:24 +0900
Message-Id: <163024694446.457128.14547469102554958784.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <163024693462.457128.1437820221831758047.stgit@devnote2>
References: <163024693462.457128.1437820221831758047.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add kernel return instruction probe event (kriprobe event)
to kprobe event. This will hook the returns of the target function
but does not intrude the real stack entry.
This depends on each architecture implement one function --
find_return_instructions(). If it is implemented correctly,
kprobe event uses the kriprobe event instead of kretprobe.

Note, this is just a PoC code for x86. This doesn't work with
other arch which only supports kretprobe.
Also, This doesn't support the function with the tail call
(jump into another function instead of call & return),
kriprobe doesn't work with it yet.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/x86/kernel/kprobes/core.c |   59 +++++++++++++++++++++
 kernel/trace/trace_kprobe.c    |  110 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 164 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index b6e046e4b289..4c4094505712 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -1117,3 +1117,62 @@ int arch_trampoline_kprobe(struct kprobe *p)
 {
 	return 0;
 }
+
+static bool insn_is_return(struct insn *insn)
+{
+	switch (insn->opcode.bytes[0]) {
+	case 0xc2:
+	case 0xc3:
+	case 0xca:
+	case 0xcb:
+		return true;
+	default:
+		return false;
+	}
+}
+
+/**
+ * find_return_instructions -- Search return instruction in the function
+ * @func: The target function address
+ * @rets: The storage of the return instruction address
+ * @nr_rets: The length of @rets
+ *
+ * This searches the address of return instructions in the @func (@func must
+ * be an entry address of the target function). The results are stored in the
+ * @rets. If the number of return instructions are bigger than @nr_rets, this
+ * will return the required length of the @rets.
+ */
+int find_return_instructions(kprobe_opcode_t *func, kprobe_opcode_t *rets[], int nr_rets)
+{
+	unsigned long addr, end, size = 0, offset = 0;
+	kprobe_opcode_t buf[MAX_INSN_SIZE];
+	unsigned long recovered_insn;
+	struct insn insn;
+	int ret, nr = 0;
+
+	addr = (unsigned long)func;
+	if (!kallsyms_lookup_size_offset(addr, &size, &offset))
+		return -EINVAL;
+
+	if (offset != 0)
+		return -EINVAL;
+	end = addr + size;
+
+	/* Decode the function to find return instructions */
+	while (addr < end) {
+		recovered_insn = recover_probed_instruction(buf, addr);
+		if (!recovered_insn)
+			return -EILSEQ;
+		ret = insn_decode_kernel(&insn, (void *)recovered_insn);
+		if (ret < 0)
+			return -EILSEQ;
+		if (insn_is_return(&insn)) {
+			if (nr < nr_rets)
+				rets[nr++] = (kprobe_opcode_t *)addr;
+		}
+		/* TODO: find jmp for tail call (outside of this func) */
+		addr += insn.length;
+	}
+
+	return nr;
+}
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 3a64ba4bbad6..99e508ff45ad 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -50,6 +50,13 @@ static struct dyn_event_operations trace_kprobe_ops = {
 	.match = trace_kprobe_match,
 };
 
+#define MAX_RET_INSNS 16
+
+struct kprobe_holder {
+	struct kprobe kp;
+	struct trace_kprobe *tk;
+};
+
 /*
  * Kprobe event core functions
  */
@@ -59,6 +66,8 @@ struct trace_kprobe {
 	unsigned long __percpu *nhit;
 	const char		*symbol;	/* symbol name */
 	struct trace_probe	tp;
+	struct kprobe_holder	*krets;
+	int			nr_krets;
 };
 
 static bool is_trace_kprobe(struct dyn_event *ev)
@@ -82,7 +91,7 @@ static struct trace_kprobe *to_trace_kprobe(struct dyn_event *ev)
 
 static nokprobe_inline bool trace_kprobe_is_return(struct trace_kprobe *tk)
 {
-	return tk->rp.handler != NULL;
+	return tk->rp.handler != NULL || tk->krets != NULL;
 }
 
 static nokprobe_inline const char *trace_kprobe_symbol(struct trace_kprobe *tk)
@@ -180,7 +189,7 @@ static nokprobe_inline unsigned long trace_kprobe_nhit(struct trace_kprobe *tk)
 
 static nokprobe_inline bool trace_kprobe_is_registered(struct trace_kprobe *tk)
 {
-	return !(list_empty(&tk->rp.kp.list) &&
+	return tk->krets || !(list_empty(&tk->rp.kp.list) &&
 		 hlist_unhashed(&tk->rp.kp.hlist));
 }
 
@@ -311,13 +320,23 @@ static struct trace_kprobe *find_trace_kprobe(const char *event,
 	return NULL;
 }
 
+static int enable_retinsn_probe(struct trace_kprobe *tk)
+{
+	int ret, i;
+
+	for (i = 0; i < tk->nr_krets; i++)
+		ret = enable_kprobe(&(tk->krets[i].kp));
+
+	return ret;
+}
+
 static inline int __enable_trace_kprobe(struct trace_kprobe *tk)
 {
 	int ret = 0;
 
 	if (trace_kprobe_is_registered(tk) && !trace_kprobe_has_gone(tk)) {
 		if (trace_kprobe_is_return(tk))
-			ret = enable_kretprobe(&tk->rp);
+			ret = enable_retinsn_probe(tk);
 		else
 			ret = enable_kprobe(&tk->rp.kp);
 	}
@@ -474,6 +493,68 @@ static bool within_notrace_func(struct trace_kprobe *tk)
 #define within_notrace_func(tk)	(false)
 #endif
 
+int find_return_instructions(kprobe_opcode_t *func, kprobe_opcode_t *rets[], int nr_rets);
+static void retinsn_dispatcher(struct kprobe *kp, struct pt_regs *regs, unsigned long flags);
+
+static void unregister_retinsn_probe(struct trace_kprobe *tk)
+{
+	struct kprobe *kpp[MAX_RET_INSNS];
+	int i;
+
+	for (i = 0; i < tk->nr_krets; i++)
+		kpp[i] = &tk->krets[i].kp;
+
+	unregister_kprobes(kpp, tk->nr_krets);
+}
+
+static int register_retinsn_probe(struct trace_kprobe *tk)
+{
+	kprobe_opcode_t *func = (kprobe_opcode_t *)trace_kprobe_address(tk);
+	kprobe_opcode_t *rets[MAX_RET_INSNS];
+	struct kprobe *kpp[MAX_RET_INSNS];
+	struct kprobe_holder *khs;
+	int i, ret, nrets;
+
+	/* Find return instruction in the target function. */
+	ret = find_return_instructions(func, rets, MAX_RET_INSNS);
+	if (ret < 0)
+		return ret;
+
+	/* There might be tail call (jump) in the function. */
+	if (ret == 0)
+		return -ENOENT;
+
+	/* Or, too many return instructions. */
+	if (ret > MAX_RET_INSNS)
+		return -E2BIG;
+
+	/* Allocate kprobes which probes the return instructions directly. */
+	nrets = ret;
+	khs = kcalloc(nrets, sizeof(struct kprobe_holder), GFP_KERNEL);
+	if (!khs)
+		return -ENOENT;
+
+	for (i = 0; i < nrets; i++) {
+		khs[i].kp.addr = rets[i];
+		khs[i].kp.flags = tk->rp.kp.flags;
+		khs[i].kp.post_handler = retinsn_dispatcher;
+		khs[i].tk = tk;
+		kpp[i] = &khs[i].kp;
+	}
+
+	ret = register_kprobes(kpp, nrets);
+	if (ret < 0) {
+		kfree(khs);
+		return ret;
+	}
+
+	tk->rp.kp.addr = trace_kprobe_address(tk);
+	tk->krets = khs;
+	tk->nr_krets = nrets;
+
+	return 0;
+}
+
 /* Internal register function - just handle k*probes and flags */
 static int __register_trace_kprobe(struct trace_kprobe *tk)
 {
@@ -505,7 +586,7 @@ static int __register_trace_kprobe(struct trace_kprobe *tk)
 		tk->rp.kp.flags |= KPROBE_FLAG_DISABLED;
 
 	if (trace_kprobe_is_return(tk))
-		ret = register_kretprobe(&tk->rp);
+		ret = register_retinsn_probe(tk);
 	else
 		ret = register_kprobe(&tk->rp.kp);
 
@@ -517,7 +598,7 @@ static void __unregister_trace_kprobe(struct trace_kprobe *tk)
 {
 	if (trace_kprobe_is_registered(tk)) {
 		if (trace_kprobe_is_return(tk))
-			unregister_kretprobe(&tk->rp);
+			unregister_retinsn_probe(tk);
 		else
 			unregister_kprobe(&tk->rp.kp);
 		/* Cleanup kprobe for reuse and mark it unregistered */
@@ -1744,6 +1825,25 @@ kretprobe_dispatcher(struct kretprobe_instance *ri, struct pt_regs *regs)
 }
 NOKPROBE_SYMBOL(kretprobe_dispatcher);
 
+static void retinsn_dispatcher(struct kprobe *kp, struct pt_regs *regs, unsigned long flags)
+{
+	struct kprobe_holder *kh = container_of(kp, struct kprobe_holder, kp);
+	struct trace_kprobe *tk = kh->tk;
+	struct kretprobe_instance ri;	/* dummy : to be fixed */
+
+	ri.ret_addr = (void *)instruction_pointer(regs);
+
+	raw_cpu_inc(*tk->nhit);
+
+	if (trace_probe_test_flag(&tk->tp, TP_FLAG_TRACE))
+		kretprobe_trace_func(tk, &ri, regs);
+#ifdef CONFIG_PERF_EVENTS
+	if (trace_probe_test_flag(&tk->tp, TP_FLAG_PROFILE))
+		kretprobe_perf_func(tk, &ri, regs);
+#endif
+}
+NOKPROBE_SYMBOL(retinsn_dispatcher);
+
 static struct trace_event_functions kretprobe_funcs = {
 	.trace		= print_kretprobe_event
 };

