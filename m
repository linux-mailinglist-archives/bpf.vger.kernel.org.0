Return-Path: <bpf+bounces-55862-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9A7A887B3
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 17:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5A463A8E1C
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 15:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E57627B504;
	Mon, 14 Apr 2025 15:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mQXp6TNE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EB31F92E;
	Mon, 14 Apr 2025 15:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744645555; cv=none; b=Jvh21GGRdGj9lyqt13bl7DbCHzg63/HQ3Aspn7NeN961+Ub2FMvRXuUMTBAKGeQC5pFSWNMts2i3oW6t9+M9ikXIHMnMdjjP7qR2Scd7ALxC0LHxk9hpt/rH7XDnSS7La6IQMlNUqJ+03rZDaqZn9kVZseAOsRhpOXQUjCLkAQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744645555; c=relaxed/simple;
	bh=qW/iEZSmptKVmguSwrimgXAbe5PaLzBos/5ELdpZOA8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DzGLaadcBkTpArf9vOVlgHrUnRXzA0P3F6tygdTknspO9yvPUz9ix/lAul2Q7LgNPFG95xcMuMl8ogocSPoSaGSyKUjAuVNXJS8IdxnCqB7ybE4hDBgliUAZTxEd10qiTxMU1f71pf2vESrWGai+n8WHcv2CPBBsqZ/pd/veIoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mQXp6TNE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDAFFC4CEE2;
	Mon, 14 Apr 2025 15:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744645555;
	bh=qW/iEZSmptKVmguSwrimgXAbe5PaLzBos/5ELdpZOA8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=mQXp6TNEHs+NyrWQgdOlD5Apw/dxN/vjUXmXOxA+ZkrX556AnUm4KiKhjTVweC5I1
	 0ny8tuF8+Rwyxc/AokzBdFB2AYzT1AtGPwvm1448ZI/Z1vBiX+w6LWtvqFBSMAdFz3
	 YEHJWFMQjfdblwvPtkWKzF+x1szTSqa4kixzKt3rKQXE4nRjMwETaifGtU1VL0ENnV
	 dm5wThcJetPbZ1EIPBMx24cGIsSYOmKTL96oTE3WbKtJipiFLHt3Wyh301roAjjtF0
	 JpbX6aiyi85YHcFH93vrRYq1usTV5v2esQwxDAtOyhNWUJWKCdcrESJ6KBiySNnHFC
	 4Mc8HLyXXDDlw==
Subject: [PATCH net-next RFC V3 1/2] net: sched: generalize check for no-op
 qdisc on TX queue
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org,
 tom@herbertland.com, Eric Dumazet <eric.dumazet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 dsahern@kernel.org, makita.toshiaki@lab.ntt.co.jp, kernel-team@cloudflare.com
Date: Mon, 14 Apr 2025 17:45:50 +0200
Message-ID: <174464555063.20396.9545196538212416415.stgit@firesoul>
In-Reply-To: <174464549885.20396.6987653753122223942.stgit@firesoul>
References: <174464549885.20396.6987653753122223942.stgit@firesoul>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

WARNING: Testing show this is NOT correct!
 - I need help figuring out why this patch is incorrect.
 - Testing against &noop_qdisc is not the same as q->enqueue == NULL
 - I copied test (txq->qdisc == &noop_qdisc) from qdisc_tx_is_noop
 - Q: is qdisc_tx_is_noop() function incorrect?

The vrf driver includes an open-coded check to determine whether a TX
queue (netdev_queue) has a real qdisc attached. This is done by testing
whether qdisc->enqueue is NULL, which is functionally equivalent to
checking whether the qdisc is &noop_qdisc.

This equivalence stems from noqueue_init(), which explicitly clears the
enqueue pointer to signal no-op behavior to __dev_queue_xmit().

This patch introduces a shared helper, qdisc_txq_is_noop(), to clarify
intent and make this logic reusable. The vrf driver is updated to use
this new helper.

Subsequent patches will make further use of this helper in other drivers,
such as veth.

This is a non-functional change.

Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
---
 drivers/net/vrf.c         |    4 +---
 include/net/sch_generic.h |    7 ++++++-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index 7168b33adadb..f0a24fc85945 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -343,15 +343,13 @@ static int vrf_ifindex_lookup_by_table_id(struct net *net, u32 table_id)
 static bool qdisc_tx_is_default(const struct net_device *dev)
 {
 	struct netdev_queue *txq;
-	struct Qdisc *qdisc;
 
 	if (dev->num_tx_queues > 1)
 		return false;
 
 	txq = netdev_get_tx_queue(dev, 0);
-	qdisc = rcu_access_pointer(txq->qdisc);
 
-	return !qdisc->enqueue;
+	return qdisc_txq_is_noop(txq);
 }
 
 /* Local traffic destined to local address. Reinsert the packet to rx
diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index d48c657191cd..a1f5560350a6 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -803,6 +803,11 @@ static inline bool qdisc_tx_changing(const struct net_device *dev)
 	return false;
 }
 
+static inline bool qdisc_txq_is_noop(const struct netdev_queue *txq)
+{
+	return rcu_access_pointer(txq->qdisc) == &noop_qdisc;
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



