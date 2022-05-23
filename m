Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC695317DD
	for <lists+bpf@lfdr.de>; Mon, 23 May 2022 22:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiEWUjq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 May 2022 16:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiEWUjp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 May 2022 16:39:45 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808DCD80B5
        for <bpf@vger.kernel.org>; Mon, 23 May 2022 13:39:43 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id t15so4307284ilg.13
        for <bpf@vger.kernel.org>; Mon, 23 May 2022 13:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1K0B6y0QlGJs0B/BRMS2ref9EXALJKv/gZ783J8g6e0=;
        b=Y1GC/8RQRMUz2A5Fw71TV98wM4PLYavK3bSFA2VAQ2Y58FrjxzfcfEJqXaLjaMDNY5
         4ZL/9FOHjdtwLwK+mp2gSDdd1qO4OVoZJ7YwukAI1OCPTp4e6Ydp4I3kLUz7rAusenl4
         tNaddA7EW66ci/Py+4EosKr9ebBXEdAI8eorSpF6EmY2XQgfvfCb+fHG0pQ6gStn4R14
         +d5iJchAjbCsj9XADT8excUSbuJQm4nzKMMgpTZTI0DkTLsOXbO504phT0IVJWCfjg2l
         Ewocm4VB/C23GaVX0uKwnNf28IcXSfPfmZGwSEjGPEeUwekhJ4Q7RiUC/gVZiW25QsGf
         4lgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1K0B6y0QlGJs0B/BRMS2ref9EXALJKv/gZ783J8g6e0=;
        b=XV3LVZ+i1xZ0OVJG5CUzRcj4HcsFTwN6ur5sYfouYSfqX6ptvX3Hfln3wCHY0jQp7j
         qln8vMK3UYdeYJCxeWZdShff/c7hsiJlylOPF21IZ4iP5ctcigp7kuIqQU5HlrxUNXyk
         Gadm4SHUbN/wE55hpokN4PHV00Mgo7hk0jAwCxFjT3WCp9eBCotB/m6wnPBgfMoBNPn7
         3YtuXGf1+JoBmm6BCBRl6J0P3cuKbnxTSwLMcqJC/ePbf8Dw9KEChTtNxaqQtMktlCrf
         1o2RvM0otHq+uVHSN/9amyQJFSiqL/vhxeO3gs3rCC5KjAkOgnKiIHDBcc5YJhuKAZKV
         PlFA==
X-Gm-Message-State: AOAM5312Fv6eIvyxY1hnkuQ6Po44MQL7bwAucPsKPk2UsRJCkizWOvUD
        S0bcYxpIrTt2NZIW0fvEmOGdaFsMQQdW5wWTc9c=
X-Google-Smtp-Source: ABdhPJyN4Jpg2YQfaINN0u57wlW0eT74HsPO1IdCiDxeMLk60J9z5oToFR+UX4JLur1Li0ZQbqOpYN4N9Sr0Z/BMers=
X-Received: by 2002:a05:6e02:1d85:b0:2d1:39cf:380c with SMTP id
 h5-20020a056e021d8500b002d139cf380cmr11839979ila.239.1653338382741; Mon, 23
 May 2022 13:39:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220518035131.725193-1-davemarchevsky@fb.com>
 <CAEf4BzYw-wKk8Wu2KEMi=tiP6akxQa4cjHwCYCvWDipkwy2SWg@mail.gmail.com> <2daebb4f-eb00-b536-85d0-985079a5ee1c@fb.com>
In-Reply-To: <2daebb4f-eb00-b536-85d0-985079a5ee1c@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 23 May 2022 13:39:31 -0700
Message-ID: <CAEf4BzZAb8wSUq+FFogU=cyuCbV9AEaHOxzWwrFr0nbFVi18aw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] selftests/bpf: Add benchmark for
 local_storage get
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Kernel Team <kernel-team@fb.com>
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

