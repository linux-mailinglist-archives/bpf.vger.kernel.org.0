Return-Path: <bpf+bounces-66354-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB3FB326C9
	for <lists+bpf@lfdr.de>; Sat, 23 Aug 2025 06:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE903684122
	for <lists+bpf@lfdr.de>; Sat, 23 Aug 2025 04:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08C12144B4;
	Sat, 23 Aug 2025 04:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QaKF7qmX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C641F463F
	for <bpf@vger.kernel.org>; Sat, 23 Aug 2025 04:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755922239; cv=none; b=rEfAbhG8QalwPYo6QXy/2amNVbBAsrSvMP9RrnjzG1RvIJLeZizFY8xSDASAReHCchdf4w6Amm2Lh3Njcw2qttI8YPjOC0oyiTfx/VMp89hIFiT4+NeMMg2dOTTnNWjY62bQoORushvXYDI+LNj1xG4PJiD0x5nB80oJSplveO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755922239; c=relaxed/simple;
	bh=CQTeMpjBQEB7jad+Hl73ZOU8QhKJMH6ebsMrPqIGjug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kpvyd8ReXYNWvtAudEeh0FvyOPm6af3vVB5YoTMTs5s4H8/JSwvpbSLJ8y4+Qsb+a/4YZnxNats6Ia+oqp80siYKMU57+joh5/LfkSbXMSLN/DiGZ20n6AQDY7IGzh/VtTm3U0TGkeQl+7dGwWUbgwpkYkK0Sljv7fcY4Oo7wR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QaKF7qmX; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-afcb73621fcso375843566b.0
        for <bpf@vger.kernel.org>; Fri, 22 Aug 2025 21:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755922236; x=1756527036; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ypumJxO03YajLjZKwy8Tkl56v3hjokXusjP9nMqhO7w=;
        b=QaKF7qmXxqEoUxiOYtRPQKmagtI/E+VJxiMlV8bSeR3MVRe0OjItVkh2IufZaHIc6q
         3ElbOzksp8iBr4dzFHKVBucwJgSbWuA0oD0bV6KMnWvne0cl13ipWdIadrslgDFQCTsX
         kqoa1oXLWa5BU8vmLBzI/vh6/Tyi9uam2necihoxK+6oc2qWUqlBoGm0l0+F2v7uJM7n
         DPs/R1rLo1yQERKL2Gli14bDIIE4YParPOIWfuKsN+phnWMXi7Z+68NJRDg2sjdOnMoP
         TwtiPJR4NTu9P3D3GPt2uE2WQ+r6BrxTzWqnXYBdWujxCi4g7FTV6Y0Hr37xxfIGlrXM
         AMtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755922236; x=1756527036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ypumJxO03YajLjZKwy8Tkl56v3hjokXusjP9nMqhO7w=;
        b=Acr4nMHZJCx87N8fpKwuxJUkLPvt4rOkP6/NRqf6uSv9wbSCaKME62OHDbeqBsZDJI
         w8x4eQV4b+Kap4js0PG66hmzUsUhnpOFOFHq6Uq5aRxU3cxjJ27M0Fjwxivp7MDt3sX/
         1B6TwD+cpovP5zNAQmDR66FT3xQIJ4kfJRTmYAqTktUqklNvKQ3RAbet+v8rD/UIO8Mu
         N55Aq+MGsvegss66kLX0C8wwFrX0BcaoIeCaxYMBlgRiv+63Dit3JP0ztDs1pwn9LHe0
         8EINb3l73YG1/Pq+OGuGifL5IEUnm0kPCYA17RsS80SoOSXxvccV4KSY469mh4J7iwqs
         wpJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCUHrwtYTKbFAXSBgXEy1zURSozaxp1kXnlz6/Nr2jP1GlEreTT4kOeZ8Z0PA96300coo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyckx/P+yrN8jq5vMHOmXYcVObIs1wzC2vZqDnOIk43GLt2m5Ny
	wD3Kec/KJFT14us9nh4VfyNXlKyBzBpBhboBtp90ESdbGxZ/A9gDTMtAOjEIYoP6MGLSHUF1ETN
	2AGGGt27DOUpo4oD5ugBlJ2cMcUVP0yKrE6P8eHKuLw==
