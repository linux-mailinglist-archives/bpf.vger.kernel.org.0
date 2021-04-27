Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0682436CF3C
	for <lists+bpf@lfdr.de>; Wed, 28 Apr 2021 01:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239185AbhD0XGm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Apr 2021 19:06:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:39010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238340AbhD0XGm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Apr 2021 19:06:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7D8E661404
        for <bpf@vger.kernel.org>; Tue, 27 Apr 2021 23:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619564758;
        bh=bFq91+wLKJQRSGqSZUDMiKbKQv489DmBnnoPHMaipC0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=F9g7ogeuaeGuK8E6M4wsY/KsStsmoCvnPTUbJxNEnBWJ/hbepbbxwg7rklNeKZay5
         y69N2IeNEHdmcvMQuWNRzVInKLsg9eUVyD5uyfvRTuoSbu5707hOsIPY+LvtfPlAJK
         0+GJuQCk+K+GJcKcpklvO/0tUkhfDQYrcSKYi/cOiUg+nwtOKTHbFkRLDmAuoQe5ZC
         XOdQkNdztiqwenZI/2yMVqKq6qlKcI407Qmk55uJj9/vDZRhrVbKchXXWWP4NX7B/J
         2H/hFN/ywykL9UE3y7Lbl9CtRTXL9YM+tiigSU266+hhpz6Y/5bk6egP5CLm+MCRC1
         2hiA4c6pFprnA==
Received: by mail-lf1-f41.google.com with SMTP id 124so15129489lff.5
        for <bpf@vger.kernel.org>; Tue, 27 Apr 2021 16:05:58 -0700 (PDT)
X-Gm-Message-State: AOAM531bD4GJCtoUktnGZ7LoljsifhyY9A+NmK0cFt4HQN6bMOr13kuG
        7JJws72+/v01r4KSxpELiYBGZ93ewEtaeTr9QbITaA==
X-Google-Smtp-Source: ABdhPJxsZ6v+mxsUFoXzh/FT+O/MG75upEAO8bufMjCXZ7qFIi7idLgKAL2HtVk+t5jLV9YS690ht3reB3J1AkFH/04=
X-Received: by 2002:a05:6512:21c2:: with SMTP id d2mr17768323lft.424.1619564756699;
 Tue, 27 Apr 2021 16:05:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210427170859.579924-1-jackmanb@google.com> <CAEf4BzZimYsgp3AS72U8nOXfryB6dVxQKetT_6yE3xzztdTyZg@mail.gmail.com>
In-Reply-To: <CAEf4BzZimYsgp3AS72U8nOXfryB6dVxQKetT_6yE3xzztdTyZg@mail.gmail.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Wed, 28 Apr 2021 01:05:45 +0200
X-Gmail-Original-Message-ID: <CACYkzJ57LqsDBgJpTZ6X-mEabgNK60J=2CJEhUWoQU6wALvQVw@mail.gmail.com>
Message-ID: <CACYkzJ57LqsDBgJpTZ6X-mEabgNK60J=2CJEhUWoQU6wALvQVw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Fix signed overflow in ringbuf_process_ring
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Brendan Jackman <jackmanb@google.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 27, 2021 at 11:34 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Apr 27, 2021 at 10:09 AM Brendan Jackman <jackmanb@google.com> wrote:
> >
> > One of our benchmarks running in (Google-internal) CI pushes data
> > through the ringbuf faster than userspace is able to consume
> > it. In this case it seems we're actually able to get >INT_MAX entries
> > in a single ringbuf_buffer__consume call. ASAN detected that cnt
> > overflows in this case.
> >
> > Fix by just setting a limit on the number of entries that can be
> > consumed.
> >
> > Fixes: bf99c936f947 (libbpf: Add BPF ring buffer support)
> > Signed-off-by: Brendan Jackman <jackmanb@google.com>
> > ---
> >  tools/lib/bpf/ringbuf.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
> > index e7a8d847161f..445a21df0934 100644
> > --- a/tools/lib/bpf/ringbuf.c
> > +++ b/tools/lib/bpf/ringbuf.c
> > @@ -213,8 +213,8 @@ static int ringbuf_process_ring(struct ring* r)
> >         do {
> >                 got_new_data = false;
> >                 prod_pos = smp_load_acquire(r->producer_pos);
> > -               while (cons_pos < prod_pos) {
> > +               /* Don't read more than INT_MAX, or the return vale won't make sense. */
> > +               while (cons_pos < prod_pos && cnt < INT_MAX) {
>
> ring_buffer__pool() is assumed to not return until all the enqueued
> messages are consumed. That's the requirement for the "adaptive"
> notification scheme to work properly. So this will break that and
> cause the next ring_buffer__pool() to never wake up.
>
> We could use __u64 internally and then cap it to INT_MAX on return
> maybe? But honestly, this sounds like an artificial corner case, if
> you are producing data faster than you can consume it and it goes
> beyond INT_MAX, something is seriously broken in your application and

Disclaimer: I don't know what Brendan's benchmark is actually doing

That said, I have seen similar boundaries being reached when
doing process monitoring and then a kernel gets compiled (esp. with ccache)
and generates a large amount of process events in a very short span of time.
Another example is when someone runs a short process in a tight while loop.

I agree it's a matter of tuning, but since these corner cases can be
easily triggered
even on real (non CI) systems no matter how much one tunes, I wouldn't
really call it artificial :)

- KP

> you have more important things to handle :)
>
> >                         len_ptr = r->data + (cons_pos & r->mask);
> >                         len = smp_load_acquire(len_ptr);
> >
> > --
> > 2.31.1.498.g6c1eba8ee3d-goog
> >
