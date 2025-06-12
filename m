Return-Path: <bpf+bounces-60494-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B63F1AD77E4
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 18:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25CF83B8659
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 16:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3BE2C325E;
	Thu, 12 Jun 2025 16:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JX17fcYy"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15DA29AB11;
	Thu, 12 Jun 2025 16:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749744601; cv=none; b=eTy9WjEI9UFusfFtDGWUc5jzwX8hW4m9cQdgVGTXdOYL3Rn+TxLSFiQMlnY9qEC61b4/ol5bWOUfotrY6+Yahqfkv7owUPuwslDj4VpJ8XASCRTSG262WlU2AdUtt/5swKbxz6Il5Pq2ylGisgqNI/jtq27WKjrugBAq1QjQyfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749744601; c=relaxed/simple;
	bh=6KiEzhdt9qasEqWInaIPgm1eHgdTWdoeWqK3mLPdjec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ES3h20f3H+O2DzXywapuyvgBTYTHgyNtxMga0amAqnl6jcP5WTIfVReReGyqoeRUVtxZcnGrhyDcApjHOVvndPnc/kcq7Vl9ZQccgfz6UHEup0vSsMbx2HlAQbNpt5mjZ8VQF0J1seC5cR5Bh9GRijHgISXrkxHrFgJapVTp5rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JX17fcYy; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749744600; x=1781280600;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6KiEzhdt9qasEqWInaIPgm1eHgdTWdoeWqK3mLPdjec=;
  b=JX17fcYyTgB2xgtYq0HJKQZfiMVaqwglNnji71b727fvUj0xdeDbLJ4p
   ZjHi5vzZeTDmh3QX975GbF+5xu8LERlqcoy2skm69vWZqS+M8KhIudveD
   5veP8Ziy6YQzXtY+GAciqKVE5ca7oCVXXjrGAPkAEXUvKT0euZqAY+05i
   3fsnRG9nmpUZJXij4g81V+o8AlfXSNHgP45IRpCM9yG9dPRCVL2rK3m+h
   hhRVY77YuVUKqbj8PXReirbhUHB6R/H8i/qbESYX1H1qqY+tgq/jK9fwS
   pL/18l8t1M5sm0Ec1lLu0SZ0VcVmCYs86tQWNqBYb8AslQSC1aqE5HQz7
   Q==;
X-CSE-ConnectionGUID: sdISGrHmTxS6E87ukElR6g==
X-CSE-MsgGUID: NG8zwkFYTI2p3z2butw0oA==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="55738940"
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; 
   d="scan'208";a="55738940"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 09:10:00 -0700
X-CSE-ConnectionGUID: w34fusxoQhqLvvX8hxOu9A==
X-CSE-MsgGUID: hcycLqAJTSmlfyQHYXpKZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; 
   d="scan'208";a="148468577"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa008.jf.intel.com with ESMTP; 12 Jun 2025 09:09:55 -0700
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
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-next v2 07/17] libeth: xdp: add XDPSQ locking helpers
Date: Thu, 12 Jun 2025 18:02:24 +0200
Message-ID: <20250612160234.68682-8-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250612160234.68682-1-aleksander.lobakin@intel.com>
References: <20250612160234.68682-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unfortunately, it's not always possible to allocate
max(num_rxqs, nr_cpu_ids) even on hi-end NICs.
To mitigate this, add simple locking helpers to libeth_xdp.
As long as XDPSQs are not shared, the whole functionality is gated
behind a static lock. Otherwise, each bulk flush locks the queue for
the time of cleaning and filling the descriptors.
As long as this particular queue is not used by more than 1 CPU,
the impact is minimal (runtime check for boolean twice per 16+
descriptors).

Suggested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com> # static key
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/net/libeth/types.h              |  21 +++-
 include/net/libeth/xdp.h                | 127 +++++++++++++++++++++++-
 drivers/net/ethernet/intel/libeth/xdp.c |  47 +++++++++
 3 files changed, 192 insertions(+), 3 deletions(-)

diff --git a/include/net/libeth/types.h b/include/net/libeth/types.h
index ad7a5c1f119f..abfccae1a346 100644
--- a/include/net/libeth/types.h
+++ b/include/net/libeth/types.h
@@ -4,7 +4,7 @@
 #ifndef __LIBETH_TYPES_H
 #define __LIBETH_TYPES_H
 
-#include <linux/types.h>
+#include <linux/spinlock.h>
 
 /**
  * struct libeth_sq_napi_stats - "hot" counters to update in Tx completion loop
@@ -41,4 +41,23 @@ struct libeth_xdpsq_napi_stats {
 	};
 };
 
+/* XDP */
+
+/*
+ * The following structures should be embedded into driver's queue structure
+ * and passed to the libeth_xdp helpers, never used directly.
+ */
+
+/* XDPSQ sharing */
+
+/**
+ * struct libeth_xdpsq_lock - locking primitive for sharing XDPSQs
+ * @lock: spinlock for locking the queue
+ * @share: whether this particular queue is shared
+ */
+struct libeth_xdpsq_lock {
+	spinlock_t			lock;
+	bool				share;
+};
+
 #endif /* __LIBETH_TYPES_H */
