Return-Path: <bpf+bounces-44811-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5389C7D77
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 22:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C093A281012
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 21:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ECB0209F25;
	Wed, 13 Nov 2024 21:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYbAmn/+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218D6209F2B;
	Wed, 13 Nov 2024 21:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731532365; cv=none; b=oNMKtBeodvA4evc74i04O2eSP3kDWZkSZy/BJa269bhWxR/+WXKQFOKfLkam9rUIdWYIFvoDMPeYfEjdI8bN8aSIK4JT9qUynX2b0rDV9pLcAlyEDFrZL129XO0D2WQnkxhj6gQFDvhmo1noKsgeqcEFjQKtoQW+i5nVRfODjso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731532365; c=relaxed/simple;
	bh=72Ve/pNh5kK8gkMu6JAKBHE6zfqtENR2gMWIhqXPMH4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bHIHlZvdwOGf1HWgZpk5TCeX6YlHrmuIEr9iSAlMa+ld9uACpat6nbyYZ1k6sGmf8XVvF3eSdv1va2ewHn/4X6QfAWPElS4wRoP1tcu+qyxLmW2d0aS12Bj3K9g552hYK8uytj/c4gKHeLVV1tcmJ1FgLJLCFDdzsUFm1Oj7z/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FYbAmn/+; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9e8522445dso1311650466b.1;
        Wed, 13 Nov 2024 13:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731532361; x=1732137161; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C/5l/kmt/6lUYnvWdJosFt6ZJCDICjlJ7hlHZRAvvEs=;
        b=FYbAmn/+6hKPVxBVwOvIpHy1dolNgRj4L3/GiV5fyPHrcFNeU5LQpjrEz8SRBw8xZI
         KRGF97z4vAvZpmpysZxRglbj5h3w8Wo+DuP54FEdv45CsLb1q3QkKw44qhbnCM70CcVM
         XCxsmoKejmxx3Ag7xFDlpzYMnMGsMd7E46iEkT31Ak2rBZaHbdG1uFTKXeAmquBEc6Js
         PAJaKktDkK1axQ5JvfYDb7EHyjZ5QgwuUkQtaqaWSXQEJd4oYC8DmBXTK+DTbDyeL0hL
         BCW4+LI4l7jkOC9ZTKcs7DQZUilQ55n45HIsZaGpv8apOzo91ixAMVeNuJmyXY7hmpWt
         bnLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731532361; x=1732137161;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C/5l/kmt/6lUYnvWdJosFt6ZJCDICjlJ7hlHZRAvvEs=;
        b=MmWPR4UmzmoCcWSKdIzT2RxjHcRf9Cp0TDD7TOeSlwQs0YI8//qPaEsKVgk8kzAD0c
         xgW+Gun8zWSmMKrQCmkqZZauj2poDQ4pgQaClDHrA+Q8f0kVLlXgoC/516Cd4WpUtvS8
         1KTYneAgtXY+8g+VQsvTNd7fk1iILtcJvVa7LaAT7ma5Kz/fNo+VnpomwTkRo9EljLkV
         8Rz8LfDQMVlmUFChIy+l/dvEsyC3zFZfAhgpMzMAjMIU7gihCOfbY/NZ02KjfwoFwVxq
         e9FN3hzaJoUlvki0b/p5z1RNzVmjdnMyGgfJ84yt6Q4nz9nTPsu+vmoSeVhDcjsGxFXU
         Htkw==
X-Forwarded-Encrypted: i=1; AJvYcCVQ/yKUpgGb8hXQzWaUP5keWbnC9Z5vA5k2Dlt9JF0XU8t0t3ukhEJXvYxem988UFpHrAHcOC5L@vger.kernel.org, AJvYcCXiU/63yy3oSXMX8dgX/xfRlqUWBbeQgxR0NaKc2PstpNlrcVhQ/WM4ZrYmwHcf1WMdxQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn/Y3FWMbXU/yn9BNl0DbEgzIChXeGSP2EdLDGNC4CtNM6mz+4
	NVgcnCop+13JgiPPZBnG/mLs5Q9hEwVvYE50zhFU6C9U0UaZPsOD
