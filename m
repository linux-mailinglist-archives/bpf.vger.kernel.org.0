Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3CD689E67
	for <lists+bpf@lfdr.de>; Fri,  3 Feb 2023 16:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbjBCPhz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Feb 2023 10:37:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbjBCPhy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Feb 2023 10:37:54 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DE2B96C10B;
        Fri,  3 Feb 2023 07:37:52 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D9D0CC14;
        Fri,  3 Feb 2023 07:38:34 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.90.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 16A553F71E;
        Fri,  3 Feb 2023 07:37:49 -0800 (PST)
Date:   Fri, 3 Feb 2023 15:37:47 +0000
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
Message-ID: <Y90qS5jTog2m6YhQ@FVFF77S0Q05N>
References: <20230201163420.1579014-1-revest@chromium.org>
 <20230201163420.1579014-7-revest@chromium.org>
 <Y9wI93m2frDFGFez@FVFF77S0Q05N.cambridge.arm.com>
 <CABRcYmKRoDeFecvj7e+0SUaoinUa7FdtG1fmYqkRS3YPXVw4-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABRcYmKRoDeFecvj7e+0SUaoinUa7FdtG1fmYqkRS3YPXVw4-w@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 03, 2023 at 01:35:00PM +0100, Florent Revest wrote:
> On Thu, Feb 2, 2023 at 8:03 PM Mark Rutland <mark.rutland@arm.com> wrote:
> > I think it'd be much better to do something like the below as a preparatory
> > cleanup (tested on s390 under QEMU).
> 
> Thanks, that looks great to me. I'll make it a part of the series in v2 then.
> Unless it's preferred that this gets merged separately?

I reckon put it in the series for v2, and if Steve or Masami want to pick it up
beforehand, they can choose to do so from there?

Since it's not currently exploding, I suspect it's not urgent.

Mark.

