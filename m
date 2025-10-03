Return-Path: <bpf+bounces-70301-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98774BB743D
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 17:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52570424A10
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 15:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7904A283CB0;
	Fri,  3 Oct 2025 15:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r8W9bJSe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9789878F4A
	for <bpf@vger.kernel.org>; Fri,  3 Oct 2025 15:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759503684; cv=none; b=msG6KuSLQrFHIqjo9wCOoeolN+6Gq6FkpWiKU7mHao2KEpSClqob3A6BhDUGhzb5isggW8tfwUMmX9y/H3b9soS/SMZm2mgwDxl01sC10w46lfg/Sw7+0Z/VEP0L/Z0NFpjnoq7ekT4XrxteVwRNayZG5GRtgAM5nyX/NAdwyWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759503684; c=relaxed/simple;
	bh=LVDJBgXtoMN71uCAVEeMR+49ypUsWLxZrHU16qX+6gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RDnOxdenJESNlaylDDyWgwjMe8jCsCfbm9uoYv9FN1VV6l090dqCN8VxPCdjNf+B/BI7WuMAi3GFm2NGoc/gQJozGV6F7+JjIdIZnUnyBQFMC+mzw4aYYSau+sjK8JgmwzMLgpRvRSRqjVY5RMJJD8CwgH7Zp5j25ITeyf0w9Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r8W9bJSe; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2731ff54949so149705ad.1
        for <bpf@vger.kernel.org>; Fri, 03 Oct 2025 08:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759503682; x=1760108482; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0zenS1wKelhByRdZ8R4MywqW+WKf5VchsSGKYTzbwgA=;
        b=r8W9bJSe7YOuOheQUVYNUsZ+f/R4w1pbby/yr52deeKtWXWRkIbKh0b7/37Fx0ZBu1
         rGnF6+swOxci60Ga+hdgiKKKIUPMPbfhbok5NGAnvm6nT5u09kjx+26XRQew5vfh95SU
         opoo8+PXAzs4f0veDciHTplf3g5MwZDW4EZcA9184Vr72hyea+lqZFi9tz1ncyqvd9kY
         L5uT7uZ++FX7Hri2PxTl8XRZpcE5/h+R6MJkcA/vuh7txpTFv3sFmlfO9dCchraJW40o
         lPpMl+b+lKLK79/4y8O8+5ZX8Z285RD5742EuixPu7qwr8QfmVU9HBreD8UUoJ+RXGaV
         34gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759503682; x=1760108482;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0zenS1wKelhByRdZ8R4MywqW+WKf5VchsSGKYTzbwgA=;
        b=p+ihdlJyQRlE/HgOoIOlXB3H4CJ9wrG8Ekeu7jI1AU3lRdCMaM35hejpv59QnZm+pG
         CSDpNxRU+FIlhFlZ41sv24nwsxR29btk+pHfDD3eawkD2mHkOFOAr0gwMFXXHhBQn/sw
         lANvHt4SceeOgj1HudsxMxI8vbx6V2NSajj/ya+w4/oMEwTeAipLOYkziF4bKiY1Jozx
         ULEYUsFX2epOrbuT+Ewr5Rvt/Yu7Q06q7Vnb5RdkDfEPTrcajnpkdyo1nFX9WboVG2ej
         Hy1ziEgDBXMhqPg0E74Z/4PPkplQxZg1Lqj6/Z/A5ion1ik/falJNyf3D8cGELhZrvMb
         1OwQ==
X-Gm-Message-State: AOJu0YzPADNhCkSTXiBNnnLqCu0R7xllbbFii2EbJS5rRN4GICgKx/gl
	EeTZU2cyHOTBLDDU9NalSUXzq06gxXBWSl/Yc/Gx5xz83H+VkWzGnQkZ1B4q3E26YpuHDvJIb5X
	k+8bL3Q==
