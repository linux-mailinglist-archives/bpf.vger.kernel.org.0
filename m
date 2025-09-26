Return-Path: <bpf+bounces-69847-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4E8BA45D4
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 17:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C32FD166E86
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 15:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3586E1F2BB5;
	Fri, 26 Sep 2025 15:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eoseU7mK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CE31F1517
	for <bpf@vger.kernel.org>; Fri, 26 Sep 2025 15:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758899498; cv=none; b=XbWMWA2ce2IJX1fwwdow0gzE3cPk6bAH/wD2hzTnbr2XBeegKRGvkvkweoBDAILkRcGG2HwVBgCL/kmFiQycOJNLJSx59WGUKJF5O3lSseR1URp+k3K6zKxovWeGSNHU/9FpyBvUUgJ1cXs0z6EdKveKcxRd/2UnK5GCYil9V3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758899498; c=relaxed/simple;
	bh=g9pIptTJimWNIf/L/brlFk5fsMJfisO7ECBgQLbZUxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZavheooBoP2nycbQnwmnVcTW1nbzIaYa9MKvMExiKfrYTpGJD4u48OSZqSoS2XKspAbb/syzhvyxNUCWiF6zkA9nmUCtIIE7oQakywOhN/7rADqrqETNFCUyodVViLCzwYbLwzHiaxSosOYENl5Xwa/8FETKp4gOIrwouaqItKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eoseU7mK; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-33274fcf5c1so2364065a91.1
        for <bpf@vger.kernel.org>; Fri, 26 Sep 2025 08:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758899496; x=1759504296; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g9pIptTJimWNIf/L/brlFk5fsMJfisO7ECBgQLbZUxo=;
        b=eoseU7mKR8vj5pTw4/Wtuk0Bwu9dZLJR/JFWwOFVAth0xqA7R5bduIjjUy3+bfYiLD
         nW1FM+gwIZvZlwPzB00SxL3uBeCiDD71qzASvfg9nGvBOvQLkPqSgmoq7mOtrgU2hAqn
         lvbMmRc0noIQJZp1/BobeLKG11LBgm0gdx2xkw+fveHS/vHI3OSxgbSU9l9um4WgRI6e
         vsFYCAUQCIIx1jTH8wpAcZLqRFvy8ofodyM323lzzYok2tznIq6S5EreDtBKT077ZJk+
         rYNxulPWH5+fOMZDAAB0lMIj/t57VAh8pDrteqE/94i4hlD/jlqMh5KdNN99b1MEqvAb
         kKRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758899496; x=1759504296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g9pIptTJimWNIf/L/brlFk5fsMJfisO7ECBgQLbZUxo=;
        b=wChAUY0ZX+b3i9zoxZeZHoZgnFIyaM6kOPSVW91SI62teNWTvToAGMp+9vEMJJlAm2
         vAhizQlcHubrNOa+1SBvyma6K2u3wTU4tRw6FMftfpa2h4/de9g2uRoGG3B6OSO9kpW/
         Dfh/lOWd8M1S76JJrKPNFUVQnRCslaf5CqCj1kPxj+ZbmWjeE/3hBdVOIMVILclKtnMx
         Ker5pxauxr8Y2vkI7bY9Qu5rc9wIr/n55GyFxyp7y7zyq1kTjx17ncsFQbh0D1uGjRa+
         109MKrQSxWfBo8y3glF4/c2qq7b/EA8a0N4M7iYHa+Uu4F3ZviEVUE9N6E4zEpBeqjhG
         0uZw==
X-Forwarded-Encrypted: i=1; AJvYcCUAd7Y4C/FAKEZCJuF5txc3yUgOGW+8CJmY0SWAo0G7oG1mgIxBuecXLHo25JgkTHB4LzA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzij9i4hwop1j4K6rAs5jfuWebtZp2KAQO/Xi0IROr8xbct0eKZ
	r3Qkat3GuyjM2GmjVm5Fr/JaURMe7JRZJPFye5P9FOGdstu1y21RH699dIOrhKNn8O1cZ+5Kdfe
	DAbP7mkF2aX+JZSdVDjkluLhGR3DUTm4=
X-Gm-Gg: ASbGncuHwqUr7Td5BPpBoZOrpHB+5MaMwJiSXzKwervBvtIwwCQBSN3njQjTjd3mSsf
	fZ57uwbW9aGfRbOMpB3uJhYmDPmiLmaWkHeYckw+LJ+Kj987X9Qu4CkaR75FDC9atVT1jB3l1LM
	F8hYTadKHkcDFlt4sMjrTR/JPC83U/2lLCUl6b4jbRLRSGPcyJMxGzsmmdNUFZlNusmcd8hOZTx
	id7omzXCqVyjao=
X-Google-Smtp-Source: AGHT+IFhJlYN40bI1MEGGa45XXHXXTHqcL+90nE/4Q0kdrKgnR2L0H7EcM4P1dJR7SAXJ5OZiKfRAiJ+xE3eBBKayEg=
X-Received: by 2002:a17:90b:1b12:b0:32e:3686:830e with SMTP id
 98e67ed59e1d1-334302782a8mr7663171a91.23.1758899496215; Fri, 26 Sep 2025
 08:11:36 -0700 (PDT)
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
 <CAP01T74_ZfQtHTsBmjNsGnuB4TeTTqqw2BOb8=3od6znS8XtQg@mail.gmail.com>
 <CAEf4BzY1g1svHDfQu8UmauTerWLMEk=OMWKO-f9HSe7tfB1arA@mail.gmail.com> <CAADnVQJX3guxpXuyP_spuNQMtWOxmh3DbDSyY+1_kz2z6_VDUQ@mail.gmail.com>
