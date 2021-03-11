Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0A953369EB
	for <lists+bpf@lfdr.de>; Thu, 11 Mar 2021 02:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbhCKByo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Mar 2021 20:54:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:35564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229483AbhCKBym (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Mar 2021 20:54:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 051E264DD1;
        Thu, 11 Mar 2021 01:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615427682;
        bh=IfzsfOitPrwLeGojJ6pZ8/YMYEJqzCh715+wQiVOIJI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uT9vnpy/L6HQyZ5uMtMX8G6OxfAeKN2z1nMGdRCBkiQMlTFHihfew53N7Nd7GbJjd
         JCQE3TV4z4YdCQwURysOcU2I3fTouqAv3OxDns7ob4mNlHAAN8STcGNTh9/t0oI8Xi
         tap4YryV7nJsd/w7mg09thRMSNVF8C3GkZBAKmOFKL7bLHO7xfe/CqfnzXBpqXB4Aq
         hKJen0j0IXmO3BY5xAkuTwbYiwrj3btQEsQ+Icg5S/O9HrTEYv9lpJe8ghwVlwI0TY
         coKHtMsk9BI8vKU9bm9wEKeFyoyi+CQJzy0NN2X2sOFOJueLYE2BYwDhqNVOTuGEh5
         F9zruhwnMh0aQ==
Date:   Thu, 11 Mar 2021 10:54:38 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Daniel Xu <dxu@dxuuu.xyz>, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kuba@kernel.org,
        mingo@redhat.com, ast@kernel.org, tglx@linutronix.de,
        kernel-team@fb.com, yhs@fb.com
Subject: Re: [PATCH -tip 0/5] kprobes: Fix stacktrace in kretprobes
Message-Id: <20210311105438.cca15ed7645c454294dc3e1f@kernel.org>
In-Reply-To: <20210311010615.7pemfngxx7cy42fe@treble>
References: <20210305191645.njvrsni3ztvhhvqw@maharaja.localdomain>
        <20210306101357.6f947b063a982da9c949f1ba@kernel.org>
        <20210307212333.7jqmdnahoohpxabn@maharaja.localdomain>
        <20210308115210.732f2c42bf347c15fbb2a828@kernel.org>
        <20210309011945.ky7v3pnbdpxhmxkh@treble>
        <20210310185734.332d9d52a26780ba02d09197@kernel.org>
        <20210310150845.7kctaox34yrfyjxt@treble>
        <20210311005509.0a1a65df0d2d6c7da73a9288@kernel.org>
        <20210310183113.xxverwh4qplr7xxb@treble>
        <20210311092018.2d0e54d2c891850e549d16fe@kernel.org>
        <20210311010615.7pemfngxx7cy42fe@treble>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 10 Mar 2021 19:06:15 -0600
Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> On Thu, Mar 11, 2021 at 09:20:18AM +0900, Masami Hiramatsu wrote:
> > > >  bool unwind_next_frame(struct unwind_state *state)
> > > >  {
> > > >  	unsigned long ip_p, sp, tmp, orig_ip = state->ip, prev_sp = state->sp;
> > > > @@ -536,6 +561,18 @@ bool unwind_next_frame(struct unwind_state *state)
> > > >  
> > > >  		state->ip = ftrace_graph_ret_addr(state->task, &state->graph_idx,
> > > >  						  state->ip, (void *)ip_p);
> > > > +		/*
> > > > +		 * There are special cases when the stack unwinder is called
> > > > +		 * from the kretprobe handler or the interrupt handler which
> > > > +		 * occurs in the kretprobe trampoline code. In those cases,
> > > > +		 * %sp is shown on the stack instead of the return address.
> > > > +		 * Or, when the unwinder find the return address is replaced
> > > > +		 * by kretprobe_trampoline.
> > > > +		 * In those cases, correct address can be found in kretprobe.
> > > > +		 */
> > > > +		if (state->ip == sp ||
> > > 
> > > Why is the 'state->ip == sp' needed?
> > 
> > As I commented above, until kretprobe_trampoline writes back the real
> > address to the stack, sp value is there (which has been pushed by the
> > 'pushq %rsp' at the entry of kretprobe_trampoline.)
> > 
> >         ".type kretprobe_trampoline, @function\n"
> >         "kretprobe_trampoline:\n"
> >         /* We don't bother saving the ss register */
> >         "       pushq %rsp\n"				// THIS
> >         "       pushfq\n"
> > 
> > Thus, from inside the kretprobe handler, like ftrace, you'll see
> > the sp value instead of the real return address.
> 
> I see.  If you change is_kretprobe_trampoline_address() to include the
> entire function, like:
> 
> static bool is_kretprobe_trampoline_address(unsigned long ip)
> {
> 	return (void *)ip >= kretprobe_trampoline &&
> 	       (void *)ip < kretprobe_trampoline_end;
> }
> 
> then the unwinder won't ever read the bogus %rsp value into state->ip,
> and the 'state->ip == sp' check can be removed.

Hmm, I couldn't get your point. Since sp is the address of stack,
it always out of text address.

> 
> > > And it would make the unwinder just work automatically when unwinding
> > > from the handler using the regs.
> > > 
> > > It would also work when unwinding from the handler's stack, if we put an
> > > UNWIND_HINT_REGS after saving the regs.
> > 
> > At that moment, the real return address is not identified. So we can not
> > put it.
> 
> True, at the time the regs are originally saved, the real return address
> isn't available.  But by the time the user handler is called, the return
> address *is* available.  So if the real return address were placed in
> regs->ip before calling the handler, the unwinder could find it there,
> when called from the handler.

OK, but this is not arch independent specification. I can make a hack
only for x86, but that is not clean implementation, hmm.

> 
> Then we wouldn't need the call to orc_kretprobe_correct_ip() in
> __unwind_start().

What about the ORC implementation in other architecture? Is that for x86 only?

> 
> But maybe it's not possible due to the regs->ip expectations of legacy
> handlers?

Usually, the legacy handlers will ignore it, the official way to access
the correct return address is kretprobe_instance.ret_addr. Because it is
arch independent.

Nowadays there are instruction_pointer() and instruction_pointer_set() APIs
in many (not all) architecutre, so I can try to replace to use it instead
of the kretprobe_instance.ret_addr.
(and it will break the out-of-tree codes)


Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
