Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31625A508B
	for <lists+bpf@lfdr.de>; Mon, 29 Aug 2022 17:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbiH2PsF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Aug 2022 11:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbiH2Pr5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Aug 2022 11:47:57 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9557E9752C
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 08:47:42 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id o4so8414030pjp.4
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 08:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=88iUlnCDXVsAXuMGWgrplFcOEmiOX6THdJ/uVLD7fBo=;
        b=M3MuD9EbigMM0V1kedTFXATrQ2JQBkgondeZ9MCkC1KKVqUPtpyZY+zhCrYmmIomby
         dK2d3lUILMZIASz6GYt/Kn2otJRCwxkRj/XzsfMptFRYQSJ7TALbO1OiqiXPkWaFgKjG
         H1kj+A1lMI1R0pq8OMXi2iJj++33XwmDjRLqyNO+Z8OVd2h6Rp8in385p4HOsmFpP04n
         evrFE/1zP/aF0c1/q5vGI/Q+rLDWCohbuz2nspdc+YGIkHtL37fONZvkO0ouaA29uNBx
         OEBQrugLAdcn7SbAUZEjoDUO4X16xL2mx1yfFbyjWgagxCNTag33z3Wom/lRGZuiOLET
         outA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=88iUlnCDXVsAXuMGWgrplFcOEmiOX6THdJ/uVLD7fBo=;
        b=3Iuq6NGsvCBI2VJyqJa3AWVms0bzOoawzxrLD2jBU/TSb9c7xAtMpaQN+mINYTvd/N
         q1dp8MB4Mx0S5RKD7WCnh3C9vnYnACJ6cbK3hiIrkEyf/swY4ylH1pCXlns46nryHjRe
         T5gEr6+8PhlknJtVKdj2z+WDypOJ2Ml7IgXToAm4TUzNuyWIrcKGgNMeOmSSDArVKBfM
         XJpHmPw8ZTWMt6wKXSeD8ZjuaUyZ7i5OJHZbhjub2M/rm4D+s7RNSojTIZvaqcv6vzvK
         Fag5nwKXeQhrekdrnfvls1Nu2trnZOg1oqQxy5oEb2TPg7RlysixelwR3sEQdGfMi2WH
         hhzw==
X-Gm-Message-State: ACgBeo2nsUWUQK+YOFkG8LfQFuzjZb4YF9V7vkHRDA3jh0q7h9R5LNnO
        UgH7jpNwbGcmKh3QCrAL19M=
X-Google-Smtp-Source: AA6agR6bzr34zTDzLN+E63HyCKhpC0/4Gx2e6fTPfB8WPtNVeC1DpaFgGbWX4m+6efZGet0Nl/Ap5g==
X-Received: by 2002:a17:902:b489:b0:171:5091:d53b with SMTP id y9-20020a170902b48900b001715091d53bmr17422794plr.44.1661788060706;
        Mon, 29 Aug 2022 08:47:40 -0700 (PDT)
Received: from macbook-pro-4.dhcp.thefacebook.com ([2620:10d:c090:400::5:b414])
        by smtp.gmail.com with ESMTPSA id a6-20020a170902ecc600b0016ed5266a5csm7797396plh.170.2022.08.29.08.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 08:47:40 -0700 (PDT)
Date:   Mon, 29 Aug 2022 08:47:37 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>, davem@davemloft.net,
        daniel@iogearbox.net, andrii@kernel.org, tj@kernel.org,
        delyank@fb.com, linux-mm@kvack.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v4 bpf-next 00/15] bpf: BPF specific memory allocator.
Message-ID: <20220829154737.zxh5xfsdhnm2nsns@macbook-pro-4.dhcp.thefacebook.com>
References: <20220826024430.84565-1-alexei.starovoitov@gmail.com>
 <CAEf4Bzapz-SNfM+ky7UwnqNZAbJyy4eBHpxuNjW-TMk8C5ba8g@mail.gmail.com>
 <CAP01T76scR191CLFU10iiVn1aP47N+b8UrZtzf0syMd6az-hWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP01T76scR191CLFU10iiVn1aP47N+b8UrZtzf0syMd6az-hWA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Aug 28, 2022 at 12:53:48AM +0200, Kumar Kartikeya Dwivedi wrote:
