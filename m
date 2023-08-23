Return-Path: <bpf+bounces-8390-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFD8785DE6
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 18:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EC1C1C20C4D
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 16:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B3B1ED5C;
	Wed, 23 Aug 2023 16:52:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965B0C139
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 16:52:44 +0000 (UTC)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D9ECE6
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 09:52:42 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4ff8f2630e3so9319358e87.1
        for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 09:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692809561; x=1693414361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dIxgYVByRKhJBxpLjFO7wIHPk+b5zZXZKALvL79eYjM=;
        b=LoSgphQ4DEHZFXTB+yDlqmQ6OLpiDst3LfmtD8C9Qm+hco7tY8LVBCcoysCyPH+EGi
         W10RlS5ToDMuKjo+VTS0+RVVISUEfrVxqvcg2GErWppixdgCV3L33wepq+9Dbt7t2JZq
         bKgK7U8lwliEpYnUPEBlVkrvk5b2Ut02MZj/S9UPATxm6iJ0ynOC6f2OZcb1+SkUpbwv
         +tnVeuOCoPYxQfl9hTHXAKm2sCjnFoiboOGZ/3jpqogF/XD+69ogIBzmtX/ewJk2Y8yD
         HhuNY5MJGnl+Dq7xiJglH0T5uY62/4lzkDknqX+FxYAJ+RcdNpLaSjcmu2NlJh5YQYiE
         26Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692809561; x=1693414361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dIxgYVByRKhJBxpLjFO7wIHPk+b5zZXZKALvL79eYjM=;
        b=aKyQB1dLID6oSrTmHERbqqxKKxY3DR4MfYzqmNh+gRC/MZoY9gXgoe8tVSyxzjS97u
         g5ajmawm1/E7pJ1MydrSVZCJzLyb+fwWR3F3jAA/qazk/jv7rHRLF87GaXu+l46t/GYf
         dwIJQMQmV+epL1Xy2hnL1sJMVJjb9OcUsmZnp6wnh+pmWRZrFlJnF9fk8/Mxa9HVeCYO
         xPiyodkuGZdv+rd73JTR0xm+/QZBXO4deDc1BgoADDssXR9R9/7AMcaFr/gsgL5SDaVI
         A3OGvrLwzRHLNReV3E+KYKnz3ny1JlGiZt8a5H50N7lNdQ+Sm7L/HkD4Q6Hbp64ifiVX
         SzEA==
X-Gm-Message-State: AOJu0Yyup/qlOp1Lj2oEiv4liyVtiuhC9MBlQj5z8bF3lp1OBGRncW/C
	S4bj+iEzk8WD/Wc0Aazi3XleR2ggriwRhhHXmOw=
X-Google-Smtp-Source: AGHT+IFWu2+3LFDb8jfbqBMvLQPOwK+j6CZTWh6l6ISCNkhJeVkDz1msncdxsCIIWEyf9AaP75bRSdaU67wOy8TT11U=
X-Received: by 2002:a05:6512:b28:b0:4ff:8f44:834f with SMTP id
 w40-20020a0565120b2800b004ff8f44834fmr10933785lfu.38.1692809560360; Wed, 23
 Aug 2023 09:52:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230724132404.1280848-1-awerner32@gmail.com> <CAEf4BzZQQ=fz+NqFHhJcqKoVAvh4=XbH7HWaHKjUg5OOzi-PTw@mail.gmail.com>
 <b226284c-ad1f-ffe8-b10e-94bbf7a00bc7@huaweicloud.com>
In-Reply-To: <b226284c-ad1f-ffe8-b10e-94bbf7a00bc7@huaweicloud.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 23 Aug 2023 09:52:28 -0700
Message-ID: <CAEf4BzZvBP9fPs7cfrvLvnha-v_9=pVM=uN=vuOXzWqKCZGeyw@mail.gmail.com>
Subject: Re: [PATCH] libbpf: handle producer position overflow
To: Hou Tao <houtao@huaweicloud.com>
Cc: Andrew Werner <awerner32@gmail.com>, bpf@vger.kernel.org, kernel-team@dataexmachina.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 22, 2023 at 6:49=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> Hi,
>
> On 8/22/2023 1:15 PM, Andrii Nakryiko wrote:
> > On Mon, Jul 24, 2023 at 6:24=E2=80=AFAM Andrew Werner <awerner32@gmail.=
com> wrote:
> >> Before this patch, the producer position could overflow `unsigned
> >> long`, in which case libbpf would forever stop processing new writes t=
o
> >> the ringbuf. This patch addresses that bug by avoiding ordered
> >> comparison between the consumer and producer position. If the consumer
> >> position is greater than the producer position, the assumption is that
> >> the producer has overflowed.
> >>
> >> A more defensive check could be to ensure that the delta is within
> >> the allowed range, but such defensive checks are neither present in
> >> the kernel side code nor in libbpf. The overflow that this patch
> >> handles can occur while the producer and consumer follow a correct
> >> protocol.
> > Yep, great find!
> >
> >> A selftest was written to demonstrate the bug, and indeed this patch
> >> allows the test to continue to make progress past the overflow.
> >> However, the author was unable to create a testing environment on a
> >> 32-bit machine, and the test requires substantial memory and over 4
> > 2GB of memory for ringbuf, right? Perhaps it would be good to just
> > outline the repro, even if we won't have it implemented in selftests.
> > Something along the lines of: a) set up ringbuf of 2GB size and
> > reserve+commit maximum-sized record (UMAX/4) constantly as fast as
> > possible. With 1 million records per second repro time should be about
> > 4.7 hours. Can you please update the commit with something like that
> > instead of a vague "there is repro, but I won't show it ;)" ? Thanks!
>
> I think it would be great that the commit message can elaborate about
> the repo. Andrew had already posted an external link to the reproducer
> in v2 [0]: https://github.com/ajwerner/bpf/commit/85e1240e7713

