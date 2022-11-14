Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2026362770C
	for <lists+bpf@lfdr.de>; Mon, 14 Nov 2022 09:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236197AbiKNIFR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Nov 2022 03:05:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236220AbiKNIFE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Nov 2022 03:05:04 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD6219C37;
        Mon, 14 Nov 2022 00:05:01 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id t4so6897450wmj.5;
        Mon, 14 Nov 2022 00:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pOyiUcMlwb6iIVRqneCejRT6cmL7tqvbaweeGxkyVQY=;
        b=Dyc8hE3bkgv3fdwVYEBfrPWDvVKTVU06p9uMkW25ygudpx2YRztu5SwPN6oI74OdmN
         i27q8tlebGRQRqXbRKD1cjIjJcljAlGFhN5CMVnn5PqV2Btwi93+9lz0LnU37Re6bLfJ
         w0xfNxRnH54n7ldZXCj41JKAaCiMcuR9cNMzPW2VOUT5vkWjjYOHu2/3ouQDvda8LNWH
         +dzURGiupdQAAUEISvmhfQ/7sQtNooOPGZ1NmR0wsV+2ZLLsUTq7ZBnQmhAc3Eydastk
         /u9oyV6/MGawMRJhARpEg7YcIHnVc9YiWrklAO7YnXV60QGKLAs/uqkK428XukAMN2JZ
         qPgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pOyiUcMlwb6iIVRqneCejRT6cmL7tqvbaweeGxkyVQY=;
        b=0GIRvs9b2YgtA6GaAYSnbLl+JUwaWj1P8YTSMaPFuuOa86Xahle+oqkVYhTS6t0f8I
         nBGrQfl9WVKCveGZx/UfSyHuiyHuU+506VX+qPKzyJddt8Gi7QNDYedOslxoL9eCMzkS
         v7iFXCdtV7eX7azWhW4kEv3TFBSFPoV/0BjWAzmftlD4tdndr8zej2uMgUWr71IWWMYX
         uoyg9S4xnEInsIyVD8H0dIpOQ0BqWJfCIqy27s3L2bWxebwzmW9o4bvM19z5+a+CWasZ
         sFBus0Havi4/EC8jUiLE7hH8ARBrXgvKWBePeTLElpBitu8twwVOSDVKZGQwIftEeCfj
         j5TA==
X-Gm-Message-State: ANoB5pntF4uxej5gIgWcL4j0YJJlRGeFowXYzpW9TaK7lJUZ9ZOG4scM
        qPkDaO1AxcqQyAE1Hwnz5GA=
X-Google-Smtp-Source: AA0mqf64pGdD2UaEYHY8pljQvwTmpH49tOtWZi446rG8mET9/Ydm1Gxb7e/GwboTH4or17hX/iJ6ig==
X-Received: by 2002:a05:600c:5107:b0:3cf:9d20:d928 with SMTP id o7-20020a05600c510700b003cf9d20d928mr6948675wms.27.1668413100017;
        Mon, 14 Nov 2022 00:05:00 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-8b88-53b7-c55c-8535.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:8b88:53b7:c55c:8535])
        by smtp.gmail.com with ESMTPSA id r7-20020a05600c458700b003c7087f6c9asm18052254wmo.32.2022.11.14.00.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 00:04:59 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Mon, 14 Nov 2022 09:04:57 +0100
To:     Hao Sun <sunhao.th@gmail.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Hao Luo <haoluo@google.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Stanislav Fomichev <sdf@google.com>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>
Subject: Re: WARNING in bpf_bprintf_prepare
Message-ID: <Y3H2qayW0hKlzBkK@krava>
References: <Y1pqWPRmP0M+hcXf@krava>
 <CACkBjsbP-iw-gpnYN=Ormcu2zXAeOgjeptjGAFXNNJRRVhRAag@mail.gmail.com>
 <Y2J+n7SqmtfyA7ZM@krava>
 <Y2j6ivTwFmA0FtvY@krava>
 <CAADnVQKXcdVa-gDj2_QTrBuVea+KMuFUdabR--HCf7x6Vo6uXg@mail.gmail.com>
 <Y2uv/GjnSdr/ujOj@krava>
 <CAADnVQJp0ZrodRu8ZtvvtXk6KAbjxmwqD-nXgFAxNpNxN6JM=g@mail.gmail.com>
 <Y2w9bNhVlAs/PcNV@krava>
 <Y25gFdliV7XqdUnN@krava>
 <CACkBjsaCsTovQHFfkqJKto6S4Z8d02ud1D7MPESrHa1cVNNTrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACkBjsaCsTovQHFfkqJKto6S4Z8d02ud1D7MPESrHa1cVNNTrw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Nov 12, 2022 at 12:02:50AM +0800, Hao Sun wrote:
