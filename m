Return-Path: <bpf+bounces-72819-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 623A4C1B89E
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 16:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B32D1888DEE
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 15:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636E72E1C54;
	Wed, 29 Oct 2025 15:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JthmCSd6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5458F2C08AD
	for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 15:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761750041; cv=none; b=G52ltiE0A4vu0nDvh0qV2TntqApP1rdgwE62405QxbCZJpZfXbQcQU+MSz/a17BYNeJX53DL/M9V05DR7T0vs1jQj8/NFg9RUU/QPy291DF7+ylLXAx/GG4VYhsK6cnXriG30WIWuymFQuX9E7zyZL5B+XrylwL7tzgMmukuJ1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761750041; c=relaxed/simple;
	bh=OU7d3RNlZHbgqky5nkbb0GWdBoezrjqgdpc9Zk0XHJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fJNwAthJPSgvGjMm7R8Kb433eQLEjTVUmN1sPSKx8bn4pwRV5+pwtNDQIBbXTrn/a3R69jnLE9EJyR1pZcR1yFLuCFjGKRwV85rv35a7TlenfkhsvBJqxRpPkygLVvICH1O0jZyb7eiO+g8TrRLszSkRCEFO3TtOGK4uw88Om5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JthmCSd6; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-33bafd5d2adso431a91.3
        for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 08:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761750037; x=1762354837; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bT40LJu6oxRypwozP+xYaDg978cHnaPf0JK9Yp1+9Sw=;
        b=JthmCSd6T5+D70NIaEGorYjojBmv6HXgTRmj629Er1wzGMXtOr/uwyqRU6re7+3FFr
         lDoeIinP6fEHyA9qJL5nNsUF6wjPTzopnHXfunLN3iAKck4NghqsiEskZG/m8WQr2qT9
         2jhitxKGTOiZSQC76Z0MUJA+T0wju6Gsadj2AdQdPAn1cSfocQTvhSyCOQxPgCMZ+gMN
         JqOBGTDb6OxJM4OL6xsUmqxX9SdG2y7YoyhTmDVGlaXi5a4BhXR9YlGgn+C18HAomAv8
         B/n5VXw17P7sleWEyVVmVY7fOzrZg6Vm3DxH0uTdDkckp7RXbcWparu9+WDXrS61O3oK
         /u0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761750037; x=1762354837;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bT40LJu6oxRypwozP+xYaDg978cHnaPf0JK9Yp1+9Sw=;
        b=w9vUb90eWbiAVolYQTDfaf/SHeOlbUIM03ukyi5EqdMFFIme0e2JsaNMVmGtjQFVrb
         mt5KFWTNIF/99QI81GiVajuTlkQkCnM5vN3Hmp/vvRWqPuZru7A9KHp1ESxpgchroeRI
         COU5zXHxpMxLM35Oiu88yT7gsaojqDIXM0DGK/903S74ZxYspk+1461SPWMNTIUGeCvB
         zklmRS9xy7z3XBgp0ret/mpqP0/Pr7SJIWIXj4o2mYQjJhOGeZKCQcJbdiDA1HGtfBdF
         +1caLxEEuChXm4Ml8aKlr1zWzT3BY7ku+BcS40LunSw6PiTTBR0UxV4CqC7yzx9eAsQg
         xVmg==
X-Forwarded-Encrypted: i=1; AJvYcCVKhRY96PBUoYsdsVoHhBzAIfzn7gi8tLGB95J0Af0Fkvh5Xy8C3QW8qeBZyvDkB5KPDMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNI9Bt5EIUWhpsINpFPjawq2xfrufYIAkZotLuodm+K34ydqiT
	fmnFYZoak95HwB26+mmwzPYgf9QjsPc2Vnn9kFO8lNbE1Q3msojWgnCp
X-Gm-Gg: ASbGncsZvmZSGFPFuJIl4JOpDvyfeCTnaUXZ0j6yFAIrQ0HZVCR6BdqtDY2A8CHFKoP
	wx0d7ElSrT1DvNz6dWXZTsQiCD6rlC5IAps6KHvwhieD0tlxrXrGRB3pC3Fq3mh6Hhh0femROMV
	heuDZNcyvHVDZ28t4dIY+LczUcUQYAzxz+gsHHXhMxzOQmyIz3408UNoHL1oaeW+xTvLdXKIAmQ
	ygOOuQNA8k5HE/OTaFX5K7/mFgTsxZKUDMr1JggDmFCDnMXmJvA3m03e1IWZ82N/9eTLqDgI8Ef
	TTaocOSjMNLOITXKbZMQXDx+1BEeivoCAF43BTmZnW5TWkd1kT7J9NRwlRD85dMerivIr0fyLJq
	aTGFyFhrDY3ME1pKyDgi/Az1DPb/GsqTfqJGK/QUTAI0+b3qX9ifSNVZZHGPF0w8RGXr177LOhq
	OSualdj95DP1FlkmuJRa5yNMnAMOW890U2WDJfacCfPPoz6emJy3Xoa9MDn34VSgCAm4CWae3JV
	g0=
