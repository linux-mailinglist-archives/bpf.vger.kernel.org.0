Return-Path: <bpf+bounces-74939-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F67C68CB7
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 11:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9574E4F3818
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 10:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251AA341AB6;
	Tue, 18 Nov 2025 10:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJAPypSW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B372E0901
	for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 10:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763461053; cv=none; b=NO3EqxymDbtlM6WD8lAkvZ32vvh/l1GszvswrZBJwZ2anKdHBJnVP+EqfH4U9KF4Pg7S3FFp/YagxI2aQyA9BThEp9tMuPC0u8PGr6zI6NGe2jwmpvmInmatjmQ9o1DUvC/dC4ojgbTVrJ4lGDEM4zEWIX8CUHJJpV9WbpWm0Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763461053; c=relaxed/simple;
	bh=WGyRfRweE8gMN9G6z26QdXogrnZa8vv3OP5CyS/P5CY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hw3iqERW0snbGXGy3Z5z1lCor6MGE52QVvaUiUb5HGIZ/m6E1Jbip0mGI33aPxcGlZMj8q/I8uPzF0eKO4op2/HziVpZCYGHMkNVRYO+XLyAzU6hyY2TVeya5/EXN+VsiqbL68lZjFE1rDS9xrC6YYJetu2PRFL4HKvTvqVLrjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJAPypSW; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-42b3d4d9ca6so4303684f8f.2
        for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 02:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763461047; x=1764065847; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o0qcjyaVhlP5nM7vHAz2cQaHwtAgAYgKJwnORS0gnzI=;
        b=FJAPypSWNasa5RPSjL7NrkYDUMjaNIC+M+ZMzRFR12yopsZ6H1KlEzJjaMFY/HnJxy
         7EsuRiapvYuLX1lqyJH7GgFMfk+MwKkK0JTL6LuyulGYzfJRwFNBJO5+BuNhwUMNdLsk
         zbmaieXCZ5wbm2BmRDss6v/3pmvGE8YugUbBLPUMLG+5O/UHfDSvd0DM2WVtuNLcBIrE
         RurnQs4Q/2KdoV0qHtAeTry1XhNkkoQnfgq+aMNwMU7Z1StbCEqpqH7U+07qhxEraEhZ
         UyiuMMlS+Ldzy3hEl44nL6dpOhTEjMGJo34Upa6y5VLQO+9eaVe/BnhHdsQH46yIvRWb
         9DzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763461047; x=1764065847;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o0qcjyaVhlP5nM7vHAz2cQaHwtAgAYgKJwnORS0gnzI=;
        b=R+M491FbL4Aa6hHrdPRdfr/oT5Uf68ydP+Ff3WM+lvhSsR/nIptZySlemSPdZiwcr9
         Eup8LF69bml3ocbF4tAGW3riuOgd5HiTWNnewMM3ch/a5gHlcH/m3zd6maTiJJsVUBBC
         HkZBtYgSZ3QESxPnw8hv4cOgtGZ2WZovAKokliZpnpmOPd8ytDu16yq2GTIPRPVd9Emj
         lDyXT3CKNP/Emfy88liUCrNg/CE0pubrV2+BeNmwWIAZ/UfUy5eBvpaRBkPyop2k0rtM
         RjXl2rHhGtwkNxWjsG9+Cm7+58tE0RsWUo4LOAAQQodTi6xFGWpSATHp3EjpQeHiUWlU
         ldfQ==
X-Gm-Message-State: AOJu0YypGEopjofASmMU1UVYVNJzR+IWhDn0VOY+9Vpgu8lItQqImPkl
	ca4a9yeQCv/OwYaQugpkM4p7L+BPq1xJ8VfpSFMvMIndoCDU/epy3iTU3uaJL61C6DhiL7GEheP
	Dc1iOoVCGN9gjQmURbIdcg3OjpLVQQpo=
X-Gm-Gg: ASbGncsClfvWfgsgQVWpdIBYDxOwpeva8nLooAYjuPh+XFaWxS5nM0++R9B/6GdKvqo
	fhaQMIJ4OdIRkjr3e3KhJYIT40fpWu7d0wwW79AckG6CIeJnxac3WJBCUvAFB2uwXRvLbbSFU87
	s+zxya/6MqUjtuERxQfL8ihZzqdLhJjg5/BGyFTsyIDq3ZnLx5qJhOxgILABtCz5vL1FTxV3Sp8
	ERhzhMKLyi1Pk41+18g3fIDvwuRl9kB5OlCoEKrjzaXYPj2aaAEufaJdUj0SOhbp/UWMTnBa9IX
	OIFan3PFfGr7f4440u9ef0iskgfID1Z67e07HF8=
