Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C41203439D8
	for <lists+bpf@lfdr.de>; Mon, 22 Mar 2021 07:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbhCVGns (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Mar 2021 02:43:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:56766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230114AbhCVGnV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Mar 2021 02:43:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 05BF46196B;
        Mon, 22 Mar 2021 06:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616395401;
        bh=uS1REgY1mW0kHpi28LD+bK8aSrj7nNHm5BFG/jnr5K0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=S+Bh3JvlKuyMlfUvmsXAUEYHxmx/3fGeFUqBtDuNKu6GBwktJLen7+ZLLPNnjpx78
         GzGwxKsxDHvIEU1Wxzcq6SeDKR7NU5hEpWVoX3DrnblC17cdYnhGHU2ZnzeOGFvu4S
         FZXvlwfBQZUllpYY/9yD2ux6GK/oFl5QvIQ18ig3QzgUR0uFPYR41hbS6d452dyPjt
         J/UVlGkpyOZnVAeEiMIaJen6dYnoTKOA+eSVzTlqqZkaVtfPTs3OoQbgVc5POtg+py
         uBjHTvZiehnQxvEmW8jmuUJrj1s/aJeUFs6fIZ3eDDue1ANr6QUv4p04haU3maeryI
         s37Y0UKOR/W3w==
Date:   Mon, 22 Mar 2021 15:43:16 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, tglx@linutronix.de, kernel-team@fb.com, yhs@fb.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-ia64@vger.kernel.org
Subject: Re: [PATCH -tip v3 00/12] kprobes: Fix stacktrace with kretprobes
 on x86
Message-Id: <20210322154316.df024040e26c7027fae3c8d9@kernel.org>
In-Reply-To: <161639500599.894584.799900058200543646.stgit@devnote2>
References: <161639500599.894584.799900058200543646.stgit@devnote2>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Oops, please ignore this. I missed updating the version.

Thanks,

On Mon, 22 Mar 2021 15:36:46 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hello,
> 
> Here is the 4th version of the series to fix the stacktrace with kretprobe
> on x86. After merging this, I'll fix other architectures.
> 
> The previous version is;
> 
> https://lore.kernel.org/bpf/161615650355.306069.17260992641363840330.stgit@devnote2/
> 
> This version fixes some build warnings/errors and a bug on arm. (I think
> arm's kretprobe implementation is a bit odd. anyway, that is off topic.)
> [5/12] fixes objtool warning when CONFIG_FRAME_POINTER=y. [7/12] fixes a
> build error on ia64. And add [8/12] for avoiding stack corruption by
> instruction_pointer_set() in kretprobe_trampoline_handler on arm.
> 
> With this series, unwinder can unwind stack correctly from ftrace as below;
> 
>   # cd /sys/kernel/debug/tracing
>   # echo > trace
>   # echo r vfs_read >> kprobe_events
>   # echo r full_proxy_read >> kprobe_events
>   # echo traceoff:1 > events/kprobes/r_vfs_read_0/trigger
>   # echo stacktrace:1 > events/kprobes/r_full_proxy_read_0/trigger
>   # echo 1 > events/kprobes/enable
>   # echo 1 > options/sym-offset
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
>            <...>-135     [005] ...1     9.422114: r_full_proxy_read_0: (vfs_read+0xab/0x1a0 <- full_proxy_read)
>            <...>-135     [005] ...1     9.422158: <stack trace>
>  => kretprobe_trace_func+0x209/0x2f0
>  => kretprobe_dispatcher+0x4a/0x70
>  => __kretprobe_trampoline_handler+0xca/0x150
>  => trampoline_handler+0x44/0x70
>  => kretprobe_trampoline+0x2a/0x50
>  => vfs_read+0xab/0x1a0
>  => ksys_read+0x5f/0xe0
>  => do_syscall_64+0x33/0x40
>  => entry_SYSCALL_64_after_hwframe+0x44/0xae
>  => 0
> 
> This shows the double return probes (vfs_read and full_proxy_read) on the stack
> correctly unwinded. (vfs_read was called from ksys_read+0x5f and full_proxy_read
> was called from vfs_read+0xab)
> 
> This actually changes the kretprobe behavisor a bit, now the instraction pointer in
> the pt_regs passed to kretprobe user handler is correctly set the real return
> address. So user handlers can get it via instruction_pointer() API.
> 
> You can also get this series from 
>  git://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git kprobes/kretprobe-stackfix-v4
> 
> 
> Thank you,
> 
> ---
> 
> Josh Poimboeuf (1):
>       x86/kprobes: Add UNWIND_HINT_FUNC on kretprobe_trampoline code
> 
> Masami Hiramatsu (11):
>       ia64: kprobes: Fix to pass correct trampoline address to the handler
>       kprobes: treewide: Replace arch_deref_entry_point() with dereference_function_descriptor()
>       kprobes: treewide: Remove trampoline_address from kretprobe_trampoline_handler()
>       kprobes: Add kretprobe_find_ret_addr() for searching return address
>       ARC: Add instruction_pointer_set() API
>       ia64: Add instruction_pointer_set() API
>       arm: kprobes: Make a space for regs->ARM_pc at kretprobe_trampoline
>       kprobes: Setup instruction pointer in __kretprobe_trampoline_handler
>       x86/kprobes: Push a fake return address at kretprobe_trampoline
>       x86/unwind: Recover kretprobe trampoline entry
>       tracing: Show kretprobe unknown indicator only for kretprobe_trampoline
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
>  arch/powerpc/kernel/kprobes.c       |   13 -----
>  arch/riscv/kernel/probes/kprobes.c  |    2 -
>  arch/s390/kernel/kprobes.c          |    2 -
>  arch/sh/kernel/kprobes.c            |    2 -
>  arch/sparc/kernel/kprobes.c         |    2 -
>  arch/x86/include/asm/kprobes.h      |    1 
>  arch/x86/include/asm/unwind.h       |   17 ++++++
>  arch/x86/include/asm/unwind_hints.h |    5 ++
>  arch/x86/kernel/kprobes/core.c      |   44 ++++++++++++----
>  arch/x86/kernel/unwind_frame.c      |    4 +
>  arch/x86/kernel/unwind_guess.c      |    3 -
>  arch/x86/kernel/unwind_orc.c        |    6 +-
>  include/linux/kprobes.h             |   41 ++++++++++++--
>  kernel/kprobes.c                    |   99 ++++++++++++++++++++++++-----------
>  kernel/trace/trace_output.c         |   17 +-----
>  lib/error-inject.c                  |    3 +
>  25 files changed, 200 insertions(+), 105 deletions(-)
> 
> --
> Masami Hiramatsu (Linaro) <mhiramat@kernel.org>


-- 
Masami Hiramatsu <mhiramat@kernel.org>
