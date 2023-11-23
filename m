Return-Path: <bpf+bounces-15723-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E73EE7F555A
	for <lists+bpf@lfdr.de>; Thu, 23 Nov 2023 01:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2097028177C
	for <lists+bpf@lfdr.de>; Thu, 23 Nov 2023 00:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E218A1115;
	Thu, 23 Nov 2023 00:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="KlEDbsl7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2AA100;
	Wed, 22 Nov 2023 16:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1700699534; x=1732235534;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CHEbKPadk4pyqek3DmP5yJp/m9dEG4KiF/yUIpEWD2c=;
  b=KlEDbsl7TCilrGZCcsN8mS8OhgfD2KTNXxI/JwJ7+UxKPh93Hatb/ftH
   dNHkXE6RuwHuKlsb6tfrhdBchU5+RXZZlS6/vCP8MxKdr24w4xsPVwLpu
   b2zOG981tCimWlszbL079DULvu+CIKxHc1HcaaBdTA8Fkrn8277o9wQ2c
   o=;
X-IronPort-AV: E=Sophos;i="6.04,220,1695686400"; 
   d="scan'208";a="364473715"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-21d8d9f4.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 00:32:10 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2a-m6i4x-21d8d9f4.us-west-2.amazon.com (Postfix) with ESMTPS id 7DDA580640;
	Thu, 23 Nov 2023 00:32:07 +0000 (UTC)
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:3865]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.54.99:2525] with esmtp (Farcaster)
 id 09acb04e-cb71-483b-8fe0-f8c2bca46f92; Thu, 23 Nov 2023 00:32:07 +0000 (UTC)
X-Farcaster-Flow-ID: 09acb04e-cb71-483b-8fe0-f8c2bca46f92
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Thu, 23 Nov 2023 00:32:06 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.170.50) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.39;
 Thu, 23 Nov 2023 00:32:03 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <martin.lau@linux.dev>
CC: <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
	<daniel@iogearbox.net>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<edumazet@google.com>, <haoluo@google.com>, <john.fastabend@gmail.com>,
	<jolsa@kernel.org>, <kpsingh@kernel.org>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <mykolal@fb.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <sdf@google.com>,
	<song@kernel.org>, <yonghong.song@linux.dev>
Subject: Re: [PATCH v3 bpf-next 10/11] bpf: tcp: Support arbitrary SYN Cookie.
Date: Wed, 22 Nov 2023 16:31:54 -0800
Message-ID: <20231123003154.56710-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <825b7dde-f421-436e-99c8-47f9c1d83f5f@linux.dev>
References: <825b7dde-f421-436e-99c8-47f9c1d83f5f@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWC001.ant.amazon.com (10.13.139.223) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

From: Martin KaFai Lau <martin.lau@linux.dev>
Date: Wed, 22 Nov 2023 15:19:29 -0800
> On 11/21/23 10:42 AM, Kuniyuki Iwashima wrote:
> > diff --git a/include/net/inet6_hashtables.h b/include/net/inet6_hashtables.h
> > index 533a7337865a..9a67f47a5e64 100644
> > --- a/include/net/inet6_hashtables.h
> > +++ b/include/net/inet6_hashtables.h
> > @@ -116,9 +116,23 @@ struct sock *inet6_steal_sock(struct net *net, struct sk_buff *skb, int doff,
> >   	if (!sk)
> >   		return NULL;
> >   
> > -	if (!prefetched || !sk_fullsock(sk))
> > +	if (!prefetched)
> >   		return sk;
> >   
> > +	if (sk->sk_state == TCP_NEW_SYN_RECV) {
> > +#if IS_ENABLED(CONFIG_SYN_COOKIE)
> > +		if (inet_reqsk(sk)->syncookie) {
> > +			*refcounted = false;
> > +			skb->sk = sk;
> > +			skb->destructor = sock_pfree;
> 
> Instead of re-init the skb->sk and skb->destructor, can skb_steal_sock() avoid 
> resetting them to NULL in the first place and skb_steal_sock() returns the 
> rsk_listener instead?

Yes, but we need to move skb_steal_sock() to request_sock.h or include it just
before skb_steal_sock() in sock.h like below.  When I include request_sock.h in
top of sock.h, there were many build errors.


> btw, can inet_reqsk(sk)->rsk_listener be set to NULL after 
> this point?

except for sock_pfree(), we will not set NULL until cookie_bpf_check().


> Beside, it is essentially assigning the incoming request to a listening sk. Does 
> it need to call the inet6_lookup_reuseport() a few lines below to avoid skipping 
> the bpf reuseport selection that was fixed in commit 9c02bec95954 ("bpf, net: 
> Support SO_REUSEPORT sockets with bpf_sk_assign")?

Ah, good point.  I assumed bpf_sk_lookup() will do the random pick, but we
need to call it just in case sk is picked from bpf map.

As you suggested, if we return rsk_listener from skb_steal_sock(), we can
reuse the reuseport_lookup call in inet6_steal_sock().

Thanks!


---8<---
diff --git a/include/net/sock.h b/include/net/sock.h
index 1d6931caf0c3..83efbe0e7c3b 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2838,6 +2838,8 @@ sk_is_refcounted(struct sock *sk)
        return !sk_fullsock(sk) || !sock_flag(sk, SOCK_RCU_FREE);
 }
 
+#include <net/request_sock.h>
+
 /**
  * skb_steal_sock - steal a socket from an sk_buff
  * @skb: sk_buff to steal the socket from
@@ -2847,20 +2849,38 @@ sk_is_refcounted(struct sock *sk)
 static inline struct sock *
 skb_steal_sock(struct sk_buff *skb, bool *refcounted, bool *prefetched)
 {
-       if (skb->sk) {
-               struct sock *sk = skb->sk;
+       struct sock *sk = skb->sk;
 
+       if (!sk) {
+               *prefetched = false;
+               *refcounted = false;
+               return NULL;
+       }
+
+       *prefetched = skb_sk_is_prefetched(skb);
+       if (!*prefetched) {
                *refcounted = true;
-               *prefetched = skb_sk_is_prefetched(skb);
-               if (*prefetched)
-                       *refcounted = sk_is_refcounted(sk);
-               skb->destructor = NULL;
-               skb->sk = NULL;
-               return sk;
+               goto out;
        }
-       *prefetched = false;
-       *refcounted = false;
-       return NULL;
+
+       switch (sk->sk_state) {
+       case TCP_NEW_SYN_RECV:
+               if (inet_reqsk(sk)->syncookie) {
+                       *refcounted = false;
+                       return inet_reqsk(sk)->rsk_listener;
+               }
+               fallthrough;
+       case TCP_TIME_WAIT:
+               *refcounted = true;
+               break;
+       default:
+               *refcounted = !sock_flag(sk, SOCK_RCU_FREE);
+       }
+
+out:
+       skb->destructor = NULL;
+       skb->sk = NULL;
+       return sk;
 }
 
 /* Checks if this SKB belongs to an HW offloaded socket
---8<---

