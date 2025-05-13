Return-Path: <bpf+bounces-58114-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C33AB536F
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 13:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09C7B189E963
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 11:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E03828C5CB;
	Tue, 13 May 2025 11:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q8+pebEE"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47700253F1B
	for <bpf@vger.kernel.org>; Tue, 13 May 2025 11:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747134275; cv=none; b=G+Y2EucajIDUFPcUp3Gf45E3iLs+kc1IRzzIrZNYhB51jlWuvLvnjZwksrDbuncI0rRrhWZuxnWD48Ita6aJdgR2vn979MUEoBNQKGDY+qNeUkFV0e1/JH2TdJZfChCgyRdbGZRaH5lYYlifxAjWDfR3znTWAQZ4jIQnPnd/qUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747134275; c=relaxed/simple;
	bh=cD0kSgh62M8/Y/zh/4GOrt1GenQJy1Ty3520jNy+5Ko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o1l7XhYO2kSDIESTIDG+aQrvthC0I5Sqvg18n36EUrWQSCnMkCGbJ7tHBpHVb39N2kFKktyFAkg/n54R9/ERjOj5ZU3+ly0elYDNa6+44rJ4S87EOoxnQ2QyyaBrNS2MwCo76HeHBP4kd1UJ/CIiLlAt1zLzXskOBsmFLEg9Y1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q8+pebEE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747134273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xK2MgygORKh5aA+2qnSZ6R0zwTOP1pHjPLlJuNvz8ic=;
	b=Q8+pebEEk5NRMQuELwNWKOCuD2fEbsz0pXlZ6f8NauIOhKrdoEMHGVnD+czRZwko/FypA4
	fN7nl5JQpJtW40WDVxeoIM8AZC1RKwY3yx5Z4G0z+hwFAFG5ABxEwKznBui16f1Wtqq/Yz
	dsDtrbdfbv3pTg/D1LvRWecOYsOlAOU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-6zTPYS1iM3KaGA0cymzYkQ-1; Tue, 13 May 2025 07:04:32 -0400
X-MC-Unique: 6zTPYS1iM3KaGA0cymzYkQ-1
X-Mimecast-MFC-AGG-ID: 6zTPYS1iM3KaGA0cymzYkQ_1747134271
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a1c86b62a8so3098591f8f.3
        for <bpf@vger.kernel.org>; Tue, 13 May 2025 04:04:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747134271; x=1747739071;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xK2MgygORKh5aA+2qnSZ6R0zwTOP1pHjPLlJuNvz8ic=;
        b=AEq8Thtf/vAnt/RQR2JQ1Ialp9spq/Oq9Huhq7t2uqKnCPFvmNBetrZT05xHwSoF4W
         ANxSNkllwPb7Q/rU4jz1iWN9iSt2EBZRtcacvJGoM29wtwctPcOq2Wkch6z8zPB2O7yY
         ifSrPsSWYYoDctAdBC/SHTJ7Kafv2fbhIbkv5WyG7kUCiddWRCUSIE7xN8/+aEEyHRIB
         TI8MiKfvSRWqvoIwsTQho8L/3yMdLpznkOpajc9iaBSFNqreR8l9Ckp6YLr9by+nb7Qx
         vfhtX3TZvel0yQeZ+Lw0T6cL01uKUkCzWbNzNe6MKwr/sGIPGS9bls71HMvDBGFQRhv0
         LNrw==
X-Gm-Message-State: AOJu0Yx34+2uVoCnGz6aa4fSmFC0vymQFTDOA3OwP/cEeY/C1/MC5u6W
	RFVddromVGlR6OwQy2V7BkSCHrwm7y9Ny1lrLztgPmOaWpWo4qYfjBUUVsH3EcK0OdixntCX282
	qqiU13pjU7LraLre11rZ9rMMeP8aLWqmvhGYd4fnUjz2A4StI0Q==
X-Gm-Gg: ASbGncszsRsIcTw6G7q3h+TXdYZ8oSri5eoGhbpriHJ3eHVJJZxrAgPk1Q5fHMeawxQ
	vdeobxeIrfGlrpDCNCBCQJmY4X4ymUAZjDBumWvzNkBpi8J8Fg9X6vCTO8yEB28XzQOMX0IhuJM
	xpxrV9UOuNds4OQHBBunP6sD/Uz32WzAiX1rGIIYsLFNevNyoJlddb/navPc2oKtv3N1Wnaa8KJ
	Kv2sQ81yesTgkmsrJjfk/YjYhBueh4qFNxoZl8VhrKOhNInLU9EWorq7x4ktDEDdPm42hGfURvJ
	Z9vEEctSJLMYjqLDMlw=
