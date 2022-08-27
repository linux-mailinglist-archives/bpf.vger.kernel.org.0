Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 792305A3A56
	for <lists+bpf@lfdr.de>; Sun, 28 Aug 2022 00:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbiH0Wya (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 27 Aug 2022 18:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiH0Wy3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 27 Aug 2022 18:54:29 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05BC94A104
        for <bpf@vger.kernel.org>; Sat, 27 Aug 2022 15:54:26 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id j6so1832726ilu.9
        for <bpf@vger.kernel.org>; Sat, 27 Aug 2022 15:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=w9D9D/NajGhrxoSovCkbBuI+jyK+pO/iei9GkIyjXiU=;
        b=Ki5wKNYle8YZQxup08zAYtp+lXjSRiLE2fDEfdCfbjGNz0lpkyDig51LhwrJMCRkx+
         N6V0cGnczPxy99G1rEIOPqraw7bpXAqjyICLnJpWEq434A1H5T3bTW+o3ecSK7qqYQAU
         hRYDHqnaC0RYloD87WtZ1MgA4/S872TsopYSVcC0WCjwjJXdJ0njUnW1TpuqBnTTPuIf
         CQsOxYfFwU4CK8JoHT/VPRzR577nbjT59h6/v1dHkqOjrciBfkd5Xf6YJWOzmJApNykn
         QPJeyp4Fvn0GKEUGvdm5C4Io+d5vNsylHY9njcVA/+pc0AGBLkm161ygO+28ac6lpKdT
         aWwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=w9D9D/NajGhrxoSovCkbBuI+jyK+pO/iei9GkIyjXiU=;
        b=jmEU0DTTJ1YgTxs0daLGEwTrhZUCgUayPSS0joXT0T6/CWa0kJTT/mGHBzK4zip655
         SytbYGfj5Xshe+aCYQoKjatCVMdiW9rsIN7wwFucMVQwWad/UKdvYY1cptQ6pGloEJnX
         FD1LoO8dySiucFUNz0Ffo+LQMvLnAuseyWnr/hMdO5WuSv0sUlJ0273611yLhP1igzEQ
         NIpHy36IwpkFVS5UA+2rdx9NmH9WFdT7jKZ6ISNf/SpGwfmCcjf2/wjQI7iZMmZZdjbd
         Pu9Hz7i+AjPXOf1RsmI4i6SfdtOM0B00teRPBjEakQgMftA498LDdsTvx5Rlpv9he+68
         TpWQ==
X-Gm-Message-State: ACgBeo1ZdcvVqLwbRvEkvl8RX7vB6kG+Y8Jq1CFZRUicBSlBD5YHrT6w
        2MmnFPF3FdeebnjCpckUW8QrE4cN6lRHQnTctpM=
X-Google-Smtp-Source: AA6agR6qg5REdc8mr1uyH5qF6IZtkImJQoczv6iCKoMk1GxyArMuXcsq1N/Qn/AnYCJh3yEEGg8KKNqMmmapeHYbHcM=
X-Received: by 2002:a05:6e02:661:b0:2e2:be22:67f0 with SMTP id
 l1-20020a056e02066100b002e2be2267f0mr7007047ilt.91.1661640865299; Sat, 27 Aug
 2022 15:54:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220826024430.84565-1-alexei.starovoitov@gmail.com> <CAEf4Bzapz-SNfM+ky7UwnqNZAbJyy4eBHpxuNjW-TMk8C5ba8g@mail.gmail.com>
In-Reply-To: <CAEf4Bzapz-SNfM+ky7UwnqNZAbJyy4eBHpxuNjW-TMk8C5ba8g@mail.gmail.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Sun, 28 Aug 2022 00:53:48 +0200
Message-ID: <CAP01T76scR191CLFU10iiVn1aP47N+b8UrZtzf0syMd6az-hWA@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 00/15] bpf: BPF specific memory allocator.
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        davem@davemloft.net, daniel@iogearbox.net, andrii@kernel.org,
        tj@kernel.org, delyank@fb.com, linux-mm@kvack.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, 27 Aug 2022 at 18:57, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Aug 25, 2022 at 7:44 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > Introduce any context BPF specific memory allocator.
