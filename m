Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D24B92FCC7E
	for <lists+bpf@lfdr.de>; Wed, 20 Jan 2021 09:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730368AbhATINI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Jan 2021 03:13:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36823 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730362AbhATIMf (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 20 Jan 2021 03:12:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611130269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WYlBb00a1Y6CTzqOK72/0+v2yGyDzKaR7ND9mWSLlUg=;
        b=flwa7LTzwaE0Ea+UaXyg13V6Vml1tRtFlnFxPtfxPiNIR0MEEnAVRoXmDYqGC0y8psarMU
        E5/7IHEMbxE+dHpxIQhRWJhP+zIbgpJE98cZjFTEl5zf6OVB9VoqXHTDIPXKIA2RYXVUcJ
        5ggrhgl9TwNg2Ybgg3xn4aiO06GKLCs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-MFOrpd06OHqkl-5EWNwAmg-1; Wed, 20 Jan 2021 03:11:06 -0500
X-MC-Unique: MFOrpd06OHqkl-5EWNwAmg-1
Received: by mail-wr1-f69.google.com with SMTP id y4so606224wrt.18
        for <bpf@vger.kernel.org>; Wed, 20 Jan 2021 00:11:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WYlBb00a1Y6CTzqOK72/0+v2yGyDzKaR7ND9mWSLlUg=;
        b=iX8Yo+Strh03+LJdmYbvYzZx/BroTm00rCkt8UMOtj8SPN1ODdTYw5zguHCC3Q3cEs
         +SfPiN16/nWLaL23SN/7RJ5byjgsy6DUCxswARWiRdReNFtViGJ2d1cSHJ6SRIVsWXBx
         DggvsRWQjlz7MlQ5ey43WM7pr83BOABQ3xGUdMu8wSjmADY+xJ0GK45fc/QLha977di2
         BVT97w2UpmhMCbDf12HOBmWP2s+D9e+QO+trJxIfiJM3zyAqq2n3+G8baA17tJn7UUQK
         y2LOjn0euXDgY+CUwvEmKKgpy8OHSrgE1stFM6+tRDJRBTgs0zfFP+5o/XiR0m8EeLiB
         un+w==
X-Gm-Message-State: AOAM5323b/8O9IPmgqNT/y9tgEwNsBppuPGCiqa7abx20JPtucHF9DED
        RfHJE9s1omssfY3grG8O6XznK6AWVmVEX2BZ3ePJQq6R2gFvvw8fepOl76pSjSRo5+OUk+FNBFm
        Uf21ZHh36ZyCd
X-Received: by 2002:a05:6000:108b:: with SMTP id y11mr7802701wrw.379.1611130264816;
        Wed, 20 Jan 2021 00:11:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwDkrxOIJwK6Xun2twNrtjYorn/nFwJo1WNi898JtlETus/g4f0F8ik3DrV6+aLfPMu0mMKvg==
X-Received: by 2002:a05:6000:108b:: with SMTP id y11mr7802669wrw.379.1611130264602;
        Wed, 20 Jan 2021 00:11:04 -0800 (PST)
Received: from redhat.com (bzq-79-177-39-148.red.bezeqint.net. [79.177.39.148])
        by smtp.gmail.com with ESMTPSA id u26sm2380200wmm.24.2021.01.20.00.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 00:11:03 -0800 (PST)
Date:   Wed, 20 Jan 2021 03:10:59 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     Alexander Lobakin <alobakin@pm.me>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, bjorn.topel@intel.com,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        virtualization@lists.linux-foundation.org, bpf@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/3] xsk: build skb by page
Message-ID: <20210120030418-mutt-send-email-mst@kernel.org>
References: <cover.1611128806.git.xuanzhuo@linux.alibaba.com>
 <6787e9a100eba47efbff81939e21e97fef492d07.1611128806.git.xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6787e9a100eba47efbff81939e21e97fef492d07.1611128806.git.xuanzhuo@linux.alibaba.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 20, 2021 at 03:50:01PM +0800, Xuan Zhuo wrote:
> This patch is used to construct skb based on page to save memory copy
> overhead.
> 
> This function is implemented based on IFF_TX_SKB_NO_LINEAR. Only the
> network card priv_flags supports IFF_TX_SKB_NO_LINEAR will use page to
> directly construct skb. If this feature is not supported, it is still
> necessary to copy data to construct skb.
> 
> ---------------- Performance Testing ------------
> 
> The test environment is Aliyun ECS server.
> Test cmd:
> ```
> xdpsock -i eth0 -t  -S -s <msg size>
> ```
> 
> Test result data:
> 
> size    64      512     1024    1500
> copy    1916747 1775988 1600203 1440054
> page    1974058 1953655 1945463 1904478
> percent 3.0%    10.0%   21.58%  32.3%
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Reviewed-by: Dust Li <dust.li@linux.alibaba.com>

I can't see the cover letter or 1/3 in this series - was probably
threaded incorrectly?


