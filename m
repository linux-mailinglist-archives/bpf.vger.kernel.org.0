Return-Path: <bpf+bounces-17350-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EC080BE0D
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 00:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AF091C208F5
	for <lists+bpf@lfdr.de>; Sun, 10 Dec 2023 23:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82F51DDCC;
	Sun, 10 Dec 2023 23:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdbWVQA3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D92ED
	for <bpf@vger.kernel.org>; Sun, 10 Dec 2023 15:13:46 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id a640c23a62f3a-a1ef2f5ed01so468042766b.0
        for <bpf@vger.kernel.org>; Sun, 10 Dec 2023 15:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702250025; x=1702854825; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8J3XA70WnRgnHyK5GGcFTiz0loRe3F6YT6mW0akReyE=;
        b=kdbWVQA33PALwMxhNpOdt+cq0/J9DcOQQWPCeh0AMaU6uMkdRTb5HKvPhJl0oRS+et
         Z5hbx6wCmoC5s+sGspTQ+WpOoddXoWATTshwUmRi5ULAu3pWtLSAst3frpOciCVKP97+
         /Rp2H6Sii4IL7zcFQ+TP2egD/ScZeFYL45JdG6NOwiD/rNzl6fq9chxoAxkl9Lvrq9Sq
         4Z4V1mwk71JmudiXRP6muw19/I9NX4fogW3VSC4ItsLvvmeS4VZr5P14rVo6ZQpzirnB
         aGox+X/GdnWp6wCNA3/ivU++SPbtJgGY2Fo/Ihm5XKf54jvcr/Dxs/30k8/zloiNAEW/
         qGRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702250025; x=1702854825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8J3XA70WnRgnHyK5GGcFTiz0loRe3F6YT6mW0akReyE=;
        b=oLqH/gmjHnatnv2KmYjPl83LXJGVOtQQewwNK+GAt3q7VFQgmI5s1RsTy4pxhl+GT9
         i3f1gxAe1OeCs1Ck5jrtITv3vAftaqQoSzaijreXDBpj1gOSydN0dnXadZFASsJqhkYm
         YOw9gctcn4gCHu1gLxTRpiepnuQ+4fNkiJ9YDumStg6csxemAly2KCA83TVbBoPzhOgi
         059T9HaLYoiDM36uvABtcplksM8frD0DxBdsUWJ6WFLLbi73y5O5CUGM+JaDcV3v5sK/
         pKoRpo5qBwkCpFJ2k9za6hO6+3XWc6AOrY5FTF236sVy5K0jFTaHPZAF2KgW5qCs2XDj
         v/2Q==
X-Gm-Message-State: AOJu0YwlKcYoBWTUKmGu0tTr4yYgvOylrbZNg+RBLBbuow615WV2LP+/
	bmFlPvDcXoM62Q4GppLwiOsuDiUN4EzIXEKFVHP26OuIku0=
X-Google-Smtp-Source: AGHT+IHmvX16QhSaD44OTkZnGL7tdswm/HU3+IBvIjficRsSAGJ4v09ngo309nBftZidrwE+ZASR0PweXoq1DqJMToA=
X-Received: by 2002:a17:906:76d2:b0:a1b:7600:1e40 with SMTP id
 q18-20020a17090676d200b00a1b76001e40mr839318ejn.166.1702250025175; Sun, 10
 Dec 2023 15:13:45 -0800 (PST)
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
 <CAEf4Bzac94=uum2ORYWR2i_qYpmyde2xTLucDf_+EtFE9vCw9Q@mail.gmail.com>
 <CAP01T75f6AojB2pLr9RJtrJXfsE+FMJ5HZHyew0KPLCbm9y3ig@mail.gmail.com> <CABWLses1dhmpqKJd--xKKOU1SObfn4OC1Lg-OKTAdJpq0ZMRNQ@mail.gmail.com>
In-Reply-To: <CABWLses1dhmpqKJd--xKKOU1SObfn4OC1Lg-OKTAdJpq0ZMRNQ@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 11 Dec 2023 00:13:08 +0100
Message-ID: <CAP01T77M=SyNviMYCO-koxizvD6eGm=5KQ1Wv=ahbRU5XQB4bA@mail.gmail.com>
Subject: Re: [PATCH bpf V2 1/1] bpf: fix verification of indirect var-off
 stack access
To: Andrei Matei <andreimatei1@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org, sunhao.th@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 10 Dec 2023 at 23:46, Andrei Matei <andreimatei1@gmail.com> wrote:
>
> On Fri, Dec 8, 2023 at 9:46=E2=80=AFPM Kumar Kartikeya Dwivedi <memxor@gm=
ail.com> wrote:
> >
> > On Fri, 8 Dec 2023 at 23:15, Andrii Nakryiko <andrii.nakryiko@gmail.com=
> wrote:
> > >
> > > On Thu, Dec 7, 2023 at 7:23=E2=80=AFPM Andrei Matei <andreimatei1@gma=
il.com> wrote:
> > > >
> > > > [...]
> > > >
> > > > > >
> > > > > > Ack. Still, if you don't mind entertaining me further, two more=
 questions:
