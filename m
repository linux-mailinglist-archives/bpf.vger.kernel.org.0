Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE1B607629
	for <lists+bpf@lfdr.de>; Fri, 21 Oct 2022 13:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbiJULcJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Oct 2022 07:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbiJULcI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Oct 2022 07:32:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258CD4D4C7;
        Fri, 21 Oct 2022 04:32:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0DA261E6F;
        Fri, 21 Oct 2022 11:32:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A11BC433C1;
        Fri, 21 Oct 2022 11:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666351926;
        bh=P7Lxm+ED8C2CEsqjuKV5vv2C68K/B923U+Drbkt4ygQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lPohNQCRkspo3XJNotHtNpQ+XgrzIktwCMBtAWzJkGSD9blI9brOrEBy2XKFGjpac
         A6tflW51KG7h1mq9j09vwnSbBxUoLRMUr5dXizGJM6gQ5JNhXnh5sNrWMrvlUluORz
         xScpOOLuRtukKXbHeli07wrIahFPTdKcYUpv64JGeIYc/XHfpOwr/r7ai1+Ug/MqFp
         2Zmoe5+fSq/S9a1TrS58vORrDvj3KIJQcnNGQsmtVHp7WQsE9eom69g/AoW8JN1QDY
         RI9ZKfjWvLHAtPf+nip6mjCxkzlITI7LeixKqUc3M0lefL8UXLFrpeiZ2Q66GSHfEC
         o/rQd7/ubc7Yw==
Date:   Fri, 21 Oct 2022 20:31:58 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Florent Revest <revest@chromium.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Xu Kuohai <xukuohai@huawei.com>,
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
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Zi Shen Lim <zlim.lnx@gmail.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Guo Ren <guoren@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH bpf-next v2 0/4] Add ftrace direct call for arm64
Message-Id: <20221021203158.4464ac19d8b19b6da6a40852@kernel.org>
In-Reply-To: <CABRcYm+d=xY9nBCJo-6JW_=F41g4X32QM9WOPChaOTfs6d6KCA@mail.gmail.com>
References: <20220913162732.163631-1-xukuohai@huaweicloud.com>
        <f1e14934-dc54-9bf7-501a-89affdb7371e@iogearbox.net>
        <YzG51Jyd5zhvygtK@arm.com>
        <YzHk1zRf1Dp8YTEe@FVFF77S0Q05N>
        <970a25e4-9b79-9e0c-b338-ed1a934f2770@huawei.com>
        <YzR5WSLux4mmFIXg@FVFF77S0Q05N>
        <2cb606b4-aa8b-e259-cdfd-1bfc61fd7c44@huawei.com>
        <CABRcYmKPchvtkkgWhOJ6o3pHVqTWeenGawHfZ2ug8Akdh6NfnQ@mail.gmail.com>
        <7f34d333-3b2a-aea5-f411-d53be2c46eee@huawei.com>
        <20221005110707.55bd9354@gandalf.local.home>
        <CABRcYmJGY6fp0CtUBYN8BjEDN=r42BPLSBcrxqu491bTRmfm7g@mail.gmail.com>
        <20221005113019.18aeda76@gandalf.local.home>
        <CABRcYmL0bDkgYP3tSwhZYaGUSbsUR3Gq85QCRiUAdXt65czzmg@mail.gmail.com>
        <20221006122922.53802a5c@gandalf.local.home>
        <CABRcYm+d=xY9nBCJo-6JW_=F41g4X32QM9WOPChaOTfs6d6KCA@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Florent,

On Mon, 17 Oct 2022 19:55:06 +0200
Florent Revest <revest@chromium.org> wrote:

