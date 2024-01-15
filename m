Return-Path: <bpf+bounces-19552-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 153A482E162
	for <lists+bpf@lfdr.de>; Mon, 15 Jan 2024 21:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAC701C22203
	for <lists+bpf@lfdr.de>; Mon, 15 Jan 2024 20:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0969C199D3;
	Mon, 15 Jan 2024 20:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Id0pIQvM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A06A199D0;
	Mon, 15 Jan 2024 20:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1705349602; x=1736885602;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EyZsQWag1Okc7cfmCCItZ6l0W8cgMueVfProkneQbSM=;
  b=Id0pIQvMkbIq+QDmlttkS2SYjscZhPELj7rKk2WrhJKNd/u5MtUBmTdM
   JULu8VH1fnE0DNIUCcJUDjqxie21RoAIdWdNgVsfZpg/4wjGWCjpk3FsW
   Iw3g4TnZ6EEhCz8mkVqjXoWJrZOuXtrUIs09aSwuFxtV3WXE8gF3ywWqt
   s=;
X-IronPort-AV: E=Sophos;i="6.04,197,1695686400"; 
   d="scan'208";a="321718437"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-d7759ebe.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2024 20:13:16 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1d-m6i4x-d7759ebe.us-east-1.amazon.com (Postfix) with ESMTPS id 324B44A3E1;
	Mon, 15 Jan 2024 20:13:13 +0000 (UTC)
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:49016]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.61.210:2525] with esmtp (Farcaster)
 id bcae45fc-5982-4853-aeb7-c864dc97260d; Mon, 15 Jan 2024 20:13:13 +0000 (UTC)
X-Farcaster-Flow-ID: bcae45fc-5982-4853-aeb7-c864dc97260d
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 15 Jan 2024 20:13:13 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.170.32) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 15 Jan 2024 20:13:10 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <martin.lau@linux.dev>
CC: <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
	<daniel@iogearbox.net>, <edumazet@google.com>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v7 bpf-next 5/6] bpf: tcp: Support arbitrary SYN Cookie.
Date: Mon, 15 Jan 2024 12:13:01 -0800
Message-ID: <20240115201301.64265-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <aea7e756-9b3a-46b0-af27-207ba306b875@linux.dev>
References: <aea7e756-9b3a-46b0-af27-207ba306b875@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWB002.ant.amazon.com (10.13.139.188) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

