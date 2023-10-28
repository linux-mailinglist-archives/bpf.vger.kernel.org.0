Return-Path: <bpf+bounces-13541-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B267DA569
	for <lists+bpf@lfdr.de>; Sat, 28 Oct 2023 09:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 610B12826F6
	for <lists+bpf@lfdr.de>; Sat, 28 Oct 2023 07:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED3F443D;
	Sat, 28 Oct 2023 07:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="DANICsOC"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFC410F5;
	Sat, 28 Oct 2023 07:07:06 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B03CA;
	Sat, 28 Oct 2023 00:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=9jZ6IeTzqgI7KPSimrweLY9VVvaA0yg3+mceyW4nrIA=; b=DANICsOCgGLFEj0wCWjFrMwVPC
	A5sg8Wg4RC6lswHA3/IGYWB7zI1WOhb7pOQinUO694iLQDudsxbuqYhX80XSEXeUCHyVB6GD22rJS
	03R4JRIW2YJYzpDfpUrPPq/gGw0Ev0hrjbnFJKdMptLmefTwg1VIroVy1GHZ9CKIICO9/9yDEAgVI
	huLWlB08TWWm4Dt7I9QHaSKHWHlGBagEXQyaoUzD36rYXYOFzBiXg/ylDHrlvaCOf3xaPFcNOzopQ
	ZwQVq06qnun9klrwFB8oT9gWhZF0xSbvD+3a/MVycKZfylQUslgCUbxN59to6BlY9qSePwmVFjte6
	yaOr1PiA==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qwdPB-0000Xk-Rh; Sat, 28 Oct 2023 09:06:45 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qwdPB-000Qwf-0W; Sat, 28 Oct 2023 09:06:45 +0200
Subject: Re: [PATCH net] veth: Fix RX stats for bpf_redirect_peer() traffic
To: Peilin Ye <yepeilin.cs@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Peilin Ye <peilin.ye@bytedance.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 Cong Wang <cong.wang@bytedance.com>, Jiang Wang <jiang.wang@bytedance.com>,
 Youlun Zhang <zhangyoulun@bytedance.com>
References: <20231027184657.83978-1-yepeilin.cs@gmail.com>
 <20231027190254.GA88444@n191-129-154.byted.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <59be18ff-dabc-2a07-3d78-039461b0f3f7@iogearbox.net>
Date: Sat, 28 Oct 2023 09:06:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231027190254.GA88444@n191-129-154.byted.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27074/Fri Oct 27 09:58:36 2023)

Hi Peilin,

On 10/27/23 9:02 PM, Peilin Ye wrote:
> On Fri, Oct 27, 2023 at 06:46:57PM +0000, Peilin Ye wrote:
>> diff --git a/net/core/filter.c b/net/core/filter.c
>> index 21d75108c2e9..7aca28b7d0fd 100644
>> --- a/net/core/filter.c
>> +++ b/net/core/filter.c
>> @@ -2492,6 +2492,7 @@ int skb_do_redirect(struct sk_buff *skb)
>>   			     net_eq(net, dev_net(dev))))
>>   			goto out_drop;
>>   		skb->dev = dev;
>> +		dev_sw_netstats_rx_add(dev, skb->len);
> 
> This assumes that all devices that support BPF_F_PEER (currently only
> veth) use tstats (instead of lstats, or dstats) - is that okay?

Dumb question, but why all this change and not simply just call ...

   dev_lstats_add(dev, skb->len)

... on the host dev ?

> If not, should I add another NDO e.g. ->ndo_stats_rx_add()?

Definitely no new stats ndo resp indirect call in fast path.

Thanks,
Daniel

