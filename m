Return-Path: <bpf+bounces-27998-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 334878B42D7
	for <lists+bpf@lfdr.de>; Sat, 27 Apr 2024 01:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFA661F23D58
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 23:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06A33C06B;
	Fri, 26 Apr 2024 23:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CVb3ShiT"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D39E3BBDC
	for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 23:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714175472; cv=none; b=YstFvAa/OWGL0H/GN0wsQ7VrSlwAMkRWE9A/BDFJiCFT49ON9y6sQq4NmW3NCoQUGzZryKowLdmFbVnHinz1Zh1mD3qTpBVTHI7uM0HAdRQECrMt++livuv54LPYKbWTnFM585WCyLgw9/SNXz6fzr8Zu0MiqnsI8fSQsbsil3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714175472; c=relaxed/simple;
	bh=UOv2aSPHtSJ211fWROncfK9M6zsTUFl405ydVst3K9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ueieWqEj5M46L1euryQEPGPrTsXVRRlJy2gShsE7t5ur2MdopfIlGuwbOMWkiyRgfCSpounk+GKFkzurd+PELcpyx+57y6LjTG/ETFrRcbEDob7YtkDK1sQnHc1/w7LgEAUeTUnuAnhNQ1J0gCjDTNDFoFnSdPeD0GqdXq0MCmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CVb3ShiT; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <379558fe-a6e2-444b-a6a7-ef233efa8311@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714175467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/GHDmjtDOSTgx3MzgQxrNQiEz0qPRdRT76sy97OELOM=;
	b=CVb3ShiTUn0xa4PG6OX8EmBXIc9zY36L10ebOPcSSWRWAE7ynY8/gPavHseNIiU3OkYG8v
	E6WqKEfo2oqkeRd1ShabxM6aKsSO5SMJ8j1ZAIlXDfHVM6e79WE8T/nGiC7don6w97B1rs
	GF92K151T07PZqqMpb5RpU4vCXP1b1w=
Date: Fri, 26 Apr 2024 16:50:59 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next v5 2/2] net: Add additional bit to support
 clockid_t timestamp type
To: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andrew Halaney <ahalaney@redhat.com>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>,
 kernel@quicinc.com
References: <20240424222028.1080134-1-quic_abchauha@quicinc.com>
 <20240424222028.1080134-3-quic_abchauha@quicinc.com>
 <2b2c3eb1-df87-40fe-b871-b52812c8ecd0@linux.dev>
 <e761e1de-0e11-4541-a4db-a1b793a60674@quicinc.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <e761e1de-0e11-4541-a4db-a1b793a60674@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 4/26/24 11:46 AM, Abhishek Chauhan (ABC) wrote:
>>> diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
>>> index 591226dcde26..f195b31d6e75 100644
>>> --- a/net/ipv4/ip_output.c
>>> +++ b/net/ipv4/ip_output.c
>>> @@ -1457,7 +1457,7 @@ struct sk_buff *__ip_make_skb(struct sock *sk,
>>>          skb->priority = (cork->tos != -1) ? cork->priority: READ_ONCE(sk->sk_priority);
>>>        skb->mark = cork->mark;
>>> -    skb->tstamp = cork->transmit_time;
>>> +    skb_set_tstamp_type_frm_clkid(skb, cork->transmit_time, sk->sk_clockid);
>> hmm... I think this will break for tcp. This sequence in particular:
>>
>> tcp_v4_timewait_ack()
>>    tcp_v4_send_ack()
>>      ip_send_unicast_reply()
>>        ip_push_pending_frames()
>>          ip_finish_skb()
>>            __ip_make_skb()
>>              /* sk_clockid is REAL but cork->transmit_time should be in mono */
>>              skb_set_tstamp_type_frm_clkid(skb, cork->transmit_time, sk->sk_clockid);;
>>
>> I think I hit it from time to time when running the test in this patch set.
>>
> do you think i need to check for protocol type here . since tcp uses Mono and the rest according to the new design is based on
> sk->sk_clockid
> if (iph->protocol == IPPROTO_TCP)
> 	skb_set_tstamp_type_frm_clkid(skb, cork->transmit_time, CLOCK_MONOTONIC);
> else
> 	skb_set_tstamp_type_frm_clkid(skb, cork->transmit_time, sk->sk_clockid);

Looks ok. iph->protocol is from sk->sk_protocol. I would defer to Willem input here.

There is at least one more place that needs this protocol check, __ip6_make_skb().

