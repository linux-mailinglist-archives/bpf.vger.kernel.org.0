Return-Path: <bpf+bounces-43463-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B6D9B58DA
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 01:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F19C81C22C89
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 00:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219692C6A3;
	Wed, 30 Oct 2024 00:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="PZW3B/Cs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D210282F4
	for <bpf@vger.kernel.org>; Wed, 30 Oct 2024 00:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730249756; cv=none; b=YG7ePKfnriJA2Y+pgMisVjRCACS2Z3OFgaMXXSp5lxVdSVfdm4kIgmeeuuKXX4+gR6DAm6klnZ9Gs7an2VCxZbwf8zsjqpB5WoMMhpi9HUAM6Olfxys+sf686q1gXdnlO38GhPcovxc6E4yEqY0I52WQfTHaXC7ta6nBMrbiOGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730249756; c=relaxed/simple;
	bh=uBwJe+hIYiIwawD/xRTydIAdO0jZ3E7YbASaA3dQz84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YRaSLuWKMCMDgOSbJVztXUrgcC+zxsZX4O9O+IvTCVc+dD8w8qbJ+ewb81MnjZhHg5ooo2aRwHXii4kpSiC1148vSxAAzvc2tnsxjXPskVboUfqdDZxgqupjskCQtRPqTfKr+8fN+YVfIWuUWPKCJ6HRGz4WvNFnj7Qi8h5rWuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=PZW3B/Cs; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-84fc1a5e65bso1489989241.2
        for <bpf@vger.kernel.org>; Tue, 29 Oct 2024 17:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1730249753; x=1730854553; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xHSOfuI79D6NFr6hfS/UGm6U2g9ymViOAr9o9F0f/rU=;
        b=PZW3B/CsKBNmRZUUnMUOKPTyeG8gn0hqGyEN6LeKin5RAaNLLHESt/Eiti0C/xU2EK
         PlLZRU8EDx/IsC4uiNcFEra0gyQBoiuozseRgXRD8gR7vm1jGtxfrWiBrpN0/wZuSFsP
         4eN5Ef4ShvReqU8nz9TJEGZsCYt22IHZXRZirP+sirYjviOBOfNjCNBRaHEUELDAqkyy
         w8kMYE4Kh+0vxWZ8H3cOvFdiAtuM9Mbnx1rWFOzxVDy9YYSTiwJyMougPviAo3+YJGDJ
         w1vm6Ulw9B54haGVMJVwYEBCjH48U4Q5d3Xxxde2kR61+/0Z69nYIht+0rikRYQQTn6L
         0jbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730249753; x=1730854553;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xHSOfuI79D6NFr6hfS/UGm6U2g9ymViOAr9o9F0f/rU=;
        b=h5WVGAwqJ/iIWtsYj7zJa3mZxr0dP62xr2SYi+WQwg6HU6MA8xMAcWWcT0KXRK86Ax
         6Y116MUv8qKPM+wFiZyz53ab3WRzLl60GpUB3j3rUb1MMxM/bmuq0s6AP85zgo2L8x8C
         VmHEydcdTM7th3PaeTZffBYk3lLfnOasmV/Ji3oK+gqfVDyIf3znYg6xhEjwzr4SgdQw
         HN0dkZ9i1HJkXdZVqSzy+bv0ZeZ0SHYYYrt1DsD+Zed23eSMgDOya/NMq6oUFJTdEGHJ
         akHyAwjIuFEtTPWL28QCdjCoPcxxrqTgMxx6BISS2NjHJywd3CrHN5zO4GN25PBEI3Fl
         1jyQ==
X-Gm-Message-State: AOJu0YwbazDeqCdArP74jxt521PHIV/x5raH2RWo6ESrx4sqY1xoMrfq
	v6kFQgUEOx6QiD9O3j1HTIvO4CBIFvTKEycWaasMKg2PhllsztYIXtEmLUGrcvM=
