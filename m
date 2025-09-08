Return-Path: <bpf+bounces-67699-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9258DB4886B
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 11:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7415A1B23EA6
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 09:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC432F069E;
	Mon,  8 Sep 2025 09:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Z3qiOu/N"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0782F3C32
	for <bpf@vger.kernel.org>; Mon,  8 Sep 2025 09:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757323709; cv=none; b=Qbyui0SFfLOnWLB2OeM/FAJQcQOOU0978Yzyw08kBN9f5Ezi4NhhmNNT2OlzUoPndgMleKXbeGCxjFBJ/qfXlusprLyZwxD1ESSfiT6z83bp9Y9GXHyaNPEG5bt0Oy2UUXMQ9g5i06/u6TP1hbJkfVeRnQIwiZRCP5pxShbMVCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757323709; c=relaxed/simple;
	bh=TBVEeAm7Jtahmfw3TwXLAhZmf3DGQa3stylZWm+XYAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mUbRc+aU2HOi3qJKhFlqwHuKOkLuwPCUhQEZdLMf74Y/CD5pTWNpy0JH6jryjfQE2twbNasxQJJMNip3R9JXwg80wet/yxbCpR/up/Xrys3Zk5xL/gRWm/V4ByGlUkZfbE0OCD9BFg2bGlY5lz9yz2s8Edia0hn8eyr8up0dIl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Z3qiOu/N; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45de2b517a3so10970105e9.3
        for <bpf@vger.kernel.org>; Mon, 08 Sep 2025 02:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757323702; x=1757928502; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oULmcJMXha8v5gh2i1FU5HOTdqs6IUKbO31Sh0Sihfo=;
        b=Z3qiOu/N5JLeCGJ1KArDUResn2Ooekd2eNrUjiBarf5GOd5FCc0lNZfL9+2w0PXXbw
         SD/FqDX+a16g8ikki+1Ditu/8uB5GK8shol2pJY+23k9q2VpUH0V5yacstCgGQQxcUYx
         7FHIk2G//Ku9nBRKZw/1ZnOmPen/jJvOxaBMYRNhxWYPViZu2ehEd7SBzt0qZq/9tppH
         uzcTa0DWYbVYvZ3NLmfOV99WpEg1m9fQN5iPwCfDpEaZOsz8w0E08hwl+mEcJ1rLQDPS
         ObJFaqbwEGHa+BxmOfs9DLYbGEN9cT0pD9ifsXGiEg4pUyLAfIP3CL7S0b5B1H5iqwqj
         mYvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757323702; x=1757928502;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oULmcJMXha8v5gh2i1FU5HOTdqs6IUKbO31Sh0Sihfo=;
        b=XKgb/QpF/9j0XrAOea01vkjBvAHJvb3bOI+AMZf82XI0/jESGt6rYGa1aq8KoK1FyM
         V7YLgBzw0pRGjHe9htJjq+PIBTWTrObwrp5Et76rUaUxcIay3SuJ4MOwgc9zKCEPJXoV
         n9Vx/ohmGErs9yrYEUfrgd6v2SBpnP0WGHd2ZgU7S7KhUCJ/V7lhhLU4Y66tKUWV24Jf
         /8PGXxzcVxFlc9mArsoXV75Y/irlXw0JQRJ8nK4WNAZMP3fYdzPOC0tseImgdzXDmub8
         kvk0kjgbIt02ibMwvR6nixKHZDf8N+nI0mDMNsyHy/MyAilBbwOETVBdR8bl4m/Jb8Vm
         fxyA==
X-Forwarded-Encrypted: i=1; AJvYcCUHlKWqFtVwfPR8FHQZy/M/7FtgpA57XcqnWpTL0w0cBfe9wHfujd4AXY7TPu6pqzPcSeY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVEdtLDnF2DoXHZjey9KNJA4IjuZUQm8h3pY7ipS8zIqtjAR1y
	PUWeOhv1LWDca8DMhgfniu8cy5NtdTLN/WpSeB4ybgyeuZL9eGmOZeUoN/xIEvpGoZw=
X-Gm-Gg: ASbGncuSMZnzbqpew5S56ffNLLsQUEsX3WT8itLzM825gInW+KteRlNCryZrxlu+nSk
	FCIRzaUv9LnUoobjWFZtxWkLqQxlHRov+zVGnw2b+G8FBfcIcbz1QuWWENlqFrSucTyvLlUSwkd
	St1n0DfDDU5McgEv5uOEGkrmCFb4QHLa0W1IjGPc0YNG7KMB4mXt39AKpcoEQR+Ne9DR+yYYlln
	URe1YTTr0N3briwykfDgxatjFiYK9wTvGYqY3riwAWpdmJ40ew2lHlBjqIEofnudKXXzIUDQBBY
	7DhSqIziVk17ockojLG9aEwBQHAayGvWlMWOupGHa2HfNRILTegEloUpJVUXCBqP7uo+wsHFhii
	IPxQfrcOyCW1Befz+LgKhWGQjczS55Q==
