Return-Path: <bpf+bounces-50579-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1802CA29E08
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 01:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B7597A337A
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 00:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B53C1A296;
	Thu,  6 Feb 2025 00:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YDFA6ljx"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE05BDF60
	for <bpf@vger.kernel.org>; Thu,  6 Feb 2025 00:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738802839; cv=none; b=ZisKUEhZvP0g2R+SdNcf8ATqasISeKW822Mw+vdFcuK9u4KTi6U3yuDFPmZmWaxpBG1UUams0yesQR1CfmcGoxfTrgTHJlyaQJEVy1p9VIPtsoCMOU83r9mu01wcdQHN1yfQvZ4bqMO/G6v2ryn+qSnYHwYN9fgl9xdRCaB8W8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738802839; c=relaxed/simple;
	bh=VxQjeGbQQN+KvByPtNpdah6SCaateHxALZrLBUN8hgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qpARctB19/M9SYQk+Ek7XGg9FVwudvlXHJE6cWNMF2TQXf8g8HsbGuR9+kXxCQA7nBVFI25FaQ80UBWYU+fn04ql5TH8wDXdd2QvhAhs+fnC8NomKbitWoktLbiZa8L2WHVgf7x5pYzfxY5IdHiGPCyVhHUk5j42crZDqzu+PPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YDFA6ljx; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0a8e7b84-bab6-4852-8616-577d9b561f4c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738802833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GUFWFmqMR+h08Bo4fFsn/LKp8dHIbel6tFLRIU+gSS4=;
	b=YDFA6ljxAKn2JgWNs1yj/UPBnA8gUq9DbSZjuA79P1g6twiAcUzNG8bFGOLgvlgO1CmAlV
	KacMGlirODRwISqPlo1lvsO+rrIo4TmsNFlpeeUU/9thTl5H8aj4wxvK2pBDv7lYCUQvsn
	obnheSQmKcvSvtVtq8VJGumVYXnZBZA=
Date: Wed, 5 Feb 2025 16:47:04 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v8 10/12] bpf: make TCP tx timestamp bpf
 extension work
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, dsahern@kernel.org,
 willemdebruijn.kernel@gmail.com, willemb@google.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, horms@kernel.org,
 bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20250204183024.87508-1-kerneljasonxing@gmail.com>
 <20250204183024.87508-11-kerneljasonxing@gmail.com>
 <20250204175744.3f92c33e@kernel.org>
 <e894c427-b4b3-4706-b44c-44fc6402c14c@linux.dev>
 <CAL+tcoCQ165Y4R7UWG=J=8e=EzwFLxSX3MQPOv=kOS3W1Q7R0A@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAL+tcoCQ165Y4R7UWG=J=8e=EzwFLxSX3MQPOv=kOS3W1Q7R0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2/5/25 4:12 PM, Jason Xing wrote:
> On Thu, Feb 6, 2025 at 5:57 AM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>> On 2/4/25 5:57 PM, Jakub Kicinski wrote:
>>> On Wed,  5 Feb 2025 02:30:22 +0800 Jason Xing wrote:
>>>> +    if (cgroup_bpf_enabled(CGROUP_SOCK_OPS) &&
>>>> +        SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_TX_TIMESTAMPING) && skb) {
>>>> +            struct skb_shared_info *shinfo = skb_shinfo(skb);
>>>> +            struct tcp_skb_cb *tcb = TCP_SKB_CB(skb);
>>>> +
>>>> +            tcb->txstamp_ack_bpf = 1;
>>>> +            shinfo->tx_flags |= SKBTX_BPF;
>>>> +            shinfo->tskey = TCP_SKB_CB(skb)->seq + skb->len - 1;
>>>> +    }
>>>
>>> If BPF program is attached we'll timestamp all skbs? Am I reading this
>>> right?
>>
>> If the attached bpf program explicitly turns on the SK_BPF_CB_TX_TIMESTAMPING
>> bit of a sock, then all skbs of this sock will be tx timestamp-ed.
> 
> Martin, I'm afraid it's not like what you expect. Only the last
> portion of the sendmsg will enter the above function which means if
> the size of sendmsg is large, only the last skb will be set SKBTX_BPF
> and be timestamped.

Sure. The last skb of a large msg and more skb of small msg (or MSG_EOR).

My point is, only attaching a bpf alone is not enough. The 
SK_BPF_CB_TX_TIMESTAMPING still needs to be turned on.

> 
>>
>>>
>>> Wouldn't it be better to let BPF_SOCK_OPS_TS_SND_CB return whether it's
>>> interested in tracing current packet all the way thru the stack?
>>
>> I like this idea. It can give the BPF prog a chance to do skb sampling on a
>> particular socket.
>>
>> The return value of BPF_SOCK_OPS_TS_SND_CB (or any cgroup BPF prog return value)
>> already has another usage, which its return value is currently enforced by the
>> verifier. It is better not to convolute it further.
>>
>> I don't prefer to add more use cases to skops->reply either, which is an union
>> of args[4], such that later progs (in the cgrp prog array) may lose the args value.
>>
>> Jason, instead of always setting SKBTX_BPF and txstamp_ack_bpf in the kernel, a
>> new BPF kfunc can be added so that the BPF prog can call it to selectively set
>> SKBTX_BPF and txstamp_ack_bpf in some skb.
> 
> Agreed because at netdev 0x19 I have an explicit plan to share the
> experience from our company about how to trace all the skbs which were
> completed through a kernel module. It's how we use in production
> especially for debug or diagnose use.

This is fine. The bpf prog can still do that by calling the kfunc. I don't see 
why move the bit setting into kfunc makes the whole set won't work.

> I'm not knowledgeable enough about BPF, so I'd like to know if there
> are some functions that I can take as good examples?
> 
> I think it's a standalone and good feature, can I handle it after this series?

Unfortunately, no. Once the default is on, this cannot be changed.

I think Jakub's suggestion to allow bpf prog selectively choose skb to timestamp 
is useful, so I suggested a way to do it.


