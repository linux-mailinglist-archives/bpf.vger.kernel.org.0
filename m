Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09D9B3EE562
	for <lists+bpf@lfdr.de>; Tue, 17 Aug 2021 06:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbhHQEQM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Aug 2021 00:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbhHQEQL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Aug 2021 00:16:11 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43029C061764
        for <bpf@vger.kernel.org>; Mon, 16 Aug 2021 21:15:39 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id z128so36996971ybc.10
        for <bpf@vger.kernel.org>; Mon, 16 Aug 2021 21:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pQzmmsYUE54Ko8luKf2zGqVAJIvH8oqDwsVyff17EzI=;
        b=UrAFsyPZo8lXzavzXwbnUxDmZKSHM1dEyYxfj0RobS40k5tloORVmgTFNfNGW2JxGR
         G0kB2koXRb/yMLON/1SJXjh8NseAEkhCJndIhnfnG4Lx1M3B5y/f2WtfEtOvAuc0kfJv
         reMqtvpWMSPya9LDHYzcXD/1UagpDR4fkwk8shRAxyXgnZOOnRbd3lZHR1wOPw6IZalI
         D+/9fOIrimTCn05tpKm7/NElmFnNX4UkEkFe9+BsquJsSml1HkA2cNfBJv24Jv3FSLmL
         WbQsKYjpO0ZdkpRCHQe3ifZW9QE73qsNRkSmHkHa/eS5y0+Mk5zVW0AxoAT0i9js8myj
         dTfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pQzmmsYUE54Ko8luKf2zGqVAJIvH8oqDwsVyff17EzI=;
        b=eRtcYOvOlPIyVgx5k9Y6/1PZ8v1fbZ16KnVNgIvRklcS1WHgSX7UUAuawl/0wVqEO7
         DEOx5liOGyIgQshwbNRBjQLfkJ0KzthIOFR9PleyFanxYscTcejZDLw9HANRnkukK9vQ
         /5l7be2fj8TaT+hEG9JdwKkZwMWXBtaDib2tk1Kc9Wu4O+VsNINH5gCtMtKCiWUJQqRC
         98p9Sj+FtzVnecBE46p4fnr5QXVCUKWI74alRlj3gawKBalPc7s15hAEG43H+QEUse3J
         62cpMSxrcYXlJJoXejbRW+wpjgHojjKNBCGeuYKsIA9acoyjRnJpAzpPsU/Erz6hR28y
         Gruw==
X-Gm-Message-State: AOAM530ko1SQzttawRMMe+aqiah5xTogFoatGz+CcFifR/1YYdOMunWa
        6fESHRIsVie44Ejwg+DcyYw4RDH97Amtdp2SXSA=
X-Google-Smtp-Source: ABdhPJxZRZQ/2+WesQ3UdHBrFpQzu6dfPylYLgu/NkzZHR4VzPCll4CAQue48vLywvNvKw7YJMdNgnCMtwLalc8F3aU=
X-Received: by 2002:a25:d691:: with SMTP id n139mr2007082ybg.27.1629173738537;
 Mon, 16 Aug 2021 21:15:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210816175250.296110-1-fallentree@fb.com> <CAPhsuW5NYMVRCmCXu=gJudfReYzMZqTUVUUWfH+U6FzVo=dWJQ@mail.gmail.com>
 <CAJygYd2rF1UzD1fmWrJ=Rn2Aa43pRniLTtqVzLFpJdR2wVnSFQ@mail.gmail.com> <CAEf4Bzax+jq_67gzFM3G8K17_mUSvtBuBmXUHqx6Xk7SxFz+eQ@mail.gmail.com>
In-Reply-To: <CAEf4Bzax+jq_67gzFM3G8K17_mUSvtBuBmXUHqx6Xk7SxFz+eQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 16 Aug 2021 21:15:27 -0700
Message-ID: <CAEf4BzZhFpgM2KcZXiCWiAoW=uYhxMtV=kBr9zJjb=er8Lu2Dg@mail.gmail.com>
Subject: Re: [PATCH v1 bpf] selftests/bpf: Add exponential backoff to
 map_update_retriable in test_maps
