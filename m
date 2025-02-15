Return-Path: <bpf+bounces-51677-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03DBEA37108
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 23:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88C01188768E
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 22:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503A41F4180;
	Sat, 15 Feb 2025 22:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZKxB7WjP"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9B319ABAB
	for <bpf@vger.kernel.org>; Sat, 15 Feb 2025 22:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739660315; cv=none; b=EamHFbgwqQ0vJFqOFbA52Qh4WQZWEzccKQZ/P/mnSxFVD/nmiE12XOA9aymwHz0ukh4wDb9UdQXNlq4YoxiXfNmKEoE3ashy+OYtITLqSyFQpqIIUBqOrRLpDtdM2KmZCSeX52Nw9j7bZWqUBd4o4pOKCfkbxeyYllp6nvGF9yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739660315; c=relaxed/simple;
	bh=BdjZ8AvaMo+4vT6WOPlVLaw1KC7ESQktdEzrstI2iF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CjxCaRBl4craa1z8vLE0owe0XRGh43nG0oCqMX51bBbK0LUwDKuyaqqAkNxQS2jRra/Dj5NTgyOGPHR78do+nvpHbrnbH0oLmzSP9Fy8zXtT99vNz4DRPgN2kTbVSGNW4pmHLD75oi0Kubf5NgErbi+W6bY0ConG8Ye+LXIVafk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZKxB7WjP; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <89989129-9336-4863-a66e-e9c8adc60072@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739660310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dfD2/0hL8j3i+NT1kl65z5I0PEXW+Bhj5oJKamC5By4=;
	b=ZKxB7WjPFszc9GFuuNGwKrBTDWXsndMnY0pxTdj+vwXhsRBixPIDUevjjyry/qKeigMU5I
	3EGzpjSpA5gb9gFObRHQuLKwQybG/hT/HT5lIisH4ZC0ykDGW7Zxe1ERPTOO+dmRU4SlQQ
	9UAqdKXhycClrIgUj+5hzW32zcWYwvk=
Date: Sat, 15 Feb 2025 14:58:22 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v11 08/12] bpf: add BPF_SOCK_OPS_TS_HW_OPT_CB
 callback
To: Jason Xing <kerneljasonxing@gmail.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemb@google.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, horms@kernel.org,
 bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20250214010038.54131-1-kerneljasonxing@gmail.com>
 <20250214010038.54131-9-kerneljasonxing@gmail.com>
 <67b0ad8819948_36e344294a7@willemb.c.googlers.com.notmuch>
 <CAL+tcoAJHSfBrfdn-Cmk=9ZkMNSdkGYKJbZ0mynn_=qU9Mp1Ag@mail.gmail.com>
 <67b0d831bf13f_381893294f4@willemb.c.googlers.com.notmuch>
 <CAL+tcoDhtBFjVBMWObHq3LaSNXgJN_UWBVONAqD=t7CRYN_PAg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <CAL+tcoDhtBFjVBMWObHq3LaSNXgJN_UWBVONAqD=t7CRYN_PAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2/15/25 2:23 PM, Jason Xing wrote:
> On Sun, Feb 16, 2025 at 2:08 AM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
>>
>> Jason Xing wrote:
>>> On Sat, Feb 15, 2025 at 11:06 PM Willem de Bruijn
>>> <willemdebruijn.kernel@gmail.com> wrote:
>>>>
>>>> Jason Xing wrote:
>>>>> Support hw SCM_TSTAMP_SND case for bpf timestamping.
>>>>>
>>>>> Add a new sock_ops callback, BPF_SOCK_OPS_TS_HW_OPT_CB. This
>>>>> callback will occur at the same timestamping point as the user
>>>>> space's hardware SCM_TSTAMP_SND. The BPF program can use it to
>>>>> get the same SCM_TSTAMP_SND timestamp without modifying the
>>>>> user-space application.
>>>>>
>>>>> To avoid increasing the code complexity, replace SKBTX_HW_TSTAMP
>>>>> with SKBTX_HW_TSTAMP_NOBPF instead of changing numerous callers
>>>>> from driver side using SKBTX_HW_TSTAMP. The new definition of
>>>>> SKBTX_HW_TSTAMP means the combination tests of socket timestamping
>>>>> and bpf timestamping. After this patch, drivers can work under the
>>>>> bpf timestamping.
>>>>>
>>>>> Considering some drivers doesn't assign the skb with hardware
>>>>> timestamp,
>>>>
>>>> This is not for a real technical limitation, like the skb perhaps
>>>> being cloned or shared?
>>>
>>> Agreed on this point. I'm kind of familiar with I40E, so I dare to say
>>> the reason why it doesn't assign the hwtstamp is because the skb will
>>> soon be destroyed, that is to say, it's pointless to assign the
>>> timestamp.
>>
>> Makes sense.
>>
>> But that does not ensure that the skb is exclusively owned. Nor that
>> the same is true for all drivers using this API (which is not small,
>> but small enough to manually review if need be).
>>
>> The first two examples I happened to look at, i40e and bnx2x, both use
>> skb_get() to get a non-exclusive skb reference for their ptp_tx_skb.

I think the existing __skb_tstamp_tx() function is also assigning to 
skb_hwtstamps(skb). The skb may be cloned from the orig_skb first, but they 
still share the same shinfo. My understanding is that this patch is assigning to 
the shinfo earlier, so it should not have changed the driver's expectation on 
the skb_hwtstamps(skb) after calling __skb_tstamp_tx(). If there are drivers 
assuming exclusive access to the skb_hwtstamps(skb), probably it is something 
that needs to be addressed regardless and should not be the common case?



