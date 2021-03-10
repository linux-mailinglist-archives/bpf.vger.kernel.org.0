Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25764333AB0
	for <lists+bpf@lfdr.de>; Wed, 10 Mar 2021 11:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbhCJKuz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Mar 2021 05:50:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:44994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230450AbhCJKum (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Mar 2021 05:50:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 75F8064FC4;
        Wed, 10 Mar 2021 10:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615373441;
        bh=+hwjUkc3aKzHKd1d/ppZeQNCLgMD1GbFQ/2v76DduBk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GH2/6emwcBNuGLikyTXbISk/7Cd7kztAzlwnaXTnIcjPRVMAkKdwUm7JJ3Dh/sHZV
         fEuuVspeBBoC8BpKJoSZaUTIn2qY1ecDYK8aruPg6JT0tv732CJg5iqjNgB6xWRD/t
         +qXJfdCE9F80pVsTIV10UsvpRNo0pyHKW4Um0FtJw5THmYbN1d5Qpv6oCPD9ZXocPj
         6RzZvQ9P9yMu+jAxgzcOHw+ZWgh6kqGD/JsoNHplvKv9yAFYBUy+NbrHeG08r0PdT5
         tgXQZS8x4W2onsdg7bR8uFvBDTimr9OvrLR9I8a3p+ohe3nf6kMsg8lGlxmI5PfRHu
         XsEhQh6ficglQ==
Date:   Wed, 10 Mar 2021 19:50:36 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kuba@kernel.org,
        mingo@redhat.com, ast@kernel.org, tglx@linutronix.de,
        kernel-team@fb.com, yhs@fb.com,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH -tip 0/5] kprobes: Fix stacktrace in kretprobes
Message-Id: <20210310195036.9aefe44bda0418484886c3a9@kernel.org>
In-Reply-To: <20210309213442.fyhxozdcyxfjljih@dlxu-fedora-R90QNFJV>
References: <161495873696.346821.10161501768906432924.stgit@devnote2>
        <20210305191645.njvrsni3ztvhhvqw@maharaja.localdomain>
        <20210306101357.6f947b063a982da9c949f1ba@kernel.org>
        <20210307212333.7jqmdnahoohpxabn@maharaja.localdomain>
        <20210308115210.732f2c42bf347c15fbb2a828@kernel.org>
        <20210309213442.fyhxozdcyxfjljih@dlxu-fedora-R90QNFJV>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 9 Mar 2021 13:34:42 -0800
Daniel Xu <dxu@dxuuu.xyz> wrote:

> Hi Masami,
> 
> Just want to clarify a few points:
> 
> On Mon, Mar 08, 2021 at 11:52:10AM +0900, Masami Hiramatsu wrote:
> > On Sun, 7 Mar 2021 13:23:33 -0800
> > Daniel Xu <dxu@dxuuu.xyz> wrote:
> > To help your understanding, let me explain.
> > 
> > If we have a code here
> > 
> > caller_func:
> > 0x00 add sp, 0x20	/* 0x20 bytes stack frame allocated */
> > ...
> > 0x10 call target_func
> > 0x15 ... /* return address */
> > 
> > On the stack in the entry of target_func, we have
> > 
> > [stack]
> > 0x0e0 caller_func+0x15
> > ... /* 0x20 bytes = 4 entries  are stack frame of caller_func */
> > 0x100 /* caller_func return address */
> > 
> > And when we put a kretprobe on the target_func, the stack will be
> > 
> > [stack]
> > 0x0e0 kretprobe_trampoline
> > ... /* 0x20 bytes = 4 entries  are stack frame of caller_func */
> > 0x100 /* caller_func return address */
> > 
> > * "caller_func+0x15" is saved in current->kretprobe_instances.first.
> > 
> > When returning from the target_func, call consumed the 0x0e0 and
> > jump to kretprobe_trampoline. Let's see the assembler code.
> > 
> >         ".text\n"
> >         ".global kretprobe_trampoline\n"
> >         ".type kretprobe_trampoline, @function\n"
> >         "kretprobe_trampoline:\n"
> >         /* We don't bother saving the ss register */
> >         "       pushq %rsp\n"
> >         "       pushfq\n"
> >         SAVE_REGS_STRING
> >         "       movq %rsp, %rdi\n"
> >         "       call trampoline_handler\n"
> >         /* Replace saved sp with true return address. */
> >         "       movq %rax, 19*8(%rsp)\n"
> >         RESTORE_REGS_STRING
> >         "       popfq\n"
> >         "       ret\n"
> > 
> > When the entry of trampoline_handler, stack is like this;
> > 
> > [stack]
> > 0x040 kretprobe_trampoline+0x25
> > 0x048 r15
> > ...     /* pt_regs */
> > 0x0d8 flags
> > 0x0e0 rsp (=0x0e0)
> > ... /* 0x20 bytes = 4 entries  are stack frame of caller_func */
> > 0x100 /* caller_func return address */
> > 
> > And after returned from trampoline_handler, "movq" changes the
> > stack like this.
> > 
> > [stack]
> > 0x040 kretprobe_trampoline+0x25
> > 0x048 r15
> > ...     /* pt_regs */
> > 0x0d8 flags
> > 0x0e0 caller_func+0x15
> > ... /* 0x20 bytes = 4 entries  are stack frame of caller_func */
> > 0x100 /* caller_func return address */
> 
> Thanks for the detailed explanation. I think I understand kretprobe
> mechanics from a somewhat high level (kprobe saves real return address
> on entry, overwrites return address to trampoline, then trampoline
> runs handler and finally resets return address to real return address).
> 
> I don't usually write much assembly so the details escape me somewhat.
> 
> > So at the kretprobe handler, we have 2 issues.
> > 1) the return address (caller_func+0x15) is not on the stack.
> >    this can be solved by searching from current->kretprobe_instances.
> 
> Yes, agreed.
> 
> > 2) the stack frame size of kretprobe_trampoline is unknown
> >    Since the stackframe is fixed, the fixed number (0x98) can be used.
> 
> I'm confused why this is relevant. Is it so ORC knows where to find
> saved return address in the frame?