X-Gm-Gg: ASbGncvBc94HDKg6MgfUU10h2wQOEj6y/TUNfM6Vy5lRqYr0dSJU7wPQAWkB70hc/sF
	lPmok4I3lnBVQ5j7+KssOBeHtwkXDhkwHghHeSivBjEOWop6FLdMfsR3skuJENYLaNYIkr/g+Zs
	XwEdRkTvJ2Qi5BEJVKwuEmp75U1dSnputMcQg2hgMUfibI8cdoZl1jV7EZPDLIZFe56U4JyDPGC
	oateKUsMcu4SIbulMoHjIPUTdmXWBDhRnvHK9mTjK9P+Aq3timMvZ8JBcX66MTHUPc6Y1YGWUKT
	t/Q0dwU615xcK/75bykKwD4NzLpOJ8NG9VqhGr7w61ge8Q9A4kpt/uo=
X-Google-Smtp-Source: AGHT+IE9HWKIFeL/eoieWGHthnR2mM+6lMen7eM7ViDX/Yt9x4J4JbxkX+waMQi8V3Vn117kbACUlSqpqH++Fl+y+yA=
X-Received: by 2002:a17:906:c145:b0:afd:eb4f:d5ce with SMTP id
 a640c23a62f3a-afe29743499mr476219566b.62.1755922235554; Fri, 22 Aug 2025
 21:10:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819111953.3197428-1-chenhuacai@loongson.cn> <CAEf4BzajrMOkdOX5fn=bzWVTLbObPM9=_4Nh9rm5oc_4377Pfw@mail.gmail.com>
In-Reply-To: <CAEf4BzajrMOkdOX5fn=bzWVTLbObPM9=_4Nh9rm5oc_4377Pfw@mail.gmail.com>
From: Huacai Chen <chenhuacai@gmail.com>
Date: Sat, 23 Aug 2025 12:10:23 +0800
X-Gm-Features: Ac12FXxdZ6yZh946ZPsRKRRir3wQhq1Dl1brKhL3lj_EOIJp0wAHwBeoD_l_qrs
Message-ID: <CAAhV-H4DG0Uhq8RpEhusPMkqssLZsU6E4ATp5yH8w3R-KXA+qQ@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: BPF: Fix uninitialized symbol 'retval_off'
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Hengqi Chen <hengqi.chen@gmail.com>, 
	George Guo <guodongtai@kylinos.cn>, Chenghao Duan <duanchenghao@kylinos.cn>, 
	loongarch@lists.linux.dev, kernel test robot <lkp@intel.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Andrii,

On Sat, Aug 23, 2025 at 2:43=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Aug 19, 2025 at 4:21=E2=80=AFAM Huacai Chen <chenhuacai@loongson.=
cn> wrote:
> >
> > In __arch_prepare_bpf_trampoline(), retval_off is meaningful only when
> > save_ret is not 0, so the current logic is correct. But it may cause a
> > build warning:
> >
> > arch/loongarch/net/bpf_jit.c:1547 __arch_prepare_bpf_trampoline() error=
: uninitialized symbol 'retval_off'.
> >
> > So initialize retval_off unconditionally to fix it.
> >
> > Fixes: f9b6b41f0cf3 ("LoongArch: BPF: Add basic bpf trampoline support"=
)
> > Closes: https://lore.kernel.org/r/202508191020.PBBh07cK-lkp@intel.com/
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >  arch/loongarch/net/bpf_jit.c | 9 ++++-----
> >  1 file changed, 4 insertions(+), 5 deletions(-)
> >
>
> Is this something that should go through loongarch-specific tree?
This one, and other LoongArch specific BPF patches will go through
loongarch tree, thanks.

Huacai

>
> > diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.=
c
> > index abfdb6bb5c38..a73f6ea4ed4a 100644
> > --- a/arch/loongarch/net/bpf_jit.c
> > +++ b/arch/loongarch/net/bpf_jit.c
> > @@ -1504,11 +1504,10 @@ static int __arch_prepare_bpf_trampoline(struct=
 jit_ctx *ctx, struct bpf_tramp_i
> >         stack_size +=3D 16;
> >
> >         save_ret =3D flags & (BPF_TRAMP_F_CALL_ORIG | BPF_TRAMP_F_RET_F=
ENTRY_RET);
> > -       if (save_ret) {
> > -               /* Save BPF R0 and A0 */
> > -               stack_size +=3D 16;
> > -               retval_off =3D stack_size;
> > -       }
> > +       if (save_ret)
> > +               stack_size +=3D 16; /* Save BPF R0 and A0 */
> > +
> > +       retval_off =3D stack_size;
> >
> >         /* Room of trampoline frame to store args */
> >         nargs =3D m->nr_args;
> > --
> > 2.47.3
> >
> >

