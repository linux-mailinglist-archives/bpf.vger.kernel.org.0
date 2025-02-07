Return-Path: <bpf+bounces-50785-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C1DA2C97A
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 17:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D4D87A58BF
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 16:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DDE1990CE;
	Fri,  7 Feb 2025 16:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T+NomE73"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAF019580F;
	Fri,  7 Feb 2025 16:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738947441; cv=none; b=giPVPeDfFAHbdMyMCzAaOOEk4aQOVigP2ezqkKPHRajKBGA+Bj+c+KqLvYZfaZ9QO0cXuqW4ClXZYciQfa4qMMJQO8OAuDDPp66E2QW6F3PHtWhhVpfT62VgRdk4J9/UsVM+PdB8uN1UgQ1BJdVmF7UdWeikGirRyc/g6BT64K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738947441; c=relaxed/simple;
	bh=y/vg46vRn1lgg6h2OUWs7r6Zp75W28a+qluOoO9J7Nk=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p97qPM+qhkvlHsRtlP+pXgHrI04fMrVgAUYy3kuPko6XIzpIwAcnNJThT75wCXqXKIhmaBSpu7rNv/NdF9BqlDYnHo53XSmclNZ/QjF8vsPnXsak1aRXUENvQphk31MdvmIkNeYtE2csu8vQPqRKH2wKJYLcQ1rF13452ei7wko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T+NomE73; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738947440; x=1770483440;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=y/vg46vRn1lgg6h2OUWs7r6Zp75W28a+qluOoO9J7Nk=;
  b=T+NomE73gqoZEIjfz5QES4POD2Xe3skZLsEoZGHyDKvkbwOFb1rIjApT
   bDyLDFgQkH86BO96QvON3qE6AaFO/uvkXwdftqAjzTc/MfbrYtCWW0AT5
   3F6jYVbUvPGKw2Qvy0Men49pzG5kMZ67lftkQS3MKQS519aibK/J5IaYt
   rCV07ADA+CjrLdT2O+qDPQLtNEOpEB4XYjIBxZIWbk2hfVXtGeibbgJ1J
   BUv5MCTZmo7vqjqEXi2k0zgNLbQLLdNtPiMeydOaPf9MszlHxXIrptdFt
   VM/qPxbK05UvDlk9iIiThi+676LcBEmuM1RyJf0ZarBEdiav5rQuaBWlv
   g==;
X-CSE-ConnectionGUID: TR/XpFavQmesnik2Lbu8Aw==
X-CSE-MsgGUID: fCEcTu53S/aNQA7lJntfYA==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="39722890"
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; 
   d="scan'208";a="39722890"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 08:57:19 -0800
X-CSE-ConnectionGUID: nj5Q2GtRT6GSjc1Bi9ryGQ==
X-CSE-MsgGUID: KtjaDsIvQ+6+udg9uICb0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; 
   d="scan'208";a="111534512"
Received: from mohdfai2-ilbpg12-1.png.intel.com ([10.88.227.73])
  by orviesa006.jf.intel.com with ESMTP; 07 Feb 2025 08:57:11 -0800
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
Subject: [PATCH iwl-next v3 2/9] igc: Rename xdp_get_tx_ring() for non-xdp usage
Date: Fri,  7 Feb 2025 11:56:42 -0500
Message-Id: <20250207165649.2245320-3-faizal.abdul.rahim@linux.intel.com>
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

Renamed xdp_get_tx_ring() function to a more generic name for use in
upcoming frame preemption patches.

Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
---
 drivers/net/ethernet/intel/igc/igc.h      |  2 +-
 drivers/net/ethernet/intel/igc/igc_main.c | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index b8111ad9a9a8..22ecdac26cf4 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -736,7 +736,7 @@ struct igc_nfc_rule *igc_get_nfc_rule(struct igc_adapter *adapter,
 				      u32 location);
 int igc_add_nfc_rule(struct igc_adapter *adapter, struct igc_nfc_rule *rule);
 void igc_del_nfc_rule(struct igc_adapter *adapter, struct igc_nfc_rule *rule);
-
+struct igc_ring *igc_get_tx_ring(struct igc_adapter *adapter, int cpu);
 void igc_ptp_init(struct igc_adapter *adapter);
 void igc_ptp_reset(struct igc_adapter *adapter);
 void igc_ptp_suspend(struct igc_adapter *adapter);
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 56a35d58e7a6..44e4f925491f 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -2444,8 +2444,8 @@ static int igc_xdp_init_tx_descriptor(struct igc_ring *ring,
 	return -ENOMEM;
 }
 
-static struct igc_ring *igc_xdp_get_tx_ring(struct igc_adapter *adapter,
-					    int cpu)
+struct igc_ring *igc_get_tx_ring(struct igc_adapter *adapter,
+				 int cpu)
 {
 	int index = cpu;
 
@@ -2469,7 +2469,7 @@ static int igc_xdp_xmit_back(struct igc_adapter *adapter, struct xdp_buff *xdp)
 	if (unlikely(!xdpf))
 		return -EFAULT;
 
-	ring = igc_xdp_get_tx_ring(adapter, cpu);
+	ring = igc_get_tx_ring(adapter, cpu);
 	nq = txring_txq(ring);
 
 	__netif_tx_lock(nq, cpu);
@@ -2546,7 +2546,7 @@ static void igc_finalize_xdp(struct igc_adapter *adapter, int status)
 	struct igc_ring *ring;
 
 	if (status & IGC_XDP_TX) {
-		ring = igc_xdp_get_tx_ring(adapter, cpu);
+		ring = igc_get_tx_ring(adapter, cpu);
 		nq = txring_txq(ring);
 
 		__netif_tx_lock(nq, cpu);
@@ -6699,7 +6699,7 @@ static int igc_xdp_xmit(struct net_device *dev, int num_frames,
 	if (unlikely(flags & ~XDP_XMIT_FLAGS_MASK))
 		return -EINVAL;
 
-	ring = igc_xdp_get_tx_ring(adapter, cpu);
+	ring = igc_get_tx_ring(adapter, cpu);
 	nq = txring_txq(ring);
 
 	__netif_tx_lock(nq, cpu);
-- 
2.34.1


