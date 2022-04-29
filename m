Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137D0515003
	for <lists+bpf@lfdr.de>; Fri, 29 Apr 2022 17:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351842AbiD2P7O (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Apr 2022 11:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378265AbiD2P6y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Apr 2022 11:58:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB737E5A5;
        Fri, 29 Apr 2022 08:55:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17A616227D;
        Fri, 29 Apr 2022 15:55:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A2D5C385A4;
        Fri, 29 Apr 2022 15:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651247734;
        bh=5H1m+PANeiREygLLUVo29Iv9EzBOmGijZgNPp5bTZl8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=V7ti3crvkpK22lQFNJedNoHfpGYZw4+zLiVl9dtU6H8Tk72HlViE13ECfOApq8cBo
         FZXzZ920sVj8GnNb7r1hSn92dwCqgFfvv9XMOY+1g+uGiloV33bLi/bk3CLe4MUeC+
         0nZ3o2Gxy+Dgpn8Rg5VUUx0GafBYyjFqyuhiLU2HchzHTaws3hufzjU5Mqope7xflK
         k9Qf3BX1VsHul33dqxX+gnI7Cn5rXvBX94eG3jazJcjnpMpoGeYuJ26x6156RWTfQk
         mJnyBDFylPGKBu3bnTxA5skScFawuR9NDDOuIPE6E2jh11W5DFtdbQUk/gn/8BC/em
         pyM8EmzJphjRw==
Date:   Sat, 30 Apr 2022 00:55:27 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Shubham Bansal <illusionist.neo@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        kernel-team@fb.com, Jiri Olsa <jolsa@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH bpf v2 4/4] arm64: rethook: Replace kretprobe trampoline
 with rethook
Message-Id: <20220430005527.80aadc7069dd92f7801df389@kernel.org>
In-Reply-To: <YlXNPEZ18RPfjsd6@FVFF77S0Q05N.cambridge.arm.com>
References: <164937903547.1272679.7244379141135199176.stgit@devnote2>
        <164937908437.1272679.6436265245953600367.stgit@devnote2>
        <YlXNPEZ18RPfjsd6@FVFF77S0Q05N.cambridge.arm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Mark,

Thanks for the comment, and sorry about late reply.

On Tue, 12 Apr 2022 20:04:28 +0100
Mark Rutland <mark.rutland@arm.com> wrote:

> > diff --git a/arch/arm64/kernel/rethook.c b/arch/arm64/kernel/rethook.c
> > new file mode 100644
> > index 000000000000..07d8f6ea34a0
> > --- /dev/null
> > +++ b/arch/arm64/kernel/rethook.c
> > @@ -0,0 +1,28 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Generic return hook for arm64.
> > + * Most of the code is copied from arch/arm64/kernel/probes/kprobes.c
> > + */
> > +
> > +#include <linux/kprobes.h>
> > +#include <linux/rethook.h>
> > +
> > +/* This is called from arch_rethook_trampoline() */
> > +unsigned long __used arch_rethook_trampoline_callback(struct pt_regs *regs);
> > +
> > +unsigned long __used arch_rethook_trampoline_callback(struct pt_regs *regs)
> > +{
> > +	return rethook_trampoline_handler(regs, regs->regs[29]);
> > +}
> > +NOKPROBE_SYMBOL(arch_rethook_trampoline_callback);
> > +
> > +int arch_rethook_prepare(struct rethook_node *rhn, struct pt_regs *regs, bool mcount)
> 
> What's the `mcount` paramater for, and why don't we seem to use it below?
> 
> The presence of that parameter suggests there is a subtle interaction with
> ftrace, but the commit message doesn't mention anything of the sort. I really
> worried that has implications for the unwinder.

mcount parameter is introduced only for arm arch at this point. Other arch will
ignore this parameter. See [3/4] for details. When the rethook caller (ftrace
or kprobe) hooks the function entry, how to get the real return address depends
on whether it is called from ftrace (mcount) or kprobe.
By kprobe, that is called from the first instruction of the function. Thus the
real return address can be found from regs->lr. But from the ftrace (mcount)
context, we can not find it from regs->lr (this LR register is used for saving
the return address of mcount itself) on arm. On arm64, this seems to be fixed.
So I'm not sure this is a real issue on arm or known limitation.

