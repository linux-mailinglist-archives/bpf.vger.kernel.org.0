Return-Path: <bpf+bounces-43571-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9999B6955
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 17:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B4171C215EA
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 16:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF712144D8;
	Wed, 30 Oct 2024 16:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="BIShLQNQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043CC26296
	for <bpf@vger.kernel.org>; Wed, 30 Oct 2024 16:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730306263; cv=none; b=gFuvlyzed4GNWKUuLFupzSiDhDhEjEcg/ccOwjquwHR9TkG71knPZ7VhkcdOQaPiP4bt9ogWZ3a+lked5KrP/gotTSyfsokfc03B85nCma7kHgyG/C6BDV8yYiTTiJw4ivwwQkxC9hKy0UoVgUhYHQi0gyoGhhTVjAmTOgxUEhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730306263; c=relaxed/simple;
	bh=Iy3O8zI89edg/FlGB6TdI2ef8zDQn2yfpjG27LDRRRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aEDkltUqxjzGQsijnDH+1Rg189HWzKX7IdjQjM/7DnMGOvFq5MvfkfqoxGPVj1IWjWNP2nJR/YfmfV19faqs6S1e6v/dFqtgjql7pY7KasHP9qZoph/Z9uVjM3ine76R9PFHRhVppPy+2sdyd9FYB7dmAVZl6ZtfTVVKmnQWv38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=BIShLQNQ; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4609967ab7eso502721cf.3
        for <bpf@vger.kernel.org>; Wed, 30 Oct 2024 09:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1730306260; x=1730911060; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WM+wCVZBPmwEyCec9sRjFyCm37cax5DL25QKp6p07YE=;
        b=BIShLQNQI346jN2VDVXqOrz3lEKJxCuBFo2ae25KcuAmgDWcwit5iobYdTJ8jQQFd4
         1u94zLryIXcwIl3SURF3VhXh0W6Y9S7vtHlmsFn+M6ALbOdZEJNuEY1iQj/WLrQ41KyV
         Hh81L7NpYGHxm3tgLwJsk5i2NzE730GK5o14VU7s75l0FR8VjZoP0op3ZLh7mb1Ce3Zr
         Ngw5B4k2TJP7NPy45Jice/0LBP/wYnqCxwV/BYzOaH3sSRRXtMSrM3BQiNrH5n8y+e+2
         7KVswlwdCh6gIc0zid9pM2wWSHdJVtE3to7WFjSCAYduKZbS2HZVU4Tn9D1EvnvnJVsc
         Yg+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730306260; x=1730911060;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WM+wCVZBPmwEyCec9sRjFyCm37cax5DL25QKp6p07YE=;
        b=vXiP8q+zeOl19GVT8orApJ37E0MVLjc6YYq9qgbn3owWlYZzNTCX2xmX9kzD0BMpkp
         3k0RPRQuKBJP03PfjdwFYl7pI48N/L5YmoAqP5RAA8BAfVz0laPTqEobKtLs30ongN25
         usqcFNub/Txd9R2iIWV0otzTBXHDMXZTD4zu9kCg/By4CgBoNDN6lI3O61QE/FOqd39k
         Yt1wOoYndUUf1HKvmUXNF1f2G9g0Gu0NHvm8dKWK4/731y7rCT8+ID9P7bdyT3cZsbKC
         8Wl45W7CSYYrF0HzdBpJ67pIPcvqu1f9MR52bMkOdB7emMXMGwkeOzwGkdsLWEgeXlN5
         MdZg==
X-Gm-Message-State: AOJu0YxKcUeEt5ksz+as/MWoc4HDgJ9y5OlZRyYH9ltD0HfXNIEu4TQR
	2IG/QrSOC6kOdXPDNtk5JVRSepyZk3tle49S+5YisEwHw4wGzqyXCxGnsbJrzjc=
X-Google-Smtp-Source: AGHT+IH1RB+SK/9AJGyEhf7dAfg35RKuCWgyeKOL8ctaX1xtXpb/EFvO4SdmxH3bPVPzs/RuZkSLkg==
X-Received: by 2002:ac8:5716:0:b0:460:8faf:c3a1 with SMTP id d75a77b69052e-4613c1a7bdamr275614651cf.37.1730306259814;
        Wed, 30 Oct 2024 09:37:39 -0700 (PDT)
