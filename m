Return-Path: <bpf+bounces-55471-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A674EA810C4
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 17:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B92911B84DE2
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 15:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B516B22B8AC;
	Tue,  8 Apr 2025 15:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IrHdCO6d"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E16288CC;
	Tue,  8 Apr 2025 15:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744127275; cv=none; b=P8Y/cCfAbLL24oNgfQWSbFMAP9XPLcuw8nqaBrM5T/yUh3io38JytXtwxYJq0w7slBiqAxYoJSHJ6GMgGn8urU2srU/PnAFaRwrj5UESehj1x2oqdLtgbo/09CLzSOhASGtZ2Mjk0p9/dr39QQaenL9TuzT2WjfxPEfmpBDN0ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744127275; c=relaxed/simple;
	bh=9pXd1fjsd/UkXlXloKHgwO8078MP0tBnXdk5SpFcPao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qor+QGXseoJM4zrh+lfpJYCyzcOOKVnBbM4rfg8wTLoqhFN6oZrOUTaGjQIVb4cqJ7efoSjvBlohpG9ZKQ/LY6IuaklEsKNU8csbPQwVbpjih3j7PPjIY5FcBamOkDkXbraxPvBrlXi1QzCFl+C1xFY4cYUEvKUHDyyJ9EfAG8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IrHdCO6d; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-39c1ef4acf2so3499334f8f.0;
        Tue, 08 Apr 2025 08:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744127272; x=1744732072; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OF2R80/I/m+psYaKl8m4E9ok2YDgHfmbWkmqjc0ZhBU=;
        b=IrHdCO6dsJuXbQ+9T1LAEPB66iq+K4g8DxCzSc53yrTRdRvVQJi+BFBMYYBxX1mTcs
         9O4EpCVrhn/VWsc0/6bKd+nYUEfdVIE9GKZpWH4sSDJ5HXNzxLrvjWe9mkoYsUWRxZNL
         aHF7slWl94kvDFLnWzOYbhTmr1JlwD8rKy+dcogmMbP0iIEqfYTIW3Rt+HlSg4UH0Dop
         m9qhu1NbcJ7KGRi5mGfV3r/xt1GaxYfM5OW16ptj4h+OcpJH8MBM+gcCYKWQYjmUie0i
         HG3tJwvKqRgpPD25qTtm1pe34hkuZGL5WFGgSUQalyTjc2siHQ+6ySC70xw8e026TvBz
         7CqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744127272; x=1744732072;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OF2R80/I/m+psYaKl8m4E9ok2YDgHfmbWkmqjc0ZhBU=;
        b=Eb8KdbtRMtf4h/c+FbmQr5XbITCvdOLN7v/ELqowg6sHn0QrInuHkZ2b+LLAGSI7Nc
         uTTYIK+ruNUkmgzA13nHkv9I3j34808X5QHNtWdAI2dBW+p6SFBFtDJehJ//vVZXHlgJ
         0H8o/NR28/f3XWc5cRPYk65jiJXmtZE6g8gJMEF/a+CgK0aUD6iLCUVXqXjiGYo+ePtK
         Mp8zSoT8foKZeoEwxl0Vojxpi9TmUDoEyNedhGHjqlZ2tede62YkJZY/uLfdfXKy3njT
         u3eCRs19YfnRd3g76RdR8roYMVobA91dOFGGDfORe8AT45m3wMFLoqUozJrwfRAslEHo
         WIAw==
X-Forwarded-Encrypted: i=1; AJvYcCXvcwU0pAsDhfyv5AQkujMSoNnbhISXDcW55ga6ygJd7EFvRDRod4D1eoDT8DYnmtACeceFvDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxySqBXutycfoe1bimX4r45e/lrFoqcgK3HAiTguL6VJojlsaRE
	9To8aAz+fIrRgGyp0beBBfm5z+0h4/tfvz/ytCnzMZUaI3UcPomU+GDIgA==
X-Gm-Gg: ASbGncswmvI0cpM0PxkAjWNewE57g62jsAvILWUR0hf/tcv+tzBEuO685PquFftL2zi
	0cLaiaOk046/B+WZhQ0iURwtRD/Zz7CGzVnvX2J7qajhmZoLdZ1z5XZYkEw9WKM/aTW9DzC/mKq
	VEkXgQby2mlGx7fctLdgdQn9YfZPInQkY79YvN542S923/fLjFlBsRgawrj07I/UQ60OF3a5uPC
	6JLMTqvhhM8U0PvHQWpvsyo7SvZy4mxrGVp+FwP1XZiu8Zgvn1z5VZ7i95NZhrHl2DtL/xxBrEK
	pmwHlDxzF8IKYXFLMJz0HiOppMB7aY17IZVEDRkO6UFxkJo=
