Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB823FE812
	for <lists+bpf@lfdr.de>; Thu,  2 Sep 2021 05:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242298AbhIBDgX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Sep 2021 23:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242286AbhIBDgT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Sep 2021 23:36:19 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7974C061575
        for <bpf@vger.kernel.org>; Wed,  1 Sep 2021 20:35:21 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id f15so1128277ybg.3
        for <bpf@vger.kernel.org>; Wed, 01 Sep 2021 20:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PgnFPbDDG83RFPFDsw23MckfDOoP8cl5oZcZyHo1I5Y=;
        b=HPz9cP/LqBKUbePH/BMYqP1qo/DAXG+Tu9+1JKSh5b8zotMGIpk5PQWg1Ilpx683OQ
         iLz3ORc3La0goXDT9cLsTuEuh1h/lE0TEvpHmz4jIVM2pLoxeh8aQcB6PCuqmvmu5Jyd
         Tvcu6CdwdOuAH6JbKi8aMnxCcHdYSlR/ZvnkSE75HLtMIIosmUVmSCKcun2ACbWIW0/U
         5EMoG8XN3tYBO/viq6eSquNevtyPNGCGBp5sJjLlsvOSnTYgvY7l1q2XXqIkwN/vdg0s
         HXv6PWbuAxjMIBih5e0dVqdJEJeNjO+tZOlIEUdJuJM0j1CGVRhD8Xa6E8+fY7QUrnlm
         Dc/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PgnFPbDDG83RFPFDsw23MckfDOoP8cl5oZcZyHo1I5Y=;
        b=qCl+6XokvLOJw+6xMcjH6get/ZWlem+N9KkeJQRNkT3Iu0bkCGoQeZE6nrsjnV1X8+
         BHbmA4FuvulgjzdBL283znXzTuaI7cvVpaSfMGZhepf6VWrRTBEcdg6NTNesgwbb7a8J
         tPy8ZU+qvPh32UPp6ubqvZiV/30gpF6dRdy4+yVMrz0nLyhQlSNDhwzNa5ifU5CYjGhc
         yiAOgxfMdvdjtbIBCZJ86MBThcSTlDksLkUsIrSNIXILpoWbzeRXROkmx9QSiaMt7Yhe
         3yMwLDKtN7O20HuA2HNrNpuxmRiROq2aUtvSGBOsh08ts3qMQYb5C31gZgJ+Qr/394Tf
         9Rtw==
X-Gm-Message-State: AOAM531AoA+7LuvYXqjW7abhXTDPbIwfO0X/tsfyi0cLYRaD4lE/8wck
        LPcpOeavjCuxnp3bHZFdopp6opyqS9Xiz9pd7amRiuKQ
X-Google-Smtp-Source: ABdhPJxnPoAeA7Z1Yz3ocapV9/UalTTIo3DBL+cslMByMQJ/Zlx5FaNJkfpxsOTLlZQPpnBJnSvkIL0CBzecTCEogfs=
X-Received: by 2002:a25:ac7:: with SMTP id 190mr1658369ybk.260.1630553721014;
 Wed, 01 Sep 2021 20:35:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210831225005.2762202-1-joannekoong@fb.com> <20210831225005.2762202-5-joannekoong@fb.com>
In-Reply-To: <20210831225005.2762202-5-joannekoong@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 1 Sep 2021 20:35:10 -0700
Message-ID: <CAEf4BzbMAogriaief+EOhVXXbon2y=KmN_JaYcMk_LVj3tCk1w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/5] bpf/benchs: Add benchmark test for bloom
 filter maps
