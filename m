Return-Path: <bpf+bounces-75533-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D43C87E69
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 04:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B4C5B4E05E2
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 03:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686B52FDC30;
	Wed, 26 Nov 2025 03:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LwS2nPoA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D4E23A562
	for <bpf@vger.kernel.org>; Wed, 26 Nov 2025 03:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764126259; cv=none; b=X6++CsB8Dci7A68HZVdtcRyUZYUGNVtEFpypdJOpGh/iCIgmV0SYm17ernJVsfxdDwNEE5JKdhnuxIXsnQbT2HQxYLyIr7E/tG3+BSXm1ncpu4oA7Q/jSYdGRwMcMo/PSQleb1uQ+heGl37gkmkZXDoE1UhsDI7v3ZOjrAbaQ4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764126259; c=relaxed/simple;
	bh=d/OsOoMVxRXMBKic3leFD4ttAhYfNb0ryZrxApbataQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gTkSurLRlGgmtsYDl8n2dlub99u8kd5qR7y9/hXns7uxQoEW4tPxqS0lKFlanc1apUBfT9ahje/5xc3R/MzVkZ6tI8cKuPXluBlhk5ZIlAnGPxfHh9kjbGaVoBtWllyc/vWm/wC1xS6Pk6wtqLDQBxRyd02QcOErSlkWGNX5yOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LwS2nPoA; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47789cd2083so36914185e9.2
        for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 19:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764126255; x=1764731055; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+L8IDoxYiHldQ+oIo026ISuZnBpF5JHpkMKgEiO+wyU=;
        b=LwS2nPoA4fzcRuD1qqS5s7jJIByypQvLuuYYmlXPU6EHMXk/ZNHl8r8XzD2z8k3WIG
         JARg14pKyQHuOYGNN3uJ/cOkc5qTExVlQRWqLuBMEZHtNqU+DXIGYrqhDtT9fyCo5e74
         fwnmHlx/FnSs/3RRgcmAL5XlmJ3sxQzp6yLV8Th//2MndtEVOzTlMKdQx1IijgNdb7+Y
         om8AM7B8Hqgwfo38HiEck92LepbZ9cScYX6d33T4dlkM6NT+Z3H0j6C9jXrmBO1MfZXl
         Q19XMwFHiUYUnChKuDJ2yBNkgaba//uk8gaL4AuQZwDYQvGXYigr7iMhzaKoT4VxVpYT
         Z8+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764126255; x=1764731055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+L8IDoxYiHldQ+oIo026ISuZnBpF5JHpkMKgEiO+wyU=;
        b=TjNkzVxpHzFDvg4IputVsmWwLZKKxOsT6wnTXDaLG8mQSZrK+ZgFg3WovlM8rSeUsi
         gLebQ8AMOnPhW5ttJCfP1lgrNOb+Y95YUY2GX/X9qjbCsQEmrgq89+ZAkD0tvufobT1p
         s1B2MBn+kFKP1+NgJbsLGQqxjguZfbRVjpAovWhHeLSNOJNGkqJyW3DtiSvEKlzxun0l
         ADwDNAO8qs77UuD+QPurfnEq8KAnHdeDfOJznh7Y13/VVsn3P5PqGaUmMcFuhZ+J6+gu
         TmCB4NjQkUXrZhPfcKOqGoFgTnL0UcmOyxkKgzwhW0Jd6oXwzYVahZ4QyhLvQ1K5KvHQ
         ngBg==
X-Gm-Message-State: AOJu0YxN5dgyVJpB1cLh04bvJXuoMfv+L1m16rQKm+dOcxhbyghFpaau
	hKXXNAxRlj8m3Zc8EBrWFkmLtHzMJhmzT/dtmXzgqSGco3Hm1soWFKF3uL+Oq4QlJD91NK3+7kq
	HOHuelELgg52vm5jy/4A0mcZgBjUbUkg=
