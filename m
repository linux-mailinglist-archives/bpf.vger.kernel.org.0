Return-Path: <bpf+bounces-16836-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD58806350
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 01:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 233C31F2174F
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 00:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD80536A;
	Wed,  6 Dec 2023 00:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vrubHhhR"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ECC9FA
	for <bpf@vger.kernel.org>; Tue,  5 Dec 2023 16:19:29 -0800 (PST)
Message-ID: <8bd1d595-4bb3-44d1-a9c3-2d9c0c960bcb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701821967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FDi2GR+fCgeL6g64+LyWBiWncmrcFqQFI6ly1vYBOLE=;
	b=vrubHhhR+3gKDTzdbUH8sRkx0vSczF/ZoFZZy5nAxYK4VEsmlMdInBYRpxPJqPBe5+jerG
	BcfIS00Zb7j5XgcPhhAVOAA6Rz6XnIC5GIdJLAPzscC64wSYSjTEJoMI/wk2e4KK9Xbl7j
	/rjKLVk2DIQuk3avtwJXyUW+Lr9f3+0=
Date: Tue, 5 Dec 2023 16:19:20 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 bpf-next 1/3] bpf: tcp: Handle BPF SYN Cookie in
 cookie_v[46]_check().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>
References: <20231205013420.88067-1-kuniyu@amazon.com>
 <20231205013420.88067-2-kuniyu@amazon.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20231205013420.88067-2-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/4/23 5:34 PM, Kuniyuki Iwashima wrote:
> diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
> index 61f1c96cfe63..0f9c3aed2014 100644
> --- a/net/ipv4/syncookies.c
> +++ b/net/ipv4/syncookies.c
> @@ -304,6 +304,59 @@ static int cookie_tcp_reqsk_init(struct sock *sk, struct sk_buff *skb,
>   	return 0;
>   }
>   
> +#if IS_ENABLED(CONFIG_BPF)
> +struct request_sock *cookie_bpf_check(struct net *net, struct sock *sk,
> +				      struct sk_buff *skb)
> +{
> +	struct request_sock *req = inet_reqsk(skb->sk);
> +	struct inet_request_sock *ireq = inet_rsk(req);
> +	struct tcp_request_sock *treq = tcp_rsk(req);
> +	struct tcp_options_received tcp_opt;
> +	int ret;
> +
> +	skb->sk = NULL;
> +	skb->destructor = NULL;
> +	req->rsk_listener = NULL;
> +
> +	memset(&tcp_opt, 0, sizeof(tcp_opt));
> +	tcp_parse_options(net, skb, &tcp_opt, 0, NULL);

In patch 2, the bpf prog is passing the tcp_opt to the kfunc. The selftest in 
patch 3 is also parsing the tcp-options.

The kernel parses the tcp-option here again to do some checking and req's member 
initialization. Can these checking and initialization be done in the 
bpf_sk_assign_tcp_reqsk() kfunc instead to avoid the double tcp-option parsing?

> +
> +	if (ireq->tstamp_ok ^ tcp_opt.saw_tstamp) {
> +		__NET_INC_STATS(net, LINUX_MIB_SYNCOOKIESFAILED);
> +		goto reset;
> +	}
> +
> +	__NET_INC_STATS(net, LINUX_MIB_SYNCOOKIESRECV);
> +
> +	if (ireq->tstamp_ok) {
> +		if (!READ_ONCE(net->ipv4.sysctl_tcp_timestamps))
> +			goto reset;
> +
> +		req->ts_recent = tcp_opt.rcv_tsval;
> +		treq->ts_off = tcp_opt.rcv_tsecr - tcp_ns_to_ts(false, tcp_clock_ns());
> +	}
> +
> +	if (ireq->sack_ok && !READ_ONCE(net->ipv4.sysctl_tcp_sack))
> +		goto reset;
> +
> +	if (ireq->wscale_ok && !READ_ONCE(net->ipv4.sysctl_tcp_window_scaling))
> +		goto reset;
> +
> +	ret = cookie_tcp_reqsk_init(sk, skb, req);
> +	if (ret) {
> +		reqsk_free(req);
> +		req = NULL;
> +	}
> +
> +	return req;
> +
> +reset:
> +	reqsk_free(req);
> +	return ERR_PTR(-EINVAL);
> +}
> +EXPORT_SYMBOL_GPL(cookie_bpf_check);
> +#endif


