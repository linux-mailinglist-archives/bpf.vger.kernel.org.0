Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 124385571BD
	for <lists+bpf@lfdr.de>; Thu, 23 Jun 2022 06:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiFWEjU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jun 2022 00:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237981AbiFWDZi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Jun 2022 23:25:38 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A772F677
        for <bpf@vger.kernel.org>; Wed, 22 Jun 2022 20:25:37 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id c4so836140plc.8
        for <bpf@vger.kernel.org>; Wed, 22 Jun 2022 20:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=v2RSkUJeEQqizKC3fHwsPSATGrc4wBVtuNubiPn69+g=;
        b=j7SSYu7vgHW6cVQSd1zQzQMpo7MzIZsoF5Z3xAF8Sdp4yA6oNHzXGi3z7xChK7NXnB
         n4S5sfmivvV+Ta9snr6tejSwvy+8pbxf2t8YosoM6T3y7KCTm2D1mKgoWgIvfIW99yS5
         2YAA1XivecRC85c1Xsg8sO4WIsvAA7sUrpDWWRhWPWLAC5eN/nHX1zNco/Zj8WMZviDz
         kjVV0zYUYcAkPMMiqBXEVxHpWMs9K29oIsXAuVE7hH0wR/KuoFzaiRDKVXEBEOCHNJmX
         VzxugqGy50tCKeUovl1oz+G2cJ2/S+oOp8Vy6T6hcQ22XEqbQRQEJ9xwJJwTxbHctfoa
         cEKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=v2RSkUJeEQqizKC3fHwsPSATGrc4wBVtuNubiPn69+g=;
        b=puSHooPy/+uHZ/VYQ+zS6GMebSR7TddZR584IiGqWRpXjzxLHksutDRA2fv2fQ7nQf
         HBEryLEGpfqltpRG3m+4RfsqYs2m8x7srT4TzysBYjhTioetYEN1ZuYM77KOp62K8uUU
         lo8hbgJwYfoFfP4F1U9GUQWkznZz6wyToF7n9BjFm/803nlyjKWVYLLkNEeg9MPDpAlH
         AapcQVuYplrvnu/nN2btZrcIu/l69YbDJ6B74qTyYTJwboQeYxSG7nnCGc3NvxsSKpob
         3gD9jXlp1fm4gEj3cL6rw+e0TXmsZ/ZGxv575YOcdFNqhkaJWDNu6dYRZT12IwsTZ0bD
         EjoA==
X-Gm-Message-State: AJIora9yts9VSzj9hS2q3aKf4WutFPoqa1Xs6T7vsMJ2LBAJ4cXXQNif
        g2i7gRX5c4NbGTR1NLl2qDM/ab0S55Giyw==
X-Google-Smtp-Source: AGRyM1v8iJ7/zrzx5b4J4r3pL18ZKtQ90WQr29ULFIPExelsWr2rsPNN0ScTo5LKmmjOKedVmOcqZA==
X-Received: by 2002:a17:902:f548:b0:167:5c83:3adb with SMTP id h8-20020a170902f54800b001675c833adbmr36717534plf.70.1655954736493;
        Wed, 22 Jun 2022 20:25:36 -0700 (PDT)
Received: from localhost ([98.97.116.244])
        by smtp.gmail.com with ESMTPSA id c129-20020a633587000000b0040ca00cd318sm7876489pga.40.2022.06.22.20.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 20:25:36 -0700 (PDT)
Date:   Wed, 22 Jun 2022 20:25:33 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     Martin KaFai Lau <kafai@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>
Message-ID: <62b3dd2d8f81c_6a3b22085b@john.notmuch>
In-Reply-To: <CAADnVQJh0BKP3+WHQ+EmEvw3h=QS9xgR=8uk_3Zb6321xhMjtg@mail.gmail.com>
References: <20220620222554.270578-1-davemarchevsky@fb.com>
 <62b21962dc64_1627420844@john.notmuch>
 <20220622002952.6334ieb3kfysx7vl@kafai-mbp>
 <62b2ad7a21e88_34dc820812@john.notmuch>
 <20220622172632.psejkta24nwz3k5m@kafai-mbp.dhcp.thefacebook.com>
 <62b3c156ad70a_6a3b2208d7@john.notmuch>
 <CAADnVQJh0BKP3+WHQ+EmEvw3h=QS9xgR=8uk_3Zb6321xhMjtg@mail.gmail.com>
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

