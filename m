Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1166F3EE43A
	for <lists+bpf@lfdr.de>; Tue, 17 Aug 2021 04:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233583AbhHQCUS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Aug 2021 22:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233528AbhHQCUS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Aug 2021 22:20:18 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766F2C061764
        for <bpf@vger.kernel.org>; Mon, 16 Aug 2021 19:19:45 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id w17so36586721ybl.11
        for <bpf@vger.kernel.org>; Mon, 16 Aug 2021 19:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aAAKS3YnpflLmFQTExIyCgWc1qxHjyAMeIEf/fKNZzo=;
        b=A9NyG6sHxb/dXd0c4T3AzIaj6WbluZsz7v26Z1w3pMDLb8j7Xf0kWK/csyaZTfC87H
         A3RcxzoHz67rfgTwMY67c8IhKE9iYwtaw9rTf+SxiEFiiZBXyIkIIk4UAsi3ap74P3/5
         UWW3b68lwjyOI9SsgvAzb4RMiVEafDVhA+ZuzLE8cuCxjD//5qIzuaHvflFWG0JgrqyZ
         7HUb+9O3VA+8/6g7yShjShX8tQ6fR1P3IR0SBlOhaPoTt94Wbv0D9oMA0duaWR6U1t/J
         2I88Iys7U1hwx3wTZTR/YjUnnQsZcEoA+Ttub5ktAT0C3cQlwsxjyDulGXVbOWrqzz0T
         BBsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aAAKS3YnpflLmFQTExIyCgWc1qxHjyAMeIEf/fKNZzo=;
        b=V8AGZh7VWQ7bifQebQTBpPQWv96hQ/VT/aAxvfBNsWIq6V7VIMtJoOxaaCri2j5O2h
         gyg4Y3U72pUeB19XKgjZgQ+EQaalEW6vN4U6YaDaMQlQ7fmCU2xqcj1lG9o6BxpisWZa
         nnAalRWDL8OHcEJjoioLcxNrhRdldfGgYWjnGqzcyDTuWW+96Rboy9yG/OepJ2sq822H
         hAzu3gXEV8Bil29gFjWmtj//AcRVDdnzzsNLuzNuFZ1nhcjrMtISAQMK/Jge7rgH6gAC
         ymnQxIaJqGcvBcWX9t1G3BZS8ZOX/PrvuDObCfN96DC6ranKilVYj04PLX8et8hV5/fB
         2Czg==
X-Gm-Message-State: AOAM531MCnbRtnTddYmiq0c5gicNrLeTLGJmvP09+nnyosP8NRLQp4cX
        Lz3MTuBXLHSItWyn1iUygEXyf7Dkt5oX7F7OXAA=
X-Google-Smtp-Source: ABdhPJzofy24mRWlmWBJwNwm9wMmhfHJ3tCa44j5owrcfAu3NSWPvVEahxI9RXqNYPvowbrMZ4HJ7sC/Jd6h9xDxTvs=
X-Received: by 2002:a25:4941:: with SMTP id w62mr1478027yba.230.1629166784542;
 Mon, 16 Aug 2021 19:19:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210816175250.296110-1-fallentree@fb.com> <CAPhsuW5NYMVRCmCXu=gJudfReYzMZqTUVUUWfH+U6FzVo=dWJQ@mail.gmail.com>
 <CAJygYd2rF1UzD1fmWrJ=Rn2Aa43pRniLTtqVzLFpJdR2wVnSFQ@mail.gmail.com>
In-Reply-To: <CAJygYd2rF1UzD1fmWrJ=Rn2Aa43pRniLTtqVzLFpJdR2wVnSFQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 16 Aug 2021 19:19:33 -0700
Message-ID: <CAEf4Bzax+jq_67gzFM3G8K17_mUSvtBuBmXUHqx6Xk7SxFz+eQ@mail.gmail.com>
Subject: Re: [PATCH v1 bpf] selftests/bpf: Add exponential backoff to
 map_update_retriable in test_maps
To:     "sunyucong@gmail.com" <sunyucong@gmail.com>
Cc:     Song Liu <song@kernel.org>, Yucong Sun <fallentree@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 16, 2021 at 4:45 PM sunyucong@gmail.com <sunyucong@gmail.com> wrote:
>
> On Mon, Aug 16, 2021 at 4:28 PM Song Liu <song@kernel.org> wrote:
> >
> > On Mon, Aug 16, 2021 at 10:54 AM Yucong Sun <fallentree@fb.com> wrote:
> > >
> > > Using a fixed delay of 1ms is proven flaky in slow CPU environment, eg.  github
> > > action CI system. This patch adds exponential backoff with a cap of 50ms, to
> > > reduce the flakiness of the test.
> >
> > Do we have data showing how flaky the test is before and after this change?
>
> Before the change, on 2 CPU KVM on my laptop the test is perfectly
> fine, on Github action (2 emulated CPU) , it appeared to fail roughly
> 1 in 10 runs or even more frequently.
> After the change, it appears pretty robust both on my laptop and on
> github action, I ran the github action a couple times and it succeeded
> every time.
>
> >
> > >
> > > Signed-off-by: Yucong Sun <fallentree@fb.com>
> > > ---
> > >  tools/testing/selftests/bpf/test_maps.c | 7 ++++++-
> > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/selftests/bpf/test_maps.c
> > > index 14cea869235b..ed92d56c19cf 100644
> > > --- a/tools/testing/selftests/bpf/test_maps.c
> > > +++ b/tools/testing/selftests/bpf/test_maps.c
> > > @@ -1400,11 +1400,16 @@ static void test_map_stress(void)
> > >  static int map_update_retriable(int map_fd, const void *key, const void *value,
> > >                                 int flags, int attempts)
> > >  {
> > > +       int delay = 1;
> > > +
> > >         while (bpf_map_update_elem(map_fd, key, value, flags)) {
> > >                 if (!attempts || (errno != EAGAIN && errno != EBUSY))
> > >                         return -errno;
> > >
> > > -               usleep(1);
> > > +               if (delay < 50)
> > > +                       delay *= 2;
> > > +
> > > +               usleep(delay);
> >
> > It is a little weird that the delay times in microseconds are 2, 4, 8,
> > 16, 32, 64, 64, ...
> > Maybe just use rand()?
>
> map_update_retriable is called by test_map_update() , which is being
> parallel executed in 1024 threads, so the lock contention is
> intentional, I think if we introduce randomness in the delay it kind
> of defeats the purpose of the test.

Not really, the purpose of the test is to test a lot of concurrent
updates with some collisions. It doesn't matter if there is one
collision or 20. We will still get an initial collision (we only
usleep() after the initial attempt fails with EAGAIN or EBUSY) even
with randomized initial sleep *after* the first collision, but after
that we should make sure that test eventually completes, so for that
random initial delay is a good thing.

I reworked the code a bit, added initial random delay between [0ms,
5ms), and then actually capped delay under 50ms (it can't go to
>50ms). Note also that your code is actually working with microseconds
(usleep() takes microseconds), while commit was actually talking about
milliseconds.

Applied to bpf-next, thanks.

> My original proposal is to just increase the attempts to 10X , Andrii
> proposed to use an exponential back-off, which is what I ended up
> implementing.
>
> >
> > Thanks,
> > Song
> >
> > >                 attempts--;
> > >         }
> > >
> > > --
> > > 2.30.2
> > >
