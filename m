Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5D8606749
	for <lists+bpf@lfdr.de>; Thu, 20 Oct 2022 19:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiJTRti (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Oct 2022 13:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiJTRth (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Oct 2022 13:49:37 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8705818E20
        for <bpf@vger.kernel.org>; Thu, 20 Oct 2022 10:49:32 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id o65so220115iof.4
        for <bpf@vger.kernel.org>; Thu, 20 Oct 2022 10:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RJ7YaAS4agjfTmcDn3kpTuuGl2DmeWnXBcOmn5dqj/w=;
        b=qjuCYizqskeVxIE8XRc5/3LFHR08VCdhXdAmkc2VRxdG9lSem9j8T70yqdza/rFriN
         iCO2aP/JDSlDmnAWeITAs6fyODoslrlXuK1bV9yYk3eGqXPxNPnw1xbZVt68M+KAfGbT
         ko4DeFredF1IPO0CPiXR5s+HeZe8M/oq09jm/4FKyETVn8VPx8DrDC8oOm4psBmIfaKI
         gXek4dzxm5CGfShff4L5is10LViUGte5rLCLS7qWa4EvvE0RbxScEqtURh5kJ4hQ9ECq
         SF3DJVaPLEw9wpm8vcGFm2KXQ3FyIsdhBV27YtAEySfIAkUk/M5Fp4Tm2i3ijCAAlcy0
         49qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RJ7YaAS4agjfTmcDn3kpTuuGl2DmeWnXBcOmn5dqj/w=;
        b=Z5xr+odI08ekYjwtOUC85RCIUqOQC6rQPmlYO/7BJqbfJscdSJzcYjlNnnTUYvjpQO
         HNbjnwi1nSmMrNRRmJPVZNoNSkU9VU8XsbO24Vx4Ol3tzcBIg411lEdZIWixGonWuHtk
         QZQA0/fkzlhfzFGJByWhUlbmALkJdYM5mpAQWUQypV4dkSe+HKxG4PVqd8s7KI24mIKH
         9t4wSEMGMNBonOt1KaeVWXy0pYBaWtzC5mopXc47K6BS8BWCfvLmnua4fn9/IskUkb36
         9Lxqu+QKYvBiEUI8NZlkf9rgblD9qnrlAuMOBEH8JV9O294ex5KtU4oE+RuAAImYa94M
         39gA==
X-Gm-Message-State: ACrzQf2L3YZ/mesIv2yjZY3YY5hSNC4bWldrmaR6zP/HYAr274m8nIvA
        6c8LLGQkQIRziu51MMiA0OtPg7mph5BcYOnlOu5Rn8t3zY9Ikw==
X-Google-Smtp-Source: AMsMyM5ooBga26qcX75y/hXcMEh01I0eAIqcES9PrAn4oHFUrolGIxd5JDQFM9cBah2Zmj+74Qr91Lf5j7Z2SvmgSYk=
X-Received: by 2002:a02:cb98:0:b0:364:a78:2098 with SMTP id
 u24-20020a02cb98000000b003640a782098mr11015886jap.106.1666288171594; Thu, 20
 Oct 2022 10:49:31 -0700 (PDT)
MIME-Version: 1.0
References: <20221019115539.983394-1-houtao@huaweicloud.com>
 <20221019115539.983394-2-houtao@huaweicloud.com> <Y1BENCpam1I+anXF@google.com>
 <381c1d2e-a87a-c143-dc4a-4e3210d5d3f0@huaweicloud.com>
In-Reply-To: <381c1d2e-a87a-c143-dc4a-4e3210d5d3f0@huaweicloud.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Thu, 20 Oct 2022 10:49:20 -0700
Message-ID: <CAKH8qBunP1LR4jCWV5Ye0YZS4sYZ0fnHkG5=o7BoCMP=n2_UDQ@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: Wait for busy refill_work when destorying
 bpf memory allocator
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 19, 2022 at 6:08 PM Hou Tao <houtao@huaweicloud.com> wrote:
>
> Hi,
>
> On 10/20/2022 2:38 AM, sdf@google.com wrote:
> > On 10/19, Hou Tao wrote:
> >> From: Hou Tao <houtao1@huawei.com>
> >
> >> A busy irq work is an unfinished irq work and it can be either in the
> >> pending state or in the running state. When destroying bpf memory
> >> allocator, refill_work may be busy for PREEMPT_RT kernel in which irq
> >> work is invoked in a per-CPU RT-kthread. It is also possible for kernel
> >> with arch_irq_work_has_interrupt() being false (e.g. 1-cpu arm32 host)
> >> and irq work is inovked in timer interrupt.
> >
> >> The busy refill_work leads to various issues. The obvious one is that
> >> there will be concurrent operations on free_by_rcu and free_list between
> >> irq work and memory draining. Another one is call_rcu_in_progress will
> >> not be reliable for the checking of pending RCU callback because
> >> do_call_rcu() may has not been invoked by irq work. The other is there
> >> will be use-after-free if irq work is freed before the callback of
> >> irq work is invoked as shown below:
> >
> >>   BUG: kernel NULL pointer dereference, address: 0000000000000000
> >>   #PF: supervisor instruction fetch in kernel mode
> >>   #PF: error_code(0x0010) - not-present page
> >>   PGD 12ab94067 P4D 12ab94067 PUD 1796b4067 PMD 0
> >>   Oops: 0010 [#1] PREEMPT_RT SMP
> >>   CPU: 5 PID: 64 Comm: irq_work/5 Not tainted 6.0.0-rt11+ #1
> >>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
> >>   RIP: 0010:0x0
> >>   Code: Unable to access opcode bytes at 0xffffffffffffffd6.
> >>   RSP: 0018:ffffadc080293e78 EFLAGS: 00010286
> >>   RAX: 0000000000000000 RBX: ffffcdc07fb6a388 RCX: ffffa05000a2e000
> >>   RDX: ffffa05000a2e000 RSI: ffffffff96cc9827 RDI: ffffcdc07fb6a388
> >>   ......
> >>   Call Trace:
> >>    <TASK>
> >>    irq_work_single+0x24/0x60
> >>    irq_work_run_list+0x24/0x30
> >>    run_irq_workd+0x23/0x30
> >>    smpboot_thread_fn+0x203/0x300
> >>    kthread+0x126/0x150
> >>    ret_from_fork+0x1f/0x30
> >>    </TASK>
> >
> >> Considering the ease of concurrency handling and the short wait time
> >> used for irq_work_sync() under PREEMPT_RT (When running two test_maps on
> >> PREEMPT_RT kernel and 72-cpus host, the max wait time is about 8ms and
> >> the 99th percentile is 10us), just waiting for busy refill_work to
> >> complete before memory draining and memory freeing.
> >
> >> Fixes: 7c8199e24fa0 ("bpf: Introduce any context BPF specific memory
> >> allocator.")
> >> Signed-off-by: Hou Tao <houtao1@huawei.com>
> >> ---
> >>   kernel/bpf/memalloc.c | 11 +++++++++++
> >>   1 file changed, 11 insertions(+)
> >
> >> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
> >> index 94f0f63443a6..48e606aaacf0 100644
> >> --- a/kernel/bpf/memalloc.c
> >> +++ b/kernel/bpf/memalloc.c
> >> @@ -497,6 +497,16 @@ void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
> >>           rcu_in_progress = 0;
> >>           for_each_possible_cpu(cpu) {
> >>               c = per_cpu_ptr(ma->cache, cpu);
> >> +            /*
> >> +             * refill_work may be unfinished for PREEMPT_RT kernel
> >> +             * in which irq work is invoked in a per-CPU RT thread.
> >> +             * It is also possible for kernel with
> >> +             * arch_irq_work_has_interrupt() being false and irq
> >> +             * work is inovked in timer interrupt. So wait for the
> >> +             * completion of irq work to ease the handling of
> >> +             * concurrency.
> >> +             */
> >> +            irq_work_sync(&c->refill_work);
> >
> > Does it make sense to guard these with "IS_ENABLED(CONFIG_PREEMPT_RT)" ?
> > We do have a bunch of them sprinkled already to run alloc/free with
> > irqs disabled.
> No. As said in the commit message and the comments, irq_work_sync() is needed
> for both PREEMPT_RT kernel and kernel with arch_irq_work_has_interrupt() being
> false. And for other kernels, irq_work_sync() doesn't incur any overhead,
> because it is  just a simple memory read through irq_work_is_busy() and nothing
> else. The reason is the irq work must have been completed when invoking
> bpf_mem_alloc_destroy() for these kernels.
>
> void irq_work_sync(struct irq_work *work)
> {
>        /* Remove code snippet for PREEMPT_RT and arch_irq_work_has_interrupt() */
>         /* irq wor*/
>         while (irq_work_is_busy(work))
>                 cpu_relax();
> }

I see, thanks for clarifying! I was so carried away with that
PREEMPT_RT that I missed the fact that arch_irq_work_has_interrupt is
a separate thing. Agreed that doing irq_work_sync won't hurt in a
non-preempt/non-has_interrupt case.

In this case, can you still do a respin and fix the spelling issue in
the comment? You can slap my acked-by for the v2:

Acked-by: Stanislav Fomichev <sdf@google.com>

s/work is inovked in timer interrupt. So wait for the/... invoked .../

> >
> > I was also trying to see if adding local_irq_save inside drain_mem_cache
> > to pair with the ones from refill might work, but waiting for irq to
> > finish seems easier...
> Disabling hard irq works, but irq_work_sync() is still needed to ensure it is
> completed before freeing its memory.
> >
> > Maybe also move both of these in some new "static void irq_work_wait"
> > to make it clear that the PREEMT_RT comment applies to both of them?
> >
> > Or maybe that helper should do 'for_each_possible_cpu(cpu)
> > irq_work_sync(&c->refill_work);'
> > in the PREEMPT_RT case so we don't have to call it twice?
> drain_mem_cache() is also time consuming somethings, so I think it is better to
> interleave irq_work_sync() and drain_mem_cache() to reduce waiting time.
>
> >
> >>               drain_mem_cache(c);
> >>               rcu_in_progress += atomic_read(&c->call_rcu_in_progress);
> >>           }
> >> @@ -511,6 +521,7 @@ void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
> >>               cc = per_cpu_ptr(ma->caches, cpu);
> >>               for (i = 0; i < NUM_CACHES; i++) {
> >>                   c = &cc->cache[i];
> >> +                irq_work_sync(&c->refill_work);
> >>                   drain_mem_cache(c);
> >>                   rcu_in_progress += atomic_read(&c->call_rcu_in_progress);
> >>               }
> >> --
> >> 2.29.2
> >
> > .
>
