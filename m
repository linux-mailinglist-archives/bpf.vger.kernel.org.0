Return-Path: <bpf+bounces-56018-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28147A8AD62
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 03:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B004D3B4CEF
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 01:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6F12063D8;
	Wed, 16 Apr 2025 01:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gx8bp6/Q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4981DA31F;
	Wed, 16 Apr 2025 01:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744765714; cv=none; b=EIb4Q/ZAEz4HZ/TJTs5A8olQ9zRTyoJ1f9bT6ff5R0WPDou6uiTkVL3GH/CwB+YJHvTAs7qGZWrGji55bgkoEKhKxEQ8kkO0TWJooUrlcWtOXFHvmZPI/8m24wr8jph2sOfFj6vw37VFBGmQ+GfbJmNEZntLYdcjNwwcg4G0r4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744765714; c=relaxed/simple;
	bh=24Pj5QnVkkLGfnJr0G5AfJt9DVnlfVPreKS2E55Q0Eo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sjd2vSF+4X1MR6nnFI4cdU5mNkWa3IxlQwXuJQZrcF6P3LDFsKnFE3G5mNR8H8fxcWjaXgN3okDX7VUkj1l3W28oyw4N/3OhU+eJMop6sCWmYiL/MmGkrxHg3X1PUuuirDhGE2JEEJyrhDClkl9Iu7ynq2fDuV+RXPhvob0i3zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gx8bp6/Q; arc=none smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-6f6ca9a3425so73139727b3.2;
        Tue, 15 Apr 2025 18:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744765711; x=1745370511; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nae8iA9Q44bLOPIklEeda/m4+BCHuPMc/pHieS0xpfQ=;
        b=Gx8bp6/QMJPBH+3bbM4rXpV8wp+gI0HJbjQ8u2vsxX0yuwHMfNzLcqDo/up84Llord
         p6imXBAdLyNmWTrZXrrVQVp6XdSbb+FxJRcvxYvj/ss1qfbWu0ZkEEWwZ7J2YzMNylrx
         Fgj+VUMXj/XzewdtNCkFzBCjuLN2lOufcao8AyKdJEfcZfba1Ugl9FMGS+f5mEVqnFaf
         5uVen5BFXhxH+qfv14cjDPI9aYGpjytFWG/KryYEK2EoMTwFk7asOZmfLvlkbNfuC9MC
         HhWNBHwPSJS1GQtshKcuU5fEkUrqT85qNav0phfOJvZmDdTdoyp48Kzh9LZYslau3Wsi
         8Nhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744765711; x=1745370511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nae8iA9Q44bLOPIklEeda/m4+BCHuPMc/pHieS0xpfQ=;
        b=mUMHwSE2TWJwB3koR2f4vwiVbZRiqLkQaXNHhVUCRN4TLaBJ4lDAPYlIq//OF7FBKD
         bWFb52RH9v6mrg4zxOBcR7GrhvG2sw1/+Pta044viLl1AdcYJoQc3lJcZbdkx4ANYzBw
         w1KVKEn55YJ7LiCBQH0GPNGyP2RmFF8ccqQyFNLLn+DMtGiAemfNosMPv5KNHiR9AU/X
         g6eHOg/JQJdOt8jU4XL8Ds/Y+8YK8AvHeZ8mvF2lQjf/Sy+HoiSNKruarPVKiiqFJI/y
         8GvZoNXL+RIBzL1KfQrnQTrIKws67PZGyvrzAzPjNy7hQf/fB4WLUAfbnTZ/cBbXN1DI
         j2Ag==
X-Forwarded-Encrypted: i=1; AJvYcCUciDjY3kM08AtSNpkewYTocjRpxT+PmYpBlVrISNeHC0VsQAlfPfvv8N4+vxkGUQeh1NNcj8zhBzmSBmUT@vger.kernel.org, AJvYcCWbnflrfeUs57lLKB0mYR+p29sA7y0CQUNefA+EYma/62UN62WDkwabaZpNG5i0FLX3Ix+a80bdBvq/K3fcwpUX7TlM@vger.kernel.org, AJvYcCXFsksgehe579tQXkm0bkxmitRpLQwMYgPbTdRPEEjsDu3Tps9lZehhiSElRoDv8IqIQ6M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp2VBMBjsi47Jn6VRHXwXulrePbIm6u7VHD2klojuSNkFNHfz5
	Ef9DxMTAbbn2sSc53zXQPtutZ+QyNEhJwET5R5wCAvywSbvu5R/Cekj3B0Ed0xSJ6DJlTLMj7WM
	9Rs4B8ZtlMWu17SQOOSnJtV1o6E0=
