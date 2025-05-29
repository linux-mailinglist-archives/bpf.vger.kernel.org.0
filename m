Return-Path: <bpf+bounces-59224-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E10D2AC752F
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 02:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0F455003DD
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 00:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14DF1A4E9D;
	Thu, 29 May 2025 00:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="hBDUN8SO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC48F1B7F4
	for <bpf@vger.kernel.org>; Thu, 29 May 2025 00:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748479768; cv=none; b=F99yJUFUjSJ2JAd0aXkF8XVQBWulGgIg0EdvO6Ns3LB7ZpcSi4PGhLufd34SkjI1a02p9Q8fmHSXWEI086k3GiYC6tkjXlesQ4+dvhC9+t0WBmLbrqQ0sDko/wKHSSdP9SYH0q288PZfKZUouO9iXm1DhvOWd9LB2Rb7vBCeT70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748479768; c=relaxed/simple;
	bh=hfUqsuqNrfhaPiVk2G40M78HYAyL0SMbPsVKu3y7pQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iTUzvql/v6ldWnwvc90EHaDtYp0US8a+AYBtObVd/Awyv7PchjmKAmwyhhWpi7aPR8nNwYAC96Pb0oHI/C/gG957OMATBlgmeWw6PngGdEowQt2Ym9Vb19l/ARgHRdMAGppp9OKBoKYsM9KmNIe0pQ8S3RVDBq5V2DmTYz7uPzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=hBDUN8SO; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-476b4c9faa2so4417211cf.3
        for <bpf@vger.kernel.org>; Wed, 28 May 2025 17:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1748479765; x=1749084565; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TKhstJNQESyypLHjwfOabdZIDAN9bNuz9Of7dFpRg2w=;
        b=hBDUN8SOH+bGI3MOkuWKbqhebfQ+3+Z0CO1nAbUUjpbGAyurGWbcNrIde642td1iTT
         mN84Sk3OCoyVIin2ExJmNZh4+5M9VcF1DsE4Uq9Sxd63a0eYA8BFB2yxP/Bbgl5DuAY5
         9w3yd0FABX90JqxTDotmDAfwWLXkbXuCA2cwiPsvcJlMBFL/Wz9m/VlID8yfVRqNvvIs
         cl6e2dcfnjPfocecYc+sjfPKo23H8aBq9lLos+rdtyhVpd9IW8OPXcZEVyj6D5JO4daL
         vQRp/2bHhpk0hVKKl+g3ADUMSE1i1kjnDZrffrFo3/1AW2Dsm9Q2XEOA79BE9tu5qwXj
         O5wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748479765; x=1749084565;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TKhstJNQESyypLHjwfOabdZIDAN9bNuz9Of7dFpRg2w=;
        b=Fto1MLtyI/d0iAUP9729lVbxPhvdmlj0O4z7GUNTPe/pjedXgNE4XWzWVwtBzJAtA8
         8v5clCQbUJv5y+wPGOrEcC0nLtiNm3CZqZhm/YkQ+sYcus/hiUzZs+0Sf54VhFqouWuJ
         3noOGkt/K662Yf0g1t5OFVmi+rFgA1Rp67RnZVYXthmY1MqIkLdWtwMbXkc7uB3XxLIw
         /kVsqRonOvZioKqITX+vqwWr2IlPnqgDlSc1a9kM6P5cNyL6MPcPwrzD5r6kbUzNifwP
         yftI+Pe/pBTpuvpkSdPA/D/e04a6UFhArGcdfG3Bhudv5zfh/gU94Ixiy8YaxgUEFNft
         cXKw==
X-Forwarded-Encrypted: i=1; AJvYcCWaeZOvE9bKNLsGWD3bsK2JPsaWRluIAuf4bHFpJEVXiH1jKa9TmoTCvkwm05lCp3huGkY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8jU+p1weqnoRgY52nthE3UHIWgDEm2hR2VPiNrFXUzVlUfMpt
	Bpj9tExEgJO8QC8P93ehAMw8d2VI5io8Hn84BcI72twaA3l3oISV3v6+eyGyzpQ7jtc=
X-Gm-Gg: ASbGnctVpdIOJk0NoBOlAYL4lOcUQlw4Yzw2SQJku4s8tGsnvvgxCW3NPrE9s9zFl2e
	QoTy3G9DiTGjj8D312Nsrb3Rz7/EVce3fsaRbO/yj0aUlQetdcyDK5AnxOmrPAXfHQPkyByCG9h
	uwTHhiBdSltZwRi3Zvj8YtJckqPH0jmPwcIxf/uCQ+157RY5IWnHp4V2wba4AaOJ+Newp5P+gfG
	blsYRp7dguPD0vuDh9aDIOnTlmRtJCz3Hi+Fv5QXYZpIUIxJ+Pam6U/GnWqug0q4xbxvcMeVu/F
	oU0u8w4zTUXvOeMZfHg1tMEarE0K+W6U2rjiZ6ynlqFgrKSPTFYZwtDcJmOWs1d7Lyl979zUi+N
	/rLV0UNBbt14L48gefgAUVpozE2r2+KSSnsbZ+IeuuZ0F0sRn
X-Google-Smtp-Source: AGHT+IEKhJCaq4H3UPpq63G+EehTUAOzPZ4WqO2UiHjawiFQXbfnvxj3bnUrDOHKVe84tdkwY0HVrQ==
X-Received: by 2002:a05:622a:4ac4:b0:49d:89bf:298a with SMTP id d75a77b69052e-49f4655bb04mr322557621cf.21.1748479764687;
        Wed, 28 May 2025 17:49:24 -0700 (PDT)
