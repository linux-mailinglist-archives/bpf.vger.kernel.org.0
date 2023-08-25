Return-Path: <bpf+bounces-8670-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E027788EA8
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 20:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF5651C20FA6
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 18:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FCD3182D1;
	Fri, 25 Aug 2023 18:26:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CEC125D2
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 18:26:00 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D799026A3
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 11:25:58 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-52a4818db4aso1694654a12.2
        for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 11:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692987957; x=1693592757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z1hG5vqpY2VbbWokGM/0uGDd/kPGEW27GGOhozSDe7E=;
        b=Tfr+OU9oFLcgz55IrTzlZb9QF6Uid2gy9bq0zBvtCgEswyNxfHipTth0CGiGT9CbGi
         KuKGfhSxYJnx3QgxEXxqYGktrQhvT/IaylSYeMWMU2vtB8uh1nCYm+RM1eH/b9KuBqOS
         CAza0fhFuozGQdJT50h4ivxlIuY3SPQ2LhIA9pOntlSLa6Hb4yZ1JNUEGalJJqC8bu5M
         RoVZCzdW/7dZCueGGvE0WWQcbxM6jajX/qdj5TgE+C+S8ySEbqbYp9hWFU5NoukzWhEO
         xLF4tzOdSbIwG0X/eH3ZhPjKwD14BB02lEsjZkEiif222kpVMobGPBomIJaapTPXBcaL
         2Gyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692987957; x=1693592757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z1hG5vqpY2VbbWokGM/0uGDd/kPGEW27GGOhozSDe7E=;
        b=g973XQTAdfzprkmaMBb8asWAL88Qhom4GCjNvnkcMM3AE37mhqgVvxxEOs9Jjsy6u/
         1qm7OjGuFcKnBALBT8T6cY7rde3qsZF/F9y3LOSeXJu6aQPo/VfTT66zJNlOB45zBXjQ
         yYP9mcQMTWvOU1wsHuKwfFgZB/MeGQa0T3ORBo3HnYSy28vZxrzoNiPdp8bZuLYbpAAM
         NjpnNCC68vZiQdN9vGX1y1aYPi/mNAjTNovJRMUkw2k660+N8jVdyd8hNUkrJR6fNYlz
         BL/9E8esGsxOMGtAKkpOzcVRKOAixArGW5SoBV+o8PW31m98qzwvQW00n0r9Vmn2uPne
         kLhg==
X-Gm-Message-State: AOJu0YzYi/Ec8jdxi5k1MKcYxnS1ETHEQQmLS8981Oh0YHBGmw8IZDfc
	bYur/nxNpqaeJZclsWOaBBa54Kvq0TwuFY43AZS1rYNEj0I=
X-Google-Smtp-Source: AGHT+IG/L6q9SWcGuoCgmN/yHwgkXvCKp5e2AolE7gImZ9qwe71WLpz3W3pF5B6WfbmzhtoZ6uYMZzTrJewj5k94I5M=
X-Received: by 2002:aa7:ccc9:0:b0:525:7cd4:34da with SMTP id
 y9-20020aa7ccc9000000b005257cd434damr14086672edt.40.1692987957075; Fri, 25
 Aug 2023 11:25:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230824220907.1172808-1-awerner32@gmail.com> <20230824224601.GC11642@maniforge>
 <CA+vRuzOLArKcmrXeoaJPcgUXtKiwy1CyfgYwZbOBFUFJrGPk7A@mail.gmail.com>
In-Reply-To: <CA+vRuzOLArKcmrXeoaJPcgUXtKiwy1CyfgYwZbOBFUFJrGPk7A@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 25 Aug 2023 11:25:45 -0700
Message-ID: <CAEf4BzY1S308AiLNz2bu6FyWijBhRYp+yUWHPHXpu9Mw3SXNUw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3] libbpf: handle producer position overflow
To: Andrew Werner <awerner32@gmail.com>
Cc: David Vernet <void@manifault.com>, bpf@vger.kernel.org, kernel-team@dataexmachina.dev, 
	alexei.starovoitov@gmail.com, andrii@kernel.org, olsajiri@gmail.com, 
	houtao@huaweicloud.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 24, 2023 at 4:42=E2=80=AFPM Andrew Werner <awerner32@gmail.com>=
 wrote:
>
> On Thu, Aug 24, 2023 at 6:46=E2=80=AFPM David Vernet <void@manifault.com>=
 wrote:
> >
> > On Thu, Aug 24, 2023 at 06:09:08PM -0400, Andrew Werner wrote:
> > > Before this patch, the producer position could overflow `unsigned
> > > long`, in which case libbpf would forever stop processing new writes =
to
> > > the ringbuf. Similarly, overflows of the producer position could resu=
lt
> > > in __bpf_user_ringbuf_peek not discovering available data. This patch
> > > addresses that bug by computing using the signed delta between the
> > > consumer and producer position to determine if data is available; the
> > > delta computation is robust to overflow.
> > >
> > > A more defensive check could be to ensure that the delta is within
> > > the allowed range, but such defensive checks are neither present in
> > > the kernel side code nor in libbpf. The overflow that this patch
> > > handles can occur while the producer and consumer follow a correct
> > > protocol.
> > >
> > > Secondarily, the type used to represent the positions in the
> > > user_ring_buffer functions in both libbpf and the kernel has been
> > > changed from u64 to unsigned long to match the type used in the
> > > kernel's representation of the structure. The change occurs in the
> > > same patch because it's required to align the data availability
> > > calculations between the userspace producing ringbuf and the bpf
> > > producing ringbuf.
> > >
> > > Not included in this patch, a selftest was written to demonstrate the
> > > bug, and indeed this patch allows the test to continue to make progre=
ss
> > > past the overflow. The shape of the self test was as follows:
> > >
> > >  a) Set up ringbuf of 2GB size (the maximum permitted size).
> > >  b) reserve+commit maximum-sized records (ULONG_MAX/4) constantly as
> > >     fast as possible.
> > >
> > > With 1 million records per second repro time should be about 4.7 hour=
s.
> > > Such a test duration is impractical to run, hence the omission.
> > >
> > > Additionally, this patch adds commentary around a separate point to n=
ote
> > > that the modular arithmetic is valid in the face of overflows, as tha=
t
> > > fact may not be obvious to future readers.
> > >
> > > v2->v3:
> > >   - Changed the representation of the consumer and producer positions
> > >     from u64 to unsigned long in user_ring_buffer functions.
> > >   - Addressed overflow in __bpf_user_ringbuf_peek.
> > >   - Changed data availability computations to use the signed delta
> > >     between the consumer and producer positions rather than merely
> > >     checking whether their values were unequal.
> > > v1->v2:
> > >   - Fixed comment grammar.
> > >   - Properly formatted subject line.
> > >
> > > Signed-off-by: Andrew Werner <awerner32@gmail.com>
> >
> > Hey Andrew,
> >
> > This LGTM, thanks for finding and fixing this. I left a comment below
> > about the cast >=3D vs. equality comparison, but I won't block on it gi=
ven
> > that it's already been discussed on another thread. Here's my tag:
> >
> > Reviewed-by: David Vernet<void@manifault.com>
> >
> > > ---
> > >  kernel/bpf/ringbuf.c    | 11 ++++++++---
> > >  tools/lib/bpf/ringbuf.c | 16 +++++++++++++---
> > >  2 files changed, 21 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
> > > index f045fde632e5..0c48673520fb 100644
> > > --- a/kernel/bpf/ringbuf.c
> > > +++ b/kernel/bpf/ringbuf.c
> > > @@ -658,7 +658,7 @@ static int __bpf_user_ringbuf_peek(struct bpf_rin=
gbuf *rb, void **sample, u32 *s
> > >  {
> > >       int err;
> > >       u32 hdr_len, sample_len, total_len, flags, *hdr;
> > > -     u64 cons_pos, prod_pos;
> > > +     unsigned long cons_pos, prod_pos;
> > >
> > >       /* Synchronizes with smp_store_release() in user-space producer=
. */
> > >       prod_pos =3D smp_load_acquire(&rb->producer_pos);
> > > @@ -667,7 +667,12 @@ static int __bpf_user_ringbuf_peek(struct bpf_ri=
ngbuf *rb, void **sample, u32 *s
> > >
> > >       /* Synchronizes with smp_store_release() in __bpf_user_ringbuf_=
sample_release() */
> > >       cons_pos =3D smp_load_acquire(&rb->consumer_pos);
> > > -     if (cons_pos >=3D prod_pos)
> > > +
> > > +     /* Check if there's data available by computing the signed delt=
a between
> > > +      * cons_pos and prod_pos; a negative delta indicates that the c=
onsumer has
> > > +      * not caught up. This formulation is robust to prod_pos wrappi=
ng around.
> > > +      */
> > > +     if ((long)(cons_pos - prod_pos) >=3D 0)
> >
> > I see that Andrii suggested doing it this way in [0] so I won't insist
> > on changing it, but IMO this is much less readable and more confusing
> > than just doing an if (cond_pos =3D=3D prod_pos) with a comment. The wa=
y

this is a canonical way of comparing two counters that can wrap over,
just like time_before() for jiffies. We can add a small macro similar
to time_before(), but I figured given it's in one place in kernel's
ringbuf, it should be fine

as for just using inequality here, I still would prefer to preserve
original semantics (cons_pos >=3D prod_pos) instead of having to analyze
anew whether just doing inequality here and handling potentially
garbage data later on would be always correct.

For libbpf side, given we expect kernel to behave correctly always,
inequality would be a bit more acceptable, but I'd still keep
inequality just like in the original code (except taking into account
wraparound possibility)


> > it's written this way, it makes it look like there could be a situation
> > where cond_pos could be ahead of prod_pos, whereas that would actually
> > just be a bug elsewhere that we'd be papering over. I guess this is mor=
e
> > defensive. In any case, I won't insit on it needing to change.
>
> I am also happy with the !=3D/=3D=3D checks vs this delta checking. Any c=
ast
> in C makes me worry I'm doing something wrong. My understanding is
> that the C spec doesn't state that `unsigned long` and `long` have to
> be the same bit width even in the same program, but that's not
> practically going to happen. Even the wraparound behavior and the
> representation of negative numbers aren't defined in the spec as I
> understand.

I haven't studied C spec and don't really want to :) but if ever
signed vs unsigned changed the size of int/long/long long, so much
code would be broken, that I refuse to worry about this :) Similarly
such comparison-in-the-face-of-wrapping is done all the time in kernel
for jiffies comparison and such, so we are not charting a new
territory here.

>
> I'm going to wait for Andrii to opine before doing anything to avoid
> excessive churn.
>
> >
> > [0]: https://lore.kernel.org/all/CAEf4BzZQQ=3Dfz+NqFHhJcqKoVAvh4=3DXbH7=
HWaHKjUg5OOzi-PTw@mail.gmail.com/
> >
> > >               return -ENODATA;
> > >
> > >       hdr =3D (u32 *)((uintptr_t)rb->data + (uintptr_t)(cons_pos & rb=
->mask));
> > > @@ -711,7 +716,7 @@ static int __bpf_user_ringbuf_peek(struct bpf_rin=
gbuf *rb, void **sample, u32 *s
> > >
> > >  static void __bpf_user_ringbuf_sample_release(struct bpf_ringbuf *rb=
, size_t size, u64 flags)
> > >  {
> > > -     u64 consumer_pos;
> > > +     unsigned long consumer_pos;
> > >       u32 rounded_size =3D round_up(size + BPF_RINGBUF_HDR_SZ, 8);
> > >
> > >       /* Using smp_load_acquire() is unnecessary here, as the busy-bi=
t
> > > diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
> > > index 02199364db13..141030a89370 100644
> > > --- a/tools/lib/bpf/ringbuf.c
> > > +++ b/tools/lib/bpf/ringbuf.c
> > > @@ -237,7 +237,13 @@ static int64_t ringbuf_process_ring(struct ring =
*r)
> > >       do {
> > >               got_new_data =3D false;
> > >               prod_pos =3D smp_load_acquire(r->producer_pos);
> > > -             while (cons_pos < prod_pos) {
> > > +
> > > +             /* Check if there's data available by computing the sig=
ned delta
> > > +              * between cons_pos and prod_pos; a negative delta indi=
cates that the
> > > +              * consumer has not caught up. This formulation is robu=
st to prod_pos
> > > +              * wrapping around.
> > > +              */
> > > +             while ((long)(cons_pos - prod_pos) < 0) {
> >
> > Same here. Doing a !=3D is much more clear, in my opinion. Not a blocke=
r
> > though.
> >
> > [...]
> >
> > Thanks,
> > David

