Return-Path: <bpf+bounces-43081-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C41809AF316
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 21:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 817222821C5
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 19:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0061FC7FE;
	Thu, 24 Oct 2024 19:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XP3RnTLw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6968C19CC3A;
	Thu, 24 Oct 2024 19:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729799813; cv=none; b=gRs2143U7fnYjBn0NDg/Ua/ib9SigWYoR4wg23WFS3BuMxCWe1eKzQWtQ7ZM5jmVKaTOG7I9wfu6fCqPkNDRdx+/bP62hgrV4axLEZ0NY8SAAh4AIixkeoW5K20vjKcWMh550inla4hI14uVdIOHrsKWeTJK3p72Y7sVIt8YpGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729799813; c=relaxed/simple;
	bh=jfheUJXRXphnInu0N8u3js8I9OFFNqmCme1OL1+9W0o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dKs+K5+GWuoMCHESayUrkyKIFRRU7SLfceU91n+aLff7UpAKvTiKirJXvCuu0m9RaZmfomTgmyM+LJ1m+SED+r52HB9r0AfWjwUFVhu+1e9acDuFQ3tDmyUz6mY8TF4zjl5Tm794xzcfHx0awdrMEYg+32U87GDoaoU+20zSm+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XP3RnTLw; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7db238d07b3so877728a12.2;
        Thu, 24 Oct 2024 12:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729799809; x=1730404609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n0M5qg+opbMnajsYEiFgs7dkzouioWHNOMwmoWUb8C8=;
        b=XP3RnTLwQjkX9y5DsDDvs4aphZFlY7cmDNbGgY85Sh+FMQeKtbzEeB4WfjaBG4Uaan
         lRe5RvbCYWZZ2xtFLmTE73uFR9WIGK7Sk4L8jfQoZNW+2VIaXTnp/mRcdg8PFyjHe0H0
         55Sa6j45WsOu6VXMF0gHpJkAdLic/+iGWL/d45L13D3bap69oRKlzh5SPgRXRQFZO+8K
         w68IPy4V+99G8RMhgbddBMzqdYzWvxoAlp9UOwt3gWtbhdjjXdxCApJ8DHIYZu3qLp7I
         QCzC4xBW/l0+W17uTULpBlaYpCdyAls4sdssmlPoZ8LPRgsHn5XpUtNEl97JxfzTldWR
         xNmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729799809; x=1730404609;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n0M5qg+opbMnajsYEiFgs7dkzouioWHNOMwmoWUb8C8=;
        b=smixYZPfxlCHtkg60LuAgZH+EZlEbwkT8lY13IVhlGdt0Eq6PQMCvbsoUJuRsEAqnY
         5cxWwuKS1V33bym9A83q0e6M81b1TTzUI8UxvVvLvLudfpYlC38Z4MHhDYWN4CHd9LXZ
         12WGqd2gaBBtZByhjHLZGzIG+7xBAJaxLAUy172+wZce16g5BrY1H+VKbVHUsXzI8WIp
         WQ8+ni6vggZrulDmboDeUG0nHxhDLErLVAHj3+Rt377aVqZB5WBNEPUffSyvXGHiemEN
         HVFFCe19z4kjapmhMglbebiXVMl/109mkTBbBwUdCZxPhQyWRQEBctyG2Sf39tH5XsLk
         BXzg==
X-Forwarded-Encrypted: i=1; AJvYcCVXfPkcaKhglX5A7jLS5vxCNy2BzuvpNvkjhda8g+hitKmqUiOPe2jhEzxBtA0d2DbqkLY=@vger.kernel.org, AJvYcCWXf/IyrjSB9zJvB7746NK439iMr02mXPOk/toPWzfzH+hu+FJwhDzxMtjy04CvxFbveecQu7y9b61i0GM6@vger.kernel.org
X-Gm-Message-State: AOJu0YxysQw2Dek5qJWY+8nbmXB7AxBewNigwQT6SXhHFHr4qCcso3vT
	icn8QrMmlfWD9KxRbbcll3B9LZLbQEhBXdQBPGlw4j/1sT7Xf19bwfSZXSmQ
