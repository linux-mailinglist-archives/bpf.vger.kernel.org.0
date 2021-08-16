Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA5A3EE086
	for <lists+bpf@lfdr.de>; Tue, 17 Aug 2021 01:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234414AbhHPXq1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Aug 2021 19:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234188AbhHPXq1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Aug 2021 19:46:27 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9FCC061764
        for <bpf@vger.kernel.org>; Mon, 16 Aug 2021 16:45:55 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id s3so880845ljp.11
        for <bpf@vger.kernel.org>; Mon, 16 Aug 2021 16:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cjh7+6tL6LfBP+sdk9hqUKOtKlCNmRYIEg4fED+lDu0=;
        b=drN3FM8Ox6Pj2KHvKv5nY3nFXU3rGiFC7TDeOV6/IHMUs8su4495DTqFg6clOQ8UpQ
         x5TEWwrfFbnH4OjcFRI4PdUq0o+ACYZsbF7H3RkLgV0/wTc0ZeOJoaoP0AmhAb1Wu8lc
         kQHN7Lr/D0AczZE3Q+qhnN2Lx2TThnNYQpYs27QZbMoQ5wp4zRJHn/N0DEoN7nTytXaB
         LVNCOASfOuxt1pYjmzgw8kDIKU7zlPTNnO/pd7b+3raTPsFlq7OVCadQNe9SE7/GBBXV
         z7O9jXKC5GSMAsr1Jp/V+FvLFt8trhE131Myk3X2EoW0GWXSkfnC2Q7AXGXDLCQzxBdV
         U9ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cjh7+6tL6LfBP+sdk9hqUKOtKlCNmRYIEg4fED+lDu0=;
        b=PPh6mcQS+QvBYzYNjANocjxFM+g0VoSZndFj+x9EPAC35YsxKaNhTyWQMeWnNkS2lc
         0/tvasr5KYqqP/utVY26NgbYAoCFo/pCSi7Vefr7MHH4RAa5BRod37CMq4bEW12Aqq82
         T36ARSKJe7dW2GgiQ5Dh+nNfK1FEJf+BW6nJcePFJOd1ptltKg1XR69HkIXH/0UPpLf1
         Lx0Cx8bbg5AF8HdE6JVZ6hxKAQErJMgSfA5xWSR/ws26DlbMEc87z2pfP2iLSWyWK04X
         O6QNJNy+KkAYNKsoYoiqs73kZTF8fFpPnq83YzQPL/uNw2ltgdx6lOWQDnP2P8Rm7/94
         d1yQ==
X-Gm-Message-State: AOAM5339xwvaj5mgz9A+9pph9COcDa1Hvp8BF9emFmZSVzFqPNLmQVE1
        +LaRmEk0cmvSBr7iGwYi4DgIQwutDKDH9ASbNQ0=
X-Google-Smtp-Source: ABdhPJxTrUZMaHauRNDOv4IJ43D30uNVQyMrJ4q9DQ87YihjBHbYhCUpPGvoQkRseW6Cf0OdE2EEQsrxC1vhmjX6iqQ=
X-Received: by 2002:a05:651c:1189:: with SMTP id w9mr620508ljo.14.1629157553323;
 Mon, 16 Aug 2021 16:45:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210816175250.296110-1-fallentree@fb.com> <CAPhsuW5NYMVRCmCXu=gJudfReYzMZqTUVUUWfH+U6FzVo=dWJQ@mail.gmail.com>
In-Reply-To: <CAPhsuW5NYMVRCmCXu=gJudfReYzMZqTUVUUWfH+U6FzVo=dWJQ@mail.gmail.com>
From:   "sunyucong@gmail.com" <sunyucong@gmail.com>
Date:   Mon, 16 Aug 2021 16:45:27 -0700
Message-ID: <CAJygYd2rF1UzD1fmWrJ=Rn2Aa43pRniLTtqVzLFpJdR2wVnSFQ@mail.gmail.com>
Subject: Re: [PATCH v1 bpf] selftests/bpf: Add exponential backoff to
 map_update_retriable in test_maps
To:     Song Liu <song@kernel.org>
Cc:     Yucong Sun <fallentree@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 16, 2021 at 4:28 PM Song Liu <song@kernel.org> wrote:
>
> On Mon, Aug 16, 2021 at 10:54 AM Yucong Sun <fallentree@fb.com> wrote:
> >
> > Using a fixed delay of 1ms is proven flaky in slow CPU environment, eg.  github
> > action CI system. This patch adds exponential backoff with a cap of 50ms, to
> > reduce the flakiness of the test.
>
> Do we have data showing how flaky the test is before and after this change?

Before the change, on 2 CPU KVM on my laptop the test is perfectly
fine, on Github action (2 emulated CPU) , it appeared to fail roughly
1 in 10 runs or even more frequently.
After the change, it appears pretty robust both on my laptop and on
github action, I ran the github action a couple times and it succeeded
every time.

>
> >
> > Signed-off-by: Yucong Sun <fallentree@fb.com>
> > ---
> >  tools/testing/selftests/bpf/test_maps.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/selftests/bpf/test_maps.c
> > index 14cea869235b..ed92d56c19cf 100644
> > --- a/tools/testing/selftests/bpf/test_maps.c
> > +++ b/tools/testing/selftests/bpf/test_maps.c
> > @@ -1400,11 +1400,16 @@ static void test_map_stress(void)
> >  static int map_update_retriable(int map_fd, const void *key, const void *value,
> >                                 int flags, int attempts)
> >  {
> > +       int delay = 1;
> > +
> >         while (bpf_map_update_elem(map_fd, key, value, flags)) {
> >                 if (!attempts || (errno != EAGAIN && errno != EBUSY))
> >                         return -errno;
> >
> > -               usleep(1);
> > +               if (delay < 50)
> > +                       delay *= 2;
> > +
> > +               usleep(delay);
>
> It is a little weird that the delay times in microseconds are 2, 4, 8,
> 16, 32, 64, 64, ...
> Maybe just use rand()?

map_update_retriable is called by test_map_update() , which is being
parallel executed in 1024 threads, so the lock contention is
intentional, I think if we introduce randomness in the delay it kind
of defeats the purpose of the test.
My original proposal is to just increase the attempts to 10X , Andrii
proposed to use an exponential back-off, which is what I ended up
implementing.

>
> Thanks,
> Song
>
> >                 attempts--;
> >         }
> >
> > --
> > 2.30.2
> >
