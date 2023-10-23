Return-Path: <bpf+bounces-13053-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4F27D41C5
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 23:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3ED95B20BF1
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 21:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCEBE23745;
	Mon, 23 Oct 2023 21:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PvgAUMYz"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9A2219FB
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 21:36:02 +0000 (UTC)
Received: from out-199.mta0.migadu.com (out-199.mta0.migadu.com [IPv6:2001:41d0:1004:224b::c7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31FADE
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 14:36:00 -0700 (PDT)
Message-ID: <42d66dde-29d6-f948-bc2e-72465beb800f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1698096956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7NzOgVAY6bvLUksVYUKvNj9r++7UpyzJXRYa2Cetic0=;
	b=PvgAUMYzTY9V+oDiz+H1rUNzwifJtXOau2MrJwr2ckGrLdpxn4AmPSMvFqrwybwlffsR80
	4qVvPmntZsz+yzIsfDzc9rZOfNIfODRHbaFEWlQV3L/8MsVvmdZnhodrq+2VQoz3Pv41pw
	XrAooVadMtN+F0yONmwHZjvgK2k42TI=
Date: Mon, 23 Oct 2023 14:35:47 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 bpf-next 00/11] bpf: tcp: Add SYN Cookie
 generation/validation SOCK_OPS hooks.
Content-Language: en-US
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, haoluo@google.com, john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org, kuba@kernel.org, kuni1840@gmail.com,
 mykolal@fb.com, netdev@vger.kernel.org, pabeni@redhat.com, sdf@google.com,
 sinquersw@gmail.com, song@kernel.org, yonghong.song@linux.dev
References: <20231020231003.51313-1-kuniyu@amazon.com>
 <20231021064801.87816-1-kuniyu@amazon.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20231021064801.87816-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 10/20/23 11:48 PM, Kuniyuki Iwashima wrote:
> I think this was doable.  With the diff below, I was able to skip
> validation in cookie_v[46]_check() when if skb->sk is not NULL.
> 
> The kfunc allocates req and set req->syncookie to 1, which is usually
> set in TX path, so if it's 1 in RX (inet_steal_sock()), we can see
> that req is allocated by kfunc (at least, req->syncookie &&
> req->rsk_listener never be true in the current TCP stack).
> 
> The difference here is that req allocated by kfunc holds refcnt of
> rsk_listener (passing true to inet_reqsk_alloc()) to prevent freeing
> the listener until req reaches cookie_v[46]_check().

The cookie_v[46]_check() holds the listener sk refcnt now?

 >
> The cookie generation at least should be done at tc/xdp.  The
> valdation can be done earlier as well on tc/xdp, but it could
> add another complexity, listener's life cycle if we allocate
> req there.

I think your code below looks pretty close already.

It seems the only concern/complexity is the extra rsk_listener refcnt (btw the 
concern is on performance for the extra refcnt? or there is correctness issue?).

Asking because bpf_sk_assign() can already assign a listener to skb->sk and it 
also does not take a refcnt on the listener. The same no refcnt needed on 
req->rsk_listener should be doable also. sock_pfree may need to be smarter to 
check req->syncookie. What else may need to change?

> 
> I'm wondering which place to add the validation capability, and
> I think SOCK_OPS is simpler than tc.
> 
>    #1 validate cookie and allocate req at tc, and skip validation
> 
>    #2 validate cookie (and update bpf map at xdp/tc, and look up bpf
>       map) and allocate req at SOCK_OPS hook
> 
> Given SYN proxy is usually on the other node and incoming cookie
> is almost always valid, we might need not validate it in the early
> stage in the stack.
> 
> What do you think ?

Yeah, supporting validation in sock_ops is an open option if the tc side is too 
hard but I feel you are pretty close on the tc side.