X-Google-Smtp-Source: AGHT+IHdZCwLUfzW3pSUTEPCLeUJMGfDJgXFJED02bnL4dznZxTGoq56+zS5WaDb1pVoSATrJgcwpg==
X-Received: by 2002:a05:6a20:b418:b0:1d2:e888:fcd1 with SMTP id adf61e73a8af0-1d989cc9341mr3458237637.33.1729799809359;
        Thu, 24 Oct 2024 12:56:49 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec13ea1f3sm8601300b3a.147.2024.10.24.12.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 12:56:49 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
	linux-kernel@vger.kernel.org (open list),
	bpf@vger.kernel.org (open list:XDP (eXpress Data Path):Keyword:(?:\b|_)xdp(?:\b|_))
Subject: [PATCH net-next] net: intel: use ethtool string helpers
Date: Thu, 24 Oct 2024 12:56:47 -0700
Message-ID: <20241024195647.176614-1-rosenp@gmail.com>
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
 .../net/ethernet/intel/e1000/e1000_ethtool.c  | 10 ++---
 drivers/net/ethernet/intel/e1000e/ethtool.c   | 14 +++----
 .../net/ethernet/intel/fm10k/fm10k_ethtool.c  | 12 +++---
 .../net/ethernet/intel/i40e/i40e_ethtool.c    |  8 ++--
 drivers/net/ethernet/intel/ice/ice_ethtool.c  | 37 +++++++++++--------
 drivers/net/ethernet/intel/igb/igb_ethtool.c  | 35 ++++++++++--------
 drivers/net/ethernet/intel/igbvf/ethtool.c    | 10 ++---
 drivers/net/ethernet/intel/igc/igc_ethtool.c  | 36 +++++++++---------
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  | 32 ++++++++--------
 drivers/net/ethernet/intel/ixgbevf/ethtool.c  | 36 +++++++-----------
 10 files changed, 119 insertions(+), 111 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
