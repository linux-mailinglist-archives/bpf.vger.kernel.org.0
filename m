Return-Path: <bpf+bounces-53359-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05784A504AB
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 17:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB3193B15C5
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 16:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660C225333A;
	Wed,  5 Mar 2025 16:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N9n+Q6pa"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA5D252913;
	Wed,  5 Mar 2025 16:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741191765; cv=none; b=Ppz6p1xgLF72Nv8H766StE6A7mwI3mqjpD8QvhPBwakid6RLPhousAGNsT2Yvnx6wFs3kvHcFUBl0QjWLMBlG6vVyRW85B6sfs/EhuK6VW2cYFpLcY5GqDa4NXm3z/qwIM/ajAjFQhE45YyYCFXYw0JxaO35rnKuel16gjq+amg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741191765; c=relaxed/simple;
	bh=1M2VbwN5hnOYJWgYeISa3Kluhv1VQz0eEOr3k7U7mdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mRDlYDPNuTaxYBYhMhIyghm/eMtKDPqNZ6EveALE1Qz96Ctz6yHLEJAbcem8iuYgzgdZA8+nkWM5XYSuHiTgs6DrzspoW8eJjWc592p8dL8iAqNVJ3fmAfA3uvgnks2Ct5PraCmWJs9EpO9WVdiwDiPH9sP+Wtr9FG2bBg3AGAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N9n+Q6pa; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741191765; x=1772727765;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1M2VbwN5hnOYJWgYeISa3Kluhv1VQz0eEOr3k7U7mdg=;
  b=N9n+Q6pafiDscEhAXIpF4z/cHE3DhPcASQDtUcZg8tD7r58+SbUtszKy
   MCwcVCYmydA+mmlBF5tf1p/lNBOwyfm77jJ+sJuPxQKtVLjXN55gFfb6c
   XXqug9SoENUTNluHkrPTVwl6IiAZVGgqJQkwZajpoZ8MF+a7DQb6zUCFA
   8Zd1d7wlgBz/3q4Ji4VZZ6Fgzx4MGcHdwzHm5mRc6w/gU4uGPI3NCHSho
   RC4YWlrFu/+1P1JFUUzEy8dZNbwKq3tvrIy+vg0QXdOj75Tm5oWhyY8Pm
   cefOjSm4gttL4FnOGapyPl3nVw82dmD4cC9qEQP0OEVsMklSgp2ezVk3c
   w==;
X-CSE-ConnectionGUID: U3PKFKyoRtWnH0IXpZZPxw==
X-CSE-MsgGUID: hkRXZUQ6SJGQRqlEJ0MuHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="42026479"
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="42026479"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 08:22:44 -0800
X-CSE-ConnectionGUID: exkwKE7NQWWtxRGhghcW7A==
X-CSE-MsgGUID: 7qMio8hmT+6x6qIjuyDeGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="123832897"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa004.fm.intel.com with ESMTP; 05 Mar 2025 08:22:40 -0800
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
Subject: [PATCH net-next 07/16] idpf: link NAPIs to queues
Date: Wed,  5 Mar 2025 17:21:23 +0100
Message-ID: <20250305162132.1106080-8-aleksander.lobakin@intel.com>
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

Add the missing linking of NAPIs to netdev queues when enabling
interrupt vectors in order to support NAPI configuration and
interfaces requiring get_rx_queue()->napi to be set (like XSk
busy polling).

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 30 +++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 2f221c0abad8..a3f6e8cff7a0 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -3560,8 +3560,11 @@ void idpf_vport_intr_rel(struct idpf_vport *vport)
 static void idpf_vport_intr_rel_irq(struct idpf_vport *vport)
 {
 	struct idpf_adapter *adapter = vport->adapter;
+	bool unlock;
 	int vector;
 
+	unlock = rtnl_trylock();
+
 	for (vector = 0; vector < vport->num_q_vectors; vector++) {
 		struct idpf_q_vector *q_vector = &vport->q_vectors[vector];
 		int irq_num, vidx;
@@ -3573,8 +3576,23 @@ static void idpf_vport_intr_rel_irq(struct idpf_vport *vport)
 		vidx = vport->q_vector_idxs[vector];
 		irq_num = adapter->msix_entries[vidx].vector;
 
+		for (u32 i = 0; i < q_vector->num_rxq; i++)
+			netif_queue_set_napi(vport->netdev,
+					     q_vector->rx[i]->idx,
+					     NETDEV_QUEUE_TYPE_RX,
+					     NULL);
+
+		for (u32 i = 0; i < q_vector->num_txq; i++)
+			netif_queue_set_napi(vport->netdev,
+					     q_vector->tx[i]->idx,
+					     NETDEV_QUEUE_TYPE_TX,
+					     NULL);
+
 		kfree(free_irq(irq_num, q_vector));
 	}
+
+	if (unlock)
+		rtnl_unlock();
 }
 
 /**
@@ -3760,6 +3778,18 @@ static int idpf_vport_intr_req_irq(struct idpf_vport *vport)
 				   "Request_irq failed, error: %d\n", err);
 			goto free_q_irqs;
 		}
+
+		for (u32 i = 0; i < q_vector->num_rxq; i++)
+			netif_queue_set_napi(vport->netdev,
+					     q_vector->rx[i]->idx,
+					     NETDEV_QUEUE_TYPE_RX,
+					     &q_vector->napi);
+
+		for (u32 i = 0; i < q_vector->num_txq; i++)
+			netif_queue_set_napi(vport->netdev,
+					     q_vector->tx[i]->idx,
+					     NETDEV_QUEUE_TYPE_TX,
+					     &q_vector->napi);
 	}
 
 	return 0;
-- 
2.48.1