> On Thu, Oct 6, 2022 at 6:29 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Thu, 6 Oct 2022 18:19:12 +0200
> > Florent Revest <revest@chromium.org> wrote:
> >
> > > Sure, we can give this a try, I'll work on a macro that generates the
> > > 7 callbacks and we can check how much that helps. My belief right now
> > > is that ftrace's iteration over all ops on arm64 is where we lose most
> > > time but now that we have numbers it's pretty easy to check hypothesis
> > > :)
> >
> > Ah, I forgot that's what Mark's code is doing. But yes, that needs to be
> > fixed first. I forget that arm64 doesn't have the dedicated trampolines yet.
> >
> > So, let's hold off until that is complete.
> >
> > -- Steve
> 
> Mark finished an implementation of his per-callsite-ops and min-args
> branches (meaning that we can now skip the expensive ftrace's saving
> of all registers and iteration over all ops if only one is attached)
> - https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=arm64-ftrace-call-ops-20221017
> 
> And Masami wrote similar patches to what I had originally done to
> fprobe in my branch:
> - https://github.com/mhiramat/linux/commits/kprobes/fprobe-update
> 
> So I could rebase my previous "bpf on fprobe" branch on top of these:
> (as before, it's just good enough for benchmarking and to give a
> general sense of the idea, not for a thorough code review):
> - https://github.com/FlorentRevest/linux/commits/fprobe-min-args-3
> 
> And I could run the benchmarks against my rpi4. I have different
> baseline numbers as Xu so I ran everything again and tried to keep the
> format the same. "indirect call" refers to my branch I just linked and
> "direct call" refers to the series this is a reply to (Xu's work)

Thanks for sharing the measurement results. Yes, fprobes/rethook
implementation is just porting the kretprobes implementation, thus
it may not be so optimized.

BTW, I remember Wuqiang's patch for kretprobes.

https://lore.kernel.org/all/20210830173324.32507-1-wuqiang.matt@bytedance.com/T/#u

This is for the scalability fixing, but may possible to improve
the performance a bit. It is not hard to port to the recent kernel.
Can you try it too?

Anyway, eventually, I would like to remove the current kretprobe
based implementation and unify fexit hook with function-graph
tracer. It should make more better perfromance on it.

Thank you,


> 
> 1. test with dd
> 
> 1.1 when no bpf prog attached to vfs_write
> 
> # dd if=/dev/zero of=/dev/null count=1000000
> 1000000+0 records in
> 1000000+0 records out
> 512000000 bytes (512 MB, 488 MiB) copied, 3.94315 s, 130 MB/s
> 
> 
> 1.2 attach bpf prog with kprobe, bpftrace -e kprobe:vfs_write {}
> 
> # dd if=/dev/zero of=/dev/null count=1000000
> 1000000+0 records in
> 1000000+0 records out
> 512000000 bytes (512 MB, 488 MiB) copied, 5.80493 s, 88.2 MB/s
> 
> 
> 1.3 attach bpf prog with with direct call, bpftrace -e kfunc:vfs_write {}
> 
> # dd if=/dev/zero of=/dev/null count=1000000
> 1000000+0 records in
> 1000000+0 records out
> 512000000 bytes (512 MB, 488 MiB) copied, 4.18579 s, 122 MB/s
> 
> 
> 1.4 attach bpf prog with with indirect call, bpftrace -e kfunc:vfs_write {}
> 
> # dd if=/dev/zero of=/dev/null count=1000000
> 1000000+0 records in
> 1000000+0 records out
> 512000000 bytes (512 MB, 488 MiB) copied, 4.92616 s, 104 MB/s
> 
> 
> 2. test with bpf/bench
> 
> 2.1 bench trig-base
> Iter   0 ( 86.518us): hits    0.700M/s (  0.700M/prod), drops
> 0.000M/s, total operations    0.700M/s
> Iter   1 (-26.352us): hits    0.701M/s (  0.701M/prod), drops
> 0.000M/s, total operations    0.701M/s
> Iter   2 (  1.092us): hits    0.701M/s (  0.701M/prod), drops
> 0.000M/s, total operations    0.701M/s
> Iter   3 ( -1.890us): hits    0.701M/s (  0.701M/prod), drops
> 0.000M/s, total operations    0.701M/s
> Iter   4 ( -2.315us): hits    0.701M/s (  0.701M/prod), drops
> 0.000M/s, total operations    0.701M/s
> Iter   5 (  4.184us): hits    0.701M/s (  0.701M/prod), drops
> 0.000M/s, total operations    0.701M/s
> Iter   6 ( -3.241us): hits    0.701M/s (  0.701M/prod), drops
> 0.000M/s, total operations    0.701M/s
> Summary: hits    0.701 ± 0.000M/s (  0.701M/prod), drops    0.000 ±
> 0.000M/s, total operations    0.701 ± 0.000M/s
> 
> 2.2 bench trig-kprobe
> Iter   0 ( 96.833us): hits    0.290M/s (  0.290M/prod), drops
> 0.000M/s, total operations    0.290M/s
> Iter   1 (-20.834us): hits    0.291M/s (  0.291M/prod), drops
> 0.000M/s, total operations    0.291M/s
> Iter   2 ( -2.426us): hits    0.291M/s (  0.291M/prod), drops
> 0.000M/s, total operations    0.291M/s
> Iter   3 ( 22.332us): hits    0.292M/s (  0.292M/prod), drops
> 0.000M/s, total operations    0.292M/s
> Iter   4 (-18.204us): hits    0.292M/s (  0.292M/prod), drops
> 0.000M/s, total operations    0.292M/s
> Iter   5 (  5.370us): hits    0.292M/s (  0.292M/prod), drops
> 0.000M/s, total operations    0.292M/s
> Iter   6 ( -7.853us): hits    0.290M/s (  0.290M/prod), drops
> 0.000M/s, total operations    0.290M/s
> Summary: hits    0.291 ± 0.001M/s (  0.291M/prod), drops    0.000 ±
> 0.000M/s, total operations    0.291 ± 0.001M/s
> 
> 2.3 bench trig-fentry, with direct call
> Iter   0 ( 86.481us): hits    0.530M/s (  0.530M/prod), drops
> 0.000M/s, total operations    0.530M/s
> Iter   1 (-12.593us): hits    0.536M/s (  0.536M/prod), drops
> 0.000M/s, total operations    0.536M/s
> Iter   2 ( -5.760us): hits    0.532M/s (  0.532M/prod), drops
> 0.000M/s, total operations    0.532M/s
> Iter   3 (  1.629us): hits    0.532M/s (  0.532M/prod), drops
> 0.000M/s, total operations    0.532M/s
> Iter   4 ( -1.945us): hits    0.533M/s (  0.533M/prod), drops
> 0.000M/s, total operations    0.533M/s
> Iter   5 ( -1.297us): hits    0.532M/s (  0.532M/prod), drops
> 0.000M/s, total operations    0.532M/s
> Iter   6 (  0.444us): hits    0.535M/s (  0.535M/prod), drops
> 0.000M/s, total operations    0.535M/s
> Summary: hits    0.533 ± 0.002M/s (  0.533M/prod), drops    0.000 ±
> 0.000M/s, total operations    0.533 ± 0.002M/s
> 
> 2.3 bench trig-fentry, with indirect call
> Iter   0 ( 84.463us): hits    0.404M/s (  0.404M/prod), drops
> 0.000M/s, total operations    0.404M/s
> Iter   1 (-16.260us): hits    0.405M/s (  0.405M/prod), drops
> 0.000M/s, total operations    0.405M/s
> Iter   2 ( -1.038us): hits    0.405M/s (  0.405M/prod), drops
> 0.000M/s, total operations    0.405M/s
> Iter   3 ( -3.797us): hits    0.405M/s (  0.405M/prod), drops
> 0.000M/s, total operations    0.405M/s
> Iter   4 ( -0.537us): hits    0.402M/s (  0.402M/prod), drops
> 0.000M/s, total operations    0.402M/s
> Iter   5 (  3.536us): hits    0.403M/s (  0.403M/prod), drops
> 0.000M/s, total operations    0.403M/s
> Iter   6 ( 12.203us): hits    0.404M/s (  0.404M/prod), drops
> 0.000M/s, total operations    0.404M/s
> Summary: hits    0.404 ± 0.001M/s (  0.404M/prod), drops    0.000 ±
> 0.000M/s, total operations    0.404 ± 0.001M/s
> 
> 
> 3. perf report of bench trig-fentry
> 
> 3.1 with direct call
> 
>     98.67%     0.27%  bench    bench
>         [.] trigger_producer
>             |
>              --98.40%--trigger_producer
>                        |
>                        |--96.63%--syscall
>                        |          |
>                        |           --71.90%--el0t_64_sync
>                        |                     el0t_64_sync_handler
>                        |                     el0_svc
>                        |                     do_el0_svc
>                        |                     |
>                        |                     |--70.94%--el0_svc_common
>                        |                     |          |
>                        |                     |
> |--29.55%--invoke_syscall
>                        |                     |          |          |
>                        |                     |          |
> |--26.23%--__arm64_sys_getpgid
>                        |                     |          |          |
>        |
>                        |                     |          |          |
>        |--18.88%--bpf_trampoline_6442462665_0
>                        |                     |          |          |
>        |          |
>                        |                     |          |          |
>        |          |--6.85%--__bpf_prog_enter
>                        |                     |          |          |
>        |          |          |
>                        |                     |          |          |
>        |          |           --2.68%--migrate_disable
>                        |                     |          |          |
>        |          |
>                        |                     |          |          |
>        |          |--5.28%--__bpf_prog_exit
>                        |                     |          |          |
>        |          |          |
>                        |                     |          |          |
>        |          |           --1.29%--migrate_enable
>                        |                     |          |          |
>        |          |
>                        |                     |          |          |
>        |
> |--3.96%--bpf_prog_21856463590f61f1_bench_trigger_fentry
>                        |                     |          |          |
>        |          |
>                        |                     |          |          |
>        |           --0.61%--__rcu_read_lock
>                        |                     |          |          |
>        |
>                        |                     |          |          |
>         --4.42%--find_task_by_vpid
>                        |                     |          |          |
>                   |
>                        |                     |          |          |
>                   |--2.53%--radix_tree_lookup
>                        |                     |          |          |
>                   |
>                        |                     |          |          |
>                    --0.61%--idr_find
>                        |                     |          |          |
>                        |                     |          |
> --0.81%--pid_vnr
>                        |                     |          |
>                        |                     |
> --0.53%--__arm64_sys_getpgid
>                        |                     |
>                        |                      --0.95%--invoke_syscall
>                        |
>                         --0.99%--syscall@plt
> 
> 
> 3.2 with indirect call
> 
>     98.68%     0.20%  bench    bench
>         [.] trigger_producer
>             |
>              --98.48%--trigger_producer
>                        |
>                         --97.47%--syscall
>                                   |
>                                    --76.11%--el0t_64_sync
>                                              el0t_64_sync_handler
>                                              el0_svc
>                                              do_el0_svc
>                                              |
>                                              |--75.52%--el0_svc_common
>                                              |          |
>                                              |
> |--46.35%--invoke_syscall
>                                              |          |          |
>                                              |          |
> --44.06%--__arm64_sys_getpgid
>                                              |          |
>        |
>                                              |          |
>        |--35.40%--ftrace_caller
>                                              |          |
>        |          |
>                                              |          |
>        |           --34.04%--fprobe_handler
>                                              |          |
>        |                     |
>                                              |          |
>        |                     |--15.61%--bpf_fprobe_entry
>                                              |          |
>        |                     |          |
>                                              |          |
>        |                     |          |--3.79%--__bpf_prog_enter
>                                              |          |
>        |                     |          |          |
>                                              |          |
>        |                     |          |
> --0.80%--migrate_disable
>                                              |          |
>        |                     |          |
>                                              |          |
>        |                     |          |--3.74%--__bpf_prog_exit
>                                              |          |
>        |                     |          |          |
>                                              |          |
>        |                     |          |
> --0.77%--migrate_enable
>                                              |          |
>        |                     |          |
>                                              |          |
>        |                     |
> --2.65%--bpf_prog_21856463590f61f1_bench_trigger_fentry
>                                              |          |
>        |                     |
>                                              |          |
>        |                     |--12.65%--rethook_trampoline_handler
>                                              |          |
>        |                     |
>                                              |          |
>        |                     |--1.70%--rethook_try_get
>                                              |          |
>        |                     |          |
>                                              |          |
>        |                     |           --1.48%--rcu_is_watching
>                                              |          |
>        |                     |
>                                              |          |
>        |                     |--1.46%--freelist_try_get
>                                              |          |
>        |                     |
>                                              |          |
>        |                      --0.65%--rethook_recycle
>                                              |          |
>        |
>                                              |          |
>         --6.36%--find_task_by_vpid
>                                              |          |
>                   |
>                                              |          |
>                   |--3.64%--radix_tree_lookup
>                                              |          |
>                   |
>                                              |          |
>                    --1.74%--idr_find
>                                              |          |
>                                              |           --1.05%--ftrace_caller
>                                              |
>                                               --0.59%--invoke_syscall
> 
> This looks slightly better than before but it is actually still a
> pretty significant performance hit compared to direct calls.
> 
> Note that I can't really make sense of the perf report with indirect
> calls. it always reports it spent 12% of the time in
> rethook_trampoline_handler but I verified with both a WARN in that
> function and a breakpoint with a debugger, this function does *not*
> get called when running this "bench trig-fentry" benchmark. Also it
> wouldn't make sense for fprobe_handler to call it so I'm quite
> confused why perf would report this call and such a long time spent
> there. Anyone know what I could be missing here ?


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
