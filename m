Return-Path: <bpf+bounces-67305-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6830B42430
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 16:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 338187C3559
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 14:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CBF30ACFD;
	Wed,  3 Sep 2025 14:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7HAd25l"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F36306D4A
	for <bpf@vger.kernel.org>; Wed,  3 Sep 2025 14:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756911492; cv=none; b=QeQBlVf5az1FugGxrZEOdtvvnyYgVkuc0OESKnKDJzavXFycOUWq0bWLVgU1R/1dIN4au1VJQZO+E23JYRdFa9HhP3OUpOobMexUGCRmHLqOWZTpfEeRskoRKYGucmfMmPBUAFnBYtRyckohGhynAPKvdXJcNY8OaFo4A0rNqJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756911492; c=relaxed/simple;
	bh=tWZekKKStp6kFvRiz+qb3N6bVanABErKWt0eBJKgsig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LhKy5pf9JhwDBaAO5YHVW0g4d2jDwbTr6lg0cU7v18zD9aOtjJdJzCbgP7iEl9qGpgSRk840ufqMIjPdZVi7yfi9DS57lghXPQcqQxP6HGUnpEjj+sQQWOkCPskEvoEHIbw5a4qM1rcETZbMkk66NJM1qjmF1FPIwoZNkDNe92A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R7HAd25l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AC16C4CEF7
	for <bpf@vger.kernel.org>; Wed,  3 Sep 2025 14:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756911492;
	bh=tWZekKKStp6kFvRiz+qb3N6bVanABErKWt0eBJKgsig=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=R7HAd25lq4IIwVBiIQEwFEqWUnNDYpsz2GQntZHD4N2YvV9WuROtq4Md1n/Iansx2
	 SKTgWsq2CgiGCjfFBr7L/FWr/a83U0Ef4wHhDyfi998qVw0bR+qOa9lu2ZPd6qaLk6
	 mgmCulV6YhBsiNovX2tHVd0zoQHZJ1XamUNeHTKUFvT+CML7aTjTJ7bMHb8mXoZFqy
	 kTz4sQTGCh1OWRDCRb47PP8EBOVxpcR0KDeb2L9lnGBx5FBFA6NdhY+AaMQQ7o+vr6
	 JEnqC1kle809PtlrcugRo5PuJjmS/mYdACsTF/kFtCUNuccRtX9jji661T63lEwE8z
	 iKQRY/VrCnMvA==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b03fa5c5a89so671529966b.2
        for <bpf@vger.kernel.org>; Wed, 03 Sep 2025 07:58:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW3iKBQuFzgbcZAdTf3Fbk1ObwoXO4Kwd2ALOLVc7tyQUB2nYSJzjQ5lwb9uGuf2CrT9BQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVo/OchseboJII0+bv3d8xLvIAAJcwlaU4t35i0o60wpoeDdFL
	mll8lTTgNFm48+6PcIAC+dCh205NqwKgq0yy0Op606mc0bEUe/GwB6u2CfQKPFbDLOKe4r5w2Q7
	HzQUtzTwWxDZR/xN8Phmo0KR87i3t0mo=
X-Google-Smtp-Source: AGHT+IEQdz/6HHPrlHWcXsBqwfPSpSoB2scn38L0h8dvQDnzJLHYZCOlDSjCkWcl9vSE9MYc/WDCuYKLsumHBkkk9/0=
X-Received: by 2002:a17:907:9704:b0:b04:20c0:b1fd with SMTP id
 a640c23a62f3a-b0420c0b5e2mr1255800166b.36.1756911490581; Wed, 03 Sep 2025
 07:58:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903070113.42215-1-hengqi.chen@gmail.com> <20250903070113.42215-3-hengqi.chen@gmail.com>
In-Reply-To: <20250903070113.42215-3-hengqi.chen@gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 3 Sep 2025 22:58:05 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5UUVYnM3TkKujvS2u99NTEK7VCQsVHZkAKzhL5o8jCXA@mail.gmail.com>
X-Gm-Features: Ac12FXzqlrMQ-TPwKEnppkGqt3OANbFQ523PHs2fYeTPmp-QPJJR0YAr0QHMt14
Message-ID: <CAAhV-H5UUVYnM3TkKujvS2u99NTEK7VCQsVHZkAKzhL5o8jCXA@mail.gmail.com>
Subject: Re: [PATCH v4 2/8] LoongArch: BPF: Remove duplicated bpf_flush_icache()
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: yangtiezhu@loongson.cn, vincent.mc.li@gmail.com, hejinyang@loongson.cn, 
	loongarch@lists.linux.dev, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Hengqi,

On Wed, Sep 3, 2025 at 8:05=E2=80=AFPM Hengqi Chen <hengqi.chen@gmail.com> =
wrote:
>
> The bpf_flush_icache() is called by bpf_arch_text_copy()
> already. So remove it.
>
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---
>  arch/loongarch/net/bpf_jit.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index 77033947f1b2..9155f9e725a1 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -1721,7 +1721,6 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_im=
age *im, void *ro_image,
>                 goto out;
>         }
>
> -       bpf_flush_icache(ro_image, ro_image_end);
Both ARM64 and RISC-V do this, so I prefer to keep it.

Huacai

>  out:
>         kvfree(image);
>         return ret < 0 ? ret : size;
> --
> 2.43.5
>

