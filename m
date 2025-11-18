Return-Path: <bpf+bounces-74926-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 85728C68951
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 10:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3924F347057
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 09:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D9931280F;
	Tue, 18 Nov 2025 09:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DytWVwPT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F46315D47
	for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 09:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763458516; cv=none; b=VzzaACuzs172A7rspdu6S3WmiWyOIHwf28BWcbBUNT1guDMn791Yds80ntvk1IRPupqWM8V8v0c1OGb3IVTu80Otae1LkmdBj8pQgO+ic8YRKS+4xMha8FGa6OszlAABEu2qVGAryc31U7dAlgdAKvt2PpzxY3uUZUEUl4VmdrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763458516; c=relaxed/simple;
	bh=NkZaaxDPId7zFBcud2FRpEytYE8UzEeNgevbakrWZJg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IynzSnJ6ULytfoERBpZsHebw44Fp0Q+gHqsNsaL+vvAbqw9ux0rqZWzcnFZRpkOMcMSzx5kf56AgK13+BFIxW1fdGv+8N+wVCccoFyL+ZwfpzKdaLRp/zkP5tEQJeIShjwY48OFLHexZwQseZWnPR6rAsvNn44oZPZVYggujPZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DytWVwPT; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5957ac0efc2so5784723e87.1
        for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 01:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763458513; x=1764063313; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aHMdZCOCGbX2O155/NUOCcK4115xr54Ob6gQNzq7blw=;
        b=DytWVwPT2Dv87+5En/jeANlIELE4nzZ/wsz/YyiQc2YC8L7iyqliAntaMDGD3bFCiZ
         7SZA+OFt9eVr5G5vpkhyWfnB+07EAb9zMUNYTESGQnpfQac+QeO98VylGv7wSNZKjIbB
         a7arsryV8VlDBCc2nUMtroJ8NTgxUVBFr215YePeiLxtQ4Jjpc5MRB71kHwp27ORiMIY
         ydQB9LZSRrthXue7LpYadqOEf/t9my3uaJa7XU+M2+4qdQFpeBldfO5Q+pMEYHhO3oC6
         5OJ8WlHbbu/UL2GqH1AsWRHzpMeeudekldmyDkwJv6IFrzpnsfi4nnX6Sz4zVmQlfLA4
         0ldg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763458513; x=1764063313;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aHMdZCOCGbX2O155/NUOCcK4115xr54Ob6gQNzq7blw=;
        b=jp3uT8oqoELwRXN33hKSeWkKPLpcgxOOTdzop7C1qudSqV5GtyZtiOa8bSN+dhmdhV
         Q6KXchUqyJoPSvf0J3iRERd434cXSD+VV0kqKMpUvfi3/DfPIuIoPv78TWjF0YjdcuI4
         lTJPj1EB+zGpQfG3YOk8Rtv52wbCF55vX9Tp076vhsSvzgEYUdcnO1k9CO6qVokFsJXt
         GpzLQJ8LbZTchaSCDcaU6kNi37WrByycPWlQ4TWH6V51lwNu40jatdY8UfBy/Vgzg8Xg
         1Ux17jqixhbmyklwvDsbN6Y4U5KJgnEWX7x+ohMEVZ08oZnzWva+uPaDDwuL8xXP4T/x
         /9qQ==
X-Forwarded-Encrypted: i=1; AJvYcCXu4HS9CPeD4UyTlERyRscWLiai+hkWqXDNqFQxrgldyLU/XPu+Cq9P3DI7b3QqoAtJ6qQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw38onjA58s0IOKwuU2jxirHcYi0cApam2L6VE6s64QSmWizyTp
	IQB6UlMLj2kSmDln/ytDtjYVEVHFV6Z0Tk2+DoYJJGERrK1i2yjLKJja
