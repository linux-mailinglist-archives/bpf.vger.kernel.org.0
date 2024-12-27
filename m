Return-Path: <bpf+bounces-47667-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 813D79FD564
	for <lists+bpf@lfdr.de>; Fri, 27 Dec 2024 16:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 703D77A2565
	for <lists+bpf@lfdr.de>; Fri, 27 Dec 2024 15:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F781F866B;
	Fri, 27 Dec 2024 15:13:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274CE1F76BD;
	Fri, 27 Dec 2024 15:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735312382; cv=none; b=jmkMLGuCsws0PzTC0qbumx6IWK0QGuE5VWHbqyjW1zV5GZ/PUMB0jto53+ME/zycIOA+jCvABXg8KGubxBrTjyC2qKlzhoKGPztBeA/U8KpNz3MlbBiCFxjvgjtnRZRGXnOI9gIV0blVevpvIKHZijBAj6L3LzQUqcQnOzDmclc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735312382; c=relaxed/simple;
	bh=fpvJn/qg/zJZnNLIZ4p18NHSLfHWXdhJR9BoJO0Vf7g=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ItCxNKaVTi76rRkOa7yfcvDenBdTO9zcg621ZF6VtHfpKfzGnfQ6zDVto2HZCY0jp8UcQntZHVsTO5NNJYmlBz9lZ1EFCyYykamuHSc1iD3fi7QgUag62+iEN8SRoKlrvpPOinMEgAxteT6L03Pm5BSViAR/T9IkG8OyK/8p57Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1846EC2BCB5;
	Fri, 27 Dec 2024 15:13:01 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tRC2M-0000000GxXO-2Ukh;
	Fri, 27 Dec 2024 10:14:02 -0500
Message-ID: <20241227151402.443592487@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 27 Dec 2024 10:13:46 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Florent Revest <revest@chromium.org>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>,
 Alan Maguire <alan.maguire@oracle.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>
Subject: [for-next][PATCH 11/18] s390/tracing: Enable HAVE_FTRACE_GRAPH_FUNC
References: <20241227151335.898746489@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Sven Schnelle <svens@linux.ibm.com>

Add ftrace_graph_func() which is required for fprobe to access registers.
This also eliminates the need for calling prepare_ftrace_return() from
ftrace_caller().

Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Florent Revest <revest@chromium.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf <bpf@vger.kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Link: https://lore.kernel.org/173519002875.391279.7060964632119674159.stgit@devnote2
Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
Acked-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 arch/s390/Kconfig              |  1 +
 arch/s390/include/asm/ftrace.h |  5 ++++
 arch/s390/kernel/entry.h       |  1 -
 arch/s390/kernel/ftrace.c      | 48 ++++++++++------------------------
 arch/s390/kernel/mcount.S      | 11 --------
 5 files changed, 20 insertions(+), 46 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index d8eee56c10b6..622ea2e9a87e 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -190,6 +190,7 @@ config S390
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
 	select HAVE_GUP_FAST
 	select HAVE_FENTRY
+	select HAVE_FTRACE_GRAPH_FUNC
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_FUNCTION_ARG_ACCESS_API
 	select HAVE_FUNCTION_ERROR_INJECTION
diff --git a/arch/s390/include/asm/ftrace.h b/arch/s390/include/asm/ftrace.h
index 5b7cb49c41ee..fd3f0fe9f7b3 100644
--- a/arch/s390/include/asm/ftrace.h
+++ b/arch/s390/include/asm/ftrace.h
@@ -39,6 +39,7 @@ struct dyn_arch_ftrace { };
 
 struct module;
 struct dyn_ftrace;
+struct ftrace_ops;
 
 bool ftrace_need_init_nop(void);
 #define ftrace_need_init_nop ftrace_need_init_nop
@@ -122,6 +123,10 @@ static inline bool arch_syscall_match_sym_name(const char *sym,
 	return !strcmp(sym + 7, name) || !strcmp(sym + 8, name);
 }
 
+void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
+		       struct ftrace_ops *op, struct ftrace_regs *fregs);
+#define ftrace_graph_func ftrace_graph_func
+
 #endif /* __ASSEMBLY__ */
 
 #ifdef CONFIG_FUNCTION_TRACER
