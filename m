Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 724E032C298
	for <lists+bpf@lfdr.de>; Thu,  4 Mar 2021 01:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391279AbhCCWd2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Mar 2021 17:33:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:38932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1578528AbhCCEtP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Mar 2021 23:49:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 996D464E86;
        Wed,  3 Mar 2021 04:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614746912;
        bh=2Xca8x9wbooaqbFV/0T0htnTgUXTo0FSs3BlsceoobY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=U8eO64NVL5Eoo7yZfv5TElRsz7ky182deE0coW76Z0tm7yI96MLzsd1O65tuYNiwv
         TKTdYIBpxyRbeaEglZsuSwJ2IIAgFB5X52GacfYZveMtNfI7ZN+pmqjlraa0nnUgug
         RdAk6s3wqAVJlgbNnj7a7MVFSi5wD5FbJBN4e0qGZhb9gB9JunUEpzXBeSHbuJf3vo
         n9h9/u9IDfM8nlLaUza3nSpOSL66TUcmmenU5SwzVIN1OsnJwU5yY0Bmb/XP6iX2P9
         H+FqqQ9VY19yFlR8nfVgDjbBEWRa3gIYnuVkD5DZBebdKZ45NXXqYglj6jf8k9Ba4p
         ydqOJKE0YRNog==
Date:   Wed, 3 Mar 2021 13:48:28 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     "Daniel Xu" <dxu@dxuuu.xyz>
Cc:     linux-kernel@vger.kernel.org,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>, kuba@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Broken kretprobe stack traces
Message-Id: <20210303134828.39922eb167524bc7206c7880@kernel.org>
In-Reply-To: <1fed0793-391c-4c68-8d19-6dcd9017271d@www.fastmail.com>
References: <1fed0793-391c-4c68-8d19-6dcd9017271d@www.fastmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Daniel,

On Tue, 02 Mar 2021 17:15:13 -0800
"Daniel Xu" <dxu@dxuuu.xyz> wrote:

> Hi Masami,
> 
> Jakub reported a bug with kretprobe stack traces -- wondering if you've gotten
> any bug reports related to stack traces being broken for kretprobes.

Yeah, stack dumper must check the stack entry is kretprobe'd and skip it.
For example, ftrace checks it as below.

/sys/kernel/debug/tracing # echo r vfs_read > kprobe_events 
/sys/kernel/debug/tracing # echo stacktrace > events/kprobes/r_vfs_read_0/trigger 
/sys/kernel/debug/tracing # echo 1 > events/kprobes/r_vfs_read_0/enable 
/sys/kernel/debug/tracing # head -20 trace
# tracer: nop
#
# entries-in-buffer/entries-written: 15685/336094   #P:8
#
#                                _-----=> irqs-off
#                               / _----=> need-resched
#                              | / _---=> hardirq/softirq
#                              || / _--=> preempt-depth
#                              ||| /     delay
#           TASK-PID     CPU#  ||||   TIMESTAMP  FUNCTION
#              | |         |   ||||      |         |
              sh-132     [006] ...1    38.920352: <stack trace>
 => kretprobe_dispatcher
 => __kretprobe_trampoline_handler
 => trampoline_handler
 => [unknown/kretprobe'd]
 => [unknown/kretprobe'd]
 => __x64_sys_read
 => do_syscall_64
 => entry_SYSCALL_64_after_hwframe


> 
> I think (can't prove) this used to work:

I'm not sure the bpftrace had correctly handled it or not.

> 
>     # bpftrace -e 'kretprobe:__tcp_retransmit_skb { @[kstack()] = count() }'
>     Attaching 1 probe...
>     ^C
> 
>     @[
>         kretprobe_trampoline+0
>     ]: 1

Would you know how the bpftrace stacktracer rewinds the stack entries?
FYI, ftrace does it in trace_seq_print_sym()@kernel/trace/trace_output.c

Thank you,

> 
> fentry/fexit probes seem to work:
> 
>     # bpftrace -e 'kretfunc:__tcp_retransmit_skb { @[kstack()] = count() }'
>     Attaching 1 probe...
>     ^C
>     
>     @[
>         ftrace_trampoline+10799
>         bpf_get_stackid_raw_tp+121
>         ftrace_trampoline+10799
>         __tun_chr_ioctl.isra.0.cold+33312
>         __tcp_retransmit_skb+5
>         tcp_send_loss_probe+254
>         tcp_write_timer_handler+394
>         tcp_write_timer+149
>         call_timer_fn+41
>         __run_timers+493
>         run_timer_softirq+25
>         __softirqentry_text_start+207
>         asm_call_sysvec_on_stack+18
>         do_softirq_own_stack+55
>         irq_exit_rcu+158
>         sysvec_apic_timer_interrupt+54
>         asm_sysvec_apic_timer_interrupt+18
>     ]: 1
>     @[
>         ftrace_trampoline+10799
>         bpf_get_stackid_raw_tp+121
>         ftrace_trampoline+10799
>         __tun_chr_ioctl.isra.0.cold+33312
>         __tcp_retransmit_skb+5
>   <...>
> 
> which makes me suspect it's a kprobe specific issue.
> 
> Thanks,
> Daniel


-- 
Masami Hiramatsu <mhiramat@kernel.org>