X-Gm-Gg: ASbGncuVLT86ctrM2W6lm1tHQgVQJJJLqqxqhSALs/w7GIjHAtpfrYVHN1Et9zJz+Cb
	VQyIhsDzFAjKHuUZxEtGXyn8o5DCY69iq295Q7eqiIRkzoQ2EPu4nT0r4cOV1XKsGk94951AK3Y
	nh7Nkd4eMQSvAy6X/3Zh8YzGzEufyQBltjHn8kJH3gS3aYvmv092Kwdec9U6x+gv5XJc0lNLFmg
	oo5INbj+HvUIiMzW2xe1T8ImzDaP7NRLSNFqFPHFuqBrQO1OyQAdaCY5FpCiRDgbANW2ZgY6W2p
	bQ2gBPc4XbzxEWn3Oi0DqCZD22qRBdGdrxk8x5bScG4q/8vnAewFQ1lM2X81CD9XaHMmM8QIvUN
	pCvdTyph0orco9lMJ8iafJuGCQv8V1m7XrZWUOwn9SjGWVe10HQ+rao7NuxUNlB+PtCAjNnpwZD
	/CCQ+cSEclD7j91Q==
X-Google-Smtp-Source: AGHT+IHQSlB6y0yoS/2SJRGI6OmxNreWIDSNmKLWw1s8pQn38QPypGMNjNRREJMfXdM8WQ5+i1jsOQ==
X-Received: by 2002:a17:903:2447:b0:275:8110:7a4d with SMTP id d9443c01a7336-28e9a1d169fmr4442805ad.0.1759503680938;
        Fri, 03 Oct 2025 08:01:20 -0700 (PDT)
Received: from google.com (133.101.105.34.bc.googleusercontent.com. [34.105.101.133])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099f73537sm4826900a12.43.2025.10.03.08.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 08:01:20 -0700 (PDT)
Date: Fri, 3 Oct 2025 15:01:16 +0000
From: Jordan Rife <jrife@google.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Yusuke Suzuki <yusuke.suzuki@isovalent.com>, Julian Wiedmann <jwi@isovalent.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH bpf] bpf: Fix metadata_dst leak
 __bpf_redirect_neigh_v{4,6}
Message-ID: <76nzfqbnb7dfbzrezpaeudtdzub7l26v6fdubbif6quu3hyvcv@gfhmjdh64r2c>
References: <20251003073418.291171-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003073418.291171-1-daniel@iogearbox.net>

On Fri, Oct 03, 2025 at 09:34:18AM +0200, Daniel Borkmann wrote:
> Cilium has a BPF egress gateway feature which forces outgoing K8s Pod
> traffic to pass through dedicated egress gateways which then SNAT the
> traffic in order to interact with stable IPs outside the cluster.
> 
> The traffic is directed to the gateway via vxlan tunnel in collect md
> mode. A recent BPF change utilized the bpf_redirect_neigh() helper to
> forward packets after the arrival and decap on vxlan, which turned out
> over time that the kmalloc-256 slab usage in kernel was ever-increasing.
> 
> The issue was that vxlan allocates the metadata_dst object and attaches
> it through a fake dst entry to the skb. The latter was never released
> though given bpf_redirect_neigh() was merely setting the new dst entry
> via skb_dst_set() without dropping an existing one first.
> 
> Fixes: b4ab31414970 ("bpf: Add redirect_neigh helper as redirect drop-in")
> Reported-by: Yusuke Suzuki <yusuke.suzuki@isovalent.com>
> Reported-by: Julian Wiedmann <jwi@isovalent.com>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Martin KaFai Lau <martin.lau@kernel.org>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Jordan Rife <jrife@google.com>
> ---
>  net/core/filter.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index b005363f482c..c3c0b5a37504 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -2281,6 +2281,7 @@ static int __bpf_redirect_neigh_v6(struct sk_buff *skb, struct net_device *dev,
>  		if (IS_ERR(dst))
>  			goto out_drop;
>  
> +		skb_dst_drop(skb);
>  		skb_dst_set(skb, dst);
>  	} else if (nh->nh_family != AF_INET6) {
>  		goto out_drop;
> @@ -2389,6 +2390,7 @@ static int __bpf_redirect_neigh_v4(struct sk_buff *skb, struct net_device *dev,
>  			goto out_drop;
>  		}
>  
> +		skb_dst_drop(skb);
>  		skb_dst_set(skb, &rt->dst);
>  	}
>  
> -- 
> 2.43.0
>

Nice catch!

Reviewed-by: Jordan Rife <jrife@google.com>

