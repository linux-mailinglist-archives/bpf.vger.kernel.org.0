Return-Path: <bpf+bounces-12894-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 731E57D1B68
	for <lists+bpf@lfdr.de>; Sat, 21 Oct 2023 08:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE43BB21416
	for <lists+bpf@lfdr.de>; Sat, 21 Oct 2023 06:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38FE6FB1;
	Sat, 21 Oct 2023 06:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="wGf7PJxG"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A42E111A;
	Sat, 21 Oct 2023 06:48:24 +0000 (UTC)
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4D313E;
	Fri, 20 Oct 2023 23:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1697870900; x=1729406900;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K2rketWq3v9JoqPTwJTCBLlkrdDkoZxgpwNt064ngFY=;
  b=wGf7PJxGfuMQuqRK4zBO9SlMTqyczUaKTRiLvV28dKpjaILBWeewZd02
   3E5CDvnegVBTu2Oh8N64p8pw++EEU+1r/oX06ZtlFr0Mfi3qKThlci05c
   Oi06/A/6qfF8gojntnRX3DjIlTKCXWjzl3dg+EvYEkovU3Qq68jd/ZSZr
   U=;
X-IronPort-AV: E=Sophos;i="6.03,240,1694736000"; 
   d="scan'208";a="590293178"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-83883bdb.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2023 06:48:16 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2a-m6i4x-83883bdb.us-west-2.amazon.com (Postfix) with ESMTPS id A23C960CAC;
	Sat, 21 Oct 2023 06:48:14 +0000 (UTC)
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:59548]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.48.147:2525] with esmtp (Farcaster)
 id 7d5f03c4-9b3f-455a-99a3-eb39c912c736; Sat, 21 Oct 2023 06:48:14 +0000 (UTC)
X-Farcaster-Flow-ID: 7d5f03c4-9b3f-455a-99a3-eb39c912c736
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Sat, 21 Oct 2023 06:48:13 +0000
Received: from 88665a182662.ant.amazon.com.com (10.142.223.91) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Sat, 21 Oct 2023 06:48:09 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuniyu@amazon.com>
CC: <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
	<daniel@iogearbox.net>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<edumazet@google.com>, <haoluo@google.com>, <john.fastabend@gmail.com>,
	<jolsa@kernel.org>, <kpsingh@kernel.org>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <martin.lau@linux.dev>, <mykolal@fb.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <sdf@google.com>,
	<sinquersw@gmail.com>, <song@kernel.org>, <yonghong.song@linux.dev>
Subject: Re: [PATCH v1 bpf-next 00/11] bpf: tcp: Add SYN Cookie generation/validation SOCK_OPS hooks.
Date: Fri, 20 Oct 2023 23:48:01 -0700
Message-ID: <20231021064801.87816-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231020231003.51313-1-kuniyu@amazon.com>
References: <20231020231003.51313-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.142.223.91]
X-ClientProxiedBy: EX19D039UWA003.ant.amazon.com (10.13.139.49) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