> >
> > Tracing BPF programs can attach to kprobe and fentry. Hence they
> > run in unknown context where calling plain kmalloc() might not be safe.
> > Front-end kmalloc() with per-cpu cache of free elements.
> > Refill this cache asynchronously from irq_work.
> >
> > Major achievements enabled by bpf_mem_alloc:
> > - Dynamically allocated hash maps used to be 10 times slower than fully preallocated.
> >   With bpf_mem_alloc and subsequent optimizations the speed of dynamic maps is equal to full prealloc.
> > - Tracing bpf programs can use dynamically allocated hash maps.
> >   Potentially saving lots of memory. Typical hash map is sparsely populated.
> > - Sleepable bpf programs can used dynamically allocated hash maps.
> >
> > v3->v4:
> > - fix build issue due to missing local.h on 32-bit arch
> > - add Kumar's ack
> > - proposal for next steps from Delyan:
> > https://lore.kernel.org/bpf/d3f76b27f4e55ec9e400ae8dcaecbb702a4932e8.camel@fb.com/
> >
> > v2->v3:
> > - Rewrote the free_list algorithm based on discussions with Kumar. Patch 1.
> > - Allowed sleepable bpf progs use dynamically allocated maps. Patches 13 and 14.
> > - Added sysctl to force bpf_mem_alloc in hash map even if pre-alloc is
> >   requested to reduce memory consumption. Patch 15.
> > - Fix: zero-fill percpu allocation
> > - Single rcu_barrier at the end instead of each cpu during bpf_mem_alloc destruction
> >
> > v2 thread:
> > https://lore.kernel.org/bpf/20220817210419.95560-1-alexei.starovoitov@gmail.com/
> >
> > v1->v2:
> > - Moved unsafe direct call_rcu() from hash map into safe place inside bpf_mem_alloc. Patches 7 and 9.
> > - Optimized atomic_inc/dec in hash map with percpu_counter. Patch 6.
> > - Tuned watermarks per allocation size. Patch 8
> > - Adopted this approach to per-cpu allocation. Patch 10.
> > - Fully converted hash map to bpf_mem_alloc. Patch 11.
> > - Removed tracing prog restriction on map types. Combination of all patches and final patch 12.
> >
> > v1 thread:
> > https://lore.kernel.org/bpf/20220623003230.37497-1-alexei.starovoitov@gmail.com/
> >
> > LWN article:
> > https://lwn.net/Articles/899274/
> >
> > Future work:
> > - expose bpf_mem_alloc as uapi FD to be used in dynptr_alloc, kptr_alloc
> > - convert lru map to bpf_mem_alloc
> >
> > Alexei Starovoitov (15):
> >   bpf: Introduce any context BPF specific memory allocator.
> >   bpf: Convert hash map to bpf_mem_alloc.
> >   selftests/bpf: Improve test coverage of test_maps
> >   samples/bpf: Reduce syscall overhead in map_perf_test.
> >   bpf: Relax the requirement to use preallocated hash maps in tracing
> >     progs.
> >   bpf: Optimize element count in non-preallocated hash map.
> >   bpf: Optimize call_rcu in non-preallocated hash map.
> >   bpf: Adjust low/high watermarks in bpf_mem_cache
> >   bpf: Batch call_rcu callbacks instead of SLAB_TYPESAFE_BY_RCU.
> >   bpf: Add percpu allocation support to bpf_mem_alloc.
> >   bpf: Convert percpu hash map to per-cpu bpf_mem_alloc.
> >   bpf: Remove tracing program restriction on map types
> >   bpf: Prepare bpf_mem_alloc to be used by sleepable bpf programs.
> >   bpf: Remove prealloc-only restriction for sleepable bpf programs.
> >   bpf: Introduce sysctl kernel.bpf_force_dyn_alloc.
> >
> >  include/linux/bpf_mem_alloc.h             |  26 +
> >  include/linux/filter.h                    |   2 +
> >  kernel/bpf/Makefile                       |   2 +-
> >  kernel/bpf/core.c                         |   2 +
> >  kernel/bpf/hashtab.c                      | 132 +++--
> >  kernel/bpf/memalloc.c                     | 602 ++++++++++++++++++++++
> >  kernel/bpf/syscall.c                      |  14 +-
> >  kernel/bpf/verifier.c                     |  52 --
> >  samples/bpf/map_perf_test_kern.c          |  44 +-
> >  samples/bpf/map_perf_test_user.c          |   2 +-
> >  tools/testing/selftests/bpf/progs/timer.c |  11 -
> >  tools/testing/selftests/bpf/test_maps.c   |  38 +-
> >  12 files changed, 796 insertions(+), 131 deletions(-)
> >  create mode 100644 include/linux/bpf_mem_alloc.h
> >  create mode 100644 kernel/bpf/memalloc.c
> >
> > --
> > 2.30.2
> >
>
> It's great to lift all those NMI restrictions on non-prealloc hashmap!
> This should also open up new maps (like qp-trie) that can't be
> pre-sized to the NMI world as well.
>
> But just to clarify, in NMI mode we can exhaust memory in caches (and
> thus if we do a lot of allocation in single BPF program execution we
> can fail some operations). That's unavoidable. But it's not 100% clear
> what's the behavior in IRQ mode and separately from that in "usual"
> less restrictive mode. Is my understanding correct that we shouldn't
> run out of memory (assuming there is memory available, of course)
> because replenishing of caches will interrupt BPF program execution?

