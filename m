Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B60C336CF7D
	for <lists+bpf@lfdr.de>; Wed, 28 Apr 2021 01:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236792AbhD0XUN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Apr 2021 19:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235423AbhD0XUN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Apr 2021 19:20:13 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A908C061574;
        Tue, 27 Apr 2021 16:19:28 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id p202so27810772ybg.8;
        Tue, 27 Apr 2021 16:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5FfFOfy+ipYphXgdKrdbLv2yDmO7+UBL+r3kaZKExys=;
        b=BqunpMpUdebAz3Oqv7/e76j2n6S3wAmHDZAiBOtrNLeZHtlAQM80yoLE3peA1naDp9
         EKmDMv04qo2kXwSACbacX1tLsqsKigafLGdQX5cGR0WNHIinY92//mAQd740DhKNNy0p
         CdSLYgVPOm8NJeNH+w6tPmr9j7fV+BfHU+JGPuH0nY5Z/qFIEEXfk/wkmiikMwv9gvd5
         3/ny/NA5dm6Ah6mGoiyExexBDrbdPUq6SfgpbBLrR3an5W52jIoMkQGxOn6Y+I3I2rH/
         IwYSzd+EU2CZmTS/MIyfOdiiM7jQrDAl3buakEkIIa2kD2MCSnkHT6UYpPScZLCsi5B4
         8sNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5FfFOfy+ipYphXgdKrdbLv2yDmO7+UBL+r3kaZKExys=;
        b=pv5rlq7Ubugyp8/P4bUReFFpYH1c8pffWrQLVqyCLAoyt8Bj0Al/HwFUq+F/NEBw7U
         Ar6l+GpYKhpSdlb3ZnApKiHf61LesgMn9bxg1tgQtDqil1LNYjIVr81rDQqhmmjEM1su
         JpZTbOceLc/jsZ1M5yBRBdl+xVcChuPWLr4nnKswafcZdyuj6wc6IaCeFhq6kw6qCg3y
         +87NARFfAienXh/4TiINFAtET7mtcECjBmYTP5WYtAMbjjcSFaWKXdcEenBh8bgFE4n8
         pOWh+kFfdSGnk0rfcA8x9L9UC52ZYSwAZaZg3u2gUh9R0uUOiAtZrFXhhviwi7bq8Pt1
         I/gg==
X-Gm-Message-State: AOAM530IL692x1xkB1Uxk8/ACjj92Lc6++ouPZJmfBu5QeyJyItdyjcF
        Q5O+ih1j0KXqLYZ3aSBM6nEtSaF7drI4WdV+dm4=
X-Google-Smtp-Source: ABdhPJxWaRis+6CDZk0WoubzO6mVsrmCgwWXwf9YZ7QhUng27ECRea07WG0f8A9aSvzBQnc/tpEOkXZeLoW1ltUwDDk=
X-Received: by 2002:a25:ba06:: with SMTP id t6mr33806610ybg.459.1619565567743;
 Tue, 27 Apr 2021 16:19:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210427170859.579924-1-jackmanb@google.com> <CAEf4BzZimYsgp3AS72U8nOXfryB6dVxQKetT_6yE3xzztdTyZg@mail.gmail.com>
 <CACYkzJ57LqsDBgJpTZ6X-mEabgNK60J=2CJEhUWoQU6wALvQVw@mail.gmail.com>
In-Reply-To: <CACYkzJ57LqsDBgJpTZ6X-mEabgNK60J=2CJEhUWoQU6wALvQVw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 27 Apr 2021 16:19:16 -0700
Message-ID: <CAEf4Bzb+OGZrvmgLk3C1bGtmyLU9JiJKp2WfgGkWq0nW0Tq32g@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Fix signed overflow in ringbuf_process_ring
To:     KP Singh <kpsingh@kernel.org>
Cc:     Brendan Jackman <jackmanb@google.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 27, 2021 at 4:05 PM KP Singh <kpsingh@kernel.org> wrote:
>
> On Tue, Apr 27, 2021 at 11:34 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Tue, Apr 27, 2021 at 10:09 AM Brendan Jackman <jackmanb@google.com> wrote:
> > >
> > > One of our benchmarks running in (Google-internal) CI pushes data
> > > through the ringbuf faster than userspace is able to consume
> > > it. In this case it seems we're actually able to get >INT_MAX entries
> > > in a single ringbuf_buffer__consume call. ASAN detected that cnt
> > > overflows in this case.
> > >
> > > Fix by just setting a limit on the number of entries that can be
> > > consumed.
> > >
> > > Fixes: bf99c936f947 (libbpf: Add BPF ring buffer support)
> > > Signed-off-by: Brendan Jackman <jackmanb@google.com>
> > > ---
> > >  tools/lib/bpf/ringbuf.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
> > > index e7a8d847161f..445a21df0934 100644
> > > --- a/tools/lib/bpf/ringbuf.c
> > > +++ b/tools/lib/bpf/ringbuf.c
> > > @@ -213,8 +213,8 @@ static int ringbuf_process_ring(struct ring* r)
> > >         do {
> > >                 got_new_data = false;
> > >                 prod_pos = smp_load_acquire(r->producer_pos);
> > > -               while (cons_pos < prod_pos) {
> > > +               /* Don't read more than INT_MAX, or the return vale won't make sense. */
> > > +               while (cons_pos < prod_pos && cnt < INT_MAX) {
> >
> > ring_buffer__pool() is assumed to not return until all the enqueued
> > messages are consumed. That's the requirement for the "adaptive"
> > notification scheme to work properly. So this will break that and
> > cause the next ring_buffer__pool() to never wake up.
> >
> > We could use __u64 internally and then cap it to INT_MAX on return
> > maybe? But honestly, this sounds like an artificial corner case, if
> > you are producing data faster than you can consume it and it goes
> > beyond INT_MAX, something is seriously broken in your application and
>
> Disclaimer: I don't know what Brendan's benchmark is actually doing
>
> That said, I have seen similar boundaries being reached when
> doing process monitoring and then a kernel gets compiled (esp. with ccache)
> and generates a large amount of process events in a very short span of time.
> Another example is when someone runs a short process in a tight while loop.
>
> I agree it's a matter of tuning, but since these corner cases can be
> easily triggered
> even on real (non CI) systems no matter how much one tunes, I wouldn't
> really call it artificial :)

Well of course, given sufficiently active kernel sample producer and
sufficiently slow consumer you can keep consuming forever.

I think we have two alternatives here:
1) consume all but cap return to INT_MAX
2) consume all but return long long as return result

Third alternative is to have another API with maximum number of
samples to consume. But then user needs to know what they are doing
(e.g., they do FORCE on BPF side, or they do their own epoll_wait, or
they do ring_buffer__poll with timeout = 0, etc).

I'm just not sure anyone would want to understand all the
implications. And it's easy to miss those implications. So maybe let's
do long long (or __s64) return type instead?

>
> - KP
>
> > you have more important things to handle :)
> >
> > >                         len_ptr = r->data + (cons_pos & r->mask);
> > >                         len = smp_load_acquire(len_ptr);
> > >
> > > --
> > > 2.31.1.498.g6c1eba8ee3d-goog
> > >
