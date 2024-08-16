Return-Path: <bpf+bounces-37353-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CD6954560
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 11:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ED732846C9
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 09:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68239140360;
	Fri, 16 Aug 2024 09:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4nWx4hb/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H9SkJjuF"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA9D13CA9C;
	Fri, 16 Aug 2024 09:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723800253; cv=none; b=XO6qT2VKEWD6CzGTsskeaOOQQMLzG9zFQLEU9JIkp4tmxlkb7L5OKJ2pFidJcJalEVQrK4eYDgjbSdStoNC1N29e4qaIqjX0aSZzcGNN+2RHH5TqrKwaW3jWR0DZR9PdRWyYZFTVarNP95aBAKcHGZt3XRI9/EZDuU8LKGlklhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723800253; c=relaxed/simple;
	bh=tW171kOYcZmd4mFk0mRF/gs59thtIlcEIw5cqoowYlM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r1EcPU4Uw+GXsEgYXAWcwCeNozI/04u5By3tUqEb64tfK+ZuSI0tNgFcQKjCzyPkB1GtWh8Llf2fD9AD2ro3OaYDkcuDf3LX0zrnfalJlLVGB5+f/pxpRvR0KavsZfbR9pYFoySHoYsjnM58ml2rPKt8hW9I2IoF9PMaEnPMtPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4nWx4hb/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H9SkJjuF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723800245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bak+m2qQoBEQzYHvJmjORRQi4Tj5On9ZejuXC/d+69E=;
	b=4nWx4hb/K/UsXkzYYqApOvbdCjONyzCjhDLV0UTfrWiF5aqc7Mg8iOH4KIqntZqEtfQ8fQ
	9EnwAN8zGcZ7YY3ibyp1mgXqJtR/ltF7NmZ3IFG4EuUmMRUfPKtAAtQpZPnPFqKsd99RMZ
	R3IU65l/Bz5uUls5OeWrWbV8nGI2Hj6kJM2eL4PY8heZZEPcQ2iqhXGLRInIphwI//sQF/
	u+i8aJWoXmNWqPHixCWgU8tAy+HbHGHnjIHvsbFCXi15xylMuhdQch9/YWJ62BKgQ/2T5w
	7qTzpQRpWj7Kv0i9+ZoMpK78qLrFamWpNMz9pmDm9YGLhIMCk4sZT6E7yqqAhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723800245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bak+m2qQoBEQzYHvJmjORRQi4Tj5On9ZejuXC/d+69E=;
	b=H9SkJjuFqaoe6ZVoNMhmPqjEyxboXhrC+eu+p7fL5h/qocsdVStcgpJPEpXBUJmJ5coJnv
	Qz6WcDCXQkindEDg==
Date: Fri, 16 Aug 2024 11:24:00 +0200
Subject: [PATCH iwl-next v6 1/6] igb: Always call
 igb_xdp_ring_update_tail() under Tx lock
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-b4-igb_zero_copy-v6-1-4bfb68773b18@linutronix.de>
References: <20240711-b4-igb_zero_copy-v6-0-4bfb68773b18@linutronix.de>
In-Reply-To: <20240711-b4-igb_zero_copy-v6-0-4bfb68773b18@linutronix.de>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Benjamin Steinke <benjamin.steinke@woks-audio.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 Kurt Kanzenbach <kurt@linutronix.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2300; i=kurt@linutronix.de;
 h=from:subject:message-id; bh=U6trs47/PyNyJV/m4Ea4yvgs+072UkD6YSCfX6FH6WE=;
 b=owEBbQKS/ZANAwAKAcGT0fKqRnOCAcsmYgBmvxqyKDiKZjJAp9CblBxFnNhNqSEQqAXGeAt1G
 8Dm1VoIpIGJAjMEAAEKAB0WIQS8ub+yyMN909/bWZLBk9HyqkZzggUCZr8asgAKCRDBk9HyqkZz
 gsL0D/40xSksBfB+rDd3hF91cgxuSCBmJMP2Yyptt0AJ9OVJbG3GfZG9+2/GnXPEgRlt2Sr90aT
 qcpfeQTrMD9FWWCcFx1jIBfWEPKDPWhvb4C9olgaGviYUlDyufdQWc6kHVHr9l+e6m7ekTOEBf/
 XIL5cn1BYbNNJ9/pPftfrdBsxv00Ii+TLBVvP2gvM/6RmSexGUUpFHS+XUb4Cr9d15eWqph0CI9
 ua+5S/FT/zOXMhhwdLH3bKbVJEZzDmPYIZVF29624DEeonFIe7BcUrXUKNxwMO4mS4vUPXSirty
 Nr4idfrE3mhDtA1dbkpnhAdy+IKuJ/wniZym3i/jkY8TxD3Nw43itDId5+nPm8yMjCkADLWwa6G
 TF+unyg3oXk96+OpunovOGeQ/enwg33OCWvPFI0xJHQheDl7zGGzkx2QEF9vQitmF5Q3OGAgJxG
 JZ+E3WUu0yGGti6E1VJBLulclFHsnrXgK1hGAfx7O2xvlmNtf/4mB2TYNB6odsNHzWqBZADKlak
 npMn1vCKsuxIDa7gt1CEqcHSeU5Pvwr8yoibfDTpSEvQmv+yy86fmopSmo45OahZlVDTBd9ou5T
 C0rt8nuTz6Tgs27Mhz/djNNWuciwsEZ/dudCU/FVE9QaLGj8hwuk7Y4SpEXpY6Cq+40gCIj9qeV
 w9CD/EYljYdt4gg==
