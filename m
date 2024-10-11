Return-Path: <bpf+bounces-41731-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81580999F9F
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 11:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12E51B21DCB
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 09:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB89D20FA9B;
	Fri, 11 Oct 2024 09:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xmI8egAA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2q6fvdvX"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958DB208996;
	Fri, 11 Oct 2024 09:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728637275; cv=none; b=r935Wr5JWYf0yj0Tj5nYP39YP19BDxz0hfIGXb+A9Rlsa0fHpbCfICkqg+2Hngncq889MTAz00q7/USdsV3sEglb2WauKi2vhtjaVObo5vswJAL7s3mTSBTN0nWjjbPRcel+NlnIK/4F3WWK5hPtKaJP1hjjOKUen7dUydWyl9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728637275; c=relaxed/simple;
	bh=RxSqs8NhiCYm+wD9waRwQ/hZJZEj5uRwsmB4iDu6ApA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h8NCg/AxWTllSynVDVCIXmxJLZqdxBrjpqN/eg1bjRreTr5D++t1sJpOoZdU57ahBLw84UOOcjknH+dcxagVvVbDrxTdYXzJSybjkxwi8MSuXUkanFuCDipjTNX0QQDBi0ZWs+wkU0DzU/CYIgVquF1MR0gittJmbXAo3ITsF7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xmI8egAA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2q6fvdvX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728637271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J5c9Dqq0SnHXxdpQbse0l3LR2qIrtWblfzrhDH1purg=;
	b=xmI8egAAOqsFSjIqNWLxrlw9rItVF5I6GTvRCmqb7F5JtTVEtjzDFauiIOm2McIVnTWKDU
	Mbv/K1QsgLoQGEjJ7XihWA/ecoZ1dsV13+7SjHjmyuvfBqHlSXXIRu8T+ulmP82oMrKHMP
	dxTXrkMUevduumCGF/1pYRXZovBrAym+a90VLbALkwAzQ4iDZxYjJr+IZ1ShANAo5nvNib
	eoG4lx6GPsB5nvjJbc4sI4Hqv4sH0IPZW5LYZHNMo5Vo7wPY0dWr00fQuUXsl4yN4+UWtr
	3a0DqgBVY8Maf9tYtCpPDH6j3hROT5nIUb0x5uEcOIhIBnTEKbgHMF/0WvKfSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728637271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J5c9Dqq0SnHXxdpQbse0l3LR2qIrtWblfzrhDH1purg=;
	b=2q6fvdvXtufkhlqawip3Xt2+JpTPCH8dqQn8800lPRktyJbJCDq5WQeC6P/B+tpe9cfS2E
	yKclC/TEDPQ22tAw==
Date: Fri, 11 Oct 2024 11:01:02 +0200
Subject: [PATCH iwl-next v8 4/6] igb: Add XDP finalize and stats update
 functions
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241011-b4-igb_zero_copy-v8-4-83862f726a9e@linutronix.de>
References: <20241011-b4-igb_zero_copy-v8-0-83862f726a9e@linutronix.de>
In-Reply-To: <20241011-b4-igb_zero_copy-v8-0-83862f726a9e@linutronix.de>
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
 bpf@vger.kernel.org, Kurt Kanzenbach <kurt@linutronix.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3889; i=kurt@linutronix.de;
 h=from:subject:message-id; bh=RxSqs8NhiCYm+wD9waRwQ/hZJZEj5uRwsmB4iDu6ApA=;
 b=owEBbQKS/ZANAwAKAcGT0fKqRnOCAcsmYgBnCOlTqSmw3OePjAE9hCRD2mHxyW7+ltzSzvuKP
 rZ/6WyYY5SJAjMEAAEKAB0WIQS8ub+yyMN909/bWZLBk9HyqkZzggUCZwjpUwAKCRDBk9HyqkZz
 gmnkD/0fQgyFnD06Li6sJKjVRhZrPpeuGVsgAbpjD+vsCoDOpvKwH7sq7iiELw7xm89NL1fK0eI
 ru+tHymK8bKzjZhx45kLwndvDQJPYA3JVJ5iSER/MjAPZBtmyqOOXGb93b+L4I2bOu+z61oxqiA
 W4DxoE5wMeYwhbxVWmMlH6+iSIrhKD4ZtCFpvtCeG95WQ+ZtlCDlSqgz5kGreNwzx2QRKPtueCr
 krwZeek2WCPu4dNfijRXMhm8vzU1RAleFZXZEqM156/IfEjmx+7yBMVa80ouvsAmP5TtBloLqlq
 rGAEnFriEGFR2c5SRCVPMZiXX2MbfofTlq/1oRqqeedbjQX9pNDm6QAB4VzLMd/aWFwoDJno9nz
 wZa16bw4ZTpcy8LuITr/McL8aLtQ1kQaS5JTqL6DYYJloQmm7K5v4pC0AWBEi1QvuH5Ejt8GXBe
 6VGGDa6/QWGlTbn5p0QrK5y1iqU0qjdeuNAomp2Lnh3KaKqiuoWgMo3bflx3DCz9FhA0GsCmw35
 s7PB9tWWRTHNxnfakrCIA5ZWl82mxKt+IJa0oZDgV/W2MBAbbO8ozROUauJn4bs4UtrbfjbsNVs
 qNqn7y4ixwed+pFDCKA/JZohQOFoa1npd5+qqiFRgqRZiGAIDaisDU4aiY1w2N5OefuC8On/YHx
 2tfIwwwQNoBp7Ow==
