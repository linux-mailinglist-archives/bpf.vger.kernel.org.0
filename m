Return-Path: <bpf+bounces-70171-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB450BB207C
	for <lists+bpf@lfdr.de>; Thu, 02 Oct 2025 01:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34BFF19279C5
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 23:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1E131326C;
	Wed,  1 Oct 2025 22:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ekLhcHnG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657CC3128CF
	for <bpf@vger.kernel.org>; Wed,  1 Oct 2025 22:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759359586; cv=none; b=CkSd6HE7effwkb5UaBh/GPKTbO8Z0ArdPxU2Ttt98xaB6PkOT7+ys+rhYS0hPtUHJ1F1OoKVF2hVtYAN18jxERxngdmA7jvZiS24CLcYGaZ4Kl8tp3cc0S8obyLNWv+6VTVqujaujD3v2nBQe6qkWDgE/y0GPsd7VNo6UkXAXIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759359586; c=relaxed/simple;
	bh=/jEZePi63ifb7LawHxT3yfaud/22p+YbYH+kfCQsEVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e/h+53ihYzA02UnCtnZ+TplnHJGHicWiinKLELTHCODJZoBZE6sFHsXmSTQqkMnlgfW6ZJtjELf3kzjHVw2YwHmij8ZUnYPzFMHVdyZsZ+Kh+yRsO1m1inlB/z4S9uG9BCDvYELvJfVywmOJZ9prD5cOGVp2ATt8sy6n6qaHjwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ekLhcHnG; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-46e326e4e99so8394325e9.1
        for <bpf@vger.kernel.org>; Wed, 01 Oct 2025 15:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759359583; x=1759964383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I2LJjpzKHNhkNbLIhRR6OhIR28zGFHZ3AsWw8V3scZQ=;
        b=ekLhcHnGgRaFHZPl+8I7CNhiukr6E77fHqYw6yBYvktrkZjIp6Eo7+zMaNHy+nDuUh
         1mocxv7sRgM+nZshpSXYbQgZ/HsTjAfJHrsDSN2yq8e81U8jyIdVSkXvmJsKL7h1S3MV
         zdT7BCmG+hAsa2HbXnJtcX0a9HCoxlz0mXh6STsOY79IahfWfSIv4oofaPUmCbdYeHir
         K+GO3vJ5w5Jrx1Py7Br0wAN/pHTPp4csiBO9PfQNsXXJ+M9h1RB3RppYBZdHkamuxQ1r
         G7bsW3OR+/VqWoaBvkb3vPjWGCCiFP1+I7/GLj125sOHmKMyvOr8KYU9/rGqjogWSJ5z
         CWFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759359583; x=1759964383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I2LJjpzKHNhkNbLIhRR6OhIR28zGFHZ3AsWw8V3scZQ=;
        b=PlwUy2iAfQzcBiHv5+5TdoYPrIvDTnYKSFU5G6PeZzcv7K2EszaW0rFhlwXGJmmRpv
         P5/XyDqHxVMxdZlA55fYJputrAzUw9aC39KtjUcr9DHcJxgjtmemOVnf5wNWPSdbGC0F
         IbrlrOx9x3OjA738XfKYhBbx9vS2Zo8bmuSm2kqkLykUC2dugCP3ZEz/DkIkErPxycUQ
         9gzJkE5V/FfAY4d+VfsZouNTDh7LZqT/5Z3F3GiETvSjSxx5Xz7+LryjIesZ8lqdl5h+
         M2AbBbhsYoy3eupflA2dEFEgNEwik6DbGblLc7eZtYHPSlgCEV5BWxdkV6D9z+RGbwOQ
         nXmA==
X-Forwarded-Encrypted: i=1; AJvYcCWnjYNpY48zmcSSBdH0rv+ZcbomLM28O24jEQmJW7YBPWDqRGiHZOrQCC/mYOf3LCrjEH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdaBi8V246Btl5M06PCma/oM3/GcXKIFOVIYUBev9ZeMIPaYR5
	8hZNILKLEZbbDAuXaOPhPrkfeIyCWSXoYCFmhiIeuT/UpKVW/9gZuxCtG9iJwMEDsatGSOZIv5Y
	WWyuYJPAGdumLGXzXwmwlANrxO3HKWq8=
