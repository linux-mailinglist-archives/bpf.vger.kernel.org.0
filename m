Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0719D3EE0A9
	for <lists+bpf@lfdr.de>; Tue, 17 Aug 2021 02:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234672AbhHQACq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Aug 2021 20:02:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:44988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232944AbhHQACp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Aug 2021 20:02:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8DC1B60F5C
        for <bpf@vger.kernel.org>; Tue, 17 Aug 2021 00:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629158533;
        bh=R6a15wGlPy19AL96LLrSJQ696EXY/QrCzB6A5lxbN9Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZUUfJavoRzc9ISNRz1GZIE6txRs3tBNgG80jx0FABHyh1xzze3KNauSFieaSCmH/x
         R7s84M9WjXsqGkID9mGIYYBVwyclhBEk6HiFO6t/sc5rmE5kNVibibEv3ljsqP+J3Z
         diGbjj2cFhnhkrp6sUhNmb0CB8xNfZm4jul+EzJsMoAqNBQswdBYtjh5L20894LPuB
         yH8gSdr2buplk2f9wVKZOUzYCseJKHjKdiNsA8qkq7P7Y6vndLqeQXc9rsoS9O66K0
         53xMMU/F9jrcxqaeB3y6KNGYino0Ft7mT35lgQHLlUExm/IcWHcQwYyJV1ASRrU2zB
         X+ulz2GnDVseA==
Received: by mail-lj1-f180.google.com with SMTP id f2so8263489ljn.1
        for <bpf@vger.kernel.org>; Mon, 16 Aug 2021 17:02:13 -0700 (PDT)
X-Gm-Message-State: AOAM533B6DT01xM5HF7tj2UGNxy87nAWD6AKvKk9eNg60gbVxvGHa8D/
        p9ZSj5JyIhCuLEUsqCDqlG2HbIe/xGpUgqKSKY0=
X-Google-Smtp-Source: ABdhPJxpOpXkrC4L5Fhw7zFDsVgi1yOFHXnGJkf4yvmeRY7vtyE1lOXaMpctqIfGYUSkGZQsUAsGu6VKDUcHB5xRApc=
X-Received: by 2002:a2e:7514:: with SMTP id q20mr641565ljc.506.1629158531896;
 Mon, 16 Aug 2021 17:02:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210816175250.296110-1-fallentree@fb.com> <CAPhsuW5NYMVRCmCXu=gJudfReYzMZqTUVUUWfH+U6FzVo=dWJQ@mail.gmail.com>
 <CAJygYd2rF1UzD1fmWrJ=Rn2Aa43pRniLTtqVzLFpJdR2wVnSFQ@mail.gmail.com>
In-Reply-To: <CAJygYd2rF1UzD1fmWrJ=Rn2Aa43pRniLTtqVzLFpJdR2wVnSFQ@mail.gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 16 Aug 2021 17:02:00 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5cXZUcuWwLwdQEArhokjhpKpfOvqmH+Ksz-fsxtz_txA@mail.gmail.com>
Message-ID: <CAPhsuW5cXZUcuWwLwdQEArhokjhpKpfOvqmH+Ksz-fsxtz_txA@mail.gmail.com>
Subject: Re: [PATCH v1 bpf] selftests/bpf: Add exponential backoff to
 map_update_retriable in test_maps
To:     "sunyucong@gmail.com" <sunyucong@gmail.com>
Cc:     Yucong Sun <fallentree@fb.com>,
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

Thanks for the data!

We should include this in the commit log. Maybe the maintainer could just
amend it when applying the patch.

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
> My original proposal is to just increase the attempts to 10X , Andrii
> proposed to use an exponential back-off, which is what I ended up
> implementing.

If that is what we agreed on, it works.

Acked-by: Song Liu <songliubraving@fb.com>
