Return-Path: <bpf+bounces-71935-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C5EA8C01F6B
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 17:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 91C4A507BE4
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 15:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5FB3370F0;
	Thu, 23 Oct 2025 14:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PlaN2aSD"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC88333452;
	Thu, 23 Oct 2025 14:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761231577; cv=none; b=L+rZXW6zn7NUwKMzQgw8hJrycoZI7ivsTFynM44ftTH43y8D5987QuxI/xj1sV/XEZQ+xKkkChoY4fv4gKF2I2F/lF7lk0daG21cPoqbkxhJ+VAFvFJ49R2H8JHlRlH0yvAnluPz/wtdkJ/WlyEdfRxzsWzzfMgfnWtm6KMq/NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761231577; c=relaxed/simple;
	bh=mEGb7sJhxpAsby+nkcgfpSTFUr7uvLYxKEWGdriM7AU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QzDgmZKuUVwAhzf0aL11WouBOSczoege5Ntng2Gjj/PJgeGsCb7zixQ4e0rcyVXUVcr1anDjfEGN3CFbzsALGt9uIbLKpcjQuPbUoyA83FHTzlotF/Hdz6I7gLYM2dh48UbPsvl9SwGoOLn5eWGYOAQEpMO9qTxIrNZVo3PVqSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PlaN2aSD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99A20C4CEE7;
	Thu, 23 Oct 2025 14:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761231576;
	bh=mEGb7sJhxpAsby+nkcgfpSTFUr7uvLYxKEWGdriM7AU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=PlaN2aSDl2VV3R1B6IKJF7dgbpvailfkTYGlNomAs923Npb2aqkM3bsEP4o1uQyX8
	 8rVbvDEcjo8Tl7QADG0jePlA8fEgNRvYatTK3Y+689/1xNumbJV3DYllezuoAO/j0m
	 YRVR6IJnEcaJburMly0URgF4aiNWpAMkg+ffSyu8Es8XnP7b5VR7YHevTaUIhtx30y
	 21n2dhBwF7tENaohgFfatLGFzdtU8wkDFNzlkWyJ4Mz4AvMqmt/KVGNBRkr8iZzBTW
	 hUOTNjuVzjE9x8n67xO88inHC7MklA+E5NLKMUrFcvx9vSJd0Si4TF19wtX8xfBUJ0
	 kCxYUb6291oiw==
Subject: [PATCH net V1 1/3] veth: enable dev_watchdog for detecting stalled
 TXQs
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: netdev@vger.kernel.org, makita.toshiaki@lab.ntt.co.jp
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Eric Dumazet <eric.dumazet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, ihor.solodrai@linux.dev,
 toshiaki.makita1@gmail.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@cloudflare.com
Date: Thu, 23 Oct 2025 16:59:31 +0200
Message-ID: <176123157173.2281302.7040578942230212638.stgit@firesoul>
In-Reply-To: <176123150256.2281302.7000617032469740443.stgit@firesoul>
References: <176123150256.2281302.7000617032469740443.stgit@firesoul>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The changes introduced in commit dc82a33297fc ("veth: apply qdisc
backpressure on full ptr_ring to reduce TX drops") have been found to cause
a race condition in production environments.

Under specific circumstances, observed exclusively on ARM64 (aarch64)
systems with Ampere Altra Max CPUs, a transmit queue (TXQ) can become
permanently stalled. This happens when the race condition leads to the TXQ
entering the QUEUE_STATE_DRV_XOFF state without a corresponding queue wake-up,
preventing the attached qdisc from dequeueing packets and causing the
network link to halt.

As a first step towards resolving this issue, this patch introduces a
failsafe mechanism. It enables the net device watchdog by setting a timeout
value and implements the .ndo_tx_timeout callback.

If a TXQ stalls, the watchdog will trigger the veth_tx_timeout() function,
which logs a warning and calls netif_tx_wake_queue() to unstall the queue
and allow traffic to resume.

The log message will look like this:

 veth42: NETDEV WATCHDOG: CPU: 34: transmit queue 0 timed out 5393 ms
 veth42: veth backpressure stalled(n:1) TXQ(0) re-enable

This provides a necessary recovery mechanism while the underlying race
condition is investigated further. Subsequent patches will address the root
cause and add more robust state handling in ndo_open/ndo_stop.

Fixes: dc82a33297fc ("veth: apply qdisc backpressure on full ptr_ring to reduce TX drops")
Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
---
 drivers/net/veth.c |   16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index a3046142cb8e..7b1a9805b270 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -959,8 +959,10 @@ static int veth_xdp_rcv(struct veth_rq *rq, int budget,
 	rq->stats.vs.xdp_packets += done;
 	u64_stats_update_end(&rq->stats.syncp);
 
-	if (peer_txq && unlikely(netif_tx_queue_stopped(peer_txq)))
+	if (peer_txq && unlikely(netif_tx_queue_stopped(peer_txq))) {
+		txq_trans_cond_update(peer_txq);
 		netif_tx_wake_queue(peer_txq);
+	}
 
 	return done;
 }
@@ -1373,6 +1375,16 @@ static int veth_set_channels(struct net_device *dev,
 	goto out;
 }
 
+static void veth_tx_timeout(struct net_device *dev, unsigned int txqueue)
+{
+	struct netdev_queue *txq = netdev_get_tx_queue(dev, txqueue);
+
+	netdev_err(dev, "veth backpressure stalled(n:%ld) TXQ(%u) re-enable\n",
+		   atomic_long_read(&txq->trans_timeout), txqueue);
+
+	netif_tx_wake_queue(txq);
+}
+
 static int veth_open(struct net_device *dev)
 {
 	struct veth_priv *priv = netdev_priv(dev);
@@ -1711,6 +1723,7 @@ static const struct net_device_ops veth_netdev_ops = {
 	.ndo_bpf		= veth_xdp,
 	.ndo_xdp_xmit		= veth_ndo_xdp_xmit,
 	.ndo_get_peer_dev	= veth_peer_dev,
+	.ndo_tx_timeout		= veth_tx_timeout,
 };
 
 static const struct xdp_metadata_ops veth_xdp_metadata_ops = {
@@ -1749,6 +1762,7 @@ static void veth_setup(struct net_device *dev)
 	dev->priv_destructor = veth_dev_free;
 	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
 	dev->max_mtu = ETH_MAX_MTU;
+	dev->watchdog_timeo = msecs_to_jiffies(5000);
 
 	dev->hw_features = VETH_FEATURES;
 	dev->hw_enc_features = VETH_FEATURES;



