Return-Path: <bpf+bounces-13083-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EED7D4419
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 02:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4A0B2817D1
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 00:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C967E;
	Tue, 24 Oct 2023 00:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2c6Ickq"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6050A6FB5;
	Tue, 24 Oct 2023 00:37:32 +0000 (UTC)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5169F;
	Mon, 23 Oct 2023 17:37:30 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5a7af52ee31so39153157b3.2;
        Mon, 23 Oct 2023 17:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698107849; x=1698712649; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PjW7lvam0fg9EP6TtrMmgSnBg89UyoO50C4CtkCLw1w=;
        b=D2c6IckqoxVHR35fsOtEuOOHrD4yF5t2jhGZEsPGSkWpQQOQqVt/yE8rMPrdm4bGkD
         VhZds33AGb8JimTRcxhVJl6T7/RMoWk+hhiF3UEaneNq3ZiYfSkPCd6BqFELE1KD8tOw
         MTKK64nsih24oKIcLWlTpgzYLPH4w1MOcDV/nkJNvQ/tlWZ2AoqmAkcaCe5I6yPuSUhc
         0Wo4p0R4z9UUVCRKnEMqes5LH9fLMS6cvK5+QM8W6K+MjWf9Ji/hvQ4WkzRJB0dHWH45
         j9CPnmiHc7DAg0nLlRIbHu78dPn6kziy2vtaoJGCycBzrN7oyQaQa+qTdfrhBJtX0NW1
         PdgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698107849; x=1698712649;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PjW7lvam0fg9EP6TtrMmgSnBg89UyoO50C4CtkCLw1w=;
        b=KiPFLYqM431QQR/hnGgsQhC7w5avXu6D6RaAhyvKkNHUao35w34cfOzvM/WMJWUbWi
         MafTr3hVUxTcUCzJPc5c/06sF0cV0IrUf8HRodK5M4eROZMCkGjUPkByCz6eLLmeQaY2
         hQs4DME8RwLEC7Tw6Es/yJwuB/OvzUNrSjCPD5zue5s8p+R3xlkI1m0Lva4DT7Anadcf
         47jIAsB2vsc7HNfdWqDTBPRAlW3qz6jcrsRb2bJa3amQnB4wtCS6l6i2HuIijaZ/ZZ/j
         kn2UbsXRn3YtzxCrD9H8jl14kqBYmu2EQZmdIX1SZ2Znk3jpUeoSBWxKbmNHy+iwfDxe
         9Fxg==
X-Gm-Message-State: AOJu0YwIvkjaBaoMZTf0ZAPpTTChemPLE1TLLVd6yp4c7RTBitT4CEZk
	Osh/4lEbUm16OyTEpmXd51c=
X-Google-Smtp-Source: AGHT+IH2SPL6rgD/G9MZBiW9cJ/j479f7hc84WIM9jVu14+AAUq0CAAjEkbHcqluQEy1kF84nJkk4A==
X-Received: by 2002:a0d:e84b:0:b0:589:8b55:f7f7 with SMTP id r72-20020a0de84b000000b005898b55f7f7mr10640118ywe.39.1698107849418;
        Mon, 23 Oct 2023 17:37:29 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:d2a1:45b1:73e7:daa2? ([2600:1700:6cf8:1240:d2a1:45b1:73e7:daa2])
        by smtp.gmail.com with ESMTPSA id v123-20020a814881000000b005a7c829dda2sm3584359ywa.84.2023.10.23.17.37.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 17:37:29 -0700 (PDT)
Message-ID: <9aebb3e9-70c5-428c-bc31-7b38a04e4848@gmail.com>
Date: Mon, 23 Oct 2023 17:37:26 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 bpf-next 00/11] bpf: tcp: Add SYN Cookie
 generation/validation SOCK_OPS hooks.
To: Martin KaFai Lau <martin.lau@linux.dev>,
 Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, haoluo@google.com, john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org, kuba@kernel.org, kuni1840@gmail.com,
 mykolal@fb.com, netdev@vger.kernel.org, pabeni@redhat.com, sdf@google.com,
 song@kernel.org, yonghong.song@linux.dev
References: <20231020231003.51313-1-kuniyu@amazon.com>
 <20231021064801.87816-1-kuniyu@amazon.com>
 <42d66dde-29d6-f948-bc2e-72465beb800f@linux.dev>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <42d66dde-29d6-f948-bc2e-72465beb800f@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/23/23 14:35, Martin KaFai Lau wrote:
> On 10/20/23 11:48 PM, Kuniyuki Iwashima wrote:
>> I think this was doable.  With the diff below, I was able to skip
>> validation in cookie_v[46]_check() when if skb->sk is not NULL.
>>
>> The kfunc allocates req and set req->syncookie to 1, which is usually
>> set in TX path, so if it's 1 in RX (inet_steal_sock()), we can see
>> that req is allocated by kfunc (at least, req->syncookie &&
>> req->rsk_listener never be true in the current TCP stack).
>>
>> The difference here is that req allocated by kfunc holds refcnt of
>> rsk_listener (passing true to inet_reqsk_alloc()) to prevent freeing
>> the listener until req reaches cookie_v[46]_check().
> 
> The cookie_v[46]_check() holds the listener sk refcnt now?


The caller of cookie_v[46]_check() should hold a refcnt of the listener.
If the listener is destroyed, the callers of cookie_v[46]_check() should
fail to lookup a sock for the skb. However, in this case, the kfunc sets
a sock to skb->sk, and the lookup function
(__inet_lookup_skb()) steals sock from skb. So, there is no guarantee
ensuring the listener is still alive.

One solution is let the stealing function to lookup the listener if
inet_reqsk(skb->sk)->syncookie is true.

