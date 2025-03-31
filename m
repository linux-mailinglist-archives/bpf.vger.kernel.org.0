Return-Path: <bpf+bounces-54957-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF7FA7648E
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 12:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6454A16A5CE
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 10:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F0C1E0B91;
	Mon, 31 Mar 2025 10:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Su1QJpmS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D172AE8D
	for <bpf@vger.kernel.org>; Mon, 31 Mar 2025 10:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743418380; cv=none; b=rSipxa9lgqRTXL/4cRfuc/Mos+Buh6HFAAnbfcRb/RDQPvhnqjmeqhGgOoCKNuEySmTAv61dC9fa9iIf43K67o+lOfJtPQoytHudTFZaKuTV9HRbcfl9fmdy5oxoHj3ItPXMJMdN8R89J92pkXgflup2GDLP7LgLQ+/47aHbHvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743418380; c=relaxed/simple;
	bh=h1HpzViZ3BjGOFn1CidaT9F4YiMczr4ZKexz9ka0o5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dyz06Y5YcCQH/UpQw3T1EZw1o+Z2qUgb2rqIB+qb4r2NHZuB3rHidn/2QXjllvpAN12OvgmIxNCkWzOv4u0UMYiXtqSMrbEHkcFGxNsTA/RhUIi76urH//+4sn04K4FXTOZpTlUdIUT2mENdQ/klKv5RDNkz6j5O9DoD8InSAis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Su1QJpmS; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e6194e9d2cso8366886a12.2
        for <bpf@vger.kernel.org>; Mon, 31 Mar 2025 03:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1743418377; x=1744023177; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uLzxNg5j/t2QO8pYd3KuhubdixjbDcFsY5dnvsuInnI=;
        b=Su1QJpmS+WEJ11WLVwPPlO9Z97JIKAcsfD6BnKK28T1cBJDnieDtibo8tmCFhSDAGX
         welB+9/NL+NgzMWVSmNGQr532Sen9qKDh7BZnE1CbHBqAGSN3isAwRaOBs0ZQloLaJBV
         HPIxE7t5Vgmn+5ZV6lmu2cX28Jp0tYo1cATcicWeleqYezFTLCGRvjWSmwecJUcOIvHL
         UjgAAVwn3E91iF06vK+MBWkwbscnsyG8YVaig65dUezIrEF1S20i65AgbRmE2u4kLDq7
         K++wGH7Wjbz54Lflny6xpUM1EBfMwpghr6uFxMNQTJGM2njfRiNG443JnRKeila3zA5z
         FwVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743418377; x=1744023177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uLzxNg5j/t2QO8pYd3KuhubdixjbDcFsY5dnvsuInnI=;
        b=FQrhP6Lwk/K8luFuJ7gYqvdKL9WGg4nOBlbMJHgTCa8Yjo1wexqirnki0XyShwPkQt
         LZ1Wpq6d7A9bBgSx+uBuwyXNOWlm8gvOEP0EEXY7DsTv/C2sdnqMYvypgWZmGqmxM6qF
         FCdWxH812jM52lGiGR0t7d16A041bTVRQNU5wkh6D/uzlzeULRXNhnPIGXiEvcvNZJQ4
         zQyrZKSDHeUIzFv0V8QunE5v8zUnzyjXOOdOAAqi/2KQ4q9nLcl+LjOvE1eIRQVcr2yK
         fGl5+sjj7TAabbbtvxmEMq6vQ8SifQ4Wii56UoAoHxwDlPadlq1xZCQLmcyjYA8JBVTS
         YobA==
X-Forwarded-Encrypted: i=1; AJvYcCWkvi4o3Ruw/kjinu3jkwNnt6OC20u/ujwGlLyjpaMvq4A8GA3OVBWwBZ45nSRRVL0AVcE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIYUdwDvJZhcV5+N3ogy8DpW/aAboF5ZfSZJpsZKNWgNHMbpl4
	oEBwJiiNuQDzNSliFJKU10iuIDUkzMVDEloSuYVn0rakWMSo2V7VnD+EqAl+T84=
