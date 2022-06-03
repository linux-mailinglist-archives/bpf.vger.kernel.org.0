Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E5253D32E
	for <lists+bpf@lfdr.de>; Fri,  3 Jun 2022 23:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346785AbiFCV01 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Jun 2022 17:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346661AbiFCV00 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Jun 2022 17:26:26 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F7730F52
        for <bpf@vger.kernel.org>; Fri,  3 Jun 2022 14:26:24 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id a2so8389017lfg.5
        for <bpf@vger.kernel.org>; Fri, 03 Jun 2022 14:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eiikkDr/lWC7ee92TE+9gY2LOBZUmRfqeXGAN/+Pwq8=;
        b=BsvVuHFXDZLcetnawB+fv/PpSD7QV/czAhqgYzvRrpL5d8LK6v8EdZpPwWtYGgxylH
         qIw3qF21EzPkc6acImE8vp0ncMA7tsfSVj6vOTas/5jr+W1WTZGhKKZ3aiJON15FApNw
         GTt843AypISkXjcIzTVJcSiwonNRO5kjZ9sh4G3F4i6MZpnVn+aMgDzValvTxuCkGhVp
         3qbud0K3r9PG+r0ODreeMkpMsTiU3TS9+ZJUXJ0m4uM19jIYZuMkt82iUqrMauIITJiX
         P2cAe3uyqxDohB1gHoLridqqwZiQ1J2x1DXutMrkE67vq58OPYOAcWGou1p3HV2sx18+
         oftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eiikkDr/lWC7ee92TE+9gY2LOBZUmRfqeXGAN/+Pwq8=;
        b=2hXH3EsjQw9aCSBBXPLQ0WPybuEukBW1QFGaRTRnaih9Rj/tbzXtyRyzvpSHDX9uyM
         A6ML47iuA/WY1JWL1T+Dzn8K020qmLZeuJ1rOOPBqy2W01XX1kgqmAXulsfS/kEBFJP0
         1+HF9XD7St0KU0Ji6tGckv4Rtb/kEYwXlT8f7Ksjnh69DE/DbCwLWU4th/B5/9WuPWDV
         NjZaXp1sUbi2O7Ro330IO+VKlB6z+tyFCpSPfdl0U2L2Fcvs6Hs4oPbzcCkNRtQU7xWw
         qMkVIePdADpUl/xTxcJkhaeSAVNxrtDzdZraV2FCsRzWlblrBtwJT9zDU5osoOonKYbC
         FrFA==
X-Gm-Message-State: AOAM530QzyN8yHMzLKmNmCe4gKCJrH+tJ8Iqz9FshJAMO2cy2LH14pxC
        82pST63zgV2UMyPMqgO1E+t3pSvVBqIJpOnQbkA=
X-Google-Smtp-Source: ABdhPJxzeR05rdcW2DVysZ4P2SIQDVJdl/IbxS/X/GCoopDmWicqYfZPaVn+ghx4+4oRaND5zzkwWygOZL8XxZU4m+A=
X-Received: by 2002:ac2:4e88:0:b0:477:c186:6e83 with SMTP id
 o8-20020ac24e88000000b00477c1866e83mr53583645lfr.663.1654291582721; Fri, 03
 Jun 2022 14:26:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220530202711.2594486-1-davemarchevsky@fb.com>
