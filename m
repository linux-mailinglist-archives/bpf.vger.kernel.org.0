Return-Path: <bpf+bounces-66567-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D48B36FD0
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 18:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E055E1BC1BF5
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 16:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153093705A5;
	Tue, 26 Aug 2025 16:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mOzAH3sc"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EB4314B98;
	Tue, 26 Aug 2025 16:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756224849; cv=none; b=CThZ3LylIVP5ikzF/lw4CTuuDW6XYp6ycOf21oKOr27OQCaLn5NN8i1jXc6qdM/P1ytw6KdMqGsNJvOqQTmx3GuS3po4XSGsH7GYXR7nSFYwM9OK64Y/oPtPS8kdoTT5pzZq2ClDk3zBjqGn3gJuNn0ozIBrR54crQa4aI6Drq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756224849; c=relaxed/simple;
	bh=FByDu3fwk48hL4vjTUA5aayxoLqy+QrYRAj5aKjJU0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LMZcnGT1QtkFV3LWDDwrjDbNzFBdTLil9++suHnAvoDynajrVHflbokCRDN/yMsOewg+Bx3jVAKz8zG3g4Q0t3WK+HS5NVWXetCtWywArzbijYHHEN+gi8Nb6FDG0SjimVWttAy7TT469WFM63Piqpo1ZAyqWDagzgjtQq/FMNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mOzAH3sc; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756224848; x=1787760848;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FByDu3fwk48hL4vjTUA5aayxoLqy+QrYRAj5aKjJU0Y=;
  b=mOzAH3scU7OtUuSGYtBVRF2vVB1SSymxAVELz+r9b9gDB38KZ7DiF3Ww
   dJJgjbcDfyvBVtuDhF6d8/EAZ0QgPMRnqcwd+19vo6fktOgPd4y2WY07l
   7UG+bWfPvT/YWbJ+tcvq1p5h8Vnu4/UUuXesW3x1LVejabpIEBiQPszXl
   KYNQN+01gZR3mOe3Qcu3cyDDeQA2KEXrLFuN11lf2vIKAWeYIhGtLe/Dn
   EhxgZ2CafqPLpe3BnQtir5E0fJp0mh33GQm5XdKHExFOym1M9dDemflbI
   DQqmCofm0NHxekKpFRQ/yfTN5RTUMAb5/OywnfLn2X/dcVN/R+eqJ0/RV
   g==;
X-CSE-ConnectionGUID: XptqlmPrSGW4fauhYrGalA==
X-CSE-MsgGUID: duGgsq0+QbiXrIZqSxgPlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="46045039"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="46045039"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 09:14:07 -0700
X-CSE-ConnectionGUID: RxFXdrvITSyeQm7A1OjNww==
X-CSE-MsgGUID: /8vddwJ3Rmq3+c8lOeqOGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="200562489"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa002.jf.intel.com with ESMTP; 26 Aug 2025 09:14:03 -0700
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
Subject: [PATCH iwl-next v5 09/13] idpf: implement XDP_SETUP_PROG in ndo_bpf for splitq
Date: Tue, 26 Aug 2025 17:55:03 +0200
Message-ID: <20250826155507.2138401-10-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250826155507.2138401-1-aleksander.lobakin@intel.com>
References: <20250826155507.2138401-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Kubiak <michal.kubiak@intel.com>

