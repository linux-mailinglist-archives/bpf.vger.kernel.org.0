Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 496563FC524
	for <lists+bpf@lfdr.de>; Tue, 31 Aug 2021 11:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234216AbhHaJvp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Aug 2021 05:51:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49784 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240734AbhHaJvf (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 31 Aug 2021 05:51:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630403440;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6i+vmebuDOOghhLAstCSS2o/gKVEVgaCIAFpYy/d7w4=;
        b=DRtVVAkQveF8RY3LWq78kHmOPTEA5ZyJlA/3fjz3cLut9aG2fLHEh0NRuYhsm06oSqBBXM
        lKnX9FhCSJcn55EfdYSeywstlbLkOzjl9PWwlgA8ABsXs9EJ07G2TcLVIR62SlNcuaDOX5
        rIlRRbdcabZrSA5XGTZr7UAExMsCQek=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-126-DApYzNlxN5iUGhGBmG4K3g-1; Tue, 31 Aug 2021 05:50:38 -0400
X-MC-Unique: DApYzNlxN5iUGhGBmG4K3g-1
Received: by mail-wr1-f70.google.com with SMTP id l1-20020adff481000000b00156e670a09dso3896222wro.1
        for <bpf@vger.kernel.org>; Tue, 31 Aug 2021 02:50:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6i+vmebuDOOghhLAstCSS2o/gKVEVgaCIAFpYy/d7w4=;
        b=p7nSx4MCPe5meXIHknwjk+QiaZ8YfgjDpa1zgPYVhToqY5iuXkBuxMfCnyo41P/xwq
         Sznw0Z4WYhYzYoL1oP4mfazWnwfiXDg1x75/aId3GWZVtCncE2B1fX9pI6lHNRr842ef
         ENudynVTnU0dOHkm4XAtNvsrOiF7Pmy3F5CWh7QCf7AMpVift4TLChm+4K21itpBz7LS
         9FIkJ+fVl23kjCvs87k27SN5NnHaotkjhfZoHTIjj044etRCNyk0jEB6WapZYt/EuHu+
         ENY9o5ZyB7Dg2cHRZ8zlFDKykaxaKaYkRVxRT17x0ey6vs8oKUTHhDGsu8jSNBhQpwNq
         2QuA==
X-Gm-Message-State: AOAM530sq9tdWJPRMnGN2XUJzEUK944C0jeUS7mQpWjlVctjWFUYJ4+P
        m3qnpwts52plk6tnqEtqRK06C0CkMObTqy3dNwuFIBE8bhYujnnpD3mUqgd0EMGjHnzM9AGLY+D
        LfuL/kY+MZnSM
X-Received: by 2002:a5d:4689:: with SMTP id u9mr30401973wrq.330.1630403437700;
        Tue, 31 Aug 2021 02:50:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyZje1w3zbpxcG3Pn/8Bstzk1Hrr/hQybjuNQDhGqMbyqhR6qxgEG0pi7+Q8BULAX8c1EXCYg==
X-Received: by 2002:a5d:4689:: with SMTP id u9mr30401947wrq.330.1630403437472;
        Tue, 31 Aug 2021 02:50:37 -0700 (PDT)
Received: from krava.redhat.com ([94.113.247.3])
        by smtp.gmail.com with ESMTPSA id t11sm2117512wmi.23.2021.08.31.02.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 02:50:37 -0700 (PDT)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Subject: [PATCH 3/8] x86/ftrace: Make function graph use ftrace directly
Date:   Tue, 31 Aug 2021 11:50:12 +0200
Message-Id: <20210831095017.412311-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210831095017.412311-1-jolsa@kernel.org>
References: <20210831095017.412311-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

We don't need special hook for graph tracer entry point,
but instead we can use graph_ops::func function to install
the return_hooker.

This moves the graph tracing setup _before_ the direct
trampoline prepares the stack, so the return_hooker will
be called when the direct trampoline is finished.

This simplifies the code, because we don't need to take into
account the direct trampoline setup when preparing the graph
tracer hooker and we can allow function graph tracer on entries
registered with direct trampoline.

[fixed compile error reported by kernel test robot <lkp@intel.com>]
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/include/asm/ftrace.h |  9 +++++++--
 arch/x86/kernel/ftrace.c      | 37 ++++++++++++++++++++++++++++++++---
 arch/x86/kernel/ftrace_64.S   | 29 +--------------------------
 include/linux/ftrace.h        |  9 +++++++++
 kernel/trace/fgraph.c         |  6 ++++--
 5 files changed, 55 insertions(+), 35 deletions(-)

diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
index 9f3130f40807..024d9797646e 100644
--- a/arch/x86/include/asm/ftrace.h
+++ b/arch/x86/include/asm/ftrace.h
@@ -57,6 +57,13 @@ arch_ftrace_get_regs(struct ftrace_regs *fregs)
 
 #define ftrace_instruction_pointer_set(fregs, _ip)	\
 	do { (fregs)->regs.ip = (_ip); } while (0)
+
+struct ftrace_ops;
+#define ftrace_graph_func ftrace_graph_func
+void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
+		       struct ftrace_ops *op, struct ftrace_regs *fregs);
+#else
+#define FTRACE_GRAPH_TRAMP_ADDR FTRACE_GRAPH_ADDR
 #endif
 
 #ifdef CONFIG_DYNAMIC_FTRACE
