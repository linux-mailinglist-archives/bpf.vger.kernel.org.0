Return-Path: <bpf+bounces-6783-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A61E376DF19
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 05:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E04511C2144B
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 03:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042A38C01;
	Thu,  3 Aug 2023 03:41:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBAD6FDF
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 03:41:40 +0000 (UTC)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69A7E4
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 20:41:38 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fe1c285690so801899e87.3
        for <bpf@vger.kernel.org>; Wed, 02 Aug 2023 20:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691034097; x=1691638897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PyCfkXvXXocqFKUX4dnL0Afmc1NyLTe7tPDz1iAI8f4=;
        b=jBWw1x36aYVNzuSl+DcIXQzqFplsZJCGeaGViaCGsiGRfQ6x3RnZ2KlK++tsF6sFF7
         UY7Pr04is6WA8x6SxIsDhsmcVBKhuMBcUCTKI3GF/PDpzBO4FbBiKCdd2bF5Sc81J51M
         2g8mV6/sNsvw4dxlwuyICN3QcP/BebVBXYzMVKQHCrm6u1CaCkeYSuQAFtIbx7BimpQ+
         gDTaLFmSD56ZwVpnvnW6UzG2Ln+NZCkoeJpogpOVCB3CZ8kZMROVxQ+jw5u1ap56Pr2X
         WdfBlqfSRKRshRrOrTCCHtJwQCOE+rVQMltbLGg4SY4HA2I8QAqNxDh9Jl5WI0QvN7no
         DjMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691034097; x=1691638897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PyCfkXvXXocqFKUX4dnL0Afmc1NyLTe7tPDz1iAI8f4=;
        b=YlPVqMouxcDhBNyZ66DKoBR+gvfjkm6NHS/himWQE2PfAZpeuuh6ynnVYw7RcpogzI
         kpbeQjF7ho1odrPVGIQhCXOki1BDXmBdpEVE4l5Ktzc/0dGZyIAGtTnAF6PyLjFa5YPY
         uxS22IuqjnOVywxIvsBsh/yQjI19g20M0+hu19H+ZEigYBv+qhbR08Sr9SnNwyaHbBWg
         SieEMd7yztQ1VLUEWDPcOKBWVfzgJcUApYHc4yHDX8ao9PygBMsWAtRX2HcO/Bb4IqBW
         vmHKCVWZjPRAzRz6K0FPOGw14bDV6QqY+yICay2CGcrtSffetJ+IwlIsx47Fm1wD9SgJ
         on0A==
X-Gm-Message-State: ABy/qLaXCxXCWy5y09lwe5+PtGGTvSrtsSpupkJDSnWOC0a4yZCRawHY
	Gef9FrhPkSEANdTP0aPflj3eZkVCgjBAWHZ4TPk=
X-Google-Smtp-Source: APBJJlFAcX4Fp+LJFFnaRiHsf8ywCU1CiRlpD1ZTJSkbqYO2cbCbLQchvT9Wl1a50oxTw5liRGmd82Glrc+eWV5PHNY=
X-Received: by 2002:a2e:998f:0:b0:2b9:45ad:88b1 with SMTP id
 w15-20020a2e998f000000b002b945ad88b1mr6873651lji.2.1691034096822; Wed, 02 Aug
 2023 20:41:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230724132543.1282645-1-awerner32@gmail.com> <ZMIr2GbRcvihtidX@krava>
 <CABXGaTBFjF8NNLEmpYgeuujS=PQct7PJuQd=FhW1qmvHgOeVBQ@mail.gmail.com>
In-Reply-To: <CABXGaTBFjF8NNLEmpYgeuujS=PQct7PJuQd=FhW1qmvHgOeVBQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 2 Aug 2023 20:41:25 -0700
Message-ID: <CAADnVQLJ_ybL-BOGGYJ6HLHR2BVzfxR-KtwpVOum1K1FeJVmFg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] libbpf: handle producer position overflow
To: Andrew Werner <andrew@dataexmachina.dev>
Cc: Jiri Olsa <olsajiri@gmail.com>, Andrew Werner <awerner32@gmail.com>, bpf <bpf@vger.kernel.org>, 
	kernel-team@dataexmachina.dev, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 27, 2023 at 7:48=E2=80=AFAM Andrew Werner <andrew@dataexmachina=
