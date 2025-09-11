Return-Path: <bpf+bounces-68161-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB97DB5392E
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 18:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B07F1C80491
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 16:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50883705A6;
	Thu, 11 Sep 2025 16:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U1f1WM85"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDA036CDE6;
	Thu, 11 Sep 2025 16:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757607825; cv=none; b=XKM/ME0Je5aZwjfmeVvWLaRtj4XPrjTjl7o0qbezV+u3s+RkkafFW7aGU2uphy7QorjgAEEjTHuu+QH6pxAXij5L1dbLL8sj6TdeARUYFiJp3Oq47ybJLpsf1zNlNhSjP6Dh9B7+SFHjpvyoh8H5kCn9Mk+KcqKDwmuXP6aVGZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757607825; c=relaxed/simple;
	bh=ZbzwFksgb7H1D0gKuZCJsoT2wb4x1APi3k7nuAZfsng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HJ9FLqX0ALHZ0NpSe+4tRmsq2f0MtKCkGxlMw5LDCIWZwNJdOCtD9nj+KDfj0vF88tMKVGO0xNayCOzn2IecuqeMp5vnQ0RsUW2+TNaMsHnMXalhiyEXAYCI0RkHBNKHXJjA533mkYqAEqOxYWWQIpIkthQnipBnjvVfD+r5oDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U1f1WM85; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757607823; x=1789143823;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZbzwFksgb7H1D0gKuZCJsoT2wb4x1APi3k7nuAZfsng=;
  b=U1f1WM85yQKQwYY+y8RMtkrG8IsakMUilozjaQJYOiutRpaYGKx6pKSL
   IPy8iQTwQlXu3oMyRL0HDPAgYm2bvXAGen0bozuW6gUMPOPPXI6EbbYAI
   LM/wGtB0roGJ0eCd6txA+mZRPtHjDAGWMDJ2DaoUdZ8LeGbKaCZaYd2vY
   rYk2v7xki+jEC48TxyWjTfTo18+5xs5judtNmGV4h0v6e050deSqhsSTG
   inEjrWx9j3+O152MO/WWJoCYhczzi8kzjx50HvLFGUsnSBYbVkm3yl30h
   sO7kzPZ2KmT1l+NZlloPYV6+i5XKlHlaEVo+gWMRqFox8YAJY3yld7OBO
   g==;
X-CSE-ConnectionGUID: NCstvL1wT82bf3CGc1retw==
X-CSE-MsgGUID: XRKs40YQQOaco0k265bHIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11549"; a="70635216"
X-IronPort-AV: E=Sophos;i="6.18,257,1751266800"; 
   d="scan'208";a="70635216"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 09:23:43 -0700
X-CSE-ConnectionGUID: BYgh7milQWyE4Mf5GqIn9A==
X-CSE-MsgGUID: iWVXcq3mT628kEEr6mXlZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,257,1751266800"; 
   d="scan'208";a="173284722"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa009.jf.intel.com with ESMTP; 11 Sep 2025 09:23:38 -0700
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
	Simon Horman <horms@kernel.org>,
	nxne.cnse.osdt.itp.upstreaming@intel.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-next 5/5] idpf: enable XSk features and ndo_xsk_wakeup
Date: Thu, 11 Sep 2025 18:22:33 +0200
Message-ID: <20250911162233.1238034-6-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250911162233.1238034-1-aleksander.lobakin@intel.com>
References: <20250911162233.1238034-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that AF_XDP functionality is fully implemented, advertise XSk XDP
feature and add .ndo_xsk_wakeup() callback to be able to use it with
this driver.

Co-developed-by: Michal Kubiak <michal.kubiak@intel.com>
Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf.h      |  7 +++++
 drivers/net/ethernet/intel/idpf/idpf_txrx.h | 10 ++++---
 drivers/net/ethernet/intel/idpf/xsk.h       |  4 +++
 drivers/net/ethernet/intel/idpf/idpf_lib.c  |  2 ++
 drivers/net/ethernet/intel/idpf/idpf_txrx.c |  3 +++
 drivers/net/ethernet/intel/idpf/xdp.c       |  4 ++-
 drivers/net/ethernet/intel/idpf/xsk.c       | 29 +++++++++++++++++++++
 7 files changed, 55 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index 6e79fa8556e9..c5ede00c5b2e 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -978,6 +978,13 @@ static inline void idpf_vport_ctrl_unlock(struct net_device *netdev)
 	mutex_unlock(&np->adapter->vport_ctrl_lock);
 }
 