X-Gm-Gg: ASbGnculqmU73j9fhdYHsMo7EEP7QNv9RSYBKOpqd571bJqMELJbtS9LXWk5G+N89je
	57RomLL6alW8dMkEXcAf84qWCQ4HGgL/j8ZgLfvZcfHAe3UWC1ZxXsaFEeQNY7CTvNe9cRRgIdE
	hOu87DJ3PLgjlcgaup4P6zpF3g3YKIsQILHMfShDqZV3aFwGHeoHt/ODPDrFv/N1Lp0apdLbQia
	9mKtMdF5qtYwTILjqqZsh1A3NF/6fr5HTMKxIolW0UBcZ72UKrAzAY/HPQnv7AA/Ev/+Z5Nxbpx
	EjiXc3sfSjyZXq9+v0/w6sTMxlM+6Z/zsWsacrZ1FhGupkFM4xDr5XG0bRR40yE//KbAy9snl3w
	S0KWqPPYilk9RGLt6lySAiTNq8iiq53NseZquoUUTFi2MZl19xl8WyhUa3fdphxSnbz1cg61BU+
	jAkX7MPQ9M0or4ZV8k2qRxtbPHG/gETg==
X-Google-Smtp-Source: AGHT+IExm5aC89xgarQdyothH+dB9CzoUQ8H+p8Qx06g62Zn9Tjz5qsjq3/+2wKJFAz0pDGkZ+oHrA==
X-Received: by 2002:a05:6512:3d21:b0:595:80d2:cfda with SMTP id 2adb3069b0e04-595841b4e1cmr4374691e87.13.1763458512596;
        Tue, 18 Nov 2025 01:35:12 -0800 (PST)
Received: from pc636 (host-90-233-212-127.mobileonline.telia.com. [90.233.212.127])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-595803b3050sm3774175e87.27.2025.11.18.01.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 01:35:11 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 18 Nov 2025 10:35:09 +0100
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 2/4] mm/vmalloc: Add a helper to optimize vmalloc
 allocation gfps
Message-ID: <aRw9zbfD6Jf9_M2E@pc636>
References: <20251117173530.43293-1-vishal.moola@gmail.com>
 <20251117173530.43293-3-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117173530.43293-3-vishal.moola@gmail.com>

On Mon, Nov 17, 2025 at 09:35:28AM -0800, Vishal Moola (Oracle) wrote:
> vm_area_alloc_pages() attempts to use different gfp flags as a way
> to optimize allocations. This has been done inline which makes things
> harder to read.
> 
> Add a helper function to make the code more readable.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> ---
>  mm/vmalloc.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 5dc467c6cab4..0929f4f53ffe 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3614,6 +3614,17 @@ void *vmap_pfn(unsigned long *pfns, unsigned int count, pgprot_t prot)
>  EXPORT_SYMBOL_GPL(vmap_pfn);
>  #endif /* CONFIG_VMAP_PFN */
>  
> +/*
> + * Helper for vmalloc to adjust the gfp flags for certain allocations.
> + */
> +static inline gfp_t vmalloc_gfp_adjust(gfp_t flags, const bool large)
> +{
> +	flags |= __GFP_NOWARN;
> +	if (large)
> +		flags &= ~__GFP_NOFAIL;
> +	return flags;
> +}
> +
>  static inline unsigned int
>  vm_area_alloc_pages(gfp_t gfp, int nid,
>  		unsigned int order, unsigned int nr_pages, struct page **pages)
> @@ -3852,9 +3863,9 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>  	 * Please note, the __vmalloc_node_range_noprof() falls-back
>  	 * to order-0 pages if high-order attempt is unsuccessful.
>  	 */
> -	area->nr_pages = vm_area_alloc_pages((page_order ?
> -		gfp_mask & ~__GFP_NOFAIL : gfp_mask) | __GFP_NOWARN,
> -		node, page_order, nr_small_pages, area->pages);
> +	area->nr_pages = vm_area_alloc_pages(
> +			vmalloc_gfp_adjust(gfp_mask, page_order), node,
> +			page_order, nr_small_pages, area->pages);
>  
>  	atomic_long_add(area->nr_pages, &nr_vmalloc_pages);
>  	/* All pages of vm should be charged to same memcg, so use first one. */
> -- 
> 2.51.1
> 
Reviewed-by: "Uladzislau Rezki (Sony)" <urezki@gmail.com>

--
Uladzislau Rezki