When I was reviewing the code what I understood was as follows:

There are two ways work is queued. On non-RT, it is queued for
execution in hardirq context (raised_list), on RT it will instead be
executed by per-CPU pinned irq_work kthreads (from lazy_list).

We cannot set the IRQ_WORK_HARD_IRQ to force RT to execute them in
hardirq context, as bpf_mem_refill may take sleepable non-raw
spinlocks when calling into kmalloc, which is disallowed.

So, to summarize the behavior:
In NMI context:
- for both RT and non-RT, once we deplete the cache we get -ENOMEM.
In IRQ context:
- for RT, it will fill it asynchronously by waking up the irq_work
kthread, so you may still get -ENOMEM (also depends on if bpf prog is
in hardirq or threaded irq context, since hardirq context would be
non-preemptible, delaying refilling from irq_work kthread context).
- for non-RT, it is already inside the interrupt handler hence you
will get -ENOMEM. Interrupt handlers keep interrupts disabled, so IPI
execution is delayed until the handler returns.
In softirq and task context:
- for RT, it will fill it asynchronously by waking up the irq_work
kthread, so you may still get -ENOMEM.
- for non-RT, it will send IPI to local cpu, which will execute the
work synchronously, so you will refill the cache by interrupting the
program. Even when executing softirq inside the exit path of
interrupts, at that point interrupts are enabled so it will refill
synchronously by raising local IPI.

For the last case (say task context), the problem of kmalloc
reentrancy comes to mind again, e.g if we are tracing in guts of
kmalloc and send local IPI which eventually calls kmalloc again (which
may deadlock). But remember that such cases are already possible
without BPF, interrupts which allocate may come in at any time, so the
kmalloc code itself will keep IRQs disabled at these places, hence we
are fine from BPF side as well.

Please let me know of any inaccuracies in the above description.


> Or am I wrong and we can still run out of memory if we don't have
> enough pre-cached memory. I think it would be good to clearly state
> such things (unless I missed them somewhere in patches). I'm trying to
> understand if in non-restrictive mode we can still fail to allocate a
> bunch of hashmap elements in a loop just because of the design of
> bpf_mem_alloc?
>
> But it looks great otherwise. For the series:
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
