Return-Path: <bpf+bounces-64680-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2D7B155C4
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 01:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3183718A7E70
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 23:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AFF028152A;
	Tue, 29 Jul 2025 23:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BiEAl4Qm"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE57278E77
	for <bpf@vger.kernel.org>; Tue, 29 Jul 2025 23:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753830806; cv=none; b=QGSXEnqb5liL0CFEEm9BzwI2uGWw50Z1+SUM4JdONkkXXxG1EgtvfBeeqGgnNXhAm6IBCZBjX9/9FEmchVGyDAEdaCxGDJrTJ6eLKL5dRrg/M3xh3BFws9qE2tFWbnQjIYEHz6qZGjW6td8ZHhDHUECMt+GjICZhTwBxEyAnV+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753830806; c=relaxed/simple;
	bh=WxvGFF87EU5ki9LEBULBMG8gjNsmrJZkd22aGwiMvlk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lvi5EwrbUI0+PEoRfhToe+KgrlbjXYHm3V0lJQo7sy7QIk0N8WhiYnJWQfph3YEXnBLlEy9Bw9BdR/1ejiMIBnfl8N1MJv92jO0qTyL0dNDLvS+In0TT3ZjweCbMV1m/SGJ/dL9x05MGCWaYIZr1sLI7uIcNF7VL9Ir5NQr/3X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BiEAl4Qm; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <df4b0996-3e88-4ea4-983b-82866455a6fc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753830792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yjZl9PRQAkl316Uaa6TzM+hjGmhIkh7ZeU0G7I1jd4M=;
	b=BiEAl4Qm3PbuOsjicsutjMzchEM7XKBSfoLzdFyUpBR9uGvso774O5UyFJNIOtd2NwzlTT
	Bcic+Ln0G48LIKHqwWhrCKJ23M07E4r1AmTtIaFcd3/AKrVWpQ99+dyepcr85P1eTuC0WQ
	sUe6tM/IXZbQhTTvtgXsCgAFVqinD6E=
Date: Tue, 29 Jul 2025 16:13:06 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 3/4] bpf: add bpf_icmp_send_unreach cgroup_skb
 kfunc
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: alexei.starovoitov@gmail.com, andrii@kernel.org, ast@kernel.org,
 bpf@vger.kernel.org, coreteam@netfilter.org, daniel@iogearbox.net,
 fw@strlen.de, john.fastabend@gmail.com, netdev@vger.kernel.org,
 netfilter-devel@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
 pablo@netfilter.org, lkp@intel.com
References: <202507270940.kXGmRbg5-lkp@intel.com>
 <20250728094345.46132-1-mahe.tardy@gmail.com>
 <20250728094345.46132-4-mahe.tardy@gmail.com>
 <b3f25e61-7b0c-4576-baae-9b498c3b8748@linux.dev> <aIidIq2EM--Ugp6f@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <aIidIq2EM--Ugp6f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/29/25 3:06 AM, Mahe Tardy wrote:
> On Mon, Jul 28, 2025 at 06:05:26PM -0700, Martin KaFai Lau wrote:
>> On 7/28/25 2:43 AM, Mahe Tardy wrote:
>>> This is needed in the context of Tetragon to provide improved feedback
>>> (in contrast to just dropping packets) to east-west traffic when blocked
>>> by policies using cgroup_skb programs.
>>>
>>> This reuse concepts from netfilter reject target codepath with the
>>> differences that:
>>> * Packets are cloned since the BPF user can still return SK_PASS from
>>>     the cgroup_skb progs and the current skb need to stay untouched
>>
>> This needs more details. Which field(s) of the skb are changed by the kfunc,
>> the skb_dst_set in ip[6]_route_reply_fetch_dst() and/or the code path in the
>> icmp[v6]_send() ?
> 
> Okay I can add that: "ip[6]_route_reply_fetch_dst set the dst of the skb
> by using the saddr as a daddr and routing it", I don't think
> icmp[v6]_send touches the skb?

I also don't think icmp[v6]_send touches the skb. I am still not sure if 
ip[6]_route_reply_fetch_dst is needed.

