Return-Path: <bpf+bounces-47697-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D26209FE914
	for <lists+bpf@lfdr.de>; Mon, 30 Dec 2024 17:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3CED3A236B
	for <lists+bpf@lfdr.de>; Mon, 30 Dec 2024 16:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BB51ACEC1;
	Mon, 30 Dec 2024 16:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="inrrVCSK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5215CAD2D;
	Mon, 30 Dec 2024 16:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735576853; cv=none; b=iKcXF6jw0jrRFt7fh3+rhgv/W1Ea1X/Yt910LvjHwi1Q9Rr1xPtlsVkR9MDB1VYlthcurhz/7ZGs1XBsb/VkPs5wlshN2kFAcKjJ9b9CE/BEyhFeNO3bZoxP+DA6k/0J1qAGHJSVfG+ljKe99Ymo3YRaSWgQfl/U37hILXwsqAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735576853; c=relaxed/simple;
	bh=3D0XoxQbEucKZVLMbEt0crkGIGQY93WkfTjsnP5JoCY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fF8RFw/Au5r2YRXt60ehZnPFv79iXCYD9jGYoYCKh9ywiKbPNijt6bYsLtUwzC4hSiBwzdAi7LkD6EjWCajfhwAKBUhOt9MGpHLPrqZlitSB4mdE+hdE8Bhf0cXBP+9NCOi7AV/0g2rKPSXh8YCEPrX10tRTOAbWGMrLi2YQk+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=inrrVCSK; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38634c35129so7150846f8f.3;
        Mon, 30 Dec 2024 08:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735576849; x=1736181649; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c34inWLrJLZIxxvrkUgRcAEz+7YrbH7BxLS5ubF+0ts=;
        b=inrrVCSKLHJOguLxqEo17Wt4XQTopsIm0jOfc/G5Ixk4dbOYqlRzueHlgUatHT/o2B
         taXYGLgNX59nK7tvIOxZsbtRM3vMGG8M6AwarSfpX4q1P20yZCR0AhIjpIy2awcjY1Jf
         06qHm9AtvMDK9YmBV2pRW32xM94UzaAz7iIy/nvSG5M/Q93NTukrGMbybysQ1/wuX6vx
         FN2ZZmybeb94GOMRyriXhiCmAcK9xvPoEVTd7Vwp/xhOFRv+wkVjhqkMqnAzkzKhvGgq
         dXD0WDIbvGLSPlDL9IHrC7h5FDnlLj93Q6okLJLOfT6chvDdpITGD3BWFe8YZvnuSqZ7
         DVFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735576849; x=1736181649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c34inWLrJLZIxxvrkUgRcAEz+7YrbH7BxLS5ubF+0ts=;
        b=Gwdn+zbpH85EJbNUTl2viwgndGmcIb9DvSv/yob6173gdaj/oRgj56CxBorrxQgPcw
         6HSt1VcNBFTMe2oWMUTSxUoiFUnSCqe3ld7/DP2Si+KcyRLYccghWYhYIihI6Kgq4RpR
         a9JnuOiSuzQl8/fhxpxHyNX7Yz8VndiiZxn9sIwfEh+UCSeL5riJJWEPKbSx0YmNZWFL
         cjrnsRm8AAH3jaxHaJ81VefN5BWtBVJloKFEdxh9xOgf22fjgpvgqb8U8CyyoCW9zjY9
         0ih6ltRwDUZm9XyYvFxUMLXEt3w/OiYZRuVCxfMaW6ZhCJ6O21pVjgsnvR36M7ElKpas
         U3GA==
X-Forwarded-Encrypted: i=1; AJvYcCXHrH5c1d7O8MFkNVOpnWC8SeonvwrHo8eJKQhSrDyuZfZaSwMx7MAHsH9A81+Rjtq/sOrd/aTsvuSOD30=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHy4YpPN+cXaf1p3/Uhg1KZ/QPKCyGwDVaRKqxWCEHYV3g3C2e
	SIytTqjle9I7+uLHBs2TnOCexhlVUTrNpdLk36nccFSRooOHk3k+
