Return-Path: <bpf+bounces-69591-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AFF4B9B220
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 19:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2AFA167530
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 17:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B5931A06A;
	Wed, 24 Sep 2025 17:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gy4Go6iQ"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BFA31814C;
	Wed, 24 Sep 2025 17:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758736366; cv=none; b=tQ4dy6RzeBK1PvZqdUTeMwefovMf5VUVI5OpJSK8fLreLlfEXSfgJrGdbI/uQen8kGLFjq27dkzZcYdSZWhoQGjygbjc/GDGfarKKavprpofcmHxLKSZYk0+0nJ8rsLWB7zaGpQCoQkyCEsARPcYy+Z5pfdUH/6/S8VFRjbqTIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758736366; c=relaxed/simple;
	bh=6zIRlqjWjsnWP7h5BY9WwdctyVb1Y0PK+MKBGfni9FI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RKOaGVdRKBqNe7Jtq3G+lzYOxNFLr3sNepYkwkGVh9t+f1AVxhFAgb8lRtCvq3cz+PqA4CGy0CkcubONQpvcr1jQGeXJqlWWCYli38aNQTnOLxpxuJb3s4ELrG3NLepCf41PxqhclAIVLdSLzgtShgubfN1NTuneMYHzdep9434=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gy4Go6iQ; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758736365; x=1790272365;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6zIRlqjWjsnWP7h5BY9WwdctyVb1Y0PK+MKBGfni9FI=;
  b=gy4Go6iQTXeVKLCZ9joGvIcdd9QiKFwCXu00UiaENfMxJDESPKUav9f7
   aBXOR4U8zBdG87ZEDLPM+4aHZhivTreRKUIXA34w5MVgVnNSfWr3vOG2G
   dIP+vGEvuklE25LG/1R8W+bf143ix0RuI2k2L4ZW9WCPYvH9JdG4/4MPp
   uXI8k/88gLdMObzpGsKFflFsJVOujHamn9qFYg0q+S4qk9dueufKdZnin
   JH2vbDjyvA3Gf/9Yli8w5P3tlescRqXbl/nuKTT51/lzcm2mZ6birmh8Z
   bRjM8oWwSWvfzqmXs8Ir/yRHrJdZxcr6viqzoXNIG7B0q1Q3fy0GnpCMO
   A==;
X-CSE-ConnectionGUID: 7oYCdbCbQUOWQDTUj+nixQ==
X-CSE-MsgGUID: 4eLmq7X1TkivDDQPk9EcpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="61152277"
X-IronPort-AV: E=Sophos;i="6.18,291,1751266800"; 
   d="scan'208";a="61152277"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 10:52:45 -0700
X-CSE-ConnectionGUID: xRK5cIpnT9Ok38/dkKznTQ==
X-CSE-MsgGUID: sRXoI18oTrCgKOrM4Ah/5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,291,1751266800"; 
   d="scan'208";a="176701862"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa007.fm.intel.com with ESMTP; 24 Sep 2025 10:52:43 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	anthony.l.nguyen@intel.com,
	michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	przemyslaw.kitszel@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	horms@kernel.org,
	sdf@fomichev.me,
	nxne.cnse.osdt.itp.upstreaming@intel.com,
	bpf@vger.kernel.org,
	Ramu R <ramu.r@intel.com>
Subject: [PATCH net-next 5/5] idpf: enable XSk features and ndo_xsk_wakeup
Date: Wed, 24 Sep 2025 10:52:28 -0700
Message-ID: <20250924175230.1290529-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250924175230.1290529-1-anthony.l.nguyen@intel.com>
References: <20250924175230.1290529-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Lobakin <aleksander.lobakin@intel.com>

Now that AF_XDP functionality is fully implemented, advertise XSk XDP
feature and add .ndo_xsk_wakeup() callback to be able to use it with
this driver.

Co-developed-by: Michal Kubiak <michal.kubiak@intel.com>
Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Tested-by: Ramu R <ramu.r@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf.h      |  7 +++++
 drivers/net/ethernet/intel/idpf/idpf_lib.c  |  2 ++
 drivers/net/ethernet/intel/idpf/idpf_txrx.c |  3 +++
 drivers/net/ethernet/intel/idpf/idpf_txrx.h | 10 ++++---
 drivers/net/ethernet/intel/idpf/xdp.c       |  4 ++-
 drivers/net/ethernet/intel/idpf/xsk.c       | 29 +++++++++++++++++++++
 drivers/net/ethernet/intel/idpf/xsk.h       |  4 +++
 7 files changed, 55 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index 6db6d6f0562a..ca4da0c89979 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -995,6 +995,13 @@ static inline void idpf_vport_ctrl_unlock(struct net_device *netdev)
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
-- 
2.47.1


