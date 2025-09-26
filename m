Return-Path: <bpf+bounces-69839-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04354BA3941
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 14:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 996D4384351
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 12:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F81E2EB85A;
	Fri, 26 Sep 2025 12:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMKZdsiw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6662EA754
	for <bpf@vger.kernel.org>; Fri, 26 Sep 2025 12:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758888622; cv=none; b=nH3aI+bM+VBbLS23qNYF3WPxyAJxy/jant2y3yShgPxf08chNfifJ5YgQeV7ScvVEkS2HGBx8UNaDAks3E2BwVxR0kUn1O+wO/lNMkwaob7jzfvofv5GEUCio0IrZokgWR/sJVBSvy19L5XeHvpFQStFNnO+8KaDKb2msC7ytHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758888622; c=relaxed/simple;
	bh=98Qnu7flfxkf7wI/METMehtEGP+JyUBz2GmZ46j+rx0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OCw3to0PdS5cVKqITTXYKFBN6/4i/eSsTQ1sx+1H/Uj/orq5ziTS7v7Tsjh2ZpQzaKYFORT0zCuaM3pNe9evn6Y7zIyUB68YUE93bGVdobHl1mbW2Oy3iU7TbkfJQYa0BXE0EqR2/D9yvi+IB6B10ItOerD9nFDMiPoaKhtSOxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DMKZdsiw; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-46e3cdc1a6aso4621755e9.1
        for <bpf@vger.kernel.org>; Fri, 26 Sep 2025 05:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758888618; x=1759493418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=98Qnu7flfxkf7wI/METMehtEGP+JyUBz2GmZ46j+rx0=;
        b=DMKZdsiwug3nYxSqV0Vx/uR4PtJx6NxHMXfkNOcEUXnUK4P0Li0uS88dOIXyqF3T4/
         D+EY2LDNxuIHMtEsQKr9m0P3MVXwxPzRKhbM885ReD4vY0EWDtWkffRo6Tfi/LLnGltj
         T1N9YLWlnnDZtYUaA01+rJkvhHw05EAFiZoAla5vRgObf3ebb94bZ4uhd1kLCr6tOOA+
         zcD59qseHc/HwwzaF/qAyvzppz+2rcyHQEnQoqfbF87SXgPdsMY0gCZSj3QzPqXQ/AM9
         zqndYKycO3OvrVJAMoZkCJ45Eij2BYz9qYzwS3Xf/aUwmIT50FurYs/6mDHBtYQxAzZD
         G5uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758888618; x=1759493418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=98Qnu7flfxkf7wI/METMehtEGP+JyUBz2GmZ46j+rx0=;
        b=b3Ik3CuLkHgUD9AW5xxxlAcWm/KkOXPp6xM87mehh2K+XI6Ie0nNjhzwK44QPDT1jv
         ZA3QnuS5AG/oIlJB6QPVwH8yoIAjAWh/ZLtfJ4dXzWsThwLkDr7z7q6Oo8Ox7FNRkQ3j
         AKZfihMfMnEEgayJbFcThKlCf3EiiMViKONvK52oC/Jr5CT779Uny4F4OJAPfGutG2n2
         6OFGqV4Ti5phW8zBiiTOR9nTlysGogOpVbVcyw4ApdWgGqEpjQ/uDbVZ3Br2neRZbzIZ
         HsZQEyVHCWLDeoJR0Zr5GmG/bBzkBipzT6WrGKpesfHx6+KArKtzt1UVSgkmNbPnesH1
         JDKg==
X-Forwarded-Encrypted: i=1; AJvYcCVox8CqHJeWRpzZAzJiHww99QWH0iNuOgHGy0tTIShHAMNG+9XNG7TSsX8xZ/T66F8WGz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDkgsn/3Mg+fyj8L+hGSe58i4Qh5u9UEuq2pZ8tYt6SY2MIn7L
	zkCQtbsFJ3Y1ygNr45DqQ8BsRD1AD1/rgSq3OCxDVzhCUfGcRdZ8JeTZqk+shra2M5EmzsSwOKF
	Bjor4a5zzmxUzGmTdSWZRIYDlzB5CcB0=
X-Gm-Gg: ASbGnctKogjUT6Wtn2UMLEZNZic4/JBJz96yP2KfbmNqKQIEfCkyT9kKDxS82uECv+m
	8iDr22of6nFGHrYl4/eyY1kauDCstYFXr5tBep6QHOORx+lsioO5QinckGlGurUL+Fk5OgRgfqd
	TsiPsCTuZbLxFGp7Ovzccw6gi8xVu5YE3FyBCrbIIGS0VkAEd0kipXaOVycv/HTYdZEF9EEBZ5z
	YAkV10MbrbKivy4I6X6
X-Google-Smtp-Source: AGHT+IH9loFwUgH3YJGS+0RMq0eswdUZUaJXCi+wpIdfNHiJAuvdmXHUnrSkjTiparpZLGmnpYEMlVTEa/AVQtMm2GI=
X-Received: by 2002:a05:600c:4d01:b0:459:d577:bd24 with SMTP id
 5b1f17b1804b1-46e33c36bacmr37230875e9.7.1758888618365; Fri, 26 Sep 2025
 05:10:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924211716.1287715-1-ihor.solodrai@linux.dev>
 <20250924211716.1287715-2-ihor.solodrai@linux.dev> <CAADnVQLvuubey0A0Fk=bzN-=JG2UUQHRqBijZpuvqMQ+xy4W4g@mail.gmail.com>
 <6a6403ec-166a-4d48-8bf5-f43ae1759e5f@linux.dev> <CAEf4BzbYXADoUge5C7zhzZAEDESE7YJFwW_jO4-F5L3j-bwPMw@mail.gmail.com>
 <CAADnVQL+28vPquMgw+hZMT1P6NkE5jLUXf=HDNj65N9np1rgfw@mail.gmail.com>
 <CAEf4BzYm=dTqT=Aj-=Jg=n8AtcxZL1CiQiY5mVbUNA-pesz=sQ@mail.gmail.com>
 <CAP01T74_ZfQtHTsBmjNsGnuB4TeTTqqw2BOb8=3od6znS8XtQg@mail.gmail.com> <CAEf4BzY1g1svHDfQu8UmauTerWLMEk=OMWKO-f9HSe7tfB1arA@mail.gmail.com>
