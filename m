Return-Path: <bpf+bounces-70217-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D17CBB4A0F
	for <lists+bpf@lfdr.de>; Thu, 02 Oct 2025 19:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C7391735D2
	for <lists+bpf@lfdr.de>; Thu,  2 Oct 2025 17:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A50C22758F;
	Thu,  2 Oct 2025 17:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UDxYN0Zg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F70E26CE3B
	for <bpf@vger.kernel.org>; Thu,  2 Oct 2025 17:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759425152; cv=none; b=jZW/SEo9KKAHrHuQ8hwRSET2fckvkEr9fq/h6Xeg8YAW9BKJzctO1oXeEQ7/W3k/Y7slf0DQ0VVuMvyKsPMBghhJhZKKPos7MJfjn/LfZ9B4DxB0/6ldtKGhuILTOTeqqqzNhEKKjQj9X9ARTMDlSPwsTROCwOE00+hdjqcTlbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759425152; c=relaxed/simple;
	bh=Vs3Od78lsWY3eVAuifJD7IXnTuiSOYqocBICozC/gbE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qIQJ8i/cqI9CIgHdAjl0CRq0Fg8qo2Q/1gwFEV2AzDEqIQswXgLM2lKhOAElec9hV240lHLPd4XsEOZgEPyGG5VbrvQeqiE6I2c/cAXgPDRZGja8vNux+NypkR1fBPybu7yHjbTHgKYsurpqxQVuCL9NR47V6YUQ/sObOVz/ssk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UDxYN0Zg; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46e52279279so9266075e9.3
        for <bpf@vger.kernel.org>; Thu, 02 Oct 2025 10:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759425147; x=1760029947; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XjVO/8J6cwZWczHY1sJ+Xbg1pNEa0jeZoI5ktypxapw=;
        b=UDxYN0ZgVT+RNK0VZhYbwqpaM1e9lo7G2UOhYbat+0T8zVxVnN/6fdIcZ0etHRsqbg
         lT4NxLa1ffqCawVN8+xvVVNuIjXGW+rSFc30Uk6EGYSgjQDtG0oGwRC8GZj1gzYVK1zx
         YkMQeWE47wYMGChUUW52X6X/TP8coD+O9tqYxhowjybgfo+3PW+qykggIoeeuAW4f/40
         248jvKdPH4Nkkz8aXiPn4AoG95gETJqm7tXOLRKby1pXz+Qviw6kSn4lzpOTazc+RHW2
         FYJ0t+iUHvrQaSt5It27I/1budNADjlB6qYGRFxTUQRw66zCHwgAfpoorxF2/racsHEH
         SHzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759425147; x=1760029947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XjVO/8J6cwZWczHY1sJ+Xbg1pNEa0jeZoI5ktypxapw=;
        b=NZfdbp99rzzZI3QW/2i1nq8Mf683xRlYH6KRk5RCNfM6WFSESXGtZ5UplTGe0MbQDN
         90PBHkSsAAA6nkm9Sr19VzOKqDvZSuBJPNhEHsc9a4kPeq0w4jGy7jgS46aEbWLVdnUJ
         3j66kao8PlE+PYT5RdD2FdTt63+5AY3MGXP7FXuQStdqQ2TjyIJEWCNIBGtdt/7IV7tO
         2/Y2ySrMGyNRvCvvZNWRrxVvJbeWwN4TkBwAP6UbAPZLFNYgk4gP6d/Tz5mc5gaBThGg
         y0JNZSii/CduKXmK1caCoQgzKaLzGjwVqAZotkNSDbMoetg+9uFaSkKyO3CBe3Azx+l3
         uJtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdDqEX3m30llIbz29M212tkrL9Egd3qZ35Ooi17Bjxt6ua1TPZ9wZ6xD98pjmUL47f1dI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNEZ5IH5lcpPsq0Kv36/j77aRGR63uaTadk7eAaFa6SugQFx5E
	mW/Whi89H8MOG+f98bnXB5ESERa99ioxQ8U495UC69GCMZoHTGf9Imnwb2f+fTK7QTJPYsB48Y/
	NSejURU8wtp0RgJ99LsW3y0tzkmxg5X4=
X-Gm-Gg: ASbGncs+FKLzqcc98qT50v36u5rK1Znd4Tmq8lwdj0jJMrI3eyz34xYn+iCKYGnHLdS
	fG8AIi0JpJihxN5t12z279FuYwhtGVpuDarnhngpEIrBE3pDYElEikJX4GNTH/XoV8y1GGQQKTH
	HT26oFaNHm42/+xOg21BdsJ6uuE5Mt8KwnKJy1mJIbhG53EO8wU5LfpZtkOAYXhgdKjWHDtgU/L
	q4p1SDyR1RJPwZvy6ilMcwmQSHmoEp+ASfPyqX/2C2LJUbzuQNXdbRuJQ==
