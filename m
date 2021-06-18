Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 007E63AD16F
	for <lists+bpf@lfdr.de>; Fri, 18 Jun 2021 19:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234428AbhFRRrD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Jun 2021 13:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233642AbhFRRrC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Jun 2021 13:47:02 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D306BC061574;
        Fri, 18 Jun 2021 10:44:51 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id c138so12873828qkg.5;
        Fri, 18 Jun 2021 10:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FR+j4ibUZYxVxtLHYp5VfTmT/DdQ17eK0rtdrvCRg0Y=;
        b=B6A0thG6L6xsHikbc/o6Z5vKwZm8BGzLTDsuvRo6crCr37R5zGV2RuscVXGheWA4V/
         N93Ct/UfnfBuz5+sb3V6kbl5kzLXdF4/BdwhWQ5OFVO3lUrAm5viqC+ErwzD6kugxnSt
         1zXKQETmX95NjAWJ1zrjx7NCBPtN15LYx3Tv2sHsthelvIWyHEu72UE3kx9Fzv9GNqJW
         m1X5YQXGgtEH86EOreFRROrKvA7JH3ihdeJJdb5pmvW1ZvmueRTrmwJ39z0cXNjkBqJH
         WHEaH3AXjjn6WDW8m1kO/7B5JqxRlyta0ht4YBsfUOQtPbix18He9MLE2A5iZZU/Atp4
         YXUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FR+j4ibUZYxVxtLHYp5VfTmT/DdQ17eK0rtdrvCRg0Y=;
        b=JhceB9KZJx8z7XmJehW1oQovM8nCiWQUifRAOopQ1CcUK+LNMQpX4I87P1eUuVl3eh
         W/lEAdhevgld63jF8K/o0IEkjfy9lyKK19Vhqjzf3ijXSAt9C0UPNQ7QHRuU2euFmPXh
         vB50E/aoEhEhFgwalbdnaFWeYpkNfmeHn/OJvUd+BcheSn9GreC0vTKeDXo0Ir68OPHF
         mipZWtxHhRi1+3+3aGfl6jAH5Spj25Z62UveGssJ2OJAPf4cGwwthnIqk0JwsNArMEoO
         5ASwKWCZG199ba9HOf4rn8R+nMvzG7Xooi6ep1ywPq+IvUiKp6SXqDh587DAFp6UIeQ+
         YhEg==
X-Gm-Message-State: AOAM533QahuHFUTkvCy0yla2Wo8co5h/LNUiLDbGErIwU0tNbpGazls3
        9Wugooi8HEV6nYLHVmeiMhV1csIXMHbj3sGtZFs=
X-Google-Smtp-Source: ABdhPJzgJgF6ywtzAw/DmT6x6GNlEgN4QIxsZf+y8JTa1ZWuJjmsnTsIKvMOTFGbzerL6tyibjGc459UWW6x8qPiFPA=
X-Received: by 2002:a25:b741:: with SMTP id e1mr5806503ybm.347.1624038290998;
 Fri, 18 Jun 2021 10:44:50 -0700 (PDT)
MIME-Version: 1.0
References: <162399992186.506599.8457763707951687195.stgit@devnote2>
In-Reply-To: <162399992186.506599.8457763707951687195.stgit@devnote2>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 18 Jun 2021 10:44:39 -0700
Message-ID: <CAEf4BzaoRZ4GOR7aP6G9NQmrgQ4VifStbieeEm=tcxiMsOb57A@mail.gmail.com>
Subject: Re: [PATCH -tip v8 00/13] kprobes: Fix stacktrace with kretprobes on x86
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
        Abhishek Sagar <sagar.abhishek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jun 18, 2021 at 12:05 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
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

It works for BPF cases. Thanks!

Tested-by: Andrii Nakryiko <andrii@kernel.org>


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
