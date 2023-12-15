Return-Path: <bpf+bounces-17939-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C782C813FF4
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 03:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BFE2284224
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 02:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9657EDDC3;
	Fri, 15 Dec 2023 02:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="RrBX8bqu"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596D96ADB;
	Fri, 15 Dec 2023 02:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702607852; x=1734143852;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BMuquihvkV7y6qBpruCNT7zj5pk94gUeJwQRZWzrrNo=;
  b=RrBX8bquTm8s8WihJqq70Y0QhJXZjVXj2VlGXM7/D63oPiAIZLZ+IWfO
   7O912lVFWCOMlO1N4p23GjmNrLDeFu9ZyBKDAMP3oFm9CpzweboHvWHHb
   MljjBC2kCu8R/vXPXBRMklMYxXWqdiL9yUfZh0iZgr8vo4zMBYjHUoD6G
   o=;
X-IronPort-AV: E=Sophos;i="6.04,277,1695686400"; 
   d="scan'208";a="691284391"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-366646a6.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 02:37:25 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1a-m6i4x-366646a6.us-east-1.amazon.com (Postfix) with ESMTPS id 15757A3096;
	Fri, 15 Dec 2023 02:37:21 +0000 (UTC)
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:5142]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.18.147:2525] with esmtp (Farcaster)
 id 34600c7c-afc1-48b6-b40a-836b38bf7abd; Fri, 15 Dec 2023 02:37:21 +0000 (UTC)
X-Farcaster-Flow-ID: 34600c7c-afc1-48b6-b40a-836b38bf7abd
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 15 Dec 2023 02:37:20 +0000
Received: from 88665a182662.ant.amazon.com (10.37.244.8) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 15 Dec 2023 02:37:16 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: Matthieu Baerts <matttbe@kernel.org>, Mat Martineau
	<martineau@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <edumazet@google.com>, <andrii@kernel.org>, <ast@kernel.org>,
	<bpf@vger.kernel.org>, <daniel@iogearbox.net>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <martin.lau@linux.dev>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v6 bpf-next 3/6] bpf: tcp: Handle BPF SYN Cookie in skb_steal_sock().
Date: Fri, 15 Dec 2023 11:37:07 +0900
Message-ID: <20231215023707.41864-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CANn89i+8e8VJ8cJX6vwLFhtj=BmT233nNr=F9H3nFs8BZgTbsQ@mail.gmail.com>
References: <CANn89i+8e8VJ8cJX6vwLFhtj=BmT233nNr=F9H3nFs8BZgTbsQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D038UWB002.ant.amazon.com (10.13.139.185) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

From: Eric Dumazet <edumazet@google.com>
Date: Thu, 14 Dec 2023 17:31:15 +0100
> On Thu, Dec 14, 2023 at 4:56 PM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> >
> > We will support arbitrary SYN Cookie with BPF.
> >
> > If BPF prog validates ACK and kfunc allocates a reqsk, it will
> > be carried to TCP stack as skb->sk with req->syncookie 1.  Also,
> > the reqsk has its listener as req->rsk_listener with no refcnt
> > taken.
> >
> > When the TCP stack looks up a socket from the skb, we steal
> > inet_reqsk(skb->sk)->rsk_listener in skb_steal_sock() so that
> > the skb will be processed in cookie_v[46]_check() with the
> > listener.
> >
> > Note that we do not clear skb->sk and skb->destructor so that we
> > can carry the reqsk to cookie_v[46]_check().
> >
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > ---
> >  include/net/request_sock.h | 15 +++++++++++++--
> >  1 file changed, 13 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/net/request_sock.h b/include/net/request_sock.h
> > index 26c630c40abb..8839133d6f6b 100644
> > --- a/include/net/request_sock.h
> > +++ b/include/net/request_sock.h
> > @@ -101,10 +101,21 @@ static inline struct sock *skb_steal_sock(struct sk_buff *skb,
> >         }
> >
> >         *prefetched = skb_sk_is_prefetched(skb);
> > -       if (*prefetched)
> > +       if (*prefetched) {
> > +#if IS_ENABLED(CONFIG_SYN_COOKIES)
> > +               if (sk->sk_state == TCP_NEW_SYN_RECV && inet_reqsk(sk)->syncookie) {
> > +                       struct request_sock *req = inet_reqsk(sk);
> > +
> > +                       *refcounted = false;
> > +                       sk = req->rsk_listener;
> > +                       req->rsk_listener = NULL;
> 
> I am not sure about interactions with MPTCP.
> 
> I would be nice to have their feedback.

Matthieu, Mat, Paolo, could you double check if the change
above is sane ?
https://lore.kernel.org/bpf/20231214155424.67136-4-kuniyu@amazon.com/


Short sumamry:

With this series, tc could allocate reqsk to skb->sk and set a
listener to reqsk->rsk_listener, then __inet_lookup_skb() returns
a listener in the same reuseport group, and skb is processed in the
listener function flow, especially cookie_v[46]_check().

The only difference here is that skb->sk has reqsk, which does not
have rsk_listener.


> 
> > +                       return sk;
> > +               }
> > +#endif
> >                 *refcounted = sk_is_refcounted(sk);
> > -       else
> > +       } else {
> >                 *refcounted = true;
> > +       }
> >
> >         skb->destructor = NULL;
> >         skb->sk = NULL;
> > --
> > 2.30.2

