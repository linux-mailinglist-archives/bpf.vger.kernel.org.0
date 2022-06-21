Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3EB553A53
	for <lists+bpf@lfdr.de>; Tue, 21 Jun 2022 21:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352979AbiFUTTU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Jun 2022 15:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353489AbiFUTTJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Jun 2022 15:19:09 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9F62D1F7
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 12:18:04 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id n12so2694470ilt.4
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 12:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=m1rLTRVD/2sg8vR2B4hxWhx0vDPDz7W+AGIeWIe05S0=;
        b=BhiHJrqVGBeBdxH9tV4XPGosKr36AfR5IWr1suzwwJGFkLupgqpMjIO9xrO1zHjhOr
         g9xbsh9Y1p2M4Q2q6yMS1FEyN+r1uoDwDeXtY2B1Mv6zQDiMf1YAmOoHe+Aw4DJVYXbh
         geV5XV8J7aHhJNO9ZE4qePK0PYzdRLix/iLX4xvJJqzrVKRsHe6h/gR4CfwiZt1KUd2y
         YQQd5tXRLv7RwxDwj2K0b84hi+vjkWDSpq47ixP9df4JCWrFsn2ildE9Y8cVHm6IXDFU
         N7PYs1YyK8A7r8LOPbIPTdP/549Ag1rLc0Bvx7eg1teEnqQx5yxZ1rNRl20I2h4XbM5L
         qFyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=m1rLTRVD/2sg8vR2B4hxWhx0vDPDz7W+AGIeWIe05S0=;
        b=q9E2cZGXB2M0zJ0ifhwkZepmOwssx+8uw79OVHND8Y9fiRpjUKsJ27C6Fo4I+4OVDo
         sWH1wk2CSvWikBa8aTQsu1UWpduJ+lEvATFi9WJGXBqnnUTvRBB+Xbs+w7Pl1HwbLF7q
         AA/8IoItPlyN+OWhK6aEIB/KowaNbXP/1KdqCcKMuje1jJ/m0ELmpaD+Vn6AON7CwdOd
         kfWSrSDWuSuVroIkahbJ2uh8DVPDNyRVWGD8iq15X8UxcWW0uj8XNmSl5WuKKpjfxKnw
         e9riSUK/wSM0YyIBVrPMF35CXSYc5argkN1tudBCoRIZdex66LX2cii9X0zIk/KDfcw7
         vatA==
X-Gm-Message-State: AJIora+IrRsKCxkfRlqK6YOARZQX8BySlHIDEM3urbUf6+BRwqqUaA2O
        3UGZ7q+RWD33ch54GNw5+cDNHQbyWtgxuA==
X-Google-Smtp-Source: AGRyM1twy2m/bNQ7hY4CswVHAnrbsJN8jn1cQ/7bMwKvaT5LbNmg3ye3vWecy4AgrZB/Ed5JxrAzxQ==
X-Received: by 2002:a05:6e02:1c0e:b0:2d3:fa6d:ce23 with SMTP id l14-20020a056e021c0e00b002d3fa6dce23mr16634575ilh.98.1655839083366;
        Tue, 21 Jun 2022 12:18:03 -0700 (PDT)
Received: from localhost ([172.243.153.43])
        by smtp.gmail.com with ESMTPSA id r13-20020a02880d000000b00331b841cf9fsm7418430jai.33.2022.06.21.12.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 12:18:02 -0700 (PDT)
Date:   Tue, 21 Jun 2022 12:17:54 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Kernel Team <kernel-team@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Message-ID: <62b21962dc64_1627420844@john.notmuch>
In-Reply-To: <20220620222554.270578-1-davemarchevsky@fb.com>
References: <20220620222554.270578-1-davemarchevsky@fb.com>
Subject: RE: [PATCH v6 bpf-next] selftests/bpf: Add benchmark for
 local_storage get
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
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

Dave Marchevsky wrote:
> Add a benchmarks to demonstrate the performance cliff for local_storage=

> get as the number of local_storage maps increases beyond current
> local_storage implementation's cache size.
> =

