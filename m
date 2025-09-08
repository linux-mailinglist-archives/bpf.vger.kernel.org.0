Return-Path: <bpf+bounces-67787-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D16B49A74
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 21:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D1A544829F
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 19:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953352D6E69;
	Mon,  8 Sep 2025 19:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D36x9k5t"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5781D2D5C78;
	Mon,  8 Sep 2025 19:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757361494; cv=none; b=hCToIAp/MHnildrt3F/bcBm/BsEHLsIGu+WZAmpviBsxx9ldUL1pP3PtQWeKCekNfi0LoDJ43aAul0qBUtWWNShzJSJ+IAWrBELmzN+2Ot9OBmi2pEAALtoFHoQxbT22lPSWrFuqKMpR3k6BGxeFztHlEfmkR3H8r04vsQXgl0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757361494; c=relaxed/simple;
	bh=+hHoWo4ijGStjiWhswwHdqFYWXa0AYgieJKkmmICwbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YiEPATJXgahcG7Aks479L8HvzQmA5xu3v8zpOZtKMwi059BXlu8U/MBKmmuRDzutUJbxvcEKEg1nbMBX6eak2yfOdJ3cTTEN5wwehPCOAsFHGWCaxqcSAXfodCWjY4LOQs515+ummPHHvpSg51yZ1KsgmpMhCop5vOwTuqfVhMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D36x9k5t; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757361493; x=1788897493;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+hHoWo4ijGStjiWhswwHdqFYWXa0AYgieJKkmmICwbc=;
  b=D36x9k5t7sA4sKZDtNtsU3FMFDVa4Ej38UNibyZzLKE1f9im4k8M/n66
   Pwm+sUfUxjWNI8boWXOrCC5Nej93f57EIncng1DUv/YXtIlbdB3xsLZ3/
   H5FEh+WhQA03tKN7xCC4VJ/6FqiZV4ZdbFK9GLkr+vtFgsVMI8ZkJbFQl
   Gv8bfrJO3JvuVKc2kFlbQIDlrn8/nJYfPQzdfeTBvjkJcc0SkdmiDXEb1
   CNF9EMWkoodPIJvOEj1EOOKd+u8dNwai+NpX+2n3ArgGiI1sNgQWymh9o
   yne7V6dYN2Wh8eszQSRF+pglVbXdwd8COcgZ8/GKCnQ/0ijDownkWyZDM
   w==;
X-CSE-ConnectionGUID: oh7xojmTT+WEeOHpsOEUAw==
X-CSE-MsgGUID: baD9iIe5SdWKP+TJfqrEOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="77088898"
X-IronPort-AV: E=Sophos;i="6.18,249,1751266800"; 
   d="scan'208";a="77088898"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 12:58:11 -0700
X-CSE-ConnectionGUID: MwaazRh5RHCJ18HbLltA9A==
X-CSE-MsgGUID: W+gpwjgORHiXw/i8ar5IDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,249,1751266800"; 
   d="scan'208";a="177189724"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa004.jf.intel.com with ESMTP; 08 Sep 2025 12:58:11 -0700
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
Subject: [PATCH net-next 03/13] idpf: use a saner limit for default number of queues to allocate
Date: Mon,  8 Sep 2025 12:57:33 -0700
Message-ID: <20250908195748.1707057-4-anthony.l.nguyen@intel.com>
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

From: Alexander Lobakin <aleksander.lobakin@intel.com>

Currently, the maximum number of queues available for one vport is 16.
This is hardcoded, but then the function calculating the optimal number
of queues takes min(16, num_online_cpus()).
In order to be able to allocate more queues, which will be then used for
XDP, stop hardcoding 16 and rely on what the device gives us[*]. Instead
of num_online_cpus(), which is considered suboptimal since at least 2013,
use netif_get_num_default_rss_queues() to still have free queues in the
pool.

[*] With the note:

Currently, idpf always allocates `IDPF_MAX_BUFQS_PER_RXQ_GRP` (== 2)
buffer queues for each Rx queue and one completion queue for each Tx for
best performance. But there was no check whether such number is available,
IOW the assumption was not backed by any "harmonizing" / actual checks.
Fix this while at it.

nr_cpu_ids number of Tx queues are needed only for lockless XDP sending,
the regular stack doesn't benefit from that anyhow.
On a 128-thread Xeon, this now gives me 32 regular Tx queues and leaves
224 free for XDP (128 of which will handle XDP_TX, .ndo_xdp_xmit(), and
XSk xmit when enabled).

Note 2:

