Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 381B252F6F7
	for <lists+bpf@lfdr.de>; Sat, 21 May 2022 02:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244830AbiEUAlX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 May 2022 20:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbiEUAlW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 May 2022 20:41:22 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FA522532
        for <bpf@vger.kernel.org>; Fri, 20 May 2022 17:41:21 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id 2so512387iou.5
        for <bpf@vger.kernel.org>; Fri, 20 May 2022 17:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vGzkNYbQAoRwu+67a4nmufMTjnKJEgx17yeeLC0RCtU=;
        b=Mc5jXlxRleKxrSiIGvU5dKZAYPJa6vMpET5SeB0+pCR9h3rVI9+0/6QDwMPAItkCTJ
         wWqXcX7+hyLiSi/26ssteI6Dvi3u60JTwtHT1iIP7tyZoS8ZgQfDtd1ePFhJvPlA/Ltu
         g6+IqoDtKGva8U1k5/Knjsn2vhDFQYODU7W00MooyOZv7TJGKwbAVRutSX0yhAnolh9S
         btpL8v1qnYwHgA526Mnnq4xEUAARkz1lYS5pIWK3NneVX2DeaxAaEPpFOoRTYVGJdW56
         +XUZ1oe0L0nPNILk4kF+FuKYhRp7T69BBzPT7+6DgzVYidOX64wTxf0s/okuk7Hg9Jih
         ul0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vGzkNYbQAoRwu+67a4nmufMTjnKJEgx17yeeLC0RCtU=;
        b=pixxdo+0ymSTiWuvOnmE7V5jFKPxQkniPN+s2F6jvo4t5Kq1GheelrPDmuiUx8lilO
         8aGTK24tWAKrhyaBbD+VnVx7QMjSOepZ+ATEuMkgqBPpubzpBwx3Agumbyge4kyXAKnT
         tKvI1VASEyf6IpZH1Q+FyDSUO3BWIguFPajIz0ePggycwLwOYIHH6LX48FBgc2P8+x73
         CM7jp3KftEqFfaEGWQW8OemcENOqTUUGGvyC2ogRPcrRNSc0aF50jk4ciogLuG1lxfCe
         P0e6xjskjwpD8XmtAYJjK9WZVd3uXIOjmqp0LrNMEIrnQOeyhz18pmI4DI3wotELpjXJ
         En5A==
X-Gm-Message-State: AOAM533Y1U7UB/472yIL71HYdPwdchxW0CHssDxN5L1x0lAJXkVn0/9f
        +0LRdN63Vsb5aIiqqpfzkSjIiCZSFv3eI0uYr2Y=
X-Google-Smtp-Source: ABdhPJzkhM/b+IxUz5HMAqMPu/WXU9Ry5mss+cXHm5Aqf6AlD7PR/nvAmKpT7WQiZbBh4gtS3cPBoQkAYtWBtc2rbzk=
X-Received: by 2002:a05:6638:344c:b0:32e:9170:6a4f with SMTP id
 q12-20020a056638344c00b0032e91706a4fmr4714966jav.145.1653093680445; Fri, 20
 May 2022 17:41:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220518035131.725193-1-davemarchevsky@fb.com>
In-Reply-To: <20220518035131.725193-1-davemarchevsky@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 20 May 2022 17:41:09 -0700
Message-ID: <CAEf4BzYw-wKk8Wu2KEMi=tiP6akxQa4cjHwCYCvWDipkwy2SWg@mail.gmail.com>
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

On Tue, May 17, 2022 at 8:51 PM Dave Marchevsky <davemarchevsky@fb.com> wrote:
>
> Add a benchmarks to demonstrate the performance cliff for local_storage
> get as the number of local_storage maps increases beyond current
> local_storage implementation's cache size.
>
> "sequential get" and "interleaved get" benchmarks are added, both of
> which do many bpf_task_storage_get calls on sets of task local_storage
> maps of various counts, while considering a single specific map to be
> 'important' and counting task_storage_gets to the important map
> separately in addition to normal 'hits' count of all gets. Goal here is
> to mimic scenario where a particular program using one map - the
> important one - is running on a system where many other local_storage
> maps exist and are accessed often.
>
> While "sequential get" benchmark does bpf_task_storage_get for map 0, 1,
> ..., {9, 99, 999} in order, "interleaved" benchmark interleaves 4
> bpf_task_storage_gets for the important map for every 10 map gets. This
> is meant to highlight performance differences when important map is
> accessed far more frequently than non-important maps.
>
> A "hashmap control" benchmark is also included for easy comparison of
> standard bpf hashmap lookup vs local_storage get. The benchmark is
> identical to "sequential get", but creates and uses BPF_MAP_TYPE_HASH
> instead of local storage.
>
> Addition of this benchmark is inspired by conversation with Alexei in a
> previous patchset's thread [0], which highlighted the need for such a
> benchmark to motivate and validate improvements to local_storage
> implementation. My approach in that series focused on improving
> performance for explicitly-marked 'important' maps and was rejected
> with feedback to make more generally-applicable improvements while
> avoiding explicitly marking maps as important. Thus the benchmark
> reports both general and important-map-focused metrics, so effect of
> future work on both is clear.
>
> Regarding the benchmark results. On a powerful system (Skylake, 20
> cores, 256gb ram):
>
> Local Storage
> =============

