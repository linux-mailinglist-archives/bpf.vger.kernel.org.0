Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA9D63923B4
	for <lists+bpf@lfdr.de>; Thu, 27 May 2021 02:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbhE0AWQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 May 2021 20:22:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:43456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233640AbhE0AWQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 May 2021 20:22:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F1195613CD;
        Thu, 27 May 2021 00:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622074844;
        bh=OhAGputHj8LGq3lVPwQDXhpZGAMwnpAJqfNe9xdfpgA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=N3OIqpKhD37LVHkg6S/JzzVY6O0J+uxJdbcQIY6kdb0Cjjcepa8FchCJtG2RhmR9C
         auNcHZAuI/02K3IPy1YynmHZ1w5a81ZEUmPqKtLtGgF3TDgLbLrkyofQYc9xeP8zUE
         wmf4ef2EIUCdyQ0pa7AFlb2uy1ZQDNZB2bQCUv6UgcxnbczXZmeJhFqbYcOUbPV3He
         9h3sJs/cLRGJTNRhXTfT5vQJR5Jt1hBhnmbMO4qs1x7s+S1mYbwORZvEXqX/Q7Bvy5
         vu9y9j+uFJ4ZbrSq1aUr7JtMT/meyQ2vUTI2BduVg3vuamqP+dYYDAKwGqp/IIr4nv
         RYYdYo5idHbSQ==
Date:   Thu, 27 May 2021 09:20:39 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kernel Team <kernel-team@fb.com>, Yonghong Song <yhs@fb.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>
Subject: Re: [PATCH -tip v6 00/13] kprobes: Fix stacktrace with kretprobes
 on x86
Message-Id: <20210527092039.9bf13c221ee096cddc965cef@kernel.org>
In-Reply-To: <CAEf4BzbTKwnuutnJG6ALYX_YgLPg0Tzm+BNRGYLfh62oZPNGpg@mail.gmail.com>
References: <162201612941.278331.5293566981784464165.stgit@devnote2>
        <CAEf4BzbTKwnuutnJG6ALYX_YgLPg0Tzm+BNRGYLfh62oZPNGpg@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 26 May 2021 10:39:57 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> On Wed, May 26, 2021 at 1:02 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > Hello,
> >
> > Here is the 6th version of the series to fix the stacktrace with kretprobe
> > on x86.
> >
> > The previous version is;
> >
> >  https://lore.kernel.org/bpf/161676170650.330141.6214727134265514123.stgit@devnote2/
> >
> > This version is rebased on the latest tip tree and add some patches for
> > improving stacktrace[13/13].
> >
> > Changes from v5:
> > [02/13]:
> >   - Use dereference_symbol_descriptor() instead of dereference_function_descriptor()
> > [04/13]:
> >   - Replace BUG_ON() with WARN_ON_ONCE() in __kretprobe_trampoline_handler().
> > [13/13]:
> >   - Add a new patch to fix return address in earlier stage.
> >
> >
> > With this series, unwinder can unwind stack correctly from ftrace as below;
> >
> >   # cd /sys/kernel/debug/tracing
> >   # echo > trace
> >   # echo 1 > options/sym-offset
> >   # echo r vfs_read >> kprobe_events
> >   # echo r full_proxy_read >> kprobe_events
> >   # echo traceoff:1 > events/kprobes/r_vfs_read_0/trigger
> >   # echo stacktrace:1 > events/kprobes/r_full_proxy_read_0/trigger
> >   # echo 1 > events/kprobes/enable
> >   # cat /sys/kernel/debug/kprobes/list
> > ffffffff8133b740  r  full_proxy_read+0x0    [FTRACE]
> > ffffffff812560b0  r  vfs_read+0x0    [FTRACE]
> >   # echo 0 > events/kprobes/enable
> >   # cat trace
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
> >            <...>-134     [007] ...1    16.185877: r_full_proxy_read_0: (vfs_read+0x98/0x180 <- full_proxy_read)
> >            <...>-134     [007] ...1    16.185901: <stack trace>
> >  => kretprobe_trace_func+0x209/0x300
> >  => kretprobe_dispatcher+0x4a/0x70
> >  => __kretprobe_trampoline_handler+0xd4/0x170
> >  => trampoline_handler+0x43/0x60
> >  => kretprobe_trampoline+0x2a/0x50
> >  => vfs_read+0x98/0x180
> >  => ksys_read+0x5f/0xe0
> >  => do_syscall_64+0x37/0x90
> >  => entry_SYSCALL_64_after_hwframe+0x44/0xae
> >            <...>-134     [007] ...1    16.185902: r_vfs_read_0: (ksys_read+0x5f/0xe0 <- vfs_read)
> >
> > This shows the double return probes (vfs_read and full_proxy_read) on the stack
> > correctly unwinded. (vfs_read will return to ksys_read+0x5f and full_proxy_read
> > will return to vfs_read+0x98)
> >
> > This actually changes the kretprobe behavisor a bit, now the instraction pointer in
> > the pt_regs passed to kretprobe user handler is correctly set the real return
> > address. So user handlers can get it via instruction_pointer() API.
> >
> > You can also get this series from
> >  git://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git kprobes/kretprobe-stackfix-v6
> >
> >
> > Thank you,
> >
> > ---
> >
> 
> Thanks for following up on this! I've applied this patch set on top of
> bpf-next and tested with my local BPF-based tool that uses stack
> traces in kretprobes heavily. It all works now and I'm getting
> meaningful and correctly looking stacktraces. Thanks a lot!
> 
> Tested-by: Andrii Nakryik <andrii@kernel.org>

Thanks for testing! I got a minor warning issue on [13/13] from kernel test
bot, which can be fixed by adding a prototype. So I will update it.

Thank you!

-- 
Masami Hiramatsu <mhiramat@kernel.org>