index d06d29c6c037..33222fadb3b9 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
@@ -1839,18 +1839,18 @@ static void e1000_get_ethtool_stats(struct net_device *netdev,
 static void e1000_get_strings(struct net_device *netdev, u32 stringset,
 			      u8 *data)
 {
-	u8 *p = data;
+	const char *str;
 	int i;
 
 	switch (stringset) {
 	case ETH_SS_TEST:
-		memcpy(data, e1000_gstrings_test, sizeof(e1000_gstrings_test));
+		for (i = 0; i < E1000_TEST_LEN; i++)
+			ethtool_puts(&data, e1000_gstrings_test[i]);
 		break;
 	case ETH_SS_STATS:
 		for (i = 0; i < E1000_GLOBAL_STATS_LEN; i++) {
-			memcpy(p, e1000_gstrings_stats[i].stat_string,
-			       ETH_GSTRING_LEN);
-			p += ETH_GSTRING_LEN;
+			str = e1000_gstrings_stats[i].stat_string;
+			ethtool_puts(&data, str);
 		}
 		/* BUG_ON(p - data != E1000_STATS_LEN * ETH_GSTRING_LEN); */
 		break;
diff --git a/drivers/net/ethernet/intel/e1000e/ethtool.c b/drivers/net/ethernet/intel/e1000e/ethtool.c
index 9364bc2b4eb1..ab590b69c14f 100644
--- a/drivers/net/ethernet/intel/e1000e/ethtool.c
+++ b/drivers/net/ethernet/intel/e1000e/ethtool.c
@@ -2075,23 +2075,23 @@ static void e1000_get_ethtool_stats(struct net_device *netdev,
 static void e1000_get_strings(struct net_device __always_unused *netdev,
 			      u32 stringset, u8 *data)
 {
-	u8 *p = data;
+	const char *str;
 	int i;
 
 	switch (stringset) {
 	case ETH_SS_TEST:
-		memcpy(data, e1000_gstrings_test, sizeof(e1000_gstrings_test));
+		for (i = 0; i < E1000_TEST_LEN; i++)
+			ethtool_puts(&data, e1000_gstrings_test[i]);
 		break;
 	case ETH_SS_STATS:
 		for (i = 0; i < E1000_GLOBAL_STATS_LEN; i++) {
-			memcpy(p, e1000_gstrings_stats[i].stat_string,
-			       ETH_GSTRING_LEN);
-			p += ETH_GSTRING_LEN;
+			str = e1000_gstrings_stats[i].stat_string;
+			ethtool_puts(&data, str);
 		}
 		break;
 	case ETH_SS_PRIV_FLAGS:
-		memcpy(data, e1000e_priv_flags_strings,
-		       E1000E_PRIV_FLAGS_STR_LEN * ETH_GSTRING_LEN);
+		for (i = 0; i < E1000E_PRIV_FLAGS_STR_LEN; i++)
+			ethtool_puts(&data, e1000e_priv_flags_strings[i]);
 		break;
 	}
 }
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
index 1bc5b6c0b897..b86fb1be78df 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
@@ -122,7 +122,7 @@ static const char fm10k_gstrings_test[][ETH_GSTRING_LEN] = {
 	"Mailbox test (on/offline)"
 };
 
-#define FM10K_TEST_LEN (sizeof(fm10k_gstrings_test) / ETH_GSTRING_LEN)
+#define FM10K_TEST_LEN ARRAY_SIZE(fm10k_gstrings_test)
 
 enum fm10k_self_test_types {
 	FM10K_TEST_MBX,
@@ -180,17 +180,19 @@ static void fm10k_get_stat_strings(struct net_device *dev, u8 *data)
 static void fm10k_get_strings(struct net_device *dev,
 			      u32 stringset, u8 *data)
 {
+	int i;
+
 	switch (stringset) {
 	case ETH_SS_TEST:
-		memcpy(data, fm10k_gstrings_test,
-		       FM10K_TEST_LEN * ETH_GSTRING_LEN);
+		for (i = 0; i < FM10K_TEST_LEN; i++)
+			ethtool_puts(&data, fm10k_gstrings_test[i]);
 		break;
 	case ETH_SS_STATS:
 		fm10k_get_stat_strings(dev, data);
 		break;
 	case ETH_SS_PRIV_FLAGS:
-		memcpy(data, fm10k_prv_flags,
-		       FM10K_PRV_FLAG_LEN * ETH_GSTRING_LEN);
+		for (i = 0; i < FM10K_PRV_FLAG_LEN; i++)
+			ethtool_puts(&data, fm10k_prv_flags[i]);
 		break;
 	}
 }
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index f2506511bbff..ee63ef7ae393 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -426,7 +426,7 @@ static const char i40e_gstrings_test[][ETH_GSTRING_LEN] = {
 	"Link test   (on/offline)"
 };
 
-#define I40E_TEST_LEN (sizeof(i40e_gstrings_test) / ETH_GSTRING_LEN)
+#define I40E_TEST_LEN ARRAY_SIZE(i40e_gstrings_test)
 
 struct i40e_priv_flags {
 	char flag_string[ETH_GSTRING_LEN];
@@ -2529,10 +2529,12 @@ static void i40e_get_priv_flag_strings(struct net_device *netdev, u8 *data)
 static void i40e_get_strings(struct net_device *netdev, u32 stringset,
 			     u8 *data)
 {
+	int i;
+
 	switch (stringset) {
 	case ETH_SS_TEST:
-		memcpy(data, i40e_gstrings_test,
-		       I40E_TEST_LEN * ETH_GSTRING_LEN);
+		for (i = 0; i < I40E_TEST_LEN; i++)
+			ethtool_puts(&data, i40e_gstrings_test[i]);
 		break;
 	case ETH_SS_STATS:
 		i40e_get_stat_strings(netdev, data);
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 2924ac61300d..62a152be8180 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -83,7 +83,7 @@ static const char ice_gstrings_test[][ETH_GSTRING_LEN] = {
 	"Link test   (on/offline)",
 };
 
-#define ICE_TEST_LEN (sizeof(ice_gstrings_test) / ETH_GSTRING_LEN)
+#define ICE_TEST_LEN ARRAY_SIZE(ice_gstrings_test)
 
 /* These PF_STATs might look like duplicates of some NETDEV_STATs,
  * but they aren't. This device is capable of supporting multiple
@@ -1481,48 +1481,53 @@ static void
 __ice_get_strings(struct net_device *netdev, u32 stringset, u8 *data,
 		  struct ice_vsi *vsi)
 {
+	const char *str;
 	unsigned int i;
-	u8 *p = data;
 
 	switch (stringset) {
 	case ETH_SS_STATS:
-		for (i = 0; i < ICE_VSI_STATS_LEN; i++)
-			ethtool_puts(&p, ice_gstrings_vsi_stats[i].stat_string);
+		for (i = 0; i < ICE_VSI_STATS_LEN; i++) {
+			str = ice_gstrings_vsi_stats[i].stat_string;
+			ethtool_puts(&data, str);
+		}
 
 		if (ice_is_port_repr_netdev(netdev))
 			return;
 
 		ice_for_each_alloc_txq(vsi, i) {
-			ethtool_sprintf(&p, "tx_queue_%u_packets", i);
-			ethtool_sprintf(&p, "tx_queue_%u_bytes", i);
+			ethtool_sprintf(&data, "tx_queue_%u_packets", i);
+			ethtool_sprintf(&data, "tx_queue_%u_bytes", i);
 		}
 
 		ice_for_each_alloc_rxq(vsi, i) {
-			ethtool_sprintf(&p, "rx_queue_%u_packets", i);
-			ethtool_sprintf(&p, "rx_queue_%u_bytes", i);
+			ethtool_sprintf(&data, "rx_queue_%u_packets", i);
+			ethtool_sprintf(&data, "rx_queue_%u_bytes", i);
 		}
 
 		if (vsi->type != ICE_VSI_PF)
 			return;
 
-		for (i = 0; i < ICE_PF_STATS_LEN; i++)
-			ethtool_puts(&p, ice_gstrings_pf_stats[i].stat_string);
+		for (i = 0; i < ICE_PF_STATS_LEN; i++) {
+			str = ice_gstrings_pf_stats[i].stat_string;
+			ethtool_puts(&data, str);
+		}
 
 		for (i = 0; i < ICE_MAX_USER_PRIORITY; i++) {
-			ethtool_sprintf(&p, "tx_priority_%u_xon.nic", i);
-			ethtool_sprintf(&p, "tx_priority_%u_xoff.nic", i);
+			ethtool_sprintf(&data, "tx_priority_%u_xon.nic", i);
+			ethtool_sprintf(&data, "tx_priority_%u_xoff.nic", i);
 		}
 		for (i = 0; i < ICE_MAX_USER_PRIORITY; i++) {
-			ethtool_sprintf(&p, "rx_priority_%u_xon.nic", i);
-			ethtool_sprintf(&p, "rx_priority_%u_xoff.nic", i);
+			ethtool_sprintf(&data, "rx_priority_%u_xon.nic", i);
+			ethtool_sprintf(&data, "rx_priority_%u_xoff.nic", i);
 		}
 		break;
 	case ETH_SS_TEST:
-		memcpy(data, ice_gstrings_test, ICE_TEST_LEN * ETH_GSTRING_LEN);
+		for (i = 0; i < ICE_TEST_LEN; i++)
+			ethtool_puts(&data, ice_gstrings_test[i]);
 		break;
 	case ETH_SS_PRIV_FLAGS:
 		for (i = 0; i < ICE_PRIV_FLAG_ARRAY_SIZE; i++)
-			ethtool_puts(&p, ice_gstrings_priv_flags[i].name);
+			ethtool_puts(&data, ice_gstrings_priv_flags[i].name);
 		break;
 	default:
 		break;
diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index ca6ccbc13954..c4a8712389af 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -123,7 +123,7 @@ static const char igb_gstrings_test[][ETH_GSTRING_LEN] = {
 	[TEST_LOOP] = "Loopback test  (offline)",
 	[TEST_LINK] = "Link test   (on/offline)"
 };
-#define IGB_TEST_LEN (sizeof(igb_gstrings_test) / ETH_GSTRING_LEN)
+#define IGB_TEST_LEN ARRAY_SIZE(igb_gstrings_test)
 
 static const char igb_priv_flags_strings[][ETH_GSTRING_LEN] = {
 #define IGB_PRIV_FLAGS_LEGACY_RX	BIT(0)
@@ -2347,35 +2347,38 @@ static void igb_get_ethtool_stats(struct net_device *netdev,
 static void igb_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
 {
 	struct igb_adapter *adapter = netdev_priv(netdev);
-	u8 *p = data;
+	const char *str;
 	int i;
 
 	switch (stringset) {
 	case ETH_SS_TEST:
-		memcpy(data, igb_gstrings_test, sizeof(igb_gstrings_test));
+		for (i = 0; i < IGB_TEST_LEN; i++)
+			ethtool_puts(&data, igb_gstrings_test[i]);
 		break;
 	case ETH_SS_STATS:
 		for (i = 0; i < IGB_GLOBAL_STATS_LEN; i++)
-			ethtool_puts(&p, igb_gstrings_stats[i].stat_string);
-		for (i = 0; i < IGB_NETDEV_STATS_LEN; i++)
-			ethtool_puts(&p, igb_gstrings_net_stats[i].stat_string);
+			ethtool_puts(&data, igb_gstrings_stats[i].stat_string);
+		for (i = 0; i < IGB_NETDEV_STATS_LEN; i++) {
+			str = igb_gstrings_net_stats[i].stat_string;
+			ethtool_puts(&data, str);
+		}
 		for (i = 0; i < adapter->num_tx_queues; i++) {
-			ethtool_sprintf(&p, "tx_queue_%u_packets", i);
-			ethtool_sprintf(&p, "tx_queue_%u_bytes", i);
-			ethtool_sprintf(&p, "tx_queue_%u_restart", i);
+			ethtool_sprintf(&data, "tx_queue_%u_packets", i);
+			ethtool_sprintf(&data, "tx_queue_%u_bytes", i);
+			ethtool_sprintf(&data, "tx_queue_%u_restart", i);
 		}
 		for (i = 0; i < adapter->num_rx_queues; i++) {
-			ethtool_sprintf(&p, "rx_queue_%u_packets", i);
-			ethtool_sprintf(&p, "rx_queue_%u_bytes", i);
-			ethtool_sprintf(&p, "rx_queue_%u_drops", i);
-			ethtool_sprintf(&p, "rx_queue_%u_csum_err", i);
-			ethtool_sprintf(&p, "rx_queue_%u_alloc_failed", i);
+			ethtool_sprintf(&data, "rx_queue_%u_packets", i);
+			ethtool_sprintf(&data, "rx_queue_%u_bytes", i);
+			ethtool_sprintf(&data, "rx_queue_%u_drops", i);
+			ethtool_sprintf(&data, "rx_queue_%u_csum_err", i);
+			ethtool_sprintf(&data, "rx_queue_%u_alloc_failed", i);
 		}
 		/* BUG_ON(p - data != IGB_STATS_LEN * ETH_GSTRING_LEN); */
 		break;
 	case ETH_SS_PRIV_FLAGS:
-		memcpy(data, igb_priv_flags_strings,
-		       IGB_PRIV_FLAGS_STR_LEN * ETH_GSTRING_LEN);
+		for (i = 0; i < IGB_PRIV_FLAGS_STR_LEN; i++)
+			ethtool_puts(&data, igb_priv_flags_strings[i]);
 		break;
 	}
 }
diff --git a/drivers/net/ethernet/intel/igbvf/ethtool.c b/drivers/net/ethernet/intel/igbvf/ethtool.c
index 83b97989a6bd..2da95ea66718 100644
--- a/drivers/net/ethernet/intel/igbvf/ethtool.c
+++ b/drivers/net/ethernet/intel/igbvf/ethtool.c
@@ -412,18 +412,18 @@ static int igbvf_get_sset_count(struct net_device *dev, int stringset)
 static void igbvf_get_strings(struct net_device *netdev, u32 stringset,
 			      u8 *data)
 {
-	u8 *p = data;
+	const char *str;
 	int i;
 
 	switch (stringset) {
 	case ETH_SS_TEST:
-		memcpy(data, *igbvf_gstrings_test, sizeof(igbvf_gstrings_test));
+		for (i = 0; i < IGBVF_TEST_LEN; i++)
+			ethtool_puts(&data, igbvf_gstrings_test[i]);
 		break;
 	case ETH_SS_STATS:
 		for (i = 0; i < IGBVF_GLOBAL_STATS_LEN; i++) {
-			memcpy(p, igbvf_gstrings_stats[i].stat_string,
-			       ETH_GSTRING_LEN);
-			p += ETH_GSTRING_LEN;
+			str = igbvf_gstrings_stats[i].stat_string;
+			ethtool_puts(&data, str);
 		}
 		break;
 	}
diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 5b0c6f433767..7b118fb7097b 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -104,7 +104,7 @@ static const char igc_gstrings_test[][ETH_GSTRING_LEN] = {
 	[TEST_LINK] = "Link test   (on/offline)"
 };
 
-#define IGC_TEST_LEN (sizeof(igc_gstrings_test) / ETH_GSTRING_LEN)
+#define IGC_TEST_LEN ARRAY_SIZE(igc_gstrings_test)
 
 #define IGC_GLOBAL_STATS_LEN	\
 	(sizeof(igc_gstrings_stats) / sizeof(struct igc_stats))
@@ -763,36 +763,38 @@ static void igc_ethtool_get_strings(struct net_device *netdev, u32 stringset,
 				    u8 *data)
 {
 	struct igc_adapter *adapter = netdev_priv(netdev);
-	u8 *p = data;
+	const char *str;
 	int i;
 
 	switch (stringset) {
 	case ETH_SS_TEST:
-		memcpy(data, *igc_gstrings_test,
-		       IGC_TEST_LEN * ETH_GSTRING_LEN);
+		for (i = 0; i < IGC_TEST_LEN; i++)
+			ethtool_puts(&data, igc_gstrings_test[i]);
 		break;
 	case ETH_SS_STATS:
 		for (i = 0; i < IGC_GLOBAL_STATS_LEN; i++)
-			ethtool_puts(&p, igc_gstrings_stats[i].stat_string);
-		for (i = 0; i < IGC_NETDEV_STATS_LEN; i++)
-			ethtool_puts(&p, igc_gstrings_net_stats[i].stat_string);
+			ethtool_puts(&data, igc_gstrings_stats[i].stat_string);
+		for (i = 0; i < IGC_NETDEV_STATS_LEN; i++) {
+			str = igc_gstrings_net_stats[i].stat_string;
+			ethtool_puts(&data, str);
+		}
 		for (i = 0; i < adapter->num_tx_queues; i++) {
-			ethtool_sprintf(&p, "tx_queue_%u_packets", i);
-			ethtool_sprintf(&p, "tx_queue_%u_bytes", i);
-			ethtool_sprintf(&p, "tx_queue_%u_restart", i);
+			ethtool_sprintf(&data, "tx_queue_%u_packets", i);
+			ethtool_sprintf(&data, "tx_queue_%u_bytes", i);
+			ethtool_sprintf(&data, "tx_queue_%u_restart", i);
 		}
 		for (i = 0; i < adapter->num_rx_queues; i++) {
-			ethtool_sprintf(&p, "rx_queue_%u_packets", i);
-			ethtool_sprintf(&p, "rx_queue_%u_bytes", i);
-			ethtool_sprintf(&p, "rx_queue_%u_drops", i);
-			ethtool_sprintf(&p, "rx_queue_%u_csum_err", i);
-			ethtool_sprintf(&p, "rx_queue_%u_alloc_failed", i);
+			ethtool_sprintf(&data, "rx_queue_%u_packets", i);
+			ethtool_sprintf(&data, "rx_queue_%u_bytes", i);
+			ethtool_sprintf(&data, "rx_queue_%u_drops", i);
+			ethtool_sprintf(&data, "rx_queue_%u_csum_err", i);
+			ethtool_sprintf(&data, "rx_queue_%u_alloc_failed", i);
 		}
 		/* BUG_ON(p - data != IGC_STATS_LEN * ETH_GSTRING_LEN); */
 		break;
 	case ETH_SS_PRIV_FLAGS:
-		memcpy(data, igc_priv_flags_strings,
-		       IGC_PRIV_FLAGS_STR_LEN * ETH_GSTRING_LEN);
+		for (i = 0; i < IGC_PRIV_FLAGS_STR_LEN; i++)
+			ethtool_puts(&data, igc_priv_flags_strings[i]);
 		break;
 	}
 }
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index 9482e0cca8b7..b3b2e38c2ae6 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -129,7 +129,7 @@ static const char ixgbe_gstrings_test[][ETH_GSTRING_LEN] = {
 	"Interrupt test (offline)", "Loopback test  (offline)",
 	"Link test   (on/offline)"
 };
-#define IXGBE_TEST_LEN sizeof(ixgbe_gstrings_test) / ETH_GSTRING_LEN
+#define IXGBE_TEST_LEN ARRAY_SIZE(ixgbe_gstrings_test)
 
 static const char ixgbe_priv_flags_strings[][ETH_GSTRING_LEN] = {
 #define IXGBE_PRIV_FLAGS_LEGACY_RX	BIT(0)
@@ -1409,38 +1409,40 @@ static void ixgbe_get_ethtool_stats(struct net_device *netdev,
 static void ixgbe_get_strings(struct net_device *netdev, u32 stringset,
 			      u8 *data)
 {
+	const char *str;
 	unsigned int i;
-	u8 *p = data;
 
 	switch (stringset) {
 	case ETH_SS_TEST:
 		for (i = 0; i < IXGBE_TEST_LEN; i++)
-			ethtool_puts(&p, ixgbe_gstrings_test[i]);
+			ethtool_puts(&data, ixgbe_gstrings_test[i]);
 		break;
 	case ETH_SS_STATS:
-		for (i = 0; i < IXGBE_GLOBAL_STATS_LEN; i++)
-			ethtool_puts(&p, ixgbe_gstrings_stats[i].stat_string);
+		for (i = 0; i < IXGBE_GLOBAL_STATS_LEN; i++) {
+			str = ixgbe_gstrings_stats[i].stat_string;
+			ethtool_puts(&data, str);
+		}
 		for (i = 0; i < netdev->num_tx_queues; i++) {
-			ethtool_sprintf(&p, "tx_queue_%u_packets", i);
-			ethtool_sprintf(&p, "tx_queue_%u_bytes", i);
+			ethtool_sprintf(&data, "tx_queue_%u_packets", i);
+			ethtool_sprintf(&data, "tx_queue_%u_bytes", i);
 		}
 		for (i = 0; i < IXGBE_NUM_RX_QUEUES; i++) {
-			ethtool_sprintf(&p, "rx_queue_%u_packets", i);
-			ethtool_sprintf(&p, "rx_queue_%u_bytes", i);
+			ethtool_sprintf(&data, "rx_queue_%u_packets", i);
+			ethtool_sprintf(&data, "rx_queue_%u_bytes", i);
 		}
 		for (i = 0; i < IXGBE_MAX_PACKET_BUFFERS; i++) {
-			ethtool_sprintf(&p, "tx_pb_%u_pxon", i);
-			ethtool_sprintf(&p, "tx_pb_%u_pxoff", i);
+			ethtool_sprintf(&data, "tx_pb_%u_pxon", i);
+			ethtool_sprintf(&data, "tx_pb_%u_pxoff", i);
 		}
 		for (i = 0; i < IXGBE_MAX_PACKET_BUFFERS; i++) {
-			ethtool_sprintf(&p, "rx_pb_%u_pxon", i);
-			ethtool_sprintf(&p, "rx_pb_%u_pxoff", i);
+			ethtool_sprintf(&data, "rx_pb_%u_pxon", i);
+			ethtool_sprintf(&data, "rx_pb_%u_pxoff", i);
 		}
 		/* BUG_ON(p - data != IXGBE_STATS_LEN * ETH_GSTRING_LEN); */
 		break;
 	case ETH_SS_PRIV_FLAGS:
-		memcpy(data, ixgbe_priv_flags_strings,
-		       IXGBE_PRIV_FLAGS_STR_LEN * ETH_GSTRING_LEN);
+		for (i = 0; i < IXGBE_PRIV_FLAGS_STR_LEN; i++)
+			ethtool_puts(&data, ixgbe_priv_flags_strings[i]);
 	}
 }
 
diff --git a/drivers/net/ethernet/intel/ixgbevf/ethtool.c b/drivers/net/ethernet/intel/ixgbevf/ethtool.c
index 7ac53171b041..f63a9f683e20 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ethtool.c
@@ -70,7 +70,7 @@ static const char ixgbe_gstrings_test[][ETH_GSTRING_LEN] = {
 	"Link test   (on/offline)"
 };
 
-#define IXGBEVF_TEST_LEN (sizeof(ixgbe_gstrings_test) / ETH_GSTRING_LEN)
+#define IXGBEVF_TEST_LEN ARRAY_SIZE(ixgbe_gstrings_test)
 
 static const char ixgbevf_priv_flags_strings[][ETH_GSTRING_LEN] = {
 #define IXGBEVF_PRIV_FLAGS_LEGACY_RX	BIT(0)
@@ -504,43 +504,35 @@ static void ixgbevf_get_strings(struct net_device *netdev, u32 stringset,
 				u8 *data)
 {
 	struct ixgbevf_adapter *adapter = netdev_priv(netdev);
-	char *p = (char *)data;
+	const char *str;
 	int i;
 
 	switch (stringset) {
 	case ETH_SS_TEST:
-		memcpy(data, *ixgbe_gstrings_test,
-		       IXGBEVF_TEST_LEN * ETH_GSTRING_LEN);
+		for (i = 0; i < IXGBEVF_TEST_LEN; i++)
+			ethtool_puts(&data, ixgbe_gstrings_test[i]);
 		break;
 	case ETH_SS_STATS:
 		for (i = 0; i < IXGBEVF_GLOBAL_STATS_LEN; i++) {
-			memcpy(p, ixgbevf_gstrings_stats[i].stat_string,
-			       ETH_GSTRING_LEN);
-			p += ETH_GSTRING_LEN;
+			str = ixgbevf_gstrings_stats[i].stat_string;
+			ethtool_puts(&data, str);
 		}
-
 		for (i = 0; i < adapter->num_tx_queues; i++) {
-			sprintf(p, "tx_queue_%u_packets", i);
-			p += ETH_GSTRING_LEN;
-			sprintf(p, "tx_queue_%u_bytes", i);
-			p += ETH_GSTRING_LEN;
+			ethtool_sprintf(&data, "tx_queue_%u_packets", i);
+			ethtool_sprintf(&data, "tx_queue_%u_bytes", i);
 		}
 		for (i = 0; i < adapter->num_xdp_queues; i++) {
-			sprintf(p, "xdp_queue_%u_packets", i);
-			p += ETH_GSTRING_LEN;
-			sprintf(p, "xdp_queue_%u_bytes", i);
-			p += ETH_GSTRING_LEN;
+			ethtool_sprintf(&data, "xdp_queue_%u_packets", i);
+			ethtool_sprintf(&data, "xdp_queue_%u_bytes", i);
 		}
 		for (i = 0; i < adapter->num_rx_queues; i++) {
-			sprintf(p, "rx_queue_%u_packets", i);
-			p += ETH_GSTRING_LEN;
-			sprintf(p, "rx_queue_%u_bytes", i);
-			p += ETH_GSTRING_LEN;
+			ethtool_sprintf(&data, "rx_queue_%u_packets", i);
+			ethtool_sprintf(&data, "rx_queue_%u_bytes", i);
 		}
 		break;
 	case ETH_SS_PRIV_FLAGS:
-		memcpy(data, ixgbevf_priv_flags_strings,
-		       IXGBEVF_PRIV_FLAGS_STR_LEN * ETH_GSTRING_LEN);
+		for (i = 0; i < IXGBEVF_PRIV_FLAGS_STR_LEN; i++)
+			ethtool_puts(&data, ixgbevf_priv_flags_strings[i]);
 		break;
 	}
 }
-- 
2.47.0


