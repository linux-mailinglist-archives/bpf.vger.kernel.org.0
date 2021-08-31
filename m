Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0C23FC27E
	for <lists+bpf@lfdr.de>; Tue, 31 Aug 2021 08:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbhHaGHk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Aug 2021 02:07:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:57046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229457AbhHaGHk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Aug 2021 02:07:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 74AB260462;
        Tue, 31 Aug 2021 06:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630390005;
        bh=iGqd1gdBS4buQPKVKJn5mGlEseAOem/rUnrMjB3UPTc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ofk7+Ihwkf1XUTURUTMYMVU101LwSWTjEILWISAEwEcTpNDTSQXOr/sSHbest0LIz
         NyhRu9rOZufSn94utlFZ90bD4pVmlOOxDlSoC6IKS8YpFrjHWzXBDg8Ty2H0NTc69r
         a2GiwTKjWdcEkIu5Voj/bkr80AVizTq42ScSor3Bs9g55ZSpL4lqyLCxAFHMR/TYXl
         BqlhUQp/hez/0YdBoJvn29bJuYOcJMSXxz4FRd9xWTD1o0Hnba75nn41LX0YlBhSda
         u76mUacrWn9jshpC1RPUPEO2S9F9vUDBAcodhvHCKOK0ASrYBtSbGKgm+xbDddV18o
         UPcwEdSCv7NwA==
Date:   Tue, 31 Aug 2021 15:06:42 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kernel Team <kernel-team@fb.com>, Yonghong Song <yhs@fb.com>,
        linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>
Subject: Re: [RFC PATCH 0/1] Non stack-intrusive return probe event
Message-Id: <20210831150642.f28141b1d62d224077612517@kernel.org>
In-Reply-To: <CAEf4BzbQZqtHAt5XMVxpeH2AmfaWmrqesB5fZavcwESudymR+g@mail.gmail.com>
References: <162756755600.301564.4957591913842010341.stgit@devnote2>
        <163024693462.457128.1437820221831758047.stgit@devnote2>
        <CAEf4BzbQZqtHAt5XMVxpeH2AmfaWmrqesB5fZavcwESudymR+g@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 30 Aug 2021 12:04:56 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> On Sun, Aug 29, 2021 at 7:22 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > Hello,
> >
> > For a long time, we tackled to fix some issues around kretprobe.
> > One of the latest action was the stacktrace fix on x86 in this
> > thread.
> >
> > https://lore.kernel.org/bpf/162756755600.301564.4957591913842010341.stgit@devnote2/
> >
> > However, there seems no progress/further discussion. So I would
> > like to make another approach for this (and the other issues.)
> 
> v10 of kretprobe+stacktrace fixes ([0]) from Masami has received no
> comment or objections in the last month, since it was posted. It fixes
> the very real and very limiting problem of not being able to capture a
> stack trace from BPF kretprobe programs. Masami, while I don't mind
> your new approach, I think we shouldn't consider them as "either/or"
> solutions. We have a fix that works for existing implementations, can
> we please land it, and then work on further improvements
> independently?

That's right. The original stacktrace fix series is for fixing
existing issue with kretprobes and stack unwinder.
This one just for avoiding the issue only from dynamic events.
So we can anyway proceed both.

> 
> Ingo, Peter, Steven,
> 
> I'm not sure who and which kernel tree this has to go through, but
> assuming it's one of you/yours, can you please take a look at [0] and
> apply it where appropriate? The work has been going on since March and
> it blocks development of some extremely useful tooling (retsnoop [1]
> being one of them). There were also bpftrace users that were
> completely surprised about the inability to use stack trace capturing
> from kretprobe handlers, so it's not just me. I (and a bunch of other
> BPF users) would greatly appreciate help with getting this problem
> fixed. Thank you!
> 
>   [0] https://lore.kernel.org/bpf/162756755600.301564.4957591913842010341.stgit@devnote2/
>   [1] https://github.com/anakryiko/retsnoop

Thank you,

