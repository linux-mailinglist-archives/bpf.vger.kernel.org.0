Return-Path: <bpf+bounces-13088-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF307D44DE
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 03:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 981B72817C0
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 01:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7AA525B;
	Tue, 24 Oct 2023 01:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="QgTcTdXy"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15E2442F;
	Tue, 24 Oct 2023 01:22:28 +0000 (UTC)
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37C1A1;
	Mon, 23 Oct 2023 18:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1698110547; x=1729646547;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=y+P9TSdbnbPVt6dNtgNwEznrlEpot+BLYyv+xZH6+/8=;
  b=QgTcTdXyOO7hN9dQTaseXmNTmr26uzyiZtZIMAVU2+PtmNZ3Dvzhn06x
   AfNp21chD3wxjmWHZVLsumvPrR0U4kQm21dXqkYoOsy4wtzVhNnHrl/XA
   OvMRhVZ452qMs7526K1jj9Fc+ZRqOipD3LKUNQYAX/Y+vJZsQ+FVnOw6E
   c=;
X-IronPort-AV: E=Sophos;i="6.03,246,1694736000"; 
   d="scan'208";a="615150268"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-83883bdb.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 01:22:24 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2a-m6i4x-83883bdb.us-west-2.amazon.com (Postfix) with ESMTPS id D2179609A3;
	Tue, 24 Oct 2023 01:22:21 +0000 (UTC)
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:18678]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.16.26:2525] with esmtp (Farcaster)
 id 0d5bdd93-4aa3-47e1-95ca-e56723cce65d; Tue, 24 Oct 2023 01:22:21 +0000 (UTC)
X-Farcaster-Flow-ID: 0d5bdd93-4aa3-47e1-95ca-e56723cce65d
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Tue, 24 Oct 2023 01:22:21 +0000
Received: from 88665a182662.ant.amazon.com.com (10.119.77.134) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Tue, 24 Oct 2023 01:22:16 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <sinquersw@gmail.com>
CC: <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
	<daniel@iogearbox.net>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<edumazet@google.com>, <haoluo@google.com>, <john.fastabend@gmail.com>,
	<jolsa@kernel.org>, <kpsingh@kernel.org>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <martin.lau@linux.dev>,
	<mykolal@fb.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<sdf@google.com>, <song@kernel.org>, <yonghong.song@linux.dev>
Subject: Re: [PATCH v1 bpf-next 00/11] bpf: tcp: Add SYN Cookie generation/validation SOCK_OPS hooks.
Date: Mon, 23 Oct 2023 18:22:08 -0700
Message-ID: <20231024012208.82653-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <9aebb3e9-70c5-428c-bc31-7b38a04e4848@gmail.com>
References: <9aebb3e9-70c5-428c-bc31-7b38a04e4848@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.119.77.134]
X-ClientProxiedBy: EX19D042UWB002.ant.amazon.com (10.13.139.175) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

> On 10/23/23 14:35, Martin KaFai Lau wrote:
> > On 10/20/23 11:48 PM, Kuniyuki Iwashima wrote:
> > > I think this was doable.  With the diff below, I was able to skip
> > > validation in cookie_v[46]_check() when if skb->sk is not NULL.
> > > 
> > > The kfunc allocates req and set req->syncookie to 1, which is usually
> > > set in TX path, so if it's 1 in RX (inet_steal_sock()), we can see
> > > that req is allocated by kfunc (at least, req->syncookie &&
> > > req->rsk_listener never be true in the current TCP stack).
> > > 
> > > The difference here is that req allocated by kfunc holds refcnt of
> > > rsk_listener (passing true to inet_reqsk_alloc()) to prevent freeing
> > > the listener until req reaches cookie_v[46]_check().
> > 
> > The cookie_v[46]_check() holds the listener sk refcnt now?
> 
> The caller of cookie_v[46]_check() should hold a refcnt of the listener.

No, it need not.

When we handle the default syn cookie, cookie_tcp_reqsk_alloc() passes
false to inet_reqsk_alloc(), then reqsk does not hold refcnt of the
listener.

If inet_csk_reqsk_queue_add() in tcp_get_cookie_sock() succeeds, we know
the listener is still alive.


> If the listener is destroyed, the callers of cookie_v[46]_check() should
> fail to lookup a sock for the skb. However, in this case, the kfunc sets
> a sock to skb->sk, and the lookup function
> (__inet_lookup_skb()) steals sock from skb. So, there is no guarantee
> ensuring the listener is still alive.
> 
> One solution is let the stealing function to lookup the listener if
> inet_reqsk(skb->sk)->syncookie is true.

