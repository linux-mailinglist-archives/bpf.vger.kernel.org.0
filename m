Return-Path: <bpf+bounces-13136-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F34F77D546C
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 16:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 937E5B21025
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 14:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8477526291;
	Tue, 24 Oct 2023 14:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mM1HOH6L"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B77328A0
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 14:53:39 +0000 (UTC)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A2C10C9
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 07:53:36 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-53de0d1dc46so7413074a12.3
        for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 07:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698159215; x=1698764015; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cwys6Tea1+0kU5IFYOJb6cGSlacvLAEcBR5tizkk1zQ=;
        b=mM1HOH6Lx8y31ZjBYreFxVm+xyLs/4vCaeO870u8/H6w1tEmCehBksfgFIDtf2bcwr
         uvSyHdmhwQkjryaL2HmQQSIIg7Dh/RxpxKQxf4Y9CuMzBqaBZBrgyYlLh1G2eP4fFloY
         8dEoWBFZ9T/4c04fMHf9eybCOpqau3hojRVh7bDgN0501fgrfQzK03qfuUOMocyoAHwo
         5nb3rECyQ2OZy9RfF7s4Ffq+9xQPa5y+GPsYQqkVXPzhwexbrWvmdK+QS/F/Ux5DmDvK
         9JpR1WrC8OglWtZQYUAPo3wUPDwryHYglnksOaOf23/FH1I8i6KTcTLpAAWuqSMhwERJ
         sXOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698159215; x=1698764015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cwys6Tea1+0kU5IFYOJb6cGSlacvLAEcBR5tizkk1zQ=;
        b=WQUgj0fqsypEhUxRvUaqAq/DHaZvKNHxagJOA24L/qq9UAM+B3l2IB+38wkaVJBSnf
         uGCOm+B2a3xaN171SlO4biRaVzKbupF/PfJiSU9Pr3rbGAu9oni+NKHlZs6u/FMF0SNC
         9orRYK1MSLOiN9w/20UqqngaSzx0bnNhb4cln2YGljjHJ0quwHNSRNX8Ln6VhnXqkFB8
         oUewZUWK24GXuUdVfrQHOCq4fELauteNURJrXWdoAAUL0+qKq/9YXIJKw7QkiIFAB2H2
         b6GdY1xt1GuNMJ6ZvjIpIKoso5qxvhoEPDy5nQdaL3k/wml1TbpAvZuLkFHVLN0dzzi9
         fZxw==
X-Gm-Message-State: AOJu0YxrHJA41+XB3veH3EfCAJ4qmh37+Vv9ET/fPUIrvDZ7hpPS/VxV
	PrOUAtHSsrvEWky1EbHvcYNUTzYlht4NuQtCJKppUP8Z
X-Google-Smtp-Source: AGHT+IFdHSaAtispTTihj010UPI3dK91eVYwrg6vChQ7gM/5Ej1FrJJpxSuLQeE3RFhVM6ur0c+XXJkRqwo8AmO3Fwg=
X-Received: by 2002:a05:6402:26c4:b0:540:4f18:7faf with SMTP id
 x4-20020a05640226c400b005404f187fafmr5672770edd.13.1698159214551; Tue, 24 Oct
 2023 07:53:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231022205743.72352-1-andrii@kernel.org> <20231022205743.72352-3-andrii@kernel.org>
 <5fed076b-597d-1721-2430-155d27188dfe@iogearbox.net>
In-Reply-To: <5fed076b-597d-1721-2430-155d27188dfe@iogearbox.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 24 Oct 2023 07:53:23 -0700
Message-ID: <CAEf4BzafU5qofmEq3Kgpg77TLwLwnZ=8hth63gu5L9omT_USqw@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 2/7] bpf: derive smin/smax from umin/max bounds
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 6:08=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> On 10/22/23 10:57 PM, Andrii Nakryiko wrote:
> > Add smin/smax derivation from appropriate umin/umax values. Previously =
the
> > logic was surprisingly asymmetric, trying to derive umin/umax from smin=
/smax
> > (if possible), but not trying to do the same in the other direction. A =
simple
> > addition to __reg64_deduce_bounds() fixes this.
>
> Do you have a concrete example case where bounds get further refined? Mig=
ht be
> useful to add this to the commit description or as comment in the code fo=
r future
> reference to make this one here more obvious.

Yes, it's one of the crafted tests. I've been adding those issues
where I found bugs or discrepancies between kernel and selftest to the
"crafted list" to make sure all previously broken cases are covered.
Unfortunately I didn't keep a detailed log of cases (as there were
initially too many). I'll try to undo each of these changes and see
what breaks, will take a bit to do this one by one, but it's fine.

What level of details is necessary? Just having a test case? Showing
how the kernel adjusts stuff (I can get verbose debugging logs both
from kernel and selftest)? I'm trying to understand the desired
balance between too little and too much information (and save myself a
lot of time, if I can ;)


>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >   kernel/bpf/verifier.c | 7 +++++++
> >   1 file changed, 7 insertions(+)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index f8fca3fbe20f..885dd4a2ff3a 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -2164,6 +2164,13 @@ static void __reg32_deduce_bounds(struct bpf_reg=
_state *reg)
> >
> >   static void __reg64_deduce_bounds(struct bpf_reg_state *reg)
> >   {
> > +     /* u64 range forms a valid s64 range (due to matching sign bit),
> > +      * so try to learn from that
> > +      */
> > +     if ((s64)reg->umin_value <=3D (s64)reg->umax_value) {
> > +             reg->smin_value =3D max_t(s64, reg->smin_value, reg->umin=
_value);
> > +             reg->smax_value =3D min_t(s64, reg->smax_value, reg->umax=
_value);
> > +     }
> >       /* Learn sign from signed bounds.
> >        * If we cannot cross the sign boundary, then signed and unsigned=
 bounds
> >        * are the same, so combine.  This works even in the negative cas=
e, e.g.
> >
>
>

