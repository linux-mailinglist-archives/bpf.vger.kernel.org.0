Return-Path: <bpf+bounces-74925-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 392C2C68939
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 10:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A68C33537AA
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 09:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2786315D39;
	Tue, 18 Nov 2025 09:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDp8FMjI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBA430E844
	for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 09:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763458483; cv=none; b=UW+Hx1qXD3lmFVd7HDgTwVEZaCCRRpV2eGkKlfOb1QcPXfClMEceeV2kI7u6/372Tt5ngU8Oqn3QyXQ0Mksvw5WkUiYbdouInokZUtR9OovzWb53u6uzQgipYRLP4t+OGS/c4JVZrl3WbpO7mxNTPmTPe7U7C29FdK3MjIDF5kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763458483; c=relaxed/simple;
	bh=yIPnM3n4I0PjAXIK5w2dmHOKPXHY68UV/yyBRwOcZow=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hp9nYpXExLCiEKC7B0mDOwrsvkfrzNTF0rp37fgVEV3BmuFj6Utj/KLpM5AMSb+SiZEPMZ5w4tlxnRgXTAYH57TX4bb2PmjeRwq9Loe8XyVUyx9/R0apVuQvESWUhjdMNtTYnVjnJ2etlGtbid+U2JIvd4blFXOjiyX5Wxay+hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DDp8FMjI; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-37b99da107cso47320841fa.1
        for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 01:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763458479; x=1764063279; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SqcgtmKu36yGOEI8Pko6WxzeIhQjSBh9Rhu3pqJUFvQ=;
        b=DDp8FMjIZ1ENtVlp1JLIiOs3XbW424Jo1oFO5bHNZGIxdUFVP/YGA/EMuCFrFwcqPv
         kFftuTXpHlEec3Qf3i1Up/078GiD0oGOsKrwk7m+6S624XURdUyz77R4duQwEmM8TBot
         dfBElJALViOLOWqd2hPo9OmEDMt+gLHIoKhk+XWv+HpsrXNFvuRQFp5sup7WeJX+tolO
         /V94g4kw9gavm3rYZ+T4kGQn9gYgdivCCCVtW2PTZ1TeOpZQKSkygLLnNjsPXxgYGNyp
         261w0RXP6KK55446jQ8zArsjDaAMXs6SvHaeXuuOKAeYthxqbCcs4xTGGQL3f9PqPmI8
         Pmxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763458479; x=1764063279;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SqcgtmKu36yGOEI8Pko6WxzeIhQjSBh9Rhu3pqJUFvQ=;
        b=oC/LU2nAH3ATs+d29yWU3dVXJasRoBEMih7rWC2Bq6FG6xb9WEE1PZuH0QI8AbE+kd
         1wGmnosHtmv/43GaAbYAbf6Ux4QRXfIP35aiocyf40a0Bp3733u2dM2DV8pkGz080QBT
         1MzWQug6nAWvv222zMcdPSHxrLhcTwBJskDa0Bjlbx4KNd42nN7xObPd+nXyU+vsh2WV
         Sva5CUlXRQ0KqKnmuOqjLhh0x119EiiVk7Ri0KgEaWqA8SYMRpjhZxz0mN+XhWa2Sqta
         aQw0Z9iHj8YpxMmpBGWruTRmFS4gOO5vy+/TSRXl26ypzVP7cjl/ZaiFU/wxeK8vVEJV
         zp5A==
X-Forwarded-Encrypted: i=1; AJvYcCVbXqDBGWuJ/+f1iecI7T4WSeNXyhWPxapmVX5GrofEkD55yophZhc+EVZa42PYRTgO1Dc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+Upf9xUck7ia04btKH3SrvTnT44XK4TzVDU4Fp7itdBhIpO5y
	vs5t/Pc9AcpArSC3MFgXaDZNAkbUWVQItZKtJkJh3oQXphhOK9gutCCE
X-Gm-Gg: ASbGncsz52F8QXumkNl02lI80gE2EpmRQd7F30Y5JLpmNVoOKS8x/MVljQUcyFPxSAO
	2SEFU/yiq5DuBdKA8IxPBUX0pm0a44evHoRcoZ3EJtPTp3HqgBIM48t9CBuKCC0ax3UzfCspPOh
	uc9EoSsMAqPsEWN/Aj6mjB1xOUlwgXwWQutrwsHTskoM/P2ZeYEXszPRzC0/TjtV8M/BrNgh7QT
	Gh7G1XmV1LoJNiDyW1gagc+b7cvdjP9PIg821LoADAGBbKz9pnitTYCnh5Qs0G6+lkLID3I6F3U
	dKINIAnNnYB6Rv3tdr1PWYHnWcHvYv4nJApcHJO78bteFM+/bHahdO6RwAC3WYOO6Fzuadw2s30
	GqG71qj151kYjp7W9T26Wd4LrrJkmN5tYkKR07C31GIR8UEi3vRhcOFMwvLehT95X41oUYueost
	FvXSQbTqZ9VvHG+R3IPPPD1FWLWkB08pe6rIEGx18v
