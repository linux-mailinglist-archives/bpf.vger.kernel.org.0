Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC5DC5570FB
	for <lists+bpf@lfdr.de>; Thu, 23 Jun 2022 04:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377921AbiFWCSb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Jun 2022 22:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377918AbiFWCS3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Jun 2022 22:18:29 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE0538BEC
        for <bpf@vger.kernel.org>; Wed, 22 Jun 2022 19:18:28 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id t5so5537377eje.1
        for <bpf@vger.kernel.org>; Wed, 22 Jun 2022 19:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CY9oxi+y6NdBBCIR7GjueYjw9YZOoMj2Yx07Y8ISeas=;
        b=PfiV0VB0KJRxf5I4gEVqi7KNZnB/Q/saYrhx7mN01Zo5tzYiOEgJSZP/g6Xc5QAJD0
         ooG3IeYMrwejYgFK2lOEU2E4bKMy6ld7xkW5uQADW9QCip1x7sHwkdOqX2Du1FnMP1iM
         pc1XObH+IarF1ZnCLVBmfr/uCfvsB36Ka/LcGWT7yVp1K8sbmtD5/Q1WMEJZSRcAmQ0W
         hsz9oimIvYRdISAvlhHDHYM/KP5s4q977Rx/1ztIzKwyDdTMwgPw746IdGywkPJrL3Dt
         0WnSuRaTpKbeCB/hYhb/TszC9MFBOq8V4SQ43l3R/tU+4tyQfl3RxCrtySl8KyJflAHS
         jqrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CY9oxi+y6NdBBCIR7GjueYjw9YZOoMj2Yx07Y8ISeas=;
        b=iABOAXXNvKmP0DGR35lntLg/dukYS+LWRnzoohxsQQLJ00oPWMUQ2kLsAJxlaY2qzz
         kKJ0E1aU3W+zVtBO86F+MvEqx3u8bTWlrEqENWfIvIMpzLZAvJC+/etnq67dg8YxMu+S
         86R01Av1PpdZ5JvVAq1Ilnvif6XCJHnEJM0M9G6QaTl8/JgheDkQYxyJY3AhiC5cXYo5
         tn7rx5gIIeLZTW2mOhCnaZ71E2EfUF954u4G6Jqdue2QTeDdkgt5y4lMYJoI96oeepoN
         aWqtg+SZ//Pcr+eUj5N6aKb0AAAcxWzbAKdroCDMKOq2L3nvyKeiCxg7xhltaAnitRob
         bTdQ==
X-Gm-Message-State: AJIora9udBstAp8hJiQxZDG+b0iDwJVzmA5Z66PPMLVsE+Kd9fja3VR0
        v0CSqnU2kXwpZTAF8rrLwTzbLBGXjM98c61quUhCQxvi
X-Google-Smtp-Source: AGRyM1s9HjCk4pHEcPGlImucdPFiMRbbE4Fck2xVvLQfFbOowaXKXFHmLwN7SelX6CuQ9WTjVFFIMROV8FDaPEdo9CE=
X-Received: by 2002:a17:906:6146:b0:722:f8c4:ec9b with SMTP id
 p6-20020a170906614600b00722f8c4ec9bmr4360229ejl.708.1655950706617; Wed, 22
 Jun 2022 19:18:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220620222554.270578-1-davemarchevsky@fb.com>
 <62b21962dc64_1627420844@john.notmuch> <20220622002952.6334ieb3kfysx7vl@kafai-mbp>
 <62b2ad7a21e88_34dc820812@john.notmuch> <20220622172632.psejkta24nwz3k5m@kafai-mbp.dhcp.thefacebook.com>
 <62b3c156ad70a_6a3b2208d7@john.notmuch>
