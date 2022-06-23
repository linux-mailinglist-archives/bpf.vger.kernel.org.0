Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD4965571D4
	for <lists+bpf@lfdr.de>; Thu, 23 Jun 2022 06:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiFWEjm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jun 2022 00:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238408AbiFWD10 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Jun 2022 23:27:26 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805652FFCD
        for <bpf@vger.kernel.org>; Wed, 22 Jun 2022 20:27:25 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id p14so12169836pfh.6
        for <bpf@vger.kernel.org>; Wed, 22 Jun 2022 20:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=PYLf+McgE1v7VZmfEmle34zbko4zETjKip0SRez/UOg=;
        b=pezrpDAAMRBLAkuapdHVaP/tmYgvU5TLDp6emyGNXqQIzvK4XD1gVYfZqkrXpj9VNM
         o7QlkBMSq+5OogWJU88IAplqWQ0fHvCdDNS36gUtEIGuJSfIkahEV0Df9b+TZxjaqwC/
         mPnP+GHcvBJw338OeMiKQ/r0UaggWfLzOkQBZ/hXEavu1961n3DuifeK5xkhaMDagW9l
         jMRxTzznhrZEFgeNCTe30rbgognlN6rrzy78knBk3O/bTpkIZNgsnPb9QpeGXsYZPWsK
         32JXoWoAK6va9PcmYZiFyRpOCGCNap4mfS1PUjQvwU9WDHu13ETKbTZp/QesZiLRJNWf
         Zmgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=PYLf+McgE1v7VZmfEmle34zbko4zETjKip0SRez/UOg=;
        b=j9bpC/R6maMStBz8gqZC/2l8EGRxyxCOp1+bAlBvT0i717pPlhKi2+r5ZAE9+ZrSR7
         12/XluKImtokaVg9lm6duUYcwgRm3F5vJPtFyy3TaFJpeKp7JyFGY32rd8xr9H6vUFOK
         cKOcV1+rqSvgm5imNrdppXNraIcRb7wyFdU/MCQc5DN9Yj6J8T3HrdwUe+eX0MXB22Cv
         DT0ofB7aaiKfGtTU14MtZ7iUOQ+Pubj4Av8019PQIJhI5L38/V/8nDhIL8XEQynI3vdG
         wgptrcBOxfYkrNhRWntDXVuE0rtJwB3DLZTbaQdk5gUrHPu6zxtzAevOGrusVjg8MaYM
         bDcQ==
X-Gm-Message-State: AJIora8zVzIy4s5r8v6o4P2xHSqG8p0Y5eQ+a/Ahaiumny3bfltyTB1K
        /HZW5/6aPhKJwudGJpgR9Wo=
X-Google-Smtp-Source: AGRyM1vUSciN+g0qPK6mHutgB8uHuW9WlntLXGZg8bBqbl6xKf/MY35zjnvpVYdKZG11Ol6T1lRyKA==
X-Received: by 2002:a65:6a94:0:b0:40c:977c:9665 with SMTP id q20-20020a656a94000000b0040c977c9665mr5788677pgu.5.1655954844897;
        Wed, 22 Jun 2022 20:27:24 -0700 (PDT)
Received: from localhost ([98.97.116.244])
        by smtp.gmail.com with ESMTPSA id b8-20020a17090a010800b001ecd9a69933sm561626pjb.34.2022.06.22.20.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 20:27:24 -0700 (PDT)
Date:   Wed, 22 Jun 2022 20:27:23 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Dave Marchevsky <davemarchevsky@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>
Message-ID: <62b3dd9b8249b_6a3b2208a4@john.notmuch>
In-Reply-To: <31bba044-6bb0-1a78-d706-f9fd9fbb1e2c@fb.com>
References: <20220620222554.270578-1-davemarchevsky@fb.com>
 <62b21962dc64_1627420844@john.notmuch>
 <20220622002952.6334ieb3kfysx7vl@kafai-mbp>
 <62b2ad7a21e88_34dc820812@john.notmuch>
 <20220622172632.psejkta24nwz3k5m@kafai-mbp.dhcp.thefacebook.com>
 <62b3c156ad70a_6a3b2208d7@john.notmuch>
 <31bba044-6bb0-1a78-d706-f9fd9fbb1e2c@fb.com>
Subject: Re: [PATCH v6 bpf-next] selftests/bpf: Add benchmark for
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
> On 6/22/22 9:26 PM, John Fastabend wrote:   =

> > Martin KaFai Lau wrote:
> >> On Tue, Jun 21, 2022 at 10:49:46PM -0700, John Fastabend wrote:
> >>> Martin KaFai Lau wrote:
> >>>> On Tue, Jun 21, 2022 at 12:17:54PM -0700, John Fastabend wrote:
> >>>>>> Hashmap Control
> >>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>>>>         num keys: 10
> >>>>>> hashmap (control) sequential    get:  hits throughput: 20.900 =C2=
=B1 0.334 M ops/s, hits latency: 47.847 ns/op, important_hits throughput:=
 20.900 =C2=B1 0.334 M ops/s
> >>>>>>
> >>>>>>         num keys: 1000
> >>>>>> hashmap (control) sequential    get:  hits throughput: 13.758 =C2=
=B1 0.219 M ops/s, hits latency: 72.683 ns/op, important_hits throughput:=
 13.758 =C2=B1 0.219 M ops/s