@@ -65,8 +72,6 @@ struct dyn_arch_ftrace {
 	/* No extra data needed for x86 */
 };
 
-#define FTRACE_GRAPH_TRAMP_ADDR FTRACE_GRAPH_ADDR
-
 #endif /*  CONFIG_DYNAMIC_FTRACE */
 #endif /* __ASSEMBLY__ */
 #endif /* CONFIG_FUNCTION_TRACER */
diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index c555624da989..804fcc6ef2c7 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -527,7 +527,7 @@ static void *addr_from_call(void *ptr)
 	return ptr + CALL_INSN_SIZE + call.disp;
 }
 
-void prepare_ftrace_return(unsigned long self_addr, unsigned long *parent,
+void prepare_ftrace_return(unsigned long ip, unsigned long *parent,
 			   unsigned long frame_pointer);
 
 /*
@@ -541,7 +541,8 @@ static void *static_tramp_func(struct ftrace_ops *ops, struct dyn_ftrace *rec)
 	void *ptr;
 
 	if (ops && ops->trampoline) {
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+#if !defined(CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS) && \
+	defined(CONFIG_FUNCTION_GRAPH_TRACER)
 		/*
 		 * We only know about function graph tracer setting as static
 		 * trampoline.
@@ -589,8 +590,9 @@ void arch_ftrace_trampoline_free(struct ftrace_ops *ops)
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 
 #ifdef CONFIG_DYNAMIC_FTRACE
-extern void ftrace_graph_call(void);
 
+#ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
+extern void ftrace_graph_call(void);
 static const char *ftrace_jmp_replace(unsigned long ip, unsigned long addr)
 {
 	return text_gen_insn(JMP32_INSN_OPCODE, (void *)ip, (void *)addr);
@@ -618,7 +620,17 @@ int ftrace_disable_ftrace_graph_caller(void)
 
 	return ftrace_mod_jmp(ip, &ftrace_stub);
 }
+#else /* !CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS */
+int ftrace_enable_ftrace_graph_caller(void)
+{
+	return 0;
+}
 
+int ftrace_disable_ftrace_graph_caller(void)
+{
+	return 0;
+}
+#endif /* CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS */
 #endif /* !CONFIG_DYNAMIC_FTRACE */
 
 /*
@@ -629,6 +641,7 @@ void prepare_ftrace_return(unsigned long ip, unsigned long *parent,
 			   unsigned long frame_pointer)
 {
 	unsigned long return_hooker = (unsigned long)&return_to_handler;
+	int bit;
 
 	/*
 	 * When resuming from suspend-to-ram, this function can be indirectly
@@ -648,7 +661,25 @@ void prepare_ftrace_return(unsigned long ip, unsigned long *parent,
 	if (unlikely(atomic_read(&current->tracing_graph_pause)))
 		return;
 
+	bit = ftrace_test_recursion_trylock(ip, *parent);
+	if (bit < 0)
+		return;
+
 	if (!function_graph_enter(*parent, ip, frame_pointer, parent))
 		*parent = return_hooker;
+
+	ftrace_test_recursion_unlock(bit);
+}
+
+#ifdef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
+void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
+		       struct ftrace_ops *op, struct ftrace_regs *fregs)
+{
+	struct pt_regs *regs = &fregs->regs;
+	unsigned long *stack = (unsigned long *)kernel_stack_pointer(regs);
+
+	prepare_ftrace_return(ip, (unsigned long *)stack, 0);
 }
+#endif
+
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index a8eb084a7a9a..7a879901f103 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -174,11 +174,6 @@ SYM_INNER_LABEL(ftrace_caller_end, SYM_L_GLOBAL)
 SYM_FUNC_END(ftrace_caller);
 
 SYM_FUNC_START(ftrace_epilogue)
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
-SYM_INNER_LABEL(ftrace_graph_call, SYM_L_GLOBAL)
-	jmp ftrace_stub
-#endif
-
 /*
  * This is weak to keep gas from relaxing the jumps.
  * It is also used to copy the retq for trampolines.
@@ -288,15 +283,6 @@ SYM_FUNC_START(__fentry__)
 	cmpq $ftrace_stub, ftrace_trace_function
 	jnz trace
 
-fgraph_trace:
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
-	cmpq $ftrace_stub, ftrace_graph_return
-	jnz ftrace_graph_caller
-
-	cmpq $ftrace_graph_entry_stub, ftrace_graph_entry
-	jnz ftrace_graph_caller
-#endif
-
 SYM_INNER_LABEL(ftrace_stub, SYM_L_GLOBAL)
 	retq
 
@@ -314,25 +300,12 @@ trace:
 	CALL_NOSPEC r8
 	restore_mcount_regs
 
-	jmp fgraph_trace
+	jmp ftrace_stub
 SYM_FUNC_END(__fentry__)
 EXPORT_SYMBOL(__fentry__)
 #endif /* CONFIG_DYNAMIC_FTRACE */
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
-SYM_FUNC_START(ftrace_graph_caller)
-	/* Saves rbp into %rdx and fills first parameter  */
-	save_mcount_regs
-
-	leaq MCOUNT_REG_SIZE+8(%rsp), %rsi
-	movq $0, %rdx	/* No framepointers needed */
-	call	prepare_ftrace_return
-
-	restore_mcount_regs
-
-	retq
-SYM_FUNC_END(ftrace_graph_caller)
-
 SYM_FUNC_START(return_to_handler)
 	subq  $24, %rsp
 
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index a69f363b61bf..d399621a67ee 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -779,6 +779,15 @@ static inline bool is_ftrace_trampoline(unsigned long addr)
 }
 #endif /* CONFIG_DYNAMIC_FTRACE */
 
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+#ifndef ftrace_graph_func
+#define ftrace_graph_func ftrace_stub
+#define FTRACE_OPS_GRAPH_STUB FTRACE_OPS_FL_STUB
+#else
+#define FTRACE_OPS_GRAPH_STUB 0
+#endif
+#endif /* CONFIG_FUNCTION_GRAPH_TRACER */
+
 /* totally disable ftrace - can not re-enable after this */
 void ftrace_kill(void);
 
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index b8a0d1d564fb..22061d38fc00 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -115,6 +115,7 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 {
 	struct ftrace_graph_ent trace;
 
+#ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
 	/*
 	 * Skip graph tracing if the return location is served by direct trampoline,
 	 * since call sequence and return addresses are unpredictable anyway.
@@ -124,6 +125,7 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 	if (ftrace_direct_func_count &&
 	    ftrace_find_rec_direct(ret - MCOUNT_INSN_SIZE))
 		return -EBUSY;
+#endif
 	trace.func = func;
 	trace.depth = ++current->curr_ret_depth;
 
@@ -333,10 +335,10 @@ unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
 #endif /* HAVE_FUNCTION_GRAPH_RET_ADDR_PTR */
 
 static struct ftrace_ops graph_ops = {
-	.func			= ftrace_stub,
+	.func			= ftrace_graph_func,
 	.flags			= FTRACE_OPS_FL_INITIALIZED |
 				   FTRACE_OPS_FL_PID |
-				   FTRACE_OPS_FL_STUB,
+				   FTRACE_OPS_GRAPH_STUB,
 #ifdef FTRACE_GRAPH_TRAMP_ADDR
 	.trampoline		= FTRACE_GRAPH_TRAMP_ADDR,
 	/* trampoline_size is only needed for dynamically allocated tramps */
-- 
2.31.1

