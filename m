Return-Path: <bpf+bounces-59807-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2306BACF99B
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 00:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03FDF3B00DD
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 22:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FFB212B28;
	Thu,  5 Jun 2025 22:17:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dediextern.your-server.de (dediextern.your-server.de [85.10.215.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55B12AF0A;
	Thu,  5 Jun 2025 22:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.215.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749161873; cv=none; b=c921oQw3+TpZ90Ru1Gu+ZjJ6RGnnXSrKmiwYJRJ9RxbSF20De4aV77B5V014bN1vtHtJgSghwMHuP/ihnJzhzkZdab0HGEKgEE3ntoLceB8Fx846Mr1cjjpAX8+g3a6gTecjLLGR9EBGsoX7eQNbHteXCiorRm3GPoTFllhiHh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749161873; c=relaxed/simple;
	bh=2WQ9W11exx47Q9f3WT3IYNFY7Jbv+k4/wE0FVLTuGYk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sk6sLP2pkhYJh2/0eBNJcBs0eP4oV/t3jHAOMBdaPpxudbJPrh9r13KuoGuJyNNISJAWFWoaJeC9oq/6FCG04aneEjw+2OkQpGC96mTuX5yRygq2JDFFD6GQp35INzh0GdmLd7ZSnjwsq4vhr4PneyjDG/jIugjZHU3hXaKa2P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hetzner-cloud.de; spf=pass smtp.mailfrom=hetzner-cloud.de; arc=none smtp.client-ip=85.10.215.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hetzner-cloud.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hetzner-cloud.de
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by dediextern.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <marcus.wichelmann@hetzner-cloud.de>)
	id 1uNIu2-000Pxi-0p; Fri, 06 Jun 2025 00:17:38 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <marcus.wichelmann@hetzner-cloud.de>)
	id 1uNIu1-0005A0-1q;
	Fri, 06 Jun 2025 00:17:38 +0200
Message-ID: <5f19b555-b0fa-472a-a5f3-6673c0b69c5c@hetzner-cloud.de>
Date: Fri, 6 Jun 2025 00:17:37 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] veth: TX drops with NAPI enabled and crash in combination
 with qdisc
To: Eric Dumazet <edumazet@google.com>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jamal Hadi Salim <jhs@mojatatu.com>,
 Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 linux-kernel@vger.kernel.org
References: <9da42688-bfaa-4364-8797-e9271f3bdaef@hetzner-cloud.de>
 <87zfemtbah.fsf@toke.dk>
 <CANn89i+7crgdpf-UXDpTNdWfei95+JHyMD_dBD8efTbLBnvZUQ@mail.gmail.com>
 <CANn89iKpZ5aLNpv66B9M4R1d_Pn5ZX=8-XaiyCLgKRy3marUtQ@mail.gmail.com>
Content-Language: en-US
From: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
Autocrypt: addr=marcus.wichelmann@hetzner-cloud.de; keydata=
 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
 wySmewx3h/yfMh0aFxHhvLPxrO2IEQ==
In-Reply-To: <CANn89iKpZ5aLNpv66B9M4R1d_Pn5ZX=8-XaiyCLgKRy3marUtQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: marcus.wichelmann@hetzner-cloud.de
X-Virus-Scanned: Clear (ClamAV 1.0.7/27659/Thu Jun  5 10:37:15 2025)