> Jiri Olsa <olsajiri@gmail.com> 于2022年11月11日周五 22:45写道：
> >
> > On Thu, Nov 10, 2022 at 12:53:16AM +0100, Jiri Olsa wrote:
> >
> > SNIP
> >
> > > > > > > ---
> > > > > > > diff --git a/include/trace/bpf_probe.h b/include/trace/bpf_probe.h
> > > > > > > index 6a13220d2d27..5a354ae096e5 100644
> > > > > > > --- a/include/trace/bpf_probe.h
> > > > > > > +++ b/include/trace/bpf_probe.h
> > > > > > > @@ -78,11 +78,15 @@
> > > > > > >  #define CAST_TO_U64(...) CONCATENATE(__CAST, COUNT_ARGS(__VA_ARGS__))(__VA_ARGS__)
> > > > > > >
> > > > > > >  #define __BPF_DECLARE_TRACE(call, proto, args)                         \
> > > > > > > +static DEFINE_PER_CPU(int, __bpf_trace_tp_active_##call);              \
> > > > > > >  static notrace void                                                    \
> > > > > > >  __bpf_trace_##call(void *__data, proto)                                        \
> > > > > > >  {                                                                      \
> > > > > > >         struct bpf_prog *prog = __data;                                 \
> > > > > > > -       CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(prog, CAST_TO_U64(args));  \
> > > > > > > +                                                                       \
> > > > > > > +       if (likely(this_cpu_inc_return(__bpf_trace_tp_active_##call) == 1))             \
> > > > > > > +               CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(prog, CAST_TO_U64(args));  \
> > > > > > > +       this_cpu_dec(__bpf_trace_tp_active_##call);                                     \
> > > > > > >  }
> > > > > >
> > > > > > This approach will hurt real use cases where
> > > > > > multiple and different raw_tp progs run on the same cpu.
> > > > >
> > > > > would the 2 levels of nesting help in here?
> > > > >
> > > > > I can imagine the change above would break use case where we want to
> > > > > trigger tracepoints in irq context that interrupted task that's already
> > > > > in the same tracepoint
> > > > >
> > > > > with 2 levels of nesting we would trigger that tracepoint from irq and
> > > > > would still be safe with bpf_bprintf_prepare buffer
> > > >
> > > > How would these 2 levels work?
> > >
> > > just using the active counter like below, but I haven't tested it yet
> > >
> > > jirka
> >
> > seems to be working
> > Hao Sun, could you please test this patch?
> >
> 
> Hi Jirka,
> 
> I've tested the proposed patch, the warning from bpf_bprintf_prepare will not
> be triggered with the patch, but the reproducer can still trigger the following
> warning. My test was conducted on:
> 
> commit:  f67dd6ce0723 Merge tag 'slab-for-6.1-rc4-fixes'
> git tree:   upstream
> kernel config: https://pastebin.com/raw/sE5QK5HL
> C reproducer: https://pastebin.com/raw/X96ASi27
> console log *before* the patch: https://pastebin.com/raw/eSCUNFrd
> console log *after* the patch: https://pastebin.com/raw/tzcmdWZt

thanks for testing.. I can't reproduce this for some reason

I'll check some more and perhaps go with denying bpf attachment
for this tracepoint as Alexei suggeste

jirka


> 
> ============================================
> WARNING: possible recursive locking detected
> 6.1.0-rc4-00020-gf67dd6ce0723-dirty #11 Not tainted
> --------------------------------------------
> a.out/6703 is trying to acquire lock:
> ffffffff8ce0ea18 (trace_printk_lock){....}-{2:2}, at:
> ____bpf_trace_printk kernel/trace/bpf_trace.c:390 [inline]
> ffffffff8ce0ea18 (trace_printk_lock){....}-{2:2}, at:
> bpf_trace_printk+0xcf/0x170 kernel/trace/bpf_trace.c:376
> 
> but task is already holding lock:
> ffffffff8ce0ea18 (trace_printk_lock){....}-{2:2}, at:
> ____bpf_trace_printk kernel/trace/bpf_trace.c:390 [inline]
> ffffffff8ce0ea18 (trace_printk_lock){....}-{2:2}, at:
> bpf_trace_printk+0xcf/0x170 kernel/trace/bpf_trace.c:376
> 
> other info that might help us debug this:
> Possible unsafe locking scenario:
> 
> CPU0
> ----
> lock(trace_printk_lock);
> lock(trace_printk_lock);
> 
> *** DEADLOCK ***
> 
> May be due to missing lock nesting notation
> 
> 4 locks held by a.out/6703:
> #0: ffffffff8ce02fc8 (event_mutex){+.+.}-{3:3}, at:
> __ftrace_set_clr_event kernel/trace/trace_events.c:1060 [inline]
> #0: ffffffff8ce02fc8 (event_mutex){+.+.}-{3:3}, at:
> trace_set_clr_event+0xd5/0x140 kernel/trace/trace_events.c:1126
> #1: ffffffff8cd85f00 (rcu_read_lock){....}-{1:2}, at: __bpf_trace_run
> kernel/trace/bpf_trace.c:2249 [inline]
> #1: ffffffff8cd85f00 (rcu_read_lock){....}-{1:2}, at:
> bpf_trace_run2+0xb9/0x3d0 kernel/trace/bpf_trace.c:2293
> #2: ffffffff8ce0ea18 (trace_printk_lock){....}-{2:2}, at:
> ____bpf_trace_printk kernel/trace/bpf_trace.c:390 [inline]
> #2: ffffffff8ce0ea18 (trace_printk_lock){....}-{2:2}, at:
> bpf_trace_printk+0xcf/0x170 kernel/trace/bpf_trace.c:376
> #3: ffffffff8cd85f00 (rcu_read_lock){....}-{1:2}, at: __bpf_trace_run
> kernel/trace/bpf_trace.c:2249 [inline]
> #3: ffffffff8cd85f00 (rcu_read_lock){....}-{1:2}, at:
> bpf_trace_run2+0xb9/0x3d0 kernel/trace/bpf_trace.c:2293
> 
> stack backtrace:
> CPU: 7 PID: 6703 Comm: a.out Not tainted 6.1.0-rc4-00020-gf67dd6ce0723-dirty #11
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux
> 1.16.0-3-3 04/01/2014
> Call Trace:
> <TASK>
> __dump_stack lib/dump_stack.c:88 [inline]
> dump_stack_lvl+0xfc/0x174 lib/dump_stack.c:106
> print_deadlock_bug kernel/locking/lockdep.c:2990 [inline]
> check_deadlock kernel/locking/lockdep.c:3033 [inline]
> validate_chain kernel/locking/lockdep.c:3818 [inline]
> __lock_acquire.cold+0x119/0x3b9 kernel/locking/lockdep.c:5055
> lock_acquire kernel/locking/lockdep.c:5668 [inline]
> lock_acquire+0x1dc/0x600 kernel/locking/lockdep.c:5633
> __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
> _raw_spin_lock_irqsave+0x36/0x50 kernel/locking/spinlock.c:162
> ____bpf_trace_printk kernel/trace/bpf_trace.c:390 [inline]
> bpf_trace_printk+0xcf/0x170 kernel/trace/bpf_trace.c:376
> ___bpf_prog_run+0x42e5/0x8de0 kernel/bpf/core.c:1818
> __bpf_prog_run32+0x99/0xe0 kernel/bpf/core.c:2041
> bpf_dispatcher_nop_func include/linux/bpf.h:964 [inline]
> __bpf_prog_run include/linux/filter.h:600 [inline]
> bpf_prog_run include/linux/filter.h:607 [inline]
> __bpf_trace_run kernel/trace/bpf_trace.c:2254 [inline]
> bpf_trace_run2+0x14d/0x3d0 kernel/trace/bpf_trace.c:2293
> __bpf_trace_contention_begin+0xc8/0x120 include/trace/events/lock.h:95
> __traceiter_contention_begin+0x56/0x90 include/trace/events/lock.h:95
> trace_contention_begin.constprop.0+0x143/0x240 include/trace/events/lock.h:95
> __pv_queued_spin_lock_slowpath+0xfd/0xc70 kernel/locking/qspinlock.c:405
> pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:591 [inline]
> queued_spin_lock_slowpath arch/x86/include/asm/qspinlock.h:51 [inline]
> queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
> do_raw_spin_lock+0x20a/0x2b0 kernel/locking/spinlock_debug.c:115
> __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:111 [inline]
> _raw_spin_lock_irqsave+0x3e/0x50 kernel/locking/spinlock.c:162
> ____bpf_trace_printk kernel/trace/bpf_trace.c:390 [inline]
> bpf_trace_printk+0xcf/0x170 kernel/trace/bpf_trace.c:376
> ___bpf_prog_run+0x42e5/0x8de0 kernel/bpf/core.c:1818
> __bpf_prog_run32+0x99/0xe0 kernel/bpf/core.c:2041
> bpf_dispatcher_nop_func include/linux/bpf.h:964 [inline]
> __bpf_prog_run include/linux/filter.h:600 [inline]
> bpf_prog_run include/linux/filter.h:607 [inline]
> __bpf_trace_run kernel/trace/bpf_trace.c:2254 [inline]
> bpf_trace_run2+0x14d/0x3d0 kernel/trace/bpf_trace.c:2293
> __bpf_trace_contention_begin+0xc8/0x120 include/trace/events/lock.h:95
> __traceiter_contention_begin+0x56/0x90 include/trace/events/lock.h:95
> trace_contention_begin+0x129/0x1e0 include/trace/events/lock.h:95
> __mutex_lock_common kernel/locking/mutex.c:605 [inline]
> __mutex_lock+0x15a/0x12d0 kernel/locking/mutex.c:747
> __ftrace_set_clr_event kernel/trace/trace_events.c:1060 [inline]
> trace_set_clr_event+0xd5/0x140 kernel/trace/trace_events.c:1126
> __set_printk_clr_event kernel/trace/bpf_trace.c:419 [inline]
> bpf_get_trace_printk_proto kernel/trace/bpf_trace.c:425 [inline]
> bpf_tracing_func_proto+0x476/0x5a0 kernel/trace/bpf_trace.c:1422
> raw_tp_prog_func_proto+0x4f/0x60 kernel/trace/bpf_trace.c:1885
> check_helper_call+0x20a/0x94d0 kernel/bpf/verifier.c:7255
> do_check kernel/bpf/verifier.c:12384 [inline]
> do_check_common+0x6b3e/0xdf20 kernel/bpf/verifier.c:14643
> do_check_main kernel/bpf/verifier.c:14706 [inline]
> bpf_check+0x714c/0xa9b0 kernel/bpf/verifier.c:15276
> bpf_prog_load+0xfb1/0x2110 kernel/bpf/syscall.c:2605
> __sys_bpf+0xaba/0x5520 kernel/bpf/syscall.c:4965
> __do_sys_bpf kernel/bpf/syscall.c:5069 [inline]
> __se_sys_bpf kernel/bpf/syscall.c:5067 [inline]
> __x64_sys_bpf+0x74/0xb0 kernel/bpf/syscall.c:5067
> do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> do_syscall_64+0x34/0xb0 arch/x86/entry/common.c:80
> entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7fe9f4ee4469
> Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48
> 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
> 01 f0 ff ff 73 01 c3 48 8b 0d ff 49 2b 00 f7 d8 64 89 01 48
> RSP: 002b:00007fff7c845438 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fe9f4ee4469
> RDX: 0000000000000048 RSI: 0000000020000080 RDI: 0000000000000005
> RBP: 00007fff7c845450 R08: 00007fe9f4f2e160 R09: 00007fff7c845450
> R10: 0000000020001cc2 R11: 0000000000000246 R12: 000055643c800c00
> R13: 00007fff7c845570 R14: 0000000000000000 R15: 0000000000000000
> </TASK>
> 
> Regards
> Hao
> 
> > thanks,
> > jirka
> > >
> > >
> > > ---
> > > diff --git a/include/trace/bpf_probe.h b/include/trace/bpf_probe.h
> > > index 6a13220d2d27..ca5dd34478b7 100644
> > > --- a/include/trace/bpf_probe.h
> > > +++ b/include/trace/bpf_probe.h
> > > @@ -78,11 +78,15 @@
> > >  #define CAST_TO_U64(...) CONCATENATE(__CAST, COUNT_ARGS(__VA_ARGS__))(__VA_ARGS__)
> > >
> > >  #define __BPF_DECLARE_TRACE(call, proto, args)                               \
> > > +static DEFINE_PER_CPU(int, __bpf_trace_tp_active_##call);            \
> > >  static notrace void                                                  \
> > >  __bpf_trace_##call(void *__data, proto)                                      \
> > >  {                                                                    \
> > >       struct bpf_prog *prog = __data;                                 \
> > > -     CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(prog, CAST_TO_U64(args));  \
> > > +                                                                     \
> > > +     if (likely(this_cpu_inc_return(__bpf_trace_tp_active_##call) < 3))              \
> > > +             CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(prog, CAST_TO_U64(args));  \
> > > +     this_cpu_dec(__bpf_trace_tp_active_##call);                                     \
> > >  }
> > >
> > >  #undef DECLARE_EVENT_CLASS
