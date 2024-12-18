Return-Path: <bpf+bounces-47152-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C33B9F5B1A
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 01:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08E641892080
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 00:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759C71487DC;
	Wed, 18 Dec 2024 00:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J21EcWU1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6ACB46B8;
	Wed, 18 Dec 2024 00:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734480219; cv=none; b=FwRdY5AoufgBLuGI1Iv8PGsjxY4q2Q7FJ6FJf6EP07WqvYf24JztiebDUS1pxUN32+QrxgYasjVGzhuU779EtAfn38WDL0cE4WWlisNVZaDinPCKRt9rp9zd7zJZ6dt9EGGPPKY72l9VD2BWmJaXjDv4/5UKFOLnQcnzj26Dfno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734480219; c=relaxed/simple;
	bh=EWN8HzaCcVGiN6zESp1IAzLmb9kUlts7STcl2xcNnmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ILiUmj0Kk6zI4vj64o6B+WGf/bJqqkqin17x9EjqB0JapqFLGEnGLkzGSlC9ExWc6hFroJbPp7FdJQ7XZplp9kSRdGXY4RfaoMeeKYgulyb6eG/BMxrh0YaA7UyJEDH/jR+YXC9Ff7ddWAcWjoc1sGmCQiDyhseXMWu+JOjP018=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J21EcWU1; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7f4325168c8so2643014a12.1;
        Tue, 17 Dec 2024 16:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734480216; x=1735085016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EWN8HzaCcVGiN6zESp1IAzLmb9kUlts7STcl2xcNnmE=;
        b=J21EcWU1QnUxDQ9TnGTxJNaVTAW8IzpsZnaZvycuRehRIidjWok11SqOo5Jmme1/Ol
         hUjz1CrYc4bMBbY0qFXsROydKckkAFVZZNv+MPnx3MZ3c62E1VSGcY/Rc57SKKugS389
         Hjw0ADbXbHoLZBt2TfOxBRrqll8lnQB3pzQ/FA9G6MyzGVjSX7u/A+qEErNtgnKy9jby
         AclLIo862Fq+Y6rNB7sM/x1r6tGlmM8efZQVjSEkI0cynEiCciob9uhw31tyzZ0bhqJ9
         xFTBcA6hWJ91CMeQQHgQdIE6jj2J44vMauIXfl4kVGPRKReeU73lINpuYvAU11S9RBDk
         QPEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734480216; x=1735085016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EWN8HzaCcVGiN6zESp1IAzLmb9kUlts7STcl2xcNnmE=;
        b=iCDpbSb289K/kHrMIHeJnjuxrE6QLg6D9o8xaVI0yIGEwZjrOF6Fi6FSZIcTntF5GS
         r1mZs3AVMkrMWenWWYyUwLIJZMbN0tU3u15xGsBqa2b3ZPKt8mUgMSrnxAztlAXxESoT
         fV0gl4EnpraEiussNfKyteTf8+RkLZCrsKoyyvVH9RwJLkh1c7vZMBSfloZAcGtfiDqu
         RRjVILHV4sgb1IEbbKQvfNZuDv0vfJ98z7NXwPM7ZV5NXqT+ewr9Q/f7jCEUsB8gpVVC
         9c+IIL1Wg+k4DPZKovhrYUfr33z3ShrnMgFITiQ1F2XOFxAMSoV5XFob5PIRtZoi75AJ
         YCCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdZJotreQS4EYNispZU2zXOHCSl3pxLZYHkykVYWeX0UPNsmZSucWJ2B9rWJvnBS9EhRdTGio5qg==@vger.kernel.org, AJvYcCWsQtvoLxu24bLELjhUFpg1Awo7D8Lg/MdAlWasjk8max8FMLuAzQ8VhUySlRqui2ihzj4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7WSFSXJ5eEL5v8as8HdWKbDLnx2TEq+2wEjr/+9pz3cUGdf5m
	g8tm5SAM4Scox7EPCWnsuWzca0SVWu3OK7W1YlG/WCqadV95DzWXpoW77acJiGCBHoTvlvZqDp4
	iRmfJcXfwtNLiLGk78shyn6XlmOc=
X-Gm-Gg: ASbGncsr2rtVsa6m3RqqJ2kLR7uQd/VQ4+ym4YgzRXfLHcAk25wEEEadBOOiNdjyBHN
	Uv/gwY2519nVD4BAx38sr6sB0DHI+xYnMmboJ7mM5sNHRMyIV/46jWw==