Yeah, of course, I saw it. I didn't mean that he actually refuses to
show repro, it's just that the commit message is vague about it and we
should improve that. I think we are on the same page. Including the
link to full repro in addition to more detailed description is also
good.

>
> [0]:
> https://lore.kernel.org/bpf/20230724132543.1282645-1-awerner32@gmail.com/
> >> hours to hit the overflow point on a 64-bit machine. Thus, the test
> >> is not included in this patch because of the impracticality of running
> >> it.
> >>
> >> Additionally, this patch adds commentary around a separate point to no=
te
> >> that the modular arithmetic is valid in the face of overflows, as that
> >> fact may not be obvious to future readers.
> >>
> >> Signed-off-by: Andrew Werner <awerner32@gmail.com>
> >> ---
> >>  tools/lib/bpf/ringbuf.c | 11 ++++++++++-
> >>  1 file changed, 10 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
> >> index 02199364db13..6271757bc3d2 100644
> >> --- a/tools/lib/bpf/ringbuf.c
> >> +++ b/tools/lib/bpf/ringbuf.c
> >> @@ -237,7 +237,11 @@ static int64_t ringbuf_process_ring(struct ring *=
r)
> >>         do {
> >>                 got_new_data =3D false;
> >>                 prod_pos =3D smp_load_acquire(r->producer_pos);
> >> -               while (cons_pos < prod_pos) {
> >> +
> >> +               /* Avoid signed comparisons between the positions; the=
 producer
> > "signed comparisons" is confusing and invalid, as cons_pos and
> > prod_pos are unsigned and comparison here is unsigned. What you meant
> > is inequality comparison, which is invalid when done naively (like it
> > is done in libbpf right now, sigh...), if counters can wrap around.
> >
> >> +                * position can overflow before the consumer position.
> >> +                */
> >> +               while (cons_pos !=3D prod_pos) {
> > I'm wondering if we should preserve the "consumer pos is before
> > producer pos" check just for clarity's sake (with a comment about
> > wrapping around of counters, of course) like:
> >
> > if ((long)(cons_pos - prod_pos) < 0) ?
> >
> > BTW, I think kernel code needs fixing as well in
> > __bpf_user_ringbuf_peek (we should compare consumer/producer positions
> > directly, only through subtraction and casting to signed long as
> > above), would you be able to fix it at the same time with libbpf?
> > Would be good to also double-check the rest of kernel/bpf/ringbuf.c to
> > make sure we don't directly compare positions anywhere else.
>
> I missed __bpf_user_ringbuf_peek() when reviewed the patch. I also can
> help to double-check kernel/bpf/ringbuf.c.

great, thanks!

> >
> >>                         len_ptr =3D r->data + (cons_pos & r->mask);
> >>                         len =3D smp_load_acquire(len_ptr);
> >>
> >> @@ -498,6 +502,11 @@ void *user_ring_buffer__reserve(struct user_ring_=
buffer *rb, __u32 size)
> >>         prod_pos =3D smp_load_acquire(rb->producer_pos);
> >>
> >>         max_size =3D rb->mask + 1;
> >> +
> >> +       /* Note that this formulation in the face of overflow of prod_=
pos
> >> +        * so long as the delta between prod_pos and cons_pos remains =
no
> >> +        * greater than max_size.
> >> +        */
> >>         avail_size =3D max_size - (prod_pos - cons_pos);
> >>         /* Round up total size to a multiple of 8. */
> >>         total_size =3D (size + BPF_RINGBUF_HDR_SZ + 7) / 8 * 8;
> >> --
> >> 2.39.2
> >>
> >>
> > .
>
>

