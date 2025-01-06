Return-Path: <bpf+bounces-48018-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A06B5A03292
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 23:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2364A3A54E9
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 22:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F71E1E25E8;
	Mon,  6 Jan 2025 22:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zd7zZy9p"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7500B1E1A31;
	Mon,  6 Jan 2025 22:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736201982; cv=none; b=ZigOCi390Hb3q1X0CNwIbgAz7+MvSA7NMxcgc2JP5EWsUozIkzF7vqbMY3kb52aRj+qEggox3LbyCILZfkihNeW3Vwcar0STUTFVDSe0eYBiSldOhHaVb3wT+YdK087rgS+DttB7V9QzaMfdMQxdhWohnx1mxhgrXwn7kr7IfHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736201982; c=relaxed/simple;
	bh=MXVIc9pJCjgrpXq7eInzO3fOTzI4JtvYkRF8Wq7E35w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jkfisMQ+1ni5FW78keU07LuQMCt/XgN6pQxWinGCsEdOXVLKhmAYg3sczfMkd+loiYAQ+nGpk0hDvtBgq+Ti67MkrZS2OHkJCKdzCInoWZ3LO/ycmNgur2tshcqsGiNOsqrsi57GAiKZbck4i5a4o0C1DGIWxtb69olV1vMvvMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zd7zZy9p; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736201981; x=1767737981;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MXVIc9pJCjgrpXq7eInzO3fOTzI4JtvYkRF8Wq7E35w=;
  b=Zd7zZy9pjUZbf2OUL4SKqQx1EB2k1BtG8JrmnMY1TgzHxrjKII2RS+W9
   u39M2QgBqvsnzVPCjgkLtdhPHEkr72zlacPC5fE83sHp+5TPuKtTHrvYJ
   Z+480wkGv57V03FlUfvwhg0CJ9IRh1sR2M1Jb42HIYZH3G5RVQeQCC7lQ
   EtBiUZFIEllQa0Cv0aepgUjmbVRWvH1Ue3AToWBIiMvzTKfV1v66cxqr4
   0bvpQ2wUBBqEg5gskJvxO8TuuIb+I1RdzOoVv93BlWerdc/DUq2m5daAU
   SEzuH+uPJVd7FgBwgg8ksGLiwYzjHGTYNbceeOZ+w3DEOjG3ZJ5qh38XT
   w==;
X-CSE-ConnectionGUID: aPOH8+lIQBWJFQnhFlBMXA==
X-CSE-MsgGUID: UM3Fap7FRomeu+6mgk9HyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11307"; a="46858710"
X-IronPort-AV: E=Sophos;i="6.12,293,1728975600"; 
   d="scan'208";a="46858710"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2025 14:19:39 -0800
X-CSE-ConnectionGUID: UmcbyHjNQui3wU2D9SF2tA==
X-CSE-MsgGUID: 8EVfPR5aQCGxrVCsH9ezvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,293,1728975600"; 
   d="scan'208";a="102368469"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa006.fm.intel.com with ESMTP; 06 Jan 2025 14:19:38 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Song Yoong Siang <yoong.siang.song@intel.com>,
	anthony.l.nguyen@intel.com,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	vitaly.lifshits@intel.com,
	dima.ruinskiy@intel.com,
	vinicius.gomes@intel.com,
	przemyslaw.kitszel@intel.com,
	Avigail Dahan <avigailx.dahan@intel.com>
Subject: [PATCH net-next 07/15] igc: Allow hot-swapping XDP program
Date: Mon,  6 Jan 2025 14:19:15 -0800
Message-ID: <20250106221929.956999-8-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106221929.956999-1-anthony.l.nguyen@intel.com>
References: <20250106221929.956999-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Song Yoong Siang <yoong.siang.song@intel.com>

Currently, the driver would always close and reopen the network interface
when setting/removing the XDP program, regardless of the presence of XDP
resources. This could cause unnecessary disruptions.

To avoid this, introduces a check to determine if there is a need to
close and reopen the interface, allowing for seamless hot-swapping of
XDP programs.

Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Tested-by: Avigail Dahan <avigailx.dahan@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_xdp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_xdp.c b/drivers/net/ethernet/intel/igc/igc_xdp.c
index e27af72aada8..869815f48ac1 100644
--- a/drivers/net/ethernet/intel/igc/igc_xdp.c
+++ b/drivers/net/ethernet/intel/igc/igc_xdp.c
@@ -13,6 +13,7 @@ int igc_xdp_set_prog(struct igc_adapter *adapter, struct bpf_prog *prog,
 	struct net_device *dev = adapter->netdev;
 	bool if_running = netif_running(dev);
 	struct bpf_prog *old_prog;
+	bool need_update;
 
 	if (dev->mtu > ETH_DATA_LEN) {
 		/* For now, the driver doesn't support XDP functionality with
@@ -22,7 +23,8 @@ int igc_xdp_set_prog(struct igc_adapter *adapter, struct bpf_prog *prog,
 		return -EOPNOTSUPP;
 	}
 
-	if (if_running)
+	need_update = !!adapter->xdp_prog != !!prog;
+	if (if_running && need_update)
 		igc_close(dev);
 
 	old_prog = xchg(&adapter->xdp_prog, prog);
@@ -34,7 +36,7 @@ int igc_xdp_set_prog(struct igc_adapter *adapter, struct bpf_prog *prog,
 	else
 		xdp_features_clear_redirect_target(dev);
 
-	if (if_running)
+	if (if_running && need_update)
 		igc_open(dev);
 
 	return 0;
-- 
2.47.1


