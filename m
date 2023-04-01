Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAEBD6D34C6
	for <lists+bpf@lfdr.de>; Sun,  2 Apr 2023 00:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjDAWLB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 1 Apr 2023 18:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjDAWLA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 1 Apr 2023 18:11:00 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C38F7AB6
        for <bpf@vger.kernel.org>; Sat,  1 Apr 2023 15:10:59 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id eh3so103307287edb.11
        for <bpf@vger.kernel.org>; Sat, 01 Apr 2023 15:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680387058; x=1682979058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IjGKY67SRGtqSj1G77HxZ5+rLXp/TJLxNZYjr1mCBqI=;
        b=ga+lWRSJeGzNU0Csh9vFMBXYn+H6tgdT0vm6ybQ1SiJGSWR+dxS7z8L+9nN4Doa1/o
         WqJ+3cmQtmQ/82voBZ6OKEB5qZV13B6PIpSCWeBYfCUu2IECwki/3uCLU5EV2TsS7Gp6
         4RkedMfRT3Kkcy6gjGUIYWJGWFdlbfvvGIt11+NvSqIdTTWu6906vmeyvy0WJXmFUIJx
         LTKPWvBw9dK/ycsxlNBFd9tB7lM9Vg0ydM5H6wyB6ailKn/hw7vrhuUnFhRxnrXcVtDC
         LpdxG+ojmgBCoURegauZ4OtUqYBsTWTTBMMISiOuIpbHokS9OKz0O0l20FmiJSDNB76W
         8s7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680387058; x=1682979058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IjGKY67SRGtqSj1G77HxZ5+rLXp/TJLxNZYjr1mCBqI=;
        b=hVU5s13S7SNGQKjbMnNW1flIGxHXikQJ0/7VmKIM6DI+Yf5SExSLYsxWRMMYftduzX
         5CHkCsoo8EEHRQxPJKzEuFkA6FN8ttDl7z52wzlw10vzgE2zMJZXmSSilBdCeTfGf6JI
         zIw0fw7zz5S6+nNvPyXuMEX8GOif+8Hh8pwa6g+50TJCAjzOr7ntBBuq9VcW7NK9X4Da
         pL36fT0F4F02j4rgLMrZnOg38Ir1v6u2h2Wk97zM+DyNhKar2Z9zi/dsiiCArOIfck5A
         K5trz2qaQ7BCt5ZUwoARKdkX1eZb1T6T4QEM88xUfFx57bGqrQ4Z6iJzXJaJorqjlC1t
         W33A==
X-Gm-Message-State: AAQBX9eTCOyKz/lgJl9NsVT2t2APNG5MjAFV/bZG6hkjxXMltuZ4CqSU
        bdbGdH+C0Oe1GJKuHwQB1smoAuzqOPfBytd3ZI8=
X-Google-Smtp-Source: AKy350aNfbrtcQnDWTOv8bxZJO8G1wC3CvkLrpsH6rXSWRO6JD0fZcEpOdxNE6WmrzfD7iic/4PI22Z92rDWJts+gD4=
X-Received: by 2002:a50:f69e:0:b0:4fc:8749:cd77 with SMTP id
 d30-20020a50f69e000000b004fc8749cd77mr15755400edn.3.1680387057670; Sat, 01
 Apr 2023 15:10:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230401200602.3275-1-aspsk@isovalent.com>
In-Reply-To: <20230401200602.3275-1-aspsk@isovalent.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sat, 1 Apr 2023 15:10:46 -0700
Message-ID: <CAADnVQJpF+rYo969niqpPPh_=Sv-2jztA0GpRYBfi-jPE65ZyQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] bpf: optimize hashmap lookups when key_size
 is divisible by 4
