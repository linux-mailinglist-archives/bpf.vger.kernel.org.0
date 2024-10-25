Return-Path: <bpf+bounces-43186-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D77DD9B0FA7
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 22:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C844F1C21812
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 20:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9892620EA32;
	Fri, 25 Oct 2024 20:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fiGerNMo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1420D17C9E8;
	Fri, 25 Oct 2024 20:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729887440; cv=none; b=b5UI2YWIYC4/nWKKIUmcTZ1ri3cFSYRaL+9+enEOCAXatn8bzC975i8bBeMduXtnCVIupZKrE68mtwK0B/Y+SRFcm3I0m4clCV4WfD1+i0bCoXE7xbaQkqx1S5cO8ljEvUdB1OZV0jBP5QdDFsJrfK2TMr+ELix8iDtGsG5Fi7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729887440; c=relaxed/simple;
	bh=WmqRJIOGnsDY3+h02QvcZgWVYRk7bISPfyVcMIuO20c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QQ8QxmIbkrwXl/0WJWgRn0c+FXYeHnWis5wVpfZk81BCpG3sMTYO4W1Dzb9bAc11L16YHTOB033Sj3lsnGiquqmSh8SDLnwZgMVb+nBqeGR50MvIL0w+DXlZOpw8Hzc2UC6NYj6/4eUkj0/D9y/RiDS5tcO6MF3xLOjz4dZJ+Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fiGerNMo; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71e79f73aaeso1692677b3a.3;
        Fri, 25 Oct 2024 13:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729887436; x=1730492236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1wc/QZe1hiCCq5FlwaTTiitAUZHpvboWKLlfnwXki6s=;
        b=fiGerNMoT9bnPPM0ZWbDQ4AjFNWJMqKN4Ea2UcNfv0KQb3Vr1ZWaXZUR318/BLzOYT
         XO6HhigSyTe3ipruX794tdeZWcjrba29AlgdSc93iJLMpD82VziV9NJe/P97T+UtrbFT
         lV71oRjiPoRBh1qRUxQlJ7zKvHiY28OUOk0hamyQVEJDplpxqi4aLtBRE/38yOQgIASg
         iXVlVhmFmxZ0mDfVc9Raj8sRJQxaAlirxZCI39Rx729CapVReMg/Teb4HJE2xxPm1J8r
         IoJ0UtJBtNqX1hSGG+RK4bCj6wSQqevB5bgZY4ZmtpPCVGXs+ZDcA6lU+1F8Nyc8a14Z
         I4hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729887436; x=1730492236;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1wc/QZe1hiCCq5FlwaTTiitAUZHpvboWKLlfnwXki6s=;
        b=TkyE5NyR8AES27nnBQuaroUH0OWKSf0oEfBzI2QhTg+JHDNYr9HWgpz9aM4gBTqAfj
         a/czJrkI/6lfj4B3eTz8z1/nGTJGZ8cs3jBMgQIXqMQdqAugRKJSS7TkOIN/W9t98TlW
         dAA8V94UTtmpRJa31HJC3SFMkMtYVA6lHgAVeQncKDP4GxWYzyQ3DSMT329kOWpQfBPa
         xSh0c+9ZR/GuQ+amB1XKgK7Bnm4vzMo24S3qnUdKxjoI6QT5LymOAa8+OlSSLdsp1hTk
         Ov72qF4Op2smDrJEqDZX4i5KKiwGxYNg/YPva+/JGuezy39JifHutTiqHsMGkW1Yb+5d
         fIxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUb6AD81HNb1JDcED7bfzgHH8IUlfAkrCjLadWqBjFwlDQZm31ZrbfosTGgjN1OwiqA7oMt6MHrERBC2wYJ@vger.kernel.org, AJvYcCXyIKtOuqL9jh4C0xm5qkMpzVx+GIaEb+vV2rnSPgeQuDci214GvvN3PYFXWaZA+Jjubm8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4JHBXtPvmUMYs56bwKL/jifdZOSbc34cAia86+YLpJhLfCPmE
	/7YM8PYnRuPtkk0oyZSXGRNGhROM2xGPCiciNX1op4hUV3eeVcZ5RGO+KaaX
X-Google-Smtp-Source: AGHT+IFy/XpPK5XHbCp3ZcMUxcmsqjAA3atraI3Q40V3KVXnSL7m4jzYB5iT5tJHNZvoUDUcDGUpZw==
X-Received: by 2002:a05:6a00:2e08:b0:71e:6f63:f076 with SMTP id d2e1a72fcca58-72062f4e5c7mr902990b3a.5.1729887436038;
        Fri, 25 Oct 2024 13:17:16 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a3c228sm1478335b3a.187.2024.10.25.13.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 13:17:15 -0700 (PDT)
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
Subject: [PATCHv2 net-next iwl-next] net: intel: use ethtool string helpers
Date: Fri, 25 Oct 2024 13:17:13 -0700
Message-ID: <20241025201713.286074-1-rosenp@gmail.com>
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
 v2: add iwl-next tag. use inline int in for loops.
 .../net/ethernet/intel/e1000/e1000_ethtool.c  | 10 ++---
 drivers/net/ethernet/intel/e1000e/ethtool.c   | 14 +++----
 .../net/ethernet/intel/fm10k/fm10k_ethtool.c  | 10 ++---
 .../net/ethernet/intel/i40e/i40e_ethtool.c    |  6 +--
 drivers/net/ethernet/intel/ice/ice_ethtool.c  | 37 +++++++++++--------
 drivers/net/ethernet/intel/igb/igb_ethtool.c  | 35 ++++++++++--------
 drivers/net/ethernet/intel/igbvf/ethtool.c    | 10 ++---
 drivers/net/ethernet/intel/igc/igc_ethtool.c  | 36 +++++++++---------
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  | 32 ++++++++--------
 drivers/net/ethernet/intel/ixgbevf/ethtool.c  | 36 +++++++-----------
 10 files changed, 115 insertions(+), 111 deletions(-)

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