diff --git a/include/net/libeth/xdp.h b/include/net/libeth/xdp.h
index c47ecba56020..20977fdfd6c9 100644
--- a/include/net/libeth/xdp.h
+++ b/include/net/libeth/xdp.h
@@ -60,6 +60,123 @@ static_assert(offsetof(struct libeth_xdp_buff, desc) ==
 static_assert(IS_ALIGNED(sizeof(struct xdp_buff_xsk),
 			 __alignof(struct libeth_xdp_buff)));
 
+/* XDPSQ sharing */
+
+DECLARE_STATIC_KEY_FALSE(libeth_xdpsq_share);
+
+/**
+ * libeth_xdpsq_num - calculate optimal number of XDPSQs for this device + sys
+ * @rxq: current number of active Rx queues
+ * @txq: current number of active Tx queues
+ * @max: maximum number of Tx queues
+ *
+ * Each RQ must have its own XDPSQ for XSk pairs, each CPU must have own XDPSQ
+ * for lockless sending (``XDP_TX``, .ndo_xdp_xmit()). Cap the maximum of these
+ * two with the number of SQs the device can have (minus used ones).
+ *
+ * Return: number of XDP Tx queues the device needs to use.
+ */
+static inline u32 libeth_xdpsq_num(u32 rxq, u32 txq, u32 max)
+{
+	return min(max(nr_cpu_ids, rxq), max - txq);
+}
+
+/**
+ * libeth_xdpsq_shared - whether XDPSQs can be shared between several CPUs
+ * @num: number of active XDPSQs
+ *
+ * Return: true if there's no 1:1 XDPSQ/CPU association, false otherwise.
+ */
+static inline bool libeth_xdpsq_shared(u32 num)
+{
+	return num < nr_cpu_ids;
+}
+
+/**
+ * libeth_xdpsq_id - get XDPSQ index corresponding to this CPU
+ * @num: number of active XDPSQs
+ *
+ * Helper for libeth_xdp routines, do not use in drivers directly.
+ *
+ * Return: XDPSQ index needs to be used on this CPU.
+ */
+static inline u32 libeth_xdpsq_id(u32 num)
+{
+	u32 ret = raw_smp_processor_id();
+
+	if (static_branch_unlikely(&libeth_xdpsq_share) &&
+	    libeth_xdpsq_shared(num))
+		ret %= num;
+
+	return ret;
+}
+
+void __libeth_xdpsq_get(struct libeth_xdpsq_lock *lock,
+			const struct net_device *dev);
+void __libeth_xdpsq_put(struct libeth_xdpsq_lock *lock,
+			const struct net_device *dev);
+
+/**
+ * libeth_xdpsq_get - initialize &libeth_xdpsq_lock
+ * @lock: lock to initialize
+ * @dev: netdev which this lock belongs to
+ * @share: whether XDPSQs can be shared
+ *
+ * Tracks the current XDPSQ association and enables the static lock
+ * if needed.
+ */
+static inline void libeth_xdpsq_get(struct libeth_xdpsq_lock *lock,
+				    const struct net_device *dev,
+				    bool share)
+{
+	if (unlikely(share))
+		__libeth_xdpsq_get(lock, dev);
+}
+
+/**
+ * libeth_xdpsq_put - deinitialize &libeth_xdpsq_lock
+ * @lock: lock to deinitialize
+ * @dev: netdev which this lock belongs to
+ *
+ * Tracks the current XDPSQ association and disables the static lock
+ * if needed.
+ */
+static inline void libeth_xdpsq_put(struct libeth_xdpsq_lock *lock,
+				    const struct net_device *dev)
+{
+	if (static_branch_unlikely(&libeth_xdpsq_share) && lock->share)
+		__libeth_xdpsq_put(lock, dev);
+}
+
+void __libeth_xdpsq_lock(struct libeth_xdpsq_lock *lock);
+void __libeth_xdpsq_unlock(struct libeth_xdpsq_lock *lock);
+
+/**
+ * libeth_xdpsq_lock - grab &libeth_xdpsq_lock if needed
+ * @lock: lock to take
+ *
+ * Touches the underlying spinlock only if the static key is enabled
+ * and the queue itself is marked as shareable.
+ */
+static inline void libeth_xdpsq_lock(struct libeth_xdpsq_lock *lock)
+{
+	if (static_branch_unlikely(&libeth_xdpsq_share) && lock->share)
+		__libeth_xdpsq_lock(lock);
+}
+
+/**
+ * libeth_xdpsq_unlock - free &libeth_xdpsq_lock if needed
+ * @lock: lock to free
+ *
+ * Touches the underlying spinlock only if the static key is enabled
+ * and the queue itself is marked as shareable.
+ */
+static inline void libeth_xdpsq_unlock(struct libeth_xdpsq_lock *lock)
+{
+	if (static_branch_unlikely(&libeth_xdpsq_share) && lock->share)
+		__libeth_xdpsq_unlock(lock);
+}
+
 /* Common Tx bits */
 
 /**
@@ -179,6 +296,7 @@ struct libeth_xdp_tx_bulk {
  * @count: number of descriptors on that queue
  * @pending: pointer to the number of sent-not-completed descs on that queue
  * @xdp_tx: pointer to the above
+ * @lock: corresponding XDPSQ lock
  *
  * Abstraction for driver-independent implementation of Tx. Placed on the stack
  * and filled by the driver before the transmission, so that the generic
@@ -193,6 +311,7 @@ struct libeth_xdpsq {
 
 	u32				*pending;
 	u32				*xdp_tx;
+	struct libeth_xdpsq_lock	*lock;
 };
 
 /**
@@ -229,7 +348,8 @@ struct libeth_xdp_tx_desc {
  *
  * Internal abstraction for placing @n XDP Tx frames on the HW XDPSQ. Used for
  * all types of frames.
- * @unroll greatly increases the object code size, but also greatly increases
+ * @prep must lock the queue as this function releases it at the end. @unroll
+ * greatly increases the object code size, but also greatly increases
  * performance.
  * The compilers inline all those onstack abstractions to direct data accesses.
  *
@@ -253,7 +373,7 @@ libeth_xdp_tx_xmit_bulk(const struct libeth_xdp_tx_frame *bulk, void *xdpsq,
 
 	n = min(n, prep(xdpsq, &sq));
 	if (unlikely(!n))
-		return 0;
+		goto unlock;
 
 	ntu = *sq.ntu;
 
@@ -302,6 +422,9 @@ libeth_xdp_tx_xmit_bulk(const struct libeth_xdp_tx_frame *bulk, void *xdpsq,
 	if (sq.xdp_tx)
 		*sq.xdp_tx += n;
 
+unlock:
+	libeth_xdpsq_unlock(sq.lock);
+
 	return n;
 }
 
diff --git a/drivers/net/ethernet/intel/libeth/xdp.c b/drivers/net/ethernet/intel/libeth/xdp.c
index c29a1a0dfc57..0f08dd405190 100644
--- a/drivers/net/ethernet/intel/libeth/xdp.c
+++ b/drivers/net/ethernet/intel/libeth/xdp.c
@@ -9,6 +9,53 @@
 
 #include "priv.h"
 
+/* XDPSQ sharing */
+
+DEFINE_STATIC_KEY_FALSE(libeth_xdpsq_share);
+EXPORT_SYMBOL_GPL(libeth_xdpsq_share);
+
+void __libeth_xdpsq_get(struct libeth_xdpsq_lock *lock,
+			const struct net_device *dev)
+{
+	bool warn;
+
+	spin_lock_init(&lock->lock);
+	lock->share = true;
+
+	warn = !static_key_enabled(&libeth_xdpsq_share);
+	static_branch_inc(&libeth_xdpsq_share);
+
+	if (warn && net_ratelimit())
+		netdev_warn(dev, "XDPSQ sharing enabled, possible XDP Tx slowdown\n");
+}
+EXPORT_SYMBOL_GPL(__libeth_xdpsq_get);
+
+void __libeth_xdpsq_put(struct libeth_xdpsq_lock *lock,
+			const struct net_device *dev)
+{
+	static_branch_dec(&libeth_xdpsq_share);
+
+	if (!static_key_enabled(&libeth_xdpsq_share) && net_ratelimit())
+		netdev_notice(dev, "XDPSQ sharing disabled\n");
+
+	lock->share = false;
+}
+EXPORT_SYMBOL_GPL(__libeth_xdpsq_put);
+
+void __acquires(&lock->lock)
+__libeth_xdpsq_lock(struct libeth_xdpsq_lock *lock)
+{
+	spin_lock(&lock->lock);
+}
+EXPORT_SYMBOL_GPL(__libeth_xdpsq_lock);
+
+void __releases(&lock->lock)
+__libeth_xdpsq_unlock(struct libeth_xdpsq_lock *lock)
+{
+	spin_unlock(&lock->lock);
+}
+EXPORT_SYMBOL_GPL(__libeth_xdpsq_unlock);
+
 /* ``XDP_TX`` bulking */
 
 static void __cold
-- 
2.49.0


