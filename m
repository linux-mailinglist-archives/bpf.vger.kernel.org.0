Return-Path: <bpf+bounces-57711-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 471F3AAED69
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 22:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5508D1BC7370
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 20:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11227289820;
	Wed,  7 May 2025 20:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4yt6LCR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C1B28FFEE;
	Wed,  7 May 2025 20:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746651025; cv=none; b=gQzCd1bDfDcehk4denOOIWNEWfoobiMFJtQGid3f2elxoaz3NpwvfedwQTm9rt3WY15q4bHk4mtNHyO/FFMhB9M6ETWHlSdSEeCchL7iM0h1KLmb/PptIOjcLVC9OXlWaFr5DqVH6YMN/DHCWgCCcVUBb1+jzpwe3PavwRaGrxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746651025; c=relaxed/simple;
	bh=oREyia90vrwjG57m1GjbuJvKXNfgjoa8NvoqFrgTkEA=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=GQ61y11jekA869tdKCBmhNcHNszQp9KZBi6+26Shc2qjdeCSGCmlnv26X3yu+TE3ogrCRgCLX2xHOkPyvwOmArWII1vD6R5e4jAwWecqI304RIRgSf6JRMQahh2YQRq+YL0qQnS99UMbkOAiiqU1eE656ymFop4wdiG/zZAYNyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y4yt6LCR; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7caeeef95d4so25895285a.2;
        Wed, 07 May 2025 13:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746651023; x=1747255823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V+AjIJ8CiVlst9h05Ktre1hME9VZPs8qmDoFr2rJJ6I=;
        b=Y4yt6LCRnlTJOyIic29XdaAj5sPLkxxx1n7vorB+y+Nv/wqQ/hzZeI/EGDu+k0Lx/T
         aWFQl3hIQQeWDVBL3iGfSYeRIJffLrMIlXc6W/ZrowQBEZae0DeVNNnACRxLjIkJMLC1
         qXxiw8h8pQxgtYprJsUrhFMza68q+v0EPPz6tOT/3pOJza7eUmRuCV+UWH3RNIJHgzr7
         qSQFbqdwx6Ak9Qq3DCE57hnoj2YKgDk6JmaH3s0hLTFa9Tw14HzfmbhksHP/vtwoGjqI
         iDKy8FPmaenznsfMEK5dn8E8TjzNR/Rb1sJx7v92xJiYcCboqbciCNOH8jzzaz0SoISt
         zZgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746651023; x=1747255823;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V+AjIJ8CiVlst9h05Ktre1hME9VZPs8qmDoFr2rJJ6I=;
        b=pRTxCWS11X2EcZNHW0uep7FjNqNI75jMBXbzOrz0itwLizb6DKS9L1xpyJ3qFZbTJ+
         GAqYub7x/j3APcuy9jqrf8KRvFaBlKFKb4buSKfXIr44UCNS3RqCcAhJ6krsj5G1ilj2
         FbsSxd4qsRPsBYiu/fB02FZZQJFFqUP2noKk+Ciovh+0u8exSNoh39nx/BdJfeHsdokg
         mQ0ZjvA/x9exJOkidihnsu673fZApn38EMJHo4Q8+Eb2E5ZBxcuODl3bPJYrOpsAML/L
         gsAwbTP8Zp8/I0Zo8vdTWXLwO1MLgb6JgH4ySEqkHaWz8Js3jHL35I9SkPbTMPBTHLhP
         NhOg==
X-Forwarded-Encrypted: i=1; AJvYcCUFDALZou6FctG5bHlJK7P+1WtDc/ABPb4amZKaDbzbNUipxH6xywJE/taGjfDa+dQmp7c=@vger.kernel.org, AJvYcCVoxDAoAimcAFq3EVYsssISUgln68JdTE8hV3Ke5jsVi1RwDdRXOMEHewNTxk57iCcOgoRiFB7f@vger.kernel.org, AJvYcCWWCOOt4lGRONJS7xD//9/QQeM7SLVwP82EfIVyfRBLjlT5NdBeCHefphECMzmFtCNkaB7FX4MM+xXNyXGd@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ0YuZdNSgxao1IG4VwV6KcRk9WV+FZuGtncNhc4GLfql7XnmE
	lELE899BDI53X7Hlf6lSN8DJYvo9u+cHOLRgAiybu0pA5BBift32
