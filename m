Return-Path: <bpf+bounces-44805-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 278239C7C9E
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 21:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AD88B294BD
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 20:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933B420605E;
	Wed, 13 Nov 2024 20:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O2djfWw/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0174205E22;
	Wed, 13 Nov 2024 20:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731528474; cv=none; b=KCPaz94F5sEo8bYutEoFKQVqOH7zTFIJ+h/PodGt0G0CIrNLlNgmvYIpPM2WNSa4D0xrvhY1FUoldD5ceeEK+qnwzXE6fljprpbRp9PGD5P3i9b2wonMXGnDHqCEpziSiYTaMy5ZvDZUkL8NY0JgrBACJSe8f2ssgU6MHsOwGFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731528474; c=relaxed/simple;
	bh=EdWpC6nUWjtW9kS9CKz2Hu+efJl8wyTxUFLglQU0rzI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LHo5Tjb32rTvF99t0Z89Rxv2Prl4eWnnRf1pCDw66J6eiB050tP2DvP3W6U0PkfyH6hnsE4OBWvfUQqJGK+M3tbBIqTQZIgWQofnC2n11QZa9mkoRYZacgqvLw+tq6T1jaoiHcc7gQWoTmK1cO1g7u6v4og7rIMnmZLC9hLehQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O2djfWw/; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2e31af47681so5901507a91.2;
        Wed, 13 Nov 2024 12:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731528472; x=1732133272; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W0c7fbidZtqQe8FY/FRRJ545PywZBvyL5JkJDhrZcU8=;
        b=O2djfWw/C2i6MVMW9di+J4J3xtapqogdfLvxO+/vSi1fhbWGktCrFIVe+nvytkpjUd
         ssWX/0qexYMuThvm3Y5gK8JYHO1TrZyU53dKOvebf4owDViqivIsAicFHmP0vrqzW4eM
         oBOS58h/FdF5g8lV9HzspN5cfoOmM92vF1jIpxdQcZkRJ0PcYD+SRaZAQKADu6yG6oTj
         0gxA2l7NapAq6sBKqiJTEUs/ILqc+QdyDgkG6L6eElkQ9kdDHqUBkO+gaCC4AnrApMD9
         7TA2XHoSJ0uD9OYkKJMiXOKD3tQdROl909hu7i2Y/TK7VBwvxzjsDTGJRRAoJg5MU6Jk
         onKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731528472; x=1732133272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W0c7fbidZtqQe8FY/FRRJ545PywZBvyL5JkJDhrZcU8=;
        b=i6EOrkEzm4An/n/2Lwqu/93p/nXDkSH7/HgIzbqZWmyZjYogxAXz5HfzAO+4QZwLY9
         O81ufR6TD5Prom7JBSKugXhI88Ysr203d6QQH++63+boPYyBj0CAlFDCldgW9g+UoOkW
         SpHPxgk91lg5uZxpU/bwEXckIuMYNOzdZE8HL6Bpry56oJ/UWNQBuzwKvggtF+dFm/+8
         0FviftMgpBbcW/IkdBy7AKn1LWH/LzJ0ISzAV8Y8f3FrdXV5DI9rlCUc4xJk4t9tBUYe
         /5OlsJ3e5STP7rYDLtvESgvMWsQOjvXBCwHuVqmIaB0faBDqhoHOTMKtehEBuiv4QKsk
         g4iw==
X-Forwarded-Encrypted: i=1; AJvYcCVSI54dxwNeRjtqd8ZYz5Bw4ndwJGyeqcwT7oqJO/bcW8ey0GjRxA+nydSkdbNVQ9wwT/s=@vger.kernel.org, AJvYcCXyZDh1FSqA00be18DfQrwqoWvFHfAoxP9PYdBydG3YpL1tcEpbj7nSGOXU2gTC8Nm90lSC5KSD@vger.kernel.org
X-Gm-Message-State: AOJu0YzQvjfBgR1kQPuLaT+OIinKLXxcU87tTlgah4IsypPV5/b6hMnw
	DCl/uCQ0jqnVe1nbyACnt2vJF5a+bw3MQYAiTJgRjIFWovLLUEYghdP8QVNriIfiaGiLFT7jRq/
	MoQ7MOCHjvgsexz3gWDmJ9kvL46g=
X-Google-Smtp-Source: AGHT+IHwI6W6VWIsZI7BAzEIbR0gTXidnkFyVaH6guFsV7JNnjNO5KKBA3Dw5LIIUN0rALuS32cLlAfmboLP5JrFJf4=
X-Received: by 2002:a17:90b:3c91:b0:2e2:d821:1b78 with SMTP id
 98e67ed59e1d1-2e9f2b3bbd3mr5411263a91.0.1731528471714; Wed, 13 Nov 2024
 12:07:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104175256.2327164-1-jolsa@kernel.org> <2024110536-agonizing-campus-21f0@gregkh>
 <ZyniGMz5QLhGVWSY@krava> <2024110636-rebound-chip-f389@gregkh>
 <ZytZrt31Y1N7-hXK@krava> <Zy0dNahbYlHISjkU@telecaster> <Zy3NVkewYPO9ZSDx@krava>
 <Zy6eJdwR3LWOlrQg@krava>
In-Reply-To: <Zy6eJdwR3LWOlrQg@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 13 Nov 2024 12:07:39 -0800
Message-ID: <CAEf4Bza3PFp53nkBxupn1Z6jYw-FyXJcZp7kJh8aeGhe1cc6CA@mail.gmail.com>
Subject: Re: Fix build ID parsing logic in stable trees
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Omar Sandoval <osandov@osandov.com>, Greg KH <gregkh@linuxfoundation.org>, 
	stable@vger.kernel.org, bpf@vger.kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 3:26=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrote=
