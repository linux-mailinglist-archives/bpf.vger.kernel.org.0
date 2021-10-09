Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B42394276B3
	for <lists+bpf@lfdr.de>; Sat,  9 Oct 2021 04:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232321AbhJIClt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Oct 2021 22:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbhJIClt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Oct 2021 22:41:49 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24078C061570
        for <bpf@vger.kernel.org>; Fri,  8 Oct 2021 19:39:53 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id a7so24997128yba.6
        for <bpf@vger.kernel.org>; Fri, 08 Oct 2021 19:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nUkZuK1BMfQuUaypVZX2vqM9+rDyJiUOGv2Kp6ZiWic=;
        b=axczh4K2wNP/ujc4mYZVf4YeJ75wbkavq5dObKhGOiGyIkhwuevchVBWnyoconG5wb
         Z8ykIK5UF8RFCesPibL0lDkvdvBZtYMp28qohCfWpn+6epX66YQX/+nD7TA0Fv4ekIFq
         NZVWZ5IPa4UNsL1T9zowhXn1AUXdJSgLxtiJ3rtql0iJGRnEdce47S6AskOYbbvp1uXV
         0clbRlCkT03dj/i4DEutQkgRm7d+lmWHNZ+mt5uhCuKUnkBS+/4XUbGnefnApSW/Gzqw
         sP9qhAmcdVDKluwCsusNqO00Tegu/2J4gK9B5X7eXyb+MSrymPBvKriX81MFNl1yDzQL
         tvEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nUkZuK1BMfQuUaypVZX2vqM9+rDyJiUOGv2Kp6ZiWic=;
        b=LGfWWddJrdFcnUmU9gNnHDN5/xtpez/Lg2v3y6VI+xfIIR9A/0XYo71/blYchZ27kU
         0+r5CS/BcTmjnD/IyJeErJm54gUlIE5pTmx2zj6fxc3IDFDL1jKsvFVT2d1T60wy53op
         GbICWSKe5zmskkq0jTbpNK06ikTA73uMVXcj6bbyETg/3WmKZ7CN5nmi6Qr4eqhdtKEO
         3zLRA5eRI0fytBE5b/0OwDrSIlp9kkfm6GfN6vn725zMuNuiVmFbSPtFVOt8lfeCgluf
         FfE5vfOJYxdTnrMWlar74M2tM5R1pZoF0mFZHOu4F7g6qgg9Hr6H7LDLahZn43cSfwHu
         LyPw==
X-Gm-Message-State: AOAM533KflapB1iLBbqbn9tx3rUH7HedcNRHcemYKvasV+iT/dJS8Z38
        AwNeH4HD8hd5I+3Dqa99eOuEqzdBo7MGq2Pe0Ws=
X-Google-Smtp-Source: ABdhPJxhEE7FdoU1nBKd7F/ooWpML1h3s+qLdyWXRo6vRKq52Rf1oGaih8s09rOS9iI0foW5h33ohSUWCqmOiYX7KGc=
X-Received: by 2002:a25:24c1:: with SMTP id k184mr7540681ybk.2.1633747192189;
 Fri, 08 Oct 2021 19:39:52 -0700 (PDT)
MIME-Version: 1.0
References: <20211006222103.3631981-1-joannekoong@fb.com> <20211006222103.3631981-5-joannekoong@fb.com>
In-Reply-To: <20211006222103.3631981-5-joannekoong@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 8 Oct 2021 19:39:39 -0700
Message-ID: <CAEf4BzYZLABqsGH-Qy7-3M_VVuy-t+5FS589+Syftw4zNXdmEA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 4/5] bpf/benchs: Add benchmark tests for bloom
 filter throughput + false positive
