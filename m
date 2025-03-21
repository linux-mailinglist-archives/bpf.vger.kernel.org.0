Return-Path: <bpf+bounces-54512-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B383A6B248
	for <lists+bpf@lfdr.de>; Fri, 21 Mar 2025 01:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC153189FD93
	for <lists+bpf@lfdr.de>; Fri, 21 Mar 2025 00:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6546117E00E;
	Fri, 21 Mar 2025 00:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s47HC+i6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AC714A095
	for <bpf@vger.kernel.org>; Fri, 21 Mar 2025 00:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742516972; cv=none; b=ez/KNjJRy60E7pf1V0P2wVWfNHG/3NtTIN0+YbR3blhPpZoz3BpjWvdWH4QcItjgSa18jiAHUHCOZ6FUHUxKNcePzk4DE8NU6/aw0oSUamiqAJYwvHTKux0Z/gMLY9Ws9RsQJNaBV9xUEuMF2yfCQFqO0537NzgUESE3ZsRkhx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742516972; c=relaxed/simple;
	bh=NhcZ+zbzhwPnYjaWWSny+o04Svf37lvqboIKaR19mLE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pGA4mrWj3osAU22JJCxHQXbM9ahbNqLp3zz8MDZq+07LTLq1Zw0aHLXUC5PoTi2rjyBVff7Xg85k19KM6vQYfQj4On/NRyTCcwRxVV5KDHR7B59OA9bObZ02QG2o5ndyYXl/PBNl56VI3yzAivDSaGBlr+4NIgnxmZu8gS6yGJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s47HC+i6; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff798e8c90so2068566a91.1
        for <bpf@vger.kernel.org>; Thu, 20 Mar 2025 17:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742516969; x=1743121769; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=em9gQO4+IduflzLNE8by+sP01vmyK8sm1poXWbQdmh8=;
        b=s47HC+i6Ww6fkYcZBOvC2+Kv78HWeDRKHY8tqeIp59MmhTzuqu80mkEEK6JT4WDuOI
         9huYGIkcZER4wHT27fM0qYt6G6sTwnI/wnek6Fk1Kx8Qa/4q6wuvuHFbKV4wmHJGIehZ
         y/rnA8BlrBLbjDsbJKUXNXkN68eyTTVgfBKhjVS0oRmEUJO9KSew7axqJjwLPQY7YnhA
         F2753sVnS5cqpS9ywmNnszoz8y71MMvOG39XkKPcC1My9oqnvHw9Xg4g9q/jKBzRN9Nq
         spHCTUgz3cgFd/1uTgzLofHOhBzjTUJwZMCq7Un+HW229zaUQML+4ExZy+mryudtgd9s
         5FWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742516969; x=1743121769;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=em9gQO4+IduflzLNE8by+sP01vmyK8sm1poXWbQdmh8=;
        b=pt7w4d0+mKkcbpSiS1VEO3F7CKtTOX7rYAKV4pOJ17ijNerQO5030jjlFV+vAVZCqm
         2y4qsG0lqHDtmVlX6DySUNqzLP3XBxXGljrBni+CektQNv6bDsUxZw6Svb0wKqo+2t50
         Ls/hRd1MDouQV+4nPP3kxa4UAwuSkJoVYZDPmS4pqYoGtBuypwGkqFoxSwJFHm3qPU5H
         fjKpiQkBHdzaQSoZ0LPCw4JT5M8JSGb+WWGU3Qi+OCwLLzzcy1Wa1kxbD3c+7MBmLE/d
         g2P/oaparKh/F/fv5Gj1PWOpMSzILWpAyZ87kl+ih6trdi+1G9erj1VYEPuu4aE1gNi9
         ABXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnld60Zx3ZyZvjh2AijcGgIOLahFa3/8y4q6JBJcUXHSvLzSLnrdwXKOieyA1QhLGvuDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkbPmSw9yjny43go0FcHoYtM2oTsuBa3Ba3e0RuPgEAIPVYbvm
	htTBAFVzEDk6espw8/t/wMBwu+4HgHy5nq2fGe/+MLT/VLbvseNVOC4m83RHFh8XPPX095aV393
	KqS4wKxkGRDhIT17W9+ZqAg==
X-Google-Smtp-Source: AGHT+IE8Ju/LbwThFm7Q2P3L+DeXYJs94u/aaDVbtgY6B0JEC3AT/HfCkpiYyotrEytpARmRRKMIrfjEygFYwdJSMw==
X-Received: from pjc7.prod.google.com ([2002:a17:90b:2f47:b0:2f9:e05f:187f])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4d05:b0:2f1:3355:4a8f with SMTP id 98e67ed59e1d1-3030fe8d50amr1526961a91.4.1742516969451;
 Thu, 20 Mar 2025 17:29:29 -0700 (PDT)
