Return-Path: <bpf+bounces-41197-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDFF9942F5
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 10:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FF201C22DF8
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 08:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF824190477;
	Tue,  8 Oct 2024 08:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHBIHnJ1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F4318C35D;
	Tue,  8 Oct 2024 08:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728377132; cv=none; b=lOB9cIwEIfhT4rth71UIBP7OJLH6DOXebzkdAnQN85McpD74eLo/VyWHIEhXQU0CsGtdHpBfd2tycmvS6zq0g6pQxS0DS5rq6XBDNqjfPwTu+CNpdHPN6r0xWQfiCWdV45dG/gND1IY14ErF/5Sguv7n8E2ig6EGDVXCi/WbFFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728377132; c=relaxed/simple;
	bh=VIHLJ66eE/wavOygB1PuGao6FeCvbE2xkQRb2vPO9G4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m7ot4RH3TO3s329m/U3U7RpXqfX1CogP1Mfe0bg8L2qz/OCNRVVqby2r5/xHTaReOR/3GUXV/MdTyEBdPYYU0nvUCodiSoxvxLdpdwZWYsz+MFBCCuqZGb7l80Ob8hRL5aQLgC5y4tOYwdvApGxXJ5y8ztBt5DMplWDCh1xvGV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SHBIHnJ1; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c8967dd2c7so6662957a12.1;
        Tue, 08 Oct 2024 01:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728377129; x=1728981929; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tjUdOJA4jWMVSrUGgvOSdZl3neMitSFURhlyYwW/SrM=;
        b=SHBIHnJ16+Ya7nr2cce9T1QavDSakrBNsCdthQdESUiB2fkKYGJ3MuyxhNTl1cP7x4
         dK5cGunRTQ0JrpiF0ZM+MnyJm/6FQIFwYFOGLxhitru2Puoq2NGegZrguJ/kLUWpWlut
         jIUsRCozdcI1HMUSEsAJbyk31uCjDBTxY7g2/w+DYHlRiZMr34490FIjZSoXLZKhN8Qy
         P1dDj3qe49Rftj4C37mXO4jLmt++uYuHl0nF8QW9muaiV/LnnwhQiFtqaX1EUn/FdYF0
         IH1K78WZNXEQV1zwNoAUI1XCwYpELMxEN5D0n+LrKNYDYF9v50ZMfS/XNrgWvtrTodfO
         9LlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728377129; x=1728981929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tjUdOJA4jWMVSrUGgvOSdZl3neMitSFURhlyYwW/SrM=;
        b=GdZ++GdrpKl8yZVSQatBsBIOJGG9gy7HZx6B62p4dwhTwxtvm5sFdc6XWMe3CiCB+4
         JF+EIJon5RYBeSLbM5KBqdrXmChFNLOKXOL2h0BfBDnV9pgQnPKpptqJ0eX2+dxfvKfm
         ldzZesnUho5ChFnI6bzGN9qws3V2joYgYUOP3gr7e0yjesIrZInBNYkc8WFBUG4L+1aP
         pdyJL28law1MpNvm0S42uOFbU1Y1AnfHdNp+Q1HWn/hahvbiG+JmEQnXxm4DVpeJxVKL
         xJMpCX4g0LtPL5smbKiQtBfQMwpELdd1766CMenKEvm4kl2cup1Pum3gdkhxxdtFuphT
         dKjw==
X-Forwarded-Encrypted: i=1; AJvYcCVAn02MAJJO11Oj4YItlBX+L1jsS5Q9ElJhhWbnSfi4l62oTyHt+7eXz5atbe7sIS0aT4I=@vger.kernel.org, AJvYcCWIvQ+TYHM0zide9+a7zxZSS1bUxPc0YNXu6WbxHsmYsopwQ2O1RwMjbvKqiiLSoduGKyq48bAAWXWw0ck9@vger.kernel.org
X-Gm-Message-State: AOJu0YwTNmCZTaXNdccmbTOkh+l8unho7o6EAu3IpRDvUcy/cfUKUrkA
	C2hL98fO7l0ombNjF3MqUCAPlyFQJ0YTwAPV0Ob0obxK6gHO+X3C/ffpjEzi9kAIXLYpy+ExSat
	9IYKhelZRTZyzPfHQ5ueT4gxJpMQ=
