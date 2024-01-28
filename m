Return-Path: <bpf+bounces-20525-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 571F083F940
	for <lists+bpf@lfdr.de>; Sun, 28 Jan 2024 19:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A4161C212F2
	for <lists+bpf@lfdr.de>; Sun, 28 Jan 2024 18:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7FB321B0;
	Sun, 28 Jan 2024 18:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ayLC4kT/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3192E851
	for <bpf@vger.kernel.org>; Sun, 28 Jan 2024 18:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706468189; cv=none; b=jGQhQ0avKYhoiYOyErrIkWUhyZl/H7qtebUmnXUx1HCX6yNIbAl14bZkT1quNm4mM+no4Y3Otg/DZTDDjO7KtXtPPinoY8QNj+WFCKvRDTG+XDWj395mCEWOvva4Gi5ljMvBuBsxGBjqbVoXL3Sl0rGqAMfCFeEXsBNVenZ7hYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706468189; c=relaxed/simple;
	bh=WRJdnBGnsSCo7aRUSpfpeRR2g2XI5KL78sa7XlBIh8c=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ppppkAA//5vlLgHQNDkARbJ7V0P18Cl/K/R0HfA66QVFZa9MLfCOgtsbioOCVeBP9HQ7cIsYVJ/9yF1nBsDOUIVt9gih8BqqSyr816WJ3W+zrnr6qbRE3ql6xuIiN7NKXDgI1+30uGtfBhXfmGOijTyZy0+b2xcF/VDWq2ZMEtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ayLC4kT/; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40ef6bbb61fso2154565e9.1
        for <bpf@vger.kernel.org>; Sun, 28 Jan 2024 10:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706468186; x=1707072986; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RTwZ5EK3ge5EHhomTUclPPP6lME/7K/eAkzgltqyHjo=;
        b=ayLC4kT/P2JQMKUUtPrECyMvJ/5d1Pf3S8EIKEj0NDX/M8OvzwzVZDM3mlykhBmjiv
         k6+CyYjDmSvcQ5RQWuM8ocmNzsO8pJh4aKQ2GeVFHcwy7oZ6aZ07r3dJaGpDbZXwqwNa
         2a+ghbRWDCCS0Q+Mj0HFczKUaqbCtcVZi6rppxQ5cfm3Z4vrsKbNJs3wIMdNDeArGi4I
         uLZhaIKW3fF5zYuIwgz7e+hBa0IVnK4ywxy9o2b7yXBeWxDiy6JgqzbWD8jDvwJIEq/y
         cYb0j2GUEhQiYDRQMNXelG6ye1SeOml2JSSK5EzzjgQdSe9nAdD7GipR3e+zlDWhhtei
         Kyqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706468186; x=1707072986;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RTwZ5EK3ge5EHhomTUclPPP6lME/7K/eAkzgltqyHjo=;
        b=YOYCIDiCCQNGhXn6Xjrqxg6uoC/I/1YTz1HPDPS2RDt0ter6LX2eQST9QoLu3KV2Ti
         Tpl1aJHUaY9fECyhziwwguc1v7TlpEb6KO3GPuZ85QL+heIMmUVEuPUBu+1yQKUku2Gu
         en3rpuflwp6V2M4yEthLcNaP7OTwuicRrWQLBBlO7YWXS6F9wI5WquCkRswtlt0r7sGF
         G19eC+g1VXX2WASy4O7NSMNyyAWVa0Nv2nwGaz2L0c9Hnodp2u3aGdZP4DdaEskuaoln
         rkVDxGVveehnl/cxDtCjspXuWKHBdnT49PKm12WXolXEt1tqYaquJCTQNUqOkhsL2nmK
         6umw==
X-Gm-Message-State: AOJu0YxDxjj3RjiykZbyxO5o2SNN+RJdeXxy5j6fyaQTDvA0mLTFkRzL
	iFIGWikbNsWg5tGCeS99aZCzE8UKVcd8uLqBIEg7xioOwldWyAtL
X-Google-Smtp-Source: AGHT+IGHDWlj4JQ3HEYvZamG4Mlupkm4pAT0ySnChCogWIqXwBNDaq7sJFpZNSPkwtIkrwCsEAjzeQ==
X-Received: by 2002:a05:600c:219a:b0:40e:d2da:fc7f with SMTP id e26-20020a05600c219a00b0040ed2dafc7fmr3873411wme.1.1706468185581;
        Sun, 28 Jan 2024 10:56:25 -0800 (PST)
Received: from krava ([83.240.60.213])
        by smtp.gmail.com with ESMTPSA id r12-20020a05600c35cc00b0040eac0721edsm8029688wmq.3.2024.01.28.10.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 10:56:25 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 28 Jan 2024 19:56:23 +0100
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next] libbpf: fix faccessat() usage on Android
Message-ID: <ZbajVxpkL7Vh_DW7@krava>
References: <20240126220944.2497665-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126220944.2497665-1-andrii@kernel.org>

On Fri, Jan 26, 2024 at 02:09:44PM -0800, Andrii Nakryiko wrote:
> Android implementation of libc errors out with -EINVAL in faccessat() if
> passed AT_EACCESS ([0]), this leads to ridiculous issue with libbpf
> refusing to load /sys/kernel/btf/vmlinux on Androids ([1]). Fix by
> detecting Android and redefining AT_EACCESS to 0, it's equivalent on
> Android.
> 
>   [0] https://android.googlesource.com/platform/bionic/+/refs/heads/android13-release/libc/bionic/faccessat.cpp#50
>   [1] https://github.com/libbpf/libbpf-bootstrap/issues/250#issuecomment-1911324250
> 
> Fixes: 6a4ab8869d0b ("libbpf: Fix the case of running as non-root with capabilities")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  tools/lib/bpf/libbpf_internal.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
> index 930cc9616527..5b30f3b67a02 100644
> --- a/tools/lib/bpf/libbpf_internal.h
> +++ b/tools/lib/bpf/libbpf_internal.h
> @@ -19,6 +19,20 @@
>  #include <libelf.h>
>  #include "relo_core.h"
>  
> +/* Android's libc doesn't support AT_EACCESS in faccessat() implementation
> + * ([0]), and just returns -EINVAL even if file exists and is accessible.
> + * See [1] for issues caused by this.
> + *
> + * So just redefine it to 0 on Android.
> + *
> + * [0] https://android.googlesource.com/platform/bionic/+/refs/heads/android13-release/libc/bionic/faccessat.cpp#50
> + * [1] https://github.com/libbpf/libbpf-bootstrap/issues/250#issuecomment-1911324250
> + */
> +#ifdef __ANDROID__
> +#undef AT_EACCESS
> +#define AT_EACCESS 0
> +#endif
> +
>  /* make sure libbpf doesn't use kernel-only integer typedefs */
>  #pragma GCC poison u8 u16 u32 u64 s8 s16 s32 s64
>  
> -- 
> 2.34.1
> 
> 