From: Kuniyuki Iwashima <kuniyu@amazon.com>
Date: Fri, 20 Oct 2023 16:10:03 -0700
> From: Martin KaFai Lau <martin.lau@linux.dev>
> Date: Fri, 20 Oct 2023 12:59:00 -0700
> > On 10/19/23 11:01 AM, Kuniyuki Iwashima wrote:
> > > From: Martin KaFai Lau <martin.lau@linux.dev>
> > > Date: Thu, 19 Oct 2023 00:25:00 -0700
> > >> On 10/18/23 3:31 PM, Kuniyuki Iwashima wrote:
> > >>> From: Kui-Feng Lee <sinquersw@gmail.com>
> > >>> Date: Wed, 18 Oct 2023 14:47:43 -0700
> > >>>> On 10/18/23 10:20, Kuniyuki Iwashima wrote:
> > >>>>> From: Eric Dumazet <edumazet@google.com>
> > >>>>> Date: Wed, 18 Oct 2023 10:02:51 +0200
> > >>>>>> On Wed, Oct 18, 2023 at 8:19 AM Martin KaFai Lau <martin.lau@linux.dev> wrote:
> > >>>>>>>
> > >>>>>>> On 10/17/23 9:48 AM, Kuniyuki Iwashima wrote:
> > >>>>>>>> From: Martin KaFai Lau <martin.lau@linux.dev>
> > >>>>>>>> Date: Mon, 16 Oct 2023 22:53:15 -0700
> > >>>>>>>>> On 10/13/23 3:04 PM, Kuniyuki Iwashima wrote:
> > >>>>>>>>>> Under SYN Flood, the TCP stack generates SYN Cookie to remain stateless
> > >>>>>>>>>> After 3WHS, the proxy restores SYN and forwards it and ACK to the backend
> > >>>>>>>>>> server.  Our kernel module works at Netfilter input/output hooks and first
> > >>>>>>>>>> feeds SYN to the TCP stack to initiate 3WHS.  When the module is triggered
> > >>>>>>>>>> for SYN+ACK, it looks up the corresponding request socket and overwrites
> > >>>>>>>>>> tcp_rsk(req)->snt_isn with the proxy's cookie.  Then, the module can
> > >>>>>>>>>> complete 3WHS with the original ACK as is.
> > >>>>>>>>>
> > >>>>>>>>> Does the current kernel module also use the timestamp bits differently?
> > >>>>>>>>> (something like patch 8 and patch 10 trying to do)
> > >>>>>>>>
> > >>>>>>>> Our SYN Proxy uses TS as is.  The proxy nodes generate a random number
> > >>>>>>>> if TS is in SYN.
> > >>>>>>>>
> > >>>>>>>> But I thought someone would suggest making TS available so that we can
> > >>>>>>>> mock the default behaviour at least, and it would be more acceptable.
> > >>>>>>>>
> > >>>>>>>> The selftest uses TS just to strengthen security by validating 32-bits
> > >>>>>>>> hash.  Dropping a part of hash makes collision easier to happen, but
> > >>>>>>>> 24-bits were sufficient for us to reduce SYN flood to the managable
> > >>>>>>>> level at the backend.
> > >>>>>>>
> > >>>>>>> While enabling bpf to customize the syncookie (and timestamp), I want to explore
> > >>>>>>> where can this also be done other than at the tcp layer.
> > >>>>>>>
> > >>>>>>> Have you thought about directly sending the SYNACK back at a lower layer like
> > >>>>>>> tc/xdp after receiving the SYN?
> > >>>>>
> > >>>>> Yes.  Actually, at netconf I mentioned the cookie generation hook will not
> > >>>>> be necessary and should be replaced with XDP.
> > >>
> > >> Right, it is also what I have been thinking when seeing the
> > >> BPF_SOCK_OPS_GEN_SYNCOOKIE_CB carrying the bpf generated timestamp to the
> > >> tcp_make_synack. It feels like trying hard to work with the tcp want_cookie
> > >> logic while there is an existing better alternative in tc/xdp to deal with synflood.
> > >>
> > >>>>>
> > >>>>>
> > >>>>>>> There are already bpf_tcp_{gen,check}_syncookie
> > >>>>>>> helper that allows to do this for the performance reason to absorb synflood. It
> > >>>>>>> will be natural to extend it to handle the customized syncookie also.
> > >>>>>
> > >>>>> Maybe we even need not extend it and can use XDP as said below.
> > >>>>>
> > >>>>>
> > >>>>>>>
> > >>>>>>> I think it should already be doable to send a SYNACK back with customized
> > >>>>>>> syncookie (and timestamp) at tc/xdp today.
> > >>>>>>>
> > >>>>>>> When ack is received, the prog@tc/xdp can verify the cookie. It will probably
> > >>>>>>> need some new kfuncs to create the ireq and queue the child socket. The bpf prog
> > >>>>>>> can change the ireq->{snd_wscale, sack_ok...} if needed. The details of the
> > >>>>>>> kfuncs need some more thoughts. I think most of the bpf-side infra is ready,
> > >>>>>>> e.g. acquire/release/ref-tracking...etc.
> > >>>>>>>
> > >>>>>>
> > >>>>>> I think I mostly agree with this.
> > >>>>>
> > >>>>> I didn't come up with kfunc to create ireq and queue it to listener, so
> > >>>>> cookie_v[46]_check() were best place for me to extend easily, but now it
> > >>>>> sounds like kfunc would be the way to go.
> > >>>>>
> > >>>>> Maybe we can move the core part of cookie_v[46]_check() except for kernel
> > >>>>> cookie's validation to __cookie_v[46]_check() and expose a wrapper of it
> > >>>>> as kfunc ?
> > >>>>>
> > >>>>> Then, we can look up sk and pass the listener, skb, and flags (for sack_ok,
> > >>>>> etc) to the kfunc.  (It could still introduce some conflicts with Eric's
> > >>>>> patch though...)
> > >>>>
> > >>>> Does that mean the packets handled in this way (in XDP) will skip all
> > >>>> netfilter at all?
> > >>>
> > >>> Good point.
> > >>>
> > >>> If we want not to skip other layers, maybe we can use tc ?
> > >>>
> > >>> 1) allocate ireq and set sack_ok etc with kfunc
> > >>> 2) bpf_sk_assign() to set ireq to skb (this could be done in kfunc above)
> > >>> 3) let inet_steal_sock() return req->sk_listener if not sk_fullsock(sk)
> > >>> 4) if skb->sk is reqsk in cookie_v[46]_check(), skip validation and
> > >>>      req allocation and create full sk

