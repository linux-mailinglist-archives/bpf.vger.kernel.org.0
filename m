Return-Path: <bpf+bounces-58626-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4793FABE806
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 01:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A741B3B9554
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 23:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6847725E836;
	Tue, 20 May 2025 23:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y7gK6RJF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833AD1E5702;
	Tue, 20 May 2025 23:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747783633; cv=none; b=UqLYCOPGVFK1/qwI5BAnzYK6jlxN30VnQqpeceCcDgBwPcv8WcTOr8U3cdTVrA1LpCB3yQeq1E0/bsOaCtp72VShRB19BMJ6gHXKQU5xBClFzR+lcgusw9+rIVJ6IIijsvpkGYS86Fk7ExzhBCG1gG1OseIIhQFJWqsqn41c/lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747783633; c=relaxed/simple;
	bh=L2E9RD+pq7S1M0YUk5YQcJW9SRR95r2qnL390cImzeo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y6pN8L2zuI8Aw7rGQv4SrA6Z5+m5OeikD7/A+RCuNLj3TE9y3Y5Dkm2jp3bfaGnMccCR/PTyWbv0SO3OFuno8W2w0KsxBvUBlH+qZdmTEhD6Ux8GnJZh7vQS9gHJmDd8Z9Rck+uK49KF+yFRTrySCihxcRyxmewzeDuZlEo/fIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y7gK6RJF; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-73712952e1cso5845137b3a.1;
        Tue, 20 May 2025 16:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747783630; x=1748388430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KUOFlpMrFmoGg2W22Wnb/50CaD/8+Zpw2eXYbFsNGa4=;
        b=Y7gK6RJF9627aph+JEbx5tpGASMzeQCtrNA84LTV/KoR8c0n3JuxgN2OpXYJHMfpa0
         JWDGBsASedKCW2Fd1G5q2BN0kf2rftUV9VM9qBcbrkiwYzzqVUrlkIExN3otwtCkzc2e
         2PatKBx+wUaUAJnsYfYhT4nzeXAQWsk9CG1gHJzdJAeF/27R2tud7uu6DhJkGE89Js4Y
         zLXn5DYHm656Qj/I9SBzFY0efVOySCo6DvQcFrORfg6FmHF8vO4zGv7J31Fu3QiuJPuG
         JWgtvZC8gpoFj0GJhXqgVlf9gY1ggeRp2JBfbzG27N5J/0fFK2CLumFw54WL1SLuFna1
         TL3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747783630; x=1748388430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KUOFlpMrFmoGg2W22Wnb/50CaD/8+Zpw2eXYbFsNGa4=;
        b=RneaIOYd1ukGL06il3iIQ6LVUtLUhRqM0w/RrKrEfhQ1y/3rzXXz8jiBJaxfIZnHyD
         DCBiH5FPG5ul6mFq55PU590Duze2E7CCU6dy0+dsFpYXzlkIfeT6AfdUBIcEblO01U2j
         yzvzClNyIKd9QlbIjC6EElwpwrT5A9g/eff0Y6UCGVVW4VZ71R1AWSBHpriuz/oZTRjk
         GqGxAAPXFGe5AtS+0tVwhYpc8t7pa0+iFmJEy4otFqwX6ZWnN35FGTJWfKANTgbTWs0A
         U9K4ZV9TM6Xr/iBS3yqYyKoRZs7Snm5qaCmTNgIxpOi1ZJ/vZsu11ORUrD/FJDIpbH5+
         jtjA==
X-Forwarded-Encrypted: i=1; AJvYcCU4eznEKuSSXPxfqTt5OElKhjuWS4DGjGKBmSfqOv4LTX667XPpmtgpNP1Dk2x5RvgybPU=@vger.kernel.org, AJvYcCUa2WbJ5VqXgeurKNKcv0If0BipkANWTye/Z/iamfIuSqQoPkucEQI2uZ1p6CskffnJhd/6knlz8rqDid1A@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7EK/K6ZaE4CLsVJfWYiC9y3csZqEMJEYELIVI7W1VDBlkiVLP
	Gxj0iJFwJ8UCRnI94DocICUf3dG0PlNn53iozqUy5ZhKgetcLNsM6dMZLfL9wq7OLsuBUyXVyPv
	T9cfVuCMFN5dux+BNYukMLea1MZ404GI=