> On Sat, 27 Aug 2022 at 18:57, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, Aug 25, 2022 at 7:44 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > From: Alexei Starovoitov <ast@kernel.org>
> > >
> > > Introduce any context BPF specific memory allocator.
> > >
> > > Tracing BPF programs can attach to kprobe and fentry. Hence they
> > > run in unknown context where calling plain kmalloc() might not be safe.
> > > Front-end kmalloc() with per-cpu cache of free elements.
> > > Refill this cache asynchronously from irq_work.
> > >
> > > Major achievements enabled by bpf_mem_alloc:
> > > - Dynamically allocated hash maps used to be 10 times slower than fully preallocated.
> > >   With bpf_mem_alloc and subsequent optimizations the speed of dynamic maps is equal to full prealloc.
> > > - Tracing bpf programs can use dynamically allocated hash maps.
> > >   Potentially saving lots of memory. Typical hash map is sparsely populated.
> > > - Sleepable bpf programs can used dynamically allocated hash maps.
> > >
> > > v3->v4:
> > > - fix build issue due to missing local.h on 32-bit arch
> > > - add Kumar's ack
> > > - proposal for next steps from Delyan:
> > > https://lore.kernel.org/bpf/d3f76b27f4e55ec9e400ae8dcaecbb702a4932e8.camel@fb.com/
> > >
> > > v2->v3:
> > > - Rewrote the free_list algorithm based on discussions with Kumar. Patch 1.
> > > - Allowed sleepable bpf progs use dynamically allocated maps. Patches 13 and 14.
> > > - Added sysctl to force bpf_mem_alloc in hash map even if pre-alloc is
> > >   requested to reduce memory consumption. Patch 15.
> > > - Fix: zero-fill percpu allocation
> > > - Single rcu_barrier at the end instead of each cpu during bpf_mem_alloc destruction
> > >
> > > v2 thread:
> > > https://lore.kernel.org/bpf/20220817210419.95560-1-alexei.starovoitov@gmail.com/
> > >
> > > v1->v2:
> > > - Moved unsafe direct call_rcu() from hash map into safe place inside bpf_mem_alloc. Patches 7 and 9.
> > > - Optimized atomic_inc/dec in hash map with percpu_counter. Patch 6.
> > > - Tuned watermarks per allocation size. Patch 8
> > > - Adopted this approach to per-cpu allocation. Patch 10.
> > > - Fully converted hash map to bpf_mem_alloc. Patch 11.
> > > - Removed tracing prog restriction on map types. Combination of all patches and final patch 12.
> > >
> > > v1 thread:
> > > https://lore.kernel.org/bpf/20220623003230.37497-1-alexei.starovoitov@gmail.com/
> > >
> > > LWN article:
> > > https://lwn.net/Articles/899274/
> > >
> > > Future work:
> > > - expose bpf_mem_alloc as uapi FD to be used in dynptr_alloc, kptr_alloc
> > > - convert lru map to bpf_mem_alloc
> > >
> > > Alexei Starovoitov (15):
> > >   bpf: Introduce any context BPF specific memory allocator.
> > >   bpf: Convert hash map to bpf_mem_alloc.
> > >   selftests/bpf: Improve test coverage of test_maps
> > >   samples/bpf: Reduce syscall overhead in map_perf_test.
> > >   bpf: Relax the requirement to use preallocated hash maps in tracing
> > >     progs.
> > >   bpf: Optimize element count in non-preallocated hash map.
> > >   bpf: Optimize call_rcu in non-preallocated hash map.
> > >   bpf: Adjust low/high watermarks in bpf_mem_cache
> > >   bpf: Batch call_rcu callbacks instead of SLAB_TYPESAFE_BY_RCU.
> > >   bpf: Add percpu allocation support to bpf_mem_alloc.
> > >   bpf: Convert percpu hash map to per-cpu bpf_mem_alloc.
> > >   bpf: Remove tracing program restriction on map types
> > >   bpf: Prepare bpf_mem_alloc to be used by sleepable bpf programs.
> > >   bpf: Remove prealloc-only restriction for sleepable bpf programs.
> > >   bpf: Introduce sysctl kernel.bpf_force_dyn_alloc.
> > >
> > >  include/linux/bpf_mem_alloc.h             |  26 +
> > >  include/linux/filter.h                    |   2 +
> > >  kernel/bpf/Makefile                       |   2 +-
> > >  kernel/bpf/core.c                         |   2 +
> > >  kernel/bpf/hashtab.c                      | 132 +++--
> > >  kernel/bpf/memalloc.c                     | 602 ++++++++++++++++++++++
> > >  kernel/bpf/syscall.c                      |  14 +-
> > >  kernel/bpf/verifier.c                     |  52 --
> > >  samples/bpf/map_perf_test_kern.c          |  44 +-
> > >  samples/bpf/map_perf_test_user.c          |   2 +-
> > >  tools/testing/selftests/bpf/progs/timer.c |  11 -
> > >  tools/testing/selftests/bpf/test_maps.c   |  38 +-
> > >  12 files changed, 796 insertions(+), 131 deletions(-)
> > >  create mode 100644 include/linux/bpf_mem_alloc.h
> > >  create mode 100644 kernel/bpf/memalloc.c
> > >
> > > --
> > > 2.30.2
> > >
> >
> > It's great to lift all those NMI restrictions on non-prealloc hashmap!
> > This should also open up new maps (like qp-trie) that can't be
> > pre-sized to the NMI world as well.
> >
> > But just to clarify, in NMI mode we can exhaust memory in caches (and
> > thus if we do a lot of allocation in single BPF program execution we
> > can fail some operations). That's unavoidable. But it's not 100% clear
> > what's the behavior in IRQ mode and separately from that in "usual"
> > less restrictive mode. Is my understanding correct that we shouldn't
> > run out of memory (assuming there is memory available, of course)
> > because replenishing of caches will interrupt BPF program execution?
> 
> When I was reviewing the code what I understood was as follows:
> 
> There are two ways work is queued. On non-RT, it is queued for
> execution in hardirq context (raised_list), on RT it will instead be
> executed by per-CPU pinned irq_work kthreads (from lazy_list).
> 
> We cannot set the IRQ_WORK_HARD_IRQ to force RT to execute them in
> hardirq context, as bpf_mem_refill may take sleepable non-raw
> spinlocks when calling into kmalloc, which is disallowed.

