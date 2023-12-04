Return-Path: <bpf+bounces-16655-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9C480428A
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 00:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE7B91C20B8E
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 23:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B976A2FC48;
	Mon,  4 Dec 2023 23:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YT6m4HmM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77E1188
	for <bpf@vger.kernel.org>; Mon,  4 Dec 2023 15:28:44 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c9f572c4c5so33933161fa.2
        for <bpf@vger.kernel.org>; Mon, 04 Dec 2023 15:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701732523; x=1702337323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H5B54lJKg1GHl3hc3dVPHJJHySGnnP34piv9RtNjIO0=;
        b=YT6m4HmMgzn+7zt4zz3DPMjSrI4Hc7IoX/fzwwlRh/aVhtfX5fZ4ppDEJjZic0FPwp
         uiKyb7W4FNd+dHN2rbdbL8if0TFXOs3yMZdJq2JOBxRfda5ACyK8fU+wjJdx1JRTzyPr
         UG1XBc9KBHL69DEOquc0mZ1U7IlY/KQu6Oq6twaRGHM4NSCm3FT4p43IvVrCQAzy7IwR
         shEiAkTrFHPp4+OxPh0S61oGsYzDXN2Mfu6yigud6fM+e8ya7l1baLhWKVG7OkbA8rMV
         rQY4uaNZzlNQu2SzT+gBiJYv9gJz9kwczSlULOR298HwFrqnqE1auJkiq7wUne9rs9oi
         biCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701732523; x=1702337323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H5B54lJKg1GHl3hc3dVPHJJHySGnnP34piv9RtNjIO0=;
        b=GMrN+/wRnkLpkS5oCFlY5m6XRW4C7Wglh0/IUIjt8WLWpN/44jQlb7+/gqU+3pMMHj
         kdvnA1KWf0lvsTknNlSJa8B1+itK7jItjMRkM9By8+ftmo/2lioDCFUqW4vPJIS6uaPU
         gmY5sghC1Yyzv92nzzie+UqSYhGhHGysSBuGHr8pTDExL3zTxTD9Qr1VfqwZ5rNi4A50
         aIao9kvNeUgy0mMjNNCehf6n7jjljVbr2NsPNhfkSVgTXYWXlysGO1a1kHOmFlio/Tmp
         LpCvX31kqqDlq+D9wsfn/A62nDe5mzH2gokMY9Wql6k/BdM+tZuHYgIWc1HRaII3ZpMd
         009g==
X-Gm-Message-State: AOJu0YxcdTnyhlshW4ktW+ZX6g4YLlVTUVIGBNgRiLc6TUBvgyupz/iu
	HkplJp7Xzy8xB69D7aeVrNHUdwWlZmPTW87Vl7s5Mx3FR/mqrw==
X-Google-Smtp-Source: AGHT+IEfncTpyh3CETSraseUhDtHM3R1kYDpEkuy0RarE8B+5eZKQ+SfAymSx4l43QaXAHPAjnQ8u6R5bJiw5uPaxHE=
X-Received: by 2002:a2e:9c14:0:b0:2ca:d14:96d0 with SMTP id
 s20-20020a2e9c14000000b002ca0d1496d0mr865706lji.71.1701732522630; Mon, 04 Dec
 2023 15:28:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204153919.11967-1-andreimatei1@gmail.com>
 <CAEf4BzZ57kAWYDBwpxxAsWRyo5fvnHf5-R+OZuPSd1L-viQDig@mail.gmail.com>
 <CABWLsetTu3fBcJaVhC8D-ZDBR0n4HM5xkhk1pA9KA+_-nZy9cw@mail.gmail.com> <CAEf4BzYhn7wD102_5E0jqiP4yH7prb-RyTTHaF_3fuVPVN--Og@mail.gmail.com>
In-Reply-To: <CAEf4BzYhn7wD102_5E0jqiP4yH7prb-RyTTHaF_3fuVPVN--Og@mail.gmail.com>
From: Andrei Matei <andreimatei1@gmail.com>
Date: Mon, 4 Dec 2023 18:28:30 -0500
Message-ID: <CABWLses4A1W4kMAqiEd8drL6PKiK7egk_btT7OH3C=LxC4vefQ@mail.gmail.com>
Subject: Re: [PATCH bpf V2 1/1] bpf: fix verification of indirect var-off
 stack access
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, sunhao.th@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 5:05=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Dec 4, 2023 at 11:52=E2=80=AFAM Andrei Matei <andreimatei1@gmail.=
com> wrote:
> >
> > [...]
> >
> > > >
> > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > index af2819d5c8ee..b646bdde09cd 100644
> > > > --- a/kernel/bpf/verifier.c
> > > > +++ b/kernel/bpf/verifier.c
> > > > @@ -6816,10 +6816,9 @@ static int check_stack_access_within_bounds(
> > > >                         return -EACCES;
> > > >                 }
> > > >                 min_off =3D reg->smin_value + off;
> > > > +               max_off =3D reg->smax_value + off;
> > > >                 if (access_size > 0)
> > > > -                       max_off =3D reg->smax_value + off + access_=
size - 1;
> > > > -               else
> > > > -                       max_off =3D min_off;
> > > > +                       max_off +=3D access_size - 1;
> > >
> > > this special casing of access_size =3D=3D 0 feels wrong (and I mean b=
efore
> > > your patch as well).
> > >
> > > Looking at the code, we only really calculate max_off to check that w=
e
> > > don't go to a non-negative stack offset, e.g., r10+0 or r10+1 (and
> > > beyond).
> > >
> > > So given that, I propose to calculate max_off as an exclusive bound,
> > > and instead of doing a mostly useless check_stack_slot_within_bounds(=
)
> > > call for it, just check that max_off is <=3D 0.
> > >
> > > Something like this:
> > >
> > > min_off =3D reg->smin_value + off;
> > > max_off =3D reg->smax_value + off + access_size;
> > > err =3D check_stack_slot_within_bounds(min_off, state, type);
> > > if (!err && max_off > 0)
> > >     err =3D -EINVAL; /* out of stack access into non-negative offsets=
 */
