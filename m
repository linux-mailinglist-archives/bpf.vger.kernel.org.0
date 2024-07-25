Return-Path: <bpf+bounces-35632-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8968593C168
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 14:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A035B1F22C7F
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 12:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047231991C3;
	Thu, 25 Jul 2024 12:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="enCn0H05"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA75E22089
	for <bpf@vger.kernel.org>; Thu, 25 Jul 2024 12:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721909039; cv=none; b=ZGwhB7Hp6nVL+K0fv9UTSYWA3MEEWHqbYqwo9iY39GOpgHcaNRTiDtr9Vuphwkf/LodIsIMv1857tPFW6N3Lq38y31yeriTmdCoOiumQ1ImI/wbxj48hdvX0FUv4TyHG3P+AUHbArbMtSWdYClb6vmafgVjV/fK09rP3vsyV0xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721909039; c=relaxed/simple;
	bh=MG69CF36gpm28X0sYYqIxwGuPJLqiU4CzQJbAErnYzM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KJ2KszzBp0CtgrI0vVkb0YJvbsnayHcrF/ipavSxk7RnoA5L0d4zwrM5sw6uNyXvF2NKllK1EW0oWqooRU698RXkQD3baEqH2tjepzC540nVMtl11jWLUGknCtFboxZL2vQL0CcbYfxs1wQTPEMOYDvEFC6p4q426R0rkCeYxQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=enCn0H05; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-368313809a4so1208735f8f.0
        for <bpf@vger.kernel.org>; Thu, 25 Jul 2024 05:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721909036; x=1722513836; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gFGqeF6p5yDrmaqSWYiTyir0PswadDEtpT/arBN8MS8=;
        b=enCn0H051YAmiLtPJbJ76xTCu6xmVDzJpLzTjwKvH37hxTzcZ5m63988+JwqZD+SL+
         W0/C6wd4kfUkGl5Dh5fy+/sE37NOWwzC7nPVetjyZhr0vYjtrf3uJ0emObuZQR94TclY
         /xf7fOinsFMVxUXzCcUei2MySpEBvlQSp5M5ptNhfTCEnMiihToIC6yD5Rf/WgSgaH9D
         wlNluWdU27jUGk1D7lF0H7d51b6TycEOWUZGb0mDHRwI03Wb2oscyrNvSz2vk7GNrr24
         X76D2M+uUzQhtbBmcyfO7gPhFyz9Np8TxJYlsiF6Avd/nIVXYfUbL0jtAbdlZTELJNdm
         Y0PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721909036; x=1722513836;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gFGqeF6p5yDrmaqSWYiTyir0PswadDEtpT/arBN8MS8=;
        b=lbjxaEryc+ieQafAGneVT817daUmprlzSIUjan8supE7YgDX2XyaXvbmsGYqBwjs02
         9diV/97X0ibrxrhoaJ9VIpxZ+2dBqxfhidV2b3mobmXj88/oboamwwKzTbRVJazw/Cey
         6KeyP1cllDPrE6x6MjH0zsXX9KO4eh8sUqwdFLE77Opl55eSHcm9yZ1S8eDydxEfZQ2f
         /0l9sPze9RXM4hEtPL1oaLyrhkYlS+mGLFwIR8fZy9whnEzDtthodQ9n9NXAdfFm0vlQ
         oK9Erxn9wu+G3nbI8p3xq5xPpcSaYjBdaNSxx+cKgLrsn/LLXoOMM8yNHy8rreYf0zoa
         gvSg==
X-Gm-Message-State: AOJu0Yy4HDeywl4/a+4o71uMxmq1jo8AQT1UF9+LzDdRUu1ZrhZYxOJw
	vSx5OKxUoY1dvrpDzqUhfd5e1LYUnNIpfjhbCkNiXHbUVwkn98rW
X-Google-Smtp-Source: AGHT+IF2Y9vGGSxvcU23deEn/T62D35tC9vu+dIH2UtVlU4Cy0Ec4LLYYQvoqc8LhI9agIsmOtdn+w==
X-Received: by 2002:adf:b19c:0:b0:360:70e3:ef2b with SMTP id ffacd0b85a97d-36b31b9c655mr1844761f8f.26.1721909035831;
        Thu, 25 Jul 2024 05:03:55 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36858229sm1981784f8f.82.2024.07.25.05.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 05:03:55 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 25 Jul 2024 14:03:53 +0200
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org,
	adobriyan@gmail.com, shakeel.butt@linux.dev, hannes@cmpxchg.org,
	ak@linux.intel.com, osandov@osandov.com, song@kernel.org
