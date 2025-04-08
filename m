Return-Path: <bpf+bounces-55484-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9873A81636
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 22:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7857219E0C56
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 20:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC0B254AF6;
	Tue,  8 Apr 2025 20:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rXnlvhcn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65E2254840;
	Tue,  8 Apr 2025 20:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744142411; cv=none; b=ksesjlad1f3iPSZLk/HtiRbrF9xRFIqDGjdi8qgeIKB5D8GZD/xkCH2J3AOKv7J5MUrHrHgfh8puLYisqqL50vuwPZIMcxO+jTX0TGaK8Veg2xab2ftaLhDctZg9BTUNsCSdh2Av6bzlM4Sfb+nkZAUTAvCo3yniSvihIAj3M0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744142411; c=relaxed/simple;
	bh=DxJbKtG/Yz4PpeU3tbXajF1XYBa8WDoJkNgKlsLBPfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A4XumG7mduiUlec01+UOk8DZ221EfdgPUAAiXNe3S00A9kfVcf1MAsWKEq8VZ4ft7BxytFosKxn9bRk1qVCmJgRDfWgiO+Hj8UpIQUYHC9OsXEHeC0gLsbO9g+YXeGYr6Krf4oEu/1QKqt0BpShgo54U36FiJtO4m2g7vb0gDNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rXnlvhcn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 991CAC4CEEC;
	Tue,  8 Apr 2025 20:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744142410;
	bh=DxJbKtG/Yz4PpeU3tbXajF1XYBa8WDoJkNgKlsLBPfs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rXnlvhcnmtm9IDbNuGhMpqYuf+9vPnMKXFtefxE/cumIm3uBYyYL21d3/ZK/MIl7Q
	 Kfct9jEsts0cy/GUfaWZPpYQh1iAwkQRfYy3LRSBSpcd6Sbj/2YRpse9PyPp3tW9ql
	 QiZzhWHW1XgnpZ9oVPfk0bYhjHrF9B21dkoWyIzWNzK+77/djHi4qAItlv2UnIo8SL
	 OAL8zTAGjDB3DhLC/xE+h8mwWsZ8awmOqlk1/T9zlTGnciTVBTlIViXrcx09gY/bCI
	 C7UAbfibb/Fi6jTkkvrhik9ZxivySAtaA2rV8Y0iJAi9dxR7A8SrcVD8hj+GXj7FTJ
	 WaGo1UgB+3/4g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	sdf@fomichev.me,
	hramamurthy@google.com,
	kuniyu@amazon.com,
	jdamato@fastly.com,
	Jakub Kicinski <kuba@kernel.org>,
	bpf@vger.kernel.org
Subject: [PATCH net-next v2 5/8] xdp: double protect netdev->xdp_flags with netdev->lock
Date: Tue,  8 Apr 2025 12:59:52 -0700
Message-ID: <20250408195956.412733-6-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408195956.412733-1-kuba@kernel.org>
References: <20250408195956.412733-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Protect xdp_features with netdev->lock. This way pure readers
no longer have to take rtnl_lock to access the field.

This includes calling NETDEV_XDP_FEAT_CHANGE under the lock.
Looks like that's fine for bonding, the only "real" listener,
it's the same as ethtool feature change.

In terms of normal drivers - only GVE need special consideration
(other drivers don't use instance lock or don't support XDP).
It calls xdp_set_features_flag() helper from gve_init_priv() which
in turn is called from gve_reset_recovery() (locked), or prior
to netdev registration. So switch to _locked.

Reviewed-by: Joe Damato <jdamato@fastly.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: bpf@vger.kernel.org
---
 Documentation/networking/netdevices.rst    |  1 +
 include/linux/netdevice.h                  |  2 +-
 include/net/xdp.h                          |  1 +
 drivers/net/ethernet/google/gve/gve_main.c |  2 +-
 net/core/lock_debug.c                      |  2 +-
 net/core/xdp.c                             | 12 +++++++++++-
 6 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/Documentation/networking/netdevices.rst b/Documentation/networking/netdevices.rst
index 6c2d8945f597..d6357472d3f1 100644
--- a/Documentation/networking/netdevices.rst
+++ b/Documentation/networking/netdevices.rst
@@ -354,6 +354,7 @@ For devices with locked ops, currently only the following notifiers are
 running under the lock:
 * ``NETDEV_REGISTER``
 * ``NETDEV_UP``
