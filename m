Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F4B54A07F
	for <lists+bpf@lfdr.de>; Mon, 13 Jun 2022 22:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243550AbiFMU4Y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Jun 2022 16:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351344AbiFMUzN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Jun 2022 16:55:13 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9F96178
        for <bpf@vger.kernel.org>; Mon, 13 Jun 2022 13:26:50 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id me5so13330767ejb.2
        for <bpf@vger.kernel.org>; Mon, 13 Jun 2022 13:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uz3PI89i1c16Dbje2nGiiLeIeVtdi1Uh8uPw/mVSaYc=;
        b=OIM62TGf8NYcq809TesH0ZL/ybL6fatIYhLcKSuDzeIsltE2JL9aTPP3vsPvGQEXAa
         NKG95ePu4SwAxQFWCTbIPNwiuMTAaAeYuYFoO5ZWQDfsWc9PuVn7eUCvvyjoYqZUhwY+
         FLm2LlhKOXYsuLAaxgAabnL2dd5q7S5gSr9ytQ1hXS3CSO82KmWbXFizqfllTEmn3o4u
         bEGe92qXTcew5AvVtYirKdKRMt4jGVsVJeLkrolp76wS+Wbl90nCiCOFEHF1/ZGBxxfE
         Ar1JzRcrs5R5T+hLabVmQlpTG36Lbvk4/Amq0UUXot7XuIWRAcYprn92X4P3TvytU/lP
         xFNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uz3PI89i1c16Dbje2nGiiLeIeVtdi1Uh8uPw/mVSaYc=;
        b=dtOMS3LQgPGLdU67yr/g9swuwo17aZ0A/U4XfD4HxRkkwwQQlLEOLLMHD+f4yYDqtw
         Q+Mgt3ku3x/yvzjPj1hY8sPH31O+nEi/dNRMXMKSfCjjAc/zc90tAfGjuigK4+uMj23j
         AvcCKBrCjwbQsthahX/4/u1ypbhWFVqZH4lwGJpNR31TrqDuJABUd3Wm0BAq1341A0nz
         JcFRL9BPMrk3fsgo6x4nd6TSnuWRtd05pkDS+Whv0fvaFkyMEzTdTahnQgMo7JHrL8gE
         ej4gf9/bZ7OcbLv7CvOBV0KSfphiIxHIMR8gQqL2BGkXVQD/FkF5Hfs4S9asgjx/Q1DA
         tKuQ==
X-Gm-Message-State: AJIora8OPgXaOnXzjWJs8u35jgR+9JYhnQ7cq6OFMEFTmUN7ypaKrLAD
        +VDF1LOumtx5DNllg5IYIYaX5etZNQg7BC9TMtLTmpv35TY=
X-Google-Smtp-Source: AGRyM1uRSp6yAsfK7FJ3aWBw6pkcc8ILGvT0Hhbk1yeDsayrekVX6Rns6zwzGmlPn0qI7wsNnxYbbQ8PY2BW+0QwLO4=
X-Received: by 2002:a17:906:610:b0:715:79ac:7db9 with SMTP id
 s16-20020a170906061000b0071579ac7db9mr1316916ejb.226.1655152008788; Mon, 13
 Jun 2022 13:26:48 -0700 (PDT)
MIME-Version: 1.0
References: <CANqewP1RFzD9TWgyyZy00ZVQhQr8QjmjUgyaaNK0g0_GJse=KA@mail.gmail.com>
 <CANqewP0cDTXVf1ekJTvaetB1DGkEKu56_H8dPjVQqxSvHfPziA@mail.gmail.com>
In-Reply-To: <CANqewP0cDTXVf1ekJTvaetB1DGkEKu56_H8dPjVQqxSvHfPziA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 13 Jun 2022 13:26:37 -0700
Message-ID: <CAEf4BzaSc_nMrYr3YvSnwEXhzhiUjkQ=-zOnyyH0jqeH__w9JA@mail.gmail.com>
Subject: Re: [Resend] BPF ringbuf misses notifications due to improper coherence
To:     Tatsuyuki Ishi <ishitatsuyuki@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andriin@fb.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jun 13, 2022 at 11:42 AM Tatsuyuki Ishi <ishitatsuyuki@gmail.com> wrote:
>
> The BPF ringbuf defaults to a mechanism to deliver epoll notifications
> only when the userspace seems to "catch up" to the last written entry.
> This is done by comparing the consumer pointer to the head of the last
> written entry, and if it's equal, a notification is sent.
>
> During the effort of implementing ringbuf in aya [1] I observed that
> the epoll loop will sometimes get stuck, entering the wait state but
> never getting the notification it's supposed to get. The
> implementation originally mirrored libbpf's logic, especially its use
> of acquire and release memory operations. However, it turned out that
> the use of causal memory model is not sufficient, and using a seq_cst
> store is required to avoid anomalies as outlined below.
>
> The release-acquire ordering permits the following anomaly to happen
> (in a simplified model where writing a new entry atomically completes
> without going through busy bit):
>
> kernel: write p 2 -> read c X -> write p 3 -> read c 1 (X doesn't matter)
> user  : write c 2 -> read p 2
>
> This is because the release-acquire model allows stale reads, and in
> the case above the stale reads means that none of the causal effect
> can prevent this anomaly from happening. In order to prevent this
> anomaly, a total ordering needs to be enforced on producer and
> consumer writes. (Interestingly, it doesn't need to be enforced on
> reads, however.)
>
> If this is correct, then the fix needed right now is to correct
> libbpf's stores to be sequentially consistent. On the kernel side,
> however, we have something weird, probably inoptimal, but still
> correct. The kernel uses xchg when clearing the BUSY flag [2]. This
> doesn't sound like a necessary thing, since making the written event
> visible only require release ordering. However, it's this xchg that
> provides the other half of total ordering in order to prevent the
> anomalies, as it performs a smp_mb, essentially upgrading the prior
> store to seq_cst. If the intention was actually that, it would be
> really obscure and hard-to-reason way to implement coherency. I'd
> appreciate a clarification on this.
>
> [1]: https://github.com/aya-rs/aya/pull/294#issuecomment-1144385687
> [2]: https://github.com/torvalds/linux/blob/50fd82b3a9a9335df5d50c7ddcb81c81d358c4fc/kernel/bpf/ringbuf.c#L384


Hey Tatsuyuki,

Sorry for not getting back in time, I haven't missed or forgot about
this, it's just in my TODO queue and I haven't had time to seriously
look at this. No one has reported this for libbpf previously, but it
could be because most people specify timeout on ring_buffer__poll() so
never noticed this issue.

I need a bit more time to page in all the context and recall semantics
around smp_load_acquire/smp_store_release and stuff like that. As for
xchg, if I remember correctly it was a deliberate choice, I remember
Paul suggesting that xchg is faster for what we needed with ringbuf.

I'd like to get to this in next few days, but meanwhile have you tried
to benchmark what are the implications of stricter memory ordering
changes on libbpf side? Do you have example changes you were thinking
about for libbpf side? I can try benchmarking it on my side as well.

Thanks!
