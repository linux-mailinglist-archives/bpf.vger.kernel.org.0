Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738A45A38F5
	for <lists+bpf@lfdr.de>; Sat, 27 Aug 2022 18:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233876AbiH0Q6E (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 27 Aug 2022 12:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiH0Q6D (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 27 Aug 2022 12:58:03 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A102558DF8
        for <bpf@vger.kernel.org>; Sat, 27 Aug 2022 09:58:00 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id gb36so8279882ejc.10
        for <bpf@vger.kernel.org>; Sat, 27 Aug 2022 09:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=UH/bQrlcY3qy+d3vRB45tQDHJMPwlx5v9AaMDIYAjgQ=;
        b=W5h/+FSmglVlSgGSgzquYkjELn992cmjIkHWV5/o9LR6Jp+U4+EoVTjGAHChls1//q
         vmuXwcCpXIVKkqrWexNLP73AmjQN0Ka1H8QCqxhv+b7f4l74n3zY/o67Rl+X+YbSm6Uv
         zwTSLUBpvnCUTk/nSfj6t9lf8LIeZK37lC+MGYMuiX0r+8mo3H2IGsiTUlq748nt3dhq
         25Vsi0uv74VranF+zMai3yHbycHmDWQ3tE7r3V5yz9Hs3IR0WFIQtq9TIyTcQ87GdFS1
         sM7Te5ddk26T8fI3M6yyMIRf84AihBajHmcyHinGHnblXN84mjSIcVbl4oOA31Vkgvl7
         h+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=UH/bQrlcY3qy+d3vRB45tQDHJMPwlx5v9AaMDIYAjgQ=;
        b=VfyxSfp8E5JH/9GdCDOtNFQXmyLNab4zCWmy/fFWu9ATHYETZVh+n0JVot0wIbXEtr
         e5d1yxCuPlDeUoO40MZOQTebZ6JarsWTJaWW7JHt54nwrwFYG8tIQTtBRFUkQqfOCuEt
         MJ6v2Z38Y+aTflnJs2B0Smjrmm2j4eJzuS+InPnHHS6+RlROF3KxnWRrmg+nF92jbjjY
         amnmNm6XzSVtTD08L/MC2ajWHlYrHCSIv/0eu6QfN5eMwGMj/aIoGWy8y4wfgR67JDX7
         2ErsmZceT0274QFhG0tRGHfZZ3M4pQFmp4+u5ryDL+DKJVdqMxCoxOBLZ90nSk9fVGHX
         xMeA==
X-Gm-Message-State: ACgBeo3DxqYwoR9G3I2p95oUW2oyYEyjUaxrVzZDEAXxMPn2t5ctxbia
        jTSLUKVa7gTBKCtjEHt/HFq2w7PolFdT5s1o6+3sEjnPfPU=
X-Google-Smtp-Source: AA6agR5BCHlpqqmUvMgkGUYyrlYQwcB3+STdxYryA5d/zheNS8DkK5nR+hqZgGxsk42fYx2Ebn3OMGVT+wKtxXYbWWE=
X-Received: by 2002:a17:907:6e8b:b0:73d:c094:e218 with SMTP id
 sh11-20020a1709076e8b00b0073dc094e218mr8745372ejc.226.1661619478696; Sat, 27
 Aug 2022 09:57:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220826024430.84565-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20220826024430.84565-1-alexei.starovoitov@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sat, 27 Aug 2022 09:57:47 -0700
Message-ID: <CAEf4Bzapz-SNfM+ky7UwnqNZAbJyy4eBHpxuNjW-TMk8C5ba8g@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 00/15] bpf: BPF specific memory allocator.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     davem@davemloft.net, daniel@iogearbox.net, andrii@kernel.org,
        tj@kernel.org, memxor@gmail.com, delyank@fb.com,
        linux-mm@kvack.org, bpf@vger.kernel.org, kernel-team@fb.com
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

On Thu, Aug 25, 2022 at 7:44 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Introduce any context BPF specific memory allocator.
>
> Tracing BPF programs can attach to kprobe and fentry. Hence they
> run in unknown context where calling plain kmalloc() might not be safe.
> Front-end kmalloc() with per-cpu cache of free elements.
> Refill this cache asynchronously from irq_work.
>
> Major achievements enabled by bpf_mem_alloc:
> - Dynamically allocated hash maps used to be 10 times slower than fully preallocated.
>   With bpf_mem_alloc and subsequent optimizations the speed of dynamic maps is equal to full prealloc.
> - Tracing bpf programs can use dynamically allocated hash maps.
>   Potentially saving lots of memory. Typical hash map is sparsely populated.
> - Sleepable bpf programs can used dynamically allocated hash maps.
>
> v3->v4:
> - fix build issue due to missing local.h on 32-bit arch
> - add Kumar's ack
> - proposal for next steps from Delyan:
> https://lore.kernel.org/bpf/d3f76b27f4e55ec9e400ae8dcaecbb702a4932e8.camel@fb.com/
>
> v2->v3:
> - Rewrote the free_list algorithm based on discussions with Kumar. Patch 1.
> - Allowed sleepable bpf progs use dynamically allocated maps. Patches 13 and 14.
> - Added sysctl to force bpf_mem_alloc in hash map even if pre-alloc is
>   requested to reduce memory consumption. Patch 15.
> - Fix: zero-fill percpu allocation
> - Single rcu_barrier at the end instead of each cpu during bpf_mem_alloc destruction
>
> v2 thread:
> https://lore.kernel.org/bpf/20220817210419.95560-1-alexei.starovoitov@gmail.com/
>
> v1->v2:
> - Moved unsafe direct call_rcu() from hash map into safe place inside bpf_mem_alloc. Patches 7 and 9.
> - Optimized atomic_inc/dec in hash map with percpu_counter. Patch 6.
> - Tuned watermarks per allocation size. Patch 8
> - Adopted this approach to per-cpu allocation. Patch 10.
> - Fully converted hash map to bpf_mem_alloc. Patch 11.
> - Removed tracing prog restriction on map types. Combination of all patches and final patch 12.
>
> v1 thread:
> https://lore.kernel.org/bpf/20220623003230.37497-1-alexei.starovoitov@gmail.com/
>
> LWN article:
> https://lwn.net/Articles/899274/
>
> Future work:
> - expose bpf_mem_alloc as uapi FD to be used in dynptr_alloc, kptr_alloc
> - convert lru map to bpf_mem_alloc
>
> Alexei Starovoitov (15):
>   bpf: Introduce any context BPF specific memory allocator.
>   bpf: Convert hash map to bpf_mem_alloc.
>   selftests/bpf: Improve test coverage of test_maps
>   samples/bpf: Reduce syscall overhead in map_perf_test.
>   bpf: Relax the requirement to use preallocated hash maps in tracing
>     progs.
>   bpf: Optimize element count in non-preallocated hash map.
>   bpf: Optimize call_rcu in non-preallocated hash map.
>   bpf: Adjust low/high watermarks in bpf_mem_cache
>   bpf: Batch call_rcu callbacks instead of SLAB_TYPESAFE_BY_RCU.
>   bpf: Add percpu allocation support to bpf_mem_alloc.
>   bpf: Convert percpu hash map to per-cpu bpf_mem_alloc.
>   bpf: Remove tracing program restriction on map types
>   bpf: Prepare bpf_mem_alloc to be used by sleepable bpf programs.
>   bpf: Remove prealloc-only restriction for sleepable bpf programs.
>   bpf: Introduce sysctl kernel.bpf_force_dyn_alloc.
>
>  include/linux/bpf_mem_alloc.h             |  26 +
>  include/linux/filter.h                    |   2 +
>  kernel/bpf/Makefile                       |   2 +-
>  kernel/bpf/core.c                         |   2 +
>  kernel/bpf/hashtab.c                      | 132 +++--
>  kernel/bpf/memalloc.c                     | 602 ++++++++++++++++++++++
>  kernel/bpf/syscall.c                      |  14 +-
>  kernel/bpf/verifier.c                     |  52 --
>  samples/bpf/map_perf_test_kern.c          |  44 +-
>  samples/bpf/map_perf_test_user.c          |   2 +-
>  tools/testing/selftests/bpf/progs/timer.c |  11 -
>  tools/testing/selftests/bpf/test_maps.c   |  38 +-
>  12 files changed, 796 insertions(+), 131 deletions(-)
>  create mode 100644 include/linux/bpf_mem_alloc.h
>  create mode 100644 kernel/bpf/memalloc.c
>
> --
> 2.30.2
>

It's great to lift all those NMI restrictions on non-prealloc hashmap!
This should also open up new maps (like qp-trie) that can't be
pre-sized to the NMI world as well.

But just to clarify, in NMI mode we can exhaust memory in caches (and
thus if we do a lot of allocation in single BPF program execution we
can fail some operations). That's unavoidable. But it's not 100% clear
what's the behavior in IRQ mode and separately from that in "usual"
less restrictive mode. Is my understanding correct that we shouldn't
run out of memory (assuming there is memory available, of course)
because replenishing of caches will interrupt BPF program execution?
Or am I wrong and we can still run out of memory if we don't have
enough pre-cached memory. I think it would be good to clearly state
such things (unless I missed them somewhere in patches). I'm trying to
understand if in non-restrictive mode we can still fail to allocate a
bunch of hashmap elements in a loop just because of the design of
bpf_mem_alloc?

But it looks great otherwise. For the series:

Acked-by: Andrii Nakryiko <andrii@kernel.org>
