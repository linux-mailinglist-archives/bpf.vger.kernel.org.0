Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D225F2D9D2C
	for <lists+bpf@lfdr.de>; Mon, 14 Dec 2020 18:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732052AbgLNREI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Dec 2020 12:04:08 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:26337 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbgLNREI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Dec 2020 12:04:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.jp; i=@amazon.co.jp; q=dns/txt;
  s=amazon201209; t=1607965446; x=1639501446;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=lqHKJPd9p8tOaHlKsv820xPIgj3zA0jsQwSAqZ8S+cM=;
  b=A2znBmfzEzxNyioo9gK8SV3pUZgkAS/nmQMrLG1iWZ0wk09i/FbFSO/V
   Rs2IGa3r44Ne1UHc8LPkX2cvFYKajm3rQ05dTXpvsg/uToVo05rt6h+Jj
   UuoE4HbI/DPN1EcxoCN2ljwj9g732N0pNFs8LFWm/t6u5K89ARWkhSbsL
   c=;
X-IronPort-AV: E=Sophos;i="5.78,420,1599523200"; 
   d="scan'208";a="69008563"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-c7f73527.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 14 Dec 2020 17:03:25 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1e-c7f73527.us-east-1.amazon.com (Postfix) with ESMTPS id 91F27C220B;
        Mon, 14 Dec 2020 17:03:22 +0000 (UTC)
Received: from EX13D04ANC001.ant.amazon.com (10.43.157.89) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 14 Dec 2020 17:03:21 +0000
Received: from 38f9d3582de7.ant.amazon.com (10.43.160.48) by
 EX13D04ANC001.ant.amazon.com (10.43.157.89) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 14 Dec 2020 17:03:17 +0000
From:   Kuniyuki Iwashima <kuniyu@amazon.co.jp>
To:     <kafai@fb.com>
CC:     <ast@kernel.org>, <benh@amazon.com>, <bpf@vger.kernel.org>,
        <daniel@iogearbox.net>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <kuni1840@gmail.com>,
        <kuniyu@amazon.co.jp>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>
Subject: Re: [PATCH v1 bpf-next 05/11] tcp: Migrate TCP_NEW_SYN_RECV requests.
Date:   Tue, 15 Dec 2020 02:03:13 +0900
Message-ID: <20201214170313.50197-1-kuniyu@amazon.co.jp>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20201210184915.4codwsoufxdhtj3o@kafai-mbp.dhcp.thefacebook.com>
References: <20201210184915.4codwsoufxdhtj3o@kafai-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.48]
X-ClientProxiedBy: EX13D32UWA001.ant.amazon.com (10.43.160.4) To
 EX13D04ANC001.ant.amazon.com (10.43.157.89)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From:   Martin KaFai Lau <kafai@fb.com>