No, because the kretprobe_trampoline is somewhat special. Usually, at the
function entry, there is a return address on the top of stack, but
kretprobe_trampoline doesn't have it.
So we have to put a hint at the function entry to mark there should be
a next return address. (and ORC unwinder must find it)

> > However, those solutions are only for the kretprobe handler. The stacktrace
> > from interrupt handler hit in the kretprobe_trampoline still doesn't work.
> > 
> > So, here is my idea;
> > 
> > 1) Change the trampline code to prepare stack frame at first and save
> >    registers on it, instead of "push". This will makes ORC easy to setup
> >    stackframe information for this code.
> 
> I'm confused on the details here. But this is what Josh solves in his
> patch, right?

I'm not so sure how objtool makes the ORC information. If it can trace the
push/pop correctly, yes, it is solved.

> > 2) change the return addres fixup timing. Instead of using return value
> >    of trampoline handler, before removing the real return address from
> >    current->kretprobe_instances.
> 
> Is the idea to have `kretprobe_trampoline` place the real return address
> on the stack (while telling ORC where to find it) _before_ running `call
> trampoline_handler` ? So that an unwind from inside the user defined
> kretprobe handler simply unwinds correctly?

No, unless calling the trampoline_handler, we can not get the real return
address. Thus, the __kretprobe_trampoline_handler() will call return address
fixup function right before unlink the current->kretprobe_instances.

> And to be extra clear, this would only work for stack_trace_save() and
> not stack_trace_save_regs()?

Yes, for the stack_trace_save_regs() and the stack-tracing inside the
kretprobe'd target function, we still need a hack as same as orc_ftrace_find().

> 
> > 3) Then, if orc_find() finds the ip is in the kretprobe_trampoline, it
> >    checks the contents of the end of stackframe (at the place of regs->sp)
> >    is same as the address of it. If it is, it can find the correct address
> >    from current->kretprobe_instances. If not, there is a correct address.
> 
> What do you mean by "it" w.r.t. "is the same address of it"? I'm
> confused on this point.

Oh I meant,

3) Then, if orc_find() finds the ip is in the kretprobe_trampoline, orc_find()
    checks the contents of the end of stackframe (at the place of regs->sp)
   is same as the address of the stackframe (Note that kretprobe_trampoline
   does "push %sp" at first). If so, orc_find() can find the correct address
   from current->kretprobe_instances. If not, there is a correct address.

I need to see the orc unwinder carefully, orc_find() only gets the ip but
to find stackframe, I think this should be fixed in the caller of orc_find().

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