> ---
>  net/xdp/xsk.c | 104 ++++++++++++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 86 insertions(+), 18 deletions(-)
> 
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 8037b04..817a3a5 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -430,6 +430,87 @@ static void xsk_destruct_skb(struct sk_buff *skb)
>  	sock_wfree(skb);
>  }
>  
> +static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
> +					      struct xdp_desc *desc)
> +{
> +	u32 len, offset, copy, copied;
> +	struct sk_buff *skb;
> +	struct page *page;
> +	char *buffer;

Actually, make this void *, this way you will not need
casts down the road. I know this is from xsk_generic_xmit -
I don't know why it's char * there, either.

> +	int err, i;
> +	u64 addr;
> +
> +	skb = sock_alloc_send_skb(&xs->sk, 0, 1, &err);
> +	if (unlikely(!skb))
> +		return ERR_PTR(err);
> +
> +	addr = desc->addr;
> +	len = desc->len;
> +
> +	buffer = xsk_buff_raw_get_data(xs->pool, addr);
> +	offset = offset_in_page(buffer);
> +	addr = buffer - (char *)xs->pool->addrs;
> +
> +	for (copied = 0, i = 0; copied < len; i++) {
> +		page = xs->pool->umem->pgs[addr >> PAGE_SHIFT];
> +
> +		get_page(page);
> +
> +		copy = min_t(u32, PAGE_SIZE - offset, len - copied);
> +
> +		skb_fill_page_desc(skb, i, page, offset, copy);
> +
> +		copied += copy;
> +		addr += copy;
> +		offset = 0;
> +	}
> +
> +	skb->len += len;
> +	skb->data_len += len;
> +	skb->truesize += len;
> +
> +	refcount_add(len, &xs->sk.sk_wmem_alloc);
> +
> +	return skb;
> +}
> +
> +static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
> +				     struct xdp_desc *desc)
> +{
> +	struct sk_buff *skb = NULL;
> +
> +	if (xs->dev->priv_flags & IFF_TX_SKB_NO_LINEAR) {
> +		skb = xsk_build_skb_zerocopy(xs, desc);
> +		if (IS_ERR(skb))
> +			return skb;
> +	} else {
> +		char *buffer;
> +		u32 len;
> +		int err;
> +
> +		len = desc->len;
> +		skb = sock_alloc_send_skb(&xs->sk, len, 1, &err);
> +		if (unlikely(!skb))
> +			return ERR_PTR(err);
> +
> +		skb_put(skb, len);
> +		buffer = xsk_buff_raw_get_data(xs->pool, desc->addr);
> +		err = skb_store_bits(skb, 0, buffer, len);
> +		if (unlikely(err)) {
> +			kfree_skb(skb);
> +			return ERR_PTR(err);
> +		}
> +	}
> +
> +	skb->dev = xs->dev;
> +	skb->priority = xs->sk.sk_priority;
> +	skb->mark = xs->sk.sk_mark;
> +	skb_shinfo(skb)->destructor_arg = (void *)(long)desc->addr;
> +	skb->destructor = xsk_destruct_skb;
> +
> +	return skb;
> +}
> +
>  static int xsk_generic_xmit(struct sock *sk)
>  {
>  	struct xdp_sock *xs = xdp_sk(sk);
> @@ -446,43 +527,30 @@ static int xsk_generic_xmit(struct sock *sk)
>  		goto out;
>  
>  	while (xskq_cons_peek_desc(xs->tx, &desc, xs->pool)) {
> -		char *buffer;
> -		u64 addr;
> -		u32 len;
> -
>  		if (max_batch-- == 0) {
>  			err = -EAGAIN;
>  			goto out;
>  		}
>  
> -		len = desc.len;
> -		skb = sock_alloc_send_skb(sk, len, 1, &err);
> -		if (unlikely(!skb))
> +		skb = xsk_build_skb(xs, &desc);
> +		if (IS_ERR(skb)) {
> +			err = PTR_ERR(skb);
>  			goto out;
> +		}
>  
> -		skb_put(skb, len);
> -		addr = desc.addr;
> -		buffer = xsk_buff_raw_get_data(xs->pool, addr);
> -		err = skb_store_bits(skb, 0, buffer, len);
>  		/* This is the backpressure mechanism for the Tx path.
>  		 * Reserve space in the completion queue and only proceed
>  		 * if there is space in it. This avoids having to implement
>  		 * any buffering in the Tx path.
>  		 */
>  		spin_lock_irqsave(&xs->pool->cq_lock, flags);
> -		if (unlikely(err) || xskq_prod_reserve(xs->pool->cq)) {
> +		if (xskq_prod_reserve(xs->pool->cq)) {
>  			spin_unlock_irqrestore(&xs->pool->cq_lock, flags);
>  			kfree_skb(skb);
>  			goto out;
>  		}
>  		spin_unlock_irqrestore(&xs->pool->cq_lock, flags);
>  
> -		skb->dev = xs->dev;
> -		skb->priority = sk->sk_priority;
> -		skb->mark = sk->sk_mark;
> -		skb_shinfo(skb)->destructor_arg = (void *)(long)desc.addr;
> -		skb->destructor = xsk_destruct_skb;
> -
>  		err = __dev_direct_xmit(skb, xs->queue_id);
>  		if  (err == NETDEV_TX_BUSY) {
>  			/* Tell user-space to retry the send */
> -- 
> 1.8.3.1