X-Gm-Gg: ASbGncsLzRhwSGozs7uF5mdYHG5ZoLEIFcu6/aKJM2rcvcVHL463hpsytGlY3aY0le5
	KcnIxuolErQN7MQjRcxT8e07SIHPsEW/GRUwOTx75bcXdYUBOzyT9hCsOnk9fw6qod95Ydr3l2A
	aSpGapDaXoaCSOtYl8m10gfDQDwFo/GcI1pD0YFoIBO75Htee4rREKmBIDXcsBAWVG35unezufR
	wYCZDvDgkwHMLR8jLtuwalHaw1ISZ8KlFRyVLSX5kY3cjnamCrPbUZar+U9
X-Google-Smtp-Source: AGHT+IFIthqNLIzsiiVqfIC/794k1c4r4WbSgF7mi39Ywx1WhaF8XPcDvawxyxt3Hv5pgCvoq9HKGrKtaTz9avnQwoo=
X-Received: by 2002:a05:6000:26c8:b0:3ec:dd27:dfa3 with SMTP id
 ffacd0b85a97d-4255d2b70c7mr906497f8f.25.1759359582571; Wed, 01 Oct 2025
 15:59:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929194648.145585-1-ebiggers@kernel.org>
In-Reply-To: <20250929194648.145585-1-ebiggers@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 1 Oct 2025 15:59:31 -0700
X-Gm-Features: AS18NWDraC0eOVPTbkYt3tRMCpa8HC5n2XCxn7eFZFOdN6cdM4zLD1NKkPUHBCk
Message-ID: <CAADnVQKKQEjZjz21e_639XkttoT4NvXYxUb8oTQ4X7hZKYLduQ@mail.gmail.com>
Subject: Re: [PATCH iproute2-next v2] lib/bpf_legacy: Use userspace SHA-1 code
 instead of AF_ALG
To: Eric Biggers <ebiggers@kernel.org>
Cc: Network Development <netdev@vger.kernel.org>, Stephen Hemminger <stephen@networkplumber.org>, 
	bpf <bpf@vger.kernel.org>, 
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 12:48=E2=80=AFPM Eric Biggers <ebiggers@kernel.org>=
 wrote:
>
> Add a basic SHA-1 implementation to lib/, and make lib/bpf_legacy.c use
> it to calculate SHA-1 digests instead of the previous AF_ALG-based code.
>
> This eliminates the dependency on AF_ALG, specifically the kernel config
> options CONFIG_CRYPTO_USER_API_HASH and CONFIG_CRYPTO_SHA1.
>
> Over the years AF_ALG has been very problematic, and it is also not
> supported on all kernels.  Escalating to the kernel's privileged
> execution context merely to calculate software algorithms, which can be
> done in userspace instead, is not something that should have ever been
> supported.  Even on kernels that support it, the syscall overhead of
> AF_ALG means that it is often slower than userspace code.

Help me understand the crusade against AF_ALG.
Do you want to deprecate AF_ALG altogether or when it's used for
sha-s like sha1 and sha256 ?

I thought the main advantage of going through the kernel is that
the kernel might have an optimized implementation for a specific
architecture, while the open coded C version is generic.
The cost of syscall and copies in/out is small compared
to actual math, especially since compilers might not be smart enough
to use single asm insn for rol32() C function.

sha1/256 are simple enough in plain C, but other crypto/hash
could be complex and the kernel may have HW acceleration for them.
CONFIG_CRYPTO_USER_API_HASH has been there forever and plenty
of projects have code to use that. Like qemu, stress-ng, ruby.
python and rust have standard binding for af_alg too.
If the kernel has optimized and/or hw accelerated crypto, I see an appeal
to alway use AF_ALG when it's available.

