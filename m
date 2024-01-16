Return-Path: <bpf+bounces-19652-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FD782F8B7
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 21:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FA76B23A2B
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 20:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C9C2563C;
	Tue, 16 Jan 2024 19:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RCy6UDfY"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AA4135411;
	Tue, 16 Jan 2024 19:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434769; cv=none; b=u/pv7x8CmNaX0I45uBPyk3iSeMIX9JRi7RnWYIlMH7L/bHLC7vVVkmit1xlUSlTLNV0ocHPXP8r3mkxuigO7o3aSBwYPnpV7voUsGXzsR8QKuJrJaDG/rYHdM5yg4RIThN5ZrreEWzkuW/bkp0c7KbeFk1Eb2vJ+UwXFGD1wTFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434769; c=relaxed/simple;
	bh=Eq9KS9R2ANyGRZukR1Q7siHbtI5EWQTRdMAJgPNQPhg=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=RdTVBdaCBEkik59G6ydXFQ+IZfB6ZywhLh/6UTDLPKP/z0wjfvqId2f/wZDuy0z7yaNckkCxcwlT9N9JB7kdssSMfwDoWBg40aYOR6uDo7VA3xbLNeBHeVnamBR5CtXI1WeuoLq8wbfaQibqxKVXuMoZ6JOOb2EiON/VTiH4SCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RCy6UDfY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 781C6C43394;
	Tue, 16 Jan 2024 19:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434768;
	bh=Eq9KS9R2ANyGRZukR1Q7siHbtI5EWQTRdMAJgPNQPhg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RCy6UDfYLUr99Kt5eQ4OluCKyHpeb3U8kBQxbW4+c9XwwfLmhChf6PEWH0U9wNzr3
	 w1X2ingXzGqL4d/paiLK+km/MU4l9mntQ1vbv0BvCmLPuwO3+MxZAzEJgZl77HBR1s
	 7+E1Z13NN+uRStasiS+kvS/5LfvJIBRLCtlk/3bELqD5p69vo/5wBb2M3S4lWMMHfC
	 lqseTbEuSd2TX4I0lSYXS/ZPx52NsWiHvjTVs9fRpOYwo5snmT3Z8Y1BifMG7wWlRY
	 1u836MTxXp/WpSKMONZ4d6fALcBnz6xAFy1OmPjtcUfWP2nPsOJ7MAvgLSyq/HO44K
	 Xt03QbFHNSlqA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Igor Russkikh <irusskikh@marvell.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	epomozov@marvell.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 075/104] net: atlantic: eliminate double free in error handling logic
Date: Tue, 16 Jan 2024 14:46:41 -0500
Message-ID: <20240116194908.253437-75-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194908.253437-1-sashal@kernel.org>
References: <20240116194908.253437-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
Content-Transfer-Encoding: 8bit

From: Igor Russkikh <irusskikh@marvell.com>

[ Upstream commit b3cb7a830a24527877b0bc900b9bd74a96aea928 ]

Driver has a logic leak in ring data allocation/free,
where aq_ring_free could be called multiple times on same ring,
if system is under stress and got memory allocation error.

Ring pointer was used as an indicator of failure, but this is
not correct since only ring data is allocated/deallocated.
Ring itself is an array member.

Changing ring allocation functions to return error code directly.
This simplifies error handling and eliminates aq_ring_free
on higher layer.

Signed-off-by: Igor Russkikh <irusskikh@marvell.com>
Link: https://lore.kernel.org/r/20231213095044.23146-1-irusskikh@marvell.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/aquantia/atlantic/aq_ptp.c   | 28 +++------
 .../net/ethernet/aquantia/atlantic/aq_ring.c  | 61 +++++--------------
 .../net/ethernet/aquantia/atlantic/aq_ring.h  | 22 +++----
 .../net/ethernet/aquantia/atlantic/aq_vec.c   | 23 +++----
 4 files changed, 47 insertions(+), 87 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c b/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c
