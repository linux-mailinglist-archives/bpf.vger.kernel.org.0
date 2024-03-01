Return-Path: <bpf+bounces-23170-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0409E86E7F2
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 19:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33E561C25A62
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 18:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F8D134CB;
	Fri,  1 Mar 2024 18:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3C/Mogv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0833C16FF21
	for <bpf@vger.kernel.org>; Fri,  1 Mar 2024 18:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709316251; cv=none; b=hmg464lUKODjyzwWKGi6k7JSPNnsyvNrL5kdPPQz9IKZkOnhWsEQ1cHwiPseFCKgfHBwrMVpzgI0dAy1sJudHKU7dFZTgPHvA3zeAEkLJgawtfFII7DL6Vva/2Sp00x0l80NzUUb/VbhRbNh/IguYhfBHaxMdAf6C2/avAf6geU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709316251; c=relaxed/simple;
	bh=lwCb91WcQ2bGMOZknm39AzEmhaOOLciC6uGVherzH7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O4WHrqhYVUcv6HhGaDHIScA6EQQzvFN6lKwTorESgOey9m4iexM7g4k2V/P0gjGu+MmRYtO2rrOAwYu3xK32BbfW/ztE/E8GdpV4+UOr0VTvXQYtNI263/pf/YNliC7fNGSoCodH3rpDfP0Bh4nLeqWL6NW5FC+yckSkW9pFOYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3C/Mogv; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-29ab78237d2so1812002a91.1
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2024 10:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709316249; x=1709921049; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pW9upuESmTGZjQGoX2TsqLUr9Chq9Sgcdv/UTzWod8U=;
        b=J3C/Mogvc9n/CIBCrqMS22ihhY2L0lsVhtjA2e9S4mxR3Z6seykVbPNW5vsN4d2jZN
         +aUs9bA/Yfx2ZV5avs80WAOKSKNQyxXIE08EO/B4v6uR6njctg7ThVsUnacjE0zdVnAP
         UfVG2pYAgt3+hrT1P9xcueO2Y8BERnH8oamERhx20D9IO9BUfKLlG2KgsrdYa2KLztna
         VEeYK0dfvioOpsnemRiEtvd0jRui114sVQ4smpIrXUxsyYhCPsCxzK0b5fwLKv2X/iMa
         haT+IzYGP4dHZHPOHkN2lkxY+Lok/VVls+Hx/pY1QZZi8QSo/6WC7ZqdU7Y+ELDvqAO2
         qbdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709316249; x=1709921049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pW9upuESmTGZjQGoX2TsqLUr9Chq9Sgcdv/UTzWod8U=;
        b=KutVhToo974llrX3bns5xvo4YZdxylmdHA/VSWzdT6D2YxMlt78hm5FWRVI5S4sYNE
         r7imIF/HaXeHzcgUYMGYNcRw5cBHkVLkC6BynoLIFHRvtpz3fXIKMNDEEbX9tTG79KxO
         fBxRec9CJW1l2RLe6Sl9zxpglAfCAR3cJKoh2OBifBdZW4l28ROxSVcFq4zAuozTG4RT
         KyV3q84Yy0PRcY6pAk68GkFjk8Ckmh2JfCuAZAuYQoA8lB6A2UCEndBDa+BU87pHxUj+
         SABDWBNw20wuG4LmowRtz6sAFa0GajnjqtF0vG8W/97if/DP6yF5mSjEzNWr0iiTsQ/4
         Eb7w==
X-Gm-Message-State: AOJu0YytKmqlJB/DQ5G//GavtA9GbAZFahQ6I0pApF5ZWGCCtTTNNu4U
	F/AepMtlx7Z2FeCJyNVjhIb2ozUbnIQdgU9jKTZQ92ISuCRGzrxebhvmYcpn8KwEK9VZjQr/XI7
	a/iiChj9uirOq8A5E1yVWe5Zhasc=
X-Google-Smtp-Source: AGHT+IHdTU27d4uhFDTLrKWWIqMJccI55TRHbg2idZ0//h+it7DebDJtOQ9IqCDT4vY/0jnbiZNvQkr6dVaw1EjPwKw=
X-Received: by 2002:a17:90a:e614:b0:299:45ee:412c with SMTP id
 j20-20020a17090ae61400b0029945ee412cmr2313329pjy.41.1709316249293; Fri, 01
 Mar 2024 10:04:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227204556.17524-1-eddyz87@gmail.com> <20240227204556.17524-7-eddyz87@gmail.com>
 <CAEf4BzbXzsDUx-dvUQQEMcCVUeUjnBnbF6V4fmc36C0YzVF73A@mail.gmail.com>
 <d5fda01ecfac47e096e741a68ac8a1d2d726fc16.camel@gmail.com>
 <CAEf4BzYRS-wd_FTi-_=1t9mjgMp3P6yrTqbkQ+359aKmcjZDNQ@mail.gmail.com> <316cd654a3c3294a2bb2b9ca2e5bc9767bef294b.camel@gmail.com>
In-Reply-To: <316cd654a3c3294a2bb2b9ca2e5bc9767bef294b.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 1 Mar 2024 10:03:57 -0800
Message-ID: <CAEf4Bzb--AaV3=hu8J1F-taPPpYDcuRRRs_QztVr5c3g=RJFXg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 6/8] selftests/bpf: test autocreate behavior
 for struct_ops maps
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, void@manifault.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 5:28=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Wed, 2024-02-28 at 16:02 -0800, Andrii Nakryiko wrote:
> > On Wed, Feb 28, 2024 at 3:55=E2=80=AFPM Eduard Zingerman <eddyz87@gmail=
.com> wrote:
> > >
> [...]
> > > On Wed, 2024-02-28 at 15:43 -0800, Andrii Nakryiko wrote:
> > > > > +SEC(".struct_ops.link")
> > > >
> > > > can you please also have a test where we use SEC("?.struct_ops.link=
")
> > > > which set autoload to false by default?
> > >
> > > As far as I understand, that would be a new behavior, currently '?'
> > > works only for programs. I'll add a separate patch to support this.
> > >
> >
> > Yep, thanks!
>
> So, I have a draft for v2 with support for this feature in [0].
> But there is a gotcha:
>
>     libbpf: BTF loading error: -22
>     libbpf: -- BEGIN BTF LOAD LOG ---
>     ...
>     [23] DATASEC ?.struct_ops size=3D8 vlen=3D1 Invalid name
>
>     -- END BTF LOAD LOG --
>     libbpf: Error loading .BTF into kernel: -22. BTF is mandatory, can't =
proceed.
>
> Kernel rejects DATASEC name with '?'.
> The options are:
> 1. Tweak kernel to allow '?' as a first char in DATASEC names;
> 2. Use some different name, e.g. ".struct_ops.opt";
> 3. Do some kind of BTF rewrite in libbpf to merge
>    "?.struct_ops" and ".struct_ops" DATASECs as a single DATASEC.
>
> (1) is simple, but downside is requirement for kernel upgrade;
> (2) is simple, but goes against current convention for program section na=
mes;
> (3) idk, will check if that is feasible tomorrow.
>
> [0] https://github.com/eddyz87/bpf/tree/structops-multi-version
>
>

Let's do 1) for sure (ELF allows pretty much any name for DATASEC).
And then detect this in libbpf, and if the kernel is old and doesn't
yet support it, change DATASEC name from "?.struct_ops" to just
".struct_ops". Merging DATASECs seems like an unnecessary
complication.

>

