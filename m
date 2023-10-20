Return-Path: <bpf+bounces-12788-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6EB7D073B
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 05:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72734B2147C
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 03:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1861FBC;
	Fri, 20 Oct 2023 03:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012B81C38
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 03:55:17 +0000 (UTC)
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6BB9E
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 20:55:16 -0700 (PDT)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-1e0ee4e777bso284327fac.3
        for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 20:55:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697774116; x=1698378916;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GL0rTnxX/JHJhmO0PubTkBEvJ+H5orYuhHbybqoZ3rQ=;
        b=Oa5KlR8+pY/TuTCOfaZ5x9I6uoDgLtIn9ZiusPhtBQ4JyLfDKCvly4P8UtbulDo1GU
         wTwefD7taU4EeyRHtbFfdPXEbo4279oy2SLcjCdczj1O9S6spxje7B3NXajatpkyYRke
         DXTonLqeC74E4FAd78wkz5iHPfIn2Jr+8Njmdye1QG2MweSsty7SB3lPczvS5LD7ZeAo
         /Sofz4RqT62difuoKPSUoi4HipjcSN/R/SJT1ujo6KFJYJfpBRjPYI8l9jSZ1jNXcBWT
         EjN9m/IIThCWBbmlBu6t8FPWvckj6LFRlwL4IuEU07OIWxU1seBDEYcMOSpKqdn8Jcca
         d/8Q==
X-Gm-Message-State: AOJu0YzqkYKlg0aG+xyWIAyZhA1A1b0GYLlzfVIyXiZc83Cyah/voO5s
	yANFFftLCb9GtQb11jULcPo=
X-Google-Smtp-Source: AGHT+IEGxU/dDFQbKVbiOUNM/3o4Z54rKfODbJ/7X7xVhTHixvIFjGWQxnl7k/46IVdP7NB2ebgzJw==
X-Received: by 2002:a05:6358:7e07:b0:166:f338:78e3 with SMTP id o7-20020a0563587e0700b00166f33878e3mr837485rwm.21.1697774115018;
        Thu, 19 Oct 2023 20:55:15 -0700 (PDT)
Received: from snowbird ([136.25.84.107])
        by smtp.gmail.com with ESMTPSA id h26-20020aa796da000000b0069343e474bcsm523590pfq.104.2023.10.19.20.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 20:55:14 -0700 (PDT)
Date: Thu, 19 Oct 2023 20:55:11 -0700
From: Dennis Zhou <dennis@kernel.org>
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com,
	Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH bpf-next v2 1/7] mm/percpu.c: don't acquire pcpu_lock for
 pcpu_chunk_addr_search()
Message-ID: <ZTH6H7t7nouUXaEe@snowbird>
References: <20231018113343.2446300-1-houtao@huaweicloud.com>
 <20231018113343.2446300-2-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018113343.2446300-2-houtao@huaweicloud.com>

On Wed, Oct 18, 2023 at 07:33:37PM +0800, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> There is no need to acquire pcpu_lock for pcpu_chunk_addr_search():
> 1) both pcpu_first_chunk & pcpu_reserved_chunk must have been
>    initialized before the invocation of free_percpu().
> 2) The dynamically-created chunk must be valid before the per-cpu
>    pointers allocated from it are freed.
> 
> So acquire pcpu_lock() after the invocation of pcpu_chunk_addr_search().
> 
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  mm/percpu.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/mm/percpu.c b/mm/percpu.c
> index 7b40b3963f10..76b9c5e63c56 100644
> --- a/mm/percpu.c
> +++ b/mm/percpu.c
> @@ -2267,12 +2267,10 @@ void free_percpu(void __percpu *ptr)
>  	kmemleak_free_percpu(ptr);
>  
>  	addr = __pcpu_ptr_to_addr(ptr);
> -
> -	spin_lock_irqsave(&pcpu_lock, flags);
> -
>  	chunk = pcpu_chunk_addr_search(addr);
>  	off = addr - chunk->base_addr;
>  
> +	spin_lock_irqsave(&pcpu_lock, flags);
>  	size = pcpu_free_area(chunk, off);
>  
>  	pcpu_memcg_free_hook(chunk, off, size);
> -- 
> 2.29.2
> 

Acked-by: Dennis Zhou <dennis@kernel.org>

Thanks,
Dennis

