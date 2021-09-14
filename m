Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 290D440BBD4
	for <lists+bpf@lfdr.de>; Wed, 15 Sep 2021 00:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235638AbhINW5L (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 18:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbhINW5K (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Sep 2021 18:57:10 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B62C061574;
        Tue, 14 Sep 2021 15:55:52 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id s11so1512042yba.11;
        Tue, 14 Sep 2021 15:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0B3klIkpb3nInzJRZwG50vUBeb7cpWi8YoICQPgl+iI=;
        b=NClC5iW4gXTXrl99QvDPgtEkHY2B9mqNdZRT00HzJe4fKnRoF9S4VpRkxCkkYiO1qC
         TcNHFjsCIdpSR0Z+XcoElB16L63kpZoMdBwcRu6GcnSRLTcsrFomW4JqNZUB+ovbKkKd
         KeutWuvdWfoZMvFUPQCrfa0Wu7pnxMA0P/+VHal6htxJulS/HE7KV1ZhDaRKINN/DBAL
         yzIP0DC5OXJAmLAv/AriWd/TfbPCQokuyuQvblItRvlt6AkCSWB8COeYfLm+80D1/Mle
         bxFN43durd2Oe4FLeIz+7u0CVWRV4JYk+j5eQaULQ7lF7SGQAKp32+tx2nNWAxcQErSV
         EwAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0B3klIkpb3nInzJRZwG50vUBeb7cpWi8YoICQPgl+iI=;
        b=ySoAyEg/pdj4lEFhtqCgidz0Cu4ewH6kKgsM52lgLHEpmbAQ9rEIsRAlahP2uKZXBI
         GFl3RGE1Av0cb71NuoeGL4HjT/3ligI8dX//tFvLcGE00yB8eSFab7+5onpG/4Lppi0Z
         w7M1vVYT18qtCicCJACgFj6ulbFIZD5kF+syxL9Nrok7vf4EwBXzaL6bG1VAQjHYA810
         AaffhlTPvyoTTSEbTi/Xx6zk8fM9bGr1Mk0z3+zrF5EhqZoqW++yRGlIVqoZ3YvAbBXK
         phwSLQpnio9yINFUP4e/9lHb632xWFTowNRPKrrWj4kB8IZSVQlDrReHPlw8VlsX6125
         1EEA==
X-Gm-Message-State: AOAM533oFC7sHt64XjM2urISxsGHBOuKcGKJwRz2Kz7qOLVLxTeBjxJI
        RndtZdFa9mXTPC5elD9aT+AXX2xPLSr37wPrOec=
X-Google-Smtp-Source: ABdhPJwZhtOZnW/SAsDIaJy9ovBDZT4STyMWszIVik9OhcGii4FS4g8CftwDOh0DjHPE30OHClcZTbCNj7iQw9bWk/o=
X-Received: by 2002:a25:bbc4:: with SMTP id c4mr2215277ybk.114.1631660151720;
 Tue, 14 Sep 2021 15:55:51 -0700 (PDT)
MIME-Version: 1.0
References: <163163030719.489837.2236069935502195491.stgit@devnote2>
In-Reply-To: <163163030719.489837.2236069935502195491.stgit@devnote2>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 14 Sep 2021 15:55:40 -0700
Message-ID: <CAEf4BzaAHhEgsyBV07Q37FkUSh9wypuJW6HqJ1jS8-XrjzKDmA@mail.gmail.com>
Subject: Re: [PATCH -tip v11 00/27] kprobes: Fix stacktrace with kretprobes on x86
To:     Masami Hiramatsu <mhiramat@kernel.org>
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
        Abhishek Sagar <sagar.abhishek@gmail.com>,
        Paul McKenney <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 14, 2021 at 7:38 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
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

Re-tested with latest BPF selftests and retsnoop tool utilizing
kretprobe and capturing stack traces (broken without these changes).
Looks good, thank you!

Tested-by: Andrii Nakryiko <andriin@kernel.org>

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
