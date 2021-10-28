Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1793843E84F
	for <lists+bpf@lfdr.de>; Thu, 28 Oct 2021 20:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbhJ1S25 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Oct 2021 14:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbhJ1S24 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Oct 2021 14:28:56 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8D1C061570
        for <bpf@vger.kernel.org>; Thu, 28 Oct 2021 11:26:29 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id v138so12060962ybb.8
        for <bpf@vger.kernel.org>; Thu, 28 Oct 2021 11:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dsUp5nfRCBpwlRh0clmwN9Nf5SR8cet/sm+WCbNgozU=;
        b=nyAIqB9nuO0nps0PFqUiFJapBf/YC3Mqsm4FBWlrzcLjzbraKQpmpC1B2kTWi8sDsq
         fKzhtQktP2MJ+AHXUTLFcp+8qg/h3oYOP5oiTwTDzjwbN7tquNi0OQGt5xrsyj5TONtP
         /nI713+PGfdAGqqiykSIOrf5a60bOb84SAz6wSCHfwWXxnPjZAZlD7XV2haYgj0XmeCG
         xp/CNCbUscjESxs0lVzKpWUgJegqBELCc5Kw6UhL7rIfPTgUFzZ0lmYQ4W1jOLuVoqYG
         TZdmpdp6Rd2qMv8JjAUxSVSoPs0EKy0wlvEJLcFA+hB0rflvmuVwVkeYgpHHY45rXJ9Y
         rY/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dsUp5nfRCBpwlRh0clmwN9Nf5SR8cet/sm+WCbNgozU=;
        b=Tz0XAs5VQE9uPRejgqZqrE/7tf9hk60GmOKUTZV2bi6V5g4D7JA2sAQXhU7r17bwD3
         haeVUp3DfFUbzISZeG73WxS1hS9JZK1FL5g8fBwXtmFZeeflg6Pcd3Q+Vp/kCLSmtYva
         HlvbXiHFNNgsclMqutxz0iwPUlAuLisz3DqXpWU8lTrOnqVaChKFplUDEIfGu7xFzcq5
         ppWe2v9XKmIiAepMXtNlOupQJVlVwTku/AvlN45YBJ1LplJMNBMFdP50UDFg7qJMhlKn
         GCEcFdHSXCEbD0DEnV2t8XHEusNQuFyGwWd6aLXwQ8jlahLlPmx5Utv160tItjSlcc58
         SkEA==
X-Gm-Message-State: AOAM533G8ph80m3cFdlUmaZZIGACRL7rbL0wHaroFzs6DEL8D/DVgQay
        COdWC57FD7wBwWnuSj/n9ylJBF3n5wdWjYcphSs=
X-Google-Smtp-Source: ABdhPJyPquO6sWnMq6cXs2JOPlLcBRQu+fA5mZCOoMIBDp8wpibHtuMTosQMeeYS6PcEWXLZGwNZwLNdDDie6dIW0GA=
X-Received: by 2002:a25:afcf:: with SMTP id d15mr5573679ybj.433.1635445588691;
 Thu, 28 Oct 2021 11:26:28 -0700 (PDT)
MIME-Version: 1.0
References: <20211027234504.30744-1-joannekoong@fb.com> <20211027234504.30744-5-joannekoong@fb.com>
In-Reply-To: <20211027234504.30744-5-joannekoong@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 28 Oct 2021 11:26:17 -0700
Message-ID: <CAEf4BzZFZTt5eOC7VW9UyWkN=EdgOH6uZxODDch8GZmGAibfWg@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 4/5] bpf/benchs: Add benchmark tests for bloom
 filter throughput + false positive
