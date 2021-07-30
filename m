Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 025143DBBBC
	for <lists+bpf@lfdr.de>; Fri, 30 Jul 2021 17:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239142AbhG3PJW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Jul 2021 11:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239030AbhG3PJV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Jul 2021 11:09:21 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36935C06175F
        for <bpf@vger.kernel.org>; Fri, 30 Jul 2021 08:09:17 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id ba4so2679395vsb.5
        for <bpf@vger.kernel.org>; Fri, 30 Jul 2021 08:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j9/a7+t9MG8o7AYvrOOmnuKmHpvB+vlubq5mK0wGp/8=;
        b=C3SCPd5UF67ci5jibg0YRSRub77HHgvJdWBeGoSB6jd3T2ywMBbeoaoQjZ/F/pwz+H
         3A9dz07y+ZH1ob1Qaw1iMgBrGRYfRJzppB5KibnX/nkBBCKAPHtR3zQTkjqW8IFM00Zm
         SwQBxWgLdjvG6jP6yzuTHswWeRhJsan2gOCS/6q6BDdHmQbQLuhEAF91erJRYSnEOZC4
         ZVJnoYOeRuTeHo2ZBa5YngtcGmQ9hr2UIzWp5LWGSVxJt8XhiFHNFC3U7BQcQRjeVBMS
         XGdGlbJfYEaMXFlRSKBbwnyCB0HwH+NMoOSALa5756svxR0cEunqcP4m2LfZQaqKymR0
         2BQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j9/a7+t9MG8o7AYvrOOmnuKmHpvB+vlubq5mK0wGp/8=;
        b=Ibr0pTbxgZs+aTGHHqMzNpm15U+xT66qWLEd8wP6Fx4REvjjhdIQrFM4OrEDljfJAi
         z6Uo2xCUazdFhQl5JT6gh/Opl62XMERcF1Q8wD8+rlpsVy1gqCiMAymvBsehaALcWrS4
         ViT11+bXa2jmv/I4uGq4znEPZaM2xCXRbfZyW4+iVw145aPYe4I+ulXxH+MPSAjwXJ+s
         QcXy3EnQ0zrUWGdnW0tlqEVuPyZsgCdIaavYWQXi8bF4y6K68lL+lFFL8SEktWurPCKG
         vwEJKqzZ+oWWUYhjcpZ2CrKtVDA3mvxdkAnyVdlghHOrYEjuzLaWbWDUx2T703O1IMmL
         M6Hw==
X-Gm-Message-State: AOAM530C3b2xtcmblUW3tMoW8AMfvNUOXWpEA+cncweJ6c4M2/HwNIi1
        TyINW7wxb53GQKwwWGPpsCkJ4m0dZlGKTe6HtwWw/g==
X-Google-Smtp-Source: ABdhPJzp6efxOCx5QZDJO5MdiYBIzr5/sIYpjHjbzSzv8LQevlDuh/P6B4sSDxBK2+A6raMuT5ejhS/WjG9VRUVnfB8=
X-Received: by 2002:a67:3294:: with SMTP id y142mr2144185vsy.8.1627657756040;
 Fri, 30 Jul 2021 08:09:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210723093938.49354-1-zeil@yandex-team.ru> <CADVnQykVQhT_4f2CV6cAqx_oFvQ-vvq-S0Pnw0a6cnXFuJnPpg@mail.gmail.com>
 <E09A2DA0-A741-4566-B8C6-09C563546538@yandex-team.ru>
In-Reply-To: <E09A2DA0-A741-4566-B8C6-09C563546538@yandex-team.ru>
From:   Neal Cardwell <ncardwell@google.com>
Date:   Fri, 30 Jul 2021 11:08:59 -0400
Message-ID: <CADVnQykFrPByw82NHm-L00cqhaSCuBNAmYbkkJ06SGNitqkxEw@mail.gmail.com>
Subject: Re: [PATCH] tcp: use rto_min value from socket in retransmits timeout
To:     Dmitry Yakunin <zeil@yandex-team.ru>
Cc:     kafai@fb.com, edumazet@google.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org, dmtrmonakhov@yandex-team.ru,
        Yuchung Cheng <ycheng@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        mitradir@yandex-team.ru
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jul 30, 2021 at 8:37 AM Dmitry Yakunin <zeil@yandex-team.ru> wrote:
>
> Hello, Neal!
>
> Thanks for your reply and explanations.
>
> I agree with all your points, about safe defaults for both timeouts
> and the number of retries. But what the patch does is not changing the
> defaults, it only provides a way to work with these values through
> bpf, which is important in an environment that is way different from
> cellular networks. For example in the modern DC the rto_min value
> should correspond with real RTT, that definitely not 200ms.

It seems your patch and your analysis are conflating several different issues:

(1) how long should rto_min be in datacenter environments?
(2) for reliability/robustness, how long should TCP retry to transmit
data before giving up?
(2) should rto_min just correspond to the real RTT, or other factors
(like delayed ACK timers)?

I am talking about the reliability/robustness cost of your proposal to
tie custom reductions in (1) to automatic custom reductions in (2).
(I'm not talking about safe defaults.)

If BPF or routing table entries customize rto_min, then it's great for
the rto_min knob to customize the RTO timer value to use a lower value
in datacenters to speed up loss recovery (1) (as already happens).

But just because you customize (1) does not imply that it is safe to
massively reduce the answer to (2): it is not safe to cripple
reliability/robustness by (as in your proposed patch) having the
rto_min setting massively reduce the length of time that a TCP
connection retries sending data before giving up and closing the
connection.

The problem caused by your proposal to have rto_min shorten the retry
duration (e.g. a 5ms rto_min leading to only 1.275 seconds of retries)
is a general problem of reliability/robustness, not specific to
cellular paths. My point about cellular networks was just the most
crisp example I could think of, to try to provide a clear and concrete
example.

If you really think it's important for TCP connections to only retry
sending data for 1.275 seconds, then can you please give an example of
when this is important, and then please implement a separate
customization mechanism for that, rather than forcing all Linux users
of the rto_min mechanism to suffer the fallout from tying (1) to (2)?

best regards,
neal
