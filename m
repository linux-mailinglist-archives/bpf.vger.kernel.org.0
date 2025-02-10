Return-Path: <bpf+bounces-50920-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3EDA2E50A
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 08:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA563188BF91
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 07:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37FD1BCA0E;
	Mon, 10 Feb 2025 07:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k8Y5We8v"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E861B4153;
	Mon, 10 Feb 2025 07:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739170968; cv=none; b=bRIvXYTjTUta/o1v6JDIFCbLMXXPR3DFfRSU1tEYSwEsn4aaMERu1uxIV+6vBHbpSA4qT879OaoL0NIFQDjjdyurpcRJIRjWCvlk0zGWagnoxaEzjO2dLQ3Zn2wqulCeNbEK/SvRJboLxw1GfdGg/ObJWTjhESdQaWr+SKW2kSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739170968; c=relaxed/simple;
	bh=0OdUdx+lahN2+LUJ2jOFDFj83SCLzyn+8zKWv0oeisM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GwJhhy57jDMylPh2j4L7kEDkcVllR/LebcpDCOFHpzgxVN8t4wDHHty+Rasf9bjxOswjsxWE9daXlBp4RlbantK0CNimJHTZgvvekn9t1ZJ2rsivlS5Q4mhqF2YUUT9FvslXJTytcRdb/fNM8t/nUzpiQ2WHCrcSwHEVvWxZnJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k8Y5We8v; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739170967; x=1770706967;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=0OdUdx+lahN2+LUJ2jOFDFj83SCLzyn+8zKWv0oeisM=;
  b=k8Y5We8vrYpAmUK8TLBnaQArLyMxjoUVAtrKF/8vK8LsITSOG1iNcL1i
   ec93ZbjEwwphQ1MDE0j0IyafEdjcjMLOnIAfdc1VFI5c3ql5D9rFrACok
   p1f3Gf1EZ0IdqlmF+72qgvpb2B3RNh/MKOW9L9KTRpcmLWqkYhsxyyKhQ
   1qg+ejs1kiNlN65pnVulw4MaqVKCxl2iLUgIN9zkZjOOD8MLE8w/fkkwr
   NkQHMlmUVhRSpzuUZTngHombnTgDWKpCPEI5LhH7m7Jk3GFOlg6wvSXQd
   WvKCHnpExEhypGsGT+GW75y2tDKsdtRXfPdIUA0O3w1QkazH3Qem/q5Z1
   w==;
X-CSE-ConnectionGUID: m45i1en8SL2bGS7ZxT0zYA==
X-CSE-MsgGUID: j2AaVWFlRBe8nlG94MK8jA==
X-IronPort-AV: E=McAfee;i="6700,10204,11340"; a="38937917"
X-IronPort-AV: E=Sophos;i="6.13,273,1732608000"; 
   d="scan'208";a="38937917"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2025 23:02:45 -0800
X-CSE-ConnectionGUID: wLT55tOHRMKeuc2LVdnz4w==
X-CSE-MsgGUID: Zgli5lz3SPSQKPPmks04Qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,273,1732608000"; 
   d="scan'208";a="112622530"
Received: from mohdfai2-ilbpg12-1.png.intel.com ([10.88.227.73])
  by fmviesa010.fm.intel.com with ESMTP; 09 Feb 2025 23:02:36 -0800
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
Subject: [PATCH iwl-next v4 3/9] igc: Optimize the TX packet buffer utilization
Date: Mon, 10 Feb 2025 02:02:01 -0500
Message-Id: <20250210070207.2615418-4-faizal.abdul.rahim@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250210070207.2615418-1-faizal.abdul.rahim@linux.intel.com>
References: <20250210070207.2615418-1-faizal.abdul.rahim@linux.intel.com>
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