kfunc at least guarantees that the listener is not freed until req
is freed.  There's two cases where the listener could be close()d
after kfunc:

  1. close()d before lookup
     -> kfree_skb(skb) calls reqsk_put() and releases the last
        refcnt of the listener

  2. close()d between lookup and inet_csk_reqsk_queue_add()
     -> inet_csk_reqsk_queue_add() fails and __reqsk_free()
        releases the last refcnt of the listener.

So, we need not look up the listener again in inet_steal_sock().


> > 
> >  >
> > > The cookie generation at least should be done at tc/xdp.  The
> > > valdation can be done earlier as well on tc/xdp, but it could
> > > add another complexity, listener's life cycle if we allocate
> > > req there.
> > 
> > I think your code below looks pretty close already.
> > 
> > It seems the only concern/complexity is the extra rsk_listener refcnt (btw the 
> > concern is on performance for the extra refcnt? or there is correctness issue?).

Yes, that's the only concern and I think it's all ok now.

[ I was seeing a weird refcnt warning, but I missed *refcounted was true
  in inet_steal_sock() for reqsk and forgot to flipping it to false :S ]


> > 
> > Asking because bpf_sk_assign() can already assign a listener to skb->sk and it 
> > also does not take a refcnt on the listener. The same no refcnt needed on 
> > req->rsk_listener should be doable also. sock_pfree may need to be smarter to 
> > check req->syncookie. What else may need to change?

I was wondering if we are in the same RCU period between tc and
cookie_v[46]_check(), but yeah, probably sock_pfree() can check
req->syncookie and set NULL to rsk_listener so that reqsk_put()
will not touch the listener.


> > 
> > > 
> > > I'm wondering which place to add the validation capability, and
> > > I think SOCK_OPS is simpler than tc.
> > > 
> > >    #1 validate cookie and allocate req at tc, and skip validation
> > > 
> > >    #2 validate cookie (and update bpf map at xdp/tc, and look up bpf
> > >       map) and allocate req at SOCK_OPS hook
> > > 
> > > Given SYN proxy is usually on the other node and incoming cookie
> > > is almost always valid, we might need not validate it in the early
> > > stage in the stack.
> > > 
> > > What do you think ?
> > 
> > Yeah, supporting validation in sock_ops is an open option if the tc side is too 
> > hard but I feel you are pretty close on the tc side.

Now I think I can go v2 with tc.

Thanks for your guide!


