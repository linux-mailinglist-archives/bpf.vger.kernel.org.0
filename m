Return-Path: <bpf+bounces-48752-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E97A1046E
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 11:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E4427A256F
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 10:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16622229639;
	Tue, 14 Jan 2025 10:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Wj6JZlf0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9196E22960F
	for <bpf@vger.kernel.org>; Tue, 14 Jan 2025 10:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736851175; cv=none; b=E66cODzJdBdxQJpPCdPpkIbEAsG5czSg0X+ZTvBPZMqTwpK8d+cgiYGP6HL/7okEIQ4fJISg803PCdfAw2eacoFYYsEdw3vEjissrkKBKZAC25QR6lCBUuhZz4qBD+dgws2LBHHDaTIVPcTOHpsD6ppTJ17rIGWRIO0Z2RXnuqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736851175; c=relaxed/simple;
	bh=woVodFa4wiuEcb72OniRfB+tbBISLwXJiqugpfA1l5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lSzU7KC2FiZi3KgFDYrJqwiYnGHZ63YwGDPgxHwwH8NB+brbfUS74bBtwLAyFf0QHW9JoTnQt6XpojzqkTwrOSa/XveFhQJS3A5q5KbAik/sRmfdWOjEn71roceZEOXO8weDJEuB0t2+4olmuNHiVPP3RTuqUx4nc1LVBhkrox8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Wj6JZlf0; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-385e1fcb0e1so2749645f8f.2
        for <bpf@vger.kernel.org>; Tue, 14 Jan 2025 02:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1736851172; x=1737455972; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FsRTQIRkFQb4leXv1P1v2eNnz9iWaV1jp8hC6C+H31Q=;
        b=Wj6JZlf0KJ0pKnS3NH9oesWJ9DTR8d2VwJXFvEUPO+3Cls/ADyyaUIRMHSHzsJlNaq
         aQNz2FBYaFKXX+bOL6fv4/AdkkT1k6GIGFbG3qo1d6QdoetvStR1GHvyKa0r8FnqT/0T
         4/DzBTsEqqL3kmooguQiRvqFZt4BZ+XH1cGNK7y+o+pFeP9cmon5+MGDAH5XpyoCMUle
         FJCDz/hw2O6ql5UHTQMjC+gT8LpeD/UiiWfR90zDtHQBV6qaqS+sDMtxw2aPOvf/zeMp
         LHZs3AMXpez7YYCFma2vL8J2rTi0/G7t+bYXwQwsTueVy13tHO8Fjype5oo3zxVz8qkX
         AN9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736851172; x=1737455972;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FsRTQIRkFQb4leXv1P1v2eNnz9iWaV1jp8hC6C+H31Q=;
        b=BOWXAJfb3qod+tK5Y7Ihe1Q5cXl70ua2RXXj3PRXSrLCUxmAc0/XfyCsVM3wIQkbq3
         5STnsPW/ThheD8DXK6S/uSFzj4zw11+SpAnwAMxkRXTi7vOsjjS9hnY2J1l/G9A45naV
         h+VaMdqXtDLtnMPAqlxUg7GdO3dxqUzPLOh3M0yIChpH8wzwcmgQBN4s5Hh/gkNzLKaj
         6/IQ0sjFyp0Lt75HYr2Ajgoyw00zVMmxOdKPHLPChjU9hF9QzIa19w0/gmeMhljcQ0tJ
         CYnuafmewJhv+Ktvo3+s8t2X/5R8Vwv9hj//tv0SulczYQ27ZxVuEOsBOQmU7QWC4kwV
         hxHg==
X-Gm-Message-State: AOJu0YxPBjWI7ro36Y41BKc/CVfTfdqEL5d4psRzmk/FRxMc6je56eQU
	VIT4NUjCOuTXoAo4yDS2r//Si69PKH0s3cUuLrJ2aIlGifFrlBpnNNrwqfl5lEU=
X-Gm-Gg: ASbGncvBgFcn5vCY+8tMYq8soNrZjv5JOuTINGamjemLybhvFtVuyrCloX8rtnCkvSu
	opfrkSr565KdoPOFAen+mSW1wFL1r5qXnyN6xR/swQy3FOMr3eKHXBW7C1C2TEx+h5cpihgX/s+
	Xwpbj9tpGowL5Qoyupek3qUVTOYa4I1Iiz4QV9h6FUxBSM9uNLyDng0O6IzSRDQc1VgtWkFZsCe
	S3aSyacgqNgj2UBVADefCIIA87RTmeTCDq/fr7gr3a8SvA8dwZV3UsT5zfxActTlFZaSg==