+static inline bool idpf_vport_ctrl_is_locked(struct net_device *netdev)
+{
+	struct idpf_netdev_priv *np = netdev_priv(netdev);
+
+	return mutex_is_locked(&np->adapter->vport_ctrl_lock);
+}
+
 void idpf_statistics_task(struct work_struct *work);
 void idpf_init_task(struct work_struct *work);
 void idpf_service_task(struct work_struct *work);
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index a42aa4669c3c..75b977094741 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -374,9 +374,10 @@ struct idpf_intr_reg {
  * @complq: array of completion queues
  * @xsksq: array of XSk send queues
  * @intr_reg: See struct idpf_intr_reg
- * @napi: napi handler
+ * @csd: XSk wakeup CSD
  * @total_events: Number of interrupts processed
  * @wb_on_itr: whether WB on ITR is enabled
+ * @napi: napi handler
  * @tx_dim: Data for TX net_dim algorithm
  * @tx_itr_value: TX interrupt throttling rate
  * @tx_intr_mode: Dynamic ITR or not
@@ -406,10 +407,13 @@ struct idpf_q_vector {
 	__cacheline_group_end_aligned(read_mostly);
 
 	__cacheline_group_begin_aligned(read_write);
-	struct napi_struct napi;
+	call_single_data_t csd;
+
 	u16 total_events;
 	bool wb_on_itr;
 
+	struct napi_struct napi;
+
 	struct dim tx_dim;
 	u16 tx_itr_value;
 	bool tx_intr_mode;
@@ -427,7 +431,7 @@ struct idpf_q_vector {
 	__cacheline_group_end_aligned(cold);
 };
 libeth_cacheline_set_assert(struct idpf_q_vector, 136,
-			    24 + sizeof(struct napi_struct) +
+			    56 + sizeof(struct napi_struct) +
 			    2 * sizeof(struct dim),
 			    8);
 
diff --git a/drivers/net/ethernet/intel/idpf/xsk.h b/drivers/net/ethernet/intel/idpf/xsk.h
index d5338cbef8bd..b622d08c03e8 100644
--- a/drivers/net/ethernet/intel/idpf/xsk.h
+++ b/drivers/net/ethernet/intel/idpf/xsk.h
@@ -8,14 +8,17 @@
 
 enum virtchnl2_queue_type;
 struct idpf_buf_queue;
+struct idpf_q_vector;
 struct idpf_rx_queue;
 struct idpf_tx_queue;
 struct idpf_vport;
+struct net_device;
 struct netdev_bpf;
 
 void idpf_xsk_setup_queue(const struct idpf_vport *vport, void *q,
 			  enum virtchnl2_queue_type type);
 void idpf_xsk_clear_queue(void *q, enum virtchnl2_queue_type type);
+void idpf_xsk_init_wakeup(struct idpf_q_vector *qv);
 
 int idpf_xskfq_init(struct idpf_buf_queue *bufq);
 void idpf_xskfq_rel(struct idpf_buf_queue *bufq);
@@ -25,5 +28,6 @@ int idpf_xskrq_poll(struct idpf_rx_queue *rxq, u32 budget);
 bool idpf_xsk_xmit(struct idpf_tx_queue *xsksq);
 
 int idpf_xsk_pool_setup(struct idpf_vport *vport, struct netdev_bpf *xdp);
+int idpf_xsk_wakeup(struct net_device *dev, u32 qid, u32 flags);
 
 #endif /* !_IDPF_XSK_H_ */
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 9b8f7a6d65d6..8a941f0fb048 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -5,6 +5,7 @@
 #include "idpf_virtchnl.h"
 #include "idpf_ptp.h"
 #include "xdp.h"
+#include "xsk.h"
 
 static const struct net_device_ops idpf_netdev_ops;
 
@@ -2618,4 +2619,5 @@ static const struct net_device_ops idpf_netdev_ops = {
 	.ndo_hwtstamp_set = idpf_hwtstamp_set,
 	.ndo_bpf = idpf_xdp,
 	.ndo_xdp_xmit = idpf_xdp_xmit,
+	.ndo_xsk_wakeup = idpf_xsk_wakeup,
 };
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 67963c0f4541..828f7c444d30 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -1210,6 +1210,8 @@ static int idpf_qp_enable(const struct idpf_queue_set *qs, u32 qid)
 		if (!idpf_queue_has(XSK, q->txq))
 			continue;
 
+		idpf_xsk_init_wakeup(q_vector);
+
 		q->txq->q_vector = q_vector;
 		q_vector->xsksq[q_vector->num_xsksq++] = q->txq;
 	}
@@ -4418,6 +4420,7 @@ static void idpf_vport_intr_map_vector_to_qs(struct idpf_vport *vport)
 			continue;
 
 		qv = idpf_find_rxq_vec(vport, i);
+		idpf_xsk_init_wakeup(qv);
 
 		xdpsq->q_vector = qv;
 		qv->xsksq[qv->num_xsksq++] = xdpsq;
diff --git a/drivers/net/ethernet/intel/idpf/xdp.c b/drivers/net/ethernet/intel/idpf/xdp.c
index cde6d56553d2..21ce25b0567f 100644
--- a/drivers/net/ethernet/intel/idpf/xdp.c
+++ b/drivers/net/ethernet/intel/idpf/xdp.c
@@ -400,7 +400,9 @@ void idpf_xdp_set_features(const struct idpf_vport *vport)
 	if (!idpf_is_queue_model_split(vport->rxq_model))
 		return;
 
-	libeth_xdp_set_features_noredir(vport->netdev, &idpf_xdpmo);
+	libeth_xdp_set_features_noredir(vport->netdev, &idpf_xdpmo,
+					idpf_get_max_tx_bufs(vport->adapter),
+					libeth_xsktmo);
 }
 
 static int idpf_xdp_setup_prog(struct idpf_vport *vport,
diff --git a/drivers/net/ethernet/intel/idpf/xsk.c b/drivers/net/ethernet/intel/idpf/xsk.c
index ba35dca946d5..fd2cc43ab43c 100644
--- a/drivers/net/ethernet/intel/idpf/xsk.c
+++ b/drivers/net/ethernet/intel/idpf/xsk.c
@@ -158,6 +158,11 @@ void idpf_xsk_clear_queue(void *q, enum virtchnl2_queue_type type)
 	}
 }
 