X-Gm-Gg: ASbGncuMRylKkALqA64HJ079B3fMYbOOiEI/qA1Cz0oSl1g2uJBe3B4kidw4VmocMZO
	jIdosFe3+9UV6rRX/nDU06HSrrYLr9Tqhsaa9n8WtuysQVBlf64rMwrSXUSbKxgoy+/+jEpRi6S
	SODIhAguk2EGo9gSUe+/ZS4Aleq2SucsFUkApGvUP4IwzPhzDa
X-Google-Smtp-Source: AGHT+IEufFXJiKtzl5TuIOFWpCrPNbmFm84xA7Ldij7ZC3EK8FFiaL73RK08VKixI2im3Hf3sTnTT3s8zSLxJpilwHc=
X-Received: by 2002:a17:90b:5410:b0:30e:823f:ef22 with SMTP id
 98e67ed59e1d1-30e83215898mr26986321a91.24.1747783629658; Tue, 20 May 2025
 16:27:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515064800.2201498-1-senozhatsky@chromium.org>
In-Reply-To: <20250515064800.2201498-1-senozhatsky@chromium.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 20 May 2025 16:26:55 -0700
X-Gm-Features: AX0GCFtw-8QwaBPYdz6XMNoCpPhg6cWRy_wFLDfS2jeLs5bM_xrcux7WvxV2OUc
Message-ID: <CAEf4BzYTiPuOUbQgkNvT2haAupeep79q0pVu=fcD5fEgnAjR_A@mail.gmail.com>
Subject: Re: [PATCHv2] bpf: add bpf_msleep_interruptible() kfunc
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 14, 2025 at 11:48=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> bpf_msleep_interruptible() puts a calling context into an
> interruptible sleep.  This function is expected to be used
> for testing only (perhaps in conjunction with fault-injection)
> to simulate various execution delays or timeouts.
>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
>
> v2:
> -- switched to kfunc (Matt)
>
>  kernel/bpf/helpers.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index fed53da75025..a7404ab3b0b8 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -24,6 +24,7 @@
>  #include <linux/bpf_mem_alloc.h>
>  #include <linux/kasan.h>
>  #include <linux/bpf_verifier.h>
> +#include <linux/delay.h>
>
>  #include "../../lib/kstrtox.h"
>
> @@ -3283,6 +3284,11 @@ __bpf_kfunc void bpf_local_irq_restore(unsigned lo=
ng *flags__irq_flag)
>         local_irq_restore(*flags__irq_flag);
>  }
>
> +__bpf_kfunc unsigned long bpf_msleep_interruptible(unsigned int msecs)
> +{
> +       return msleep_interruptible(msecs);
> +}
> +

What happened to the trying out custom kernel module for
fuzzing/testing use case you have?

I'll repeat my concerns. BPF maps and progs are all interdependent
between each other by global RCU Tasks Trace "domain". Delay one RCU
tasks trace grace period through the use of msleep() will delay
everything BPF-related in the entire kernel.

Until we have some way to give some of BPF programs and its isolated
BPF maps its own RCU domain, I don't think we should allow arbitrary
sleeps inside BPF programs.

pw-bot: cr

>  __bpf_kfunc_end_defs();
>
>  BTF_KFUNCS_START(generic_btf_ids)
> @@ -3388,6 +3394,7 @@ BTF_ID_FLAGS(func, bpf_iter_kmem_cache_next, KF_ITE=
R_NEXT | KF_RET_NULL | KF_SLE
>  BTF_ID_FLAGS(func, bpf_iter_kmem_cache_destroy, KF_ITER_DESTROY | KF_SLE=
EPABLE)
>  BTF_ID_FLAGS(func, bpf_local_irq_save)
>  BTF_ID_FLAGS(func, bpf_local_irq_restore)
> +BTF_ID_FLAGS(func, bpf_msleep_interruptible, KF_SLEEPABLE)
>  BTF_KFUNCS_END(common_btf_ids)
>
>  static const struct btf_kfunc_id_set common_kfunc_set =3D {
> --
> 2.49.0.1101.gccaa498523-goog
>