> "sequential get" and "interleaved get" benchmarks are added, both of
> which do many bpf_task_storage_get calls on sets of task local_storage
> maps of various counts, while considering a single specific map to be
> 'important' and counting task_storage_gets to the important map
> separately in addition to normal 'hits' count of all gets. Goal here is=

> to mimic scenario where a particular program using one map - the
> important one - is running on a system where many other local_storage
> maps exist and are accessed often.
> =

> While "sequential get" benchmark does bpf_task_storage_get for map 0, 1=
,
> ..., {9, 99, 999} in order, "interleaved" benchmark interleaves 4
> bpf_task_storage_gets for the important map for every 10 map gets. This=

> is meant to highlight performance differences when important map is
> accessed far more frequently than non-important maps.
> =

> A "hashmap control" benchmark is also included for easy comparison of
> standard bpf hashmap lookup vs local_storage get. The benchmark is
> similar to "sequential get", but creates and uses BPF_MAP_TYPE_HASH
> instead of local storage. Only one inner map is created - a hashmap
> meant to hold tid -> data mapping for all tasks. Size of the hashmap is=

> hardcoded to my system's PID_MAX_LIMIT (4,194,304). The number of these=

> keys which are actually fetched as part of the benchmark is
> configurable.
> =

> Addition of this benchmark is inspired by conversation with Alexei in a=

> previous patchset's thread [0], which highlighted the need for such a
> benchmark to motivate and validate improvements to local_storage
> implementation. My approach in that series focused on improving
> performance for explicitly-marked 'important' maps and was rejected
> with feedback to make more generally-applicable improvements while
> avoiding explicitly marking maps as important. Thus the benchmark
> reports both general and important-map-focused metrics, so effect of
> future work on both is clear.
> =

> Regarding the benchmark results. On a powerful system (Skylake, 20
> cores, 256gb ram):
> =

> Hashmap Control
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>         num keys: 10
> hashmap (control) sequential    get:  hits throughput: 20.900 =C2=B1 0.=
334 M ops/s, hits latency: 47.847 ns/op, important_hits throughput: 20.90=
0 =C2=B1 0.334 M ops/s
> =

>         num keys: 1000
> hashmap (control) sequential    get:  hits throughput: 13.758 =C2=B1 0.=
219 M ops/s, hits latency: 72.683 ns/op, important_hits throughput: 13.75=
8 =C2=B1 0.219 M ops/s
> =

>         num keys: 10000
> hashmap (control) sequential    get:  hits throughput: 6.995 =C2=B1 0.0=
34 M ops/s, hits latency: 142.959 ns/op, important_hits throughput: 6.995=
 =C2=B1 0.034 M ops/s
> =

>         num keys: 100000
> hashmap (control) sequential    get:  hits throughput: 4.452 =C2=B1 0.3=
71 M ops/s, hits latency: 224.635 ns/op, important_hits throughput: 4.452=
 =C2=B1 0.371 M ops/s
> =

>         num keys: 4194304
> hashmap (control) sequential    get:  hits throughput: 3.043 =C2=B1 0.0=
33 M ops/s, hits latency: 328.587 ns/op, important_hits throughput: 3.043=
 =C2=B1 0.033 M ops/s
> =


Why is the hashmap lookup not constant with the number of keys? It looks
like its prepopulated without collisions so I wouldn't expect any
extra ops on the lookup side after looking at the code quickly.


> Local Storage
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>         num_maps: 1
> local_storage cache sequential  get:  hits throughput: 47.298 =C2=B1 0.=
180 M ops/s, hits latency: 21.142 ns/op, important_hits throughput: 47.29=
8 =C2=B1 0.180 M ops/s
> local_storage cache interleaved get:  hits throughput: 55.277 =C2=B1 0.=
888 M ops/s, hits latency: 18.091 ns/op, important_hits throughput: 55.27=
7 =C2=B1 0.888 M ops/s
> =

