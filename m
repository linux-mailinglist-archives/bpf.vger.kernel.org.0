Return-Path: <bpf+bounces-16253-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8D77FED69
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 11:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FBA51C20E1E
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 10:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D56E3C06B;
	Thu, 30 Nov 2023 10:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="SpNsCB7z"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EDA510D1;
	Thu, 30 Nov 2023 02:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=mc1OLpee3TWcqUe5AdRmVwPMQcYF7vxiCpediutrrUY=; b=SpNsCB7z0+7EO8aKboPMHjpTQU
	PXgj3eo95QbN0OLDseUhZdxx44PVLDrlobFy++Achn9m5E24RjwE56fgKA1OhAvJuXGEvCKKe49PI
	b6WLX6TNfayJAK54fhQEJ08Bjkkmal/R0wJ3cobHS5Yowxf079VoQMeg8e1028vWOYmLaVuo9JpuN
	mjN48PUjDcmJDK9UWJ3B7o7bNl+u3SccMd3MWzQNoS9i5IH0eOqdPcUMmGyLoKujnbc3fQGTQQ8LA
	RT8QgmUahb91whlkHdQNTHXc8UFEl6yqxH9bvk/jAoC4LF98X0mUw4TP5qG9wG4929MeUMh9yw7+9
	1KxJzXwQ==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1r8ej4-000JxI-LG; Thu, 30 Nov 2023 11:56:58 +0100
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1r8ej4-0005mZ-1V; Thu, 30 Nov 2023 11:56:58 +0100
Subject: Re: [External] Re: [PATCH bpf-next] netkit: Add some ethtool ops to
 provide information to user
To: Feng Zhou <zhoufeng.zf@bytedance.com>,
 Nikolay Aleksandrov <razor@blackwall.org>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, yangzhenze@bytedance.com,
 wangdongdong.6@bytedance.com, tangchen.1@bytedance.com
References: <20231130075844.52932-1-zhoufeng.zf@bytedance.com>
 <51dd35c9-ff5b-5b11-04d1-9a5ae9466780@blackwall.org>
 <16b4d42d-2d62-460e-912f-6e3b86f3004d@bytedance.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <94e335d4-ec90-ba78-b2b4-8419b25bfa88@iogearbox.net>
Date: Thu, 30 Nov 2023 11:56:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <16b4d42d-2d62-460e-912f-6e3b86f3004d@bytedance.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27109/Thu Nov 30 09:44:04 2023)

On 11/30/23 10:24 AM, Feng Zhou wrote:
> 在 2023/11/30 17:06, Nikolay Aleksandrov 写道:
>> On 11/30/23 09:58, Feng zhou wrote:
>>> From: Feng Zhou <zhoufeng.zf@bytedance.com>
>>>
>>> Add get_strings, get_sset_count, get_ethtool_stats to get peer
>>> ifindex.
>>> ethtool -S nk1
>>> NIC statistics:
>>>       peer_ifindex: 36
>>>
>>> Add get_link, get_link_ksettings to get link stat.
>>> ethtool nk1
>>> Settings for nk1:
>>>     ...
>>>     Link detected: yes
>>>
>>> Add get_ts_info.
>>> ethtool -T nk1
>>> Time stamping parameters for nk1:
>>> ...
>>>
>>> Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
>>> ---
>>>   drivers/net/netkit.c | 53 ++++++++++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 53 insertions(+)
>>>
>>
>> Hi,
>> I don't see any point in sending peer_ifindex through ethtool, even
>> worse through ethtool stats. That is definitely the wrong place for it.
>> You can already retrieve that through netlink. About the speed/duplex
>> this one makes more sense, but this is the wrong way to do it.
>> See how we did it for virtio_net (you are free to set speed/duplex
>> to anything to please bonding for example). Although I doubt anyone will use netkit with bonding, so even that is questionable. :)
>>
>> Nacked-by: Nikolay Aleksandrov <razor@blackwall.org>
> 
> We use netkit to replace veth to improve performance, veth can be used ethtool -S veth to get peer_ifindex, so this part is added, as long as it is to keep the netkit part and veth unified, to ensure the same usage habits, and to replace it without perception.

Could you elaborate some more on the use case why you need to retrieve it
via ethtool, what alternatives were tried and don't work?

Please also elaborate on the case for netkit_get_link_ksettings() and which
concrete problem you are trying to address with this extension?

The commit message only explains what is done but does not go into the detail
of _why_ you need it.

Thanks,
Daniel