In-Reply-To: <CAADnVQJX3guxpXuyP_spuNQMtWOxmh3DbDSyY+1_kz2z6_VDUQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 26 Sep 2025 08:11:23 -0700
X-Gm-Features: AS18NWBVh-eDMGsV6DeA-MzCTtUSumqnZn07H3JmR1vfv4XHhrnBxxxj1HSVa_M
Message-ID: <CAEf4Bzb9jiFegQQHLpgBvVUS1HcEWuCJFfvG+2UNevT_0Ki5ng@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/6] bpf: implement KF_IMPLICIT_PROG_AUX_ARG flag
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Eduard <eddyz87@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	dwarves <dwarves@vger.kernel.org>, Alan Maguire <alan.maguire@oracle.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Tejun Heo <tj@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 5:10=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Sep 26, 2025 at 12:07=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, Sep 25, 2025 at 3:58=E2=80=AFPM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > >
> > > On Fri, 26 Sept 2025 at 00:54, Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Thu, Sep 25, 2025 at 12:35=E2=80=AFPM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > >
> > > > > On Thu, Sep 25, 2025 at 6:23=E2=80=AFPM Andrii Nakryiko
> > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > >
> > > > > > I do see the benefit of having the generic "KF_MAGIC_ARG(s)" fl=
ag on
> > > > > > the kernel side of things and having access to full BTF informa=
tion
> > > > > > for parameters to let verifier know what specific kind of magic
> > > > > > argument that kfunc has, though. So as an alternative, maybe we=
 can
> > > > > > create both a kfunc definition *meant for BPF programs* (i.e., =
without
> > > > > > magic argument(s)), and then have a full original definition (p=
roduced
> > > > > > by pahole, it will need to understand KF_MAGIC_ARGS anyways) wi=
th full
> > > > > > type information *for internal BPF verifier needs*. I don't kno=
w
> > > > > > what's the best way to do that, maybe just a special ".magic" s=
uffix,
> > > > > > just to let the verifier easily find that? On the kernel side, =
if
> > > > > > kfunc has BPF_MAGIC_ARGS kflag we just look up "my_fancy_kfunc.=
magic"
> > > > > > FUNC definition?
> > > > >
> > > > > Interesting idea. Maybe to simplify backward compat the pahole ca=
n
> > > > > emit two BTFs: kfunc_foo(args), kfunc_foo_impl(args, void *aux)
> > > > > into vmlinux BTF.
> > > > > bpftool will emit both in vmlinux.h and bpf side doesn't need to =
change.
> > > > > libbpf doesn't need to change either.
> > > > > The verifier would need a special check to resolve two kfunc BTFs
> > > > > name into one kallsym name, since both kfuncs is one actual funct=
ion
> > > > > on the kernel.
> > > > > bpf_wq_set_callback_impl() definition doesn't change. Only:
> > > > > -BTF_ID_FLAGS(func, bpf_wq_set_callback_impl)
> > > > > +BTF_ID_FLAGS(func, bpf_wq_set_callback_impl, KF_PROG_ARG)
> > > > >
> > > > > and the verifier can check that the last arg is aux__prog when
> > > > > KF_PROG_ARG is specified.
> > > > >
> > > > > The runtime performance will be slightly better too, since
> > > > > no need for wrappers like:
> > > > >
> > > > > +__bpf_kfunc int bpf_wq_set_callback_impl(struct bpf_wq *wq,
> > > > > + int (callback_fn)(void *map, int *key, void *value),
> > > > > + unsigned int flags,
> > > > > + void *aux__prog)
> > > > > +{
> > > > > + return bpf_wq_set_callback(wq, callback_fn, flags, aux__prog);
> > > > > +}
> > > > >
> > > > > It's just one jmpl insn, but still.
> > > >
> > > > So basically xxx_impl() will be a phantom function that verifier wi=
ll
> > > > recognize and it will need to have corresponding xxx() kfunc with
> > > > corresponding KF_PROG_ARG for everything to work. Makes sense.
> > > >
> > > > Two notes:
> > > >
> > > > a) KF flag would need to be more generically named, because we'll h=
ave
> > > > other implicit arguments (like those for bpf_obj_new_impl, for
> > > > example), which will be distinguished based on their BTF type
>
> agree
>
> > > >
> > > > b) bpf_stream_vprintk() throws a bit of a wrench into all this beca=
use
> > > > it doesn't follow _impl naming convention. Any suggestions on how t=
o
> > > > deal with that?
> > >
> > > We can probably do a compat break for this kfunc alone for now, it's
> > > not been a long time since it's been out (1 release) not much adoptio=
n
> > > yet.
> >
> > Ideally there would be 0 releases with that name :) it's just
> > tantalizing that we can s/bpf_stream_vprintk/bpf_stream_vprintk_impl/
> > in like 8 places and avoid this altogether, but it is so late in the
> > release that I suspect no one will want to do this last minute "fix".
>
> I think we can still do it even after 6.17 is released and
> backport it as a fix.

ok then, sounds like a plan

