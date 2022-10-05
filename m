Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2465F5C72
	for <lists+bpf@lfdr.de>; Thu,  6 Oct 2022 00:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiJEWMa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Oct 2022 18:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiJEWM0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Oct 2022 18:12:26 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9328307D;
        Wed,  5 Oct 2022 15:12:22 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id 13so698883ejn.3;
        Wed, 05 Oct 2022 15:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aUv12Ps+d8c83bpBxAt8IvYSTG0FAKuKCZixocXljkw=;
        b=gwlCq7fIpFl3gZiufw2foklvXpOp4nitQSSITSxU5aHImh7tH8HGgldbw6tqX1103W
         5pX7g5OdZ5PShaCPmwvNZUHP3sWXQsR0OQnUE2BgfBbLU73JIaXfa+5Mdltj8tT2ZcXv
         MD+xEjEag6noz/UTZJ6F/3lTeZkNpXTVoOTWAZcqswPT5Z8pQbwiiu1h2KbuXX3Ts0Bb
         PVYziK8Y510fouNp33darZA9gCdCQBmme64It1qvYW7oQ4g7oLrNP7rrcWbuQ9G6KFJ6
         GL7dUglcEZUCxuxQ/2JlbY00O9cfsET59mp5hmXryFKSpbvaz/vjkqjW6NgLzrBmLdvW
         lQgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aUv12Ps+d8c83bpBxAt8IvYSTG0FAKuKCZixocXljkw=;
        b=auuG2D2vcbkGqyUKTwIDLCLrNavC/+KY2YdL+/y9fqDvWlkrIf+WAy9GAlwZV8oRJF
         P0aAOtmHdCkbRw4v2WDmuDWe6z/6znybAE3HabuqlHZbmAgiQcjqMTOOZmVDtZ/6HgwU
         AcRaQNtZOcfHyKhHuOe3KTC5As0voB7Ikqse4iGsgRmadxSEupxqXxNdNdemAuIjopbs
         GujulAQOvRoMAp00FnKTQjJzv0YtO/5aImams1KBCtg0iVsUP9FlMhYCjBJnO1atH174
         UbTf3hICUbJasIrRuUcOMhkdBJ3erY2Xo0wLypzg8raVdXglPsSzFR+qA3t1Wy9NgC62
         5UuQ==
X-Gm-Message-State: ACrzQf03fja+wsrJD2gCpSbIBtlWN1Siq9wx+ChvevVvRvpzE/Ol3xcr
        eBWhUtLLTatpDIr5ztXmJxQ=
X-Google-Smtp-Source: AMsMyM6X04bPH4h6VK1Hhb5gbJTdKDMUkgfQIciMWJ+Acmfr6DJarysk2w1c1RW/zJM73ocCbms0kA==
X-Received: by 2002:a17:907:2d8e:b0:783:8d26:645 with SMTP id gt14-20020a1709072d8e00b007838d260645mr1320362ejc.535.1665007940711;
        Wed, 05 Oct 2022 15:12:20 -0700 (PDT)
Received: from krava ([83.240.63.251])
        by smtp.gmail.com with ESMTPSA id hp20-20020a1709073e1400b0072b33e91f96sm3601477ejc.190.2022.10.05.15.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 15:12:20 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 6 Oct 2022 00:12:17 +0200
To:     Steven Rostedt <rostedt@goodmis.org>,
        Florent Revest <revest@chromium.org>
Cc:     Xu Kuohai <xukuohai@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Xu Kuohai <xukuohai@huaweicloud.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, Will Deacon <will@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Zi Shen Lim <zlim.lnx@gmail.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Guo Ren <guoren@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH bpf-next v2 0/4] Add ftrace direct call for arm64
Message-ID: <Yz4BQXtYPa/TU652@krava>
References: <YzG51Jyd5zhvygtK@arm.com>
 <YzHk1zRf1Dp8YTEe@FVFF77S0Q05N>
 <970a25e4-9b79-9e0c-b338-ed1a934f2770@huawei.com>
 <YzR5WSLux4mmFIXg@FVFF77S0Q05N>
 <2cb606b4-aa8b-e259-cdfd-1bfc61fd7c44@huawei.com>
 <CABRcYmKPchvtkkgWhOJ6o3pHVqTWeenGawHfZ2ug8Akdh6NfnQ@mail.gmail.com>
 <7f34d333-3b2a-aea5-f411-d53be2c46eee@huawei.com>
 <20221005110707.55bd9354@gandalf.local.home>
 <CABRcYmJGY6fp0CtUBYN8BjEDN=r42BPLSBcrxqu491bTRmfm7g@mail.gmail.com>
 <20221005113019.18aeda76@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221005113019.18aeda76@gandalf.local.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 05, 2022 at 11:30:19AM -0400, Steven Rostedt wrote:
