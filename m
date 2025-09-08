Return-Path: <bpf+bounces-67793-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17212B49A7F
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 21:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AAF04E04BE
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 19:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FE92D8799;
	Mon,  8 Sep 2025 19:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a6X3vJf2"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC5C2D7D27;
	Mon,  8 Sep 2025 19:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757361498; cv=none; b=nh0WrewdVHkxTQeunSFOhve20+ZHdAYxm/5KKuynLZcdbG7ebt28DJbABBVNVct7DzqyxlcNZcQpFvig6Em64Fk5SD6oV4U7u0F3iUu4Z1rzMuNwPFcs/Jh2ypKKBEfia/3HhMBcs4ah1Igfw4gACLkuqXrh0hQdoEhgm27jFCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757361498; c=relaxed/simple;
	bh=RM535H16wR/M8F4M/PyXMJY+w34Z0hTa803h7we88tc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mD+94DpdYh7feip4ExffvKecgRiCCYKvWs8apngKQcaC9F1bx+HZCSgg7kPp1B/UzznW34m1sA0EqLa3n8ELhF/F39JCqg8+/nTMIzeUqy5whESvZOU1Zy8EXIrp1KQnFXY2YceE+4jlRLlkUWbhS4GOn+hNqLmLddWjz/Q3IFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a6X3vJf2; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757361497; x=1788897497;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RM535H16wR/M8F4M/PyXMJY+w34Z0hTa803h7we88tc=;
  b=a6X3vJf2+YM/LS44noOaDpKv+Wkx8GDV5/5McWK//QSK0K+HufjNJ86K
   3xhg46cU0ItEoasUjNoqb5LupOCxCrZFQ60nDEaTmT8r3UEh/VYcbF2AI
   b9ZmxS8VmmsnqeQZRe/qK5GnZtb79QUdxqK6Upixc6zjOpYpOeS68MKmw
   oHrUNy60UC4xAaWsyu//d3ci+7Cpmq39JAZ65t8jLww6TkndSDpMZQu/1
   NTpFosGRmN5SXGY47KFHiNz5sXO9gRNdNHx0dnJ+DrZehXTdSWOBXxWmH
   WtjkCj2divcFi+/nrHC3OKVaTBdgmXfqRGjylOPCTMy145OxV2abQqiCF
   A==;
X-CSE-ConnectionGUID: 50IbG5ovQ92kpSD2GHhYhQ==
X-CSE-MsgGUID: kjyvDtcWRkuOapCKvhh8uQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="77088953"
X-IronPort-AV: E=Sophos;i="6.18,249,1751266800"; 
   d="scan'208";a="77088953"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 12:58:12 -0700
X-CSE-ConnectionGUID: hKB25DgRSTqrEskFFvVojA==
X-CSE-MsgGUID: 2m4L4IYZQ26oYdY5FIdWrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,249,1751266800"; 
   d="scan'208";a="177189747"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa004.jf.intel.com with ESMTP; 08 Sep 2025 12:58:12 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Michal Kubiak <michal.kubiak@intel.com>,
	anthony.l.nguyen@intel.com,
	aleksander.lobakin@intel.com,
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
Subject: [PATCH net-next 09/13] idpf: implement XDP_SETUP_PROG in ndo_bpf for splitq
Date: Mon,  8 Sep 2025 12:57:39 -0700
Message-ID: <20250908195748.1707057-10-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250908195748.1707057-1-anthony.l.nguyen@intel.com>
References: <20250908195748.1707057-1-anthony.l.nguyen@intel.com>
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
Tested-by: Ramu R <ramu.r@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_lib.c  |  1 +
 drivers/net/ethernet/intel/idpf/idpf_txrx.c |  4 +
 drivers/net/ethernet/intel/idpf/idpf_txrx.h |  4 +-
 drivers/net/ethernet/intel/idpf/xdp.c       | 97 +++++++++++++++++++++
 drivers/net/ethernet/intel/idpf/xdp.h       |  7 ++
 5 files changed, 112 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 7db1042782af..2ee887de88e6 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -2614,4 +2614,5 @@ static const struct net_device_ops idpf_netdev_ops = {
 	.ndo_tx_timeout = idpf_tx_timeout,
 	.ndo_hwtstamp_get = idpf_hwtstamp_get,
 	.ndo_hwtstamp_set = idpf_hwtstamp_set,
+	.ndo_bpf = idpf_xdp,
 };
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 80dd7c3433af..c17fd475eaf3 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -762,6 +762,8 @@ int idpf_rx_bufs_init_all(struct idpf_vport *vport)
 	bool split = idpf_is_queue_model_split(vport->rxq_model);
 	int i, j, err;
 
+	idpf_xdp_copy_prog_to_rqs(vport, vport->xdp_prog);
+
 	for (i = 0; i < vport->num_rxq_grp; i++) {
 		struct idpf_rxq_group *rx_qgrp = &vport->rxq_grps[i];
 		u32 truesize = 0;
@@ -1040,6 +1042,8 @@ static void idpf_vport_queue_grp_rel_all(struct idpf_vport *vport)
  */
 void idpf_vport_queues_rel(struct idpf_vport *vport)
 {
+	idpf_xdp_copy_prog_to_rqs(vport, NULL);
+
 	idpf_tx_desc_rel_all(vport);
 	idpf_rx_desc_rel_all(vport);
 
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
-- 
2.47.1


