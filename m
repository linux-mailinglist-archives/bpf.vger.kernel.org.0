Return-Path: <bpf+bounces-46301-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FBE9E77D7
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 19:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78DEE165B40
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 18:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA961FFC69;
	Fri,  6 Dec 2024 18:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NceLmaeI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34361FFC64
	for <bpf@vger.kernel.org>; Fri,  6 Dec 2024 18:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733508688; cv=none; b=dcf6h5+9d/GvNSzGurNcaNw0F0bk//kdaigV1z1c8fbDZiS362cPZiouSowB6j9twvZeHYCnr0R5mVBDCqo1imx1+fH4BSO9m+oAaQjdFA/zbkN7prrGYghnb0Di+y0qGV1ZlIr7WecCPoTjs+kYn3Y0FB0AC88bliSYrkiFbnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733508688; c=relaxed/simple;
	bh=GoobNhRFFwkcGiu5eExolVm9p9/61axjJwtomONeo80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Deay6iGLMbFQQxv/6Umh+I3xJUscB0yOlafkTWv5pjr2XECNTfKsAX91spyLnE3xvJuNGK2rFR/d0owzF5/sdqKc6L8l6ALjOgtjAb++8qyBXxQ7nb/myM19mFgiwSqMqk3ou3wo8t1udoYVEuMWR2JWFfKffSDHj6lj1bpj2q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NceLmaeI; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-5d3d74363cbso481224a12.2
        for <bpf@vger.kernel.org>; Fri, 06 Dec 2024 10:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733508685; x=1734113485; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ySY5LZfp9JTLMgXsUgLGVqBVmJJHRdBvhQmVdEl2y3k=;
        b=NceLmaeIYthShlUcXmY6YU9RJY/Mhk5qwIaSw1JyxUcEjT9+u4ea3kQUXMfD5B104w
         BB10ac/TpC3S9+nnxh0hlj1tdvSOAtb3O+nzJsQepGb8dr3pJnV26u1rL03GpTAPd4oO
         x2HiiB6bQkr9QSiapRFzpW2G1+75EM4zMF9qdyAQv4uM95bLuBuLLJOXdIZnRF/Lkm7e
         yHjDv+mLeZSnU6f6Un6mGSRfCIdsWYMo6O/uYo/8J8wIoVMoAGFPyQuAReOo+ht2whXi
         yD2fuVLxvWjDXHu9XB+HR+ZgJmw7NKnn9GMFgPuON/3Z9sHU6ttFgGT+m8WSUmM7mRMM
         atrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733508685; x=1734113485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ySY5LZfp9JTLMgXsUgLGVqBVmJJHRdBvhQmVdEl2y3k=;
        b=XhzS9NAx++7FLpGunJnm0CsiZO5qcTiDA3Q4Ty7u0mEjZtt4T0lZguLTTY229KGqjT
         Xjcc3RztaCnh3TjTogtlKeD5GWtVNG/nQjux/W08UjBR6QGDJwGTYT1UMS8IPWDbQ+aW
         1Obr49nWkdSIRh9gsF0XBxHCKszn0gC5MRFOAOHFF/Ymr0zkXzzD0a6EHBdhgSHmap9E
         bRyuyeIychYprzEKgeR/gi9NE8Zwbh6x0FyYrEVSJ43jFd/vwRHC8YrfunKIVL4BxtZI
         FQgMdcdIUF42d/8GgDGZyURH9MgsMOkJc21/1JFHFFdAlOjpKkiNqkatIpLPy+6bE0by
         ii5A==
X-Forwarded-Encrypted: i=1; AJvYcCV28dRPunITiC/Aq/854Oe9mn+LRHAkA08LuM/bnMu2Daxvv/fcrz2+CVhKm9bJB4RlItE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5R/rTop8wThQtlziMcGPBtHslMsZLMriH5EVTP8zx28aZjuO0
	780CEgH76/u2vJGyCNl4p4DofZoSJB06UsPwfbJPuxJ83Y8fp5GpJIK+fvIYmlZdqC7T5N+qwKp
	NaPhtwAW2w7wj/guKlrHUv2+MQ2cjct/if4s=
X-Gm-Gg: ASbGncs4lc+m7ZSNlf30FIafh8JYZMIbq0fmsI3930BGvJmcPz6DZrPGqv4RdaOqTFY
	hyEGl7xCS0IZ0rRaVbADtkOAhf4UpOCB5cKCAyjYHCi4asQVauFEyVVLTN+fxRrIx
