Return-Path: <bpf+bounces-16840-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1121D806426
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 02:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 427561C20DA2
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 01:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD2310EC;
	Wed,  6 Dec 2023 01:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ZqCAe3W2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F291B9;
	Tue,  5 Dec 2023 17:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1701826225; x=1733362225;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VmwbFzgQc683/Km1kXUxblbm3uj2GMRfIZtyMCZbTXU=;
  b=ZqCAe3W2S9XNRU3Ll37bYAlV6GsiDVnzI6+olCxhnPPxemK1OIfprayn
   aDfWWHQcYlBdfp+iWxLosmDTjQWi4MUjYYWEb6Vz0P61XGWNdPxHDOMBx
   J9EQKabfHugJKuOKyDCK3QroTcfs93FDlxY2rNK2GgKiDcVX2W7pY106m
   I=;
X-IronPort-AV: E=Sophos;i="6.04,254,1695686400"; 
   d="scan'208";a="48659072"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-e651a362.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 01:30:22 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
	by email-inbound-relay-iad-1d-m6i4x-e651a362.us-east-1.amazon.com (Postfix) with ESMTPS id 176E5804F5;
	Wed,  6 Dec 2023 01:30:20 +0000 (UTC)
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:44813]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.6.101:2525] with esmtp (Farcaster)
 id 37ef6114-7268-42c9-88f9-80743902ad9e; Wed, 6 Dec 2023 01:30:20 +0000 (UTC)
X-Farcaster-Flow-ID: 37ef6114-7268-42c9-88f9-80743902ad9e
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 6 Dec 2023 01:30:19 +0000
Received: from 88665a182662.ant.amazon.com (10.119.13.242) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 6 Dec 2023 01:30:08 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <martin.lau@linux.dev>
CC: <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
	<daniel@iogearbox.net>, <edumazet@google.com>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v4 bpf-next 1/3] bpf: tcp: Handle BPF SYN Cookie in cookie_v[46]_check().
Date: Wed, 6 Dec 2023 10:29:52 +0900
Message-ID: <20231206012952.18761-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <8bd1d595-4bb3-44d1-a9c3-2d9c0c960bcb@linux.dev>
References: <8bd1d595-4bb3-44d1-a9c3-2d9c0c960bcb@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWA004.ant.amazon.com (10.13.139.56) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

From: Martin KaFai Lau <martin.lau@linux.dev>
Date: Tue, 5 Dec 2023 16:19:20 -0800
> On 12/4/23 5:34 PM, Kuniyuki Iwashima wrote:
> > diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
> > index 61f1c96cfe63..0f9c3aed2014 100644
> > --- a/net/ipv4/syncookies.c
> > +++ b/net/ipv4/syncookies.c
> > @@ -304,6 +304,59 @@ static int cookie_tcp_reqsk_init(struct sock *sk, struct sk_buff *skb,
> >   	return 0;
> >   }
> >   
> > +#if IS_ENABLED(CONFIG_BPF)
> > +struct request_sock *cookie_bpf_check(struct net *net, struct sock *sk,
> > +				      struct sk_buff *skb)
> > +{
> > +	struct request_sock *req = inet_reqsk(skb->sk);
> > +	struct inet_request_sock *ireq = inet_rsk(req);
> > +	struct tcp_request_sock *treq = tcp_rsk(req);
> > +	struct tcp_options_received tcp_opt;
> > +	int ret;
> > +
> > +	skb->sk = NULL;
> > +	skb->destructor = NULL;
> > +	req->rsk_listener = NULL;
> > +
> > +	memset(&tcp_opt, 0, sizeof(tcp_opt));
> > +	tcp_parse_options(net, skb, &tcp_opt, 0, NULL);
> 
> In patch 2, the bpf prog is passing the tcp_opt to the kfunc. The selftest in 
> patch 3 is also parsing the tcp-options.
> 
> The kernel parses the tcp-option here again to do some checking and req's member 
> initialization. Can these checking and initialization be done in the 
> bpf_sk_assign_tcp_reqsk() kfunc instead to avoid the double tcp-option parsing?

If TS is not used as a cookie storage, bpf prog need not parse it.
OTOH, if a value is encoded into TS, bpf prog need to parse it.
In that case, we cannot avoid parsing options in bpf prog.

The parsing here comes from my paranoia, so.. probably we can drop it
and the first test below, and rely on bpf prog's tcp_opt, especially
tstamp_ok, rcv_tsval, and rcv_tsecr ?

I placed other tests here to align with the normal cookie flow, but
they can be moved to kfunc.  However, initialisation assuems skb
points to TCP header, so here would be better place, I think.


> 
> > +
> > +	if (ireq->tstamp_ok ^ tcp_opt.saw_tstamp) {
> > +		__NET_INC_STATS(net, LINUX_MIB_SYNCOOKIESFAILED);
> > +		goto reset;
> > +	}
> > +
> > +	__NET_INC_STATS(net, LINUX_MIB_SYNCOOKIESRECV);
> > +
> > +	if (ireq->tstamp_ok) {
> > +		if (!READ_ONCE(net->ipv4.sysctl_tcp_timestamps))
> > +			goto reset;
> > +
> > +		req->ts_recent = tcp_opt.rcv_tsval;
> > +		treq->ts_off = tcp_opt.rcv_tsecr - tcp_ns_to_ts(false, tcp_clock_ns());
> > +	}
> > +
> > +	if (ireq->sack_ok && !READ_ONCE(net->ipv4.sysctl_tcp_sack))
> > +		goto reset;
> > +
> > +	if (ireq->wscale_ok && !READ_ONCE(net->ipv4.sysctl_tcp_window_scaling))
> > +		goto reset;
> > +
> > +	ret = cookie_tcp_reqsk_init(sk, skb, req);
> > +	if (ret) {
> > +		reqsk_free(req);
> > +		req = NULL;
> > +	}
> > +
> > +	return req;
> > +
> > +reset:
> > +	reqsk_free(req);
> > +	return ERR_PTR(-EINVAL);
> > +}
> > +EXPORT_SYMBOL_GPL(cookie_bpf_check);
> > +#endif