Implement loading/removing XDP program using .ndo_bpf callback
in the split queue mode. Reconfigure and restart the queues if needed
(!!old_prog != !!new_prog), otherwise, just update the pointers.

Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.h |  4 +-
 drivers/net/ethernet/intel/idpf/xdp.h       |  7 ++
 drivers/net/ethernet/intel/idpf/idpf_lib.c  |  1 +
 drivers/net/ethernet/intel/idpf/idpf_txrx.c |  4 +
 drivers/net/ethernet/intel/idpf/xdp.c       | 97 +++++++++++++++++++++
 5 files changed, 112 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index 6bc204b68d9e..f898a9c8de1d 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -467,6 +467,7 @@ struct idpf_tx_queue_stats {
  * @desc_ring: virtual descriptor ring address
  * @bufq_sets: Pointer to the array of buffer queues in splitq mode
  * @napi: NAPI instance corresponding to this queue (splitq)
+ * @xdp_prog: attached XDP program
  * @rx_buf: See struct &libeth_fqe
  * @pp: Page pool pointer in singleq mode
  * @tail: Tail offset. Used for both queue models single and split.
@@ -508,13 +509,14 @@ struct idpf_rx_queue {
 		struct {
 			struct idpf_bufq_set *bufq_sets;
 			struct napi_struct *napi;
+			struct bpf_prog __rcu *xdp_prog;
 		};
 		struct {
 			struct libeth_fqe *rx_buf;
 			struct page_pool *pp;
+			void __iomem *tail;
 		};
 	};
-	void __iomem *tail;
 
 	DECLARE_BITMAP(flags, __IDPF_Q_FLAGS_NBITS);
 	u16 idx;
diff --git a/drivers/net/ethernet/intel/idpf/xdp.h b/drivers/net/ethernet/intel/idpf/xdp.h
index cf6823b24ba5..47553ce5f81a 100644
--- a/drivers/net/ethernet/intel/idpf/xdp.h
+++ b/drivers/net/ethernet/intel/idpf/xdp.h
@@ -6,12 +6,19 @@
 
 #include <linux/types.h>
 
+struct bpf_prog;
 struct idpf_vport;
+struct net_device;
+struct netdev_bpf;
 
 int idpf_xdp_rxq_info_init_all(const struct idpf_vport *vport);
 void idpf_xdp_rxq_info_deinit_all(const struct idpf_vport *vport);
+void idpf_xdp_copy_prog_to_rqs(const struct idpf_vport *vport,
+			       struct bpf_prog *xdp_prog);
 
 int idpf_xdpsqs_get(const struct idpf_vport *vport);
 void idpf_xdpsqs_put(const struct idpf_vport *vport);
 
+int idpf_xdp(struct net_device *dev, struct netdev_bpf *xdp);
+
 #endif /* _IDPF_XDP_H_ */
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 0427f2e86fb8..d645dcc2deda 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -2609,4 +2609,5 @@ static const struct net_device_ops idpf_netdev_ops = {
 	.ndo_tx_timeout = idpf_tx_timeout,
 	.ndo_hwtstamp_get = idpf_hwtstamp_get,
 	.ndo_hwtstamp_set = idpf_hwtstamp_set,
+	.ndo_bpf = idpf_xdp,
 };
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index ecdd9d88f4dc..00bf949d60b5 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -761,6 +761,8 @@ int idpf_rx_bufs_init_all(struct idpf_vport *vport)
 	bool split = idpf_is_queue_model_split(vport->rxq_model);
 	int i, j, err;
 
+	idpf_xdp_copy_prog_to_rqs(vport, vport->xdp_prog);
+
 	for (i = 0; i < vport->num_rxq_grp; i++) {
 		struct idpf_rxq_group *rx_qgrp = &vport->rxq_grps[i];
 		u32 truesize = 0;
@@ -1039,6 +1041,8 @@ static void idpf_vport_queue_grp_rel_all(struct idpf_vport *vport)
  */
 void idpf_vport_queues_rel(struct idpf_vport *vport)
 {
+	idpf_xdp_copy_prog_to_rqs(vport, NULL);
+
 	idpf_tx_desc_rel_all(vport);
 	idpf_rx_desc_rel_all(vport);
 
diff --git a/drivers/net/ethernet/intel/idpf/xdp.c b/drivers/net/ethernet/intel/idpf/xdp.c
index 98bdccc0c957..02f63810632f 100644
--- a/drivers/net/ethernet/intel/idpf/xdp.c
+++ b/drivers/net/ethernet/intel/idpf/xdp.c
@@ -4,6 +4,7 @@
 #include <net/libeth/xdp.h>
 
 #include "idpf.h"
+#include "idpf_virtchnl.h"
 #include "xdp.h"
 
 static int idpf_rxq_for_each(const struct idpf_vport *vport,
@@ -91,6 +92,27 @@ void idpf_xdp_rxq_info_deinit_all(const struct idpf_vport *vport)
 			  (void *)(size_t)vport->rxq_model);
 }
 
+static int idpf_xdp_rxq_assign_prog(struct idpf_rx_queue *rxq, void *arg)
+{
+	struct bpf_prog *prog = arg;
+	struct bpf_prog *old;
+
+	if (prog)
+		bpf_prog_inc(prog);
+
+	old = rcu_replace_pointer(rxq->xdp_prog, prog, lockdep_rtnl_is_held());
+	if (old)
+		bpf_prog_put(old);
+
+	return 0;
+}
+
+void idpf_xdp_copy_prog_to_rqs(const struct idpf_vport *vport,
+			       struct bpf_prog *xdp_prog)
+{
+	idpf_rxq_for_each(vport, idpf_xdp_rxq_assign_prog, xdp_prog);
+}
+
 int idpf_xdpsqs_get(const struct idpf_vport *vport)
 {
 	struct libeth_xdpsq_timer **timers __free(kvfree) = NULL;
@@ -166,3 +188,78 @@ void idpf_xdpsqs_put(const struct idpf_vport *vport)
 		idpf_queue_clear(NOIRQ, xdpsq);
 	}
 }
+
+static int idpf_xdp_setup_prog(struct idpf_vport *vport,
+			       const struct netdev_bpf *xdp)
+{
+	const struct idpf_netdev_priv *np = netdev_priv(vport->netdev);
+	struct bpf_prog *old, *prog = xdp->prog;
+	struct idpf_vport_config *cfg;
+	int ret;
+
+	cfg = vport->adapter->vport_config[vport->idx];
+
+	if (test_bit(IDPF_REMOVE_IN_PROG, vport->adapter->flags) ||
+	    !test_bit(IDPF_VPORT_REG_NETDEV, cfg->flags) ||
+	    !!vport->xdp_prog == !!prog) {
+		if (np->state == __IDPF_VPORT_UP)
+			idpf_xdp_copy_prog_to_rqs(vport, prog);
+
+		old = xchg(&vport->xdp_prog, prog);
+		if (old)
+			bpf_prog_put(old);
+
+		cfg->user_config.xdp_prog = prog;
+
+		return 0;
+	}
+
+	if (!vport->num_xdp_txq && vport->num_txq == cfg->max_q.max_txq) {
+		NL_SET_ERR_MSG_MOD(xdp->extack,
+				   "No Tx queues available for XDP, please decrease the number of regular SQs");
+		return -ENOSPC;
+	}
+
+	old = cfg->user_config.xdp_prog;
+	cfg->user_config.xdp_prog = prog;
+
+	ret = idpf_initiate_soft_reset(vport, IDPF_SR_Q_CHANGE);
+	if (ret) {
+		NL_SET_ERR_MSG_MOD(xdp->extack,
+				   "Could not reopen the vport after XDP setup");
+
+		cfg->user_config.xdp_prog = old;
+		old = prog;
+	}
+
+	if (old)
+		bpf_prog_put(old);
+
+	return ret;
+}
+
+int idpf_xdp(struct net_device *dev, struct netdev_bpf *xdp)
+{
+	struct idpf_vport *vport;
+	int ret;
+
+	idpf_vport_ctrl_lock(dev);
+	vport = idpf_netdev_to_vport(dev);
+
+	if (!idpf_is_queue_model_split(vport->txq_model))
+		goto notsupp;
+
+	switch (xdp->command) {
+	case XDP_SETUP_PROG:
+		ret = idpf_xdp_setup_prog(vport, xdp);
+		break;
+	default:
+notsupp:
+		ret = -EOPNOTSUPP;
+		break;
+	}
+
+	idpf_vport_ctrl_unlock(dev);
+
+	return ret;
+}
-- 
2.51.0


