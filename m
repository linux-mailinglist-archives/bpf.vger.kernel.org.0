Return-Path: <bpf+bounces-27986-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 624D38B4103
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 23:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90B591C21A2D
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 21:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496872CCA3;
	Fri, 26 Apr 2024 21:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="g8p/odsG"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3275221101;
	Fri, 26 Apr 2024 21:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714165703; cv=none; b=b+YvAE3pruydzp3Zawezf/N/M/aCELvnboxJzU/ValoZ2kWEgQ02AKY+pvNCLAO4rS9lO7obWGEK6k0QumA0tmXeNUp2PMDe6AgOqvi98A4/smY2I5JdpZxTxZTA3M0DUIpASuKIPCJum1EX3iRovyAElsl5Jci3PlpKQt29PQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714165703; c=relaxed/simple;
	bh=lW/l8KKGYNmqkUhIpCA4l+1y/1J7i0LRaZxS7i9FoSU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=qLdbe1Zvrub6/Z9E5UVE30QIxy09vOTDPqmDTZe4ue3gkSZDoSncMwZ9tcClATOXkAfpJkbaiVsr8R0FNh6XLhVeJYWOoQLxpW1LfUtV4gu0dXOEa2NfhQfwfA/9S4FHzUGpl/X5w9wozqYTUYe6qWa9hJCE2zuw9K9JMM2ngcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=g8p/odsG; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=XU9L50gMutWaXiQoUCnKhAbOZc/erS00yVvgujisH+s=; b=g8p/odsGvImQC9g77//tEJhzbn
	8neUm1aG0rRZ0Vk/6hl3/j64WgZ1Y9mBrX0Rb1ECxdv96LttbNwy4oTjcX8XsvUpEKo9aCyi5/h8W
	mpJMQB8EnYR1BxpGgT2vWdNhNec7U9T2CWeX1NB1EaWPlE7tzzhtb6uxhnafzSFb8F4lVVU4GJCAk
	g5QF/KSwWEYgozMN0A5e/INgn3c3IZVtd/9Le+FI1zxlgc7xqu0dJuCPngUQ3+o2H+gMDRoEFXbo/
	3iskDU6xOhB8XRX3nEMqbNaCs2+A4VwAWon87FL5NcLRTMMWSEX/8hmgwifUd6K+qT2BHiyKIri71
	BoDzf5wQ==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1s0Snl-000K9y-Bo; Fri, 26 Apr 2024 23:08:13 +0200
Received: from [178.197.249.19] (helo=linux.home)
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1s0Snk-000A6x-0v;
	Fri, 26 Apr 2024 23:08:12 +0200
Subject: Re: [PATCH net] udp: fix segmentation crash for GRO packet without
 fraglist
To: =?UTF-8?B?TGVuYSBXYW5nICjnjovlqJwp?= <Lena.Wang@mediatek.com>,
 "maze@google.com" <maze@google.com>,
 "willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "steffen.klassert@secunet.com" <steffen.klassert@secunet.com>,
 "kuba@kernel.org" <kuba@kernel.org>,
 =?UTF-8?B?U2hpbWluZyBDaGVuZyAo5oiQ6K+X5piOKQ==?=
 <Shiming.Cheng@mediatek.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "edumazet@google.com" <edumazet@google.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "yan@cloudflare.com" <yan@cloudflare.com>
References: <20240415150103.23316-1-shiming.cheng@mediatek.com>
 <77068ef60212e71b270281b2ccd86c8c28ee6be3.camel@mediatek.com>
 <662027965bdb1_c8647294b3@willemb.c.googlers.com.notmuch>
 <11395231f8be21718f89981ffe3703da3f829742.camel@mediatek.com>
 <CANP3RGdh24xyH2V7Sa2fs9Ca=tiZNBdKu1qQ8LFHS3sY41CxmA@mail.gmail.com>
 <b24bc70ae2c50dc50089c45afbed34904f3ee189.camel@mediatek.com>
 <66227ce6c1898_116a9b294be@willemb.c.googlers.com.notmuch>
 <CANP3RGfxeKDUmGwSsZrAs88Fmzk50XxN+-MtaJZTp641aOhotA@mail.gmail.com>
 <6622acdd22168_122c5b2945@willemb.c.googlers.com.notmuch>
 <9f097bcafc5bacead23c769df4c3f63a80dcbad5.camel@mediatek.com>
 <6627ff5432c3a_1759e929467@willemb.c.googlers.com.notmuch>
 <274c7e9837e5bbe468d19aba7718cc1cf0f9a6eb.camel@mediatek.com>
 <66291716bcaed_1a760729446@willemb.c.googlers.com.notmuch>
 <c28a5c635f38a47f1be266c4328e5fbba44ff084.camel@mediatek.com>
 <662a63aeee385_1de39b294fd@willemb.c.googlers.com.notmuch>
 <752468b66d2f5766ea16381a0c5d7b82ab77c5c4.camel@mediatek.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <ae0ba22a-049a-49c1-d791-d0e953625904@iogearbox.net>
Date: Fri, 26 Apr 2024 23:08:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <752468b66d2f5766ea16381a0c5d7b82ab77c5c4.camel@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27257/Fri Apr 26 10:25:03 2024)

On 4/26/24 11:52 AM, Lena Wang (王娜) wrote:
[...]
>>>  From 301da5c9d65652bac6091d4cd64b751b3338f8bb Mon Sep 17 00:00:00
>> 2001
>>> From: Shiming Cheng <shiming.cheng@mediatek.com>
>>> Date: Wed, 24 Apr 2024 13:42:35 +0800
>>> Subject: [PATCH net] net: prevent BPF pulling SKB_GSO_FRAGLIST skb
>>>
>>> A SKB_GSO_FRAGLIST skb can't be pulled data
>>> from its fraglist as it may result an invalid
>>> segmentation or kernel exception.
>>>
>>> For such structured skb we limit the BPF pulling
>>> data length smaller than skb_headlen() and return
>>> error if exceeding.
>>>
>>> Fixes: 3a1296a38d0c ("net: Support GRO/GSO fraglist chaining.")
>>> Signed-off-by: Shiming Cheng <shiming.cheng@mediatek.com>
>>> Signed-off-by: Lena Wang <lena.wang@mediatek.com>
>>> ---
>>>   net/core/filter.c | 5 +++++
>>>   1 file changed, 5 insertions(+)
>>>
>>> diff --git a/net/core/filter.c b/net/core/filter.c
>>> index 8adf95765cdd..8ed4d5d87167 100644
>>> --- a/net/core/filter.c
>>> +++ b/net/core/filter.c
>>> @@ -1662,6 +1662,11 @@ static DEFINE_PER_CPU(struct bpf_scratchpad,
>>> bpf_sp);
>>>   static inline int __bpf_try_make_writable(struct sk_buff *skb,
>>>     unsigned int write_len)
>>>   {
>>> +if (skb_is_gso(skb) &&
>>> +    (skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST) &&
>>> +     write_len > skb_headlen(skb)) {
>>> +return -ENOMEM;
>>> +}
>>>   return skb_ensure_writable(skb, write_len);

Dumb question, but should this guard be more generically part of skb_ensure_writable()
internals, presumably that would be inside pskb_may_pull_reason(), or only if we ever
see more code instances similar to this?

Thanks,
Daniel

