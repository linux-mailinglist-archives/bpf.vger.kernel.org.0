Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC5736DEDB
	for <lists+bpf@lfdr.de>; Wed, 28 Apr 2021 20:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240125AbhD1SOc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Apr 2021 14:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240111AbhD1SOb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Apr 2021 14:14:31 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA55C061573;
        Wed, 28 Apr 2021 11:13:46 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id p202so31433126ybg.8;
        Wed, 28 Apr 2021 11:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yOBofwvLv9zf8YC0Zy32OgrcWp0knjz3rutihNNwWNI=;
        b=TqSG1JPI7Ay2Z9T/58cWhm29Dop0mBA8wysl0/1OHbrmkteoHRXE2k19L9LqhKSAUZ
         FDzpgoKg6VrmM5iq3Ltk7JAnUhHXLXvm+NNHShmTtWqTRsIivEm9ltss2eZRu/5MR/RR
         R9Ckt+GEyEmmafmTzfU3IKcITK5ZFazRMpS/7dWgmm4vbJOH+Af1nAJnQMdAw+CYXsK1
         ZDuheRVpNwMHJAZbZGC6HlwwJh5pw+n6PrFz9dftLJewuyTknVk1MaUGwSxLQ2r0Nrws
         HFPqzHKzBUErEdb36sAr2Af5QYCIzOn4xruJyVNf6NEh3ScSgh6ogM5TvTftYafuk2ZA
         AwAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yOBofwvLv9zf8YC0Zy32OgrcWp0knjz3rutihNNwWNI=;
        b=Z+lPCnN/Y1dK+HhLsMvqpWh24gNJIgX7jx8KCSfQa6sIeVOLCUr6ArX+8hwByndav0
         b9Ucbed+2lFVTxrRie2jwoT8zG0/yLl/QgzW3y4Ynx5dyZ7QLkB/mmIqqoV6KgqnsX/Y
         chQokrVRs+R/gjxpLlhKUb9F7YsREuW2y23r8hW+YCNOV907LFNnpfwQsOjVino9qlJo
         Ty4pUIXAeuSpDZueydmCnO6hrLxWhGwY6KihZCdbBDMaCIs15Ut9/YiKtsdTrKP3cPzZ
         +1g1E1BnpcvXJRgazfMMlw9zAAOeQEyEAyciPqFCTb1dMTZHfaDz6E6cwjorN7pyLeX4
         1yHA==
X-Gm-Message-State: AOAM533YvL4mMgongQHt5E5Cjro4AuZxzwDy+BDkGhHK7IkyvNwQQ8t6
        MDLJ7oZJNRQm3qY3cwRfodYikjyrE80XO7sOlxU6aAzuNf0=
X-Google-Smtp-Source: ABdhPJyc2qzfdeNvDJl5v5UW81DmjCcv0tE2v/uDC6KdAdCZmnyZAfv1SOYuJVIapAzmE30TVAPcgq+u6MTr9fStb+4=
X-Received: by 2002:a25:c4c5:: with SMTP id u188mr42036749ybf.425.1619633625302;
 Wed, 28 Apr 2021 11:13:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210427170859.579924-1-jackmanb@google.com> <CAEf4BzZimYsgp3AS72U8nOXfryB6dVxQKetT_6yE3xzztdTyZg@mail.gmail.com>
 <CACYkzJ57LqsDBgJpTZ6X-mEabgNK60J=2CJEhUWoQU6wALvQVw@mail.gmail.com>
 <CAEf4Bzb+OGZrvmgLk3C1bGtmyLU9JiJKp2WfgGkWq0nW0Tq32g@mail.gmail.com> <CA+i-1C2bNk0Mx_9KkuyOjvQh_y7KFrHBU-869P+8oTFq8HdVcw@mail.gmail.com>
