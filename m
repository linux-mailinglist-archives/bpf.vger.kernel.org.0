Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B54A538BDD3
	for <lists+bpf@lfdr.de>; Fri, 21 May 2021 07:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbhEUFRX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 May 2021 01:17:23 -0400
Received: from smtp-fw-80007.amazon.com ([99.78.197.218]:20096 "EHLO
        smtp-fw-80007.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbhEUFRX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 May 2021 01:17:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.jp; i=@amazon.co.jp; q=dns/txt;
  s=amazon201209; t=1621574161; x=1653110161;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HGhopqNit1CyoiAPFzXCxUVGqD+msanIlpljNJNwB4g=;
  b=JGJYVRw0y/FPCKxENMAtlnwqSuSsVzu1tlInOdLcHS1boOHkkluBo90I
   uFGixGs1Ihp8uEwiRZVG0ATBirXpftiNz4QatJWDOvXAa9mIxLEEtGu3h
   NDwv9nYKkuUuphb78cNfOvveJxr7q8FpWteefcGvkz+aZ0Ty8Y4TwnU35
   w=;
X-IronPort-AV: E=Sophos;i="5.82,313,1613433600"; 
   d="scan'208";a="2506590"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-1a-807d4a99.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP; 21 May 2021 05:15:59 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-1a-807d4a99.us-east-1.amazon.com (Postfix) with ESMTPS id C64BAA2005;
        Fri, 21 May 2021 05:15:58 +0000 (UTC)
Received: from EX13D04ANC001.ant.amazon.com (10.43.157.89) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.18; Fri, 21 May 2021 05:15:58 +0000
Received: from 88665a182662.ant.amazon.com (10.43.162.239) by
 EX13D04ANC001.ant.amazon.com (10.43.157.89) with Microsoft SMTP Server (TLS)
 id 15.0.1497.18; Fri, 21 May 2021 05:15:53 +0000
From:   Kuniyuki Iwashima <kuniyu@amazon.co.jp>
To:     <kafai@fb.com>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <benh@amazon.com>,
        <bpf@vger.kernel.org>, <daniel@iogearbox.net>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <kuni1840@gmail.com>, <kuniyu@amazon.co.jp>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v6 bpf-next 03/11] tcp: Keep TCP_CLOSE sockets in the reuseport group.
Date:   Fri, 21 May 2021 14:15:48 +0900
Message-ID: <20210521051548.48515-1-kuniyu@amazon.co.jp>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210521044725.acvvp3qoj5tk4xts@kafai-mbp.dhcp.thefacebook.com>
References: <20210521044725.acvvp3qoj5tk4xts@kafai-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.43.162.239]
X-ClientProxiedBy: EX13D25UWC003.ant.amazon.com (10.43.162.129) To
 EX13D04ANC001.ant.amazon.com (10.43.157.89)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From:   Martin KaFai Lau <kafai@fb.com>
