Return-Path: <bpf+bounces-16011-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A18107FAE2B
	for <lists+bpf@lfdr.de>; Tue, 28 Nov 2023 00:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5095A281A9C
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 23:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D0E495D5;
	Mon, 27 Nov 2023 23:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tOwjcNQk"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E791A2
	for <bpf@vger.kernel.org>; Mon, 27 Nov 2023 15:04:46 -0800 (PST)
Message-ID: <96afef48-a729-4947-9672-d63627a43cb0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701126285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NTyfDqxBZcr8oN7mgZIp9hCONWbE61hVHn2IywdLDaM=;
	b=tOwjcNQkmYk5dK6dFsE0mOvfdY9cDTQT5C616pazMxNwn/wvI+KZSw/zgQChrgzzzMkLta
	HHJvZJDKCBufhw9SjRuxj0uW3fLvBnxK96PQhXMDn7WdCqFy0DiyGYT7hq/FJ3IncN5oJ7
	q/Ylrxeo0EMSf1n4C7v936NtuQ4mPnI=
Date: Mon, 27 Nov 2023 15:04:38 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 bpf-next 10/11] bpf: tcp: Support arbitrary SYN Cookie.
Content-Language: en-US
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, haoluo@google.com, john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org, kuba@kernel.org, kuni1840@gmail.com,
 mykolal@fb.com, netdev@vger.kernel.org, pabeni@redhat.com, sdf@google.com,
 song@kernel.org, yonghong.song@linux.dev
References: <825b7dde-f421-436e-99c8-47f9c1d83f5f@linux.dev>
 <20231123003154.56710-1-kuniyu@amazon.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20231123003154.56710-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/22/23 4:31 PM, Kuniyuki Iwashima wrote:
> From: Martin KaFai Lau <martin.lau@linux.dev>
> Date: Wed, 22 Nov 2023 15:19:29 -0800
>> On 11/21/23 10:42 AM, Kuniyuki Iwashima wrote:
>>> diff --git a/include/net/inet6_hashtables.h b/include/net/inet6_hashtables.h
>>> index 533a7337865a..9a67f47a5e64 100644
>>> --- a/include/net/inet6_hashtables.h
>>> +++ b/include/net/inet6_hashtables.h
>>> @@ -116,9 +116,23 @@ struct sock *inet6_steal_sock(struct net *net, struct sk_buff *skb, int doff,
>>>    	if (!sk)
>>>    		return NULL;
>>>    
>>> -	if (!prefetched || !sk_fullsock(sk))
>>> +	if (!prefetched)
>>>    		return sk;
>>>    
>>> +	if (sk->sk_state == TCP_NEW_SYN_RECV) {
>>> +#if IS_ENABLED(CONFIG_SYN_COOKIE)
>>> +		if (inet_reqsk(sk)->syncookie) {
>>> +			*refcounted = false;
>>> +			skb->sk = sk;
>>> +			skb->destructor = sock_pfree;
>>
>> Instead of re-init the skb->sk and skb->destructor, can skb_steal_sock() avoid
>> resetting them to NULL in the first place and skb_steal_sock() returns the
>> rsk_listener instead?
> 
> Yes, but we need to move skb_steal_sock() to request_sock.h or include it just

Moving it seems better than including a header in the middle. Not sure if 
inet_sock.h or request_sock.h is a better target.


> before skb_steal_sock() in sock.h like below.  When I include request_sock.h in
> top of sock.h, there were many build errors.



