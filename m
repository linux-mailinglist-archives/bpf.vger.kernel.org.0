Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB7256CD3A
	for <lists+bpf@lfdr.de>; Sun, 10 Jul 2022 07:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiGJFX2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 10 Jul 2022 01:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiGJFX2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 10 Jul 2022 01:23:28 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40EE120B2
        for <bpf@vger.kernel.org>; Sat,  9 Jul 2022 22:23:26 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id g1so2789794edb.12
        for <bpf@vger.kernel.org>; Sat, 09 Jul 2022 22:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xbIxivya81dB9dOtWxKUjG49nCVClihiUDoOdjXiRno=;
        b=iY/Wh87X1E4J+7otRN7YIHVcyAA+CExZGlq+1bEArMnqsyf+nvqyy3BWX1QIFHMCfO
         jjQ2uiT7QIJ3yG6e6pG+0KTc+MhyFHYC8iTGxBPMOWcjZm1GWyQcJzXtaxv5MqGKNWzz
         Tauz7MJuuv17yn4/ydM4bG27kwFuP4J+GxG8mzDBD4bJFPYh7fZEZlAK7nlJxzDuCM7p
         EBo44PxHZuU7NUyb+wfrSvKpmzcVAcviCBRuGFD/Gj+3xWhbc5+nBFS+2Bw9xhYmZemn
         /Lgac+Sm8utMYwB53RKjapCocqpBhcUQINkvSIBN3fkjyAkLksc63OCEB/ThbhmGv9DK
         9zCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xbIxivya81dB9dOtWxKUjG49nCVClihiUDoOdjXiRno=;
        b=VZ0IgoAi5A4m8fGehNaX1iPxN/ly111G5WzrENJ1jdatvhW2SdQeULhW880q2u8pu3
         mkyGaXqt9beaAIdJzl62SY+bDG97yofEj/N7QEW2kFOC8sGZX6SR5vOkkS3hNezjQ9qZ
         G8gL30rmxj6Q3FoR+hrhnwn+dEXytjVD4ym2OHqo9+UIZZeIBDc1avphRGGHQDJ8xlCd
         z4GeAyNgwxouEJtbHZQtm62kvr0hqt9+2HSEgVrLqdfsvN2zEyR+PkEOvir9YKtOpmbv
         sBPFHaXf1v3o8lAPsPRYd7mtU6YQZpabs6qj+HZapM3uQKUYFMz4ETuCyNZB46hAKuZt
         otfg==
X-Gm-Message-State: AJIora9vwIDolfveDJskhuO5ieNPi+gYo9ohrsgr0ews7zR+gGvpPGdd
        laRCkwcLRXZWs0gifttONqneWC9tc9qGkQ6rlG/mWIf4+M0=
X-Google-Smtp-Source: AGRyM1tNQuhHs6tTos/XbsqpravP1D2eCWW6CEgUL+k1T+Ih4lyDKdp1vzbO7U0EtlRjQjcG8FNE/p30B56xNtckVmA=
X-Received: by 2002:aa7:c9d3:0:b0:43a:67b9:6eea with SMTP id
 i19-20020aa7c9d3000000b0043a67b96eeamr15875352edt.94.1657430605400; Sat, 09
 Jul 2022 22:23:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220708060416.1788789-1-arilou@gmail.com> <20220708060416.1788789-2-arilou@gmail.com>
 <CAEf4BzZkfWTQppe97E1CTLKEqgtxP9gUQqbXB1EKRm5pK_ZmDA@mail.gmail.com> <YsjtxLuTvn8DWEA6@jondnuc>
In-Reply-To: <YsjtxLuTvn8DWEA6@jondnuc>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sat, 9 Jul 2022 22:23:13 -0700
Message-ID: <CAADnVQLmAg9_StyD9_pMO0YUn-Yi1ozxfinxuQmkL0BYoTjbjw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/1] libbpf: perfbuf: allow raw access to buffers
To:     Jon Doron <arilou@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, Jon Doron <jond@wiz.io>
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

On Fri, Jul 8, 2022 at 7:54 PM Jon Doron <arilou@gmail.com> wrote:
>
> On 08/07/2022, Andrii Nakryiko wrote:
> >On Thu, Jul 7, 2022 at 11:04 PM Jon Doron <arilou@gmail.com> wrote:
> >>
> >> From: Jon Doron <jond@wiz.io>
> >>
> >> Add support for writing a custom event reader, by exposing the ring
> >> buffer state, and allowing to set it's tail.
> >>
> >> Few simple examples where this type of needed:
> >> 1. perf_event_read_simple is allocating using malloc, perhaps you want
> >>    to handle the wrap-around in some other way.
> >> 2. Since perf buf is per-cpu then the order of the events is not
> >>    guarnteed, for example:
> >>    Given 3 events where each event has a timestamp t0 < t1 < t2,
> >>    and the events are spread on more than 1 CPU, then we can end
> >>    up with the following state in the ring buf:
> >>    CPU[0] => [t0, t2]
> >>    CPU[1] => [t1]
> >>    When you consume the events from CPU[0], you could know there is
> >>    a t1 missing, (assuming there are no drops, and your event data
> >>    contains a sequential index).
> >>    So now one can simply do the following, for CPU[0], you can store
> >>    the address of t0 and t2 in an array (without moving the tail, so
> >>    there data is not perished) then move on the CPU[1] and set the
> >>    address of t1 in the same array.
> >>    So you end up with something like:
> >>    void **arr[] = [&t0, &t1, &t2], now you can consume it orderely
> >>    and move the tails as you process in order.
> >> 3. Assuming there are multiple CPUs and we want to start draining the
> >>    messages from them, then we can "pick" with which one to start with
> >>    according to the remaining free space in the ring buffer.
> >>
> >
> >All the above use cases are sufficiently advanced that you as such an
> >advanced user should be able to write your own perfbuf consumer code.
> >There isn't a lot of code to set everything up, but then you get full
> >control over all the details.
> >
> >I don't see this API as a generally useful, it feels way too low-level
> >and special for inclusion in libbpf.
> >
>
> Hi Andrii,
>
> I understand, but I was still hoping you will be willing to expose this
> API.
> libbpf has very simple and nice binding to Rust and other languages,
> implementing one of those use cases in the bindings can make things much
> simpler than using some libc or syscall APIs, instead of enjoying all
> the simplicity that you get for free in libbpf.
>
> Hope you will be willing to reconsider :)

The discussion would have been different if you mentioned that
motivation in the commit logs.
Please provide links to "Rust and other languages" code that
uses this api.