X-Google-Smtp-Source: AGHT+IFPJRdOknfnkbue7SxrxsIhCX4vkgfeT5R/tU7n9j53nxUtAv8xJxsD439Yz4+ifO0M3SAHnw==
X-Received: by 2002:a17:907:2ce3:b0:a9a:1778:7024 with SMTP id a640c23a62f3a-a9eefee9c40mr2078713266b.20.1731532361208;
        Wed, 13 Nov 2024 13:12:41 -0800 (PST)
Received: from krava (85-193-35-167.rib.o2.cz. [85.193.35.167])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0e2eb33sm931476466b.186.2024.11.13.13.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 13:12:40 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 13 Nov 2024 22:12:39 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Omar Sandoval <osandov@osandov.com>,
	Greg KH <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
	bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: Fix build ID parsing logic in stable trees
Message-ID: <ZzUWRyDmndTpZU3Y@krava>
References: <20241104175256.2327164-1-jolsa@kernel.org>
 <2024110536-agonizing-campus-21f0@gregkh>
 <ZyniGMz5QLhGVWSY@krava>
 <2024110636-rebound-chip-f389@gregkh>
 <ZytZrt31Y1N7-hXK@krava>
 <Zy0dNahbYlHISjkU@telecaster>
 <Zy3NVkewYPO9ZSDx@krava>
 <Zy6eJdwR3LWOlrQg@krava>
 <CAEf4Bza3PFp53nkBxupn1Z6jYw-FyXJcZp7kJh8aeGhe1cc6CA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bza3PFp53nkBxupn1Z6jYw-FyXJcZp7kJh8aeGhe1cc6CA@mail.gmail.com>