X-Google-Smtp-Source: AGHT+IFzB/S1g5PALcSm/2lfkoxL1BqemGJh78Qfy9WluUkeFR/7p7TtXs7GB6KMGWBrVZe47kUA2ouWWdPGHcimwnA=
X-Received: by 2002:a05:6402:458a:b0:5d0:b455:36ad with SMTP id
 4fb4d7f45d1cf-5d3be763181mr4347853a12.27.1733508684903; Fri, 06 Dec 2024
 10:11:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206161053.809580-1-memxor@gmail.com> <20241206161053.809580-3-memxor@gmail.com>
 <CAADnVQ+_XGVsxYji3WYNj1-KhYZwKaFCgQ6aN=yFB3YWpRT78A@mail.gmail.com>
In-Reply-To: <CAADnVQ+_XGVsxYji3WYNj1-KhYZwKaFCgQ6aN=yFB3YWpRT78A@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 6 Dec 2024 19:10:48 +0100
Message-ID: <CAP01T75PQ3RENtQMD+JkB9DZcsUYp+AH6VJURGO730DkuLUMmA@mail.gmail.com>
Subject: Re: [PATCH bpf v3 2/3] bpf: Do not mark NULL-checked raw_tp arg as scalar
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, kkd@meta.com, 
	Manu Bretelle <chantra@meta.com>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 6 Dec 2024 at 18:59, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Dec 6, 2024 at 8:11=E2=80=AFAM Kumar Kartikeya Dwivedi <memxor@gm=
ail.com> wrote:
> >
> > An implication of this fix, which follows from the way the raw_tp fixes
> > were implemented, is that all PTR_MAYBE_NULL trusted PTR_TO_BTF_ID are
> > engulfed by these checks, and PROBE_MEM will apply to all of them, incl=
.
> > those coming from helpers with KF_ACQUIRE returning maybe null trusted
> > pointers. This NULL tagging after this commit will be sticky. Compared
> > to a solution which only specially tagged raw_tp args with a different
> > special maybe null tag (like PTR_SOFT_NULL), it's a consequence of
> > overloading PTR_MAYBE_NULL with this meaning.
> >
> > Fixes: cb4158ce8ec8 ("bpf: Mark raw_tp arguments with PTR_MAYBE_NULL")
> > Reported-by: Manu Bretelle <chantra@meta.com>
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  kernel/bpf/verifier.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 82f40d63ad7b..556fb609d4a4 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -15365,6 +15365,12 @@ static void mark_ptr_or_null_reg(struct bpf_ve=
rifier_env *env,
> >                         return;
> >
> >                 if (is_null) {
> > +                       /* We never mark a raw_tp trusted pointer as sc=
alar, to
> > +                        * preserve backwards compatibility, instead ju=
st leave
> > +                        * it as is.
> > +                        */
> > +                       if (mask_raw_tp_reg_cond(env, reg))
> > +                               return;
>
> The blast radius is getting too big.
> Patch 1 is ok, but here we're doubling down on
> the hack in commit
> cb4158ce8ec8 ("bpf: Mark raw_tp arguments with PTR_MAYBE_NULL")

There are two concerns:
First, it applies whether or not a register is a raw_tp arg. There is
a way to detect that (with some register state, instead of using a
separate tag).
Second, we treat the program in the =3D=3D NULL branch as if the pointer
_maybe_ null, and in the !=3D NULL as definitively not NULL.
I don't really see how that's too different, given we already allow direct
access etc. when the pointer is _unchecked_ after entry, and the state
is same as
the case where =3D=3D NULL branch is explored.

>
> I think we need to revert the raw_tp masking hack and
> go with denylist the way Jiri proposed:
> https://lore.kernel.org/bpf/ZrIj9jkXqpKXRuS7@krava/
>
> denylist is certainly less safer and it's a whack-a-mole
> comparing to allowlist, but it's much much shorter
> according to Jiri's analysis:
> https://lore.kernel.org/bpf/Zr3q8ihbe8cUdpfp@krava/

Ok, let's revert.
Jiri, do you have the diff around for that attempt? Could you post a
revert of the patches and then the diff you shared?
If not, I can carry it as well with the revert, if you share it with
me (keeping the attribution etc.). Either is fine, lmk.

Thanks


>
> Eduard had an idea how to auto generate such allow/denylist
> during the build.
> That could be a follow up.

