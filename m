Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17C4B3B5F64
	for <lists+bpf@lfdr.de>; Mon, 28 Jun 2021 15:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbhF1Nwt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Jun 2021 09:52:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:54400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232307AbhF1Nwn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Jun 2021 09:52:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AB3BD61C74;
        Mon, 28 Jun 2021 13:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624888218;
        bh=+XEnZXMMZPwmy4U6RRfBJ9DMLt16I883FZaEFdRXwMU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=u5nSUsyZRNVeRBgVGxOsEW2VVhWj0wM+p6hohojLPcL1iPsxy94Vh8MaXU5OUtqoN
         lqxQF4BOw/iD2pYJuX1STRf8ahlHMdW+l/pyntmRTLldAWYAgplg8AJR4he+zYf65t
         yJxfazVts9tA+v2NZGcLxoT0TB3Gcl3uLdpU66Bixv+2MVhY98KIthHjdY53jX2jc2
         NXtRrHgtgo4GneSJGIuqigTp0Ukn3WSddUZicXk/rZ/fM4U9CEum1G+wO3vurg3hbl
         6Le9fJ028Yuy+gUkYDI7XulTTYX50ySi5pe7Rgj4KgP+Z6S1mJIulhM9wJSanZRF/W
         AtKK75oNsjbEw==
Date:   Mon, 28 Jun 2021 22:50:13 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>, kernel-team@fb.com,
        yhs@fb.com, linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Qiang Wang <wangqiang.wq.frank@bytedance.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH -tip v8 00/13] kprobes: Fix stacktrace with kretprobes
 on x86
Message-Id: <20210628225013.17e14b4c530478e8cc545259@kernel.org>
In-Reply-To: <162399992186.506599.8457763707951687195.stgit@devnote2>
References: <162399992186.506599.8457763707951687195.stgit@devnote2>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Ingo and Peter,

Can you merge this series to tip tree?
Josh reviewed the ORC unwinder parts, so I think it is a good time to pick it.
(And recently I got same effort from Qiang, he thinks this can be a phishing risk *)

* https://lore.kernel.org/bpf/CAMZfGtWPi4CuVOtmUpy2N9J_mvp+5=gSAFvqV1nmvDKP+CAvQA@mail.gmail.com/

Thank you,