To:     Joanne Koong <joannekoong@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Kernel Team <Kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 6, 2021 at 3:27 PM Joanne Koong <joannekoong@fb.com> wrote:
>
> This patch adds benchmark tests for the throughput (for lookups + updates)
> and the false positive rate of bloom filter lookups, as well as some
> minor refactoring of the bash script for running the benchmarks.
>
> These benchmarks show that as the number of hash functions increases,
> the throughput and the false positive rate of the bloom filter decreases.
> From the benchmark data, the approximate average false-positive rates for
> 8-byte values are roughly as follows:
>
> 1 hash function = ~30%
> 2 hash functions = ~15%
> 3 hash functions = ~5%
> 4 hash functions = ~2.5%
> 5 hash functions = ~1%
> 6 hash functions = ~0.5%
> 7 hash functions  = ~0.35%
> 8 hash functions = ~0.15%
> 9 hash functions = ~0.1%
> 10 hash functions = ~0%
>
> Signed-off-by: Joanne Koong <joannekoong@fb.com>
> ---
>  tools/testing/selftests/bpf/Makefile          |   6 +-
>  tools/testing/selftests/bpf/bench.c           |  37 ++
>  tools/testing/selftests/bpf/bench.h           |   3 +
>  .../bpf/benchs/bench_bloom_filter_map.c       | 411 ++++++++++++++++++
>  .../bpf/benchs/run_bench_bloom_filter_map.sh  |  28 ++
>  .../bpf/benchs/run_bench_ringbufs.sh          |  30 +-
>  .../selftests/bpf/benchs/run_common.sh        |  48 ++
>  tools/testing/selftests/bpf/bpf_util.h        |  11 +
>  .../selftests/bpf/progs/bloom_filter_bench.c  | 146 +++++++
>  9 files changed, 690 insertions(+), 30 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/benchs/bench_bloom_filter_map.c
>  create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_bloom_filter_map.sh
>  create mode 100644 tools/testing/selftests/bpf/benchs/run_common.sh
>  create mode 100644 tools/testing/selftests/bpf/progs/bloom_filter_bench.c
>

[...]

> +static struct ctx {
> +       struct bloom_filter_bench *skel;
> +
> +       int bloom_filter_fd;
> +       int hashmap_fd;
> +       int array_map_fd;
> +
> +       pthread_mutex_t map_done_mtx;
> +       pthread_cond_t map_done;
> +       bool map_prepare_err;
> +
> +       __u32 next_map_idx;
> +

nit: unnecessary empty line

> +} ctx = {
> +       .map_done_mtx = PTHREAD_MUTEX_INITIALIZER,
> +       .map_done = PTHREAD_COND_INITIALIZER,
> +};
> +

[...]

> +
> +static void populate_maps(void)
> +{
> +       unsigned int nr_cpus = bpf_num_possible_cpus();
> +       pthread_t map_thread;
> +       int i, err;
> +
> +       ctx.bloom_filter_fd = bpf_map__fd(ctx.skel->maps.bloom_filter_map);
> +       ctx.hashmap_fd = bpf_map__fd(ctx.skel->maps.hashmap);
> +       ctx.array_map_fd = bpf_map__fd(ctx.skel->maps.array_map);
> +
> +       for (i = 0; i < nr_cpus; i++) {
> +               err = pthread_create(&map_thread, NULL, map_prepare_thread,
> +                                    NULL);
> +               if (err) {
> +                       fprintf(stderr, "failed to create pthread: %d\n", -errno);
> +                       exit(1);
> +               }
> +       }
> +
> +       pthread_mutex_lock(&ctx.map_done_mtx);
> +       pthread_cond_wait(&ctx.map_done, &ctx.map_done_mtx);

This is a fragile way to use cond_wait. If prepare finishes faster
than you get to this cond_wait, you'll be stuck forevere. Also
cond_var can spuriously wake up, if I remember correctly. So the
pattern is usually to do
checking of some condition in a loop  (inside the locked region) and
if the condition doesn't hold, cond_wait on it (I renamed ctx.map_done
into ctx.map_done_cv):

pthread_mutex_lock(&ctx.map_done_mtx);
while (!ctx.map_done /* this is bool now */)
    pthread_cond_wait(&ctx.map_done_cv, &ctx.map_done_mtx);
pthread_mutex_unlock(&ctx.map_done_mtx);


