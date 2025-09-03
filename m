Return-Path: <bpf+bounces-67302-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96234B42414
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 16:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACEED4861F7
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 14:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5A230DED9;
	Wed,  3 Sep 2025 14:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/c3Rdcp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458272FF178
	for <bpf@vger.kernel.org>; Wed,  3 Sep 2025 14:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756911176; cv=none; b=XJXnTN7C5qVxyDTRAWwJ8l9lN9os7fezsZnRHsJERkZDyGLSslbiaCWk4jCt3tF4209wMlerls71UMksRZIlFseD8ck12dqmtWa4zFqIxOTIeiNuhsw088FttTjNS8tJQHszk9A5nXEX5y2sYCr7udoIA64NOdOfDbk+SpgV3T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756911176; c=relaxed/simple;
	bh=d9Bbwtv8osC1I7NmUVFKQXL5pxMZGj1faVaNQaz1+no=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TVchlzh2yCZsxOyHJ3pQokBFSp712VUveiQrUtx2IU3PerO2duyhWbHJmsbQllVYkQyShdY+xk9elO94DZsuF5ls+nJCNuMrl7LW36Zo5Hg9UAdldu9TaYRD5NBWEqqyMVstFLOn91mhnRh+Se7q6TGvkOyZwT8AAyXWmgNvfEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k/c3Rdcp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D71A2C4CEE7
	for <bpf@vger.kernel.org>; Wed,  3 Sep 2025 14:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756911175;
	bh=d9Bbwtv8osC1I7NmUVFKQXL5pxMZGj1faVaNQaz1+no=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=k/c3RdcpxuRzeQeN7lTwqOuSNlFhaKfydnTpCNUM7Csssre/BR5tr2ze9h9qm2hw2
	 XSIyZj3FD+AZxqhdJRiio1od52bgEA4TvDkGH7j/hcOBE+ha6A3w3wDCv+lFcoXzkU
	 ND9Wmois0x2yx3gPKv03xj5XvdsUYqAWQxkkNl0Yq2k9GwJOpRMSfbqJp69F7sBhO4
	 ZxAVRyaeZ4QKqnN1zBwbOWcNPq7ZsPloPptRgZltprzT9dZOG8BA/Wpef6RnsSFFXj
	 CflDZ16bxah+l4XpTTtupMMYHfU2MeR7bfQdaPNFW9Gkfgcoo2QdJV9jEPMcKH5j+O
	 WzPTzKaykwRLQ==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-61ce9bcc624so7837988a12.1
        for <bpf@vger.kernel.org>; Wed, 03 Sep 2025 07:52:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWbMM5vZFZVAezUFaCc3TRg8pMjXbj72ID90ruLpwb1qKiAELd6EGCTpt1cpKdbZ3q7K2I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJipmFEif/fYlh0fKZImkOX7YpJO2Ycfdc30MZVuEVFzkCAcgm
	hCnq8IQsaW+ljg8Sf7A0aJsE8i18350kXSLZBAUt/0dVgmXxdJrdCucqAUe1w+B16WRnBPtx+xx
	iTbpw+AIS0S4RPh9csGoAXD0R31PPl3I=
X-Google-Smtp-Source: AGHT+IEfEGnM1rCbIpl0TVXdl65Go4E8qV576pQef7gV6AyOFKIxjqJi9IeXnD+Q1FhdPOnY0opDOYo4mGMYToI8GXo=
X-Received: by 2002:a17:906:fd8d:b0:afe:35d:fd5d with SMTP id
 a640c23a62f3a-b01d8a33c18mr1645348066b.1.1756911174477; Wed, 03 Sep 2025
 07:52:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903070113.42215-1-hengqi.chen@gmail.com> <20250903070113.42215-5-hengqi.chen@gmail.com>
In-Reply-To: <20250903070113.42215-5-hengqi.chen@gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 3 Sep 2025 22:52:51 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4ZCM7uRB_oe__pJB_a1ei4+SPnVfT6c0JXvk4-HJg=bg@mail.gmail.com>
X-Gm-Features: Ac12FXxr_quI7UFFLrrGKJoctMIpK5yvPUHqWbqxVI60ya4Nho2wm-A-D4_MNJY
Message-ID: <CAAhV-H4ZCM7uRB_oe__pJB_a1ei4+SPnVfT6c0JXvk4-HJg=bg@mail.gmail.com>
Subject: Re: [PATCH v4 4/8] LoongArch: BPF: No text_poke() for kernel text
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: yangtiezhu@loongson.cn, vincent.mc.li@gmail.com, hejinyang@loongson.cn, 
	loongarch@lists.linux.dev, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Hengqi,

On Wed, Sep 3, 2025 at 8:06=E2=80=AFPM Hengqi Chen <hengqi.chen@gmail.com> =
wrote:
>
> The current implementation of bpf_arch_text_poke() requires 5 nops
> at patch site which is not applicable for kernel/module functions.
> With CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=3Dy, this can be done
> by ftrace instead.
Does this mean BPF trampoline can only work with FTRACE enabled?

Huacai

>
> See the following commit for details:
>   * commit b91e014f078e ("bpf: Make BPF trampoline use register_ftrace_di=
rect() API")
>   * commit 9cdc3b6a299c ("LoongArch: ftrace: Add direct call support")
>
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---
>  arch/loongarch/net/bpf_jit.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index 7b7e449b9ea9..35b13d91a979 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -1294,8 +1294,11 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_pok=
e_type poke_type,
>         u32 old_insns[LOONGARCH_LONG_JUMP_NINSNS] =3D {[0 ... 4] =3D INSN=
_NOP};
>         u32 new_insns[LOONGARCH_LONG_JUMP_NINSNS] =3D {[0 ... 4] =3D INSN=
_NOP};
>
> -       if (!is_kernel_text((unsigned long)ip) &&
> -               !is_bpf_text_address((unsigned long)ip))
> +       if (!is_bpf_text_address((unsigned long)ip))
> +               /* Only poking bpf text is supported. Since kernel functi=
on
> +                * entry is set up by ftrace, we reply on ftrace to poke =
kernel
> +                * functions.
> +                */
>                 return -ENOTSUPP;
>
>         ret =3D emit_jump_or_nops(old_addr, ip, old_insns, is_call);
> --
> 2.43.5
>

