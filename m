Return-Path: <bpf+bounces-11673-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA7F7BD0ED
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 00:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70BA71C20A12
	for <lists+bpf@lfdr.de>; Sun,  8 Oct 2023 22:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5CB199A6;
	Sun,  8 Oct 2023 22:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BC3211F
	for <bpf@vger.kernel.org>; Sun,  8 Oct 2023 22:32:21 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C09A3
	for <bpf@vger.kernel.org>; Sun,  8 Oct 2023 15:32:20 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-32483535e51so3958548f8f.0
        for <bpf@vger.kernel.org>; Sun, 08 Oct 2023 15:32:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696804339; x=1697409139;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=agWXTU2Yij2i3Ap0SjGTJ2Rdepm57nHoh7x5LeUftzY=;
        b=KJBmhJSfDmueJSAUmr31MnxRkmzmH0FTiGHxS3GZMcuPkv5sQZhFvE+GYiXvVCIsAB
         BWUZLtquf6ZP+GaIjT1qPCBz16rwwVlVdHFYMJnallAL1XQTiRDjNT7P9RsX2PSV54nJ
         1TwgwdewcrSbYvaPr3hZ+h4xbohHk9HTczFxr3SyIwXd/tKoTMDod3nocQPYce8mZC0L
         hCxdg9EANMt+F5GDLyd9uZDjYgD0SwIRaOLo+qAIO5YvtxGpQiJ8pML8fB72TF4v7HPm
         egR7aIyk0PO5t91n2JgPZgbEIiGCCeFeJOJiVDMtxozfthBwgomaEE9WHBeZtn+r9wH1
         P6Tw==
X-Gm-Message-State: AOJu0YzUgJOAu4Pfcf18mOaTNrIH8uqaviwPkZqtuqdnAZPtJcHTPCqh
	49F6bP0H9IT3Gm8q14STrcQ=
X-Google-Smtp-Source: AGHT+IHzup7h6T7NZ16OB3Cn+I4QiSpINsYCf5NAnllIaELngKdXcHcsJ7bPpIosr4ciiDK3tenQ3A==
X-Received: by 2002:adf:fa12:0:b0:321:685f:e0a7 with SMTP id m18-20020adffa12000000b00321685fe0a7mr12093445wrr.3.1696804338296;
        Sun, 08 Oct 2023 15:32:18 -0700 (PDT)
Received: from snowbird (host86-164-181-115.range86-164.btcentralplus.com. [86.164.181.115])
        by smtp.gmail.com with ESMTPSA id z3-20020a056000110300b0031c6581d55esm7752662wrw.91.2023.10.08.15.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 15:32:17 -0700 (PDT)
Date: Sun, 8 Oct 2023 15:32:15 -0700
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
Subject: Re: [PATCH bpf-next 1/6] mm/percpu.c: introduce alloc_size_percpu()
Message-ID: <ZSMt70tuBrHlI0Xa@snowbird>
References: <20231007135106.3031284-1-houtao@huaweicloud.com>
 <20231007135106.3031284-2-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231007135106.3031284-2-houtao@huaweicloud.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

On Sat, Oct 07, 2023 at 09:51:01PM +0800, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> Introduce alloc_size_percpu() to get the size of the dynamic per-cpu
> area. It will be used by bpf memory allocator in the following patches.
> BPF memory allocator maintains multiple per-cpu area caches for multiple
> area sizes and it needs the size of dynamic per-cpu area to select the
> corresponding cache when bpf program frees the dynamic per-cpu area.
> 
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  include/linux/percpu.h |  1 +
>  mm/percpu.c            | 29 +++++++++++++++++++++++++++++
>  2 files changed, 30 insertions(+)
> 
> diff --git a/include/linux/percpu.h b/include/linux/percpu.h
> index 68fac2e7cbe6..d140d9d79567 100644
> --- a/include/linux/percpu.h
> +++ b/include/linux/percpu.h
> @@ -132,6 +132,7 @@ extern void __init setup_per_cpu_areas(void);
>  extern void __percpu *__alloc_percpu_gfp(size_t size, size_t align, gfp_t gfp) __alloc_size(1);
>  extern void __percpu *__alloc_percpu(size_t size, size_t align) __alloc_size(1);
>  extern void free_percpu(void __percpu *__pdata);
> +extern size_t alloc_size_percpu(void __percpu *__pdata);
>  
>  DEFINE_FREE(free_percpu, void __percpu *, free_percpu(_T))
>  
> diff --git a/mm/percpu.c b/mm/percpu.c
> index 7b40b3963f10..f541cfc3cb2d 100644
> --- a/mm/percpu.c
> +++ b/mm/percpu.c
> @@ -2244,6 +2244,35 @@ static void pcpu_balance_workfn(struct work_struct *work)
>  	mutex_unlock(&pcpu_alloc_mutex);
>  }
>  
> +/**
> + * alloc_size_percpu - the size of the dynamic percpu area

Can we name this pcpu_alloc_size(). A few other functions are
exposed under pcpu_* so it's a bit easier to keep track of.

> + * @ptr: pointer to the dynamic percpu area
> + *
> + * Return the size of the dynamic percpu area @ptr.
> + *
> + * RETURNS:
> + * The size of the dynamic percpu area.
> + *
> + * CONTEXT:
> + * Can be called from atomic context.
> + */
> +size_t alloc_size_percpu(void __percpu *ptr)
> +{
> +	struct pcpu_chunk *chunk;
> +	int bit_off, end;
> +	void *addr;
> +
> +	if (!ptr)
> +		return 0;
> +
> +	addr = __pcpu_ptr_to_addr(ptr);
> +	/* No pcpu_lock here: ptr has not been freed, so chunk is still alive */

Now that percpu variables are floating around more commonly, I think we
or I need to add more validation guards so it's easier to
debug bogus/stale pointers. Potentially like a static_key or Kconfig so
that we take the lock and `test_bit()`.

> +	chunk = pcpu_chunk_addr_search(addr);
> +	bit_off = (addr - chunk->base_addr) / PCPU_MIN_ALLOC_SIZE;
> +	end = find_next_bit(chunk->bound_map, pcpu_chunk_map_bits(chunk), bit_off + 1);

Nit: can you please reflow `bit_off + 1` to the next line. I know we
dropped the line requirement, but percpu.c almost completely still
follows it.

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