X-Google-Smtp-Source: AGHT+IFAVa5tyrLidBCYPwKeJgLed+u3W2u71vh3DJJzVgf1eg7sePiqTjsCTdbp5GPDSJ3Dar9buw==
X-Received: by 2002:a05:6000:709:b0:386:3803:bbd5 with SMTP id ffacd0b85a97d-38a8733a1f9mr23210306f8f.45.1736851170333;
        Tue, 14 Jan 2025 02:39:30 -0800 (PST)
Received: from localhost (109-81-90-202.rct.o2.cz. [109.81.90.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4c1d13sm14618544f8f.91.2025.01.14.02.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 02:39:30 -0800 (PST)
Date: Tue, 14 Jan 2025 11:39:29 +0100
From: Michal Hocko <mhocko@suse.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, memxor@gmail.com,
	akpm@linux-foundation.org, peterz@infradead.org, vbabka@suse.cz,
	bigeasy@linutronix.de, rostedt@goodmis.org, houtao1@huawei.com,
	hannes@cmpxchg.org, shakeel.butt@linux.dev, willy@infradead.org,
	tglx@linutronix.de, jannh@google.com, tj@kernel.org,
	linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH bpf-next v4 4/6] memcg: Use trylock to access memcg
 stock_lock.
Message-ID: <Z4Y-4fkNQJFMEPwh@tiehlicka>
References: <20250114021922.92609-1-alexei.starovoitov@gmail.com>
 <20250114021922.92609-5-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114021922.92609-5-alexei.starovoitov@gmail.com>

On Mon 13-01-25 18:19:20, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Teach memcg to operate under trylock conditions when
> spinning locks cannot be used.
> The end result is __memcg_kmem_charge_page() and
> __memcg_kmem_uncharge_page() are safe to use from
> any context in RT and !RT.

> In !RT the NMI handler may fail to trylock stock_lock.
> In RT hard IRQ and NMI handlers will not attempt to trylock.

I believe this is local_trylock_irqsave specific thing that is not that
interesting for the particular code path. It is more useful to mention
consequences. I would phrase it this way.

local_trylock might fail and this would lead to charge cache bypass if
the calling context doesn't allow spinning (gfpflags_allow_spinning).
In those cases we try to charge the memcg counter directly and fail
early if that is not possible. This might cause a pre-mature charge
failing but it will allow an opportunistic charging that is safe from
try_alloc_pages path.
 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/memcontrol.c | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 7b3503d12aaf..e4c7049465e0 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1756,7 +1756,8 @@ static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
>   *
>   * returns true if successful, false otherwise.
>   */
> -static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
> +static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages,
> +			  gfp_t gfp_mask)
>  {
>  	struct memcg_stock_pcp *stock;
>  	unsigned int stock_pages;
> @@ -1766,7 +1767,11 @@ static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
>  	if (nr_pages > MEMCG_CHARGE_BATCH)
>  		return ret;
>  
> -	local_lock_irqsave(&memcg_stock.stock_lock, flags);
> +	if (!local_trylock_irqsave(&memcg_stock.stock_lock, flags)) {
> +		if (!gfpflags_allow_spinning(gfp_mask))
> +			return ret;
> +		local_lock_irqsave(&memcg_stock.stock_lock, flags);
> +	}
>  
>  	stock = this_cpu_ptr(&memcg_stock);
>  	stock_pages = READ_ONCE(stock->nr_pages);
> @@ -1851,7 +1856,14 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
>  {
>  	unsigned long flags;
>  
> -	local_lock_irqsave(&memcg_stock.stock_lock, flags);
> +	if (!local_trylock_irqsave(&memcg_stock.stock_lock, flags)) {
> +		/*
> +		 * In case of unlikely failure to lock percpu stock_lock
> +		 * uncharge memcg directly.
> +		 */
> +		mem_cgroup_cancel_charge(memcg, nr_pages);
> +		return;
> +	}
>  	__refill_stock(memcg, nr_pages);
>  	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
>  }
> @@ -2196,9 +2208,13 @@ int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  	unsigned long pflags;
>  
>  retry:
> -	if (consume_stock(memcg, nr_pages))
> +	if (consume_stock(memcg, nr_pages, gfp_mask))
>  		return 0;
>  
> +	if (!gfpflags_allow_spinning(gfp_mask))
> +		/* Avoid the refill and flush of the older stock */
> +		batch = nr_pages;
> +
>  	if (!do_memsw_account() ||
>  	    page_counter_try_charge(&memcg->memsw, batch, &counter)) {
>  		if (page_counter_try_charge(&memcg->memory, batch, &counter))
> -- 
> 2.43.5

-- 
Michal Hocko
SUSE Labs