Received: from ?IPV6:2601:647:4d81:15e0:fdf3:2533:6562:13e9? ([2601:647:4d81:15e0:fdf3:2533:6562:13e9])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a435a56f7csm1715681cf.66.2025.05.28.17.49.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 17:49:24 -0700 (PDT)
Message-ID: <c66ac1f6-1626-47d6-9132-1aeedf771032@bytedance.com>
Date: Wed, 28 May 2025 17:49:22 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch bpf-next v3 2/4] skmsg: implement slab allocator cache for
 sk_msg
To: John Fastabend <john.fastabend@gmail.com>,
 Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, zhoufeng.zf@bytedance.com,
 jakub@cloudflare.com, Cong Wang <cong.wang@bytedance.com>
References: <20250519203628.203596-1-xiyou.wangcong@gmail.com>
 <20250519203628.203596-3-xiyou.wangcong@gmail.com>
 <20250529000348.upto3ztve36ccamv@gmail.com>
Content-Language: en-US
From: Zijian Zhang <zijianzhang@bytedance.com>
In-Reply-To: <20250529000348.upto3ztve36ccamv@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/28/25 5:04 PM, John Fastabend wrote:
> On 2025-05-19 13:36:26, Cong Wang wrote:
>> From: Zijian Zhang <zijianzhang@bytedance.com>
>>
>> Optimizing redirect ingress performance requires frequent allocation and
>> deallocation of sk_msg structures. Introduce a dedicated kmem_cache for
>> sk_msg to reduce memory allocation overhead and improve performance.
>>
>> Reviewed-by: Cong Wang <cong.wang@bytedance.com>
>> Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
>> ---
>>   include/linux/skmsg.h | 21 ++++++++++++---------
>>   net/core/skmsg.c      | 28 +++++++++++++++++++++-------
>>   net/ipv4/tcp_bpf.c    |  5 ++---
>>   3 files changed, 35 insertions(+), 19 deletions(-)
>>
>> diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
>> index d6f0a8cd73c4..bf28ce9b5fdb 100644
>> --- a/include/linux/skmsg.h
>> +++ b/include/linux/skmsg.h
>> @@ -121,6 +121,7 @@ struct sk_psock {
>>   	struct rcu_work			rwork;
>>   };
>>   
>> +struct sk_msg *sk_msg_alloc(gfp_t gfp);
>>   int sk_msg_expand(struct sock *sk, struct sk_msg *msg, int len,
>>   		  int elem_first_coalesce);
>>   int sk_msg_clone(struct sock *sk, struct sk_msg *dst, struct sk_msg *src,
>> @@ -143,6 +144,8 @@ int sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
>>   		   int len, int flags);
>>   bool sk_msg_is_readable(struct sock *sk);
>>   
>> +extern struct kmem_cache *sk_msg_cachep;
>> +
>>   static inline void sk_msg_check_to_free(struct sk_msg *msg, u32 i, u32 bytes)
>>   {
>>   	WARN_ON(i == msg->sg.end && bytes);
>> @@ -319,6 +322,13 @@ static inline void sock_drop(struct sock *sk, struct sk_buff *skb)
>>   	kfree_skb(skb);
>>   }
>>   
>> +static inline void kfree_sk_msg(struct sk_msg *msg)
>> +{
>> +	if (msg->skb)
>> +		consume_skb(msg->skb);
>> +	kmem_cache_free(sk_msg_cachep, msg);
>> +}
>> +
>>   static inline bool sk_psock_queue_msg(struct sk_psock *psock,
>>   				      struct sk_msg *msg)
>>   {
>> @@ -330,7 +340,7 @@ static inline bool sk_psock_queue_msg(struct sk_psock *psock,
>>   		ret = true;
>>   	} else {
>>   		sk_msg_free(psock->sk, msg);
>> -		kfree(msg);
>> +		kfree_sk_msg(msg);
> 
> Isn't this a potential use after free on msg->skb? The sk_msg_free() a
> line above will consume_skb() if it exists and its not nil set so we would
> consume_skb() again?
> 

Thanks to sk_msg_free, after consuming the skb, it invokes sk_msg_init
to make msg->skb NULL to prevent further double free.

To avoid the confusion, we can replace kfree_sk_msg here with
kmem_cache_free.


>>   		ret = false;
>>   	}
>>   	spin_unlock_bh(&psock->ingress_lock);
>> @@ -378,13 +388,6 @@ static inline bool sk_psock_queue_empty(const struct sk_psock *psock)
>>   	return psock ? list_empty(&psock->ingress_msg) : true;
>>   }
>>   
>> -static inline void kfree_sk_msg(struct sk_msg *msg)
>> -{
>> -	if (msg->skb)
>> -		consume_skb(msg->skb);
>> -	kfree(msg);
>> -}
>> -
>>   static inline void sk_psock_report_error(struct sk_psock *psock, int err)
>>   {
>>   	struct sock *sk = psock->sk;
>> @@ -441,7 +444,7 @@ static inline void sk_psock_cork_free(struct sk_psock *psock)
>>   {
>>   	if (psock->cork) {
>>   		sk_msg_free(psock->sk, psock->cork);
>> -		kfree(psock->cork);
>> +		kfree_sk_msg(psock->cork);
> 
> Same here.
> 
>>   		psock->cork = NULL;
>>   	}
>>   }


