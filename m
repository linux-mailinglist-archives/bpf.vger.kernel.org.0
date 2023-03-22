Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 631B96C58E4
	for <lists+bpf@lfdr.de>; Wed, 22 Mar 2023 22:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbjCVVjy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Mar 2023 17:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjCVVjx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Mar 2023 17:39:53 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF23113E0
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 14:39:52 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id x3so78622102edb.10
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 14:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679521191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sWD62G2mdCV8orpZNelTsZ/qyiQ3TStXFdJPyjX5x1Q=;
        b=FchTKmvKh/hhZ6U8PKvtNO7CQMmVhHLY4cPDb3cjqU65MCr0YuVKfYDnLHShB6P/On
         n3phDjrmbI0bzN1GiofBUmeNmwXMtriJz6BYk2aAN+zSTAGEzjyEW+dZGaXp9PY7ThwQ
         wjrpy4lTP1vcMTOLvt5xfN9uZRe1ijUnacinGiC0MSrZlWUMtlIyleQJsYeDx+2X17Rq
         oDvvXdpEqbJjF13K3wW4CDg+Bkm1NP4SZfvkqfkx8VdP+yfb7buZTYS5yvW1XlSbg7Bw
         exWfWB3iJcsVClQVTLx3QZXXdZvgdJXNGQjk3iqvI4fdlf5NPwxUE0ybAC1y4hXKGzhT
         EbPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679521191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sWD62G2mdCV8orpZNelTsZ/qyiQ3TStXFdJPyjX5x1Q=;
        b=NhhTMwbJwMwzWdXyfacMooNPnDwSeDT+Xzr4cBpIiAgv3kz6rw1BbhXLHzApJk0Inz
         7Us86UIquRPG3PqxjgxsE0GPC8dcXk2/qI6sD3dH43DvRXw2NIXpN1HFSfqOZUNPhjD0
         8r+0Q80wFzxFtqzePE63xR2FiKJdsjGroZe4qEGkYEEvkNplvo01uvevbFPkGBxPQ7Gy
         bz8SdZFs1H2JeCBuxCFXs1cPxG4U+ZrQpNSFG3/gNA64U0gZsG8XHLYbyF5j534PTXpH
         J243M7saHHre4PEOtGAQvjpoIakUisSKqKdNJpjZmY89xo+mV5jUdvA9xE4inJBsrsjX
         TJHA==
X-Gm-Message-State: AO0yUKVqR/FMnGDDWcMQ8fTAgu7NwQggDdEnMSZWMeYf/Iqfq5/eznFB
        RTL3r/S6ERdOJ2tMXly9CIRLHAhKU2ynUq2L2UB5Vq9G5vJ5vw==
X-Google-Smtp-Source: AK7set/fUpynTGKN30iA4mIp4xC9F6W+GAS7blt5+PxSOAE8gBqeTXtfYmfea71C889NzTS20YzFxRxjVhEYPYIbaG8=
X-Received: by 2002:a50:930d:0:b0:4fc:e5c:902 with SMTP id m13-20020a50930d000000b004fc0e5c0902mr4316456eda.8.1679521190756;
 Wed, 22 Mar 2023 14:39:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAMAi7A7+b6crWHyn9AQ+itsSh8vZ8D5=WEKatAaHj-V_4mjw-g@mail.gmail.com>
 <ZBo164Lc2eL3HUvN@krava> <CAMAi7A7Y=m=i-yEOuh-sO-5R5zEGQuo1VwOLKsgvFcv4RRhbhQ@mail.gmail.com>
 <ZBr7Jt9+yr0PHk6K@krava> <CAADnVQLCSMBhHzOgB1iYMpWVTYsKerMUJ_8MX1W+7BNveF+0tQ@mail.gmail.com>
In-Reply-To: <CAADnVQLCSMBhHzOgB1iYMpWVTYsKerMUJ_8MX1W+7BNveF+0tQ@mail.gmail.com>
From:   Davide Miola <davide.miola99@gmail.com>
Date:   Wed, 22 Mar 2023 22:39:40 +0100
Message-ID: <CAMAi7A4asgEE7MKOJC7ak4Q-wWXtfnHTtv8+x0GZ88ZUWZLMKQ@mail.gmail.com>
Subject: Re: bpf: missed fentry/fexit invocations due to implicit recursion
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 22 Mar 2023 at 17:06, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> On Wed, Mar 22, 2023 at 6:10=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wr=
ote:
> >
> > there was discussion about this some time ago:
> >   https://lore.kernel.org/bpf/CAEf4BzZ-xe-zSjbBpKLHfQKPnTRTBMA2Eg382+_4=
kQoTLnj4eQ@mail.gmail.com/
> >
> > seems the 'active' problem andrii described fits to your case as well
>
> I suspect per-cpu recursion counter will miss more events in this case,
> since _any_ kprobe on that cpu will be blocked.
> If missing events is not an issue you probably want a per-cpu counter
> that is specific to your single ip_queue_xmit attach point.

The difference between the scenario described in the linked thread
and mine is also the reason why I think in-bpf solutions like a
per-cpu guard can't work here: my programs are recursing due to irqs
interrupting them and invoking ip_queue_xmit, not because some helper
I'm using ends up calling ip_queue_xmit. Recursion can happen
anywhere in my programs, even before they get the chance to set a
flag or increment a counter in a per-cpu map, since there is no
atomic "bpf_map_lookup_and_increment" (or is there?)