X-Gm-Gg: ASbGncvO2CG+hbFd5jYGh6ODtKnt4c3Pwh8Y99B2abPIdmK6guID2C/H4bDWXahJ3Lr
	K374zR5sFHsFt7w29+W1/KXVJFhaW2GiFJ79igtLltfc9fdEdgMPVdNsID2dG8xAnLwS1Yd25PB
	IJrcQ/UiVa45noiTLljnt4J/wfx08Oixvurzcn0QHvpstQ1LRnM1qf0+d4zzbv4GKQYDJnRQwBt
	dvFeFYtrCYLsxb0a8F3MTrhn/IU7ZGxUKVcf9vh2jHWW+4JVimrIy5uguMG79hAx5IN15uHdmYN
	8XP1jWwuMFb8VZYHHa6McQ8w/DzNLUmTtFehvvjE9A/we1wcG2Wi0/xc30TC99g441x9zCuMLG+
	mVhw920tUlrShl/GXYypC
X-Google-Smtp-Source: AGHT+IGHkFRSnW5KO86R7MIbHF4GpOdPYIKH6DrqhThdmSkjT/hDIGKt2BQp0RNiJ7mEoPlJhgTHJQ==
X-Received: by 2002:a05:620a:2916:b0:7ca:f349:4265 with SMTP id af79cd13be357-7caf7376f58mr668594085a.4.1746651022603;
        Wed, 07 May 2025 13:50:22 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7caf7535dc9sm210678885a.49.2025.05.07.13.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 13:50:22 -0700 (PDT)
Date: Wed, 07 May 2025 16:50:21 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jon Kohler <jon@nutanix.com>, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 hawk@kernel.org, 
 john.fastabend@gmail.com, 
 netdev@vger.kernel.org, 
 bpf@vger.kernel.org, 
 jon@nutanix.com, 
 aleksander.lobakin@intel.com, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 linux-kernel@vger.kernel.org (open list)
Message-ID: <681bc78dc5005_20dc6429460@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250506145530.2877229-3-jon@nutanix.com>
References: <20250506145530.2877229-1-jon@nutanix.com>
 <20250506145530.2877229-3-jon@nutanix.com>
