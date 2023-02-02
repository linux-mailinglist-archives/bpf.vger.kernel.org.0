Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 025A068874D
	for <lists+bpf@lfdr.de>; Thu,  2 Feb 2023 20:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjBBTDa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Feb 2023 14:03:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbjBBTD3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Feb 2023 14:03:29 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 72D62305E6;
        Thu,  2 Feb 2023 11:03:27 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C1F7C14;
        Thu,  2 Feb 2023 11:04:09 -0800 (PST)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.27.141])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D0E293F8D6;
        Thu,  2 Feb 2023 11:03:24 -0800 (PST)
Date:   Thu, 2 Feb 2023 19:03:19 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Florent Revest <revest@chromium.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kpsingh@kernel.org, jolsa@kernel.org,
        xukuohai@huaweicloud.com, Xu Kuohai <xukuohai@huawei.com>,
        Li Huafei <lihuafei1@huawei.com>
Subject: Re: [PATCH 6/8] ftrace: Fix dead loop caused by direct call in
 ftrace selftest
Message-ID: <Y9wI93m2frDFGFez@FVFF77S0Q05N.cambridge.arm.com>
References: <20230201163420.1579014-1-revest@chromium.org>
 <20230201163420.1579014-7-revest@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201163420.1579014-7-revest@chromium.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 01, 2023 at 05:34:18PM +0100, Florent Revest wrote:
> From: Xu Kuohai <xukuohai@huawei.com>
> 
> After direct call is enabled for arm64, ftrace selftest enters a
> dead loop:
> 
> <trace_selftest_dynamic_test_func>:
> 00  bti     c
> 01  mov     x9, x30                            <trace_direct_tramp>:
> 02  bl      <trace_direct_tramp>    ---------->     ret
>                                                      |
>                                          lr/x30 is 03, return to 03
>                                                      |
> 03  mov     w0, #0x0   <-----------------------------|
>      |                                               |
>      |                   dead loop!                  |
>      |                                               |
> 04  ret   ---- lr/x30 is still 03, go back to 03 ----|
> 
> The reason is that when the direct caller trace_direct_tramp() returns
> to the patched function trace_selftest_dynamic_test_func(), lr is still
> the address after the instrumented instruction in the patched function,
> so when the patched function exits, it returns to itself!
> 
> To fix this issue, we need to restore lr before trace_direct_tramp()
> exits, so use a dedicated trace_direct_tramp() for arm64.
> 
> Reported-by: Li Huafei <lihuafei1@huawei.com>
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Signed-off-by: Florent Revest <revest@chromium.org>

Looking at this, I don't think that the existing trace_direct_tramp makes
sense -- in general a C function doesn't follow the direct call trampoline
calling convention, and cannot be used as a direct call trampoline.

Looking further, there's a distinct latent issue on s390, where the mismatch
between their regular calling convention and their direct call trampoline
calling convention means that trace_direct_tramp() returns into the *caller* of
the instrumented function, skipping that entirely (verified locally with QEMU
and printk()s added to DYN_FTRACE_TEST_NAME() / DYN_FTRACE_TEST_NAME2()
functions).

I think it'd be much better to do something like the below as a preparatory
cleanup (tested on s390 under QEMU).

Thanks,
Mark.

---->8----
From 3b3abc89fe014ea49282622c4312521b710d1463 Mon Sep 17 00:00:00 2001
From: Mark Rutland <mark.rutland@arm.com>
Date: Thu, 2 Feb 2023 18:37:40 +0000
Subject: [PATCH] ftrace: selftest: remove broken trace_direct_tramp

The ftrace selftest code has a trace_direct_tramp() function which it
uses as a direct call trampoline. This happens to work on x86, since the
direct call's return address is in the usual place, and can be returned
to via a RET, but in general the calling convention for direct calls is
different from regular function calls, and requires a trampoline written
in assembly.

On s390, regular function calls place the return address in %r14, and an
ftrace patch-site in an instrumented function places the trampoline's
return address (which is within the instrumented function) in %r0,
preserving the original %r14 value in-place. As a regular C function
will return to the address in %r14, using a C function as the trampoline
results in the trampoline returning to the caller of the instrumented
function, skipping the body of the instrumented function.

Note that the s390 issue is not detcted by the ftrace selftest code, as
the instrumented function is trivial, and returning back into the caller
happens to be equivalent.

On arm64, regular function calls place the return address in x30, and
an ftrace patch-site in an instrumented function saves this into r9
and places the trampoline's return address (within the instrumented
function) in x30. A regular C function will return to the address in
x30, but will not restore x9 into x30. Consequently, using a C function
as the trampoline results in returning to the trampoline's return
address having corrupted x30, such that when the instrumented function
returns, it will return back into itself.