Alexei Starovoitov wrote:
> On Wed, Jun 22, 2022 at 6:26 PM John Fastabend <john.fastabend@gmail.co=
m> wrote:
> >
> > Martin KaFai Lau wrote:
> > > On Tue, Jun 21, 2022 at 10:49:46PM -0700, John Fastabend wrote:
> > > > Martin KaFai Lau wrote:
> > > > > On Tue, Jun 21, 2022 at 12:17:54PM -0700, John Fastabend wrote:=

> > > > > > > Hashmap Control
> > > > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > > >         num keys: 10
> > > > > > > hashmap (control) sequential    get:  hits throughput: 20.9=
00 =C2=B1 0.334 M ops/s, hits latency: 47.847 ns/op, important_hits throu=
ghput: 20.900 =C2=B1 0.334 M ops/s
> > > > > > >
> > > > > > >         num keys: 1000
> > > > > > > hashmap (control) sequential    get:  hits throughput: 13.7=
58 =C2=B1 0.219 M ops/s, hits latency: 72.683 ns/op, important_hits throu=
ghput: 13.758 =C2=B1 0.219 M ops/s
> > > > > > >
> > > > > > >         num keys: 10000
> > > > > > > hashmap (control) sequential    get:  hits throughput: 6.99=
5 =C2=B1 0.034 M ops/s, hits latency: 142.959 ns/op, important_hits throu=
ghput: 6.995 =C2=B1 0.034 M ops/s
> > > > > > >
> > > > > > >         num keys: 100000
> > > > > > > hashmap (control) sequential    get:  hits throughput: 4.45=
2 =C2=B1 0.371 M ops/s, hits latency: 224.635 ns/op, important_hits throu=
ghput: 4.452 =C2=B1 0.371 M ops/s
> > > > > > >
> > > > > > >         num keys: 4194304
> > > > > > > hashmap (control) sequential    get:  hits throughput: 3.04=
3 =C2=B1 0.033 M ops/s, hits latency: 328.587 ns/op, important_hits throu=
ghput: 3.043 =C2=B1 0.033 M ops/s
> > > > > > >
> > > > > >
> > > > > > Why is the hashmap lookup not constant with the number of key=
s? It looks
> > > > > > like its prepopulated without collisions so I wouldn't expect=
 any
> > > > > > extra ops on the lookup side after looking at the code quickl=
y.
> > > > > It may be due to the cpu-cache misses as the map grows.
> > > >
> > > > Maybe but, values are just ints so even 1k * 4B =3D 4kB should be=

> > > > inside an otherwise unused server class system. Would be more
> > > > believable (to me at least) if the drop off happened at 100k or
> > > > more.
> > > It is not only value (and key) size.  There is overhead.
> > > htab_elem alone is 48bytes.  key and value need to 8bytes align als=
o.
> > >
> >
> > Right late night math didn't add up. Now I'm wondering if we can make=

> > hashmap behave much better, that drop off is looking really ugly.
> >
> > > From a random machine:
> > > lscpu -C
> > > NAME ONE-SIZE ALL-SIZE WAYS TYPE        LEVEL  SETS PHY-LINE COHERE=
NCY-SIZE
> > > L1d       32K     576K    8 Data            1    64        1       =
      64
> > > L1i       32K     576K    8 Instruction     1    64        1       =
      64
> > > L2         1M      18M   16 Unified         2  1024        1       =
      64
> > > L3      24.8M    24.8M   11 Unified         3 36864        1       =
      64
> >
> > Could you do a couple more data point then, num keys=3D100,200,400? I=
 would
> > expect those to fit in the cache and be same as 10 by the cache theor=
y. I
> > could try as well but looking like Friday before I have a spare momen=
t.
> =

> I think the benchmark achieved its goal :)
> It generated plenty of interesting data.
> Pulling random out of hot loop and any other improvements
> can be done as follow ups.
> Pushed it to bpf-next.

Yep just realized I hadn't ACK'd it yet. Thanks for the patches my
guess is we can improve the hashmap a bunch. FWIW we use the
hashmap as described here so wondering if we need to cut over to
task storage or just make hashmap better at large values.=
