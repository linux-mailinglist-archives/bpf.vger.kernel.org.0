Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7821A3305FB
	for <lists+bpf@lfdr.de>; Mon,  8 Mar 2021 03:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbhCHCwa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 7 Mar 2021 21:52:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:54348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232372AbhCHCwR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 7 Mar 2021 21:52:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5076865151;
        Mon,  8 Mar 2021 02:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615171936;
        bh=PIU2NM2uqbrD9ZZQVce4UkqzjWynuSfipiZx2rnbEsU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HcVCv6vUrPwue8g3aRb5KoiIoIB049s/Vda1M5OugAbHIsJVzfMm2J2Jznlb1i9pD
         iQoY6Nr5kmgjncjyuM66l4Q61kfm3HJos98lCcGDnpNh9b28El2vEGQRo+HxQ2eTQQ
         VlGG9G3N3n6q7ILZDmslTY8huR3DxNYTz5Q7ZllMJsgB3orsekIk1gb0GC/YCZVDgS
         7IbPMeyzha22yWlosVJLPInCw7JZIqVZso6nfYkdUgPBfC770NSr1sz6k33m8W776y
         zT07jBrJbck66j95/MFiSu4N4csFVEeNHu/KiN3b4aOcPG05qktABcIulnTxc6UL3v
         LRDqsGxevCH4g==
Date:   Mon, 8 Mar 2021 11:52:10 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kuba@kernel.org,
        mingo@redhat.com, ast@kernel.org, tglx@linutronix.de,
        kernel-team@fb.com, yhs@fb.com,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH -tip 0/5] kprobes: Fix stacktrace in kretprobes
Message-Id: <20210308115210.732f2c42bf347c15fbb2a828@kernel.org>
In-Reply-To: <20210307212333.7jqmdnahoohpxabn@maharaja.localdomain>
References: <161495873696.346821.10161501768906432924.stgit@devnote2>
        <20210305191645.njvrsni3ztvhhvqw@maharaja.localdomain>
        <20210306101357.6f947b063a982da9c949f1ba@kernel.org>
        <20210307212333.7jqmdnahoohpxabn@maharaja.localdomain>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, 7 Mar 2021 13:23:33 -0800
Daniel Xu <dxu@dxuuu.xyz> wrote:

> > kretprobe replaces the real return address with kretprobe_trampoline
> > and kretprobe_trampoline *calls* trampoline_handler (this part depends
> > on architecture implementation).
> > Thus, if kretprobe_trampoline has no stack frame information, ORC may
> > fails at the first kretprobe_trampoline+0x25, that is different from
> > the kretprobe_trampoline+0, so the hack doesn't work.
> 
> I'm not sure I follow 100% what you're saying, but assuming you're
> asking why bpftrace fails at `kretprobe_trampoline+0` instead of
> `kretprobe_trampoline+0x25`:
> 
> `regs` is set to &kretprobe_trampoline:
> 
>     regs->ip = (unsigned long)&kretprobe_trampoline;

Ah, OK. bpftrace does the adjustment.

> Then the kretprobe event is dispatched like this:
> 
>     kretprobe_trampoline_handler
>       __kretprobe_trampoline_handler
>         rp->handler // ie kernel/trace/trace_kprobe.c:kretprobe_dispatcher
>           kretprobe_perf_func
>             trace_bpf_call(.., regs)
>               BPF_PROG_RUN_ARRAY_CHECK
>                 bpf_get_stackid(regs, .., ..) // in bpftrace prog 
> 
> And then `bpf_get_stackid` unwinds the stack via:
> 
>     bpf_get_stackid
>       get_perf_callchain(regs, ...)
>         perf_callchain_kernel(.., regs)
>           perf_callchain_store(.., regs->ip) // !!! first unwound entry
>           unwind_start
>           unwind_next_frame
> 
> In summary: unwinding via BPF begins at regs->ip, which
> `trampoline_handler` sets to `&kretprobe_trampoline+0x0`.

OK, maybe you are using stack_trace_save_regs() with pt_regs instead of
stack_trace_save(). this means it started from regs at saved by
kretprobe always.

In the ftrace, we are using stack_trace_save() which is based on
the current stack, this means stack unwinder tracks back the stack of
kretprobe itself at first. So it saw the kretprobe_trampoline+0x25 
(return address of the trampoline_handler) and stop unwinding because
the call frame information (ORC information) and the return address
are not there.

