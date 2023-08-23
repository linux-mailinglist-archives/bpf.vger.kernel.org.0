Return-Path: <bpf+bounces-8416-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F36B878633B
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 00:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 290B028135D
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 22:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B831D200B9;
	Wed, 23 Aug 2023 22:14:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D08D1F188
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 22:14:16 +0000 (UTC)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77FDCE71
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 15:14:14 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2bcb0b973a5so67933891fa.3
        for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 15:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692828853; x=1693433653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PhPXd/zLruel1wskZRvacv/z+tm0t1X4GkQuNHWTRR8=;
        b=JY9/V0HI655tN3lsvf06KFPVkLHYxY82OlC9P/mtpwBCfay45T9n8NbdDZHXrR8VbK
         I+adgfFEWEN8RmBZ6SobECz5MaSs5hN0mcZ8whwkvUXcrXwMk9am9RK3iJl1Z+hP+x+q
         4iA57+bCCo3RGEC9g6Z1+FJpQ7mnzvwwlByPNXN4gq8PBw2MI5lxLaT+II/DcrwJi8kR
         43bdn/bMmqgHhi+0oyjbWMZ+EPwlmp+kXtcEyt+BoM/nuzLfGc5y9o7npHwGny7R1MG2
         F9JdPx1f4L8bv7ScYIBd8vr006spbK0IWRh41ABqdJcliKDnEyUMNLm3cN/qRZd4tTFg
         CWow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692828853; x=1693433653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PhPXd/zLruel1wskZRvacv/z+tm0t1X4GkQuNHWTRR8=;
        b=M6X0syNkCj0/h4XWfCk94Xp3cWMHK3GJYYTrenvKN/YYTzKjrdVSNCuSGa+b70k2wi
         Rqkf6jWTeX3FdNiHAxFGe4myYv3sIzR1U0xB181Tco9aG7jW4I8f5Txa7JRY6aLlvEVi
         aIVJ4IeEI8QC90M8+SdHxuWdvB5QK/rA3HGMnY+Yhs8Q25+Nkc/tJcG2qgeYsKJSG9Sr
         zp86HdKFi3HZTluOPEOaxat6eF9RNEedP74wDWPFi7Fy+QonVwDpJYdHdvp4EQAzOEN6
         z6Zsi9EWXiq9my1zxNyWPjgjz4sMpovC/xMtxxrpNt73XeG14DQXqyPOve5tCdDeQ9+w
         va/Q==
X-Gm-Message-State: AOJu0YycrCnkF1VDw+nMKF9fPRb4reYPNNc/qyEK93ih5RZhKA1Wyym5
	Dg3+HsuBzrpEu7tlNg0Krs5pvyI9uGS96eTHZksHDUcwwPz+KA==
X-Google-Smtp-Source: AGHT+IH9NPRzzvxyuk5YYuCOk42nOCcSis9h0wdGdgYuLygwcV4Wt2NwuIZc1DEHGPb8Fp8Tml2Rl91GQBZz7OlImWw=
X-Received: by 2002:a2e:9796:0:b0:2bc:c51d:daa1 with SMTP id
 y22-20020a2e9796000000b002bcc51ddaa1mr7148886lji.39.1692828852281; Wed, 23
 Aug 2023 15:14:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230724132404.1280848-1-awerner32@gmail.com> <CAEf4BzZQQ=fz+NqFHhJcqKoVAvh4=XbH7HWaHKjUg5OOzi-PTw@mail.gmail.com>
 <b226284c-ad1f-ffe8-b10e-94bbf7a00bc7@huaweicloud.com> <CAEf4BzZvBP9fPs7cfrvLvnha-v_9=pVM=uN=vuOXzWqKCZGeyw@mail.gmail.com>
In-Reply-To: <CAEf4BzZvBP9fPs7cfrvLvnha-v_9=pVM=uN=vuOXzWqKCZGeyw@mail.gmail.com>
From: Andrew Werner <awerner32@gmail.com>
Date: Wed, 23 Aug 2023 18:14:00 -0400
Message-ID: <CA+vRuzMP+Z4hqEK3g1c51wSO7aSfBb9=d54102puFrR_r_FJyg@mail.gmail.com>
Subject: Re: [PATCH] libbpf: handle producer position overflow
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org, 
	kernel-team@dataexmachina.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 23, 2023 at 12:52=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Aug 22, 2023 at 6:49=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> =
wrote:
> >
> > Hi,
> >
> > On 8/22/2023 1:15 PM, Andrii Nakryiko wrote:
> > > On Mon, Jul 24, 2023 at 6:24=E2=80=AFAM Andrew Werner <awerner32@gmai=
l.com> wrote:
> > >> Before this patch, the producer position could overflow `unsigned
> > >> long`, in which case libbpf would forever stop processing new writes=
 to