In-Reply-To: <CA+i-1C2bNk0Mx_9KkuyOjvQh_y7KFrHBU-869P+8oTFq8HdVcw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 28 Apr 2021 11:13:34 -0700
Message-ID: <CAEf4Bzb1ZNotcB44cDauAkAbs4R=UvPRKP1KWNbLg1k1jH25mA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Fix signed overflow in ringbuf_process_ring
To:     Brendan Jackman <jackmanb@google.com>
Cc:     KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 28, 2021 at 1:18 AM Brendan Jackman <jackmanb@google.com> wrote:
>
> On Wed, 28 Apr 2021 at 01:19, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> >
> > On Tue, Apr 27, 2021 at 4:05 PM KP Singh <kpsingh@kernel.org> wrote:
> > >
> > > On Tue, Apr 27, 2021 at 11:34 PM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Tue, Apr 27, 2021 at 10:09 AM Brendan Jackman <jackmanb@google.com> wrote:
> > > > >
> > > > > One of our benchmarks running in (Google-internal) CI pushes data
> > > > > through the ringbuf faster than userspace is able to consume
> > > > > it. In this case it seems we're actually able to get >INT_MAX entries
> > > > > in a single ringbuf_buffer__consume call. ASAN detected that cnt
> > > > > overflows in this case.
> > > > >
> > > > > Fix by just setting a limit on the number of entries that can be
> > > > > consumed.
> > > > >
> > > > > Fixes: bf99c936f947 (libbpf: Add BPF ring buffer support)
> > > > > Signed-off-by: Brendan Jackman <jackmanb@google.com>
> > > > > ---
> > > > >  tools/lib/bpf/ringbuf.c | 3 ++-
> > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
> > > > > index e7a8d847161f..445a21df0934 100644
> > > > > --- a/tools/lib/bpf/ringbuf.c
> > > > > +++ b/tools/lib/bpf/ringbuf.c
> > > > > @@ -213,8 +213,8 @@ static int ringbuf_process_ring(struct ring* r)
> > > > >         do {
> > > > >                 got_new_data = false;
> > > > >                 prod_pos = smp_load_acquire(r->producer_pos);
> > > > > -               while (cons_pos < prod_pos) {
> > > > > +               /* Don't read more than INT_MAX, or the return vale won't make sense. */
> > > > > +               while (cons_pos < prod_pos && cnt < INT_MAX) {
> > > >
> > > > ring_buffer__pool() is assumed to not return until all the enqueued
> > > > messages are consumed. That's the requirement for the "adaptive"
> > > > notification scheme to work properly. So this will break that and
> > > > cause the next ring_buffer__pool() to never wake up.
>
> Ah yes, good point, thanks.
>
> > > > We could use __u64 internally and then cap it to INT_MAX on return
> > > > maybe? But honestly, this sounds like an artificial corner case, if
> > > > you are producing data faster than you can consume it and it goes
> > > > beyond INT_MAX, something is seriously broken in your application and
>
> Yes it's certainly artificial but IMO it's still highly desirable for
> libbpf to hold up its side of the bargain even when the application is
> behaving very strangely like this.

One can also argue that if application consumed more than 2 billion
messages in one go, that's an error. ;-P But of course that is not
great.

>
> [...]
>
> > I think we have two alternatives here:
> > 1) consume all but cap return to INT_MAX
> > 2) consume all but return long long as return result
> >
> > Third alternative is to have another API with maximum number of
> > samples to consume. But then user needs to know what they are doing
> > (e.g., they do FORCE on BPF side, or they do their own epoll_wait, or
> > they do ring_buffer__poll with timeout = 0, etc).
> >
> > I'm just not sure anyone would want to understand all the
> > implications. And it's easy to miss those implications. So maybe let's
> > do long long (or __s64) return type instead?
>
> Wouldn't changing the API to 64 bit return type break existing users
> on some ABIs?
>

Yes, it might, not perfect.

> I think capping the return value to INT_MAX and adding a note to the
> function definition comment would also be fine, it doesn't feel like a
> very complex thing for the user to understand: "Returns number of
> records consumed (or INT_MAX, whichever is less)".

Yep, let's cap. But to not penalize a hot loop with extra checks.
Let's use int64_t internally for counting and only cap it before the
return.