> 
>>
>>>     (cgroup_skb hooks only allow read-only skb payload).
>>> * Since cgroup_skb programs are called late in the stack, checksums do
>>>     not need to be computed or verified, and IPv4 fragmentation does not
>>>     need to be checked (ip_local_deliver should take care of that
>>>     earlier).
>>>
>>> Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
>>> ---
>>>    net/core/filter.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++
>>>    1 file changed, 61 insertions(+)
>>>
>>> diff --git a/net/core/filter.c b/net/core/filter.c
>>> index 7a72f766aacf..050872324575 100644
>>> --- a/net/core/filter.c
>>> +++ b/net/core/filter.c
>>> @@ -85,6 +85,10 @@
>>>    #include <linux/un.h>
>>>    #include <net/xdp_sock_drv.h>
>>>    #include <net/inet_dscp.h>
>>> +#include <linux/icmp.h>
>>> +#include <net/icmp.h>
>>> +#include <net/route.h>
>>> +#include <net/ip6_route.h>
>>>
>>>    #include "dev.h"
>>>
>>> @@ -12148,6 +12152,53 @@ __bpf_kfunc int bpf_sock_ops_enable_tx_tstamp(struct bpf_sock_ops_kern *skops,
>>>    	return 0;
>>>    }
>>>
>>> +__bpf_kfunc int bpf_icmp_send_unreach(struct __sk_buff *__skb, int code)
>>> +{
>>> +	struct sk_buff *skb = (struct sk_buff *)__skb;
>>> +	struct sk_buff *nskb;
>>> +
>>> +	switch (skb->protocol) {
>>> +	case htons(ETH_P_IP):
>>> +		if (code < 0 || code > NR_ICMP_UNREACH)
>>> +			return -EINVAL;
>>> +
>>> +		nskb = skb_clone(skb, GFP_ATOMIC);
>>> +		if (!nskb)
>>> +			return -ENOMEM;
>>> +
>>> +		if (ip_route_reply_fetch_dst(nskb) < 0) {
>>> +			kfree_skb(nskb);
>>> +			return -EHOSTUNREACH;
>>> +		}
>>> +
>>> +		icmp_send(nskb, ICMP_DEST_UNREACH, code, 0);
>>> +		kfree_skb(nskb);
>>> +		break;
>>> +#if IS_ENABLED(CONFIG_IPV6)
>>> +	case htons(ETH_P_IPV6):
>>> +		if (code < 0 || code > ICMPV6_REJECT_ROUTE)
>>> +			return -EINVAL;
>>> +
>>> +		nskb = skb_clone(skb, GFP_ATOMIC);
>>> +		if (!nskb)
>>> +			return -ENOMEM;
>>> +
>>> +		if (ip6_route_reply_fetch_dst(nskb) < 0) {
>>
>>  From a very quick look at icmpv6_send(), it does its own route lookup. I
>> haven't looked at the v4 yet.
>>
>> I am likely missing some details. Can you explain why it needs to do a
>> lookup before calling icmpv6_send()?
> 
>  From my understanding, I need to do this to invert the daddr with the
> saddr to send the unreach message back to the sender.

 From looking at how fl6.{daddr,saddr} are filled and passed to 
icmpv6_route_lookup in icmpv6_send(), the icmpv6_send() should have done the 
reverse/invert route lookup. I also don't see icmpv6_send uses the skb_dst() of 
the original skb. Did I misread the code? The kfunc does not work without 
ip[6]_route_reply_fetch_dst()? Again, I have not checked the v4 icmp_send. fwiw, 
the selftest should have both v4 and v6 test.

Note that at cgroup/egress, the skb->_skb_refdst should have been set.

The same should be true for cgroup/ingress for inet proto but it seems 
BPF_CGROUP_RUN_PROG_"INET"_INGRESS is not called from INET only now. e.g. 
sk_filter() can be called from af_netlink. It seems like there is a bug.

> 
>>
>>> +			kfree_skb(nskb);
>>> +			return -EHOSTUNREACH;
>>> +		}
>>> +
>>> +		icmpv6_send(nskb, ICMPV6_DEST_UNREACH, code, 0);
>>> +		kfree_skb(nskb);
>>> +		break;
>>> +#endif
>>> +	default:
>>> +		return -EPROTONOSUPPORT;
>>> +	}
>>> +
>>> +	return SK_DROP;
>>> +}
>>> +
> 


