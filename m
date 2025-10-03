Return-Path: <bpf+bounces-70359-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A38B1BB867C
	for <lists+bpf@lfdr.de>; Sat, 04 Oct 2025 01:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 887E24A2788
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 23:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CCEE2820A4;
	Fri,  3 Oct 2025 23:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZo/wuN+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080BD27B33E;
	Fri,  3 Oct 2025 23:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759534258; cv=none; b=nMB1jbNn4HByZN0gNNImcMII9N4vhhQQOkv40mMi+xMlrZZR58ranUW5ud6KFKPtrwcD/Q3qDLvLa83EYXMUhivG0NK7eGKV2kzjhBKKO04MGxIxRCcFc8XmxhXn2flVlWvUx05zvs+Mpt0YED5lrByLFW20sOYXKnHliI2gSxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759534258; c=relaxed/simple;
	bh=QiAzhsgrRgUhIgzZ77fKjTI9YtNjD4UF2UfTJbalx6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RLHle/azca9IPuOH652XgkjocWGYubpco7RTB1G+yqsih1+3aelR2EctMS4h5SSOSH+2XH9SGq+9Ci62XnTkrXWBbK8a21xUgULbXzoouMM+ZM5mUBrn2gyFQJ5QTcGOBODpjaY0GxZcFtT7sns4Ox25kdPl1jeK7lunV9F55ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZo/wuN+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E83BC4CEFD;
	Fri,  3 Oct 2025 23:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759534257;
	bh=QiAzhsgrRgUhIgzZ77fKjTI9YtNjD4UF2UfTJbalx6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jZo/wuN+Ut3PtSe6R+h+OduGewomxni0y9JFDszXUbBwICTTHo5qlOeqnnVRv1ftf
	 wl9B8Nl8URtGjO4NvBOY1O3PEdCdIAMlXe6Qu/g0/hzbe/AKYe0Wohux6BreyUYZGm
	 CHXmMNLw6XV/ycXSWuwWWq6iZTs+cLksMze7QJHp3f4Wv59ecp3NKKCePOLQqCI6b6
	 wSklfA9+xgnBWTXDA2lFwc9BM62GlM5FAeeBwFRVLJNq6apsxy0Y7eE3f62zUnr4EG
	 uLQlYVPwipA2UXu+dU+eqEd8MVjIGKWkTtbs506B7dObhLqMkDqmJFZv9+SyUw5v02
	 kAINS55cdpV9Q==
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
Subject: [PATCH net 3/9] eth: fbnic: fix saving stats from XDP_TX rings on close
Date: Fri,  3 Oct 2025 16:30:19 -0700
Message-ID: <20251003233025.1157158-4-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003233025.1157158-1-kuba@kernel.org>
References: <20251003233025.1157158-1-kuba@kernel.org>
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
index b00d44926ba1..fee2369c2cef 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -1435,8 +1435,8 @@ void fbnic_aggregate_ring_tx_counters(struct fbnic_net *fbn,
 	BUILD_BUG_ON(sizeof(fbn->tx_stats.twq) / 8 != 6);
 }
 
-static void fbnic_aggregate_ring_xdp_counters(struct fbnic_net *fbn,
-					      struct fbnic_ring *xdpr)
+void fbnic_aggregate_ring_xdp_counters(struct fbnic_net *fbn,
+				       struct fbnic_ring *xdpr)
 {
 	struct fbnic_queue_stats *stats = &xdpr->stats;
 
@@ -1444,9 +1444,7 @@ static void fbnic_aggregate_ring_xdp_counters(struct fbnic_net *fbn,
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


