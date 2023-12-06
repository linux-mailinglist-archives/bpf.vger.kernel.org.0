Return-Path: <bpf+bounces-16839-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 334F4806404
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 02:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 139981C20BC1
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 01:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C85EC4;
	Wed,  6 Dec 2023 01:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="L8fNLdAj"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [IPv6:2001:41d0:203:375::b9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718BB1AA
	for <bpf@vger.kernel.org>; Tue,  5 Dec 2023 17:21:02 -0800 (PST)
Message-ID: <8b7aab72-5105-42fb-9a49-06b2682d9e3f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701825660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c9EvTV1sQ9NLN9kRZqBqyPzfwiYwhQkWdEcmTcY681k=;
	b=L8fNLdAjH7Xly2OseEa46LoGk+g806CFzJFXfAzoBpi02OmSmNb9Er1u/UMkP4XSff6PoT
	fx3dXKcUIrZclxZbAqTPUzNLylBh9J17FX2+6UQ2I9HH/0REXxrOHb2epxhJv344EAF2nq
	ZuoEHnn7UhRO25RSbqS/qWqwCjH+328=
Date: Tue, 5 Dec 2023 17:20:53 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 bpf-next 2/3] bpf: tcp: Support arbitrary SYN Cookie.
Content-Language: en-US
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>
References: <20231205013420.88067-1-kuniyu@amazon.com>
 <20231205013420.88067-3-kuniyu@amazon.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20231205013420.88067-3-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/4/23 5:34 PM, Kuniyuki Iwashima wrote:
> diff --git a/include/net/request_sock.h b/include/net/request_sock.h
> index 144c39db9898..2efffe2c05d0 100644
> --- a/include/net/request_sock.h
> +++ b/include/net/request_sock.h
> @@ -83,6 +83,41 @@ static inline struct sock *req_to_sk(struct request_sock *req)
>   	return (struct sock *)req;
>   }
>   
> +/**
> + * skb_steal_sock - steal a socket from an sk_buff
> + * @skb: sk_buff to steal the socket from
> + * @refcounted: is set to true if the socket is reference-counted
> + * @prefetched: is set to true if the socket was assigned from bpf
> + */
> +static inline struct sock *
> +skb_steal_sock(struct sk_buff *skb, bool *refcounted, bool *prefetched)
> +{
> +	struct sock *sk = skb->sk;
> +
> +	if (!skb->sk) {
> +		*prefetched = false;
> +		*refcounted = false;
> +		return NULL;
> +	}
> +
> +	*prefetched = skb_sk_is_prefetched(skb);
> +	if (*prefetched) {
> +#if IS_ENABLED(CONFIG_SYN_COOKIES)
> +		if (sk->sk_state == TCP_NEW_SYN_RECV && inet_reqsk(sk)->syncookie) {
> +			*refcounted = false;
> +			return inet_reqsk(sk)->rsk_listener;

If it does not break later logic, I would set inet_reqsk(sk)->rsk_listener to 
NULL to avoid inconsistency when the later inet[6]_lookup_reuseport() selects 
another listener. skb_steal_sock() steals the inet_reqsk(sk)->rsk_listener in 
this sense.


> +		}
> +#endif
> +		*refcounted = sk_is_refcounted(sk);
> +	} else {
> +		*refcounted = true;
> +	}
> +
> +	skb->destructor = NULL;
> +	skb->sk = NULL;
> +	return sk;
> +}
> +

