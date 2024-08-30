Return-Path: <bpf+bounces-38617-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 782B3966C33
	for <lists+bpf@lfdr.de>; Sat, 31 Aug 2024 00:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95B2E1C21596
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 22:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766891C1759;
	Fri, 30 Aug 2024 22:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IfLF2WpR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EC7171E43;
	Fri, 30 Aug 2024 22:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725056418; cv=none; b=GImE24x7NNN9RyGSb4sWwCfP/EKO8+Yp4UBPucA9vIlyITK8SvnlR/AQl1NVvW8+IJd6cOKCEOuasL7pvVQptPmAu/1FgBhnZIIsiyX+xGcEpEimqhqUSAqibPygM8hmsyxkfSZ4Z60/NHMHrlXErYeLIk1ph7a2oezCrS9pqL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725056418; c=relaxed/simple;
	bh=7Lyr+XdUGvWK6+YO67eKidrjSDSHBsQdkK5IN9kuxjo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tvRFGfXmhzngWw61oCc/0TR6AD6e36c6kRTvkFYgOuOZt/6E3RWwRy1/cDEDUiUh6yPlgzozDRtI7SPjj1V4XM0TtstdHs9dWP/hMHiQRyZwPzh9ACz5q6JQLjNZNBi5Dx67T07kygGV0gj46SceF62tlA2NNoPSM5lFqj8hVCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IfLF2WpR; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2d86f71353dso791758a91.2;
        Fri, 30 Aug 2024 15:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725056416; x=1725661216; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iGZP+ZdMQuPvnN+UBKHPmT/pJSs9RBJYMCPcn1MymVw=;
        b=IfLF2WpRfNAeAs4N9Dx+EXYlrZV5xLi59t+2Hi/qNUtM5JokJURQyNbuMrJi1x9i/6
         Za5EdyKwXMkqsm/14HqprnFDUT+phO3Dx47dqYCnsBDOVgnAzwlyFW2p+uoBEk8OGvzc
         K6hrZpQFXkmyCMotzIllc7imllp3nc6bSwpR7SZpRjGHvyv+CbcBHvxfQcZzilEjH9kw
         54aKxpUvxcwhJG2iPDQ5tlhR2b8ByYZTBccXislDcbrZZ6S5Gv5Cs+8otJWsbBWMb8xf
         GEfuzyK6yMt51G+DgVRkGLEJrkR7Nkr5rq5myEyMRkaEWBZvMgCFGreBmasC8mNbL8k0
         jHeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725056416; x=1725661216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iGZP+ZdMQuPvnN+UBKHPmT/pJSs9RBJYMCPcn1MymVw=;
        b=b9Oybz8xwCAoZVWktQylptqibxqrVeRYW6zXCB8ciqSSacPUvEsEe3VJMGkRiM9JXe
         Z05Oust2cZOTj+3RYwqxlwL+BbLd1JdN8EYlYChRcLongakBbeBgktsOXaG3bCdkP8PD
         +oARW5h8p4MujlHxbjGa2REVTN4RI95uDIxa08p/xmZZdn/6qH0h/djw67Bd2v03f1IQ
         3yXMk2osh9dRuDK51evoUWCXEn8xDppIdExo1PU8/wA53EveF40DzJVCuOifHHxoSUiz
         Ki25eR92uIqWT2PaX26rSdF8LOtTJVwNtMPr5f+A4I3qLPeLkLAQ1Nh/l0wuXIvgmPWC
         Ayiw==
X-Forwarded-Encrypted: i=1; AJvYcCVVj6ApufxoNc22Pn8vG8nAkIP6BvHz76XE9t0B+JaEiyHluV2J9s2mOl306fgjOcENtFVoQgGozQ==@vger.kernel.org, AJvYcCWxAdNV6z9LDwuG5w2MVxU6vG5WYXhToOlgLmOtPfp72mCNEjCQGkj4v/nB+98qG2F/XRY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywclk0YtFZvvUy7yzqZfsJXw6aKdzyXRUTbK12YHmuVdCwy6KEd
	cnpBBg7Xqf1e4UYnrj9gMlK+LR91MqiLD0dNhUJfNNFgGduYG1Kk4C5MJwidwlPDlegTrCDQtwe
	duMI2wRQbheUY0dW+JhqehbyfJvk=
