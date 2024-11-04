Return-Path: <bpf+bounces-43947-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE719BBEC7
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 21:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2045FB2151D
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 20:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897FF1E572C;
	Mon,  4 Nov 2024 20:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCQaniXB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BF41C876D;
	Mon,  4 Nov 2024 20:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730752031; cv=none; b=PpY1YNVVS2ihh9KLSwYOs5Rk9L+ur6RNCmkeVPEdLiWmzq80N77TzeMnJx0m9dhAwj5irS5/U64doBRIAbfr+dMO8LgZp1SD7aICgLt20PeEdlk7GlCeiUI4rcKmWxygiIN5qNr/wx5fmk6vindYVnxdlNQK8uT5zStCE+UIj5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730752031; c=relaxed/simple;
	bh=zNFhcFpEP65NUzbAtTkXf545aP3mOPVQlH7TWQL+oVc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f9hya3KuGmjDabWyybYLzFCn1hUpId3GVkhf4dgG6JB9gS/VEapTltpvTEwuJ8jvHi4ZsC7STt00ls89hqeNKobEkM0aaUM7CPskHRA4I/ZpzpwNbqLinelloio95oy/+D1ju7qVQ2vei746F0B7YCqq90AFQptQ9JgxIB0wV0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jCQaniXB; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20c693b68f5so49832345ad.1;
        Mon, 04 Nov 2024 12:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730752029; x=1731356829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RHtMBfQecyyKv9bmAtAYemSSyWK9CXs7Ly84qsFf5U8=;
        b=jCQaniXBwpLOtbgAm8+k5Ttu+/9MfIEemRaPNfqaqUy12DoCPut3MMa/ujisdDYXmQ
         bVyTmLhLocIN63QcUomWaEgGH80iXHtCgI2KSAvDUOML/eb1S5W0cxLidep+swtyyMbc
         Uq2GZfH9P9LDvXUbuYFjOaoiMeMKxTH5wU8p12kmv7sNULv5ErAepBwo++t3sJeVcmRA
         0TKeCuzjPRW2LoJUpM/EMF7kp55tUYEGfPqGwALjTVs18sM5s+U4W+ePOcApfmzMIP/x
         BiMGrQrb2lJe7l+j9ltF+4VdL6+dH/YMUaNHvZ4JFSXHvDuckpKpoh58ZtfDwjxfuH0D
         6Tww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730752029; x=1731356829;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RHtMBfQecyyKv9bmAtAYemSSyWK9CXs7Ly84qsFf5U8=;
        b=Dsor7MRM7GbZg5WrCjCFFMPShvQFabXnwUAUD3C2fYbaB0ToVtAyYu2S4wcUtL3843
         TsMaKlVKbonh4S4s4kgPx1ZxRZMhIPiGN7D8ejU3K0N+mq54O4tbeC7sinnkyI1Yi03l
         fLS3KUuhcqEbOgsiFH/9lgh/Pwpswo153eQ4Q8LGvvVixL7zQPJOZu9Uhqo71l4kDgor
         45GIgTLnMdGjFUyFVB/h5YTuxzOxX0LoBFru2jSKqA85hgxT4h5XD5FF0yzKxVvozwtM
         Sx7qH4yKdT0M5YAP4Obsa7z6//+3myobVFdBu4LO3lLpwHs4rRPslu4v5a5+B8tXvVS1
         mM/Q==
X-Forwarded-Encrypted: i=1; AJvYcCW3bJRRYGvK72m6ouOEmAgK38OQxoazg/4VE7NhAeYXU1FwmTmT2AQ6RSGtm94bb+z0RPo=@vger.kernel.org, AJvYcCXvx6KxdfSBfpovkiqEtUnjd1WI1JeZAHMXINplqkpwh3BqtZCjKTtTJk6qRZKNbJYe1ON+edz2orAdZLNf@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf8+e2FyzDFr8ZCDSE9AbeUaVcYpWeBBfCK5yO4VNC6ncxR/6X
	HPjzFp8v7AFQtBlCEi93xviYDTtzsCo9OI/gsZzUe+WxKMJD8fgAmrIcb6SP