Correct.

> So, to summarize the behavior:
> In NMI context:
> - for both RT and non-RT, once we deplete the cache we get -ENOMEM.
> In IRQ context:
> - for RT, it will fill it asynchronously by waking up the irq_work
> kthread, so you may still get -ENOMEM (also depends on if bpf prog is
> in hardirq or threaded irq context, since hardirq context would be
> non-preemptible, delaying refilling from irq_work kthread context).
> - for non-RT, it is already inside the interrupt handler hence you
> will get -ENOMEM. Interrupt handlers keep interrupts disabled, so IPI
> execution is delayed until the handler returns.
> In softirq and task context:
> - for RT, it will fill it asynchronously by waking up the irq_work
> kthread, so you may still get -ENOMEM.
> - for non-RT, it will send IPI to local cpu, which will execute the
> work synchronously, so you will refill the cache by interrupting the
> program. Even when executing softirq inside the exit path of
> interrupts, at that point interrupts are enabled so it will refill
> synchronously by raising local IPI.

Correct.

> For the last case (say task context), the problem of kmalloc
> reentrancy comes to mind again, e.g if we are tracing in guts of
> kmalloc and send local IPI which eventually calls kmalloc again (which
> may deadlock). But remember that such cases are already possible
> without BPF, interrupts which allocate may come in at any time, so the
> kmalloc code itself will keep IRQs disabled at these places, hence we
> are fine from BPF side as well.

Exactly.

> Please let me know of any inaccuracies in the above description.

All looks correct.
I'm hesitant to add such low level details to a bpf documentation though
because things will change soon and program writers often don't have
control on the execution context. When bpf prog is attached to a kernel
function 'foo' that function maybe called out of all possible contexts.
Just like rigth now the bpf progs call bpf_map_update_elem (which does
some kind of memory allocation inside) and don't think twice.
Smarter thresholds are on todo list.
When bpf_mem_alloc is exposed to bpf progs directly they will have
an ability to prefill the cache to guarantee availability of objects later.
Sleepable progs might skip cache altogether or try direct kmalloc and fallback
to cache or the other way around.
In other words the program writers should not rely on specific
implementation details of bpf_mem_alloc, RT or non-RT, IRQs on or off, etc.

> > Or am I wrong and we can still run out of memory if we don't have
> > enough pre-cached memory. I think it would be good to clearly state
> > such things (unless I missed them somewhere in patches). I'm trying to
> > understand if in non-restrictive mode we can still fail to allocate a
> > bunch of hashmap elements in a loop just because of the design of
> > bpf_mem_alloc?

The users shouldn't rely on internal details. bpf_mem_alloc can
return NULL. That's all they need to know.
If it's not acceptable the prog should prefill the cache. Then the prog
will have a guaranteed reserve at the time of allocation.
That api is work in progress. It's another step after Delyan's work.

> > But it looks great otherwise. For the series:
> >
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>

Thanks for the review!
