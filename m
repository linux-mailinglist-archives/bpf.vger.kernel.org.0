Return-Path: <bpf+bounces-27195-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4158AA694
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 03:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE03DB2263E
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 01:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9830B8F40;
	Fri, 19 Apr 2024 01:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9CKF7cm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A180553A6;
	Fri, 19 Apr 2024 01:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713490680; cv=none; b=MVU5vIn6KTvmiZZ4XxAbDoPFmxbekPevDkJQ7jQojM9Da05BBN6x2AESo/jrcnSrU/aD+GWUKAlACHIufDkKUeAzM5y1SPPUVkC1e+KYXpQf6o3dOeGoa3YvUNA7qt8T8LDyoAxGbjmsKpp3RJU7DT57FdJx/ye555dQKviBz1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713490680; c=relaxed/simple;
	bh=UYMHsuUrFxQopuPbIS3zIjJBBYtmpFhVOdo7syoe4oc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ksK2pzQgnQB0xiIUCInQG5MbKHOpK9SKMl+qyQxXknkEFQyZ4NAFgCoqeHt9BHAGxwlet84p+FHD6m/u6QGXTuwCXtwICW0mhnmf0cP1XspHI4MKzRcgr8IbZNUhIJmLEc4wNL6FyLY3lDWWe8xURO3el+oXGq1/i75qRwlozCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e9CKF7cm; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6ed2170d89fso1762043b3a.1;
        Thu, 18 Apr 2024 18:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713490678; x=1714095478; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E9G+v/GtJOaWa6VqgZjoJYkrEprmSKqR6JZBM1hfbVE=;
        b=e9CKF7cmX8ghXza2+F7YoPxxxB6rf5A+315PUTEwSQ1bCi2OCgnm+ULOHZFrDilwo4
         6bodrYB8sjwG0XUBaEYUY6siI8AKFl30FS61ly2IpEwBNLy4ObM0LuSha1XNY0v/zqb8
         7yReLBcYgEZzKp+IIYNLXMDNOZ2Y1JHB5iAKaFVFxcWhN4TO1dHhnAMsQi4spZEkAkSE
         MM6L7ikfjHhYty+dJMOYQk0Ed5hpYbSEL2/vhNwo2HXXHuQElifcFpHK90fBGsuoWGWe
         X5efp+ocSWeZIgJwBEkKtlRSO4ROs1fKjJYfAZ3iBru+F/BjtazlOaKAvVWnXasIRcVV
         6nCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713490678; x=1714095478;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E9G+v/GtJOaWa6VqgZjoJYkrEprmSKqR6JZBM1hfbVE=;
        b=K8GKRxHwqhWT8uo1659ZLh+EgU0XfxRP1O3hjeXfybAjg1pml5y/s8IFi2umUu9sGl
         dEat3QXexF53JQ4LbXSr4t3QpIbq8aXw7SY3+PkX+SQ/rNmKRZ+RnTtwBUmb8gc/e6dW
         h9BEk1ddiuvpF34hgwEUK9YJCg0pJQOAPIvpqy0flKdHtAZ8Uz2gCoDQ69W28WqbaswE
         +clIXW2IGLPZsihr3pkdIZcAfMMJH+HD4y5P00nTlNS/ZRdbsvIudgPWmghbsAJhr1LU
         A46q3ei1LTiliKAQEo/ZQQHizfUAMU4xXAfG9egwGOPHIghk6lm/00sXlqY3qAExHuDX
         W4PQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFIrrhqVZy3mczulRn46vwxjy3akBefLMrjpeBrwjMtialBW/8PGp2PHOw1EpC06G7k0Dto9jgz/BzeqHcJvESX5heslXHrtKE+84n1aJp0Ky4cw5JU4Ms3A5l
X-Gm-Message-State: AOJu0YycohvYNJfQAy7dlehoU61f01OcapCIPckPuoXyGIkVvbzlr8Zb
	/fiq9eAGCiFZTlfy2aTd4Wy+cO9l1Jw++ON/JfU2ZHU1rJUbukIb
