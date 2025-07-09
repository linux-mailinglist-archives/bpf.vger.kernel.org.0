Return-Path: <bpf+bounces-62806-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8ACDAFED9E
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 17:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46BA73BF0A9
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 15:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260AC2E7648;
	Wed,  9 Jul 2025 15:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uf1yeEHi"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1C028FFDB;
	Wed,  9 Jul 2025 15:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752074610; cv=none; b=Uja3Kqimy8jCRUCcCyAd8sNEsS84WAzhbY2cjfQyf+6a9gLtNTuykd6ksKMdjd1kcCsBP0XKfE6ShmchKTuxtM+/jQ9DZOhf4vHLKx8Ost/80yrf04ki+Hv/Jm9BqtSYOcp8uynwskq2t9O3a6gaQl5e2DvIpyCZjKplwR7t+2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752074610; c=relaxed/simple;
	bh=zF7zUZo4oyIfGlJULyHtOWF7n/UOTmrSOecmFDx0BoE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=onNsZwZn5LLN2y+PCWx8ib7arc92vGYu6XrGv9ltS+0L8kevpRlcjRY/cHX82G/moqUQyAPF6I66BRdLQjdBt+KXcWPCvQN4mRXfPvC/VtGckQRsqlz/xA1+h0ZCByXUZEMzWCPddSuk3RqTDnSIfYQeHjhoeHXqPfN5mYDKScc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uf1yeEHi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47BB8C4CEF8;
	Wed,  9 Jul 2025 15:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752074610;
	bh=zF7zUZo4oyIfGlJULyHtOWF7n/UOTmrSOecmFDx0BoE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Uf1yeEHik2aWc0YkbhH+tQVzi2oQhfbsEKbDGyDLHT0DSfZCrl3AhlRxUcZmSEgO8
	 KSOOkEFSd6yLgybq7PZBFbujX3/cjab/3vwNDGTJPQ2JtQSE/cKBLog0Bp70Q31bO0
	 RSx8cXCnAIQ86lXNCyuRd9mIFxexYC749BCECjpEb9i9Dq8JOj2IlKLgzuY6t28H1L
	 uUWf8zgGxy1SCXaDQXjkPOel5mfF7JG174ERyhWjZsV/2t/qGYROTKkz0LZTGBxdcG
	 emgVIgnmTXnCdwMnvZipm1gJdQukJGrVB/jMQwhvZkf239dmb9Z1naI8fyBygSR/PT
	 8mciu9+Yh+JIw==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-60780d74c85so8050369a12.2;
        Wed, 09 Jul 2025 08:23:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXCrXMwoWrBx9tpb3K5M9PMwIfqQPuEXevLy2Z4q3GLAVcBA0aAoUzU0Bf/mEx06PfGEvvmzpNhUlPnx+7I@vger.kernel.org, AJvYcCXngvyP+maHuw2nqMwuJR0/YlPHkC6z1qU+VqnzvHcGXiuQp+3DM8GmP2PjXe1nr2zd+g0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJRcPg5QQW0XajPrVSgRsbTJiCJl3h0WEA/v4aCOVUtrI6QB8C
	fXP9IR8yzbQRFkjlSIJH2VX+1NEZfaW0eonmk3SKNkaolOhoFjoGmvuUn+iBDpjKpTUI8mMMfRJ
	fea4HqS2kMXMcoa/zVzOcJJTvaNY+hpw=
X-Google-Smtp-Source: AGHT+IFRc6KIPeIaTMgPSKSHBeOiMQSXV6QtwyTjMyRju61upfaitdwA2JeGkExFRNlEYZnT+5a44EPyZtE1No/SoLc=
X-Received: by 2002:a05:6402:1d51:b0:607:32e8:652 with SMTP id
 4fb4d7f45d1cf-611a6e20969mr2685377a12.19.1752074608783; Wed, 09 Jul 2025
 08:23:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709055029.723243-1-duanchenghao@kylinos.cn> <20250709055029.723243-4-duanchenghao@kylinos.cn>
In-Reply-To: <20250709055029.723243-4-duanchenghao@kylinos.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 9 Jul 2025 23:23:12 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6bKrnDpVouriAoMUN5i26G6a+UuOGMyEj5h9kJGd6qnQ@mail.gmail.com>
X-Gm-Features: Ac12FXyKw1YlQ-8ZaRt610FTtjuYkLfHQZ0sgZr9IxwIob4HevdQCXQrASehvIY
Message-ID: <CAAhV-H6bKrnDpVouriAoMUN5i26G6a+UuOGMyEj5h9kJGd6qnQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] LoongArch: BPF: Add EXECMEM_BPF memory to execmem subsystem
To: Chenghao Duan <duanchenghao@kylinos.cn>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	yangtiezhu@loongson.cn, hengqi.chen@gmail.com, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, kernel@xen0n.name, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, bpf@vger.kernel.org, 
	guodongtai@kylinos.cn, youling.tang@linux.dev, jianghaoran@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Chenghao,

On Wed, Jul 9, 2025 at 1:50=E2=80=AFPM Chenghao Duan <duanchenghao@kylinos.=
cn> wrote:
>
> The bpf_jit_alloc_exec function serves as the core mechanism for BPF
> memory allocation, invoking execmem_alloc(EXECMEM_BPF, size) to
> allocate memory. This change explicitly designates the allocation space
> for EXECMEM_BPF.
Without this patch, BPF JIT is allocated from MODULES region; with
this patch, BPF JIT will be allocated from VMALLOC region. However,
BPF JIT is similar to modules that the target of direct branch
instruction is limited, so it should also be allocated from the
MODULES region.

So, it is better to drop this patch.


Huacai

>
> Signed-off-by: Chenghao Duan <duanchenghao@kylinos.cn>
> ---
>  arch/loongarch/mm/init.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/loongarch/mm/init.c b/arch/loongarch/mm/init.c
> index c3e4586a7..07cedd9ee 100644
> --- a/arch/loongarch/mm/init.c
> +++ b/arch/loongarch/mm/init.c
> @@ -239,6 +239,12 @@ struct execmem_info __init *execmem_arch_setup(void)
>                                 .pgprot =3D PAGE_KERNEL,
>                                 .alignment =3D 1,
>                         },
> +                       [EXECMEM_BPF] =3D {
> +                               .start  =3D VMALLOC_START,
> +                               .end    =3D VMALLOC_END,
> +                               .pgprot =3D PAGE_KERNEL,
> +                               .alignment =3D PAGE_SIZE,
> +                       },
>                 },
>         };
>
> --
> 2.43.0
>
>