Am 06.06.25 um 00:11 schrieb Eric Dumazet:
> On Thu, Jun 5, 2025 at 9:46 AM Eric Dumazet <edumazet@google.com> wrote:
>>
>> On Thu, Jun 5, 2025 at 9:15 AM Toke Høiland-Jørgensen <toke@redhat.com> wrote:
>>>
>>> Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de> writes:
>>>
>>>> Hi,
>>>>
>>>> while experimenting with XDP_REDIRECT from a veth-pair to another interface, I
>>>> noticed that the veth-pair looses lots of packets when multiple TCP streams go
>>>> through it, resulting in stalling TCP connections and noticeable instabilities.
>>>>
>>>> This doesn't seem to be an issue with just XDP but rather occurs whenever the
>>>> NAPI mode of the veth driver is active.
>>>> I managed to reproduce the same behavior just by bringing the veth-pair into
>>>> NAPI mode (see commit d3256efd8e8b ("veth: allow enabling NAPI even without
>>>> XDP")) and running multiple TCP streams through it using a network namespace.
>>>>
>>>> Here is how I reproduced it:
>>>>
>>>>   ip netns add lb
>>>>   ip link add dev to-lb type veth peer name in-lb netns lb
>>>>
>>>>   # Enable NAPI
>>>>   ethtool -K to-lb gro on
>>>>   ethtool -K to-lb tso off
>>>>   ip netns exec lb ethtool -K in-lb gro on
>>>>   ip netns exec lb ethtool -K in-lb tso off
>>>>
>>>>   ip link set dev to-lb up
>>>>   ip -netns lb link set dev in-lb up
>>>>
>>>> Then run a HTTP server inside the "lb" namespace that serves a large file:
>>>>
>>>>   fallocate -l 10G testfiles/10GB.bin
>>>>   caddy file-server --root testfiles/
>>>>
>>>> Download this file from within the root namespace multiple times in parallel:
>>>>
>>>>   curl http://[fe80::...%to-lb]/10GB.bin -o /dev/null
>>>>
>>>> In my tests, I ran four parallel curls at the same time and after just a few
>>>> seconds, three of them stalled while the other one "won" over the full bandwidth
>>>> and completed the download.
>>>>
>>>> This is probably a result of the veth's ptr_ring running full, causing many
>>>> packet drops on TX, and the TCP congestion control reacting to that.
>>>>
>>>> In this context, I also took notice of Jesper's patch which describes a very
>>>> similar issue and should help to resolve this:
>>>>   commit dc82a33297fc ("veth: apply qdisc backpressure on full ptr_ring to
>>>>   reduce TX drops")
>>>>
>>>> But when repeating the above test with latest mainline, which includes this
>>>> patch, and enabling qdisc via
>>>>   tc qdisc add dev in-lb root sfq perturb 10
>>>> the Kernel crashed just after starting the second TCP stream (see output below).
>>>>
>>>> So I have two questions:
>>>> - Is my understanding of the described issue correct and is Jesper's patch
>>>>   sufficient to solve this?
>>>
>>> Hmm, yeah, this does sound likely.
>>>
>>>> - Is my qdisc configuration to make use of this patch correct and the kernel
>>>>   crash is likely a bug?
>>>>
>>>> ------------[ cut here ]------------
>>>> UBSAN: array-index-out-of-bounds in net/sched/sch_sfq.c:203:12
>>>> index 65535 is out of range for type 'sfq_head [128]'
>>>
>>> This (the 'index 65535') kinda screams "integer underflow". So certainly
>>> looks like a kernel bug, yeah. Don't see any obvious reason why Jesper's
>>> patch would trigger this; maybe Eric has an idea?
>>>
>>> Does this happen with other qdiscs as well, or is it specific to sfq?
>>
>> This seems like a bug in sfq, we already had recent fixes in it, and
>> other fixes in net/sched vs qdisc_tree_reduce_backlog()
>>
>> It is possible qdisc_pkt_len() could be wrong in this use case (TSO off ?)
> 
> This seems to be a very old bug, indeed caused by sch->gso_skb
> contribution to sch->q.qlen
> 
> diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
> index b912ad99aa15d95b297fb28d0fd0baa9c21ab5cd..77fa02f2bfcd56a36815199aa2e7987943ea226f
> 100644
> --- a/net/sched/sch_sfq.c
> +++ b/net/sched/sch_sfq.c
> @@ -310,7 +310,10 @@ static unsigned int sfq_drop(struct Qdisc *sch,
> struct sk_buff **to_free)
>                 /* It is difficult to believe, but ALL THE SLOTS HAVE
> LENGTH 1. */
>                 x = q->tail->next;
>                 slot = &q->slots[x];
> -               q->tail->next = slot->next;
> +               if (slot->next == x)
> +                       q->tail = NULL; /* no more active slots */
> +               else
> +                       q->tail->next = slot->next;
>                 q->ht[slot->hash] = SFQ_EMPTY_SLOT;
>                 goto drop;
>         }
> 

Hi,

thank you for looking into it.
I'll give your patch a try and will also do tests with other qdiscs as well when I'm back
in office.

Marcus

