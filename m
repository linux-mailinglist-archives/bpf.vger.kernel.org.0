Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3CF4276BF
	for <lists+bpf@lfdr.de>; Sat,  9 Oct 2021 04:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbhJIC4P (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Oct 2021 22:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbhJIC4P (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Oct 2021 22:56:15 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF2FC061570
        for <bpf@vger.kernel.org>; Fri,  8 Oct 2021 19:54:19 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id n65so24998899ybb.7
        for <bpf@vger.kernel.org>; Fri, 08 Oct 2021 19:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ocKjrYvb22HsIxuFHu/b++PGP1TjnE77U2wPvIjBMDM=;
        b=K5Og+Z9pBvxdUDClV1Dcf5A7RRLPuDogDZPeDmTJUh4t4oYSKEmoIOYm0TLs0MNl3R
         SX42mFo/a4aF4ozb1kApv5K1981tsreKUBWnqOXXF3WTQvJ8LGbVP+kgfF95PxJlDl+G
         lifssTN3x0QkrvwfiAGgMvoIbbptjV3h8Ch9qYF17J+KD3pnPiX75Y8zcX4nJUW2EfyP
         qPmEdmYV2/7TQ0+BMy0BCiIHBdBwoAhpSCbtSBUs5sunWCyOfblySKCgmH2bc6mWjyWh
         kSUs4o7JRxvw07fikmHj5sjKrYyDIwG/FvDLGv2WrAXuS1eg9l8cmormU3zH07GXV4Qp
         qd5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ocKjrYvb22HsIxuFHu/b++PGP1TjnE77U2wPvIjBMDM=;
        b=f9P20lzcV12bMXmhU3m2qzM+jG1hdGNAJci0WbwVO4/Okayy5H4BmvulsgzUhleoNj
         rycLqTb4N9sVtUMPOAyrKtG0A8cglch24wYJBp5X4OoAkq4e1Q80x8cSMT6MQfiIAsd0
         MKIUComVtK9NG5e0+CYg9BTcRf125rdb3mRCPAr6acNU06hyOc7ZXJKiNsJ2OaXJQnBh
         vCAM8HGOOW40ZQyGqLx96Yf9M/NHl4gpn6wVSmmtkGfxLHJ9cNg7u4Dz9YwQ1A0Zwab6
         hQo3o8JKTP5mYHWRQcCaDcko/MHNDszVXSU36TxC4Nn/fM3kgVC34qT1e+f3acQWmgmS
         uHFg==
X-Gm-Message-State: AOAM531iWW6jo+NxIIGKhoR7TKQNbLurdnQRB2Ucdql92+LSEgnNIGZ3
        m6jRCaPTKN5D3k36oxEW0znd7zyLlov8fIfUkbcxdBGllCM=
X-Google-Smtp-Source: ABdhPJzPYPdN0mxOa4zzWGk+nh69/4GCf2Xjpj/4eLh394aqAH24J31VSNmSe+yb1gUZ0fAOlj+4wh/6f9By7ZMcByY=
X-Received: by 2002:a25:e7d7:: with SMTP id e206mr7154420ybh.267.1633748058171;
 Fri, 08 Oct 2021 19:54:18 -0700 (PDT)
MIME-Version: 1.0
References: <20211006222103.3631981-1-joannekoong@fb.com> <20211006222103.3631981-5-joannekoong@fb.com>
 <9eb52022-2528-c2a8-62a8-25dfda4c0908@fb.com>
In-Reply-To: <9eb52022-2528-c2a8-62a8-25dfda4c0908@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 8 Oct 2021 19:54:05 -0700
Message-ID: <CAEf4Bzanj_rGR4Y1iQB=TLb8ud3m9_W6JEQx9sW=auFMV3QGRg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 4/5] bpf/benchs: Add benchmark tests for bloom
 filter throughput + false positive
To:     Joanne Koong <joannekoong@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Kernel Team <Kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 6, 2021 at 3:37 PM Joanne Koong <joannekoong@fb.com> wrote:
>
> On 10/6/21 3:21 PM, Joanne Koong wrote:
>
> > This patch adds benchmark tests for the throughput (for lookups + updates)
> > and the false positive rate of bloom filter lookups, as well as some
> > minor refactoring of the bash script for running the benchmarks.
> >
> > These benchmarks show that as the number of hash functions increases,
> > the throughput and the false positive rate of the bloom filter decreases.
> >  From the benchmark data, the approximate average false-positive rates for
> > 8-byte values are roughly as follows:
> >
> > 1 hash function = ~30%
> > 2 hash functions = ~15%
> > 3 hash functions = ~5%
> > 4 hash functions = ~2.5%
> > 5 hash functions = ~1%
> > 6 hash functions = ~0.5%
> > 7 hash functions  = ~0.35%
> > 8 hash functions = ~0.15%
> > 9 hash functions = ~0.1%
> > 10 hash functions = ~0%
> >
> > Signed-off-by: Joanne Koong <joannekoong@fb.com>
> > ---
> >   tools/testing/selftests/bpf/Makefile          |   6 +-
> >   tools/testing/selftests/bpf/bench.c           |  37 ++
> >   tools/testing/selftests/bpf/bench.h           |   3 +
> >   .../bpf/benchs/bench_bloom_filter_map.c       | 411 ++++++++++++++++++
> >   .../bpf/benchs/run_bench_bloom_filter_map.sh  |  28 ++
> >   .../bpf/benchs/run_bench_ringbufs.sh          |  30 +-
> >   .../selftests/bpf/benchs/run_common.sh        |  48 ++
> >   tools/testing/selftests/bpf/bpf_util.h        |  11 +
> >   .../selftests/bpf/progs/bloom_filter_bench.c  | 146 +++++++
> >   9 files changed, 690 insertions(+), 30 deletions(-)
> >   create mode 100644 tools/testing/selftests/bpf/benchs/bench_bloom_filter_map.c
> >   create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_bloom_filter_map.sh
> >   create mode 100644 tools/testing/selftests/bpf/benchs/run_common.sh
> >   create mode 100644 tools/testing/selftests/bpf/progs/bloom_filter_bench.c
> >

[...] (it's a good idea to trim irrelevant parts of email to make it
easier to see relevant parts)

> > +
> > +SEC("fentry/__x64_sys_getpgid")
> > +int prog_bloom_filter_hashmap_lookup(void *ctx)
> > +{
> > +     __u64 *result;
> > +     int i, j, err;
> > +
> > +     __u32 val[64] = {0};
> > +
> > +     for (i = 0; i < 1024; i++) {
> > +             for (j = 0; j < value_sz_nr_u32s && j < 64; j++)
> > +                     val[j] = bpf_get_prandom_u32();
> > +
> I tried out prepopulating these random values from the userspace side
> (where we generate a random sequence of 10000 bytes and put that
> in a bpf array map, then iterate through the bpf array map in the bpf
> program; when I tried implementing it using a global array, I saw
> verifier errors when indexing into the array).
>
> Additionally, this slows down the bench program as well, since we need
> to generate all of these random values in the setup() portion of the
> program.
> I'm not convinced that prepopulating the values ahead of time nets us
> anything - if the concern is that this slows down the bpf program,
> I think this slows down the program in both the hashmap with and without
> bloom filter cases; since we are mainly only interested in the delta between
> these two scenarios, I don't think this ends up mattering that much.

So imagine that a hashmap benchmark takes 10ms per iteration, and
bloom filter + hashmap takes 5ms. That's a 2x difference, right? Now
imagine that random values generation takes another 5ms, so actually
you measure 15ms vs 10ms run time. Now, suddenly, you have measured
just a 1.5x difference.

But it's ok, feel free to just keep the benchmark as is.

>
> > +             if (hashmap_use_bloom_filter) {
> > +                     err = bpf_map_peek_elem(&bloom_filter_map, val);
> > +                     if (err) {
> > +                             if (err != -ENOENT) {
> > +                                     error |= 3;
> > +                                     return 0;
> > +                             }
> > +                             log_result(hit_key);
> > +                             continue;
> > +                     }
> > +             }
> > +
> > +             result = bpf_map_lookup_elem(&hashmap, val);
> > +             if (result) {
> > +                     log_result(hit_key);
> > +             } else {
> > +                     if (hashmap_use_bloom_filter)
> > +                             log_result(false_hit_key);
> > +                     log_result(drop_key);
> > +             }
> > +     }
> > +
> > +     return 0;
> > +}