>         num_maps: 10
> local_storage cache sequential  get:  hits throughput: 40.240 =C2=B1 0.=
802 M ops/s, hits latency: 24.851 ns/op, important_hits throughput: 4.024=
 =C2=B1 0.080 M ops/s
> local_storage cache interleaved get:  hits throughput: 48.701 =C2=B1 0.=
722 M ops/s, hits latency: 20.533 ns/op, important_hits throughput: 17.39=
3 =C2=B1 0.258 M ops/s
> =

>         num_maps: 16
> local_storage cache sequential  get:  hits throughput: 44.515 =C2=B1 0.=
708 M ops/s, hits latency: 22.464 ns/op, important_hits throughput: 2.782=
 =C2=B1 0.044 M ops/s
> local_storage cache interleaved get:  hits throughput: 49.553 =C2=B1 2.=
260 M ops/s, hits latency: 20.181 ns/op, important_hits throughput: 15.76=
7 =C2=B1 0.719 M ops/s
> =

>         num_maps: 17
> local_storage cache sequential  get:  hits throughput: 38.778 =C2=B1 0.=
302 M ops/s, hits latency: 25.788 ns/op, important_hits throughput: 2.284=
 =C2=B1 0.018 M ops/s
> local_storage cache interleaved get:  hits throughput: 43.848 =C2=B1 1.=
023 M ops/s, hits latency: 22.806 ns/op, important_hits throughput: 13.34=
9 =C2=B1 0.311 M ops/s
> =

>         num_maps: 24
> local_storage cache sequential  get:  hits throughput: 19.317 =C2=B1 0.=
568 M ops/s, hits latency: 51.769 ns/op, important_hits throughput: 0.806=
 =C2=B1 0.024 M ops/s
> local_storage cache interleaved get:  hits throughput: 24.397 =C2=B1 0.=
272 M ops/s, hits latency: 40.989 ns/op, important_hits throughput: 6.863=
 =C2=B1 0.077 M ops/s
> =

>         num_maps: 32
> local_storage cache sequential  get:  hits throughput: 13.333 =C2=B1 0.=
135 M ops/s, hits latency: 75.000 ns/op, important_hits throughput: 0.417=
 =C2=B1 0.004 M ops/s
> local_storage cache interleaved get:  hits throughput: 16.898 =C2=B1 0.=
383 M ops/s, hits latency: 59.178 ns/op, important_hits throughput: 4.717=
 =C2=B1 0.107 M ops/s
> =

>         num_maps: 100
> local_storage cache sequential  get:  hits throughput: 6.360 =C2=B1 0.1=
07 M ops/s, hits latency: 157.233 ns/op, important_hits throughput: 0.064=
 =C2=B1 0.001 M ops/s
> local_storage cache interleaved get:  hits throughput: 7.303 =C2=B1 0.3=
62 M ops/s, hits latency: 136.930 ns/op, important_hits throughput: 1.907=
 =C2=B1 0.094 M ops/s
> =

>         num_maps: 1000
> local_storage cache sequential  get:  hits throughput: 0.452 =C2=B1 0.0=
10 M ops/s, hits latency: 2214.022 ns/op, important_hits throughput: 0.00=
0 =C2=B1 0.000 M ops/s
> local_storage cache interleaved get:  hits throughput: 0.542 =C2=B1 0.0=
07 M ops/s, hits latency: 1843.341 ns/op, important_hits throughput: 0.13=
6 =C2=B1 0.002 M ops/s
> =

> Looking at the "sequential get" results, it's clear that as the
> number of task local_storage maps grows beyond the current cache size
> (16), there's a significant reduction in hits throughput. Note that
> current local_storage implementation assigns a cache_idx to maps as the=
y
> are created. Since "sequential get" is creating maps 0..n in order and
> then doing bpf_task_storage_get calls in the same order, the benchmark
> is effectively ensuring that a map will not be in cache when the progra=
m
> tries to access it.
> =

> For "interleaved get" results, important-map hits throughput is greatly=

> increased as the important map is more likely to be in cache by virtue
> of being accessed far more frequently. Throughput still reduces as #
> maps increases, though.
> =

