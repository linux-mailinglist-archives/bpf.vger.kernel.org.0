Return-Path: <bpf+bounces-54509-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E96EA6B244
	for <lists+bpf@lfdr.de>; Fri, 21 Mar 2025 01:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DCC718994FF
	for <lists+bpf@lfdr.de>; Fri, 21 Mar 2025 00:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F61270823;
	Fri, 21 Mar 2025 00:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="geEeMLjT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545C94879B
	for <bpf@vger.kernel.org>; Fri, 21 Mar 2025 00:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742516963; cv=none; b=lcMb6YkFpcELvwPXDPu+H1jNM/qZwcGypuVKMVnbcG8XiZN+wj9b6t0RiNBSTtP7FsG2PibzLDcRmnywaerjE0FrRQgBpvD8utuzheYkjBLf+K2FrT6w28InCvKR6MSeiEB2LTk+dj9vcktlSvUfg8JgyLfJC4vLiG29ea/THrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742516963; c=relaxed/simple;
	bh=Jbm7GYaJXcjd03+tuScQgxz8fqw00dOQwC1LuGpDchY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LDN7P+9KlYSRqsWd1CIRMmBtpgs2RnSUI2OQZeoU/TD5oWY8eXtPfFX/xJr8rIKFNquWQCJMfAbIz45h6eelXMr3M+fkKaxdAgLz2sv9pXbs4uD+anHHSRXo9nxxBC8bcIBmLrkFMqz7FC56VBDKy7vs1wHx8XfCHI7BFO3ppF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=geEeMLjT; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2233b764fc8so20825805ad.3
        for <bpf@vger.kernel.org>; Thu, 20 Mar 2025 17:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742516962; x=1743121762; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KoTBbWww7JEQC+F5jRMP+bnOpvYvD/+5OAlhy1ULkuk=;
        b=geEeMLjTSdLTdOKmTL2VSJ6nhZu2vOQdxNxwK934MjNLfhmNL72gdx0YamiIFAduVu
         0/jNV6T/6traltcsEO2ihRo5TNMFXhvbLNyOWlxE7dS93JntCDH07lCjSgiNMaigo0p7
         GrXvXcgv65+UarRPSEFu7kN5H2j0klMDkJTNcLsGN5iEh2Vtpdk3aujHYZmXheHFsrzb
         0td9JZ/4zrBvkSGlTB+/W4MzNkO9iS2y7PkPoIoNUSzI7uxlSGcB/bzpLgyiHDNtdc/J
         NxhgBprpAaDXhbH16oSqzLhcyqQ2cHsJTh9amDiRbGPxFZtkwWtPa6fXolrt9b66kzQD
         sDOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742516962; x=1743121762;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KoTBbWww7JEQC+F5jRMP+bnOpvYvD/+5OAlhy1ULkuk=;
        b=nok3Hhh6igF9MkBpdtciWBQbklpTBrUsbNKr+1LtLTcIQAgk6bwuuvHr2PuIfFInR9
         h0YcFKALNtX7ALPh+WTDJBq+/r6epmZyH88HreirloTCCieKWPBvsbFVcF2qeINNUAZp
         LhagTbDAN+tFt+m6ZlGZdgf1IqynkMqu4hkUYoly5eY/p7klVfyZONgX1WhRqJO1OWLW
         sth3Kph08JHGfhRE+4C24+jWOngzCxGHoIbq0DNEqU+ZCJQrAqQYmwcMZdbHtaavcOwg
         4hJzgTpuT/JputyPilCF160phyb+QHOXaV0PmyXVM/Ghr6BCZqIVAnqoH62LIm+FR1DI
         g0Xw==
X-Forwarded-Encrypted: i=1; AJvYcCUfe2g06cvS5sxClfhltlAmSMAcNmYwSUcTSIuzLIHnF3H20URGnD84va2a2fWcz09TkQo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd8dxtx1iiam0teO77Ldtjk6r/P5zR4m2uhoEbzIXA776t4Dnd
	Zi9KagPfxUNOWvfWS10PgG8INo3JuZheXtOcuWC1e4QcsiSvlNmk55bh3YCW6peR3uz33JOPWbh
	mr8AL775x5wJ1BqwDPL7VzQ==