[...]

>
> Looking at the "sequential get" results, it's clear that as the
> number of task local_storage maps grows beyond the current cache size
> (16), there's a significant reduction in hits throughput. Note that
> current local_storage implementation assigns a cache_idx to maps as they
> are created. Since "sequential get" is creating maps 0..n in order and
> then doing bpf_task_storage_get calls in the same order, the benchmark
> is effectively ensuring that a map will not be in cache when the program
> tries to access it.
>
> For "interleaved get" results, important-map hits throughput is greatly
> increased as the important map is more likely to be in cache by virtue
> of being accessed far more frequently. Throughput still reduces as #
> maps increases, though.
>
> Note that the test programs need to split task_storage_get calls across
> multiple programs to work around the verifier's MAX_USED_MAPS
> limitations. As evidenced by the unintuitive-looking results for smaller
> num_maps benchmark runs, overhead which is amortized across larger
> num_maps in other runs dominates when there are fewer maps. To get a
> sense of the overhead, I commented out
> bpf_task_storage_get/bpf_map_lookup_elem in local_storage_bench.h and
> ran the benchmark on the same host as 'real' run. Results:
>
> Local Storage
> =============

[...]

>
> Adjusting for overhead, latency numbers for "hashmap control" and "sequential get" are:
>
> hashmap_control:     ~6.8ns
> sequential_get_1:    ~15.5ns
> sequential_get_10:   ~20ns
> sequential_get_16:   ~17.8ns
> sequential_get_17:   ~21.8ns
> sequential_get_24:   ~45.2ns
> sequential_get_32:   ~69.7ns
> sequential_get_100:  ~153.3ns
> sequential_get_1000: ~2300ns
>
> Clearly demonstrating a cliff.
>
> When running the benchmarks it may be necessary to bump 'open files'
> ulimit for a successful run.
>
>   [0]: https://lore.kernel.org/all/20220420002143.1096548-1-davemarchevsky@fb.com
>
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---
> Changelog:
>
> v1 -> v2:
>   * Adopt ARRAY_OF_MAPS approach for bpf program, allowing truly
>     configurable # of maps (Andrii)
>   * Add hashmap benchmark (Alexei)
>         * Add discussion of overhead
>

[...]

> +
> +/* Keep in sync w/ array of maps in bpf */
> +#define MAX_NR_MAPS 1000
> +/* Keep in sync w/ number of progs in bpf app */
> +#define MAX_NR_PROGS 20
> +
> +static struct {
> +       void (*destroy_skel)(void *obj);
> +       int (*load_skel)(void *obj);
> +       long *important_hits;
> +       long *hits;
> +       void *progs;
> +       void *skel;
> +       struct bpf_map *array_of_maps;
> +} ctx;
> +
> +int created_maps[MAX_NR_MAPS];
> +struct bpf_link *attached_links[MAX_NR_PROGS];
> +

static?


> +static void teardown(void)
> +{
> +       int i;
> +
> +       for (i = 0; i < MAX_NR_PROGS; i++) {
> +               if (!attached_links[i])
> +                       break;
> +               bpf_link__detach(attached_links[i]);
> +       }
> +
> +       if (ctx.destroy_skel && ctx.skel)
> +               ctx.destroy_skel(ctx.skel);
> +
> +       for (i = 0; i < MAX_NR_MAPS; i++) {
> +               if (!created_maps[i])
> +                       break;
> +               close(created_maps[i]);
> +       }
> +}
> +

Wouldn't all this be cleaned up on bench exit anyway?.. We've been
less strict about proper clean up for bench to keep code simpler.