In-Reply-To: <20220530202711.2594486-1-davemarchevsky@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 3 Jun 2022 14:26:10 -0700
Message-ID: <CAEf4BzZihqda7cdSCwbF5fwZPSFevNGHc3+76n+=49NWWgqtEQ@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 1/2] selftests/bpf: Add benchmark for
 local_storage get
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, May 30, 2022 at 1:27 PM Dave Marchevsky <davemarchevsky@fb.com> wro=
te:
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
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>         Hashmap Control w/ 500 maps
> hashmap (control) sequential    get:  hits throughput: 48.338 =C2=B1 2.36=
6 M ops/s, hits latency: 20.688 ns/op, important_hits throughput: 0.097 =C2=
=B1 0.005 M ops/s
>
>         num_maps: 1
> local_storage cache sequential  get:  hits throughput: 44.503 =C2=B1 1.08=
0 M ops/s, hits latency: 22.470 ns/op, important_hits throughput: 44.503 =
=C2=B1 1.080 M ops/s
> local_storage cache interleaved get:  hits throughput: 54.963 =C2=B1 0.58=
6 M ops/s, hits latency: 18.194 ns/op, important_hits throughput: 54.963 =
=C2=B1 0.586 M ops/s
>
>         num_maps: 10
> local_storage cache sequential  get:  hits throughput: 43.743 =C2=B1 0.41=
8 M ops/s, hits latency: 22.861 ns/op, important_hits throughput: 4.374 =C2=
=B1 0.042 M ops/s
> local_storage cache interleaved get:  hits throughput: 50.073 =C2=B1 0.60=
9 M ops/s, hits latency: 19.971 ns/op, important_hits throughput: 17.883 =
=C2=B1 0.217 M ops/s
>
>         num_maps: 16
> local_storage cache sequential  get:  hits throughput: 43.962 =C2=B1 0.52=
5 M ops/s, hits latency: 22.747 ns/op, important_hits throughput: 2.748 =C2=
=B1 0.033 M ops/s
> local_storage cache interleaved get:  hits throughput: 48.166 =C2=B1 0.82=
5 M ops/s, hits latency: 20.761 ns/op, important_hits throughput: 15.326 =
=C2=B1 0.263 M ops/s
>
>         num_maps: 17
> local_storage cache sequential  get:  hits throughput: 33.207 =C2=B1 0.46=
1 M ops/s, hits latency: 30.114 ns/op, important_hits throughput: 1.956 =C2=
=B1 0.027 M ops/s
> local_storage cache interleaved get:  hits throughput: 43.540 =C2=B1 0.26=
5 M ops/s, hits latency: 22.968 ns/op, important_hits throughput: 13.255 =
=C2=B1 0.081 M ops/s
>
>         num_maps: 24
> local_storage cache sequential  get:  hits throughput: 19.402 =C2=B1 0.34=
8 M ops/s, hits latency: 51.542 ns/op, important_hits throughput: 0.809 =C2=
=B1 0.015 M ops/s
> local_storage cache interleaved get:  hits throughput: 22.981 =C2=B1 0.48=
7 M ops/s, hits latency: 43.514 ns/op, important_hits throughput: 6.465 =C2=
=B1 0.137 M ops/s
>
>         num_maps: 32
> local_storage cache sequential  get:  hits throughput: 13.378 =C2=B1 0.22=
0 M ops/s, hits latency: 74.748 ns/op, important_hits throughput: 0.419 =C2=
=B1 0.007 M ops/s
> local_storage cache interleaved get:  hits throughput: 16.894 =C2=B1 0.17=
2 M ops/s, hits latency: 59.193 ns/op, important_hits throughput: 4.716 =C2=
=B1 0.048 M ops/s
>
>         num_maps: 100
> local_storage cache sequential  get:  hits throughput: 6.070 =C2=B1 0.140=
 M ops/s, hits latency: 164.745 ns/op, important_hits throughput: 0.061 =C2=
=B1 0.001 M ops/s
> local_storage cache interleaved get:  hits throughput: 7.323 =C2=B1 0.149=
 M ops/s, hits latency: 136.554 ns/op, important_hits throughput: 1.913 =C2=
=B1 0.039 M ops/s
>
>         num_maps: 1000
> local_storage cache sequential  get:  hits throughput: 0.438 =C2=B1 0.012=
 M ops/s, hits latency: 2281.369 ns/op, important_hits throughput: 0.000 =
=C2=B1 0.000 M ops/s
> local_storage cache interleaved get:  hits throughput: 0.522 =C2=B1 0.010=
 M ops/s, hits latency: 1913.937 ns/op, important_hits throughput: 0.131 =
