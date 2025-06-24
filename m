Return-Path: <bpf+bounces-61404-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 183DEAE6CDC
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 18:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A9AF1BC831E
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 16:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABADE2ED150;
	Tue, 24 Jun 2025 16:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CnA7PT+B"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31B82ECE92;
	Tue, 24 Jun 2025 16:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750783586; cv=none; b=I5tMrHVEn32LsZuuiLQxakiNKl9HabijGwjAbMyFAFvCxpv4E1dfuQOrKCvr9UCrirx72PhqYFIF/44J892u5/AzG4E6uXA7u1qDmLvAnyzmM+5T7m+wz2f779CkmIcMxL9lkCze0pBZByKUOCisfMRXgDlHFIxek871878raLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750783586; c=relaxed/simple;
	bh=7Ys41ewzCv16gpSQ+y6b4i3wPF1PkgZ8oZ/5SVgWznE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jLfIL7cpIYDxpBh41i21ysbRZVmtEavmmU7wh827DYM2P3sGYnN2uYGzm2c8tzcc/tbvZcGELEsUeD6B1A8RyHYVWnXz3YuNAu+c8Y0esqAU8UW6DzZR3d+wEBwElkoBRhoOymNxyboNUR5SPQyxShHgFNLeUU16cXc+nFI1ydo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CnA7PT+B; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750783585; x=1782319585;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7Ys41ewzCv16gpSQ+y6b4i3wPF1PkgZ8oZ/5SVgWznE=;
  b=CnA7PT+B4prncIzxD5E19kjaEDVm/lNOu5GzoJoefQ7935vdj9ypbQI4
   kQvmBYqiqRnOtn0PvjPRUc1/NAo/ikBhaZwZiAkBjJrDBJ52p0DIsDMIP
   LVYZCidnjBUHJBQXhCy+72eUVfbSVQD5oaM0Am3Id2hCCDDLZAK4xtV43
   yF4MQX5lu5HPv8cPcDeB2Yg8gNHJ6c/inGsHlkmgd1o5UHtI71P/HnFiI
   SRjSROel1OnfsfWenvfVrOw9qtaF73mAIbUtYU35m+CaFGpdgwFCV0mUT
   8FxJzV7f/TXW65SY7Pz4+icsplzNzemvuacyJS8v0nnknOY+EKyU9laBk
   g==;
X-CSE-ConnectionGUID: PEh3kc1ZSQyMxEyhs9evbA==
X-CSE-MsgGUID: 9qpPGZVUSli+PJ9d2PFvqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="64091324"
X-IronPort-AV: E=Sophos;i="6.16,262,1744095600"; 
   d="scan'208";a="64091324"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 09:46:24 -0700
X-CSE-ConnectionGUID: 3UDVJG++QUyKJ6k9kt6Hiw==
X-CSE-MsgGUID: PKiGO8XSQLmbIDx6XtSjoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,262,1744095600"; 
   d="scan'208";a="152669496"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa010.fm.intel.com with ESMTP; 24 Jun 2025 09:46:20 -0700
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
Subject: [PATCH iwl-next v2 11/12] idpf: add support for .ndo_xdp_xmit()
Date: Tue, 24 Jun 2025 18:45:14 +0200
Message-ID: <20250624164515.2663137-12-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250624164515.2663137-1-aleksander.lobakin@intel.com>
References: <20250624164515.2663137-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use libeth XDP infra to implement .ndo_xdp_xmit() in idpf.
The Tx callbacks are reused from XDP_TX code. XDP redirect target
feature is set/cleared depending on the XDP prog presence, as for now
we still don't allocate XDP Tx queues when there's no program.

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/idpf/xdp.h      |  2 ++
 drivers/net/ethernet/intel/idpf/idpf_lib.c |  1 +
 drivers/net/ethernet/intel/idpf/xdp.c      | 20 ++++++++++++++++++++
 3 files changed, 23 insertions(+)

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
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index ad458a3eba66..c2c9267e4254 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -2421,4 +2421,5 @@ static const struct net_device_ops idpf_netdev_ops = {
 	.ndo_hwtstamp_get = idpf_hwtstamp_get,
 	.ndo_hwtstamp_set = idpf_hwtstamp_set,
 	.ndo_bpf = idpf_xdp,
+	.ndo_xdp_xmit = idpf_xdp_xmit,
 };
diff --git a/drivers/net/ethernet/intel/idpf/xdp.c b/drivers/net/ethernet/intel/idpf/xdp.c
index d7ba2848148e..d2549f8b8e24 100644
--- a/drivers/net/ethernet/intel/idpf/xdp.c
+++ b/drivers/net/ethernet/intel/idpf/xdp.c
@@ -320,8 +320,26 @@ LIBETH_XDP_DEFINE_START();
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
@@ -376,6 +394,8 @@ static int idpf_xdp_setup_prog(struct idpf_vport *vport,
 	if (old)
 		bpf_prog_put(old);
 
+	libeth_xdp_set_redirect(vport->netdev, vport->xdp_prog);
+
 	return ret;
 }
 
-- 
2.49.0


