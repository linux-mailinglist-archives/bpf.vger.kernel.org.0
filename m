Return-Path: <bpf+bounces-55470-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09ACBA81044
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 17:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 272F78C3809
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 15:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3F422D4DE;
	Tue,  8 Apr 2025 15:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5oXuucM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AD122F17B;
	Tue,  8 Apr 2025 15:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744126289; cv=none; b=MsmBTTQCO3gO0SAd5bEXlnEPym82rV5JubrNyJNTRaCks07TGnPAq0YzRNWZ9kzV1ka4wPWt3+D5Y8vp5JPhDRF7c/FFi9NKO8U4ydLq+r81+AH5EoCvCOLEIOt7yx9cbt8ZbUHKZScdW7TjvQilkJfRRNlkzoQf/kq/5EJ5JG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744126289; c=relaxed/simple;
	bh=vtSahLkmhgPYUtYhRoekNvjHggVsr/Uts6Ijlq9T1Hk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GuBQBOCGZFjovbz1ZVpRXgDFh0lISsARDvxwSn7Lzw4HqZML0RZOVeG40QVZEoNzpJvDQLrxddaKp0sMnpVLP31UdRkNz+n8jgU2ycgyVnlgzSpBxwK5cBqow1loOydKW6uOsPdhDC7KA7HfaxndWbVZVwtVTmbMID9AJzpHIgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5oXuucM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FDD6C4CEE9;
	Tue,  8 Apr 2025 15:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744126288;
	bh=vtSahLkmhgPYUtYhRoekNvjHggVsr/Uts6Ijlq9T1Hk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=f5oXuucMoaf+Js6+lwgrHnc5KXrBxF/xWk8ki3Ofz8nh24MMR0MWE9ozbIO1fPSyi
	 284cHeRQeVvM+/0Vwok3Ouq0Tezp+BVN2zm8GYZ0e5oOjo5R+xmHg/zbfuawrpjM++
	 PqCnMxMLd4TPOhGtQ3aGtQLxLPR0AAodkqCMb1mVn25eWaWOu/N3J+9PKL0j+dbs2Y
	 wRH9P3jjBUpnCshCQggoFOKDjfKnzgrZtAmIps+7KM3m2PL+N9GTx+GKar97WY1rE/
	 jN/Ce8u2VBiF3uvpJRtY3EgQKtcngAFCfnDhariwd/3s2rYk8aMlmye+I7TLNUrc8F
	 +2vcdkigRn6+w==
Subject: [PATCH net-next V2 2/2] net: sched: generalize check for no-op qdisc
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org,
 tom@herbertland.com, Eric Dumazet <eric.dumazet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 dsahern@kernel.org, makita.toshiaki@lab.ntt.co.jp, kernel-team@cloudflare.com
Date: Tue, 08 Apr 2025 17:31:24 +0200
Message-ID: <174412628464.3702169.81132659219041209.stgit@firesoul>
In-Reply-To: <174412623473.3702169.4235683143719614624.stgit@firesoul>
References: <174412623473.3702169.4235683143719614624.stgit@firesoul>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Several drivers (e.g., veth, vrf) contain open-coded checks to determine
whether a TX queue has a real qdisc attached - typically by testing if
qdisc->enqueue is non-NULL.

These checks are functionally equivalent to comparing the queue's qdisc
pointer against &noop_qdisc (qdisc named "noqueue"). This equivalence
stems from noqueue_init(), which explicitly clears the enqueue pointer
for the "noqueue" qdisc. As a result, __dev_queue_xmit() treats the qdisc
as a no-op only when enqueue == NULL.

This patch introduces a common helper, qdisc_txq_is_noop() to standardize
this check. The helper is added in sch_generic.h and replaces open-coded
logic in both the veth and vrf drivers.

This is a non-functional change.

Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
---
 drivers/net/veth.c        |   14 +-------------
 drivers/net/vrf.c         |    3 +--
 include/net/sch_generic.h |    7 ++++++-
 3 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index f29a0db2ba36..83c7758534da 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -341,18 +341,6 @@ static bool veth_skb_is_eligible_for_gro(const struct net_device *dev,
 		 rcv->features & (NETIF_F_GRO_FRAGLIST | NETIF_F_GRO_UDP_FWD));
 }
 
-/* Does specific txq have a real qdisc attached? - see noqueue_init() */
-static inline bool txq_has_qdisc(struct netdev_queue *txq)
-{
-	struct Qdisc *q;
-
-	q = rcu_dereference(txq->qdisc);
-	if (q->enqueue)
-		return true;
-	else
-		return false;
-}
-
 static netdev_tx_t veth_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct veth_priv *rcv_priv, *priv = netdev_priv(dev);
@@ -399,7 +387,7 @@ static netdev_tx_t veth_xmit(struct sk_buff *skb, struct net_device *dev)
 		 */
 		txq = netdev_get_tx_queue(dev, rxq);
 
-		if (!txq_has_qdisc(txq)) {
+		if (qdisc_txq_is_noop(txq)) {
 			dev_kfree_skb_any(skb);
 			goto drop;
 		}
diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index 7168b33adadb..d4fe36c55f29 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -349,9 +349,8 @@ static bool qdisc_tx_is_default(const struct net_device *dev)
 		return false;
 
 	txq = netdev_get_tx_queue(dev, 0);
-	qdisc = rcu_access_pointer(txq->qdisc);
 
-	return !qdisc->enqueue;
+	return qdisc_txq_is_noop(txq);
 }
 
 /* Local traffic destined to local address. Reinsert the packet to rx
diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index d48c657191cd..eb90d5103371 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -803,6 +803,11 @@ static inline bool qdisc_tx_changing(const struct net_device *dev)
 	return false;
 }
 
+static inline bool qdisc_txq_is_noop(const struct netdev_queue *txq)
+{
+	return (rcu_access_pointer(txq->qdisc) == &noop_qdisc);
+}
+
 /* Is the device using the noop qdisc on all queues?  */
 static inline bool qdisc_tx_is_noop(const struct net_device *dev)
 {
@@ -810,7 +815,7 @@ static inline bool qdisc_tx_is_noop(const struct net_device *dev)
 
 	for (i = 0; i < dev->num_tx_queues; i++) {
 		struct netdev_queue *txq = netdev_get_tx_queue(dev, i);
-		if (rcu_access_pointer(txq->qdisc) != &noop_qdisc)
+		if (!qdisc_txq_is_noop(txq))
 			return false;
 	}
 	return true;



