Return-Path: <bpf+bounces-46709-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 327B69EEA9D
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 16:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E838028117A
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 15:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C813218592;
	Thu, 12 Dec 2024 15:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l2DbvhJK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pamKl+3Q"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE1B21577D
	for <bpf@vger.kernel.org>; Thu, 12 Dec 2024 15:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734016534; cv=none; b=qq+UFuS1C6gS/5e3LPoVCUbbSaAbUYiz0uUH6k14+MiTsT8njDcjgwl7Kn60YKBNDOpDPkOKu+QCZSUKY/FPDuSZFzMiILc+Xb2km/BqieawfwQIPMNCd1bWDzbOGYNR6c2PAF6Mp+Gvf1cKS+BEA9f3O0ctlBDVv9VbdA4ARUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734016534; c=relaxed/simple;
	bh=vKNJrkJOzJP33NvIBJvsVt1P/pXRByR40w8uhPa7gJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F0F32DDnGkEtA1tJN4xKsaDb8DYSq2+dewx2GXRGfvv05+j3i5r+0L3jmMEeFelaSlxjtT79KzeR01Dnm5egsC6qyALOvhz5iOu4vWTSJyNp1k5LvKZCeXW/+4SW3pA6in/ac5ukCSmH0HrdRGFUxf86tI0Z1yrLnQVK5xvoD4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=l2DbvhJK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pamKl+3Q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 12 Dec 2024 16:15:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734016531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4emVGX5GKepZ/jaWhhYiVTv1Ym5mrZk/KN4PTzN7QiA=;
	b=l2DbvhJK9YYMV1DKIxM5b0/6AtJVAOtdqeQQUHzFPzos2HJTwiXcvrNzbE5bAlomrwyvli
	H+bZHxsMpS/32BvSRsojazKgDAWQ5i+hpgAxIFWikj9CBxiLMKq4AMrfdWtqNH1c/ip+fI
	Se2xWbFCt3WA+R65kgsaNDv804+jaqQ8qnOED4WfXsSEQnbp3nyhFtsZ5VlA5ir06CaxA4
	P7S41PbX6EyY9QghnxVqvr9NF0TPAuaFa0a9KS+JykyMzouG0D4HzYg7+WXDXPHrxNlgbF
	gS+pGCFWSK7PBK3di2oPAINuR3n7CwWO5QIOe2eXm27QkO9D7ssvkBW30EHjzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734016531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4emVGX5GKepZ/jaWhhYiVTv1Ym5mrZk/KN4PTzN7QiA=;
	b=pamKl+3Qf1+QZyveYyqL6dfqNAtGdvGhknNoGidk+HGu3eI3KbDvtL/xUBICQV66iUA1EQ
	HDmhzAgNbYJ8GFDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, memxor@gmail.com,
	akpm@linux-foundation.org, peterz@infradead.org, vbabka@suse.cz,
	rostedt@goodmis.org, houtao1@huawei.com, hannes@cmpxchg.org,
	shakeel.butt@linux.dev, mhocko@suse.com, willy@infradead.org,
	tglx@linutronix.de, tj@kernel.org, linux-mm@kvack.org,
	kernel-team@fb.com
Subject: Re: [PATCH bpf-next v2 3/6] locking/local_lock: Introduce
 local_trylock_irqsave()
Message-ID: <20241212151529.oPNxM6JC@linutronix.de>
References: <20241210023936.46871-1-alexei.starovoitov@gmail.com>
 <20241210023936.46871-4-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241210023936.46871-4-alexei.starovoitov@gmail.com>

> diff --git a/include/linux/local_lock_internal.h b/include/linux/local_lock_internal.h
> index 8dd71fbbb6d2..2c0f8a49c2d0 100644
> --- a/include/linux/local_lock_internal.h
> +++ b/include/linux/local_lock_internal.h
> @@ -148,6 +163,14 @@ typedef spinlock_t local_lock_t;
>  		__local_lock(lock);				\
>  	} while (0)
>  
> +#define __local_trylock_irqsave(lock, flags)			\
> +	({							\
> +		typecheck(unsigned long, flags);		\
> +		flags = 0;					\
> +		migrate_disable();				\
> +		spin_trylock(this_cpu_ptr((__lock)));		\

You should probably do a migrate_enable() here if the trylock fails.

> +	})
> +
>  #define __local_unlock(__lock)					\
>  	do {							\
>  		spin_unlock(this_cpu_ptr((__lock)));		\

Sebastian