From: Martin KaFai Lau <martin.lau@linux.dev>
Date: Thu, 11 Jan 2024 17:44:55 -0800
> On 12/20/23 5:28 PM, Kuniyuki Iwashima wrote:
> > This patch adds a new kfunc available at TC hook to support arbitrary
> > SYN Cookie.
> > 
> > The basic usage is as follows:
> > 
> >      struct bpf_tcp_req_attrs attrs = {
> >          .mss = mss,
> >          .wscale_ok = wscale_ok,
> >          .rcv_wscale = rcv_wscale, /* Server's WScale < 15 */
> >          .snd_wscale = snd_wscale, /* Client's WScale < 15 */
> >          .tstamp_ok = tstamp_ok,
> >          .rcv_tsval = tsval,
> >          .rcv_tsecr = tsecr, /* Server's Initial TSval */
> >          .usec_ts_ok = usec_ts_ok,
> >          .sack_ok = sack_ok,
> >          .ecn_ok = ecn_ok,
> >      }
> > 
> >      skc = bpf_skc_lookup_tcp(...);
> >      sk = (struct sock *)bpf_skc_to_tcp_sock(skc);
> >      bpf_sk_assign_tcp_reqsk(skb, sk, attrs, sizeof(attrs));
> >      bpf_sk_release(skc);
> > 
> > bpf_sk_assign_tcp_reqsk() takes skb, a listener sk, and struct
> > bpf_tcp_req_attrs and allocates reqsk and configures it.  Then,
> > bpf_sk_assign_tcp_reqsk() links reqsk with skb and the listener.
> > 
> > The notable thing here is that we do not hold refcnt for both reqsk
> > and listener.  To differentiate that, we mark reqsk->syncookie, which
> > is only used in TX for now.  So, if reqsk->syncookie is 1 in RX, it
> > means that the reqsk is allocated by kfunc.
> > 
> > When skb is freed, sock_pfree() checks if reqsk->syncookie is 1,
> > and in that case, we set NULL to reqsk->rsk_listener before calling
> > reqsk_free() as reqsk does not hold a refcnt of the listener.
> > 
> > When the TCP stack looks up a socket from the skb, we steal the
> > listener from the reqsk in skb_steal_sock() and create a full sk
> > in cookie_v[46]_check().
> > 
> > The refcnt of reqsk will finally be set to 1 in tcp_get_cookie_sock()
> > after creating a full sk.
> > 
> > Note that we can extend struct bpf_tcp_req_attrs in the future when
> > we add a new attribute that is determined in 3WHS.
> 
> Notice a few final details.
> 
> > 
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > ---
> >   include/net/tcp.h |  13 ++++++
> >   net/core/filter.c | 113 +++++++++++++++++++++++++++++++++++++++++++++-
> >   net/core/sock.c   |  14 +++++-
> >   3 files changed, 136 insertions(+), 4 deletions(-)
> > 
> > diff --git a/include/net/tcp.h b/include/net/tcp.h
> > index a63916f41f77..20619df8819e 100644
> > --- a/include/net/tcp.h
> > +++ b/include/net/tcp.h
> > @@ -600,6 +600,19 @@ static inline bool cookie_ecn_ok(const struct net *net, const struct dst_entry *
> >   }
> >   
> >   #if IS_ENABLED(CONFIG_BPF)
> > +struct bpf_tcp_req_attrs {
> > +	u32 rcv_tsval;
> > +	u32 rcv_tsecr;
> > +	u16 mss;
> > +	u8 rcv_wscale;
> > +	u8 snd_wscale;
> > +	u8 ecn_ok;
> > +	u8 wscale_ok;
> > +	u8 sack_ok;
> > +	u8 tstamp_ok;
> > +	u8 usec_ts_ok;
> 
> Add "u8 reserved[3];" for the 3 bytes tail padding.
> 
> > +};
> > +
> >   static inline bool cookie_bpf_ok(struct sk_buff *skb)
> >   {
> >   	return skb->sk;
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 24061f29c9dd..961c2d30bd72 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -11837,6 +11837,105 @@ __bpf_kfunc int bpf_sock_addr_set_sun_path(struct bpf_sock_addr_kern *sa_kern,
> >   
> >   	return 0;
> >   }
> > +
> > +__bpf_kfunc int bpf_sk_assign_tcp_reqsk(struct sk_buff *skb, struct sock *sk,
> > +					struct bpf_tcp_req_attrs *attrs, int attrs__sz)
> > +{
> > +#if IS_ENABLED(CONFIG_SYN_COOKIES)
> > +	const struct request_sock_ops *ops;
> > +	struct inet_request_sock *ireq;
> > +	struct tcp_request_sock *treq;
> > +	struct request_sock *req;
> > +	struct net *net;
> > +	__u16 min_mss;
> > +	u32 tsoff = 0;
> > +
> > +	if (attrs__sz != sizeof(*attrs))
> > +		return -EINVAL;
> > +
> > +	if (!sk)
> > +		return -EINVAL;
> > +
> > +	if (!skb_at_tc_ingress(skb))
> > +		return -EINVAL;
> > +
> > +	net = dev_net(skb->dev);
> > +	if (net != sock_net(sk))
> > +		return -ENETUNREACH;
> > +
> > +	switch (skb->protocol) {
> > +	case htons(ETH_P_IP):
> > +		ops = &tcp_request_sock_ops;
> > +		min_mss = 536;
> > +		break;
> > +#if IS_BUILTIN(CONFIG_IPV6)
> > +	case htons(ETH_P_IPV6):
> > +		ops = &tcp6_request_sock_ops;
> > +		min_mss = IPV6_MIN_MTU - 60;
> > +		break;
> > +#endif
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (sk->sk_type != SOCK_STREAM || sk->sk_state != TCP_LISTEN ||
> > +	    sk_is_mptcp(sk))
> > +		return -EINVAL;
> > +
> 
> and check for:
> 
> 	if (attrs->reserved[0] || attrs->reserved[1] || attrs->reserved[2])
> 		return -EINVAL;
> 
> It will be safer if it needs to extend "struct bpf_tcp_req_attrs". There is an 
> existing example in __bpf_nf_ct_lookup() when checking the 'struct bpf_ct_opts 
> *opts'.

I'll add that test in v8.

Thank you!