> > > > > >
> > > > > > 1. What do you make of the code in check_mem_size_reg() [1] whe=
re we do
> > > > > >
> > > > > > if (reg->umin_value =3D=3D 0) {
> > > > > >   err =3D check_helper_mem_access(env, regno - 1, 0,
> > > > > >         zero_size_allowed,
> > > > > >         meta);
> > > > > >
> > > > > > followed by
> > > > > >
> > > > > > err =3D check_helper_mem_access(env, regno - 1,
> > > > > >       reg->umax_value,
> > > > > >       zero_size_allowed, meta);
> > > > > >
> > > > > > [1] https://github.com/torvalds/linux/blob/bee0e7762ad2c6025b9f=
5245c040fcc36ef2bde8/kernel/bpf/verifier.c#L7486-L7489
> > > > > >
> > > > > > What's the point of the first check_helper_mem_access() call - =
the
> > > > > > zero-sized one
> > > > > > (given that we also have the second, broader, check)? Could it =
be
> > > > > > simply replaced by a
> > > > > >
> > > > > > if (reg->umin_value =3D=3D 0 && !zero_sized_allowed)
> > > > > >     err =3D no_bueno;
> > > > > >
> > > > >
> > > > > Maybe Kumar (cc'ed) can chime in as well, but I suspect that's ex=
actly
> > > > > this, and kind of similar to the min_off/max_off discussion we ha=
d. So
> > > > > yes, I suspect the above simple and straightforward check would b=
e
> > > > > much more meaningful and targeted.
> > > >
> > > > I plan on trying this in a bit; sounds like you're encouraging it.
> > > >
> > > > >
> > > > > I gotta say that the reg->smin_value < 0 check is confusing, thou=
gh,
> > > > > I'm not sure why we are mixing smin and umin/umax in this change.=
..
> > > >
> > > > When you say "in this change", you mean in the existing code, yeah?=
  I'm not
> > >
> > > Yeah, sorry, words are hard. It's clearly a question about pre-existi=
ng code.
> > >
> > > > familiar enough with the smin/umin tracking to tell if `reg->smin_v=
alue >=3D 0`
> > > > (the condition that the function tests first) implies that
> > > > `reg->smin_value =3D=3D reg->umin_value` (i.e. the fact that we're =
currently mixing
> > >
> > > this is probably true most of the time, but knowing how tricky this
> > > range tracking is, there is non-zero chance that this is not always
> > > true. Which is why I'm a bit confused why we are freely intermixing
> > > signed/unsigned range in this code.
> > >
> > > > smin/umin in check_mem_size_reg() is confusing, but benign).  Is th=
at true? If
> > > > so, are you saying that check_mem_size_reg() should exclusively use=
 smin/smax?
> > > >
> > >
> > > I'd like to hear from Kumar on what was the intent before suggesting
> > > changing anything.
> >
> > So this was not originally from me, I just happened to move it around
> > when adding support for this to kfuncs into a shared helper (if you
> > look at the git blame), it's hard for me to comment on the original
> > intent, I would know as much as anyone else.
> >
> > But to helpful, I digged around a bit and found the original patch
> > adding this snippet:
> >
> > 06c1c049721a ("bpf: allow helpers access to variable memory")
> >
> > It seems the main reason to add that < 0 check on min value was to
> > tell the user in the specific case where a spilled value is reloaded
> > from stack that they need to mask it again using bitwise operations,
> > because back then a spilled constant when reloaded would become
> > unknown, and when passed as a parameter to a helper the program would
> > be rejected with a weird error trying to access size greater than the
> > user specified in C.
> >
> > Now this change predates the signed/unsigned distinction, that came in:
> >
> > b03c9f9fdc37 ("bpf/verifier: track signed and unsigned min/max values")
> >
> > That changes reg->min_value to reg->smin_value, the < 0 comparison
> > only makes sense for that.
> > Since then that part of the code has stayed the same.
> >
> > So I think it would probably be better to just use smin/smax as you
> > discussed above upthread, also since the BPF_MAX_VAR_SIZE is INT_MAX,
> > so it shouldn't be a problem.
>
> Thank you for spelunking, Kumar!
> There were two discussions upthread:
> 1) whether the 0-size check_helper_mem_access() call in
> check_mem_size_reg() can be drastically simplified
> 2) whether the mixed use of smin with umin/umax makes sense.
>
> It seems that we've come up empty-handed on a good reasoning
> for 1). I have a patch that simplifies it AND also improves
> error messages as a result. I'm inclined to send it for your
> consideration, Andrii, if that's cool, as you also didn't
> seem to like the current code.
>

While that's true, I think it should probably go into
check_helper_mem_access instead of being duplicated for handlers of
each switch statement.
It seems one of them (for PTR_TO_MAP_KEY) hardcodes it regardless of
what's passed in, and there's a special case of register_is_null which
is permitted.

So it might be better to unify the handling in check_helper_mem_access
instead of its callers. Just my $0.02.

> About 2) -- the current mixing of smin/umin/umax actually
> makes sense to me.  I'd rationalize the (smin < 0) check as
> "does this value *look* like a negative value? If so,
> opportunistically give the user a nice error message". Even
> if the value did not actually come from a signed variable,
> but instead came for a very large unsigned, the program
> shouldn't verify anyway, so it's no big deal if the negative
> interpretation is erroneous. After that check, the value is
> exclusively treated as unsigned, since the size argument for
> which it is intended is unsigned.
> So, I think you can argue either way for the combinations of
> signed/unsigned checks that could be done, but I personally
> am not inclined to change the current code.
>

I think based on the thread it would be better to atleast comments
explaining all this, even if in the end we don't decide to touch it.

>
> [...]

