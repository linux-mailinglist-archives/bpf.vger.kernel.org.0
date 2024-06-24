Return-Path: <bpf+bounces-32889-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB14914879
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 13:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 850DEB2452A
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 11:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0715E13A25B;
	Mon, 24 Jun 2024 11:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XfISkCRq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C7E137758;
	Mon, 24 Jun 2024 11:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719228186; cv=none; b=SvvWCz+7SPECVYdgq8AoeNiip2VphNLiBIXo/3qOPxeGnQQwkPhA0uvFV4qq/5Ea/1SAD6C96ZqyBckNIbYtihVR9CJW6GKQ5yvvZ2LlAEVbkWqZJmm1WuVFE6Gu/wrYJcCBKFjvaJ32D7ts3NC6oHSGcsw6jbBQn+2U94EAsus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719228186; c=relaxed/simple;
	bh=1wz1DO4+P9GXw81HrvYZRwiMbG8RW3ptYFK10YnWQYI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pX9Or4u1yrYi5esIy8u8yqB3SwLwG+raW0b0eE2Gdxxud2dHTtLHwCnsTADaG1TjCgppSpLUm/bCE42/wKElFcxeHQpCubkmtVj72NdZ9FJdkL8VQod9KowLTeA8VhvjXZDZm+2SmB5jSTbFDMmUfdUJCuIY4phkBtaX8CnRcy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XfISkCRq; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52cdf2c7454so2834479e87.1;
        Mon, 24 Jun 2024 04:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719228183; x=1719832983; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GuZakqcQ8P7/8zUig3bLggNmER3pcdpTwZQ0sDBpoFc=;
        b=XfISkCRq9mHxRrTkuJ1eEU8ytNFflYnYpPWmbW/a3X4rtwHo5wJxc8TUkqTlrtp94u
         nZPJSeDe+E8VQiIhJygZm7f9kw0rUxQ2FZRX+OrtBw5ZJKgaCiWGWJII67XdBeD4Pd1R
         Qu8akQIq5SRAE4HWkYzCHS5Yr+ooQRwqvUZ7tAbykzqhHy4WVtYK+ppo6QizzbxFvzYU
         RIZIw8L+AkMWDro9ygZsOHCJbIS38RApFOlTsqZ4Qb98XD89F1mapqBS8skXpVgSZnEZ
         A343fX+NaAPqhi9hBIFzWK0UH5dW8+lWSSoA4nTC/QkV4Mjp9B/E5hmF2LBr7Fu8Vu9a
         dLgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719228183; x=1719832983;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GuZakqcQ8P7/8zUig3bLggNmER3pcdpTwZQ0sDBpoFc=;
        b=Buf9aaQtx4UsAzJ4i35K1uWDthIIh2v31RRawMYnuifJTj3/H5apQsX4YptCIRXikY
         Ty43I1a+hlKjpCoic3loFNcXZiYz+0r2WNCv6omVE8ty06dsRFrpPfD9v4ogA9mxtDk0
         JYEDtVhjGm7WgDdiULYiPbDg1kvnaY18naxkEXGj4NrLRWoLrgHFiCTfH6jqgbtZs2Sw
         7QkKjCfG476U6mVJzqczlqxNBh7QPcnaZH+ouM4RpxdB/bEP6EyJJ8OM7gmU9ySDw0r0
         zUXPNi5p9jxjzFoviT9eKTP7QCONtoPvwPDnyoLAu6HrAABrvCwa6oqdKedPeEpl+NPx
         ceyw==
X-Forwarded-Encrypted: i=1; AJvYcCUEBZoyJGvGa8aTxPkcn5HwzZIONg09E6t+qgXKAuUYMY74yB8mGwZBKajZ+B41ivHTgZD4EdXit6UGxIbJToWnuKLkuSNfDC8O+sASXWGp1Ayjovif451upp9eNQSKcrPd
X-Gm-Message-State: AOJu0Yz55vZr0aU+obsMaJB99iwS8mxjuIRQFbWeNfesN9T974l/eyYv
	cRP+WY06xkCHrvdF+tdTEzCCvcQWpQrK1RMlUCh+6xhn/xvhjq2BQD9Pwg==
X-Google-Smtp-Source: AGHT+IFFVh3a7Lk9TfHP/1hRO/050f5iXVyxCbY49eRmEy35wRdA+P/mkPt07Tee0w1T9Be/vxUe4Q==
X-Received: by 2002:a05:6512:490:b0:52b:c195:5d9c with SMTP id 2adb3069b0e04-52ce185ce3dmr3369478e87.61.1719228182746;
        Mon, 24 Jun 2024 04:23:02 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7251ace5besm125505566b.179.2024.06.24.04.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 04:23:02 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 24 Jun 2024 13:23:00 +0200
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH v2] build-id: require program headers to be right after
 ELF header
Message-ID: <ZnlXFF2sV-JNjGl2@krava>
References: <0e13fa2e-2d1c-4dac-968e-b1a0c7a05229@p183>
 <20240621100752.ea87e0868591dd3f49bbd271@linux-foundation.org>
 <d58bc281-6ca7-467a-9a64-40fa214bd63e@p183>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d58bc281-6ca7-467a-9a64-40fa214bd63e@p183>

ccing bpf list

On Fri, Jun 21, 2024 at 09:39:33PM +0300, Alexey Dobriyan wrote:
> Neither ELF spec not ELF loader require program header to be placed
> right after ELF header, but build-id code very much assumes such placement:
> 
> See
> 
> 	find_get_page(vma->vm_file->f_mapping, 0);
> 
> line and checks against PAGE_SIZE. 
> 
> Returns errors for now until someone rewrites build-id parser
> to be more inline with load_elf_binary().
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
> 
>  lib/buildid.c |   14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> --- a/lib/buildid.c
> +++ b/lib/buildid.c
> @@ -73,6 +73,13 @@ static int get_build_id_32(const void *page_addr, unsigned char *build_id,
>  	Elf32_Phdr *phdr;
>  	int i;
>  
> +	/*
> +	 * FIXME

nit, FIXME is usually on the same line as the rest of the comment,
otherwise looks good

Reviewed-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka


> +	 * Neither ELF spec nor ELF loader require that program headers
> +	 * start immediately after ELF header.
> +	 */
> +	if (ehdr->e_phoff != sizeof(Elf32_Ehdr))
> +		return -EINVAL;
>  	/* only supports phdr that fits in one page */
>  	if (ehdr->e_phnum >
>  	    (PAGE_SIZE - sizeof(Elf32_Ehdr)) / sizeof(Elf32_Phdr))
> @@ -98,6 +105,13 @@ static int get_build_id_64(const void *page_addr, unsigned char *build_id,
>  	Elf64_Phdr *phdr;
>  	int i;
>  
> +	/*
> +	 * FIXME
> +	 * Neither ELF spec nor ELF loader require that program headers
> +	 * start immediately after ELF header.
> +	 */
> +	if (ehdr->e_phoff != sizeof(Elf64_Ehdr))
> +		return -EINVAL;
>  	/* only supports phdr that fits in one page */
>  	if (ehdr->e_phnum >
>  	    (PAGE_SIZE - sizeof(Elf64_Ehdr)) / sizeof(Elf64_Phdr))