X-Developer-Key: i=kurt@linutronix.de; a=openpgp;
 fpr=BCB9BFB2C8C37DD3DFDB5992C193D1F2AA467382

Move XDP finalize and Rx statistics update into separate functions. This
way, they can be reused by the XDP and XDP/ZC code later.

Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
---
 drivers/net/ethernet/intel/igb/igb.h      |  3 ++
 drivers/net/ethernet/intel/igb/igb_main.c | 54 ++++++++++++++++++++-----------
 2 files changed, 38 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
index c30d6f9708f8..1e65b41a48d8 100644
--- a/drivers/net/ethernet/intel/igb/igb.h
+++ b/drivers/net/ethernet/intel/igb/igb.h
@@ -740,6 +740,9 @@ void igb_clean_tx_ring(struct igb_ring *tx_ring);
 void igb_clean_rx_ring(struct igb_ring *rx_ring);
 void igb_configure_tx_ring(struct igb_adapter *, struct igb_ring *);
 void igb_configure_rx_ring(struct igb_adapter *, struct igb_ring *);
+void igb_finalize_xdp(struct igb_adapter *adapter, unsigned int status);
+void igb_update_rx_stats(struct igb_q_vector *q_vector, unsigned int packets,
+			 unsigned int bytes);
 void igb_setup_tctl(struct igb_adapter *);
 void igb_setup_rctl(struct igb_adapter *);
 void igb_setup_srrctl(struct igb_adapter *, struct igb_ring *);
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 341b83e39019..4d3aed6cd848 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -8852,6 +8852,38 @@ static void igb_put_rx_buffer(struct igb_ring *rx_ring,
 	rx_buffer->page = NULL;
 }
 
+void igb_finalize_xdp(struct igb_adapter *adapter, unsigned int status)
+{
+	int cpu = smp_processor_id();
+	struct netdev_queue *nq;
+
+	if (status & IGB_XDP_REDIR)
+		xdp_do_flush();
+
+	if (status & IGB_XDP_TX) {
+		struct igb_ring *tx_ring = igb_xdp_tx_queue_mapping(adapter);
+
+		nq = txring_txq(tx_ring);
+		__netif_tx_lock(nq, cpu);
+		igb_xdp_ring_update_tail(tx_ring);
+		__netif_tx_unlock(nq);
+	}
+}
+
+void igb_update_rx_stats(struct igb_q_vector *q_vector, unsigned int packets,
+			 unsigned int bytes)
+{
+	struct igb_ring *ring = q_vector->rx.ring;
+
+	u64_stats_update_begin(&ring->rx_syncp);
+	ring->rx_stats.packets += packets;
+	ring->rx_stats.bytes += bytes;
+	u64_stats_update_end(&ring->rx_syncp);
+
+	q_vector->rx.total_packets += packets;
+	q_vector->rx.total_bytes += bytes;
+}
+
 static int igb_clean_rx_irq(struct igb_q_vector *q_vector, const int budget)
 {
 	unsigned int total_bytes = 0, total_packets = 0;
@@ -8859,9 +8891,7 @@ static int igb_clean_rx_irq(struct igb_q_vector *q_vector, const int budget)
 	struct igb_ring *rx_ring = q_vector->rx.ring;
 	u16 cleaned_count = igb_desc_unused(rx_ring);
 	struct sk_buff *skb = rx_ring->skb;
-	int cpu = smp_processor_id();
 	unsigned int xdp_xmit = 0;
-	struct netdev_queue *nq;
 	struct xdp_buff xdp;
 	u32 frame_sz = 0;
 	int rx_buf_pgcnt;
@@ -8983,24 +9013,10 @@ static int igb_clean_rx_irq(struct igb_q_vector *q_vector, const int budget)
 	/* place incomplete frames back on ring for completion */
 	rx_ring->skb = skb;
 
-	if (xdp_xmit & IGB_XDP_REDIR)
-		xdp_do_flush();
-
-	if (xdp_xmit & IGB_XDP_TX) {
-		struct igb_ring *tx_ring = igb_xdp_tx_queue_mapping(adapter);
-
-		nq = txring_txq(tx_ring);
-		__netif_tx_lock(nq, cpu);
-		igb_xdp_ring_update_tail(tx_ring);
-		__netif_tx_unlock(nq);
-	}
+	if (xdp_xmit)
+		igb_finalize_xdp(adapter, xdp_xmit);
 
-	u64_stats_update_begin(&rx_ring->rx_syncp);
-	rx_ring->rx_stats.packets += total_packets;
-	rx_ring->rx_stats.bytes += total_bytes;
-	u64_stats_update_end(&rx_ring->rx_syncp);
-	q_vector->rx.total_packets += total_packets;
-	q_vector->rx.total_bytes += total_bytes;
+	igb_update_rx_stats(q_vector, total_packets, total_bytes);
 
 	if (cleaned_count)
 		igb_alloc_rx_buffers(rx_ring, cleaned_count);

-- 
2.39.5