> 
> >
> > Here is my idea -- replace kretprobe with kprobe.
> > In other words, put a kprobe on the "return instruction" directly
> > instead of modifying the kernel stack. This can solve most
> > of the kretprobe disadvantges. E.g.
> >
> > - Since it doesn't change the kernel stack, any special stack
> >   unwinder fixup is not needed anymore.
> > - No "max-instance" limitations anymore, because it will use
> >   kprobes directly.
> > - Scalability performance will be improved as same as kprobes.
> >   No list-operation in probe-runtime.
> >
> > Here is a PoC code which introduces "retinsn_probe" event as a part
> > of ftrace kprobe event. I don't think we need to replace the
> > kretprobe. This should be a higher layer feature, because some
> > kernel functions can have multiple "return instructions". Thus,
> > the "retinsn_probe" must manage multiple kprobes. That means the
> > "retinsn_probe" will be a user of kprobes. I decided to make it
> > inside the ftrace "kprobe-event". This gives us another advantage
> > for eBPF support. Because eBPF uses "kprobe-event" instead of
> > "kprobe" directly, if the "retinsn_probe" is implemented in the
> > "kprobe-event", eBPF can use it without any change.
> > Anyway, this can be co-exist with kretprobe. So as far as any
> > user uses kretprobe, we can keep it.
> >
> >
> > Example
> > =======
> > For example, I ran a shell script, which was used in the
> > stacktrace fix series.
> >
> > ----
> > mount -t debugfs debugfs /sys/kernel/debug/
> > cd /sys/kernel/debug/tracing
> > echo > trace
> > echo 1 > options/sym-offset
> > echo r vfs_read >> kprobe_events
> > echo r full_proxy_read >> kprobe_events
> > echo traceoff:1 > events/kprobes/r_vfs_read_0/trigger
> > echo stacktrace:1 > events/kprobes/r_full_proxy_read_0/trigger
> > echo 1 > events/kprobes/enable
> > cat /sys/kernel/debug/kprobes/list
> > echo 0 > events/kprobes/enable
> > cat trace
> > ----
> >
> > This is the result.
> > ----
> > ffffffff813b420e  k  full_proxy_read+0x6e
> > ffffffff812b7c0a  k  vfs_read+0xda
> > # tracer: nop
> > #
> > # entries-in-buffer/entries-written: 3/3   #P:8
> > #
> > #                                _-----=> irqs-off
> > #                               / _----=> need-resched
> > #                              | / _---=> hardirq/softirq
> > #                              || / _--=> preempt-depth
> > #                              ||| /     delay
> > #           TASK-PID     CPU#  ||||   TIMESTAMP  FUNCTION
> > #              | |         |   ||||      |         |
> >              cat-136     [007] d.Z.     8.038381: r_full_proxy_read_0: (vfs_read+0x9b/0x180 <- full_proxy_read)
> >              cat-136     [007] d.Z.     8.038386: <stack trace>
> >  => kretprobe_trace_func+0x209/0x300
> >  => retinsn_dispatcher+0x7a/0xa0
> >  => kprobe_post_process+0x28/0x80
> >  => kprobe_int3_handler+0x166/0x1a0
> >  => exc_int3+0x47/0x140
> >  => asm_exc_int3+0x31/0x40
> >  => vfs_read+0x9b/0x180
> >  => ksys_read+0x68/0xe0
> >  => do_syscall_64+0x3b/0x90
> >  => entry_SYSCALL_64_after_hwframe+0x44/0xae
> >              cat-136     [007] d.Z.     8.038387: r_vfs_read_0: (ksys_read+0x68/0xe0 <- vfs_read)
> > ----
> >
> > You can see the return probe events are translated to kprobes
> > instead of kretprobes. And also, on the stacktrace, we can see
> > an int3 calls the kprobe and decode stacktrace correctly.
> >
> >
> > TODO
> > ====
> > Of course, this is just an PoC code, there are many TODOs.
> >
> > - This PoC code only supports x86 at this moment. But I think this
> >   can be done on the other architectures. What it needs is
> >   to implement "find_return_instructions()".
> > - Code cleanup is not enough. I have to remove "kretprobe" from
> >  "trace_kprobe" data structure, rewrite related functions etc.
> > - It has to handle "tail-call" optimized code, which replaces
> >   a "call + return" into "jump". find_return_instruction() should
> >   detect it and decode the jump destination too.
> >
> >
> > Thank you,
> >
> >
> > ---
> >
> > Masami Hiramatsu (1):
> >       [PoC] tracing: kprobe: Add non-stack intrusion return probe event
> >
> >
> >  arch/x86/kernel/kprobes/core.c |   59 +++++++++++++++++++++
> >  kernel/trace/trace_kprobe.c    |  110 ++++++++++++++++++++++++++++++++++++++--
> >  2 files changed, 164 insertions(+), 5 deletions(-)
> >
> > --
> > Masami Hiramatsu (Linaro) <mhiramat@kernel.org>


-- 
Masami Hiramatsu <mhiramat@kernel.org>
