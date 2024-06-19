Return-Path: <bpf+bounces-32524-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E774590F3F6
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 18:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7509D1F21F48
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 16:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C4C152799;
	Wed, 19 Jun 2024 16:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HEloc2u/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECE01848;
	Wed, 19 Jun 2024 16:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718814138; cv=none; b=XRt47QCflbTaFBlzqhgFl74I8DjJ/3zM8bImXnOqJmD5UoHt6tJq6yk/tmpV2pSHKVzm2dS6pr2LqH35MRqcP3mZ1ILD/xMzF9+KK+x8crAzrHtF55wQrIbN8y0XQ++EvauzwhhdqfZSr4QQpiAM91Ew4HpH6pfN5jGeNAQbsMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718814138; c=relaxed/simple;
	bh=IsSvs8vJzAB6QrmDJJuINQX8sXAnwZ1o3/A6u9zFI6c=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p+KqoIjm9KM/yGjPpX5f1QZIYZyPhkEjNffNCS/3kjVa51dO604d5Mtz/L/5TGz3qVrG0kE8GjEioEm6IoBO03IBtSC0FHzGDj4JjuntoHPXt2EPcldtec2q1lH+1U33Se9ClNELxwt3XRs4q/n5nIJPxovI6OQ1EOidMloEDak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HEloc2u/; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-362bc731810so1503501f8f.1;
        Wed, 19 Jun 2024 09:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718814135; x=1719418935; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P8Nq2A2G674garxMhqxXT5D8eJ9itPY7dy4g98ctkCk=;
        b=HEloc2u/RIu07aiM2LYsCylA7qOK1Pp9T2pEuuF6qvr24RfiKk8caBEkgZCX0T5dqW
         RPG2Jt3guMS1nG348QzCfIMltDq+BPxlsvYjMQ7iCZpkI+RcBJKYbq80q+Zp8Gl0CZ1Q
         RKjK5Xrhud9pNofq4HhR5wE7H68iVkCrlBovmlm7MR8BWcgHYIZuzO4r+2bk2HpyR2j+
         lGpsBRZyNvuKdwRfRT1Xw4MlB9CCyFwIIzVRbbInhIAKs+rfcTmB9JjQB21v8klaXY3i
         fl+iwxd+2zgP0AH7ZdFXBownR4LmLrzR/9cVLmrJynuWUUmFnbyT+vEw7YqcR63zEpqo
         amBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718814135; x=1719418935;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P8Nq2A2G674garxMhqxXT5D8eJ9itPY7dy4g98ctkCk=;
        b=IXcCY6L8UnoeonpeNSv5iGgDC2nlQ0e0JXEY9BbQbsnz8x0l4A8dDdei0w7YxKMesq
         pH44IWzS80qvA5jBT98rYSwKS4svf/rw7FVuwPoA2MdHmlSecHcFKudEsE+TTB8ZFxUB
         GzdiL6H1pdEtVsruoQRQqevmL8MAHaGaABd1lDqn+x3AYdIDQZ3f40P8OkcqlDykdJeB
         7l9dT+4ElvSw1ZQPdk6A5UbItx11XBoIvkbzQt0xoWD4f9gJmiD6J8UnJNVRY2ot8iID
         Ka8RN106psUMiy61T4WANJrulpSilRSq3MGLL4xmKJI5Z2B1ENOkH67wLDD6QIlxdaoX
         jMXA==
X-Forwarded-Encrypted: i=1; AJvYcCUE6kKeE6ao5d7bT7iKj2vWKDsNnRbjBc2t+rVgI7EfOE/QsJiIJNcKub/jeqbBAtXWW5QUpThzhUQtHibUIEw40DGK8rwI+jH3RaDv15k1FGWqpRcwOlBAZcEtvf90EM/g21MPkOdcziBRGUHrtg1ScuhzbyPHiVgOEOhweK+YsLTFcg==
X-Gm-Message-State: AOJu0YyfRp+qaZs0cOjdD888N/761wUPF2wP4Ed4gCbtDXom2YJGPOVV
	f3goA0tiJMeriGkunYnxvl6Qp2SJEgSEp+Vg8Kfud0R9DWxU8Vie
X-Google-Smtp-Source: AGHT+IHEq2/vpeV2ZS149nVdu+6aXWdzIsTynQteI9ekppwXCQ6c7CKWhpb/9Ytanm/P3y+Q7f7bYg==
X-Received: by 2002:adf:e9c8:0:b0:35f:3189:ddd2 with SMTP id ffacd0b85a97d-36317c79ba6mr2590075f8f.35.1718814135013;
        Wed, 19 Jun 2024 09:22:15 -0700 (PDT)
Received: from krava (85-193-35-215.rib.o2.cz. [85.193.35.215])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42286fe9230sm269539285e9.17.2024.06.19.09.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 09:22:14 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 19 Jun 2024 18:22:12 +0200
To: Liao Chang <liaochang1@huawei.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, oleg@redhat.com,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	nathan@kernel.org, peterz@infradead.org, mingo@redhat.com,
	mark.rutland@arm.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next] uprobes: Fix the xol slots reserved for
 uretprobe trampoline
Message-ID: <ZnMFtCsRCVZ6pkp8@krava>
References: <20240619013411.756995-1-liaochang1@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619013411.756995-1-liaochang1@huawei.com>

On Wed, Jun 19, 2024 at 01:34:11AM +0000, Liao Chang wrote:
> When the new uretprobe system call was added [1], the xol slots reserved
> for the uretprobe trampoline might be insufficient on some architecture.

hum, uretprobe syscall is x86_64 specific, nothing was changed wrt slots
or other architectures.. could you be more specific in what's changed?

thanks,
jirka

> For example, on arm64, the trampoline is consist of three instructions
> at least. So it should mark enough bits in area->bitmaps and
> and area->slot_count for the reserved slots.
> 
> [1] https://lore.kernel.org/all/20240611112158.40795-4-jolsa@kernel.org/
> 
> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> ---
>  kernel/events/uprobes.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 2816e65729ac..efd2d7f56622 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -1485,7 +1485,7 @@ void * __weak arch_uprobe_trampoline(unsigned long *psize)
>  static struct xol_area *__create_xol_area(unsigned long vaddr)
>  {
>  	struct mm_struct *mm = current->mm;
> -	unsigned long insns_size;
> +	unsigned long insns_size, slot_nr;
>  	struct xol_area *area;
>  	void *insns;
>  
> @@ -1508,10 +1508,13 @@ static struct xol_area *__create_xol_area(unsigned long vaddr)
>  
>  	area->vaddr = vaddr;
>  	init_waitqueue_head(&area->wq);
> -	/* Reserve the 1st slot for get_trampoline_vaddr() */
> -	set_bit(0, area->bitmap);
> -	atomic_set(&area->slot_count, 1);
>  	insns = arch_uprobe_trampoline(&insns_size);
> +	/* Reserve enough slots for the uretprobe trampoline */
> +	for (slot_nr = 0;
> +	     slot_nr < max((insns_size / UPROBE_XOL_SLOT_BYTES), 1);
> +	     slot_nr++)
> +		set_bit(slot_nr, area->bitmap);
> +	atomic_set(&area->slot_count, slot_nr);
>  	arch_uprobe_copy_ixol(area->pages[0], 0, insns, insns_size);
>  
>  	if (!xol_add_vma(mm, area))
> -- 
> 2.34.1
> 