Date: Fri, 21 Mar 2025 00:29:08 +0000
In-Reply-To: <20250321002910.1343422-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250321002910.1343422-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250321002910.1343422-5-hramamurthy@google.com>
Subject: [PATCH net-next 4/6] gve: merge packet buffer size fields
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: jeroendb@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, pkaligineedi@google.com, willemb@google.com, 
	ziweixiao@google.com, joshwash@google.com, horms@kernel.org, 
	shailend@google.com, bcf@google.com, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Joshua Washington <joshwash@google.com>

The data_buffer_size_dqo field in gve_priv and the packet_buffer_size
field in gve_rx_ring theoretically have the same meaning, but they are
defined in two different places and used in two separate contexts. There
is no good reason for this, so this change merges those fields into the
packet_buffer_size field in the RX ring.

This change also introduces a packet_buffer_size field to struct
gve_rx_queue_config to account for cases where queues are not allocated,
such as when the interface is down.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve.h                 | 4 ++--
 drivers/net/ethernet/google/gve/gve_adminq.c          | 4 +---
 drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c | 7 +++----
 drivers/net/ethernet/google/gve/gve_ethtool.c         | 3 +--
 drivers/net/ethernet/google/gve/gve_main.c            | 8 +++-----
 drivers/net/ethernet/google/gve/gve_rx.c              | 2 +-
 drivers/net/ethernet/google/gve/gve_rx_dqo.c          | 1 +
 7 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index e5cc3fada9c9..9895541eddae 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -227,6 +227,7 @@ struct gve_rx_cnts {
 /* Contains datapath state used to represent an RX queue. */
 struct gve_rx_ring {
 	struct gve_priv *gve;
+	u16 packet_buffer_size;
 	union {
 		/* GQI fields */
 		struct {
@@ -235,7 +236,6 @@ struct gve_rx_ring {
 
 			/* threshold for posting new buffs and descs */
 			u32 db_threshold;
-			u16 packet_buffer_size;
 
 			u32 qpl_copy_pool_mask;
 			u32 qpl_copy_pool_head;
@@ -635,6 +635,7 @@ struct gve_notify_block {
 struct gve_rx_queue_config {
 	u16 max_queues;
 	u16 num_queues;
+	u16 packet_buffer_size;
 };
 
 /* Tracks allowed and current tx queue settings */
@@ -842,7 +843,6 @@ struct gve_priv {
 	struct gve_ptype_lut *ptype_lut_dqo;
 
 	/* Must be a power of two. */
-	u16 data_buffer_size_dqo;
 	u16 max_rx_buffer_size; /* device limit */
 
 	enum gve_queue_format queue_format;
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index be7a423e5ab9..3e8fc33cc11f 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -731,6 +731,7 @@ static void gve_adminq_get_create_rx_queue_cmd(struct gve_priv *priv,
 		.ntfy_id = cpu_to_be32(rx->ntfy_id),
 		.queue_resources_addr = cpu_to_be64(rx->q_resources_bus),
 		.rx_ring_size = cpu_to_be16(priv->rx_desc_cnt),
+		.packet_buffer_size = cpu_to_be16(rx->packet_buffer_size),
 	};
 
 	if (gve_is_gqi(priv)) {
@@ -743,7 +744,6 @@ static void gve_adminq_get_create_rx_queue_cmd(struct gve_priv *priv,
 			cpu_to_be64(rx->data.data_bus);
 		cmd->create_rx_queue.index = cpu_to_be32(queue_index);
 		cmd->create_rx_queue.queue_page_list_id = cpu_to_be32(qpl_id);
-		cmd->create_rx_queue.packet_buffer_size = cpu_to_be16(rx->packet_buffer_size);
 	} else {
 		u32 qpl_id = 0;
 
@@ -756,8 +756,6 @@ static void gve_adminq_get_create_rx_queue_cmd(struct gve_priv *priv,
 			cpu_to_be64(rx->dqo.complq.bus);
 		cmd->create_rx_queue.rx_data_ring_addr =
 			cpu_to_be64(rx->dqo.bufq.bus);
-		cmd->create_rx_queue.packet_buffer_size =
-			cpu_to_be16(priv->data_buffer_size_dqo);
 		cmd->create_rx_queue.rx_buff_ring_size =
 			cpu_to_be16(priv->rx_desc_cnt);
 		cmd->create_rx_queue.enable_rsc =
diff --git a/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c b/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
index af84cb88f828..f9824664d04c 100644
--- a/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
@@ -139,7 +139,7 @@ int gve_alloc_qpl_page_dqo(struct gve_rx_ring *rx,
 	buf_state->page_info.page_offset = 0;
 	buf_state->page_info.page_address =
 		page_address(buf_state->page_info.page);
-	buf_state->page_info.buf_size = priv->data_buffer_size_dqo;
+	buf_state->page_info.buf_size = rx->packet_buffer_size;
 	buf_state->last_single_ref_offset = 0;
 
 	/* The page already has 1 ref. */
@@ -162,7 +162,7 @@ void gve_free_qpl_page_dqo(struct gve_rx_buf_state_dqo *buf_state)
 void gve_try_recycle_buf(struct gve_priv *priv, struct gve_rx_ring *rx,
 			 struct gve_rx_buf_state_dqo *buf_state)
 {
-	const u16 data_buffer_size = priv->data_buffer_size_dqo;
+	const u16 data_buffer_size = rx->packet_buffer_size;
 	int pagecount;
 
 	/* Can't reuse if we only fit one buffer per page */
@@ -217,10 +217,9 @@ void gve_free_to_page_pool(struct gve_rx_ring *rx,
 static int gve_alloc_from_page_pool(struct gve_rx_ring *rx,
 				    struct gve_rx_buf_state_dqo *buf_state)
 {
-	struct gve_priv *priv = rx->gve;
 	netmem_ref netmem;
 
-	buf_state->page_info.buf_size = priv->data_buffer_size_dqo;
+	buf_state->page_info.buf_size = rx->packet_buffer_size;
 	netmem = page_pool_alloc_netmem(rx->dqo.page_pool,
 					&buf_state->page_info.page_offset,
 					&buf_state->page_info.buf_size,
diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
index a862031ba5d1..31a21ccf4863 100644
--- a/drivers/net/ethernet/google/gve/gve_ethtool.c
+++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
@@ -647,8 +647,7 @@ static int gve_set_tunable(struct net_device *netdev,
 	switch (etuna->id) {
 	case ETHTOOL_RX_COPYBREAK:
 	{
-		u32 max_copybreak = gve_is_gqi(priv) ?
-			GVE_DEFAULT_RX_BUFFER_SIZE : priv->data_buffer_size_dqo;
+		u32 max_copybreak = priv->rx_cfg.packet_buffer_size;
 
 		len = *(u32 *)value;
 		if (len > max_copybreak)
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 354f526a9238..20aabbe0e518 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1224,9 +1224,7 @@ static void gve_rx_get_curr_alloc_cfg(struct gve_priv *priv,
 	cfg->raw_addressing = !gve_is_qpl(priv);
 	cfg->enable_header_split = priv->header_split_enabled;
 	cfg->ring_size = priv->rx_desc_cnt;
-	cfg->packet_buffer_size = gve_is_gqi(priv) ?
-				  GVE_DEFAULT_RX_BUFFER_SIZE :
-				  priv->data_buffer_size_dqo;
+	cfg->packet_buffer_size = priv->rx_cfg.packet_buffer_size;
 	cfg->rx = priv->rx;
 }
 
@@ -1331,7 +1329,7 @@ static int gve_queues_start(struct gve_priv *priv,
 		goto reset;
 
 	priv->header_split_enabled = rx_alloc_cfg->enable_header_split;
-	priv->data_buffer_size_dqo = rx_alloc_cfg->packet_buffer_size;
+	priv->rx_cfg.packet_buffer_size = rx_alloc_cfg->packet_buffer_size;
 
 	err = gve_create_rings(priv);
 	if (err)
@@ -2627,7 +2625,7 @@ static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	priv->service_task_flags = 0x0;
 	priv->state_flags = 0x0;
 	priv->ethtool_flags = 0x0;
-	priv->data_buffer_size_dqo = GVE_DEFAULT_RX_BUFFER_SIZE;
+	priv->rx_cfg.packet_buffer_size = GVE_DEFAULT_RX_BUFFER_SIZE;
 	priv->max_rx_buffer_size = GVE_DEFAULT_RX_BUFFER_SIZE;
 
 	gve_set_probe_in_progress(priv);
diff --git a/drivers/net/ethernet/google/gve/gve_rx.c b/drivers/net/ethernet/google/gve/gve_rx.c
index 9d444e723fcd..90e875c1832f 100644
--- a/drivers/net/ethernet/google/gve/gve_rx.c
+++ b/drivers/net/ethernet/google/gve/gve_rx.c
@@ -288,7 +288,7 @@ int gve_rx_alloc_ring_gqi(struct gve_priv *priv,
 
 	rx->gve = priv;
 	rx->q_num = idx;
-	rx->packet_buffer_size = GVE_DEFAULT_RX_BUFFER_SIZE;
+	rx->packet_buffer_size = cfg->packet_buffer_size;
 
 	rx->mask = slots - 1;
 	rx->data.raw_addressing = cfg->raw_addressing;
diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index dcdad6d09bf3..5fbcf93a54e0 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -223,6 +223,7 @@ int gve_rx_alloc_ring_dqo(struct gve_priv *priv,
 	memset(rx, 0, sizeof(*rx));
 	rx->gve = priv;
 	rx->q_num = idx;
+	rx->packet_buffer_size = cfg->packet_buffer_size;
 
 	rx->dqo.num_buf_states = cfg->raw_addressing ? buffer_queue_slots :
 		gve_get_rx_pages_per_qpl_dqo(cfg->ring_size);
-- 
2.49.0.rc1.451.g8f38331e32-goog


