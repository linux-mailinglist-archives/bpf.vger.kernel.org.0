Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4AF391E46
	for <lists+bpf@lfdr.de>; Wed, 26 May 2021 19:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbhEZRlm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 May 2021 13:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhEZRll (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 May 2021 13:41:41 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F97C061574;
        Wed, 26 May 2021 10:40:09 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id g38so3169247ybi.12;
        Wed, 26 May 2021 10:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DJ9ACjlxnCUJLajZkvUg3JRAmdPpDh57UE8Z7+zKl2E=;
        b=q14fR1x7ZC6FG7q+YFW4P6RUspWpjhXIvmW9USnA/SUNqRH1AUzv0WSzhYqRTohAz2
         7irBwyQJFjA/i8GFWP8rx/cQwO6X5VHW3uQ4nvaXVtNHbSDiQY5SB2oDQ895viceF7P3
         Fz1wQd6cmUcIc9W/QWS79G+z47BFExxBBKSlMv8thl79VEZJ/MRhnLZB+D+cqHCTzjXH
         H39PDvxNpLrpYYaQaTRryNMAiAoc+3SfPpYsM28btzVdYJn0vba13w1/RTDgu2ulV1EH
         ojkaLc4nwVpuiFi5aJtzofc1iU9DKu/HasrzoYs9EjIKw+VK/NIbWd+/+9Ucn47ddRyE
         fhng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DJ9ACjlxnCUJLajZkvUg3JRAmdPpDh57UE8Z7+zKl2E=;
        b=FWOC+7OIHve66YafO5DfIYPIN51ARKXW7BYGEZki2NDluiE8WrsfNBtfp1yQGGKq/G
         mQTsE0jdoX1Tta9DX9XoajBlTIEM7vEdRSPxqBxar5ZzhUo2jOGqy9a9rvzrXVcLvZsS
         kbi45shpQ7XDfzsDGLbMS9csvslQopCh81GoGrcEkga6GI5qRHHcSgCG3XCu3oecjn+3
         VYUgE6Pem/+KP8gIFSlPJTXmkMBRjaX+iuEDEIscIvPolihK1ed2LdI/mTz3nyVyqOzm
         p//2QgGFEcyoffjyo6SoIEYhKISQIKszVQigUPTKoacHhaOuJVKyuSIQY2M3Vh7uVxXz
         Rl4Q==
X-Gm-Message-State: AOAM5328VR3l35GLvnogt39RPsbqC1k7INBVtLhb926gk57uQ62+nPQn
        mXPmHb8w1vJT1wKmsPokF2Ya+Q4qvM3U7UwyzVBahQVG
X-Google-Smtp-Source: ABdhPJyHiz6p+6b1Nq2tExGkbdorYbnD1UY697xYQETPqevt15o2HZJjdTPsN4ZBFpMJFOsWxQsAmgFDAigeVojp2nQ=
X-Received: by 2002:a5b:286:: with SMTP id x6mr54464936ybl.347.1622050808310;
 Wed, 26 May 2021 10:40:08 -0700 (PDT)
MIME-Version: 1.0
References: <162201612941.278331.5293566981784464165.stgit@devnote2>
In-Reply-To: <162201612941.278331.5293566981784464165.stgit@devnote2>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 26 May 2021 10:39:57 -0700
Message-ID: <CAEf4BzbTKwnuutnJG6ALYX_YgLPg0Tzm+BNRGYLfh62oZPNGpg@mail.gmail.com>
Subject: Re: [PATCH -tip v6 00/13] kprobes: Fix stacktrace with kretprobes on x86
To:     Masami Hiramatsu <mhiramat@kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 26, 2021 at 1:02 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> Hello,
>
> Here is the 6th version of the series to fix the stacktrace with kretprobe
> on x86.
>
> The previous version is;
>
>  https://lore.kernel.org/bpf/161676170650.330141.6214727134265514123.stgit@devnote2/
>
> This version is rebased on the latest tip tree and add some patches for
> improving stacktrace[13/13].
>
> Changes from v5:
> [02/13]:
>   - Use dereference_symbol_descriptor() instead of dereference_function_descriptor()
> [04/13]:
>   - Replace BUG_ON() with WARN_ON_ONCE() in __kretprobe_trampoline_handler().
> [13/13]:
>   - Add a new patch to fix return address in earlier stage.
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
> address. So user handlers can get it via instruction_pointer() API.
>
> You can also get this series from
>  git://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git kprobes/kretprobe-stackfix-v6
>
>
> Thank you,
>
> ---
>

Thanks for following up on this! I've applied this patch set on top of
bpf-next and tested with my local BPF-based tool that uses stack
traces in kretprobes heavily. It all works now and I'm getting
meaningful and correctly looking stacktraces. Thanks a lot!

Tested-by: Andrii Nakryik <andrii@kernel.org>


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
>       kprobes: Setup instruction pointer in __kretprobe_trampoline_handler
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
>  arch/x86/kernel/unwind_frame.c      |    4 +
>  arch/x86/kernel/unwind_guess.c      |    3 -
>  arch/x86/kernel/unwind_orc.c        |   19 +++++-
>  include/linux/kprobes.h             |   41 +++++++++++--
>  kernel/kprobes.c                    |  108 +++++++++++++++++++++++++----------
>  kernel/trace/trace_output.c         |   17 +-----
>  lib/error-inject.c                  |    3 +
>  25 files changed, 237 insertions(+), 105 deletions(-)
>
> --
> Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
