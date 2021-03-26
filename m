Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFFB34B325
	for <lists+bpf@lfdr.de>; Sat, 27 Mar 2021 00:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbhCZXth (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Mar 2021 19:49:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:52168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230343AbhCZXt1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Mar 2021 19:49:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1749A619E4;
        Fri, 26 Mar 2021 23:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616802567;
        bh=hEIUPf9Cy1KrnmqTliwoUoilooZlC/3f7DU61g9/wHc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CUXQg7D2cIQq4P6tH0ChrbEfcWlgWGUwtTK6L2O/UggTirNTptYK+9n2akspxUzct
         WoCg5BXDPgK0zXSir0BywBCiEG/fkA6dAxrFI2zWqDv0jwAvj/7ClSCGXI7hAmHCV5
         gUEPXOy8eEpC0KwCcPZMncuhf6P1/8bL/8nyb78xm0v3l9KnE8CVqE4VW7pYmfo3tC
         qQcNQVR5FdckcjOczFDfXiDwT9+aUtMlXH0mj/Xxx3Fg7k/qiaJ4XEj3xvNJxoi5l7
         AOmScukUeTIH5eSXlMO+CgaDe8MWHmWbud/fyEOHln+2WIZf9dW2Q2SO0uQIXlzaQR
         HAAis91KCWuIA==
Date:   Sat, 27 Mar 2021 08:49:21 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, tglx@linutronix.de, kernel-team@fb.com, yhs@fb.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>
Subject: Re: [PATCH -tip v5 00/12] kprobes: Fix stacktrace with kretprobes
 on x86
Message-Id: <20210327084921.89473486c5b73dda94fcb172@kernel.org>
In-Reply-To: <161676170650.330141.6214727134265514123.stgit@devnote2>
References: <161676170650.330141.6214727134265514123.stgit@devnote2>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 26 Mar 2021 21:28:26 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hello,
> 
> Here is the 5th version of the series to fix the stacktrace with kretprobe
> on x86. After merging this, I'll fix other architectures.
> 
> The previous version is;
> 
> https://lore.kernel.org/bpf/161639518354.895304.15627519393073806809.stgit@devnote2/
> 
> This version fixes a build error from a typo in [1/12] and the
> case of interrupt happens on kretprobe_trampoline+0 in [11/12].
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

BTW, this is only for the kretprobe on x86. ORC unwinder (without pt_regs)
still stopped when the kprobe is optimized.


# entries-in-buffer/entries-written: 4/4   #P:8
#
#                                _-----=> irqs-off
#                               / _----=> need-resched
#                              | / _---=> hardirq/softirq
#                              || / _--=> preempt-depth
#                              ||| /     delay
#           TASK-PID     CPU#  ||||   TIMESTAMP  FUNCTION
#              | |         |   ||||      |         |
             cat-138     [005] ...1     9.501630: p_full_proxy_read_5: (full_proxy_read+0x5/0x80)
             cat-138     [005] ...1     9.501675: <stack trace>
 => kprobe_trace_func+0x1d0/0x2c0
 => kprobe_dispatcher+0x39/0x60
 => opt_pre_handler+0x4f/0x80
 => optimized_callback+0xc3/0xf0
 => 0xffffffffa0006032
 => 0

This requires another fix. I think the unwinder can refer the ORC info
(as a bias from the original function) from optprobe_template_func if
it finds the frame address is in the optprobe trampoline buffer.
Note that this is a bit different from the kretprobe_trampoline, because
optprobe trampoline code is cloned for each probed address.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