I think this was doable.  With the diff below, I was able to skip
validation in cookie_v[46]_check() when if skb->sk is not NULL.

The kfunc allocates req and set req->syncookie to 1, which is usually
set in TX path, so if it's 1 in RX (inet_steal_sock()), we can see
that req is allocated by kfunc (at least, req->syncookie &&
req->rsk_listener never be true in the current TCP stack).

The difference here is that req allocated by kfunc holds refcnt of
rsk_listener (passing true to inet_reqsk_alloc()) to prevent freeing
the listener until req reaches cookie_v[46]_check().

The cookie generation at least should be done at tc/xdp.  The
valdation can be done earlier as well on tc/xdp, but it could
add another complexity, listener's life cycle if we allocate
req there.

I'm wondering which place to add the validation capability, and
I think SOCK_OPS is simpler than tc.

  #1 validate cookie and allocate req at tc, and skip validation

  #2 validate cookie (and update bpf map at xdp/tc, and look up bpf
     map) and allocate req at SOCK_OPS hook

Given SYN proxy is usually on the other node and incoming cookie
is almost always valid, we might need not validate it in the early
stage in the stack.

What do you think ?

---8<---
diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.h
index 3ecfeadbfa06..e5e4627bf270 100644
--- a/include/net/inet_hashtables.h
+++ b/include/net/inet_hashtables.h
@@ -462,9 +462,19 @@ struct sock *inet_steal_sock(struct net *net, struct sk_buff *skb, int doff,
 	if (!sk)
 		return NULL;
 
-	if (!prefetched || !sk_fullsock(sk))
+	if (!prefetched)
 		return sk;
 
+	if (!sk_fullsock(sk)) {
+		if (sk->sk_state == TCP_NEW_SYN_RECV && inet_reqsk(sk)->syncookie) {
+			skb->sk = sk;
+			skb->destructor = sock_pfree;
+			sk = inet_reqsk(sk)->rsk_listener;
+		}
+
+		return sk;
+	}
+
 	if (sk->sk_protocol == IPPROTO_TCP) {
 		if (sk->sk_state != TCP_LISTEN)
 			return sk;
diff --git a/net/core/filter.c b/net/core/filter.c
index cc2e4babc85f..bca491ddf42c 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -11800,6 +11800,71 @@ __bpf_kfunc int bpf_sock_addr_set_sun_path(struct bpf_sock_addr_kern *sa_kern,
 
 	return 0;
 }
+
+__bpf_kfunc int bpf_sk_assign_tcp_reqsk(struct sk_buff *skb, struct sock *sk,
+					struct tcp_options_received *tcp_opt,
+					int tcp_opt__sz, u16 mss)
+{
+	const struct tcp_request_sock_ops *af_ops;
+	const struct request_sock_ops *ops;
+	struct inet_request_sock *ireq;
+	struct tcp_request_sock *treq;
+	struct request_sock *req;
+
+	if (!sk)
+		return -EINVAL;
+
+	if (!skb_at_tc_ingress(skb))
+		return -EINVAL;
+
+	if (dev_net(skb->dev) != sock_net(sk))
+		return -ENETUNREACH;
+
+	switch (sk->sk_family) {
+	case AF_INET:  /* TODO: MPTCP */
+		ops = &tcp_request_sock_ops;
+		af_ops = &tcp_request_sock_ipv4_ops;
+		break;
+#if IS_ENABLED(CONFIG_IPV6)
+	case AF_INET6:
+		ops = &tcp6_request_sock_ops;
+		af_ops = &tcp_request_sock_ipv6_ops;
+		break;
+#endif
+	default:
+		return -EINVAL;
+	}
+
+	if (sk->sk_type != SOCK_STREAM || sk->sk_state != TCP_LISTEN)
+		return -EINVAL;
+
+	req = inet_reqsk_alloc(ops, sk, true);
+	if (!req)
+		return -ENOMEM;
+
+	ireq = inet_rsk(req);
+	treq = tcp_rsk(req);
+
+	refcount_set(&req->rsk_refcnt, 1);
+	req->syncookie = 1;
+	req->mss = mss;
+	req->ts_recent = tcp_opt->saw_tstamp ? tcp_opt->rcv_tsval : 0;
+
+	ireq->snd_wscale = tcp_opt->snd_wscale;
+	ireq->sack_ok = tcp_opt->sack_ok;
+	ireq->wscale_ok = tcp_opt->wscale_ok;
+	ireq->tstamp_ok	= tcp_opt->saw_tstamp;
+
+	tcp_rsk(req)->af_specific = af_ops;
+	tcp_rsk(req)->ts_off = tcp_opt->rcv_tsecr - tcp_ns_to_ts(tcp_clock_ns());
+
+	skb_orphan(skb);
+	skb->sk = req_to_sk(req);
+	skb->destructor = sock_pfree;
+
+	return 0;
+}
+
 __diag_pop();
 
 int bpf_dynptr_from_skb_rdonly(struct sk_buff *skb, u64 flags,
@@ -11828,6 +11893,10 @@ BTF_SET8_START(bpf_kfunc_check_set_sock_addr)
 BTF_ID_FLAGS(func, bpf_sock_addr_set_sun_path)
 BTF_SET8_END(bpf_kfunc_check_set_sock_addr)
 
+BTF_SET8_START(bpf_kfunc_check_set_tcp_reqsk)
+BTF_ID_FLAGS(func, bpf_sk_assign_tcp_reqsk)
+BTF_SET8_END(bpf_kfunc_check_set_tcp_reqsk)
+
 static const struct btf_kfunc_id_set bpf_kfunc_set_skb = {
 	.owner = THIS_MODULE,
 	.set = &bpf_kfunc_check_set_skb,
@@ -11843,6 +11912,11 @@ static const struct btf_kfunc_id_set bpf_kfunc_set_sock_addr = {
 	.set = &bpf_kfunc_check_set_sock_addr,
 };
 
+static const struct btf_kfunc_id_set bpf_kfunc_set_tcp_reqsk = {
+	.owner = THIS_MODULE,
+	.set = &bpf_kfunc_check_set_tcp_reqsk,
+};
+
 static int __init bpf_kfunc_init(void)
 {
 	int ret;
@@ -11858,8 +11932,10 @@ static int __init bpf_kfunc_init(void)
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_LWT_SEG6LOCAL, &bpf_kfunc_set_skb);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_NETFILTER, &bpf_kfunc_set_skb);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &bpf_kfunc_set_xdp);
-	return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCK_ADDR,
-						&bpf_kfunc_set_sock_addr);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCK_ADDR,
+					       &bpf_kfunc_set_sock_addr);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_kfunc_set_tcp_reqsk);
+	return ret;
 }
 late_initcall(bpf_kfunc_init);
 
