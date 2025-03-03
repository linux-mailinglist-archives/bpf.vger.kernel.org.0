Return-Path: <bpf+bounces-53218-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB42A4E9FD
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 18:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD26D8A1434
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 17:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231B12803E0;
	Tue,  4 Mar 2025 17:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Atf7+ptv"
X-Original-To: bpf@vger.kernel.org
Received: from beeline1.cc.itu.edu.tr (beeline1.cc.itu.edu.tr [160.75.25.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8331F2380
	for <bpf@vger.kernel.org>; Tue,  4 Mar 2025 17:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741109049; cv=fail; b=uqVF59ccX/wR4tutwdBBr9Rpn+W0cfvzbqnId/EjRMf+hKYlXR0hcv/iJ3Gk1kVLz3ZbWyvNy2rk6D3S+dmzoSPxoP1H9s5efCo7nGTJzhbJfoZQMzzVYww9qD+WBxbVscbzHZFpETVRN66TXLq1WnYB3OnmmFeWxDzVNlmUTkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741109049; c=relaxed/simple;
	bh=wgwvUzcv9WZS9kUxNOhraSZ9ZOWP+CJ0pKU7K/uc37g=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r2aASy/zHooUoaZDIeDOYD7WkGVxoNQq91eNT9O1sjCV7OhEfodzhqiKkJybm/eS4CLrDZO7R27EoLDvP+rUaiYdE0bq6JPaxjlP7CuAVsWytFIY9oIDd4YyG0oW9gBdk9oX+RX4VVsKfuXXt5Py+F15W734ZXrPg8psimRjvbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=fail (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Atf7+ptv reason="signature verification failed"; arc=none smtp.client-ip=198.175.65.9; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; arc=fail smtp.client-ip=160.75.25.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline1.cc.itu.edu.tr (Postfix) with ESMTPS id 117DA408B642
	for <bpf@vger.kernel.org>; Tue,  4 Mar 2025 20:24:05 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6dMt2F8HzFwlD
	for <bpf@vger.kernel.org>; Tue,  4 Mar 2025 17:28:42 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 7188C42731; Tue,  4 Mar 2025 17:28:33 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Atf7+ptv
X-Envelope-From: <linux-kernel+bounces-541370-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Atf7+ptv
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 15AF1434E4
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:30:17 +0300 (+03)
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by fgw1.itu.edu.tr (Postfix) with SMTP id A74C43064C0E
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:30:16 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C59E3B4022
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 10:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43CF1F417D;
	Mon,  3 Mar 2025 10:28:05 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559DA1F1531;
	Mon,  3 Mar 2025 10:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740997682; cv=none; b=J3EFh39Ksro3i2hphp1EYlPeWxb7FHZpEJ2pjMHpWy7Z9xvVRxWZcqsVISgIETaYwQKPfi6KqA7SZwmgvV5uX9pm5l8U81NsFcwkx6dAQ+UBhatcaBbrBHVTNAWH3/kIYYNeSVLKSCysgGaRrxCXLcZLSlUa8SzqnkJgZHg/4Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740997682; c=relaxed/simple;
	bh=2Msp7YoBmanu425m0MXmljH1/c1Or8M2lkzZSA8x+50=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gwFL7HifRZ31pXnXgm3LCxleNcgXmlY0m7lLUK3xNokOZlMQFHRE4I2/gu6XED9xVqdzR76sBe35GuNpHgNn+t1Dkfb5KsPla5FkUZQuVmvVSrby6pfF9FDFQ5m9RLnuyekrTVFlpfAjseFJ6otX8BKn6p3nfcdeeubcOeXGxYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Atf7+ptv; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740997681; x=1772533681;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=2Msp7YoBmanu425m0MXmljH1/c1Or8M2lkzZSA8x+50=;
  b=Atf7+ptv8dTGijcC4Y2ByFOWVgMvl16sgYfwDZeuSpxjsGwPTAfVwEOL
   hAsv9w8r6qXw+A99LJQbL8U3aJx5MWhGuH+wFP+m6RicTowSZ+BuzPPBJ
   FHfGLgfGAsCQ2TRrEeB3O+VoAZ0M8WOdoJvT1onD3gHGydHx4s0T0LRp/
   JPNolp4zpFUpbV1sVF5VnH/hoxTKJmD688FapwgWfbmwP9TgFnUDYOTyo
   o825lFYxO5q/7BdELdeQFWSygIJeQOJc96AMXdyqkf/WmXh+gJOeF1aaN
   TQJR0InVlpsg/Dn+KfSuxwoOoPn5QvTQnkhJnyPnXh2AmZ8Pv4tVzI84q
   A==;
X-CSE-ConnectionGUID: USuXoOE4SMm7+bg5rJ8cnw==
X-CSE-MsgGUID: HzMTCOLxTdOGRmFPo6mRMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11361"; a="64310149"
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="64310149"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 02:28:00 -0800
X-CSE-ConnectionGUID: t9zZnSvsR46o8m5nS2uR3g==
X-CSE-MsgGUID: DkMFzS4QTBm8OGTiacD7eQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="122569880"
Received: from mohdfai2-ilbpg12-1.png.intel.com ([10.88.227.73])
  by fmviesa005.fm.intel.com with ESMTP; 03 Mar 2025 02:27:53 -0800
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
Subject: [PATCH iwl-next v7 4/9] igc: Set the RX packet buffer size for TSN mode
Date: Mon,  3 Mar 2025 05:26:53 -0500
Message-Id: <20250303102658.3580232-5-faizal.abdul.rahim@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250303102658.3580232-1-faizal.abdul.rahim@linux.intel.com>
References: <20250303102658.3580232-1-faizal.abdul.rahim@linux.intel.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6dMt2F8HzFwlD
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741713755.68967@QqU3pCdgwT5w2bRW2Bp6UA
X-ITU-MailScanner-SpamCheck: not spam

In preparation for supporting frame preemption, when entering TSN mode
set the receive packet buffer to 16KB for the Express MAC, 16KB for
the Preemptible MAC and 2KB for the BMC, according to the datasheet
section 7.1.3.2.

Co-developed-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
---
 drivers/net/ethernet/intel/igc/igc_defines.h |  3 +++
 drivers/net/ethernet/intel/igc/igc_tsn.c     | 13 +++++++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/e=
thernet/intel/igc/igc_defines.h
index 516ef70c98e9..b19ac6f30dac 100644
--- a/drivers/net/ethernet/intel/igc/igc_defines.h
+++ b/drivers/net/ethernet/intel/igc/igc_defines.h
@@ -402,6 +402,9 @@
=20
  /* 7KB bytes buffer for each tx queue (total 4 queues) + 4KB for BMC*/
 #define IGC_TXPBSIZE_TSN	0x041c71c7
+/* 15KB for EXP + 15KB for BE + 2KB for BMC */
+#define IGC_RXPBSIZE_TSN	0x0000f08f
+#define IGC_RXPBSIZE_SIZE_MASK	0x0001FFFF
=20
 #define IGC_DTXMXPKTSZ_TSN	0x19 /* 1600 bytes of max TX DMA packet size =
*/
 #define IGC_DTXMXPKTSZ_DEFAULT	0x98 /* 9728-byte Jumbo frames */
diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ether=
net/intel/igc/igc_tsn.c
index 1e44374ca1ff..f0213cfce07d 100644
--- a/drivers/net/ethernet/intel/igc/igc_tsn.c
+++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
@@ -132,13 +132,17 @@ static int igc_tsn_disable_offload(struct igc_adapt=
er *adapter)
 {
 	u16 queue_per_tc[4] =3D { 3, 2, 1, 0 };
 	struct igc_hw *hw =3D &adapter->hw;
-	u32 tqavctrl;
+	u32 tqavctrl, rxpbs;
 	int i;
=20
 	wr32(IGC_GTXOFFSET, 0);
 	wr32(IGC_TXPBS, I225_TXPBSIZE_DEFAULT);
 	wr32(IGC_DTXMXPKTSZ, IGC_DTXMXPKTSZ_DEFAULT);
=20
+	rxpbs =3D rd32(IGC_RXPBS) & ~IGC_RXPBSIZE_SIZE_MASK;
+	rxpbs |=3D I225_RXPBSIZE_DEFAULT;
+	wr32(IGC_RXPBS, rxpbs);
+
 	if (igc_is_device_id_i226(hw))
 		igc_tsn_restore_retx_default(adapter);
=20
@@ -194,7 +198,7 @@ static int igc_tsn_enable_offload(struct igc_adapter =
*adapter)
 {
 	struct igc_hw *hw =3D &adapter->hw;
 	u32 tqavctrl, baset_l, baset_h;
-	u32 sec, nsec, cycle;
+	u32 sec, nsec, cycle, rxpbs;
 	ktime_t base_time, systim;
 	int i;
=20
@@ -202,6 +206,11 @@ static int igc_tsn_enable_offload(struct igc_adapter=
 *adapter)
 	wr32(IGC_DTXMXPKTSZ, IGC_DTXMXPKTSZ_TSN);
 	wr32(IGC_TXPBS, IGC_TXPBSIZE_TSN);
=20
+	rxpbs =3D rd32(IGC_RXPBS) & ~IGC_RXPBSIZE_SIZE_MASK;
+	rxpbs |=3D IGC_RXPBSIZE_TSN;
+
+	wr32(IGC_RXPBS, rxpbs);
+
 	if (igc_is_device_id_i226(hw))
 		igc_tsn_set_retx_qbvfullthreshold(adapter);
=20
--=20
2.34.1