X-Google-Smtp-Source: AGHT+IEOkPwYwTFIVyYy1Led+KFM3xqFIeFci9I21joi8fE+JYYc9crGaKwgD7ZoZewH4VXhcVQQg24JZJC7QpvlP7A=
X-Received: by 2002:a17:90b:4f:b0:2ee:889b:b11e with SMTP id
 98e67ed59e1d1-2f2e937836bmr1126852a91.30.1734480215970; Tue, 17 Dec 2024
 16:03:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241213223641.564002-1-ihor.solodrai@pm.me> <20241213223641.564002-8-ihor.solodrai@pm.me>
 <09f6bc335380ca73d365566de7af8f2e73ac9cfd.camel@gmail.com>
 <735014fda88330d2124f4956cc9a0507f47176db.camel@gmail.com> <yKpaq5zO0TcrAm1v3p4yd2D9ic0jGUQM0CUSg6CU_31_S1mX7SDljMf36ayteEV2O_MTE2eJkUuu3JoJWPQyIxHibe2zz1W3Uq_RzqiyPVY=@pm.me>
In-Reply-To: <yKpaq5zO0TcrAm1v3p4yd2D9ic0jGUQM0CUSg6CU_31_S1mX7SDljMf36ayteEV2O_MTE2eJkUuu3JoJWPQyIxHibe2zz1W3Uq_RzqiyPVY=@pm.me>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 17 Dec 2024 16:03:24 -0800
Message-ID: <CAEf4BzZ-chyzJzCdW0AwjaxhO+yfUCO=Dcu+7=m96Ccyq94Y8g@mail.gmail.com>
Subject: Re: [PATCH dwarves v2 07/10] btf_encoder: introduce btf_encoding_context
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: Eduard Zingerman <eddyz87@gmail.com>, dwarves@vger.kernel.org, acme@kernel.org, 
	alan.maguire@oracle.com, andrii@kernel.org, mykolal@fb.com, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 10:06=E2=80=AFAM Ihor Solodrai <ihor.solodrai@pm.me=
> wrote:
>
> On Monday, December 16th, 2024 at 7:15 PM, Eduard Zingerman <eddyz87@gmai=
l.com> wrote:
>
> >
> > On Mon, 2024-12-16 at 18:39 -0800, Eduard Zingerman wrote:
> >
> > > On Fri, 2024-12-13 at 22:37 +0000, Ihor Solodrai wrote:
> > >
> > > > Introduce a static struct holding global data necessary for BTF
> > > > encoding: elf_functions tables and btf_encoder structs.
> > [...]
> > >
> > > After patch #10 "dwarf_loader: multithreading with a job/worker model=
"
> > > from this series I do not understand why this patch is necessary.
> > > After patch #10 there is only one BTF encoder, thus:
> > > - there is no need to track btf_encoder_list;
> > > - elf_functions_list can now be a part of the encoder;
> > > - it should be possible to forgo global variable for encoder
> > > and pass it as a parameter for each btf_encoder__* func.
> > >
> > > So it seems that this patch should be dropped and replaced by one tha=
t
> > > follows patch #10 and applies the above simplifications.
> > > Wdyt?
> >
> >
> > Meaning that patch #6 "btf_encoder: switch to shared elf_functions tabl=
e"
> > is not necessary. Strictly speaking, patches 1,2,4 might not be necessa=
ry
> > as well, but could be viewed as a refactoring.
> > Switch to single-threaded BTF encoder significantly changes this patch-=
set.
>
> Eduard, thanks for the review again.
>
> You are correct: if we focus on the multithreading changes in
> dwarf_loader.c and make a decision that there is always a single
> btf_encoder, then much of this series can be discarded.
>
> At the same time I think most of the patches are useful. At the very
> least they enabled experiments that in the end lead me to the
> dwarf_loader changes.
>
> The changes making ELF functions table shared were beneficial in
> isolation, because they eliminated unnecessary duplication of
> information between encoders, leading to reduced memory usage.
>
> The changes splitting ELF and BTF function information in
> btf_encoder.c and simplifying function processing are also good in
> isolation.
>
> In my opinion, it's not wise to discard all of that, because it turned
> out that a single btf_encoder works better in the use-case we care
> about now. Later we might want to revisit parallel BTF encoding. Then
> some version of the refactoring changes here will have to be re-done.
>
> So I think it makes sense to land most of this series without
> significant re-work. But of course I am biased here, as I wrote most
> of the patches, and it's always painful to "throw away" effort.
>
> Let's see what others think.

I agree with Ihor. I think he invested a lot of time into these
improvements, and asking him to re-do the series just to shuffle a few
patches around is just an unnecessary overhead (which also delays the
ultimate outcome: faster BTF generation with pahole). And as Ihor
mentioned, we might improve upon this series by parallelizing encoders
to gain some further improvements, so I think all the internal
refactoring and preparations are setting up a good base for further
work.

Let's try to finalize patch #10's implementation and land this. It's a
nice improvement both performance-wise. It's also good that we don't
need to care about reproducible or not and can effectively deprecate
that short-lived feature we added not so long ago.