> 
> > Thanks,
> > Mark.
> >
> > ---->8----
> > From 3b3abc89fe014ea49282622c4312521b710d1463 Mon Sep 17 00:00:00 2001
> > From: Mark Rutland <mark.rutland@arm.com>
> > Date: Thu, 2 Feb 2023 18:37:40 +0000
> > Subject: [PATCH] ftrace: selftest: remove broken trace_direct_tramp
> >
> > The ftrace selftest code has a trace_direct_tramp() function which it
> > uses as a direct call trampoline. This happens to work on x86, since the
> > direct call's return address is in the usual place, and can be returned
> > to via a RET, but in general the calling convention for direct calls is
> > different from regular function calls, and requires a trampoline written
> > in assembly.
> >
> > On s390, regular function calls place the return address in %r14, and an
> > ftrace patch-site in an instrumented function places the trampoline's
> > return address (which is within the instrumented function) in %r0,
> > preserving the original %r14 value in-place. As a regular C function
> > will return to the address in %r14, using a C function as the trampoline
> > results in the trampoline returning to the caller of the instrumented
> > function, skipping the body of the instrumented function.
> >
> > Note that the s390 issue is not detcted by the ftrace selftest code, as
> > the instrumented function is trivial, and returning back into the caller
> > happens to be equivalent.
> >
> > On arm64, regular function calls place the return address in x30, and
> > an ftrace patch-site in an instrumented function saves this into r9
> > and places the trampoline's return address (within the instrumented
> > function) in x30. A regular C function will return to the address in
> > x30, but will not restore x9 into x30. Consequently, using a C function
> > as the trampoline results in returning to the trampoline's return
> > address having corrupted x30, such that when the instrumented function
> > returns, it will return back into itself.
> >
> > To avoid future issues in this area, remove the trace_direct_tramp()
> > function, and require that each architecture with direct calls provides
> > a stub trampoline, named ftrace_stub_direct_tramp. This can be written
> > to handle the architecture's trampoline calling convention, and in
> > future could be used elsewhere (e.g. in the ftrace ops sample, to
> > measure the overhead of direct calls), so we may as well always build it
> > in.
> >
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Cc: Li Huafei <lihuafei1@huawei.com>
> > Cc: Xu Kuohai <xukuohai@huawei.com>
> > Cc: Steven Rostedt (Google) <rostedt@goodmis.org>
> > Cc: Florent Revest <revest@chromium.org>
> > ---
> >  arch/s390/kernel/mcount.S     |  5 +++++
> >  arch/x86/kernel/ftrace_32.S   |  5 +++++
> >  arch/x86/kernel/ftrace_64.S   |  4 ++++
> >  include/linux/ftrace.h        |  2 ++
> >  kernel/trace/trace_selftest.c | 15 ++-------------
> >  5 files changed, 18 insertions(+), 13 deletions(-)
> >
> > diff --git a/arch/s390/kernel/mcount.S b/arch/s390/kernel/mcount.S
> > index 4786bfe02144..ad13a0e2c307 100644
> > --- a/arch/s390/kernel/mcount.S
> > +++ b/arch/s390/kernel/mcount.S
> > @@ -32,6 +32,11 @@ ENTRY(ftrace_stub)
> >         BR_EX   %r14
> >  ENDPROC(ftrace_stub)
> >
> > +SYM_CODE_START(ftrace_stub_direct_tramp)
> > +       lgr     %r1, %r0
> > +       BR_EX   %r1
> > +SYM_CODE_END(ftrace_stub_direct_tramp)
> > +
> >         .macro  ftrace_regs_entry, allregs=0
> >         stg     %r14,(__SF_GPRS+8*8)(%r15)      # save traced function caller
> >
> > diff --git a/arch/x86/kernel/ftrace_32.S b/arch/x86/kernel/ftrace_32.S
> > index a0ed0e4a2c0c..0d9a14528176 100644
> > --- a/arch/x86/kernel/ftrace_32.S
> > +++ b/arch/x86/kernel/ftrace_32.S
> > @@ -163,6 +163,11 @@ SYM_INNER_LABEL(ftrace_regs_call, SYM_L_GLOBAL)
> >         jmp     .Lftrace_ret
> >  SYM_CODE_END(ftrace_regs_caller)
> >
> > +SYM_FUNC_START(ftrace_stub_direct_tramp)
> > +       CALL_DEPTH_ACCOUNT
> > +       RET
> > +SYM_FUNC_END(ftrace_stub_direct_tramp)
> > +
> >  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
> >  SYM_CODE_START(ftrace_graph_caller)
> >         pushl   %eax
> > diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
> > index 1265ad519249..8fc77e3e039c 100644
> > --- a/arch/x86/kernel/ftrace_64.S
> > +++ b/arch/x86/kernel/ftrace_64.S
> > @@ -307,6 +307,10 @@ SYM_INNER_LABEL(ftrace_regs_caller_end, SYM_L_GLOBAL)
> >  SYM_FUNC_END(ftrace_regs_caller)
> >  STACK_FRAME_NON_STANDARD_FP(ftrace_regs_caller)
> >
> > +SYM_FUNC_START(ftrace_stub_direct_tramp)
> > +       CALL_DEPTH_ACCOUNT
> > +       RET
> > +SYM_FUNC_END(ftrace_stub_direct_tramp)
> >
> >  #else /* ! CONFIG_DYNAMIC_FTRACE */
> >
> > diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> > index 3d2156e335d7..a9836b40630e 100644
> > --- a/include/linux/ftrace.h
> > +++ b/include/linux/ftrace.h
> > @@ -412,6 +412,8 @@ int unregister_ftrace_direct(struct ftrace_ops *ops, unsigned long addr);
> >  int modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr);
> >  int modify_ftrace_direct_nolock(struct ftrace_ops *ops, unsigned long addr);
> >
> > +void ftrace_stub_direct_tramp(void *);
> > +
> >  #else
> >  struct ftrace_ops;
> >  # define ftrace_direct_func_count 0
> > diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
> > index 06218fc9374b..e6530b7b42e4 100644
> > --- a/kernel/trace/trace_selftest.c
> > +++ b/kernel/trace/trace_selftest.c
> > @@ -784,17 +784,6 @@ static struct fgraph_ops fgraph_ops __initdata  = {
> >         .retfunc                = &trace_graph_return,
> >  };
> >
> > -#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
> > -#ifndef CALL_DEPTH_ACCOUNT
> > -#define CALL_DEPTH_ACCOUNT ""
> > -#endif
> > -
> > -noinline __noclone static void trace_direct_tramp(void)
> > -{
> > -       asm(CALL_DEPTH_ACCOUNT);
> > -}
> > -#endif
> > -
> >  /*
> >   * Pretty much the same than for the function tracer from which the selftest
> >   * has been borrowed.
> > @@ -875,7 +864,7 @@ trace_selftest_startup_function_graph(struct tracer *trace,
> >          */
> >         ftrace_set_filter_ip(&direct, (unsigned long)DYN_FTRACE_TEST_NAME, 0, 0);
> >         ret = register_ftrace_direct(&direct,
> > -                                    (unsigned long)trace_direct_tramp);
> > +                                    (unsigned long)ftrace_stub_direct_tramp);
> >         if (ret)
> >                 goto out;
> >
> > @@ -896,7 +885,7 @@ trace_selftest_startup_function_graph(struct tracer *trace,
> >         unregister_ftrace_graph(&fgraph_ops);
> >
> >         ret = unregister_ftrace_direct(&direct,
> > -                                      (unsigned long)trace_direct_tramp);
> > +                                      (unsigned long)ftrace_stub_direct_tramp);
> >         if (ret)
> >                 goto out;
> >
> > --
> > 2.30.2
> >
