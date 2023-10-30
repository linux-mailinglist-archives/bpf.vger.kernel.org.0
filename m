Return-Path: <bpf+bounces-13610-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAAF17DBB9A
	for <lists+bpf@lfdr.de>; Mon, 30 Oct 2023 15:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 033CB1C2082F
	for <lists+bpf@lfdr.de>; Mon, 30 Oct 2023 14:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C25179AF;
	Mon, 30 Oct 2023 14:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="Ic4ZQEsz"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497D717982;
	Mon, 30 Oct 2023 14:19:47 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDED7B7;
	Mon, 30 Oct 2023 07:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=pUI5nGy0LFYKow2okhoQ6OKyczy/kEldDjABNORebOc=; b=Ic4ZQEszf7DdPBZRY4YiXz7+XW
	MXv68gsOVMuwSkXRYL3DrKHyZyOzPhzVGgAzEr2A8oyeWtTuVUNGncN2F6Z6J4fvq0Qi+kxFw3Nv+
	Wf2XDjFO0BG4tlbg6rVzLmM4d2PQc1hwMNJAKKWQFYImP5WKESkANmYPNN6Qxph0TbYQdY3QbEPQ6
	Di2fOOca1/h91PJlU7/bCFlPRgI4jm3zJn92v3HYBljyZR/8uiXQ6JDr1dIDq0nhvxRVrE7nsJXX6
	TlIZkm3efA9OG3prnCXoxKJq8psh4siiA9ollSw1vn53aWlwdBFGj6ZROeQb92e8a3iV6UND6mRPD
	/f/ivMyw==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qxT72-0001SS-KC; Mon, 30 Oct 2023 15:19:28 +0100
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qxT71-000Y1o-O6; Mon, 30 Oct 2023 15:19:27 +0100
Subject: Re: [PATCH net] veth: Fix RX stats for bpf_redirect_peer() traffic
To: Peilin Ye <yepeilin.cs@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Peilin Ye <peilin.ye@bytedance.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 Cong Wang <cong.wang@bytedance.com>, Jiang Wang <jiang.wang@bytedance.com>,
 Youlun Zhang <zhangyoulun@bytedance.com>
References: <20231027184657.83978-1-yepeilin.cs@gmail.com>
 <20231027190254.GA88444@n191-129-154.byted.org>
 <59be18ff-dabc-2a07-3d78-039461b0f3f7@iogearbox.net>
 <20231028231135.GA2236124@n191-129-154.byted.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <94c88020-5282-c82b-8f88-a2d012444699@iogearbox.net>
Date: Mon, 30 Oct 2023 15:19:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231028231135.GA2236124@n191-129-154.byted.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27077/Mon Oct 30 08:39:55 2023)

On 10/29/23 1:11 AM, Peilin Ye wrote:
> On Sat, Oct 28, 2023 at 09:06:44AM +0200, Daniel Borkmann wrote:
>>>> diff --git a/net/core/filter.c b/net/core/filter.c
>>>> index 21d75108c2e9..7aca28b7d0fd 100644
>>>> --- a/net/core/filter.c
>>>> +++ b/net/core/filter.c
>>>> @@ -2492,6 +2492,7 @@ int skb_do_redirect(struct sk_buff *skb)
>>>>    			     net_eq(net, dev_net(dev))))
>>>>    			goto out_drop;
>>>>    		skb->dev = dev;
>>>> +		dev_sw_netstats_rx_add(dev, skb->len);
>>>
>>> This assumes that all devices that support BPF_F_PEER (currently only
>>> veth) use tstats (instead of lstats, or dstats) - is that okay?
>>
>> Dumb question, but why all this change and not simply just call ...
>>
>>    dev_lstats_add(dev, skb->len)
>>
>> ... on the host dev ?
> 
> Since I didn't want to update host-veth's TX counters.  If we
> bpf_redirect_peer()ed a packet from NIC TC ingress to Pod-veth TC ingress,
> I think it means we've bypassed host-veth TX?

Yes. So the idea is to transition to tstats replace the location where
we used to bump lstats with tstat's tx counter, and only the peer redirect
would bump the rx counter.. then upon stats traversal we fold the latter into
the rx stats which was populated by the opposite's tx counters. Makes sense.

OT: does cadvisor run inside the Pod to collect the device stats? Just
curious how it gathers them.

>>> If not, should I add another NDO e.g. ->ndo_stats_rx_add()?
>>
>> Definitely no new stats ndo resp indirect call in fast path.
> 
> Yeah, I think I'll put a comment saying that all devices that support
> BPF_F_PEER must use tstats (or must use lstats), then.

sgtm.

Thanks,
Daniel

