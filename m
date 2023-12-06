Return-Path: <bpf+bounces-16846-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDCF8806576
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 04:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AA9E1C21172
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 03:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15C4CA67;
	Wed,  6 Dec 2023 03:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UNo90qxN"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [IPv6:2001:41d0:203:375::b2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6FA01B6
	for <bpf@vger.kernel.org>; Tue,  5 Dec 2023 19:11:26 -0800 (PST)
Message-ID: <48a54674-3e96-4a35-89d9-d726608fb8c5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701832284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Td1wCnY57CVO1M0Fwy3V9pqGf9Wilw3eR6IuVutexXI=;
	b=UNo90qxN9V5KsiQAIks/yAlpvZpPtWdA8P8ZtVzPUdaTYHP9LBFh4mmeRAqHnuOqKv0462
	y90OEn/M0M5AFWLwYA7WmAe7zzIqLV8pyVZLeXwFMOhd2ROMWg0oRP+eSsSJQvhANYhWxU
	BAhyGyi1o1qGxGDd3giHz/4McO1/+n4=
Date: Tue, 5 Dec 2023 19:11:17 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 bpf-next 1/3] bpf: tcp: Handle BPF SYN Cookie in
 cookie_v[46]_check().
Content-Language: en-US
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, edumazet@google.com, kuni1840@gmail.com,
 netdev@vger.kernel.org
References: <8bd1d595-4bb3-44d1-a9c3-2d9c0c960bcb@linux.dev>
 <20231206012952.18761-1-kuniyu@amazon.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20231206012952.18761-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/5/23 5:29 PM, Kuniyuki Iwashima wrote:
> From: Martin KaFai Lau <martin.lau@linux.dev>
> Date: Tue, 5 Dec 2023 16:19:20 -0800
>> On 12/4/23 5:34 PM, Kuniyuki Iwashima wrote:
>>> diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
>>> index 61f1c96cfe63..0f9c3aed2014 100644
>>> --- a/net/ipv4/syncookies.c
>>> +++ b/net/ipv4/syncookies.c
>>> @@ -304,6 +304,59 @@ static int cookie_tcp_reqsk_init(struct sock *sk, struct sk_buff *skb,
>>>    	return 0;
>>>    }
>>>    
>>> +#if IS_ENABLED(CONFIG_BPF)
>>> +struct request_sock *cookie_bpf_check(struct net *net, struct sock *sk,
>>> +				      struct sk_buff *skb)
>>> +{
>>> +	struct request_sock *req = inet_reqsk(skb->sk);
>>> +	struct inet_request_sock *ireq = inet_rsk(req);
>>> +	struct tcp_request_sock *treq = tcp_rsk(req);
>>> +	struct tcp_options_received tcp_opt;
>>> +	int ret;
>>> +
>>> +	skb->sk = NULL;
>>> +	skb->destructor = NULL;
>>> +	req->rsk_listener = NULL;
>>> +
>>> +	memset(&tcp_opt, 0, sizeof(tcp_opt));
>>> +	tcp_parse_options(net, skb, &tcp_opt, 0, NULL);
>>
>> In patch 2, the bpf prog is passing the tcp_opt to the kfunc. The selftest in
>> patch 3 is also parsing the tcp-options.
>>
>> The kernel parses the tcp-option here again to do some checking and req's member
>> initialization. Can these checking and initialization be done in the
>> bpf_sk_assign_tcp_reqsk() kfunc instead to avoid the double tcp-option parsing?
> 
> If TS is not used as a cookie storage, bpf prog need not parse it.
> OTOH, if a value is encoded into TS, bpf prog need to parse it.
> In that case, we cannot avoid parsing options in bpf prog.

If I read patch 2 correctly, the ireq->tstamp_ok is set by the kfunc, so I 
assume that the bpf prog has to parse the tcp-option.

Like the "if (ireq->tstamp_ok ^ tcp_opt.saw_tstamp)" test below, ireq->tstamp_ok 
will always be 0 if the bpf prog did not parse the tcp-option.

> 
> The parsing here comes from my paranoia, so.. probably we can drop it
> and the first test below, and rely on bpf prog's tcp_opt, especially
> tstamp_ok, rcv_tsval, and rcv_tsecr ?

My preference is that it is clearer to allow the bpf prog to initialize all 
tcp_opt instead of only taking the tcp_opt.tstamp_ok from bpf_prog but ignore 
the tcp_opt.rcv_tsval/tsecr. The kfunc will then use the tcp_opt to initialize 
the req.

It is also better to detect the following error cases as much as possible in the 
kfunc instead of failing later in the tcp stack. e.g. checking the sysctl should 
be doable in the kfunc.

> 
> I placed other tests here to align with the normal cookie flow, but
> they can be moved to kfunc.  However, initialisation assuems skb
> points to TCP header, so here would be better place, I think.
> 
> 
>>
>>> +
>>> +	if (ireq->tstamp_ok ^ tcp_opt.saw_tstamp) {
>>> +		__NET_INC_STATS(net, LINUX_MIB_SYNCOOKIESFAILED);
>>> +		goto reset;
>>> +	}
>>> +
>>> +	__NET_INC_STATS(net, LINUX_MIB_SYNCOOKIESRECV);
>>> +
>>> +	if (ireq->tstamp_ok) {
>>> +		if (!READ_ONCE(net->ipv4.sysctl_tcp_timestamps))
>>> +			goto reset;
>>> +
>>> +		req->ts_recent = tcp_opt.rcv_tsval;
>>> +		treq->ts_off = tcp_opt.rcv_tsecr - tcp_ns_to_ts(false, tcp_clock_ns());
>>> +	}
>>> +
>>> +	if (ireq->sack_ok && !READ_ONCE(net->ipv4.sysctl_tcp_sack))
>>> +		goto reset;
>>> +
>>> +	if (ireq->wscale_ok && !READ_ONCE(net->ipv4.sysctl_tcp_window_scaling))
>>> +		goto reset;
>>> +
>>> +	ret = cookie_tcp_reqsk_init(sk, skb, req);
>>> +	if (ret) {
>>> +		reqsk_free(req);
>>> +		req = NULL;
>>> +	}
>>> +
>>> +	return req;
>>> +
>>> +reset:
>>> +	reqsk_free(req);
>>> +	return ERR_PTR(-EINVAL);
>>> +}
>>> +EXPORT_SYMBOL_GPL(cookie_bpf_check);
>>> +#endif