> On Wed, 5 Oct 2022 17:10:33 +0200
> Florent Revest <revest@chromium.org> wrote:
> 
> > On Wed, Oct 5, 2022 at 5:07 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> > >
> > > On Wed, 5 Oct 2022 22:54:15 +0800
> > > Xu Kuohai <xukuohai@huawei.com> wrote:
> > >  
> > > > 1.3 attach bpf prog with with direct call, bpftrace -e 'kfunc:vfs_write {}'
> > > >
> > > > # dd if=/dev/zero of=/dev/null count=1000000
> > > > 1000000+0 records in
> > > > 1000000+0 records out
> > > > 512000000 bytes (512 MB, 488 MiB) copied, 1.72973 s, 296 MB/s
> > > >
> > > >
> > > > 1.4 attach bpf prog with with indirect call, bpftrace -e 'kfunc:vfs_write {}'
> > > >
> > > > # dd if=/dev/zero of=/dev/null count=1000000
> > > > 1000000+0 records in
> > > > 1000000+0 records out
> > > > 512000000 bytes (512 MB, 488 MiB) copied, 1.99179 s, 257 MB/s  
> > 
> > Thanks for the measurements Xu!
> > 
> > > Can you show the implementation of the indirect call you used?  
> > 
> > Xu used my development branch here
> > https://github.com/FlorentRevest/linux/commits/fprobe-min-args

nice :) I guess you did not try to run it on x86, I had to add some small
changes and disable HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS to compile it

> 
> That looks like it could be optimized quite a bit too.
> 
> Specifically this part:
> 
> static bool bpf_fprobe_entry(struct fprobe *fp, unsigned long ip, struct ftrace_regs *regs, void *private)
> {
> 	struct bpf_fprobe_call_context *call_ctx = private;
> 	struct bpf_fprobe_context *fprobe_ctx = fp->ops.private;
> 	struct bpf_tramp_links *links = fprobe_ctx->links;
> 	struct bpf_tramp_links *fentry = &links[BPF_TRAMP_FENTRY];
> 	struct bpf_tramp_links *fmod_ret = &links[BPF_TRAMP_MODIFY_RETURN];
> 	struct bpf_tramp_links *fexit = &links[BPF_TRAMP_FEXIT];
> 	int i, ret;
> 
> 	memset(&call_ctx->ctx, 0, sizeof(call_ctx->ctx));
> 	call_ctx->ip = ip;
> 	for (i = 0; i < fprobe_ctx->nr_args; i++)
> 		call_ctx->args[i] = ftrace_regs_get_argument(regs, i);
> 
> 	for (i = 0; i < fentry->nr_links; i++)
> 		call_bpf_prog(fentry->links[i], &call_ctx->ctx, call_ctx->args);
> 
> 	call_ctx->args[fprobe_ctx->nr_args] = 0;
> 	for (i = 0; i < fmod_ret->nr_links; i++) {
> 		ret = call_bpf_prog(fmod_ret->links[i], &call_ctx->ctx,
> 				      call_ctx->args);
> 
> 		if (ret) {
> 			ftrace_regs_set_return_value(regs, ret);
> 			ftrace_override_function_with_return(regs);
> 
> 			bpf_fprobe_exit(fp, ip, regs, private);
> 			return false;
> 		}
> 	}
> 
> 	return fexit->nr_links;
> }
> 
> There's a lot of low hanging fruit to speed up there. I wouldn't be too
> fast to throw out this solution if it hasn't had the care that direct calls
> have had to speed that up.
> 
> For example, trampolines currently only allow to attach to functions with 6
> parameters or less (3 on x86_32). You could make 7 specific callbacks, with
> zero to 6 parameters, and unroll the argument loop.
> 
> Would also be interesting to run perf to see where the overhead is. There
> may be other locations to work on to make it almost as fast as direct
> callers without the other baggage.