---8<---


> > >>
> > >> Haven't looked at the details. The above feels reasonable and would be nice if
> > >> it works out. don't know if the skb at tc can be used in cookie_v[46]_check() as
> > >> is. It probably needs more thoughts.  [ note, xdp does not have skb. ]
> > >>
> > >> Regarding the "allocate ireq and set sack_ok etc with kfunc", do you think it
> > >> will be useful (and potentially cleaner) even for the
> > >> BPF_SOCK_OPS_CHECK_SYNCOOKIE_CB if it needed to go back to consider skops? Then
> > >> only do the BPF_SOCK_OPS_CHECK_SYNCOOKIE_CB and the xdp/tc can generate SYNACK.
> > >> The xdp/tc can still do the check and drop the bad ACK earlier in the stack.
> > > 
> > > kfunc would be useful if we want to fall back to the default
> > > validation, but I think we should not allocate ireq in kfunc.
> > > 
> > > The SOCK_OPS prog only returns a binary value.  If we decide whether
> > > we skip validation or not based on kfunc call (ireq allocation), the
> > > flow would be like :
> > > 
> > >    1. CG_OK & ireq is allocated -> skip validation and req allocation
> > >    2. CG_OK & no ireq           -> default validation
> > >    3. CG_ERR                    -> RST
> > > 
> > > The problem here is that if kfunc fails with -ENOMEM and cookie
> > > is valid, we need a way to tell the kernel to drop the ACK instead
> > > of sending RST.  (I hope the prog could return CG_DROP...)
> > 
> > bpf_set_retval() helper allows the cgrp bpf prog to return -ENOMEM. Take a look 
> > at how __cgroup_bpf_run_filter_getsockopt is using the return value of 
> > bpf_prog_run_array_cg() and an example in progs/cgroup_getset_retval_getsockopt.c.
> 
> Oh, this is nice, I assumed -EPERM was always returned.
> 
> 
> > > If we allocate ireq first, it would be cleaner as bpf need not care
> > > about the drop path.
> > > 
> > >    1. CG_OK & mss is set -> skip validation
> > >    2. CG_OK & no mss set -> default validation
> > >    3. CG_ERR             -> RST
> > 
> > Even if it uses the mss set/not-set like above to decide drop/rst. Does it 
> > really need to pre-allocate ireq? Looking at the test, the bpf prog is not using 
> > the skops->sk either.
> 
> It uses skops->remote_ip4 etc, maybe this was another reason why
> I chose pre-alloc, but yes, it's not needed.  The same value can
> be extraced from skb with bpf_skb_load_bytes_relative(BPF_HDR_START_NET).
> 
> 
> > It would be nice to allow bpf prog to check the cookie first before creating 
> > ireq. The kernel also checks the cookie first before tcp_parse_option and ireq 
> > creation. Beside, I suspect the multiple "if ([!]bpf_cookie)" checks in 
> > cookie_v[46]_check() is due to the pre-alloc ireq requirement.
> > 
> > What does it take to create an ireq? sk, skb, tcp_opt, and mss? Potentially, it 
> > could have a "bpf_skops_parse_tcp_options(struct bpf_sock_ops_kern *skops, 
> > struct tcp_options_received *opt_rx, u32 opt_rx__sz)" to initialize the tcp_opt. 
> > I think the bpf prog should be able to parse the tcp options by itself also and 
> > directly initialize the tcp_opt.
> 
> Yes, also the prog will not need to parse all the options unless
> the validation algorithm needs to becaues SACK_PERMITTED, WSCALE,
> MSS (and ECN bits) are only available in SYN.
> 
> So, the prog will just need to parse timestamps option with
> bpf_load_hdr_opt() and can initialise tcp_opt based on ISN
> (and/or TS).
> 
> 
> > The "bpf_skops_alloc_tcp_req(struct bpf_sock_ops_kern *skops, struct 
> > tcp_options_received *opt_rx, u32 opt_rx__size, int mss,...)" could directly 
> > save the "ireq" in skops->ireq (new member). If skops->ireq is available, the 
> > kernel could then skip most of the ireq initialization and directly continue the 
> > remaining processing (e.g. directly to security_inet_conn_request() ?). would 
> > that work?
> 
> Yes, that will work.