Date:   Thu, 10 Dec 2020 10:49:15 -0800
> On Thu, Dec 10, 2020 at 02:15:38PM +0900, Kuniyuki Iwashima wrote:
> > From:   Martin KaFai Lau <kafai@fb.com>
> > Date:   Wed, 9 Dec 2020 16:07:07 -0800
> > > On Tue, Dec 01, 2020 at 11:44:12PM +0900, Kuniyuki Iwashima wrote:
> > > > This patch renames reuseport_select_sock() to __reuseport_select_sock() and
> > > > adds two wrapper function of it to pass the migration type defined in the
> > > > previous commit.
> > > > 
> > > >   reuseport_select_sock          : BPF_SK_REUSEPORT_MIGRATE_NO
> > > >   reuseport_select_migrated_sock : BPF_SK_REUSEPORT_MIGRATE_REQUEST
> > > > 
> > > > As mentioned before, we have to select a new listener for TCP_NEW_SYN_RECV
> > > > requests at receiving the final ACK or sending a SYN+ACK. Therefore, this
> > > > patch also changes the code to call reuseport_select_migrated_sock() even
> > > > if the listening socket is TCP_CLOSE. If we can pick out a listening socket
> > > > from the reuseport group, we rewrite request_sock.rsk_listener and resume
> > > > processing the request.
> > > > 
> > > > Reviewed-by: Benjamin Herrenschmidt <benh@amazon.com>
> > > > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.co.jp>
> > > > ---
> > > >  include/net/inet_connection_sock.h | 12 +++++++++++
> > > >  include/net/request_sock.h         | 13 ++++++++++++
> > > >  include/net/sock_reuseport.h       |  8 +++----
> > > >  net/core/sock_reuseport.c          | 34 ++++++++++++++++++++++++------
> > > >  net/ipv4/inet_connection_sock.c    | 13 ++++++++++--
> > > >  net/ipv4/tcp_ipv4.c                |  9 ++++++--
> > > >  net/ipv6/tcp_ipv6.c                |  9 ++++++--
> > > >  7 files changed, 81 insertions(+), 17 deletions(-)
> > > > 
> > > > diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
> > > > index 2ea2d743f8fc..1e0958f5eb21 100644
> > > > --- a/include/net/inet_connection_sock.h
> > > > +++ b/include/net/inet_connection_sock.h
> > > > @@ -272,6 +272,18 @@ static inline void inet_csk_reqsk_queue_added(struct sock *sk)
> > > >  	reqsk_queue_added(&inet_csk(sk)->icsk_accept_queue);
> > > >  }
> > > >  
> > > > +static inline void inet_csk_reqsk_queue_migrated(struct sock *sk,
> > > > +						 struct sock *nsk,
> > > > +						 struct request_sock *req)
> > > > +{
> > > > +	reqsk_queue_migrated(&inet_csk(sk)->icsk_accept_queue,
> > > > +			     &inet_csk(nsk)->icsk_accept_queue,
> > > > +			     req);
> > > > +	sock_put(sk);
> > > not sure if it is safe to do here.
> > > IIUC, when the req->rsk_refcnt is held, it also holds a refcnt
> > > to req->rsk_listener such that sock_hold(req->rsk_listener) is
> > > safe because its sk_refcnt is not zero.
> > 
> > I think it is safe to call sock_put() for the old listener here.
> > 
> > Without this patchset, at receiving the final ACK or retransmitting
> > SYN+ACK, if sk_state == TCP_CLOSE, sock_put(req->rsk_listener) is done
> > by calling reqsk_put() twice in inet_csk_reqsk_queue_drop_and_put().
> Note that in your example (final ACK), sock_put(req->rsk_listener) is
> _only_ called when reqsk_put() can get refcount_dec_and_test(&req->rsk_refcnt)
> to reach zero.
> 
> Here in this patch, it sock_put(req->rsk_listener) without req->rsk_refcnt
> reaching zero.
> 
> Let says there are two cores holding two refcnt to req (one cnt for each core)
> by looking up the req from ehash.  One of the core do this migrate and
> sock_put(req->rsk_listener).  Another core does sock_hold(req->rsk_listener).
> 
> 	Core1					Core2
> 						sock_put(req->rsk_listener)
> 
> 	sock_hold(req->rsk_listener)

I'm sorry for the late reply.

I missed this situation that different Cores get into NEW_SYN_RECV path,
but this does exist.
https://lore.kernel.org/netdev/1517977874.3715.153.camel@gmail.com/#t
https://lore.kernel.org/netdev/1518531252.3715.178.camel@gmail.com/


If close() is called for the listener and the request has the last refcount
for it, sock_put() by Core2 frees it, so Core1 cannot proceed with freed
listener. So, it is good to call refcount_inc_not_zero() instead of
sock_hold(). If refcount_inc_not_zero() fails, it means that the listener
is closed and the req->rsk_listener is changed in another place. Then, we
can continue processing the request by rewriting sk with rsk_listener and
calling sock_hold() for it.

Also, the migration by Core2 can be done after sock_hold() by Core1. Then
if Core1 win the race by removing the request from ehash,
in inet_csk_reqsk_queue_add(), instead of sk, req->rsk_listener should be
used as the proper listener to add the req into its queue. But if the
rsk_listener is also TCP_CLOSE, we have to call inet_child_forget().

Moreover, we have to check the listener is freed in the beginning of
reqsk_timer_handler() by refcount_inc_not_zero().


> > And then, we do `goto lookup;` and overwrite the sk.
> > 
> > In the v2 patchset, refcount_inc_not_zero() is done for the new listener in
> > reuseport_select_migrated_sock(), so we have to call sock_put() for the old
> > listener instead to free it properly.
> > 
> > ---8<---
> > +struct sock *reuseport_select_migrated_sock(struct sock *sk, u32 hash,
> > +					    struct sk_buff *skb)
> > +{
> > +	struct sock *nsk;
> > +
> > +	nsk = __reuseport_select_sock(sk, hash, skb, 0, BPF_SK_REUSEPORT_MIGRATE_REQUEST);
> > +	if (nsk && likely(refcount_inc_not_zero(&nsk->sk_refcnt)))
> There is another potential issue here.  The TCP_LISTEN nsk is protected
> by rcu.  refcount_inc_not_zero(&nsk->sk_refcnt) cannot be done if it
> is not under rcu_read_lock().
> 
> The receive path may be ok as it is in rcu.  You may need to check for
> others.

IIUC, is this mean nsk can be NULL after grace period of RCU? If so, I will
move rcu_read_lock/unlock() from __reuseport_select_sock() to
reuseport_select_sock() and reuseport_select_migrated_sock().


> > +		return nsk;
> > +
> > +	return NULL;
> > +}
> > +EXPORT_SYMBOL(reuseport_select_migrated_sock);
> > ---8<---
> > https://lore.kernel.org/netdev/20201207132456.65472-8-kuniyu@amazon.co.jp/
> > 
> > 
> > > > +	sock_hold(nsk);
> > > > +	req->rsk_listener = nsk;
> It looks like there is another race here.  What
> if multiple cores try to update req->rsk_listener?

I think we have to add a lock in struct request_sock, acquire it, check
if the rsk_listener is changed or not, and then do migration. Also, if the
listener has been changed, we have to tell the caller to use it as the new
listener.

---8<---
       spin_lock(&lock)
       if (sk != req->rsk_listener) {
               nsk = req->rsk_listener;
               goto out;
       }

       // do migration
out:
       spin_unlock(&lock)
       return nsk;
---8<---