In-Reply-To: <CAEf4BzY1g1svHDfQu8UmauTerWLMEk=OMWKO-f9HSe7tfB1arA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 26 Sep 2025 13:10:06 +0100
X-Gm-Features: AS18NWA3vm22xwhbQzcJRYtbJa4eUp3__481yLn5_uTUvxfxIjYG-CHsmDTDgR0
Message-ID: <CAADnVQJX3guxpXuyP_spuNQMtWOxmh3DbDSyY+1_kz2z6_VDUQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/6] bpf: implement KF_IMPLICIT_PROG_AUX_ARG flag
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Eduard <eddyz87@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	dwarves <dwarves@vger.kernel.org>, Alan Maguire <alan.maguire@oracle.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Tejun Heo <tj@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 12:07=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Sep 25, 2025 at 3:58=E2=80=AFPM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > On Fri, 26 Sept 2025 at 00:54, Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Thu, Sep 25, 2025 at 12:35=E2=80=AFPM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Thu, Sep 25, 2025 at 6:23=E2=80=AFPM Andrii Nakryiko
> > > > <andrii.nakryiko@gmail.com> wrote:
> > > > >
> > > > > I do see the benefit of having the generic "KF_MAGIC_ARG(s)" flag=
 on
> > > > > the kernel side of things and having access to full BTF informati=
on
> > > > > for parameters to let verifier know what specific kind of magic
> > > > > argument that kfunc has, though. So as an alternative, maybe we c=
an
> > > > > create both a kfunc definition *meant for BPF programs* (i.e., wi=
thout
> > > > > magic argument(s)), and then have a full original definition (pro=
duced
> > > > > by pahole, it will need to understand KF_MAGIC_ARGS anyways) with=
 full
> > > > > type information *for internal BPF verifier needs*. I don't know
> > > > > what's the best way to do that, maybe just a special ".magic" suf=
fix,
> > > > > just to let the verifier easily find that? On the kernel side, if
> > > > > kfunc has BPF_MAGIC_ARGS kflag we just look up "my_fancy_kfunc.ma=
gic"
> > > > > FUNC definition?
> > > >
> > > > Interesting idea. Maybe to simplify backward compat the pahole can
> > > > emit two BTFs: kfunc_foo(args), kfunc_foo_impl(args, void *aux)
> > > > into vmlinux BTF.
> > > > bpftool will emit both in vmlinux.h and bpf side doesn't need to ch=
ange.
> > > > libbpf doesn't need to change either.
> > > > The verifier would need a special check to resolve two kfunc BTFs
> > > > name into one kallsym name, since both kfuncs is one actual functio=
n
> > > > on the kernel.
> > > > bpf_wq_set_callback_impl() definition doesn't change. Only:
> > > > -BTF_ID_FLAGS(func, bpf_wq_set_callback_impl)
> > > > +BTF_ID_FLAGS(func, bpf_wq_set_callback_impl, KF_PROG_ARG)
> > > >
> > > > and the verifier can check that the last arg is aux__prog when
> > > > KF_PROG_ARG is specified.
> > > >
> > > > The runtime performance will be slightly better too, since
> > > > no need for wrappers like:
> > > >
> > > > +__bpf_kfunc int bpf_wq_set_callback_impl(struct bpf_wq *wq,
> > > > + int (callback_fn)(void *map, int *key, void *value),
> > > > + unsigned int flags,
> > > > + void *aux__prog)
> > > > +{
> > > > + return bpf_wq_set_callback(wq, callback_fn, flags, aux__prog);
> > > > +}
> > > >
> > > > It's just one jmpl insn, but still.
> > >
> > > So basically xxx_impl() will be a phantom function that verifier will
> > > recognize and it will need to have corresponding xxx() kfunc with
> > > corresponding KF_PROG_ARG for everything to work. Makes sense.
> > >
> > > Two notes:
> > >
> > > a) KF flag would need to be more generically named, because we'll hav=
e
> > > other implicit arguments (like those for bpf_obj_new_impl, for
> > > example), which will be distinguished based on their BTF type

agree

> > >
> > > b) bpf_stream_vprintk() throws a bit of a wrench into all this becaus=
e
> > > it doesn't follow _impl naming convention. Any suggestions on how to
> > > deal with that?
> >
> > We can probably do a compat break for this kfunc alone for now, it's
> > not been a long time since it's been out (1 release) not much adoption
> > yet.
>
> Ideally there would be 0 releases with that name :) it's just
> tantalizing that we can s/bpf_stream_vprintk/bpf_stream_vprintk_impl/
> in like 8 places and avoid this altogether, but it is so late in the
> release that I suspect no one will want to do this last minute "fix".

I think we can still do it even after 6.17 is released and
backport it as a fix.

