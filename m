Return-Path: <bpf+bounces-59275-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A447AC77B8
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 07:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 699EBA2572E
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 05:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE2E252299;
	Thu, 29 May 2025 05:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="akUT/QuU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2994685;
	Thu, 29 May 2025 05:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748496917; cv=none; b=SnHd49AsOm37UbN4ONMdw0h5rguQCYKK5zv/xjm7jmy2Q1brlLFJMwHfSsWVJsCwJc+6uqmETi2qUvLKuXP6ArkVHLf3ZSw9FsWYvmU72N/80TGmjtjUU92Ktx4NQDsaR4M5uYjmqP8LvcZ3ew5WsmDWaLW0nA3ppAahEl83WIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748496917; c=relaxed/simple;
	bh=6fRuZd8jwy1+cEmMH+1K7LAYDssyVXfGXLxGuyPMyD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nUmSWfCPJavw7QcTX+tbBBP8CPC9uln7FcYtaDBuassFl9ts4RvNoNZwVSeZUZQHPyW0IIXEKZ5336fs5qSi3ujAeZkVxSXtkQP1FW7csKymhhJl2hWC5Gg8g3WtTpVlHvobRxpwiT8oJHuA9ECaBAASSr5O4kS7CH4E/Fgj7G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=akUT/QuU; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cf257158fso3966085e9.2;
        Wed, 28 May 2025 22:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748496913; x=1749101713; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OQ5bGBuDRHlPqX9Pkj2cY2f4XXf/2SjhXBJpx+bX+FU=;
        b=akUT/QuUFqzCv5DWMUEfrf0gNccA91SSUF5AOXPRm5ZZEclWP942KfOcgXl7PNsRE4
         7wDeRtgYkx4YMmKbWxv00SEdd1UQfB0cD4NT9tkHjxHRIIJn1EE/teIwooJsBbAIMcfC
         V2r8EBCxDqmDnmmNk/auCDHnUt7yXCYXYNUcfaGLR2323B8Tr9HlYDLAhKQL/OVaGUao
         iwe+id0ziA4CVFvHvN78MD4POicArW+N7qmyz5RAFRJwWNtu5oVpMDGC1cjSW3LD95mE
         3vGHR1J58iI+Bgn/fCYrSPj5dGUNeNdc6keF4rABF2/yOzfRGrsrWVFNhJdgksRU655A
         m5cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748496913; x=1749101713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OQ5bGBuDRHlPqX9Pkj2cY2f4XXf/2SjhXBJpx+bX+FU=;
        b=G8S4fOcoBPmqrwBF0oTrzmIrQmD8XfBL2K9p2c7h14OcJSysyxuu0LLAm5xrFNVeRR
         AwwfGdhpNZcG+XhtnisS8puJ+ldmVkutkps3sCmN+oXS2CfMv5qX8PGex8/Y+praqLXE
         cL3nRedXo4gQkRrsKL0cl3+vurJNAiLEZ8BzT1aMW51WipujTiWtmk/HJqX6rbItVO9L
         kJvYCICTmIVOz4Un5FnkjEQITaq+IEFBl8v4KfIPFJumC9cUUcccyjfjgzEw9kAYs8ax
         X7ZjdzE6KQKfDtgxUFSXFE4steqza2MvepmMn/STfGW8hiPNQEedIStqRtwhEeFHPFSw
         T3jQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPItjYsixPuYHgwmgx0SDUbVvQHBrDqZsGKvUe2IXfu+vh9aoch4/zlDtZJfSHR+BfByukr6wEVw==@vger.kernel.org, AJvYcCXotymfHlM33rU6cpHi/jwogvOvNhErrw9z0Ak1twEP8q4cxKOnMDCCQWoXpLzbEHBegfw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFGFxC4UK4mXjfJGGToroxROe9dVCN1d7B/E6AaZ0BbHFq31XD
	Jdeipj24baKQw31r3Vj9tZST/s8G8SzsK5855VgNjOUzbWH18JqH/x5WmknSzJRWhYgzSiMU6l7
	YxH1r0uOGfDVEKlnmzDpJJ/UFZrOuBUU=
X-Gm-Gg: ASbGnctRglqoAfa7U5+SF2Qlgv9R5I34ZfSBukKdyb0zJmfVEN2LQJTtEd2+uT1g54M
	A0nySNJN/A+ix6RzEZc3BHcwO58erB/A4huRt3RxjZPODaCM/QA07eGNwLm23i29AlC5afUpjWj
	iy/Az/B3S9ION82I+mIGYNG0qfxoFIy9ch
X-Google-Smtp-Source: AGHT+IG0PO9zxZhpyGgKiwuKrmIHwuBSYeRkXM7mZD9bJje26lX33u5gWEifjmcZnsrkAypYXzPuuzPSqC676GEiqFw=
X-Received: by 2002:a05:600c:190a:b0:450:cfcb:5c83 with SMTP id
 5b1f17b1804b1-450cfcb5d89mr9748175e9.30.1748496913169; Wed, 28 May 2025
 22:35:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250528095743.791722-1-alan.maguire@oracle.com> <20250528095743.791722-4-alan.maguire@oracle.com>
In-Reply-To: <20250528095743.791722-4-alan.maguire@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 28 May 2025 22:35:01 -0700
X-Gm-Features: AX0GCFtcEyZCPoazMkdZV5JY7UPDrVS2B2qyJBIyP9dyX6y_W1ezUk_nj-E69ws
Message-ID: <CAADnVQ+GDezR0e+SgqDB5h885Gd500cGYpFs4_LiXpLuD5gYFg@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 3/9] libbpf: use kind layout to compute an
 unknown kind size
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Masahiro Yamada <masahiroy@kernel.org>, Quentin Monnet <qmo@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, dwarves@vger.kernel.org, 
	bpf <bpf@vger.kernel.org>, Thierry Treyer <ttreyer@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 2:58=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> This allows BTF parsing to proceed even if we do not know the
> kind.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  tools/lib/bpf/btf.c | 35 ++++++++++++++++++++++++++++-------
>  1 file changed, 28 insertions(+), 7 deletions(-)
>
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 43d1fce8977c..7a197dbfc689 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -355,7 +355,29 @@ static int btf_parse_kind_layout_sec(struct btf *btf=
)
>         return 0;
>  }
>
> -static int btf_type_size(const struct btf_type *t)
> +/* for unknown kinds, consult kind layout. */
> +static int btf_type_size_unknown(const struct btf *btf, const struct btf=
_type *t)
> +{
> +       int size =3D sizeof(struct btf_type);
> +       struct btf_kind_layout *k =3D NULL;
> +       __u16 vlen =3D btf_vlen(t);
> +       __u8 kind =3D btf_kind(t);
> +
> +       if (btf->kind_layout)
> +               k =3D &((struct btf_kind_layout *)btf->kind_layout)[kind]=
;
> +
> +       if (!k || (void *)k > ((void *)btf->kind_layout + btf->hdr->kind_=
layout_len)) {
> +               pr_debug("Unsupported BTF_KIND: %u\n", btf_kind(t));
> +               return -EINVAL;

I'm missing the point around kind_layout->flags.
I was expecting that this helper and others at least
would check that flags =3D=3D 0, but none of it is happening.
The patches say that flags is unused and do nothing.
Why add flags field at all?

> +       }
> +
> +       size +=3D k->info_sz;
> +       size +=3D vlen * k->elem_sz;
> +
> +       return size;
> +}

