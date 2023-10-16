Return-Path: <bpf+bounces-12353-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 969457CB62A
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 00:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 318A8281805
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 22:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6BC38F8C;
	Mon, 16 Oct 2023 22:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Ri/GNkth"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7130347AA;
	Mon, 16 Oct 2023 22:03:03 +0000 (UTC)
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C460A2;
	Mon, 16 Oct 2023 15:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1697493783; x=1729029783;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L/dSmXdNxfjyVjizo2pCEKEcYlM8cqjMSI3pDpxoZRg=;
  b=Ri/GNkthq8KjvoNf04X/gY5t3SccYoRUUnPdbRle2WGZLLfFcTTrDvXt
   Ao8UjvU/MCm8sfTr5vMVAW/AGUKvxqrHM7V8Zsp63nAMeWvsbJDH5uW89
   9woXq1ETenFBM+7QfAl4JMYDZKQumsLadsVnmCNrPdfwUkOmgvwTKo8NU
   k=;
X-IronPort-AV: E=Sophos;i="6.03,230,1694736000"; 
   d="scan'208";a="245935877"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-21d8d9f4.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 22:02:59 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2a-m6i4x-21d8d9f4.us-west-2.amazon.com (Postfix) with ESMTPS id 02E6580EC7;
	Mon, 16 Oct 2023 22:02:57 +0000 (UTC)
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:35485]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.209:2525] with esmtp (Farcaster)
 id fee03f79-316a-4ce6-a9a8-7c0fc8854bb7; Mon, 16 Oct 2023 22:02:57 +0000 (UTC)
X-Farcaster-Flow-ID: fee03f79-316a-4ce6-a9a8-7c0fc8854bb7
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Mon, 16 Oct 2023 22:02:47 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.171.29) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Mon, 16 Oct 2023 22:02:43 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <sdf@google.com>
CC: <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
	<daniel@iogearbox.net>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<edumazet@google.com>, <haoluo@google.com>, <john.fastabend@gmail.com>,
	<jolsa@kernel.org>, <kpsingh@kernel.org>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <martin.lau@linux.dev>,
	<mykolal@fb.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<song@kernel.org>, <yonghong.song@linux.dev>