> 
> ---8<---
> diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.h
> index 3ecfeadbfa06..e5e4627bf270 100644
> --- a/include/net/inet_hashtables.h
> +++ b/include/net/inet_hashtables.h
> @@ -462,9 +462,19 @@ struct sock *inet_steal_sock(struct net *net, struct sk_buff *skb, int doff,
>   	if (!sk)
>   		return NULL;
>   
> -	if (!prefetched || !sk_fullsock(sk))
> +	if (!prefetched)
>   		return sk;
>   
> +	if (!sk_fullsock(sk)) {
> +		if (sk->sk_state == TCP_NEW_SYN_RECV && inet_reqsk(sk)->syncookie) {
> +			skb->sk = sk;
> +			skb->destructor = sock_pfree;
> +			sk = inet_reqsk(sk)->rsk_listener;
> +		}
> +
> +		return sk;
> +	}
> +
>   	if (sk->sk_protocol == IPPROTO_TCP) {
>   		if (sk->sk_state != TCP_LISTEN)
>   			return sk;
> diff --git a/net/core/filter.c b/net/core/filter.c
> index cc2e4babc85f..bca491ddf42c 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -11800,6 +11800,71 @@ __bpf_kfunc int bpf_sock_addr_set_sun_path(struct bpf_sock_addr_kern *sa_kern,
>   
>   	return 0;
>   }
> +
> +__bpf_kfunc int bpf_sk_assign_tcp_reqsk(struct sk_buff *skb, struct sock *sk,
> +					struct tcp_options_received *tcp_opt,
> +					int tcp_opt__sz, u16 mss)
> +{
> +	const struct tcp_request_sock_ops *af_ops;
> +	const struct request_sock_ops *ops;
> +	struct inet_request_sock *ireq;
> +	struct tcp_request_sock *treq;
> +	struct request_sock *req;
> +
> +	if (!sk)
> +		return -EINVAL;
> +
> +	if (!skb_at_tc_ingress(skb))
> +		return -EINVAL;
> +
> +	if (dev_net(skb->dev) != sock_net(sk))
> +		return -ENETUNREACH;
> +
> +	switch (sk->sk_family) {
> +	case AF_INET:  /* TODO: MPTCP */
> +		ops = &tcp_request_sock_ops;
> +		af_ops = &tcp_request_sock_ipv4_ops;
> +		break;
> +#if IS_ENABLED(CONFIG_IPV6)
> +	case AF_INET6:
> +		ops = &tcp6_request_sock_ops;
> +		af_ops = &tcp_request_sock_ipv6_ops;
> +		break;
> +#endif
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (sk->sk_type != SOCK_STREAM || sk->sk_state != TCP_LISTEN)
> +		return -EINVAL;
> +
> +	req = inet_reqsk_alloc(ops, sk, true);
> +	if (!req)
> +		return -ENOMEM;
> +
> +	ireq = inet_rsk(req);
> +	treq = tcp_rsk(req);
> +
> +	refcount_set(&req->rsk_refcnt, 1);
> +	req->syncookie = 1;
> +	req->mss = mss;
> +	req->ts_recent = tcp_opt->saw_tstamp ? tcp_opt->rcv_tsval : 0;
> +
> +	ireq->snd_wscale = tcp_opt->snd_wscale;
> +	ireq->sack_ok = tcp_opt->sack_ok;
> +	ireq->wscale_ok = tcp_opt->wscale_ok;
> +	ireq->tstamp_ok	= tcp_opt->saw_tstamp;
> +
> +	tcp_rsk(req)->af_specific = af_ops;
> +	tcp_rsk(req)->ts_off = tcp_opt->rcv_tsecr - tcp_ns_to_ts(tcp_clock_ns());
> +
> +	skb_orphan(skb);
> +	skb->sk = req_to_sk(req);
> +	skb->destructor = sock_pfree;
> +
> +	return 0;
> +}
> +
>   __diag_pop();
>   
>   int bpf_dynptr_from_skb_rdonly(struct sk_buff *skb, u64 flags,
> @@ -11828,6 +11893,10 @@ BTF_SET8_START(bpf_kfunc_check_set_sock_addr)
>   BTF_ID_FLAGS(func, bpf_sock_addr_set_sun_path)
>   BTF_SET8_END(bpf_kfunc_check_set_sock_addr)
>   
> +BTF_SET8_START(bpf_kfunc_check_set_tcp_reqsk)
> +BTF_ID_FLAGS(func, bpf_sk_assign_tcp_reqsk)
> +BTF_SET8_END(bpf_kfunc_check_set_tcp_reqsk)
> +
>   static const struct btf_kfunc_id_set bpf_kfunc_set_skb = {
>   	.owner = THIS_MODULE,
>   	.set = &bpf_kfunc_check_set_skb,
> @@ -11843,6 +11912,11 @@ static const struct btf_kfunc_id_set bpf_kfunc_set_sock_addr = {
>   	.set = &bpf_kfunc_check_set_sock_addr,
>   };
>   
> +static const struct btf_kfunc_id_set bpf_kfunc_set_tcp_reqsk = {
> +	.owner = THIS_MODULE,
> +	.set = &bpf_kfunc_check_set_tcp_reqsk,
> +};
> +
>   static int __init bpf_kfunc_init(void)
>   {
>   	int ret;
> @@ -11858,8 +11932,10 @@ static int __init bpf_kfunc_init(void)
>   	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_LWT_SEG6LOCAL, &bpf_kfunc_set_skb);
>   	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_NETFILTER, &bpf_kfunc_set_skb);
>   	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &bpf_kfunc_set_xdp);
> -	return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCK_ADDR,
> -						&bpf_kfunc_set_sock_addr);
> +	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCK_ADDR,
> +					       &bpf_kfunc_set_sock_addr);
> +	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_kfunc_set_tcp_reqsk);
> +	return ret;
>   }
>   late_initcall(bpf_kfunc_init);
>   
> ---8<---


