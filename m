Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A95AB68207B
	for <lists+bpf@lfdr.de>; Tue, 31 Jan 2023 01:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjAaAQ0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Jan 2023 19:16:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjAaAQ0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Jan 2023 19:16:26 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD18A1F5D8
        for <bpf@vger.kernel.org>; Mon, 30 Jan 2023 16:16:24 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id kt14so37057274ejc.3
        for <bpf@vger.kernel.org>; Mon, 30 Jan 2023 16:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FbFR6VsrA+i8jMUY0OafAz/SsQjZl2kB73G1Ln43lP4=;
        b=Q5y1jLrTqboZAgIg4wKdnLV6VNPDgxtXp0lwMjhrPlV1KFp+hb4wyc6DC9tuWXItCM
         XVPXnJTl4ZeFrYGPa3VC7UebfjnS44SnvGZKFZtXx/4b4mmN56QEFyI0StNXADlc7MvT
         wWnlHpu2PFV9Lb16R3e0l9/dvmn1KubpsZQ9ELmFFzrnmto5vjnwM/KuxT918tc2eNsN
         PBZDeBpWxubK03kbAD6E2UywAu/+xTkg/s06IQmMi3AuR9kP8gqlyb05yR7VAGLq4c1M
         drpQ6TNnO0A69EOqI6j6qEpwjMtwCzWuBSZOERUvksjgEKsX/9ghcAuo4dgY+J0w1Wid
         XPyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FbFR6VsrA+i8jMUY0OafAz/SsQjZl2kB73G1Ln43lP4=;
        b=ueVMgSq0/rflj/5d+96GTiYw6+R0ldus/06vJlZjdSuWkHexb6HYNwDRZniVXbX9Wx
         boEru95He24fTckaOgU4fHEur6Pq2ZMrQBxJkLnQONx4T02yYIsyK0DF7rL8Qr5Kq2yY
         MYMMV+JJDPvq0Do2S7dVtYguitp702K/xy2Aq3X8Ax3bVJm4Igj5QW85uNI+3+C5fuvS
         ibc3olEygksGbVPCYpoDv/We8tPisFRPpxpLFAOYdGDczAXAPgclSnaKIY1xiPoYthGV
         aIMnrsWlg9YswddQIy/TlvNiJZ4KvGBZEjocQK0RckCmrRHMFbysE1ldEZtvVy0Ku9ae
         bGng==
X-Gm-Message-State: AO0yUKVQdMo3TkWWMaAVWTamiJ+eReBKkJggPJfIzTtzH4ewwSFiZ8BG
        HdH5LZDQ9tJK9yNRZmKjm2a1wkD0ox4bzjgEfsnabJb0
X-Google-Smtp-Source: AK7set9oLiu+KZt921BQ/Rm4jAt5bEotnuqNlsTeezPdxmymtkwgvYvhQqBSv+vCVpH40Ae2AEZYOt92or0xEAUghQM=
X-Received: by 2002:a17:906:46d3:b0:888:1f21:4424 with SMTP id
 k19-20020a17090646d300b008881f214424mr1807362ejs.141.1675124183256; Mon, 30
 Jan 2023 16:16:23 -0800 (PST)
MIME-Version: 1.0
References: <20230127181457.21389-1-aspsk@isovalent.com> <20230127181457.21389-7-aspsk@isovalent.com>
In-Reply-To: <20230127181457.21389-7-aspsk@isovalent.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 30 Jan 2023 16:16:10 -0800
Message-ID: <CAEf4BzbS-2QdXxU7i0y0oDqBd==FuGxg+mSAMaA3q4Nc2pYTMA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 6/6] selftest/bpf/benchs: Add benchmark for
 hashmap lookups
To:     Anton Protopopov <aspsk@isovalent.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 27, 2023 at 10:14 AM Anton Protopopov <aspsk@isovalent.com> wro=
te:
>
> Add a new benchmark which measures hashmap lookup operations speed.  A us=
er can
> control the following parameters of the benchmark:
>
>     * key_size (max 1024): the key size to use
>     * max_entries: the hashmap max entries
>     * nr_entries: the number of entries to insert/lookup
>     * nr_loops: the number of loops for the benchmark
>     * map_flags The hashmap flags passed to BPF_MAP_CREATE
>
> The BPF program performing the benchmarks calls two nested bpf_loop:
>
>     bpf_loop(nr_loops/nr_entries)
>             bpf_loop(nr_entries)
>                      bpf_map_lookup()
>
> So the nr_loops determines the number of actual map lookups. All lookups =
are
> successful.
>
> Example (the output is generated on a AMD Ryzen 9 3950X machine):
>
>     for nr_entries in `seq 4096 4096 65536`; do echo -n "$((nr_entries*10=
0/65536))% full: "; sudo ./bench -d2 -a bpf-hashmap-lookup --key_size=3D4 -=
-nr_entries=3D$nr_entries --max_entries=3D65536 --nr_loops=3D1000000 --map_=
flags=3D0x40 | grep cpu; done
>     6% full: cpu01: lookup 50.739M =C2=B1 0.018M events/sec (approximated=
 from 32 samples of ~19ms)
