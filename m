Return-Path: <bpf+bounces-16852-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A168D8066D8
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 06:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D669281E82
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 05:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C481096A;
	Wed,  6 Dec 2023 05:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="A5+x/R5Q"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC71F18F;
	Tue,  5 Dec 2023 21:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1701842335; x=1733378335;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Jiid3VnmgO38FuDauqCHNE+JsaMyjWrVFplJsd8HSpk=;
  b=A5+x/R5Qf9Hz0bjoLDd+qf2MKYttoghSudBUT4WstlG1zZTkVsGiuArZ
   g712ZkzW9FUtaopidMnCkZh8NgcFSzCkc1CYVclIoj60+pq5xYer/r6+G
   pnoALrEssIE4f/dHRA2lR2qplflTg6JM3FHCm2oUjUtzUEiPj3j4ky3D0
   E=;
X-IronPort-AV: E=Sophos;i="6.04,254,1695686400"; 
   d="scan'208";a="372081276"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-94edd59b.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 05:58:53 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan3.pdx.amazon.com [10.39.38.70])
	by email-inbound-relay-pdx-2c-m6i4x-94edd59b.us-west-2.amazon.com (Postfix) with ESMTPS id 6DA5440DBC;
	Wed,  6 Dec 2023 05:58:50 +0000 (UTC)
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:30386]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.56.214:2525] with esmtp (Farcaster)
 id 74751930-acda-40ce-8760-80c1a50a4208; Wed, 6 Dec 2023 05:58:49 +0000 (UTC)
X-Farcaster-Flow-ID: 74751930-acda-40ce-8760-80c1a50a4208
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 6 Dec 2023 05:58:44 +0000
Received: from 88665a182662.ant.amazon.com.com (10.119.13.242) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 6 Dec 2023 05:58:40 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <martin.lau@linux.dev>
CC: <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
	<daniel@iogearbox.net>, <edumazet@google.com>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v4 bpf-next 1/3] bpf: tcp: Handle BPF SYN Cookie in cookie_v[46]_check().
Date: Wed, 6 Dec 2023 14:58:31 +0900
Message-ID: <20231206055831.37584-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <48a54674-3e96-4a35-89d9-d726608fb8c5@linux.dev>
References: <48a54674-3e96-4a35-89d9-d726608fb8c5@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWB004.ant.amazon.com (10.13.139.164) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