To:     Joanne Koong <joannekoong@fb.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 31, 2021 at 3:52 PM Joanne Koong <joannekoong@fb.com> wrote:
>
> This patch adds benchmark tests for the throughput and false positive
> rate of bloom filter map lookups for a given number of entries and a
> given number of hash functions.
>
> These benchmarks show that as the number of hash functions increases,
> the throughput and the false positive rate of the bloom filter map
> decreases. From the benchmark data, the approximate average
> false-positive rates are roughly as follows:
>
> 1 hash function = ~30%
> 2 hash functions = ~15%
> 3 hash functions = ~5%
> 4 hash functions = ~2.5%
> 5 hash functions = ~1%
> 6 hash functions = 0.5%
> 7 hash functions  = ~0.35%
> 8 hash functions = ~0.15%
> 9 hash functions = ~0.1%
> 10 hash functions = ~0%
>
> Signed-off-by: Joanne Koong <joannekoong@fb.com>
> ---
>  tools/testing/selftests/bpf/Makefile          |   4 +-
>  tools/testing/selftests/bpf/bench.c           |  35 ++
>  tools/testing/selftests/bpf/bench.h           |   3 +
>  .../bpf/benchs/bench_bloom_filter_map.c       | 344 ++++++++++++++++++
>  .../bpf/benchs/run_bench_bloom_filter_map.sh  |  28 ++
>  .../bpf/benchs/run_bench_ringbufs.sh          |  30 +-
>  .../selftests/bpf/benchs/run_common.sh        |  48 +++
>  .../selftests/bpf/progs/bloom_filter_map.c    |  74 ++++
>  8 files changed, 537 insertions(+), 29 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/benchs/bench_bloom_filter_map.c
>  create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_bloom_filter_map.sh
>  create mode 100644 tools/testing/selftests/bpf/benchs/run_common.sh
>

[...]

> diff --git a/tools/testing/selftests/bpf/progs/bloom_filter_map.c b/tools/testing/selftests/bpf/progs/bloom_filter_map.c
> index 2d9c43a30246..1b139689219e 100644
> --- a/tools/testing/selftests/bpf/progs/bloom_filter_map.c
> +++ b/tools/testing/selftests/bpf/progs/bloom_filter_map.c
> @@ -1,7 +1,9 @@
>  // SPDX-License-Identifier: GPL-3.0
>  /* Copyright (c) 2021 Facebook */
>
> +#include <errno.h>
>  #include <linux/bpf.h>
> +#include <stdbool.h>
>  #include <bpf/bpf_helpers.h>
>
>  char _license[] SEC("license") = "GPL";
> @@ -23,8 +25,38 @@ struct {
>         __uint(nr_hashes, 2);
>  } map_bloom_filter SEC(".maps");
>
> +/* Tracks the number of hits, drops, and false hits */
> +struct {
> +       __uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
> +       __uint(max_entries, 3);
> +       __type(key, __u32);
> +       __type(value, __u64);
> +} percpu_array SEC(".maps");
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_HASH);
> +       __uint(max_entries, 1000);
> +       __type(key, __u64);
> +       __type(value, __u64);
> +} hashmap SEC(".maps");
> +
> +const __u32 hit_key  = 0;
> +const __u32 drop_key  = 1;
> +const __u32 false_hit_key = 2;
> +
> +bool hashmap_use_bloom_filter = true;
> +
>  int error = 0;
>
> +static __always_inline void log_result(__u32 key)
> +{
> +       __u64 *count;
> +
> +       count = bpf_map_lookup_elem(&percpu_array, &key);
> +       if (count)
> +               *count += 1;

it will be actually more performant to have a global array with some
fixed number of elements (e.g., 256, to support up to 256 CPUs), one
for each CPU, instead of BPF_MAP_TYPE_PERCPU_ARRAY. Don't know how
much impact that has on benchmark, but doing one extra per-cpu map
lookup for each Bloom filter lookup might be a significant portion of
spent CPU.

> +}
> +
>  static __u64
>  check_elem(struct bpf_map *map, __u32 *key, __u64 *val,
>            void *data)
> @@ -37,6 +69,8 @@ check_elem(struct bpf_map *map, __u32 *key, __u64 *val,
>                 return 1; /* stop the iteration */
>         }
>
> +       log_result(hit_key);
> +
>         return 0;
>  }
>
> @@ -47,3 +81,43 @@ int prog_bloom_filter(void *ctx)
>
>         return 0;
>  }
> +
> +SEC("fentry/__x64_sys_getpgid")
> +int prog_bloom_filter_hashmap_lookup(void *ctx)
> +{
> +       __u64 *result;
> +       int i, err;
> +
> +       union {
> +               __u64 data64;
> +               __u32 data32[2];
> +       } val;
> +
> +       for (i = 0; i < 512; i++) {
> +               val.data32[0] = bpf_get_prandom_u32();
> +               val.data32[1] = bpf_get_prandom_u32();
> +
> +               if (hashmap_use_bloom_filter) {
> +                       err = bpf_map_peek_elem(&map_bloom_filter, &val);
> +                       if (err) {
> +                               if (err != -ENOENT) {
> +                                       error |= 2;
> +                                       return 0;
> +                               }
> +                               log_result(drop_key);
> +                               continue;
> +                       }
> +               }
> +
> +               result = bpf_map_lookup_elem(&hashmap, &val);
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
