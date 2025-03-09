Return-Path: <bpf+bounces-53672-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3CEEA5836D
	for <lists+bpf@lfdr.de>; Sun,  9 Mar 2025 11:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1E5B16DBC2
	for <lists+bpf@lfdr.de>; Sun,  9 Mar 2025 10:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944991CAA7A;
	Sun,  9 Mar 2025 10:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U850VBpe"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A6F1C5D78;
	Sun,  9 Mar 2025 10:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741517303; cv=none; b=LTocT7PJPd3rjTdsJxMI433HfE2FVlmXBuJHYiS/3/wK6ua3tnFp2/cMMdSixJOezUBRJYttj+at02t5xq94Ec+NRwTq2wmcmHTOAanFZEj903q/ZlJ/Hadep+u994AunNjxzHDF060bXdCn0gl35ueYDWv1G3LmRPrHvsgTvcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741517303; c=relaxed/simple;
	bh=Ij2fIraKDwf5/gzdQZNpLgFH8xiF4vMpUeJsnouOpmo=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zi+8LZEv5cOUN5vcd5HAC3ZV5rMBJpOJgMPTL3xYS3Iquvvs4WqvypA+krnvNLGMTf8drzqR2kBOnZHuSPMvPZTlib2EkIaAUpmhY/EEaaq6CkCre0HNLSJnNMPLX+f7c1bpH8QDWMYm6cy47+GO6qg1rdvtTk4qIvSvsyNk20A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U850VBpe; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741517302; x=1773053302;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=Ij2fIraKDwf5/gzdQZNpLgFH8xiF4vMpUeJsnouOpmo=;
  b=U850VBpe1CVimmQCwE+KJOA8gMZrEQXnZBH+cQsAVYdfIBmsVgQnTZTZ
   3bQ0fifKy5HSQRAiMt7CPWKU/GZtKzxlNi93G2DYwF5su3GtUqLHv5Cow
   1PMohzwhyEoa99/KRIkwfIfaK3aOyqbc6cHMjupyiGhaVqTCeCzdKMl9K
   i9wzD64z+cqmvse7Lt0KXnqpFJghnay/sRk/kKlbU2TmOsNc+qa0wgUoR
   ml1ey+7Xm7JOKxOXKtwprSmrcvpwOubCa+xoIYy7F52QUZWBn10UG4O0F
   5Ddt66RPhwu3Orp7u5dSOXl49/2nx2OQL1w6ooYH/HNOsJrbrW11Kk7K4
   Q==;
X-CSE-ConnectionGUID: Tg4HZ5BkQv6xRH4gmqqpBA==
X-CSE-MsgGUID: 6LjIvoBOQgCj8dAGy2XpGw==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="42636109"
X-IronPort-AV: E=Sophos;i="6.14,234,1736841600"; 
   d="scan'208";a="42636109"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2025 03:48:21 -0700
X-CSE-ConnectionGUID: qUiAYvO5T/msA+rP2OOg+w==
X-CSE-MsgGUID: p13HVF5gQh6tQD9QU4MA+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,234,1736841600"; 
   d="scan'208";a="124655099"
Received: from mohdfai2-ilbpg12-1.png.intel.com ([10.88.227.73])
  by orviesa003.jf.intel.com with ESMTP; 09 Mar 2025 03:48:13 -0700
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
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Chwee-Lin Choong <chwee.lin.choong@intel.com>,
	Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	bpf@vger.kernel.org
Subject: [PATCH iwl-next v9 07/14] igc: optimize TX packet buffer utilization for TSN mode
Date: Sun,  9 Mar 2025 06:46:41 -0400
Message-Id: <20250309104648.3895551-8-faizal.abdul.rahim@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250309104648.3895551-1-faizal.abdul.rahim@linux.intel.com>
References: <20250309104648.3895551-1-faizal.abdul.rahim@linux.intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for upcoming frame preemption patches, optimize the TX
packet buffer size. The total packet buffer size (RX + TX) is 64KB, with
a maximum of 34KB for either RX or TX. Split the buffer evenly,
allocating 32KB to each.

For TX, assign 7KB to each of the four TX packet buffers (total 28KB)
and reserve 4KB for BMC.

References:
I225/I226 SW User Manual Section 4.7.9, Section 8.3.2

Co-developed-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
---
 drivers/net/ethernet/intel/igc/igc_defines.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
index b180e1497cc5..db937931c646 100644
--- a/drivers/net/ethernet/intel/igc/igc_defines.h
+++ b/drivers/net/ethernet/intel/igc/igc_defines.h
@@ -419,8 +419,8 @@
 	IGC_TXPB0SIZE(20) | IGC_TXPB1SIZE(0) | IGC_TXPB2SIZE(0) | \
 	IGC_TXPB3SIZE(0) | IGC_OS2BMCPBSIZE(4))
 #define IGC_TXPBSIZE_TSN ( \
-	IGC_TXPB0SIZE(5) | IGC_TXPB1SIZE(5) | IGC_TXPB2SIZE(5) | \
-	IGC_TXPB3SIZE(5) | IGC_OS2BMCPBSIZE(4))
+	IGC_TXPB0SIZE(7) | IGC_TXPB1SIZE(7) | IGC_TXPB2SIZE(7) | \
+	IGC_TXPB3SIZE(7) | IGC_OS2BMCPBSIZE(4))
 
 #define IGC_DTXMXPKTSZ_TSN	0x19 /* 1600 bytes of max TX DMA packet size */
 #define IGC_DTXMXPKTSZ_DEFAULT	0x98 /* 9728-byte Jumbo frames */
-- 
2.34.1


