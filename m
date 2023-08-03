Return-Path: <bpf+bounces-6855-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2807576EB5B
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 15:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D786E281164
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 13:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D531F949;
	Thu,  3 Aug 2023 13:59:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757611F195
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 13:59:13 +0000 (UTC)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC782726
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 06:59:07 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b9d07a8d84so15624501fa.3
        for <bpf@vger.kernel.org>; Thu, 03 Aug 2023 06:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691071146; x=1691675946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R2hrsQe5CDFWHLRwtQzfZju+6HU79k9Vd50/YG5VM5Q=;
        b=lu3duGIcZFfO5+ud7EihX/uQenTmy+t6cmIrfEZwWVw+VmhHdp055KllrcbIrIT9uY
         CK/iiE15DWLEZWNoEVHOJ8CJ3ppWwtTsrO60oCpKHVPpUtctaPLbiAP4Ii/4dVafQCii
         vhIEAYBWy7ZYVHawEvjrkrvGBk+wB3lVlaP/HCHCkAHgjqRWpM/bVXi/7oIimALcrw3M
         EbzMBTkFmqM1PIjB1fN9TZiXxn1NYGAtw+8oqqxJ7J275mNqnw0rQS9yyfaTxwW/3Xis
         DvYYPQiDf+C62hpzepQuHqJRrpGLZorEt35dJ/QC+0Rpi8nDVqIEL0ryIhiHifTZEKBN
         r5oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691071146; x=1691675946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R2hrsQe5CDFWHLRwtQzfZju+6HU79k9Vd50/YG5VM5Q=;
        b=lcYY2x28rI14x4jdjJcqM0GRQ90tWSPveUsWPt/y/Cs29hJDFy0/EQIhu/6FFbg9jE
         vbyEZ40dRZ79hc3RtnrUhMy/76N1ucKTv2Cug4qmi0JcGIa4m05/z0H8eVlWJZbjVZtm
         K4jR4BspCdmj6hEZZ+G3UiT5fltm2jMpHqOt1eqVmNKDsWI6W6uKMdWS/rHf8dhO/WnT
         lZRTKdZmsClAL3jbRcWCTfRuJ8B0kT8fAHBEnuqqZAB8+4SJqgl7omobFa3iFDzbh96r
         71ocRpDAOi/nUSjplfahkRi6+MV0EDK2+bsdMjkKtLDH2gn7DD56NR6n5CvrQwhE5sYv
         49kw==
X-Gm-Message-State: ABy/qLZ1qb6O3Enk89xJyJ8tkEsi27UKnOseq0TyxwLMN54BFu8MkpIr
	N5Y+WXqn/t6jHr7jigkYCOFhnv68guM44BGXMck=
X-Google-Smtp-Source: APBJJlGxf+rH9pr+Ow6Rrge5QrUGs62xcFUYMQ3kwkOaGLcoChAAxjINuMcis9nbUjDhY41bNKEGpwAN6/uRQ001UJ8=
X-Received: by 2002:a2e:3307:0:b0:2b6:e76b:1e50 with SMTP id
 d7-20020a2e3307000000b002b6e76b1e50mr7924533ljc.41.1691071145294; Thu, 03 Aug
 2023 06:59:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230724132543.1282645-1-awerner32@gmail.com> <ZMIr2GbRcvihtidX@krava>
 <CABXGaTBFjF8NNLEmpYgeuujS=PQct7PJuQd=FhW1qmvHgOeVBQ@mail.gmail.com> <CAADnVQLJ_ybL-BOGGYJ6HLHR2BVzfxR-KtwpVOum1K1FeJVmFg@mail.gmail.com>
In-Reply-To: <CAADnVQLJ_ybL-BOGGYJ6HLHR2BVzfxR-KtwpVOum1K1FeJVmFg@mail.gmail.com>
From: Andrew Werner <awerner32@gmail.com>
Date: Thu, 3 Aug 2023 09:58:54 -0400
Message-ID: <CA+vRuzMgEHy18wzhbeyiPt5JDdjBniX3piQYRuUqqGU7XLEU+w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] libbpf: handle producer position overflow
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrew Werner <andrew@dataexmachina.dev>, Jiri Olsa <olsajiri@gmail.com>, 
	bpf <bpf@vger.kernel.org>, kernel-team@dataexmachina.dev, 
	Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 2, 2023 at 11:41=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Jul 27, 2023 at 7:48=E2=80=AFAM Andrew Werner <andrew@dataexmachi=