Subject: Re: [PATCH v2 bpf-next 02/10] lib/buildid: take into account e_phoff
 when fetching program headers
Message-ID: <ZqI_KQl_Gq1Ego4-@krava>
References: <20240724225210.545423-1-andrii@kernel.org>
 <20240724225210.545423-3-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724225210.545423-3-andrii@kernel.org>

On Wed, Jul 24, 2024 at 03:52:02PM -0700, Andrii Nakryiko wrote:
> Current code assumption is that program (segment) headers are following
> ELF header immediately. This is a common case, but is not guaranteed. So
> take into account e_phoff field of the ELF header when accessing program
> headers.
> 
> Reported-by: Alexey Dobriyan <adobriyan@gmail.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

looks like this one never got in right?
  https://lore.kernel.org/bpf/CAEf4BzaAKAwO=-=0qZQfkHhBodN0MQUHpL-RY7tCHdcFidjv-Q@mail.gmail.com/

I couldn't find the place where you remove that check ;-)

jirka

> ---
>  lib/buildid.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/buildid.c b/lib/buildid.c
> index 1442a2483a8b..ce48ffab4111 100644
> --- a/lib/buildid.c
> +++ b/lib/buildid.c
> @@ -206,7 +206,7 @@ static int get_build_id_32(struct freader *r, unsigned char *build_id, __u32 *si
>  {
>  	const Elf32_Ehdr *ehdr;
>  	const Elf32_Phdr *phdr;
> -	__u32 phnum, i;
> +	__u32 phnum, phoff, i;
>  
>  	ehdr = freader_fetch(r, 0, sizeof(Elf32_Ehdr));
>  	if (!ehdr)
> @@ -214,13 +214,14 @@ static int get_build_id_32(struct freader *r, unsigned char *build_id, __u32 *si
>  
>  	/* subsequent freader_fetch() calls invalidate pointers, so remember locally */
>  	phnum = ehdr->e_phnum;
> +	phoff = READ_ONCE(ehdr->e_phoff);
>  
>  	/* only supports phdr that fits in one page */
>  	if (phnum > (PAGE_SIZE - sizeof(Elf32_Ehdr)) / sizeof(Elf32_Phdr))
>  		return -EINVAL;
>  
>  	for (i = 0; i < phnum; ++i) {
> -		phdr = freader_fetch(r, i * sizeof(Elf32_Phdr), sizeof(Elf32_Phdr));
> +		phdr = freader_fetch(r, phoff + i * sizeof(Elf32_Phdr), sizeof(Elf32_Phdr));
>  		if (!phdr)
>  			return r->err;
>  
> @@ -237,6 +238,7 @@ static int get_build_id_64(struct freader *r, unsigned char *build_id, __u32 *si
>  	const Elf64_Ehdr *ehdr;
>  	const Elf64_Phdr *phdr;
>  	__u32 phnum, i;
> +	__u64 phoff;
>  
>  	ehdr = freader_fetch(r, 0, sizeof(Elf64_Ehdr));
>  	if (!ehdr)
> @@ -244,13 +246,14 @@ static int get_build_id_64(struct freader *r, unsigned char *build_id, __u32 *si
>  
>  	/* subsequent freader_fetch() calls invalidate pointers, so remember locally */
>  	phnum = ehdr->e_phnum;
> +	phoff = READ_ONCE(ehdr->e_phoff);
>  
>  	/* only supports phdr that fits in one page */
>  	if (phnum > (PAGE_SIZE - sizeof(Elf64_Ehdr)) / sizeof(Elf64_Phdr))
>  		return -EINVAL;
>  
>  	for (i = 0; i < phnum; ++i) {
> -		phdr = freader_fetch(r, i * sizeof(Elf64_Phdr), sizeof(Elf64_Phdr));
> +		phdr = freader_fetch(r, phoff + i * sizeof(Elf64_Phdr), sizeof(Elf64_Phdr));
>  		if (!phdr)
>  			return r->err;
>  
> -- 
> 2.43.0
> 
> 

