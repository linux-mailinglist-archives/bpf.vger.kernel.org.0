Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89AF4336887
	for <lists+bpf@lfdr.de>; Thu, 11 Mar 2021 01:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbhCKAUy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Mar 2021 19:20:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:48954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229459AbhCKAUZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Mar 2021 19:20:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5C10D64EE6;
        Thu, 11 Mar 2021 00:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615422025;
        bh=29A3tQmLUaVsH/VlOprQhZ4OraRU/blMhZzT0B8bXQU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WZECi1RxVRFYWjE+LGaAC3SyMy/4yH2uhjhMmliXi4M1WXtKKKIqGydZi1mRcD99k
         VjxKHFWvDi2DGGUVSKpqV6RlZBpgFFQz/MYVXyFcB2EjEYNKh90v4+YxCDPHa4o6UJ
         t0LVYGytBWq7tkDKe7HCf1pvwSFegP/pI/2pWTIt183Bf7leJ/taY10lrAfJplbxsU
         z5yqOnvkJQqvmnni5tWXvAysH+hhf3h9BxWGsZ1uf0UUyKCqwN0BMBZcQ6H3S+gqfA
         hUYpECcgJPvz84wuDN4+3D3pDgc3thrCjS0k+UzgkHo8DqLSsKPyn2oi0rDm3pO7Gg
         YMslQ63MFcQ4Q==
Date:   Thu, 11 Mar 2021 09:20:18 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Daniel Xu <dxu@dxuuu.xyz>, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kuba@kernel.org,
        mingo@redhat.com, ast@kernel.org, tglx@linutronix.de,
        kernel-team@fb.com, yhs@fb.com
Subject: Re: [PATCH -tip 0/5] kprobes: Fix stacktrace in kretprobes
Message-Id: <20210311092018.2d0e54d2c891850e549d16fe@kernel.org>
In-Reply-To: <20210310183113.xxverwh4qplr7xxb@treble>
References: <161495873696.346821.10161501768906432924.stgit@devnote2>
        <20210305191645.njvrsni3ztvhhvqw@maharaja.localdomain>
        <20210306101357.6f947b063a982da9c949f1ba@kernel.org>
        <20210307212333.7jqmdnahoohpxabn@maharaja.localdomain>
        <20210308115210.732f2c42bf347c15fbb2a828@kernel.org>
        <20210309011945.ky7v3pnbdpxhmxkh@treble>
        <20210310185734.332d9d52a26780ba02d09197@kernel.org>
        <20210310150845.7kctaox34yrfyjxt@treble>
        <20210311005509.0a1a65df0d2d6c7da73a9288@kernel.org>
        <20210310183113.xxverwh4qplr7xxb@treble>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 10 Mar 2021 12:31:13 -0600
Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> On Thu, Mar 11, 2021 at 12:55:09AM +0900, Masami Hiramatsu wrote:
> > +#ifdef CONFIG_KRETPROBES
> > +static unsigned long orc_kretprobe_correct_ip(struct unwind_state *state)
> > +{
> > +	return kretprobe_find_ret_addr(
> > +			(unsigned long)kretprobe_trampoline_addr(),
> > +			state->task, &state->kr_iter);
> > +}
> > +
> > +static bool is_kretprobe_trampoline_address(unsigned long ip)
> > +{
> > +	return ip == (unsigned long)kretprobe_trampoline_addr();
> > +}
> > +#else
> > +static unsigned long orc_kretprobe_correct_ip(struct unwind_state *state)
> > +{
> > +	return state->ip;
> > +}
> > +
> > +static bool is_kretprobe_trampoline_address(unsigned long ip)
> > +{
> > +	return false;
> > +}
> > +#endif
> > +
> 
> Can this code go in a kprobes file?  I'd rather not clutter ORC with it,
> and maybe it would be useful for other arches or unwinders.

Yes, anyway dummy kretprobe_find_ret_addr() and kretprobe_trampoline_addr()
should be defined !CONFIG_KRETPROBES case.

> 
> >  bool unwind_next_frame(struct unwind_state *state)
> >  {
> >  	unsigned long ip_p, sp, tmp, orig_ip = state->ip, prev_sp = state->sp;
> > @@ -536,6 +561,18 @@ bool unwind_next_frame(struct unwind_state *state)
> >  
> >  		state->ip = ftrace_graph_ret_addr(state->task, &state->graph_idx,
> >  						  state->ip, (void *)ip_p);
> > +		/*
> > +		 * There are special cases when the stack unwinder is called
> > +		 * from the kretprobe handler or the interrupt handler which
> > +		 * occurs in the kretprobe trampoline code. In those cases,
> > +		 * %sp is shown on the stack instead of the return address.
> > +		 * Or, when the unwinder find the return address is replaced
> > +		 * by kretprobe_trampoline.
> > +		 * In those cases, correct address can be found in kretprobe.
> > +		 */
> > +		if (state->ip == sp ||
> 
> Why is the 'state->ip == sp' needed?

As I commented above, until kretprobe_trampoline writes back the real
address to the stack, sp value is there (which has been pushed by the
'pushq %rsp' at the entry of kretprobe_trampoline.)

        ".type kretprobe_trampoline, @function\n"
        "kretprobe_trampoline:\n"
        /* We don't bother saving the ss register */
        "       pushq %rsp\n"				// THIS
        "       pushfq\n"

Thus, from inside the kretprobe handler, like ftrace, you'll see
the sp value instead of the real return address.

> > +		    is_kretprobe_trampoline_address(state->ip))
> > +			state->ip = orc_kretprobe_correct_ip(state);
> 
> This is similar in concept to ftrace_graph_ret_addr(), right?  Would it
> be possible to have a similar API?  Like
> 
> 		state->ip = kretprobe_ret_addr(state->task, &state->kr_iter, state->ip);

OK, but,

> and without the conditional.

As I said, it is not possible because "state->ip == sp" check depends on
ORC unwinder.

> >  		state->sp = sp;
> >  		state->regs = NULL;
> > @@ -649,6 +686,12 @@ void __unwind_start(struct unwind_state *state, struct task_struct *task,
> >  		state->full_regs = true;
> >  		state->signal = true;
> >  
> > +		/*
> > +		 * When the unwinder called with regs from kretprobe handler,
> > +		 * the regs->ip starts from kretprobe_trampoline address.
> > +		 */
> > +		if (is_kretprobe_trampoline_address(state->ip))
> > +			state->ip = orc_kretprobe_correct_ip(state);
> 
> Shouldn't __kretprobe_trampoline_handler() just set regs->ip to
> 'correct_ret_addr' before passing the regs to the handler?  I'd think
> that would be a less surprising value for regs->ip than
> '&kretprobe_trampoline'.

Hmm, actually current implementation on x86 mimics the behevior of
the int3 exception (which many architectures still do).

Previously the kretprobe_trampoline is a place holder like this.

        "kretprobe_trampoline:\n"
        "       nop\n"

And arch_init_kprobes() puts a kprobe (int3) there.
So in that case regs->ip should be kretprobe_trampoline.
User handler (usually architecutre independent) finds the
correct_ret_addr in kretprobe_instance.ret_addr field.

> And it would make the unwinder just work automatically when unwinding
> from the handler using the regs.
> 
> It would also work when unwinding from the handler's stack, if we put an
> UNWIND_HINT_REGS after saving the regs.

At that moment, the real return address is not identified. So we can not
put it.

> 
> The only (rare) case it wouldn't work would be unwinding from an
> interrupt before regs->ip gets set properly.  In which case we'd still
> need the above call to orc_kretprobe_correct_ip() or so.


Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