Subject: Re: [PATCH v1 bpf-next 06/11] bpf: tcp: Add SYN Cookie validation SOCK_OPS hook.
Date: Mon, 16 Oct 2023 15:02:35 -0700
Message-ID: <20231016220235.80560-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <ZS2fQXqhjRlG64kZ@google.com>
References: <ZS2fQXqhjRlG64kZ@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.171.29]
X-ClientProxiedBy: EX19D038UWB003.ant.amazon.com (10.13.139.157) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Stanislav Fomichev <sdf@google.com>
Date: Mon, 16 Oct 2023 13:38:25 -0700
> On 10/13, Kuniyuki Iwashima wrote:
> > This patch adds a new SOCK_OPS hook to validate arbitrary SYN Cookie.
> > 
> > When the kernel receives ACK for SYN Cookie, the hook is invoked with
> > bpf_sock_ops.op == BPF_SOCK_OPS_CHECK_SYNCOOKIE_CB if the listener has
> > BPF_SOCK_OPS_SYNCOOKIE_CB_FLAG set by bpf_sock_ops_cb_flags_set().
> > 
> > The BPF program can access the following information to validate ISN:
> > 
> >   bpf_sock_ops.sk      : 4-tuple
> >   bpf_sock_ops.skb     : TCP header
> >   bpf_sock_ops.args[0] : ISN
> > 
> > The program must decode MSS and set it to bpf_sock_ops.replylong[0].
> > 
> > By default, the kernel validates SYN Cookie before allocating reqsk, but
> > the hook is invoked after allocating reqsk to keep the user interface
> > consistent with BPF_SOCK_OPS_GEN_SYNCOOKIE_CB.
> > 
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > ---
> >  include/net/tcp.h              | 12 ++++++
> >  include/uapi/linux/bpf.h       | 20 +++++++---
> >  net/ipv4/syncookies.c          | 73 +++++++++++++++++++++++++++-------
> >  net/ipv6/syncookies.c          | 44 +++++++++++++-------
> >  tools/include/uapi/linux/bpf.h | 20 +++++++---
> >  5 files changed, 130 insertions(+), 39 deletions(-)
> > 
> > diff --git a/include/net/tcp.h b/include/net/tcp.h
> > index 676618c89bb7..90d95acdc34a 100644
> > --- a/include/net/tcp.h
> > +++ b/include/net/tcp.h
> > @@ -2158,6 +2158,18 @@ static inline __u32 cookie_init_sequence(const struct tcp_request_sock_ops *ops,
> >  	__NET_INC_STATS(sock_net(sk), LINUX_MIB_SYNCOOKIESSENT);
> >  	return ops->cookie_init_seq(skb, mss);
> >  }
> > +
> > +#ifdef CONFIG_CGROUP_BPF
> > +int bpf_skops_cookie_check(struct sock *sk, struct request_sock *req,
> > +			   struct sk_buff *skb);
> > +#else
> > +static inline int bpf_skops_cookie_check(struct sock *sk, struct request_sock *req,
> > +					 struct sk_buff *skb)
> > +{
> > +	return 0;
> > +}
> > +#endif
> > +
> >  #else
> >  static inline __u32 cookie_init_sequence(const struct tcp_request_sock_ops *ops,
> >  					 const struct sock *sk, struct sk_buff *skb,
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index d3cc530613c0..e6f1507d7895 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -6738,13 +6738,16 @@ enum {
> >  	 * options first before the BPF program does.
> >  	 */
> >  	BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG = (1<<6),
> > -	/* Call bpf when the kernel generates SYN Cookie (ISN) for SYN+ACK.
> > +	/* Call bpf when the kernel generates SYN Cookie (ISN) for SYN+ACK
> > +	 * and validates ACK for SYN Cookie.
> >  	 *
> > -	 * The bpf prog will be called to encode MSS into SYN Cookie with
> > -	 * sock_ops->op == BPF_SOCK_OPS_GEN_SYNCOOKIE_CB.
> > +	 * The bpf prog will be first called to encode MSS into SYN Cookie
> > +	 * with sock_ops->op == BPF_SOCK_OPS_GEN_SYNCOOKIE_CB.  Then, the
> > +	 * bpf prog will be called to decode MSS from SYN Cookie with
> > +	 * sock_ops->op == BPF_SOCK_OPS_CHECK_SYNCOOKIE_CB.
> >  	 *
> > -	 * Please refer to the comment in BPF_SOCK_OPS_GEN_SYNCOOKIE_CB for
> > -	 * input and output.
> > +	 * Please refer to the comment in BPF_SOCK_OPS_GEN_SYNCOOKIE_CB and
> > +	 * BPF_SOCK_OPS_CHECK_SYNCOOKIE_CB for input and output.
> >  	 */
> >  	BPF_SOCK_OPS_SYNCOOKIE_CB_FLAG = (1<<7),
> >  /* Mask of all currently supported cb flags */
> > @@ -6868,6 +6871,13 @@ enum {
> >  					 *
> >  					 * replylong[0]: ISN
> >  					 */
> > +	BPF_SOCK_OPS_CHECK_SYNCOOKIE_CB,/* Validate SYN Cookie and set
> > +					 * MSS.
> > +					 *
> > +					 * args[0]: ISN
> > +					 *
> > +					 * replylong[0]: MSS
> > +					 */
> >  };
> >  
> >  /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
> > diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
> > index 514f1a4abdee..b1dd415863ff 100644
> > --- a/net/ipv4/syncookies.c
> > +++ b/net/ipv4/syncookies.c
> > @@ -317,6 +317,37 @@ struct request_sock *cookie_tcp_reqsk_alloc(const struct request_sock_ops *ops,
> >  }
> >  EXPORT_SYMBOL_GPL(cookie_tcp_reqsk_alloc);
> >  
> > +#if IS_ENABLED(CONFIG_CGROUP_BPF) && IS_ENABLED(CONFIG_SYN_COOKIES)
> > +int bpf_skops_cookie_check(struct sock *sk, struct request_sock *req, struct sk_buff *skb)
> > +{
> > +	struct bpf_sock_ops_kern sock_ops;
> > +
> > +	memset(&sock_ops, 0, offsetof(struct bpf_sock_ops_kern, temp));
> > +
> > +	sock_ops.op = BPF_SOCK_OPS_CHECK_SYNCOOKIE_CB;
> > +	sock_ops.sk = req_to_sk(req);
> > +	sock_ops.args[0] = tcp_rsk(req)->snt_isn;
> > +
> > +	bpf_skops_init_skb(&sock_ops, skb, tcp_hdrlen(skb));
> > +
> > +	if (BPF_CGROUP_RUN_PROG_SOCK_OPS_SK(&sock_ops, sk))
> > +		goto err;
> > +
> > +	if (!sock_ops.replylong[0])
> > +		goto err;
> > +
> > +	__NET_INC_STATS(sock_net(sk), LINUX_MIB_SYNCOOKIESRECV);
> 
> I don't see LINUX_MIB_SYNCOOKIESSENT being incremented in the
> previous patch, so maybe also don't touch the mib here? The bpf
> program can do the counting if needed?
> 
> Or, alternatively, add LINUX_MIB_SYNCOOKIESSENT to
> the BPF_SOCK_OPS_GEN_SYNCOOKIE_CB path?

Good catch!

I skipped calling tcp_synq_overflow() in the previous patch but should
have incremented LINUX_MIB_SYNCOOKIESSENT.  Will fix in v2.

Thanks!