X-Google-Smtp-Source: AGHT+IHTkNofjDYYCSUvcwrFzhudLkajYIpTI8Ehsx/uXD1wcmUENfXD8vGHxIX5mKjdzFiMwoBquQ==
X-Received: by 2002:a17:90b:3d0b:b0:335:2b15:7f46 with SMTP id 98e67ed59e1d1-3403a2a68dcmr3998093a91.21.1761750036781;
        Wed, 29 Oct 2025 08:00:36 -0700 (PDT)
Received: from [192.168.99.24] (i223-218-244-253.s42.a013.ap.plala.or.jp. [223.218.244.253])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-3402a5540absm3353475a91.5.2025.10.29.08.00.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 08:00:36 -0700 (PDT)
Message-ID: <4aa74767-082c-4407-8677-70508eb53a5d@gmail.com>
Date: Thu, 30 Oct 2025 00:00:28 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net V2 2/2] veth: more robust handing of race to avoid txq
 getting stuck
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Eric Dumazet <eric.dumazet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, ihor.solodrai@linux.dev,
 "Michael S. Tsirkin" <mst@redhat.com>, makita.toshiaki@lab.ntt.co.jp,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel-team@cloudflare.com,
 netdev@vger.kernel.org, =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
 <toke@toke.dk>
References: <176159549627.5396.15971398227283515867.stgit@firesoul>
 <176159553930.5396.4492315010562655785.stgit@firesoul>
 <aacc9c56-bea9-44eb-90fd-726d41b418dd@gmail.com>
 <27e74aeb-89f5-4547-8ecc-232570e2644c@kernel.org>
Content-Language: en-US
From: Toshiaki Makita <toshiaki.makita1@gmail.com>
In-Reply-To: <27e74aeb-89f5-4547-8ecc-232570e2644c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025/10/29 19:33, Jesper Dangaard Brouer wrote:
> On 28/10/2025 15.56, Toshiaki Makita wrote:
>> On 2025/10/28 5:05, Jesper Dangaard Brouer wrote:
>>> (3) Finally, the NAPI completion check in veth_poll() is updated. If NAPI is
>>> about to complete (napi_complete_done), it now also checks if the peer TXQ
>>> is stopped. If the ring is empty but the peer TXQ is stopped, NAPI will
>>> reschedule itself. This prevents a new race where the producer stops the
>>> queue just as the consumer is finishing its poll, ensuring the wakeup is not missed.
>> ...
>>
>>> @@ -986,7 +979,8 @@ static int veth_poll(struct napi_struct *napi, int budget)
>>>       if (done < budget && napi_complete_done(napi, done)) {
>>>           /* Write rx_notify_masked before reading ptr_ring */
>>>           smp_store_mb(rq->rx_notify_masked, false);
>>> -        if (unlikely(!__ptr_ring_empty(&rq->xdp_ring))) {
>>> +        if (unlikely(!__ptr_ring_empty(&rq->xdp_ring) ||
>>> +                 (peer_txq && netif_tx_queue_stopped(peer_txq)))) {
>>
>> Not sure if this is necessary.
> 
> How sure are you that this isn't necessary?
> 
>>  From commitlog, your intention seems to be making sure to wake up the queue,
>> but you wake up the queue immediately after this hunk in the same function,
>> so isn't it guaranteed without scheduling another napi?
>>
> 
> The above code catches the case, where the ptr_ring is empty and the
> tx_queue is stopped.  It feels wrong not to reach in this case, but you
> *might* be right that it isn't strictly necessary, because below code
> will also call netif_tx_wake_queue() which *should* have a SKB stored
> that will *indirectly* trigger a restart of the NAPI.

I'm a bit confused.
Wrt (3), what you want is waking up the queue, right?
Or, what you want is actually NAPI reschedule itself?

My understanding was the former (wake up the queue).
If it's correct, (3) seems not necessary because you have already woken up the queue 
in the same function.

First NAPI
  veth_poll()
    // ptr_ring_empty() and queue_stopped()
   __napi_schedule() ... schedule second NAPI
   netif_tx_wake_queue() ... wake up the queue if queue_stopped()

Second NAPI
  veth_poll()
   netif_tx_wake_queue() ... this is what you want,
                             but the queue has been woken up in the first NAPI
                             What's the point?

> I will stare some more at the code to see if I can convince myself that
> we don't have to catch this case.
> 
> Please, also provide "How sure are you that this isn't necessary?"

I could not find the case we need (3) as I explained above.

--
Toshiaki Makita

