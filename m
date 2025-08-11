Return-Path: <bpf+bounces-65360-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3FFB211EE
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 18:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E32AE626B24
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 16:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA662E6138;
	Mon, 11 Aug 2025 16:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kzNRIYUb"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA472E54B5;
	Mon, 11 Aug 2025 16:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754928819; cv=none; b=AwwZzMW5/ifu8Y0wy0bCWwBRDmG5KazwSYL/bpk4biO4lwicJB+XBblnLslxLHWbV4PphgV7qjdE01bHAYt3BYYxrIRkb6W66RTxDA9TdNzJh1Qi9AYPJn2oQrukLKFlCutjkBtaDocgxoKArtr1jfjNRG9spxbsBFQD8bxbSfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754928819; c=relaxed/simple;
	bh=W8iajtxQR5EvXVvoBEguC35xUz0udGCfNW9PJAuo4MQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SpXDk0cgOPfHQrIXFG5ok6rZfLrtqy8H6nwppAmxMfioOE8OK44IDl3eEcKibi2yiGuIi3xkiqwfjN0A4wSYL+UlZYuKAK8BAlGKqctqzOHrADoCmysB37v3wXxulDn6Iu7ldnqfRjaLq1ON5Z6qA/NbmzzSd+kDbnPJ/YPANKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kzNRIYUb; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754928817; x=1786464817;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W8iajtxQR5EvXVvoBEguC35xUz0udGCfNW9PJAuo4MQ=;
  b=kzNRIYUbYjvYgohLw9QMO6kNVwgaOfA2PnqcX8WveswMIzMZqhER8cLt
   Fjgo+345feJKoBd1rXJD6ECK9eWSBDUHW1WcgXFY//Qw0eZUefTDdZX+Y
   gAHx6WYODOGKulP7vAZSMHOSiRhwURG6MHxUilyP0g09Hn/BKlxBZmGxH
   aZU3+WqoJUXFP5qANsCxxofzKtpMfkN3mkXsUkmmWivpRWVOEsMIQRo2x
   9EEkj67wSKSxS9jFbn7FUp0l2mhhavAOnz/9iuT/NxRsCsLq+WdhHV6yk
   dTlrXRJ2ijsmF+AxiqfEb3YyM2TM05pGaNE9AzB6P5R90HKMRgld8bG5x
   w==;
X-CSE-ConnectionGUID: fr1pbcH8SJi03LURRZhGdQ==
X-CSE-MsgGUID: J+E0cEqbTHqIbqSvClETEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="56899722"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="56899722"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 09:13:37 -0700
X-CSE-ConnectionGUID: NHqslrRbR6uQVT53x8sBCg==
X-CSE-MsgGUID: OiXv2TsPTwGHRWkpDfHwUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="165163249"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa006.jf.intel.com with ESMTP; 11 Aug 2025 09:13:33 -0700
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
Subject: [PATCH iwl-next v4 12/13] idpf: add support for .ndo_xdp_xmit()
Date: Mon, 11 Aug 2025 18:10:43 +0200
Message-ID: <20250811161044.32329-13-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250811161044.32329-1-aleksander.lobakin@intel.com>
References: <20250811161044.32329-1-aleksander.lobakin@intel.com>
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
index 371fd40356c4..d41ffcefe544 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -2522,4 +2522,5 @@ static const struct net_device_ops idpf_netdev_ops = {
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
2.50.1


