Return-Path: <bpf+bounces-50588-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC86EA29E4D
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 02:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1331E7A1942
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 01:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1419B29CE7;
	Thu,  6 Feb 2025 01:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="c4XsHugj"
X-Original-To: bpf@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2E338382
	for <bpf@vger.kernel.org>; Thu,  6 Feb 2025 01:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738805309; cv=none; b=V9DH2BHzswUCuN90NbK0KnD40fBSTha1tHWCVM9k7+7+vpUL9nl8PR2hfoFtHGyhI4+vySCRfsknRDEvs7ogA0f0Oiah+NRgro++Ng9c5i6gb1XRQszk1Q6QzSe5an+ApIqMhRW6+jTlEP49RWrh/LCk8B9w7Mc6hoYhO/E7FwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738805309; c=relaxed/simple;
	bh=3Lq3wjRVl9BW+oH1mXAnnGQkE0IvancZjj2TWRaOdpM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gf3p7IQ2MIWmM8ZYlhzyz1Bq9NAQ50XTf/HFdWHCYq47i77Lrle1zeJASQCtUpc1i1Ey6IK3SY8tjbTgmDjNu/QlIXLAhJ9qXYKTgoO/IL+o5FOmUOGOzfn6H24dnF3jYMd1mZTO+/IDlAA1MtCN+rXr4A0fFJM6pfIzi4DPXWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=c4XsHugj; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c329a0c1-239b-4ca1-91f2-cb30b8dd2f6a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738805296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4w4U8VzyhxI66dOB3BIsCAftLL1BbynAFr9320rct40=;
	b=c4XsHugj/Cu48+g0CYB+7KJhgt7cewiQd1ORooUEEfAKN+AwPnWpIepKcUZiclV3JCHJI4
	CeJNP3v8p6MT8/HVCrrURBGT90+Z6RYqTX8LkPtmkdBLaqcgELmoP50Juk5I2wER3SjR21
	RGKEPQn0lDZHUz2JoTUys+J8oULqDZU=
Date: Wed, 5 Feb 2025 17:28:09 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v8 12/12] selftests/bpf: add simple bpf tests in
 the tx path for timestamping feature
To: Jason Xing <kerneljasonxing@gmail.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemb@google.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, horms@kernel.org,
 bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20250204183024.87508-1-kerneljasonxing@gmail.com>
 <20250204183024.87508-13-kerneljasonxing@gmail.com>
 <67a389af981b0_14e0832949d@willemb.c.googlers.com.notmuch>
 <CAL+tcoC6egv7dTqESYy8Z80OoacvjgxLvsTXukUZZDgbLxH8AA@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAL+tcoC6egv7dTqESYy8Z80OoacvjgxLvsTXukUZZDgbLxH8AA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/5/25 8:08 AM, Jason Xing wrote:
>>> +     switch (skops->op) {
>>> +     case BPF_SOCK_OPS_TS_SCHED_OPT_CB:
>>> +             delay = val->sched_delay = timestamp - val->sendmsg_ns;
>>> +             break;
>>
>> For a test this is fine. But just a reminder that in general a packet
>> may pass through multiple qdiscs. For instance with bonding or tunnel
>> virtual devices in the egress path.
> 
> Right, I've seen this in production (two times qdisc timestamps
> because of bonding).
> 
>>
>>> +     case BPF_SOCK_OPS_TS_SW_OPT_CB:
>>> +             prior_ts = val->sched_delay + val->sendmsg_ns;
>>> +             delay = val->sw_snd_delay = timestamp - prior_ts;
>>> +             break;
>>> +     case BPF_SOCK_OPS_TS_ACK_OPT_CB:
>>> +             prior_ts = val->sw_snd_delay + val->sched_delay + val->sendmsg_ns;
>>> +             delay = val->ack_delay = timestamp - prior_ts;
>>> +             break;
>>
>> Similar to the above: fine for a test, but in practice be aware that
>> packets may be resent, in which case an ACK might precede a repeat
>> SCHED and SND. And erroneous or malicious peers may also just never
>> send an ACK. So this can never be relied on in production settings,
>> e.g., as the only signal to clear an entry from a map (as done in the
>> branch below).

All good points. I think all these notes should be added as comment to the test.

I think as a test, this will be a good start and can use some followup to 
address the cases.

> 
> Agreed. In production, actually what we do is print all the timestamps
> and let an agent parse them.

The BPF program that runs in the kernel can provide its own user interface that 
best fits its environment. If a raw printing interface is sufficient, that works 
well and is simple on the BPF program side. If the production system cannot 
afford the raw printing cost, the bpf prog can perform some aggregation first.

The BPF program should be able to detect when an outgoing skb is re-transmitted 
and act accordingly. There is BPF timer to retire entries for which no ACK has 
been received.

Potentially, this data can be aggregated into the individual bpf_sk_storage or 
using a BPF map keyed by a particular IP address prefix.

I just want to highlight here for people in the future referencing this thread 
to look for implementation ideas.

