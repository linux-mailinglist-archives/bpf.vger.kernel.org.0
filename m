Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B509225F24
	for <lists+bpf@lfdr.de>; Mon, 20 Jul 2020 14:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729145AbgGTMso (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Jul 2020 08:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728779AbgGTMsm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Jul 2020 08:48:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C4DC061794;
        Mon, 20 Jul 2020 05:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=oYVq7NIRWqvX/f/cel/N+xePG7N1PJ2B3QTLRfoiAMQ=; b=Q2M2BbM8skgQsbz+9IFT9+SRS8
        wOn0jWnTATVFcYirebkCBwKq5mT6Ub4JpyN3kocyPSwcZ9qxddqTIFOBWgt5cHn7Fiaq/A/rTr1Ny
        NJlv7iQ0FqlWOI2nLC8g9bDpVaGGUDRAPFvWzldUjdv+qtqUMGw9bRqAhBQHXLOTF8PBI5+b8YJ0f
        lSUkjWJUoqeS7o7xpPt8jkfJjaD/qpK37PcCQGm6fR3w9Ve3Av+OXeSmQz1Fcz1KSaLMTuFeT0L3h
        aoUfH/3lOromCbJGjPXv7nZzZc+/eTbity/L2HIf00Ca7AS8k5/AiW+/D9KsSdwaT+vKgWaf2mC9R
        XUUDuXUg==;
Received: from [2001:4bb8:105:4a81:2a8f:15b1:2c3:7be7] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxVDW-0004bj-37; Mon, 20 Jul 2020 12:48:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Eric Dumazet <edumazet@google.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        linux-sctp@vger.kernel.org, linux-hams@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, bridge@lists.linux-foundation.org,
        linux-can@vger.kernel.org, dccp@vger.kernel.org,
        linux-decnet-user@lists.sourceforge.net,
        linux-wpan@vger.kernel.org, linux-s390@vger.kernel.org,
        mptcp@lists.01.org, lvs-devel@vger.kernel.org,
        rds-devel@oss.oracle.com, linux-afs@lists.infradead.org,
        tipc-discussion@lists.sourceforge.net, linux-x25@vger.kernel.org
Subject: [PATCH 17/24] net/ipv6: split up ipv6_flowlabel_opt
Date:   Mon, 20 Jul 2020 14:47:30 +0200
Message-Id: <20200720124737.118617-18-hch@lst.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720124737.118617-1-hch@lst.de>
References: <20200720124737.118617-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Split ipv6_flowlabel_opt into a subfunction for each action and a small
wrapper.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 net/ipv6/ip6_flowlabel.c | 311 +++++++++++++++++++++------------------
 1 file changed, 167 insertions(+), 144 deletions(-)

diff --git a/net/ipv6/ip6_flowlabel.c b/net/ipv6/ip6_flowlabel.c
index ce4fbba4acce7e..27ee6de9beffc4 100644
--- a/net/ipv6/ip6_flowlabel.c
+++ b/net/ipv6/ip6_flowlabel.c
@@ -533,187 +533,210 @@ int ipv6_flowlabel_opt_get(struct sock *sk, struct in6_flowlabel_req *freq,
 	return -ENOENT;
 }
 
-int ipv6_flowlabel_opt(struct sock *sk, char __user *optval, int optlen)
+#define socklist_dereference(__sflp) \
+	rcu_dereference_protected(__sflp, lockdep_is_held(&ip6_sk_fl_lock))
+
+static int ipv6_flowlabel_put(struct sock *sk, struct in6_flowlabel_req *freq)
 {
-	int uninitialized_var(err);
-	struct net *net = sock_net(sk);
 	struct ipv6_pinfo *np = inet6_sk(sk);
-	struct in6_flowlabel_req freq;
-	struct ipv6_fl_socklist *sfl1 = NULL;
-	struct ipv6_fl_socklist *sfl;
 	struct ipv6_fl_socklist __rcu **sflp;
-	struct ip6_flowlabel *fl, *fl1 = NULL;
-
+	struct ipv6_fl_socklist *sfl;
 
-	if (optlen < sizeof(freq))
-		return -EINVAL;
+	if (freq->flr_flags & IPV6_FL_F_REFLECT) {
+		if (sk->sk_protocol != IPPROTO_TCP)
+			return -ENOPROTOOPT;
+		if (!np->repflow)
+			return -ESRCH;
+		np->flow_label = 0;
+		np->repflow = 0;
+		return 0;
+	}
 
-	if (copy_from_user(&freq, optval, sizeof(freq)))
-		return -EFAULT;
+	spin_lock_bh(&ip6_sk_fl_lock);
+	for (sflp = &np->ipv6_fl_list;
+	     (sfl = socklist_dereference(*sflp)) != NULL;
+	     sflp = &sfl->next) {
+		if (sfl->fl->label == freq->flr_label)
+			goto found;
+	}
+	spin_unlock_bh(&ip6_sk_fl_lock);
+	return -ESRCH;
+found:
+	if (freq->flr_label == (np->flow_label & IPV6_FLOWLABEL_MASK))
+		np->flow_label &= ~IPV6_FLOWLABEL_MASK;
+	*sflp = sfl->next;
+	spin_unlock_bh(&ip6_sk_fl_lock);
+	fl_release(sfl->fl);
+	kfree_rcu(sfl, rcu);
+	return 0;
+}
+		
+static int ipv6_flowlabel_renew(struct sock *sk, struct in6_flowlabel_req *freq)
+{
+	struct ipv6_pinfo *np = inet6_sk(sk);
+	struct net *net = sock_net(sk);
+	struct ipv6_fl_socklist *sfl;
+	int err;
 
-	switch (freq.flr_action) {
-	case IPV6_FL_A_PUT:
-		if (freq.flr_flags & IPV6_FL_F_REFLECT) {
-			if (sk->sk_protocol != IPPROTO_TCP)
-				return -ENOPROTOOPT;
-			if (!np->repflow)
-				return -ESRCH;
-			np->flow_label = 0;
-			np->repflow = 0;
-			return 0;
-		}
-		spin_lock_bh(&ip6_sk_fl_lock);
-		for (sflp = &np->ipv6_fl_list;
-		     (sfl = rcu_dereference_protected(*sflp,
-						      lockdep_is_held(&ip6_sk_fl_lock))) != NULL;
-		     sflp = &sfl->next) {
-			if (sfl->fl->label == freq.flr_label) {
-				if (freq.flr_label == (np->flow_label&IPV6_FLOWLABEL_MASK))
-					np->flow_label &= ~IPV6_FLOWLABEL_MASK;
-				*sflp = sfl->next;
-				spin_unlock_bh(&ip6_sk_fl_lock);
-				fl_release(sfl->fl);
-				kfree_rcu(sfl, rcu);
-				return 0;
-			}
+	rcu_read_lock_bh();
+	for_each_sk_fl_rcu(np, sfl) {
+		if (sfl->fl->label == freq->flr_label) {
+			err = fl6_renew(sfl->fl, freq->flr_linger,
+					freq->flr_expires);
+			rcu_read_unlock_bh();
+			return err;
 		}
-		spin_unlock_bh(&ip6_sk_fl_lock);
-		return -ESRCH;
+	}
+	rcu_read_unlock_bh();
 
-	case IPV6_FL_A_RENEW:
-		rcu_read_lock_bh();
-		for_each_sk_fl_rcu(np, sfl) {
-			if (sfl->fl->label == freq.flr_label) {
-				err = fl6_renew(sfl->fl, freq.flr_linger, freq.flr_expires);
-				rcu_read_unlock_bh();
-				return err;
-			}
-		}
-		rcu_read_unlock_bh();
+	if (freq->flr_share == IPV6_FL_S_NONE &&
+	    ns_capable(net->user_ns, CAP_NET_ADMIN)) {
+		struct ip6_flowlabel *fl = fl_lookup(net, freq->flr_label);
 
-		if (freq.flr_share == IPV6_FL_S_NONE &&
-		    ns_capable(net->user_ns, CAP_NET_ADMIN)) {
-			fl = fl_lookup(net, freq.flr_label);
-			if (fl) {
-				err = fl6_renew(fl, freq.flr_linger, freq.flr_expires);
-				fl_release(fl);
-				return err;
-			}
+		if (fl) {
+			err = fl6_renew(fl, freq->flr_linger,
+					freq->flr_expires);
+			fl_release(fl);
+			return err;
 		}
-		return -ESRCH;
-
-	case IPV6_FL_A_GET:
-		if (freq.flr_flags & IPV6_FL_F_REFLECT) {
-			struct net *net = sock_net(sk);
-			if (net->ipv6.sysctl.flowlabel_consistency) {
-				net_info_ratelimited("Can not set IPV6_FL_F_REFLECT if flowlabel_consistency sysctl is enable\n");
-				return -EPERM;
-			}
+	}
+	return -ESRCH;
+}
 
-			if (sk->sk_protocol != IPPROTO_TCP)
-				return -ENOPROTOOPT;
+static int ipv6_flowlabel_get(struct sock *sk, struct in6_flowlabel_req *freq,
+		void __user *optval, int optlen)
+{
+	struct ipv6_fl_socklist *sfl, *sfl1 = NULL;
+	struct ip6_flowlabel *fl, *fl1 = NULL;
+	struct ipv6_pinfo *np = inet6_sk(sk);
+	struct net *net = sock_net(sk);
+	int uninitialized_var(err);
 
-			np->repflow = 1;
-			return 0;
+	if (freq->flr_flags & IPV6_FL_F_REFLECT) {
+		if (net->ipv6.sysctl.flowlabel_consistency) {
+			net_info_ratelimited("Can not set IPV6_FL_F_REFLECT if flowlabel_consistency sysctl is enable\n");
+			return -EPERM;
 		}
 
-		if (freq.flr_label & ~IPV6_FLOWLABEL_MASK)
-			return -EINVAL;
+		if (sk->sk_protocol != IPPROTO_TCP)
+			return -ENOPROTOOPT;
+		np->repflow = 1;
+		return 0;
+	}
 
-		if (net->ipv6.sysctl.flowlabel_state_ranges &&
-		    (freq.flr_label & IPV6_FLOWLABEL_STATELESS_FLAG))
-			return -ERANGE;
+	if (freq->flr_label & ~IPV6_FLOWLABEL_MASK)
+		return -EINVAL;
+	if (net->ipv6.sysctl.flowlabel_state_ranges &&
+	    (freq->flr_label & IPV6_FLOWLABEL_STATELESS_FLAG))
+		return -ERANGE;
 
-		fl = fl_create(net, sk, &freq, optval, optlen, &err);
-		if (!fl)
-			return err;
-		sfl1 = kmalloc(sizeof(*sfl1), GFP_KERNEL);
+	fl = fl_create(net, sk, freq, optval, optlen, &err);
+	if (!fl)
+		return err;
 
-		if (freq.flr_label) {
-			err = -EEXIST;
-			rcu_read_lock_bh();
-			for_each_sk_fl_rcu(np, sfl) {
-				if (sfl->fl->label == freq.flr_label) {
-					if (freq.flr_flags&IPV6_FL_F_EXCL) {
-						rcu_read_unlock_bh();
-						goto done;
-					}
-					fl1 = sfl->fl;
-					if (!atomic_inc_not_zero(&fl1->users))
-						fl1 = NULL;
-					break;
+	sfl1 = kmalloc(sizeof(*sfl1), GFP_KERNEL);
+
+	if (freq->flr_label) {
+		err = -EEXIST;
+		rcu_read_lock_bh();
+		for_each_sk_fl_rcu(np, sfl) {
+			if (sfl->fl->label == freq->flr_label) {
+				if (freq->flr_flags & IPV6_FL_F_EXCL) {
+					rcu_read_unlock_bh();
+					goto done;
 				}
+				fl1 = sfl->fl;
+				if (!atomic_inc_not_zero(&fl1->users))
+					fl1 = NULL;
+				break;
 			}
-			rcu_read_unlock_bh();
+		}
+		rcu_read_unlock_bh();
 
-			if (!fl1)
-				fl1 = fl_lookup(net, freq.flr_label);
-			if (fl1) {
+		if (!fl1)
+			fl1 = fl_lookup(net, freq->flr_label);
+		if (fl1) {
 recheck:
-				err = -EEXIST;
-				if (freq.flr_flags&IPV6_FL_F_EXCL)
-					goto release;
-				err = -EPERM;
-				if (fl1->share == IPV6_FL_S_EXCL ||
-				    fl1->share != fl->share ||
-				    ((fl1->share == IPV6_FL_S_PROCESS) &&
-				     (fl1->owner.pid != fl->owner.pid)) ||
-				    ((fl1->share == IPV6_FL_S_USER) &&
-				     !uid_eq(fl1->owner.uid, fl->owner.uid)))
-					goto release;
-
-				err = -ENOMEM;
-				if (!sfl1)
-					goto release;
-				if (fl->linger > fl1->linger)
-					fl1->linger = fl->linger;
-				if ((long)(fl->expires - fl1->expires) > 0)
-					fl1->expires = fl->expires;
-				fl_link(np, sfl1, fl1);
-				fl_free(fl);
-				return 0;
+			err = -EEXIST;
+			if (freq->flr_flags&IPV6_FL_F_EXCL)
+				goto release;
+			err = -EPERM;
+			if (fl1->share == IPV6_FL_S_EXCL ||
+			    fl1->share != fl->share ||
+			    ((fl1->share == IPV6_FL_S_PROCESS) &&
+			     (fl1->owner.pid != fl->owner.pid)) ||
+			    ((fl1->share == IPV6_FL_S_USER) &&
+			     !uid_eq(fl1->owner.uid, fl->owner.uid)))
+				goto release;
+
+			err = -ENOMEM;
+			if (!sfl1)
+				goto release;
+			if (fl->linger > fl1->linger)
+				fl1->linger = fl->linger;
+			if ((long)(fl->expires - fl1->expires) > 0)
+				fl1->expires = fl->expires;
+			fl_link(np, sfl1, fl1);
+			fl_free(fl);
+			return 0;
 
 release:
-				fl_release(fl1);
-				goto done;
-			}
-		}
-		err = -ENOENT;
-		if (!(freq.flr_flags&IPV6_FL_F_CREATE))
+			fl_release(fl1);
 			goto done;
+		}
+	}
+	err = -ENOENT;
+	if (!(freq->flr_flags & IPV6_FL_F_CREATE))
+		goto done;
 
-		err = -ENOMEM;
-		if (!sfl1)
-			goto done;
+	err = -ENOMEM;
+	if (!sfl1)
+		goto done;
 
-		err = mem_check(sk);
-		if (err != 0)
-			goto done;
+	err = mem_check(sk);
+	if (err != 0)
+		goto done;
 
-		fl1 = fl_intern(net, fl, freq.flr_label);
-		if (fl1)
-			goto recheck;
+	fl1 = fl_intern(net, fl, freq->flr_label);
+	if (fl1)
+		goto recheck;
 
-		if (!freq.flr_label) {
-			if (copy_to_user(&((struct in6_flowlabel_req __user *) optval)->flr_label,
-					 &fl->label, sizeof(fl->label))) {
-				/* Intentionally ignore fault. */
-			}
+	if (!freq->flr_label) {
+		if (copy_to_user(&((struct in6_flowlabel_req __user *) optval)->flr_label,
+				 &fl->label, sizeof(fl->label))) {
+			/* Intentionally ignore fault. */
 		}
-
-		fl_link(np, sfl1, fl);
-		return 0;
-
-	default:
-		return -EINVAL;
 	}
 
+	fl_link(np, sfl1, fl);
+	return 0;
 done:
 	fl_free(fl);
 	kfree(sfl1);
 	return err;
 }
 
+int ipv6_flowlabel_opt(struct sock *sk, char __user *optval, int optlen)
+{
+	struct in6_flowlabel_req freq;
+
+	if (optlen < sizeof(freq))
+		return -EINVAL;
+	if (copy_from_user(&freq, optval, sizeof(freq)))
+		return -EFAULT;
+
+	switch (freq.flr_action) {
+	case IPV6_FL_A_PUT:
+		return ipv6_flowlabel_put(sk, &freq);
+	case IPV6_FL_A_RENEW:
+		return ipv6_flowlabel_renew(sk, &freq);
+	case IPV6_FL_A_GET:
+		return ipv6_flowlabel_get(sk, &freq, optval, optlen);
+	default:
+		return -EINVAL;
+	}
+}
+
 #ifdef CONFIG_PROC_FS
 
 struct ip6fl_iter_state {
-- 
2.27.0

