Return-Path: <bpf+bounces-43673-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05AE19B850B
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 22:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B834E280C9C
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 21:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250511CDA05;
	Thu, 31 Oct 2024 21:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYL4RoJ0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79F81C2DA4;
	Thu, 31 Oct 2024 21:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730409264; cv=none; b=JYfxbEVvmcDJz41P2VqObnaSGc0Yf0lqpA49C8sPxRnn3rgiT7MVVwi5v+d7WLYCSjCXooTaB2Pg2vuSaaP1iKqNUFQtEpR0f6QC/z0NFf/oL5cnLaiKMiQnKws1ebgtOPAdjeYx1WiUHGy7peBrSZQ1fCoUEy1k3YbqQgkD180=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730409264; c=relaxed/simple;
	bh=Pa9XBswT1M8WrAffQo5vF8YDLVCYPWCZ2nOIXhu+EoA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KIz0PAyu49R3tYGi7KSwRqVWbozUJotVztwCB+lF4N//u4cVEKUjQUP6aoP/cOSCDsHQqW8R52IEQdKBcowHKD4wsx51AL0+OHkzJlWQE0LuKGLtxE+YmFIPi2bWE0M2BLy2G9I+pUfohG7asgMKWXZvCiZyGHevdGEqURaCLCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QYL4RoJ0; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71e467c3996so1087479b3a.2;
        Thu, 31 Oct 2024 14:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730409257; x=1731014057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V/aeVyp/YGHFQWYn/TOFgL3CcHqXSTsHH6nQJSG1UhQ=;
        b=QYL4RoJ0xm1Y4aLmU9iGZi84H+tFr3Be9A2btIyUQUo6bvP7/Mu3cuyuVb5wD8rBLE
         NAlIMAi5RiCukcMzeSvqserScq8L6U3K7mjNSvEW/sef9pQ/V0BVjScDbe+LtHinRjhe
         XIb7lNllbKlVJRJKPUpCxQxjjh2W+0lwDTFjF7p9piOW/XwwPV8KVp2AZLVoOyFLHVOJ
         WUjE+cEcRcTC/0jkAJkL3GIjvTbu2C06QkWWtr/baNrgz+nkz0HH4HRfOc2rnJINTVwC
         k9bJUV8rmxVm4kWc/HgWksOUCW5v3xaaYdDB5EbpkcaCDqEI7GMmzPX3YfsmRC2Mbfnm
         W9Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730409257; x=1731014057;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V/aeVyp/YGHFQWYn/TOFgL3CcHqXSTsHH6nQJSG1UhQ=;
        b=rbhEo+U5PAcZB9bk6PK6IDim2r6yH6mhet8OCGiJwutPJTqtqYavkfoICTJRkf/uMv
         zVqbuY/6bFm6PwbGc0cxJiW7bN6l+qaN53erXMU6BVKcoUaaot5BsB05m7BSajSeHtG1
         Q9r37uUxHU0CpRBMIx12J6rigdhAugmbWc85A6HkvKgyotJRl6D4FtmbwSCo27bsdLrT
         zRDMl9Pqcf4fMKzMGw2QSQXN4YacI8av6tCjyTjdlA+UVc9qJ4D9pc/+jSHf8a1w6pb6
         Gl4S54AboEQBdXSOqwMV98LnQcyxeXKgpjdeRDfUFqbmrS9m6ehC/hwXPwoP/hGBa3sv
         un3w==
X-Forwarded-Encrypted: i=1; AJvYcCUiGNDAgJ7RFtezucnhuj22/JSeegWNyxx5xycH0VHJ0XjMzeG8Stz1VNp/JegVmxNhZTI=@vger.kernel.org, AJvYcCVekMDVOZdWnMFi0DbGMgvl3yMqoBvIo39ub9aWUVe4U3Y9Y0zR2mj5ZhrHv3sBJhKv9E0EHUlEsgnVIDiM@vger.kernel.org
X-Gm-Message-State: AOJu0YwMnX8Q16VHbOMN18ibWjMKrKWg6boPpUHLsmqYt1hq07dtHOqd
	f+xDcUHWzCxXuwnL2K74Vr7xgVA9fSGgzOLNXmG8sy+xQ8Ol21bN2OGPWyhU