> +       pthread_mutex_unlock(&ctx.map_done_mtx);
> +
> +       if (ctx.map_prepare_err)
> +               exit(1);
> +}
> +
> +static struct bloom_filter_bench *setup_skeleton(bool hashmap_use_bloom_filter)
> +{
> +       struct bloom_filter_bench *skel;
> +       int err;
> +
> +       setup_libbpf();
> +
> +       skel = bloom_filter_bench__open();
> +       if (!skel) {
> +               fprintf(stderr, "failed to open skeleton\n");
> +               exit(1);
> +       }
> +
> +       skel->rodata->hashmap_use_bloom_filter = hashmap_use_bloom_filter;
> +
> +       /* Resize number of entries */
> +       err = bpf_map__resize(skel->maps.hashmap, args.nr_entries);
> +       if (err) {

These errors can't happen unless args.nr_entries is zero, so I'd just
drop them. But please use bpf_map__set_max_entries() instead,
bpf_map__resize() is going to be deprecated.

> +               fprintf(stderr, "failed to resize hashmap\n");
> +               exit(1);
> +       }
> +
> +       err = bpf_map__resize(skel->maps.array_map, args.nr_entries);
> +       if (err) {
> +               fprintf(stderr, "failed to resize array map\n");
> +               exit(1);
> +       }
> +
> +       err = bpf_map__resize(skel->maps.bloom_filter_map,
> +                             BPF_BLOOM_FILTER_BITSET_SZ(args.nr_entries,
> +                                                        args.nr_hash_funcs));
> +       if (err) {
> +               fprintf(stderr, "failed to resize bloom filter\n");
> +               exit(1);
> +       }
> +
> +       /* Set value size */
> +       err = bpf_map__set_value_size(skel->maps.array_map, args.value_size);
> +       if (err) {

same here, error can only happen if the map is already created in the
kernel, so be pragmatic and skip that (especially in benchmarks)

> +               fprintf(stderr, "failed to set array map value size\n");
> +               exit(1);
> +       }
> +
> +       err = bpf_map__set_value_size(skel->maps.bloom_filter_map, args.value_size);
> +       if (err) {
> +               fprintf(stderr, "failed to set bloom filter map value size\n");
> +               exit(1);
> +       }
> +

[...]

> diff --git a/tools/testing/selftests/bpf/bpf_util.h b/tools/testing/selftests/bpf/bpf_util.h
> index a3352a64c067..a260a963efda 100644
> --- a/tools/testing/selftests/bpf/bpf_util.h
> +++ b/tools/testing/selftests/bpf/bpf_util.h
> @@ -40,4 +40,15 @@ static inline unsigned int bpf_num_possible_cpus(void)
>         (offsetof(TYPE, MEMBER) + sizeof_field(TYPE, MEMBER))
>  #endif
>
> +/* Helper macro for computing the optimal number of bits for a
> + * bloom filter map.
> + *
> + * Mathematically, the optimal bitset size that minimizes the
> + * false positive probability is n * k / ln(2) where n is the expected
> + * number of unique entries in the bloom filter and k is the number of
> + * hash functions. We use 7 / 5 to approximate 1 / ln(2).
> + */
> +#define BPF_BLOOM_FILTER_BITSET_SZ(nr_uniq_entries, nr_hash_funcs) \
> +       ((nr_uniq_entries) * (nr_hash_funcs) / 5 * 7)

hm.. I thought you were going to add into include/linux/uapi/bpf.h,
why did you change your mind?

> +
>  #endif /* __BPF_UTIL__ */
> diff --git a/tools/testing/selftests/bpf/progs/bloom_filter_bench.c b/tools/testing/selftests/bpf/progs/bloom_filter_bench.c
> new file mode 100644
> index 000000000000..a44a47ddc4d7
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/bloom_filter_bench.c
> @@ -0,0 +1,146 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2021 Facebook */
> +
> +#include <errno.h>
> +#include <linux/bpf.h>
> +#include <stdbool.h>
> +#include <bpf/bpf_helpers.h>
> +
> +char _license[] SEC("license") = "GPL";
> +
> +struct bpf_map;
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_ARRAY);
> +       __uint(key_size, sizeof(__u32));
> +       /* max entries and value_size will be set programmatically.
> +        * They are configurable from the userspace bench program.
> +        */
> +} array_map SEC(".maps");
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_BITSET);
> +       /* max entries,  value_size, and # of hash functions will be set
> +        * programmatically. They are configurable from the userspace
> +        * bench program.
> +        */
> +} bloom_filter_map SEC(".maps");
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_HASH);
> +       /* max entries, key_size, and value_size, will be set
> +        * programmatically. They are configurable from the userspace
> +        * bench program.
> +        */
> +} hashmap SEC(".maps");
> +
> +struct callback_ctx {
> +       struct bpf_map *map;
> +       bool update;
> +};
> +
> +/* Tracks the number of hits, drops, and false hits */
> +struct {
> +       __u32 stats[3];
> +} __attribute__((__aligned__(256))) percpu_stats[256];
> +
> +__u8 value_sz_nr_u32s;
> +
> +const __u32 hit_key  = 0;
> +const __u32 drop_key  = 1;
> +const __u32 false_hit_key = 2;
> +
> +const volatile bool hashmap_use_bloom_filter = true;
> +
> +int error = 0;
> +
> +static __always_inline void log_result(__u32 key)
> +{
> +       __u32 cpu = bpf_get_smp_processor_id();
> +
> +       percpu_stats[cpu & 255].stats[key]++;
> +}
> +
> +static __u64
> +bloom_filter_callback(struct bpf_map *map, __u32 *key, void *val,
> +                     struct callback_ctx *data)
> +{
> +       int err;
> +
> +       if (data->update)
> +               err = bpf_map_push_elem(data->map, val, 0);
> +       else
> +               err = bpf_map_peek_elem(data->map, val);
> +
> +       if (err) {
> +               error |= 1;
> +               return 1; /* stop the iteration */
> +       }
> +
> +       log_result(hit_key);
> +
> +       return 0;
> +}
> +
> +SEC("fentry/__x64_sys_getpgid")
> +int prog_bloom_filter_lookup(void *ctx)
> +{
> +       struct callback_ctx data;
> +
> +       data.map = (struct bpf_map *)&bloom_filter_map;
> +       data.update = false;
> +
> +       bpf_for_each_map_elem(&array_map, bloom_filter_callback, &data, 0);
> +
> +       return 0;
> +}
> +
> +SEC("fentry/__x64_sys_getpgid")
> +int prog_bloom_filter_update(void *ctx)
> +{
> +       struct callback_ctx data;
> +
> +       data.map = (struct bpf_map *)&bloom_filter_map;
> +       data.update = true;
> +
> +       bpf_for_each_map_elem(&array_map, bloom_filter_callback, &data, 0);
> +
> +       return 0;
> +}
> +
> +SEC("fentry/__x64_sys_getpgid")
> +int prog_bloom_filter_hashmap_lookup(void *ctx)
> +{
> +       __u64 *result;
> +       int i, j, err;
> +
> +       __u32 val[64] = {0};
> +
> +       for (i = 0; i < 1024; i++) {
> +               for (j = 0; j < value_sz_nr_u32s && j < 64; j++)
> +                       val[j] = bpf_get_prandom_u32();
> +
> +               if (hashmap_use_bloom_filter) {

this is purely subjective, so take it for what it is worth. Using full
"bloom_filter" everywhere is a bit mouthful and causes unnecessarily
long identifiers. I think "bloom" itself is very recognizable and
doesn't detract from readability (I'd claim it actually improves it).
When using a bench tool manually, having to type "bloom-filter-update"
if the equivalent "bloom-update" is just as good, would get old pretty
fast for me.

Similarly program names above, why "prog_" prefix? What does it
contribute except causes longer identifiers in skeleton?

> +                       err = bpf_map_peek_elem(&bloom_filter_map, val);
> +                       if (err) {
> +                               if (err != -ENOENT) {
> +                                       error |= 3;
> +                                       return 0;
> +                               }
> +                               log_result(hit_key);
> +                               continue;
> +                       }
> +               }
> +
> +               result = bpf_map_lookup_elem(&hashmap, val);
> +               if (result) {
> +                       log_result(hit_key);
> +               } else {
> +                       if (hashmap_use_bloom_filter)
> +                               log_result(false_hit_key);
> +                       log_result(drop_key);
> +               }
> +       }
> +
> +       return 0;
> +}
> --
> 2.30.2
>