X-Google-Smtp-Source: AGHT+IGkdRAnCzdans0QSjjqeWINwfYXF9anLqr0LKbujqMjX6imLeve1k1SvIKyWvJPxmfqbrqEhg==
X-Received: by 2002:a05:6512:3d1e:b0:593:4a:a5d3 with SMTP id 2adb3069b0e04-595841ff545mr5445493e87.22.1763458479117;
        Tue, 18 Nov 2025 01:34:39 -0800 (PST)
Received: from pc636 (host-90-233-212-127.mobileonline.telia.com. [90.233.212.127])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-595804004aasm3859270e87.60.2025.11.18.01.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 01:34:38 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 18 Nov 2025 10:34:36 +0100
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 1/4] mm/vmalloc: warn on invalid vmalloc gfp flags
Message-ID: <aRw9rJ5hx2Wrtq_Y@pc636>
References: <20251117173530.43293-1-vishal.moola@gmail.com>
 <20251117173530.43293-2-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117173530.43293-2-vishal.moola@gmail.com>

On Mon, Nov 17, 2025 at 09:35:27AM -0800, Vishal Moola (Oracle) wrote:
> Vmalloc explicitly supports a list of flags, but we never enforce them.
> vmalloc has been trying to handle unsupported flags by clearing and
> setting flags wherever necessary. This is messy and makes the code
> harder to understand, when we could simply check for a supported input
> immediately instead.
> 
> Define a helper mask and function telling callers they have passed in
> invalid flags, and clear those unsupported vmalloc flags.
> 
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  mm/vmalloc.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 0832f944544c..5dc467c6cab4 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3911,6 +3911,28 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>  	return NULL;
>  }
>  
> +/*
> + * See __vmalloc_node_range() for a clear list of supported vmalloc flags.
> + * This gfp lists all flags currently passed through vmalloc. Currently,
> + * __GFP_ZERO is used by BPF and __GFP_NORETRY is used by percpu. Both drm
> + * and BPF also use GFP_USER. Additionally, various users pass
> + * GFP_KERNEL_ACCOUNT.
> + */
> +#define GFP_VMALLOC_SUPPORTED (GFP_KERNEL | GFP_ATOMIC | GFP_NOWAIT |\
> +				__GFP_NOFAIL |  __GFP_ZERO | __GFP_NORETRY |\
> +				GFP_NOFS | GFP_NOIO | GFP_KERNEL_ACCOUNT |\
> +				GFP_USER)
> +
> +static gfp_t vmalloc_fix_flags(gfp_t flags)
> +{
> +	gfp_t invalid_mask = flags & ~GFP_VMALLOC_SUPPORTED;
> +
> +	flags &= GFP_VMALLOC_SUPPORTED;
> +	WARN(1, "Unexpected gfp: %#x (%pGg). Fixing up to gfp: %#x (%pGg). Fix your code!\n",
> +			invalid_mask, &invalid_mask, flags, &flags);
> +	return flags;
> +}
> +
>  /**
>   * __vmalloc_node_range - allocate virtually contiguous memory
>   * @size:		  allocation size
> @@ -4092,6 +4114,8 @@ EXPORT_SYMBOL_GPL(__vmalloc_node_noprof);
>  
>  void *__vmalloc_noprof(unsigned long size, gfp_t gfp_mask)
>  {
> +	if (unlikely(gfp_mask & ~GFP_VMALLOC_SUPPORTED))
> +		gfp_mask = vmalloc_fix_flags(gfp_mask);
>  	return __vmalloc_node_noprof(size, 1, gfp_mask, NUMA_NO_NODE,
>  				__builtin_return_address(0));
>  }
> @@ -4131,6 +4155,8 @@ EXPORT_SYMBOL(vmalloc_noprof);
>   */
>  void *vmalloc_huge_node_noprof(unsigned long size, gfp_t gfp_mask, int node)
>  {
> +	if (unlikely(gfp_mask & ~GFP_VMALLOC_SUPPORTED))
> +		gfp_mask = vmalloc_fix_flags(gfp_mask);
>  	return __vmalloc_node_range_noprof(size, 1, VMALLOC_START, VMALLOC_END,
>  					   gfp_mask, PAGE_KERNEL, VM_ALLOW_HUGE_VMAP,
>  					   node, __builtin_return_address(0));
> -- 
> 2.51.1
> 
Reviewed-by: "Uladzislau Rezki (Sony)" <urezki@gmail.com>

--
Uladzislau Rezki