index 28c9b6f1a54f..abd4832e4ed2 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c
@@ -953,8 +953,6 @@ int aq_ptp_ring_alloc(struct aq_nic_s *aq_nic)
 {
 	struct aq_ptp_s *aq_ptp = aq_nic->aq_ptp;
 	unsigned int tx_ring_idx, rx_ring_idx;
-	struct aq_ring_s *hwts;
-	struct aq_ring_s *ring;
 	int err;
 
 	if (!aq_ptp)
@@ -962,29 +960,23 @@ int aq_ptp_ring_alloc(struct aq_nic_s *aq_nic)
 
 	tx_ring_idx = aq_ptp_ring_idx(aq_nic->aq_nic_cfg.tc_mode);
 
-	ring = aq_ring_tx_alloc(&aq_ptp->ptp_tx, aq_nic,
-				tx_ring_idx, &aq_nic->aq_nic_cfg);
-	if (!ring) {
-		err = -ENOMEM;
+	err = aq_ring_tx_alloc(&aq_ptp->ptp_tx, aq_nic,
+			       tx_ring_idx, &aq_nic->aq_nic_cfg);
+	if (err)
 		goto err_exit;
-	}
 
 	rx_ring_idx = aq_ptp_ring_idx(aq_nic->aq_nic_cfg.tc_mode);
 
-	ring = aq_ring_rx_alloc(&aq_ptp->ptp_rx, aq_nic,
-				rx_ring_idx, &aq_nic->aq_nic_cfg);
-	if (!ring) {
-		err = -ENOMEM;
+	err = aq_ring_rx_alloc(&aq_ptp->ptp_rx, aq_nic,
+			       rx_ring_idx, &aq_nic->aq_nic_cfg);
+	if (err)
 		goto err_exit_ptp_tx;
-	}
 
-	hwts = aq_ring_hwts_rx_alloc(&aq_ptp->hwts_rx, aq_nic, PTP_HWST_RING_IDX,
-				     aq_nic->aq_nic_cfg.rxds,
-				     aq_nic->aq_nic_cfg.aq_hw_caps->rxd_size);
-	if (!hwts) {
-		err = -ENOMEM;
+	err = aq_ring_hwts_rx_alloc(&aq_ptp->hwts_rx, aq_nic, PTP_HWST_RING_IDX,
+				    aq_nic->aq_nic_cfg.rxds,
+				    aq_nic->aq_nic_cfg.aq_hw_caps->rxd_size);
+	if (err)
 		goto err_exit_ptp_rx;
-	}
 
 	err = aq_ptp_skb_ring_init(&aq_ptp->skb_ring, aq_nic->aq_nic_cfg.rxds);
 	if (err != 0) {
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
index e1885c1eb100..cda8597b4e14 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
@@ -132,8 +132,8 @@ static int aq_get_rxpages(struct aq_ring_s *self, struct aq_ring_buff_s *rxbuf)
 	return 0;
 }
 
-static struct aq_ring_s *aq_ring_alloc(struct aq_ring_s *self,
-				       struct aq_nic_s *aq_nic)
+static int aq_ring_alloc(struct aq_ring_s *self,
+			 struct aq_nic_s *aq_nic)
 {
 	int err = 0;
 
@@ -156,46 +156,29 @@ static struct aq_ring_s *aq_ring_alloc(struct aq_ring_s *self,
 err_exit:
 	if (err < 0) {
 		aq_ring_free(self);
-		self = NULL;
 	}
 
-	return self;
+	return err;
 }
 
-struct aq_ring_s *aq_ring_tx_alloc(struct aq_ring_s *self,
-				   struct aq_nic_s *aq_nic,
-				   unsigned int idx,
-				   struct aq_nic_cfg_s *aq_nic_cfg)
+int aq_ring_tx_alloc(struct aq_ring_s *self,
+		     struct aq_nic_s *aq_nic,
+		     unsigned int idx,
+		     struct aq_nic_cfg_s *aq_nic_cfg)
 {
-	int err = 0;
-
 	self->aq_nic = aq_nic;
 	self->idx = idx;
 	self->size = aq_nic_cfg->txds;
 	self->dx_size = aq_nic_cfg->aq_hw_caps->txd_size;
 
-	self = aq_ring_alloc(self, aq_nic);
-	if (!self) {
-		err = -ENOMEM;
-		goto err_exit;
-	}
-
-err_exit:
-	if (err < 0) {
-		aq_ring_free(self);
-		self = NULL;
-	}
-
-	return self;
+	return aq_ring_alloc(self, aq_nic);
 }
 
-struct aq_ring_s *aq_ring_rx_alloc(struct aq_ring_s *self,
-				   struct aq_nic_s *aq_nic,
-				   unsigned int idx,
-				   struct aq_nic_cfg_s *aq_nic_cfg)
+int aq_ring_rx_alloc(struct aq_ring_s *self,
+		     struct aq_nic_s *aq_nic,
+		     unsigned int idx,
+		     struct aq_nic_cfg_s *aq_nic_cfg)
 {
-	int err = 0;
-
 	self->aq_nic = aq_nic;
 	self->idx = idx;
 	self->size = aq_nic_cfg->rxds;
@@ -217,22 +200,10 @@ struct aq_ring_s *aq_ring_rx_alloc(struct aq_ring_s *self,
 		self->tail_size = 0;
 	}
 
-	self = aq_ring_alloc(self, aq_nic);
-	if (!self) {
-		err = -ENOMEM;
-		goto err_exit;
-	}
-
-err_exit:
-	if (err < 0) {
-		aq_ring_free(self);
-		self = NULL;
-	}
-
-	return self;
+	return aq_ring_alloc(self, aq_nic);
 }
 
-struct aq_ring_s *
+int
 aq_ring_hwts_rx_alloc(struct aq_ring_s *self, struct aq_nic_s *aq_nic,
 		      unsigned int idx, unsigned int size, unsigned int dx_size)
 {
@@ -250,10 +221,10 @@ aq_ring_hwts_rx_alloc(struct aq_ring_s *self, struct aq_nic_s *aq_nic,
 					   GFP_KERNEL);
 	if (!self->dx_ring) {
 		aq_ring_free(self);
-		return NULL;
+		return -ENOMEM;
 	}
 
-	return self;
+	return 0;
 }
 
 int aq_ring_init(struct aq_ring_s *self, const enum atl_ring_type ring_type)
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.h b/drivers/net/ethernet/aquantia/atlantic/aq_ring.h
index 0a6c34438c1d..52847310740a 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.h
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.h
@@ -183,14 +183,14 @@ static inline unsigned int aq_ring_avail_dx(struct aq_ring_s *self)
 		self->sw_head - self->sw_tail - 1);
 }
 