To:     "sunyucong@gmail.com" <sunyucong@gmail.com>
Cc:     Song Liu <song@kernel.org>, Yucong Sun <fallentree@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 16, 2021 at 7:19 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Aug 16, 2021 at 4:45 PM sunyucong@gmail.com <sunyucong@gmail.com> wrote:
> >
> > On Mon, Aug 16, 2021 at 4:28 PM Song Liu <song@kernel.org> wrote:
> > >
> > > On Mon, Aug 16, 2021 at 10:54 AM Yucong Sun <fallentree@fb.com> wrote:
> > > >
> > > > Using a fixed delay of 1ms is proven flaky in slow CPU environment, eg.  github
> > > > action CI system. This patch adds exponential backoff with a cap of 50ms, to
> > > > reduce the flakiness of the test.
> > >
> > > Do we have data showing how flaky the test is before and after this change?
> >
> > Before the change, on 2 CPU KVM on my laptop the test is perfectly
> > fine, on Github action (2 emulated CPU) , it appeared to fail roughly
> > 1 in 10 runs or even more frequently.
> > After the change, it appears pretty robust both on my laptop and on
> > github action, I ran the github action a couple times and it succeeded
> > every time.
> >
> > >
> > > >
> > > > Signed-off-by: Yucong Sun <fallentree@fb.com>
> > > > ---
> > > >  tools/testing/selftests/bpf/test_maps.c | 7 ++++++-
> > > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/selftests/bpf/test_maps.c
> > > > index 14cea869235b..ed92d56c19cf 100644
> > > > --- a/tools/testing/selftests/bpf/test_maps.c
> > > > +++ b/tools/testing/selftests/bpf/test_maps.c
> > > > @@ -1400,11 +1400,16 @@ static void test_map_stress(void)
> > > >  static int map_update_retriable(int map_fd, const void *key, const void *value,
> > > >                                 int flags, int attempts)
> > > >  {
> > > > +       int delay = 1;
> > > > +
> > > >         while (bpf_map_update_elem(map_fd, key, value, flags)) {
> > > >                 if (!attempts || (errno != EAGAIN && errno != EBUSY))
> > > >                         return -errno;
> > > >
> > > > -               usleep(1);
> > > > +               if (delay < 50)
> > > > +                       delay *= 2;
> > > > +
> > > > +               usleep(delay);
> > >
> > > It is a little weird that the delay times in microseconds are 2, 4, 8,
> > > 16, 32, 64, 64, ...
> > > Maybe just use rand()?
> >
> > map_update_retriable is called by test_map_update() , which is being
> > parallel executed in 1024 threads, so the lock contention is
> > intentional, I think if we introduce randomness in the delay it kind
> > of defeats the purpose of the test.
>
> Not really, the purpose of the test is to test a lot of concurrent
> updates with some collisions. It doesn't matter if there is one
> collision or 20. We will still get an initial collision (we only
> usleep() after the initial attempt fails with EAGAIN or EBUSY) even
> with randomized initial sleep *after* the first collision, but after
> that we should make sure that test eventually completes, so for that
> random initial delay is a good thing.
>
> I reworked the code a bit, added initial random delay between [0ms,
> 5ms), and then actually capped delay under 50ms (it can't go to
> >50ms). Note also that your code is actually working with microseconds
> (usleep() takes microseconds), while commit was actually talking about
> milliseconds.
>
> Applied to bpf-next, thanks.

Fun, two out of three test runs now fail with (see [0], for an example):

  error -16 16
  test_maps: test_maps.c:1374: test_update_delete: Assertion `err == 0' failed.
  test_maps: test_maps.c:1312: __run_parallel: Assertion `status == 0' failed.
  ./libbpf/travis-ci/vmtest/run_selftests.sh: line 19:  1226 Aborted
              ./test_maps


Seems like we need the same trick for bpf_map_delete_elem() calls?..


  [0] https://github.com/kernel-patches/bpf/pull/1632/checks?check_run_id=3345916773

>
> > My original proposal is to just increase the attempts to 10X , Andrii
> > proposed to use an exponential back-off, which is what I ended up
> > implementing.
> >
> > >
> > > Thanks,
> > > Song
> > >
> > > >                 attempts--;
> > > >         }
> > > >
> > > > --
> > > > 2.30.2
> > > >