X-Received: by 2002:adf:e0c6:0:b0:3a1:f91e:b029 with SMTP id ffacd0b85a97d-3a1f91eb0b4mr10378433f8f.57.1747134270786;
        Tue, 13 May 2025 04:04:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqosrgja6xlH2lyXFtG4dHnj8AU6GKe27ulz+iWqCHknSq8THOKHDj28BckES7SZkWcSkhFQ==
X-Received: by 2002:adf:e0c6:0:b0:3a1:f91e:b029 with SMTP id ffacd0b85a97d-3a1f91eb0b4mr10378409f8f.57.1747134270377;
        Tue, 13 May 2025 04:04:30 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:cc59:6510::f39? ([2a0d:3341:cc59:6510::f39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442cd32f238sm202841325e9.11.2025.05.13.04.04.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 04:04:29 -0700 (PDT)
Message-ID: <aac5b03d-1380-437a-9763-1069aff1fd8b@redhat.com>
Date: Tue, 13 May 2025 13:04:28 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V2] net: track pfmemalloc drops via
 SKB_DROP_REASON_PFMEMALLOC
To: Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>
Cc: bpf@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 kernel-team@cloudflare.com, mfleming@cloudflare.com
References: <174680137188.1282310.4154030185267079690.stgit@firesoul>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <174680137188.1282310.4154030185267079690.stgit@firesoul>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/9/25 4:36 PM, Jesper Dangaard Brouer wrote:
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index f5cf4d35d83e..cb31be77dd7e 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -1073,12 +1073,21 @@ bpf_jit_binary_lock_ro(struct bpf_binary_header *hdr)
>  	return set_memory_rox((unsigned long)hdr, hdr->size >> PAGE_SHIFT);
>  }
>  
> -int sk_filter_trim_cap(struct sock *sk, struct sk_buff *skb, unsigned int cap);
> +int sk_filter_trim_cap(struct sock *sk, struct sk_buff *skb, unsigned int cap,
> +		       enum skb_drop_reason *reason);
>  static inline int sk_filter(struct sock *sk, struct sk_buff *skb)
>  {
> -	return sk_filter_trim_cap(sk, skb, 1);
> +	enum skb_drop_reason ignore_reason;
> +
> +	return sk_filter_trim_cap(sk, skb, 1, &ignore_reason);
> +}

I'm sorry to nit-pick but checkpatch is not happy about the lack of
black lines here, and I think an empty line would make the code more
readable.

[...]
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 03d20a98f8b7..a1e10a13f7c8 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -5910,7 +5910,11 @@ static int __netif_receive_skb_core(struct sk_buff **pskb, bool pfmemalloc,
>  			dev_core_stats_rx_dropped_inc(skb->dev);
>  		else
>  			dev_core_stats_rx_nohandler_inc(skb->dev);
> -		kfree_skb_reason(skb, SKB_DROP_REASON_UNHANDLED_PROTO);
> +
> +		if (pfmemalloc)
> +			kfree_skb_reason(skb, SKB_DROP_REASON_PFMEMALLOC);
> +		else
> +			kfree_skb_reason(skb, SKB_DROP_REASON_UNHANDLED_PROTO);

AFAICS we can reach here even if skb_orphan_frags_rx() fails and that
will be accounted as 'SKB_DROP_REASON_UNHANDLED_PROTO'. Perhaps it would
be better to let the 'goto out' caller set the drop reason? And also set
it to 'SKB_DROP_REASON_UNHANDLED_PROTO' in this block before the 'out:'
label.

[...]
> @@ -2637,6 +2635,7 @@ static int udp_unicast_rcv_skb(struct sock *sk, struct sk_buff *skb,
>  int __udp4_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
>  		   int proto)
>  {
> +	enum skb_drop_reason drop_reason;
>  	struct sock *sk = NULL;
>  	struct udphdr *uh;
>  	unsigned short ulen;
> @@ -2644,7 +2643,6 @@ int __udp4_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
>  	__be32 saddr, daddr;
>  	struct net *net = dev_net(skb->dev);
>  	bool refcounted;
> -	int drop_reason;
>  
>  	drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
>  

The above 2 chunks look unrelated/unneeded. Since the patch is already
pretty big, I think it would be better to not include them.

Thanks,

Paolo