To:     Anton Protopopov <aspsk@isovalent.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Apr 1, 2023 at 1:05=E2=80=AFPM Anton Protopopov <aspsk@isovalent.co=
m> wrote:
>
> The BPF hashmap uses the jhash() hash function. There is an optimized ver=
sion
> of this hash function which may be used if hash size is a multiple of 4. =
Apply
> this optimization to the hashmap in a similar way as it is done in the bl=
oom
> filter map.
>
> On practice the optimization is only noticeable for smaller key sizes, wh=
ich,
> however, is sufficient for many applications. An example is listed in the
> following table of measurements (a hashmap of 65536 elements was used):
>
>     --------------------------------------------------------------------
>     | key_size | fullness | lookups /sec | lookups (opt) /sec |   gain |
>     --------------------------------------------------------------------
>     |        4 |      25% |      42.990M |            46.000M |   7.0% |
>     |        4 |      50% |      37.910M |            39.094M |   3.1% |
>     |        4 |      75% |      34.486M |            36.124M |   4.7% |
>     |        4 |     100% |      31.760M |            32.719M |   3.0% |
>     --------------------------------------------------------------------
>     |        8 |      25% |      43.855M |            49.626M |  13.2% |
>     |        8 |      50% |      38.328M |            42.152M |  10.0% |
>     |        8 |      75% |      34.483M |            38.088M |  10.5% |
>     |        8 |     100% |      31.306M |            34.686M |  10.8% |
>     --------------------------------------------------------------------
>     |       12 |      25% |      38.398M |            43.770M |  14.0% |
>     |       12 |      50% |      33.336M |            37.712M |  13.1% |
>     |       12 |      75% |      29.917M |            34.440M |  15.1% |
>     |       12 |     100% |      27.322M |            30.480M |  11.6% |
>     --------------------------------------------------------------------
>     |       16 |      25% |      41.491M |            41.921M |   1.0% |
>     |       16 |      50% |      36.206M |            36.474M |   0.7% |
>     |       16 |      75% |      32.529M |            33.027M |   1.5% |
>     |       16 |     100% |      29.581M |            30.325M |   2.5% |
>     --------------------------------------------------------------------
>     |       20 |      25% |      34.240M |            36.787M |   7.4% |
>     |       20 |      50% |      30.328M |            32.663M |   7.7% |
>     |       20 |      75% |      27.536M |            29.354M |   6.6% |
>     |       20 |     100% |      24.847M |            26.505M |   6.7% |
>     --------------------------------------------------------------------
>     |       24 |      25% |      36.329M |            40.608M |  11.8% |
>     |       24 |      50% |      31.444M |            35.059M |  11.5% |
>     |       24 |      75% |      28.426M |            31.452M |  10.6% |
>     |       24 |     100% |      26.278M |            28.741M |   9.4% |
>     --------------------------------------------------------------------
>     |       28 |      25% |      31.540M |            31.944M |   1.3% |
>     |       28 |      50% |      27.739M |            28.063M |   1.2% |
>     |       28 |      75% |      24.993M |            25.814M |   3.3% |
>     |       28 |     100% |      23.513M |            23.500M |  -0.1% |
>     --------------------------------------------------------------------
>     |       32 |      25% |      32.116M |            33.953M |   5.7% |
>     |       32 |      50% |      28.879M |            29.859M |   3.4% |
>     |       32 |      75% |      26.227M |            26.948M |   2.7% |
>     |       32 |     100% |      23.829M |            24.613M |   3.3% |
>     --------------------------------------------------------------------
>     |       64 |      25% |      22.535M |            22.554M |   0.1% |
>     |       64 |      50% |      20.471M |            20.675M |   1.0% |
>     |       64 |      75% |      19.077M |            19.146M |   0.4% |
>     |       64 |     100% |      17.710M |            18.131M |   2.4% |
>     --------------------------------------------------------------------
>
> The following script was used to gather the results (SMT & frequency off)=
:
>
>     cd tools/testing/selftests/bpf
>     for key_size in 4 8 12 16 20 24 28 32 64; do
>             for nr_entries in `seq 16384 16384 65536`; do
>                     fullness=3D$(printf '%3s' $((nr_entries*100/65536)))
>                     echo -n "key_size=3D$key_size: $fullness% full: "
>                     sudo ./bench -d2 -a bpf-hashmap-lookup --key_size=3D$=
key_size --nr_entries=3D$nr_entries --max_entries=3D65536 --nr_loops=3D2000=
000 --map_flags=3D0x40 | grep cpu
>             done
>             echo
>     done
>
> Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> ---
>
> v1->v2:
>   - simplify/optimize code by just testing the (key_len%4 =3D=3D 0) in ho=
t path (Alexei)
>
>  kernel/bpf/hashtab.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 96b645bba3a4..00c253b84bf5 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -607,6 +607,8 @@ static struct bpf_map *htab_map_alloc(union bpf_attr =
*attr)
>
>  static inline u32 htab_map_hash(const void *key, u32 key_len, u32 hashrn=
d)
>  {
> +       if (likely(key_len % 4 =3D=3D 0))
> +               return jhash2(key, key_len / 4, hashrnd);
>         return jhash(key, key_len, hashrnd);
>  }

This looks much cleaner than v1. Applied.

Do you mind doing similar patch for bloomfilter?
(removing aligned_u32_count variable)
