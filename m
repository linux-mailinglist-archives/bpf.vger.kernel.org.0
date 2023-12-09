Return-Path: <bpf+bounces-17311-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D2580B20F
	for <lists+bpf@lfdr.de>; Sat,  9 Dec 2023 05:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94E8AB20C7E
	for <lists+bpf@lfdr.de>; Sat,  9 Dec 2023 04:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CF615AD;
	Sat,  9 Dec 2023 04:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cvt7t+uN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E884810D8
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 20:45:44 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-a1f37fd4b53so301829366b.1
        for <bpf@vger.kernel.org>; Fri, 08 Dec 2023 20:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702097143; x=1702701943; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PrYi/BHuvETYPKlQUD7Cg+lFcK3UpvAcaCuA3m0/Hkg=;
        b=Cvt7t+uNa2sc34TQi5LJWxHSypuc5jIX43vSusGqUcpgF7IWIeaKIbL/WsvB3/6gbj
         tP+qQkfJxs1iMqMdGdsRtI63UyQGIFPfwlOgGYZSMVCT3Cp76KvU6ySNCHPzInz3J1yi
         QcuWUF7sy0U9AkvOPVuCL1Jua0yNk5YJExzG2r8aFeKaH+Ks8FT65CHkZ2rj2vSo1U0X
         r3e+KbH4itcQntFb/HYvD8usT/UUtAnoUbEsILY6k/Mwrvh0MrErRg9KeeRzQaZiRX9i
         rDI+Arxf0aHzTD6llG7el6hz0X7fwR5Zax5Kt34UnJWSRrS9ROWBnjt/DzXrr8igLIxi
         T3gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702097143; x=1702701943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PrYi/BHuvETYPKlQUD7Cg+lFcK3UpvAcaCuA3m0/Hkg=;
        b=AbkGeR2cmHHzkVSQGrRl+WPlad8ksnv4x0K86gItHB9+IL0LKOwmiFMnzxmDERoTW6
         yrmlomwYXdJNvQbhky8L6i+SUvA0FydRotx7iBUCvp+rwEy9DicnOyHfPKQUjxL4JW9B
         MOn4wI3CgPuL4uMCKH8HW1vO8VLRmtxfpqEjAmn18JRJDJFuCA3BTw7albAabtbKt0Zf
         PP64ClhpqffeA2LYS7g1T/Z13Dxwt7stykqRHbGHJrcP3DPPg6oWbAmOry7cpyMCBBaR
         uZTg194+1EqFhv8Ozdyi/Yr3K4TsnGpisqwkun3WrcgYCz1eJIXQjwwuVTqc2WtZbYYj
         G3Og==
X-Gm-Message-State: AOJu0YzdadxikI1VheeEWa2e9Jy+UYdD78hFTFKKMXHyw4Rxy5gHAx2C
	aR1ISN6gAPR2ukVYfXJ86y72eWL5Q4jjd2hFWW3d0mux
X-Google-Smtp-Source: AGHT+IGGx+0YG0zW1rHch6K1PYIVtSVVvW+w50x66Uxw+lwnzWiNHH1VbFGJE4lEwbe9H4ip3Mey+LFv1yrPZODCnmQ=
X-Received: by 2002:a17:907:960c:b0:a19:a1ba:da6d with SMTP id
 gb12-20020a170907960c00b00a19a1bada6dmr615758ejc.148.1702097143047; Fri, 08
 Dec 2023 20:45:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204153919.11967-1-andreimatei1@gmail.com>
 <CAEf4BzZ57kAWYDBwpxxAsWRyo5fvnHf5-R+OZuPSd1L-viQDig@mail.gmail.com>
 <CABWLsetTu3fBcJaVhC8D-ZDBR0n4HM5xkhk1pA9KA+_-nZy9cw@mail.gmail.com>
 <CAEf4BzYhn7wD102_5E0jqiP4yH7prb-RyTTHaF_3fuVPVN--Og@mail.gmail.com>
 <CABWLses4A1W4kMAqiEd8drL6PKiK7egk_btT7OH3C=LxC4vefQ@mail.gmail.com>
 <CAEf4Bzb6+dF5r4rvcPakoVS_+GOXVs=3wgPEvFMoiGxwB0evqA@mail.gmail.com>
 <CABWLseupmKtmQX4SnRF0r9taU4QNwQunU+f79QFQ1V4KXo=TKA@mail.gmail.com>
 <CAEf4Bzac94=uum2ORYWR2i_qYpmyde2xTLucDf_+EtFE9vCw9Q@mail.gmail.com> <CAP01T75f6AojB2pLr9RJtrJXfsE+FMJ5HZHyew0KPLCbm9y3ig@mail.gmail.com>
