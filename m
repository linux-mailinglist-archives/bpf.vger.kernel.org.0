Return-Path: <bpf+bounces-60341-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6845CAD5B78
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 18:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28DB818958C4
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 16:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305151E2607;
	Wed, 11 Jun 2025 16:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6qwPAEy"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEFF1DF73C
	for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 16:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749657948; cv=none; b=Iux49WA+oPa+EsS1C1XIqXjmO75A3LrsfVp8HvEnZfK80TnI8QHe3Tn1j0Jc5Xx4KEcLHSiQMxkxnk+syJ3oaAbjOwsNMW1UBAFHmFQT+RrAFo4BrxQq4sjbJz8qEy8natkOrnzVzYsRs0LJRyB2J4cqao8GRZUJkFTWH/tUJSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749657948; c=relaxed/simple;
	bh=Ey4t6TvnsBeIlDe5advtSy6jMvq6AuP+qG1plUpAXjc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NlQIvM5g1BYB6bIXPKt1cjJ9HPVdkJKjHAeUf1lC5EXaTH7H7/pxoXuSlnkKPReJ1ZzTcCpr/zKRACTVgESP0zaD9o2xd23/W2SWDqzfG8G9h0C2X5N6gNFtnRbzqcP/wnEMHUaphJUrocVPjaPdawMc6IKiV5wpo3LqsVaqpsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6qwPAEy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51978C4CEEA
	for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 16:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749657948;
	bh=Ey4t6TvnsBeIlDe5advtSy6jMvq6AuP+qG1plUpAXjc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=T6qwPAEyMG+l9mvBw5vBWH47Ex+clI75SiARLap+ouypSPo/9GOBoJF2HDEdkmE7s
	 o4lr0Wfuqbg5XC6necWIS0NiujDBN+CbRQLyJFemgHJPMH+O7hAw5elOeqz/W4AItQ
	 fM2SHY7YnbbWapxsdtswSFo2BduNujIJmV0QxSJBhzeaT42aWkVZWY5uIrtxGX+o3h
	 PyMdapGHItKYLUjUP55otXWVITO0H4Ui2R3cr9IIqQZH6OcE/qhf10ukTcY7HYJ6+O
	 K5VcAOvIhx79cjpa45M8iJR0u9xh89WztZc+mAdmj3phVm337Y6b/m4ZyvxTWTU1VZ
	 RlFnwXGDw4yHQ==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-606c5c9438fso126778a12.2
        for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 09:05:48 -0700 (PDT)
X-Gm-Message-State: AOJu0YyGDgHWd5pg0iz2TwBQpCKN1uNhdjGD5Oa0D3wpV9ODeNVtS/5t
	KZoYRUGFlUGskJ6/rWCDGWYuK/2ud+uvE5BNyGnb7ziWNyZaVtA9BCoUpn6nsoxUIfeY2E1khDr
	wcFM/PvJG29SRwSHRDFBuru3pyzVfZCcpQAtgIlQF
X-Google-Smtp-Source: AGHT+IEQ/wC4UhOsTzaMby4ck/QlmCgIY9hcONwmdeT691icR7q3A6gztyHt0h9AUoiNOTo3zyqUAyEPqenihvrgA1c=
X-Received: by 2002:a05:6402:268e:b0:602:a0:1f3a with SMTP id
 4fb4d7f45d1cf-60846aeb534mr3256002a12.13.1749657946702; Wed, 11 Jun 2025
 09:05:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606232914.317094-1-kpsingh@kernel.org> <20250606232914.317094-8-kpsingh@kernel.org>
 <CAADnVQL7Roi1gmAWZFSx-T4YVLtHu2cDneKCkLdBvB2+y_S1Uw@mail.gmail.com>
 <CACYkzJ4_NL=U525D56mVcyfxX64BDrkP3FiFotNPQ8+EDKNRQQ@mail.gmail.com> <CAADnVQLmrbOFbJZAdx3auye8YVwVJvMM4qp0L_-mFyD4xDedUA@mail.gmail.com>
