Return-Path: <bpf+bounces-8537-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E0E787C0A
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 01:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 547361C20F33
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 23:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E821C2D1;
	Thu, 24 Aug 2023 23:42:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9F8C140
	for <bpf@vger.kernel.org>; Thu, 24 Aug 2023 23:42:19 +0000 (UTC)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA3019AE
	for <bpf@vger.kernel.org>; Thu, 24 Aug 2023 16:42:17 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2bb99fbaebdso5274601fa.0
        for <bpf@vger.kernel.org>; Thu, 24 Aug 2023 16:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692920536; x=1693525336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r+oFTxNpYxKdQFZ6Z0gkBRjAG8SUjM+wGdL7le5uxBA=;
        b=NouPtGGVHy5vuAstQD+JXx3jIDE7NA1Knm+Vt4kVlYs5gxNB3vdkQnlUD/ur4looZN
         s4NP4gisCqubMC3fq3/0a0go/LMDX6ZkaIktCELyhiK9lO8oskU79CO70vT0FZEPJcO6
         gkBhhrXElzurIguUExitEnb5xe1gi/4Tza/yXT+huUOJBQ5YGvjsbFYsP70KhbiOrCsu
         g6+eGXd3CiJwzK2BlHQBYt9tpXJOSYX2CmkyikTHbxRyf1HgGBRbi/y1THhvCfq8ziqx
         hlB1CF7aax3j9WECN+KDs7wXmcFgemYJQccV9Kx/gGu+3AX0AePWGviIe19Pjjqc9Eu7
         I58w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692920536; x=1693525336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r+oFTxNpYxKdQFZ6Z0gkBRjAG8SUjM+wGdL7le5uxBA=;
        b=AEAL6/LzWiCPTox/8dCo+liXhr0RyvAeIuHis/q/4ge0tgSeJV4cadtLLaIyWOOPck
         QcP4XN3M5QL/VXGVed5rF3Va0UPV5OxoqKChSUrdEnAH1P3UfzlhnoRa5HMdj0p0s96M
         Zvt1irWh+515e1VBs0KKXQ8A5GCYbIMbny+mBZPDXszesBVUKQf4TzLoTyliy2bAscJR
         idRuPKcPpCMzzSu0KTBJa1d/GgwViXplr7+U39xAKeqTADlei2UZmz3xx3ck3bQvOp55
         IqjsXg2b+F9Sg2lcvfC/isgn7t1B3BYGdgnt72nVOsAWnpNiw0E8skw2w2MSjiPny+eZ
         YI7w==
X-Gm-Message-State: AOJu0YwXFq6BrXTSnFiwVAp/oWw86vs+jKjJvRE3CQw0XFe/Qy0NudYK
	x44qrloqBSs9aUpSkntmsUylpk+gmdVRy16da3SsWZu4M1KXLg==
X-Google-Smtp-Source: AGHT+IERzgdTdsMnLeVRGEPiAEy8/UUqHrLfRdf9BCil2DsxPnL5mVjT3SAZc7NVGWQLgI8VD1LUjISXmzFHNabn030=
X-Received: by 2002:a2e:8045:0:b0:2bc:d404:fa22 with SMTP id
 p5-20020a2e8045000000b002bcd404fa22mr7213844ljg.11.1692920535752; Thu, 24 Aug
 2023 16:42:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230824220907.1172808-1-awerner32@gmail.com> <20230824224601.GC11642@maniforge>
In-Reply-To: <20230824224601.GC11642@maniforge>
From: Andrew Werner <awerner32@gmail.com>
Date: Thu, 24 Aug 2023 19:42:04 -0400
Message-ID: <CA+vRuzOLArKcmrXeoaJPcgUXtKiwy1CyfgYwZbOBFUFJrGPk7A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3] libbpf: handle producer position overflow
To: David Vernet <void@manifault.com>
Cc: bpf@vger.kernel.org, kernel-team@dataexmachina.dev, 
	alexei.starovoitov@gmail.com, andrii@kernel.org, olsajiri@gmail.com, 
	houtao@huaweicloud.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 24, 2023 at 6:46=E2=80=AFPM David Vernet <void@manifault.com> w=