-struct aq_ring_s *aq_ring_tx_alloc(struct aq_ring_s *self,
-				   struct aq_nic_s *aq_nic,
-				   unsigned int idx,
-				   struct aq_nic_cfg_s *aq_nic_cfg);
-struct aq_ring_s *aq_ring_rx_alloc(struct aq_ring_s *self,
-				   struct aq_nic_s *aq_nic,
-				   unsigned int idx,
-				   struct aq_nic_cfg_s *aq_nic_cfg);
+int aq_ring_tx_alloc(struct aq_ring_s *self,
+		     struct aq_nic_s *aq_nic,
+		     unsigned int idx,
+		     struct aq_nic_cfg_s *aq_nic_cfg);
+int aq_ring_rx_alloc(struct aq_ring_s *self,
+		     struct aq_nic_s *aq_nic,
+		     unsigned int idx,
+		     struct aq_nic_cfg_s *aq_nic_cfg);
 
 int aq_ring_init(struct aq_ring_s *self, const enum atl_ring_type ring_type);
 void aq_ring_rx_deinit(struct aq_ring_s *self);
@@ -207,9 +207,9 @@ int aq_ring_rx_clean(struct aq_ring_s *self,
 		     int budget);
 int aq_ring_rx_fill(struct aq_ring_s *self);
 
-struct aq_ring_s *aq_ring_hwts_rx_alloc(struct aq_ring_s *self,
-		struct aq_nic_s *aq_nic, unsigned int idx,
-		unsigned int size, unsigned int dx_size);
+int aq_ring_hwts_rx_alloc(struct aq_ring_s *self,
+			  struct aq_nic_s *aq_nic, unsigned int idx,
+			  unsigned int size, unsigned int dx_size);
 void aq_ring_hwts_rx_clean(struct aq_ring_s *self, struct aq_nic_s *aq_nic);
 
 unsigned int aq_ring_fill_stats_data(struct aq_ring_s *self, u64 *data);
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_vec.c b/drivers/net/ethernet/aquantia/atlantic/aq_vec.c
index f5db1c44e9b9..9769ab4f9bef 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_vec.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_vec.c
@@ -136,35 +136,32 @@ int aq_vec_ring_alloc(struct aq_vec_s *self, struct aq_nic_s *aq_nic,
 		const unsigned int idx_ring = AQ_NIC_CFG_TCVEC2RING(aq_nic_cfg,
 								    i, idx);
 
-		ring = aq_ring_tx_alloc(&self->ring[i][AQ_VEC_TX_ID], aq_nic,
-					idx_ring, aq_nic_cfg);
-		if (!ring) {
-			err = -ENOMEM;
+		ring = &self->ring[i][AQ_VEC_TX_ID];
+		err = aq_ring_tx_alloc(ring, aq_nic, idx_ring, aq_nic_cfg);
+		if (err)
 			goto err_exit;
-		}
 
 		++self->tx_rings;
 
 		aq_nic_set_tx_ring(aq_nic, idx_ring, ring);
 
-		if (xdp_rxq_info_reg(&self->ring[i][AQ_VEC_RX_ID].xdp_rxq,
+		ring = &self->ring[i][AQ_VEC_RX_ID];
+		if (xdp_rxq_info_reg(&ring->xdp_rxq,
 				     aq_nic->ndev, idx,
 				     self->napi.napi_id) < 0) {
 			err = -ENOMEM;
 			goto err_exit;
 		}
-		if (xdp_rxq_info_reg_mem_model(&self->ring[i][AQ_VEC_RX_ID].xdp_rxq,
+		if (xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
 					       MEM_TYPE_PAGE_SHARED, NULL) < 0) {
-			xdp_rxq_info_unreg(&self->ring[i][AQ_VEC_RX_ID].xdp_rxq);
+			xdp_rxq_info_unreg(&ring->xdp_rxq);
 			err = -ENOMEM;
 			goto err_exit;
 		}
 
-		ring = aq_ring_rx_alloc(&self->ring[i][AQ_VEC_RX_ID], aq_nic,
-					idx_ring, aq_nic_cfg);
-		if (!ring) {
-			xdp_rxq_info_unreg(&self->ring[i][AQ_VEC_RX_ID].xdp_rxq);
-			err = -ENOMEM;
+		err = aq_ring_rx_alloc(ring, aq_nic, idx_ring, aq_nic_cfg);
+		if (err) {
+			xdp_rxq_info_unreg(&ring->xdp_rxq);
 			goto err_exit;
 		}
 
-- 
2.43.0


