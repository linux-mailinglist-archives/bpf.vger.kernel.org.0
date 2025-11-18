Return-Path: <bpf+bounces-74929-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9137EC6892D
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 10:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id A18912A7E3
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 09:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC252306B33;
	Tue, 18 Nov 2025 09:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ngky8XEj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F003148B3
	for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 09:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763458585; cv=none; b=YEhaRNUnAAwACTpH9xnFT0/DAXeu5/CbJn0isGUhSJD7NatDYf1R0+71YluuB0bQlZ6HzmZ9LFN+q5vM9/WYrio1Kq8okBoJqw+wYMXziRiNZUwTTKQOD6LziacSaOXfA6Di3EQCrBZF4e9ZTOm51HQo4o34atuk7cXdDI4EhtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763458585; c=relaxed/simple;
	bh=xFvX7F5+2D2kTi1KTz3rv71Ui19czvixzv8OriHMuTk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dz3FXIYOrPgKNkwDC0wneewnn33V9GYOtxFxDlYO+nQiYDAfIFQsrJI7B0ve3SG6SRb7wP9IBHa6bfw6T44DuDHQbp/Y5ZoV6d5RntzDcKdH3Ip0+aPZO840lNKBmr4priovILG9jjVX/4r77+EhzjqPfF8bHXNbX37uPxdVh6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ngky8XEj; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-595825c8eb3so5204516e87.0
        for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 01:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763458582; x=1764063382; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6W+PHyYr6Qrds76dKfFFuuKFeLdvDeDYidlI88uaq6Q=;
        b=Ngky8XEje7RZa4SOO2GnRJV37H18zF6OMqjwHW8PyLTrBsqNXihagqdXGJQkrGgNHq
         MLYfp7SY04lQwHIrW4PeihmmUb3PnqNS36KHmyndWEWS07TaUvn5c2OKi7rbQg6HbEde
         LgJImSvRAoRrRt5hEh/DoMQlF8MQtxoSB4uz1wFgHtYPvYBLInXxh4Rl0PsDBpIU6BYb
         iudbjGr27p7lkscx9afylN79/xOU/0E4ZQX0/rhuObfNtOJpUTQGRVnDerDQQLpA8SIS
         z4ZY+lEcX1PZW8CuZ7ByoVxbsbWHRxKCViLpqns0Plo8XbfLoOEaPqDNV81/DYdVYdFv
         VnVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763458582; x=1764063382;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6W+PHyYr6Qrds76dKfFFuuKFeLdvDeDYidlI88uaq6Q=;
        b=nda/ekRL/aw+ZCi/0SLCqDChTKqQse1h0LmYyJf1RfmlllauL/9BM2z+30hXp5h3dv
         pJDGnqgwI9Lpp5wlmY00/EsTJCbeJqbMLQbXCURVFEHLbWJ9HW2h0i16KZCKeb12gH4f
         p5Pe0xhSSm+QlnJdkOLNzpKV3YBVzwLrwy3QS5jM5rscc54PRVTNUJq78lLHJEGKq0yN
         YlkVYi43/LEANRCaxulftATN/STv6hAG7Gv6PwwHgxhQerWcdgVgbeqetypty0o6OPi1
         P4071yzTSazlwSRLAoNuA3CVbxCtWKspl7jYrrmq+knxnZSHKu5nrjf2Siauyb/M2eeJ
         2ckg==
X-Forwarded-Encrypted: i=1; AJvYcCWnkkQGQJ1TAR/EvImpulIPBVal6filSgrgylmekqFjmZV2TYz/15U1MGMCei9mtzHmdgk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz/q7HX4NG/XIrlbrI1QoosvlECYkgNBspxHTtdhv0olfEP8ZS
	+6gAsmYrdU6KNH1ty9bmROuIxkW5Zwo3Fmp7d+7/+L7G7Q7yjwcoLvu6
X-Gm-Gg: ASbGncv7nZJr9IcnnZDHZ6MpbiwV3Uc1ab6t+TZNba7KWVhYXCYY/QhHUi3LalXOSYm
	saP4maMg1LflC2CIAxhnBHF4TyrNTCcmEwsKb1dMCOg/Xzk+IFFJEtDxeLO+sMCa1wOxhowfO53
	GcGIKOMM1As0TeMX7ZTDxu67NCP6z3Jy/D4bW7K1n0aNxAGl6YVITbDONAT5/UcbqlKjHjTnEYq
	ZjaZ3bD1WL9VY1FJs59Mh2AGhauITidaCP8U/E5ZIGD+VvS3puaJdqkEM4dT0H3PLnvz0bTPY1x
	gi01LChBCK7d3IDd8K9lVrz58GvXxTowkwP4lx09J1fKANFVtiJgNvsHy4EeMbGvPAO43AkiAka
	QM48C5INjGF/Dgi2Dzj8hRu8OedWtFGA8Ywrmw+uHu/q0t2u67rK1WN8HTkjicOkM9rWhQOOckI
	MbXy45q8HPvcZ9K9SDcyP5txtaZ1D9iPkodS0ngDmw
X-Google-Smtp-Source: AGHT+IHqG1INewWjsbz6C3IMmcBkNzcGqPXPzD0ZPlJWWzQVtsYRHozq94AhuQEBqm2XBSLncqWcCA==
X-Received: by 2002:a05:6512:39cf:b0:594:27dd:2701 with SMTP id 2adb3069b0e04-5958426d8aemr5807769e87.49.1763458581523;
        Tue, 18 Nov 2025 01:36:21 -0800 (PST)
Received: from pc636 (host-90-233-212-127.mobileonline.telia.com. [90.233.212.127])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-595803ac955sm3817285e87.14.2025.11.18.01.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 01:36:20 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 18 Nov 2025 10:36:18 +0100
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 4/4] mm/vmalloc: cleanup gfp flag use in
 new_vmap_block()
Message-ID: <aRw-Ejy6i4ondJi8@pc636>
References: <20251117173530.43293-1-vishal.moola@gmail.com>
 <20251117173530.43293-5-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117173530.43293-5-vishal.moola@gmail.com>

On Mon, Nov 17, 2025 at 09:35:30AM -0800, Vishal Moola (Oracle) wrote:
> The only caller, vb_alloc(), passes GFP_KERNEL into new_vmap_block()
> which is a subset of GFP_RECLAIM_MASK. Since there's no reason to use
> this mask here, remove it.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  mm/vmalloc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index d343db806170..d55a77977762 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2699,8 +2699,7 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
>  
>  	node = numa_node_id();
>  
> -	vb = kmalloc_node(sizeof(struct vmap_block),
> -			gfp_mask & GFP_RECLAIM_MASK, node);
> +	vb = kmalloc_node(sizeof(struct vmap_block), gfp_mask, node);
>  	if (unlikely(!vb))
>  		return ERR_PTR(-ENOMEM);
>  
> -- 
> 2.51.1
> 
Reviewed-by: "Uladzislau Rezki (Sony)" <urezki@gmail.com>

--
Uladzislau Rezki