X-Google-Smtp-Source: AGHT+IH3UpDvfE0UgB7q4UUa3LsW0t+xBx+6PnLJvGJ6HOalkBat3n3YadhG7kEB1G7xe6xE18UXuA==
X-Received: by 2002:a05:6a20:8c22:b0:1d9:c6a6:61d8 with SMTP id adf61e73a8af0-1d9c6a661dbmr15697405637.7.1730409256713;
        Thu, 31 Oct 2024 14:14:16 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee455a74b3sm1445315a12.52.2024.10.31.14.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 14:14:16 -0700 (PDT)
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
Subject: [PATCHv3 net-next iwl-next] net: intel: use ethtool string helpers
Date: Thu, 31 Oct 2024 14:14:13 -0700
Message-ID: <20241031211413.2219686-1-rosenp@gmail.com>
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
 v3: change custom get_strings to u8** to make sure pointer increments
 get propagated.
 v2: add iwl-next tag. use inline int in for loops.
 .../net/ethernet/intel/e1000/e1000_ethtool.c  | 10 ++---
 drivers/net/ethernet/intel/e1000e/ethtool.c   | 14 +++---
 .../net/ethernet/intel/fm10k/fm10k_ethtool.c  | 10 ++---
 .../net/ethernet/intel/i40e/i40e_ethtool.c    |  6 +--
 drivers/net/ethernet/intel/ice/ice_ethtool.c  | 43 +++++++++++--------
 drivers/net/ethernet/intel/igb/igb_ethtool.c  | 35 ++++++++-------
 drivers/net/ethernet/intel/igbvf/ethtool.c    | 10 ++---
 drivers/net/ethernet/intel/igc/igc_ethtool.c  | 36 ++++++++--------
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  | 32 +++++++-------
 drivers/net/ethernet/intel/ixgbevf/ethtool.c  | 36 ++++++----------
 10 files changed, 118 insertions(+), 114 deletions(-)

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
index 1bc5b6c0b897..fb03bb30154a 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
@@ -122,7 +122,7 @@ static const char fm10k_gstrings_test[][ETH_GSTRING_LEN] = {
 	"Mailbox test (on/offline)"
 };
 