To:     Joanne Koong <joannekoong@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Kernel Team <Kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 27, 2021 at 4:45 PM Joanne Koong <joannekoong@fb.com> wrote:
>
> This patch adds benchmark tests for the throughput (for lookups + updates)
> and the false positive rate of bloom filter lookups, as well as some
> minor refactoring of the bash script for running the benchmarks.
>
> These benchmarks show that as the number of hash functions increases,
> the throughput and the false positive rate of the bloom filter decreases.
> From the benchmark data, the approximate average false-positive rates
> are roughly as follows:
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
> For reference data, the benchmarks run on one thread on a machine
> with one numa node for 1 to 5 hash functions for 8-byte and 64-byte
> values are as follows:
>
> 1 hash function:
>   50k entries
>         8-byte value
>             Lookups - 51.1 M/s operations
>             Updates - 33.6 M/s operations
>             False positive rate: 24.15%
>         64-byte value
>             Lookups - 15.7 M/s operations
>             Updates - 15.1 M/s operations
>             False positive rate: 24.2%
>   100k entries
>         8-byte value
>             Lookups - 51.0 M/s operations
>             Updates - 33.4 M/s operations
>             False positive rate: 24.04%
>         64-byte value
>             Lookups - 15.6 M/s operations
>             Updates - 14.6 M/s operations
>             False positive rate: 24.06%
>   500k entries
>         8-byte value
>             Lookups - 50.5 M/s operations
>             Updates - 33.1 M/s operations
>             False positive rate: 27.45%
>         64-byte value
>             Lookups - 15.6 M/s operations
>             Updates - 14.2 M/s operations
>             False positive rate: 27.42%
>   1 mil entries
>         8-byte value
>             Lookups - 49.7 M/s operations
>             Updates - 32.9 M/s operations
>             False positive rate: 27.45%
>         64-byte value
>             Lookups - 15.4 M/s operations
>             Updates - 13.7 M/s operations
>             False positive rate: 27.58%
>   2.5 mil entries
>         8-byte value
>             Lookups - 47.2 M/s operations
>             Updates - 31.8 M/s operations
>             False positive rate: 30.94%
>         64-byte value
>             Lookups - 15.3 M/s operations
>             Updates - 13.2 M/s operations
>             False positive rate: 30.95%
>   5 mil entries
>         8-byte value
>             Lookups - 41.1 M/s operations
>             Updates - 28.1 M/s operations
>             False positive rate: 31.01%
>         64-byte value
>             Lookups - 13.3 M/s operations
>             Updates - 11.4 M/s operations
>             False positive rate: 30.98%
>
> 2 hash functions:
>   50k entries
>         8-byte value
>             Lookups - 34.1 M/s operations
>             Updates - 20.1 M/s operations
>             False positive rate: 9.13%
>         64-byte value
>             Lookups - 8.4 M/s operations
>             Updates - 7.9 M/s operations
>             False positive rate: 9.21%
>   100k entries
>         8-byte value
>             Lookups - 33.7 M/s operations
>             Updates - 18.9 M/s operations
>             False positive rate: 9.13%
>         64-byte value
>             Lookups - 8.4 M/s operations
>             Updates - 7.7 M/s operations
>             False positive rate: 9.19%
>   500k entries
>         8-byte value
>             Lookups - 32.7 M/s operations
>             Updates - 18.1 M/s operations
>             False positive rate: 12.61%
>         64-byte value
>             Lookups - 8.4 M/s operations
>             Updates - 7.5 M/s operations
>             False positive rate: 12.61%
>   1 mil entries
>         8-byte value
>             Lookups - 30.6 M/s operations
>             Updates - 18.9 M/s operations
>             False positive rate: 12.54%
>         64-byte value
>             Lookups - 8.0 M/s operations
>             Updates - 7.0 M/s operations
>             False positive rate: 12.52%
>   2.5 mil entries
>         8-byte value
>             Lookups - 25.3 M/s operations
>             Updates - 16.7 M/s operations
>             False positive rate: 16.77%
>         64-byte value
>             Lookups - 7.9 M/s operations
>             Updates - 6.5 M/s operations
>             False positive rate: 16.88%
>   5 mil entries
>         8-byte value
>             Lookups - 20.8 M/s operations
>             Updates - 14.7 M/s operations
>             False positive rate: 16.78%
>         64-byte value
>             Lookups - 7.0 M/s operations
>             Updates - 6.0 M/s operations
>             False positive rate: 16.78%
>
> 3 hash functions:
>   50k entries
>         8-byte value
>             Lookups - 25.1 M/s operations
>             Updates - 14.6 M/s operations
>             False positive rate: 7.65%
>         64-byte value
>             Lookups - 5.8 M/s operations
>             Updates - 5.5 M/s operations
>             False positive rate: 7.58%
>   100k entries
>         8-byte value
>             Lookups - 24.7 M/s operations
>             Updates - 14.1 M/s operations
>             False positive rate: 7.71%
>         64-byte value
>             Lookups - 5.8 M/s operations
>             Updates - 5.3 M/s operations
>             False positive rate: 7.62%
>   500k entries
>         8-byte value
>             Lookups - 22.9 M/s operations
>             Updates - 13.9 M/s operations
>             False positive rate: 2.62%
>         64-byte value
>             Lookups - 5.6 M/s operations
>             Updates - 4.8 M/s operations
>             False positive rate: 2.7%
>   1 mil entries
>         8-byte value
>             Lookups - 19.8 M/s operations
>             Updates - 12.6 M/s operations
>             False positive rate: 2.60%
>         64-byte value
>             Lookups - 5.3 M/s operations
>             Updates - 4.4 M/s operations
>             False positive rate: 2.69%
>   2.5 mil entries
>         8-byte value
>             Lookups - 16.2 M/s operations
>             Updates - 10.7 M/s operations
>             False positive rate: 4.49%
>         64-byte value
>             Lookups - 4.9 M/s operations
>             Updates - 4.1 M/s operations
>             False positive rate: 4.41%
>   5 mil entries
>         8-byte value
>             Lookups - 18.8 M/s operations
>             Updates - 9.2 M/s operations
>             False positive rate: 4.45%
>         64-byte value
>             Lookups - 5.2 M/s operations
>             Updates - 3.9 M/s operations
>             False positive rate: 4.54%
>
> 4 hash functions:
>   50k entries
>         8-byte value
>             Lookups - 19.7 M/s operations
>             Updates - 11.1 M/s operations
>             False positive rate: 1.01%
>         64-byte value
>             Lookups - 4.4 M/s operations
>             Updates - 4.0 M/s operations
>             False positive rate: 1.00%
>   100k entries
>         8-byte value
>             Lookups - 19.5 M/s operations
>             Updates - 10.9 M/s operations
>             False positive rate: 1.00%
>         64-byte value
>             Lookups - 4.3 M/s operations
>             Updates - 3.9 M/s operations
>             False positive rate: 0.97%
>   500k entries
>         8-byte value
>             Lookups - 18.2 M/s operations
>             Updates - 10.6 M/s operations
>             False positive rate: 2.05%
>         64-byte value
>             Lookups - 4.3 M/s operations
>             Updates - 3.7 M/s operations
>             False positive rate: 2.05%
>   1 mil entries
>         8-byte value
>             Lookups - 15.5 M/s operations
>             Updates - 9.6 M/s operations
>             False positive rate: 1.99%
>         64-byte value
>             Lookups - 4.0 M/s operations
>             Updates - 3.4 M/s operations
>             False positive rate: 1.99%
>   2.5 mil entries
>         8-byte value
>             Lookups - 13.8 M/s operations
>             Updates - 7.7 M/s operations
>             False positive rate: 3.91%
>         64-byte value
>             Lookups - 3.7 M/s operations
>             Updates - 3.6 M/s operations
>             False positive rate: 3.78%
>   5 mil entries
>         8-byte value
>             Lookups - 13.0 M/s operations
>             Updates - 6.9 M/s operations
>             False positive rate: 3.93%
>         64-byte value
>             Lookups - 3.5 M/s operations
>             Updates - 3.7 M/s operations
>             False positive rate: 3.39%
>
> 5 hash functions:
>   50k entries
>         8-byte value
>             Lookups - 16.4 M/s operations
>             Updates - 9.1 M/s operations
>             False positive rate: 0.78%
>         64-byte value
>             Lookups - 3.5 M/s operations
>             Updates - 3.2 M/s operations
>             False positive rate: 0.77%
>   100k entries
>         8-byte value
>             Lookups - 16.3 M/s operations
>             Updates - 9.0 M/s operations
>             False positive rate: 0.79%
>         64-byte value
>             Lookups - 3.5 M/s operations
>             Updates - 3.2 M/s operations
>             False positive rate: 0.78%
>   500k entries
>         8-byte value
>             Lookups - 15.1 M/s operations
>             Updates - 8.8 M/s operations
>             False positive rate: 1.82%
>         64-byte value
>             Lookups - 3.4 M/s operations
>             Updates - 3.0 M/s operations
>             False positive rate: 1.78%
>   1 mil entries
>         8-byte value
>             Lookups - 13.2 M/s operations
>             Updates - 7.8 M/s operations
>             False positive rate: 1.81%
>         64-byte value
>             Lookups - 3.2 M/s operations
>             Updates - 2.8 M/s operations
>             False positive rate: 1.80%
>   2.5 mil entries
>         8-byte value
>             Lookups - 10.5 M/s operations
>             Updates - 5.9 M/s operations
>             False positive rate: 0.29%
>         64-byte value
>             Lookups - 3.2 M/s operations
>             Updates - 2.4 M/s operations
>             False positive rate: 0.28%
>   5 mil entries
>         8-byte value
>             Lookups - 9.6 M/s operations
>             Updates - 5.7 M/s operations
>             False positive rate: 0.30%
>         64-byte value
>             Lookups - 3.2 M/s operations
>             Updates - 2.7 M/s operations
>             False positive rate: 0.30%
>
> Signed-off-by: Joanne Koong <joannekoong@fb.com>
> ---

LGTM.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  tools/testing/selftests/bpf/Makefile          |   6 +-
>  tools/testing/selftests/bpf/bench.c           |  37 ++
>  tools/testing/selftests/bpf/bench.h           |   3 +
>  .../bpf/benchs/bench_bloom_filter_map.c       | 420 ++++++++++++++++++
>  .../bpf/benchs/run_bench_bloom_filter_map.sh  |  28 ++
>  .../bpf/benchs/run_bench_ringbufs.sh          |  30 +-
>  .../selftests/bpf/benchs/run_common.sh        |  48 ++
>  .../selftests/bpf/progs/bloom_filter_bench.c  | 153 +++++++
>  8 files changed, 695 insertions(+), 30 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/benchs/bench_bloom_filter_map.c
>  create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_bloom_filter_map.sh
>  create mode 100644 tools/testing/selftests/bpf/benchs/run_common.sh
>  create mode 100644 tools/testing/selftests/bpf/progs/bloom_filter_bench.c
>

[...]
