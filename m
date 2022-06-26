Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF0D55B0F2
	for <lists+bpf@lfdr.de>; Sun, 26 Jun 2022 11:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233714AbiFZJ4K (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 26 Jun 2022 05:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbiFZJ4J (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 26 Jun 2022 05:56:09 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFE3E0D0
        for <bpf@vger.kernel.org>; Sun, 26 Jun 2022 02:56:08 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id x184so9199091ybg.12
        for <bpf@vger.kernel.org>; Sun, 26 Jun 2022 02:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YF7F+1uu6Hd34nk6kcwI4H8bv8hGT79nfRBb3+nWXjc=;
        b=B63tP8eLixApgmGC4qG1ieyLhoPPbV8WfRNYZXAnPT99HGNqcflzyvGCjvyPiE4nOd
         R0HsgFUhEVVhPTYDi2JhYLsOqAT8S7EXNIPr/vym45kiL9EefbqBvwxdE0vh/xw5tGtP
         j44pCn3y50c0K+lTdq4yKNntkmLu3NTO/3YEitBDNtsNsVK1UMZqfx+DByhCj2V/5pmC
         w8iauqqAqi6DwNSnl+ObzBAKjlZf/Unl9iAwPJKKXRr/xldRl6NG+tvf/GJP6I/Um08i
         ZO/NUnwEUjM3PpHb563UN6xI4yPxGaMQJkYEGnor5Fq+rr2d3amRDRbV30CS+6+KtiKI
         H0aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YF7F+1uu6Hd34nk6kcwI4H8bv8hGT79nfRBb3+nWXjc=;
        b=vqRfgI9AeqEv8oS85pCVfM0+wTheYHBlNb7xqnn9rGW/A5P5MDPVp6zHqnC/eits6S
         oh8T+o9tRa25XZLkcgxDFKvQgaheocPzN2M917gaWehsge1s5+Ze48EpiQbOzBKAQza5
         uwb2y59ogWkjzj0MxVc/nnRyzA9O4Fky82GVDUx/8151ChF7IZUDmu2tQWm1ECreHSYP
         RC1ttLk4MwIQ8DIbQEOsHSyyuGTYbXN1DPBT+tixVK89Mg6CrwMNKl8Ieele34Nyf95N
         QyYv8PQZoz7JTpsO6X9GIMPNaoRoNO0L2FqDTkPvvHbLvHA1VC/gthGaF7HQOgJRvDbb
         7SUQ==
X-Gm-Message-State: AJIora8Sy8CHOFz7Z15O4pbfcaZjCZb447YFEeMNLk43+yt9Qcp0/8Rg
        r8DE65U/u6u+7sDoTim1qc555zeX4th0ZF3tlK0=
X-Google-Smtp-Source: AGRyM1vJv8tE2h62fEtKWLQ5BUmyGOsdwQ+MRCNYVtu2Vq8d8QbPgbDh1EjCTG7m//SVZ6c5EEydHz/XnA+/jVAqwxE=
X-Received: by 2002:a25:d6c1:0:b0:669:aa6f:38e8 with SMTP id
 n184-20020a25d6c1000000b00669aa6f38e8mr7867175ybg.586.1656237367870; Sun, 26
 Jun 2022 02:56:07 -0700 (PDT)
MIME-Version: 1.0
References: <CANqewP1RFzD9TWgyyZy00ZVQhQr8QjmjUgyaaNK0g0_GJse=KA@mail.gmail.com>
 <CANqewP0cDTXVf1ekJTvaetB1DGkEKu56_H8dPjVQqxSvHfPziA@mail.gmail.com>
 <CAEf4BzaSc_nMrYr3YvSnwEXhzhiUjkQ=-zOnyyH0jqeH__w9JA@mail.gmail.com>
 <CANqewP3BKc+seCaneyc+GJqf62q+aY9qcTwN276OrB0hK4faJA@mail.gmail.com> <CAEf4BzYb89M+-X55vt0NNsgTHSGbSid9BfahDfv56J2+Y82iyw@mail.gmail.com>
In-Reply-To: <CAEf4BzYb89M+-X55vt0NNsgTHSGbSid9BfahDfv56J2+Y82iyw@mail.gmail.com>
From:   Tatsuyuki Ishi <ishitatsuyuki@gmail.com>
Date:   Sun, 26 Jun 2022 18:55:56 +0900
Message-ID: <CANqewP0ne0vmPydNFMY=4ProLr3Y_5j7Fnhk+m4V3sdsuofMJw@mail.gmail.com>
Subject: Re: [Resend] BPF ringbuf misses notifications due to improper coherence
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
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

Hi Andrii,

> But before we make any changes, can you please share a reproducer for
> this issue? And which architecture (x86-64? arm64?) did you manage to
> reproduce this issue on?

I have uploaded an reproducer here:
https://github.com/ishitatsuyuki/bpf-ringbuf-examples

First, I only modified the ringbuf-output sample, so please go into
src and do `make ringbuf-output`.

Second, it turned out that libbpf was actually immune to the issue due
to it using epoll in the level-triggered mode. Presumably, epoll first
does some internal locking which acts as a global memory barrier, then
it proceeds on checking the ringbuf pointers again, which effectively
prevent the anomalies. When ET is used, epoll instead waits for the
wakeup without double checking the ringbuf pointers, allowing the
anomaly to happen.

In the reproducer above, I've modified the libbpf submodule to use
EPOLLET, so that it does reproduce the phenomenon I was talking about,
but this also means that this is not an issue with libbpf per se.
Still, relying on the implicit synchronization of epoll is rather
ugly, and can cause confusion when trying to re-implement the logic
using libbpf as the reference.

The reproducer should get "stuck" in a few seconds when running on
x86-64; I don't have an AArch64 machine to test on, but as far as I
understand the acq/rel instructions gets promoted to seq_cst on those,
so this issue simply cannot surface on AArch64.

Tatsuyuki
