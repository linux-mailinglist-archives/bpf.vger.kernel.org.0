Return-Path: <bpf+bounces-21434-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C41884D37D
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 22:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56B9B28AD9A
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 21:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09FAD127B53;
	Wed,  7 Feb 2024 21:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nYPyHHIY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E508D127B5C
	for <bpf@vger.kernel.org>; Wed,  7 Feb 2024 21:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707340212; cv=none; b=cDQexAFGTKwk0zJYmmQmCehjfFMstUvYedlcbDQ71Q/eAdJhJnpPQymzeZzSNDhVL8NCTL1GlEtH5t3sPIbM+uAZrlWi/GeISdPt7UY/kmc7loiz2I9VhV6wvp/fgCjxiRmrkYCTJ3axhYukmfY5ato+o8ebydpejcNHXyj4ReA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707340212; c=relaxed/simple;
	bh=P0LXOmaLvztmqocm18SVAo6lSqLnnWmkoI7hCJfsxCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ER/KcaaubNWK7jT52YioGqEfKu6+iDNeQXq88vT7KLSA/QagSk1M9v1779QLGDV8lku9nMm2gUjleynD16xdy+KeX1n/1a7wEeG8sSDUIiN3AF6P++Wy/dN+HdnjdrQRyMa1hUlDN95Gzm6bHSBeXfuR+MRKXtvfilwkiqPjNvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nYPyHHIY; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40fb3b5893eso9124705e9.0
        for <bpf@vger.kernel.org>; Wed, 07 Feb 2024 13:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707340209; x=1707945009; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yzIBAmAbkaokxoBuvoEHsMoxUHI/JNBVtHeWulJmQgI=;
        b=nYPyHHIY9KPrcL/d5z7Z9zGg+II461w2xjHiY3x4V6ciV4tyGLCGg5HyhaXxhICYQB
         s3eFQ5ElM5FMbHoyFG9k0+y8xIRzZap8G+D6xgQY53+vEcTu45omiEpXctjWZuxD0zYJ
         yMs6QaEw1KCHT5clQxszZnCnkocPM1ZUUC27B1IjEwshzJ9cWKQOhWnM1e2Vygx64w/P
         /3EdrkcU82Sr6bIBBwKLsSp2XdNhW1tKczoL6lkYfv9P5Sch2E7lGofooFg/UNC5uHp1
         nlDvoVlod7X942p3CKmT3xZz3defxi1WDJLM9A0cEnuc/0xu9W7D3r5RphBiUjymdU13
         mhdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707340209; x=1707945009;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yzIBAmAbkaokxoBuvoEHsMoxUHI/JNBVtHeWulJmQgI=;
        b=N+ivS9kezmXIFJoENY7e6BN4WB3ZJcfB5jVgILqhvdqF42sfSf29MdW7rdqGEoIqJr
         cks0s1gzG/qebjyKuNHpoh4g2mw43IimQQjsVJcXS0a0t4093/APtqdSc1QNl0+fbeag
         DWOQoJ3KO60wSoDoOwlURoMLVxJEYbaeT3Qp9cWTflQxljxfXwar33paIVM9L8bJf72W
         G90lEYS2VyAlf894fai9UEj9EkNaAsGjSS97o2/tmSNJisvQV3+aMvhDLpPUwU46NKxK
         U+UEo3RAKoEBj8ZskbfWjrKyrXk7hFu5K/jNiX9RqzxUEsC8ZAbSeh7du/Z43/mPdm6W
         0Rcg==
X-Gm-Message-State: AOJu0Yw2YCaRXARqKttYKwCkr31f+tZUL0wDya/PWsim9unV45YEjn7V
	kxylUxXT+NJFl8V4QCJ5iIPzA4Ma/fG8vJUM559/tqmJi2Vn23uS