From: Martin KaFai Lau <martin.lau@linux.dev>
Date: Tue, 5 Dec 2023 19:11:17 -0800
> On 12/5/23 5:29 PM, Kuniyuki Iwashima wrote:
> > From: Martin KaFai Lau <martin.lau@linux.dev>
> > Date: Tue, 5 Dec 2023 16:19:20 -0800
> >> On 12/4/23 5:34 PM, Kuniyuki Iwashima wrote:
> >>> diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
> >>> index 61f1c96cfe63..0f9c3aed2014 100644
> >>> --- a/net/ipv4/syncookies.c
> >>> +++ b/net/ipv4/syncookies.c
> >>> @@ -304,6 +304,59 @@ static int cookie_tcp_reqsk_init(struct sock *sk, struct sk_buff *skb,
> >>>    	return 0;
> >>>    }
> >>>    
> >>> +#if IS_ENABLED(CONFIG_BPF)
> >>> +struct request_sock *cookie_bpf_check(struct net *net, struct sock *sk,
> >>> +				      struct sk_buff *skb)
> >>> +{
> >>> +	struct request_sock *req = inet_reqsk(skb->sk);
> >>> +	struct inet_request_sock *ireq = inet_rsk(req);
> >>> +	struct tcp_request_sock *treq = tcp_rsk(req);
> >>> +	struct tcp_options_received tcp_opt;
> >>> +	int ret;
> >>> +
> >>> +	skb->sk = NULL;
> >>> +	skb->destructor = NULL;
> >>> +	req->rsk_listener = NULL;
> >>> +
> >>> +	memset(&tcp_opt, 0, sizeof(tcp_opt));
> >>> +	tcp_parse_options(net, skb, &tcp_opt, 0, NULL);
> >>
> >> In patch 2, the bpf prog is passing the tcp_opt to the kfunc. The selftest in
> >> patch 3 is also parsing the tcp-options.
> >>
> >> The kernel parses the tcp-option here again to do some checking and req's member
> >> initialization. Can these checking and initialization be done in the
> >> bpf_sk_assign_tcp_reqsk() kfunc instead to avoid the double tcp-option parsing?
> > 
> > If TS is not used as a cookie storage, bpf prog need not parse it.
> > OTOH, if a value is encoded into TS, bpf prog need to parse it.
> > In that case, we cannot avoid parsing options in bpf prog.
> 
> If I read patch 2 correctly, the ireq->tstamp_ok is set by the kfunc, so I 
> assume that the bpf prog has to parse the tcp-option.
> 
> Like the "if (ireq->tstamp_ok ^ tcp_opt.saw_tstamp)" test below, ireq->tstamp_ok 
> will always be 0 if the bpf prog did not parse the tcp-option.

Ah sorry, I assumed TS bit was encoded in SYN as disabled.
TCP option parsing is needed at least once for SYN, but we
need not do so for SYN+ACK if TS bit is in ISN.


> 
> > 
> > The parsing here comes from my paranoia, so.. probably we can drop it
> > and the first test below, and rely on bpf prog's tcp_opt, especially
> > tstamp_ok, rcv_tsval, and rcv_tsecr ?
> 
> My preference is that it is clearer to allow the bpf prog to initialize all 
> tcp_opt instead of only taking the tcp_opt.tstamp_ok from bpf_prog but ignore 
> the tcp_opt.rcv_tsval/tsecr. The kfunc will then use the tcp_opt to initialize 
> the req.

I'll drop the option parsing in kernel and allow bpf prog to fully
initialise tcp_opt.


> 
> It is also better to detect the following error cases as much as possible in the 
> kfunc instead of failing later in the tcp stack. e.g. checking the sysctl should 
> be doable in the kfunc.

Ok, I'll move the sysctl tests and ts_off init to kfunc.


> 
> > 
> > I placed other tests here to align with the normal cookie flow, but
> > they can be moved to kfunc.  However, initialisation assuems skb
> > points to TCP header, so here would be better place, I think.
> > 
> > 
> >>
> >>> +
> >>> +	if (ireq->tstamp_ok ^ tcp_opt.saw_tstamp) {
> >>> +		__NET_INC_STATS(net, LINUX_MIB_SYNCOOKIESFAILED);
> >>> +		goto reset;
> >>> +	}
> >>> +
> >>> +	__NET_INC_STATS(net, LINUX_MIB_SYNCOOKIESRECV);
> >>> +
> >>> +	if (ireq->tstamp_ok) {
> >>> +		if (!READ_ONCE(net->ipv4.sysctl_tcp_timestamps))
> >>> +			goto reset;
> >>> +
> >>> +		req->ts_recent = tcp_opt.rcv_tsval;
> >>> +		treq->ts_off = tcp_opt.rcv_tsecr - tcp_ns_to_ts(false, tcp_clock_ns());
> >>> +	}
> >>> +
> >>> +	if (ireq->sack_ok && !READ_ONCE(net->ipv4.sysctl_tcp_sack))
> >>> +		goto reset;
> >>> +
> >>> +	if (ireq->wscale_ok && !READ_ONCE(net->ipv4.sysctl_tcp_window_scaling))
> >>> +		goto reset;
> >>> +
> >>> +	ret = cookie_tcp_reqsk_init(sk, skb, req);
> >>> +	if (ret) {
> >>> +		reqsk_free(req);
> >>> +		req = NULL;
> >>> +	}
> >>> +
> >>> +	return req;
> >>> +
> >>> +reset:
> >>> +	reqsk_free(req);
> >>> +	return ERR_PTR(-EINVAL);
> >>> +}
> >>> +EXPORT_SYMBOL_GPL(cookie_bpf_check);
> >>> +#endif

