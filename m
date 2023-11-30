Return-Path: <bpf+bounces-16332-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 333FB7FFE38
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 23:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C83B6B21189
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 22:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506266167C;
	Thu, 30 Nov 2023 22:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jfZFb4Rg"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9AB2171B
	for <bpf@vger.kernel.org>; Thu, 30 Nov 2023 14:00:58 -0800 (PST)
Message-ID: <e23e6332-7c09-42b8-83a0-1a8029132ccc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701381656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xjU8Mjr2mhBH7uq+8/pzRg8GPwJ2oaoRJytnOd6B9Co=;
	b=jfZFb4RgRN0nxVmRsCK+puCzw5xLvUcdP/5YlayMZHTkTixhxt+RmauDjztHOAIEZfDv1q
	DE6jzWUQv8utoxqyLvoHMziQmcSz9rQvLovziqIEmUXxuNU6grDtgZHXB8qNVcHO9hAWEv
	PfFzsbu7a4Xi2RyR1+n83JRVA2O71jI=
Date: Thu, 30 Nov 2023 14:00:48 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Does skb_metadata_differs really need to stop GRO aggregation?
Content-Language: en-US
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Yan Zhai <yan@cloudflare.com>, Stanislav Fomichev <sdf@google.com>,
 Netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, kernel-team
 <kernel-team@cloudflare.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>,
 Jakub Sitnicki <jakub@cloudflare.com>, Daniel Borkmann
 <daniel@iogearbox.net>, =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
 <toke@redhat.com>, Edward Cree <ecree.xilinx@gmail.com>
References: <92a355bd-7105-4a17-9543-ba2d8ae36a37@kernel.org>
 <21d05784-3cd7-4050-b66f-bad3eab73f4e@kernel.org>
 <7f48dc04-080d-f7e1-5e01-598a1ace2d37@iogearbox.net> <87fs0qj61x.fsf@toke.dk>
 <0b0c6538-92a5-3041-bc48-d7286f1b873b@gmail.com> <87plzsi5wj.fsf@toke.dk>
 <1ff5c528-79a8-fbb7-8083-668ca5086ecf@iogearbox.net> <871qc72vmh.fsf@toke.dk>
 <8677db3e-5662-7ebe-5af0-e5a3ca60587f@iogearbox.net>
 <e3402045-a36f-461f-8eab-bbc51735492d@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <e3402045-a36f-461f-8eab-bbc51735492d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 11/30/23 12:35 PM, Jesper Dangaard Brouer wrote:
> I should explain our use-case(s) a bit more.
> We do want the information to survive XDP_PASS into the SKB.
> Its the hole point, as we want to transfer information from XDP layer to
> TC-layer and perhaps further all the way to BPF socket filters (I even
> heard someone asked for).
> 
> I'm trying to get an overview, as I now have multiple product teams that
> want to store information across/into differ layer, and they have other
> teams that consume this information.
> 
> We are exploring more options than only XDP metadata area to store
> information.  I have suggested that once an SKB have a socket
> associated, then we can switch into using BPF local socket storage
> tricks. (The lifetime of XDP metadata is not 100% clear as e.g.
> pskb_expand_head clears it via skb_metadata_clear).
> All ideas are welcome, e.g. I'm also looking at ability to store
> auxiliary/metadata data associated with a dst_entry. And SKB->mark is
> already used for other use-cases and isn't big enough. (and then there
> is fun crossing a netns boundry).
> 
> Let me explain *one* of the concrete use-cases.  As described in [1],
> the CF XDP L4 load-balancer Unimog have been extended to a product
> called Plurimog that does load-balancing across data-centers "colo's".
> When Plurimog redirects to another colo, the original "landing" colo's
> ID is carried across (in some encap header) to a Unimog instance.  Thus,
> the original landing Colo ID is known to Unimog running in another colo,
> but that header is popped, so this info need to be transferred somehow.
> I'm told that even the webserver/Nginx need to know the orig/foreign
> landing colo ID (here there should be socket associated). For TCP SYN
> packets, the layered DOS protecting also need to know foreign landing
> colo ID. Other teams/products needs this for accounting, e.g. Traffic
> Manager[1], Radar[2] and Capacity planning.

We also bumped into a usecase about plumbing the RX timestamp taken at XDP to 
its final "sk" for analysis purpose. The usecase had not materialized.

fwiw, one of my thoughts at that time is similar to your sk local storage 
thinking, do a bpf_sk_lookup_tcp at xdp and store the stats there. It will waste 
the lookup effort because there is no skb to do the bpf_sk_assign(). Then follow 
this direction of thought is to allocate a skb in the xdp prog itself if we know 
it is a XDP_PASS.

That said, the sk storage approach would work fine if whatever it wants to 
collect from xdp_md(s)/skb(s) can be stacked/aggregated in a sk. It would be 
nicer if the __sk_buff->data_meta can work more like other bpf local storage 
(sk, task, cgroup...etc) such that it will be available to other bpf prog type 
(e.g. a tracing prog).

