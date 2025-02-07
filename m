Return-Path: <bpf+bounces-50786-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A046A2C981
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 17:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15F147A3DE4
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 16:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B656919AD8C;
	Fri,  7 Feb 2025 16:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UEDn7Tvi"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45C7191F98;
	Fri,  7 Feb 2025 16:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738947449; cv=none; b=QJCCpSvxKE4Az21OpZQuXbm9sO1Ysz/ylQxYqzhkMuVbLtG5CDN+fktNWAA7mUT30b52uo7Y47V6Kd3BYTF/jawVSwGZdGylcYK17h7EJOEz9nwHkNjsnwasunWyvzaIUMzOwQa7Mgg3t8WogB/RU/TIppzc9zuZUYe6/E9RgwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738947449; c=relaxed/simple;
	bh=0OdUdx+lahN2+LUJ2jOFDFj83SCLzyn+8zKWv0oeisM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JcApgmtyLKNzSYIGs87haWof2xTP1GqUK2T+SiQc/vVdYMGWCoydZkjdZR9x+/+SQu1aO5W2aC7ptA+0Qn5LjmP+NTKa3XP/svqCB9gL93NXQxFWFmd3lJZYnZpuNuF7jHOaY3kSZnibPxg/Xoe5q27DCoRcfQPyp4LZDtWH8Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UEDn7Tvi; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738947448; x=1770483448;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=0OdUdx+lahN2+LUJ2jOFDFj83SCLzyn+8zKWv0oeisM=;
  b=UEDn7Tvif7BVU3NXJAn4lfnrDS73EOgFbMvQwlmV7/oe69gqBjwDcCPA
   ZNSN8lhdYZTidswa2vNbbucHkEfKB5FP5JoTNaleMZpq0BTqAGv1HU6qI
   KZxhAvRNOzp54dii+ysbdIVOu3IpMjXQbVanxpY1RjCGGZMTlUAZdpFlE
   28AACvB3k5JnU0fh4nBA5Z4m7nMHtRYk/ao9wjmiaJ+F+QNvE1tcDjmzc
   tfDFdhSZZTU1/oefE/cOiT0uXboSnBeG+9ZbGr1TenQDBUjsftaOipoGi
   rJKxBmdzws5AKZW8up1qgBYFsndV7G8i+3AXp8zosBsGuUfywLNuVExrE
   Q==;
X-CSE-ConnectionGUID: CLl3RvV0R9yf6eLR12d0Hw==
X-CSE-MsgGUID: O++QnD5SQVqAdUTtW5o6Yw==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="39722916"
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; 
   d="scan'208";a="39722916"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 08:57:27 -0800
X-CSE-ConnectionGUID: A6FhkeyxRMqPRpN3MXExzg==
X-CSE-MsgGUID: j9JtHEfBTN+2pNOtEYixKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; 
   d="scan'208";a="111534539"
Received: from mohdfai2-ilbpg12-1.png.intel.com ([10.88.227.73])
  by orviesa006.jf.intel.com with ESMTP; 07 Feb 2025 08:57:19 -0800
From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Furong Xu <0x1207@gmail.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Xiaolei Wang <xiaolei.wang@windriver.com>,
	Suraj Jaiswal <quic_jsuraj@quicinc.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Gal Pressman <gal@nvidia.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	bpf@vger.kernel.org
Subject: [PATCH iwl-next v3 3/9] igc: Optimize the TX packet buffer utilization
Date: Fri,  7 Feb 2025 11:56:43 -0500
Message-Id: <20250207165649.2245320-4-faizal.abdul.rahim@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250207165649.2245320-1-faizal.abdul.rahim@linux.intel.com>
References: <20250207165649.2245320-1-faizal.abdul.rahim@linux.intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Packet buffers (RX + TX) total 64KB. Neither RX or TX buffers can be
larger than 34KB. So divide the buffer equally, 32KB for each.

Co-developed-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
---
 drivers/net/ethernet/intel/igc/igc_defines.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
index 8e449904aa7d..516ef70c98e9 100644
--- a/drivers/net/ethernet/intel/igc/igc_defines.h
+++ b/drivers/net/ethernet/intel/igc/igc_defines.h
@@ -400,7 +400,8 @@
 #define I225_TXPBSIZE_DEFAULT	0x04000014 /* TXPBSIZE default */
 #define IGC_RXPBS_CFG_TS_EN	0x80000000 /* Timestamp in Rx buffer */
 
-#define IGC_TXPBSIZE_TSN	0x04145145 /* 5k bytes buffer for each queue */
+ /* 7KB bytes buffer for each tx queue (total 4 queues) + 4KB for BMC*/
+#define IGC_TXPBSIZE_TSN	0x041c71c7
 
 #define IGC_DTXMXPKTSZ_TSN	0x19 /* 1600 bytes of max TX DMA packet size */
 #define IGC_DTXMXPKTSZ_DEFAULT	0x98 /* 9728-byte Jumbo frames */
-- 
2.34.1


