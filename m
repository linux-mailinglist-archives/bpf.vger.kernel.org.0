Return-Path: <bpf+bounces-45071-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E649D085F
	for <lists+bpf@lfdr.de>; Mon, 18 Nov 2024 05:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17511280571
	for <lists+bpf@lfdr.de>; Mon, 18 Nov 2024 04:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871D513A87E;
	Mon, 18 Nov 2024 04:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ab8C/0a+"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E753525760;
	Mon, 18 Nov 2024 04:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731903374; cv=none; b=uCrRESrwtGnPLblo8Io3UqZS5E3b/x8Mf28jApqALxmsAyaNezjJZ0nxHHdPyRrUmv5uxwjpISuVAQwZ4HXOznR//tA5+4lhJeZvUYxN3sNxbD6wBvLDz/IPcLFHyWo3lXMYgtzZOghIQhZTfak6y7L0PLdYWK9GgGb/7fiPv6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731903374; c=relaxed/simple;
	bh=+kTbOpdo0OuywXlLwtJIwaTwO0qz6pqXuSdPodIB3bU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BUUnFwAr+xeFMv7bm1BwjH8JX8HJfpjXxADH0rz+Iiwd+2Vpx6+BO6d2mdVo0Gw6oq51ROp+k1j18+YJlfa9hEVl+bFi9QtHHsqVJfDz8TlXgrDRPx/AWBgENH5JvVK70zWb1YGE9IdR4VIPAdNsR8gB45C41SX9zpPvKCTGUZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ab8C/0a+; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731903372; x=1763439372;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+kTbOpdo0OuywXlLwtJIwaTwO0qz6pqXuSdPodIB3bU=;
  b=Ab8C/0a+q9FyzkPFeDeIsrriJdaV7uY0F6pN8XNzo/l5SIiwZcxOj0cm
   K7vpx7kkhoaRpMYaYOLZ9lQHkTaTo75giz9xVjhfrvkkdJrsIkVJKX9H2
   moSTSsntAj2LY7cY1URKlIUCYdYv3uw10fypvOEiOeYgwtUZyLkIa10z0
   dL/Gycmz03cyfAb+kjh9tXiuDl8u1kxfYt0XuzRNP/dfIWZKWtqh/8DI9
   IPRv8eY0MXmLAma6SeyDINW6x3HVAmzZESRSYkbfM3mQaKEAIxl3ueJaT
   n3HXYyBfzgXevDvaCzXZ4R95ycqRvo/v2PmaoaJcg9XpAf9NKM9mGb9sQ
   g==;
X-CSE-ConnectionGUID: Hhirg3EURImxJie8TDhiLg==
X-CSE-MsgGUID: CuwfljY9RXKaYEXla1VttA==
X-IronPort-AV: E=McAfee;i="6700,10204,11259"; a="34699879"
X-IronPort-AV: E=Sophos;i="6.12,163,1728975600"; 
   d="scan'208";a="34699879"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2024 20:16:11 -0800
X-CSE-ConnectionGUID: C+3iAYv2SFyg/X7ST70BDA==
X-CSE-MsgGUID: c4UaTHy9SEGeVVTPYjp+tQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,163,1728975600"; 
   d="scan'208";a="94037833"
Received: from p12ill20yoongsia.png.intel.com ([10.88.227.28])
  by orviesa005.jf.intel.com with ESMTP; 17 Nov 2024 20:16:08 -0800
From: Song Yoong Siang <yoong.siang.song@intel.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH iwl-next 1/1] igc: Allow hot-swapping XDP program
Date: Mon, 18 Nov 2024 12:15:45 +0800
Message-Id: <20241118041545.1845287-1-yoong.siang.song@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the driver would always close and reopen the network interface
when setting/removing the XDP program, regardless of the presence of XDP
resources. This could cause unnecessary disruptions.

To avoid this, introduces a check to determine if there is a need to
close and reopen the interface, allowing for seamless hot-swapping of
XDP programs.

Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
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
2.34.1