X-Google-Smtp-Source: AGHT+IEVzwOnSYQA1b2F4OqwlA/gmNlLWqBbX9kmps/lSsu6YEwLy8WGawj/FxMV3YlylFOIka6CG/gYsPqDXcjpFyg=
X-Received: by 2002:a05:6402:5108:b0:5c7:1922:d770 with SMTP id
 4fb4d7f45d1cf-5c8d2d015cfmr10905346a12.6.1728377128325; Tue, 08 Oct 2024
 01:45:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANpmjNOZ4N5mhqWGvEU9zGBxj+jqhG3Q_eM1AbHp0cbSF=HqFw@mail.gmail.com>
 <20241005164813.2475778-1-snovitoll@gmail.com> <20241005164813.2475778-2-snovitoll@gmail.com>
 <ZwTt-Sq5bsovQI5X@elver.google.com>
In-Reply-To: <ZwTt-Sq5bsovQI5X@elver.google.com>
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Date: Tue, 8 Oct 2024 13:46:17 +0500
Message-ID: <CACzwLxh1yWXQZ4LAO3gFMjK8KPDFfNOR6wqWhtXyucJ0+YXurw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm, kasan, kmsan: copy_from/to_kernel_nofault
To: Marco Elver <elver@google.com>
Cc: akpm@linux-foundation.org, andreyknvl@gmail.com, bpf@vger.kernel.org, 
	dvyukov@google.com, glider@google.com, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, ryabinin.a.a@gmail.com, 
	syzbot+61123a5daeb9f7454599@syzkaller.appspotmail.com, 
	vincenzo.frascino@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 1:32=E2=80=AFPM Marco Elver <elver@google.com> wrote=
:
>
> On Sat, Oct 05, 2024 at 09:48PM +0500, Sabyrzhan Tasbolatov wrote:
> > Instrument copy_from_kernel_nofault() with KMSAN for uninitialized kern=
el
> > memory check and copy_to_kernel_nofault() with KASAN, KCSAN to detect
> > the memory corruption.
> >
> > syzbot reported that bpf_probe_read_kernel() kernel helper triggered
> > KASAN report via kasan_check_range() which is not the expected behaviou=
r
> > as copy_from_kernel_nofault() is meant to be a non-faulting helper.
> >
> > Solution is, suggested by Marco Elver, to replace KASAN, KCSAN check in
> > copy_from_kernel_nofault() with KMSAN detection of copying uninitilaize=
d
> > kernel memory. In copy_to_kernel_nofault() we can retain
> > instrument_write() for the memory corruption instrumentation but before
> > pagefault_disable().
>
> I don't understand why it has to be before the whole copy i.e. before
> pagefault_disable()?
>

I was unsure about this decision as well - I should've waited for your resp=
onse
before sending the PATCH when I was asking for clarification. Sorry
for the confusion,
I thought that what you meant as the instrumentation was already done after
pagefault_disable().

Let me send the v3 with your suggested diff, I will also ask Andrew to drop
merged to -mm patch.
https://lore.kernel.org/all/20241008020150.4795AC4CEC6@smtp.kernel.org/

Thanks for the review.

