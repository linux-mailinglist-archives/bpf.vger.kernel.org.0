Return-Path: <bpf+bounces-61693-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9E9AEA488
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 19:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10F413A6ADA
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 17:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF192EAD1A;
	Thu, 26 Jun 2025 17:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQ82S4LB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E9B25A2CF
	for <bpf@vger.kernel.org>; Thu, 26 Jun 2025 17:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750959649; cv=none; b=L0fdgofjgLExVBvngQkdN9S5/ltAUMx2SmNz7h/gbN61Yoaesr1uaYFHkDwHSn1XL7NRnEXzWMLx7socKiM6xDsvG2oK8aUMt5yxiByD9+vl+dGLWmleVsKmUO5CPXGKjSCec5b6AoReWhRxxY/ocz5G5PtXl58/D1UMpjTqdvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750959649; c=relaxed/simple;
	bh=IWs5ehdFDJFDDKngFBMhMsbuMUGcMTJdA+gBcBujpqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=awGIR+uA1MHg3gNvNgkTkpWVJHLgR5NToEUaaFkW7MU+DLsrYPJQ7GycVi3ZpBScwiOBUxsSoYcH46x9fpzbK25m1NsACVLBBUWZqi+5vDhZc0wujhH+8DCIo83yRi7FlEgl4eeTF+8qqD+F4PPMaNFCI7UjCbfEzUdUZXZOtJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CQ82S4LB; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-749248d06faso1298784b3a.2
        for <bpf@vger.kernel.org>; Thu, 26 Jun 2025 10:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750959647; x=1751564447; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MICgp/1sW2f9ykamfVTpkjA9xdFq4PW2PGKd9dMjn98=;
        b=CQ82S4LB1Yg5E8L6ChJ5D2w+R/QJu+hPsKqCeFOJLo0EFNlWiD0fGR+afy7DpcnzDq
         FPlz09DHVk3cULKH9xXR3ktt2K4R1h1YAGOa0g+QFmEpSjSADvdgAvsHC98jpEUq6LMv
         qr5Zgyp1lKC/EpgWnLv0oSzImjfSzqb0WRhh88BKR21La15G2ZN18xpzb9Xly1GSu69l
         UubuaHEN/HOPOyur1Cvo9I7KHGKExyK6WmSCqOvpioERaAXOYpxLIUyRAxCPcKqdba5W
         DdPJGUaJFF4vvoODxAvSY6H3Zkz+Qr/Dww/48TwwyZtoEOQdg44AQDEbkPaxtudRUwTp
         Bpag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750959647; x=1751564447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MICgp/1sW2f9ykamfVTpkjA9xdFq4PW2PGKd9dMjn98=;
        b=niE7aLGEvz9lW9PG8qODMBSizsVMKchzxU7uL77T89Uv22GZgIkSDu2iyaKRdJ03Z7
         G+ouT38VXBaQmrOCrzTjWKSF3C57tddbbtZKCghC2NS28KXkrQp/1qXJ3aHnIRPB9VuD
         HZSeyIyAbCGj4AZdECNEclDxJmf7OztmzHEqVoGPKrFtgWZpgGkKObRpjXwJXFFP56Hp
         zcGHHH2NmXwI97PvMT3nmNXG/bALmvTpIklvtrRrwqopBNDLYVC8mQmN7ZuRDjxQEICz
         bhnC7zavGJJ1ZHi83xyvx67M+vcFjnBP2vvx76qNQj2PiK5OK05aw1HSx5pk/QlywE4O
         TbtA==
X-Forwarded-Encrypted: i=1; AJvYcCVQPfpoFKqjVQGKdtriqfKUZp1Np6/V09YGGZ//66iHV81jrWjYO/4/U86EykcHFPwbQcw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLZz3QzJA4+/iMz7e+3rA6vVKcv+DDTqAot4bx5BTPce+BHcOx
	70RmWTjr6DGlzRBt9VDtGA9LsEwTonwAc61qGvVibP7NJAzNfeSSCb/QVh3CKMx7QZBFaxyMaYB
	85Y9eT3uAXpn6Mc2uTwa+RpUVXmoCGlA=