Subject: Re: [PATCH net-next 2/4] tun: optimize skb allocation in tun_xdp_one
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jon Kohler wrote:
> Enhance TUN_MSG_PTR batch processing by leveraging bulk allocation from
> the per-CPU NAPI cache via napi_skb_cache_get_bulk. This improves
> efficiency by reducing allocation overhead and is especially useful
> when using IFF_NAPI and GRO is able to feed the cache entries back.
> 
> Handle scenarios where full preallocation of SKBs is not possible by
> gracefully dropping only the uncovered portion of the batch payload.
> 
> Cc: Alexander Lobakin <aleksander.lobakin@intel.com>
> Signed-off-by: Jon Kohler <jon@nutanix.com>
> ---
>  drivers/net/tun.c | 39 +++++++++++++++++++++++++++------------
>  1 file changed, 27 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 87fc51916fce..f7f7490e78dc 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -2354,12 +2354,12 @@ static int tun_xdp_one(struct tun_struct *tun,
>  		       struct tun_file *tfile,
>  		       struct xdp_buff *xdp, int *flush,
>  		       struct tun_page *tpage,
> -		       struct bpf_prog *xdp_prog)
> +		       struct bpf_prog *xdp_prog,
> +		       struct sk_buff *skb)
>  {
>  	unsigned int datasize = xdp->data_end - xdp->data;
>  	struct tun_xdp_hdr *hdr = xdp->data_hard_start;
>  	struct virtio_net_hdr *gso = &hdr->gso;
> -	struct sk_buff *skb = NULL;
>  	struct sk_buff_head *queue;
>  	u32 rxhash = 0, act;
>  	int buflen = hdr->buflen;
> @@ -2381,16 +2381,15 @@ static int tun_xdp_one(struct tun_struct *tun,
>  
>  		act = bpf_prog_run_xdp(xdp_prog, xdp);
>  		ret = tun_xdp_act(tun, xdp_prog, xdp, act);
> -		if (ret < 0) {
> -			put_page(virt_to_head_page(xdp->data));
> +		if (ret < 0)
>  			return ret;
> -		}
>  
>  		switch (ret) {
>  		case XDP_REDIRECT:
>  			*flush = true;
>  			fallthrough;
>  		case XDP_TX:
> +			napi_consume_skb(skb, 1);
>  			return 0;
>  		case XDP_PASS:
>  			break;
> @@ -2403,13 +2402,14 @@ static int tun_xdp_one(struct tun_struct *tun,
>  				tpage->page = page;
>  				tpage->count = 1;
>  			}
> +			napi_consume_skb(skb, 1);
>  			return 0;
>  		}
>  	}
>  
>  build:
> -	skb = build_skb(xdp->data_hard_start, buflen);
> -	if (!skb) {
> +	skb = build_skb_around(skb, xdp->data_hard_start, buflen);
> +	if (unlikely(!skb)) {
>  		ret = -ENOMEM;
>  		goto out;
>  	}
> @@ -2427,7 +2427,6 @@ static int tun_xdp_one(struct tun_struct *tun,
>  
>  	if (tun_vnet_hdr_to_skb(tun->flags, skb, gso)) {
>  		atomic_long_inc(&tun->rx_frame_errors);
> -		kfree_skb(skb);
>  		ret = -EINVAL;
>  		goto out;
>  	}
> @@ -2455,7 +2454,6 @@ static int tun_xdp_one(struct tun_struct *tun,
>  
>  		if (unlikely(tfile->detached)) {
>  			spin_unlock(&queue->lock);
> -			kfree_skb(skb);
>  			return -EBUSY;
>  		}
>  
> @@ -2496,7 +2494,9 @@ static int tun_sendmsg(struct socket *sock, struct msghdr *m, size_t total_len)
>  		struct bpf_prog *xdp_prog;
>  		struct tun_page tpage;
>  		int n = ctl->num;
> -		int flush = 0, queued = 0;
> +		int flush = 0, queued = 0, num_skbs = 0;
> +		/* Max size of VHOST_NET_BATCH */
> +		void *skbs[64];
>  
>  		memset(&tpage, 0, sizeof(tpage));
>  
> @@ -2505,12 +2505,27 @@ static int tun_sendmsg(struct socket *sock, struct msghdr *m, size_t total_len)
>  		bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
>  		xdp_prog = rcu_dereference(tun->xdp_prog);
>  
> -		for (i = 0; i < n; i++) {
> +		num_skbs = napi_skb_cache_get_bulk(skbs, n);
> +
> +		for (i = 0; i < num_skbs; i++) {
> +			struct sk_buff *skb = skbs[i];
>  			xdp = &((struct xdp_buff *)ctl->ptr)[i];
>  			ret = tun_xdp_one(tun, tfile, xdp, &flush, &tpage,
> -					  xdp_prog);
> +					  xdp_prog, skb);
>  			if (ret > 0)
>  				queued += ret;
> +			else if (ret < 0) {
> +				dev_core_stats_rx_dropped_inc(tun->dev);
> +				napi_consume_skb(skb, 1);
> +				put_page(virt_to_head_page(xdp->data));
> +			}
> +		}
> +
> +		/* Handle remaining xdp_buff entries if num_skbs < ctl->num */
> +		for (i = num_skbs; i < ctl->num; i++) {
> +			xdp = &((struct xdp_buff *)ctl->ptr)[i];
> +			dev_core_stats_rx_dropped_inc(tun->dev);
> +			put_page(virt_to_head_page(xdp->data));

The code should attempt to send out packets rather than drop them.