> I think my suggestion was to only check the memory where no fault
> occurred. See below.
>
> > diff --git a/mm/maccess.c b/mm/maccess.c
> > index 518a25667323..a91a39a56cfd 100644
> > --- a/mm/maccess.c
> > +++ b/mm/maccess.c
> > @@ -15,7 +15,7 @@ bool __weak copy_from_kernel_nofault_allowed(const vo=
id *unsafe_src,
> >
> >  #define copy_from_kernel_nofault_loop(dst, src, len, type, err_label) =
       \
> >       while (len >=3D sizeof(type)) {                                  =
 \
> > -             __get_kernel_nofault(dst, src, type, err_label);         =
       \
> > +             __get_kernel_nofault(dst, src, type, err_label);        \
> >               dst +=3D sizeof(type);                                   =
 \
> >               src +=3D sizeof(type);                                   =
 \
> >               len -=3D sizeof(type);                                   =
 \
> > @@ -31,6 +31,8 @@ long copy_from_kernel_nofault(void *dst, const void *=
src, size_t size)
> >       if (!copy_from_kernel_nofault_allowed(src, size))
> >               return -ERANGE;
> >
> > +     /* Make sure uninitialized kernel memory isn't copied. */
> > +     kmsan_check_memory(src, size);
> >       pagefault_disable();
> >       if (!(align & 7))
> >               copy_from_kernel_nofault_loop(dst, src, size, u64, Efault=
);
> > @@ -49,7 +51,7 @@ EXPORT_SYMBOL_GPL(copy_from_kernel_nofault);
> >
> >  #define copy_to_kernel_nofault_loop(dst, src, len, type, err_label)  \
> >       while (len >=3D sizeof(type)) {                                  =
 \
> > -             __put_kernel_nofault(dst, src, type, err_label);         =
       \
> > +             __put_kernel_nofault(dst, src, type, err_label);        \
> >               dst +=3D sizeof(type);                                   =
 \
> >               src +=3D sizeof(type);                                   =
 \
> >               len -=3D sizeof(type);                                   =
 \
> > @@ -62,6 +64,7 @@ long copy_to_kernel_nofault(void *dst, const void *sr=
c, size_t size)
> >       if (!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS))
> >               align =3D (unsigned long)dst | (unsigned long)src;
> >
> > +     instrument_write(dst, size);
> >       pagefault_disable();
>
> So this will check the whole range before the access. But if the copy
> aborts because of a fault, then we may still end up with false
> positives.
>
> Why not something like the below - normally we check the accesses
> before, but these are debug kernels anyway, so I see no harm in making
> an exception in this case and checking the memory if there was no fault
> i.e. it didn't jump to err_label yet. It's also slower because of
> repeated calls, but these helpers aren't frequently used.
>
> The alternative is to do the sanitizer check after the entire copy if we
> know there was no fault at all. But that may still hide real bugs if
> e.g. it starts copying some partial memory and then accesses an
> unfaulted page.
>
>
> diff --git a/mm/maccess.c b/mm/maccess.c
> index a91a39a56cfd..3ca55ec63a6a 100644
> --- a/mm/maccess.c
> +++ b/mm/maccess.c
> @@ -13,9 +13,14 @@ bool __weak copy_from_kernel_nofault_allowed(const voi=
d *unsafe_src,
>         return true;
>  }
>
> +/*
> + * The below only uses kmsan_check_memory() to ensure uninitialized kern=
el
> + * memory isn't leaked.
> + */
>  #define copy_from_kernel_nofault_loop(dst, src, len, type, err_label)  \
>         while (len >=3D sizeof(type)) {                                  =
 \
>                 __get_kernel_nofault(dst, src, type, err_label);        \
> +               kmsan_check_memory(src, sizeof(type));                  \
>                 dst +=3D sizeof(type);                                   =
 \
>                 src +=3D sizeof(type);                                   =
 \
>                 len -=3D sizeof(type);                                   =
 \
> @@ -31,8 +36,6 @@ long copy_from_kernel_nofault(void *dst, const void *sr=
c, size_t size)
>         if (!copy_from_kernel_nofault_allowed(src, size))
>                 return -ERANGE;
>
> -       /* Make sure uninitialized kernel memory isn't copied. */
> -       kmsan_check_memory(src, size);
>         pagefault_disable();
>         if (!(align & 7))
>                 copy_from_kernel_nofault_loop(dst, src, size, u64, Efault=
);
> @@ -52,6 +55,7 @@ EXPORT_SYMBOL_GPL(copy_from_kernel_nofault);
>  #define copy_to_kernel_nofault_loop(dst, src, len, type, err_label)    \
>         while (len >=3D sizeof(type)) {                                  =
 \
>                 __put_kernel_nofault(dst, src, type, err_label);        \
> +               instrument_write(dst, sizeof(type));                    \
>                 dst +=3D sizeof(type);                                   =
 \
>                 src +=3D sizeof(type);                                   =
 \
>                 len -=3D sizeof(type);                                   =
 \
> @@ -64,7 +68,6 @@ long copy_to_kernel_nofault(void *dst, const void *src,=
 size_t size)
>         if (!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS))
>                 align =3D (unsigned long)dst | (unsigned long)src;
>
> -       instrument_write(dst, size);
>         pagefault_disable();
>         if (!(align & 7))
>                 copy_to_kernel_nofault_loop(dst, src, size, u64, Efault);

