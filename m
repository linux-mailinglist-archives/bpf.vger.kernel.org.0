Return-Path: <bpf+bounces-7365-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A677762AA
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 16:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F971280C15
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 14:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF59918C0C;
	Wed,  9 Aug 2023 14:39:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FF317755
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 14:39:38 +0000 (UTC)
Received: from out-97.mta0.migadu.com (out-97.mta0.migadu.com [91.218.175.97])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096902107
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 07:39:36 -0700 (PDT)
Message-ID: <6acbbf63-ba10-4a66-5e31-b9a499f79489@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691591975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K70SI6itTIMucJGr0SM6nBFOaQH3QInpyitYP0k5TGc=;
	b=nJMgWPNHgDmf8TRqPDZuCQcujph5ZN/cHQX91FjhLiCSbwK5HK5u+PoCxWCJECpRrLlZFL
	qMOT4lxVTbCtawzV70UYqUiNnr8Cl5+DkmzSDNk2B67R6vBN8L8Zf4/C0pkib2D99+57Qb
	cKPYAoi/eiZvR9XkKDHftB/Qr9ml2ko=
Date: Wed, 9 Aug 2023 07:39:28 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] net: Fix slab-out-of-bounds in
 inet[6]_steal_sock
Content-Language: en-US
To: Lorenz Bauer <lmb@isovalent.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Kuniyuki Iwashima
 <kuniyu@amazon.com>, Martin KaFai Lau <martin.lau@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Kumar Kartikeya Dwivedi <memxor@gmail.com>
References: <20230809-bpf-next-v1-1-c1b80712e83b@isovalent.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230809-bpf-next-v1-1-c1b80712e83b@isovalent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/9/23 1:33 AM, Lorenz Bauer wrote:
> Kumar reported a KASAN splat in tcp_v6_rcv:
> 
>    bash-5.2# ./test_progs -t btf_skc_cls_ingress
>    ...
>    [   51.810085] BUG: KASAN: slab-out-of-bounds in tcp_v6_rcv+0x2d7d/0x3440
>    [   51.810458] Read of size 2 at addr ffff8881053f038c by task test_progs/226
> 
> The problem is that inet[6]_steal_sock accesses sk->sk_protocol without
> accounting for request sockets. I added the check to ensure that we only
> every try to perform a reuseport lookup on a supported socket.
> 
> It turns out that this isn't necessary at all. struct sock_common contains
> a skc_reuseport flag which indicates whether a socket is part of a

Does it go back to the earlier discussion 
(https://lore.kernel.org/bpf/7188429a-c380-14c8-57bb-9d05d3ba4e5e@linux.dev/) 
that the sk->sk_reuseport is 1 from sk_clone for TCP_ESTABLISHED? It works 
because there is sk->sk_reuseport"_cb" check going deeper into 
reuseport_select_sock() but there is an extra inet6_ehashfn for all TCP_ESTABLISHED.

> reuseport group. inet[6]_lookup_reuseport already check this flag,
> so we can't execute an erroneous reuseport lookup by definition.
> 
> Remove the unnecessary assertions to fix the out of bounds access.
> 
> Fixes: 9c02bec95954 ("bpf, net: Support SO_REUSEPORT sockets with bpf_sk_assign")
> Reported-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
> ---
>   include/net/inet6_hashtables.h | 10 ----------
>   include/net/inet_hashtables.h  | 10 ----------
>   2 files changed, 20 deletions(-)
> 
> diff --git a/include/net/inet6_hashtables.h b/include/net/inet6_hashtables.h
> index 284b5ce7205d..f9907ed36d54 100644
> --- a/include/net/inet6_hashtables.h
> +++ b/include/net/inet6_hashtables.h
> @@ -119,16 +119,6 @@ struct sock *inet6_steal_sock(struct net *net, struct sk_buff *skb, int doff,
>   	if (!prefetched)
>   		return sk;
>   
> -	if (sk->sk_protocol == IPPROTO_TCP) {
> -		if (sk->sk_state != TCP_LISTEN)
> -			return sk;
> -	} else if (sk->sk_protocol == IPPROTO_UDP) {
> -		if (sk->sk_state != TCP_CLOSE)
> -			return sk;
> -	} else {
> -		return sk;
> -	}
> -
>   	reuse_sk = inet6_lookup_reuseport(net, sk, skb, doff,
>   					  saddr, sport, daddr, ntohs(dport),
>   					  ehashfn);
> diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.h
> index 1177effabed3..57a46993383a 100644
> --- a/include/net/inet_hashtables.h
> +++ b/include/net/inet_hashtables.h
> @@ -465,16 +465,6 @@ struct sock *inet_steal_sock(struct net *net, struct sk_buff *skb, int doff,
>   	if (!prefetched)
>   		return sk;
>   
> -	if (sk->sk_protocol == IPPROTO_TCP) {
> -		if (sk->sk_state != TCP_LISTEN)
> -			return sk;
> -	} else if (sk->sk_protocol == IPPROTO_UDP) {
> -		if (sk->sk_state != TCP_CLOSE)
> -			return sk;
> -	} else {
> -		return sk;
> -	}
> -
>   	reuse_sk = inet_lookup_reuseport(net, sk, skb, doff,
>   					 saddr, sport, daddr, ntohs(dport),
>   					 ehashfn);
> 
> ---
> base-commit: eb62e6aef940fcb1879100130068369d4638088f
> change-id: 20230808-bpf-next-a442a095562b
> 
> Best regards,