X-Google-Smtp-Source: AGHT+IHwJxZoUDnmazdklYmHMbP1/H4HnPJZoQbCxBJOzlKHV2m8KzkXKhpB+TIGiXcIG+3QwdTMusEsFkoig14pItE=
X-Received: by 2002:a05:6000:4210:b0:42b:3bd2:b2f8 with SMTP id
 ffacd0b85a97d-42b593849ffmr14736547f8f.46.1763461047222; Tue, 18 Nov 2025
 02:17:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117191515.2934026-1-ameryhung@gmail.com>
In-Reply-To: <20251117191515.2934026-1-ameryhung@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 18 Nov 2025 05:16:50 -0500
X-Gm-Features: AWmQ_bm5b3yET3GvalhROehJP0Bxg1rdbxpkSaszeYmaUc-cP75qlrEfTxXkm2U
Message-ID: <CAP01T74CcZqt9W8Y5T3NYheU8HyGataKXFw99cnLC46ZV9oFPQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/1] bpf: Annotate rqspinlock lock acquiring
 functions with __must_check
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 17 Nov 2025 at 14:15, Amery Hung <ameryhung@gmail.com> wrote:
>
> Locking a resilient queued spinlock can fail when deadlock or timeout
> happen. Mark the lock acquring functions with __must_check to make sure
> callers always handle the returned error.
>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---

Looks like it's working :)
I would just explicitly ignore with (void) cast the locktorture case.
After that is fixed, you can add:

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Thanks!

>  include/asm-generic/rqspinlock.h | 47 +++++++++++++++++++-------------
>  1 file changed, 28 insertions(+), 19 deletions(-)
>
> diff --git a/include/asm-generic/rqspinlock.h b/include/asm-generic/rqspinlock.h
> index 6d4244d643df..855c09435506 100644
> --- a/include/asm-generic/rqspinlock.h
> +++ b/include/asm-generic/rqspinlock.h
> @@ -171,7 +171,7 @@ static __always_inline void release_held_lock_entry(void)
>   * * -EDEADLK  - Lock acquisition failed because of AA/ABBA deadlock.
>   * * -ETIMEDOUT - Lock acquisition failed because of timeout.
>   */
> -static __always_inline int res_spin_lock(rqspinlock_t *lock)
> +static __always_inline __must_check int res_spin_lock(rqspinlock_t *lock)
>  {
>         int val = 0;
>
> @@ -223,27 +223,36 @@ static __always_inline void res_spin_unlock(rqspinlock_t *lock)
>  #define raw_res_spin_lock_init(lock) ({ *(lock) = (rqspinlock_t){0}; })
>  #endif
>
> -#define raw_res_spin_lock(lock)                    \
> -       ({                                         \
> -               int __ret;                         \
> -               preempt_disable();                 \
> -               __ret = res_spin_lock(lock);       \
> -               if (__ret)                         \
> -                       preempt_enable();          \
> -               __ret;                             \
> -       })
> +static __always_inline __must_check int raw_res_spin_lock(rqspinlock_t *lock)
> +{
> +       int ret;
> +
> +       preempt_disable();
> +       ret = res_spin_lock(lock);
> +       if (ret)
> +               preempt_enable();
> +
> +       return ret;
> +}
>
>  #define raw_res_spin_unlock(lock) ({ res_spin_unlock(lock); preempt_enable(); })
>
> -#define raw_res_spin_lock_irqsave(lock, flags)    \
> -       ({                                        \
> -               int __ret;                        \
> -               local_irq_save(flags);            \
> -               __ret = raw_res_spin_lock(lock);  \
> -               if (__ret)                        \
> -                       local_irq_restore(flags); \
> -               __ret;                            \
> -       })
> +static __always_inline __must_check int
> +__raw_res_spin_lock_irqsave(rqspinlock_t *lock, unsigned long *flags)
> +{
> +       unsigned long __flags;
> +       int ret;
> +
> +       local_irq_save(__flags);
> +       ret = raw_res_spin_lock(lock);
> +       if (ret)
> +               local_irq_restore(__flags);
> +
> +       *flags = __flags;
> +       return ret;
> +}
> +
> +#define raw_res_spin_lock_irqsave(lock, flags) __raw_res_spin_lock_irqsave(lock, &flags)
>
>  #define raw_res_spin_unlock_irqrestore(lock, flags) ({ raw_res_spin_unlock(lock); local_irq_restore(flags); })
>
> --
> 2.47.3
>

