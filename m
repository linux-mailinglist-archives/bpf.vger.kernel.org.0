Return-Path: <bpf+bounces-67796-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FEDBB49A88
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 22:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0506C1BC533F
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 20:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDA22D9ED5;
	Mon,  8 Sep 2025 19:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FeuGh8ac"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F68A2D8788;
	Mon,  8 Sep 2025 19:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757361500; cv=none; b=IJWAEFLOXFxAt26Vj1BZunnze9DKRbT0/8FqKiRsz1DUf07yt37NyLNP66xT9l6OEr9o2DS82kpYqSyIrDsgQAvnsoiqWSz26M4/6ZkheFRjNVUgYoBtAZuHTcTX+zIy1mOwEHifwk7TNh3osJZS9OyVLYVLLFx133buzgWgT68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757361500; c=relaxed/simple;
	bh=I9HSNl0zKvlug+/PZYZ1BM3hqq/UR1s3gVnS1dFE9Dk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cZVhTOCEVb+ReOkjL3jgFWWGKYXlIwkeL8hDZg4mtUZXr7dUZSJ/y+v3UJyMpH0LbuiLASG5VTBmrkRXbBhZn/Eoqd2R43zFH39j0NcNB68DK1dNW5hkocOm0XO95fZGfOwiazry02DHikxk5jP9aanSjiKj931vXkNN5gZabew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FeuGh8ac; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757361499; x=1788897499;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I9HSNl0zKvlug+/PZYZ1BM3hqq/UR1s3gVnS1dFE9Dk=;
  b=FeuGh8aca+0wMwSvnVk7qImbwVlp6i5nuISE7ElzOqa7jfJbrMFmEAe/
   gApAdhWZtMg2kpZwRpLWSRr96WbOiJEwrXcakNdAz9jTWeqEMjbuwoO2J
   UMZZRo5izaGKDUANdZnuH+w82FPfj09z3/h3uOUtdi9E0yYGjx8MQUJGJ
   ZL4UFLfPx7/97RQE3rezIMrMAhoGaPPZLoz196ad6GOmKP0UtqPIcZ2zi
   NeZK0WD1LVXMeRUg5QPlXU1Gu0oNd1GUcQxXYHcCuqFlQjpsZyLMeEIB1
   cbiJ6C5x7vFV2nQvlz5HNMDustmtEsT+EN1lZhm+g8yUg+y2/UIGa30sh
   Q==;
X-CSE-ConnectionGUID: T4HYCiUzS2amapKFqlT9Xw==
X-CSE-MsgGUID: /dzHnpkJQcSNhlnC1JiLLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="77088981"
X-IronPort-AV: E=Sophos;i="6.18,249,1751266800"; 
   d="scan'208";a="77088981"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 12:58:13 -0700
X-CSE-ConnectionGUID: ef30Xnq+SDqGJEoIaN2Rmw==
X-CSE-MsgGUID: VkSr5x7bR+Ci95fw4V2CKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,249,1751266800"; 
   d="scan'208";a="177189772"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa004.jf.intel.com with ESMTP; 08 Sep 2025 12:58:12 -0700
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
Subject: [PATCH net-next 12/13] idpf: add support for .ndo_xdp_xmit()
Date: Mon,  8 Sep 2025 12:57:42 -0700
Message-ID: <20250908195748.1707057-13-anthony.l.nguyen@intel.com>
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

Use libeth XDP infra to implement .ndo_xdp_xmit() in idpf.
The Tx callbacks are reused from XDP_TX code. XDP redirect target
feature is set/cleared depending on the XDP prog presence, as for now
we still don't allocate XDP Tx queues when there's no program.

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Tested-by: Ramu R <ramu.r@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_lib.c |  1 +
 drivers/net/ethernet/intel/idpf/xdp.c      | 20 ++++++++++++++++++++
 drivers/net/ethernet/intel/idpf/xdp.h      |  2 ++
 3 files changed, 23 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 3bc719c9106f..0559f1da88a9 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -2617,4 +2617,5 @@ static const struct net_device_ops idpf_netdev_ops = {
 	.ndo_hwtstamp_get = idpf_hwtstamp_get,
 	.ndo_hwtstamp_set = idpf_hwtstamp_set,
 	.ndo_bpf = idpf_xdp,
+	.ndo_xdp_xmit = idpf_xdp_xmit,
 };
diff --git a/drivers/net/ethernet/intel/idpf/xdp.c b/drivers/net/ethernet/intel/idpf/xdp.c
index e6b45df95cd3..b6a8304d61f9 100644
--- a/drivers/net/ethernet/intel/idpf/xdp.c
+++ b/drivers/net/ethernet/intel/idpf/xdp.c
@@ -322,8 +322,26 @@ LIBETH_XDP_DEFINE_START();
 LIBETH_XDP_DEFINE_TIMER(static idpf_xdp_tx_timer, idpf_xdpsq_complete);
 LIBETH_XDP_DEFINE_FLUSH_TX(idpf_xdp_tx_flush_bulk, idpf_xdp_tx_prep,
 			   idpf_xdp_tx_xmit);
+LIBETH_XDP_DEFINE_FLUSH_XMIT(static idpf_xdp_xmit_flush_bulk, idpf_xdp_tx_prep,
+			     idpf_xdp_tx_xmit);
 LIBETH_XDP_DEFINE_END();
 
+int idpf_xdp_xmit(struct net_device *dev, int n, struct xdp_frame **frames,
+		  u32 flags)
+{
+	const struct idpf_netdev_priv *np = netdev_priv(dev);
+	const struct idpf_vport *vport = np->vport;
+
+	if (unlikely(!netif_carrier_ok(dev) || !vport->link_up))
+		return -ENETDOWN;
+
+	return libeth_xdp_xmit_do_bulk(dev, n, frames, flags,
+				       &vport->txqs[vport->xdp_txq_offset],
+				       vport->num_xdp_txq,
+				       idpf_xdp_xmit_flush_bulk,
+				       idpf_xdp_tx_finalize);
+}
+
 void idpf_xdp_set_features(const struct idpf_vport *vport)
 {
 	if (!idpf_is_queue_model_split(vport->rxq_model))
@@ -378,6 +396,8 @@ static int idpf_xdp_setup_prog(struct idpf_vport *vport,
 	if (old)
 		bpf_prog_put(old);
 
+	libeth_xdp_set_redirect(vport->netdev, vport->xdp_prog);
+
 	return ret;
 }
 
diff --git a/drivers/net/ethernet/intel/idpf/xdp.h b/drivers/net/ethernet/intel/idpf/xdp.h
index 986156162e2d..db8ecc1843fe 100644
--- a/drivers/net/ethernet/intel/idpf/xdp.h
+++ b/drivers/net/ethernet/intel/idpf/xdp.h
@@ -102,5 +102,7 @@ static inline void idpf_xdp_tx_finalize(void *_xdpsq, bool sent, bool flush)
 void idpf_xdp_set_features(const struct idpf_vport *vport);
 
 int idpf_xdp(struct net_device *dev, struct netdev_bpf *xdp);
+int idpf_xdp_xmit(struct net_device *dev, int n, struct xdp_frame **frames,
+		  u32 flags);
 
 #endif /* _IDPF_XDP_H_ */
-- 
2.47.1


