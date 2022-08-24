Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9CC35A026E
	for <lists+bpf@lfdr.de>; Wed, 24 Aug 2022 22:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240087AbiHXUDy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 16:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233529AbiHXUDx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 16:03:53 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355707C1F9
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 13:03:51 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id x64so14300788iof.1
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 13:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=cJOlmdLgf/zMpHi+EIYjFklQum6i8of9fryDup8SEYY=;
        b=A7CQ2t/w1A7p0v0JnJhvkGnQLx8cbAN3MS/QHWlVtXAlLUaspgkna6uNBRO6houek1
         zHRp+Vu1VknUMhXmrG+N9T68ubyGYpalY1lUVodDtGyk4egiEmf6+yTXsPf0dCN1TGa6
         o3zODfWJ0EIvuBfMxgGO3ztGI/ztamkY+FZjOXs6U+vdR5kl0pCTHkQaPqKdQ3TkHxzM
         hQwaQJA1FcF8Hx30Z0PeTK4vYk88GNE2AxkecV3/Qw7UXPae9n12Q6RUFdvY7zUFuPc7
         UclGKXkvGQAAK2Ym090By9LYy+XOr0vI76K/hcsiCOxm56/SokqEZx+bh2tilLxRKpog
         cTPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=cJOlmdLgf/zMpHi+EIYjFklQum6i8of9fryDup8SEYY=;
        b=R0q+KPS+N4xP9kaDI/s/9hOOd1Y/o/6HtHFJWsw2taMzAVIkSlzWMJex7Jk871pztD
         IfW0YSNOBE/Amtjc3fDT0c1nRkSFO+laACoAaI9ap8NZssEQnfcG6k7Gwrzqdt66EcTs
         cH4dJ3erkZkTfXka5M9uIky38TvCAI0SLUdVxLpGzxsf48jXfWazb9tYymjVGxEx/cJQ
         eXxRykZYconf14DILP5erDxvLcU7cUV5Tjo3mnan3kNSHbkhnNtedGLnsMaovxJbSv+m
         D0lq86d6M6PwQ/N5YuNXLNdzqPaaLyxw90G4ulxjH6gWYet1eMZNYJS3V6mHsI8m7cXo
         Y3hw==
X-Gm-Message-State: ACgBeo3Oyy/0AWKyPyvV4oE5L3o06jNbE4bm3h9FYrdut8E17CD6SCcj
        ZC/DquOetoxjlbmnOtenPsNjlqMlvIqfyZfybQo=
X-Google-Smtp-Source: AA6agR6rRJun93syO2w8ub3L3xA3WhXeByA+Ys1LJXWwINB4x3IUyfHBKzRAlS3MqYA20lQ/9CQKNkofX7c+KjNgx8k=
X-Received: by 2002:a05:6638:2105:b0:34a:694:4fa4 with SMTP id
 n5-20020a056638210500b0034a06944fa4mr286938jaj.116.1661371430570; Wed, 24 Aug
 2022 13:03:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220819214232.18784-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20220819214232.18784-1-alexei.starovoitov@gmail.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Wed, 24 Aug 2022 22:03:13 +0200
Message-ID: <CAP01T75WHh_zCgM6uf=W5uQzJSWODnsZNy0g-Wj2Z+KOoDW_FQ@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 00/15] bpf: BPF specific memory allocator.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     davem@davemloft.net, daniel@iogearbox.net, andrii@kernel.org,
        tj@kernel.org, delyank@fb.com, linux-mm@kvack.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 19 Aug 2022 at 23:42, Alexei Starovoitov
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

From my side, for the whole series:
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>


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
>  kernel/bpf/memalloc.c                     | 601 ++++++++++++++++++++++
>  kernel/bpf/syscall.c                      |  14 +-
>  kernel/bpf/verifier.c                     |  52 --
>  samples/bpf/map_perf_test_kern.c          |  44 +-
>  samples/bpf/map_perf_test_user.c          |   2 +-
>  tools/testing/selftests/bpf/progs/timer.c |  11 -
>  tools/testing/selftests/bpf/test_maps.c   |  38 +-
>  12 files changed, 795 insertions(+), 131 deletions(-)
>  create mode 100644 include/linux/bpf_mem_alloc.h
>  create mode 100644 kernel/bpf/memalloc.c
>
> --
> 2.30.2
>
