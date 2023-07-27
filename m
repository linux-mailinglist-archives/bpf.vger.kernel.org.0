Return-Path: <bpf+bounces-6084-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1EA6765660
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 16:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2033E1C210BF
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 14:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0806217AA9;
	Thu, 27 Jul 2023 14:46:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54111988B
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 14:46:34 +0000 (UTC)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF01430F9
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 07:46:11 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4fb863edcb6so1869075e87.0
        for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 07:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dataexmachina-dev.20221208.gappssmtp.com; s=20221208; t=1690469170; x=1691073970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rk1uYl2I63tr6ax8wl3xvne6XkcSkbN/oWsXfw/+F/A=;
        b=NFrvWTj5kVAIXV5ndLe1Csnt6uT8SChc2oyo/MAGN53Y+Myzswar2VGUXJDdBTTLTr
         WjkAHQQqtV4EakTb4vBhrM91ZDcT0SNJprFv13cclUzdimQhqbW6vw6YtHycP5/rV+iP
         JyBEpzuFD9S519Pv/N5ZKn103kRvFi7AjnUhZDZJAitDpd30iWS/gYui2rsMaIFAT/0U
         sY/1O6SiqGQ7cB+FdabNMYfsNTO7+k64mcz4xr91m/RYtKyckHDk/q7eYkcZI/CjRMLB
         uOg4w+4DbfPum5DScoNcWq10D5hHfRSItdbGq3cXCy8hgm8Kyl4X0vtakXOV5J+oLqWr
         uhaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690469170; x=1691073970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rk1uYl2I63tr6ax8wl3xvne6XkcSkbN/oWsXfw/+F/A=;
        b=PGZx7o7kUNKPU8+zLjp66ojS54UtjI5h+kWuZMm9eYuqiA7YtgA04uZqiNhdd52yNy
         8BfY+CoUHvYi7J/EY1pnqbqKgENx311Or0s68mMwtb4FhJGQk5ub8NckgrlvGCFMpY70
         5/ZvO0+AfZabHxuuV/Egmrhc1cLDCRfVBY0KRRibjCxrntLDZDakvvAk068PoR+9ryLF
         GchiLceD+H2wUE1jrjHfvAzkMtrMWExIEvOCs0GDDLDjjJEsDiHRu230dQlLT5xk6eiT
         vDnTRFOXwmB1AcggznmSwOYUqEuXzZv4jj8lkXhLzBMdre9c+asgsOxhBQRMMlXcAqNo
         D1Hw==
X-Gm-Message-State: ABy/qLZ4Q5aP65gksQE8zpOZSaFddwOJvo3cCT98IIJqBibGW4ag+uFd
	iKSTethWC/wQDCaEsqLovV9eYu11Qfgt4GjVm5+Zuw==
X-Google-Smtp-Source: APBJJlHbU1ScctDmqaCs16ngsdu54Lqmb82yIqwP1z80n2yzB7oxxE1W62/ECS11kfZbHQWsA4IuHn5qAZJ+xZ2j8gc=
X-Received: by 2002:ac2:5337:0:b0:4fe:1bca:d921 with SMTP id
 f23-20020ac25337000000b004fe1bcad921mr715074lfh.21.1690469169928; Thu, 27 Jul
 2023 07:46:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230724132543.1282645-1-awerner32@gmail.com> <ZMIr2GbRcvihtidX@krava>
In-Reply-To: <ZMIr2GbRcvihtidX@krava>
From: Andrew Werner <andrew@dataexmachina.dev>
Date: Thu, 27 Jul 2023 10:45:34 -0400
Message-ID: <CABXGaTBFjF8NNLEmpYgeuujS=PQct7PJuQd=FhW1qmvHgOeVBQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] libbpf: handle producer position overflow
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrew Werner <awerner32@gmail.com>, bpf@vger.kernel.org, kernel-team@dataexmachina.dev, 
	Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 27, 2023 at 4:33=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Mon, Jul 24, 2023 at 09:25:45AM -0400, Andrew Werner wrote:
