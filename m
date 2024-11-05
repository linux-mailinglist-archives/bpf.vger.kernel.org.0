Return-Path: <bpf+bounces-44080-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 004F59BD995
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 00:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 235141C2288F
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 23:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A518216A18;
	Tue,  5 Nov 2024 23:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5sdB8k0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3701D27BF;
	Tue,  5 Nov 2024 23:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730848742; cv=none; b=Fy0nhH8yeKyooWVL3ibd4j3wepZMw4FkmljKO5Mmx0T9vboyMUU/6bRqroJ9mdJB3jCeXxSbMXeT/Sl8L6rADZs2DBqpaffjaAbS7K8xIDEH3kGVRF0N0xFTFoD033m+OovBhh771uVPA4vB9CQBmKjKAV2B2BMcNCizHuMTyQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730848742; c=relaxed/simple;
	bh=S1k0dVOKWVc2a0bfW5WPnv4OSnoCxPWZfLLv7shTM6o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bx/4VJfZzl9xbv2B4wllb4nv8KKyOFGdA5COxuLslNZiukZJSyPBqr8x3dfjVjtJpmwv4lauFdv0WdiTZOTdVo3ytjKIn2MG5FII2CJhT2P+Pu93+YekXECyXaEYxdtMvQI2U1WlhY5HNj+D+ppyg0uJ12PwqbQcnGVAMMqd+zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K5sdB8k0; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3a6c1cfcb91so13902065ab.0;
        Tue, 05 Nov 2024 15:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730848739; x=1731453539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v8EPFZSgukoBpOa+lawA18BIXOypVCgpy3mTtamrzXU=;
        b=K5sdB8k0zU0VNHQ2GRkaWcqBpgI90clvWJGaWsxNVNhJQP3QdTpeX34f1XHyBkiKlS
         /XPv8xBNr8pNGtBAChv6Xra8/6uKh/Qx9f+VxnrrBOdwligg4B427iqpbOjJcQy4gwrt
         BFqz94gCWyJTh5SysW2DmR1pOV2hMfuOwiKV48E02KzVMzgqWbHkJNrSIi9EfhBKd4um
         iV4l1yNtJRXPJ/bR6CWG+aykcv1Rpmv4fPjcGrGURonkAPORsQhoB1h9/r6b9PwLILoM
         UuQxuPtQDI2HqZ0USq74q2LWZ41QyG6sAegVGFj2RvjOMjeyNw8OXeYs3pjVGrs1fbnI
         n1mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730848739; x=1731453539;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v8EPFZSgukoBpOa+lawA18BIXOypVCgpy3mTtamrzXU=;
        b=bO872uhGivaLEA1UHdYLZJHA0wVw6YkO7vqK5fbwpuG11csB2eVFV7w+KRICkGbkP6
         GtkbFhCe0KY8Si0ZAyBGDtYCyCxIpX0+jPaYE2rzwBG1OU75vCR2T5MvmAkH5DFscTEk
         uvfUNAGhwo1xNuiz/p6Nlp68xY2lHtj5neUAjpjyMF3KPCbqurohb/CkFmyar0NUTp80
         awFxrnmNn5YTlm57iyxWL3NZhVoIz68S5lSoodcgLzgKP6KXHdHFTkhMC1sBmogYxXsM
         wG3qUzdTd8ZXM0zwbydasYNevvBggEjEA1+DESpC7cU9aKqULXIqVv3YGrJs3TiEvvlR
         3PDw==
X-Forwarded-Encrypted: i=1; AJvYcCV/eQ2Rc4PUWDs2DBmcl3YuOt8AnbUAUi9f9+LSwhryYBpFaLl5HexzNfHQKK5OhIKE+nY=@vger.kernel.org, AJvYcCXBGtg2DV+wmz1GgA72bbUTMM4xMMbnvMAzsNU3s+uAoKXgJoSSasmpma/AZ4MeIyMA7wne5d7xfaI9DSI5@vger.kernel.org
X-Gm-Message-State: AOJu0Yznc7i9sMuHvd5TKmV6Obdyqvx/63Ts2SHuU+s4r8QgBVskPlHi
	Y4HTbhxcp5po3VxZ0VLTfhlcKT8+t57L3AbVc8m++o6xaQjhAXaxJVyDWZV9