X-Gm-Gg: ASbGncsoHzgYC9jrto5wrTm9fy1Lab4kxNDwcmcoQgLrn3MCM8DOuJ30p9SRalvGWuI
	sQO3Q82laYRd9maze3NR9zXor4onUgwPbF2C2RA6RJ4BMm7RCVXT0AsOmCKmvFAbTztZJNMZZCH
	xg/G+cWnR4tIqfyseKllj3HpMWXPIYesZh4vf+E9S4FSjzfqgJT0SSQJQJtCeBSzHtJJdls16No
	5Z5cCTBHWZV0tO4V9tZEJXuG2k1ce7bnhKMqzBLc3jL1uOl+z08b5QQj0SQf4jJiFmzLAdYqNgp
	alvqPFZWbjDudyftqagY0wkIpe/4I+6V7ps=
X-Google-Smtp-Source: AGHT+IEXRs3zxTgQlHAMazbr0bvhWUFwCFDuedD5ulDZkwXkLhjmf3hl/TEWnlk1pA0aBh0cVkLlIg==
X-Received: by 2002:a05:6402:4310:b0:5e0:8c55:536 with SMTP id 4fb4d7f45d1cf-5edfcbd2529mr8073398a12.4.1743418376707;
        Mon, 31 Mar 2025 03:52:56 -0700 (PDT)
Received: from localhost ([193.86.92.181])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-5edc16efb06sm5451617a12.37.2025.03.31.03.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 03:52:56 -0700 (PDT)
Date: Mon, 31 Mar 2025 12:52:55 +0200
From: Michal Hocko <mhocko@suse.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, bpf@vger.kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
	akpm@linux-foundation.org, peterz@infradead.org, vbabka@suse.cz,
	bigeasy@linutronix.de, rostedt@goodmis.org, shakeel.butt@linux.dev,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH mm] mm/page_alloc: Avoid second trylock of zone->lock
Message-ID: <Z-p0B27EtOW_lswI@tiehlicka>
References: <20250331002809.94758-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250331002809.94758-1-alexei.starovoitov@gmail.com>

On Sun 30-03-25 17:28:09, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> spin_trylock followed by spin_lock will cause extra write cache
> access. If the lock is contended it may cause unnecessary cache
> line bouncing and will execute redundant irq restore/save pair.
> Therefore, check alloc/fpi_flags first and use spin_trylock or
> spin_lock.
> 
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Fixes: 97769a53f117 ("mm, bpf: Introduce try_alloc_pages() for opportunistic page allocation")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Makes sense. Fixes tag is probably over reaching but whatever.
Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
>  mm/page_alloc.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index e3ea5bf5c459..ffbb5678bc2f 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1268,11 +1268,12 @@ static void free_one_page(struct zone *zone, struct page *page,
>  	struct llist_head *llhead;
>  	unsigned long flags;
>  
> -	if (!spin_trylock_irqsave(&zone->lock, flags)) {
> -		if (unlikely(fpi_flags & FPI_TRYLOCK)) {
> +	if (unlikely(fpi_flags & FPI_TRYLOCK)) {
> +		if (!spin_trylock_irqsave(&zone->lock, flags)) {
>  			add_page_to_zone_llist(zone, page, order);
>  			return;
>  		}
> +	} else {
>  		spin_lock_irqsave(&zone->lock, flags);
>  	}
>  
> @@ -2341,9 +2342,10 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
>  	unsigned long flags;
>  	int i;
>  
> -	if (!spin_trylock_irqsave(&zone->lock, flags)) {
> -		if (unlikely(alloc_flags & ALLOC_TRYLOCK))
> +	if (unlikely(alloc_flags & ALLOC_TRYLOCK)) {
> +		if (!spin_trylock_irqsave(&zone->lock, flags))
>  			return 0;
> +	} else {
>  		spin_lock_irqsave(&zone->lock, flags);
>  	}
>  	for (i = 0; i < count; ++i) {
> @@ -2964,9 +2966,10 @@ struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
>  
>  	do {
>  		page = NULL;
> -		if (!spin_trylock_irqsave(&zone->lock, flags)) {
> -			if (unlikely(alloc_flags & ALLOC_TRYLOCK))
> +		if (unlikely(alloc_flags & ALLOC_TRYLOCK)) {
> +			if (!spin_trylock_irqsave(&zone->lock, flags))
>  				return NULL;
> +		} else {
>  			spin_lock_irqsave(&zone->lock, flags);
>  		}
>  		if (alloc_flags & ALLOC_HIGHATOMIC)
> -- 
> 2.47.1

-- 
Michal Hocko
SUSE Labs

