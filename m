Return-Path: <bpf+bounces-53358-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6C8A504A8
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 17:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD6151653EC
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 16:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3A2252900;
	Wed,  5 Mar 2025 16:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EGfM2gm/"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9999B1957E4;
	Wed,  5 Mar 2025 16:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741191763; cv=none; b=J2spEdtaQP03NLsPyenTCrS7ez3MHKc0Y1tkgBoMNsTienyKxJvWOj/1Z/XswNKmSveGLdhy+rpiKHbDEa43DSVsb+4frmCVOfl9OE9//PkKUKbd3brtUgg6RtEZ7iCkHNY+Y+3xCFRMRlVNl5G4+lwEqWWhEh+P83O/o0fXghc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741191763; c=relaxed/simple;
	bh=jTuPmQQVFrjabXfcySuVP4YFotwZayqG8IND5NsKRCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PmhbkCYqgmOUNZ41c/whY4a02ZqUTHZWZD9Wigbk7aV0tv4VoUg7acPsGLYu9yx4d34SYiVV1fnk5FAr76gNTPO9p5/yP0/D4pjv8R4/NHHNabjyl6PTcjvkjKLxAKyGpSdZhZl3zlUXpNB9d9uSSpi84HGyJw+s73VZc2hd58Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EGfM2gm/; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741191762; x=1772727762;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jTuPmQQVFrjabXfcySuVP4YFotwZayqG8IND5NsKRCU=;
  b=EGfM2gm/2ZRjGoQJuXfMd/LO3fRdcbCukNPwkcuKbYIoOQwG+4bcAOAK
   kk2iVtz49JwOeVxmiDguaoiUjMqVE8FmEUsvdHKrtFKeiumfii7Nyc6Yo
   /MOgIumdi9FmEdf8hy4auBsZ+K7HyvB/V6v1jrMlcetLNFSu1lQYcYXYP
   k/HkkCvVgMvQ8VoDBSHBy8PKH09xAD0QmdU6pErBPORyM+oTJ6k678umn
   GDodxk6G+vlf9W/wLlq5B4eabzgBb8SGzrCBHvJweJg8IRxTKXXGwzQ/Z
   yR9MDyGMFpt3pF0lfQ+dCS+O2ToMuRzcVWQusPEolrc4QeckRTwiqpOLJ
   g==;
X-CSE-ConnectionGUID: ccYs5p20SHim2PcVzrEWhg==
X-CSE-MsgGUID: +Zw4zsiUQnudKp96No4acw==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="42026463"
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="42026463"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 08:22:40 -0800
X-CSE-ConnectionGUID: puNLARu/T7KXmwOP7nTMHA==
X-CSE-MsgGUID: cSngNrHrQKeFsSEVtkLsBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="123832891"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa004.fm.intel.com with ESMTP; 05 Mar 2025 08:22:36 -0800
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
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
	Simon Horman <horms@kernel.org>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 06/16] idpf: a use saner limit for default number of queues to allocate
Date: Wed,  5 Mar 2025 17:21:22 +0100
Message-ID: <20250305162132.1106080-7-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305162132.1106080-1-aleksander.lobakin@intel.com>
References: <20250305162132.1106080-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the maximum number of queues available for one vport is 16.
This is hardcoded, but then the function calculating the optimal number
of queues takes min(16, num_online_cpus()).
On order to be able to allocate more queues, which will be then used for
XDP, stop hardcoding 16 and rely on what the device gives us. Instead of
num_online_cpus(), which is considered suboptimal since at least 2013,
use netif_get_num_default_rss_queues() to still have free queues in the
pool.
nr_cpu_ids number of Tx queues are needed only for lockless XDP sending,
the regular stack doesn't benefit from that anyhow.
On a 128-thread Xeon, this now gives me 32 regular Tx queues and leaves
224 free for XDP (128 of which will handle XDP_TX, .ndo_xdp_xmit(), and
XSk xmit when enabled).

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c     | 8 +-------
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 2 +-
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index c15833928ea1..2f221c0abad8 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -1234,13 +1234,7 @@ int idpf_vport_calc_total_qs(struct idpf_adapter *adapter, u16 vport_idx,
 		num_req_tx_qs = vport_config->user_config.num_req_tx_qs;
 		num_req_rx_qs = vport_config->user_config.num_req_rx_qs;
 	} else {
-		int num_cpus;
-
-		/* Restrict num of queues to cpus online as a default
-		 * configuration to give best performance. User can always
-		 * override to a max number of queues via ethtool.
-		 */
-		num_cpus = num_online_cpus();
+		u32 num_cpus = netif_get_num_default_rss_queues();
 
 		dflt_splitq_txq_grps = min_t(int, max_q->max_txq, num_cpus);
 		dflt_singleq_txqs = min_t(int, max_q->max_txq, num_cpus);
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 3d2413b8684f..135af3cc243f 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -937,7 +937,7 @@ int idpf_vport_alloc_max_qs(struct idpf_adapter *adapter,
 	max_tx_q = le16_to_cpu(caps->max_tx_q) / default_vports;
 	if (adapter->num_alloc_vports < default_vports) {
 		max_q->max_rxq = min_t(u16, max_rx_q, IDPF_MAX_Q);
-		max_q->max_txq = min_t(u16, max_tx_q, IDPF_MAX_Q);
+		max_q->max_txq = min_t(u16, max_tx_q, IDPF_LARGE_MAX_Q);
 	} else {
 		max_q->max_rxq = IDPF_MIN_Q;
 		max_q->max_txq = IDPF_MIN_Q;
-- 
2.48.1