Date:   Thu, 20 May 2021 21:47:25 -0700
> On Fri, May 21, 2021 at 09:26:39AM +0900, Kuniyuki Iwashima wrote:
> > From:   Martin KaFai Lau <kafai@fb.com>
> > Date:   Thu, 20 May 2021 16:39:06 -0700
> > > On Fri, May 21, 2021 at 07:54:48AM +0900, Kuniyuki Iwashima wrote:
> > > > From:   Martin KaFai Lau <kafai@fb.com>
> > > > Date:   Thu, 20 May 2021 14:22:01 -0700
> > > > > On Thu, May 20, 2021 at 05:51:17PM +0900, Kuniyuki Iwashima wrote:
> > > > > > From:   Martin KaFai Lau <kafai@fb.com>
> > > > > > Date:   Wed, 19 May 2021 23:26:48 -0700
> > > > > > > On Mon, May 17, 2021 at 09:22:50AM +0900, Kuniyuki Iwashima wrote:
> > > > > > > 
> > > > > > > > +static int reuseport_resurrect(struct sock *sk, struct sock_reuseport *old_reuse,
> > > > > > > > +			       struct sock_reuseport *reuse, bool bind_inany)
> > > > > > > > +{
> > > > > > > > +	if (old_reuse == reuse) {
> > > > > > > > +		/* If sk was in the same reuseport group, just pop sk out of
> > > > > > > > +		 * the closed section and push sk into the listening section.
> > > > > > > > +		 */
> > > > > > > > +		__reuseport_detach_closed_sock(sk, old_reuse);
> > > > > > > > +		__reuseport_add_sock(sk, old_reuse);
> > > > > > > > +		return 0;
> > > > > > > > +	}
> > > > > > > > +
> > > > > > > > +	if (!reuse) {
> > > > > > > > +		/* In bind()/listen() path, we cannot carry over the eBPF prog
> > > > > > > > +		 * for the shutdown()ed socket. In setsockopt() path, we should
> > > > > > > > +		 * not change the eBPF prog of listening sockets by attaching a
> > > > > > > > +		 * prog to the shutdown()ed socket. Thus, we will allocate a new
> > > > > > > > +		 * reuseport group and detach sk from the old group.
> > > > > > > > +		 */
> > > > > > > For the reuseport_attach_prog() path, I think it needs to consider
> > > > > > > the reuse->num_closed_socks != 0 case also and that should belong
> > > > > > > to the resurrect case.  For example, when
> > > > > > > sk_unhashed(sk) but sk->sk_reuseport == 0.
> > > > > > 
> > > > > > In the path, reuseport_resurrect() is called from reuseport_alloc() only
> > > > > > if reuse->num_closed_socks != 0.
> > > > > > 
> > > > > > 
> > > > > > > @@ -92,6 +117,14 @@ int reuseport_alloc(struct sock *sk, bool bind_inany)
> > > > > > >  	reuse = rcu_dereference_protected(sk->sk_reuseport_cb,
> > > > > > >  					  lockdep_is_held(&reuseport_lock));
> > > > > > >  	if (reuse) {
> > > > > > > +		if (reuse->num_closed_socks) {
> > > > > > 
> > > > > > But, should this be
> > > > > > 
> > > > > > 	if (sk->sk_state == TCP_CLOSE && reuse->num_closed_socks)
> > > > > > 
> > > > > > because we need not allocate a new group when we attach a bpf prog to
> > > > > > listeners?
> > > > > The reuseport_alloc() is fine as is.  No need to change.
> > > > 
> > > > I missed sk_unhashed(sk) prevents calling reuseport_alloc()
> > > > if sk_state == TCP_LISTEN. I'll keep it as is.
> > > > 
> > > > 
> > > > > 
> > > > > I should have copied reuseport_attach_prog() in the last reply and
> > > > > commented there instead.
> > > > > 
> > > > > I meant reuseport_attach_prog() needs a change.  In reuseport_attach_prog(),
> > > > > iiuc, currently passing the "else if (!rcu_access_pointer(sk->sk_reuseport_cb))"
> > > > > check implies the sk was (and still is) hashed with sk_reuseport enabled
> > > > > because the current behavior would have set sk_reuseport_cb to NULL during
> > > > > unhash but it is no longer true now.  For example, this will break:
> > > > > 
> > > > > 1. shutdown(lsk); /* lsk was bound with sk_reuseport enabled */
> > > > > 2. setsockopt(lsk, ..., SO_REUSEPORT, &zero, ...); /* disable sk_reuseport */
> > > > > 3. setsockopt(lsk, ..., SO_ATTACH_REUSEPORT_EBPF, &prog_fd, ...);
> > > > >    ^---- /* This will work now because sk_reuseport_cb is not NULL.
> > > > >           * However, it shouldn't be allowed.
> > > > > 	  */
> > > > 
> > > > Thank you for explanation, I understood the case.
> > > > 
> > > > Exactly, I've confirmed that the case succeeded in the setsockopt() and I
> > > > could change the active listeners' prog via a shutdowned socket.
> > > > 
> > > > 
> > > > > 
> > > > > I am thinking something like this (uncompiled code):
> > > > > 
> > > > > int reuseport_attach_prog(struct sock *sk, struct bpf_prog *prog)
> > > > > {
> > > > > 	struct sock_reuseport *reuse;
> > > > > 	struct bpf_prog *old_prog;
> > > > > 
> > > > > 	if (sk_unhashed(sk)) {
> > > > > 		int err;
> > > > > 
> > > > > 		if (!sk->sk_reuseport)
> > > > > 			return -EINVAL;
> > > > > 
> > > > > 		err = reuseport_alloc(sk, false);
> > > > > 		if (err)
> > > > > 			return err;
> > > > > 	} else if (!rcu_access_pointer(sk->sk_reuseport_cb)) {
> > > > > 		/* The socket wasn't bound with SO_REUSEPORT */
> > > > > 		return -EINVAL;
> > > > > 	}
> > > > > 
> > > > > 	/* ... */
> > > > > }
> > > > > 
> > > > > WDYT?
> > > > 
> > > > I tested this change worked fine. I think this change should be added in
> > > > reuseport_detach_prog() also.
> > > > 
> > > > ---8<---
> > > > int reuseport_detach_prog(struct sock *sk)
> > > > {
> > > >         struct sock_reuseport *reuse;
> > > >         struct bpf_prog *old_prog;
> > > > 
> > > >         if (!rcu_access_pointer(sk->sk_reuseport_cb))
> > > > 		return sk->sk_reuseport ? -ENOENT : -EINVAL;
> > > > ---8<---
> > > Right, a quick thought is something like this for detach:
> > > 
> > > 	spin_lock_bh(&reuseport_lock);
> > > 	reuse = rcu_dereference_protected(sk->sk_reuseport_cb,
> > > 					  lockdep_is_held(&reuseport_lock));
> > 
> > Is this necessary because reuseport_grow() can detach sk?
> > 
> >         if (!reuse) {
> >                 spin_unlock_bh(&reuseport_lock);
> >                 return -ENOENT;
> >         }
> Yes, it is needed.  Please add a comment for the reuseport_grow() case also.

I see, I'll add this change in the next spin.
Thank you!

---8<---
@@ -608,13 +612,24 @@ int reuseport_detach_prog(struct sock *sk)
        struct sock_reuseport *reuse;
        struct bpf_prog *old_prog;
 
-       if (!rcu_access_pointer(sk->sk_reuseport_cb))
-               return sk->sk_reuseport ? -ENOENT : -EINVAL;
-
        old_prog = NULL;
        spin_lock_bh(&reuseport_lock);
        reuse = rcu_dereference_protected(sk->sk_reuseport_cb,
                                          lockdep_is_held(&reuseport_lock));
+
+       /* reuse must be checked after acquiring the reuseport_lock
+        * because reuseport_grow() can detach a closed sk.
+        */
+       if (!reuse) {
+               spin_unlock_bh(&reuseport_lock);
+               return sk->sk_reuseport ? -ENOENT : -EINVAL;
+       }
+
+       if (sk_unhashed(sk) && reuse->num_closed_socks) {
+               spin_unlock_bh(&reuseport_lock);
+               return -ENOENT;
+       }
+
        old_prog = rcu_replace_pointer(reuse->prog, old_prog,
                                       lockdep_is_held(&reuseport_lock));
        spin_unlock_bh(&reuseport_lock);
---8<---


> 
> > 
> > Then we can remove rcu_access_pointer() check and move sk_reuseport check
> > here.
> Make sense.
