Return-Path: <bpf+bounces-67304-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C13DEB42429
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 16:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AC5F1893CE5
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 14:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D121130DED9;
	Wed,  3 Sep 2025 14:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uYcabpiX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56373213E6D
	for <bpf@vger.kernel.org>; Wed,  3 Sep 2025 14:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756911375; cv=none; b=tfqwr7isF+Yc7Uv8ZlAies4zFNikq2EBUj3E6jrWOhaqiBDs38nEmhL0EMXyNtBJZ2QWztW7GaFPvgUQBbUjqP9OUibbwKUjAQRdAQDdYVmYkKFUbnmUF36DoIY2RTtmhLgxROOWsbu3GLEcphOECRPfLkj7aOdIoN94ugNY/4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756911375; c=relaxed/simple;
	bh=tIj0Z+DTJ39YmUSL3K3XPXx/F2zAbmRduMb/bX0FT0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l8xpUTr1Mg6MSEsBdeSU/SXD8Ac2H9fOfZ2TCO8DDoTYVekviZPDcxcUhLAE1iiOm88sLxKHNSpOi2zN4ymIsxTaPytV0tidLoPAgsrxTLIcmAPsPWUgNvzPyF4/R6XkaWsKtRuuHIso0W80Q1ahQuKtiMYgHXND7sQzwr1PjlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uYcabpiX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C76C4CEF8
	for <bpf@vger.kernel.org>; Wed,  3 Sep 2025 14:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756911375;
	bh=tIj0Z+DTJ39YmUSL3K3XPXx/F2zAbmRduMb/bX0FT0I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uYcabpiXBsMXHQsj5wpLGVmv80yreJZyt9i8IcopCdOx0vZdyYtgxEUiOUXPkO84j
	 aOcRPVm9WX57mJ/tgYnmc2YvK8BsJDVkotHa0Q4WYM/S95BGlL8S98WG54lGdkjO+Q
	 B2vvf05v/UXHbodQpKaV03CYGhlxe5/DJX/Jx2BxZIOE2V8Xy/RCotiYV28RR2UXN2
	 tXPjJuWZVGDObaBMCxSP+V41o6uXKDTEmuG4bLgVkPNyObcrWoOLWivz4ZBtoYppK5
	 h8msV8KNE1hnIlji0JhohkPyUf2Ljawr7kPJPv9VW5DlHVACP3ecJPzvrWeEK8dBxF
	 +9rHbRCjcyDBA==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b045d56e181so232608966b.2
        for <bpf@vger.kernel.org>; Wed, 03 Sep 2025 07:56:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVTBjTPe8RpF04aQakCOGWw91hstzfQ1Bg9yv+Va1384DA/xncMifIHCgMmOirlc5Gb9GA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZEAALGfVzpb5E+sJx8lSt+V3fEwMZLT/ZJ7dOBGnoD9F2KSfn
	KpVqdz8mTyjcp6p6WEceQLuJJer1QeilCZSzfi+YgKNlRIc5YnPLSPeLMDomXKfqhiJrJI+RSnQ
	3OC3LAHJXpbs/TE2qHoDNI1aFn8dXa/Y=
X-Google-Smtp-Source: AGHT+IE/LR48GB5PXHUyXlgQN5d5j+LDUGmvSVQKVgj1NaHdjQ4F+nQJz/y0FnAx1FoJMmd7o/fE4B1dCE3EM5yDCH4=
X-Received: by 2002:a17:906:c111:b0:afe:a446:b22e with SMTP id
 a640c23a62f3a-b01d8a277bamr1555805266b.12.1756911373705; Wed, 03 Sep 2025
 07:56:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903070113.42215-1-hengqi.chen@gmail.com> <20250903070113.42215-6-hengqi.chen@gmail.com>
In-Reply-To: <20250903070113.42215-6-hengqi.chen@gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 3 Sep 2025 22:56:10 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5PkWkhnBWEynxJki3rbN6rh_HW1hmVUY+ixY0Gx+ot+w@mail.gmail.com>
X-Gm-Features: Ac12FXy6uYcWS4k8gsz97tFti1aoMm3hFKJp5EYEa2tM3SdU5Vr5jNyS3XB9jq0
Message-ID: <CAAhV-H5PkWkhnBWEynxJki3rbN6rh_HW1hmVUY+ixY0Gx+ot+w@mail.gmail.com>
Subject: Re: [PATCH v4 5/8] LoongArch: BPF: Don't assume trampoline size is
 page aligned
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: yangtiezhu@loongson.cn, vincent.mc.li@gmail.com, hejinyang@loongson.cn, 
	loongarch@lists.linux.dev, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Hengqi,

On Wed, Sep 3, 2025 at 8:06=E2=80=AFPM Hengqi Chen <hengqi.chen@gmail.com> =
wrote:
>
> Currently, arch_alloc_bpf_trampoline() use bpf_prog_pack_alloc()
> which will pack multiple trampolines into a huge page. So no need
> to assume the trampoline size is page aligned.
We do the alignment because larch_insn_text_copy() changes page attrs.
If there is other data and BPF trampoline is in the same page,
changing page attrs may cause errors.

Huacai

>
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---
>  arch/loongarch/net/bpf_jit.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index 35b13d91a979..43628b5e1553 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -1747,8 +1747,7 @@ int arch_bpf_trampoline_size(const struct btf_func_=
model *m, u32 flags,
>
>         ret =3D __arch_prepare_bpf_trampoline(&ctx, &im, m, tlinks, func_=
addr, flags);
>
> -       /* Page align */
> -       return ret < 0 ? ret : round_up(ret * LOONGARCH_INSN_SIZE, PAGE_S=
IZE);
> +       return ret < 0 ? ret : ret * LOONGARCH_INSN_SIZE;
>  }
>
>  struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
> --
> 2.43.5
>

