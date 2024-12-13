Return-Path: <bpf+bounces-46922-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7599C9F191A
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 23:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDC13188E4FE
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 22:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6983119A2A3;
	Fri, 13 Dec 2024 22:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sY6pK1H5"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552DF15573A
	for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 22:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734128804; cv=none; b=e4Nh6ZSj9iZsMHS8cA920VCu2ORQtJuwDGlozST+3YjEe87ydz4atT9Hc/dnLPrcyq0rzdJK5jd2VwXFIuzJ/rbkpHQCe4P7PuLBGqhDzfQ03gVsRge2aWaoNU8O2DnZ/VcCFPFDHiA8WLqonHhr1WsSLe7uP+ZjKf//cWBuBC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734128804; c=relaxed/simple;
	bh=XX91Xi0yFJjRfC7Mk2DYxMUHNqgtt1Y0buHqAPALJbs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tX6uTCLb4r6f6fjHgvf1Rm6ICjuGVvzd50TRQXQH5b8J8wq7CJMi5lRNmYVqTpD64QKuJEJEQpHQGIMocZEk5LS2mv52EBCYE/Rc1feGI/CNQIk0krqXOiuxzqIyXJ4oU/n0oAGuFrHLR3HQNSxlcyj1tAOlN6PVEIdPbWDgQXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sY6pK1H5; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c1701350-236d-4a9e-9c53-4badc0738309@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734128799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MG6FDJJsoBDRM7h+Zj8HQ5/vOReax2EY7pVl0sF3C0Y=;
	b=sY6pK1H5k4yNY68I/XoeOH/Iw8jNPCsidwJ65lQjB7iilAyvCMI9LSMZ74gDpeB4Ohv0or
	2/F4jGRIvBogBTj3M78nIOfBtxdHKIt9I4bsYQ6c19Mjz3ggkQLPIhh3Ot9Mk20b1OJl84
	I6RcAhwVX9A6KGr9E6oqvPtqqmDlYiI=
Date: Fri, 13 Dec 2024 14:26:26 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v4 02/11] net-timestamp: prepare for bpf prog use
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
References: <20241207173803.90744-1-kerneljasonxing@gmail.com>
 <20241207173803.90744-3-kerneljasonxing@gmail.com>
 <f8e9ab4a-38b9-43a5-aaf4-15f95a3463d0@linux.dev>
 <CAL+tcoDGq8Jih9vwsz=-O8byC1S0R1uojShMvUiTZKQvMDnfTQ@mail.gmail.com>
 <996cbe46-e2cd-44b6-a53a-13fd6ebfc4c0@linux.dev>
 <CAL+tcoAxmHj9_d5PUqvSHswavKFspd_D5tOt81fon-UtEf_OMA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <CAL+tcoAxmHj9_d5PUqvSHswavKFspd_D5tOt81fon-UtEf_OMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/13/24 6:42 AM, Jason Xing wrote:
>>>> I just noticed a trickier one, sockops bpf prog can write to sk->sk_txhash. The
>>>> same should go for reading from sk. Also, sockops prog assumes a fullsock sk is
>>>> a tcp_sock which also won't work for the udp case. A quick thought is to do
>>>> something similar to is_fullsock. May be repurpose the is_fullsock somehow or a
>>>> new u8 is needed. Take a look at SOCK_OPS_{GET,SET}_FIELD. It avoids
>>>> writing/reading the sk when is_fullsock is false.

May be this message buried in the earlier reply or some piece was not clear, so 
worth to highlight here.

Take a look at how is_fullsock is used in SOCK_OPS_{GET,SET}_FIELD. I think a 
similar idea can be borrowed here.

>>>
>>> Do you mean that if we introduce a new field, then bpf prog can
>>> read/write the socket?
>>
>> The same goes for writing the sk, e.g. writing the sk->sk_txhash. It needs the
>> sk_lock held. Reading may be ok-ish. The bpf prog can read it anyway by
>> bpf_probe_read...etc.
>>
>> When adding udp timestamp callback later, it needs to stop reading the tcp_sock
>> through skops from the udp callback for sure. Do take a look at
>> SOCK_OPS_GET_TCP_SOCK_FIELD. I think we need to ensure the udp timestamp
>> callback won't break here before moving forward.
> 
> Agreed. Removing the "sock_ops.sk = sk;" is simple, but I still want
> the bpf prog to be able to read some fields from the socket under
> those new callbacks.

No need to remove "sock_ops.sk = sk;". Try to borrow the is_fullsock idea.

Overall, the new timestamp callback breaks assumptions like, sk_lock is held and 
is_fullsock must be a tcp_sock. This needs to be audited. In particular, please 
check sock_ops_func_proto() for all accessible bpf helpers. Also check the 
sock_ops_is_valid_access() and sock_ops_convert_ctx_access() for directly 
accessible fields without the helpers. In particular, the BPF_WRITE (able) 
fields and the tcp_sock fields.