> To get a sense of the overhead of the benchmark program, I
> commented out bpf_task_storage_get/bpf_map_lookup_elem in
> local_storage_bench.c and ran the benchmark on the same host as the
> 'real' run. Results:

Also just checking the hash overhead was taken including the
urandom so we can pull that out of the cost.

[...]

> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
> +
> +#define HASHMAP_SZ 4194304
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
> +	__uint(max_entries, 1000);
> +	__type(key, int);
> +	__type(value, int);
> +	__array(values, struct {
> +		__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
> +		__uint(map_flags, BPF_F_NO_PREALLOC);
> +		__type(key, int);
> +		__type(value, int);
> +	});
> +} array_of_local_storage_maps SEC(".maps");
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
> +	__uint(max_entries, 1000);
> +	__type(key, int);
> +	__type(value, int);
> +	__array(values, struct {
> +		__uint(type, BPF_MAP_TYPE_HASH);
> +		__uint(max_entries, HASHMAP_SZ);
> +		__type(key, int);
> +		__type(value, int);
> +	});
> +} array_of_hash_maps SEC(".maps");
> +
> +long important_hits;
> +long hits;
> +
> +/* set from user-space */
> +const volatile unsigned int use_hashmap;
> +const volatile unsigned int hashmap_num_keys;
> +const volatile unsigned int num_maps;
> +const volatile unsigned int interleave;
> +
> +struct loop_ctx {
> +	struct task_struct *task;
> +	long loop_hits;
> +	long loop_important_hits;
> +};
> +
> +static int do_lookup(unsigned int elem, struct loop_ctx *lctx)
> +{
> +	void *map, *inner_map;
> +	int idx =3D 0;
> +
> +	if (use_hashmap)
> +		map =3D &array_of_hash_maps;
> +	else
> +		map =3D &array_of_local_storage_maps;
> +
> +	inner_map =3D bpf_map_lookup_elem(map, &elem);
> +	if (!inner_map)
> +		return -1;
> +
> +	if (use_hashmap) {
> +		idx =3D bpf_get_prandom_u32() % hashmap_num_keys;
> +		bpf_map_lookup_elem(inner_map, &idx);

The htab lookup is just,

 static void *htab_map_lookup_elem(struct bpf_map *map, void *key)       =
   =

 {                                                                      =

        struct htab_elem *l =3D __htab_map_lookup_elem(map, key);
                                                =

        if (l)                                                       =

                return l->key + round_up(map->key_size, 8);
        return NULL;                                    =

 }   =


> +	} else {
> +		bpf_task_storage_get(inner_map, lctx->task, &idx,
> +				     BPF_LOCAL_STORAGE_GET_F_CREATE);
> +	}
> +
> +	lctx->loop_hits++;
> +	if (!elem)
> +		lctx->loop_important_hits++;
> +	return 0;
> +}
> +
> +static long loop(u32 index, void *ctx)
> +{
> +	struct loop_ctx *lctx =3D (struct loop_ctx *)ctx;
> +	unsigned int map_idx =3D index % num_maps;
> +
> +	do_lookup(map_idx, lctx);
> +	if (interleave && map_idx % 3 =3D=3D 0)
> +		do_lookup(0, lctx);
> +	return 0;
> +}
> +
> +SEC("fentry/" SYS_PREFIX "sys_getpgid")
> +int get_local(void *ctx)
> +{
> +	struct loop_ctx lctx;
> +
> +	lctx.task =3D bpf_get_current_task_btf();
> +	lctx.loop_hits =3D 0;
> +	lctx.loop_important_hits =3D 0;
> +	bpf_loop(10000, &loop, &lctx, 0);
> +	__sync_add_and_fetch(&hits, lctx.loop_hits);
> +	__sync_add_and_fetch(&important_hits, lctx.loop_important_hits);
> +	return 0;
> +}
> +
> +char _license[] SEC("license") =3D "GPL";
> -- =

> 2.30.2
> =