In-Reply-To: <62b3c156ad70a_6a3b2208d7@john.notmuch>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 22 Jun 2022 19:18:15 -0700
Message-ID: <CAADnVQJh0BKP3+WHQ+EmEvw3h=QS9xgR=8uk_3Zb6321xhMjtg@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next] selftests/bpf: Add benchmark for
 local_storage get
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     Martin KaFai Lau <kafai@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
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

On Wed, Jun 22, 2022 at 6:26 PM John Fastabend <john.fastabend@gmail.com> w=
rote:
>
> Martin KaFai Lau wrote:
> > On Tue, Jun 21, 2022 at 10:49:46PM -0700, John Fastabend wrote:
> > > Martin KaFai Lau wrote:
> > > > On Tue, Jun 21, 2022 at 12:17:54PM -0700, John Fastabend wrote:
> > > > > > Hashmap Control
> > > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > >         num keys: 10
> > > > > > hashmap (control) sequential    get:  hits throughput: 20.900 =
=C2=B1 0.334 M ops/s, hits latency: 47.847 ns/op, important_hits throughput=
: 20.900 =C2=B1 0.334 M ops/s
> > > > > >
> > > > > >         num keys: 1000
> > > > > > hashmap (control) sequential    get:  hits throughput: 13.758 =
=C2=B1 0.219 M ops/s, hits latency: 72.683 ns/op, important_hits throughput=
: 13.758 =C2=B1 0.219 M ops/s
> > > > > >
> > > > > >         num keys: 10000
> > > > > > hashmap (control) sequential    get:  hits throughput: 6.995 =
=C2=B1 0.034 M ops/s, hits latency: 142.959 ns/op, important_hits throughpu=
t: 6.995 =C2=B1 0.034 M ops/s
> > > > > >
> > > > > >         num keys: 100000
> > > > > > hashmap (control) sequential    get:  hits throughput: 4.452 =
=C2=B1 0.371 M ops/s, hits latency: 224.635 ns/op, important_hits throughpu=
t: 4.452 =C2=B1 0.371 M ops/s
> > > > > >
> > > > > >         num keys: 4194304
> > > > > > hashmap (control) sequential    get:  hits throughput: 3.043 =
=C2=B1 0.033 M ops/s, hits latency: 328.587 ns/op, important_hits throughpu=
t: 3.043 =C2=B1 0.033 M ops/s
> > > > > >
> > > > >
> > > > > Why is the hashmap lookup not constant with the number of keys? I=
t looks
> > > > > like its prepopulated without collisions so I wouldn't expect any
> > > > > extra ops on the lookup side after looking at the code quickly.
> > > > It may be due to the cpu-cache misses as the map grows.
> > >
> > > Maybe but, values are just ints so even 1k * 4B =3D 4kB should be
> > > inside an otherwise unused server class system. Would be more
> > > believable (to me at least) if the drop off happened at 100k or
> > > more.
> > It is not only value (and key) size.  There is overhead.
> > htab_elem alone is 48bytes.  key and value need to 8bytes align also.
> >
>
> Right late night math didn't add up. Now I'm wondering if we can make
> hashmap behave much better, that drop off is looking really ugly.
>
> > From a random machine:
> > lscpu -C
> > NAME ONE-SIZE ALL-SIZE WAYS TYPE        LEVEL  SETS PHY-LINE COHERENCY-=
SIZE
> > L1d       32K     576K    8 Data            1    64        1           =
  64
> > L1i       32K     576K    8 Instruction     1    64        1           =
  64
> > L2         1M      18M   16 Unified         2  1024        1           =
  64
> > L3      24.8M    24.8M   11 Unified         3 36864        1           =
  64
>
> Could you do a couple more data point then, num keys=3D100,200,400? I wou=
ld
> expect those to fit in the cache and be same as 10 by the cache theory. I
> could try as well but looking like Friday before I have a spare moment.

I think the benchmark achieved its goal :)
It generated plenty of interesting data.
Pulling random out of hot loop and any other improvements
can be done as follow ups.
Pushed it to bpf-next.