na.dev> wrote:
> >
> > On Thu, Jul 27, 2023 at 4:33=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> =
wrote:
> > >
> > > On Mon, Jul 24, 2023 at 09:25:45AM -0400, Andrew Werner wrote:
> > > > Before this patch, the producer position could overflow `unsigned
> > > > long`, in which case libbpf would forever stop processing new write=
s to
> > > > the ringbuf. This patch addresses that bug by avoiding ordered
> > > > comparison between the consumer and producer position. If the consu=
mer
> > > > position is greater than the producer position, the assumption is t=
hat
> > > > the producer has overflowed.
> > > >
> > > > A more defensive check could be to ensure that the delta is within
> > > > the allowed range, but such defensive checks are neither present in
> > > > the kernel side code nor in libbpf. The overflow that this patch
> > > > handles can occur while the producer and consumer follow a correct
> > > > protocol.
> > > >
> > > > A selftest was written to demonstrate the bug, and indeed this patc=
h
> > > > allows the test to continue to make progress past the overflow.
> > > > However, the author was unable to create a testing environment on a
> > > > 32-bit machine, and the test requires substantial memory and over 4
> > > > hours to hit the overflow point on a 64-bit machine. Thus, the test
> > > > is not included in this patch because of the impracticality of runn=
ing
> > > > it.
>
> Are you saying on a 64-bit host you were able to overflow 64-bit integer
> in 4 hours?
> Interesting.
> Please share the test anyway. As a patch or github link. Anything works.

Here's a link to the test: https://github.com/ajwerner/bpf/commit/85e1240e7=
713

>
> > > >
> > > > Additionally, this patch adds commentary around a separate point to=
 note
> > > > that the modular arithmetic is valid in the face of overflows, as t=
hat
> > > > fact may not be obvious to future readers.
> > > >
> > > > v1->v2:
> > > >  - Fixed comment grammar.
> > > >  - Properly formatted subject line.
> > > >
> > > > Reference:
> > > > [v1]: https://lore.kernel.org/bpf/20230724132404.1280848-1-awerner3=
2@gmail.com/T/#u
> > > >
> > > > Signed-off-by: Andrew Werner <awerner32@gmail.com>
> > > > ---
> > > >  tools/lib/bpf/ringbuf.c | 11 ++++++++++-
> > > >  1 file changed, 10 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
> > > > index 02199364db13..2055f3099843 100644
> > > > --- a/tools/lib/bpf/ringbuf.c
> > > > +++ b/tools/lib/bpf/ringbuf.c
> > > > @@ -237,7 +237,11 @@ static int64_t ringbuf_process_ring(struct rin=
g *r)
> > > >       do {
> > > >               got_new_data =3D false;
> > > >               prod_pos =3D smp_load_acquire(r->producer_pos);
> > > > -             while (cons_pos < prod_pos) {
> > > > +
> > > > +             /* Avoid signed comparisons between the positions; th=
e producer
> > > > +              * position can overflow before the consumer position=
.
> > > > +              */
> > > > +             while (cons_pos !=3D prod_pos) {
> > > >                       len_ptr =3D r->data + (cons_pos & r->mask);
> > > >                       len =3D smp_load_acquire(len_ptr);
> > > >
> > > > @@ -498,6 +502,11 @@ void *user_ring_buffer__reserve(struct user_ri=
ng_buffer *rb, __u32 size)
> > > >       prod_pos =3D smp_load_acquire(rb->producer_pos);
> > > >
> > > >       max_size =3D rb->mask + 1;
> > > > +
> > > > +     /* Note that this formulation is valid in the face of overflo=
w of
> > > > +      * prod_pos so long as the delta between prod_pos and cons_po=
s is
> > > > +      * no greater than max_size.
> > > > +      */
> > > >       avail_size =3D max_size - (prod_pos - cons_pos);
> > >
> > > hi,
> > > the above hunk handles the case for 'prod_pos < cons_pos',
> > >
> > > but it looks like we assume 'cons_pos < prod_pos' in above calculatio=
n,
> > > should we check on that?
> > >
> > > jirka
> >
> > The code there does work (perhaps surprisingly) even if the cons_pos is
> > less than the prod_pos, so long as that delta is no greater than max_si=
ze.
> > I added the commentary there because I too found it to be unintuitive.
> >
> > Consider the following program. It will print "delta: 20".
> >
> > ```c
> > #include <stdio.h>
> > #include <stdlib.h>
> > #include <limits.h>
> >
> > int main() {
> >     unsigned long cons_pos =3D ULONG_MAX - 9;
> >     unsigned long prod_pos =3D 10;
> >     printf("delta: %lu\n", prod_pos - cons_pos);
> >     return 0;
> > }
> > ```
> >
> > -Andrew
> >
> > >
> > >
> > > >       /* Round up total size to a multiple of 8. */
> > > >       total_size =3D (size + BPF_RINGBUF_HDR_SZ + 7) / 8 * 8;
> > > > --
> > > > 2.39.2
> > > >
> > > >
> >

