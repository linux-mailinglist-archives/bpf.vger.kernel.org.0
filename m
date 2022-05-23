Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A459C531D6F
	for <lists+bpf@lfdr.de>; Mon, 23 May 2022 23:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiEWVLh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 May 2022 17:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbiEWVLa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 May 2022 17:11:30 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3CF31901
        for <bpf@vger.kernel.org>; Mon, 23 May 2022 14:11:27 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id f4so16614023iov.2
        for <bpf@vger.kernel.org>; Mon, 23 May 2022 14:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=A5sp3biPuMWkJinZo8eqZXCekfDUzJ6VT79+Yu42pnI=;
        b=NejvyaRv+ZlluXLCBY6Kinf3b3KUuayYiKGyTm/vYbnUW1ljURHw1TdSBHWNvyf7j+
         yE5ozjaDISWtgGtuFsWib6UfilP5RUaFDXqlazELK0UErKN4aL1yMpzjZIDPBvpgu2Xa
         3nn7/FTkwonJeoqULE63wRjcx5WmBz9zoVTly7ml4KN75XKcu+DK9llEOnhH/kzeVpDR
         nO0Q80hp8Pc24vsj9t5OTgabOzVOkacYa0El4QZUe1sPFSmHSdPbhJDBq9RPfzXB4U4z
         fE5wYvwYcZcElCX4dHbmMKXcO96GQiD9ww+qOymk8pw0QujeHMT8wGwi6kSSudviwfkJ
         NNqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=A5sp3biPuMWkJinZo8eqZXCekfDUzJ6VT79+Yu42pnI=;
        b=a0aRRhV39uBHnU/y+9IArCxFo9RK55i3OFFmM6OcDR9s7j8/XfBgPYM2RgYXe4dlGv
         uCrBqT5GrMA5w+PxdL6dAIYG0dYb8p+t0a4LsmgTHupK9mINYzUgCJm8YdYe0pFUVnhZ
         s2fhKyageqV30+LAJ9o4TSanejGrKQYqfEGfoeBozpyvoCGZc0Yor6H1cyUqiab2U84I
         WuLJ+UbpmCWSYCXYert2d2ggZ6QS2dLS08LFw+jJbhBEdEcv3L59RbhWrnLG6jRbzhI7
         xFJloqQtsXfwk5ogsW8gle38g8pnsHaE70+5kJnLwnTT6Wh3OBYa0F0HSMk92ABwO9fR
         MyDA==
X-Gm-Message-State: AOAM532Br0x7rEH5gN2HECp7HbHedcd+q3hZmOgl5vOMySewGDMxnuAd
        sOZlrCjOrUZV54HwSexOlBS5oHmzWmYpja3fbF0=
X-Google-Smtp-Source: ABdhPJzx+cCUff90rVYHMoExQBbZcmToXb4Qw+wHmUaanediQyM51ovDzIPDbyFFlzHbKROtuKCptJpQWIDN8ND+gEI=
X-Received: by 2002:a05:6602:248f:b0:65a:fb17:7a6b with SMTP id
 g15-20020a056602248f00b0065afb177a6bmr10588339ioe.79.1653340286880; Mon, 23
 May 2022 14:11:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220521045958.3405148-1-davemarchevsky@fb.com>
In-Reply-To: <20220521045958.3405148-1-davemarchevsky@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 23 May 2022 14:11:15 -0700
Message-ID: <CAEf4BzYbA74HHkNC_tiaUtz3ut2uzBz6nNhJzDNGaVLi9zwFRA@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next] selftests/bpf: Add benchmark for
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

On Fri, May 20, 2022 at 10:00 PM Dave Marchevsky <davemarchevsky@fb.com> wr=
ote:
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
> hashmap (control) sequential    get:  hits throughput: 69.649 =C2=B1 1.20=
7 M ops/s, hits latency: 14.358 ns/op, important_hits throughput: 0.139 =C2=
=B1 0.002 M ops/s
>
>         num_maps: 1
> local_storage cache sequential  get:  hits throughput: 3.849 =C2=B1 0.035=
 M ops/s, hits latency: 259.803 ns/op, important_hits throughput: 3.849 =C2=
=B1 0.035 M ops/s
> local_storage cache interleaved get:  hits throughput: 6.881 =C2=B1 0.110=
 M ops/s, hits latency: 145.324 ns/op, important_hits throughput: 6.881 =C2=
=B1 0.110 M ops/s

this is huge drop in performance for num_maps is due to syscall and
fentry overhead, is that right? How about making each syscall
invocation do (roughly) the same amount of map/storage lookups per
invocation to neutralize this overhead? Something like:


const volatile int map_cnt;
const volatile int iter_cnt;

...


for (i =3D 0; i < iter_cnt; i++) {
    int map_idx =3D i % map_cnt;

    do_lookup(map_idx, task);

...

}

User-space can calculate iter_cnt to be closest exact multiple of
map_cnt or you can just hard-code iter_cnt to fixed number (something
like 10000 or some high enough value) and just leave with slightly
uneven pattern for last round of looping.


But this way you make syscall/fentry overhead essentially fixed, which
will avoid these counter-intuitive numbers.


>
>         num_maps: 10
> local_storage cache sequential  get:  hits throughput: 20.339 =C2=B1 0.44=
2 M ops/s, hits latency: 49.167 ns/op, important_hits throughput: 2.034 =C2=
=B1 0.044 M ops/s
> local_storage cache interleaved get:  hits throughput: 22.408 =C2=B1 0.60=
6 M ops/s, hits latency: 44.627 ns/op, important_hits throughput: 8.003 =C2=
=B1 0.217 M ops/s
>
>         num_maps: 16
> local_storage cache sequential  get:  hits throughput: 24.428 =C2=B1 1.12=
0 M ops/s, hits latency: 40.937 ns/op, important_hits throughput: 1.527 =C2=
=B1 0.070 M ops/s
> local_storage cache interleaved get:  hits throughput: 26.853 =C2=B1 0.82=
5 M ops/s, hits latency: 37.240 ns/op, important_hits throughput: 8.544 =C2=
=B1 0.262 M ops/s
>
>         num_maps: 17
> local_storage cache sequential  get:  hits throughput: 24.158 =C2=B1 0.22=
2 M ops/s, hits latency: 41.394 ns/op, important_hits throughput: 1.421 =C2=
=B1 0.013 M ops/s
> local_storage cache interleaved get:  hits throughput: 26.223 =C2=B1 0.20=
1 M ops/s, hits latency: 38.134 ns/op, important_hits throughput: 7.981 =C2=
=B1 0.061 M ops/s
>
>         num_maps: 24
> local_storage cache sequential  get:  hits throughput: 16.820 =C2=B1 0.29=
4 M ops/s, hits latency: 59.451 ns/op, important_hits throughput: 0.701 =C2=
=B1 0.012 M ops/s
> local_storage cache interleaved get:  hits throughput: 19.185 =C2=B1 0.21=
2 M ops/s, hits latency: 52.125 ns/op, important_hits throughput: 5.396 =C2=
=B1 0.060 M ops/s
>
>         num_maps: 32
> local_storage cache sequential  get:  hits throughput: 11.998 =C2=B1 0.31=
0 M ops/s, hits latency: 83.347 ns/op, important_hits throughput: 0.375 =C2=
=B1 0.010 M ops/s
> local_storage cache interleaved get:  hits throughput: 14.233 =C2=B1 0.26=
5 M ops/s, hits latency: 70.259 ns/op, important_hits throughput: 3.972 =C2=
=B1 0.074 M ops/s
>
>         num_maps: 100
> local_storage cache sequential  get:  hits throughput: 5.780 =C2=B1 0.250=
 M ops/s, hits latency: 173.003 ns/op, important_hits throughput: 0.058 =C2=
=B1 0.002 M ops/s
> local_storage cache interleaved get:  hits throughput: 7.175 =C2=B1 0.312=
 M ops/s, hits latency: 139.381 ns/op, important_hits throughput: 1.874 =C2=
=B1 0.081 M ops/s
>
>         num_maps: 1000
> local_storage cache sequential  get:  hits throughput: 0.456 =C2=B1 0.011=
 M ops/s, hits latency: 2192.982 ns/op, important_hits throughput: 0.000 =
=C2=B1 0.000 M ops/s
> local_storage cache interleaved get:  hits throughput: 0.539 =C2=B1 0.005=
 M ops/s, hits latency: 1855.508 ns/op, important_hits throughput: 0.135 =
=C2=B1 0.001 M ops/s
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
> As evidenced by the unintuitive-looking results for smaller num_maps
> benchmark runs, overhead which is amortized across larger num_maps runs
> dominates when there are fewer maps. To get a sense of the overhead, I
> commented out bpf_task_storage_get/bpf_map_lookup_elem in
> local_storage_bench.h and ran the benchmark on the same host as the
> 'real' run. Results:
>
> Local Storage
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>         Hashmap Control w/ 500 maps
> hashmap (control) sequential    get:  hits throughput: 128.699 =C2=B1 1.2=
67 M ops/s, hits latency: 7.770 ns/op, important_hits throughput: 0.257 =C2=
=B1 0.003 M ops/s
>

