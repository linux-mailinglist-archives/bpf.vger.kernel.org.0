Return-Path: <bpf+bounces-50501-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89424A28774
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 11:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2524816A0F4
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 10:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B815022CBC6;
	Wed,  5 Feb 2025 10:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PdzDGmu2"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D105222ACF7;
	Wed,  5 Feb 2025 10:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738749961; cv=none; b=WF4qgZicYos7iyfsmAVURsEwIcpMWHZn5oiIMeSgSGZU6pHTYjNtz9urikebsy3+Uv9ZesCBcTz9wQldZflIC21FnIYJychPrsbGxxIvvlXFIWbNXD+kn4DAioIV36npXHLXKJ7UQL5jnYjq6m/igvAN5RAQuuDui9yGg9cg1rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738749961; c=relaxed/simple;
	bh=0OdUdx+lahN2+LUJ2jOFDFj83SCLzyn+8zKWv0oeisM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cbNnnnQRyIpLjD2MsZ58UUI46PVz2gTsg3g2Oe3uFZn0slN8lUelWg1h49s667IGoOht1tYvTjsYokXN1+SiG9lsb6yfmteeVLWsCL5XKls3nM39SMMP60j+Ootxwuvj+F0ZGkeu4z4OWHHpjBSpKiBgxeWn2N1xCB4PQaPEKSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PdzDGmu2; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738749959; x=1770285959;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=0OdUdx+lahN2+LUJ2jOFDFj83SCLzyn+8zKWv0oeisM=;
  b=PdzDGmu2Gdg2ISe+844STd0FKAxPRuJ6NE03n2XE8N0cT1M/baOBRrMQ
   kZNuqBWDLgMZMQfOlnQJn0qPjCZmbgPw2SuxoQo477LZD9k8BsT4idKlE
   vCZQ+9VOUW28pMyIE83JBlvURJZAugv+x/2dsmafPtJUbH4QYonwdEm4q
   5bpGlt3Z3B3VEmtMo3AUpLLvAIydrMLVEVNIJHP042uPYYStAIJ4n4WZw
   p/nQPChmWXQ51I6hPSu9YbJv7rl8D2V0KC6/XAyG4gSRLr7N/6RKjxjQi
   n7B0m/Iv7gtO63yMMAh5l/Q1q7v0nCGbFbDJERI0KfnD79PVHsJlOIe6v
   Q==;
X-CSE-ConnectionGUID: joDccVFPT7yFWVfHGTEFAQ==
X-CSE-MsgGUID: cgUYhPUVR9SO4AIJnLkoxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39204699"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="39204699"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 02:05:59 -0800
X-CSE-ConnectionGUID: w4+X2uWMRSiBqd4c+mmb3g==
X-CSE-MsgGUID: kprGnA/oS7Cxwm+v3SIPjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="111297712"
Received: from mohdfai2-ilbpg12-1.png.intel.com ([10.88.227.73])
  by orviesa007.jf.intel.com with ESMTP; 05 Feb 2025 02:05:51 -0800
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
	Russell King <rmk+kernel@armlinux.org.uk>,
	Furong Xu <0x1207@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Xiaolei Wang <xiaolei.wang@windriver.com>,
	Suraj Jaiswal <quic_jsuraj@quicinc.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Petr Tesarik <petr@tesarici.cz>,
	Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	bpf@vger.kernel.org
Subject: [PATCH iwl-next v2 3/9] igc: Optimize the TX packet buffer utilization
Date: Wed,  5 Feb 2025 05:05:18 -0500
Message-Id: <20250205100524.1138523-4-faizal.abdul.rahim@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250205100524.1138523-1-faizal.abdul.rahim@linux.intel.com>
References: <20250205100524.1138523-1-faizal.abdul.rahim@linux.intel.com>
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


