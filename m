Return-Path: <bpf+bounces-43118-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5F29AF5CF
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 01:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76D8D28305D
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 23:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D7E2178F6;
	Thu, 24 Oct 2024 23:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cgIRvhgD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B20A1B392C
	for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 23:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729812380; cv=none; b=dhRhZBIGhB7cJcy3uV6PwJANu1A/6dW+6Ld744RUBmAWccMOK75yWPoDpAa0ED9vcnAAVGLn7cJekfEDBEmxQFRWqjsnfjhGniVy4b7rZ5Cs30oBz9Pjt8Fn7AEmQ4zXPgXtzNsBS9MFFNR/oMdtoL05Hxx1CVaW2iJSzM8K7GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729812380; c=relaxed/simple;
	bh=NRbwwmmaSUZOqUR1dfQlmiq0wO6hRf3/rIm2e5f4tCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bu1SPBKDluwx/eiOckHYcx2KNnvYxKVBrlH9KArBErGrqKyGIFVmGTWBTn2zfrs356YpA1Fy7qbEM69wrqlspp0gEHps+LfMLwNr46qQJ17DB4sI/LKQaOuxGM0/8+OeX8fgdD3wOf8ouhwpfoQ2gzCmXsdypXQmwSDYLFiwwF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cgIRvhgD; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-71e5a1c9071so1072475b3a.0
        for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 16:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729812377; x=1730417177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y8bhWTW+rQTaf4GE7SJfD0YuKYPF6OTpKFc2C29JbkE=;
        b=cgIRvhgDJDc9pgeUD4hn0yjSs0UTAkmteUvyNUZkADvFqVZLSp7TiFloTUYZ16LX6q
         pNGnfD+0REeu+kYr9cGNlb0u5tPSxL6S7syDonaUIfoUKtD6hDzL1i+7DhGG7s1zCvrb
         xmI74IZW2IkgmvedKo6gjJryW4SHulh6lkRu9lLhZ9z6xsIlW+RNJJ3+l45sBWR52LWm
         ytzWNZ4KBr7qcyzIO9fypvkj3URyAoCSSB2zQRh8cOTQi0mShcyCOnI/n8Rnzgl9DfI5
         t5zBLHIKaG5NN3XI7PzUYO/6xBLgtDEwgzKXj5OtxpXtvKbGidRPoGQ5XHDu65OCTZ+r
         wVFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729812377; x=1730417177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y8bhWTW+rQTaf4GE7SJfD0YuKYPF6OTpKFc2C29JbkE=;
        b=E3rbqWawVNY3A3eDvmCRV80Yb/ZZ0MIB/lDvpIsoOF5A/SIm89XGZWS4BCnuhpLGRt
         EAfJMDS3EhX/QCpMJW3VrVjzBViyEu1yS7n/yeN8rvbJalsbX6kGm2htPzpDh6SYl8St
         kT9VCv+nTG/awU6s/Kieiy8SMxhx0OtumY/6+dbrwmFfHU3pjb8q0nF5ggZbsQ5oRmWc
         vKaXBIy7L4lsbs++naUYzQHn4ndfejUqbadz06JuvbdZ6IaTKg0lOOWsaIRnUIlC1krN
         yWfmLrMFb5Qjv+2jBwEz4atgl9HkWR6ROJBmigKJWgSzxrFLF0wz4dHXdjN26Xo/ziRZ
         SuEA==
X-Gm-Message-State: AOJu0YxrZoWpZDwSfuDu6xA/GNaj2pnuiRYe5gMBdNGOQuLgexgxTYFZ
	3biriMyovrVm9wZ+O7UY/p6cg1nvfaSSLKDfbPA7mDeS7ZwVgKH8cVx6eLogr0f6EY+Q9X56zG8
	UEK9wwkvEZmq8FDm9lf4XMAxvJTXO8g==
X-Google-Smtp-Source: AGHT+IGoFYYYDgUtuDbzuYzba/ZH8nAWWXKaZ58nKyoUH/DE3GHz3fDOS9Bp/FmjHMk9RXpPddTWcFgQB0+poVPdtpI=
X-Received: by 2002:aa7:88ce:0:b0:71e:44f6:6900 with SMTP id
 d2e1a72fcca58-72030a8a42bmr10771208b3a.16.1729812377276; Thu, 24 Oct 2024
 16:26:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEf4BzYYZa3m5ttEgfPnZUBdYpgoq3JS0GCedXgeoWLgvr9YPQ@mail.gmail.com>
 <b58c8ae4-3a5c-44b3-bc85-2dd7dcea397b@oracle.com> <CAEf4Bzbv4SrQd=Yt7Z2PNQLT+1VkLKMaERFwfE8d=8s7QQ-_bQ@mail.gmail.com>
 <16877742-7f15-4fd9-95b4-228538decda0@oracle.com>