On Wed, Nov 13, 2024 at 12:07:39PM -0800, Andrii Nakryiko wrote:
> On Fri, Nov 8, 2024 at 3:26 PM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Fri, Nov 08, 2024 at 09:35:34AM +0100, Jiri Olsa wrote:
> > > On Thu, Nov 07, 2024 at 12:04:05PM -0800, Omar Sandoval wrote:
> > > > On Wed, Nov 06, 2024 at 12:57:34PM +0100, Jiri Olsa wrote:
> > > > > On Wed, Nov 06, 2024 at 07:12:05AM +0100, Greg KH wrote:
> > > > > > On Tue, Nov 05, 2024 at 10:15:04AM +0100, Jiri Olsa wrote:
> > > > > > > On Tue, Nov 05, 2024 at 07:54:48AM +0100, Greg KH wrote:
> > > > > > > > On Mon, Nov 04, 2024 at 06:52:52PM +0100, Jiri Olsa wrote:
> > > > > > > > > hi,
> > > > > > > > > sending fix for buildid parsing that affects only stable trees
> > > > > > > > > after merging upstream fix [1].
> > > > > > > > >
> > > > > > > > > Upstream then factored out the whole buildid parsing code, so it
> > > > > > > > > does not have the problem.
> > > > > > > >
> > > > > > > > Why not just take those patches instead?
> > > > > > >
> > > > > > > I guess we could, but I thought it's too big for stable
> > > > > > >
> > > > > > > we'd need following 2 changes to fix the issue:
> > > > > > >   de3ec364c3c3 lib/buildid: add single folio-based file reader abstraction
> > > > > > >   60c845b4896b lib/buildid: take into account e_phoff when fetching program headers
> > > > > > >
> > > > > > > and there's also few other follow ups:
> > > > > > >   5ac9b4e935df lib/buildid: Handle memfd_secret() files in build_id_parse()
> > > > > > >   cdbb44f9a74f lib/buildid: don't limit .note.gnu.build-id to the first page in ELF
> > > > > > >   ad41251c290d lib/buildid: implement sleepable build_id_parse() API
> > > > > > >   45b8fc309654 lib/buildid: rename build_id_parse() into build_id_parse_nofault()
> > > > > > >   4e9d360c4cdf lib/buildid: remove single-page limit for PHDR search
> > > > > > >
> > > > > > > which I guess are not strictly needed
> > > > > >
> > > > > > Can you verify what exact ones are needed here?  We'll be glad to take
> > > > > > them if you can verify that they work properly.
> > > > >
> > > > > ok, will check
> > > >
> > > > Hello,
> > > >
> > > > I noticed that the BUILD-ID field in vmcoreinfo is broken on
> > > > stable/longterm kernels and found this thread. Can we please get this
> > > > fixed soon?
> > > >
> > > > I tried cherry-picking the patches mentioned above ("lib/buildid: add
> > > > single folio-based file reader abstraction" and "lib/buildid: take into
> > > > account e_phoff when fetching program headers"), but they don't apply
> > > > cleanly before 6.11, and they'd need to be reworked for 5.15, which was
> > > > before folios were introduced. Jiri's minimal fix works for me and seems
> > > > like a much safer option.
> > >
> > > hi,
> > > thanks for testing
> > >
> > > I think for 6.11 we could go with backport of:
> > >   de3ec364c3c3 lib/buildid: add single folio-based file reader abstraction
> > >   60c845b4896b lib/buildid: take into account e_phoff when fetching program headers
> > >
> > > and with the small fix for the rest
> > >
> > > but I still need to figure out why also 60c845b4896b is needed
> > > to fix the issue on 6.11.. hopefully today
> >
> > ok, so the fix the issue in 6.11 with upstream backports we'd need both:
> >
> >   1) de3ec364c3c3 lib/buildid: add single folio-based file reader abstraction
> >   2) 60c845b4896b lib/buildid: take into account e_phoff when fetching program headers
> >
> > 2) is needed because 1) seems to omit ehdr->e_phoff addition (patch below)
> > which is added back in 2)
> >
> > IMO 6.11 is close to upstream and by taking above upstream fixes it will be
> > easier to backport other possible fixes in the future, for other trees I'd
> > take the original one line fix I posted
> 
> I still maintain that very minimal is the way to go instead of risking
> bringing new potential regressions by partially backporting folio
> rework patchset.
> 
> Jiri, there is no point in risking this, best to fix this quickly and
> minimally. If we ever need to backport further fixes, *then* we can
> think about folio-based implementation backport.

ok, make sense, the original plan works for me as well

jirka

> 
> >
> > jirka
> >
> >
> > ---
> > diff --git a/lib/buildid.c b/lib/buildid.c
> > index bfe00b66b1e8..19d9a0f6ce99 100644
> > --- a/lib/buildid.c
> > +++ b/lib/buildid.c
> > @@ -234,7 +234,7 @@ static int get_build_id_32(struct freader *r, unsigned char *build_id, __u32 *si
> >                 return -EINVAL;
> >
> >         for (i = 0; i < phnum; ++i) {
> > -               phdr = freader_fetch(r, i * sizeof(Elf32_Phdr), sizeof(Elf32_Phdr));
> > +               phdr = freader_fetch(r, sizeof(Elf32_Ehdr) + i * sizeof(Elf32_Phdr), sizeof(Elf32_Phdr));
> >                 if (!phdr)
> >                         return r->err;
> >
> > @@ -272,7 +272,7 @@ static int get_build_id_64(struct freader *r, unsigned char *build_id, __u32 *si
> >                 return -EINVAL;
> >
> >         for (i = 0; i < phnum; ++i) {
> > -               phdr = freader_fetch(r, i * sizeof(Elf64_Phdr), sizeof(Elf64_Phdr));
> > +               phdr = freader_fetch(r, sizeof(Elf64_Ehdr) + i * sizeof(Elf64_Phdr), sizeof(Elf64_Phdr));
> >                 if (!phdr)
> >                         return r->err;
> >