+* ``NETDEV_XDP_FEAT_CHANGE``
 
 The following notifiers are running without the lock:
 * ``NETDEV_UNREGISTER``
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 7242fb8a22fc..dece2ae396a1 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2526,7 +2526,7 @@ struct net_device {
 	 *	@net_shaper_hierarchy, @reg_state, @threaded
 	 *
 	 * Double protects:
-	 *	@up, @moving_ns, @nd_net
+	 *	@up, @moving_ns, @nd_net, @xdp_flags
 	 *
 	 * Double ops protects:
 	 *	@real_num_rx_queues, @real_num_tx_queues
diff --git a/include/net/xdp.h b/include/net/xdp.h
index 48efacbaa35d..20e41b5ff319 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -616,6 +616,7 @@ struct xdp_metadata_ops {
 u32 bpf_xdp_metadata_kfunc_id(int id);
 bool bpf_dev_bound_kfunc_id(u32 btf_id);
 void xdp_set_features_flag(struct net_device *dev, xdp_features_t val);
+void xdp_set_features_flag_locked(struct net_device *dev, xdp_features_t val);
 void xdp_features_set_redirect_target(struct net_device *dev, bool support_sg);
 void xdp_features_clear_redirect_target(struct net_device *dev);
 #else
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index f9a73c956861..7a249baee316 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -2185,7 +2185,7 @@ static void gve_set_netdev_xdp_features(struct gve_priv *priv)
 		xdp_features = 0;
 	}
 
-	xdp_set_features_flag(priv->dev, xdp_features);
+	xdp_set_features_flag_locked(priv->dev, xdp_features);
 }
 
 static int gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
diff --git a/net/core/lock_debug.c b/net/core/lock_debug.c
index b7f22dc92a6f..598c443ef2f3 100644
--- a/net/core/lock_debug.c
+++ b/net/core/lock_debug.c
@@ -20,6 +20,7 @@ int netdev_debug_event(struct notifier_block *nb, unsigned long event,
 	switch (cmd) {
 	case NETDEV_REGISTER:
 	case NETDEV_UP:
+	case NETDEV_XDP_FEAT_CHANGE:
 		netdev_ops_assert_locked(dev);
 		fallthrough;
 	case NETDEV_DOWN:
@@ -58,7 +59,6 @@ int netdev_debug_event(struct notifier_block *nb, unsigned long event,
 	case NETDEV_OFFLOAD_XSTATS_DISABLE:
 	case NETDEV_OFFLOAD_XSTATS_REPORT_USED:
 	case NETDEV_OFFLOAD_XSTATS_REPORT_DELTA:
-	case NETDEV_XDP_FEAT_CHANGE:
 		ASSERT_RTNL();
 		break;
 
diff --git a/net/core/xdp.c b/net/core/xdp.c
index f86eedad586a..3cd0db9c9d2d 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -17,6 +17,7 @@
 #include <net/page_pool/helpers.h>
 
 #include <net/hotdata.h>
+#include <net/netdev_lock.h>
 #include <net/xdp.h>
 #include <net/xdp_priv.h> /* struct xdp_mem_allocator */
 #include <trace/events/xdp.h>
@@ -991,17 +992,26 @@ static int __init xdp_metadata_init(void)
 }
 late_initcall(xdp_metadata_init);
 
-void xdp_set_features_flag(struct net_device *dev, xdp_features_t val)
+void xdp_set_features_flag_locked(struct net_device *dev, xdp_features_t val)
 {
 	val &= NETDEV_XDP_ACT_MASK;
 	if (dev->xdp_features == val)
 		return;
 
+	netdev_assert_locked_or_invisible(dev);
 	dev->xdp_features = val;
 
 	if (dev->reg_state == NETREG_REGISTERED)
 		call_netdevice_notifiers(NETDEV_XDP_FEAT_CHANGE, dev);
 }
+EXPORT_SYMBOL_GPL(xdp_set_features_flag_locked);
+
+void xdp_set_features_flag(struct net_device *dev, xdp_features_t val)
+{
+	netdev_lock(dev);
+	xdp_set_features_flag_locked(dev, val);
+	netdev_unlock(dev);
+}
 EXPORT_SYMBOL_GPL(xdp_set_features_flag);
 
 void xdp_features_set_redirect_target(struct net_device *dev, bool support_sg)
-- 
2.49.0


