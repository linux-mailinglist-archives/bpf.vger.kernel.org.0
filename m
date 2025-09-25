Return-Path: <bpf+bounces-69701-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A15B9EA55
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 12:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1A8A4C78B9
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 10:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BCD2ECD37;
	Thu, 25 Sep 2025 10:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VeA/hF1f"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D0D2EC569
	for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 10:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758796095; cv=none; b=C2AicIsP2xclkGD7nC6Xjr5SQDCEZ7L/KOtmq95yNvL29YC+55bgKY/KOuTvY+ANBHjHDhXzdkSh5qfYCCz5Kr780H8lSO2V41fBp+wmxLwqR3BNJHZAnOnKPfu8PRx8YHDQ2aslZ4bA5bXLwfRQgrd/K30jgFaoGdjsvLm7dRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758796095; c=relaxed/simple;
	bh=fCJa3DLjw9wWm3YVXWypadAkRQz6cPsnPd46/rToZIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hmI1s21RYPCTEHsWsfEWT+FjBfsYp+nkb7kPKCLyEgl8GMWzPj9dTwuMww2smZ964a11fMZVlGeI9Qljn2xjPsGbu2ch5EKZi2rDgGD33lr3ODIeHI1gfIQTYjRkKB+O9ly0BOYejy/wi2j+OyqtVp99ydmcu3fdrARKxJTdSpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VeA/hF1f; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-634578d2276so78097a12.3
        for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 03:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758796091; x=1759400891; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AkkQhkQp0131ZIKNy1iXUtHUjD1n/PLL5NGGdY7hx9Y=;
        b=VeA/hF1fEafh2ltsyw6VMP+CM6z9Ok0mpZb5lPZoE9yLpUYM1BIXGB6sBuKxiMMHiV
         2kEpgRuQnT83ZD+Opev6Ql3UbcSvzoo3W/YyEzk/5hrKPGnjHGlljVTKNXXpd4Z2tbSV
         OfyIXr7WMUG3K7Hx7Y2HHAEN0N58LdMkWQksHMRzxuqXElaKngDOgYoB6AiCR7w1QaqD
         4KPSfdwG+a9H/PVxpDo8d0tTBdP8jE6R29VQTdl93X6IvWrlb29Q9q60Nwpz2LJAQg5c
         jWUpxjH0YD6NGyr/Kf7z5EwnJWFEXVehf5QuDrUgAtiKlMb88QGu6xpNHqKaIIrALQMJ
         fNXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758796091; x=1759400891;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AkkQhkQp0131ZIKNy1iXUtHUjD1n/PLL5NGGdY7hx9Y=;
        b=YYnV9Hpzkuk3TyYXfRXMNeEo+kUk+zWixq6T21yRfstHGRMdpVN3Q7nqfg6gIp92Vl
         b5bWtSjNjHd1IdZmvqX8Ln6kMI19X+T6RbFhUf32USMIF2reZPf/cZ/863MNMuSD4SI7
         WIpklNbPztAuls4v2lu+CqIQskKdGZOLaUEs2RHKsY4SzQp4jKW8enxqH91yvHv+yOCP
         WIMKQmiH/2GwAvP/J+01s0N8sgNU6OGdE6q21lxT3vayiA15OIX0muDERrGVlaM4i6ml
         HSCXEphMN6LWYSw9M8y87Kc7j6nDlGnDz0Iqhm/SiSnt6Hluk8Y6B/RRGN+2ZmoIYduQ
         KSVA==
X-Forwarded-Encrypted: i=1; AJvYcCVunvORuZ4vtcwwHconkgbt/UcWD3eKbO4XqlupcZoWAG55yEOgi0KgP3RGUhvOQv2PRDk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj3RidAbqvcyqxB8x56mRgOO0QUi8tId0dC7h6yFstUv2SuvIL
	fX+FfgBqfzzok4adWEEHzZSJtuZbpsZt6sPVtB9GhCnC65Wia72LFF4L
