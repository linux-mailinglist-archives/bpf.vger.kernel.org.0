Return-Path: <bpf+bounces-65003-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E046AB1A321
	for <lists+bpf@lfdr.de>; Mon,  4 Aug 2025 15:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 023871887C88
	for <lists+bpf@lfdr.de>; Mon,  4 Aug 2025 13:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3294B266B6F;
	Mon,  4 Aug 2025 13:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aO7MnoiW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228C51D6187;
	Mon,  4 Aug 2025 13:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754313692; cv=none; b=V+WuYY/LtCf3p0iTZ9nHJUbnGUpvE34ZuSOuNA+KCRuYhrXBCSUUdfvDMnDqyl7AZA8oYOt1GhfbZ2h5ASrkRI+GVBrgeOm4pI5VVCrK+KzXShtri9/wOqfH8FSmZ+QbEmaP66lUwD5rnbMJtVpb01YuH855/Z5OMsxjef73F50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754313692; c=relaxed/simple;
	bh=g2sA1Fds1nlSJJEi/ElywiQ6C4KqAI+ujifxQCtypGg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A83hleVIxIzcaifBr1M3AR6BfEj2o7cnGveU6rOsezyHaxY2RTcwCWG9oJNrGXUFGwQrmyy88dfLgwdm1BGlDWfzCLLBN07Kscdb/0LXYNQHmZWo+ibFjqES47CLRkDcbqNsJgEf5D1tnaa9SY5IrdjlH+EUk4awwWiLrfMXj8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aO7MnoiW; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-af8fd1b80e5so729473866b.2;
        Mon, 04 Aug 2025 06:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754313689; x=1754918489; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4HeCvEqJ9PJPJxZO6EghnJ727smuSZ/NKLaIR+eVjtM=;
        b=aO7MnoiW5Ul/EgbI9wmG8qZG+qsjYhkJzBsLMTKKKAgCpgOR5RO8f0PUpGP8+QPacB
         YzAWpUPxYtdCPeFirNzEdy4ddaH+zmZud9FBhVpQHkwNY9M/MSpRDan1mzcrdtFbIWqj
         4Fq42eezmbuSIUnRqgKIycV8daa+S6LTeA3r0RjMFXYfAXKtJjFPXRr1Hkpy9UKqPy+a
         r7K5FEk7Y+pxihqg6poG0AvTRE9u7/JZxE8U/Z0w6Z4ApyNGw99v40vxSBvyI5Y57fui
         e4YZBj/6oiNyb7f44pr86gTwodsHeq8TNtQ74Xs5yRJqI6VEZa/iUEkpJM6iwtskeGZ7
         vMbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754313689; x=1754918489;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4HeCvEqJ9PJPJxZO6EghnJ727smuSZ/NKLaIR+eVjtM=;
        b=SXuYZrp1SYWwN1vKPkGqnZwqsV0qjvarjbdAfKTlNmr2P/jGnNJaBz0/3vzSzn5MIr
         kSXXm0ERNCfCaHqf1YLFmgEiAYJjYmxcbo4JJkO6EvAf/hhM7OkR1vxRTXh5tP6sjATW
         cMlt8h8zNayQiRFwqaVcEYQEPbXqHQZ+tkeY+1iXK/sYV1Gp3Xd6vLB+LCducCNROccL
         e8ctIxSqv6BC3tucHGLoL3U4eU9ia6Y3iAlPOTm9obz61ORyYRvHMJOPm1CGP/Ini9hD
         oN91LjFBG1/mCfiw5UIamXuDHeelQXE9P5DMgZ+MBeiNE+FlijSk9jQ63fOtfpOu+hVO
         hsBA==
X-Forwarded-Encrypted: i=1; AJvYcCWXQLFUcuvDXrT0mNUVUKJ3BFzhp0A8OX5wAbcNm6wAB4NGnzCmJlJzf2tap3VO9OVN+WA=@vger.kernel.org, AJvYcCXHBk9sz+l12iDpJb8Qx009s+fK0sPDTcgfwWS7c9hWX20qoQrF7Yy8YEI1SMLOCwFUfU8lfR/8@vger.kernel.org, AJvYcCXHiyMEnzaEcuR6sMoF9DarHzmwJgMYDd2vP9wpNlRDY03o2mwBntgfxCkhB7PgIOZE42/l4vMptnXRGvuR@vger.kernel.org
X-Gm-Message-State: AOJu0YxTZCAkLVAc/9IEMpkGf5LW6PgptvVhbtVByuxUZd0gWx7fsNzB
	xMrGMO/K+oVTlDOaOk9NsD8Sbf8fo+o4p5QLFR7OY+Jv3jUlBvaXnWNC
