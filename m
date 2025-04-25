Return-Path: <bpf+bounces-56699-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A13A9CC25
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 16:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DAD77B7F7F
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 14:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4844258CCE;
	Fri, 25 Apr 2025 14:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jMri0RCL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C8984E1C;
	Fri, 25 Apr 2025 14:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745592939; cv=none; b=lcRk6KxmeUqOd+TcBKOc+y7O9hImrHLhzssnEc9jC3ic4UN0VpGAYqpt6ZnpgqLA0v7t540+tjaKttEx1lqXPLlQzGuxzfhT3vvDGNsVbsCLCqR6ks+C3xrKbAGD4nURohiTvJrsAg1C8ilJOjv2YNaxMLjBxELYSqUTIFOYHVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745592939; c=relaxed/simple;
	bh=DaXbVItV4vEdJ1PxdCzd1lAzo6REI3kB5/yRt2cUJ1Q=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZhR26RMbQ6PKRfaEjMBXB1IRatPPYh8v/cyRF72bNMYZydchlHzny4WCa+0/X7wwwGm8zBQoqWYVt0Zx0/kPjrHE7+BeFMK9tli9eVx4mcGyXwzy69+ZLVto2QjhEMz/D7XdDReirjRdObaFYD6m/S5aRt22IawTLu2ddlmiYQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jMri0RCL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 202ECC4CEE4;
	Fri, 25 Apr 2025 14:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745592938;
	bh=DaXbVItV4vEdJ1PxdCzd1lAzo6REI3kB5/yRt2cUJ1Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=jMri0RCLiZ3fThC4qw+BwF93wANj588iE5W7SKTUim/ZuM8PZgXQ5ErCokAPxzEKG
	 hFCZSLh3RJjymLdTajct8USH3RfKNtsWefdGia+nzNxZB7q4zWjtNyzgzJDshXWG/0
	 SA1n35Uf3Shg6IuOnp1/dtB6dguo7HN2PtnOU+7AKpccKRYetciy1OdBh5qPxcu0Xn
	 qgKGc4OHnsWd71RYlZj/xSWNArjrpBNCVgQtp2ZJd/a9bRK1bKa8qnkofc5lG5Tlsw
	 S/zkRMjdTbuo4Ta/8+6yb3yfWgk5ExvKS+3mawbIryLhyJp4THMdplTwDjZASvJysG
	 sEUFV9FocY8GQ==
Subject: [PATCH net-next V7 1/2] net: sched: generalize check for no-queue
 qdisc on TX queue
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org,
 tom@herbertland.com, Eric Dumazet <eric.dumazet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 dsahern@kernel.org, makita.toshiaki@lab.ntt.co.jp,
 kernel-team@cloudflare.com, phil@nwl.cc
Date: Fri, 25 Apr 2025 16:55:31 +0200
Message-ID: <174559293172.827981.7583862632045264175.stgit@firesoul>
In-Reply-To: <174559288731.827981.8748257839971869213.stgit@firesoul>
References: <174559288731.827981.8748257839971869213.stgit@firesoul>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The "noqueue" qdisc can either be directly attached, or get default
attached if net_device priv_flags has IFF_NO_QUEUE. In both cases, the
allocated Qdisc structure gets it's enqueue function pointer reset to
NULL by noqueue_init() via noqueue_qdisc_ops.

This is a common case for software virtual net_devices. For these devices
with no-queue, the transmission path in __dev_queue_xmit() will bypass
the qdisc layer. Directly invoking device drivers ndo_start_xmit (via
dev_hard_start_xmit).  In this mode the device driver is not allowed to
ask for packets to be queued (either via returning NETDEV_TX_BUSY or
stopping the TXQ).

The simplest and most reliable way to identify this no-queue case is by
checking if enqueue == NULL.

The vrf driver currently open-codes this check (!qdisc->enqueue). While
functionally correct, this low-level detail is better encapsulated in a
dedicated helper for clarity and long-term maintainability.

To make this behavior more explicit and reusable, this patch introduce a
new helper: qdisc_txq_has_no_queue(). Helper will also be used by the
veth driver in the next patch, which introduces optional qdisc-based
backpressure.

This is a non-functional change.

Reviewed-by: David Ahern <dsahern@kernel.org>
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
---
 drivers/net/vrf.c         |    4 +---
 include/net/sch_generic.h |    8 ++++++++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index 7168b33adadb..9a4beea6ee0c 100644
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
+	return qdisc_txq_has_no_queue(txq);
 }
 
 /* Local traffic destined to local address. Reinsert the packet to rx
diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index d48c657191cd..b6c177f7141c 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -803,6 +803,14 @@ static inline bool qdisc_tx_changing(const struct net_device *dev)
 	return false;
 }
 
+/* "noqueue" qdisc identified by not having any enqueue, see noqueue_init() */
+static inline bool qdisc_txq_has_no_queue(const struct netdev_queue *txq)
+{
+	struct Qdisc *qdisc = rcu_access_pointer(txq->qdisc);
+
+	return qdisc->enqueue == NULL;
+}
+
 /* Is the device using the noop qdisc on all queues?  */
 static inline bool qdisc_tx_is_noop(const struct net_device *dev)
 {



