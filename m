Return-Path: <bpf+bounces-43452-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F719B570B
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 00:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95AD81C22240
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 23:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032AF20ADF0;
	Tue, 29 Oct 2024 23:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="eke80TKr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531F22038D9
	for <bpf@vger.kernel.org>; Tue, 29 Oct 2024 23:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730245056; cv=none; b=GkEdHFdBWqGqcr+UocrNMmvV8kjSC5wSclipLJhs687mvJHQ58/IcIW6t+8NYK3wjcP8f4BUvd/DtK/VRu/DAG+2FbaqtZ5569q4V5q+o2GsMrc7+vSIvxHZKS/sLyyYcjDuJRD6lgP/vHOZlKI7fo9VKuRMnUx9GuaqrSmLSqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730245056; c=relaxed/simple;
	bh=wZbzvjzzDWdqjv0oO9AzMXD0zWjiIHgOpeg6C5KKZQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mQ4n0RTDvd0smn9cOwnkIM16TbmhUywIo3bT8tErPkwGzLPZibsIaRu1RD6yveMqErzA+TC7lbJ1KtoxxGtEjhX0/ZSLg2uxmqseMuy7qIT7ZIAgcWvJ8umR5X2Rgo4Bz10cx0cQ/iFFWjPVSZBRy4h0PcHmwFkP7+IWH1/UyVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=eke80TKr; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7b1457ba751so462350885a.3
        for <bpf@vger.kernel.org>; Tue, 29 Oct 2024 16:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1730245053; x=1730849853; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=06zxxfztZiRby3Y41pfZr0mzu18WelKjK9XTRSWEpy8=;
        b=eke80TKrZpx5bamFnpwH8wyFLOHzQ5N/DaY5XT5Z/u62l3AoJbMoFa0VFmgizjUKEZ
         XP/xL6WwLE4f80dPCWb+4llOUknv8yCLHZADbWnSRjx4pPLAY0OJcQpX6gWH4F/Xo78A
         YdeFIWn13M7HalFioZV+qb6KrkHK0+HE+cHP+2jWwyIo3UXJRbzGB2EWLav/xU0C6bTT
         K6o/Rjl71ZJaZQEedYuFFaJfmWjkraVfl8rU8QVW7SMbn30FtGw5l8J4t9BNLNuEi2vB
         7EfEsoD9FBpKn7wZNbn3H2+LB8CExT/CCKNgw3IOiQm4+Q3JctMle/poSAotDD+XfRUY
         x6Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730245053; x=1730849853;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=06zxxfztZiRby3Y41pfZr0mzu18WelKjK9XTRSWEpy8=;
        b=Du7ilX7XYj/xDzyYQynlEqkuguzmefC4MQ7atqO/DZ34klIJGp57Ehek1BielgB3BD
         4k1B8/k3G8UtfI2Xb71wWlkHarwPefggaknld52HfP1zVxMl5+oSRjnmahfIZFYgkGTT
         kDkwVB/fCS+Qs0fgIXUL1R2AT+rV1OjsqBCQhFPzGD9xIkr/2UG4Ty1Eu1+LPG90sn/c
         SOQ0Wx99+FMQe5gw0lqqDHt6XV7LCdgBEio5QiGRuFDOsl90qbxdQcCNQklCkaAtcW7F
         QJ/NLkjBg0DKw/FOHd5y6vRQ7cnmWL5wTeaQ0AhNxEhowiqjBvyUp6SNfVM93Q46CQUL
         rQpQ==
X-Gm-Message-State: AOJu0Yzg+Ve1wlrqBgKH4za/aNHS8gD5vof03mr9+4DRbmZEphyor+tv
	YIshq/j511pgztbGzwSefNfaDjw2jPjThScPZ4zQz8NPpgfxj6you+LU+H7b0BY=
X-Google-Smtp-Source: AGHT+IEa1KCqOP8xKA9IaN7zkjzvfeOA7VsGlXjM6gXPHRVR3V+j3GAx7qYeS6SEbZndE6o0HVw+rw==
X-Received: by 2002:a05:620a:2941:b0:7b1:4ad5:571c with SMTP id af79cd13be357-7b193f0a65amr2133157885a.38.1730245053138;
        Tue, 29 Oct 2024 16:37:33 -0700 (PDT)