X-Gm-Gg: ASbGncuGk0xVMVlkNsya+d29L1q+6nzjGgu9/+OcS7VFNm8IIF1gb8dcFcAEYOM+aT3
	3gtnssJvNxXHSXL4aSV1Ff0t3pMwcWOQrFyryFcEO5c8LhKzVbKEZKj72GA+kksKXTnVn4R3+Zr
	gsKyR6mEYwECTf0Qb4sxHnSXDqT04P/2DXO0txKtxwL4gUxYeOihZClBa8UGD7+EpyEfLP3XZtn
	/t+9wmymCuRYGCwObef4k2CthFnTiXrBEUvLdHB6DZb654yQt68SUS/+9ypwPPaw5QQmLX7bhqM
	JEIicYbx47zW+CAFGrgJJtd4Zbjb2WG6cpTpV8YZSW1eX2bMeF8Lxy1vbzCGFTu5Gl6ChR00mQk
	5RM/yNiHk
X-Google-Smtp-Source: AGHT+IEqQQxYJKlfzPoqMUFgHU6zIROEhRJl3hS7d/QAoZRcIhvjAFJTl85oWEYcXxqL2Ug3uv6Oaw==
X-Received: by 2002:a17:907:1c12:b0:af8:f9e8:6fae with SMTP id a640c23a62f3a-af9402077e3mr996033666b.46.1754313688819;
        Mon, 04 Aug 2025 06:21:28 -0700 (PDT)
Received: from krava ([173.38.220.40])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a1e89a6sm732669466b.73.2025.08.04.06.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 06:21:27 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 4 Aug 2025 15:21:25 +0200
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
	netdev@vger.kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bpf: Remove redundant __GFP_NOWARN
Message-ID: <aJCz1cRFjEo-Jm1-@krava>
References: <20250804122731.460158-1-rongqianfeng@vivo.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804122731.460158-1-rongqianfeng@vivo.com>

On Mon, Aug 04, 2025 at 08:27:30PM +0800, Qianfeng Rong wrote:
> Commit 16f5dfbc851b ("gfp: include __GFP_NOWARN in GFP_NOWAIT")
> made GFP_NOWAIT implicitly include __GFP_NOWARN.
> 
> Therefore, explicit __GFP_NOWARN combined with GFP_NOWAIT
> (e.g., `GFP_NOWAIT | __GFP_NOWARN`) is now redundant. Let's clean
> up these redundant flags across subsystems.
> 
> No functional changes.
> 
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka


> ---
>  kernel/bpf/devmap.c        | 2 +-
>  kernel/bpf/local_storage.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
> index 482d284a1553..2625601de76e 100644
> --- a/kernel/bpf/devmap.c
> +++ b/kernel/bpf/devmap.c
> @@ -865,7 +865,7 @@ static struct bpf_dtab_netdev *__dev_map_alloc_node(struct net *net,
>  	struct bpf_dtab_netdev *dev;
>  
>  	dev = bpf_map_kmalloc_node(&dtab->map, sizeof(*dev),
> -				   GFP_NOWAIT | __GFP_NOWARN,
> +				   GFP_NOWAIT,
>  				   dtab->map.numa_node);
>  	if (!dev)
>  		return ERR_PTR(-ENOMEM);
> diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
> index 632d51b05fe9..c93a756e035c 100644
> --- a/kernel/bpf/local_storage.c
> +++ b/kernel/bpf/local_storage.c
> @@ -165,7 +165,7 @@ static long cgroup_storage_update_elem(struct bpf_map *map, void *key,
>  	}
>  
>  	new = bpf_map_kmalloc_node(map, struct_size(new, data, map->value_size),
> -				   __GFP_ZERO | GFP_NOWAIT | __GFP_NOWARN,
> +				   __GFP_ZERO | GFP_NOWAIT,
>  				   map->numa_node);
>  	if (!new)
>  		return -ENOMEM;
> -- 
> 2.34.1
> 