>     12% full: cpu01: lookup 47.751M =C2=B1 0.015M events/sec (approximate=
d from 32 samples of ~20ms)
>     18% full: cpu01: lookup 45.153M =C2=B1 0.013M events/sec (approximate=
d from 32 samples of ~22ms)
>     25% full: cpu01: lookup 43.826M =C2=B1 0.014M events/sec (approximate=
d from 32 samples of ~22ms)
>     31% full: cpu01: lookup 41.971M =C2=B1 0.012M events/sec (approximate=
d from 32 samples of ~23ms)
>     37% full: cpu01: lookup 41.034M =C2=B1 0.015M events/sec (approximate=
d from 32 samples of ~24ms)
>     43% full: cpu01: lookup 39.946M =C2=B1 0.012M events/sec (approximate=
d from 32 samples of ~25ms)
>     50% full: cpu01: lookup 38.256M =C2=B1 0.014M events/sec (approximate=
d from 32 samples of ~26ms)
>     56% full: cpu01: lookup 36.580M =C2=B1 0.018M events/sec (approximate=
d from 32 samples of ~27ms)
>     62% full: cpu01: lookup 36.252M =C2=B1 0.012M events/sec (approximate=
d from 32 samples of ~27ms)
>     68% full: cpu01: lookup 35.200M =C2=B1 0.012M events/sec (approximate=
d from 32 samples of ~28ms)
>     75% full: cpu01: lookup 34.061M =C2=B1 0.009M events/sec (approximate=
d from 32 samples of ~29ms)
>     81% full: cpu01: lookup 34.374M =C2=B1 0.010M events/sec (approximate=
d from 32 samples of ~29ms)
>     87% full: cpu01: lookup 33.244M =C2=B1 0.011M events/sec (approximate=
d from 32 samples of ~30ms)
>     93% full: cpu01: lookup 32.182M =C2=B1 0.013M events/sec (approximate=
d from 32 samples of ~31ms)
>     100% full: cpu01: lookup 31.497M =C2=B1 0.016M events/sec (approximat=
ed from 32 samples of ~31ms)
>
> Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> ---
>  tools/testing/selftests/bpf/Makefile          |   5 +-
>  tools/testing/selftests/bpf/bench.c           |   7 +
>  tools/testing/selftests/bpf/bench.h           |   3 +
>  .../bpf/benchs/bench_bpf_hashmap_lookup.c     | 277 ++++++++++++++++++
>  .../selftests/bpf/progs/bpf_hashmap_lookup.c  |  61 ++++
>  5 files changed, 352 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/bpf/benchs/bench_bpf_hashmap_=
lookup.c
>  create mode 100644 tools/testing/selftests/bpf/progs/bpf_hashmap_lookup.=
c
>

[...]

> +static error_t parse_arg(int key, char *arg, struct argp_state *state)
> +{
> +       long ret;
> +
> +       switch (key) {
> +       case ARG_KEY_SIZE:
> +               ret =3D strtol(arg, NULL, 10);
> +               if (ret < 1 || ret > MAX_KEY_SIZE) {
> +                       fprintf(stderr, "invalid key_size");
> +                       argp_usage(state);
> +               }
> +               args.key_size =3D ret;
> +               break;
> +       case ARG_MAP_FLAGS:
> +               if (!strncasecmp(arg, "0x", 2))
> +                       ret =3D strtol(arg, NULL, 0x10);
> +               else
> +                       ret =3D strtol(arg, NULL, 10);

if you pass base as zero, strtol() will do this for you

> +               if (ret < 0 || ret > UINT_MAX) {
> +                       fprintf(stderr, "invalid map_flags");
> +                       argp_usage(state);
> +               }
> +               args.map_flags =3D ret;
> +               break;

[...]