X-Google-Smtp-Source: AGHT+IGwx4SmI9ceRF/57XXFL+jnLXt/f43mLfRRmWIi1TEpIz9VSsTQSeK140PRBYiXCKNFROOojg==
X-Received: by 2002:a17:902:ea0a:b0:20c:b876:b4eb with SMTP id d9443c01a7336-21103ca9ebemr256880845ad.59.1730752028558;
        Mon, 04 Nov 2024 12:27:08 -0800 (PST)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057d5326sm63976945ad.278.2024.11.04.12.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 12:27:08 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Edward Cree <ecree.xilinx@gmail.com>,
	Martin Habets <habetsm.xilinx@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	linux-net-drivers@amd.com (open list:SFC NETWORK DRIVER),
	linux-kernel@vger.kernel.org (open list),
	bpf@vger.kernel.org (open list:XDP (eXpress Data Path):Keyword:(?:\b|_)xdp(?:\b|_))
Subject: [PATCH net-next] net: sfc: use ethtool string helpers
Date: Mon,  4 Nov 2024 12:27:05 -0800
Message-ID: <20241104202705.120939-1-rosenp@gmail.com>
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
 drivers/net/ethernet/sfc/ethtool_common.c     | 34 +++++++------------
 drivers/net/ethernet/sfc/falcon/ethtool.c     | 24 +++++--------
 drivers/net/ethernet/sfc/falcon/nic.c         |  7 ++--
 drivers/net/ethernet/sfc/nic.c                |  7 ++--
 .../net/ethernet/sfc/siena/ethtool_common.c   | 34 +++++++------------
 drivers/net/ethernet/sfc/siena/nic.c          |  7 ++--
 6 files changed, 40 insertions(+), 73 deletions(-)

