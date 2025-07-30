Return-Path: <bpf+bounces-64684-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C09E2B15758
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 03:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8CFA3A5741
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 01:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3609B1DED42;
	Wed, 30 Jul 2025 01:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cFW/GKps"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE4E1DE8A8
	for <bpf@vger.kernel.org>; Wed, 30 Jul 2025 01:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753840519; cv=none; b=HeJuJ5fY03+b0sXdOWKc9G4DPN/dZPRol13iCDydi9UhPzA0oM/w+jiMBv2AwBPWkqgbGtpyul8vjXKTBQQvMUVF0qNFnZ8eJQVF1srj6F0v+aMV3WKGLi/qnmBGVKtABNB3SxDUnMn4gr29wJ/9djceRJlt8m+TOc/koU87+fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753840519; c=relaxed/simple;
	bh=revpl56mPq9KLBzHa8CWXLrKv7rkFACf5P5lX0gZwDY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iLtkXjfxlAWXWGhd/KYg3mhgfcNHvQKRpJCSp8dXJZpgL/SXiFpkxI471apk+kQSBtMAlnq4Mj4unj6KjPoQN7ExXeWhmL9HNQ14+4N1gkhMuWkUxfF8wNvoLg5T4Mnjf1B/NqZdp54mDtZ9yl62RLejKy+Vk5CfDVFcEHcdy/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cFW/GKps; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7083544f-5b0c-432e-bec8-509ca733f316@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753840504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bBtDeEQmDVhAbCwRLb1FMhSSfBFoIGvei1/u976ODoM=;
	b=cFW/GKpstUwfA0eP64NEgFb+fMg5cHQC4yPqe+JA0B2ivT3Pu6QPj4QsfAt9pOakE+i3C0
	dU5eMBP8v+uNHZpzL7xCNXAd2QmYo+XXYePnIrEtk7Cugeq/oenIX5pjTFwIxkD99xed1T
	uT3yLlujhn3HJgh+LghAu/0+y8DuyEQ=
Date: Tue, 29 Jul 2025 18:54:58 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 0/4] bpf: add icmp_send_unreach kfunc
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: alexei.starovoitov@gmail.com, andrii@kernel.org, ast@kernel.org,
 bpf@vger.kernel.org, coreteam@netfilter.org, daniel@iogearbox.net,
 fw@strlen.de, john.fastabend@gmail.com, netdev@vger.kernel.org,
 netfilter-devel@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
 pablo@netfilter.org, lkp@intel.com
References: <202507270940.kXGmRbg5-lkp@intel.com>
 <20250728094345.46132-1-mahe.tardy@gmail.com>
 <b36532a2-506b-4ba5-b6a3-a089386a190e@linux.dev> <aIiaB2QUxKmhvPlx@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <aIiaB2QUxKmhvPlx@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/29/25 2:53 AM, Mahe Tardy wrote:
>> Which other program types do you need this kfunc to send icmp and the future
>> tcp rst?
> 
> I don't really know, I mostly need this in cgroup_skb for my use case
> but I could see other programs type using this either for simplification
> (for progs that can already rewrite the packet, like tc) or other
> programs types like cgroup_skb, because they can't touch the packet
> themselves.

I also don't think the tc needs this kfunc either. The tc should already have 
ways to do this now.

> 
>>
>> This cover letter mentioned sending icmp unreach is easier than sending tcp
>> rst. What problems do you see in sending tcp rst?
>>
> 
> Yes, I based these patches on what net/ipv4/netfilter/ipt_REJECT.c's
> 'reject_tg' function does. In the case of sending ICMP unreach
> 'nf_send_unreach', the routing step is quite straighforward as they are
> only inverting the daddr and the saddr (that's what my renamed/moved
> ip_route_reply_fetch_dst helper does).
> 
> In the case of sending RST 'nf_send_reset', there are extra steps, first
> the same routing mechanism is done by just inverting the daddr and the
> saddr but later 'ip_route_me_harder' is called which is doing a lot
> more. I'm currently not sure which parts of this must be ported to work
> in our BPF use case so I wanted to start with unreach.

I don't think we necessarily need to completely borrow from nf, the hooks' 
locations are different and the use case may be different.

A concern that I have is the icmp6_send called by the kfunc. The icmp6_send 
should eventually call to ip6_finish_output which may call the very same 
"cgroup/egress" program again in a recursive way. The same for v4 icmp_send.

The icmp packet is sent from an internal kernel sk. I suspect you will see this 
recursive behavior if the test is done in the default cgroup (/sys/fs/cgroup). I 
think the is_ineligible(skb) should have stopped the second icmpv6_send from 
replying to an icmp error and the cgroup hook cannot change the skb. However, I 
am not sure I want to cross this bridge. Is there a way to avoid the recursive 
bpf prog?