Unfortunately, some CP/FW versions are not able to
reconfigure/enable/disable large amount of queues within the minimum
timeout (2 seconds). For now, fall back to the default timeout for
every operation until this is resolved.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Tested-by: Ramu R <ramu.r@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  8 +--
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 62 +++++++++++--------
 .../net/ethernet/intel/idpf/idpf_virtchnl.h   |  1 -
 3 files changed, 38 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index e75a94d7ac2a..53fb5cf496cc 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -1176,13 +1176,7 @@ int idpf_vport_calc_total_qs(struct idpf_adapter *adapter, u16 vport_idx,
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
index 6330d4a0ae07..fc45c28251d7 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -1061,21 +1061,35 @@ int idpf_vport_alloc_max_qs(struct idpf_adapter *adapter,
 	struct idpf_avail_queue_info *avail_queues = &adapter->avail_queues;
 	struct virtchnl2_get_capabilities *caps = &adapter->caps;
 	u16 default_vports = idpf_get_default_vports(adapter);
-	int max_rx_q, max_tx_q;
+	u32 max_rx_q, max_tx_q, max_buf_q, max_compl_q;
 
 	mutex_lock(&adapter->queue_lock);
 
+	/* Caps are device-wide. Give each vport an equal piece */
 	max_rx_q = le16_to_cpu(caps->max_rx_q) / default_vports;
 	max_tx_q = le16_to_cpu(caps->max_tx_q) / default_vports;
-	if (adapter->num_alloc_vports < default_vports) {
-		max_q->max_rxq = min_t(u16, max_rx_q, IDPF_MAX_Q);
-		max_q->max_txq = min_t(u16, max_tx_q, IDPF_MAX_Q);
-	} else {
-		max_q->max_rxq = IDPF_MIN_Q;
-		max_q->max_txq = IDPF_MIN_Q;
+	max_buf_q = le16_to_cpu(caps->max_rx_bufq) / default_vports;
+	max_compl_q = le16_to_cpu(caps->max_tx_complq) / default_vports;
+
+	if (adapter->num_alloc_vports >= default_vports) {
+		max_rx_q = IDPF_MIN_Q;
+		max_tx_q = IDPF_MIN_Q;
 	}
-	max_q->max_bufq = max_q->max_rxq * IDPF_MAX_BUFQS_PER_RXQ_GRP;
-	max_q->max_complq = max_q->max_txq;
+
+	/*
+	 * Harmonize the numbers. The current implementation always creates
+	 * `IDPF_MAX_BUFQS_PER_RXQ_GRP` buffer queues for each Rx queue and
+	 * one completion queue for each Tx queue for best performance.
+	 * If less buffer or completion queues is available, cap the number
+	 * of the corresponding Rx/Tx queues.
+	 */
+	max_rx_q = min(max_rx_q, max_buf_q / IDPF_MAX_BUFQS_PER_RXQ_GRP);
+	max_tx_q = min(max_tx_q, max_compl_q);
+
+	max_q->max_rxq = max_rx_q;
+	max_q->max_txq = max_tx_q;
+	max_q->max_bufq = max_rx_q * IDPF_MAX_BUFQS_PER_RXQ_GRP;
+	max_q->max_complq = max_tx_q;
 
 	if (avail_queues->avail_rxq < max_q->max_rxq ||
 	    avail_queues->avail_txq < max_q->max_txq ||
@@ -1506,7 +1520,7 @@ int idpf_send_destroy_vport_msg(struct idpf_vport *vport)
 	xn_params.vc_op = VIRTCHNL2_OP_DESTROY_VPORT;
 	xn_params.send_buf.iov_base = &v_id;
 	xn_params.send_buf.iov_len = sizeof(v_id);
-	xn_params.timeout_ms = IDPF_VC_XN_MIN_TIMEOUT_MSEC;
+	xn_params.timeout_ms = IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC;
 	reply_sz = idpf_vc_xn_exec(vport->adapter, &xn_params);
 
 	return reply_sz < 0 ? reply_sz : 0;
@@ -1554,7 +1568,7 @@ int idpf_send_disable_vport_msg(struct idpf_vport *vport)
 	xn_params.vc_op = VIRTCHNL2_OP_DISABLE_VPORT;
 	xn_params.send_buf.iov_base = &v_id;
 	xn_params.send_buf.iov_len = sizeof(v_id);
-	xn_params.timeout_ms = IDPF_VC_XN_MIN_TIMEOUT_MSEC;
+	xn_params.timeout_ms = IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC;
 	reply_sz = idpf_vc_xn_exec(vport->adapter, &xn_params);
 
 	return reply_sz < 0 ? reply_sz : 0;
@@ -1845,7 +1859,9 @@ static int idpf_send_ena_dis_queues_msg(struct idpf_vport *vport, bool ena)
 	struct virtchnl2_del_ena_dis_queues *eq __free(kfree) = NULL;
 	struct virtchnl2_queue_chunk *qc __free(kfree) = NULL;
 	u32 num_msgs, num_chunks, num_txq, num_rxq, num_q;
-	struct idpf_vc_xn_params xn_params = {};
+	struct idpf_vc_xn_params xn_params = {
+		.timeout_ms	= IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC,
+	};
 	struct virtchnl2_queue_chunks *qcs;
 	u32 config_sz, chunk_sz, buf_sz;
 	ssize_t reply_sz;
@@ -1946,13 +1962,10 @@ static int idpf_send_ena_dis_queues_msg(struct idpf_vport *vport, bool ena)
 	if (!eq)
 		return -ENOMEM;
 
-	if (ena) {
+	if (ena)
 		xn_params.vc_op = VIRTCHNL2_OP_ENABLE_QUEUES;
-		xn_params.timeout_ms = IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC;
-	} else {
+	else
 		xn_params.vc_op = VIRTCHNL2_OP_DISABLE_QUEUES;
-		xn_params.timeout_ms = IDPF_VC_XN_MIN_TIMEOUT_MSEC;
-	}
 
 	for (i = 0, k = 0; i < num_msgs; i++) {
 		memset(eq, 0, buf_sz);
@@ -1990,7 +2003,9 @@ int idpf_send_map_unmap_queue_vector_msg(struct idpf_vport *vport, bool map)
 {
 	struct virtchnl2_queue_vector_maps *vqvm __free(kfree) = NULL;
 	struct virtchnl2_queue_vector *vqv __free(kfree) = NULL;
-	struct idpf_vc_xn_params xn_params = {};
+	struct idpf_vc_xn_params xn_params = {
+		.timeout_ms	= IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC,
+	};
 	u32 config_sz, chunk_sz, buf_sz;
 	u32 num_msgs, num_chunks, num_q;
 	ssize_t reply_sz;
@@ -2074,13 +2089,10 @@ int idpf_send_map_unmap_queue_vector_msg(struct idpf_vport *vport, bool map)
 	if (!vqvm)
 		return -ENOMEM;
 
-	if (map) {
+	if (map)
 		xn_params.vc_op = VIRTCHNL2_OP_MAP_QUEUE_VECTOR;
-		xn_params.timeout_ms = IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC;
-	} else {
+	else
 		xn_params.vc_op = VIRTCHNL2_OP_UNMAP_QUEUE_VECTOR;
-		xn_params.timeout_ms = IDPF_VC_XN_MIN_TIMEOUT_MSEC;
-	}
 
 	for (i = 0, k = 0; i < num_msgs; i++) {
 		memset(vqvm, 0, buf_sz);
@@ -2207,7 +2219,7 @@ int idpf_send_delete_queues_msg(struct idpf_vport *vport)
 					 num_chunks);
 
 	xn_params.vc_op = VIRTCHNL2_OP_DEL_QUEUES;
-	xn_params.timeout_ms = IDPF_VC_XN_MIN_TIMEOUT_MSEC;
+	xn_params.timeout_ms = IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC;
 	xn_params.send_buf.iov_base = eq;
 	xn_params.send_buf.iov_len = buf_size;
 	reply_sz = idpf_vc_xn_exec(vport->adapter, &xn_params);
@@ -2371,7 +2383,7 @@ int idpf_send_dealloc_vectors_msg(struct idpf_adapter *adapter)
 	xn_params.vc_op = VIRTCHNL2_OP_DEALLOC_VECTORS;
 	xn_params.send_buf.iov_base = vcs;
 	xn_params.send_buf.iov_len = buf_size;
-	xn_params.timeout_ms = IDPF_VC_XN_MIN_TIMEOUT_MSEC;
+	xn_params.timeout_ms = IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC;
 	reply_sz = idpf_vc_xn_exec(adapter, &xn_params);
 	if (reply_sz < 0)
 		return reply_sz;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
index 86f30f0db07a..d714ff0eaca0 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
@@ -4,7 +4,6 @@
 #ifndef _IDPF_VIRTCHNL_H_
 #define _IDPF_VIRTCHNL_H_
 
-#define IDPF_VC_XN_MIN_TIMEOUT_MSEC	2000
 #define IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC	(60 * 1000)
 #define IDPF_VC_XN_IDX_M		GENMASK(7, 0)
 #define IDPF_VC_XN_SALT_M		GENMASK(15, 8)
-- 
2.47.1