To avoid future issues in this area, remove the trace_direct_tramp()
function, and require that each architecture with direct calls provides
a stub trampoline, named ftrace_stub_direct_tramp. This can be written
to handle the architecture's trampoline calling convention, and in
future could be used elsewhere (e.g. in the ftrace ops sample, to
measure the overhead of direct calls), so we may as well always build it
in.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Li Huafei <lihuafei1@huawei.com>
Cc: Xu Kuohai <xukuohai@huawei.com>
Cc: Steven Rostedt (Google) <rostedt@goodmis.org>
Cc: Florent Revest <revest@chromium.org>
---
 arch/s390/kernel/mcount.S     |  5 +++++
 arch/x86/kernel/ftrace_32.S   |  5 +++++
 arch/x86/kernel/ftrace_64.S   |  4 ++++
 include/linux/ftrace.h        |  2 ++
 kernel/trace/trace_selftest.c | 15 ++-------------
 5 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/arch/s390/kernel/mcount.S b/arch/s390/kernel/mcount.S
index 4786bfe02144..ad13a0e2c307 100644
--- a/arch/s390/kernel/mcount.S
+++ b/arch/s390/kernel/mcount.S
@@ -32,6 +32,11 @@ ENTRY(ftrace_stub)
 	BR_EX	%r14
 ENDPROC(ftrace_stub)
 
+SYM_CODE_START(ftrace_stub_direct_tramp)
+	lgr	%r1, %r0
+	BR_EX	%r1
+SYM_CODE_END(ftrace_stub_direct_tramp)
+
 	.macro	ftrace_regs_entry, allregs=0
 	stg	%r14,(__SF_GPRS+8*8)(%r15)	# save traced function caller
 
diff --git a/arch/x86/kernel/ftrace_32.S b/arch/x86/kernel/ftrace_32.S
index a0ed0e4a2c0c..0d9a14528176 100644
--- a/arch/x86/kernel/ftrace_32.S
+++ b/arch/x86/kernel/ftrace_32.S
@@ -163,6 +163,11 @@ SYM_INNER_LABEL(ftrace_regs_call, SYM_L_GLOBAL)
 	jmp	.Lftrace_ret
 SYM_CODE_END(ftrace_regs_caller)
 
+SYM_FUNC_START(ftrace_stub_direct_tramp)
+	CALL_DEPTH_ACCOUNT
+	RET
+SYM_FUNC_END(ftrace_stub_direct_tramp)
+
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 SYM_CODE_START(ftrace_graph_caller)
 	pushl	%eax
diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index 1265ad519249..8fc77e3e039c 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -307,6 +307,10 @@ SYM_INNER_LABEL(ftrace_regs_caller_end, SYM_L_GLOBAL)
 SYM_FUNC_END(ftrace_regs_caller)
 STACK_FRAME_NON_STANDARD_FP(ftrace_regs_caller)
 
+SYM_FUNC_START(ftrace_stub_direct_tramp)
+	CALL_DEPTH_ACCOUNT
+	RET
+SYM_FUNC_END(ftrace_stub_direct_tramp)
 
 #else /* ! CONFIG_DYNAMIC_FTRACE */
 
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 3d2156e335d7..a9836b40630e 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -412,6 +412,8 @@ int unregister_ftrace_direct(struct ftrace_ops *ops, unsigned long addr);
 int modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr);
 int modify_ftrace_direct_nolock(struct ftrace_ops *ops, unsigned long addr);
 
+void ftrace_stub_direct_tramp(void *);
+
 #else
 struct ftrace_ops;
 # define ftrace_direct_func_count 0
diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
index 06218fc9374b..e6530b7b42e4 100644
--- a/kernel/trace/trace_selftest.c
+++ b/kernel/trace/trace_selftest.c
@@ -784,17 +784,6 @@ static struct fgraph_ops fgraph_ops __initdata  = {
 	.retfunc		= &trace_graph_return,
 };
 
-#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
-#ifndef CALL_DEPTH_ACCOUNT
-#define CALL_DEPTH_ACCOUNT ""
-#endif
-
-noinline __noclone static void trace_direct_tramp(void)
-{
-	asm(CALL_DEPTH_ACCOUNT);
-}
-#endif
-
 /*
  * Pretty much the same than for the function tracer from which the selftest
  * has been borrowed.
@@ -875,7 +864,7 @@ trace_selftest_startup_function_graph(struct tracer *trace,
 	 */
 	ftrace_set_filter_ip(&direct, (unsigned long)DYN_FTRACE_TEST_NAME, 0, 0);
 	ret = register_ftrace_direct(&direct,
-				     (unsigned long)trace_direct_tramp);
+				     (unsigned long)ftrace_stub_direct_tramp);
 	if (ret)
 		goto out;
 
@@ -896,7 +885,7 @@ trace_selftest_startup_function_graph(struct tracer *trace,
 	unregister_ftrace_graph(&fgraph_ops);
 
 	ret = unregister_ftrace_direct(&direct,
-				       (unsigned long)trace_direct_tramp);
+				       (unsigned long)ftrace_stub_direct_tramp);
 	if (ret)
 		goto out;
 
-- 
2.30.2