X-Google-Smtp-Source: AGHT+IFFlAPEENjXsjwK7bYP+KO48yG0A6g+1HtPLd84tk/Vz6QU9fm/nAqB6Q/bimjlcjZtqjdjdWNinzemU/d2SzI=
X-Received: by 2002:a05:600c:8b01:b0:46e:59f8:8546 with SMTP id
 5b1f17b1804b1-46e71140bf4mr224205e9.17.1759425147356; Thu, 02 Oct 2025
 10:12:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929194648.145585-1-ebiggers@kernel.org> <CAADnVQKKQEjZjz21e_639XkttoT4NvXYxUb8oTQ4X7hZKYLduQ@mail.gmail.com>
 <20251001233304.GB2760@quark>
In-Reply-To: <20251001233304.GB2760@quark>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 2 Oct 2025 10:12:12 -0700
X-Gm-Features: AS18NWDHorhHHJaEuzPLLApApsbU6t0qJWlskRVAJzEXEEmEQhmHrh4_H7WjqmE
Message-ID: <CAADnVQL=zs-n1s-0emSuDmpfnU7QzMFo+92D3b4tqa3sG+uiQw@mail.gmail.com>
Subject: Re: [PATCH iproute2-next v2] lib/bpf_legacy: Use userspace SHA-1 code
 instead of AF_ALG
To: Eric Biggers <ebiggers@kernel.org>
Cc: Network Development <netdev@vger.kernel.org>, Stephen Hemminger <stephen@networkplumber.org>, 
	bpf <bpf@vger.kernel.org>, 
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 4:33=E2=80=AFPM Eric Biggers <ebiggers@kernel.org> w=
rote:
>
> On Wed, Oct 01, 2025 at 03:59:31PM -0700, Alexei Starovoitov wrote:
> > On Mon, Sep 29, 2025 at 12:48=E2=80=AFPM Eric Biggers <ebiggers@kernel.=
org> wrote:
> > >
> > > Add a basic SHA-1 implementation to lib/, and make lib/bpf_legacy.c u=
se
> > > it to calculate SHA-1 digests instead of the previous AF_ALG-based co=
de.
> > >
> > > This eliminates the dependency on AF_ALG, specifically the kernel con=
fig
> > > options CONFIG_CRYPTO_USER_API_HASH and CONFIG_CRYPTO_SHA1.
> > >
> > > Over the years AF_ALG has been very problematic, and it is also not
> > > supported on all kernels.  Escalating to the kernel's privileged
> > > execution context merely to calculate software algorithms, which can =
be
> > > done in userspace instead, is not something that should have ever bee=
n
> > > supported.  Even on kernels that support it, the syscall overhead of
> > > AF_ALG means that it is often slower than userspace code.
> >
> > Help me understand the crusade against AF_ALG.
> > Do you want to deprecate AF_ALG altogether or when it's used for
> > sha-s like sha1 and sha256 ?
>
> Altogether, when possible.  AF_ALG has been (and continues to be)
> incredibly problematic, for both security and maintainability.

Could you provide an example of a security issue with AF_ALG ?
Not challenging the statement. Mainly curious what is going
to understand it better and pass the message.

> > I thought the main advantage of going through the kernel is that
> > the kernel might have an optimized implementation for a specific
> > architecture, while the open coded C version is generic.
> > The cost of syscall and copies in/out is small compared
> > to actual math, especially since compilers might not be smart enough
> > to use single asm insn for rol32() C function.
>
> Not for small amounts of data, since syscalls are expensive these days.
>
> (Aren't BPF programs usually fairly small?)

Depends on the definition of small :)
The largest we have in production is 620kbytes of ELF.
Couple dozens between 100k to 400k.
And a hundred between 5k to 50k.

>
> BTW, both gcc and clang reliably lower rol32() to a single instruction.
>
> > sha1/256 are simple enough in plain C, but other crypto/hash
> > could be complex and the kernel may have HW acceleration for them.
> > CONFIG_CRYPTO_USER_API_HASH has been there forever and plenty
> > of projects have code to use that. Like qemu, stress-ng, ruby.
> > python and rust have standard binding for af_alg too.
> > If the kernel has optimized and/or hw accelerated crypto, I see an appe=
al
> > to alway use AF_ALG when it's available.
>
> Well, userspace programs that want accelerated crypto routines without
> incorporating them themselves should just use a userspace library that
> has them.  It's not hard.
>
> But iproute2 should be fine with just the generic C code.
>
> As for why AF_ALG support keeps showing up in different programs, it's
> mainly just a misunderstanding.  But I think you're also overestimating
> how often it's used.  Your 5 examples were 4 bindings (not users), and 1
> user where it's disabled by default.
>
> There are Linux systems where it's only iproute2 that's blocking
> CONFIG_CRYPTO_USER_API_HASH from being disabled.  This patch is really
> valuable on such systems.

Fair enough.