X-Google-Smtp-Source: AGHT+IH/T9/lXvaBhNgTmK0GKSsWeO9frRGfe7AAMSGYRY6dlsqjFrlc4M5cXlVW83MFhqz1L+XK8g==
X-Received: by 2002:a05:6102:1623:b0:492:a93d:7cab with SMTP id ada2fe7eead31-4a8cfb433c8mr13422682137.1.1730249753070;
        Tue, 29 Oct 2024 17:55:53 -0700 (PDT)
Received: from ?IPV6:2601:647:4200:9750:d096:b1fe:ffde:1a3d? ([2601:647:4200:9750:d096:b1fe:ffde:1a3d])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4613211a1c0sm49672791cf.20.2024.10.29.17.55.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2024 17:55:51 -0700 (PDT)
Message-ID: <08853817-921b-4595-a7d5-67007bf21500@bytedance.com>
Date: Tue, 29 Oct 2024 17:55:48 -0700
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
Content-Language: en-US
From: Zijian Zhang <zijianzhang@bytedance.com>
In-Reply-To: <ZyF8LA6v9iAuxNXi@mini-arch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/29/24 5:22 PM, Stanislav Fomichev wrote:
> On 10/29, Zijian Zhang wrote:
>>
>>
>> On 10/29/24 4:07 PM, Stanislav Fomichev wrote:
>>> On 10/29, zijianzhang@bytedance.com wrote:
...
>>>> diff --git a/include/net/tls.h b/include/net/tls.h
>>>> index 3a33924db2bc..a65939c7ad61 100644
>>>> --- a/include/net/tls.h
>>>> +++ b/include/net/tls.h
>>>> @@ -390,8 +390,12 @@ tls_offload_ctx_tx(const struct tls_context *tls_ctx)
>>>>    static inline bool tls_sw_has_ctx_tx(const struct sock *sk)
>>>>    {
>>>> -	struct tls_context *ctx = tls_get_ctx(sk);
>>>> +	struct tls_context *ctx;
>>>> +
>>>> +	if (!sk_is_inet(sk))
>>>> +		return false;
>>>> +	ctx = tls_get_ctx(sk);
>>>>    	if (!ctx)
>>>>    		return false;
>>>>    	return !!tls_sw_ctx_tx(ctx);
>>>> @@ -399,8 +403,12 @@ static inline bool tls_sw_has_ctx_tx(const struct sock *sk)
>>>>    static inline bool tls_sw_has_ctx_rx(const struct sock *sk)
>>>>    {
>>>> -	struct tls_context *ctx = tls_get_ctx(sk);
>>>> +	struct tls_context *ctx;
>>>> +
>>>> +	if (!sk_is_inet(sk))
>>>> +		return false;
>>>> +	ctx = tls_get_ctx(sk);
>>>>    	if (!ctx)
>>>>    		return false;
>>>>    	return !!tls_sw_ctx_rx(ctx);
>>>
>>> This seems like a strange place to fix it. Why does tls_get_ctx return
>>> invalid pointer for non-tls/ulp sockets? Shouldn't it be NULL?
>>> Is sockmap even supposed to work with vsock?
>>
>> Here is my understanding, please correct me if I am wrong :)
>> ```
>> static inline struct tls_context *tls_get_ctx(const struct sock *sk)
>> {
>> 	const struct inet_connection_sock *icsk = inet_csk(sk);
>> 	return (__force void *)icsk->icsk_ulp_data;
>> }
>> ```
>> tls_get_ctx assumes the socket passed is icsk_socket. However, unix
>> and vsock do not have inet_connection_sock, they have unix_sock and
>> vsock_sock. The offset of icsk_ulp_data are meaningless for them, and
>> they might point to some other values which might not be NULL.
>>
>> Afaik, sockmap started to support vsock in 634f1a7110b4 ("vsock: support
>> sockmap"), and support unix in 94531cfcbe79 ("af_unix: Add
>> unix_stream_proto for sockmap").
>>
>> If the above is correct, I find that using inet_test_bit(IS_ICSK, sk)
>> instead of sk_is_inet will be more accurate.
> 
> Thanks for the context, makes sense. And consolidating this sk_is_inet
> check inside tls_get_ctx is worse because it gets called outside of
> sockmap?

Yes, tls_get_ctx is invoked in multiple locations, and I want to only
fix sockmap related calls.


