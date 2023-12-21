Return-Path: <bpf+bounces-18466-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C573981ABFA
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 01:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DC181F2359B
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 00:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3137810F5;
	Thu, 21 Dec 2023 00:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Gy+I/jbE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE962567;
	Thu, 21 Dec 2023 00:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1703120338; x=1734656338;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hCCNF7iGQcRhyplgbnTLU1frrwHgbZiRWW8sPPIWH8I=;
  b=Gy+I/jbEtaUT5BmB+5QwQVBb7zb8RhD3NADQ9GmH/KBqhfyqHzzTkJ70
   ovxNY6Ir4QRUx8JY22qRRzLQhl3m3p1WJzkz7Lk2ba7QVxL28HYYJ3+bp
   kgLPCq+ZAbgzuiFmF8m/KgXirnhNZon1bHWQkxzc7qYQAu4hQSqju+luc
   g=;
X-IronPort-AV: E=Sophos;i="6.04,292,1695686400"; 
   d="scan'208";a="260910136"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-6e7a78d7.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 00:58:52 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1e-m6i4x-6e7a78d7.us-east-1.amazon.com (Postfix) with ESMTPS id B9C1A804D0;
	Thu, 21 Dec 2023 00:58:49 +0000 (UTC)
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:3402]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.6.30:2525] with esmtp (Farcaster)
 id b29cd697-4f61-493a-b153-a49eb6f7a4b6; Thu, 21 Dec 2023 00:58:49 +0000 (UTC)
X-Farcaster-Flow-ID: b29cd697-4f61-493a-b153-a49eb6f7a4b6
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 21 Dec 2023 00:58:44 +0000
Received: from 88665a182662.ant.amazon.com (10.119.15.211) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.40;
 Thu, 21 Dec 2023 00:58:39 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <pabeni@redhat.com>
CC: <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
	<daniel@iogearbox.net>, <edumazet@google.com>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <martin.lau@linux.dev>, <martineau@kernel.org>,
	<matttbe@kernel.org>, <mptcp@lists.linux.dev>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v6 bpf-next 3/6] bpf: tcp: Handle BPF SYN Cookie in skb_steal_sock().
Date: Thu, 21 Dec 2023 09:58:30 +0900
Message-ID: <20231221005830.33710-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <533e8e80c4db4ecd34a2c49dd3de3e76810afe22.camel@redhat.com>
References: <533e8e80c4db4ecd34a2c49dd3de3e76810afe22.camel@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D045UWA003.ant.amazon.com (10.13.139.46) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

From: Paolo Abeni <pabeni@redhat.com>
Date: Wed, 20 Dec 2023 11:22:45 +0100
> On Tue, 2023-12-19 at 08:45 -0800, Mat Martineau wrote:
> > On Fri, 15 Dec 2023, Kuniyuki Iwashima wrote:
> > 
> > > From: Eric Dumazet <edumazet@google.com>
> > > Date: Thu, 14 Dec 2023 17:31:15 +0100
> > > > On Thu, Dec 14, 2023 at 4:56 PM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> > > > > 
> > > > > We will support arbitrary SYN Cookie with BPF.
> > > > > 
> > > > > If BPF prog validates ACK and kfunc allocates a reqsk, it will
> > > > > be carried to TCP stack as skb->sk with req->syncookie 1.  Also,
> > > > > the reqsk has its listener as req->rsk_listener with no refcnt
> > > > > taken.
> > > > > 
> > > > > When the TCP stack looks up a socket from the skb, we steal
> > > > > inet_reqsk(skb->sk)->rsk_listener in skb_steal_sock() so that
> > > > > the skb will be processed in cookie_v[46]_check() with the
> > > > > listener.
> > > > > 
> > > > > Note that we do not clear skb->sk and skb->destructor so that we
> > > > > can carry the reqsk to cookie_v[46]_check().
> > > > > 
> > > > > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > > > > ---
> > > > >  include/net/request_sock.h | 15 +++++++++++++--
> > > > >  1 file changed, 13 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/include/net/request_sock.h b/include/net/request_sock.h
> > > > > index 26c630c40abb..8839133d6f6b 100644
> > > > > --- a/include/net/request_sock.h
> > > > > +++ b/include/net/request_sock.h
> > > > > @@ -101,10 +101,21 @@ static inline struct sock *skb_steal_sock(struct sk_buff *skb,
> > > > >         }
> > > > > 
> > > > >         *prefetched = skb_sk_is_prefetched(skb);
> > > > > -       if (*prefetched)
> > > > > +       if (*prefetched) {
> > > > > +#if IS_ENABLED(CONFIG_SYN_COOKIES)
> > > > > +               if (sk->sk_state == TCP_NEW_SYN_RECV && inet_reqsk(sk)->syncookie) {
> > > > > +                       struct request_sock *req = inet_reqsk(sk);
> > > > > +
> > > > > +                       *refcounted = false;
> > > > > +                       sk = req->rsk_listener;
> > > > > +                       req->rsk_listener = NULL;
> > > > 
> > > > I am not sure about interactions with MPTCP.
> > > > 
> > > > I would be nice to have their feedback.
> > > 
> > > Matthieu, Mat, Paolo, could you double check if the change
> > > above is sane ?
> > > https://lore.kernel.org/bpf/20231214155424.67136-4-kuniyu@amazon.com/
> > 
> > Hi Kuniyuki -
> > 
> > Yes, we will take a look. Haven't had time to look in detail yet but I 
> > wanted to let you know we saw your message and will follow up.
> 
> I'm sorry for the late reply.
> 
> AFAICS, from mptcp perspective, the main differences from built-in
> cookie validation are:
> 
> - cookie allocation via mptcp_subflow_reqsk_alloc() and cookie
> 'finalization' via cookie_tcp_reqsk_init() /
> mptcp_subflow_init_cookie_req(req, sk, skb) could refer 2 different
> listeners - within the same REUSEPORT group.
> 
> - incoming pure syn packets will not land into the TCP stack, so
> af_ops->route_req will not happen.
> 
> I think both the above are problematic form mptcp. 
> 
> Potentially we can have both mptcp-enabled and plain tcp socket with
> the same reuseport group. 
> 
> Currently the mptcp code assumes the listener is mptcp
> cookie_tcp_reqsk_init(), the req is mptcp, too. I think we could fix
> this at the mptcp level, but no patch ready at the moment.
> 
> Even the missing call to route_req() is problematic, as we use that to
> fetch required information from the initial syn for MP_JOIN subflows -
> yep, unfortunately mptcp needs to track of some state across MPJ syn
> and MPJ 3rd ack reception.
> 
> Fixing this last item looks more difficult. I think it would be safer
> and simpler to avoid mptcp support for generic syncookie and ev enable
> it later - after we address things on the mptcp side.

Thanks for checking, Paolo!

Ok, I will change kfunc in the next version so that it will return
-EINVAL for mptcp listener, and later the issues above are sorted out,
we can add mptcp support back.


> 
> @Eric, were you looking to something else and/or more specific?