[...]

>
> Adjusting for overhead, latency numbers for "hashmap control" and "sequen=
tial get" are:
>
> hashmap_control:     ~6.6ns
> sequential_get_1:    ~17.9ns
> sequential_get_10:   ~18.9ns
> sequential_get_16:   ~19.0ns
> sequential_get_17:   ~20.2ns
> sequential_get_24:   ~42.2ns
> sequential_get_32:   ~68.7ns
> sequential_get_100:  ~163.3ns
> sequential_get_1000: ~2200ns
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
> v2 -> v3:
>   * Accessing 1k maps in ARRAY_OF_MAPS doesn't hit MAX_USED_MAPS limit,
>           so just use 1 program (Alexei)
>
> v1 -> v2:
>   * Adopt ARRAY_OF_MAPS approach for bpf program, allowing truly
>     configurable # of maps (Andrii)
>   * Add hashmap benchmark (Alexei)
>         * Add discussion of overhead
>
>  tools/testing/selftests/bpf/Makefile          |   6 +-
>  tools/testing/selftests/bpf/bench.c           |  57 +++
>  tools/testing/selftests/bpf/bench.h           |   5 +
>  .../bpf/benchs/bench_local_storage.c          | 332 ++++++++++++++++++
>  .../bpf/benchs/run_bench_local_storage.sh     |  21 ++
>  .../selftests/bpf/benchs/run_common.sh        |  17 +
>  .../selftests/bpf/progs/local_storage_bench.h |  63 ++++
>  .../bpf/progs/local_storage_bench__get_int.c  |  12 +
>  .../bpf/progs/local_storage_bench__get_seq.c  |  12 +
>  .../bpf/progs/local_storage_bench__hashmap.c  |  13 +
>  10 files changed, 537 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/bpf/benchs/bench_local_storag=
e.c
>  create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_local_st=
orage.sh
>  create mode 100644 tools/testing/selftests/bpf/progs/local_storage_bench=
.h
>  create mode 100644 tools/testing/selftests/bpf/progs/local_storage_bench=
__get_int.c
>  create mode 100644 tools/testing/selftests/bpf/progs/local_storage_bench=
__get_seq.c
>  create mode 100644 tools/testing/selftests/bpf/progs/local_storage_bench=
__hashmap.c
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index 4030dd6cbc34..6095f6af2ad1 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -560,6 +560,9 @@ $(OUTPUT)/bench_ringbufs.o: $(OUTPUT)/ringbuf_bench.s=
kel.h \
>  $(OUTPUT)/bench_bloom_filter_map.o: $(OUTPUT)/bloom_filter_bench.skel.h
>  $(OUTPUT)/bench_bpf_loop.o: $(OUTPUT)/bpf_loop_bench.skel.h
>  $(OUTPUT)/bench_strncmp.o: $(OUTPUT)/strncmp_bench.skel.h
> +$(OUTPUT)/bench_local_storage.o: $(OUTPUT)/local_storage_bench__get_seq.=
skel.h \
> +                                 $(OUTPUT)/local_storage_bench__get_int.=
skel.h \
> +                                 $(OUTPUT)/local_storage_bench__hashmap.=
skel.h

You really don't need 3 skeletons for this, you can parameterize
everything with 2-3 .rodata variables and have fixed code and single
skeleton header. It will also simplify your setup code, you won't need
need those callbacks that abstract specific skeleton away. Much
cleaner and simpler, IMO.

Please, try to simplify this and make it easier to maintain.


