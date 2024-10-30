Return-Path: <bpf+bounces-43491-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C39539B5B5E
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 06:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 485FE1F24FB0
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 05:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF441D1F5D;
	Wed, 30 Oct 2024 05:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Mim1FQ9e"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE3C1D131F
	for <bpf@vger.kernel.org>; Wed, 30 Oct 2024 05:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730266654; cv=none; b=VH26DX0/9wPM9ATnKMuavbL5/orsYRlS1J2b79X1m4166WVGriQNda9aJrr3BIkcwuLnqLuYbtw3R0qaQRX5V08vFJ86Lv2CGM0DXaU/XO1YOrp+oND8ULZdfWP2wRja8MJ4FQjNYpTmvsV9OAekAQjQM+BNZRIMkyYJMA2HLKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730266654; c=relaxed/simple;
	bh=iLnIhrlG+CozN0nP890uzAxeFT/8VLXW/nYxRDWorpU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D48600MTl60ATLyYaQLVgIJBKjzwD/8AznDZxOXm77COZG0UJW7ksb4l07/TOR03E5jyPVMdc8hVRWhx4xkfOCKrV0d2SqGZIWyb8Miuset2HV5wzDBDGyrxXdIsOSgw3rOPMKWddEHrsQKT01k3syN8pBEFRBoLrJBCozuj688=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Mim1FQ9e; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3c7c5f25-593f-4b48-9274-a18a9ea61e8f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730266649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=reQcU/j3xncUA/PGDWknFHcvbc/DQLVE0K0ar+e4i5Y=;
	b=Mim1FQ9ergVEiEXYRPbbepgROHwYIXlw8vsoXxcR41mADW9HYF1UknhTSIYTae28L9AbMm
	gxxfuh2KBhI5aYdbdEPP1ikRtmsZCjIYak5H+N0g1QQKziPA2ytVM728PQsGL+5I112rNF
	a+MLUW1IqEPmPlXCKv5LcnH80n0pEDY=
Date: Tue, 29 Oct 2024 22:37:18 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v3 02/14] net-timestamp: allow two features to
 work parallelly
To: Jason Xing <kerneljasonxing@gmail.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: willemb@google.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 ykolal@fb.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
 Jason Xing <kernelxing@tencent.com>
References: <20241028110535.82999-1-kerneljasonxing@gmail.com>
 <20241028110535.82999-3-kerneljasonxing@gmail.com>
 <61e8c5cf-247f-484e-b3cc-27ab86e372de@linux.dev>
 <CAL+tcoDB8UvNMfTwmvTJb1JvCGDb3ESaJMszh4-Qa=ey0Yn3Vg@mail.gmail.com>
 <67218fb61dbb5_31d4d029455@willemb.c.googlers.com.notmuch>
 <CAL+tcoBhfZ4XB5QgCKKbNyq+dfm26fPsvXfbWbV=jAEKYeLDEg@mail.gmail.com>
 <67219e5562f8c_37251929465@willemb.c.googlers.com.notmuch>
 <CAL+tcoDonudsr800HmhDir7f0B6cx0RPwmnrsRmQF=yDUJUszg@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAL+tcoDonudsr800HmhDir7f0B6cx0RPwmnrsRmQF=yDUJUszg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/29/24 8:04 PM, Jason Xing wrote:
>>>>>>>    static void skb_tstamp_tx_output(struct sk_buff *orig_skb,
>>>>>>>                                 const struct sk_buff *ack_skb,
>>>>>>>                                 struct skb_shared_hwtstamps *hwtstamps,
>>>>>>> @@ -5549,6 +5575,9 @@ static void skb_tstamp_tx_output(struct sk_buff *orig_skb,
>>>>>>>        u32 tsflags;
>>>>>>>
>>>>>>>        tsflags = READ_ONCE(sk->sk_tsflags);
>>>>>>> +     if (!sk_tstamp_tx_flags(sk, tsflags, tstype))
>>>>>>
>>>>>> I still don't get this part since v2. How does it work with cmsg only
>>>>>> SOF_TIMESTAMPING_TX_*?
>>>>>>
>>>>>> I tried with "./txtimestamp -6 -c 1 -C -N -L ::1" and it does not return any tx
>>>>>> time stamp after this patch.
>>>>>>
>>>>>> I am likely missing something
>>>>>> or v2 concluded that this behavior change is acceptable?
>>>>>
>>>>> Sorry, I submitted this series accidentally removing one important
>>>>> thing which is similar to what Vadim Fedorenko mentioned in the v1
>>>>> [1]:
>>>>> adding another member like sk_flags_bpf to handle the cmsg case.
>>>>>
>>>>> Willem, would it be acceptable to add another field in struct sock to
>>>>> help us recognise the case where BPF and cmsg works parallelly?
>>>>>
>>>>> [1]: https://lore.kernel.org/all/662873cb-a897-464e-bdb3-edf01363c3b2@linux.dev/
>>>>
>>>> The current timestamp flags don't need a u32. Maybe just reserve a bit
>>>> for this purpose?
>>>
>>> Sure. Good suggestion.
>>>
>>> But I think only using one bit to reflect whether the sk->sk_tsflags
>>> is used by normal or cmsg features is not enough. The existing
>>> implementation in tcp_sendmsg_locked() doesn't override the
>>> sk->sk_tsflags even the normal and cmsg features enabled parallelly.
>>> It only overrides sockc.tsflags in tcp_sendmsg_locked(). Based on
>>> that, even if at some point users suddenly remove the cmsg use and
>>> then the prior normal SO_TIMESTAMPING continues to work.
>>>
>>> How about this, please see below:
>>> For now, sk->sk_tsflags only uses 17 bits (see the last one
>>> SOF_TIMESTAMPING_OPT_RX_FILTER). The cmsg feature only uses 4 flags
>>> (see SOF_TIMESTAMPING_TX_RECORD_MASK in __sock_cmsg_send()). With that
>>> said, we could reserve the highest four bits for cmsg use for the
>>> moment. Four bits represents four points where we can record the
>>> timestamp in the tx case.
>>>
>>> Do you agree on this point?
>>
>> I don't follow.
>>
>> I probably miss the entire point.
>>
>> The goal for sockcm fields is to start with the sk field and
>> optionally override based on cmsg. This is what sockcm_init does for
>> tsflags.
>>
>> This information is for the skb, so these are recording flags.
>>
>> Why does the new datapath need to know whether features are enabled
>> through setsockopt or on a per-call basis with a cmsg?
>>
>> The goal was always to keep the reporting flags per socket, but make
>> the recording flag per packet, mainly for sampling.
> 
> If a user uses 1) cmsg feature, 2) bpf feature at the same time, we
> allow each feature to work independently.
> 
> How could it work? It relies on sk_tstamp_tx_flags() function in the
> current patch: when we are in __skb_tstamp_tx(), we cannot know which
> flags in each feature are set without fetching sk->sk_tsflags and
> sk->sk_tsflags_bpf. Then we are able to know what timestamp we want to
> record. To put it in a simple way, we're not sure if the user wants to
> see a SCHED timestamp by using the cmsg feature in __skb_tstamp_tx()
> if we hit this test statement "skb_shinfo(skb)->tx_flags &
> SKBTX_SCHED_TSTAMP)". So we need those two socket tsflag fields to
> help us.

I also don't see how a new bit/integer in a sk can help to tell the per cmsg 
on/off. This cmsg may have tx timestamp on while the next cmsg can have it off.

There is still one bit in skb_shinfo(skb)->tx_flags. How about define a 
SKBTX_BPF for everything. imo, the fine control on 
SOF_TIMESTAMPING_TX_{SCHED,SOFTWARE} is not useful for bpf. Almost all of the 
time the bpf program wants all available time stamps (sched, software, and 
hwtstamp if the NIC has it). Since bpf is in the kernel, it is much cheaper 
because it does not need to do skb_alloc/clone and queue to the error queue.

I think the bpf prog needs to capture a timestamp at the sendmsg() time, so a 
bpf prog needs to be called at sendmsg(). Then it may as well allow the bpf 
prog@sendmsg() to decide if it needs to set the SKBTX_BPF bit in 
skb_shinfo(skb)->tx_flags or not.

TCP_SKB_CB(skb)->txstamp_ack can also work similarly. There is still unused bit 
in "struct tcp_skb_cb", so may be adding TCP_SKB_CB(skb)->bpf_txstamp_ack

Then there is no need to control SOF_TIMESTAMPING_TX_* through bpf_setsockopt(). 
It only needs one bpf specific socket option like bpf_setsockopt(SOL_SOCKET, 
BPF_TX_TIMESTAMPING) to guard if the bpf-prog@sendmsg() needs to be called or 
not. There are already other TCP_BPF_IW,TCP_BPF_SNDCWND_CLAMP,... specific 
socket options.

imo, this is a simpler interface and also gives the bpf prog per packet control 
at the same time.

[ This user space cmsg-only testing has to be in the selftests/bpf to show how 
it can work. ]

> 
> Thanks,
> Jason


