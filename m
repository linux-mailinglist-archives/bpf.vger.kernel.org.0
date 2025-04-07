Return-Path: <bpf+bounces-55427-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E17A7F055
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 00:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 252B018945E6
	for <lists+bpf@lfdr.de>; Mon,  7 Apr 2025 22:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51834224890;
	Mon,  7 Apr 2025 22:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZjQcfVvQ"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B08189B84
	for <bpf@vger.kernel.org>; Mon,  7 Apr 2025 22:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744065025; cv=none; b=GWUpF6jl9qDZy1nXKq/M6Vs4MZLCsB7ZDYxJCFWZ2kB/hEp7vZBCKAFHTcsm7qnffQo4Lf4AReroka4x5SMZCoPidLj/hPjYirrS8KdDB0ePb1NnEtNLonTMSyialR55ZJyisB6I5T9QuEWrkjb3SWEWTDw+n5mXJdYuWgxvyTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744065025; c=relaxed/simple;
	bh=VT5e2QPJpXKPCyt+xyHhkKuDO/O11DKdFu/Gm0y60i8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VOkROtF1odcS/FBknBQvzGbJ4fzlYQIGCQxlzQHgXt50ZefyxsJTz7fSHQA1EMpk03Uk9z4I/MpH0CFFBqXFBM7g98uUZWcNp7mnImuKby40ZnGbgzUOqDVck51mdEoA2BLIwsGx82gR1RyFmw8vsUDeen1V/jWPW8tAxCOMjf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZjQcfVvQ; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b9a75b48-9572-482c-9f8d-0dfae41f09a1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744065011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1yvXU5VmWeqiR0pVuAEpxZIKJoqNCtLLKDriulf8zQ8=;
	b=ZjQcfVvQKYGxrfUAMfNwzHXmYQ6RCmx/NFE+B7cq67P0q/LGw1Wd8xTkUCSxKUYRpTxXld
	85utElGLAoEcSGxmFLZ1ieGEePJNEHqKAfSTNh3FYwpreN0e4DHa6JydwRlPbq98rI5xFt
	/nr+38u12DjTy7RGq1sjZElYGI1yGaA=
Date: Mon, 7 Apr 2025 15:30:06 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 3/3] [RFC] Bluetooth: enable bpf TX timestamping
To: Pauli Virtanen <pav@iki.fi>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 kerneljasonxing@gmail.com
References: <cover.1743337403.git.pav@iki.fi>
 <bbd7fa454ed03ebba9bfe79590fb78a75d4f07db.1743337403.git.pav@iki.fi>
 <3546b79d-a09b-4971-abd7-ce18696a9536@linux.dev>
 <db7f317539cbda89df7e87efaea9b22328af610a.camel@iki.fi>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <db7f317539cbda89df7e87efaea9b22328af610a.camel@iki.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/2/25 9:56 AM, Pauli Virtanen wrote:
> Hi,
> 
> ti, 2025-04-01 kello 18:34 -0700, Martin KaFai Lau kirjoitti:
>> On 3/30/25 5:23 AM, Pauli Virtanen wrote:
>>> Emit timestamps also for BPF timestamping.
>>>
>>> ***
>>>
>>> The tskey management here is not quite right: see cover letter.
>>> ---
>>>    include/net/bluetooth/bluetooth.h |  1 +
>>>    net/bluetooth/hci_conn.c          | 21 +++++++++++++++++++--
>>>    2 files changed, 20 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
>>> index bbefde319f95..3b2e59cedd2d 100644
>>> --- a/include/net/bluetooth/bluetooth.h
>>> +++ b/include/net/bluetooth/bluetooth.h
>>> @@ -383,6 +383,7 @@ struct bt_sock {
>>>    	struct list_head accept_q;
>>>    	struct sock *parent;
>>>    	unsigned long flags;
>>> +	atomic_t bpf_tskey;
>>>    	void (*skb_msg_name)(struct sk_buff *, void *, int *);
>>>    	void (*skb_put_cmsg)(struct sk_buff *, struct msghdr *, struct sock *);
>>>    };
>>> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
>>> index 95972fd4c784..7430df1c5822 100644
>>> --- a/net/bluetooth/hci_conn.c
>>> +++ b/net/bluetooth/hci_conn.c
>>> @@ -28,6 +28,7 @@
>>>    #include <linux/export.h>
>>>    #include <linux/debugfs.h>
>>>    #include <linux/errqueue.h>
>>> +#include <linux/bpf-cgroup.h>
>>>    
>>>    #include <net/bluetooth/bluetooth.h>
>>>    #include <net/bluetooth/hci_core.h>
>>> @@ -3072,6 +3073,7 @@ void hci_setup_tx_timestamp(struct sk_buff *skb, size_t key_offset,
>>>    			    const struct sockcm_cookie *sockc)
>>>    {
>>>    	struct sock *sk = skb ? skb->sk : NULL;
>>> +	bool have_tskey = false;
>>>    
>>>    	/* This shall be called on a single skb of those generated by user
>>>    	 * sendmsg(), and only when the sendmsg() does not return error to
>>> @@ -3096,6 +3098,20 @@ void hci_setup_tx_timestamp(struct sk_buff *skb, size_t key_offset,
>>>    
>>>    			skb_shinfo(skb)->tskey = key - 1;
>>>    		}
>>> +		have_tskey = true;
>>> +	}
>>> +
>>> +	if (cgroup_bpf_enabled(CGROUP_SOCK_OPS) &&
>>> +	    SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_TX_TIMESTAMPING)) {
>>> +		struct bt_sock *bt_sk = container_of(sk, struct bt_sock, sk);
>>> +		int key = atomic_inc_return(&bt_sk->bpf_tskey);
>>
>> I don't think it needs to add "atomic_t bpf_tskey". Allow the bpf to decide what
>> the skb_shinfo(skb)->tskey should be if it is not set by the userspace.

The idea was that the bpf prog can directly set the skb_shinfo(skb)->tskey if it 
is not used by the userspace. iirc, it is where the discussion left at during 
the earlier UDP support thread.


> Ok. So if I understand correctly, the plan is that for UDP and
> Bluetooth seqpacket sockets it works like this:
> 
> bpf_sock_ops_enable_tx_tstamp() does not set tskey.

The bpf_sock_ops_enable_tx_tstamp() has an used "u64 flags" argument. 
Potentially, it can use the higher 32bits to specify the tskey.

> 
> Socket timestamping sets tskey the same way as previously.
> 
> So when both are in play, it shall work like:
> 
> * attach BPF timestamping
> * setsockopt(SOF_TIMESTAMPING_SOFTWARE | SOF_TIMESTAMPING_OPT_ID)
> * sendmsg() CMSG SO_TIMESTAMPING = 0
> => tskey 0 (unset)
> * sendmsg() CMSG SO_TIMESTAMPING = SOF_TIMESTAMPING_TX_SOFTWARE
> => tskey 0
> * sendmsg() CMSG SO_TIMESTAMPING = SOF_TIMESTAMPING_TX_SOFTWARE
> => tskey 1
> * sendmsg() CMSG SO_TIMESTAMPING = 0
> => tskey 0 (unset)
> * sendmsg() CMSG SO_TIMESTAMPING = 0
> => tskey 0 (unset)
> * sendmsg() CMSG SO_TIMESTAMPING = 0
> => tskey 0 (unset)
> * sendmsg() CMSG SO_TIMESTAMPING = SOF_TIMESTAMPING_TX_SOFTWARE
> => tskey 2
> 
> and BPF program has to handle the (unset) cases itself.
> 
>>
>>> +
>>> +		if (!have_tskey)
>>> +			skb_shinfo(skb)->tskey = key - 1;
>>> +
>>> +		bpf_skops_tx_timestamping(sk, skb,
>>> +					  BPF_SOCK_OPS_TSTAMP_SENDMSG_CB);
>>> +
>>>    	}
>>>    }
>>>    
>>
>>
> 


