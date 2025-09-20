Return-Path: <bpf+bounces-69084-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B660B8BDCB
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 04:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 273E0A066E7
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 02:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1809620B7E1;
	Sat, 20 Sep 2025 02:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="meMi53Sh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023AA10F1
	for <bpf@vger.kernel.org>; Sat, 20 Sep 2025 02:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758337165; cv=none; b=h3GT1MviA3A3aZBIZAExWEYIynANkhvV8VNfVo7HeCh4yFv65s2IlGv4VacRRmQ+pS7bzSuCTn0k2DJdKtGKt868KUDi9z3GBayopGjSojX7sXIrk6jq/+3C3Cj/WAGGMp8lQpo0cgxDkPObwkCcDRUyVQbMUDNe1pEvXzTTXwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758337165; c=relaxed/simple;
	bh=Kio4IgfzGetKrQ+Vmi7CJ7v20rVuamqkp9nDw0JYd/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lywcoIRbDu7VIebFtZJNwo4d11xf+krd+pYgeBW1bS8/cHmTr+ebP8JerPG1Ib24tSIgScRJUwfI+XkanclV6kHaESGiDqKPWLa/6Pti847oq6HOR+h1hkQjFtEYPBqvDUSJcKgwypMV9y0npjY2jfXCMHqocL/aU717HMDGQPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=meMi53Sh; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3ee1381b835so1631611f8f.1
        for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 19:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758337162; x=1758941962; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N2Eb0wJdHUFnX10uzRRUnfJrx9dL62sQVXN9vTHggjo=;
        b=meMi53ShMiJvF8ZbxoZY/STmyHxgKzkWCRT5qeASXs0CwTPQUBEAcOIj3nYRTAZGB6
         YVjsOJcxfCwWMgvr4YXj+yFEzSqrI0LWIFHYUQ3mznfspax+lOb7/QTr9tWpuLaZhpJC
         0maZzeavCcfIqNC801hipJzqiKpsG/pCHY/6wvtOvqmktl0YVJD5XVj0O0E4QWP9kGB7
         8fkJrPIAs6RD18jPO7LKSuhbfFKmwNslbvDR8ZrrA51TDIGB2NEiBZRoqjjxtSjYBv6g
         9q9YqKh6bN9xebdcKGH5uyvvMhBB6Cej4FVFgf//j2GwxjhAwpJllLKNTZu2t5OEjs15
         0YnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758337162; x=1758941962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N2Eb0wJdHUFnX10uzRRUnfJrx9dL62sQVXN9vTHggjo=;
        b=CGq40+w4oCtQZw1LrFnxfMSVRC9/xtqQXGk2q7oGD4ZhnXMid39deIhlaeT+dfEgNO
         GHXUjKqdVfLEY7RddEAUZ1GWaS6KalN+iyTc86njQZ8OSDiMUyh++zkeK5GmpQoBPQMb
         cagTQLLj6GFGNiYXE8tKhoRLoBpoJvuGQvkFjztAgi+GC1SMJQM+D2mYcqoIs7kn9zQv
         /BBfDAnDVF4i4wj3zHsyUbAGO7P46UKhZYvRh7tN6ePbhf/QT/Zm7akrzVG2G23s6jFN
         DxJ0CPLIS6x198sJs+tK03Ur0daKLmhI/qlDXVz3cL+U1N/BgZ6f6oKoDK+pEiLgIq4W
         iGew==
X-Forwarded-Encrypted: i=1; AJvYcCX82Ud5539yxdrfR5z0hqG8WsdrL3yCFN01LgJ4lWgRo0VBTNB/NSrgrRbfd428IUgfs08=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9Cwl+gaMmRVtPvja8dYRAJZx/u6wlwBXh/XNZ6FJFMII3Vqgv
	gZUtPOeM5+5IfeZFpBFrx766U2nG9f2bYMmHL2xiMywuPh1uLxX5ZYGB0wmnFDQbe/BeBV8J/iL
	WqeB99sTQk1K64/Cput9seFEeg4P8EuI=
X-Gm-Gg: ASbGncsk00Th14/ZMvOhg/HGx/tEcQWpa2qi9mactuBT2pCIhyGn1H9PyxNwLjfjxAf
	AsKF1OpCX3eK5Ycn4HnwkBCnfuXDpuJEHHmDb8e3HNQAtraH/LgW/sCwe4+MvBgDUhOe0GjWwYd
	TZJYdsBq73z6gSDbtfuITkVL6yB/qIFGmzgXfWktm/3chVSSmrbXnyMa2uWCpTIiBi56sc1JfbJ
	XEAMAu6zEB9DX7Icosdmd7BNC5sStww5JE/
X-Google-Smtp-Source: AGHT+IFRGyG4auHs7ZZneBj6eSPG6L/DnRYQuv7CqLo9ZXyuKfT2VzBIRPD0340Xw1Ny+YY+4F+uJ+EBpOJesm2KR60=
X-Received: by 2002:a05:6000:2404:b0:3d5:d5ea:38d5 with SMTP id
 ffacd0b85a97d-3ee7e10616fmr4618767f8f.25.1758337162152; Fri, 19 Sep 2025
 19:59:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919163054.60723-1-vincent.mc.li@gmail.com>
In-Reply-To: <20250919163054.60723-1-vincent.mc.li@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 19 Sep 2025 19:59:11 -0700
X-Gm-Features: AS18NWCEnD1bfsOJXdZKVCkmpFrWn4wZLlG_L6gtrqfu9kWav_ij2m3s3m5_Ris
Message-ID: <CAADnVQJi93AiYf7+eF2z4kSKfJujgvF-7ZorccEfgvMHoLjM=Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf, x86: No bpf_arch_text_poke() for kernel text
To: Vincent Li <vincent.mc.li@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>, 
	X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 9:31=E2=80=AFAM Vincent Li <vincent.mc.li@gmail.com=
> wrote:
>
> kernel function replies on ftrace to poke kernel functions.
>
> Signed-off-by: Vincent Li <vincent.mc.li@gmail.com>
> ---
>  arch/x86/net/bpf_jit_comp.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 8d34a9400a5e..63b9c8717bf3 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -643,10 +643,12 @@ static int __bpf_arch_text_poke(void *ip, enum bpf_=
text_poke_type t,
>  int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
>                        void *old_addr, void *new_addr)
>  {
> -       if (!is_kernel_text((long)ip) &&
> -           !is_bpf_text_address((long)ip))
> -               /* BPF poking in modules is not supported */
> -               return -EINVAL;
> +       if (!is_bpf_text_address((long)ip))
> +               /* Only poking bpf text is supported. Since kernel functi=
on
> +                * entry is set up by ftrace, we reply on ftrace to poke =
kernel
> +                * functions. BPF poking in modules is not supported.
> +                */

Not true. Pls study kernel/bpf/trampoline.c and how it's used.

pw-bot: cr

