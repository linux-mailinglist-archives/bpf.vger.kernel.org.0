Return-Path: <bpf+bounces-8423-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5EA6786436
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 02:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B51E11C20D39
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 00:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C4E623;
	Thu, 24 Aug 2023 00:07:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FD4179
	for <bpf@vger.kernel.org>; Thu, 24 Aug 2023 00:07:58 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A670CDA
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 17:07:56 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-52683da3f5cso7679401a12.3
        for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 17:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692835675; x=1693440475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QL9jD5n6LtD+KnugdgXmkmMUoPfJ1FH8qar95sjcJAs=;
        b=az0RIBGyuL6BxYXcUnRGdYG4EUiLi9rS/ugmORsJSnBD7ioLdWV9GRlpmAx7pJK35F
         /47no4eKZE1mz7K3X8eASugrIt2ssxkfms9pKUz6wPwR8eGe8YK7jOceQQGg1wD17Zew
         FhA0Xo5H1hehSW7e31r+q1IIuRC2XA70Xr8gqsZcv9r3ik89cCvXAYLV3ZRPmlQFDDIg
         VaZV9Oab98IPu3ppEZdT/8++/+dTP1RmdKox4hvbIl8CG5X4DxUVQ0I+k+NpAS8gqpDW
         1ZinScf/wK/0oUbh71Isr9+Q9OCof3YF9zUTUOaUdGgIZ6qMF2XLgIMyUXP3nfObEbNR
         CI/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692835675; x=1693440475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QL9jD5n6LtD+KnugdgXmkmMUoPfJ1FH8qar95sjcJAs=;
        b=F4Ek2USLX+eMN3nry3nDYWVaeLcWudSH/7UpwurHU5kf/bGQbopiFQvUmdQrpbfwXp
         xqrcfMqzA6ndx+Wh7o+yZLUG5JGA1NYMgL7N6SVCK64CNVa7YclFdE7mVftovJsRscrb
         uf/dtUTqY5+ej9n/gUzRyWgtlI6v81O97G+kgyylDWxVSV5u3/ZQXe89CfepyWU6ExvC
         ovTgnxanO4l5IUp16MaDoAwQKlkF8mylLcJZ4FdWzUIAxXDwoNHu6WMInolsBEEM9Ocd
         Gz+a9OrZac4dxgBQyqLGG0s7L0P33Of1X0a6UkmOyUCo4U+SCkak+Bn4fXJaSGsJog29
         N0lQ==
X-Gm-Message-State: AOJu0YzrQABpyQSflmZfLtRJCBUWXmDDktmRM6mD88CVwQjK0G/9henP
	po77usvkmjix5ahZkEYp2UDW1PRi3XNeRa/5YnM=
X-Google-Smtp-Source: AGHT+IEhm8VcgpcJ+NY6lhlXECBR44NZBWexf63j7DmKkg7yTmvz50zjIqOHr5kTQ9vA77SZMO+TQL3MCALMJQfQ0Oc=
X-Received: by 2002:aa7:da53:0:b0:523:b37e:b83c with SMTP id
 w19-20020aa7da53000000b00523b37eb83cmr11540561eds.37.1692835674726; Wed, 23
 Aug 2023 17:07:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230724132404.1280848-1-awerner32@gmail.com> <CAEf4BzZQQ=fz+NqFHhJcqKoVAvh4=XbH7HWaHKjUg5OOzi-PTw@mail.gmail.com>
 <b226284c-ad1f-ffe8-b10e-94bbf7a00bc7@huaweicloud.com> <CAEf4BzZvBP9fPs7cfrvLvnha-v_9=pVM=uN=vuOXzWqKCZGeyw@mail.gmail.com>
 <CA+vRuzMP+Z4hqEK3g1c51wSO7aSfBb9=d54102puFrR_r_FJyg@mail.gmail.com>
