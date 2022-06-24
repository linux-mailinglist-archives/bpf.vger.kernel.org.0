Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89A755A09F
	for <lists+bpf@lfdr.de>; Fri, 24 Jun 2022 20:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbiFXSVn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Jun 2022 14:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiFXSVm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Jun 2022 14:21:42 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F63256C3D
        for <bpf@vger.kernel.org>; Fri, 24 Jun 2022 11:21:42 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id u12so6291758eja.8
        for <bpf@vger.kernel.org>; Fri, 24 Jun 2022 11:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JK++XilAEHLY0yZoDY3RtErcoXp7VO8VHkVXB4yXcIY=;
        b=nmQxQV95IPnZD/Idv5sknPi/hRKtc6Gfu+iU64lHcvyMIA9GgHiIJ6sycPWUiXT0GJ
         1tf/RJSissBvlpNCSVEbX12y30dCnLEoqto5t4Fxu9C75raa2zoshgLydCmW3saWXPtO
         WQ9WxIqrtl746nvyanEDzV3S/K+8zkO4DE+wsTEntpzk5qJZJ87jzKG8du2fq0985EMU
         VNsT00ZU2lFuSfbuB9FZO/1jw/P8fjNPasLsdR23JBLMXqWaPNa58AnpoxVHRucpXu5+
         CQH/k5YHAaroovLZ235aQvzTd6GkPCvgk+4mitE7henfitERB4izeeqUFzK5ep/o2oBB
         jRBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JK++XilAEHLY0yZoDY3RtErcoXp7VO8VHkVXB4yXcIY=;
        b=RNKmklYOcCret/17O1pC3MSr2xLQJFjYNpDUh9ADSwesw8zHMCBVx2gf/tNvwb6WDk
         3JaZH/0383fDL3aLPQqsNB/TmyMJQJKThNd9M/w+/kbGo9nSUACNE4IUGxey7bDKf7wK
         PMdyXVaJ7zgPrukh1mwQuwXKIGrK+m7NtpLzrrrqe4HL3DMaHa/WCzotNqH6+NaM/kPL
         ECoKRy1ztonJlBl+FLzNIAOyMJwhJT2ZjvDabJDoU0QTscAi5nrnHOofdc9aHUcjB6Fv
         pey7Q61cvN/W++UplzK1bUISVvQhShiV0dXY771EksIvIqbY91Lj9BHtRwT3z/p7/bWY
         9oiQ==
X-Gm-Message-State: AJIora9m6NuChi4Uf1rZtekkqZyxgHK5BAp4H2c648zFncMPiemXSojY
        bAZX4TEgSjOfoss56KxoeuN7iy0IHNyMZ0qeru8=
X-Google-Smtp-Source: AGRyM1twOzMCenKuiPMdFlfXQjPdX9cluTZws7PZE+B4UZwMv0jRijh79vfdZu7jQF9JnF06Bo2uOewefzCXrj5GsH8=
X-Received: by 2002:a17:906:58ca:b0:722:f12b:a0e4 with SMTP id
 e10-20020a17090658ca00b00722f12ba0e4mr267426ejs.545.1656094900606; Fri, 24
 Jun 2022 11:21:40 -0700 (PDT)
MIME-Version: 1.0
References: <CANqewP1RFzD9TWgyyZy00ZVQhQr8QjmjUgyaaNK0g0_GJse=KA@mail.gmail.com>
 <CANqewP0cDTXVf1ekJTvaetB1DGkEKu56_H8dPjVQqxSvHfPziA@mail.gmail.com>
 <CAEf4BzaSc_nMrYr3YvSnwEXhzhiUjkQ=-zOnyyH0jqeH__w9JA@mail.gmail.com> <CANqewP3BKc+seCaneyc+GJqf62q+aY9qcTwN276OrB0hK4faJA@mail.gmail.com>
In-Reply-To: <CANqewP3BKc+seCaneyc+GJqf62q+aY9qcTwN276OrB0hK4faJA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 24 Jun 2022 11:21:29 -0700
Message-ID: <CAEf4BzYb89M+-X55vt0NNsgTHSGbSid9BfahDfv56J2+Y82iyw@mail.gmail.com>
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

On Tue, Jun 14, 2022 at 8:31 AM Tatsuyuki Ishi <ishitatsuyuki@gmail.com> wrote:
>
> Hi Andrii,
> Thanks for looking into this.
>
> > I'd like to get to this in next few days, but meanwhile have you tried
> > to benchmark what are the implications of stricter memory ordering
> > changes on libbpf side? Do you have example changes you were thinking
> > about for libbpf side? I can try benchmarking it on my side as well.
>
> I don't have a benchmark yet. I'll try to prepare a benchmark when I
> have time to do so.
>
> The proposed change to libbpf is simply to replace the two
> smp_store_release with smp_store_mb. I just realized that the Linux
> kernel memory model doesn't have direct mappings to seq_cst loads and
> stores though, so this will lead to a redundant barrier on AArch64
> etc.

Hey Tatsuyuki,

Just to follow up on this. We do have a bunch of benchmarks in
selftests/bpf/bench, so I did run after replacing smp_store_release()
in libbpf code with atomic_store(SEQ_CST). Generally it didn't show
significant performance differences, except for "Single-producer,
back-to-back mode (rb-libbpf case)". You can run these benchmarks
yourself from selftest/bpf with just benchs/run_bench_ringbufs.sh.

But before we make any changes, can you please share a reproducer for
this issue? And which architecture (x86-64? arm64?) did you manage to
reproduce this issue on?

>
> Regards,
> Tatsuyuki