X-Google-Smtp-Source: AGHT+IFyJwpCnZypYeVjqrfxhUogtRX8g8lz1frQAMDMe5ER6GX/66EvIzUAj9h4P87PWlMEvszGVA==
X-Received: by 2002:a05:6e02:1a05:b0:3a0:9952:5fcb with SMTP id e9e14a558f8ab-3a5e2513773mr259212395ab.17.1730848738765;
        Tue, 05 Nov 2024 15:18:58 -0800 (PST)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee455a4fe4sm9482294a12.51.2024.11.05.15.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 15:18:58 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Edward Cree <ecree.xilinx@gmail.com>,
	Martin Habets <habetsm.xilinx@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	linux-net-drivers@amd.com (open list:SFC NETWORK DRIVER),
	linux-kernel@vger.kernel.org (open list),
	bpf@vger.kernel.org (open list:XDP (eXpress Data Path):Keyword:(?:\b|_)xdp(?:\b|_))
Subject: [PATCHv2 net-next] net: sfc: use ethtool string helpers
Date: Tue,  5 Nov 2024 15:18:55 -0800
Message-ID: <20241105231855.235894-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The latter is the preferred way to copy ethtool strings.

Avoids manually incrementing the pointer. Cleans up the code quite well.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: cleaned up further with signature changes to make sure all
 increments get propagated.
 drivers/net/ethernet/sfc/ef10.c               |  2 +-
 drivers/net/ethernet/sfc/ef100_nic.c          |  2 +-
 drivers/net/ethernet/sfc/ethtool_common.c     | 46 ++++++++-----------
 drivers/net/ethernet/sfc/falcon/ethtool.c     | 34 ++++++--------
 drivers/net/ethernet/sfc/falcon/falcon.c      |  2 +-
 drivers/net/ethernet/sfc/falcon/net_driver.h  |  2 +-
 drivers/net/ethernet/sfc/falcon/nic.c         |  9 ++--
 drivers/net/ethernet/sfc/falcon/nic.h         |  2 +-
 drivers/net/ethernet/sfc/net_driver.h         |  2 +-
 drivers/net/ethernet/sfc/nic.c                |  9 ++--
 drivers/net/ethernet/sfc/nic_common.h         |  2 +-
 drivers/net/ethernet/sfc/ptp.c                |  2 +-
 drivers/net/ethernet/sfc/ptp.h                |  2 +-
 .../net/ethernet/sfc/siena/ethtool_common.c   | 46 ++++++++-----------
 drivers/net/ethernet/sfc/siena/net_driver.h   |  2 +-
 drivers/net/ethernet/sfc/siena/nic.c          | 14 +++---
 drivers/net/ethernet/sfc/siena/nic_common.h   |  5 +-
 drivers/net/ethernet/sfc/siena/ptp.c          |  2 +-
 drivers/net/ethernet/sfc/siena/ptp.h          |  2 +-
 drivers/net/ethernet/sfc/siena/siena.c        |  2 +-
 20 files changed, 83 insertions(+), 106 deletions(-)

diff --git a/drivers/net/ethernet/sfc/ef10.c b/drivers/net/ethernet/sfc/ef10.c
index de131fc5fa0b..452009ed7a43 100644
--- a/drivers/net/ethernet/sfc/ef10.c
+++ b/drivers/net/ethernet/sfc/ef10.c
@@ -1751,7 +1751,7 @@ static void efx_ef10_get_stat_mask(struct efx_nic *efx, unsigned long *mask)
 #endif
 }
 