Received: from ?IPV6:2601:647:4200:9750:d096:b1fe:ffde:1a3d? ([2601:647:4200:9750:d096:b1fe:ffde:1a3d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b18d343b5asm462467785a.109.2024.10.29.16.37.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2024 16:37:32 -0700 (PDT)
Message-ID: <abc69614-869d-42d8-be8e-b4573029611b@bytedance.com>
Date: Tue, 29 Oct 2024 16:37:30 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] bpf: Add sk_is_inet check in tls_sw_has_ctx_tx/rx
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: bpf@vger.kernel.org, borisp@nvidia.com, john.fastabend@gmail.com,
 kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, daniel@iogearbox.net, ast@kernel.org,
 cong.wang@bytedance.com
References: <20241029202830.3121552-1-zijianzhang@bytedance.com>
 <ZyFquswggZxKCYGH@mini-arch>
Content-Language: en-US
From: Zijian Zhang <zijianzhang@bytedance.com>
In-Reply-To: <ZyFquswggZxKCYGH@mini-arch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/29/24 4:07 PM, Stanislav Fomichev wrote:
> On 10/29, zijianzhang@bytedance.com wrote:
>> From: Zijian Zhang <zijianzhang@bytedance.com>
>>
>> As the introduction of the support for vsock and unix sockets in sockmap,
>> tls_sw_has_ctx_tx/rx cannot presume the socket passed in must be inet.
>> Otherwise, tls_get_ctx may return an invalid pointer and result in page
>> fault in function tls_sw_ctx_rx.
>>
>> BUG: unable to handle page fault for address: 0000000000040030
>> Workqueue: vsock-loopback vsock_loopback_work
>> RIP: 0010:sk_psock_strp_data_ready+0x23/0x60
>> Call Trace:
>>   ? __die+0x81/0xc3
>>   ? no_context+0x194/0x350
>>   ? do_page_fault+0x30/0x110
>>   ? async_page_fault+0x3e/0x50
>>   ? sk_psock_strp_data_ready+0x23/0x60
>>   virtio_transport_recv_pkt+0x750/0x800
>>   ? update_load_avg+0x7e/0x620
>>   vsock_loopback_work+0xd0/0x100
>>   process_one_work+0x1a7/0x360
>>   worker_thread+0x30/0x390
>>   ? create_worker+0x1a0/0x1a0
>>   kthread+0x112/0x130
>>   ? __kthread_cancel_work+0x40/0x40
>>   ret_from_fork+0x1f/0x40
>>
>> Fixes: 0608c69c9a80 ("bpf: sk_msg, sock{map|hash} redirect through ULP")
>> Fixes: e91de6afa81c ("bpf: Fix running sk_skb program types with ktls")
>>
>> Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
>> ---
>>   include/net/tls.h | 12 ++++++++++--
>>   1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/net/tls.h b/include/net/tls.h
>> index 3a33924db2bc..a65939c7ad61 100644
>> --- a/include/net/tls.h
>> +++ b/include/net/tls.h
>> @@ -390,8 +390,12 @@ tls_offload_ctx_tx(const struct tls_context *tls_ctx)
>>   
>>   static inline bool tls_sw_has_ctx_tx(const struct sock *sk)
>>   {
>> -	struct tls_context *ctx = tls_get_ctx(sk);
>> +	struct tls_context *ctx;
>> +
>> +	if (!sk_is_inet(sk))
>> +		return false;
>>   
>> +	ctx = tls_get_ctx(sk);
>>   	if (!ctx)
>>   		return false;
>>   	return !!tls_sw_ctx_tx(ctx);
>> @@ -399,8 +403,12 @@ static inline bool tls_sw_has_ctx_tx(const struct sock *sk)
>>   
>>   static inline bool tls_sw_has_ctx_rx(const struct sock *sk)
>>   {
>> -	struct tls_context *ctx = tls_get_ctx(sk);
>> +	struct tls_context *ctx;
>> +
>> +	if (!sk_is_inet(sk))
>> +		return false;
>>   
>> +	ctx = tls_get_ctx(sk);
>>   	if (!ctx)
>>   		return false;
>>   	return !!tls_sw_ctx_rx(ctx);
> 
> This seems like a strange place to fix it. Why does tls_get_ctx return
> invalid pointer for non-tls/ulp sockets? Shouldn't it be NULL?
> Is sockmap even supposed to work with vsock?

Here is my understanding, please correct me if I am wrong :)
```
static inline struct tls_context *tls_get_ctx(const struct sock *sk)
{
	const struct inet_connection_sock *icsk = inet_csk(sk);
	return (__force void *)icsk->icsk_ulp_data;
}
```
tls_get_ctx assumes the socket passed is icsk_socket. However, unix
and vsock do not have inet_connection_sock, they have unix_sock and
vsock_sock. The offset of icsk_ulp_data are meaningless for them, and
they might point to some other values which might not be NULL.

Afaik, sockmap started to support vsock in 634f1a7110b4 ("vsock: support
sockmap"), and support unix in 94531cfcbe79 ("af_unix: Add
unix_stream_proto for sockmap").

If the above is correct, I find that using inet_test_bit(IS_ICSK, sk)
instead of sk_is_inet will be more accurate.

