Return-Path: <bpf+bounces-70555-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C54D2BC2F06
	for <lists+bpf@lfdr.de>; Wed, 08 Oct 2025 01:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 217C64E8680
	for <lists+bpf@lfdr.de>; Tue,  7 Oct 2025 23:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62F62641E7;
	Tue,  7 Oct 2025 23:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TvtuFxmG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C24261B94;
	Tue,  7 Oct 2025 23:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759879629; cv=none; b=e7FgBF/2+OxyZUOIoLUvK68QczoaTWDV8SrN2LZcM2bQec6BI38N8Q0538si/idANKa8nBKaHLCkzMbSYUrQOV+hr64JuVgLkZSJsS16fiU0od67bOz3CjgiUZt+ULv4hkoC7r7SJihunDTJJAAeyK6qr/EYlbBLmXywGNVgAnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759879629; c=relaxed/simple;
	bh=c9v3tYwHAbfDId9cJSfUbArwcR9x7GiTv3l/aySt2do=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i5QHeJGDPwtFz/jFJLna5q1Usd9WDBKIKcroiyxIxtqfV++vCMxwVjmMPelDFFw9vkHBCpG8xCh8E/PNgXWvOSbrtABygSgmexllWc0ExV8GUI4sF8jJpR0TLbWbWVj0FYvfsO/mAV8VnEhl/hUKGSxFsCpqZVDLvqHG+5rI7GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TvtuFxmG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E128C4CEF1;
	Tue,  7 Oct 2025 23:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759879627;
	bh=c9v3tYwHAbfDId9cJSfUbArwcR9x7GiTv3l/aySt2do=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TvtuFxmGO495odf+FAngx4UJ/DP1A1Vrs5oTbta34PFsJBa/1FS54Deuc9nWIgTJt
	 /znALaFisqYw0mlzmSo1ETbEdHEoAe04rdoShayMezIs4kpxvgg/QEHkDaW/GlG3wx
	 /9kZDFRY+yedWN5yYEu86u/u7ANAgRMFo9kL1MTH49VSyJt+rLetF6dh0a4fHBEUNa
	 1ep94q+X4hLWAlW3oHuzDwXJs9wdse5/SUdjm16b8wzH06B6ReM8gKVvfvElk/s/fU
	 3WW8pLj67+/8RTgK9qyz4hQ7S1FWAZTFINjK0ZeBeOPiiv26ejorDaLKgELIBLMkev
	 SPkxW7eiTGigg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	bpf@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	alexanderduyck@fb.com,
	sdf@fomichev.me,
	mohsin.bashr@gmail.com
Subject: [PATCH net v2 3/9] eth: fbnic: fix saving stats from XDP_TX rings on close
Date: Tue,  7 Oct 2025 16:26:47 -0700
Message-ID: <20251007232653.2099376-4-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251007232653.2099376-1-kuba@kernel.org>
References: <20251007232653.2099376-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When rings are freed - stats get added to the device level stat
structs. Save the stats from the XDP_TX ring just as Tx stats.
Previously they would be saved to Rx and Tx stats. So we'd not
see XDP_TX packets as Rx during runtime but after an down/up cycle
the packets would appear in stats.

Correct the helper used by ethtool code which does a runtime
config switch.

Reviewed-by: Simon Horman <horms@kernel.org>
Fixes: 5213ff086344 ("eth: fbnic: Collect packet statistics for XDP")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: alexanderduyck@fb.com
CC: sdf@fomichev.me
CC: mohsin.bashr@gmail.com
CC: bpf@vger.kernel.org
---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h    | 2 ++
 drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c | 2 +-
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c    | 8 +++-----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
index 31fac0ba0902..4a41e21ed542 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
@@ -167,6 +167,8 @@ void fbnic_aggregate_ring_rx_counters(struct fbnic_net *fbn,
 				      struct fbnic_ring *rxr);
 void fbnic_aggregate_ring_tx_counters(struct fbnic_net *fbn,
 				      struct fbnic_ring *txr);
+void fbnic_aggregate_ring_xdp_counters(struct fbnic_net *fbn,
+				       struct fbnic_ring *xdpr);
 
 int fbnic_alloc_napi_vectors(struct fbnic_net *fbn);
 void fbnic_free_napi_vectors(struct fbnic_net *fbn);
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
index a1c2db69b198..a37906b70c3a 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
@@ -185,7 +185,7 @@ static void fbnic_aggregate_vector_counters(struct fbnic_net *fbn,
 
 	for (i = 0; i < nv->txt_count; i++) {
 		fbnic_aggregate_ring_tx_counters(fbn, &nv->qt[i].sub0);
-		fbnic_aggregate_ring_tx_counters(fbn, &nv->qt[i].sub1);
+		fbnic_aggregate_ring_xdp_counters(fbn, &nv->qt[i].sub1);
 		fbnic_aggregate_ring_tx_counters(fbn, &nv->qt[i].cmpl);
 	}
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index a56dc148f66d..26328e8090c6 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -1433,8 +1433,8 @@ void fbnic_aggregate_ring_tx_counters(struct fbnic_net *fbn,
 	BUILD_BUG_ON(sizeof(fbn->tx_stats.twq) / 8 != 6);
 }
 
-static void fbnic_aggregate_ring_xdp_counters(struct fbnic_net *fbn,
-					      struct fbnic_ring *xdpr)
+void fbnic_aggregate_ring_xdp_counters(struct fbnic_net *fbn,
+				       struct fbnic_ring *xdpr)
 {
 	struct fbnic_queue_stats *stats = &xdpr->stats;
 
@@ -1442,9 +1442,7 @@ static void fbnic_aggregate_ring_xdp_counters(struct fbnic_net *fbn,
 		return;
 
 	/* Capture stats from queues before dissasociating them */
-	fbn->rx_stats.bytes += stats->bytes;
-	fbn->rx_stats.packets += stats->packets;
-	fbn->rx_stats.dropped += stats->dropped;
+	fbn->tx_stats.dropped += stats->dropped;
 	fbn->tx_stats.bytes += stats->bytes;
 	fbn->tx_stats.packets += stats->packets;
 }
-- 
2.51.0