diff --git a/arch/s390/kernel/entry.h b/arch/s390/kernel/entry.h
index 21969520f947..a1f28879c87e 100644
--- a/arch/s390/kernel/entry.h
+++ b/arch/s390/kernel/entry.h
@@ -41,7 +41,6 @@ void do_restart(void *arg);
 void __init startup_init(void);
 void die(struct pt_regs *regs, const char *str);
 int setup_profiling_timer(unsigned int multiplier);
-unsigned long prepare_ftrace_return(unsigned long parent, unsigned long sp, unsigned long ip);
 
 struct s390_mmap_arg_struct;
 struct fadvise64_64_args;
diff --git a/arch/s390/kernel/ftrace.c b/arch/s390/kernel/ftrace.c
index 51439a71e392..c0b2c97efefb 100644
--- a/arch/s390/kernel/ftrace.c
+++ b/arch/s390/kernel/ftrace.c
@@ -261,43 +261,23 @@ void ftrace_arch_code_modify_post_process(void)
 }
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
-/*
- * Hook the return address and push it in the stack of return addresses
- * in current thread info.
- */
-unsigned long prepare_ftrace_return(unsigned long ra, unsigned long sp,
-				    unsigned long ip)
-{
-	if (unlikely(ftrace_graph_is_dead()))
-		goto out;
-	if (unlikely(atomic_read(&current->tracing_graph_pause)))
-		goto out;
-	ip -= MCOUNT_INSN_SIZE;
-	if (!function_graph_enter(ra, ip, 0, (void *) sp))
-		ra = (unsigned long) return_to_handler;
-out:
-	return ra;
-}
-NOKPROBE_SYMBOL(prepare_ftrace_return);
 
-/*
- * Patch the kernel code at ftrace_graph_caller location. The instruction
- * there is branch relative on condition. To enable the ftrace graph code
- * block, we simply patch the mask field of the instruction to zero and
- * turn the instruction into a nop.
- * To disable the ftrace graph code the mask field will be patched to
- * all ones, which turns the instruction into an unconditional branch.
- */
-int ftrace_enable_ftrace_graph_caller(void)
+void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
+		       struct ftrace_ops *op, struct ftrace_regs *fregs)
 {
-	/* Expect brc 0xf,... */
-	return ftrace_patch_branch_mask(ftrace_graph_caller, 0xa7f4, false);
-}
+	unsigned long *parent = &arch_ftrace_regs(fregs)->regs.gprs[14];
+	int bit;
 
-int ftrace_disable_ftrace_graph_caller(void)
-{
-	/* Expect brc 0x0,... */
-	return ftrace_patch_branch_mask(ftrace_graph_caller, 0xa704, true);
+	if (unlikely(ftrace_graph_is_dead()))
+		return;
+	if (unlikely(atomic_read(&current->tracing_graph_pause)))
+		return;
+	bit = ftrace_test_recursion_trylock(ip, *parent);
+	if (bit < 0)
+		return;
+	if (!function_graph_enter_regs(*parent, ip, 0, parent, fregs))
+		*parent = (unsigned long)&return_to_handler;
+	ftrace_test_recursion_unlock(bit);
 }
 
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
diff --git a/arch/s390/kernel/mcount.S b/arch/s390/kernel/mcount.S
index 2b628aa3d809..1fec370fecf4 100644
--- a/arch/s390/kernel/mcount.S
+++ b/arch/s390/kernel/mcount.S
@@ -104,17 +104,6 @@ SYM_CODE_START(ftrace_common)
 	lgr	%r3,%r14
 	la	%r5,STACK_FREGS(%r15)
 	BASR_EX	%r14,%r1
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
-# The j instruction gets runtime patched to a nop instruction.
-# See ftrace_enable_ftrace_graph_caller.
-SYM_INNER_LABEL(ftrace_graph_caller, SYM_L_GLOBAL)
-	j	.Lftrace_graph_caller_end
-	lmg	%r2,%r3,(STACK_FREGS_PTREGS_GPRS+14*8)(%r15)
-	lg	%r4,(STACK_FREGS_PTREGS_PSW+8)(%r15)
-	brasl	%r14,prepare_ftrace_return
-	stg	%r2,(STACK_FREGS_PTREGS_GPRS+14*8)(%r15)
-.Lftrace_graph_caller_end:
-#endif
 	lg	%r0,(STACK_FREGS_PTREGS_PSW+8)(%r15)
 #ifdef MARCH_HAS_Z196_FEATURES
 	ltg	%r1,STACK_FREGS_PTREGS_ORIG_GPR2(%r15)
-- 
2.45.2