X-Gm-Gg: ASbGncvCK3pr1AzN6zCt0yccs/CIQDy3246BIPrk/f1Mnoubn+rtxn8Srod26E9f8Gx
	i/Sw8xRmeUVpqBrLUjZQb2TRytG6yOXLn+3xVDUfuf9nqV5aYyG48LrCYW+9v7qxE/uq3fsL997
	SkhUpYCbQ0ZbQawtVw9S122aKkLLEBhX8aUnY4PyP9bjpAkVsXrc+ZXrK5xoET2FQhrNe9iDG9h
	/0yhNvYQCLFcGMIP46TReZPAL22Z2e6OWVLwjJypjrSOjFLoSSF9CmSQbbYynvGvXEhCYcTIy3l
	gCqnIis8t2VmnfDqoTUk58gGP02G
X-Google-Smtp-Source: AGHT+IHJk/fvaVYr+OKStwKRUG8lTIT66xUxWZjIcegOdXS64yL6CTleODzAou0yxPoBLU6bkhH7HcvMSrMHJKJh78I=
X-Received: by 2002:a05:6000:22ca:b0:3eb:d906:e553 with SMTP id
 ffacd0b85a97d-42cc1d23c80mr18005083f8f.55.1764126255521; Tue, 25 Nov 2025
 19:04:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125030858.2485401-1-memxor@gmail.com>
In-Reply-To: <20251125030858.2485401-1-memxor@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 25 Nov 2025 19:04:04 -0800
X-Gm-Features: AWmQ_bmF3xg0WDABfY68M38_H8JPaieAGNFMrzEO4iCUkunH6F1BdMlWfx7Szao
Message-ID: <CAADnVQ+hvw+sMkob_+OYgc9=nkshG=CdXg4x=fDB9js_8BmUNQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1] rqspinlock: Introduce res_spin_trylock
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, kkd@meta.com, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 24, 2025 at 7:09=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> A trylock variant for rqspinlock was missing owing to lack of users in
> the tree thus far, add one now as it would be needed in subsequent
> patches. Mark as __must_check and __always_inline.
>
> This essentially copies queued_spin_trylock, but doesn't depend on it as
> rqspinlock compiles down to a TAS when CONFIG_QUEUED_SPINLOCKS=3Dn.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  include/asm-generic/rqspinlock.h | 45 ++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>
> diff --git a/include/asm-generic/rqspinlock.h b/include/asm-generic/rqspi=
nlock.h
> index 6d4244d643df3..a7f4b7c0fb78a 100644
> --- a/include/asm-generic/rqspinlock.h
> +++ b/include/asm-generic/rqspinlock.h
> @@ -217,12 +217,57 @@ static __always_inline void res_spin_unlock(rqspinl=
ock_t *lock)
>         this_cpu_dec(rqspinlock_held_locks.cnt);
>  }
>
> +/**
> + * res_spin_trylock - try to acquire a queued spinlock
> + * @lock: Pointer to queued spinlock structure
> + *
> + * Attempts to acquire the lock without blocking. This function should b=
e used
> + * in contexts where blocking is not allowed (e.g., NMI handlers).
> + *
> + * Return:
> + * * 1    - Lock was acquired successfully.
> + * * 0    - Lock acquisition failed.
> + */
> +static __must_check __always_inline int res_spin_trylock(rqspinlock_t *l=
ock)
> +{
> +       int val =3D atomic_read(&lock->val);

This needs a comment why val =3D 0 like res_spin_lock() is doing
is not enough here.

> +       int ret;
> +
> +       if (unlikely(val))
> +               return 0;
> +
> +       ret =3D likely(atomic_try_cmpxchg_acquire(&lock->val, &val, 1));
> +       if (ret)
> +               grab_held_lock_entry(lock);

Same issue as with res_spin_lock()...

Overall it makes sense, but let's defer it for now,
since without users somebody might send a patch to remove it
as dead code.

pw-bot: cr