In-Reply-To: <16877742-7f15-4fd9-95b4-228538decda0@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 24 Oct 2024 16:26:05 -0700
Message-ID: <CAEf4Bza6pL1-2AmX-zfuv5-mEk=b6yhhGRtb7DrkUTsArvEO6Q@mail.gmail.com>
Subject: Re: Questions about the state of some BTF features
To: Alan Maguire <alan.maguire@oracle.com>
Cc: bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 10:21=E2=80=AFAM Alan Maguire <alan.maguire@oracle.=
com> wrote:
>
> On 24/10/2024 17:53, Andrii Nakryiko wrote:
> > On Thu, Oct 24, 2024 at 7:10=E2=80=AFAM Alan Maguire <alan.maguire@orac=
le.com> wrote:
> >>
> >> hey Andrii
> >>
> >> On 23/10/2024 01:08, Andrii Nakryiko wrote:
> >>> Hey Alan,
> >>>
> >>> There were a few BTF-related features you've been working on, and I
> >>> realized recently that I don't remember exactly where we ended up wit=
h
> >>> them and whether there is anything blocking those features. So instea=
d
> >>> of going on a mailing list archeology trip, I decided to lazily ask
> >>> you directly :)
> >>>
> >>> Basically, at some point we were discussing and reviewing BTF
> >>> extensions to have a minimal description of BTF types sizes (fixed an=
d
> >>> per-item length). What happened to it? Did we decide it's not
> >>> necessary, or is it still in the works?
> >>
> >> Yeah, it's still in the works; more on that below..
> >>
> >>>
> >>> Also, distilled BTF stuff. We landed libbpf-side API (and I believe
> >>> the kernel-side changes went in as well, right?), but I don't think w=
e
> >>> enabled this functionality for kernel builds, is that right? What's
> >>> missing to have relocatable BTF inside kernel modules? Pahole changes=
?
> >>> Has that landed?
> >>>
> >>
> >> The pahole changes are in, and will be available in the imminent v1.28
> >> release. Distilled BTF will however only be generated for out-of-tree
> >> module builds, since it's not needed for kernels where vmlinux + modul=
e
> >> are built at the same time.
> >
> > It's not, strictly speaking, needed, but it might be a good thing to
> > do this anyways to avoid unnecessary rebuilding of kernel modules
> > (always a good thing).
> >
> > But at the very least we should enable it for bpf_testmod* in BPF
> > selftests. Can we start with that?
> >
>
> The good news is that already happens, provided you have the updated
> pahole to handle distilled base generation. After building selftests I se=
e
>
> $ objdump -h bpf_testmod.ko |grep BTF
>   7 .BTF_ids      000001c8  0000000000000000  0000000000000000  00002c50
>  2**0
>  50 .BTF          000036f4  0000000000000000  0000000000000000  0006e048
>  2**0
>  51 .BTF.base     000004cc  0000000000000000  0000000000000000  0007173c
>  2**0
>

Indeed, after updating to the latest pahole master now I get
.BTF.base, very nice.

> Given that these changes are in the master branch of dwarves, I _think_
> we should be testing with this in CI already, or will be imminently at
> least. I'll do some retesting at my end to ensure no regressions are
> observed in test results when using distilled base BTF.
>
> One thing I neglected to do was to send a patch that describe .BTF.base
> in Documentation/bpf/btf.rst ; we discuss .BTF_ids there so I think it'd
> be good to mention .BTF.base there too?

Makes sense, please send the patch.

>
> >>
> >> Here's the set of BTF things I think we've discussed and folks have
> >> talked about wanting. I've tried to order them based upon dependencies=
,
> >> but in most cases a different ordering is possible.
> >>
> >> 1. Build vmlinux BTF as a module (support CONFIG_DEBUG_INFO_BTF=3Dm). =
This
> >> one helps the embedded folks as modules can be on a separate partition=
,
> >> and a very large vmlinux is a problem in that environment apparently.
> >> Plus we can do module compression, and I did some measurements and
> >> vmlinux BTF shrinks from ~7Mb to ~1.5Mb when gzip-compressed. This is
> >> sort of a dependency for
> >>
> >> 2. all global variables in BTF. Stephen Brennan added support to pahol=
e,
> >> but we haven't switched the feature on yet in Makefile.btf. Needs more
> >> testing and for some folks the growth in vmlinux BTF (~1.5Mb) may be a=
n
> >> issue, hence a soft dependency on 1.
> >>
> >> 3. BTF header modifications to support kind layout. I've been waiting
> >> for the need for a new BTF kind to add this, but that's not strictly
> >> needed. But that brings us on to
> >>
> >> 4. Augmenting BTF representations to support site-specific info
> >> (including function addresses). We talked about this a bit with Yongho=
ng
> >> at plumbers. Will probably require new kind(s) so 3 should likely be
> >> done first. May also need some special handling so as not to expose
> >> function addresses to unprivileged users.
> >>
> >> So I think 1 is possibly needed before 2, and I'm working on an RFC fo=
r
> >> 1 which I hope to get sent out next week (been a bit delayed working o=
n
> >> the pahole release). 3 would need to be done before 4, or ideally any
> >> other series that introduced new BTF kinds.
> >>
> >> So that's the set of things I'm aware of - there may be other needs of
> >> course - but the order 1-4 was roughly how I was thinking we could
> >> attack it. 1 and 2 don't require core BTF changes, so are less
> >> disruptive. We'd got pretty far down the road with an earlier version =
of
> >> 3, so if anyone needed it sooner than I get to it, I'd be happy to hel=
p
> >> of course.
> >
> > Thanks, Alan, for the list.
> >
> > I think we should prioritize 3 (and 1, of course), as you said, any
> > BTF extension would be blocked on this (as far as I'm concerned at
> > least). I wouldn't delay until we actually add a new BTF kind to land
> > BTF header modifications, that would just delay future work
> > unnecessarily.
> >
>
> Sounds good! I'll prioritize 3; it was pretty close last time we
> discussed it I think.
>
> Alan

