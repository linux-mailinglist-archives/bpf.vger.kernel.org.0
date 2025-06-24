Return-Path: <bpf+bounces-61445-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4ECAE71B4
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 23:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA99C178AC4
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 21:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525CE25B30B;
	Tue, 24 Jun 2025 21:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZioQ43G6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6362025A355
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 21:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750801836; cv=none; b=d4/R8H/Y87ukygT4Yn50Ojq1LGkybN16MHfv1L4gb+PUW9naXkYooqeTgfBwEBcNANdzIV2P2WVkVF+O4KWiokOAxlTc1lcl86zP5y5i0S4EgQX+A3hfrFoe2+CHgi3tsQf8QoapDZB/8WT/u1j2f2W1IbvCl3MMc0iEu+SqgjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750801836; c=relaxed/simple;
	bh=h5/DwuqHZJqVUPp1HV8Ru8W3pwLUUJaeAi1ZRw60ZYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FXPzZZP2n580auT7gkJjPItOU+Rg7j3LukHxS41ZfspsZwMle+auR8tTMp7cFcVOm86s4gDr6mShPYwf0+Ni8EeUxUgmdDgSB1p2dcsTERQFhSmBTEOnwu0SkQNCwn8KK8BF4kWOMO4fDdaER33XHBpA7mARm8X6ZC//AhSKuxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZioQ43G6; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3135f3511bcso6077785a91.0
        for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 14:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750801835; x=1751406635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=41Jo2c0rR+Z8XQX9H01chYtPnXI8NQ/xiH3XhKcvTic=;
        b=ZioQ43G6SNdFsvJZQl32bMHkNuVu4lwyCn2nvy6LI2q1TZz+SBBvYGI9lnxSY8Y3n7
         yZHV24WWWnVg17jBCdQWIe089nLcMw30Tv34hYbrnMdikG28kbNDaB5DZgxxUN/GKHjy
         MJK6xtB8hJjf5XtB4rSBVipot8D+SW5TTtRiGxOn9Fz7EaAmA1h7y6b+nMjsuls9iLF6
         f904MjUuLqkrBCYtSwrdU08hnE2uJXs+XM96vPJw8qE40SCdNFdtflQnL4gCExtgCMNh
         hTho3ZwMvPzi+CKsG9y5c3gOxpLi+O27ssBBZa8k+gvVqXXu+t5w3i2CjWa0Tg/sVM9w
         b9/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750801835; x=1751406635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=41Jo2c0rR+Z8XQX9H01chYtPnXI8NQ/xiH3XhKcvTic=;
        b=OA8Ae56AN++JSfCt/HHbKuKI2/YL4zoSK2Du7ZKoHE1w6rqAqammnW6ZRr9aUYqFXX
         /beVKb7Isae/Z3tinkrlQlGVc6v1oeRb+U79mmsjjBlS0ErZi9uBHHAg254jLN1ZYEef
         2jzbd4QCO9HB4bApvlrsH1vSluJAh8y3LcjPyRRbzLBCn4kTfym+M0s3FHSDYxBdg3mY
         Cs3n/ZUIeY2gsjv0xdictiYjqjUOJMRFsfVSMLEauKnB/r67Tgbri30/ZGu19fxQHCFW
         7d9RYpDTnudbTUFHa2Fbnbd3jb6S+v1EpAEJ/IfhBEEOxsdSSTtTCWPwjwboYU6Yyw1Z
         2Zyg==
X-Gm-Message-State: AOJu0Yxn0EadMep/jzD40zFGqo11e/PoaeP3zrZKrBXw25Kh3RReMbpA
	BEY125Wf2qvHhp3oEJtqbhkSqGCfy9ksxVU8rDRmll2+gjm8LQSnhi9bODepWcbn7OoXln8X1Z8
	Z14PCzG3WDDPwuir5/sNKSdCEP/gNNIE=
X-Gm-Gg: ASbGncv395Oa/fxplFl7njdptTm8wGKr5bm5gzvaxdRgbc2a4TVkqKN1oxRnTPheFr7
	vzMEWSpCiLpzeJehmHK9bXpTsfR6eP5PvxdqyGjyB8wuACeF/0GO9dUptze60e0NQ2cmd+fk16+
	YQZhM/NJXmhZx0pWUMu7suQSmaBm0v/fGadYvVVml6Mg==
X-Google-Smtp-Source: AGHT+IGkrCGMkjmafk7lGqXmwyRdlx1lAcwBT/+ikhEgod36xYVeSj2zqksc0OhBH2EW9WHvg6v9khYc978lT8e8J6I=
X-Received: by 2002:a17:90b:53c5:b0:312:1508:fb4e with SMTP id
 98e67ed59e1d1-315f2675bbbmr619927a91.17.1750801834635; Tue, 24 Jun 2025
 14:50:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624205240.1311453-1-isolodrai@meta.com> <20250624205240.1311453-2-isolodrai@meta.com>