> >
> > Dealing with access_size =3D=3D 0 indeed feels dubious to me, but I'm n=
ot entirely
> > sure that your suggested code is better. min_off being inclusive and
> > max_off being
> > exclusive seems surprising. I'll do it if you want, I don't care too mu=
ch.
> > We could keep max_off exclusive, and still not call
> > check_stack_slot_within_bounds() for it:
> >
> >  min_off =3D reg->smin_value + off;
> >  max_off =3D reg->smax_value + off + access_size - 1;
> >  err =3D check_stack_slot_within_bounds(min_off, state, type);
> >  if (!err && max_off >=3D 0)
> >      err =3D -EINVAL; /* out of stack access into non-negative offsets =
*/
> >
>
> Yeah, we can do that. The reason I go for max_off being exclusive is
> because using half-opened ranges is very convenient [start, end) (end
> exclusive) is much more uniform and natural to handle compared to
> closed [start, end] (end inclusive), in all sorts of checks, including
> handling empty ranges. The math just works out better and more
> naturally. And it's not like this will be the first time where in BPF
> we have half-open ranges.

Yeah, after hitting send, I was also thinking that half-open is the more co=
mmon
interval representation; it just wasn't how this code right here was writte=
n.
Will do.

>
> > But now max_off can be below min_off, which again seems confusing.
>
> That's ok, the point here is to validate that we don't access stack
> out of bounds.
>
> >
> > What I'd really like to know is whether this whole zero access_size bus=
iness
> > deserves to exist. Do you know what the point of verifying a zero-sized=
 access
> > is exactly / could we turn 0-byte access into 1-byte accesses and
> > verify that instead?
> > Because then there'd be no more special case to consider.
> >
>
>
> I think zero is a natural case that can come up, at least with
> helpers. As we have ARG_CONST_SIZE_OR_ZERO. So yeah, I wouldn't treat
> zero-sized access as 1-byte access, that seems to be more confusing
> and potentially broken.

Ack. Still, if you don't mind entertaining me further, two more questions:

1. What do you make of the code in check_mem_size_reg() [1] where we do

if (reg->umin_value =3D=3D 0) {
  err =3D check_helper_mem_access(env, regno - 1, 0,
        zero_size_allowed,
        meta);

followed by

err =3D check_helper_mem_access(env, regno - 1,
      reg->umax_value,
      zero_size_allowed, meta);

[1] https://github.com/torvalds/linux/blob/bee0e7762ad2c6025b9f5245c040fcc3=
6ef2bde8/kernel/bpf/verifier.c#L7486-L7489

What's the point of the first check_helper_mem_access() call - the
zero-sized one
(given that we also have the second, broader, check)? Could it be
simply replaced by a

if (reg->umin_value =3D=3D 0 && !zero_sized_allowed)
    err =3D no_bueno;

?

2. I believe you're saying that, if we were to verify zero-sized
accesses as 1-byte-sized accesses, we
might refuse some accesses that we permit today, and that wouldn't be
good. But what about
permitting zero-sized accesses with no further checks - i.e.
considering *any* pointer value to
be ok when the access_size =3D=3D 0 ? Would that be bad? The question is,
morally, what checks are
important (if any) when the size of access is zero?
Or to phrase another way - when a helper is called with a zero access
size, do we expect the helper
to do anything with that pointer, or do we expect the helper to be a no-op?

Thank you!


>
> > >
> > >
> > > Now, one more issue that jumped out at me is that we calculate min/ma=
x
> > > off as a sum of smin/smax values (which are checked to be within
> > > +/-1<<29, all good so far) *and* insn->off, which can be a full s32,
> > > it seems. So we are running into overflow/underflow territory with
> > > using int for min_off/max_off.
> > >
> > > While you are at it, can you please use s64 for all these calculation=
s? Thanks!
> > >
> > >
> > > >         }
> > > >
> > > >         err =3D check_stack_slot_within_bounds(min_off, state, type=
);
> >
> > Will do.

