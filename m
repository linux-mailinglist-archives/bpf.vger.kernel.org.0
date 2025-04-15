Return-Path: <bpf+bounces-55954-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06AAFA89FCD
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 15:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55C46441916
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 13:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED699192D70;
	Tue, 15 Apr 2025 13:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kn0vo6CQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F36818FDD2;
	Tue, 15 Apr 2025 13:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744724704; cv=none; b=eahQxvgzy8iXncZx9YX5Ap82Fy6xpfQ5/abeQPEnLMjBox72Q4YRsxv13UtFvzbK+/cYjd7GafE56Xt5H9UYkqI8R56JTr9IyMoXLX8g+usF8nxklSr6CO/+CA2/9A7PCbFzElcktTWoJPnROVGw6TT3ULHXudOXODl8M7j3Cqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744724704; c=relaxed/simple;
	bh=xfvsE+GJNMhvR7Eb4Cnn6O5Db8UHQokNj7BMnN4xdUY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QUt0hDUW+c2/tJDhxJWiRZxOfocXDMzuxXlShsZOmaMaDelhuYINOpWY0qBDfzNGZS8OzKFPElXNLcOuiyvh2631vQ3kkx+YHcWggc+fHQGTjZDtJx+N40L9gaf0/aFvYQI2bVPyLXK5PA2s5kmyihNWgJy4oSqddTtq7tOaQXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kn0vo6CQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61691C4CEEC;
	Tue, 15 Apr 2025 13:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744724703;
	bh=xfvsE+GJNMhvR7Eb4Cnn6O5Db8UHQokNj7BMnN4xdUY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=kn0vo6CQtzndmcD4GwSJaDAJGs/pgCAbP4/T0EStG0b2ubZiyYjCbZInh1v+MH+oM
	 alsUW2jiC4uf1aCHqw76Vfk0mlm3Wi96dfpaSSp3+xEYo+fmYMGCYKntDKOh9McbES
	 +ZHL079abH0RSSr6BFbDmMc3MBTIvGfQ/UqxOPqkT8uNZ7TUtALbtR9XqPbjlseIx1
	 99f5v/b0iwU4SlRQHRsKj2SHnlMAnJPjyoonLchfs37SSs7rwvi0cJZnWENNKRPaJs
	 5SFHKKWgFFnsUxqU9fzdgXMq3WbvDKWjT6vsXacH96nHb/fVCGA2C85Rmn65CEey9c
	 kIMvmOQwGXC5A==
Subject: [PATCH net-next V4 1/2] net: sched: generalize check for no-queue
 qdisc on TX queue
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org,
 tom@herbertland.com, Eric Dumazet <eric.dumazet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 dsahern@kernel.org, makita.toshiaki@lab.ntt.co.jp,
 kernel-team@cloudflare.com, phil@nwl.cc
Date: Tue, 15 Apr 2025 15:44:59 +0200
Message-ID: <174472469906.274639.14909448343817900822.stgit@firesoul>
In-Reply-To: <174472463778.274639.12670590457453196991.stgit@firesoul>
References: <174472463778.274639.12670590457453196991.stgit@firesoul>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

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



