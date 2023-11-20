Return-Path: <bpf+bounces-15408-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 921187F1E91
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 22:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFC5EB20E9E
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 21:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C6E374C9;
	Mon, 20 Nov 2023 21:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="o4TgVxrl"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722A9C4
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 13:13:26 -0800 (PST)
Message-ID: <bc92c670-f472-43b1-af0b-a50353ed8757@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1700514804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d28l39Q/WnmLlrxe8irc1XL5IccL462Ojh4J4C8JN9o=;
	b=o4TgVxrlR4vNw/maO8ivZFZsOjFsx5V2XQlx0+4YWm47yXBJc13MS6cDT/xHi7o36vzUHF
	jh1ziBee/ehphVINcZHLEbtZ+yogQO6nCm7B6ghl4C8bF41fiMkLBTCzmlvifhzlmOviXR
	oQ00LN86FA7xKjdeKugkWB/2qieKY8M=
Date: Mon, 20 Nov 2023 13:13:18 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf 1/2] bpf: sockmap, af_unix sockets need to hold ref
 for pair sock
Content-Language: en-US
To: John Fastabend <john.fastabend@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, yangyingliang@huawei.com,
 martin.lau@kernel.org, Jakub Sitnicki <jakub@cloudflare.com>
References: <20231016190819.81307-1-john.fastabend@gmail.com>
 <20231016190819.81307-2-john.fastabend@gmail.com>
 <87cywnjblh.fsf@cloudflare.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <87cywnjblh.fsf@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/6/23 4:35 AM, Jakub Sitnicki wrote:
>> diff --git a/net/unix/unix_bpf.c b/net/unix/unix_bpf.c
>> index 2f9d8271c6ec..705eeed10be3 100644
>> --- a/net/unix/unix_bpf.c
>> +++ b/net/unix/unix_bpf.c
>> @@ -143,6 +143,8 @@ static void unix_stream_bpf_check_needs_rebuild(struct proto *ops)
>>   
>>   int unix_dgram_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore)
>>   {
>> +	struct sock *skpair;
>> +
>>   	if (sk->sk_type != SOCK_DGRAM)
>>   		return -EOPNOTSUPP;
>>   
>> @@ -152,6 +154,9 @@ int unix_dgram_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool re
>>   		return 0;
>>   	}
>>   
>> +	skpair = unix_peer(sk);
>> +	sock_hold(skpair);
>> +	psock->skpair = skpair;
>>   	unix_dgram_bpf_check_needs_rebuild(psock->sk_proto);
>>   	sock_replace_proto(sk, &unix_dgram_bpf_prot);
>>   	return 0;
> unix_dgram should not need this, since it grabs a ref on each sendmsg.

John, could you address this comment and respin v2?

The unix_inet_redir_to_connected() seems needing a fix in patch 2 also as 
pointed out by JakubS.

Thanks.

> 
> I'm not able to reproduce this bug for unix_dgram.
> 
> Have you seen any KASAN reports for unix_dgram from syzcaller?