On Fri, May 20, 2022 at 10:22 PM Dave Marchevsky <davemarchevsky@fb.com> wrote:
>
> On 5/20/22 8:41 PM, Andrii Nakryiko wrote:
> > On Tue, May 17, 2022 at 8:51 PM Dave Marchevsky <davemarchevsky@fb.com> wrote:
> >>
> >> Add a benchmarks to demonstrate the performance cliff for local_storage
> >> get as the number of local_storage maps increases beyond current
> >> local_storage implementation's cache size.
> >>
> >> "sequential get" and "interleaved get" benchmarks are added, both of
> >> which do many bpf_task_storage_get calls on sets of task local_storage
> >> maps of various counts, while considering a single specific map to be
> >> 'important' and counting task_storage_gets to the important map
> >> separately in addition to normal 'hits' count of all gets. Goal here is
> >> to mimic scenario where a particular program using one map - the
> >> important one - is running on a system where many other local_storage
> >> maps exist and are accessed often.
> >>
> >> While "sequential get" benchmark does bpf_task_storage_get for map 0, 1,
> >> ..., {9, 99, 999} in order, "interleaved" benchmark interleaves 4
> >> bpf_task_storage_gets for the important map for every 10 map gets. This
> >> is meant to highlight performance differences when important map is
> >> accessed far more frequently than non-important maps.
> >>
> >> A "hashmap control" benchmark is also included for easy comparison of
> >> standard bpf hashmap lookup vs local_storage get. The benchmark is
> >> identical to "sequential get", but creates and uses BPF_MAP_TYPE_HASH
> >> instead of local storage.
> >>
> >> Addition of this benchmark is inspired by conversation with Alexei in a
> >> previous patchset's thread [0], which highlighted the need for such a
> >> benchmark to motivate and validate improvements to local_storage
> >> implementation. My approach in that series focused on improving
> >> performance for explicitly-marked 'important' maps and was rejected
> >> with feedback to make more generally-applicable improvements while
> >> avoiding explicitly marking maps as important. Thus the benchmark
> >> reports both general and important-map-focused metrics, so effect of
> >> future work on both is clear.
> >>
> >> Regarding the benchmark results. On a powerful system (Skylake, 20
> >> cores, 256gb ram):
> >>
> >> Local Storage
> >> =============
> >
> > [...]
> >
> >>
> >> Looking at the "sequential get" results, it's clear that as the
> >> number of task local_storage maps grows beyond the current cache size
> >> (16), there's a significant reduction in hits throughput. Note that
> >> current local_storage implementation assigns a cache_idx to maps as they
> >> are created. Since "sequential get" is creating maps 0..n in order and
> >> then doing bpf_task_storage_get calls in the same order, the benchmark
> >> is effectively ensuring that a map will not be in cache when the program
> >> tries to access it.
> >>
> >> For "interleaved get" results, important-map hits throughput is greatly
> >> increased as the important map is more likely to be in cache by virtue
> >> of being accessed far more frequently. Throughput still reduces as #
> >> maps increases, though.
> >>
> >> Note that the test programs need to split task_storage_get calls across
> >> multiple programs to work around the verifier's MAX_USED_MAPS
> >> limitations. As evidenced by the unintuitive-looking results for smaller
> >> num_maps benchmark runs, overhead which is amortized across larger
> >> num_maps in other runs dominates when there are fewer maps. To get a
> >> sense of the overhead, I commented out
> >> bpf_task_storage_get/bpf_map_lookup_elem in local_storage_bench.h and
> >> ran the benchmark on the same host as 'real' run. Results:
> >>
> >> Local Storage
> >> =============
> >
> > [...]
> >
> >>
> >> Adjusting for overhead, latency numbers for "hashmap control" and "sequential get" are:
> >>
> >> hashmap_control:     ~6.8ns
> >> sequential_get_1:    ~15.5ns
> >> sequential_get_10:   ~20ns
> >> sequential_get_16:   ~17.8ns
> >> sequential_get_17:   ~21.8ns
> >> sequential_get_24:   ~45.2ns
> >> sequential_get_32:   ~69.7ns
> >> sequential_get_100:  ~153.3ns
> >> sequential_get_1000: ~2300ns
> >>
> >> Clearly demonstrating a cliff.
> >>
> >> When running the benchmarks it may be necessary to bump 'open files'
> >> ulimit for a successful run.
> >>
> >>   [0]: https://lore.kernel.org/all/20220420002143.1096548-1-davemarchevsky@fb.com
> >>
> >> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> >> ---
> >> Changelog:
> >>
> >> v1 -> v2:
> >>   * Adopt ARRAY_OF_MAPS approach for bpf program, allowing truly
> >>     configurable # of maps (Andrii)
> >>   * Add hashmap benchmark (Alexei)
> >>         * Add discussion of overhead
> >>
> >
> > [...]
> >
> >> +
> >> +/* Keep in sync w/ array of maps in bpf */
> >> +#define MAX_NR_MAPS 1000
> >> +/* Keep in sync w/ number of progs in bpf app */
> >> +#define MAX_NR_PROGS 20
> >> +
> >> +static struct {
> >> +       void (*destroy_skel)(void *obj);
> >> +       int (*load_skel)(void *obj);
> >> +       long *important_hits;
> >> +       long *hits;
> >> +       void *progs;
> >> +       void *skel;
> >> +       struct bpf_map *array_of_maps;
> >> +} ctx;
> >> +
> >> +int created_maps[MAX_NR_MAPS];
> >> +struct bpf_link *attached_links[MAX_NR_PROGS];
> >> +
> >
> > static?
>
> I sent v3 before seeing this email, but luckily most of your comments are
> addressed already.
>
> attached_links is removed in v3, created_maps is moved to ctx
>
> >
> >
> >> +static void teardown(void)
> >> +{
> >> +       int i;
> >> +
> >> +       for (i = 0; i < MAX_NR_PROGS; i++) {
> >> +               if (!attached_links[i])
> >> +                       break;
> >> +               bpf_link__detach(attached_links[i]);
> >> +       }
> >> +
> >> +       if (ctx.destroy_skel && ctx.skel)
> >> +               ctx.destroy_skel(ctx.skel);
> >> +
> >> +       for (i = 0; i < MAX_NR_MAPS; i++) {
> >> +               if (!created_maps[i])
> >> +                       break;
> >> +               close(created_maps[i]);
> >> +       }
> >> +}
> >> +
> >
> > Wouldn't all this be cleaned up on bench exit anyway?.. We've been
> > less strict about proper clean up for bench to keep code simpler.
>
> It's important to explicitly clean up created_maps because local_storage maps
> are assigned a cache slot when the map is created, and count of "how many maps
> are assigned to this cache slot" is incr'd. On map free the count is decr'd.
>
> So cache behavior of subsequently alloc'd maps can be affected if these are kept
> around.
>
> Not a big deal now since just 1 bench is run and process exits, but if that
> changes in the future I don't want the benchmark to silently give odd results.
>