[...]

> diff --git a/tools/testing/selftests/bpf/progs/local_storage_bench.h b/tools/testing/selftests/bpf/progs/local_storage_bench.h
> new file mode 100644
> index 000000000000..b5e358dee245
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/local_storage_bench.h
> @@ -0,0 +1,69 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
> +       __uint(max_entries, 1000);
> +       __type(key, int);
> +       __type(value, int);
> +} array_of_maps SEC(".maps");

you don't need setup_inner_map_and_load and load_btf, you can just
declaratively have two ARRAY_OF_MAPS, one using inner hashmap and
another using inner task_local_storage. Grep for __array in selftests
to see how to declaratively define inner map prototype, e.g., see
test_ringbuf_multi.c. With the below suggestion one of do_lookup
flavors will use array_of_hashes and another will use
array_of_storages explicitly. From user-space you can create and setup
as many inner maps as needed. If you need btf_id for value_type_id for
inner map, see if bpf_map__inner_map() would be useful.

> +
> +long important_hits;
> +long hits;
> +
> +#ifdef LOOKUP_HASHMAP

why #ifdef'ing if you can have do_lookup_hashmap and
do_lookup_task_storage and choose which one to call using read-only
variable:

const volatile bool use_hashmap;

just set it before load and verifier will know that one of do_lookup
flavors is dead code

> +static int do_lookup(unsigned int elem, struct task_struct *task /* unused */)
> +{
> +       void *map;
> +       int zero = 0;
> +
> +       map = bpf_map_lookup_elem(&array_of_maps, &elem);
> +       if (!map)
> +               return -1;
> +
> +       bpf_map_lookup_elem(map, &zero);
> +       __sync_add_and_fetch(&hits, 1);
> +       if (!elem)
> +               __sync_add_and_fetch(&important_hits, 1);
> +       return 0;
> +}
> +#else
> +static int do_lookup(unsigned int elem, struct task_struct *task)
> +{
> +       void *map;
> +
> +       map = bpf_map_lookup_elem(&array_of_maps, &elem);
> +       if (!map)
> +               return -1;
> +
> +       bpf_task_storage_get(map, task, 0, BPF_LOCAL_STORAGE_GET_F_CREATE);
> +       __sync_add_and_fetch(&hits, 1);
> +       if (!elem)
> +               __sync_add_and_fetch(&important_hits, 1);
> +       return 0;
> +}
> +#endif /* LOOKUP_HASHMAP */
> +
> +#define __TASK_STORAGE_GET_LOOP_PROG(array, start, interleave) \
> +SEC("fentry/" SYS_PREFIX "sys_getpgid")                        \
> +int get_local_ ## start(void *ctx)                             \
> +{                                                              \
> +       struct task_struct *task;                               \
> +       unsigned int i, elem;                                   \
> +       void *map;                                              \
> +                                                               \
> +       task = bpf_get_current_task_btf();                      \
> +       for (i = 0; i < 50; i++) {                              \

I'm trying to understand why you didn't just do


for (i = 0; i < 1000; i++) { ... }

and avoid all the macro stuff? what didn't work?


> +               elem = start + i;                               \
> +               if (do_lookup(elem, task))                      \
> +                       return 0;                               \
> +               if (interleave && i % 3 == 0)                   \

nit % 3 will be slow(-ish), why not pick some power of 2?

> +                       do_lookup(0, task);                     \
> +       }                                                       \
> +       return 0;                                               \
> +}
> +
> +#define TASK_STORAGE_GET_LOOP_PROG_SEQ(array, start) \
> +       __TASK_STORAGE_GET_LOOP_PROG(array, start, false)
> +#define TASK_STORAGE_GET_LOOP_PROG_INT(array, start) \
> +       __TASK_STORAGE_GET_LOOP_PROG(array, start, true)

[...]

> +
> +TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 0);
> +TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 50);
> +TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 100);
> +TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 150);
> +TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 200);
> +TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 250);
> +TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 300);
> +TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 350);
> +TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 400);
> +TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 450);
> +TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 500);
> +TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 550);
> +TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 600);
> +TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 650);
> +TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 700);
> +TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 750);
> +TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 800);
> +TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 850);
> +TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 900);
> +TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 950);
> +

all these macro make me sad, I'd like to understand why it has to be
done this way

> +char _license[] SEC("license") = "GPL";
> --
> 2.30.2
>