X-Google-Smtp-Source: AGHT+IF/RKffTkar3eNChq0M93Wm9yCSbeUCKsyAMrO6ynd5mACmphLhb4ZEULjZm1n+Oj8W1m67dSwK7GHZr2a5Lg==
X-Received: from pgbdo13.prod.google.com ([2002:a05:6a02:e8d:b0:af2:8474:f67e])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:2448:b0:1f5:8179:4f42 with SMTP id adf61e73a8af0-1fe42f090fdmr2537813637.6.1742516961712;
 Thu, 20 Mar 2025 17:29:21 -0700 (PDT)
Date: Fri, 21 Mar 2025 00:29:05 +0000
In-Reply-To: <20250321002910.1343422-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250321002910.1343422-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250321002910.1343422-2-hramamurthy@google.com>
Subject: [PATCH net-next 1/6] gve: remove xdp_xsk_done and xdp_xsk_wakeup statistics
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

These statistics pollute the hotpath and do not have any real-world use
or meaning.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve.h         | 2 --
 drivers/net/ethernet/google/gve/gve_ethtool.c | 8 +++-----
 drivers/net/ethernet/google/gve/gve_tx.c      | 8 ++------
 3 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 483c43bab3a9..2064e592dfdd 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -613,8 +613,6 @@ struct gve_tx_ring {
 	dma_addr_t complq_bus_dqo; /* dma address of the dqo.compl_ring */
 	struct u64_stats_sync statss; /* sync stats for 32bit archs */
 	struct xsk_buff_pool *xsk_pool;
-	u32 xdp_xsk_wakeup;
-	u32 xdp_xsk_done;
 	u64 xdp_xsk_sent;
 	u64 xdp_xmit;
 	u64 xdp_xmit_errors;
diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
index a572f1e05934..bc59b5b4235a 100644
--- a/drivers/net/ethernet/google/gve/gve_ethtool.c
+++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
@@ -63,8 +63,8 @@ static const char gve_gstrings_rx_stats[][ETH_GSTRING_LEN] = {
 static const char gve_gstrings_tx_stats[][ETH_GSTRING_LEN] = {
 	"tx_posted_desc[%u]", "tx_completed_desc[%u]", "tx_consumed_desc[%u]", "tx_bytes[%u]",
 	"tx_wake[%u]", "tx_stop[%u]", "tx_event_counter[%u]",
-	"tx_dma_mapping_error[%u]", "tx_xsk_wakeup[%u]",
-	"tx_xsk_done[%u]", "tx_xsk_sent[%u]", "tx_xdp_xmit[%u]", "tx_xdp_xmit_errors[%u]"
+	"tx_dma_mapping_error[%u]",
+	"tx_xsk_sent[%u]", "tx_xdp_xmit[%u]", "tx_xdp_xmit_errors[%u]"
 };
 
 static const char gve_gstrings_adminq_stats[][ETH_GSTRING_LEN] = {
@@ -417,9 +417,7 @@ gve_get_ethtool_stats(struct net_device *netdev,
 					data[i++] = value;
 				}
 			}
-			/* XDP xsk counters */
-			data[i++] = tx->xdp_xsk_wakeup;
-			data[i++] = tx->xdp_xsk_done;
+			/* XDP counters */
 			do {
 				start = u64_stats_fetch_begin(&priv->tx[ring].statss);
 				data[i] = tx->xdp_xsk_sent;
diff --git a/drivers/net/ethernet/google/gve/gve_tx.c b/drivers/net/ethernet/google/gve/gve_tx.c
index 4350ebd9c2bd..c8c067e18059 100644
--- a/drivers/net/ethernet/google/gve/gve_tx.c
+++ b/drivers/net/ethernet/google/gve/gve_tx.c
@@ -959,14 +959,10 @@ static int gve_xsk_tx(struct gve_priv *priv, struct gve_tx_ring *tx,
 
 	spin_lock(&tx->xdp_lock);
 	while (sent < budget) {
-		if (!gve_can_tx(tx, GVE_TX_START_THRESH))
+		if (!gve_can_tx(tx, GVE_TX_START_THRESH) ||
+		    !xsk_tx_peek_desc(tx->xsk_pool, &desc))
 			goto out;
 
-		if (!xsk_tx_peek_desc(tx->xsk_pool, &desc)) {
-			tx->xdp_xsk_done = tx->xdp_xsk_wakeup;
-			goto out;
-		}
-
 		data = xsk_buff_raw_get_data(tx->xsk_pool, desc.addr);
 		nsegs = gve_tx_fill_xdp(priv, tx, data, desc.len, NULL, true);
 		tx->req += nsegs;
-- 
2.49.0.rc1.451.g8f38331e32-goog


