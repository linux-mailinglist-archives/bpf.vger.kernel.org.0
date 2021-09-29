Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 435CC41BCAD
	for <lists+bpf@lfdr.de>; Wed, 29 Sep 2021 04:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243687AbhI2CZw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Sep 2021 22:25:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:48480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243226AbhI2CZw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Sep 2021 22:25:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B9284613DB;
        Wed, 29 Sep 2021 02:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632882252;
        bh=9NFXQ4/P9w1k+dbu6IuJLZ9l+o27aTU15/CDrlN+9x4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vCoLeUvoT/Pvm6B4wSOSUGuVkG50pR7e5x3I9z70npIIaLELoMB8LeQANLCbDSjSY
         QFwtvXto+20M1yOHCtE+zjB3OI5DSTxvIzJd+rVeF1UEWY/l9yj2sAQQ5ikyQtqBLA
         ao/3uwxjvN4lzjavLSwXNGmzcRTPXK+PsRATkl0j/ENRVsqX9FcFQzfu4xfReSMYGz
         VhYeyT0R1YcsPwQ0yIelJT8RoTEZRiL4rZeKsgxQAxjdOCLgfPl1BMHhUjW4bY5dZJ
         +A0MZCqEARhBeTB9Km71rJNUUHEpxkLOmEYigQUYnka8g4lFV0NbPRus0ynsebXC4R
         k/USCnQ6Pb7KA==
Date:   Wed, 29 Sep 2021 11:24:08 +0900
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
        Paul McKenney <paulmck@kernel.org>
Subject: Re: [PATCH -tip v11 00/27] kprobes: Fix stacktrace with kretprobes
 on x86
Message-Id: <20210929112408.35b0ffe06b372533455d890d@kernel.org>
In-Reply-To: <163163030719.489837.2236069935502195491.stgit@devnote2>
References: <163163030719.489837.2236069935502195491.stgit@devnote2>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Ingo,

Can you merge this series to -tip tree since if I understand correctly,
all kprobes patches still should be merged via -tip tree.
If you don't think so anymore, I would like to handle the kprobe related
patches on my tree. Since many kprobes fixes/cleanups have not been
merged these months, it seems unhealthy now.

Thank you,