X-Google-Smtp-Source: AGHT+IHHKKolUgiYT3qqV6HCjxg/O5o7+cUUHQwntnVd+b0iAtxfpJm9hR+s2B9Kdo9ACQp5mD6+kg==
X-Received: by 2002:a05:6000:1849:b0:391:ba6:c066 with SMTP id ffacd0b85a97d-39d0de3e88dmr14995337f8f.35.1744127271425;
        Tue, 08 Apr 2025 08:47:51 -0700 (PDT)
Received: from [10.0.0.4] ([37.165.172.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c301b760bsm15366907f8f.55.2025.04.08.08.47.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 08:47:51 -0700 (PDT)
Message-ID: <1ad134d3-4173-4d43-b2ad-0b2c5165bbc1@gmail.com>
Date: Tue, 8 Apr 2025 17:47:49 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V2 2/2] net: sched: generalize check for no-op
 qdisc
To: Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, edumazet@google.com
Cc: bpf@vger.kernel.org, tom@herbertland.com,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 dsahern@kernel.org, makita.toshiaki@lab.ntt.co.jp, kernel-team@cloudflare.com
References: <174412623473.3702169.4235683143719614624.stgit@firesoul>
 <174412628464.3702169.81132659219041209.stgit@firesoul>
Content-Language: en-US
From: Eric Dumazet <eric.dumazet@gmail.com>
In-Reply-To: <174412628464.3702169.81132659219041209.stgit@firesoul>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 4/8/25 5:31 PM, Jesper Dangaard Brouer wrote:
> Several drivers (e.g., veth, vrf) contain open-coded checks to determine
> whether a TX queue has a real qdisc attached - typically by testing if
> qdisc->enqueue is non-NULL.
>
> These checks are functionally equivalent to comparing the queue's qdisc
> pointer against &noop_qdisc (qdisc named "noqueue"). This equivalence
> stems from noqueue_init(), which explicitly clears the enqueue pointer
> for the "noqueue" qdisc. As a result, __dev_queue_xmit() treats the qdisc
> as a no-op only when enqueue == NULL.
>
> This patch introduces a common helper, qdisc_txq_is_noop() to standardize
> this check. The helper is added in sch_generic.h and replaces open-coded
> logic in both the veth and vrf drivers.
>
> This is a non-functional change.
>
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
> ---
>   drivers/net/veth.c        |   14 +-------------
>   drivers/net/vrf.c         |    3 +--
>   include/net/sch_generic.h |    7 ++++++-
>   3 files changed, 8 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index f29a0db2ba36..83c7758534da 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c
> @@ -341,18 +341,6 @@ static bool veth_skb_is_eligible_for_gro(const struct net_device *dev,
>   		 rcv->features & (NETIF_F_GRO_FRAGLIST | NETIF_F_GRO_UDP_FWD));
>   }
>   
> -/* Does specific txq have a real qdisc attached? - see noqueue_init() */
> -static inline bool txq_has_qdisc(struct netdev_queue *txq)
> -{
> -	struct Qdisc *q;
> -
> -	q = rcu_dereference(txq->qdisc);
> -	if (q->enqueue)
> -		return true;
> -	else
> -		return false;
> -}
> -
>   static netdev_tx_t veth_xmit(struct sk_buff *skb, struct net_device *dev)
>   {
>   	struct veth_priv *rcv_priv, *priv = netdev_priv(dev);
> @@ -399,7 +387,7 @@ static netdev_tx_t veth_xmit(struct sk_buff *skb, struct net_device *dev)
>   		 */
>   		txq = netdev_get_tx_queue(dev, rxq);
>   
> -		if (!txq_has_qdisc(txq)) {
> +		if (qdisc_txq_is_noop(txq)) {
>   			dev_kfree_skb_any(skb);
>   			goto drop;
>   		}
> diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
> index 7168b33adadb..d4fe36c55f29 100644
> --- a/drivers/net/vrf.c
> +++ b/drivers/net/vrf.c
> @@ -349,9 +349,8 @@ static bool qdisc_tx_is_default(const struct net_device *dev)
>   		return false;
>   
>   	txq = netdev_get_tx_queue(dev, 0);
> -	qdisc = rcu_access_pointer(txq->qdisc);
>   
> -	return !qdisc->enqueue;
> +	return qdisc_txq_is_noop(txq);
>   }
>   
>   /* Local traffic destined to local address. Reinsert the packet to rx
> diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
> index d48c657191cd..eb90d5103371 100644
> --- a/include/net/sch_generic.h
> +++ b/include/net/sch_generic.h
> @@ -803,6 +803,11 @@ static inline bool qdisc_tx_changing(const struct net_device *dev)
>   	return false;
>   }
>   
> +static inline bool qdisc_txq_is_noop(const struct netdev_queue *txq)
> +{
> +	return (rcu_access_pointer(txq->qdisc) == &noop_qdisc);


return (expression);

->

return expression;


return rcu_access_pointer(txq->qdisc) == &noop_qdisc;

I also feel this patch should come first in the series ?