X-Gm-Gg: ASbGnct0THh4BgAgM8QZEsrkzxhZ1NR8w0uq9LOkvPdXs6crHwxmPwlxLVfjq2XnA/5
	Br+uie6YaPfPCYCZTsht3KLK6GQeUCXCokdL5/MHctar9fvkpSHA+FNsUzsGFhxLzUPSofpPKzw
	CdkWrzJLXAWWO+w6uahP4V8fybfzyav5yY/4K0+eXZWxODgs8vh4MTIsQRu05P/Qv0BbwmiaKXN
	ca1swmyTW2i+bM9Lz5RaWz6MXG4ppwun9Fe2+m5TLTLyuaLfVh9luAdXVER2hC58fLB/vAV5XN8
	AVAspJ/fdBKYuZAaYjOAHvO+1ODSFc/hhpvhJQfBfD9J6Vo2Zay7KAwecKRiJ4fggfRe2ItbSin
	zeCdxxga68WBdRoT8YMjm4r6F6ZXj1h/0RA6RFI6Mq/Q=
X-Google-Smtp-Source: AGHT+IEJRAjZWd8i/spFohWijM9GpkErorZXWbmJA8bf0ZF8n/1FpAdkOBR7e4k1rIrGaK9+GbCQ4A==
X-Received: by 2002:a17:907:9493:b0:b0e:e45:f934 with SMTP id a640c23a62f3a-b34ba350c67mr180986166b.4.1758796091304;
        Thu, 25 Sep 2025 03:28:11 -0700 (PDT)
Received: from [192.168.1.105] ([165.50.112.244])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3545a9769bsm139873366b.99.2025.09.25.03.28.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 03:28:10 -0700 (PDT)
Message-ID: <e85e7bb2-6229-4b04-9c2a-7a7b79497c6c@gmail.com>
Date: Thu, 25 Sep 2025 12:28:07 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/4] Add XDP RX queue index metadata via kfuncs
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, donald.hunter@gmail.com, andrew+netdev@lunn.ch,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, matttbe@kernel.org, chuck.lever@oracle.com,
 jdamato@fastly.com, skhawaja@google.com, dw@davidwei.uk,
 mkarsten@uwaterloo.ca, yoong.siang.song@intel.com,
 david.hunter.linux@gmail.com, skhan@linuxfoundation.org, horms@kernel.org,
 sdf@fomichev.me, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org
References: <20250923210026.3870-1-mehdi.benhadjkhelifa@gmail.com>
 <87h5wq50l0.fsf@cloudflare.com>
 <0cddb596-a70b-48d4-9d8e-c6cb76abd9d2@gmail.com>
 <87348a4yyd.fsf@cloudflare.com>
Content-Language: en-US
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
In-Reply-To: <87348a4yyd.fsf@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/25/25 11:18 AM, Jakub Sitnicki wrote:
> On Thu, Sep 25, 2025 at 11:54 AM +01, Mehdi Ben Hadj Khelifa wrote:
>> On 9/25/25 10:43 AM, Jakub Sitnicki wrote:
>>> On Tue, Sep 23, 2025 at 10:00 PM +01, Mehdi Ben Hadj Khelifa wrote:
>>>>    This patch series is intended to make a base for setting
>>>>    queue_index in the xdp_rxq_info struct in bpf/cpumap.c to
>>>>    the right index. Although that part I still didn't figure
>>>>    out yet,I m searching for my guidance to do that as well
>>>>    as for the correctness of the patches in this series.
>>> What is the use case/movtivation behind this work?
>>
>> The goal of the work is to have xdp programs have the correct packet RX queue
>> index after being redirected through cpumap because currently the queue_index
>> gets unset or more accurately set to 0 as a default in xdp_rxq_info. This is my
>> current understanding.I still have to know how I can propogate that HW hint from
>> the NICs to the function where I need it.
> 
> This explains what this series does, the desired end state of
> information passing, but not why is does it - how that information is
> going to be consumed? To what end?

In my vision,The queue index propagated correctly through cpumap can 
help xdp programs use it for things such as per queue load 
balancing,Adaptive RSS tuning and even maybe for DDoS mitigation where 
they can drop traffic per queue.I mean if these aren't correct intents 
or if they don't justify the added code, I can abort working on it. Even 
if they weren't I need more guidance on how I can have that metadata 
from HW hints...
Best Regards,
Mehdi