X-Gm-Gg: ASbGncvY7WQaPn6cZrwUQqcOqAlwQQqLsyONrcrrBMwyY8TtKI5pO0DbGecy6R4pRUK
	z2eGBwiGxw5qHqRwmrd3G/JZ9Kawkcvm9rnyAFEWa2Cf4sfCb41/SDKUHH789yHK/2OHsCUWbxk
	Sy6G+esgHzckttULq84XC7fA==
X-Google-Smtp-Source: AGHT+IErozDlBEtdi3kw+kK2RMiMLcVJupyXpukTsMbcRfzHTw8qXYapvuK6UCyQRpv5sk9NgzQQexQH7kAbCBffMJQ=
X-Received: by 2002:a05:690c:6009:b0:6f9:af1f:fdd0 with SMTP id
 00721157ae682-706ad1d8a76mr23158377b3.31.1744765710804; Tue, 15 Apr 2025
 18:08:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250413014444.36724-1-dongml2@chinatelecom.cn>
 <20250414160528.3fd76062ad194bdffff515b5@kernel.org> <CAEf4BzbyqNAPrOR7cR+2PKCy+cXoEftWufFbhMv73QPFZM+ysw@mail.gmail.com>
In-Reply-To: <CAEf4BzbyqNAPrOR7cR+2PKCy+cXoEftWufFbhMv73QPFZM+ysw@mail.gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Wed, 16 Apr 2025 09:06:14 +0800
X-Gm-Features: ATxdqUH3BxeiuPSItNg15YgITrPiruh7-ARebQqerIosErclXgD5_4u5RLQsuuI
Message-ID: <CADxym3a2sr-CB=G-ryew+LV3tcbZ1EZ6kzbAPDyQmV=xbaF4bQ@mail.gmail.com>
Subject: Re: [PATCH bpf v2] ftrace: fix incorrect hash size in register_ftrace_direct()
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, rostedt@goodmis.org, mark.rutland@arm.com, 
	mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Menglong Dong <dongml2@chinatelecom.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 7:14=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Apr 14, 2025 at 12:05=E2=80=AFAM Masami Hiramatsu <mhiramat@kerne=
l.org> wrote:
> >
> > On Sun, 13 Apr 2025 09:44:44 +0800
> > Menglong Dong <menglong8.dong@gmail.com> wrote:
> >
> > > The maximum of the ftrace hash bits is made fls(32) in
> > > register_ftrace_direct(), which seems illogical. So, we fix it by mak=
ing
> > > the max hash bits FTRACE_HASH_MAX_BITS instead.
> > >
> >
> > Loogs good to me.
> >
> > Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> >
> > Thanks!
> >
>
> I'm a bit confused by the "[PATCH bpf]" prefix... This fix doesn't
> seem to be BPF-related, so I'm not sure why it would go through the
> bpf tree. I presume Masami or Steven will route it through their tree,
> is that right?
>

Sorry about the confusing......I throught the register_ftrace_direct()
is mainly used by BPF, and it should go to the ftrace tree :/

Thanks!
Menglong Dong

>
> > > Fixes: d05cb470663a ("ftrace: Fix modification of direct_function has=
h while in use")
> > > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > > ---
> > > v2:
> > > - thanks for Steven's advice, we fix the problem by making the max ha=
sh
> > >   bits FTRACE_HASH_MAX_BITS instead.
> > > ---
> > >  kernel/trace/ftrace.c | 7 ++++---
> > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> > > index 1a48aedb5255..d153ad13e0e0 100644
> > > --- a/kernel/trace/ftrace.c
> > > +++ b/kernel/trace/ftrace.c
> > > @@ -5914,9 +5914,10 @@ int register_ftrace_direct(struct ftrace_ops *=
ops, unsigned long addr)
> > >
> > >       /* Make a copy hash to place the new and the old entries in */
> > >       size =3D hash->count + direct_functions->count;
> > > -     if (size > 32)
> > > -             size =3D 32;
> > > -     new_hash =3D alloc_ftrace_hash(fls(size));
> > > +     size =3D fls(size);
> > > +     if (size > FTRACE_HASH_MAX_BITS)
> > > +             size =3D FTRACE_HASH_MAX_BITS;
> > > +     new_hash =3D alloc_ftrace_hash(size);
> > >       if (!new_hash)
> > >               goto out_unlock;
> > >
> > > --
> > > 2.39.5
> > >
> > >
> >
> >
> > --
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> >