>  $(OUTPUT)/bench.o: bench.h testing_helpers.h $(BPFOBJ)
>  $(OUTPUT)/bench: LDLIBS +=3D -lm
>  $(OUTPUT)/bench: $(OUTPUT)/bench.o \
> @@ -571,7 +574,8 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o \
>                  $(OUTPUT)/bench_ringbufs.o \
>                  $(OUTPUT)/bench_bloom_filter_map.o \
>                  $(OUTPUT)/bench_bpf_loop.o \
> -                $(OUTPUT)/bench_strncmp.o
> +                $(OUTPUT)/bench_strncmp.o \
> +                $(OUTPUT)/bench_local_storage.o
>         $(call msg,BINARY,,$@)
>         $(Q)$(CC) $(CFLAGS) $(LDFLAGS) $(filter %.a %.o,$^) $(LDLIBS) -o =
$@
>
> diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftest=
s/bpf/bench.c
> index f061cc20e776..71271062f68d 100644
> --- a/tools/testing/selftests/bpf/bench.c
> +++ b/tools/testing/selftests/bpf/bench.c
> @@ -150,6 +150,53 @@ void ops_report_final(struct bench_res res[], int re=
s_cnt)
>         printf("latency %8.3lf ns/op\n", 1000.0 / hits_mean * env.produce=
r_cnt);
>  }
>
> +void local_storage_report_progress(int iter, struct bench_res *res,
> +                                  long delta_ns)
> +{
> +       double important_hits_per_sec, hits_per_sec;
> +       double delta_sec =3D delta_ns / 1000000000.0;
> +
> +       hits_per_sec =3D res->hits / 1000000.0 / delta_sec;
> +       important_hits_per_sec =3D res->important_hits / 1000000.0 / delt=
a_sec;
> +
> +       printf("Iter %3d (%7.3lfus): ", iter, (delta_ns - 1000000000) / 1=
000.0);
> +
> +       printf("hits %8.3lfM/s ", hits_per_sec);
> +       printf("important_hits %8.3lfM/s\n", important_hits_per_sec);
> +}
> +
> +void local_storage_report_final(struct bench_res res[], int res_cnt)
> +{
> +       double important_hits_mean =3D 0.0, important_hits_stddev =3D 0.0=
;
> +       double hits_mean =3D 0.0, hits_stddev =3D 0.0;
> +       int i;
> +
> +       for (i =3D 0; i < res_cnt; i++) {
> +               hits_mean +=3D res[i].hits / 1000000.0 / (0.0 + res_cnt);
> +               important_hits_mean +=3D res[i].important_hits / 1000000.=
0 / (0.0 + res_cnt);
> +       }
> +
> +       if (res_cnt > 1)  {
> +               for (i =3D 0; i < res_cnt; i++) {
> +                       hits_stddev +=3D (hits_mean - res[i].hits / 10000=
00.0) *
> +                                      (hits_mean - res[i].hits / 1000000=
.0) /
> +                                      (res_cnt - 1.0);
> +                       important_hits_stddev +=3D
> +                                      (important_hits_mean - res[i].impo=
rtant_hits / 1000000.0) *
> +                                      (important_hits_mean - res[i].impo=
rtant_hits / 1000000.0) /
> +                                      (res_cnt - 1.0);
> +               }
> +
> +               hits_stddev =3D sqrt(hits_stddev);
> +               important_hits_stddev =3D sqrt(important_hits_stddev);
> +       }
> +       printf("Summary: hits throughput %8.3lf \u00B1 %5.3lf M ops/s, ",
> +              hits_mean, hits_stddev);
> +       printf("hits latency %8.3lf ns/op, ", 1000.0 / hits_mean);
> +       printf("important_hits throughput %8.3lf \u00B1 %5.3lf M ops/s\n"=
,
> +              important_hits_mean, important_hits_stddev);
> +}
> +

We have hits_drops_report_progress/hits_drops_report_final which uses
"hit" and "drop" terminology (admittedly confusing for this set of
benchmarks), but if you ignore the "drop" part, it's exactly what you
need - to track two independent values (in your case hit and important
hit). You'll get rid of a good chunk of repetitive code with some
statistics in it. You post-processing scripts will further hide this
detail.