I can boot the change and run tests in qemu but for some reason it
won't boot on hw, so I have just perf report from qemu so far

there's fprobe/rethook machinery showing out as expected

jirka


---
# To display the perf.data header info, please use --header/--header-only options.
#
#
# Total Lost Samples: 0
#
# Samples: 23K of event 'cpu-clock:k'
# Event count (approx.): 5841250000
#
# Overhead  Command  Shared Object                                   Symbol                                            
# ........  .......  ..............................................  ..................................................
#
    18.65%  bench    [kernel.kallsyms]                               [k] syscall_enter_from_user_mode
            |
            ---syscall_enter_from_user_mode
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               syscall

    13.03%  bench    [kernel.kallsyms]                               [k] seqcount_lockdep_reader_access.constprop.0
            |
            ---seqcount_lockdep_reader_access.constprop.0
               ktime_get_coarse_real_ts64
               syscall_trace_enter.constprop.0
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               syscall

     9.49%  bench    [kernel.kallsyms]                               [k] rethook_try_get
            |
            ---rethook_try_get
               fprobe_handler
               ftrace_trampoline
               __x64_sys_getpgid
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               syscall

     8.71%  bench    [kernel.kallsyms]                               [k] rethook_recycle
            |
            ---rethook_recycle
               fprobe_handler
               ftrace_trampoline
               __x64_sys_getpgid
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               syscall

     4.31%  bench    [kernel.kallsyms]                               [k] rcu_is_watching
            |
            ---rcu_is_watching
               |          
               |--1.49%--rethook_try_get
               |          fprobe_handler
               |          ftrace_trampoline
               |          __x64_sys_getpgid
               |          do_syscall_64
               |          entry_SYSCALL_64_after_hwframe
               |          syscall
               |          
               |--1.10%--do_getpgid
               |          __x64_sys_getpgid
               |          do_syscall_64
               |          entry_SYSCALL_64_after_hwframe
               |          syscall
               |          
               |--1.02%--__bpf_prog_exit
               |          call_bpf_prog.isra.0
               |          bpf_fprobe_entry
               |          fprobe_handler
               |          ftrace_trampoline
               |          __x64_sys_getpgid
               |          do_syscall_64
               |          entry_SYSCALL_64_after_hwframe
               |          syscall
               |          
                --0.70%--__bpf_prog_enter
                          call_bpf_prog.isra.0
                          bpf_fprobe_entry
                          fprobe_handler
                          ftrace_trampoline
                          __x64_sys_getpgid
                          do_syscall_64
                          entry_SYSCALL_64_after_hwframe
                          syscall

     2.94%  bench    [kernel.kallsyms]                               [k] lock_release
            |
            ---lock_release
               |          
               |--1.51%--call_bpf_prog.isra.0
               |          bpf_fprobe_entry
               |          fprobe_handler
               |          ftrace_trampoline
               |          __x64_sys_getpgid
               |          do_syscall_64
               |          entry_SYSCALL_64_after_hwframe
               |          syscall
               |          
                --1.43%--do_getpgid
                          __x64_sys_getpgid
                          do_syscall_64
                          entry_SYSCALL_64_after_hwframe
                          syscall

     2.91%  bench    bpf_prog_21856463590f61f1_bench_trigger_fentry  [k] bpf_prog_21856463590f61f1_bench_trigger_fentry
            |
            ---bpf_prog_21856463590f61f1_bench_trigger_fentry
               |          
                --2.66%--call_bpf_prog.isra.0
                          bpf_fprobe_entry
                          fprobe_handler
                          ftrace_trampoline
                          __x64_sys_getpgid
                          do_syscall_64
                          entry_SYSCALL_64_after_hwframe
                          syscall

     2.69%  bench    [kernel.kallsyms]                               [k] bpf_fprobe_entry
            |
            ---bpf_fprobe_entry
               fprobe_handler
               ftrace_trampoline
               __x64_sys_getpgid
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               syscall

     2.60%  bench    [kernel.kallsyms]                               [k] lock_acquire
            |
            ---lock_acquire
               |          
               |--1.34%--__bpf_prog_enter
               |          call_bpf_prog.isra.0
               |          bpf_fprobe_entry
               |          fprobe_handler
               |          ftrace_trampoline
               |          __x64_sys_getpgid
               |          do_syscall_64
               |          entry_SYSCALL_64_after_hwframe
               |          syscall
               |          
                --1.24%--do_getpgid
                          __x64_sys_getpgid
                          do_syscall_64
                          entry_SYSCALL_64_after_hwframe
                          syscall

     2.42%  bench    [kernel.kallsyms]                               [k] syscall_exit_to_user_mode_prepare
            |
            ---syscall_exit_to_user_mode_prepare
               syscall_exit_to_user_mode
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               syscall

     2.37%  bench    [kernel.kallsyms]                               [k] __audit_syscall_entry
            |
            ---__audit_syscall_entry
               syscall_trace_enter.constprop.0
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               |          
                --2.36%--syscall

     2.35%  bench    [kernel.kallsyms]                               [k] syscall_trace_enter.constprop.0
            |
            ---syscall_trace_enter.constprop.0
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               syscall

     2.12%  bench    [kernel.kallsyms]                               [k] check_preemption_disabled
            |
            ---check_preemption_disabled
               |          
                --1.55%--rcu_is_watching
                          |          
                           --0.59%--do_getpgid
                                     __x64_sys_getpgid
                                     do_syscall_64
                                     entry_SYSCALL_64_after_hwframe
                                     syscall

     2.00%  bench    [kernel.kallsyms]                               [k] fprobe_handler
            |
            ---fprobe_handler
               ftrace_trampoline
               __x64_sys_getpgid
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               syscall

     1.94%  bench    [kernel.kallsyms]                               [k] local_irq_disable_exit_to_user
            |
            ---local_irq_disable_exit_to_user
               syscall_exit_to_user_mode
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               syscall

     1.84%  bench    [kernel.kallsyms]                               [k] rcu_read_lock_sched_held
            |
            ---rcu_read_lock_sched_held
               |          
               |--0.93%--lock_acquire
               |          
                --0.90%--lock_release

     1.71%  bench    [kernel.kallsyms]                               [k] migrate_enable
            |
            ---migrate_enable
               __bpf_prog_exit
               call_bpf_prog.isra.0
               bpf_fprobe_entry
               fprobe_handler
               ftrace_trampoline
               __x64_sys_getpgid
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               syscall

     1.66%  bench    [kernel.kallsyms]                               [k] call_bpf_prog.isra.0
            |
            ---call_bpf_prog.isra.0
               bpf_fprobe_entry
               fprobe_handler
               ftrace_trampoline
               __x64_sys_getpgid
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               syscall

     1.53%  bench    [kernel.kallsyms]                               [k] __rcu_read_unlock
            |
            ---__rcu_read_unlock
               |          
               |--0.86%--__bpf_prog_exit
               |          call_bpf_prog.isra.0
               |          bpf_fprobe_entry
               |          fprobe_handler
               |          ftrace_trampoline
               |          __x64_sys_getpgid
               |          do_syscall_64
               |          entry_SYSCALL_64_after_hwframe
               |          syscall
               |          
                --0.66%--do_getpgid
                          __x64_sys_getpgid
                          do_syscall_64
                          entry_SYSCALL_64_after_hwframe
                          syscall

     1.31%  bench    [kernel.kallsyms]                               [k] debug_smp_processor_id
            |
            ---debug_smp_processor_id
               |          
                --0.77%--rcu_is_watching

     1.22%  bench    [kernel.kallsyms]                               [k] migrate_disable
            |
            ---migrate_disable
               __bpf_prog_enter
               call_bpf_prog.isra.0
               bpf_fprobe_entry
               fprobe_handler
               ftrace_trampoline
               __x64_sys_getpgid
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               syscall

     1.19%  bench    [kernel.kallsyms]                               [k] __bpf_prog_enter
            |
            ---__bpf_prog_enter
               call_bpf_prog.isra.0
               bpf_fprobe_entry
               fprobe_handler
               ftrace_trampoline
               __x64_sys_getpgid
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               syscall

     0.84%  bench    [kernel.kallsyms]                               [k] __radix_tree_lookup
            |
            ---__radix_tree_lookup
               find_task_by_pid_ns
               do_getpgid
               __x64_sys_getpgid
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               syscall

     0.82%  bench    [kernel.kallsyms]                               [k] do_getpgid
            |
            ---do_getpgid
               __x64_sys_getpgid
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               syscall

     0.78%  bench    [kernel.kallsyms]                               [k] debug_lockdep_rcu_enabled
            |
            ---debug_lockdep_rcu_enabled
               |          
                --0.63%--rcu_read_lock_sched_held

     0.74%  bench    ftrace_trampoline                               [k] ftrace_trampoline
            |
            ---ftrace_trampoline
               __x64_sys_getpgid
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               syscall

     0.72%  bench    [kernel.kallsyms]                               [k] preempt_count_add
            |
            ---preempt_count_add

     0.71%  bench    [kernel.kallsyms]                               [k] ktime_get_coarse_real_ts64
            |
            ---ktime_get_coarse_real_ts64
               syscall_trace_enter.constprop.0
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               syscall

     0.69%  bench    [kernel.kallsyms]                               [k] do_syscall_64
            |
            ---do_syscall_64
               entry_SYSCALL_64_after_hwframe
               |          
                --0.68%--syscall

     0.60%  bench    [kernel.kallsyms]                               [k] preempt_count_sub
            |
            ---preempt_count_sub

     0.59%  bench    [kernel.kallsyms]                               [k] __rcu_read_lock
            |
            ---__rcu_read_lock

     0.59%  bench    [kernel.kallsyms]                               [k] __x64_sys_getpgid
            |
            ---__x64_sys_getpgid
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               syscall

     0.58%  bench    [kernel.kallsyms]                               [k] __audit_syscall_exit
            |
            ---__audit_syscall_exit
               syscall_exit_to_user_mode_prepare
               syscall_exit_to_user_mode
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               syscall

     0.53%  bench    [kernel.kallsyms]                               [k] audit_reset_context
            |
            ---audit_reset_context
               syscall_exit_to_user_mode_prepare
               syscall_exit_to_user_mode
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               syscall

     0.45%  bench    [kernel.kallsyms]                               [k] rcu_read_lock_held
     0.36%  bench    [kernel.kallsyms]                               [k] find_task_by_vpid
     0.32%  bench    [kernel.kallsyms]                               [k] __bpf_prog_exit
     0.26%  bench    [kernel.kallsyms]                               [k] syscall_exit_to_user_mode
     0.20%  bench    [kernel.kallsyms]                               [k] idr_find
     0.18%  bench    [kernel.kallsyms]                               [k] find_task_by_pid_ns
     0.17%  bench    [kernel.kallsyms]                               [k] update_prog_stats
     0.16%  bench    [kernel.kallsyms]                               [k] _raw_spin_unlock_irqrestore
     0.14%  bench    [kernel.kallsyms]                               [k] pid_task
     0.04%  bench    [kernel.kallsyms]                               [k] memchr_inv
     0.04%  bench    [kernel.kallsyms]                               [k] smp_call_function_many_cond
     0.03%  bench    [kernel.kallsyms]                               [k] do_user_addr_fault
     0.03%  bench    [kernel.kallsyms]                               [k] kallsyms_expand_symbol.constprop.0
     0.03%  bench    [kernel.kallsyms]                               [k] native_flush_tlb_global
     0.03%  bench    [kernel.kallsyms]                               [k] __change_page_attr_set_clr
     0.02%  bench    [kernel.kallsyms]                               [k] memcpy_erms
     0.02%  bench    [kernel.kallsyms]                               [k] unwind_next_frame
     0.02%  bench    [kernel.kallsyms]                               [k] copy_user_enhanced_fast_string
     0.01%  bench    [kernel.kallsyms]                               [k] __orc_find
     0.01%  bench    [kernel.kallsyms]                               [k] call_rcu
     0.01%  bench    [kernel.kallsyms]                               [k] __alloc_pages
     0.01%  bench    [kernel.kallsyms]                               [k] __purge_vmap_area_lazy
     0.01%  bench    [kernel.kallsyms]                               [k] __softirqentry_text_start
     0.01%  bench    [kernel.kallsyms]                               [k] __stack_depot_save
     0.01%  bench    [kernel.kallsyms]                               [k] __up_read
     0.01%  bench    [kernel.kallsyms]                               [k] __virt_addr_valid
     0.01%  bench    [kernel.kallsyms]                               [k] clear_page_erms
     0.01%  bench    [kernel.kallsyms]                               [k] deactivate_slab
     0.01%  bench    [kernel.kallsyms]                               [k] do_check_common
     0.01%  bench    [kernel.kallsyms]                               [k] finish_task_switch.isra.0
     0.01%  bench    [kernel.kallsyms]                               [k] free_unref_page_list
     0.01%  bench    [kernel.kallsyms]                               [k] ftrace_rec_iter_next
     0.01%  bench    [kernel.kallsyms]                               [k] handle_mm_fault
     0.01%  bench    [kernel.kallsyms]                               [k] orc_find.part.0
     0.01%  bench    [kernel.kallsyms]                               [k] try_charge_memcg
     0.00%  bench    [kernel.kallsyms]                               [k] ___slab_alloc
     0.00%  bench    [kernel.kallsyms]                               [k] __fdget_pos
     0.00%  bench    [kernel.kallsyms]                               [k] __handle_mm_fault
     0.00%  bench    [kernel.kallsyms]                               [k] __is_insn_slot_addr
     0.00%  bench    [kernel.kallsyms]                               [k] __kmalloc
     0.00%  bench    [kernel.kallsyms]                               [k] __mod_lruvec_page_state
     0.00%  bench    [kernel.kallsyms]                               [k] __mod_node_page_state
     0.00%  bench    [kernel.kallsyms]                               [k] __mutex_lock
     0.00%  bench    [kernel.kallsyms]                               [k] __raw_spin_lock_init
     0.00%  bench    [kernel.kallsyms]                               [k] alloc_vmap_area
     0.00%  bench    [kernel.kallsyms]                               [k] allocate_slab
     0.00%  bench    [kernel.kallsyms]                               [k] audit_get_tty
     0.00%  bench    [kernel.kallsyms]                               [k] bpf_ksym_find
     0.00%  bench    [kernel.kallsyms]                               [k] btf_check_all_metas
     0.00%  bench    [kernel.kallsyms]                               [k] btf_put
     0.00%  bench    [kernel.kallsyms]                               [k] cmpxchg_double_slab.constprop.0.isra.0
     0.00%  bench    [kernel.kallsyms]                               [k] do_fault
     0.00%  bench    [kernel.kallsyms]                               [k] do_raw_spin_trylock
     0.00%  bench    [kernel.kallsyms]                               [k] find_vma
     0.00%  bench    [kernel.kallsyms]                               [k] fs_reclaim_release
     0.00%  bench    [kernel.kallsyms]                               [k] ftrace_check_record
     0.00%  bench    [kernel.kallsyms]                               [k] ftrace_replace_code
     0.00%  bench    [kernel.kallsyms]                               [k] get_mem_cgroup_from_mm
     0.00%  bench    [kernel.kallsyms]                               [k] get_page_from_freelist
     0.00%  bench    [kernel.kallsyms]                               [k] in_gate_area_no_mm
     0.00%  bench    [kernel.kallsyms]                               [k] in_task_stack
     0.00%  bench    [kernel.kallsyms]                               [k] kernel_text_address
     0.00%  bench    [kernel.kallsyms]                               [k] kernfs_fop_read_iter
     0.00%  bench    [kernel.kallsyms]                               [k] kernfs_put_active
     0.00%  bench    [kernel.kallsyms]                               [k] kfree
     0.00%  bench    [kernel.kallsyms]                               [k] kmem_cache_alloc
     0.00%  bench    [kernel.kallsyms]                               [k] ksys_read
     0.00%  bench    [kernel.kallsyms]                               [k] lookup_address_in_pgd
     0.00%  bench    [kernel.kallsyms]                               [k] mlock_page_drain_local
     0.00%  bench    [kernel.kallsyms]                               [k] page_remove_rmap
     0.00%  bench    [kernel.kallsyms]                               [k] post_alloc_hook
     0.00%  bench    [kernel.kallsyms]                               [k] preempt_schedule_irq
     0.00%  bench    [kernel.kallsyms]                               [k] queue_work_on
     0.00%  bench    [kernel.kallsyms]                               [k] stack_trace_save
     0.00%  bench    [kernel.kallsyms]                               [k] within_error_injection_list


#
# (Tip: To record callchains for each sample: perf record -g)
#