X-Google-Smtp-Source: AGHT+IGGMokDFkj82R0pk4Z/rqNX/HhpeR5ehoF8XM4OAGAn6N/D/anNfAR0B0g0zuYN0L4mk8/Jeg==
X-Received: by 2002:a05:6000:4404:b0:3e6:a8ba:7422 with SMTP id ffacd0b85a97d-3e6a8ba779cmr2767890f8f.10.1757323702096;
        Mon, 08 Sep 2025 02:28:22 -0700 (PDT)
Received: from localhost (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3cf33fba9fbsm40887135f8f.50.2025.09.08.02.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 02:28:21 -0700 (PDT)
Date: Mon, 8 Sep 2025 11:28:20 +0200
From: Michal Hocko <mhocko@suse.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Peilin Ye <yepeilin@google.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org,
	linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: skip cgroup_file_notify if spinning is not allowed
Message-ID: <aL6htMt-jHAaCGLv@tiehlicka>
References: <20250905201606.66198-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905201606.66198-1-shakeel.butt@linux.dev>

On Fri 05-09-25 13:16:06, Shakeel Butt wrote:
> Generally memcg charging is allowed from all the contexts including NMI
> where even spinning on spinlock can cause locking issues. However one
> call chain was missed during the addition of memcg charging from any
> context support. That is try_charge_memcg() -> memcg_memory_event() ->
> cgroup_file_notify().
> 
> The possible function call tree under cgroup_file_notify() can acquire
> many different spin locks in spinning mode. Some of them are
> cgroup_file_kn_lock, kernfs_notify_lock, pool_workqeue's lock. So, let's
> just skip cgroup_file_notify() from memcg charging if the context does
> not allow spinning.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  include/linux/memcontrol.h | 23 ++++++++++++++++-------
>  mm/memcontrol.c            |  7 ++++---
>  2 files changed, 20 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 9dc5b52672a6..054fa34c936a 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -993,22 +993,25 @@ static inline void count_memcg_event_mm(struct mm_struct *mm,
>  	count_memcg_events_mm(mm, idx, 1);
>  }
>  
> -static inline void memcg_memory_event(struct mem_cgroup *memcg,
> -				      enum memcg_memory_event event)
> +static inline void __memcg_memory_event(struct mem_cgroup *memcg,
> +					enum memcg_memory_event event,
> +					bool allow_spinning)
>  {
>  	bool swap_event = event == MEMCG_SWAP_HIGH || event == MEMCG_SWAP_MAX ||
>  			  event == MEMCG_SWAP_FAIL;
>  
>  	atomic_long_inc(&memcg->memory_events_local[event]);

Doesn't this involve locking on 32b? I guess we do not care all that
much but we might want to bail out early on those arches for
!allow_spinning

> -	if (!swap_event)
> +	if (!swap_event && allow_spinning)
>  		cgroup_file_notify(&memcg->events_local_file);
>  
>  	do {
>  		atomic_long_inc(&memcg->memory_events[event]);
> -		if (swap_event)
> -			cgroup_file_notify(&memcg->swap_events_file);
> -		else
> -			cgroup_file_notify(&memcg->events_file);
> +		if (allow_spinning) {
> +			if (swap_event)
> +				cgroup_file_notify(&memcg->swap_events_file);
> +			else
> +				cgroup_file_notify(&memcg->events_file);
> +		}
>  
>  		if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
>  			break;
> @@ -1018,6 +1021,12 @@ static inline void memcg_memory_event(struct mem_cgroup *memcg,
>  		 !mem_cgroup_is_root(memcg));
>  }
>  
> +static inline void memcg_memory_event(struct mem_cgroup *memcg,
> +				      enum memcg_memory_event event)
> +{
> +	__memcg_memory_event(memcg, event, true);
> +}
> +
>  static inline void memcg_memory_event_mm(struct mm_struct *mm,
>  					 enum memcg_memory_event event)
>  {
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 257d2c76b730..dd5cd9d352f3 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2306,12 +2306,13 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  	bool drained = false;
>  	bool raised_max_event = false;
>  	unsigned long pflags;
> +	bool allow_spinning = gfpflags_allow_spinning(gfp_mask);
>  
>  retry:
>  	if (consume_stock(memcg, nr_pages))
>  		return 0;
>  
> -	if (!gfpflags_allow_spinning(gfp_mask))
> +	if (!allow_spinning)
>  		/* Avoid the refill and flush of the older stock */
>  		batch = nr_pages;
>  
> @@ -2347,7 +2348,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  	if (!gfpflags_allow_blocking(gfp_mask))
>  		goto nomem;
>  
> -	memcg_memory_event(mem_over_limit, MEMCG_MAX);
> +	__memcg_memory_event(mem_over_limit, MEMCG_MAX, allow_spinning);
>  	raised_max_event = true;
>  
>  	psi_memstall_enter(&pflags);
> @@ -2414,7 +2415,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  	 * a MEMCG_MAX event.
>  	 */
>  	if (!raised_max_event)
> -		memcg_memory_event(mem_over_limit, MEMCG_MAX);
> +		__memcg_memory_event(mem_over_limit, MEMCG_MAX, allow_spinning);
>  
>  	/*
>  	 * The allocation either can't fail or will lead to more memory
> -- 
> 2.47.3
> 

-- 
Michal Hocko
SUSE Labs

