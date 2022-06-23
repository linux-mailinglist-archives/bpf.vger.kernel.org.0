Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66070556FD1
	for <lists+bpf@lfdr.de>; Thu, 23 Jun 2022 03:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbiFWB0w (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Jun 2022 21:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiFWB0v (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Jun 2022 21:26:51 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D3E3DA73
        for <bpf@vger.kernel.org>; Wed, 22 Jun 2022 18:26:50 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id w19-20020a17090a8a1300b001ec79064d8dso1052128pjn.2
        for <bpf@vger.kernel.org>; Wed, 22 Jun 2022 18:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=Sz8dEWTrv7xSyBA5Tv4T6AmwPvMSqtixYJ+z5HT0wXQ=;
        b=bGGlH6WqI9cGbMCH5pZvMjXpsrJBd3oD9NYZpsyW4nQTICx7iojzzyo/eNUJK8cmDo
         PAM1Mjk+RN9YYvbBpwT9FUGLl1nVzsWI/PVIuv5RhLh2zmHtiFR8Oxz48oW5GFfEZMcN
         7fVmNYaYxJUb+bRL4gRHxTt5rpayPD7hjBVvFxZxCzFD2aTeZfUjyuPUcDlm8lIlHR7t
         zVqMaxLKQ0huSKy0O3LZio5XrGx6AEeAiPVVUeXI+gNRRpcpG8GGdowK3cnHLb7uZ09M
         137xyOYa17PFn45w2aJESNDbOu8qMpHLJeNpR9ZUMTHfBN34kO+usQ3wbCWnr4Y6FHnm
         Gacg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=Sz8dEWTrv7xSyBA5Tv4T6AmwPvMSqtixYJ+z5HT0wXQ=;
        b=XgBz+pSHu7dm/JWeXOg90NNptdIlEnUE4WUb5TGCQ3KsZF+U4NxwWk33CQ17rP9lp8
         ePd/Nr+6KHBWw2K+mJFggCfESV0LmGwjZrl/m7z4JkXl+xg69DE3r4vX/7ir88MJtX/L
         /YDyB9sCDYApjrLXq8g6srCrbzwTnBg/gpsunahBcdCk37FWxYO9OpZVYpCc8/GHt8uV
         Ct+Lkzq9CcUJoUZrrsmK5NWrREPMZ2Vj6kfl22XkfdTppISv0oGAmr4uKIcbzwxCV+ST
         f2oMA//JjESkIYvci3cCxB/SnTnVU81Ac47qVOt9lGLO9cQcZf+GUUiDls5Sgl/nMWVA
         9uwA==
X-Gm-Message-State: AJIora/6eQTdM0MGZ9sZpKBNWzIG0PceUlCklsKcTdqjJcIdZocRlVzR
        I6zSS2bYR8l064PEVQMt+JA=
X-Google-Smtp-Source: AGRyM1sjAwtofGZiPRHctVAD//ZbGbW+t1x2JD8vEvzZS5/D6ADE2xFrgi+Afi4oLYk3RvwdNP9RYQ==
X-Received: by 2002:a17:902:ecd0:b0:16a:2c0f:3a1a with SMTP id a16-20020a170902ecd000b0016a2c0f3a1amr15398511plh.108.1655947609903;
        Wed, 22 Jun 2022 18:26:49 -0700 (PDT)
Received: from localhost ([98.97.116.244])
        by smtp.gmail.com with ESMTPSA id b19-20020a62a113000000b0051b9ac5a377sm14346238pff.213.2022.06.22.18.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 18:26:49 -0700 (PDT)
Date:   Wed, 22 Jun 2022 18:26:46 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Martin KaFai Lau <kafai@fb.com>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>
Message-ID: <62b3c156ad70a_6a3b2208d7@john.notmuch>
In-Reply-To: <20220622172632.psejkta24nwz3k5m@kafai-mbp.dhcp.thefacebook.com>
References: <20220620222554.270578-1-davemarchevsky@fb.com>
 <62b21962dc64_1627420844@john.notmuch>
 <20220622002952.6334ieb3kfysx7vl@kafai-mbp>
 <62b2ad7a21e88_34dc820812@john.notmuch>
 <20220622172632.psejkta24nwz3k5m@kafai-mbp.dhcp.thefacebook.com>
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

Martin KaFai Lau wrote:
> On Tue, Jun 21, 2022 at 10:49:46PM -0700, John Fastabend wrote:
> > Martin KaFai Lau wrote:
> > > On Tue, Jun 21, 2022 at 12:17:54PM -0700, John Fastabend wrote:
> > > > > Hashmap Control
> > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > >         num keys: 10
> > > > > hashmap (control) sequential    get:  hits throughput: 20.900 =C2=
=B1 0.334 M ops/s, hits latency: 47.847 ns/op, important_hits throughput:=
 20.900 =C2=B1 0.334 M ops/s
> > > > > =

> > > > >         num keys: 1000
> > > > > hashmap (control) sequential    get:  hits throughput: 13.758 =C2=
=B1 0.219 M ops/s, hits latency: 72.683 ns/op, important_hits throughput:=
 13.758 =C2=B1 0.219 M ops/s
> > > > > =

> > > > >         num keys: 10000
> > > > > hashmap (control) sequential    get:  hits throughput: 6.995 =C2=
=B1 0.034 M ops/s, hits latency: 142.959 ns/op, important_hits throughput=
: 6.995 =C2=B1 0.034 M ops/s
> > > > > =

> > > > >         num keys: 100000
> > > > > hashmap (control) sequential    get:  hits throughput: 4.452 =C2=
=B1 0.371 M ops/s, hits latency: 224.635 ns/op, important_hits throughput=
: 4.452 =C2=B1 0.371 M ops/s
> > > > > =

> > > > >         num keys: 4194304
> > > > > hashmap (control) sequential    get:  hits throughput: 3.043 =C2=
=B1 0.033 M ops/s, hits latency: 328.587 ns/op, important_hits throughput=
: 3.043 =C2=B1 0.033 M ops/s
> > > > > =

> > > > =

> > > > Why is the hashmap lookup not constant with the number of keys? I=
t looks
> > > > like its prepopulated without collisions so I wouldn't expect any=

> > > > extra ops on the lookup side after looking at the code quickly.
> > > It may be due to the cpu-cache misses as the map grows.
> > =

> > Maybe but, values are just ints so even 1k * 4B =3D 4kB should be
> > inside an otherwise unused server class system. Would be more
> > believable (to me at least) if the drop off happened at 100k or
> > more.
> It is not only value (and key) size.  There is overhead.
> htab_elem alone is 48bytes.  key and value need to 8bytes align also.
> =


Right late night math didn't add up. Now I'm wondering if we can make
hashmap behave much better, that drop off is looking really ugly.

> From a random machine:
> lscpu -C
> NAME ONE-SIZE ALL-SIZE WAYS TYPE        LEVEL  SETS PHY-LINE COHERENCY-=
SIZE
> L1d       32K     576K    8 Data            1    64        1           =
  64
> L1i       32K     576K    8 Instruction     1    64        1           =
  64
> L2         1M      18M   16 Unified         2  1024        1           =
  64
> L3      24.8M    24.8M   11 Unified         3 36864        1           =
  64

Could you do a couple more data point then, num keys=3D100,200,400? I wou=
ld
expect those to fit in the cache and be same as 10 by the cache theory. I=

could try as well but looking like Friday before I have a spare moment.

Thanks,
John=