:
>
> On Fri, Nov 08, 2024 at 09:35:34AM +0100, Jiri Olsa wrote:
> > On Thu, Nov 07, 2024 at 12:04:05PM -0800, Omar Sandoval wrote:
> > > On Wed, Nov 06, 2024 at 12:57:34PM +0100, Jiri Olsa wrote:
> > > > On Wed, Nov 06, 2024 at 07:12:05AM +0100, Greg KH wrote:
> > > > > On Tue, Nov 05, 2024 at 10:15:04AM +0100, Jiri Olsa wrote:
> > > > > > On Tue, Nov 05, 2024 at 07:54:48AM +0100, Greg KH wrote:
> > > > > > > On Mon, Nov 04, 2024 at 06:52:52PM +0100, Jiri Olsa wrote:
> > > > > > > > hi,
> > > > > > > > sending fix for buildid parsing that affects only stable tr=
ees
> > > > > > > > after merging upstream fix [1].
> > > > > > > >
> > > > > > > > Upstream then factored out the whole buildid parsing code, =
so it
> > > > > > > > does not have the problem.
> > > > > > >
> > > > > > > Why not just take those patches instead?
> > > > > >
> > > > > > I guess we could, but I thought it's too big for stable
> > > > > >
> > > > > > we'd need following 2 changes to fix the issue:
> > > > > >   de3ec364c3c3 lib/buildid: add single folio-based file reader =
abstraction
> > > > > >   60c845b4896b lib/buildid: take into account e_phoff when fetc=
hing program headers
> > > > > >
> > > > > > and there's also few other follow ups:
> > > > > >   5ac9b4e935df lib/buildid: Handle memfd_secret() files in buil=
d_id_parse()
> > > > > >   cdbb44f9a74f lib/buildid: don't limit .note.gnu.build-id to t=
he first page in ELF
> > > > > >   ad41251c290d lib/buildid: implement sleepable build_id_parse(=
) API
> > > > > >   45b8fc309654 lib/buildid: rename build_id_parse() into build_=
id_parse_nofault()
> > > > > >   4e9d360c4cdf lib/buildid: remove single-page limit for PHDR s=
earch
> > > > > >
> > > > > > which I guess are not strictly needed
> > > > >
> > > > > Can you verify what exact ones are needed here?  We'll be glad to=
 take
> > > > > them if you can verify that they work properly.
> > > >
> > > > ok, will check
> > >
> > > Hello,
> > >
> > > I noticed that the BUILD-ID field in vmcoreinfo is broken on
> > > stable/longterm kernels and found this thread. Can we please get this
> > > fixed soon?
> > >
> > > I tried cherry-picking the patches mentioned above ("lib/buildid: add
> > > single folio-based file reader abstraction" and "lib/buildid: take in=
to
> > > account e_phoff when fetching program headers"), but they don't apply
> > > cleanly before 6.11, and they'd need to be reworked for 5.15, which w=
as
> > > before folios were introduced. Jiri's minimal fix works for me and se=
ems
> > > like a much safer option.
> >
> > hi,
> > thanks for testing
> >
> > I think for 6.11 we could go with backport of:
> >   de3ec364c3c3 lib/buildid: add single folio-based file reader abstract=
ion
> >   60c845b4896b lib/buildid: take into account e_phoff when fetching pro=
gram headers
> >
> > and with the small fix for the rest
> >
> > but I still need to figure out why also 60c845b4896b is needed
> > to fix the issue on 6.11.. hopefully today
>
> ok, so the fix the issue in 6.11 with upstream backports we'd need both:
>
>   1) de3ec364c3c3 lib/buildid: add single folio-based file reader abstrac=
tion
>   2) 60c845b4896b lib/buildid: take into account e_phoff when fetching pr=
ogram headers
>
> 2) is needed because 1) seems to omit ehdr->e_phoff addition (patch below=
)
> which is added back in 2)
>
> IMO 6.11 is close to upstream and by taking above upstream fixes it will =
be
> easier to backport other possible fixes in the future, for other trees I'=
d
> take the original one line fix I posted

I still maintain that very minimal is the way to go instead of risking
bringing new potential regressions by partially backporting folio
rework patchset.

Jiri, there is no point in risking this, best to fix this quickly and
minimally. If we ever need to backport further fixes, *then* we can
think about folio-based implementation backport.

>
> jirka
>
>
> ---
> diff --git a/lib/buildid.c b/lib/buildid.c
> index bfe00b66b1e8..19d9a0f6ce99 100644
> --- a/lib/buildid.c
> +++ b/lib/buildid.c
> @@ -234,7 +234,7 @@ static int get_build_id_32(struct freader *r, unsigne=
d char *build_id, __u32 *si
>                 return -EINVAL;
>
>         for (i =3D 0; i < phnum; ++i) {
> -               phdr =3D freader_fetch(r, i * sizeof(Elf32_Phdr), sizeof(=
Elf32_Phdr));
> +               phdr =3D freader_fetch(r, sizeof(Elf32_Ehdr) + i * sizeof=
(Elf32_Phdr), sizeof(Elf32_Phdr));
>                 if (!phdr)
>                         return r->err;
>
> @@ -272,7 +272,7 @@ static int get_build_id_64(struct freader *r, unsigne=
d char *build_id, __u32 *si
>                 return -EINVAL;
>
>         for (i =3D 0; i < phnum; ++i) {
> -               phdr =3D freader_fetch(r, i * sizeof(Elf64_Phdr), sizeof(=
Elf64_Phdr));
> +               phdr =3D freader_fetch(r, sizeof(Elf64_Ehdr) + i * sizeof=
(Elf64_Phdr), sizeof(Elf64_Phdr));
>                 if (!phdr)
>                         return r->err;
>