=C2=B1 0.003 M ops/s
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
> To get a sense of the overhead of the benchmark program, I
> commented out bpf_task_storage_get/bpf_map_lookup_elem in
> local_storage_bench.c and ran the benchmark on the same host as the
> 'real' run. Results:
>
> Local Storage
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>         Hashmap Control w/ 500 maps
> hashmap (control) sequential    get:  hits throughput: 96.965 =C2=B1 1.34=
6 M ops/s, hits latency: 10.313 ns/op, important_hits throughput: 0.194 =C2=
=B1 0.003 M ops/s
>
>         num_maps: 1
> local_storage cache sequential  get:  hits throughput: 105.792 =C2=B1 1.8=
60 M ops/s, hits latency: 9.453 ns/op, important_hits throughput: 105.792 =
=C2=B1 1.860 M ops/s
> local_storage cache interleaved get:  hits throughput: 185.847 =C2=B1 4.0=
14 M ops/s, hits latency: 5.381 ns/op, important_hits throughput: 185.847 =
=C2=B1 4.014 M ops/s
>
>         num_maps: 10
> local_storage cache sequential  get:  hits throughput: 109.867 =C2=B1 1.3=
58 M ops/s, hits latency: 9.102 ns/op, important_hits throughput: 10.987 =
=C2=B1 0.136 M ops/s
> local_storage cache interleaved get:  hits throughput: 144.165 =C2=B1 1.2=
56 M ops/s, hits latency: 6.936 ns/op, important_hits throughput: 51.487 =
=C2=B1 0.449 M ops/s
>
>         num_maps: 16
> local_storage cache sequential  get:  hits throughput: 109.258 =C2=B1 1.9=
02 M ops/s, hits latency: 9.153 ns/op, important_hits throughput: 6.829 =C2=
=B1 0.119 M ops/s
> local_storage cache interleaved get:  hits throughput: 140.248 =C2=B1 1.8=
36 M ops/s, hits latency: 7.130 ns/op, important_hits throughput: 44.624 =
=C2=B1 0.584 M ops/s
>
>         num_maps: 17
> local_storage cache sequential  get:  hits throughput: 116.397 =C2=B1 7.6=
79 M ops/s, hits latency: 8.591 ns/op, important_hits throughput: 6.856 =C2=
=B1 0.452 M ops/s
> local_storage cache interleaved get:  hits throughput: 128.411 =C2=B1 4.9=
27 M ops/s, hits latency: 7.787 ns/op, important_hits throughput: 39.093 =
=C2=B1 1.500 M ops/s
>
>         num_maps: 24
> local_storage cache sequential  get:  hits throughput: 110.890 =C2=B1 0.9=
76 M ops/s, hits latency: 9.018 ns/op, important_hits throughput: 4.624 =C2=
=B1 0.041 M ops/s
> local_storage cache interleaved get:  hits throughput: 133.316 =C2=B1 1.8=
89 M ops/s, hits latency: 7.501 ns/op, important_hits throughput: 37.503 =
=C2=B1 0.531 M ops/s
>
>         num_maps: 32
> local_storage cache sequential  get:  hits throughput: 112.900 =C2=B1 1.1=
71 M ops/s, hits latency: 8.857 ns/op, important_hits throughput: 3.534 =C2=
=B1 0.037 M ops/s
> local_storage cache interleaved get:  hits throughput: 132.844 =C2=B1 1.2=
07 M ops/s, hits latency: 7.528 ns/op, important_hits throughput: 37.081 =
=C2=B1 0.337 M ops/s
>
>         num_maps: 100
> local_storage cache sequential  get:  hits throughput: 110.025 =C2=B1 4.7=
14 M ops/s, hits latency: 9.089 ns/op, important_hits throughput: 1.100 =C2=
=B1 0.047 M ops/s
> local_storage cache interleaved get:  hits throughput: 131.979 =C2=B1 5.0=
13 M ops/s, hits latency: 7.577 ns/op, important_hits throughput: 34.472 =
=C2=B1 1.309 M ops/s
>
>         num_maps: 1000
> local_storage cache sequential  get:  hits throughput: 117.850 =C2=B1 2.4=
23 M ops/s, hits latency: 8.485 ns/op, important_hits throughput: 0.118 =C2=
=B1 0.002 M ops/s
> local_storage cache interleaved get:  hits throughput: 141.268 =C2=B1 9.6=
58 M ops/s, hits latency: 7.079 ns/op, important_hits throughput: 35.476 =
=C2=B1 2.425 M ops/s
>
> Adjusting for overhead, latency numbers for "hashmap control" and "sequen=
tial get" are:
>
> hashmap_control:     ~10.4ns
> sequential_get_1:    ~13.0ns