In-Reply-To: <CAADnVQLmrbOFbJZAdx3auye8YVwVJvMM4qp0L_-mFyD4xDedUA@mail.gmail.com>
From: KP Singh <kpsingh@kernel.org>
Date: Wed, 11 Jun 2025 18:05:36 +0200
X-Gmail-Original-Message-ID: <CACYkzJ6b0uiLMos3SOTz196GpFUjTH-qAk7sr_7DYafh+=1Rfg@mail.gmail.com>
X-Gm-Features: AX0GCFvfoowa5QykVLNVEJgC8uTGu3RzBdJvX1Kqy6urMMXGWRnA_1GJEgRP0Ag
Message-ID: <CACYkzJ6b0uiLMos3SOTz196GpFUjTH-qAk7sr_7DYafh+=1Rfg@mail.gmail.com>
Subject: Re: [PATCH 07/12] bpf: Return hashes of maps in BPF_OBJ_GET_INFO_BY_FD
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>, 
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>, Paul Moore <paul@paul-moore.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 5:04=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Jun 11, 2025 at 7:27=E2=80=AFAM KP Singh <kpsingh@kernel.org> wro=
te:
> >
> > On Mon, Jun 9, 2025 at 11:30=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Fri, Jun 6, 2025 at 4:29=E2=80=AFPM KP Singh <kpsingh@kernel.org> =
wrote:
> >
> > [...]
> >
> > > >
> > > > +       if (map->ops->map_get_hash && map->frozen && map->excl_prog=
_sha) {
> > > > +               err =3D map->ops->map_get_hash(map, SHA256_DIGEST_S=
IZE, &map->sha);
> > >
> > > & in &map->sha looks suspicious. Should be just map->sha ?
> >
> > yep, fixed.
> >
> > >
> > > > +               if (err !=3D 0)
> > > > +                       return err;
> > > > +       }
> > > > +
> > > > +       if (info.hash) {
> > > > +               char __user *uhash =3D u64_to_user_ptr(info.hash);
> > > > +
> > > > +               if (!map->ops->map_get_hash)
> > > > +                       return -EINVAL;
> > > > +
> > > > +               if (info.hash_size < SHA256_DIGEST_SIZE)
> > >
> > > Similar to prog let's =3D=3D here?
> >
> > Thanks, yeah agreed.
> >
> > >
> > > > +                       return -EINVAL;
> > > > +
> > > > +               info.hash_size  =3D SHA256_DIGEST_SIZE;
> > > > +
> > > > +               if (map->excl_prog_sha && map->frozen) {
> > > > +                       if (copy_to_user(uhash, map->sha, SHA256_DI=
GEST_SIZE) !=3D
> > > > +                           0)
> > > > +                               return -EFAULT;
> > >
> > > I would drop above and keep below part only.
> > >
> > > > +               } else {
> > > > +                       u8 sha[SHA256_DIGEST_SIZE];
> > > > +
> > > > +                       err =3D map->ops->map_get_hash(map, SHA256_=
DIGEST_SIZE,
> > > > +                                                    sha);
> > >
> > > Here the kernel can write into map->sha and then copy it to uhash.
> > > I think the concern was to disallow 2nd map_get_hash on exclusive
> > > and frozen map, right?
> > > But I think that won't be an issue for signed lskel loader.
> > > Since the map is frozen the user space cannot modify it.
> > > Since the map is exclusive another bpf prog cannot modify it.
> > > If user space calls map_get_hash 2nd time the sha will be
> > > exactly the same until loader prog writes into the map.
> > > So I see no harm generalizing this bit of code.
> > > I don't have a particular use case in mind,
> > > but it seems fine to allow user space to recompute sha
> > > of exclusive and frozen map.
> > > The loader will check the sha of its map as the very first operation,
> > > so if user space did two map_get_hash() it just wasted cpu cycles.
> > > If user space is calling map_get_hash() while loader prog
> > > reads and writes into it the map->sha will change, but
> > > it doesn't matter to the loader program anymore.
> > >
> > > Also I wouldn't special case the !info.hash case for exclusive maps.
> > > It seems cleaner to waste few bytes on stack in
> > > skel_obj_get_info_by_fd() later in patch 9.
> > > Let it point to valid u8 sha[] on stack.
> > > The skel won't use it, but this way we can kernel behavior
> > > consistent.
> > > if info.hash !=3D NULL -> compute sha, update map->sha, copy to user =
space.
> >
> > Here's what I updated it to:
> >
> >     if (info.hash) {
> >         char __user *uhash =3D u64_to_user_ptr(info.hash);
> >
> >         if (!map->ops->map_get_hash)
> >             return -EINVAL;
> >
> >         if (info.hash_size !=3D SHA256_DIGEST_SIZE)
> >             return -EINVAL;
> >
> >         if (!map->excl_prog_sha || !map->frozen)
> >             return -EINVAL;
> >
> >          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >          I think we still need this check as we want the program to
> > have exclusive control over the map when the hash is being calculated
> > right?
>
> Why add such a restriction?
> Whether it's frozen or exclusive or both it still races with map_get_hash=
.
> It's up to the user to make sure that the computed hash
> will be meaningful.

Sure, yeah. I removed the check, they can use the hash in many ways,
even if racy.

- KP

> I would allow for all maps.

