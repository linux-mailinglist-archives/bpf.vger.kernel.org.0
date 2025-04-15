Return-Path: <bpf+bounces-56013-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A9EA8ABEE
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 01:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD84D441603
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 23:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5A62D8DAA;
	Tue, 15 Apr 2025 23:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFMAlPjP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E62F2D8DA0;
	Tue, 15 Apr 2025 23:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744758856; cv=none; b=FtqaWqDmQPqtMs/+ZrtKCmL9x5JVqzdLfsKZiOoVE1fl//Pf4OSxT5nlayMsNZCEC1wvcnyK7e/zDQ/u+JUWmTh6YcsGuwCWda4y2q9ES7fh6jR8D5/mcVxXKmITP9rR+AUkS0NPjPv6PFwu/m6Zx8W+eANH0VgM/Y89qQh1DN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744758856; c=relaxed/simple;
	bh=zCpIDGFs2MI6JDqwoAKjdYAM75z0bLJsxlg2XtGnRx0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gzx48lhzncuSRl0ZXH1ppoTpdRc2fsVYYVF3v6TxNyiVu+wOmSzaSBZx2jcODcdGoB4bYkwSsBoClVmfCHS1JBZ+TqqC3nZ5xW1iM6Bth3oypEgazJh8T//0EQsJf4bu2wFW5WmHzCgIIZ0bJUuLa1j8zUTs5fIU0odNRbJqwtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dFMAlPjP; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-301d6cbbd5bso6236432a91.3;
        Tue, 15 Apr 2025 16:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744758854; x=1745363654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PRKGyTCLCkh+hncjT8M1rmbcW8JfhBSDz6kNDmOfBHI=;
        b=dFMAlPjP3IC+txSIvnYG5qLBjgC8Ghd2xVJhIRd/l46FNmwqOIKYQxHLxUUZ49FKTm
         nRc51SeusJQkGELfjhcdhER2YwuyDxd2lovqf5bDlvGlDBzcFjj+/Zvi9fcFsON8rHGV
         3TjV2BptrmBUJP5mIBZawJQXNLeB2Mua4wsXgEyITIe27EFT6pgKnYp+igOJ43f41YAd
         7P1W8SP2visVLLdsGaDqC0JX/rsiFp9F2W9r8kybyz1mziAdv8BTnL2C5n6OfBw6T2/8
         Mjcff+G0BxsMo9zrT5nNMsUOBxA/h952+4yy93YfvaE1EX9BlvTvU9VuTO19x5o6tVV3
         wqSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744758854; x=1745363654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PRKGyTCLCkh+hncjT8M1rmbcW8JfhBSDz6kNDmOfBHI=;
        b=pYyQcWUC+QDt5ky5QY01FBf+Kt9DbyoyliUacL6MfOsbPR/MSs8cgmZH3NVLWBCd3H
         nLRqKEwIv+irFabwh8FSVdY+6aAR+gPoKLqD7a4F6wpaCEm6VtW6mzv+yf/pUCs9kway
         rOYLLDP6HCafMvc2k1mCuAHdD1FqS+MnLdbj6ImXvUT2nxNTICIvxh/sZmmV1TQHDZra
         7EcZ7pZQOHaEqi1TyyH/nqq+2ZXuEkWWTBY/gUTYsLKH7EXzzMU7o2btx54rb2d/24DO
         Ic2MS84pYvGa+e/gBlz9XCUspRrTmXotnz9iKSk9FJrJcTpp/+XOww7R4AdhS31RAVfI
         iQ2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUVjPF02a70KPsiYxt2xGA3u5PBEFYGOjU2U9M5r2CxfMx3b2NYk1EIGLzmYR/WSE1EPY4LCE1WzXUHsspZ@vger.kernel.org, AJvYcCUfQrZvMnKFPlHtKHW6AdhYOA/ipdJg6QW8TxhHN5rxFZ1EO/zkedMGutFc4tZKtb4KYTI=@vger.kernel.org, AJvYcCWO8hYGGRlxlyHuX3ERi5NBJMVIKBeD0PHrmtC/PgjBo2H3RiG4d4YR+xr5ti1Xs5B0/SiO2tr3tTAFX8MclfAvtdWh@vger.kernel.org
