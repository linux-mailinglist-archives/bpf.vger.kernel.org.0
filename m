Return-Path: <bpf+bounces-16870-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2D8806CD1
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 11:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C56FDB2101B
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 10:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED0330645;
	Wed,  6 Dec 2023 10:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="jNp6Fmd7"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513FDA4;
	Wed,  6 Dec 2023 02:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=AiRXDpNXIfs5EZ5Lp3a9zJWQNeoM5F+3ORGaNxIHk1Q=; b=jNp6Fmd7/DrxioOrhec5GompK9
	91DPtXLB5PUnoPftHmhZr3HO6bortfBNuENewCaetPhtQUxhpGBTgKX7O7tnflBPNwUjl3qyEdzZH
	EVaEMX8mHEkmCSwPqCUjO8BiMoYlIyYqHtb9F9zgsIm2j/cjZCe4jJ5dwwRHbN9/jzbO1ddu2L3nY
	EJye0oWg+BOtgudG/id+gEMwWMplBcfXbSV/3ukLpjlDUySLg7QVng55TMBq6Uj8TuMb32vwnkbeC
	tAVvIhC+ARr3/kvZszBj6e4YyJ4F8xNCmX9V83mS73mLpG8B7fB6P2f1oTe7fmkWWx7vT+y7B8s9G
	2z2XSmkg==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rApab-000Coo-F7; Wed, 06 Dec 2023 11:57:13 +0100
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1rApaa-0002zw-QJ; Wed, 06 Dec 2023 11:57:12 +0100
Subject: Re: [PATCH bpf-next] netkit: Add some ethtool ops to provide
 information to user
To: Feng Zhou <zhoufeng.zf@bytedance.com>,
 Nikolay Aleksandrov <razor@blackwall.org>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, yangzhenze@bytedance.com,
 wangdongdong.6@bytedance.com, tangchen.1@bytedance.com
References: <20231130075844.52932-1-zhoufeng.zf@bytedance.com>
 <51dd35c9-ff5b-5b11-04d1-9a5ae9466780@blackwall.org>
 <16b4d42d-2d62-460e-912f-6e3b86f3004d@bytedance.com>
 <94e335d4-ec90-ba78-b2b4-8419b25bfa88@iogearbox.net>
 <57587b74-f865-4b56-8d65-a5cbc6826079@bytedance.com>
 <2a829a9c-69a6-695d-d3df-59190b161787@iogearbox.net>
 <b7053425-65eb-46a0-abd9-59ade5e78211@bytedance.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <d75ffdd9-203a-94a3-57c1-69b1561d808e@iogearbox.net>
Date: Wed, 6 Dec 2023 11:57:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <b7053425-65eb-46a0-abd9-59ade5e78211@bytedance.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27115/Wed Dec  6 09:44:21 2023)

On 12/6/23 7:59 AM, Feng Zhou wrote:
> 在 2023/12/4 23:22, Daniel Borkmann 写道:
>> Thanks, so the netkit_get_link_ksettings is optional. 
> 
> Yes, netkit_get_link_ksettings really not necessary, I just added it in line with veth.
> 
> I don't quite
>> follow what you
>> mean with regards to your business logic in veth to obtain peer ifindex. What does
>> the script do exactly with the peer ifindex (aka /why/ is it needed), could you
>> elaborate some more - it's still somewhat too vague? 🙂 E.g. why it does not suffice
>> to look at the device type or other kind of attributes?
> 
> The scripting logic of the business colleagues should just be simple logging records, using ethtool. Then they saw that netkit has this missing, so raised this requirement, so I sent this patch, wanting to hear your opinions. If you don't think it's necessary, let the business colleagues modify it.

So it is basically only logging the peer_ifindex data from ethtool but nothing
more is done with it? Meaning, this was raised as a requirement because this was
missing from the logging data, or was there anything more to it?

The peer ifindex is already available via IFLA_LINK (which does dev_get_iflink()
internally to fetch the peer's ifindex). This is also what you see in iproute2:

# ip l
[...]
163: nk0@nk1: <BROADCAST,MULTICAST,NOARP,M-DOWN> mtu 1500 qdisc noop state DOWN group default qlen 1000
     link/ether 00:00:00:00:00:00 brd ff:ff:ff:ff:ff:ff
164: nk1@nk0: <BROADCAST,MULTICAST,NOARP,M-DOWN> mtu 1500 qdisc noop state DOWN group default qlen 1000
     link/ether 00:00:00:00:00:00 brd ff:ff:ff:ff:ff:ff
[...]
# ip netns add blue
# ip link set nk1 netns blue
# ip l
[...]
163: nk0@if164: <BROADCAST,MULTICAST,NOARP> mtu 1500 qdisc noop state DOWN group default qlen 1000
     link/ether 00:00:00:00:00:00 brd ff:ff:ff:ff:ff:ff link-netns blue
[...]

The `if164` denotes the peer's ifindex and `link-netns blue` provides info on the netns of the peer.
This is much better and more generic than the ethtool hack. I would suggest changing the logic to
rather look at data populated by rtnl_fill_link_netnsid() instead.

Thanks,
Daniel