This issue is not only the ftrace, but also backtrace in interrupt
handler and kretprobe handler.

> > Hmm, how the other inline-asm function makes its stackframe info?
> > If I get the kretprobe_trampoline+0, I can fix it up.
> 
> So I think I misunderstood the mechanics before. I think `call
> trampoline_handler` does set up a new frame. My current guess is that
> ftrace doesn't thread through `regs` like the bpf code path does. I'm
> not very familiar with ftrace internals so I haven't looked.

Yes, that's right. Since I made a kretprobe event on top of the ftrace
event framework, it doesn't pass the regs to the event trigger.


> > > The only way I can think of to fix this issue is to make the ORC
> > > unwinder aware of kretprobe (ie the patch I sent earlier). I'm hoping
> > > you have another idea if my patch isn't acceptable.
> > 
> > OK, anyway, your patch doesn't care the case that the multiple functions
> > are probed by kretprobes. In that case, you'll see several entries are
> > replaced by the kretprobe_trampoline. To find it correctly, you have
> > to pass a state-holder (@cur of the kretprobe_find_ret_addr())
> > to the fixup entries.
> 
> I'll see if I can figure something out tomorrow.

To help your understanding, let me explain.

If we have a code here

caller_func:
0x00 add sp, 0x20	/* 0x20 bytes stack frame allocated */
...
0x10 call target_func
0x15 ... /* return address */

On the stack in the entry of target_func, we have

[stack]
0x0e0 caller_func+0x15
... /* 0x20 bytes = 4 entries  are stack frame of caller_func */
0x100 /* caller_func return address */

And when we put a kretprobe on the target_func, the stack will be

[stack]
0x0e0 kretprobe_trampoline
... /* 0x20 bytes = 4 entries  are stack frame of caller_func */
0x100 /* caller_func return address */

* "caller_func+0x15" is saved in current->kretprobe_instances.first.

When returning from the target_func, call consumed the 0x0e0 and
jump to kretprobe_trampoline. Let's see the assembler code.

        ".text\n"
        ".global kretprobe_trampoline\n"
        ".type kretprobe_trampoline, @function\n"
        "kretprobe_trampoline:\n"
        /* We don't bother saving the ss register */
        "       pushq %rsp\n"
        "       pushfq\n"
        SAVE_REGS_STRING
        "       movq %rsp, %rdi\n"
        "       call trampoline_handler\n"
        /* Replace saved sp with true return address. */
        "       movq %rax, 19*8(%rsp)\n"
        RESTORE_REGS_STRING
        "       popfq\n"
        "       ret\n"

When the entry of trampoline_handler, stack is like this;

[stack]
0x040 kretprobe_trampoline+0x25
0x048 r15
...     /* pt_regs */
0x0d8 flags
0x0e0 rsp (=0x0e0)
... /* 0x20 bytes = 4 entries  are stack frame of caller_func */
0x100 /* caller_func return address */

And after returned from trampoline_handler, "movq" changes the
stack like this.

[stack]
0x040 kretprobe_trampoline+0x25
0x048 r15
...     /* pt_regs */
0x0d8 flags
0x0e0 caller_func+0x15
... /* 0x20 bytes = 4 entries  are stack frame of caller_func */
0x100 /* caller_func return address */


So at the kretprobe handler, we have 2 issues.
1) the return address (caller_func+0x15) is not on the stack.
   this can be solved by searching from current->kretprobe_instances.
2) the stack frame size of kretprobe_trampoline is unknown
   Since the stackframe is fixed, the fixed number (0x98) can be used.

However, those solutions are only for the kretprobe handler. The stacktrace
from interrupt handler hit in the kretprobe_trampoline still doesn't work.

So, here is my idea;

1) Change the trampline code to prepare stack frame at first and save
   registers on it, instead of "push". This will makes ORC easy to setup
   stackframe information for this code.
2) change the return addres fixup timing. Instead of using return value
   of trampoline handler, before removing the real return address from
   current->kretprobe_instances.
3) Then, if orc_find() finds the ip is in the kretprobe_trampoline, it
   checks the contents of the end of stackframe (at the place of regs->sp)
   is same as the address of it. If it is, it can find the correct address
   from current->kretprobe_instances. If not, there is a correct address.

I need to find how the ORC info is prepared for 1), maybe UNWIND_HINT macro
may help?

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