> > 
> > > 
> > > ---8<---
> > > diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.h
> > > index 3ecfeadbfa06..e5e4627bf270 100644
> > > --- a/include/net/inet_hashtables.h
> > > +++ b/include/net/inet_hashtables.h
> > > @@ -462,9 +462,19 @@ struct sock *inet_steal_sock(struct net *net, struct sk_buff *skb, int doff,
> > >   	if (!sk)
> > >   		return NULL;
> > >   
> > > -	if (!prefetched || !sk_fullsock(sk))
> > > +	if (!prefetched)
> > >   		return sk;
> > >   
> > > +	if (!sk_fullsock(sk)) {
> > > +		if (sk->sk_state == TCP_NEW_SYN_RECV && inet_reqsk(sk)->syncookie) {
> > > +			skb->sk = sk;
> > > +			skb->destructor = sock_pfree;
> > > +			sk = inet_reqsk(sk)->rsk_listener;
> > > +		}
> > > +
> > > +		return sk;
> > > +	}
> > > +
> > >   	if (sk->sk_protocol == IPPROTO_TCP) {
> > >   		if (sk->sk_state != TCP_LISTEN)
> > >   			return sk;
> > > diff --git a/net/core/filter.c b/net/core/filter.c
> > > index cc2e4babc85f..bca491ddf42c 100644
> > > --- a/net/core/filter.c
> > > +++ b/net/core/filter.c
> > > @@ -11800,6 +11800,71 @@ __bpf_kfunc int bpf_sock_addr_set_sun_path(struct bpf_sock_addr_kern *sa_kern,
> > >   
> > >   	return 0;
> > >   }
> > > +
> > > +__bpf_kfunc int bpf_sk_assign_tcp_reqsk(struct sk_buff *skb, struct sock *sk,
> > > +					struct tcp_options_received *tcp_opt,
> > > +					int tcp_opt__sz, u16 mss)
> > > +{
> > > +	const struct tcp_request_sock_ops *af_ops;
> > > +	const struct request_sock_ops *ops;
> > > +	struct inet_request_sock *ireq;
> > > +	struct tcp_request_sock *treq;
> > > +	struct request_sock *req;
> > > +
> > > +	if (!sk)
> > > +		return -EINVAL;
> > > +
> > > +	if (!skb_at_tc_ingress(skb))
> > > +		return -EINVAL;
> > > +
> > > +	if (dev_net(skb->dev) != sock_net(sk))
> > > +		return -ENETUNREACH;
> > > +
> > > +	switch (sk->sk_family) {
> > > +	case AF_INET:  /* TODO: MPTCP */
> > > +		ops = &tcp_request_sock_ops;
> > > +		af_ops = &tcp_request_sock_ipv4_ops;
> > > +		break;
> > > +#if IS_ENABLED(CONFIG_IPV6)
> > > +	case AF_INET6:
> > > +		ops = &tcp6_request_sock_ops;
> > > +		af_ops = &tcp_request_sock_ipv6_ops;
> > > +		break;
> > > +#endif
> > > +	default:
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	if (sk->sk_type != SOCK_STREAM || sk->sk_state != TCP_LISTEN)
> > > +		return -EINVAL;
> > > +
> > > +	req = inet_reqsk_alloc(ops, sk, true);
> > > +	if (!req)
> > > +		return -ENOMEM;
> > > +
> > > +	ireq = inet_rsk(req);
> > > +	treq = tcp_rsk(req);
> > > +
> > > +	refcount_set(&req->rsk_refcnt, 1);
> > > +	req->syncookie = 1;
> > > +	req->mss = mss;
> > > +	req->ts_recent = tcp_opt->saw_tstamp ? tcp_opt->rcv_tsval : 0;
> > > +
> > > +	ireq->snd_wscale = tcp_opt->snd_wscale;
> > > +	ireq->sack_ok = tcp_opt->sack_ok;
> > > +	ireq->wscale_ok = tcp_opt->wscale_ok;
> > > +	ireq->tstamp_ok	= tcp_opt->saw_tstamp;
> > > +
> > > +	tcp_rsk(req)->af_specific = af_ops;
> > > +	tcp_rsk(req)->ts_off = tcp_opt->rcv_tsecr - tcp_ns_to_ts(tcp_clock_ns());
> > > +
> > > +	skb_orphan(skb);
> > > +	skb->sk = req_to_sk(req);
> > > +	skb->destructor = sock_pfree;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >   __diag_pop();
> > >   
> > >   int bpf_dynptr_from_skb_rdonly(struct sk_buff *skb, u64 flags,
> > > @@ -11828,6 +11893,10 @@ BTF_SET8_START(bpf_kfunc_check_set_sock_addr)
> > >   BTF_ID_FLAGS(func, bpf_sock_addr_set_sun_path)
> > >   BTF_SET8_END(bpf_kfunc_check_set_sock_addr)
> > >   
> > > +BTF_SET8_START(bpf_kfunc_check_set_tcp_reqsk)
> > > +BTF_ID_FLAGS(func, bpf_sk_assign_tcp_reqsk)
> > > +BTF_SET8_END(bpf_kfunc_check_set_tcp_reqsk)
> > > +
> > >   static const struct btf_kfunc_id_set bpf_kfunc_set_skb = {
> > >   	.owner = THIS_MODULE,
> > >   	.set = &bpf_kfunc_check_set_skb,
> > > @@ -11843,6 +11912,11 @@ static const struct btf_kfunc_id_set bpf_kfunc_set_sock_addr = {
> > >   	.set = &bpf_kfunc_check_set_sock_addr,
> > >   };
> > >   
> > > +static const struct btf_kfunc_id_set bpf_kfunc_set_tcp_reqsk = {
> > > +	.owner = THIS_MODULE,
> > > +	.set = &bpf_kfunc_check_set_tcp_reqsk,
> > > +};
> > > +
> > >   static int __init bpf_kfunc_init(void)
> > >   {
> > >   	int ret;
> > > @@ -11858,8 +11932,10 @@ static int __init bpf_kfunc_init(void)
> > >   	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_LWT_SEG6LOCAL, &bpf_kfunc_set_skb);
> > >   	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_NETFILTER, &bpf_kfunc_set_skb);
> > >   	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &bpf_kfunc_set_xdp);
> > > -	return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCK_ADDR,
> > > -						&bpf_kfunc_set_sock_addr);
> > > +	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCK_ADDR,
> > > +					       &bpf_kfunc_set_sock_addr);
> > > +	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_kfunc_set_tcp_reqsk);
> > > +	return ret;
> > >   }
> > >   late_initcall(bpf_kfunc_init);
> > >   
> > > ---8<---

