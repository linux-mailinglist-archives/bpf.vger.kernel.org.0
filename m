Return-Path: <bpf+bounces-47016-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FBD79F2A5B
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 07:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CA6E1886B9B
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 06:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F7A1D279C;
	Mon, 16 Dec 2024 06:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NUTbA5BC"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B111D0E26;
	Mon, 16 Dec 2024 06:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734331734; cv=none; b=UvlrfTgvAUnZ7B9VIIBKOht5fGMuM+eJRJbUychNsblY5jzoyTVNXAQr+xZps3IYP3NMGuhwv7zv+XVeToE68NWAmtmI9CjHT3dUT6W4Zo7hum/xGF/F/1Nw8Jql6nuR+SGQZmrXuzcXL1RSyzwoaUrJI4n6S+gMtu2x77D1ISg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734331734; c=relaxed/simple;
	bh=lp2ZOST2PsJMRL/3aLQoOskt3ewvhhs0cnvkLwFO9gY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wf4Nq+/ZRHmif2dzMlNpBxW4Gck/wSIgI0Ncpapgo7fjl+1TWKt5viRRHmeclpp81SeKsBC/wFgeiGbAWP+Yg6ou2L/Cc35SaWQURZWjtiZHGHdz9gi6Q+D5yUmCvK5pLjzyOPzR6os3Tz7TGFZPSFplglQkkKJieZgThXKyYzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NUTbA5BC; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734331733; x=1765867733;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lp2ZOST2PsJMRL/3aLQoOskt3ewvhhs0cnvkLwFO9gY=;
  b=NUTbA5BCJIzFgq5LX2MKtkAfOWTHkKNgEIUYZWFjLu+o1Wh0MxtokmAJ
   XVLSRqBix9Q7QtLleqNDdvGjyrJqrMUawAY4a3Kf23OOqgS7X/x3JngQU
   zzRH41kMRcntfYsWVc2HS9WlkPWaZk0xZ6izHQyQIe3TCimvldx/BAAqq
   6aQ0+Brp+pJGB6qdRdfjhrbuxx0t9guSjMKOFz/lXDSf5GVHGswQ2WAUy
   Q3N05al/4l4CCR+SAhuTK0DjHIbfXe5vjwFWui+FyM+o2c2kMp4FsCRpe
   sCWQqnTUz9PUdzW4y2UV00+uKX02Mjp+GULje7OVH2m/lHWoIWNBzIbvN
   g==;
X-CSE-ConnectionGUID: s5u/9W+HQ3OL/Hgt5678vg==
X-CSE-MsgGUID: wAaC/hCLSLKXiV+7YoQvsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11287"; a="34848197"
X-IronPort-AV: E=Sophos;i="6.12,237,1728975600"; 
   d="scan'208";a="34848197"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2024 22:48:52 -0800
X-CSE-ConnectionGUID: Qo3+iPYiQk+lYjS+equ3Ng==
X-CSE-MsgGUID: mRUZg2REQ/qZPZ0u3CJ5jQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="128101855"
Received: from mohdfai2-ilbpg12-1.png.intel.com ([10.88.227.73])
  by fmviesa001.fm.intel.com with ESMTP; 15 Dec 2024 22:48:48 -0800
From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH iwl-next 2/9] igc: Optimize the TX packet buffer utilization
Date: Mon, 16 Dec 2024 01:47:13 -0500
Message-Id: <20241216064720.931522-3-faizal.abdul.rahim@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241216064720.931522-1-faizal.abdul.rahim@linux.intel.com>
References: <20241216064720.931522-1-faizal.abdul.rahim@linux.intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vinicius Costa Gomes <vinicius.gomes@intel.com>

Packet buffers (RX + TX) total 64KB. Neither RX or TX buffers can be
larger than 34KB. So divide the buffer equally, 32KB for each.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
---
 drivers/net/ethernet/intel/igc/igc_defines.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
index 8e449904aa7d..1f63a523faf2 100644
--- a/drivers/net/ethernet/intel/igc/igc_defines.h
+++ b/drivers/net/ethernet/intel/igc/igc_defines.h
@@ -400,7 +400,7 @@
 #define I225_TXPBSIZE_DEFAULT	0x04000014 /* TXPBSIZE default */
 #define IGC_RXPBS_CFG_TS_EN	0x80000000 /* Timestamp in Rx buffer */
 
-#define IGC_TXPBSIZE_TSN	0x04145145 /* 5k bytes buffer for each queue */
+#define IGC_TXPBSIZE_TSN	0x041c71c7 /* 7k bytes buffer for each queue + 4KB for BMC*/
 
 #define IGC_DTXMXPKTSZ_TSN	0x19 /* 1600 bytes of max TX DMA packet size */
 #define IGC_DTXMXPKTSZ_DEFAULT	0x98 /* 9728-byte Jumbo frames */
-- 
2.25.1


