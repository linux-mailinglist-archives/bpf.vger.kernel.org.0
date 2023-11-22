Return-Path: <bpf+bounces-15714-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2857F5464
	for <lists+bpf@lfdr.de>; Thu, 23 Nov 2023 00:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04B69B20C47
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 23:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE86221106;
	Wed, 22 Nov 2023 23:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dEO32lU2"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C8618D
	for <bpf@vger.kernel.org>; Wed, 22 Nov 2023 15:19:40 -0800 (PST)
Message-ID: <825b7dde-f421-436e-99c8-47f9c1d83f5f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1700695178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M0SdBYwoVa7t0s/5f4Mfjq0zCPOORxBTD1xrJ9cW3qI=;
	b=dEO32lU21qCqsbjfNveGAmR/RkZwjQMWu15I10HYUhMoB6VmZnCuQbrtRe2ZOffUPunzGk
	ALS7kieIcfNqJjMoByogXscns4N0juL9HEnd94k9RYfTDKfprrNRiwA4AkfN4RUGZVXsmd
	jPnM/Aa20cpYF9MZPiCS5/TDiVw2Htc=
Date: Wed, 22 Nov 2023 15:19:29 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 bpf-next 10/11] bpf: tcp: Support arbitrary SYN Cookie.
Content-Language: en-US
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>
References: <20231121184245.69569-1-kuniyu@amazon.com>
 <20231121184245.69569-11-kuniyu@amazon.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20231121184245.69569-11-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/21/23 10:42 AM, Kuniyuki Iwashima wrote:
> diff --git a/include/net/inet6_hashtables.h b/include/net/inet6_hashtables.h
> index 533a7337865a..9a67f47a5e64 100644
> --- a/include/net/inet6_hashtables.h
> +++ b/include/net/inet6_hashtables.h
> @@ -116,9 +116,23 @@ struct sock *inet6_steal_sock(struct net *net, struct sk_buff *skb, int doff,
>   	if (!sk)
>   		return NULL;
>   
> -	if (!prefetched || !sk_fullsock(sk))
> +	if (!prefetched)
>   		return sk;
>   
> +	if (sk->sk_state == TCP_NEW_SYN_RECV) {
> +#if IS_ENABLED(CONFIG_SYN_COOKIE)
> +		if (inet_reqsk(sk)->syncookie) {
> +			*refcounted = false;
> +			skb->sk = sk;
> +			skb->destructor = sock_pfree;

Instead of re-init the skb->sk and skb->destructor, can skb_steal_sock() avoid 
resetting them to NULL in the first place and skb_steal_sock() returns the 
rsk_listener instead? btw, can inet_reqsk(sk)->rsk_listener be set to NULL after 
this point?

Beside, it is essentially assigning the incoming request to a listening sk. Does 
it need to call the inet6_lookup_reuseport() a few lines below to avoid skipping 
the bpf reuseport selection that was fixed in commit 9c02bec95954 ("bpf, net: 
Support SO_REUSEPORT sockets with bpf_sk_assign")?

> +			return inet_reqsk(sk)->rsk_listener;
> +		}
> +#endif
> +		return sk;
> +	} else if (sk->sk_state == TCP_TIME_WAIT) {
> +		return sk;
> +	}
> +
>   	if (sk->sk_protocol == IPPROTO_TCP) {
>   		if (sk->sk_state != TCP_LISTEN)
>   			return sk;
> diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.h
> index 3ecfeadbfa06..36609656a047 100644
> --- a/include/net/inet_hashtables.h
> +++ b/include/net/inet_hashtables.h
> @@ -462,9 +462,23 @@ struct sock *inet_steal_sock(struct net *net, struct sk_buff *skb, int doff,
>   	if (!sk)
>   		return NULL;
>   
> -	if (!prefetched || !sk_fullsock(sk))
> +	if (!prefetched)
>   		return sk;
>   
> +	if (sk->sk_state == TCP_NEW_SYN_RECV) {
> +#if IS_ENABLED(CONFIG_SYN_COOKIE)
> +		if (inet_reqsk(sk)->syncookie) {
> +			*refcounted = false;
> +			skb->sk = sk;
> +			skb->destructor = sock_pfree;
> +			return inet_reqsk(sk)->rsk_listener;
> +		}
> +#endif
> +		return sk;
> +	} else if (sk->sk_state == TCP_TIME_WAIT) {
> +		return sk;
> +	}
> +
>   	if (sk->sk_protocol == IPPROTO_TCP) {
>   		if (sk->sk_state != TCP_LISTEN)


