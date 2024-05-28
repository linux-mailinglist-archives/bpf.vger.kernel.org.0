Return-Path: <bpf+bounces-30786-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A945B8D25D7
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 22:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AC181F2477A
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 20:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23E0178367;
	Tue, 28 May 2024 20:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GSqc7N9W"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36E1F4EB;
	Tue, 28 May 2024 20:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716928247; cv=none; b=T1lPXxzC058affAIykZxIAgCMT1FuHEp73EotraniMclhn/lWMh1Qn9si02SXr4wL0DxMaKGAo0ZjZL5T0bq1ca61pSAO7gznDhvF/cXUei5BB+u30PzMhJbLzhBGEUIDG9R0x89OtSzyFv7DOZyRMe5gBD6GO0c9gt0n3y9g0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716928247; c=relaxed/simple;
	bh=ZP1V1PX5xMJHcGzZ3BmWo98GFHHt8uSTJsjW7Y+4B0M=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GzBY95y2yWTbM9rwOtPybFgWY1RX6vhWntb8Q/Da/zsgZNeIETJBXlF6swWpbiShZ4l6kToqsVeQJfasY0TunK/39GVaF+GNqN0novVMDPt/XSioC64QHhmRtxKSyHporb0ttC3aPtB9lgrk6qstYOHZEAXsOCJYs9P6MMBuAik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GSqc7N9W; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a59a609dd3fso38090966b.0;
        Tue, 28 May 2024 13:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716928244; x=1717533044; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wxa9leDMBQqxY4da9JkyLPvpBxzGSOQBoL3fVq0BhEQ=;
        b=GSqc7N9Wup95911Hp3+MjMNTf9AxwGC0X8MYs3L0FYFemg8RoZrwhLRb6iwK+0/oRn
         iNZ1tZvtD0bBGKRR2CPVUljgCH44xq56VOC/3hdi7ep98O0RRb+XySIYNi3zmBePLPPY
         9DWRqBJD2dRX3P8yXS84Zr9b5JJEJaUCjMm8SpbvQCYV3wYQoTqHCc6YUzj+/bFFB85R
         myUicxnzW8NYv18NTMKCsYbfuEd2HAAhC6ZBhwTb7c56hm2jndivx1dJeMwJEpAtjeh+
         H6ua2c0QR3klDn14TlDUBoJHv9Tv/s/C/FdrDOMztzOws0etb+gQEdd1Y2/98M2i1zIc
         GxWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716928244; x=1717533044;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wxa9leDMBQqxY4da9JkyLPvpBxzGSOQBoL3fVq0BhEQ=;
        b=vEvtQfYP9k5nLFm7oGcgKnQ2oiypmp0F9do41gdSXSFPxyE+RMs3l+j/5SInpu6qku
         H6CXedcCbDHk+ysPbfg4UgDZ19YFRIWO33EZom6KaZNon+fFtw7Hk/HHXr9Oesrn3JBp
         gWRQtz9DGjaSOQ6Li7YrcOsfQ5wMpTHwfUvgrHtEFaD09+3sVHkDCZtzHhuoJDGFWNBW
         DWmmyB5xMg+F/da1ZBHcT6YETAQFJbjtmUxSfgHiilEZPFGSeK4W6MvDHwowR/hOC8Uw
         h0dthdppSASR/7JQwAV3ZYpAWrbDd/xholZfSDHX4DXhY4cnCfaul8vb7ewcxZNyo0sv
         h1qQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVoGGx8oH4UeF5+N3u7HuJDeycSzmT64n7yJJ0ENOqyxB3HpLtrdVToM2eYil5EYNKMf+jO0tnlDXOGXnJb7jBqzM9
X-Gm-Message-State: AOJu0YyFMOfT3gN84scK56Clv319WycoHU47Sirun9AY8F6Lym37CAZi
	vItmr0LILjaUjO6p7wsdEwx3UxY5dEaHNlU2X7S+gtQ3/JzydcGE
X-Google-Smtp-Source: AGHT+IFr5kgtYaMOxMY5JPPqiEfEKrj0VBMZhNOOBDwbkpnacPbU6enNJr768HawA8aG44+8QJueCg==
X-Received: by 2002:a17:906:a294:b0:a5c:dad0:c464 with SMTP id a640c23a62f3a-a642d267093mr14114466b.6.1716928243936;
        Tue, 28 May 2024 13:30:43 -0700 (PDT)