So what this benchmark doesn't demonstrate is why one would use local
storage at all if hashmap is so fast :)

I think at least partially it's because of your choice to do fixed
hashmap lookup with zero key. Think about how you'd replace
local_storage with hashmap. You'd have task/socket/whatever ID as look
up key. For different tasks you'd be looking up different pids. For
your benchmark you have the same task all the time, but local_storage
look up still does all the work to find local storage instance in a
list of local storages for current task, so you don't have to use many
tasks to simulate realistic lookup overhead (well, at least to some
extent). But it seems not realistic for testing hashmap as an
alternative to local_storage, for that I think we'd need to randomize
key look up a bit. Unless I misunderstand what we are testing for
hashmap use case.

But other than that LGTM.

> sequential_get_10:   ~13.8ns
> sequential_get_16:   ~13.6ns
> sequential_get_17:   ~21.5ns
> sequential_get_24:   ~42.5ns
> sequential_get_32:   ~65.9ns
> sequential_get_100:  ~155.7ns
> sequential_get_1000: ~2270ns
>
> Clearly demonstrating a cliff.
>
> When running the benchmarks it may be necessary to bump 'open files'
> ulimit for a successful run.
>
>   [0]: https://lore.kernel.org/all/20220420002143.1096548-1-davemarchevsk=
y@fb.com
>
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---
> Changelog:
>
> v3 -> v4:
>         * Remove ifs guarding increments in measure fn (Andrii)
>         * Refactor to use 1 bpf prog for all 3 benchmarks w/ global vars =
set
>           from userspace before load to control behavior (Andrii)
>         * Greatly reduce variance in overhead by having benchmark bpf pro=
g
>           loop 10k times regardless of map count (Andrii)
>                 * Also, move sync_fetch_and_incr out of do_lookup as the =
guaranteed
>                   second sync_fetch_and_incr call for num_maps =3D 1 was =
adding
>                   overhead
>         * Add second patch refactoring bench.c's mean/stddev calculations
>           in reporting helper fns
>
> v2 -> v3:
>   * Accessing 1k maps in ARRAY_OF_MAPS doesn't hit MAX_USED_MAPS limit,
>     so just use 1 program (Alexei)
>
> v1 -> v2:
>   * Adopt ARRAY_OF_MAPS approach for bpf program, allowing truly
>     configurable # of maps (Andrii)
>   * Add hashmap benchmark (Alexei)
>   * Add discussion of overhead
>
>  tools/testing/selftests/bpf/Makefile          |   4 +-
>  tools/testing/selftests/bpf/bench.c           |  55 ++++
>  tools/testing/selftests/bpf/bench.h           |   4 +
>  .../bpf/benchs/bench_local_storage.c          | 250 ++++++++++++++++++
>  .../bpf/benchs/run_bench_local_storage.sh     |  21 ++
>  .../selftests/bpf/benchs/run_common.sh        |  17 ++
>  .../selftests/bpf/progs/local_storage_bench.c |  99 +++++++
>  7 files changed, 449 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/bpf/benchs/bench_local_storag=
e.c
>  create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_local_st=
orage.sh
>  create mode 100644 tools/testing/selftests/bpf/progs/local_storage_bench=
.c
>

[...]

> +
> +static void hashmap_setup(void)
> +{
> +       struct local_storage_bench *skel;
> +
> +       setup_libbpf();
> +
> +       skel =3D local_storage_bench__open();
> +       ctx.skel =3D skel;
> +       ctx.bpf_obj =3D skel->obj;

nit: ctx.skel->obj is the same as ctx.bpf_obj, so bpf_obj is probably
not needed?


> +       ctx.array_of_maps =3D skel->maps.array_of_hash_maps;
> +       skel->rodata->use_hashmap =3D 1;
> +       skel->rodata->interleave =3D 0;
> +
> +       __setup(skel->progs.get_local, true);
> +}
> +

[...]