-static size_t efx_ef10_describe_stats(struct efx_nic *efx, u8 *names)
+static size_t efx_ef10_describe_stats(struct efx_nic *efx, u8 **names)
 {
 	DECLARE_BITMAP(mask, EF10_STAT_COUNT);
 
diff --git a/drivers/net/ethernet/sfc/ef100_nic.c b/drivers/net/ethernet/sfc/ef100_nic.c
index 6da06931187d..62e674d6ff60 100644
--- a/drivers/net/ethernet/sfc/ef100_nic.c
+++ b/drivers/net/ethernet/sfc/ef100_nic.c
@@ -583,7 +583,7 @@ static const struct efx_hw_stat_desc ef100_stat_desc[EF100_STAT_COUNT] = {
 	EFX_GENERIC_SW_STAT(rx_noskb_drops),
 };
 
-static size_t ef100_describe_stats(struct efx_nic *efx, u8 *names)
+static size_t ef100_describe_stats(struct efx_nic *efx, u8 **names)
 {
 	DECLARE_BITMAP(mask, EF100_STAT_COUNT) = {};
 
diff --git a/drivers/net/ethernet/sfc/ethtool_common.c b/drivers/net/ethernet/sfc/ethtool_common.c
index ae32e08540fa..2d734496733f 100644
--- a/drivers/net/ethernet/sfc/ethtool_common.c
+++ b/drivers/net/ethernet/sfc/ethtool_common.c
@@ -395,7 +395,7 @@ int efx_ethtool_fill_self_tests(struct efx_nic *efx,
 	return n;
 }
 
-static size_t efx_describe_per_queue_stats(struct efx_nic *efx, u8 *strings)
+static size_t efx_describe_per_queue_stats(struct efx_nic *efx, u8 **strings)
 {
 	size_t n_stats = 0;
 	struct efx_channel *channel;
@@ -403,24 +403,22 @@ static size_t efx_describe_per_queue_stats(struct efx_nic *efx, u8 *strings)
 	efx_for_each_channel(channel, efx) {
 		if (efx_channel_has_tx_queues(channel)) {
 			n_stats++;
-			if (strings != NULL) {
-				snprintf(strings, ETH_GSTRING_LEN,
-					 "tx-%u.tx_packets",
-					 channel->tx_queue[0].queue /
-					 EFX_MAX_TXQ_PER_CHANNEL);
+			if (!strings)
+				continue;
 
-				strings += ETH_GSTRING_LEN;
-			}
+			ethtool_sprintf(strings, "tx-%u.tx_packets",
+					channel->tx_queue[0].queue /
+						EFX_MAX_TXQ_PER_CHANNEL);
 		}
 	}
 	efx_for_each_channel(channel, efx) {
 		if (efx_channel_has_rx_queue(channel)) {
 			n_stats++;
-			if (strings != NULL) {
-				snprintf(strings, ETH_GSTRING_LEN,
-					 "rx-%d.rx_packets", channel->channel);
-				strings += ETH_GSTRING_LEN;
-			}
+			if (!strings)
+				continue;
+
+			ethtool_sprintf(strings, "rx-%d.rx_packets",
+					channel->channel);
 		}
 	}
 	if (efx->xdp_tx_queue_count && efx->xdp_tx_queues) {
@@ -428,11 +426,11 @@ static size_t efx_describe_per_queue_stats(struct efx_nic *efx, u8 *strings)
 
 		for (xdp = 0; xdp < efx->xdp_tx_queue_count; xdp++) {
 			n_stats++;
-			if (strings) {
-				snprintf(strings, ETH_GSTRING_LEN,
-					 "tx-xdp-cpu-%hu.tx_packets", xdp);
-				strings += ETH_GSTRING_LEN;
-			}
+			if (!strings)
+				continue;
+
+			ethtool_sprintf(strings, "tx-xdp-cpu-%hu.tx_packets",
+					xdp);
 		}
 	}
 
@@ -464,15 +462,11 @@ void efx_ethtool_get_strings(struct net_device *net_dev,
 
 	switch (string_set) {
 	case ETH_SS_STATS:
-		strings += (efx->type->describe_stats(efx, strings) *
-			    ETH_GSTRING_LEN);
+		efx->type->describe_stats(efx, &strings);
 		for (i = 0; i < EFX_ETHTOOL_SW_STAT_COUNT; i++)
-			strscpy(strings + i * ETH_GSTRING_LEN,
-				efx_sw_stat_desc[i].name, ETH_GSTRING_LEN);
-		strings += EFX_ETHTOOL_SW_STAT_COUNT * ETH_GSTRING_LEN;
-		strings += (efx_describe_per_queue_stats(efx, strings) *
-			    ETH_GSTRING_LEN);
-		efx_ptp_describe_stats(efx, strings);
+			ethtool_puts(&strings, efx_sw_stat_desc[i].name);
+		efx_describe_per_queue_stats(efx, &strings);
+		efx_ptp_describe_stats(efx, &strings);
 		break;
 	case ETH_SS_TEST:
 		efx_ethtool_fill_self_tests(efx, NULL, strings, NULL);
diff --git a/drivers/net/ethernet/sfc/falcon/ethtool.c b/drivers/net/ethernet/sfc/falcon/ethtool.c
index f4db683b80f7..04766448a545 100644
--- a/drivers/net/ethernet/sfc/falcon/ethtool.c
+++ b/drivers/net/ethernet/sfc/falcon/ethtool.c
@@ -353,7 +353,7 @@ static int ef4_ethtool_fill_self_tests(struct ef4_nic *efx,
 	return n;
 }
 
-static size_t ef4_describe_per_queue_stats(struct ef4_nic *efx, u8 *strings)
+static size_t ef4_describe_per_queue_stats(struct ef4_nic *efx, u8 **strings)
 {
 	size_t n_stats = 0;
 	struct ef4_channel *channel;
@@ -361,24 +361,22 @@ static size_t ef4_describe_per_queue_stats(struct ef4_nic *efx, u8 *strings)
 	ef4_for_each_channel(channel, efx) {
 		if (ef4_channel_has_tx_queues(channel)) {
 			n_stats++;
-			if (strings != NULL) {
-				snprintf(strings, ETH_GSTRING_LEN,
-					 "tx-%u.tx_packets",
-					 channel->tx_queue[0].queue /
-					 EF4_TXQ_TYPES);
+			if (!strings)
+				continue;
 
-				strings += ETH_GSTRING_LEN;
-			}
+			ethtool_sprintf(strings, "tx-%u.tx_packets",
+					channel->tx_queue[0].queue /
+						EF4_TXQ_TYPES);
 		}
 	}
 	ef4_for_each_channel(channel, efx) {
 		if (ef4_channel_has_rx_queue(channel)) {
 			n_stats++;
-			if (strings != NULL) {
-				snprintf(strings, ETH_GSTRING_LEN,
-					 "rx-%d.rx_packets", channel->channel);
-				strings += ETH_GSTRING_LEN;
-			}
+			if (!strings)
+				continue;
+
+			ethtool_sprintf(strings, "rx-%d.rx_packets",
+					channel->channel);
 		}
 	}
 	return n_stats;
@@ -409,14 +407,10 @@ static void ef4_ethtool_get_strings(struct net_device *net_dev,
 
 	switch (string_set) {
 	case ETH_SS_STATS:
-		strings += (efx->type->describe_stats(efx, strings) *
-			    ETH_GSTRING_LEN);
+		efx->type->describe_stats(efx, &strings);
 		for (i = 0; i < EF4_ETHTOOL_SW_STAT_COUNT; i++)
-			strscpy(strings + i * ETH_GSTRING_LEN,
-				ef4_sw_stat_desc[i].name, ETH_GSTRING_LEN);
-		strings += EF4_ETHTOOL_SW_STAT_COUNT * ETH_GSTRING_LEN;
-		strings += (ef4_describe_per_queue_stats(efx, strings) *
-			    ETH_GSTRING_LEN);
+			ethtool_puts(&strings, ef4_sw_stat_desc[i].name);
+		ef4_describe_per_queue_stats(efx, &strings);
 		break;
 	case ETH_SS_TEST:
 		ef4_ethtool_fill_self_tests(efx, NULL, strings, NULL);
diff --git a/drivers/net/ethernet/sfc/falcon/falcon.c b/drivers/net/ethernet/sfc/falcon/falcon.c
index 36114ce88034..4af56333ea49 100644
--- a/drivers/net/ethernet/sfc/falcon/falcon.c
+++ b/drivers/net/ethernet/sfc/falcon/falcon.c
@@ -2564,7 +2564,7 @@ static void falcon_remove_nic(struct ef4_nic *efx)
 	efx->nic_data = NULL;
 }
 
-static size_t falcon_describe_nic_stats(struct ef4_nic *efx, u8 *names)
+static size_t falcon_describe_nic_stats(struct ef4_nic *efx, u8 **names)
 {
 	return ef4_nic_describe_stats(falcon_stat_desc, FALCON_STAT_COUNT,
 				      falcon_stat_mask, names);
diff --git a/drivers/net/ethernet/sfc/falcon/net_driver.h b/drivers/net/ethernet/sfc/falcon/net_driver.h
index a2c7139f2b32..7ab0db44720d 100644
--- a/drivers/net/ethernet/sfc/falcon/net_driver.h
+++ b/drivers/net/ethernet/sfc/falcon/net_driver.h
@@ -1057,7 +1057,7 @@ struct ef4_nic_type {
 	void (*finish_flush)(struct ef4_nic *efx);
 	void (*prepare_flr)(struct ef4_nic *efx);
 	void (*finish_flr)(struct ef4_nic *efx);
-	size_t (*describe_stats)(struct ef4_nic *efx, u8 *names);
+	size_t (*describe_stats)(struct ef4_nic *efx, u8 **names);
 	size_t (*update_stats)(struct ef4_nic *efx, u64 *full_stats,
 			       struct rtnl_link_stats64 *core_stats);
 	void (*start_stats)(struct ef4_nic *efx);
diff --git a/drivers/net/ethernet/sfc/falcon/nic.c b/drivers/net/ethernet/sfc/falcon/nic.c
index 78c851b5a56f..f7acd81c6b6c 100644
--- a/drivers/net/ethernet/sfc/falcon/nic.c
+++ b/drivers/net/ethernet/sfc/falcon/nic.c
@@ -444,18 +444,15 @@ void ef4_nic_get_regs(struct ef4_nic *efx, void *buf)
  * bits in the first @count bits of @mask for which a name is defined.
  */
 size_t ef4_nic_describe_stats(const struct ef4_hw_stat_desc *desc, size_t count,
-			      const unsigned long *mask, u8 *names)
+			      const unsigned long *mask, u8 **names)
 {
 	size_t visible = 0;
 	size_t index;
 
 	for_each_set_bit(index, mask, count) {
 		if (desc[index].name) {
-			if (names) {
-				strscpy(names, desc[index].name,
-					ETH_GSTRING_LEN);
-				names += ETH_GSTRING_LEN;
-			}
+			if (names)
+				ethtool_puts(names, desc[index].name);
 			++visible;
 		}
 	}
diff --git a/drivers/net/ethernet/sfc/falcon/nic.h b/drivers/net/ethernet/sfc/falcon/nic.h
index ada6e036fd97..1ce9406896bf 100644
--- a/drivers/net/ethernet/sfc/falcon/nic.h
+++ b/drivers/net/ethernet/sfc/falcon/nic.h
@@ -498,7 +498,7 @@ size_t ef4_nic_get_regs_len(struct ef4_nic *efx);
 void ef4_nic_get_regs(struct ef4_nic *efx, void *buf);
 
 size_t ef4_nic_describe_stats(const struct ef4_hw_stat_desc *desc, size_t count,
-			      const unsigned long *mask, u8 *names);
+			      const unsigned long *mask, u8 **names);
 void ef4_nic_update_stats(const struct ef4_hw_stat_desc *desc, size_t count,
 			  const unsigned long *mask, u64 *stats,
 			  const void *dma_buf, bool accumulate);
diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
index b54662d32f55..620ba6ef3514 100644
--- a/drivers/net/ethernet/sfc/net_driver.h
+++ b/drivers/net/ethernet/sfc/net_driver.h
@@ -1408,7 +1408,7 @@ struct efx_nic_type {
 	int (*fini_dmaq)(struct efx_nic *efx);
 	void (*prepare_flr)(struct efx_nic *efx);
 	void (*finish_flr)(struct efx_nic *efx);
-	size_t (*describe_stats)(struct efx_nic *efx, u8 *names);
+	size_t (*describe_stats)(struct efx_nic *efx, u8 **names);
 	size_t (*update_stats)(struct efx_nic *efx, u64 *full_stats,
 			       struct rtnl_link_stats64 *core_stats);
 	size_t (*update_stats_atomic)(struct efx_nic *efx, u64 *full_stats,
diff --git a/drivers/net/ethernet/sfc/nic.c b/drivers/net/ethernet/sfc/nic.c
index a33ed473cc8a..80aa5e9c732a 100644
--- a/drivers/net/ethernet/sfc/nic.c
+++ b/drivers/net/ethernet/sfc/nic.c
@@ -299,18 +299,15 @@ void efx_nic_get_regs(struct efx_nic *efx, void *buf)
  * bits in the first @count bits of @mask for which a name is defined.
  */
 size_t efx_nic_describe_stats(const struct efx_hw_stat_desc *desc, size_t count,
-			      const unsigned long *mask, u8 *names)
+			      const unsigned long *mask, u8 **names)
 {
 	size_t visible = 0;
 	size_t index;
 
 	for_each_set_bit(index, mask, count) {
 		if (desc[index].name) {
-			if (names) {
-				strscpy(names, desc[index].name,
-					ETH_GSTRING_LEN);
-				names += ETH_GSTRING_LEN;
-			}
+			if (names)
+				ethtool_puts(names, desc[index].name);
 			++visible;
 		}
 	}
diff --git a/drivers/net/ethernet/sfc/nic_common.h b/drivers/net/ethernet/sfc/nic_common.h
index 7ec4ac7b7ff5..821d91efda19 100644
--- a/drivers/net/ethernet/sfc/nic_common.h
+++ b/drivers/net/ethernet/sfc/nic_common.h
@@ -241,7 +241,7 @@ void efx_nic_get_regs(struct efx_nic *efx, void *buf);
 #define EFX_MC_STATS_GENERATION_INVALID ((__force __le64)(-1))
 
 size_t efx_nic_describe_stats(const struct efx_hw_stat_desc *desc, size_t count,
-			      const unsigned long *mask, u8 *names);
+			      const unsigned long *mask, u8 **names);
 int efx_nic_copy_stats(struct efx_nic *efx, __le64 *dest);
 void efx_nic_update_stats(const struct efx_hw_stat_desc *desc, size_t count,
 			  const unsigned long *mask, u64 *stats,
diff --git a/drivers/net/ethernet/sfc/ptp.c b/drivers/net/ethernet/sfc/ptp.c
index aaacdcfa54ae..5be42e61c40c 100644
--- a/drivers/net/ethernet/sfc/ptp.c
+++ b/drivers/net/ethernet/sfc/ptp.c
@@ -399,7 +399,7 @@ static const unsigned long efx_ptp_stat_mask[] = {
 	[0 ... BITS_TO_LONGS(PTP_STAT_COUNT) - 1] = ~0UL,
 };
 
-size_t efx_ptp_describe_stats(struct efx_nic *efx, u8 *strings)
+size_t efx_ptp_describe_stats(struct efx_nic *efx, u8 **strings)
 {
 	if (!efx->ptp_data)
 		return 0;
diff --git a/drivers/net/ethernet/sfc/ptp.h b/drivers/net/ethernet/sfc/ptp.h
index 6946203499ef..2b52a4b5cc8f 100644
--- a/drivers/net/ethernet/sfc/ptp.h
+++ b/drivers/net/ethernet/sfc/ptp.h
@@ -31,7 +31,7 @@ int efx_ptp_change_mode(struct efx_nic *efx, bool enable_wanted,
 			unsigned int new_mode);
 int efx_ptp_tx(struct efx_nic *efx, struct sk_buff *skb);
 void efx_ptp_event(struct efx_nic *efx, efx_qword_t *ev);
-size_t efx_ptp_describe_stats(struct efx_nic *efx, u8 *strings);
+size_t efx_ptp_describe_stats(struct efx_nic *efx, u8 **strings);
 size_t efx_ptp_update_stats(struct efx_nic *efx, u64 *stats);
 void efx_time_sync_event(struct efx_channel *channel, efx_qword_t *ev);
 void __efx_rx_skb_attach_timestamp(struct efx_channel *channel,
diff --git a/drivers/net/ethernet/sfc/siena/ethtool_common.c b/drivers/net/ethernet/sfc/siena/ethtool_common.c
index 075fef64de68..eeee676fdca7 100644
--- a/drivers/net/ethernet/sfc/siena/ethtool_common.c
+++ b/drivers/net/ethernet/sfc/siena/ethtool_common.c
@@ -395,7 +395,7 @@ void efx_siena_ethtool_self_test(struct net_device *net_dev,
 		test->flags |= ETH_TEST_FL_FAILED;
 }
 
-static size_t efx_describe_per_queue_stats(struct efx_nic *efx, u8 *strings)
+static size_t efx_describe_per_queue_stats(struct efx_nic *efx, u8 **strings)
 {
 	size_t n_stats = 0;
 	struct efx_channel *channel;
@@ -403,24 +403,22 @@ static size_t efx_describe_per_queue_stats(struct efx_nic *efx, u8 *strings)
 	efx_for_each_channel(channel, efx) {
 		if (efx_channel_has_tx_queues(channel)) {
 			n_stats++;
-			if (strings != NULL) {
-				snprintf(strings, ETH_GSTRING_LEN,
-					 "tx-%u.tx_packets",
-					 channel->tx_queue[0].queue /
-					 EFX_MAX_TXQ_PER_CHANNEL);
+			if (!strings)
+				continue;
 
-				strings += ETH_GSTRING_LEN;
-			}
+			ethtool_sprintf(strings, "tx-%u.tx_packets",
+					channel->tx_queue[0].queue /
+						EFX_MAX_TXQ_PER_CHANNEL);
 		}
 	}
 	efx_for_each_channel(channel, efx) {
 		if (efx_channel_has_rx_queue(channel)) {
 			n_stats++;
-			if (strings != NULL) {
-				snprintf(strings, ETH_GSTRING_LEN,
-					 "rx-%d.rx_packets", channel->channel);
-				strings += ETH_GSTRING_LEN;
-			}
+			if (!strings)
+				continue;
+
+			ethtool_sprintf(strings, "rx-%d.rx_packets",
+					channel->channel);
 		}
 	}
 	if (efx->xdp_tx_queue_count && efx->xdp_tx_queues) {
@@ -428,11 +426,11 @@ static size_t efx_describe_per_queue_stats(struct efx_nic *efx, u8 *strings)
 
 		for (xdp = 0; xdp < efx->xdp_tx_queue_count; xdp++) {
 			n_stats++;
-			if (strings) {
-				snprintf(strings, ETH_GSTRING_LEN,
-					 "tx-xdp-cpu-%hu.tx_packets", xdp);
-				strings += ETH_GSTRING_LEN;
-			}
+			if (!strings)
+				continue;
+
+			ethtool_sprintf(strings, "tx-xdp-cpu-%hu.tx_packets",
+					xdp);
 		}
 	}
 
@@ -464,15 +462,11 @@ void efx_siena_ethtool_get_strings(struct net_device *net_dev,
 
 	switch (string_set) {
 	case ETH_SS_STATS:
-		strings += (efx->type->describe_stats(efx, strings) *
-			    ETH_GSTRING_LEN);
+		efx->type->describe_stats(efx, &strings);
 		for (i = 0; i < EFX_ETHTOOL_SW_STAT_COUNT; i++)
-			strscpy(strings + i * ETH_GSTRING_LEN,
-				efx_sw_stat_desc[i].name, ETH_GSTRING_LEN);
-		strings += EFX_ETHTOOL_SW_STAT_COUNT * ETH_GSTRING_LEN;
-		strings += (efx_describe_per_queue_stats(efx, strings) *
-			    ETH_GSTRING_LEN);
-		efx_siena_ptp_describe_stats(efx, strings);
+			ethtool_puts(&strings, efx_sw_stat_desc[i].name);
+		efx_describe_per_queue_stats(efx, &strings);
+		efx_siena_ptp_describe_stats(efx, &strings);
 		break;
 	case ETH_SS_TEST:
 		efx_ethtool_fill_self_tests(efx, NULL, strings, NULL);
diff --git a/drivers/net/ethernet/sfc/siena/net_driver.h b/drivers/net/ethernet/sfc/siena/net_driver.h
index 3fa7c652ae9b..9785eff10607 100644
--- a/drivers/net/ethernet/sfc/siena/net_driver.h
+++ b/drivers/net/ethernet/sfc/siena/net_driver.h
@@ -1307,7 +1307,7 @@ struct efx_nic_type {
 	void (*finish_flush)(struct efx_nic *efx);
 	void (*prepare_flr)(struct efx_nic *efx);
 	void (*finish_flr)(struct efx_nic *efx);
-	size_t (*describe_stats)(struct efx_nic *efx, u8 *names);
+	size_t (*describe_stats)(struct efx_nic *efx, u8 **names);
 	size_t (*update_stats)(struct efx_nic *efx, u64 *full_stats,
 			       struct rtnl_link_stats64 *core_stats);
 	size_t (*update_stats_atomic)(struct efx_nic *efx, u64 *full_stats,
diff --git a/drivers/net/ethernet/sfc/siena/nic.c b/drivers/net/ethernet/sfc/siena/nic.c
index 0ea0433a6230..32fce70085e3 100644
--- a/drivers/net/ethernet/sfc/siena/nic.c
+++ b/drivers/net/ethernet/sfc/siena/nic.c
@@ -449,20 +449,20 @@ void efx_siena_get_regs(struct efx_nic *efx, void *buf)
  * Returns the number of visible statistics, i.e. the number of set
  * bits in the first @count bits of @mask for which a name is defined.
  */
-size_t efx_siena_describe_stats(const struct efx_hw_stat_desc *desc, size_t count,
-				const unsigned long *mask, u8 *names)
+size_t efx_siena_describe_stats(const struct efx_hw_stat_desc *desc,
+				size_t count, const unsigned long *mask,
+				u8 **names)
 {
 	size_t visible = 0;
 	size_t index;
 
 	for_each_set_bit(index, mask, count) {
 		if (desc[index].name) {
-			if (names) {
-				strscpy(names, desc[index].name,
-					ETH_GSTRING_LEN);
-				names += ETH_GSTRING_LEN;
-			}
 			++visible;
+			if (!names)
+				continue;
+
+			ethtool_puts(names, desc[index].name);
 		}
 	}
 
diff --git a/drivers/net/ethernet/sfc/siena/nic_common.h b/drivers/net/ethernet/sfc/siena/nic_common.h
index 3af0405eeaa4..b7fbe198008d 100644
--- a/drivers/net/ethernet/sfc/siena/nic_common.h
+++ b/drivers/net/ethernet/sfc/siena/nic_common.h
@@ -239,8 +239,9 @@ void efx_siena_get_regs(struct efx_nic *efx, void *buf);
 
 #define EFX_MC_STATS_GENERATION_INVALID ((__force __le64)(-1))
 
-size_t efx_siena_describe_stats(const struct efx_hw_stat_desc *desc, size_t count,
-				const unsigned long *mask, u8 *names);
+size_t efx_siena_describe_stats(const struct efx_hw_stat_desc *desc,
+				size_t count, const unsigned long *mask,
+				u8 **names);
 void efx_siena_update_stats(const struct efx_hw_stat_desc *desc, size_t count,
 			    const unsigned long *mask, u64 *stats,
 			    const void *dma_buf, bool accumulate);
diff --git a/drivers/net/ethernet/sfc/siena/ptp.c b/drivers/net/ethernet/sfc/siena/ptp.c
index 85005196b4c5..062c77c92077 100644
--- a/drivers/net/ethernet/sfc/siena/ptp.c
+++ b/drivers/net/ethernet/sfc/siena/ptp.c
@@ -393,7 +393,7 @@ static const unsigned long efx_ptp_stat_mask[] = {
 	[0 ... BITS_TO_LONGS(PTP_STAT_COUNT) - 1] = ~0UL,
 };
 
-size_t efx_siena_ptp_describe_stats(struct efx_nic *efx, u8 *strings)
+size_t efx_siena_ptp_describe_stats(struct efx_nic *efx, u8 **strings)
 {
 	if (!efx->ptp_data)
 		return 0;
diff --git a/drivers/net/ethernet/sfc/siena/ptp.h b/drivers/net/ethernet/sfc/siena/ptp.h
index b6133e7c5608..54840036ab67 100644
--- a/drivers/net/ethernet/sfc/siena/ptp.h
+++ b/drivers/net/ethernet/sfc/siena/ptp.h
@@ -28,7 +28,7 @@ int efx_siena_ptp_change_mode(struct efx_nic *efx, bool enable_wanted,
 			      unsigned int new_mode);
 int efx_siena_ptp_tx(struct efx_nic *efx, struct sk_buff *skb);
 void efx_siena_ptp_event(struct efx_nic *efx, efx_qword_t *ev);
-size_t efx_siena_ptp_describe_stats(struct efx_nic *efx, u8 *strings);
+size_t efx_siena_ptp_describe_stats(struct efx_nic *efx, u8 **strings);
 size_t efx_siena_ptp_update_stats(struct efx_nic *efx, u64 *stats);
 void efx_siena_time_sync_event(struct efx_channel *channel, efx_qword_t *ev);
 void __efx_siena_rx_skb_attach_timestamp(struct efx_channel *channel,
diff --git a/drivers/net/ethernet/sfc/siena/siena.c b/drivers/net/ethernet/sfc/siena/siena.c
index ca33dc08e555..49f0c8a1a90a 100644
--- a/drivers/net/ethernet/sfc/siena/siena.c
+++ b/drivers/net/ethernet/sfc/siena/siena.c
@@ -545,7 +545,7 @@ static const unsigned long siena_stat_mask[] = {
 	[0 ... BITS_TO_LONGS(SIENA_STAT_COUNT) - 1] = ~0UL,
 };
 
-static size_t siena_describe_nic_stats(struct efx_nic *efx, u8 *names)
+static size_t siena_describe_nic_stats(struct efx_nic *efx, u8 **names)
 {
 	return efx_siena_describe_stats(siena_stat_desc, SIENA_STAT_COUNT,
 					siena_stat_mask, names);
-- 
2.47.0


