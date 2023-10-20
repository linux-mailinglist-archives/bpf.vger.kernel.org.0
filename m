Return-Path: <bpf+bounces-12789-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AF97D0747
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 06:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 556271C20EDE
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 04:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8512115;
	Fri, 20 Oct 2023 04:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D06C1C38
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 04:09:28 +0000 (UTC)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CB4C9
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 21:09:27 -0700 (PDT)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1ca74e77aecso11517165ad.1
        for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 21:09:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697774967; x=1698379767;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JBPrqlmjNIj3pkUkK5h9WU4rbUin2LukEllYZU8Zu9U=;
        b=o4EyAbpqG1lA53EJyTE8Jv40sUyIKkYxechT/7nEYEdNCVukROZnY8acKKfju2DWuv
         HjQOuxe3IYP1XffqTDrsIJW96i2+LgJzibsV6QBUv2eZWrakcyzjOkW9yNqyOasuLwis
         pzdbEfWSH5fBY3HfdBotK94LsD8TQZx9fSWAsEub2QJowLgKsqeTqSOTLQVR5potdyjk
         XcNgclgFepAOWAaBoczr5k8E+fzZ9A3Z7O5NbsXPXUHSJ4oL4gyDSbE/cdpjoxqtcsLg
         cST+CTo1/1KKbUEaMHYL4QMUmmq8YO6t1zkXjAMjGzYs6AcmRgfLwwCa4o/Snn2bGr5u
         n0+Q==
X-Gm-Message-State: AOJu0YzJPnNRfaVQ8a6g8XSirhq897isV3GXY1bQrVKdp9LyvqbD32GR
	I1FdJtwFCEKlOJP3sSP7Wlw=
X-Google-Smtp-Source: AGHT+IGwTz27h4Q4bf0o73MotCEtkVUsaLpMQCXrwYR+ZdXvkwNIK3WbwjxFNOKgfhIKhL0UV3EkOg==
X-Received: by 2002:a17:902:e847:b0:1b0:3ab6:5140 with SMTP id t7-20020a170902e84700b001b03ab65140mr1224169plg.4.1697774966571;
        Thu, 19 Oct 2023 21:09:26 -0700 (PDT)
Received: from snowbird ([136.25.84.107])
        by smtp.gmail.com with ESMTPSA id jj7-20020a170903048700b001bbfa86ca3bsm498989plb.78.2023.10.19.21.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 21:09:26 -0700 (PDT)
Date: Thu, 19 Oct 2023 21:09:23 -0700
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
Subject: Re: [PATCH bpf-next v2 2/7] mm/percpu.c: introduce pcpu_alloc_size()
Message-ID: <ZTH9c2kj2jpP0SDD@snowbird>
References: <20231018113343.2446300-1-houtao@huaweicloud.com>
 <20231018113343.2446300-3-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018113343.2446300-3-houtao@huaweicloud.com>

On Wed, Oct 18, 2023 at 07:33:38PM +0800, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> Introduce pcpu_alloc_size() to get the size of the dynamic per-cpu
> area. It will be used by bpf memory allocator in the following patches.
> BPF memory allocator maintains per-cpu area caches for multiple area
> sizes and its free API only has the to-be-freed per-cpu pointer, so it
> needs the size of dynamic per-cpu area to select the corresponding cache
> when bpf program frees the dynamic per-cpu pointer.
> 
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  include/linux/percpu.h |  1 +
>  mm/percpu.c            | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 31 insertions(+)
> 
> diff --git a/include/linux/percpu.h b/include/linux/percpu.h
> index 68fac2e7cbe6..8c677f185901 100644
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
> index 76b9c5e63c56..b0cea2dc16a9 100644
> --- a/mm/percpu.c
> +++ b/mm/percpu.c
> @@ -2244,6 +2244,36 @@ static void pcpu_balance_workfn(struct work_struct *work)
>  	mutex_unlock(&pcpu_alloc_mutex);
>  }
>  
> +/**
> + * pcpu_alloc_size - the size of the dynamic percpu area
> + * @ptr: pointer to the dynamic percpu area
> + *
> + * Return the size of the dynamic percpu area @ptr.
> + *

Alexei, can you modify the above comment to:

Returns the size of the @ptr allocation.  This is undefined for statically
defined percpu variables as there is no corresponding chunk->bound_map.

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
> 

Acked-by: Dennis Zhou <dennis@kernel.org>

Thanks,
Dennis