> 
> I also see that (with these patches applied) it's possible to select
> CONFIG_FPROBE, but the commit message doesn't describe that either, and I'm not
> sure how to test any of that.

Ah, Sorry. Fprobe requires this feature, so HAVE_RETHOOK=y, CONFIG_FPROBE is
available on this architecture. If you enable CONFIG_FPROBE_SANITY_TEST=y,
this feature is tested by fprobe.

> 
> > +{
> > +	rhn->ret_addr = regs->regs[30];
> > +	rhn->frame = regs->regs[29];
> > +
> > +	/* replace return addr (x30) with trampoline */
> > +	regs->regs[30] = (u64)arch_rethook_trampoline;
> > +	return 0;
> > +}
> > +NOKPROBE_SYMBOL(arch_rethook_prepare);
> > diff --git a/arch/arm64/kernel/rethook_trampoline.S b/arch/arm64/kernel/rethook_trampoline.S
> > new file mode 100644
> > index 000000000000..146d4553674c
> > --- /dev/null
> > +++ b/arch/arm64/kernel/rethook_trampoline.S
> > @@ -0,0 +1,87 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * trampoline entry and return code for rethook.
> > + * Renamed from arch/arm64/kernel/probes/kprobes_trampoline.S
> > + */
> > +
> > +#include <linux/linkage.h>
> > +#include <asm/asm-offsets.h>
> > +#include <asm/assembler.h>
> > +
> > +	.text
> > +
> > +	.macro	save_all_base_regs
> > +	stp x0, x1, [sp, #S_X0]
> > +	stp x2, x3, [sp, #S_X2]
> > +	stp x4, x5, [sp, #S_X4]
> > +	stp x6, x7, [sp, #S_X6]
> > +	stp x8, x9, [sp, #S_X8]
> > +	stp x10, x11, [sp, #S_X10]
> > +	stp x12, x13, [sp, #S_X12]
> > +	stp x14, x15, [sp, #S_X14]
> > +	stp x16, x17, [sp, #S_X16]
> > +	stp x18, x19, [sp, #S_X18]
> > +	stp x20, x21, [sp, #S_X20]
> > +	stp x22, x23, [sp, #S_X22]
> > +	stp x24, x25, [sp, #S_X24]
> > +	stp x26, x27, [sp, #S_X26]
> > +	stp x28, x29, [sp, #S_X28]
> > +	add x0, sp, #PT_REGS_SIZE
> > +	stp lr, x0, [sp, #S_LR]
> > +	/*
> > +	 * Construct a useful saved PSTATE
> > +	 */
> > +	mrs x0, nzcv
> > +	mrs x1, daif
> > +	orr x0, x0, x1
> > +	mrs x1, CurrentEL
> > +	orr x0, x0, x1
> > +	mrs x1, SPSel
> > +	orr x0, x0, x1
> 
> I realise this is just a copy of the existing kretprobe code, but it would be
> *really* nice if we could avoid faking the regs when we don't take an
> exception, like the FTRACE_WITH_ARGS thing.

No, since this is not a "function call". This is function exit, thus the
all registers can be involved.

> 
> The "useful saved PSTATE" is getting increasingly bogus these days, since it
> doesn't contain a bunch of values that are in the real PSTATE, and we don't
> restore anything other than NZCV anyway.

Hmm, that is a real bug. It should be fixed even without this patch, on kretprobes.
Are there any good way to store those flags in the real PSTATE?

I need arm64 maintainer's help to fix that. If there is a limitation of getting
the PSTATE, I need to decide to
- use kprobe instead of hand-assembly code (like powerpc) to hook the trampoline.
or
- just notice users this is a limitation of kretprobe on arm64.


> 
> > +	stp xzr, x0, [sp, #S_PC]
> > +	.endm
> > +
> > +	.macro	restore_all_base_regs
> > +	ldr x0, [sp, #S_PSTATE]
> > +	and x0, x0, #(PSR_N_BIT | PSR_Z_BIT | PSR_C_BIT | PSR_V_BIT)
> > +	msr nzcv, x0
> > +	ldp x0, x1, [sp, #S_X0]
> > +	ldp x2, x3, [sp, #S_X2]
> > +	ldp x4, x5, [sp, #S_X4]
> > +	ldp x6, x7, [sp, #S_X6]
> > +	ldp x8, x9, [sp, #S_X8]
> > +	ldp x10, x11, [sp, #S_X10]
> > +	ldp x12, x13, [sp, #S_X12]
> > +	ldp x14, x15, [sp, #S_X14]
> > +	ldp x16, x17, [sp, #S_X16]
> > +	ldp x18, x19, [sp, #S_X18]
> > +	ldp x20, x21, [sp, #S_X20]
> > +	ldp x22, x23, [sp, #S_X22]
> > +	ldp x24, x25, [sp, #S_X24]
> > +	ldp x26, x27, [sp, #S_X26]
> > +	ldp x28, x29, [sp, #S_X28]
> > +	.endm
> > +
> > +SYM_CODE_START(arch_rethook_trampoline)
> > +	sub sp, sp, #PT_REGS_SIZE
> > +
> > +	save_all_base_regs
> > +
> > +	/* Setup a frame pointer. */
> > +	add x29, sp, #S_FP
> > +
> > +	mov x0, sp
> > +	bl arch_rethook_trampoline_callback
> > +	/*
> > +	 * Replace trampoline address in lr with actual orig_ret_addr return
> > +	 * address.
> > +	 */
> > +	mov lr, x0
> > +
> > +	/* The frame pointer (x29) is restored with other registers. */
> > +	restore_all_base_regs
> > +
> > +	add sp, sp, #PT_REGS_SIZE
> > +	ret
> > +
> > +SYM_CODE_END(arch_rethook_trampoline)
> > diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
> > index e4103e085681..5b717af4b555 100644
> > --- a/arch/arm64/kernel/stacktrace.c
> > +++ b/arch/arm64/kernel/stacktrace.c
> > @@ -8,6 +8,7 @@
> >  #include <linux/export.h>
> >  #include <linux/ftrace.h>
> >  #include <linux/kprobes.h>
> > +#include <linux/rethook.h>
> >  #include <linux/sched.h>
> >  #include <linux/sched/debug.h>
> >  #include <linux/sched/task_stack.h>
> > @@ -38,7 +39,7 @@ static notrace void start_backtrace(struct stackframe *frame, unsigned long fp,
> >  {
> >  	frame->fp = fp;
> >  	frame->pc = pc;
> > -#ifdef CONFIG_KRETPROBES
> > +#if defined(CONFIG_RETHOOK)
> >  	frame->kr_cur = NULL;
> >  #endif
> >  
> > @@ -134,9 +135,9 @@ static int notrace unwind_frame(struct task_struct *tsk,
> >  		frame->pc = orig_pc;
> >  	}
> >  #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
> > -#ifdef CONFIG_KRETPROBES
> > -	if (is_kretprobe_trampoline(frame->pc))
> > -		frame->pc = kretprobe_find_ret_addr(tsk, (void *)frame->fp, &frame->kr_cur);
> > +#ifdef CONFIG_RETHOOK
> > +	if (is_rethook_trampoline(frame->pc))
> > +		frame->pc = rethook_find_ret_addr(tsk, frame->fp, &frame->kr_cur);
> >  #endif
> 
> Is it possible to have an fprobe and a regular ftrace graph caller call on the
> same ftrace callsite? ... or are those mutually exclusive?

Hmm, those are too different at this moment, but I would like to do that.
What I would like to do is
- if the arch has no ftrace-graph implementation, rethook will use the
  kretprobe trampoline based implementation. This can drop some events
  because of the resource limitation.
- else, it will use ftrace-graph implementation. This can be very effective
  in some case (like tracing frequently called function) because it uses
  par-task shadow stack. But not many arch implemented it.
- Also, the interface needs to be unified. Rethook API is intended to be
  used for the integration. kretprobe and fprobe will use the rethook, thus
  the pt_regs is required.

> 
> The existing code here depends on kretprobes and ftrace graph caller
> instrumentation nesting in a specific order, and I'm worried that might have
> changed.

Would you mean that the "nesting" is using kretprobe and ftrace-graph on
same function, correct?
At this moment, this rethook (kretprobe and fprobe) does not use the same
shadow stack of the ftrace graph caller, so the nesting must work correctly.

Thank you,

> 
> Thanks,
> Mark.


-- 
Masami Hiramatsu <mhiramat@kernel.org>