X-Google-Smtp-Source: AGHT+IHiyJYAj3ma0jKlMl7N7wodzV2+2eae3nM3PGPfCPcc5EuS7gXFGNAFvjBRUuEd7EpqEEKg4g==
X-Received: by 2002:adf:e3c5:0:b0:33b:28df:345f with SMTP id k5-20020adfe3c5000000b0033b28df345fmr4069245wrm.22.1707340208779;
        Wed, 07 Feb 2024 13:10:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXqK+BrGQGJO9KlmE/cbDN13L6DIFt/OS+YSBrzCTWPEwUz8isiJ3iRNm7xX+6FPEDQ54kx/Pg6vjSzeuUYxUZ7H44yNOXhKtrcDv2PVZnG1Do7xdyQOGWG44uMIAwwALSs/wuw0Z24yZ5c2+d/MuA9Te6xxWg94exzwSOfZg+teu+9kay4/bL5OPoWK8k8uYOSo0id8rwnTDcFCxiPZjI2OcALYbbyL8EQotbppR9CVlGDDGeHbWSphzZvxA2R/03PmtIPYNxtZVORkOjKfw5vFjuMv2Z7MEarDr92dK2YlBFu1wuVLD1B2PbYiBzbUTOwR2jXjQIMvIkeEzoyIP8idRImbzm3gLpa4NYoTjUtBANbLkAMzb1dcUe+moAh/XOmn2vl9ncZooi0aGKST9o=
Received: from localhost (host109-150-53-182.range109-150.btcentralplus.com. [109.150.53.182])
        by smtp.gmail.com with ESMTPSA id o8-20020a5d62c8000000b0033b1b01e4fcsm2240467wrv.96.2024.02.07.13.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 13:10:07 -0800 (PST)
Date: Wed, 7 Feb 2024 21:07:51 +0000
From: Lorenzo Stoakes <lstoakes@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@kernel.org, memxor@gmail.com, eddyz87@gmail.com,
	tj@kernel.org, brho@google.com, hannes@cmpxchg.org,
	linux-mm@kvack.org, kernel-team@fb.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH bpf-next 03/16] mm: Expose vmap_pages_range() to the rest
 of the kernel.
Message-ID: <30a722f3-dbf5-4fa3-9079-6574aae4b81d@lucifer.local>
References: <20240206220441.38311-1-alexei.starovoitov@gmail.com>
 <20240206220441.38311-4-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206220441.38311-4-alexei.starovoitov@gmail.com>

I don't know what conventions you bpf guys follow, but it's common courtesy
in the rest of the kernel to do a get_maintainers.pl check and figure out
who the maintainers/reviews of a part of the kernel you change are,
and include them in your mailing list.

I've done this for you.

On Tue, Feb 06, 2024 at 02:04:28PM -0800, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>
> The next commit will introduce bpf_arena which is a sparsely populated shared
> memory region between bpf program and user space process.
> It will function similar to vmalloc()/vm_map_ram():
> - get_vm_area()
> - alloc_pages()
> - vmap_pages_range()

This tells me absolutely nothing about why it is justified to expose this
internal interface. You need to put more explanation here along the lines
of 'we had no other means of achieving what we needed from vmalloc because
X, Y, Z and are absolutely convinced it poses no risk of breaking anything'.

I mean I see a lot of checks in vmap() that aren't in vmap_pages_range()
for instance. We good to expose that, not only for you but for any other
core kernel users?

>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  include/linux/vmalloc.h | 2 ++
>  mm/vmalloc.c            | 4 ++--
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> index c720be70c8dd..bafb87c69e3d 100644
> --- a/include/linux/vmalloc.h
> +++ b/include/linux/vmalloc.h
> @@ -233,6 +233,8 @@ static inline bool is_vm_area_hugepages(const void *addr)
>
>  #ifdef CONFIG_MMU
>  void vunmap_range(unsigned long addr, unsigned long end);
> +int vmap_pages_range(unsigned long addr, unsigned long end,
> +		     pgprot_t prot, struct page **pages, unsigned int page_shift);
>  static inline void set_vm_flush_reset_perms(void *addr)
>  {
>  	struct vm_struct *vm = find_vm_area(addr);
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index d12a17fc0c17..eae93d575d1b 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -625,8 +625,8 @@ int vmap_pages_range_noflush(unsigned long addr, unsigned long end,
>   * RETURNS:
>   * 0 on success, -errno on failure.
>   */
> -static int vmap_pages_range(unsigned long addr, unsigned long end,
> -		pgprot_t prot, struct page **pages, unsigned int page_shift)
> +int vmap_pages_range(unsigned long addr, unsigned long end,
> +		     pgprot_t prot, struct page **pages, unsigned int page_shift)
>  {
>  	int err;
>
> --
> 2.34.1
>