> > >> the ringbuf. This patch addresses that bug by avoiding ordered
> > >> comparison between the consumer and producer position. If the consum=
er
> > >> position is greater than the producer position, the assumption is th=
at
> > >> the producer has overflowed.
> > >>
> > >> A more defensive check could be to ensure that the delta is within
> > >> the allowed range, but such defensive checks are neither present in
> > >> the kernel side code nor in libbpf. The overflow that this patch
> > >> handles can occur while the producer and consumer follow a correct
> > >> protocol.
> > > Yep, great find!
> > >
> > >> A selftest was written to demonstrate the bug, and indeed this patch
> > >> allows the test to continue to make progress past the overflow.
> > >> However, the author was unable to create a testing environment on a
> > >> 32-bit machine, and the test requires substantial memory and over 4
> > > 2GB of memory for ringbuf, right? Perhaps it would be good to just
> > > outline the repro, even if we won't have it implemented in selftests.
> > > Something along the lines of: a) set up ringbuf of 2GB size and
> > > reserve+commit maximum-sized record (UMAX/4) constantly as fast as
> > > possible. With 1 million records per second repro time should be abou=
t
> > > 4.7 hours. Can you please update the commit with something like that
> > > instead of a vague "there is repro, but I won't show it ;)" ? Thanks!
> >
> > I think it would be great that the commit message can elaborate about
> > the repo. Andrew had already posted an external link to the reproducer
> > in v2 [0]: https://github.com/ajwerner/bpf/commit/85e1240e7713
>
> Yeah, of course, I saw it. I didn't mean that he actually refuses to
> show repro, it's just that the commit message is vague about it and we
> should improve that. I think we are on the same page. Including the
> link to full repro in addition to more detailed description is also
> good.

I'll update the message as you suggest in v3.

>
> >
> > [0]:
> > https://lore.kernel.org/bpf/20230724132543.1282645-1-awerner32@gmail.co=
m/
> > >> hours to hit the overflow point on a 64-bit machine. Thus, the test
> > >> is not included in this patch because of the impracticality of runni=
ng
> > >> it.
> > >>
> > >> Additionally, this patch adds commentary around a separate point to =
note
> > >> that the modular arithmetic is valid in the face of overflows, as th=
at
> > >> fact may not be obvious to future readers.
> > >>
> > >> Signed-off-by: Andrew Werner <awerner32@gmail.com>
> > >> ---
> > >>  tools/lib/bpf/ringbuf.c | 11 ++++++++++-
> > >>  1 file changed, 10 insertions(+), 1 deletion(-)
> > >>
> > >> diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
> > >> index 02199364db13..6271757bc3d2 100644
> > >> --- a/tools/lib/bpf/ringbuf.c
> > >> +++ b/tools/lib/bpf/ringbuf.c
> > >> @@ -237,7 +237,11 @@ static int64_t ringbuf_process_ring(struct ring=
 *r)
> > >>         do {
> > >>                 got_new_data =3D false;
> > >>                 prod_pos =3D smp_load_acquire(r->producer_pos);
> > >> -               while (cons_pos < prod_pos) {
> > >> +
> > >> +               /* Avoid signed comparisons between the positions; t=
he producer
> > > "signed comparisons" is confusing and invalid, as cons_pos and
> > > prod_pos are unsigned and comparison here is unsigned. What you meant
> > > is inequality comparison, which is invalid when done naively (like it
> > > is done in libbpf right now, sigh...), if counters can wrap around.
> > >
> > >> +                * position can overflow before the consumer positio=
n.
> > >> +                */
> > >> +               while (cons_pos !=3D prod_pos) {
> > > I'm wondering if we should preserve the "consumer pos is before
> > > producer pos" check just for clarity's sake (with a comment about
> > > wrapping around of counters, of course) like:
> > >
> > > if ((long)(cons_pos - prod_pos) < 0) ?

Will do.

> > >
> > > BTW, I think kernel code needs fixing as well in
> > > __bpf_user_ringbuf_peek (we should compare consumer/producer position=
s
> > > directly, only through subtraction and casting to signed long as
> > > above), would you be able to fix it at the same time with libbpf?
> > > Would be good to also double-check the rest of kernel/bpf/ringbuf.c t=
o
> > > make sure we don't directly compare positions anywhere else.
> >
> > I missed __bpf_user_ringbuf_peek() when reviewed the patch. I also can
> > help to double-check kernel/bpf/ringbuf.c.
>
> great, thanks!

I'll update the code in __bpf_user_ringbuf_peek. One observation is
that the code there differs from the regular (non-user) ringbuf and
the libbpf code in that it uses u64 for the positions whereas
everywhere else (including in the struct definition) the types of
these positions are unsigned long. I get that on 64-bit architectures,
practically speaking, these are the same. What I'm less clear on is
whether there's anything that prevents this code from running (perhaps
with bugs) on 32-bit machines. I suppose that on little-endian
machines things will just work out until the positions overflow 32
bits.

Would it make sense for me to make the change to always use unsigned
long for these values in the same change?

>
> > >
> > >>                         len_ptr =3D r->data + (cons_pos & r->mask);
> > >>                         len =3D smp_load_acquire(len_ptr);
> > >>
> > >> @@ -498,6 +502,11 @@ void *user_ring_buffer__reserve(struct user_rin=
g_buffer *rb, __u32 size)
> > >>         prod_pos =3D smp_load_acquire(rb->producer_pos);
> > >>
> > >>         max_size =3D rb->mask + 1;
> > >> +
> > >> +       /* Note that this formulation in the face of overflow of pro=
d_pos
> > >> +        * so long as the delta between prod_pos and cons_pos remain=
s no
> > >> +        * greater than max_size.
> > >> +        */
> > >>         avail_size =3D max_size - (prod_pos - cons_pos);
> > >>         /* Round up total size to a multiple of 8. */
> > >>         total_size =3D (size + BPF_RINGBUF_HDR_SZ + 7) / 8 * 8;
> > >> --
> > >> 2.39.2
> > >>
> > >>
> > > .
> >
> >