In-Reply-To: <CAP01T75f6AojB2pLr9RJtrJXfsE+FMJ5HZHyew0KPLCbm9y3ig@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 8 Dec 2023 20:45:31 -0800
Message-ID: <CAEf4Bzb1p5_3sKF5QW3ftBjQh5CaFWwZvhVRGeqTYbzhOkaeeg@mail.gmail.com>
Subject: Re: [PATCH bpf V2 1/1] bpf: fix verification of indirect var-off
 stack access
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Andrei Matei <andreimatei1@gmail.com>, bpf@vger.kernel.org, sunhao.th@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 8, 2023 at 6:46=E2=80=AFPM Kumar Kartikeya Dwivedi <memxor@gmai=
l.com> wrote:
>
> On Fri, 8 Dec 2023 at 23:15, Andrii Nakryiko <andrii.nakryiko@gmail.com> =
wrote:
> >
> > On Thu, Dec 7, 2023 at 7:23=E2=80=AFPM Andrei Matei <andreimatei1@gmail=
.com> wrote:
> > >
> > > [...]
> > >
> > > > >
> > > > > Ack. Still, if you don't mind entertaining me further, two more q=
uestions:
> > > > >
> > > > > 1. What do you make of the code in check_mem_size_reg() [1] where=
 we do
> > > > >
> > > > > if (reg->umin_value =3D=3D 0) {
> > > > >   err =3D check_helper_mem_access(env, regno - 1, 0,
> > > > >         zero_size_allowed,
> > > > >         meta);
> > > > >
> > > > > followed by
> > > > >
> > > > > err =3D check_helper_mem_access(env, regno - 1,
> > > > >       reg->umax_value,
> > > > >       zero_size_allowed, meta);
> > > > >
> > > > > [1] https://github.com/torvalds/linux/blob/bee0e7762ad2c6025b9f52=
45c040fcc36ef2bde8/kernel/bpf/verifier.c#L7486-L7489
> > > > >
> > > > > What's the point of the first check_helper_mem_access() call - th=
e
> > > > > zero-sized one
> > > > > (given that we also have the second, broader, check)? Could it be
> > > > > simply replaced by a
> > > > >
> > > > > if (reg->umin_value =3D=3D 0 && !zero_sized_allowed)
> > > > >     err =3D no_bueno;
> > > > >
> > > >
> > > > Maybe Kumar (cc'ed) can chime in as well, but I suspect that's exac=
tly
> > > > this, and kind of similar to the min_off/max_off discussion we had.=
 So
> > > > yes, I suspect the above simple and straightforward check would be
> > > > much more meaningful and targeted.
> > >
> > > I plan on trying this in a bit; sounds like you're encouraging it.
> > >
> > > >
> > > > I gotta say that the reg->smin_value < 0 check is confusing, though=
,
> > > > I'm not sure why we are mixing smin and umin/umax in this change...
> > >
> > > When you say "in this change", you mean in the existing code, yeah?  =
I'm not
> >
> > Yeah, sorry, words are hard. It's clearly a question about pre-existing=
 code.
> >
> > > familiar enough with the smin/umin tracking to tell if `reg->smin_val=
ue >=3D 0`
> > > (the condition that the function tests first) implies that
> > > `reg->smin_value =3D=3D reg->umin_value` (i.e. the fact that we're cu=
rrently mixing
> >
> > this is probably true most of the time, but knowing how tricky this
> > range tracking is, there is non-zero chance that this is not always
> > true. Which is why I'm a bit confused why we are freely intermixing
> > signed/unsigned range in this code.
> >
> > > smin/umin in check_mem_size_reg() is confusing, but benign).  Is that=
 true? If
> > > so, are you saying that check_mem_size_reg() should exclusively use s=
min/smax?
> > >
> >
> > I'd like to hear from Kumar on what was the intent before suggesting
> > changing anything.
>
> So this was not originally from me, I just happened to move it around
> when adding support for this to kfuncs into a shared helper (if you
> look at the git blame), it's hard for me to comment on the original
> intent, I would know as much as anyone else.
>
> But to helpful, I digged around a bit and found the original patch
> adding this snippet:
>
> 06c1c049721a ("bpf: allow helpers access to variable memory")
>
> It seems the main reason to add that < 0 check on min value was to
> tell the user in the specific case where a spilled value is reloaded
> from stack that they need to mask it again using bitwise operations,
> because back then a spilled constant when reloaded would become
> unknown, and when passed as a parameter to a helper the program would
> be rejected with a weird error trying to access size greater than the
> user specified in C.
>
> Now this change predates the signed/unsigned distinction, that came in:
>
> b03c9f9fdc37 ("bpf/verifier: track signed and unsigned min/max values")
>
> That changes reg->min_value to reg->smin_value, the < 0 comparison
> only makes sense for that.
> Since then that part of the code has stayed the same.
>
> So I think it would probably be better to just use smin/smax as you
> discussed above upthread, also since the BPF_MAX_VAR_SIZE is INT_MAX,
> so it shouldn't be a problem.

Great, thanks for the code archeology tour, Kumar! :)

>
> >
> > >
> > > [...]