Received: from krava ([83.240.60.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6283119b12sm569946766b.192.2024.05.28.13.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 13:30:43 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 28 May 2024 22:30:41 +0200
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
	mhiramat@kernel.org, bpf@vger.kernel.org,
	Matt Wu <wuqiang.matt@bytedance.com>
Subject: Re: [PATCH 2/2] objpool: cache nr_possible_cpus() and avoid caching
 nr_cpu_ids
Message-ID: <ZlY-8ZI_irTK9MAk@krava>
References: <20240424215214.3956041-1-andrii@kernel.org>
 <20240424215214.3956041-3-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240424215214.3956041-3-andrii@kernel.org>

On Wed, Apr 24, 2024 at 02:52:14PM -0700, Andrii Nakryiko wrote:
> Profiling shows that calling nr_possible_cpus() in objpool_pop() takes
> a noticeable amount of CPU (when profiled on 80-core machine), as we
> need to recalculate number of set bits in a CPU bit mask. This number
> can't change, so there is no point in paying the price for recalculating
> it. As such, cache this value in struct objpool_head and use it in
> objpool_pop().
> 
> On the other hand, cached pool->nr_cpus isn't necessary, as it's not
> used in hot path and is also a pretty trivial value to retrieve. So drop
> pool->nr_cpus in favor of using nr_cpu_ids everywhere. This way the size
> of struct objpool_head remains the same, which is a nice bonus.
> 
> Same BPF selftests benchmarks were used to evaluate the effect. Using
> changes in previous patch (inlining of objpool_pop/objpool_push) as
> baseline, here are the differences:
> 
> BASELINE
> ========
> kretprobe      :    9.937 ± 0.174M/s
> kretprobe-multi:   10.440 ± 0.108M/s
> 
> AFTER
> =====
> kretprobe      :   10.106 ± 0.120M/s (+1.7%)
> kretprobe-multi:   10.515 ± 0.180M/s (+0.7%)

nice, overall lgtm

jirka

> 
> Cc: Matt (Qiang) Wu <wuqiang.matt@bytedance.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  include/linux/objpool.h |  6 +++---
>  lib/objpool.c           | 12 ++++++------
>  2 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/objpool.h b/include/linux/objpool.h
> index d8b1f7b91128..cb1758eaa2d3 100644
> --- a/include/linux/objpool.h
> +++ b/include/linux/objpool.h
> @@ -73,7 +73,7 @@ typedef int (*objpool_fini_cb)(struct objpool_head *head, void *context);
>   * struct objpool_head - object pooling metadata
>   * @obj_size:   object size, aligned to sizeof(void *)
>   * @nr_objs:    total objs (to be pre-allocated with objpool)
> - * @nr_cpus:    local copy of nr_cpu_ids
> + * @nr_possible_cpus: cached value of num_possible_cpus()
>   * @capacity:   max objs can be managed by one objpool_slot
>   * @gfp:        gfp flags for kmalloc & vmalloc
>   * @ref:        refcount of objpool
> @@ -85,7 +85,7 @@ typedef int (*objpool_fini_cb)(struct objpool_head *head, void *context);
>  struct objpool_head {
>  	int                     obj_size;
>  	int                     nr_objs;
> -	int                     nr_cpus;
> +	int                     nr_possible_cpus;
>  	int                     capacity;
>  	gfp_t                   gfp;
>  	refcount_t              ref;
> @@ -176,7 +176,7 @@ static inline void *objpool_pop(struct objpool_head *pool)
>  	raw_local_irq_save(flags);
>  
>  	cpu = raw_smp_processor_id();
> -	for (i = 0; i < num_possible_cpus(); i++) {
> +	for (i = 0; i < pool->nr_possible_cpus; i++) {
>  		obj = __objpool_try_get_slot(pool, cpu);
>  		if (obj)
>  			break;
> diff --git a/lib/objpool.c b/lib/objpool.c
> index f696308fc026..234f9d0bd081 100644
> --- a/lib/objpool.c
> +++ b/lib/objpool.c
> @@ -50,7 +50,7 @@ objpool_init_percpu_slots(struct objpool_head *pool, int nr_objs,
>  {
>  	int i, cpu_count = 0;
>  
> -	for (i = 0; i < pool->nr_cpus; i++) {
> +	for (i = 0; i < nr_cpu_ids; i++) {
>  
>  		struct objpool_slot *slot;
>  		int nodes, size, rc;
> @@ -60,8 +60,8 @@ objpool_init_percpu_slots(struct objpool_head *pool, int nr_objs,
>  			continue;
>  
>  		/* compute how many objects to be allocated with this slot */
> -		nodes = nr_objs / num_possible_cpus();
> -		if (cpu_count < (nr_objs % num_possible_cpus()))
> +		nodes = nr_objs / pool->nr_possible_cpus;
> +		if (cpu_count < (nr_objs % pool->nr_possible_cpus))
>  			nodes++;
>  		cpu_count++;
>  
> @@ -103,7 +103,7 @@ static void objpool_fini_percpu_slots(struct objpool_head *pool)
>  	if (!pool->cpu_slots)
>  		return;
>  
> -	for (i = 0; i < pool->nr_cpus; i++)
> +	for (i = 0; i < nr_cpu_ids; i++)
>  		kvfree(pool->cpu_slots[i]);
>  	kfree(pool->cpu_slots);
>  }
> @@ -130,13 +130,13 @@ int objpool_init(struct objpool_head *pool, int nr_objs, int object_size,
>  
>  	/* initialize objpool pool */
>  	memset(pool, 0, sizeof(struct objpool_head));
> -	pool->nr_cpus = nr_cpu_ids;
> +	pool->nr_possible_cpus = num_possible_cpus();
>  	pool->obj_size = object_size;
>  	pool->capacity = capacity;
>  	pool->gfp = gfp & ~__GFP_ZERO;
>  	pool->context = context;
>  	pool->release = release;
> -	slot_size = pool->nr_cpus * sizeof(struct objpool_slot);
> +	slot_size = nr_cpu_ids * sizeof(struct objpool_slot);
>  	pool->cpu_slots = kzalloc(slot_size, pool->gfp);
>  	if (!pool->cpu_slots)
>  		return -ENOMEM;
> -- 
> 2.43.0
> 
> 