X-Gm-Gg: ASbGnctduwGeO3CCJgt2iEvGNuwkvhj1yZDAEPUtKQNz6Q7UOYr4ZqF9j8IV8xSmF/K
	Sp4SiTKoavqb1LZImh2LREdmqj2ypWuZpmXPc1jVIxl7D96cUnrEDuUIW/CrPMscAU6cRflRFiW
	0UpQE3I9pPHa8EfeWWGcngwYFtNq5XPS5h9Av3Rjhqb9kORiZW6ZuJqYHkrb8D6Mltp+iUtGUou
	pj7oM0U/pXvhYSqafTiCUhkRkmvhEliWPARBjq7BZY=
X-Google-Smtp-Source: AGHT+IHjGuXf/XElL7gZWedC8xhQAZYTXimOnHbXw1GRZMDN0TZeLWfDEsWzbMIuXaokGpEKqTCtSA==
X-Received: by 2002:a05:6000:186b:b0:386:3835:9fec with SMTP id ffacd0b85a97d-38a223f76aemr36139683f8f.44.1735576849396;
        Mon, 30 Dec 2024 08:40:49 -0800 (PST)
Received: from krava ([213.175.46.84])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4365c08afcbsm370553605e9.21.2024.12.30.08.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2024 08:40:49 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 30 Dec 2024 17:40:48 +0100
To: Pei Xiao <xiaopei01@kylinos.cn>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] bpf: Use refcount_t instead of atomic_t for mmap_count
Message-ID: <Z3LNEHfLmtSi4wpO@krava>
References: <6ecce439a6bc81adb85d5080908ea8959b792a50.1735542814.git.xiaopei01@kylinos.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ecce439a6bc81adb85d5080908ea8959b792a50.1735542814.git.xiaopei01@kylinos.cn>

On Mon, Dec 30, 2024 at 03:16:55PM +0800, Pei Xiao wrote:
> Use an API that resembles more the actual use of mmap_count.

I'm not sure I understand the issue, could you provide more details?

thanks,
jirka

> 
> Found by cocci:
> kernel/bpf/arena.c:245:6-25: WARNING: atomic_dec_and_test variation before object free at line 249.
> 
> Fixes: b90d77e5fd78 ("bpf: Fix remap of arena.")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202412292037.LXlYSHKl-lkp@intel.com/
> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
> ---
>  kernel/bpf/arena.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 945a5680f6a5..8caf56a308d9 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
> @@ -218,7 +218,7 @@ static u64 arena_map_mem_usage(const struct bpf_map *map)
>  struct vma_list {
>  	struct vm_area_struct *vma;
>  	struct list_head head;
> -	atomic_t mmap_count;
> +	refcount_t mmap_count;
>  };
>  
>  static int remember_vma(struct bpf_arena *arena, struct vm_area_struct *vma)
> @@ -228,7 +228,7 @@ static int remember_vma(struct bpf_arena *arena, struct vm_area_struct *vma)
>  	vml = kmalloc(sizeof(*vml), GFP_KERNEL);
>  	if (!vml)
>  		return -ENOMEM;
> -	atomic_set(&vml->mmap_count, 1);
> +	refcount_set(&vml->mmap_count, 1);
>  	vma->vm_private_data = vml;
>  	vml->vma = vma;
>  	list_add(&vml->head, &arena->vma_list);
> @@ -239,7 +239,7 @@ static void arena_vm_open(struct vm_area_struct *vma)
>  {
>  	struct vma_list *vml = vma->vm_private_data;
>  
> -	atomic_inc(&vml->mmap_count);
> +	refcount_inc(&vml->mmap_count);
>  }
>  
>  static void arena_vm_close(struct vm_area_struct *vma)
> @@ -248,7 +248,7 @@ static void arena_vm_close(struct vm_area_struct *vma)
>  	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
>  	struct vma_list *vml = vma->vm_private_data;
>  
> -	if (!atomic_dec_and_test(&vml->mmap_count))
> +	if (!refcount_dec_and_test(&vml->mmap_count))
>  		return;
>  	guard(mutex)(&arena->lock);
>  	/* update link list under lock */
> -- 
> 2.25.1
> 
> 