In-Reply-To: <20250624205240.1311453-2-isolodrai@meta.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 24 Jun 2025 14:50:22 -0700
X-Gm-Features: AX0GCFuuNa64TUgAsT8jG7k-PqixIu8DihP5wcO7skNmqfumm2s7Z4HOdap42is
Message-ID: <CAEf4BzYEHi8Z9btni7+yDaW7yNuiA3nAj6kSTXkznRdVAtC85w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: add bpf_dynptr_memset() kfunc
To: ihor.solodrai@linux.dev
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org, eddyz87@gmail.com, 
	mykyta.yatsenko5@gmail.com, mykolal@fb.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 1:53=E2=80=AFPM Ihor Solodrai <isolodrai@meta.com> =
wrote:
>
> Currently there is no straightforward way to fill dynptr memory with a
> value (most commonly zero). One can do it with bpf_dynptr_write(), but
> a temporary buffer is necessary for that.
>
> Implement bpf_dynptr_memset() - an analogue of memset() from libc.
>
> Signed-off-by: Ihor Solodrai <isolodrai@meta.com>
> ---
>  kernel/bpf/helpers.c | 48 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index b71e428ad936..b8a7dbc971b4 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2906,6 +2906,53 @@ __bpf_kfunc int bpf_dynptr_copy(struct bpf_dynptr =
*dst_ptr, u32 dst_off,
>         return 0;
>  }
>
> +/**
> + * bpf_dynptr_memset() - Fill dynptr memory with a constant byte.
> + * @ptr: Destination dynptr - where data will be filled
> + * @ptr_off: Offset into the dynptr to start filling from
> + * @size: Number of bytes to fill
> + * @val: Constant byte to fill the memory with
> + *
> + * Fills the size bytes of the memory area pointed to by ptr
> + * at offset ptr_off with the constant byte val.
> + * Returns 0 on success; negative error, otherwise.
> + */
> + __bpf_kfunc int bpf_dynptr_memset(struct bpf_dynptr *ptr, u32 ptr_off, =
u32 size, u8 val)

nit: ptr_off -> offset, let's keep consistent naming with other APIs
(as much as possible)

> + {
> +       struct bpf_dynptr_kern *p =3D (struct bpf_dynptr_kern *)ptr;
> +       char buf[256];
> +       u32 chunk_sz;
> +       void* slice;
> +       u32 offset;

nit: combine chunk_sz and offset on single line

> +       int err;
> +
> +       if (__bpf_dynptr_is_rdonly(p))
> +               return -EINVAL;
> +
> +       err =3D bpf_dynptr_check_off_len(p, ptr_off, size);
> +       if (err)
> +               return err;
> +
> +       slice =3D bpf_dynptr_slice_rdwr(ptr, ptr_off, NULL, size);
> +       if (likely(slice)) {
> +               memset(slice, val, size);
> +               return 0;
> +       }
> +
> +       /* Non-linear data under the dynptr, write from a local buffer */
> +       chunk_sz =3D min_t(u32, sizeof(buf), size);
> +       memset(buf, val, chunk_sz);
> +
> +       for (offset =3D ptr_off; offset < ptr_off + size; offset +=3D chu=
nk_sz) {
> +               chunk_sz =3D min_t(u32, sizeof(buf), size - offset);

you have offset =3D ptr_off + chunk offset, so size - offset seems
wrong, it should be `size - offset + ptr_off` to "neutralize" ptr_off
itself. I'd probably write the for loop using

for (offset =3D 0; offset < size; offset +=3D chunk_sz) {
    chunk_sz =3D min_t(u32, sizeof(buf), size - offset);
    err =3D __bpf_dynptr_write(p, ptr_off + offset, buf, chink_sz, 0);
    ...


seems simpler to just add that ptr_off in dynptr_write call

pw-bot: cr


> +               err =3D __bpf_dynptr_write(p, offset, buf, chunk_sz, 0);
> +               if (err)
> +                       return err;
> +       }
> +
> +       return 0;
> +}
> +
>  __bpf_kfunc void *bpf_cast_to_kern_ctx(void *obj)
>  {
>         return obj;
> @@ -3364,6 +3411,7 @@ BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
>  BTF_ID_FLAGS(func, bpf_dynptr_size)
>  BTF_ID_FLAGS(func, bpf_dynptr_clone)
>  BTF_ID_FLAGS(func, bpf_dynptr_copy)
> +BTF_ID_FLAGS(func, bpf_dynptr_memset)
>  #ifdef CONFIG_NET
>  BTF_ID_FLAGS(func, bpf_modify_return_test_tp)
>  #endif
> --
> 2.47.1
>

