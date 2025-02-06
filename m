Return-Path: <bpf+bounces-50619-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 241FCA2A0B9
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 07:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35041161F26
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 06:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4198224893;
	Thu,  6 Feb 2025 06:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HA1BjPN7"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6272E64A
	for <bpf@vger.kernel.org>; Thu,  6 Feb 2025 06:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738822373; cv=none; b=PxMO1TC6yMxE+DswFw5KiI1EGpD0iXx8Lu2hn2G4D04KLxJbmQB7pNVdl/fz3P0EK1AnXWrEnpKwpHHqaTrSxk+Olp/8kpTJgk4gBBKJQ+vS+t4G1qwVlIRIpclKFjiyNroR85Z00phkjdrBUNVcv40h1A2vkjcRB1oyDi5jqQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738822373; c=relaxed/simple;
	bh=hogkxHDEfpKbYOQm+WoV7gcsiLjVcIZZhSZnar9SZ2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bhUQ9YSmbjmle5pCy94COfa0s2w1zQec95Suh/lSkIblZL6bitUv3aU9//GU9F6b4wt1Y/V/hlOhY4SHo/AdxtgyDWMujmUx3NwxPNojZIBZFbji+YwoMvITGWFayi3WKZPmrozlwrniHg1vlWAMwbSjkBuWt/0k8WBXj96fRaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HA1BjPN7; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b158a837-d46c-4ae0-8130-7aa288422182@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738822359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fP09qw0fTTx05drYQv3984Q2Z6Ps7338BY1vTUz5Gr0=;
	b=HA1BjPN7H6pdK3AQPHUWBR9CHXN16ayPkbkeHGvuP2GKpSsCEwT2H2iw6bGpEyB9tWasQe
	Rk/oV7PeEgmp+rux3MlammoofunRdZXnGozYtW9LE2xOhbOCmu5TQp39Yq2QnfC7p6LTgq
	zsMyB+R+joci9qA/38YWvfSVpCszJTI=
Date: Wed, 5 Feb 2025 22:12:29 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v8 10/12] bpf: make TCP tx timestamp bpf
 extension work
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, dsahern@kernel.org, willemb@google.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, horms@kernel.org,
 bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20250204183024.87508-1-kerneljasonxing@gmail.com>
 <20250204183024.87508-11-kerneljasonxing@gmail.com>
 <20250204175744.3f92c33e@kernel.org>
 <e894c427-b4b3-4706-b44c-44fc6402c14c@linux.dev>
 <CAL+tcoCQ165Y4R7UWG=J=8e=EzwFLxSX3MQPOv=kOS3W1Q7R0A@mail.gmail.com>
 <0a8e7b84-bab6-4852-8616-577d9b561f4c@linux.dev>
 <CAL+tcoAp8v49fwUrN5pNkGHPF-+RzDDSNdy3PhVoJ7+MQGNbXQ@mail.gmail.com>
 <CAL+tcoC5hmm1HQdbDaYiQ1iW1x2J+H42RsjbS_ghyG8mSDgqqQ@mail.gmail.com>
 <67a424d2aa9ea_19943029427@willemb.c.googlers.com.notmuch>
 <CAL+tcoCPGAjs=+Hnzr4RLkioUV7nzy=ZmKkTDPA7sBeVP=qzow@mail.gmail.com>
 <67a42ba112990_19c315294b7@willemb.c.googlers.com.notmuch>
 <CAL+tcoC_5106onp6yQh-dKnCTLtEr73EZVC31T_YeMtqbZ5KBw@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAL+tcoC_5106onp6yQh-dKnCTLtEr73EZVC31T_YeMtqbZ5KBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2/5/25 7:41 PM, Jason Xing wrote:
> On Thu, Feb 6, 2025 at 11:25 AM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
>>
>>>>> I think we can split the whole idea into two parts: for now, because
>>>>> of the current series implementing the same function as SO_TIMETAMPING
>>>>> does, I will implement the selective sample feature in the series.
>>>>> After someday we finish tracing all the skb, then we will add the
>>>>> corresponding selective sample feature.
>>>>
>>>> Are you saying that you will include selective sampling now or want to
>>>> postpone it?
>>>
>>> A few months ago, I planned to do it after this series. Since you all
>>> ask, it's not complex to have it included in this series :)
>>>
>>> Selective sampling has two kinds of meaning like I mentioned above, so
>>> in the next re-spin I will implement the cmsg feature for bpf
>>> extension in this series.
>>
>> Great thanks.
> 
> I have to rephrase a bit in case Martin visits here soon: I will
> compare two approaches 1) reply value, 2) bpf kfunc and then see which
> way is better.

I have already explained in details why the 1) reply value from the bpf prog 
won't work. Please go back to that reply which has the context.

> 
>>
>>> I'm doing the test right now. And leave
>>> another selective sampling small feature until the feature of tracing
>>> all the skbs is implemented if possible.
>>
>> Can you elaborate on this other feature?
> 
> Do you recall oneday I asked your opinion privately about whether we
> can trace _all the skbs_ (not the last skb from each sendmsg) to have
> a better insight of kernel behaviour? I can also see a couple of
> latency issues in the kernel. If it is approved, then corresponding
> selective sampling should be supported. It's what I was trying to
> describe.
> 
> The advantage of relying on the timestamping feature is that we can
> isolate normal flows and monitored flow so that normal flows wouldn't
> be affected because of enabling the monitoring feature, compared to so
> many open source monitoring applications I've dug into. They usually
> directly hook the hot path like __tcp_transmit_skb() or
> dev_queue_xmit, which will surely influence the normal flows and cause
> performance degradation to some extent. I noticed that after
> conducting some tests a few months ago. The principle behind the bpf
> fentry is to replace some instructions at the very beginning of the
> hooked function, so every time even normal flows entering the
> monitored function will get affected.

I sort of guess this while stalled in the traffic... :/

I was not asking to be able to "selective on all skb of a large msg". This will 
be a separate topic. If we really wanted to support this case (tbh, I am not 
convinced) in the future, there is more reason the default behavior should be 
"off" now for consistency reason.

The comment was on the existing tcp_tx_timestamp(). First focus on allowing 
selective tracking of the skb that the current tcp_tx_timestamp() also tracks 
because it is the most understood use case. This will allow the bpf prog to 
select which tcp_sendmsg call it should track/sample. Perhaps the bpf prog will 
limit tracking X numbers of packets and then will stop there. Perhaps the bpf 
prog will only allocate X numbers of sample spaces in the bpf_sk_storage to 
track packet. There are many reasons that bpf prog may want to sample and stop 
tracking at some point even in the current tcp_tx_timestamp().