X-Gm-Message-State: AOJu0YxlUDDiTg9an/yxiSWO03Kxs+duQxjXz+1uGjFeakwzNUJnkdmA
	yTgoDYlFe6P2jclR/V0MJ9eAb0j12EuCtO9Zk6jZIEkp2dlRfQCvoNzxZ4RbN/wHiMv0x1ty3LR
	yn2RVqvy/9SXgdK7LThY8boGjYS/Pqg==
X-Gm-Gg: ASbGncvhKVzFTgnYx9BzBLLgUXfQI0AIjZME6tXnr/RHcIpF4VY6Oq5c+4aXAtz8OMq
	uRq8Qh9zGJfSu8BeZdTgmZ2c2TK9jpjQiBm2Q2QUCFN1bgVVvYz+1teF2U9EHG+aAfMj1l6KfcA
	1ArzdmmH1f8n+Se9OikUa31EnOT9gvgXWoC6/jXA==
X-Google-Smtp-Source: AGHT+IFZfWmP8O8dyWubwAzXvc5NO6Xm7sJPqAU2vM5adnZ9hKvqzRlxDmYr31KsnnAkgi+t+pW2vCnDknhLhrWoXyk=
X-Received: by 2002:a17:90b:2b45:b0:2f8:49ad:4079 with SMTP id
 98e67ed59e1d1-3085ee96ca6mr1354317a91.6.1744758853747; Tue, 15 Apr 2025
 16:14:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250413014444.36724-1-dongml2@chinatelecom.cn> <20250414160528.3fd76062ad194bdffff515b5@kernel.org>
In-Reply-To: <20250414160528.3fd76062ad194bdffff515b5@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 15 Apr 2025 16:14:01 -0700
X-Gm-Features: ATxdqUERe79cDUWqxs-YYWqHkNaH3OT9MoqFhzb9dJh8p3Rnu2DrlpQQVxahrVc
Message-ID: <CAEf4BzbyqNAPrOR7cR+2PKCy+cXoEftWufFbhMv73QPFZM+ysw@mail.gmail.com>
Subject: Re: [PATCH bpf v2] ftrace: fix incorrect hash size in register_ftrace_direct()
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Menglong Dong <menglong8.dong@gmail.com>, rostedt@goodmis.org, mark.rutland@arm.com, 
	mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Menglong Dong <dongml2@chinatelecom.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2025 at 12:05=E2=80=AFAM Masami Hiramatsu <mhiramat@kernel.=
org> wrote:
>
> On Sun, 13 Apr 2025 09:44:44 +0800
> Menglong Dong <menglong8.dong@gmail.com> wrote:
>
> > The maximum of the ftrace hash bits is made fls(32) in
> > register_ftrace_direct(), which seems illogical. So, we fix it by makin=
g
> > the max hash bits FTRACE_HASH_MAX_BITS instead.
> >
>
> Loogs good to me.
>
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
> Thanks!
>

I'm a bit confused by the "[PATCH bpf]" prefix... This fix doesn't
seem to be BPF-related, so I'm not sure why it would go through the
bpf tree. I presume Masami or Steven will route it through their tree,
is that right?


> > Fixes: d05cb470663a ("ftrace: Fix modification of direct_function hash =
while in use")
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > ---
> > v2:
> > - thanks for Steven's advice, we fix the problem by making the max hash
> >   bits FTRACE_HASH_MAX_BITS instead.
> > ---
> >  kernel/trace/ftrace.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> > index 1a48aedb5255..d153ad13e0e0 100644
> > --- a/kernel/trace/ftrace.c
> > +++ b/kernel/trace/ftrace.c
> > @@ -5914,9 +5914,10 @@ int register_ftrace_direct(struct ftrace_ops *op=
s, unsigned long addr)
> >
> >       /* Make a copy hash to place the new and the old entries in */
> >       size =3D hash->count + direct_functions->count;
> > -     if (size > 32)
> > -             size =3D 32;
> > -     new_hash =3D alloc_ftrace_hash(fls(size));
> > +     size =3D fls(size);
> > +     if (size > FTRACE_HASH_MAX_BITS)
> > +             size =3D FTRACE_HASH_MAX_BITS;
> > +     new_hash =3D alloc_ftrace_hash(size);
> >       if (!new_hash)
> >               goto out_unlock;
> >
> > --
> > 2.39.5
> >
> >
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
>

