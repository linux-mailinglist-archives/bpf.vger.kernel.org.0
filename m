Return-Path: <bpf+bounces-56599-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 642C4A9AE0D
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 14:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C83181B65AC6
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 12:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758F827BF63;
	Thu, 24 Apr 2025 12:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FK+yS8f3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1FB2701AA;
	Thu, 24 Apr 2025 12:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745499409; cv=none; b=FQOITINA86PnEsqN7hO9VPbdCO4MHDUL847bMsxLh0WrR8V6Uo6LyJawOYex+Yhx3oP+b1Rwu4E8mKKWtQFHMif1UEfN2fFKS0MojiUnsI+8dJjdv6I1TBsD9JRPXmdhhY2H0YoP/HadONMbW+EqUArKXHBNRM8UAvjWKfs3+UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745499409; c=relaxed/simple;
	bh=DaXbVItV4vEdJ1PxdCzd1lAzo6REI3kB5/yRt2cUJ1Q=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rvYEuLSbQVQzLov34/DGVB5MjuDG0ZGcNPJqv79xz5DLaBYfQOG57kXwqmn7XJKF5snBqygq2Y1OiKiNnrydTGIkKg0ndc/2Wbpu7y+mFO/JYpkpps/woKhNUQfo9qX3HuT2mCgwmsPPOvAir5V7bnKLgajn2dj1DuzMDFcgqXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FK+yS8f3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3F95C4CEE3;
	Thu, 24 Apr 2025 12:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745499408;
	bh=DaXbVItV4vEdJ1PxdCzd1lAzo6REI3kB5/yRt2cUJ1Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=FK+yS8f39TnBFF/YNxyPxuMXSApGjuYJZoXZvVXHWirUP3BvijrRf7sUxrMQ3apyD
	 lrTzWJBbeCI69MmSczBrDlK73QxLEoGe5/yALuL4ya7WJtasPE9+DIHAf/NS6unRv9
	 ul7eRGw6g3xm7RMCeyTyq98D3XAdpU1HoF4sV+b0a4l5BvrZqwjRE5o6Efne6PK0qS
	 Qv4+/wnvISPQLfH+ElZx4Bb4LAfz55cyKQeT3OmA2ZbzNUDCFZTqygBtXCcV9pMiAr
	 jlojmsf1m3r3JeFktlSvhj6G3YwqXdF+h8xQOfhRf70zYQUYzXZBM+jXgTohct0rt7
	 x+Oxr9Mj6FfWA==
Subject: [PATCH net-next V6 1/2] net: sched: generalize check for no-queue
 qdisc on TX queue
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org,
 tom@herbertland.com, Eric Dumazet <eric.dumazet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 dsahern@kernel.org, makita.toshiaki@lab.ntt.co.jp,
 kernel-team@cloudflare.com, phil@nwl.cc
Date: Thu, 24 Apr 2025 14:56:43 +0200
Message-ID: <174549940355.608169.5089683270353339881.stgit@firesoul>
In-Reply-To: <174549933665.608169.392044991754158047.stgit@firesoul>
References: <174549933665.608169.392044991754158047.stgit@firesoul>
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