Right, I don't see why we'd need to support running multiple
benchmarks within the same bench process. We can always run ./bench
twice. So the exact point is that there is no need to clean up after
benchmark (unless kernel won't clean up after us automatically).
That's the reason why we never had teardown callback in the first
place, not because there is nothing to clean up, but because it will
happen automatically on process exit (and that's ok for ./bench).


> >
> >
> > [...]
> >
> >> diff --git a/tools/testing/selftests/bpf/progs/local_storage_bench.h b/tools/testing/selftests/bpf/progs/local_storage_bench.h
> >> new file mode 100644
> >> index 000000000000..b5e358dee245
> >> --- /dev/null
> >> +++ b/tools/testing/selftests/bpf/progs/local_storage_bench.h
> >> @@ -0,0 +1,69 @@
> >> +/* SPDX-License-Identifier: GPL-2.0 */
> >> +/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
> >> +
> >> +struct {
> >> +       __uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
> >> +       __uint(max_entries, 1000);
> >> +       __type(key, int);
> >> +       __type(value, int);
> >> +} array_of_maps SEC(".maps");
> >
> > you don't need setup_inner_map_and_load and load_btf, you can just
> > declaratively have two ARRAY_OF_MAPS, one using inner hashmap and
> > another using inner task_local_storage. Grep for __array in selftests
> > to see how to declaratively define inner map prototype, e.g., see
> > test_ringbuf_multi.c. With the below suggestion one of do_lookup
> > flavors will use array_of_hashes and another will use
> > array_of_storages explicitly. From user-space you can create and setup
> > as many inner maps as needed. If you need btf_id for value_type_id for
> > inner map, see if bpf_map__inner_map() would be useful.
> >
>
> Declaratively specifying an inner task_local_storage map will result in libbpf
> creating such a map to pass as the inner_map_fd, no? This will have same
> effect on cache_idx assignment as my previous comment.

It will inner "prototype" map, pass its FD as inner_map_fd to create
outer map. But after that it will immediately close FD and destroy it.
Does that affect the benchmark negatively? Extra inner map should be
gone by the time you start creating actual inner maps.

>
> >> +
> >> +long important_hits;
> >> +long hits;
> >> +
> >> +#ifdef LOOKUP_HASHMAP
> >
> > why #ifdef'ing if you can have do_lookup_hashmap and
> > do_lookup_task_storage and choose which one to call using read-only
> > variable:
> >
> > const volatile bool use_hashmap;
> >
> > just set it before load and verifier will know that one of do_lookup
> > flavors is dead code
>
> I want it to be obvious that the hashmap part of the benchmark is not a flavor
> of local_storage, the distinct separation of do_lookups here makes this easier
> to notice.
>
> Can do a v4 addressing this if you feel strongly about it.

I generally dislike #if/#endif guards for BPF code, if they can be
avoided, as they go completely against the spirit of CO-RE.

>
> >
> >> +static int do_lookup(unsigned int elem, struct task_struct *task /* unused */)
> >> +{
> >> +       void *map;
> >> +       int zero = 0;
> >> +
> >> +       map = bpf_map_lookup_elem(&array_of_maps, &elem);
> >> +       if (!map)
> >> +               return -1;
> >> +
> >> +       bpf_map_lookup_elem(map, &zero);
> >> +       __sync_add_and_fetch(&hits, 1);
> >> +       if (!elem)
> >> +               __sync_add_and_fetch(&important_hits, 1);
> >> +       return 0;
> >> +}
> >> +#else
> >> +static int do_lookup(unsigned int elem, struct task_struct *task)
> >> +{
> >> +       void *map;
> >> +
> >> +       map = bpf_map_lookup_elem(&array_of_maps, &elem);
> >> +       if (!map)
> >> +               return -1;
> >> +
> >> +       bpf_task_storage_get(map, task, 0, BPF_LOCAL_STORAGE_GET_F_CREATE);
> >> +       __sync_add_and_fetch(&hits, 1);
> >> +       if (!elem)
> >> +               __sync_add_and_fetch(&important_hits, 1);
> >> +       return 0;
> >> +}
> >> +#endif /* LOOKUP_HASHMAP */
> >> +
> >> +#define __TASK_STORAGE_GET_LOOP_PROG(array, start, interleave) \
> >> +SEC("fentry/" SYS_PREFIX "sys_getpgid")                        \
> >> +int get_local_ ## start(void *ctx)                             \
> >> +{                                                              \
> >> +       struct task_struct *task;                               \
> >> +       unsigned int i, elem;                                   \
> >> +       void *map;                                              \
> >> +                                                               \
> >> +       task = bpf_get_current_task_btf();                      \
> >> +       for (i = 0; i < 50; i++) {                              \
> >
> > I'm trying to understand why you didn't just do
> >
> >
> > for (i = 0; i < 1000; i++) { ... }
> >
> > and avoid all the macro stuff? what didn't work?
> >
> >
> >> +               elem = start + i;                               \
> >> +               if (do_lookup(elem, task))                      \
> >> +                       return 0;                               \
> >> +               if (interleave && i % 3 == 0)                   \
> >
> > nit % 3 will be slow(-ish), why not pick some power of 2?
>
> Few reasons:
>
> 1) This results in a ratio of "get important map" to "get any other map" closest
> to v1 of this patchset, and similar interleaving pattern. Made it easy to
> compare results after big refactor and be reasonably sure I didn't break the
> benchmark.
>

ok, np, div and mod are noticeably more expensive than even
multiplication, so if you have microbenchmark it would be preferable
to avoid division, if possible


> 2) The current local_storage cache has 16 entries and the current
> cache slot assignment algorithm will always give the important map cache_idx
> 0 since it's created first. Second created map - idx 1 in the ARRAY_OF_MAPS -
> will get cache_idx 1, etc, so for this benchmark
> cache_idx = map_of_maps_idx % 16. (Assuming no other task_local_storage maps
> have been created on the system).
>
> We want to pick a small number because in 'important map' scenario the
> important map is accessed significantly more often than other maps. So < 16.
> Considering current implementation with fixed cache_idx, if we pick a power
> of 2 that's < 16, there will always be the same 'gap' between important
> map get and other map gets with same cache_idx. We care about these specifically
> since they'll be knocking each other out of cache slot.
>
> If an odd number is used the gaps will vary, resulting in a benchmark more
> closely mimicing "bunch of unrelated progs accessing maps in arbitrary order,
> with one important prog accessing its map very frequently".
>
> Probably moving to bpf_get_prandom or some userspace nondeterminism to feed
> list of indices to interleave gets of important map is the best solution,
> but I'm hoping to keep things simple for now.
>

yeah, IMO it's fine, as long as it's done consciously

> >
> >> +                       do_lookup(0, task);                     \
> >> +       }                                                       \
> >> +       return 0;                                               \
> >> +}
> >> +
> >> +#define TASK_STORAGE_GET_LOOP_PROG_SEQ(array, start) \
> >> +       __TASK_STORAGE_GET_LOOP_PROG(array, start, false)
> >> +#define TASK_STORAGE_GET_LOOP_PROG_INT(array, start) \
> >> +       __TASK_STORAGE_GET_LOOP_PROG(array, start, true)
> >
> > [...]
> >
> >> +
> >> +TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 0);
> >> +TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 50);
> >> +TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 100);
> >> +TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 150);
> >> +TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 200);
> >> +TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 250);
> >> +TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 300);
> >> +TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 350);
> >> +TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 400);
> >> +TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 450);
> >> +TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 500);
> >> +TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 550);
> >> +TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 600);
> >> +TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 650);
> >> +TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 700);
> >> +TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 750);
> >> +TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 800);
> >> +TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 850);
> >> +TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 900);
> >> +TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 950);
> >> +
> >
> > all these macro make me sad, I'd like to understand why it has to be
> > done this way
> >
>
> Macro and "why not i < 1000" are addressed in v3. v1 of this patch - before your
> ARRAY_OF_MAPS suggestion - was hitting MAX_USED_MAPS limit and failing
> verification when trying to access all 1k maps in a single program. I assumed
> that accessing maps from within an ARRAY_OF_MAPS would trigger similar limit,
> but this is not the case.

ok, haven't checked v3 yet, will take a look, thanks

>
> >> +char _license[] SEC("license") = "GPL";
> >> --
> >> 2.30.2
> >>