Received: from ?IPV6:2601:647:4200:9750:d096:b1fe:ffde:1a3d? ([2601:647:4200:9750:d096:b1fe:ffde:1a3d])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4613213a204sm55207901cf.28.2024.10.30.09.37.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 09:37:39 -0700 (PDT)
Message-ID: <0e609f5d-ebee-46f8-b3c6-69672495b4a4@bytedance.com>
Date: Wed, 30 Oct 2024 09:37:36 -0700
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
 <abc69614-869d-42d8-be8e-b4573029611b@bytedance.com>
 <ZyF8LA6v9iAuxNXi@mini-arch>
 <08853817-921b-4595-a7d5-67007bf21500@bytedance.com>
 <ZyJS5UCJu1YlsrJr@mini-arch>
Content-Language: en-US
From: Zijian Zhang <zijianzhang@bytedance.com>
In-Reply-To: <ZyJS5UCJu1YlsrJr@mini-arch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/30/24 8:38 AM, Stanislav Fomichev wrote:
> On 10/29, Zijian Zhang wrote:
>>
>> On 10/29/24 5:22 PM, Stanislav Fomichev wrote:
>>> On 10/29, Zijian Zhang wrote:
>>>>
>>>>
>>>> On 10/29/24 4:07 PM, Stanislav Fomichev wrote:
>>>>> On 10/29, zijianzhang@bytedance.com wrote:
>> ...
>>>>>> diff --git a/include/net/tls.h b/include/net/tls.h
>>>>>> index 3a33924db2bc..a65939c7ad61 100644
>>>>>> --- a/include/net/tls.h
>>>>>> +++ b/include/net/tls.h
>>>>>> @@ -390,8 +390,12 @@ tls_offload_ctx_tx(const struct tls_context *tls_ctx)
>>>>>>     static inline bool tls_sw_has_ctx_tx(const struct sock *sk)
>>>>>>     {
>>>>>> -	struct tls_context *ctx = tls_get_ctx(sk);
>>>>>> +	struct tls_context *ctx;
>>>>>> +
>>>>>> +	if (!sk_is_inet(sk))
>>>>>> +		return false;
>>>>>> +	ctx = tls_get_ctx(sk);
>>>>>>     	if (!ctx)
>>>>>>     		return false;
>>>>>>     	return !!tls_sw_ctx_tx(ctx);
>>>>>> @@ -399,8 +403,12 @@ static inline bool tls_sw_has_ctx_tx(const struct sock *sk)
>>>>>>     static inline bool tls_sw_has_ctx_rx(const struct sock *sk)
>>>>>>     {
>>>>>> -	struct tls_context *ctx = tls_get_ctx(sk);
>>>>>> +	struct tls_context *ctx;
>>>>>> +
>>>>>> +	if (!sk_is_inet(sk))
>>>>>> +		return false;
>>>>>> +	ctx = tls_get_ctx(sk);
>>>>>>     	if (!ctx)
>>>>>>     		return false;
>>>>>>     	return !!tls_sw_ctx_rx(ctx);
>>>>>
>>>>> This seems like a strange place to fix it. Why does tls_get_ctx return
>>>>> invalid pointer for non-tls/ulp sockets? Shouldn't it be NULL?
>>>>> Is sockmap even supposed to work with vsock?
>>>>
>>>> Here is my understanding, please correct me if I am wrong :)
>>>> ```
>>>> static inline struct tls_context *tls_get_ctx(const struct sock *sk)
>>>> {
>>>> 	const struct inet_connection_sock *icsk = inet_csk(sk);
>>>> 	return (__force void *)icsk->icsk_ulp_data;
>>>> }
>>>> ```
>>>> tls_get_ctx assumes the socket passed is icsk_socket. However, unix
>>>> and vsock do not have inet_connection_sock, they have unix_sock and
>>>> vsock_sock. The offset of icsk_ulp_data are meaningless for them, and
>>>> they might point to some other values which might not be NULL.
>>>>
>>>> Afaik, sockmap started to support vsock in 634f1a7110b4 ("vsock: support
>>>> sockmap"), and support unix in 94531cfcbe79 ("af_unix: Add
>>>> unix_stream_proto for sockmap").
>>>>
>>>> If the above is correct, I find that using inet_test_bit(IS_ICSK, sk)
>>>> instead of sk_is_inet will be more accurate.
>>>
>>> Thanks for the context, makes sense. And consolidating this sk_is_inet
>>> check inside tls_get_ctx is worse because it gets called outside of
>>> sockmap?
>>
>> Yes, tls_get_ctx is invoked in multiple locations, and I want to only
>> fix sockmap related calls.
> 
> Sounds convincing. Unless John/Jakub have better suggestions:
> 
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>

Thanks for the Ack and reviewing!

In order to make it more accurate, I added inet_test_bit(IS_ICSK, sk)
check in version2. I just found that sk_is_inet only cannot assure
inet_csk is valid. For example, udp_sock does not have inet_connection_sock.