>  const char *argp_program_version =3D "benchmark";
>  const char *argp_program_bug_address =3D "<bpf@vger.kernel.org>";
>  const char argp_program_doc[] =3D
> @@ -188,12 +235,14 @@ static const struct argp_option opts[] =3D {
>  extern struct argp bench_ringbufs_argp;
>  extern struct argp bench_bloom_map_argp;
>  extern struct argp bench_bpf_loop_argp;
> +extern struct argp bench_local_storage_argp;
>  extern struct argp bench_strncmp_argp;
>

[...]

> +
> +static int setup_inner_map_and_load(int inner_fd)
> +{
> +       int err, mim_fd;
> +
> +       err =3D bpf_map__set_inner_map_fd(ctx.array_of_maps, inner_fd);
> +       if (err)
> +               return -1;
> +
> +       err =3D ctx.load_skel(ctx.skel);
> +       if (err)
> +               return -1;
> +
> +       mim_fd =3D bpf_map__fd(ctx.array_of_maps);
> +       if (mim_fd < 0)
> +               return -1;
> +
> +       return mim_fd;
> +}
> +
> +static int load_btf(void)
> +{
> +       static const char btf_str_sec[] =3D "\0";
> +       __u32 btf_raw_types[] =3D {
> +               /* int */
> +               BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),  /* [1] */
> +       };
> +       struct btf_header btf_hdr =3D {
> +               .magic =3D BTF_MAGIC,
> +               .version =3D BTF_VERSION,
> +               .hdr_len =3D sizeof(struct btf_header),
> +               .type_len =3D sizeof(btf_raw_types),
> +               .str_off =3D sizeof(btf_raw_types),
> +               .str_len =3D sizeof(btf_str_sec),
> +       };
> +       __u8 raw_btf[sizeof(struct btf_header) + sizeof(btf_raw_types) +
> +                               sizeof(btf_str_sec)];
> +
> +       memcpy(raw_btf, &btf_hdr, sizeof(btf_hdr));
> +       memcpy(raw_btf + sizeof(btf_hdr), btf_raw_types, sizeof(btf_raw_t=
ypes));
> +       memcpy(raw_btf + sizeof(btf_hdr) + sizeof(btf_raw_types),
> +              btf_str_sec, sizeof(btf_str_sec));
> +
> +       return bpf_btf_load(raw_btf, sizeof(raw_btf), NULL);
> +}
> +

please try using declarative map-in-map definition, hopefully it
doesn't influence benchmark results. It will allow to avoid this
low-level setup code completely.

> +static void __setup(struct bpf_program *prog, bool hashmap)
> +{
> +       int i, fd, mim_fd, err;
> +       int btf_fd =3D 0;
> +
> +       LIBBPF_OPTS(bpf_map_create_opts, create_opts);
> +

[...]

> +
> +static void measure(struct bench_res *res)
> +{
> +       if (ctx.hits)
> +               res->hits =3D atomic_swap(ctx.hits, 0);
> +       if (ctx.important_hits)

why these ifs? just swap, measure is called once a second, there is no
need to optimize this

> +               res->important_hits =3D atomic_swap(ctx.important_hits, 0=
);
> +}
> +
> +static inline void trigger_bpf_program(void)
> +{
> +       syscall(__NR_getpgid);
> +}
> +

[...]

> +#ifdef LOOKUP_HASHMAP
> +static int do_lookup(unsigned int elem, struct task_struct *task /* unus=
ed */)
> +{
> +       void *map;
> +       int zero =3D 0;
> +
> +       map =3D bpf_map_lookup_elem(&array_of_maps, &elem);
> +       if (!map)
> +               return -1;
> +
> +       bpf_map_lookup_elem(map, &zero);

shouldn't you use elem here as well to make it a bit more in line with
bpf_task_storage_get()? This fixed zero is too optimistic and
minimizes CPU cache usage, skewing results towards hashmap. It's
cheaper to go access same location in hashmap over and over again, vs
randomly jumping over N elements

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
> +       map =3D bpf_map_lookup_elem(&array_of_maps, &elem);
> +       if (!map)
> +               return -1;
> +
> +       bpf_task_storage_get(map, task, 0, BPF_LOCAL_STORAGE_GET_F_CREATE=
);
> +       __sync_add_and_fetch(&hits, 1);
> +       if (!elem)
> +               __sync_add_and_fetch(&important_hits, 1);
> +       return 0;
> +}
> +#endif /* LOOKUP_HASHMAP */
> +
> +#define TASK_STORAGE_GET_LOOP_PROG(interleave)                 \
> +SEC("fentry/" SYS_PREFIX "sys_getpgid")                        \
> +int get_local(void *ctx)                                       \
> +{                                                              \
> +       struct task_struct *task;                               \
> +       unsigned int i;                                         \
> +       void *map;                                              \
> +                                                               \
> +       task =3D bpf_get_current_task_btf();                      \
> +       for (i =3D 0; i < 1000; i++) {                            \
> +               if (do_lookup(i, task))                         \
> +                       return 0;                               \
> +               if (interleave && i % 3 =3D=3D 0)                   \
> +                       do_lookup(0, task);                     \
> +       }                                                       \
> +       return 0;                                               \
> +}

I think


const volatile use_local_storage; /* set from user-space */


if (use_local_storage) {
    do_lookup_storage()
} else {
    do_lookup_hashmap()
}

is as clear (if not clearer) than having three separate skeletons
built from single #include header parameterized by extra #defines.

> diff --git a/tools/testing/selftests/bpf/progs/local_storage_bench__get_i=
nt.c b/tools/testing/selftests/bpf/progs/local_storage_bench__get_int.c
> new file mode 100644

[...]