X-Developer-Key: i=kurt@linutronix.de; a=openpgp;
 fpr=BCB9BFB2C8C37DD3DFDB5992C193D1F2AA467382

From: Sriram Yagnaraman <sriram.yagnaraman@est.tech>

Always call igb_xdp_ring_update_tail() under __netif_tx_lock(), add a
comment to indicate that. This is needed to share the same TX ring between
XDP, XSK and slow paths.

Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
[Kurt: Split patches]
Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 11be39f435f3..4d5e5691c9bd 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -2914,6 +2914,7 @@ static int igb_xdp(struct net_device *dev, struct netdev_bpf *xdp)
 	}
 }
 
+/* This function assumes __netif_tx_lock is held by the caller. */
 static void igb_xdp_ring_update_tail(struct igb_ring *ring)
 {
 	/* Force memory writes to complete before letting h/w know there
@@ -3000,11 +3001,11 @@ static int igb_xdp_xmit(struct net_device *dev, int n,
 		nxmit++;
 	}
 
-	__netif_tx_unlock(nq);
-
 	if (unlikely(flags & XDP_XMIT_FLUSH))
 		igb_xdp_ring_update_tail(tx_ring);
 
+	__netif_tx_unlock(nq);
+
 	return nxmit;
 }
 
@@ -8853,12 +8854,14 @@ static void igb_put_rx_buffer(struct igb_ring *rx_ring,
 
 static int igb_clean_rx_irq(struct igb_q_vector *q_vector, const int budget)
 {
+	unsigned int total_bytes = 0, total_packets = 0;
 	struct igb_adapter *adapter = q_vector->adapter;
 	struct igb_ring *rx_ring = q_vector->rx.ring;
-	struct sk_buff *skb = rx_ring->skb;
-	unsigned int total_bytes = 0, total_packets = 0;
 	u16 cleaned_count = igb_desc_unused(rx_ring);
+	struct sk_buff *skb = rx_ring->skb;
+	int cpu = smp_processor_id();
 	unsigned int xdp_xmit = 0;
+	struct netdev_queue *nq;
 	struct xdp_buff xdp;
 	u32 frame_sz = 0;
 	int rx_buf_pgcnt;
@@ -8986,7 +8989,10 @@ static int igb_clean_rx_irq(struct igb_q_vector *q_vector, const int budget)
 	if (xdp_xmit & IGB_XDP_TX) {
 		struct igb_ring *tx_ring = igb_xdp_tx_queue_mapping(adapter);
 
+		nq = txring_txq(tx_ring);
+		__netif_tx_lock(nq, cpu);
 		igb_xdp_ring_update_tail(tx_ring);
+		__netif_tx_unlock(nq);
 	}
 
 	u64_stats_update_begin(&rx_ring->rx_syncp);

-- 
2.39.2


