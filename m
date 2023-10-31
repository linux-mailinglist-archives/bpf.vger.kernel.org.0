Return-Path: <bpf+bounces-13761-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6867DD82A
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 23:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F22EB2107D
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 22:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB6F2744B;
	Tue, 31 Oct 2023 22:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="B3fP9cX5"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F53A28;
	Tue, 31 Oct 2023 22:20:46 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38AC2F3;
	Tue, 31 Oct 2023 15:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=NfaUNK9Gnj3jV65G++Jz1u69ma76y4R62RU6zrUykfs=; b=B3fP9cX5+GEozlK4l6bigX6CuZ
	lT42tJF+EPt9WJw7oBh4z+EYjqV7oH36njpu2YEbN9FbWoiy7sA3lDs8maIXRAukKSxNyCYOOrUwV
	4geNMJlQWeM7PXdUsBgxX27DIxZIVyRgbxq5FfwS2KPJMik5q0mqRLzB5sO3FaELAgjQCpSMxTx2f
	geSMoqnlkcrGbIwXXdT7cawzaVuTRqk9bronV7WiEnh1bcRvMIrB4xFkeoCZU63WVcK2583hlOt9g
	DCgSPdOXP9nEh9nNtm9Zz7jZTI+Q+1//WfCZHt2lNGq0k7Yv/GnKA1M/imfWIfxOhgRatcCVlCnz/
	shy3DGWg==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qxx60-000N13-Lj; Tue, 31 Oct 2023 23:20:24 +0100
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qxx5z-000GcY-Rd; Tue, 31 Oct 2023 23:20:23 +0100
Subject: Re: [PATCH net] veth: Fix RX stats for bpf_redirect_peer() traffic
To: Jakub Kicinski <kuba@kernel.org>
Cc: Peilin Ye <yepeilin.cs@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
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
 <94c88020-5282-c82b-8f88-a2d012444699@iogearbox.net>
 <20231031125348.70fc975e@kernel.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <6d5cb0ef-fabc-7ca3-94b2-5b1925a6805f@iogearbox.net>
Date: Tue, 31 Oct 2023 23:20:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231031125348.70fc975e@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27078/Tue Oct 31 08:41:25 2023)

On 10/31/23 8:53 PM, Jakub Kicinski wrote:
> On Mon, 30 Oct 2023 15:19:26 +0100 Daniel Borkmann wrote:
>>> Since I didn't want to update host-veth's TX counters.  If we
>>> bpf_redirect_peer()ed a packet from NIC TC ingress to Pod-veth TC ingress,
>>> I think it means we've bypassed host-veth TX?
>>
>> Yes. So the idea is to transition to tstats replace the location where
>> we used to bump lstats with tstat's tx counter, and only the peer redirect
>> would bump the rx counter.. then upon stats traversal we fold the latter into
>> the rx stats which was populated by the opposite's tx counters. Makes sense.
>>
>> OT: does cadvisor run inside the Pod to collect the device stats? Just
>> curious how it gathers them.
> 
> Somewhat related - where does netkit count stats?

Yeap, it needs it as well, I have a local branch here where I pushed all
of it - coming out soon; I was planning to add some selftests in addition
till end of this week:

https://github.com/cilium/linux/commits/pr/ndo_peer

>>>> Definitely no new stats ndo resp indirect call in fast path.
>>>
>>> Yeah, I think I'll put a comment saying that all devices that support
>>> BPF_F_PEER must use tstats (or must use lstats), then.
>>
>> sgtm.
> 
> Is comment good enough? Can we try to do something more robust?
> Move the allocation of stats into the core at registration based
> on some u8 assigned in the driver? (I haven't looked at the code TBH)
Hm, not sure. One thing that comes to mind is lazy one-time allocation
like in case of netdev_core_stats_inc(), so whenever one of the helpers
like dev_sw_netstats_{rx,tx}_add() are called and dev->tstats are still
NULL, the core knows about the driver's intent, but tbh that doesn't
feel overly clean and in case of netdev_core_stats_inc() it's more in
the exception case rather than fast-path.

Other option could be to have two small helpers in the core which then
set a flag as well:

static inline int netdev_tstats_alloc(struct net_device *dev)
{
	dev->tstats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
	if (!dev->tstats)
		return -ENOMEM;
	dev->priv_flags |= IFF_USES_TSTATS;
	return 0;
}

static inline void netdev_tstats_free(struct net_device *dev)
{
	free_percpu(dev->tstats);
}

They can then be used from .ndo_init/uninit - not sure if this would
be overall nicer.. or just leaving it at the .ndo callback comment for
the time being until really more users show up (which I doubt tbh).

Thanks,
Daniel

