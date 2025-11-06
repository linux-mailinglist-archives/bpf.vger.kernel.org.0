Return-Path: <bpf+bounces-73882-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AABC3CC26
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 18:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ED524505309
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 17:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7710834DB64;
	Thu,  6 Nov 2025 17:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JVU1SGMl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E02341654
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 17:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762448971; cv=none; b=NTE4QpEZnDAn9rsFpx84A2VNQVUAHphzSRUCrJwm+fuw9VobJLSX7bjUlUIYr4R8DN1rcfaoCORD4E3w30ey63sJUDopMWaZ9Zdt5pT5G5WIirioeft7tVBQlpDpfLUCgy3NfL3cJC2k6Qs13TjofCcxAauQDwIoMTb6fSVO5xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762448971; c=relaxed/simple;
	bh=JvH3OKqzSA3KvNi+aVsfuhv279eL/y2CtByR2v+3ndA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hJb3ELYhPfRtN36nagzrDTeAm2pAn6hsKWNcvO5x3FUnnMGIApPLyWvyL1woDSPxJMY/b+Y9Lj2M/aarAN/gBNddkQNogi+JAtq5cFvhk//IeYX6LnVNLlpZH5vW7ILuwzdnZ9aXEWZxqfwfOrYIKYNrJOajeyHD4t3pFPfhR4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JVU1SGMl; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-340a5c58bf1so971289a91.2
        for <bpf@vger.kernel.org>; Thu, 06 Nov 2025 09:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762448969; x=1763053769; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JvH3OKqzSA3KvNi+aVsfuhv279eL/y2CtByR2v+3ndA=;
        b=JVU1SGMlfzMuCNtb0ml3ClizNTHKHTvp/Ro39qwdSyvzzabbB4gsNzmPbd8WE2JKXW
         wAI25mESf+uVzSvCLTFWg1uVuLVe9jZNzd3KnvMxdSZZCRwZ54Vt5tVPb7BnNGsuqQR6
         cbjsKorQvepozzFg41MGnp8bdN90RzCk9KtEGmUHZoMCnN40WVSLdHFBA9TZTOeoiaf8
         gEgIAKTcVplX5F/w6HPZPRx7OPMkunFeAC1cEKiEPKTc0obOUiuXAuqZc+QaWRSnAIfz
         d515uqz8WHkixuWDuBBcrOiDW5gbb3oj3hh5z+rydccnGFNqPw5UjD3f3I11Fn2RNO7d
         N5Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762448969; x=1763053769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JvH3OKqzSA3KvNi+aVsfuhv279eL/y2CtByR2v+3ndA=;
        b=DaB/hovvkuMLA1ZrNIrQ9lo+GswwCyzPAzOc9nLllHUaEIIUWP7Cr3Mx5kBoDAT/xX
         5aZaRg+pX380y/SHftfHsjtIXqZyQUxeDZe8bjKtVTIIQLSpZWVOZllF+p560/5RPPfQ
         Fmm3CpSok4iD339d3lSqr8EXfIf8B+S0SxFs2cqihck7PUPyEzJtfX36T0NS4nGqyepW
         AQbwa/EKTGomavWRZGU8hGHv3IcvdDdgA8ausuT2ubOeGjCSzSqCCmDKOhMKUt1twMhy
         crM6kLotseU2zsQNHesHQsrVbwmpn12MZsJMTliJH0LLYOeK/RnUMujfcaJ8CsBrSeOz
         iZew==
X-Forwarded-Encrypted: i=1; AJvYcCVUwLgzShl8R0awQ7BaT/QERkxKDCYcyv8G2JIDvG4gg9pUWM3dQQKILs67peuizzr+JIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMOTnqb4rsSYFO85+Yg5ks9n9G5DvNevkxTMZTOWc8dRTf1Ali
	o782z7XPlNCV5LH0Z7UwJBrhnmXYWqwFMRVbTuEzL4EyvIgLPi2gUElKWZD5oHvhiLAj9Rb9C23
	OaC8GTsMbX9N3waFAFIuk7hC3iSRItkq/rg==