> > Before this patch, the producer position could overflow `unsigned
> > long`, in which case libbpf would forever stop processing new writes to
> > the ringbuf. This patch addresses that bug by avoiding ordered
> > comparison between the consumer and producer position. If the consumer
> > position is greater than the producer position, the assumption is that
> > the producer has overflowed.
> >
> > A more defensive check could be to ensure that the delta is within
> > the allowed range, but such defensive checks are neither present in
> > the kernel side code nor in libbpf. The overflow that this patch
> > handles can occur while the producer and consumer follow a correct
> > protocol.
> >
> > A selftest was written to demonstrate the bug, and indeed this patch
> > allows the test to continue to make progress past the overflow.
> > However, the author was unable to create a testing environment on a
> > 32-bit machine, and the test requires substantial memory and over 4
> > hours to hit the overflow point on a 64-bit machine. Thus, the test
> > is not included in this patch because of the impracticality of running
> > it.
> >
> > Additionally, this patch adds commentary around a separate point to not=
e
> > that the modular arithmetic is valid in the face of overflows, as that
> > fact may not be obvious to future readers.
> >
> > v1->v2:
> >  - Fixed comment grammar.
> >  - Properly formatted subject line.
> >
> > Reference:
> > [v1]: https://lore.kernel.org/bpf/20230724132404.1280848-1-awerner32@gm=
ail.com/T/#u
> >
> > Signed-off-by: Andrew Werner <awerner32@gmail.com>
> > ---
> >  tools/lib/bpf/ringbuf.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
> > index 02199364db13..2055f3099843 100644
> > --- a/tools/lib/bpf/ringbuf.c
> > +++ b/tools/lib/bpf/ringbuf.c
> > @@ -237,7 +237,11 @@ static int64_t ringbuf_process_ring(struct ring *r=
)
> >       do {
> >               got_new_data =3D false;
> >               prod_pos =3D smp_load_acquire(r->producer_pos);
> > -             while (cons_pos < prod_pos) {
> > +
> > +             /* Avoid signed comparisons between the positions; the pr=
oducer
> > +              * position can overflow before the consumer position.
> > +              */
> > +             while (cons_pos !=3D prod_pos) {
> >                       len_ptr =3D r->data + (cons_pos & r->mask);
> >                       len =3D smp_load_acquire(len_ptr);
> >
> > @@ -498,6 +502,11 @@ void *user_ring_buffer__reserve(struct user_ring_b=
uffer *rb, __u32 size)
> >       prod_pos =3D smp_load_acquire(rb->producer_pos);
> >
> >       max_size =3D rb->mask + 1;
> > +
> > +     /* Note that this formulation is valid in the face of overflow of
> > +      * prod_pos so long as the delta between prod_pos and cons_pos is
> > +      * no greater than max_size.
> > +      */
> >       avail_size =3D max_size - (prod_pos - cons_pos);
>
> hi,
> the above hunk handles the case for 'prod_pos < cons_pos',
>
> but it looks like we assume 'cons_pos < prod_pos' in above calculation,
> should we check on that?
>
> jirka

The code there does work (perhaps surprisingly) even if the cons_pos is
less than the prod_pos, so long as that delta is no greater than max_size.
I added the commentary there because I too found it to be unintuitive.

Consider the following program. It will print "delta: 20".

```c
#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int main() {
    unsigned long cons_pos =3D ULONG_MAX - 9;
    unsigned long prod_pos =3D 10;
    printf("delta: %lu\n", prod_pos - cons_pos);
    return 0;
}
```

-Andrew

>
>
> >       /* Round up total size to a multiple of 8. */
> >       total_size =3D (size + BPF_RINGBUF_HDR_SZ + 7) / 8 * 8;
> > --
> > 2.39.2
> >
> >