> >>>>>>
> >>>>>>         num keys: 10000
> >>>>>> hashmap (control) sequential    get:  hits throughput: 6.995 =C2=
=B1 0.034 M ops/s, hits latency: 142.959 ns/op, important_hits throughput=
: 6.995 =C2=B1 0.034 M ops/s
> >>>>>>
> >>>>>>         num keys: 100000
> >>>>>> hashmap (control) sequential    get:  hits throughput: 4.452 =C2=
=B1 0.371 M ops/s, hits latency: 224.635 ns/op, important_hits throughput=
: 4.452 =C2=B1 0.371 M ops/s
> >>>>>>
> >>>>>>         num keys: 4194304
> >>>>>> hashmap (control) sequential    get:  hits throughput: 3.043 =C2=
=B1 0.033 M ops/s, hits latency: 328.587 ns/op, important_hits throughput=
: 3.043 =C2=B1 0.033 M ops/s
> >>>>>>
> >>>>>
> >>>>> Why is the hashmap lookup not constant with the number of keys? I=
t looks
> >>>>> like its prepopulated without collisions so I wouldn't expect any=

> >>>>> extra ops on the lookup side after looking at the code quickly.
> >>>> It may be due to the cpu-cache misses as the map grows.
> >>>
> >>> Maybe but, values are just ints so even 1k * 4B =3D 4kB should be
> >>> inside an otherwise unused server class system. Would be more
> >>> believable (to me at least) if the drop off happened at 100k or
> >>> more.
> >> It is not only value (and key) size.  There is overhead.
> >> htab_elem alone is 48bytes.  key and value need to 8bytes align also=
.
> >>
> > =

> > Right late night math didn't add up. Now I'm wondering if we can make=

> > hashmap behave much better, that drop off is looking really ugly.
> > =

> >> From a random machine:
> >> lscpu -C
> >> NAME ONE-SIZE ALL-SIZE WAYS TYPE        LEVEL  SETS PHY-LINE COHEREN=
CY-SIZE
> >> L1d       32K     576K    8 Data            1    64        1        =
     64
> >> L1i       32K     576K    8 Instruction     1    64        1        =
     64
> >> L2         1M      18M   16 Unified         2  1024        1        =
     64
> >> L3      24.8M    24.8M   11 Unified         3 36864        1        =
     64
> > =

> > Could you do a couple more data point then, num keys=3D100,200,400? I=
 would
> > expect those to fit in the cache and be same as 10 by the cache theor=
y. I
> > could try as well but looking like Friday before I have a spare momen=
t.
> > =

> > Thanks,
> > John
> =

> Here's a benchmark run with those num_keys.
> =

> Hashmap Control
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>         num keys: 10
> hashmap (control) sequential    get:  hits throughput: 23.072 =C2=B1 0.=
208 M ops/s, hits latency: 43.343 ns/op, important_hits throughput: 23.07=
2 =C2=B1 0.208 M ops/s
> =

>         num keys: 100
> hashmap (control) sequential    get:  hits throughput: 17.967 =C2=B1 0.=
236 M ops/s, hits latency: 55.659 ns/op, important_hits throughput: 17.96=
7 =C2=B1 0.236 M ops/s
> =


Hmmm this is interesting. I expected a flat line and then a hard drop off=

which to me would indicate the cache miss being the culprit. But this is
almost a linear perf dec over num_keys. Guess we need to debug more.

>         num keys: 200
> hashmap (control) sequential    get:  hits throughput: 17.812 =C2=B1 0.=
428 M ops/s, hits latency: 56.143 ns/op, important_hits throughput: 17.81=
2 =C2=B1 0.428 M ops/s
> =

>         num keys: 300
> hashmap (control) sequential    get:  hits throughput: 17.070 =C2=B1 0.=
293 M ops/s, hits latency: 58.582 ns/op, important_hits throughput: 17.07=
0 =C2=B1 0.293 M ops/s
> =

>         num keys: 400
> hashmap (control) sequential    get:  hits throughput: 17.667 =C2=B1 0.=
316 M ops/s, hits latency: 56.604 ns/op, important_hits throughput: 17.66=
7 =C2=B1 0.316 M ops/s
> =

>         num keys: 500
> hashmap (control) sequential    get:  hits throughput: 17.010 =C2=B1 0.=
409 M ops/s, hits latency: 58.789 ns/op, important_hits throughput: 17.01=
0 =C2=B1 0.409 M ops/s
> =

>         num keys: 1000
> hashmap (control) sequential    get:  hits throughput: 14.330 =C2=B1 0.=
172 M ops/s, hits latency: 69.784 ns/op, important_hits throughput: 14.33=
0 =C2=B1 0.172 M ops/s
> =

>         num keys: 10000
> hashmap (control) sequential    get:  hits throughput: 6.047 =C2=B1 0.0=
24 M ops/s, hits latency: 165.380 ns/op, important_hits throughput: 6.047=
 =C2=B1 0.024 M ops/s
> =

>         num keys: 100000
> hashmap (control) sequential    get:  hits throughput: 4.472 =C2=B1 0.1=
63 M ops/s, hits latency: 223.630 ns/op, important_hits throughput: 4.472=
 =C2=B1 0.163 M ops/s
> =

>         num keys: 4194304
> hashmap (control) sequential    get:  hits throughput: 2.785 =C2=B1 0.0=
24 M ops/s, hits latency: 359.066 ns/op, important_hits throughput: 2.785=
 =C2=B1 0.024 M ops/s