[ ... ]

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 0adaa4afa35f..a43f7627c5fd 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -11816,6 +11816,94 @@ __bpf_kfunc int bpf_sock_addr_set_sun_path(struct bpf_sock_addr_kern *sa_kern,
>   
>   	return 0;
>   }
> +
> +__bpf_kfunc int bpf_sk_assign_tcp_reqsk(struct sk_buff *skb, struct sock *sk,
> +					struct tcp_cookie_attributes *attr,
> +					int attr__sz)
> +{
> +#if IS_ENABLED(CONFIG_SYN_COOKIES)
> +	const struct request_sock_ops *ops;
> +	struct inet_request_sock *ireq;
> +	struct tcp_request_sock *treq;
> +	struct request_sock *req;
> +	__u16 min_mss;
> +
> +	if (attr__sz != sizeof(*attr) || attr->tcp_opt.unused)
> +		return -EINVAL;
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
> +	switch (skb->protocol) {
> +	case htons(ETH_P_IP):
> +		ops = &tcp_request_sock_ops;
> +		min_mss = 536;
> +		break;
> +#if IS_BUILTIN(CONFIG_IPV6)
> +	case htons(ETH_P_IPV6):
> +		ops = &tcp6_request_sock_ops;
> +		min_mss = IPV6_MIN_MTU - 60;
> +		break;
> +#endif
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (sk->sk_type != SOCK_STREAM || sk->sk_state != TCP_LISTEN)
> +		return -EINVAL;
> +
> +	if (attr->tcp_opt.mss_clamp < min_mss) {
> +		__NET_INC_STATS(sock_net(sk), LINUX_MIB_SYNCOOKIESFAILED);

hmm... this one I am not sure if the kfunc should decide what counted as 
SYNCOOKIESFAILED or not. Beside, the bpf prog should have already rejected the 
skb as part of its cookie validation logic. Thus, reaching here is more like a 
bpf prog's error instead.

I would leave the SYNCOOKIESFAILED usage for the kernel tcp layer only. The 
existing bpf_tcp_check_syncookie() helper does not increment SYNCOOKIESFAILED also.

> +		return -EINVAL;
> +	}
> +
> +	if (attr->tcp_opt.wscale_ok &&
> +	    (attr->tcp_opt.snd_wscale > TCP_MAX_WSCALE ||
> +	     attr->tcp_opt.rcv_wscale > TCP_MAX_WSCALE)) {
> +		__NET_INC_STATS(sock_net(sk), LINUX_MIB_SYNCOOKIESFAILED);

Same here.

> +		return -EINVAL;
> +	}
> +
> +	if (sk_is_mptcp(sk))
> +		req = mptcp_subflow_reqsk_alloc(ops, sk, false);
> +	else
> +		req = inet_reqsk_alloc(ops, sk, false);
> +
> +	if (!req)
> +		return -ENOMEM;
> +
> +	ireq = inet_rsk(req);
> +	treq = tcp_rsk(req);
> +
> +	req->syncookie = 1;
> +	req->rsk_listener = sk;
> +	req->mss = attr->tcp_opt.mss_clamp;
> +
> +	ireq->snd_wscale = attr->tcp_opt.snd_wscale;
> +	ireq->rcv_wscale = attr->tcp_opt.rcv_wscale;
> +	ireq->wscale_ok = attr->tcp_opt.wscale_ok;
> +	ireq->tstamp_ok	= attr->tcp_opt.tstamp_ok;
> +	ireq->sack_ok = attr->tcp_opt.sack_ok;
> +	ireq->ecn_ok = attr->ecn_ok;
> +
> +	treq->req_usec_ts = attr->usec_ts_ok;
> +
> +	skb_orphan(skb);
> +	skb->sk = req_to_sk(req);
> +	skb->destructor = sock_pfree;
> +
> +	return 0;
> +#else
> +	return -EOPNOTSUPP;
> +#endif
> +}
> +
>   __bpf_kfunc_end_defs();
>   
>   int bpf_dynptr_from_skb_rdonly(struct sk_buff *skb, u64 flags,
> @@ -11844,6 +11932,10 @@ BTF_SET8_START(bpf_kfunc_check_set_sock_addr)
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
> @@ -11859,6 +11951,11 @@ static const struct btf_kfunc_id_set bpf_kfunc_set_sock_addr = {
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
> @@ -11874,8 +11971,9 @@ static int __init bpf_kfunc_init(void)
>   	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_LWT_SEG6LOCAL, &bpf_kfunc_set_skb);
>   	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_NETFILTER, &bpf_kfunc_set_skb);
>   	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &bpf_kfunc_set_xdp);
> -	return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCK_ADDR,
> -						&bpf_kfunc_set_sock_addr);
> +	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCK_ADDR,
> +					       &bpf_kfunc_set_sock_addr);
> +	return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_kfunc_set_tcp_reqsk);
>   }
>   late_initcall(bpf_kfunc_init);
>   
> diff --git a/net/core/sock.c b/net/core/sock.c
> index fef349dd72fa..998950e97dfe 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -2579,8 +2579,18 @@ EXPORT_SYMBOL(sock_efree);
>   #ifdef CONFIG_INET
>   void sock_pfree(struct sk_buff *skb)
>   {
> -	if (sk_is_refcounted(skb->sk))
> -		sock_gen_put(skb->sk);
> +	struct sock *sk = skb->sk;
> +
> +	if (!sk_is_refcounted(sk))
> +		return;
> +
> +	if (sk->sk_state == TCP_NEW_SYN_RECV && inet_reqsk(sk)->syncookie) {
> +		inet_reqsk(sk)->rsk_listener = NULL;
> +		reqsk_free(inet_reqsk(sk));
> +		return;
> +	}
> +
> +	sock_gen_put(sk);
>   }
>   EXPORT_SYMBOL(sock_pfree);
>   #endif /* CONFIG_INET */