X-Gm-Gg: ASbGncvU38t+qItKWdHf9HuZ2zrs7KbDVEQOn/5bL658403TL0Zva/KS+GaqSGAnoCo
	pMG0+ComJMGpYXNjhXkSgdZ9e/rFXY/6Wtr55DGQCgdwP+4r8exklsFRV97ltQEN+EGqZSiCyt8
	AFcjDymNJAxWA9owBXMBaNK+nORqswRXs+XsY0Hcm4pasyhToY70zS+4trOdREpNPYojKgkP3/v
	ricsMGYP6CqV7tfdQPFIVzEX9VVwGmUGEmTyxaL7QZlAtz0GlHsDjkEI8sBKKiy0YqZOLsRu2M3
X-Google-Smtp-Source: AGHT+IE3sAMweT/YOE49eQMAMasowJjZCwp1ej2zFTKLi05DHggSCpa4/L/RdLYhewS/IAuki3OKEeKoJj+tKS9pE4o=
X-Received: by 2002:a17:90b:4b0e:b0:340:6f07:fefa with SMTP id
 98e67ed59e1d1-341a6dc8cf5mr9426239a91.20.1762448968766; Thu, 06 Nov 2025
 09:09:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104134033.344807-1-dolinux.peng@gmail.com>
 <20251104134033.344807-2-dolinux.peng@gmail.com> <CAEf4BzaPDKJvQtCss4Gm1073wyBGXmixv4s9V5twnF7uEHRhPg@mail.gmail.com>
 <61e92756ea7f202f2e501747b574e97b2f5bc32f.camel@gmail.com>
 <CAEf4BzanAmmSe84GnvWSR_KLFVmeEvrxVVJAvApFNRjgeRXk8Q@mail.gmail.com>
 <61f94d36d6777b9b84e9bf865edd17476a278e73.camel@gmail.com>
 <CAEf4BzZffw1sTJUBxwUnhx8XjQNMRf2-e+vUzOfyMqgMTpYsdA@mail.gmail.com> <7f3586157e17d0ab2c34b16d2f7daf4955d0692f.camel@gmail.com>
In-Reply-To: <7f3586157e17d0ab2c34b16d2f7daf4955d0692f.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 6 Nov 2025 09:09:02 -0800
X-Gm-Features: AWmQ_bnT1dvAw2MHO4-RP6rtgu3KhUSDOQvYSNpF_QjZQHZK3C_FkOyALCAKKW8
Message-ID: <CAEf4Bzb9Q3u-a0QCv=nTjdn_ufmfUh-hd-0N3dC=0NmjO6u8kw@mail.gmail.com>
Subject: Re: [RFC PATCH v4 1/7] libbpf: Extract BTF type remapping logic into
 helper function
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Donglin Peng <dolinux.peng@gmail.com>, ast@kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>, Song Liu <song@kernel.org>, 
	pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 11:41=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Wed, 2025-11-05 at 10:20 -0800, Andrii Nakryiko wrote:
>
> [...]
>
> > You don't like that I ask people to improve implementation?
>
> Not at all.
>
> > You don't like the implementation itself? Or are you suggesting that
> > we should add a "generic" C implementation of
> > lower_bound/upper_bound and use callbacks for comparison logic? What
> > are you ranting about, exactly?
>
> Actually, having it as a static inline function in a header would be
> nice. I just tried that, and gcc is perfectly capable of inlining the
> comparison function in -O2 mode.

I dislike callbacks in principle, but I don't mind having such a
reusable primitive, if it's reasonably abstracted. Do it.

>
> I'm ranting about patch #5 being 101 insertions(+), 10 deletions(-)
> and patch #4 being 119 insertions(+), 23 deletions(-),
> while doing exactly the same thing.

Understandable, but code reuse is not (at least it should not be) the
goal for its own sake. It should help manage complexity and improve
maintainability. Code sharing is not all pros, it creates unnecessary
entanglement and dependencies.

I don't think sharing this code between libbpf and kernel is justified
here. 100 lines of code is not a big deal, IMO.

>
> And yes, this copy of binary search routine probably won't ever
> change. But changes to the comparator logic are pretty much possible,
> if we decide to include 'kind' as a secondary key one day.
> And that change will have to happen twice.
>
> > As I said, once binary search (of whatever kind, bounds or exact) is
> > written for something like this, it doesn't have to ever be modified.
> > I don't see this as a maintainability hurdle at all. But sharing code
> > between libbpf and kernel is something to be avoided. Look at #ifdef
> > __KERNEL__ sections of relo_core.c as one reason why.