X-Google-Smtp-Source: AGHT+IHr0eZuKiOPykAYh+9H3VrE72nJK/v8eNbRn5cplCBB4E0j8L349w0AXw4YXp6ODPdcRhdFRv8E4GIXOYLG7yY=
X-Received: by 2002:a17:90a:cf0b:b0:2d4:6ef:cb14 with SMTP id
 98e67ed59e1d1-2d8563916e5mr7825073a91.28.1725056415865; Fri, 30 Aug 2024
 15:20:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6358db36c5f68b07873a0a5be2d062b1af5ea5f8.camel@gmail.com>
 <442C7AEC-2919-4307-8700-F7A0B60B5565@fb.com> <322d9bac47bc3732b77cf2cf23d69f2c4665bc36.camel@gmail.com>
 <860fe244-157b-46cf-9b41-ee9fd36f9c1e@oracle.com> <ZtHG9YwwG5kwiRFt@x1>
 <CAEf4Bza9OJckdJ4=nask2m+bJsiDszvoLoaf+GhVFu8CNarb=g@mail.gmail.com> <ZtIwXdl_WyYmdLFx@x1>
In-Reply-To: <ZtIwXdl_WyYmdLFx@x1>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 30 Aug 2024 15:20:03 -0700
Message-ID: <CAEf4BzY5kx9HayBCViuXf0i7DyvFgcRObvnA1u3bqot2WjfyGg@mail.gmail.com>
Subject: Re: FYI: CI regression on big-endian arch (s390) after recent pahole changes
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alan Maguire <alan.maguire@oracle.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <songliubraving@meta.com>, 
	"dwarves@vger.kernel.org" <dwarves@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 1:49=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Fri, Aug 30, 2024 at 08:56:08AM -0700, Andrii Nakryiko wrote:
> > On Fri, Aug 30, 2024 at 6:19=E2=80=AFAM Arnaldo Carvalho de Melo <acme@=
kernel.org> wrote:
> > > On Fri, Aug 30, 2024 at 11:05:30AM +0100, Alan Maguire wrote:
> > > > Arnaldo: apologies but I think we'll either need to back out the
> > > > distilled stuff for 1.28 or have a new libbpf resync that captures =
the
> > > > fixes for endian issues once they land. Let me know what works best=
 for
> > > > you. Thanks!
> > >
> > > It was useful, we got it tested more widely and caught this one.
> > >
> > > Andrii, what do you think? Can we get a 1.5.1 with this soon so that =
we
> > > do a resying in pahole and then release 1.28?
> >
> > Did you mean 1.4.6? We haven't released v1.5 just yet.
> >
> > But yes, I'm going to cut a new set of bugfix releases to libbpf
> > anyways, there is one more skeleton-related fix I have to backport.
> >
> > So I'll try to review, land, and backport the fix ASAP.
>
> Well, Alan sent patches updating libbpf to 1.5.0, so I misunderstood, I
> think he meant what is to become 1.5.0, so even better, I think its just
> a matter of updating the submodule sha:
>
> =E2=AC=A2[acme@toolbox pahole]$ git show b6def578aa4a631f870568e13bfd6473=
12718e7f
> commit b6def578aa4a631f870568e13bfd647312718e7f
> Author: Alan Maguire <alan.maguire@oracle.com>
> Date:   Mon Jul 29 12:13:16 2024 +0100
>
>     pahole: Sync with libbpf-1.5
>
>     This will pull in BTF support for distilled base BTF.
>
>     Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>     Cc: Alexei Starovoitov <ast@kernel.org>
>     Cc: Andrii Nakryiko <andrii@kernel.org>
>     Cc: Eduard Zingerman <eddyz87@gmail.com>
>     Cc: Jiri Olsa <jolsa@kernel.org>
>     Cc: bpf@vger.kernel.org
>     Cc: dwarves@vger.kernel.org
>     Link: https://lore.kernel.org/r/20240729111317.140816-2-alan.maguire@=
oracle.com
>     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> diff --git a/lib/bpf b/lib/bpf
> index 6597330c45d18538..686f600bca59e107 160000
> --- a/lib/bpf
> +++ b/lib/bpf
> @@ -1 +1 @@
> -Subproject commit 6597330c45d185381900037f0130712cd326ae59
> +Subproject commit 686f600bca59e107af4040d0838ca2b02c14ff50
> =E2=AC=A2[acme@toolbox pahole]$
>
> Right?

Yes, and I'm doing another Github sync today.

Separate question, I think pahole supports the shared library version
of libbpf, as an option, is that right? How do you guys handle missing
APIs for distilled BTF in such a case?

>
> - Arnaldo