-#define FM10K_TEST_LEN (sizeof(fm10k_gstrings_test) / ETH_GSTRING_LEN)
+#define FM10K_TEST_LEN ARRAY_SIZE(fm10k_gstrings_test)
 
 enum fm10k_self_test_types {
 	FM10K_TEST_MBX,
@@ -182,15 +182,15 @@ static void fm10k_get_strings(struct net_device *dev,
 {
 	switch (stringset) {
 	case ETH_SS_TEST:
-		memcpy(data, fm10k_gstrings_test,
-		       FM10K_TEST_LEN * ETH_GSTRING_LEN);
+		for (int i = 0; i < FM10K_TEST_LEN; i++)
+			ethtool_puts(&data, fm10k_gstrings_test[i]);
 		break;
 	case ETH_SS_STATS:
 		fm10k_get_stat_strings(dev, data);
 		break;
 	case ETH_SS_PRIV_FLAGS:
-		memcpy(data, fm10k_prv_flags,
-		       FM10K_PRV_FLAG_LEN * ETH_GSTRING_LEN);
+		for (int i = 0; i < FM10K_PRV_FLAG_LEN; i++)
+			ethtool_puts(&data, fm10k_prv_flags[i]);
 		break;
 	}
 }
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index f2506511bbff..90fc0c29fbd6 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -426,7 +426,7 @@ static const char i40e_gstrings_test[][ETH_GSTRING_LEN] = {
 	"Link test   (on/offline)"
 };
 
-#define I40E_TEST_LEN (sizeof(i40e_gstrings_test) / ETH_GSTRING_LEN)
+#define I40E_TEST_LEN ARRAY_SIZE(i40e_gstrings_test)
 
 struct i40e_priv_flags {
 	char flag_string[ETH_GSTRING_LEN];
@@ -2531,8 +2531,8 @@ static void i40e_get_strings(struct net_device *netdev, u32 stringset,
 {
 	switch (stringset) {
 	case ETH_SS_TEST:
-		memcpy(data, i40e_gstrings_test,
-		       I40E_TEST_LEN * ETH_GSTRING_LEN);
+		for (int i = 0; i < I40E_TEST_LEN; i++)
+			ethtool_puts(&data, i40e_gstrings_test[i]);
 		break;
 	case ETH_SS_STATS:
 		i40e_get_stat_strings(netdev, data);
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 2924ac61300d..81da126f83db 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -83,7 +83,7 @@ static const char ice_gstrings_test[][ETH_GSTRING_LEN] = {
 	"Link test   (on/offline)",
 };
 
-#define ICE_TEST_LEN (sizeof(ice_gstrings_test) / ETH_GSTRING_LEN)
+#define ICE_TEST_LEN ARRAY_SIZE(ice_gstrings_test)
 
 /* These PF_STATs might look like duplicates of some NETDEV_STATs,
  * but they aren't. This device is capable of supporting multiple
@@ -1478,51 +1478,56 @@ ice_self_test(struct net_device *netdev, struct ethtool_test *eth_test,
 }
 
 static void
-__ice_get_strings(struct net_device *netdev, u32 stringset, u8 *data,
+__ice_get_strings(struct net_device *netdev, u32 stringset, u8 **data,
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
+			ethtool_puts(data, str);
+		}
 
 		if (ice_is_port_repr_netdev(netdev))
 			return;
 
 		ice_for_each_alloc_txq(vsi, i) {
-			ethtool_sprintf(&p, "tx_queue_%u_packets", i);
-			ethtool_sprintf(&p, "tx_queue_%u_bytes", i);
+			ethtool_sprintf(data, "tx_queue_%u_packets", i);
+			ethtool_sprintf(data, "tx_queue_%u_bytes", i);
 		}
 
 		ice_for_each_alloc_rxq(vsi, i) {
-			ethtool_sprintf(&p, "rx_queue_%u_packets", i);
-			ethtool_sprintf(&p, "rx_queue_%u_bytes", i);
+			ethtool_sprintf(data, "rx_queue_%u_packets", i);
+			ethtool_sprintf(data, "rx_queue_%u_bytes", i);
 		}
 
 		if (vsi->type != ICE_VSI_PF)
 			return;
 
-		for (i = 0; i < ICE_PF_STATS_LEN; i++)
-			ethtool_puts(&p, ice_gstrings_pf_stats[i].stat_string);
+		for (i = 0; i < ICE_PF_STATS_LEN; i++) {
+			str = ice_gstrings_pf_stats[i].stat_string;
+			ethtool_puts(data, str);
+		}
 
 		for (i = 0; i < ICE_MAX_USER_PRIORITY; i++) {
-			ethtool_sprintf(&p, "tx_priority_%u_xon.nic", i);
-			ethtool_sprintf(&p, "tx_priority_%u_xoff.nic", i);
+			ethtool_sprintf(data, "tx_priority_%u_xon.nic", i);
+			ethtool_sprintf(data, "tx_priority_%u_xoff.nic", i);
 		}
 		for (i = 0; i < ICE_MAX_USER_PRIORITY; i++) {
-			ethtool_sprintf(&p, "rx_priority_%u_xon.nic", i);
-			ethtool_sprintf(&p, "rx_priority_%u_xoff.nic", i);
+			ethtool_sprintf(data, "rx_priority_%u_xon.nic", i);
+			ethtool_sprintf(data, "rx_priority_%u_xoff.nic", i);
 		}
 		break;
 	case ETH_SS_TEST:
-		memcpy(data, ice_gstrings_test, ICE_TEST_LEN * ETH_GSTRING_LEN);
+		for (i = 0; i < ICE_TEST_LEN; i++)
+			ethtool_puts(data, ice_gstrings_test[i]);
 		break;
 	case ETH_SS_PRIV_FLAGS:
 		for (i = 0; i < ICE_PRIV_FLAG_ARRAY_SIZE; i++)
-			ethtool_puts(&p, ice_gstrings_priv_flags[i].name);
+			ethtool_puts(data, ice_gstrings_priv_flags[i].name);
 		break;
 	default:
 		break;
@@ -1533,7 +1538,7 @@ static void ice_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
 {
 	struct ice_netdev_priv *np = netdev_priv(netdev);
 
-	__ice_get_strings(netdev, stringset, data, np->vsi);
+	__ice_get_strings(netdev, stringset, &data, np->vsi);
 }
 
 static int
@@ -4427,7 +4432,7 @@ ice_repr_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
 	if (repr->ops.ready(repr) || stringset != ETH_SS_STATS)
 		return;
 
-	__ice_get_strings(netdev, stringset, data, repr->src_vsi);
+	__ice_get_strings(netdev, stringset, &data, repr->src_vsi);
 }
 
 static void
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


