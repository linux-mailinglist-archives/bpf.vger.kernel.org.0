Return-Path: <bpf+bounces-16877-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F7D807003
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 13:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F12FE281BF3
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 12:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E2836AFF;
	Wed,  6 Dec 2023 12:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IXZKc3TC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F5536B03;
	Wed,  6 Dec 2023 12:41:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 799C4C433C7;
	Wed,  6 Dec 2023 12:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701866515;
	bh=eBOOC6krlP+hwCu843ZBKuiZDnhcHwwF7steokZIiOE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IXZKc3TCBOVUeEfq1pemp51TtIlKtKLdFz865ZjYKS48t4GyyAF4H1F9I/tAf4iig
	 J5kvi3etslX0n+lL9CDEZKKIUbNvDLuEEY9S++jh3KBwKy7ua7rGzXsxgA/a4ivI0I
	 gJjCNOeFx5S5YiCszvP9FD3W1EsQ6D5NJZSP5TI9FHSHGEQf8yrofu2X+mINQ/Z/7S
	 aUXcZygTtYH+O7aYL7cEs1gU+zKvNQg0j3uwC1MjgzVw98yKpM42fd8yYjcgA++eZa
	 kHmIRLvecXB/riiSdYy6KoZcj9c1g3o7e+36/iBhaEQNS9+5OAYNK1gPb3r32Q7qP7
	 uU8hGqpDf/xIg==
Message-ID: <4b9804e2-42f0-4aed-b191-2abe24390e37@kernel.org>
Date: Wed, 6 Dec 2023 13:41:49 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 2/2] xdp: add multi-buff support for xdp
 running in generic mode
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: aleksander.lobakin@intel.com, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 lorenzo.bianconi@redhat.com, bpf@vger.kernel.org, toke@redhat.com,
 willemdebruijn.kernel@gmail.com, jasowang@redhat.com, sdf@google.com
References: <cover.1701437961.git.lorenzo@kernel.org>
 <c9ee1db92c8baa7806f8949186b43ffc13fa01ca.1701437962.git.lorenzo@kernel.org>
 <20231201194829.428a96da@kernel.org> <ZW3zvEbI6o4ydM_N@lore-desk>
 <20231204120153.0d51729a@kernel.org> <ZW-tX9EAnbw9a2lF@lore-desk>
 <20231205155849.49af176c@kernel.org>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20231205155849.49af176c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/6/23 00:58, Jakub Kicinski wrote:
> On Wed, 6 Dec 2023 00:08:15 +0100 Lorenzo Bianconi wrote:
>> v00 (NS:ns0 - 192.168.0.1/24) <---> (NS:ns1 - 192.168.0.2/24) v01 ==(XDP_REDIRECT)==> v10 (NS:ns1 - 192.168.1.1/24) <---> (NS:ns2 - 192.168.1.2/24) v11
>>
>> - v00: iperf3 client (pinned on core 0)
>> - v11: iperf3 server (pinned on core 7)
>>
>> net-next veth codebase (page_pool APIs):
>> =======================================
>> - MTU  1500: ~ 5.42 Gbps
>> - MTU  8000: ~ 14.1 Gbps
>> - MTU 64000: ~ 18.4 Gbps
>>
>> net-next veth codebase + page_frag_cahe APIs [0]:
>> =================================================
>> - MTU  1500: ~ 6.62 Gbps
>> - MTU  8000: ~ 14.7 Gbps
>> - MTU 64000: ~ 19.7 Gbps
>>
>> xdp_generic codebase + page_frag_cahe APIs (current proposed patch):
>> ====================================================================
>> - MTU  1500: ~ 6.41 Gbps
>> - MTU  8000: ~ 14.2 Gbps
>> - MTU 64000: ~ 19.8 Gbps
>>
>> xdp_generic codebase + page_frag_cahe APIs [1]:
>> ===============================================
> 
> This one should say page pool?
> 
>> - MTU  1500: ~ 5.75 Gbps
>> - MTU  8000: ~ 15.3 Gbps
>> - MTU 64000: ~ 21.2 Gbps
>>
>> It seems page_pool APIs are working better for xdp_generic codebase
>> (except MTU 1500 case) while page_frag_cache APIs are better for
>> veth driver. What do you think? Am I missing something?
> 
> IDK the details of veth XDP very well but IIUC they are pretty much
> the same. Are there any clues in perf -C 0 / 7?
> 
>> [0] Here I have just used napi_alloc_frag() instead of
>> page_pool_dev_alloc_va()/page_pool_dev_alloc() in
>> veth_convert_skb_to_xdp_buff()
>>
>> [1] I developed this PoC to use page_pool APIs for xdp_generic code:
> 
> Why not put the page pool in softnet_data?

First I thought cool that Jakub is suggesting softnet_data, which will
make page_pool (PP) even more central as the netstacks memory layer.

BUT then I realized that PP have a weakness, which is the return/free
path that need to take a normal spin_lock, as that can be called from
any CPU (unlike the RX/alloc case).  Thus, I fear that making multiple
devices share a page_pool via softnet_data, increase the chance of lock
contention when packets are "freed" returned/recycled.

--Jesper

p.s. PP have the page_pool_put_page_bulk() API, but only XDP 
(NIC-drivers) leverage this.