.dev> wrote:
>
> On Thu, Jul 27, 2023 at 4:33=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wr=
ote:
> >
> > On Mon, Jul 24, 2023 at 09:25:45AM -0400, Andrew Werner wrote:
> > > Before this patch, the producer position could overflow `unsigned
> > > long`, in which case libbpf would forever stop processing new writes =
to
> > > the ringbuf. This patch addresses that bug by avoiding ordered
> > > comparison between the consumer and producer position. If the consume=
r
> > > position is greater than the producer position, the assumption is tha=
t
> > > the producer has overflowed.
> > >
> > > A more defensive check could be to ensure that the delta is within
> > > the allowed range, but such defensive checks are neither present in
> > > the kernel side code nor in libbpf. The overflow that this patch
> > > handles can occur while the producer and consumer follow a correct
> > > protocol.
> > >
> > > A selftest was written to demonstrate the bug, and indeed this patch
> > > allows the test to continue to make progress past the overflow.
> > > However, the author was unable to create a testing environment on a
> > > 32-bit machine, and the test requires substantial memory and over 4
> > > hours to hit the overflow point on a 64-bit machine. Thus, the test
> > > is not included in this patch because of the impracticality of runnin=
g
> > > it.

Are you saying on a 64-bit host you were able to overflow 64-bit integer
in 4 hours?
Interesting.
Please share the test anyway. As a patch or github link. Anything works.

> > >
> > > Additionally, this patch adds commentary around a separate point to n=
ote
> > > that the modular arithmetic is valid in the face of overflows, as tha=
t
> > > fact may not be obvious to future readers.
> > >
> > > v1->v2:
> > >  - Fixed comment grammar.
> > >  - Properly formatted subject line.
> > >
> > > Reference:
> > > [v1]: https://lore.kernel.org/bpf/20230724132404.1280848-1-awerner32@=
gmail.com/T/#u
> > >
> > > Signed-off-by: Andrew Werner <awerner32@gmail.com>
> > > ---
> > >  tools/lib/bpf/ringbuf.c | 11 ++++++++++-
> > >  1 file changed, 10 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
> > > index 02199364db13..2055f3099843 100644
> > > --- a/tools/lib/bpf/ringbuf.c
> > > +++ b/tools/lib/bpf/ringbuf.c
> > > @@ -237,7 +237,11 @@ static int64_t ringbuf_process_ring(struct ring =
*r)
> > >       do {
> > >               got_new_data =3D false;
> > >               prod_pos =3D smp_load_acquire(r->producer_pos);
> > > -             while (cons_pos < prod_pos) {
> > > +
> > > +             /* Avoid signed comparisons between the positions; the =
producer
> > > +              * position can overflow before the consumer position.
> > > +              */
> > > +             while (cons_pos !=3D prod_pos) {
> > >                       len_ptr =3D r->data + (cons_pos & r->mask);
> > >                       len =3D smp_load_acquire(len_ptr);
> > >
> > > @@ -498,6 +502,11 @@ void *user_ring_buffer__reserve(struct user_ring=
_buffer *rb, __u32 size)
> > >       prod_pos =3D smp_load_acquire(rb->producer_pos);
> > >
> > >       max_size =3D rb->mask + 1;
> > > +
> > > +     /* Note that this formulation is valid in the face of overflow =
of
> > > +      * prod_pos so long as the delta between prod_pos and cons_pos =
is
> > > +      * no greater than max_size.
> > > +      */
> > >       avail_size =3D max_size - (prod_pos - cons_pos);
> >
> > hi,
> > the above hunk handles the case for 'prod_pos < cons_pos',
> >
> > but it looks like we assume 'cons_pos < prod_pos' in above calculation,
> > should we check on that?
> >
> > jirka
>
> The code there does work (perhaps surprisingly) even if the cons_pos is
> less than the prod_pos, so long as that delta is no greater than max_size=
.
> I added the commentary there because I too found it to be unintuitive.
>
> Consider the following program. It will print "delta: 20".
>
> ```c
> #include <stdio.h>
> #include <stdlib.h>
> #include <limits.h>
>
> int main() {
>     unsigned long cons_pos =3D ULONG_MAX - 9;
>     unsigned long prod_pos =3D 10;
>     printf("delta: %lu\n", prod_pos - cons_pos);
>     return 0;
> }
> ```
>
> -Andrew
>
> >
> >
> > >       /* Round up total size to a multiple of 8. */
> > >       total_size =3D (size + BPF_RINGBUF_HDR_SZ + 7) / 8 * 8;
> > > --
> > > 2.39.2
> > >
> > >
>

