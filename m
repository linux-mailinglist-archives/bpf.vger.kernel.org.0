Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12BE93F579C
	for <lists+bpf@lfdr.de>; Tue, 24 Aug 2021 07:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbhHXFda (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Aug 2021 01:33:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:57464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229885AbhHXFda (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Aug 2021 01:33:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6F6F061248;
        Tue, 24 Aug 2021 05:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629783166;
        bh=f3m6wH4+fUErojWFkMzb2VSfAZFVHpeOf9zaKd26vUU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aX6dqSl7l3PBrOEetm7QCnu9p7urn2Nrg3lR5/gHQF0uCUyFJc28wF5S7uqTiWuKH
         QbdnsziFjFyQTiknbnHxAh4r/6u6uvs1Y2Wtqr8jBzH5F0oEn49rXWPBAeM8ilUJwL
         GSr1VTRrgdRXme5Qiqc91tGmabSyRbWHWNETN4HiaW0NS+TrFMZ1r0kTL66DvqdQVJ
         xtra/loqc5TqfKHWBkIl+WZR9R3vZavrjZWTXL0mD7h0qttrzsfqv4+2j/fVwCgEdL
         jACp/sT9Tt8UTs91M9i7xpWePWvF7rO5jeHpyIQLagfiZQR+mj/Swn5e1ntm5oEsu+
         Rd9imtXLvcQlw==
Date:   Tue, 24 Aug 2021 14:32:42 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, X86 ML <x86@kernel.org>,
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
Subject: Re: [PATCH -tip v10 00/16] kprobes: Fix stacktrace with kretprobes
 on x86
Message-Id: <20210824143242.a0558b6632eef0407282364e@kernel.org>
In-Reply-To: <CAEf4Bzb2i4Z9kUWU+L-HF3k+XQ0V3hLH1Er7U2_oCdv1BTvaBw@mail.gmail.com>
References: <162756755600.301564.4957591913842010341.stgit@devnote2>
        <20210730083549.4e36df1cba88e408dc60b031@kernel.org>
        <CAEf4Bzb2i4Z9kUWU+L-HF3k+XQ0V3hLH1Er7U2_oCdv1BTvaBw@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 23 Aug 2021 22:12:06 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> On Thu, Jul 29, 2021 at 4:35 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > On Thu, 29 Jul 2021 23:05:56 +0900
> > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > > Hello,
> > >
> > > This is the 10th version of the series to fix the stacktrace with kretprobe on x86.
> > >
> > > The previous version is here;
> > >
> > >  https://lore.kernel.org/bpf/162601048053.1318837.1550594515476777588.stgit@devnote2/
> > >
> > > This version is rebased on top of new kprobes cleanup series(*1) and merging
> > > Josh's objtool update series (*2)(*3) as [6/16] and [7/16].
> > >
> > > (*1) https://lore.kernel.org/bpf/162748615977.59465.13262421617578791515.stgit@devnote2/
> > > (*2) https://lore.kernel.org/bpf/20210710192433.x5cgjsq2ksvaqnss@treble/
> > > (*3) https://lore.kernel.org/bpf/20210710192514.ghvksi3ozhez4lvb@treble/
> > >
> > > Changes from v9:
> > >  - Add Josh's objtool update patches with a build error fix as [6/16] and [7/16].
> > >  - Add a API document for kretprobe_find_ret_addr() and check cur != NULL in [5/16].
> > >
> > > With this series, unwinder can unwind stack correctly from ftrace as below;
> > >
> > >   # cd /sys/kernel/debug/tracing
> > >   # echo > trace
> > >   # echo 1 > options/sym-offset
> > >   # echo r vfs_read >> kprobe_events
> > >   # echo r full_proxy_read >> kprobe_events
> > >   # echo traceoff:1 > events/kprobes/r_vfs_read_0/trigger
> > >   # echo stacktrace:1 > events/kprobes/r_full_proxy_read_0/trigger
> > >   # echo 1 > events/kprobes/enable
> > >   # cat /sys/kernel/debug/kprobes/list
> > > ffffffff8133b740  r  full_proxy_read+0x0    [FTRACE]
> > > ffffffff812560b0  r  vfs_read+0x0    [FTRACE]
> > >   # echo 0 > events/kprobes/enable
> > >   # cat trace
> > > # tracer: nop
> > > #
> > > # entries-in-buffer/entries-written: 3/3   #P:8
> > > #
> > > #                                _-----=> irqs-off
> > > #                               / _----=> need-resched
> > > #                              | / _---=> hardirq/softirq
> > > #                              || / _--=> preempt-depth
> > > #                              ||| /     delay
> > > #           TASK-PID     CPU#  ||||   TIMESTAMP  FUNCTION
> > > #              | |         |   ||||      |         |
> > >            <...>-134     [007] ...1    16.185877: r_full_proxy_read_0: (vfs_read+0x98/0x180 <- full_proxy_read)
> > >            <...>-134     [007] ...1    16.185901: <stack trace>
> > >  => kretprobe_trace_func+0x209/0x300
> > >  => kretprobe_dispatcher+0x4a/0x70
> > >  => __kretprobe_trampoline_handler+0xd4/0x170
> > >  => trampoline_handler+0x43/0x60
> > >  => kretprobe_trampoline+0x2a/0x50
> > >  => vfs_read+0x98/0x180
> > >  => ksys_read+0x5f/0xe0
> > >  => do_syscall_64+0x37/0x90
> > >  => entry_SYSCALL_64_after_hwframe+0x44/0xae
> > >            <...>-134     [007] ...1    16.185902: r_vfs_read_0: (ksys_read+0x5f/0xe0 <- vfs_read)
> > >
> > > This shows the double return probes (vfs_read() and full_proxy_read()) on the stack
> > > correctly unwinded. (vfs_read() returns to 'ksys_read+0x5f' and full_proxy_read()
> > > returns to 'vfs_read+0x98')
> > >
> > > This also changes the kretprobe behavisor a bit, now the instraction pointer in
> > > the 'pt_regs' passed to kretprobe user handler is correctly set the real return
> > > address. So user handlers can get it via instruction_pointer() API, and can use
> > > stack_trace_save_regs().
> > >
> > > You can also get this series from
> > >  git://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git kprobes/kretprobe-stackfix-v9
> >
> > Oops, this is of course 'kprobes/kretprobe-stackfix-v10'. And this branch includes above (*1) series.
> 
> Hi Masami,
> 
> Was this ever merged/applied? This is a very important functionality
> for BPF kretprobes, so I hope this won't slip through the cracks.

No, not yet as far as I know.
I'm waiting for any comment on this series. Since this is basically
x86 ORC unwinder improvement, this series should be merged to -tip tree.

Ingo and Josh,

Could you give me any comment, please?

Thank you,


> Thanks!
> 
> >
> > Thank you,
> >
> > --
> > Masami Hiramatsu <mhiramat@kernel.org>


-- 
Masami Hiramatsu <mhiramat@kernel.org>