X-Google-Smtp-Source: AGHT+IE2sjnPk0Ea2rnvQkkkpCEx/snWjEtR8pxPBO37+LD7Vazw9R5nhzssMPUPBK8+uuoxvaEE6w==
X-Received: by 2002:a05:6a20:3c86:b0:1a9:90b8:1c13 with SMTP id b6-20020a056a203c8600b001a990b81c13mr1342544pzj.12.1713490677803;
        Thu, 18 Apr 2024 18:37:57 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id c2-20020a62e802000000b006ed4f616ec4sm2145378pfi.57.2024.04.18.18.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 18:37:57 -0700 (PDT)
Date: Fri, 19 Apr 2024 09:37:50 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	syzbot+af9492708df9797198d6@syzkaller.appspotmail.com,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf] xdp: use flags field to disambiguate broadcast
 redirect
Message-ID: <ZiHK7sCy_cyRoXJ7@Laptop-X1>
References: <20240418071840.156411-1-toke@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240418071840.156411-1-toke@redhat.com>

On Thu, Apr 18, 2024 at 09:18:39AM +0200, Toke Høiland-Jørgensen wrote:
> When redirecting a packet using XDP, the bpf_redirect_map() helper will set
> up the redirect destination information in struct bpf_redirect_info (using
> the __bpf_xdp_redirect_map() helper function), and the xdp_do_redirect()
> function will read this information after the XDP program returns and pass
> the frame on to the right redirect destination.
> 
> When using the BPF_F_BROADCAST flag to do multicast redirect to a whole
> map, __bpf_xdp_redirect_map() sets the 'map' pointer in struct
> bpf_redirect_info to point to the destination map to be broadcast. And
> xdp_do_redirect() reacts to the value of this map pointer to decide whether
> it's dealing with a broadcast or a single-value redirect. However, if the
> destination map is being destroyed before xdp_do_redirect() is called, the
> map pointer will be cleared out (by bpf_clear_redirect_map()) without
> waiting for any XDP programs to stop running. This causes xdp_do_redirect()
> to think that the redirect was to a single target, but the target pointer
> is also NULL (since broadcast redirects don't have a single target), so
> this causes a crash when a NULL pointer is passed to dev_map_enqueue().
> 
> To fix this, change xdp_do_redirect() to react directly to the presence of
> the BPF_F_BROADCAST flag in the 'flags' value in struct bpf_redirect_info
> to disambiguate between a single-target and a broadcast redirect. And only
> read the 'map' pointer if the broadcast flag is set, aborting if that has
> been cleared out in the meantime. This prevents the crash, while keeping
> the atomic (cmpxchg-based) clearing of the map pointer itself, and without
> adding any more checks in the non-broadcast fast path.
> 
> Fixes: e624d4ed4aa8 ("xdp: Extend xdp_redirect_map with broadcast support")
> Reported-and-tested-by: syzbot+af9492708df9797198d6@syzkaller.appspotmail.com
> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
> ---
>  net/core/filter.c | 42 ++++++++++++++++++++++++++++++++----------
>  1 file changed, 32 insertions(+), 10 deletions(-)
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 786d792ac816..8120c3dddf5e 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -4363,10 +4363,12 @@ static __always_inline int __xdp_do_redirect_frame(struct bpf_redirect_info *ri,
>  	enum bpf_map_type map_type = ri->map_type;
>  	void *fwd = ri->tgt_value;
>  	u32 map_id = ri->map_id;
> +	u32 flags = ri->flags;
>  	struct bpf_map *map;
>  	int err;
>  
>  	ri->map_id = 0; /* Valid map id idr range: [1,INT_MAX[ */
> +	ri->flags = 0;
>  	ri->map_type = BPF_MAP_TYPE_UNSPEC;
>  
>  	if (unlikely(!xdpf)) {
> @@ -4378,11 +4380,20 @@ static __always_inline int __xdp_do_redirect_frame(struct bpf_redirect_info *ri,
>  	case BPF_MAP_TYPE_DEVMAP:
>  		fallthrough;
>  	case BPF_MAP_TYPE_DEVMAP_HASH:
> -		map = READ_ONCE(ri->map);
> -		if (unlikely(map)) {
> +		if (unlikely(flags & BPF_F_BROADCAST)) {
> +			map = READ_ONCE(ri->map);
> +
> +			/* The map pointer is cleared when the map is being torn
> +			 * down by bpf_clear_redirect_map()
> +			 */
> +			if (unlikely(!map)) {
> +				err = -ENOENT;
> +				break;
> +			}
> +
>  			WRITE_ONCE(ri->map, NULL);
>  			err = dev_map_enqueue_multi(xdpf, dev, map,
> -						    ri->flags & BPF_F_EXCLUDE_INGRESS);
> +						    flags & BPF_F_EXCLUDE_INGRESS);
>  		} else {
>  			err = dev_map_enqueue(fwd, xdpf, dev);
>  		}
> @@ -4445,9 +4456,9 @@ EXPORT_SYMBOL_GPL(xdp_do_redirect_frame);
>  static int xdp_do_generic_redirect_map(struct net_device *dev,
>  				       struct sk_buff *skb,
>  				       struct xdp_buff *xdp,
> -				       struct bpf_prog *xdp_prog,
> -				       void *fwd,
> -				       enum bpf_map_type map_type, u32 map_id)
> +				       struct bpf_prog *xdp_prog, void *fwd,
> +				       enum bpf_map_type map_type, u32 map_id,
> +				       u32 flags)
>  {
>  	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
>  	struct bpf_map *map;
> @@ -4457,11 +4468,20 @@ static int xdp_do_generic_redirect_map(struct net_device *dev,
>  	case BPF_MAP_TYPE_DEVMAP:
>  		fallthrough;
>  	case BPF_MAP_TYPE_DEVMAP_HASH:
> -		map = READ_ONCE(ri->map);
> -		if (unlikely(map)) {
> +		if (unlikely(flags & BPF_F_BROADCAST)) {
> +			map = READ_ONCE(ri->map);
> +
> +			/* The map pointer is cleared when the map is being torn
> +			 * down by bpf_clear_redirect_map()
> +			 */
> +			if (unlikely(!map)) {
> +				err = -ENOENT;
> +				break;
> +			}
> +
>  			WRITE_ONCE(ri->map, NULL);
>  			err = dev_map_redirect_multi(dev, skb, xdp_prog, map,
> -						     ri->flags & BPF_F_EXCLUDE_INGRESS);
> +						     flags & BPF_F_EXCLUDE_INGRESS);
>  		} else {
>  			err = dev_map_generic_redirect(fwd, skb, xdp_prog);
>  		}
> @@ -4498,9 +4518,11 @@ int xdp_do_generic_redirect(struct net_device *dev, struct sk_buff *skb,
>  	enum bpf_map_type map_type = ri->map_type;
>  	void *fwd = ri->tgt_value;
>  	u32 map_id = ri->map_id;
> +	u32 flags = ri->flags;
>  	int err;
>  
>  	ri->map_id = 0; /* Valid map id idr range: [1,INT_MAX[ */
> +	ri->flags = 0;
>  	ri->map_type = BPF_MAP_TYPE_UNSPEC;
>  
>  	if (map_type == BPF_MAP_TYPE_UNSPEC && map_id == INT_MAX) {
> @@ -4520,7 +4542,7 @@ int xdp_do_generic_redirect(struct net_device *dev, struct sk_buff *skb,
>  		return 0;
>  	}
>  
> -	return xdp_do_generic_redirect_map(dev, skb, xdp, xdp_prog, fwd, map_type, map_id);
> +	return xdp_do_generic_redirect_map(dev, skb, xdp, xdp_prog, fwd, map_type, map_id, flags);
>  err:
>  	_trace_xdp_redirect_err(dev, xdp_prog, ri->tgt_index, err);
>  	return err;
> -- 
> 2.44.0
> 

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