On Tue, 14 Sep 2021 23:38:27 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hello,
> 
> This is the 11th version of the series to fix the stacktrace with kretprobe on x86.
> 
> The previous version is here;
> 
>  https://lore.kernel.org/all/162756755600.301564.4957591913842010341.stgit@devnote2/
> 
> This version is rebased on the latest tip/master branch and includes the kprobe cleanup
> series[1][2]. No code change.
> 
> [1] https://lore.kernel.org/bpf/162748615977.59465.13262421617578791515.stgit@devnote2/
> [2] https://lore.kernel.org/linux-csky/20210727133426.2919710-1-punitagrawal@gmail.com/
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
> ffffffff813bedf0  r  full_proxy_read+0x0    [FTRACE]
> ffffffff812c13e0  r  vfs_read+0x0    [FTRACE]
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
> #                              ||| / _-=> migrate-disable
> #                              |||| /     delay
> #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> #              | |         |   |||||     |         |
>              cat-136     [000] ...1.    14.474966: r_full_proxy_read_0: (vfs_read+0x99/0x190 <- full_proxy_read)
>              cat-136     [000] ...1.    14.474970: <stack trace>
>  => kretprobe_trace_func+0x209/0x300
>  => kretprobe_dispatcher+0x9d/0xb0
>  => __kretprobe_trampoline_handler+0xd4/0x1b0
>  => trampoline_handler+0x43/0x60
>  => __kretprobe_trampoline+0x2a/0x50
>  => vfs_read+0x99/0x190
>  => ksys_read+0x68/0xe0
>  => do_syscall_64+0x3b/0x90
>  => entry_SYSCALL_64_after_hwframe+0x44/0xae
>              cat-136     [000] ...1.    14.474971: r_vfs_read_0: (ksys_read+0x68/0xe0 <- vfs_read)
> 
> This shows the double return probes (vfs_read() and full_proxy_read()) on the stack
> correctly unwinded. (vfs_read() returns to 'ksys_read+0x68' and full_proxy_read()
> returns to 'vfs_read+0x99')
> 
> This also changes the kretprobe behavisor a bit, now the instraction pointer in
> the 'pt_regs' passed to kretprobe user handler is correctly set the real return
> address. So user handlers can get it via instruction_pointer() API, and can use
> stack_trace_save_regs().
> 
> You can also get this series from 
>  git://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git kprobes/kretprobe-stackfix-v11
> 
> 
> Thank you,
> 
> ---
> 
> Josh Poimboeuf (3):
>       objtool: Add frame-pointer-specific function ignore
>       objtool: Ignore unwind hints for ignored functions
>       x86/kprobes: Add UNWIND_HINT_FUNC on kretprobe_trampoline()
> 
> Masami Hiramatsu (19):
>       kprobes: treewide: Cleanup the error messages for kprobes
>       kprobes: Fix coding style issues
>       kprobes: Use IS_ENABLED() instead of kprobes_built_in()
>       kprobes: Add assertions for required lock
>       kprobes: treewide: Use 'kprobe_opcode_t *' for the code address in get_optimized_kprobe()
>       kprobes: Use bool type for functions which returns boolean value
>       ia64: kprobes: Fix to pass correct trampoline address to the handler
>       kprobes: treewide: Replace arch_deref_entry_point() with dereference_symbol_descriptor()
>       kprobes: treewide: Remove trampoline_address from kretprobe_trampoline_handler()
>       kprobes: treewide: Make it harder to refer kretprobe_trampoline directly
>       kprobes: Add kretprobe_find_ret_addr() for searching return address
>       ARC: Add instruction_pointer_set() API
>       ia64: Add instruction_pointer_set() API
>       arm: kprobes: Make space for instruction pointer on stack
>       kprobes: Enable stacktrace from pt_regs in kretprobe handler
>       x86/kprobes: Push a fake return address at kretprobe_trampoline
>       x86/unwind: Recover kretprobe trampoline entry
>       tracing: Show kretprobe unknown indicator only for kretprobe_trampoline
>       x86/kprobes: Fixup return address in generic trampoline handler
> 
> Punit Agrawal (5):
>       kprobes: Do not use local variable when creating debugfs file
>       kprobes: Use helper to parse boolean input from userspace
>       kprobe: Simplify prepare_kprobe() by dropping redundant version
>       csky: ftrace: Drop duplicate implementation of arch_check_ftrace_location()
>       kprobes: Make arch_check_ftrace_location static
> 
> 
>  arch/arc/include/asm/kprobes.h                |    2 
>  arch/arc/include/asm/ptrace.h                 |    5 
>  arch/arc/kernel/kprobes.c                     |   13 -
>  arch/arm/probes/kprobes/core.c                |   15 -
>  arch/arm/probes/kprobes/opt-arm.c             |    7 
>  arch/arm64/include/asm/kprobes.h              |    2 
>  arch/arm64/kernel/probes/kprobes.c            |   10 
>  arch/arm64/kernel/probes/kprobes_trampoline.S |    4 
>  arch/csky/include/asm/kprobes.h               |    2 
>  arch/csky/kernel/probes/ftrace.c              |    7 
>  arch/csky/kernel/probes/kprobes.c             |   14 -
>  arch/csky/kernel/probes/kprobes_trampoline.S  |    4 
>  arch/ia64/include/asm/ptrace.h                |    5 
>  arch/ia64/kernel/kprobes.c                    |   15 -
>  arch/mips/kernel/kprobes.c                    |   26 +
>  arch/parisc/kernel/kprobes.c                  |    6 
>  arch/powerpc/include/asm/kprobes.h            |    2 
>  arch/powerpc/kernel/kprobes.c                 |   29 -
>  arch/powerpc/kernel/optprobes.c               |    8 
>  arch/powerpc/kernel/stacktrace.c              |    2 
>  arch/riscv/include/asm/kprobes.h              |    2 
>  arch/riscv/kernel/probes/kprobes.c            |   15 -
>  arch/riscv/kernel/probes/kprobes_trampoline.S |    4 
>  arch/s390/include/asm/kprobes.h               |    2 
>  arch/s390/kernel/kprobes.c                    |   16 -
>  arch/s390/kernel/stacktrace.c                 |    2 
>  arch/sh/include/asm/kprobes.h                 |    2 
>  arch/sh/kernel/kprobes.c                      |   12 -
>  arch/sparc/include/asm/kprobes.h              |    2 
>  arch/sparc/kernel/kprobes.c                   |   12 -
>  arch/x86/include/asm/kprobes.h                |    1 
>  arch/x86/include/asm/unwind.h                 |   23 +
>  arch/x86/include/asm/unwind_hints.h           |    5 
>  arch/x86/kernel/kprobes/core.c                |   71 +++-
>  arch/x86/kernel/kprobes/opt.c                 |    6 
>  arch/x86/kernel/unwind_frame.c                |    3 
>  arch/x86/kernel/unwind_guess.c                |    3 
>  arch/x86/kernel/unwind_orc.c                  |   21 +
>  include/linux/kprobes.h                       |  113 ++++--
>  include/linux/objtool.h                       |   12 +
>  kernel/kprobes.c                              |  502 ++++++++++++++-----------
>  kernel/trace/trace_kprobe.c                   |    2 
>  kernel/trace/trace_output.c                   |   17 -
>  lib/error-inject.c                            |    3 
>  tools/include/linux/objtool.h                 |   12 +
>  tools/objtool/check.c                         |    2 
>  46 files changed, 607 insertions(+), 436 deletions(-)
> 
> --
> Masami Hiramatsu (Linaro) <mhiramat@kernel.org>


-- 
Masami Hiramatsu <mhiramat@kernel.org>
