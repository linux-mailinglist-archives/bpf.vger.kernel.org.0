Return-Path: <bpf+bounces-12853-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCA67D151D
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 19:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95896282448
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 17:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48BAA20337;
	Fri, 20 Oct 2023 17:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF481DA22
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 17:48:33 +0000 (UTC)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B71A3
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 10:48:32 -0700 (PDT)
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5892832f8daso1725756a12.0
        for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 10:48:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697824111; x=1698428911;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SCauBUJb5xOc/EPdCberHFtTQ9ZSrWxT/nrVc/2V/FU=;
        b=spR5ZNdP5zV4U/YKGT104EeCXdMtZL3jKcpg1IT2Ttbaj4gLE8f8Bn6VpLd8aMdSPT
         PYIB+4S8nNRGealJgKSas+Pma6PIIlLedBrmB55gAIu9D2yFdWU6/oSRZPE3bh8i7fmC
         5GbwcP7JuaMt1b0QBjGV6tmIM5AiHgRn1WJnZoHKxuuycX0QjMLX1geJiLsM9RAa6Sd7
         Q86tHyEsZvE2ckprKRV951TGb6Q++xsqvwbxmS52S+pzUMOWeqqaha8pPurceCkkY2oZ
         qiJzhowzMQWZZtkQV1B2bqXRYJHjc/IuiAUkZ7K1nM8CBUzKOGNyX0v9uiP+LAq6uNsP
         ZgaA==
X-Gm-Message-State: AOJu0YxQ4CDTwWws7KU5EvdJ+Lp1EZKRInpwbHUzsidmXNiO0RHyyTir
	1ElO+TTiwOkO2JMbSdhZOSM=
X-Google-Smtp-Source: AGHT+IEHj+lz3Ix8M+JITQXr54AgAIZBdPmCCLDyZr6Hmv+d3G5g6JueVWdWU7saSwbUww8DuiKSxQ==
X-Received: by 2002:a17:90a:6b08:b0:274:8951:b5ed with SMTP id v8-20020a17090a6b0800b002748951b5edmr3672577pjj.20.1697824110905;
        Fri, 20 Oct 2023 10:48:30 -0700 (PDT)
Received: from snowbird ([136.25.84.107])
        by smtp.gmail.com with ESMTPSA id p20-20020a17090ad31400b0027d15bd9fa2sm3474346pju.35.2023.10.20.10.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 10:48:30 -0700 (PDT)
Date: Fri, 20 Oct 2023 10:48:27 -0700
From: Dennis Zhou <dennis@kernel.org>
To: Hou Tao <houtao@huaweicloud.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com,
	Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH bpf-next v3 2/7] mm/percpu.c: introduce pcpu_alloc_size()
Message-ID: <ZTK9a4H2iuJrJG+x@snowbird>
References: <20231020133202.4043247-1-houtao@huaweicloud.com>
 <20231020133202.4043247-3-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020133202.4043247-3-houtao@huaweicloud.com>

On Fri, Oct 20, 2023 at 09:31:57PM +0800, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> Introduce pcpu_alloc_size() to get the size of the dynamic per-cpu
> area. It will be used by bpf memory allocator in the following patches.
> BPF memory allocator maintains per-cpu area caches for multiple area
> sizes and its free API only has the to-be-freed per-cpu pointer, so it
> needs the size of dynamic per-cpu area to select the corresponding cache
> when bpf program frees the dynamic per-cpu pointer.
> 
> Acked-by: Dennis Zhou <dennis@kernel.org>
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  include/linux/percpu.h |  1 +
>  mm/percpu.c            | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 32 insertions(+)
> 
> diff --git a/include/linux/percpu.h b/include/linux/percpu.h
> index 68fac2e7cbe67..8c677f185901b 100644
> --- a/include/linux/percpu.h
> +++ b/include/linux/percpu.h
> @@ -132,6 +132,7 @@ extern void __init setup_per_cpu_areas(void);
>  extern void __percpu *__alloc_percpu_gfp(size_t size, size_t align, gfp_t gfp) __alloc_size(1);
>  extern void __percpu *__alloc_percpu(size_t size, size_t align) __alloc_size(1);
>  extern void free_percpu(void __percpu *__pdata);
> +extern size_t pcpu_alloc_size(void __percpu *__pdata);
>  
>  DEFINE_FREE(free_percpu, void __percpu *, free_percpu(_T))
>  
> diff --git a/mm/percpu.c b/mm/percpu.c
> index 76b9c5e63c562..1759b91c8944a 100644
> --- a/mm/percpu.c
> +++ b/mm/percpu.c
> @@ -2244,6 +2244,37 @@ static void pcpu_balance_workfn(struct work_struct *work)
>  	mutex_unlock(&pcpu_alloc_mutex);
>  }
>  
> +/**
> + * pcpu_alloc_size - the size of the dynamic percpu area
> + * @ptr: pointer to the dynamic percpu area
> + *
> + * Returns the size of the @ptr allocation. This is undefined for statically
                                              ^ 

Nit: Alexei, when you pull this, can you make it a double space here?
Just keeps percpu's file consistent.

> + * defined percpu variables as there is no corresponding chunk->bound_map.
> + *
> + * RETURNS:
> + * The size of the dynamic percpu area.
> + *
> + * CONTEXT:
> + * Can be called from atomic context.
> + */
> +size_t pcpu_alloc_size(void __percpu *ptr)
> +{
> +	struct pcpu_chunk *chunk;
> +	unsigned long bit_off, end;
> +	void *addr;
> +
> +	if (!ptr)
> +		return 0;
> +
> +	addr = __pcpu_ptr_to_addr(ptr);
> +	/* No pcpu_lock here: ptr has not been freed, so chunk is still alive */
> +	chunk = pcpu_chunk_addr_search(addr);
> +	bit_off = (addr - chunk->base_addr) / PCPU_MIN_ALLOC_SIZE;
> +	end = find_next_bit(chunk->bound_map, pcpu_chunk_map_bits(chunk),
> +			    bit_off + 1);
> +	return (end - bit_off) * PCPU_MIN_ALLOC_SIZE;
> +}
> +
>  /**
>   * free_percpu - free percpu area
>   * @ptr: pointer to area to free
> -- 
> 2.29.2
> 

Thanks,
Dennis