In-Reply-To: <CA+vRuzMP+Z4hqEK3g1c51wSO7aSfBb9=d54102puFrR_r_FJyg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 23 Aug 2023 17:07:42 -0700
Message-ID: <CAEf4BzbG0UvhYbDK1u8nhBEsgyYQxmoNGHgKyeQSH5Spr6As6A@mail.gmail.com>
Subject: Re: [PATCH] libbpf: handle producer position overflow
To: Andrew Werner <awerner32@gmail.com>, David Vernet <void@manifault.com>
Cc: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org, 
	kernel-team@dataexmachina.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 23, 2023 at 3:14=E2=80=AFPM Andrew Werner <awerner32@gmail.com>=
 wrote:
>
> On Wed, Aug 23, 2023 at 12:52=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Tue, Aug 22, 2023 at 6:49=E2=80=AFPM Hou Tao <houtao@huaweicloud.com=
> wrote:
> > >
> > > Hi,
> > >
> > > On 8/22/2023 1:15 PM, Andrii Nakryiko wrote:
> > > > On Mon, Jul 24, 2023 at 6:24=E2=80=AFAM Andrew Werner <awerner32@gm=
ail.com> wrote:
> > > >> Before this patch, the producer position could overflow `unsigned
> > > >> long`, in which case libbpf would forever stop processing new writ=
es to
> > > >> the ringbuf. This patch addresses that bug by avoiding ordered
> > > >> comparison between the consumer and producer position. If the cons=
umer
> > > >> position is greater than the producer position, the assumption is =
that
> > > >> the producer has overflowed.
> > > >>
> > > >> A more defensive check could be to ensure that the delta is within
> > > >> the allowed range, but such defensive checks are neither present i=
n
> > > >> the kernel side code nor in libbpf. The overflow that this patch
> > > >> handles can occur while the producer and consumer follow a correct
> > > >> protocol.
> > > > Yep, great find!
> > > >
> > > >> A selftest was written to demonstrate the bug, and indeed this pat=
ch
> > > >> allows the test to continue to make progress past the overflow.
> > > >> However, the author was unable to create a testing environment on =
a
> > > >> 32-bit machine, and the test requires substantial memory and over =
4
> > > > 2GB of memory for ringbuf, right? Perhaps it would be good to just
> > > > outline the repro, even if we won't have it implemented in selftest=
s.
> > > > Something along the lines of: a) set up ringbuf of 2GB size and
> > > > reserve+commit maximum-sized record (UMAX/4) constantly as fast as
> > > > possible. With 1 million records per second repro time should be ab=
out
> > > > 4.7 hours. Can you please update the commit with something like tha=
t
> > > > instead of a vague "there is repro, but I won't show it ;)" ? Thank=
s!
> > >
> > > I think it would be great that the commit message can elaborate about
> > > the repo. Andrew had already posted an external link to the reproduce=
r
> > > in v2 [0]: https://github.com/ajwerner/bpf/commit/85e1240e7713
> >
> > Yeah, of course, I saw it. I didn't mean that he actually refuses to
> > show repro, it's just that the commit message is vague about it and we
> > should improve that. I think we are on the same page. Including the
> > link to full repro in addition to more detailed description is also
> > good.
>
> I'll update the message as you suggest in v3.
>
> >
> > >
> > > [0]:
> > > https://lore.kernel.org/bpf/20230724132543.1282645-1-awerner32@gmail.=
com/
> > > >> hours to hit the overflow point on a 64-bit machine. Thus, the tes=
t
> > > >> is not included in this patch because of the impracticality of run=
ning
> > > >> it.
> > > >>
> > > >> Additionally, this patch adds commentary around a separate point t=
o note
> > > >> that the modular arithmetic is valid in the face of overflows, as =
that
> > > >> fact may not be obvious to future readers.
> > > >>
> > > >> Signed-off-by: Andrew Werner <awerner32@gmail.com>
> > > >> ---
> > > >>  tools/lib/bpf/ringbuf.c | 11 ++++++++++-
> > > >>  1 file changed, 10 insertions(+), 1 deletion(-)
> > > >>
> > > >> diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
> > > >> index 02199364db13..6271757bc3d2 100644
> > > >> --- a/tools/lib/bpf/ringbuf.c
> > > >> +++ b/tools/lib/bpf/ringbuf.c
> > > >> @@ -237,7 +237,11 @@ static int64_t ringbuf_process_ring(struct ri=
ng *r)
> > > >>         do {
> > > >>                 got_new_data =3D false;
> > > >>                 prod_pos =3D smp_load_acquire(r->producer_pos);
> > > >> -               while (cons_pos < prod_pos) {
> > > >> +
> > > >> +               /* Avoid signed comparisons between the positions;=
 the producer
> > > > "signed comparisons" is confusing and invalid, as cons_pos and
> > > > prod_pos are unsigned and comparison here is unsigned. What you mea=
nt
> > > > is inequality comparison, which is invalid when done naively (like =
it
> > > > is done in libbpf right now, sigh...), if counters can wrap around.
> > > >
> > > >> +                * position can overflow before the consumer posit=
ion.
> > > >> +                */
> > > >> +               while (cons_pos !=3D prod_pos) {
> > > > I'm wondering if we should preserve the "consumer pos is before
> > > > producer pos" check just for clarity's sake (with a comment about
> > > > wrapping around of counters, of course) like:
> > > >
> > > > if ((long)(cons_pos - prod_pos) < 0) ?
>
> Will do.
>
> > > >
> > > > BTW, I think kernel code needs fixing as well in
> > > > __bpf_user_ringbuf_peek (we should compare consumer/producer positi=
ons
> > > > directly, only through subtraction and casting to signed long as
> > > > above), would you be able to fix it at the same time with libbpf?
> > > > Would be good to also double-check the rest of kernel/bpf/ringbuf.c=
 to
> > > > make sure we don't directly compare positions anywhere else.
> > >
> > > I missed __bpf_user_ringbuf_peek() when reviewed the patch. I also ca=
n
> > > help to double-check kernel/bpf/ringbuf.c.
> >
> > great, thanks!
>
> I'll update the code in __bpf_user_ringbuf_peek. One observation is
> that the code there differs from the regular (non-user) ringbuf and
> the libbpf code in that it uses u64 for the positions whereas
> everywhere else (including in the struct definition) the types of
> these positions are unsigned long. I get that on 64-bit architectures,
> practically speaking, these are the same. What I'm less clear on is
> whether there's anything that prevents this code from running (perhaps
> with bugs) on 32-bit machines. I suppose that on little-endian
> machines things will just work out until the positions overflow 32
> bits.
>
> Would it make sense for me to make the change to always use unsigned
> long for these values in the same change?

I'm not sure, but I suspect that u64 usage is not intentional, so we
probably do want to use unsigned long consistently.

cc'ing David as well


>
> >
> > > >
> > > >>                         len_ptr =3D r->data + (cons_pos & r->mask)=
;
> > > >>                         len =3D smp_load_acquire(len_ptr);
> > > >>
> > > >> @@ -498,6 +502,11 @@ void *user_ring_buffer__reserve(struct user_r=
ing_buffer *rb, __u32 size)
> > > >>         prod_pos =3D smp_load_acquire(rb->producer_pos);
> > > >>
> > > >>         max_size =3D rb->mask + 1;
> > > >> +
> > > >> +       /* Note that this formulation in the face of overflow of p=
rod_pos
> > > >> +        * so long as the delta between prod_pos and cons_pos rema=
ins no
> > > >> +        * greater than max_size.
> > > >> +        */
> > > >>         avail_size =3D max_size - (prod_pos - cons_pos);
> > > >>         /* Round up total size to a multiple of 8. */
> > > >>         total_size =3D (size + BPF_RINGBUF_HDR_SZ + 7) / 8 * 8;
> > > >> --
> > > >> 2.39.2
> > > >>
> > > >>
> > > > .
> > >
> > >