X-Gm-Gg: ASbGnctQ5M1MdSa2tDvfj5lO+dIW4RWnSp8yQxzvcDYt24kgTv1n7Hb23uyU4YdqU9k
	hdXQVSVvg+7yfFeP3cAw9j4yuVC6u/81siVAXFuiC1Ui1n5IkvW7p6BlbGcO85Nnltm1d2+Tz+l
	pGpquAJVbU0ydC3L9NSlZxBoA3puQzoxaaKCdq9TVpMs31wM9EGsbKsqUgPj4=
X-Google-Smtp-Source: AGHT+IHhiBRJ4iH+s30osALGjYWrIPKOAkb89fXf8i+O7r3rJGwdAYPL77zKzz+TKT3lCmC+mBVrP3w57+TsufYM1SM=
X-Received: by 2002:a05:6a00:4b16:b0:748:f1ba:9aff with SMTP id
 d2e1a72fcca58-74af6e6350cmr126777b3a.5.1750959647068; Thu, 26 Jun 2025
 10:40:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625165904.87820-1-mykyta.yatsenko5@gmail.com>
 <20250625165904.87820-3-mykyta.yatsenko5@gmail.com> <20a5f48ff07d02da2f51aaa815a0943078c87655.camel@gmail.com>
In-Reply-To: <20a5f48ff07d02da2f51aaa815a0943078c87655.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 26 Jun 2025 10:40:34 -0700
X-Gm-Features: Ac12FXymUnbPqgpmaJQovd4pe8sz985vQRjr21r2hcY3S8zipP3x6qAjqKlsQLE
Message-ID: <CAEf4BzbcwGwVLoNfMdGX8RfxXqf1+Tyo4Bp8NoU3L4zRtmrFCQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 2/3] selftests/bpf: support array presets in veristat
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2025 at 2:46=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Wed, 2025-06-25 at 17:59 +0100, Mykyta Yatsenko wrote:
> > From: Mykyta Yatsenko <yatsenko@meta.com>
> >
> > Implement support for presetting values for array elements in veristat.
> > For example:
> > ```
> > sudo ./veristat set_global_vars.bpf.o -G "arr[3] =3D 1"
> > ```
> > Arrays of structures and structure of arrays work, but each individual
> > scalar value has to be set separately: `foo[1].bar[2] =3D value`.
> >
> > Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> > ---
>
> This looks great, I have a few minor nits but let's land this patch-set.
> Maybe fix error reporting below as a follow-up.
> New array offset computation logic is much simpler to grasp.
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>

Applied to bpf-next as is. Mykyta, please send a quick follow up
addressing Eduard's suggestions, and let's cut a new veristat release
on Github after that. Thanks!

> ---
>
> Nit: this signals an error:
>
>         $ ./veristat -G "   arr[   fff  ]      =3D 1" set_global_vars.bpf=
.o
>         Processing 'set_global_vars.bpf.o'...
>         Can't resolve enum value fff
>         Failed to set global variables -3
>         Failed to process 'set_global_vars.bpf.o': -3
>
>      but this does not:
>
>         $ ./veristat -G "   arr[   11111111111111111111111111111  ]      =
=3D 1" set_global_vars.bpf.o
>         Failed to parse value '11111111111111111111111111111'
>         Processing 'set_global_vars.bpf.o'...
>         File                   Program           Verdict  Duration (us)  =
Insns  States  Program size  Jited size
>         ---------------------  ----------------  -------  -------------  =
-----  ------  ------------  ----------
>         set_global_vars.bpf.o  test_set_globals  success             27  =
   64       0            82           0
>         ---------------------  ----------------  -------  -------------  =
-----  ------  ------------  ----------
>         Done. Processed 1 files, 0 programs. Skipped 1 files, 0 programs.
>
>

[...]