+void idpf_xsk_init_wakeup(struct idpf_q_vector *qv)
+{
+	libeth_xsk_init_wakeup(&qv->csd, &qv->napi);
+}
+
 void idpf_xsksq_clean(struct idpf_tx_queue *xdpsq)
 {
 	struct libeth_xdpsq_napi_stats ss = { };
@@ -602,3 +607,27 @@ int idpf_xsk_pool_setup(struct idpf_vport *vport, struct netdev_bpf *bpf)
 
 	return ret;
 }
+
+int idpf_xsk_wakeup(struct net_device *dev, u32 qid, u32 flags)
+{
+	const struct idpf_netdev_priv *np = netdev_priv(dev);
+	const struct idpf_vport *vport = np->vport;
+	struct idpf_q_vector *q_vector;
+
+	if (unlikely(idpf_vport_ctrl_is_locked(dev)))
+		return -EBUSY;
+
+	if (unlikely(!vport->link_up))
+		return -ENETDOWN;
+
+	if (unlikely(!vport->num_xdp_txq))
+		return -ENXIO;
+
+	q_vector = idpf_find_rxq_vec(vport, qid);
+	if (unlikely(!q_vector->xsksq))
+		return -ENXIO;
+
+	libeth_xsk_wakeup(&q_vector->csd, qid);
+
+	return 0;
+}
-- 
2.51.0