On Fri, 18 Jun 2021 16:05:22 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hello,
> 
> Here is the 8th version of the series to fix the stacktrace with kretprobe on x86.
> 
> The previous version is;
> 
>  https://lore.kernel.org/bpf/162209754288.436794.3904335049560916855.stgit@devnote2/
> 
> This version fixes to call appropriate function and drop some unneeded
> patches.
> 
> 
> Changes from v7:
> [03/13]: Call dereference_kernel_function_descriptor() for getting the
>   address of kretprobe_trampoline.
> [09/13]: Update the title and description to explain why it is needed.
> [10/13][11/13]: Add Josh's Acked-by.
> 
> 
> 
> With this series, unwinder can unwind stack correctly from ftrace as below;
> 
>   # cd /sys/kernel/debug/tracing
>   # echo > trace
>   # echo 1 > options/sym-offset
>   # echo r vfs_read >> kprobe_events
>   # echo r full_proxy_read >> kprobe_events
>   # echo traceoff:1 > events/kprobes/r_vfs_read_0/trigger
>   # echo stacktrace:1 > events/kprobes/r_full_proxy_read_0/trigger
>   # echo 1 > events/kprobes/enable
>   # cat /sys/kernel/debug/kprobes/list
> ffffffff8133b740  r  full_proxy_read+0x0    [FTRACE]
> ffffffff812560b0  r  vfs_read+0x0    [FTRACE]
>   # echo 0 > events/kprobes/enable
>   # cat trace
> # tracer: nop
> #
> # entries-in-buffer/entries-written: 3/3   #P:8
> #
> #                                _-----=> irqs-off
> #                               / _----=> need-resched
> #                              | / _---=> hardirq/softirq
> #                              || / _--=> preempt-depth
> #                              ||| /     delay
> #           TASK-PID     CPU#  ||||   TIMESTAMP  FUNCTION
> #              | |         |   ||||      |         |
>            <...>-134     [007] ...1    16.185877: r_full_proxy_read_0: (vfs_read+0x98/0x180 <- full_proxy_read)
>            <...>-134     [007] ...1    16.185901: <stack trace>
>  => kretprobe_trace_func+0x209/0x300
>  => kretprobe_dispatcher+0x4a/0x70
>  => __kretprobe_trampoline_handler+0xd4/0x170
>  => trampoline_handler+0x43/0x60
>  => kretprobe_trampoline+0x2a/0x50
>  => vfs_read+0x98/0x180
>  => ksys_read+0x5f/0xe0
>  => do_syscall_64+0x37/0x90
>  => entry_SYSCALL_64_after_hwframe+0x44/0xae
>            <...>-134     [007] ...1    16.185902: r_vfs_read_0: (ksys_read+0x5f/0xe0 <- vfs_read)
> 
> This shows the double return probes (vfs_read and full_proxy_read) on the stack
> correctly unwinded. (vfs_read will return to ksys_read+0x5f and full_proxy_read
> will return to vfs_read+0x98)
> 
> This actually changes the kretprobe behavisor a bit, now the instraction pointer in
> the pt_regs passed to kretprobe user handler is correctly set the real return
> address. So user handlers can get it via instruction_pointer() API, and can use
> stack_trace_save_regs().
> 
> You can also get this series from 
>  git://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git kprobes/kretprobe-stackfix-v8
> 
> 
> Thank you,
> 
> ---
> 
> Josh Poimboeuf (1):
>       x86/kprobes: Add UNWIND_HINT_FUNC on kretprobe_trampoline code
> 
> Masami Hiramatsu (12):
>       ia64: kprobes: Fix to pass correct trampoline address to the handler
>       kprobes: treewide: Replace arch_deref_entry_point() with dereference_symbol_descriptor()
>       kprobes: treewide: Remove trampoline_address from kretprobe_trampoline_handler()
>       kprobes: Add kretprobe_find_ret_addr() for searching return address
>       ARC: Add instruction_pointer_set() API
>       ia64: Add instruction_pointer_set() API
>       arm: kprobes: Make a space for regs->ARM_pc at kretprobe_trampoline
>       kprobes: Enable stacktrace from pt_regs in kretprobe handler
>       x86/kprobes: Push a fake return address at kretprobe_trampoline
>       x86/unwind: Recover kretprobe trampoline entry
>       tracing: Show kretprobe unknown indicator only for kretprobe_trampoline
>       x86/kprobes: Fixup return address in generic trampoline handler
> 
> 
>  arch/arc/include/asm/ptrace.h       |    5 ++
>  arch/arc/kernel/kprobes.c           |    2 -
>  arch/arm/probes/kprobes/core.c      |    5 +-
>  arch/arm64/kernel/probes/kprobes.c  |    3 -
>  arch/csky/kernel/probes/kprobes.c   |    2 -
>  arch/ia64/include/asm/ptrace.h      |    5 ++
>  arch/ia64/kernel/kprobes.c          |   15 ++---
>  arch/mips/kernel/kprobes.c          |    3 -
>  arch/parisc/kernel/kprobes.c        |    4 +
>  arch/powerpc/kernel/kprobes.c       |   13 ----
>  arch/riscv/kernel/probes/kprobes.c  |    2 -
>  arch/s390/kernel/kprobes.c          |    2 -
>  arch/sh/kernel/kprobes.c            |    2 -
>  arch/sparc/kernel/kprobes.c         |    2 -
>  arch/x86/include/asm/kprobes.h      |    1 
>  arch/x86/include/asm/unwind.h       |   23 +++++++
>  arch/x86/include/asm/unwind_hints.h |    5 ++
>  arch/x86/kernel/kprobes/core.c      |   53 +++++++++++++++--
>  arch/x86/kernel/unwind_frame.c      |    3 -
>  arch/x86/kernel/unwind_guess.c      |    3 -
>  arch/x86/kernel/unwind_orc.c        |   18 +++++-
>  include/linux/kprobes.h             |   44 ++++++++++++--
>  kernel/kprobes.c                    |  108 +++++++++++++++++++++++++----------
>  kernel/trace/trace_output.c         |   17 +-----
>  lib/error-inject.c                  |    3 +
>  25 files changed, 238 insertions(+), 105 deletions(-)
> 
> --
> Masami Hiramatsu (Linaro) <mhiramat@kernel.org>


-- 
Masami Hiramatsu <mhiramat@kernel.org>
