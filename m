Return-Path: <bpf+bounces-34615-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 224E892F355
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 03:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA5FC1F245D7
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 01:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B475F2907;
	Fri, 12 Jul 2024 01:16:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7DD645
	for <bpf@vger.kernel.org>; Fri, 12 Jul 2024 01:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720746969; cv=none; b=uDp/X1hzRPTE9GyrJnwMHlyLjFBsUZhRjs9PNzyqo97mY6upzDJsgNTpW8eI0jNhiv3K+sL91VK3POmlmJIkDQ2oPX01Od0xN1ZIpQeoyQY1oKJ+ohyYc/g5aI7dWr+UPiFeE243NVu3oAZqYwX7vBPXsvlGTOTEOn7roCgE4pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720746969; c=relaxed/simple;
	bh=vIlEv1eLBKqj2J7jM8AIJHH78kWZ3dOB2NGKK91QNnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ouV9FF2uYqqUIo4vl5MvibbmY3kgSR1tNff4EQ6YfQx8AzN2CxgNJgf0IDBVPmUAyF6DKguIUX62XGNPhPvQ+Etku71M9D3sKiH0HaBDTaQeiUOBj6IGG2lU7XHqH5IeZUIXaIwstl4y5rwuv363MyycmBbE6V/LI8D53hmvEKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fafc9e07f8so11358765ad.0
        for <bpf@vger.kernel.org>; Thu, 11 Jul 2024 18:16:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720746967; x=1721351767;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vxlq0FSMsvIH8rkAHjHPLdnPAPIcEMx6a2miTZyODcw=;
        b=fZgDyOp2hpNM16CaKWePfECgj2HAeV/SwgqZFUVMYKK4P79a5y6GXONnuvYtG5m7k4
         CBPxbvZxSTWbSPQkPRZe1PUyE2KiYscOJn1jg3ZJhQO/MXjFZ2ETk7KLklbS9xJtqWue
         T2HdMkW71OAqrpTjMzQzPE7XVH0QKwCZhA+AVlvBLR4AptRRodesad9sXo4hBJ/4n4he
         BqvmCPqoKxOiD556R5BaBmWxLX8gjcDAYQCIFCm1T4sA4l1KZ7ShEA5UnXvSz0WAKFG+
         8NtF6TSMbDnZOdz6ZK7eZFBQLuiUzFR4PIy4tE9FPT441IzM0Gbt2l/P1pdMO1yDim6B
         tq2g==
X-Gm-Message-State: AOJu0YzvS/F4+E/1Ea22TtFifpHo1LoUCdlWyH71iKtXc0vKd0ilQ4OL
	Z9U8bDPRpFB+HNejnMNuzx9OpG84Sf9slqfNVJcybX1QCYu/jv7Ux+JY1t0=
X-Google-Smtp-Source: AGHT+IEH16tTK+iiVdhw3qIZKe7xmu73HB99pB64bzTVpsr8vuF6UbJQ0chA/CG8vkpJXyAMpuHYkw==
X-Received: by 2002:a17:90b:3786:b0:2c9:7ebd:b957 with SMTP id 98e67ed59e1d1-2ca35c272fbmr9319914a91.11.1720746966716;
        Thu, 11 Jul 2024 18:16:06 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:73b6:7410:eb24:cba4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cacd419b60sm228530a91.26.2024.07.11.18.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 18:16:06 -0700 (PDT)
Date: Thu, 11 Jul 2024 18:16:05 -0700
From: Stanislav Fomichev <sdf@fomichev.me>
To: Zac Ecob <zacecob@protonmail.com>
Cc: "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: Fixing coerce_subreg_to_size_sx invalidly setting reg->umax_value
Message-ID: <ZpCD1fDXkr7wLGhZ@mini-arch>
References: <h3qKLDEO6m9nhif0eAQX4fVrqdO0D_OPb0y5HfMK9jBePEKK33wQ3K-bqSVnr0hiZdFZtSJOsbNkcEQGpv_yJk61PAAiO8fUkgMRSO-lB50=@protonmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <h3qKLDEO6m9nhif0eAQX4fVrqdO0D_OPb0y5HfMK9jBePEKK33wQ3K-bqSVnr0hiZdFZtSJOsbNkcEQGpv_yJk61PAAiO8fUkgMRSO-lB50=@protonmail.com>

On 07/11, Zac Ecob wrote:
> Hi,
> 
> My fuzzer recently found another bug, in which `reg->umax_value` is being invalidly set in regards to sign extensions.
> 
> The lines below contain the bug:
> ```
> reg->umin_value = reg->u32_min_value = s64_min;                                                             
> reg->umax_value = reg->u32_max_value = s64_max;
> ```
> 
> If `s64_min` / `s64_max` are negative values here, they correctly cast when assigning to the u32 values. However, when assigned to `umin_value` / `umax_value`, it seems there is an implicit (u32) cast applied, causing the top 32 bits to not be set.
> 
> 
> I've attached the files to reproduce, as well as the patch file, based off of 6.10-rc4 - albeit this is my first patch so I'd appreciate someone checking it's formatted fine.
> 
> Thanks.


> From da5ef523f7cd018f3f0991454a18bc961ea1abba Mon Sep 17 00:00:00 2001
> From: Zac Ecob <zacecob@protonmail.com>
> Date: Thu, 11 Jul 2024 17:41:55 +1000
> Subject: [PATCH] Fixed sign-extension issue in coerce_subreg_to_size_sx
> 
> ---
>  kernel/bpf/verifier.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 010a6eb864dc..eccf3ac8996a 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6213,8 +6213,14 @@ static void coerce_reg_to_size_sx(struct bpf_reg_state *reg, int size)
>  	if ((s64_max >= 0) == (s64_min >= 0)) {
>  		reg->smin_value = reg->s32_min_value = s64_min;
>  		reg->smax_value = reg->s32_max_value = s64_max;
> -		reg->umin_value = reg->u32_min_value = s64_min;
> -		reg->umax_value = reg->u32_max_value = s64_max;
> +
> +		// Cannot chain assignments, like reg->umax_val = reg->u32_max_val = (signed input)
> +		// Because of the implicit cast leading to reg->umax_val not being properly set for negative numbers

Pls use /* */ comments instead, use [PATCH bpf] subject in a followup and
try to find a commit that introduced the problem to mention it in the
'Fixes:' tag.

Also, instead of your custom reproducer, can you add a small reproducer
to the test_verifier.c (tools/testing/selftests/bpf/verifier/**) to
demonstrate the issue and avoid similar regressions in the future?

> +		reg->u32_min_value = s64_min;
> +		reg->u32_max_value = s64_max;
> +		reg->umin_value    = s64_min;
> +		reg->umax_value    = s64_max;
> +
>  		reg->var_off = tnum_range(s64_min, s64_max);
>  		return;
>  	}
> -- 
> 2.30.2
> 