diff --git a/drivers/net/ethernet/sfc/ethtool_common.c b/drivers/net/ethernet/sfc/ethtool_common.c
index ae32e08540fa..d46972f45ec1 100644
--- a/drivers/net/ethernet/sfc/ethtool_common.c
+++ b/drivers/net/ethernet/sfc/ethtool_common.c
@@ -403,24 +403,19 @@ static size_t efx_describe_per_queue_stats(struct efx_nic *efx, u8 *strings)
 	efx_for_each_channel(channel, efx) {
 		if (efx_channel_has_tx_queues(channel)) {
 			n_stats++;
-			if (strings != NULL) {
-				snprintf(strings, ETH_GSTRING_LEN,
-					 "tx-%u.tx_packets",
-					 channel->tx_queue[0].queue /
-					 EFX_MAX_TXQ_PER_CHANNEL);
-
-				strings += ETH_GSTRING_LEN;
-			}
+			if (strings)
+				ethtool_sprintf(
+					&strings, "tx-%u.tx_packets",
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
+			if (strings)
+				ethtool_sprintf(&strings, "rx-%d.rx_packets",
+						channel->channel);
 		}
 	}
 	if (efx->xdp_tx_queue_count && efx->xdp_tx_queues) {
@@ -428,11 +423,10 @@ static size_t efx_describe_per_queue_stats(struct efx_nic *efx, u8 *strings)
 
 		for (xdp = 0; xdp < efx->xdp_tx_queue_count; xdp++) {
 			n_stats++;
-			if (strings) {
-				snprintf(strings, ETH_GSTRING_LEN,
-					 "tx-xdp-cpu-%hu.tx_packets", xdp);
-				strings += ETH_GSTRING_LEN;
-			}
+			if (strings)
+				ethtool_sprintf(&strings,
+						"tx-xdp-cpu-%hu.tx_packets",
+						xdp);
 		}
 	}
 
@@ -467,9 +461,7 @@ void efx_ethtool_get_strings(struct net_device *net_dev,
 		strings += (efx->type->describe_stats(efx, strings) *
 			    ETH_GSTRING_LEN);
 		for (i = 0; i < EFX_ETHTOOL_SW_STAT_COUNT; i++)
-			strscpy(strings + i * ETH_GSTRING_LEN,
-				efx_sw_stat_desc[i].name, ETH_GSTRING_LEN);
-		strings += EFX_ETHTOOL_SW_STAT_COUNT * ETH_GSTRING_LEN;
+			ethtool_puts(&strings, efx_sw_stat_desc[i].name);
 		strings += (efx_describe_per_queue_stats(efx, strings) *
 			    ETH_GSTRING_LEN);
 		efx_ptp_describe_stats(efx, strings);
diff --git a/drivers/net/ethernet/sfc/falcon/ethtool.c b/drivers/net/ethernet/sfc/falcon/ethtool.c
index f4db683b80f7..41bd63d0c40c 100644
--- a/drivers/net/ethernet/sfc/falcon/ethtool.c
+++ b/drivers/net/ethernet/sfc/falcon/ethtool.c
@@ -361,24 +361,18 @@ static size_t ef4_describe_per_queue_stats(struct ef4_nic *efx, u8 *strings)
 	ef4_for_each_channel(channel, efx) {
 		if (ef4_channel_has_tx_queues(channel)) {
 			n_stats++;
-			if (strings != NULL) {
-				snprintf(strings, ETH_GSTRING_LEN,
-					 "tx-%u.tx_packets",
-					 channel->tx_queue[0].queue /
-					 EF4_TXQ_TYPES);
-
-				strings += ETH_GSTRING_LEN;
-			}
+			if (strings)
+				ethtool_sprintf(&strings, "tx-%u.tx_packets",
+						channel->tx_queue[0].queue /
+							EF4_TXQ_TYPES);
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
+			if (strings)
+				ethtool_sprintf(&strings, "rx-%d.rx_packets",
+						channel->channel);
 		}
 	}
 	return n_stats;
@@ -412,9 +406,7 @@ static void ef4_ethtool_get_strings(struct net_device *net_dev,
 		strings += (efx->type->describe_stats(efx, strings) *
 			    ETH_GSTRING_LEN);
 		for (i = 0; i < EF4_ETHTOOL_SW_STAT_COUNT; i++)
-			strscpy(strings + i * ETH_GSTRING_LEN,
-				ef4_sw_stat_desc[i].name, ETH_GSTRING_LEN);
-		strings += EF4_ETHTOOL_SW_STAT_COUNT * ETH_GSTRING_LEN;
+			ethtool_puts(&strings, ef4_sw_stat_desc[i].name);
 		strings += (ef4_describe_per_queue_stats(efx, strings) *
 			    ETH_GSTRING_LEN);
 		break;
diff --git a/drivers/net/ethernet/sfc/falcon/nic.c b/drivers/net/ethernet/sfc/falcon/nic.c
index 78c851b5a56f..a7f0caa8710f 100644
--- a/drivers/net/ethernet/sfc/falcon/nic.c
+++ b/drivers/net/ethernet/sfc/falcon/nic.c
@@ -451,11 +451,8 @@ size_t ef4_nic_describe_stats(const struct ef4_hw_stat_desc *desc, size_t count,
 
 	for_each_set_bit(index, mask, count) {
 		if (desc[index].name) {
-			if (names) {
-				strscpy(names, desc[index].name,
-					ETH_GSTRING_LEN);
-				names += ETH_GSTRING_LEN;
-			}
+			if (names)
+				ethtool_puts(&names, desc[index].name);
 			++visible;
 		}
 	}
diff --git a/drivers/net/ethernet/sfc/nic.c b/drivers/net/ethernet/sfc/nic.c
index a33ed473cc8a..51c975cff4fe 100644
--- a/drivers/net/ethernet/sfc/nic.c
+++ b/drivers/net/ethernet/sfc/nic.c
@@ -306,11 +306,8 @@ size_t efx_nic_describe_stats(const struct efx_hw_stat_desc *desc, size_t count,
 
 	for_each_set_bit(index, mask, count) {
 		if (desc[index].name) {
-			if (names) {
-				strscpy(names, desc[index].name,
-					ETH_GSTRING_LEN);
-				names += ETH_GSTRING_LEN;
-			}
+			if (names)
+				ethtool_puts(&names, desc[index].name);
 			++visible;
 		}
 	}
diff --git a/drivers/net/ethernet/sfc/siena/ethtool_common.c b/drivers/net/ethernet/sfc/siena/ethtool_common.c
index 075fef64de68..53b1cdf872d8 100644
--- a/drivers/net/ethernet/sfc/siena/ethtool_common.c
+++ b/drivers/net/ethernet/sfc/siena/ethtool_common.c
@@ -403,24 +403,19 @@ static size_t efx_describe_per_queue_stats(struct efx_nic *efx, u8 *strings)
 	efx_for_each_channel(channel, efx) {
 		if (efx_channel_has_tx_queues(channel)) {
 			n_stats++;
-			if (strings != NULL) {
-				snprintf(strings, ETH_GSTRING_LEN,
-					 "tx-%u.tx_packets",
-					 channel->tx_queue[0].queue /
-					 EFX_MAX_TXQ_PER_CHANNEL);
-
-				strings += ETH_GSTRING_LEN;
-			}
+			if (strings)
+				ethtool_sprintf(
+					&strings, "tx-%u.tx_packets",
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
+			if (strings)
+				ethtool_sprintf(&strings, "rx-%d.rx_packets",
+						channel->channel);
 		}
 	}
 	if (efx->xdp_tx_queue_count && efx->xdp_tx_queues) {
@@ -428,11 +423,10 @@ static size_t efx_describe_per_queue_stats(struct efx_nic *efx, u8 *strings)
 
 		for (xdp = 0; xdp < efx->xdp_tx_queue_count; xdp++) {
 			n_stats++;
-			if (strings) {
-				snprintf(strings, ETH_GSTRING_LEN,
-					 "tx-xdp-cpu-%hu.tx_packets", xdp);
-				strings += ETH_GSTRING_LEN;
-			}
+			if (strings)
+				ethtool_sprintf(&strings,
+						"tx-xdp-cpu-%hu.tx_packets",
+						xdp);
 		}
 	}
 
@@ -467,9 +461,7 @@ void efx_siena_ethtool_get_strings(struct net_device *net_dev,
 		strings += (efx->type->describe_stats(efx, strings) *
 			    ETH_GSTRING_LEN);
 		for (i = 0; i < EFX_ETHTOOL_SW_STAT_COUNT; i++)
-			strscpy(strings + i * ETH_GSTRING_LEN,
-				efx_sw_stat_desc[i].name, ETH_GSTRING_LEN);
-		strings += EFX_ETHTOOL_SW_STAT_COUNT * ETH_GSTRING_LEN;
+			ethtool_puts(&strings, efx_sw_stat_desc[i].name);
 		strings += (efx_describe_per_queue_stats(efx, strings) *
 			    ETH_GSTRING_LEN);
 		efx_siena_ptp_describe_stats(efx, strings);
diff --git a/drivers/net/ethernet/sfc/siena/nic.c b/drivers/net/ethernet/sfc/siena/nic.c
index 0ea0433a6230..06b97218b490 100644
--- a/drivers/net/ethernet/sfc/siena/nic.c
+++ b/drivers/net/ethernet/sfc/siena/nic.c
@@ -457,11 +457,8 @@ size_t efx_siena_describe_stats(const struct efx_hw_stat_desc *desc, size_t coun
 
 	for_each_set_bit(index, mask, count) {
 		if (desc[index].name) {
-			if (names) {
-				strscpy(names, desc[index].name,
-					ETH_GSTRING_LEN);
-				names += ETH_GSTRING_LEN;
-			}
+			if (names)
+				ethtool_puts(&names, desc[index].name);
 			++visible;
 		}
 	}
-- 
2.47.0