rote:
>
> On Thu, Aug 24, 2023 at 06:09:08PM -0400, Andrew Werner wrote:
> > Before this patch, the producer position could overflow `unsigned
> > long`, in which case libbpf would forever stop processing new writes to
> > the ringbuf. Similarly, overflows of the producer position could result
> > in __bpf_user_ringbuf_peek not discovering available data. This patch
> > addresses that bug by computing using the signed delta between the
> > consumer and producer position to determine if data is available; the
> > delta computation is robust to overflow.
> >
> > A more defensive check could be to ensure that the delta is within
> > the allowed range, but such defensive checks are neither present in
> > the kernel side code nor in libbpf. The overflow that this patch
> > handles can occur while the producer and consumer follow a correct
> > protocol.
> >
> > Secondarily, the type used to represent the positions in the
> > user_ring_buffer functions in both libbpf and the kernel has been
> > changed from u64 to unsigned long to match the type used in the
> > kernel's representation of the structure. The change occurs in the
> > same patch because it's required to align the data availability
> > calculations between the userspace producing ringbuf and the bpf
> > producing ringbuf.
> >
> > Not included in this patch, a selftest was written to demonstrate the
> > bug, and indeed this patch allows the test to continue to make progress
> > past the overflow. The shape of the self test was as follows:
> >
> >  a) Set up ringbuf of 2GB size (the maximum permitted size).
> >  b) reserve+commit maximum-sized records (ULONG_MAX/4) constantly as
> >     fast as possible.
> >
> > With 1 million records per second repro time should be about 4.7 hours.
> > Such a test duration is impractical to run, hence the omission.
> >
> > Additionally, this patch adds commentary around a separate point to not=
e
> > that the modular arithmetic is valid in the face of overflows, as that
> > fact may not be obvious to future readers.
> >
> > v2->v3:
> >   - Changed the representation of the consumer and producer positions
> >     from u64 to unsigned long in user_ring_buffer functions.
> >   - Addressed overflow in __bpf_user_ringbuf_peek.
> >   - Changed data availability computations to use the signed delta
> >     between the consumer and producer positions rather than merely
> >     checking whether their values were unequal.
> > v1->v2:
> >   - Fixed comment grammar.
> >   - Properly formatted subject line.
> >
> > Signed-off-by: Andrew Werner <awerner32@gmail.com>
>
> Hey Andrew,
>
> This LGTM, thanks for finding and fixing this. I left a comment below
> about the cast >=3D vs. equality comparison, but I won't block on it give=
n
> that it's already been discussed on another thread. Here's my tag:
>
> Reviewed-by: David Vernet<void@manifault.com>
>
> > ---
> >  kernel/bpf/ringbuf.c    | 11 ++++++++---
> >  tools/lib/bpf/ringbuf.c | 16 +++++++++++++---
> >  2 files changed, 21 insertions(+), 6 deletions(-)
> >
> > diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
> > index f045fde632e5..0c48673520fb 100644
> > --- a/kernel/bpf/ringbuf.c
> > +++ b/kernel/bpf/ringbuf.c
> > @@ -658,7 +658,7 @@ static int __bpf_user_ringbuf_peek(struct bpf_ringb=
uf *rb, void **sample, u32 *s
> >  {
> >       int err;
> >       u32 hdr_len, sample_len, total_len, flags, *hdr;
> > -     u64 cons_pos, prod_pos;
> > +     unsigned long cons_pos, prod_pos;
> >
> >       /* Synchronizes with smp_store_release() in user-space producer. =
*/
> >       prod_pos =3D smp_load_acquire(&rb->producer_pos);
> > @@ -667,7 +667,12 @@ static int __bpf_user_ringbuf_peek(struct bpf_ring=
buf *rb, void **sample, u32 *s
> >
> >       /* Synchronizes with smp_store_release() in __bpf_user_ringbuf_sa=
mple_release() */
> >       cons_pos =3D smp_load_acquire(&rb->consumer_pos);
> > -     if (cons_pos >=3D prod_pos)
> > +
> > +     /* Check if there's data available by computing the signed delta =
between
> > +      * cons_pos and prod_pos; a negative delta indicates that the con=
sumer has
> > +      * not caught up. This formulation is robust to prod_pos wrapping=
 around.
> > +      */
> > +     if ((long)(cons_pos - prod_pos) >=3D 0)
>
> I see that Andrii suggested doing it this way in [0] so I won't insist
> on changing it, but IMO this is much less readable and more confusing
> than just doing an if (cond_pos =3D=3D prod_pos) with a comment. The way
> it's written this way, it makes it look like there could be a situation
> where cond_pos could be ahead of prod_pos, whereas that would actually
> just be a bug elsewhere that we'd be papering over. I guess this is more
> defensive. In any case, I won't insit on it needing to change.

I am also happy with the !=3D/=3D=3D checks vs this delta checking. Any cas=
t
in C makes me worry I'm doing something wrong. My understanding is
that the C spec doesn't state that `unsigned long` and `long` have to
be the same bit width even in the same program, but that's not
practically going to happen. Even the wraparound behavior and the
representation of negative numbers aren't defined in the spec as I
understand.

I'm going to wait for Andrii to opine before doing anything to avoid
excessive churn.

>
> [0]: https://lore.kernel.org/all/CAEf4BzZQQ=3Dfz+NqFHhJcqKoVAvh4=3DXbH7HW=
aHKjUg5OOzi-PTw@mail.gmail.com/
>
> >               return -ENODATA;
> >
> >       hdr =3D (u32 *)((uintptr_t)rb->data + (uintptr_t)(cons_pos & rb->=
mask));
> > @@ -711,7 +716,7 @@ static int __bpf_user_ringbuf_peek(struct bpf_ringb=
uf *rb, void **sample, u32 *s
> >
> >  static void __bpf_user_ringbuf_sample_release(struct bpf_ringbuf *rb, =
size_t size, u64 flags)
> >  {
> > -     u64 consumer_pos;
> > +     unsigned long consumer_pos;
> >       u32 rounded_size =3D round_up(size + BPF_RINGBUF_HDR_SZ, 8);
> >
> >       /* Using smp_load_acquire() is unnecessary here, as the busy-bit
> > diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
> > index 02199364db13..141030a89370 100644
> > --- a/tools/lib/bpf/ringbuf.c
> > +++ b/tools/lib/bpf/ringbuf.c
> > @@ -237,7 +237,13 @@ static int64_t ringbuf_process_ring(struct ring *r=
)
> >       do {
> >               got_new_data =3D false;
> >               prod_pos =3D smp_load_acquire(r->producer_pos);
> > -             while (cons_pos < prod_pos) {
> > +
> > +             /* Check if there's data available by computing the signe=
d delta
> > +              * between cons_pos and prod_pos; a negative delta indica=
tes that the
> > +              * consumer has not caught up. This formulation is robust=
 to prod_pos
> > +              * wrapping around.
> > +              */
> > +             while ((long)(cons_pos - prod_pos) < 0) {
>
> Same here. Doing a !=3D is much more clear, in my opinion. Not a blocker
> though.
>
> [...]
>
> Thanks,
> David

