Return-Path: <bpf+bounces-17347-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E0380BDB5
	for <lists+bpf@lfdr.de>; Sun, 10 Dec 2023 23:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 881D71F20EF0
	for <lists+bpf@lfdr.de>; Sun, 10 Dec 2023 22:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A6F1D545;
	Sun, 10 Dec 2023 22:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eHojU8YM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6FBDF
	for <bpf@vger.kernel.org>; Sun, 10 Dec 2023 14:46:53 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-a1d450d5c11so506445966b.3
        for <bpf@vger.kernel.org>; Sun, 10 Dec 2023 14:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702248411; x=1702853211; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sLx860UGT3aZhpv2xK8ndpeGRlEn2l7XqKi5P39IWaE=;
        b=eHojU8YMHqCxnKiuRum8O7j56Z6lewdEXnXiYonijPdICpZkC3yeH5ZFTySmQih3o3
         iWHN28rk9+yosLVfXgsihMeYuB0awY2HANJXYGIN39oxv7zrI1vK/QNiRAuXkWahOY5O
         EGXHkOua0Yv1Es5A2ee6RAZDlQQLHVKvTrPZFx2o+ggHjJqHUgOgOca5BjYk2qxxfXdZ
         PwprF+fhW4BO7WttGHlpGRkG2iqVQHZX82EYWuaZRjZ8Q2TkoIsYPVAqRaX4VlfrPKTq
         bozdHGMymFn2m7Dn7aYkArhXl47VGQHakl7e9AfDHoAzPidvhbu8EvOvhpI++yA/VOtI
         eN7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702248411; x=1702853211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sLx860UGT3aZhpv2xK8ndpeGRlEn2l7XqKi5P39IWaE=;
        b=o5I8kw34CXu6Q4bBtzwZjRsAVg7oCHVsANZpYlLF2B7ybX5ySo7vitGFsKkdOUe8G5
         +GeuJ6btb05hDI2rG+KD4LTVE/5lYdJEGX482msO1cUWNLCFjWYi2uR0s/CxqNM+0vUj
         8R8HY7Cehcdk0zarjHfuloxoK03Rf29wixYDveuBC5GWvyWR0v5ueLLrQUU3Txw1+XkH
         BekM4y32zuh5dGbc2nWPYgHTd7cnbW3py5GhpgzkYy5HZpGCvqB6RJCAXmtEgceh2hZ4
         jmlyMV2r4MOhqf69JgBh7kQ9lu56sZYO+SA7PwPyBvx9rCBwUJxq2ZeOgFiw5LxKKyEA
         r97g==
X-Gm-Message-State: AOJu0YzWnxe2gVJtSeWNvhouHLYfivhQIFihStpr1mKO1PezSq7lwgpE
	B0x+W2SZ6124Bs3RAIeLxcU3V59zc9rbMAzyeFA=
X-Google-Smtp-Source: AGHT+IEfwlOhEnnKTd/qkymx3K8GcBeEiLXC+xpkJiNIFJ2yZQAsJXQ5CIJD4G0KlnNPwqm49XNxAMM847hr9FMFsOU=
X-Received: by 2002:a17:907:7ea0:b0:a19:a19b:55e4 with SMTP id
 qb32-20020a1709077ea000b00a19a19b55e4mr2383728ejc.116.1702248410889; Sun, 10
 Dec 2023 14:46:50 -0800 (PST)
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
From: Andrei Matei <andreimatei1@gmail.com>
Date: Sun, 10 Dec 2023 17:46:39 -0500
Message-ID: <CABWLses1dhmpqKJd--xKKOU1SObfn4OC1Lg-OKTAdJpq0ZMRNQ@mail.gmail.com>
Subject: Re: [PATCH bpf V2 1/1] bpf: fix verification of indirect var-off
 stack access
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org, sunhao.th@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 8, 2023 at 9:46=E2=80=AFPM Kumar Kartikeya Dwivedi <memxor@gmai=
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

Thank you for spelunking, Kumar!
There were two discussions upthread:
1) whether the 0-size check_helper_mem_access() call in
check_mem_size_reg() can be drastically simplified
2) whether the mixed use of smin with umin/umax makes sense.

It seems that we've come up empty-handed on a good reasoning
for 1). I have a patch that simplifies it AND also improves
error messages as a result. I'm inclined to send it for your
consideration, Andrii, if that's cool, as you also didn't
seem to like the current code.

About 2) -- the current mixing of smin/umin/umax actually
makes sense to me.  I'd rationalize the (smin < 0) check as
"does this value *look* like a negative value? If so,
opportunistically give the user a nice error message". Even
if the value did not actually come from a signed variable,
but instead came for a very large unsigned, the program
shouldn't verify anyway, so it's no big deal if the negative
interpretation is erroneous. After that check, the value is
exclusively treated as unsigned, since the size argument for
which it is intended is unsigned.
So, I think you can argue either way for the combinations of
signed/unsigned checks that could be done, but I personally
am not inclined to change the current code.


>
> >
> > >
> > > [...]

