Return-Path: <bpf+bounces-55983-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 907FCA8A58A
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 19:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 953024434A2
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 17:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FBD2309AF;
	Tue, 15 Apr 2025 17:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gQqDO65C"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6D3221552;
	Tue, 15 Apr 2025 17:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744738172; cv=none; b=Ad5bVSrOg4wBX80on35Mebpi/IS3+/rKpigZcc1FKCzgUldCXMDkt3RJhgfAOdy/k47wu4pVHhEUqsV6buEmhLE9EVmXkWfQEuoqYTxRNQamfxTaFgC1dRNLcogH1WyCIcZQfUqD6V6fCn26yPx0YBAcjj4Cxhrl2J/2IDWfUVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744738172; c=relaxed/simple;
	bh=pX0JSn/zMAX5UcgOnlJbrKknoIMx4EDvUg8VXC/h7h8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WIBeCYABWwhHmlzDf45NnvBHqPirROxcb/iMESD1XYtiEaIb/2Bh9U9u3GLTcYkBRguh9XpQBgoQsNRgHI9YNU1bLv27hWaQJIheWZytKh+4vCV8N5a5Q5oZH+4Htq3DtOr2cugK9yhk+2wT62dgLNu5GrTWFEZbC/DvnvNjuIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gQqDO65C; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744738171; x=1776274171;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pX0JSn/zMAX5UcgOnlJbrKknoIMx4EDvUg8VXC/h7h8=;
  b=gQqDO65Cr1d+c46NouNI6+HQbQIgPRUccRvkBb/pHCExfH74hy8xnhxZ
   EqlPZkdEnZBG4G8uX0J6F6yTXCzcc4y4KVNPGees+jh1QGvsOJyl9Ycvx
   8YuJNMxG+Yh0jrvl23l+3j/M7OdwsSqUVpLJ7vYPRz0d2Ef5z69VKdnZO
   JXS/jkM2K7rjH5VReFAEWyokhWuIX+j0tUcvQDBXIUU7LVcoQTY/FXWUy
   Es2ij77rtuG1bBRzL4n7zIOO37I2rxeE/HuV5imy1QGtjzK6A2dqp6ept
   uK7Nmvu9uUggVwk7FdJhlcpDSgWXdZAZEBir6DeOo9/uJ6NLPT7Q4zwgl
   Q==;
X-CSE-ConnectionGUID: 63xH1cquT0K8wX1IyAirHg==
X-CSE-MsgGUID: UTGltXtrSYiC5eYb/IUUgA==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="46275700"
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="46275700"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 10:29:23 -0700
X-CSE-ConnectionGUID: PYBh1ZCGTU2zmhbSXP+jXA==
X-CSE-MsgGUID: HPpz6voRQJS6rGy8NeyGIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="130729718"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa010.fm.intel.com with ESMTP; 15 Apr 2025 10:29:19 -0700
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
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-next 07/16] libeth: xdp: add XDPSQ cleanup timers
Date: Tue, 15 Apr 2025 19:28:16 +0200
Message-ID: <20250415172825.3731091-8-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250415172825.3731091-1-aleksander.lobakin@intel.com>
References: <20250415172825.3731091-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When XDP Tx queues are not interrupt-driven but use lazy cleaning,
i.e. only when there are less than `threshold` free descriptors left,
we also need cleanup timers to avoid &xdp_buff and &xdp_frame stall
for too long, especially with Page Pool (it warns every about inflight
pages every 60 second).
Let's say we sent 256 frames and don't need to send more, but we clean
only when the number of pending items >= 384. In that case, those 256
will stall until 128 more are sent. For this, add simple helpers to
run a timer which will clean the queue regardless, after 1 second of
the last send.
The timer is triggered when finalizing the queue. As long as there is
regular active traffic, the timer doesn't fire.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/net/libeth/types.h              | 21 ++++++++-
 include/net/libeth/xdp.h                | 57 +++++++++++++++++++++++++
 drivers/net/ethernet/intel/libeth/xdp.c | 23 ++++++++++
 3 files changed, 100 insertions(+), 1 deletion(-)

diff --git a/include/net/libeth/types.h b/include/net/libeth/types.h
index abfccae1a346..4df703a9eb59 100644
--- a/include/net/libeth/types.h
+++ b/include/net/libeth/types.h
@@ -4,7 +4,7 @@
 #ifndef __LIBETH_TYPES_H
 #define __LIBETH_TYPES_H
 
-#include <linux/spinlock.h>
+#include <linux/workqueue.h>
 
 /**
  * struct libeth_sq_napi_stats - "hot" counters to update in Tx completion loop
@@ -60,4 +60,23 @@ struct libeth_xdpsq_lock {
 	bool				share;
 };
 
+/* XDPSQ clean-up timers */
+
+/**
+ * struct libeth_xdpsq_timer - timer for cleaning up XDPSQs w/o interrupts
+ * @xdpsq: queue this timer belongs to
+ * @lock: lock for the queue
+ * @dwork: work performing cleanups
+ *
+ * XDPSQs not using interrupts but lazy cleaning, i.e. only when there's no
+ * space for sending the current queued frame/bulk, must fire up timers to
+ * make sure there are no stale buffers to free.
+ */
+struct libeth_xdpsq_timer {
+	void				*xdpsq;
+	struct libeth_xdpsq_lock	*lock;
+
+	struct delayed_work		dwork;
+};
+
 #endif /* __LIBETH_TYPES_H */
diff --git a/include/net/libeth/xdp.h b/include/net/libeth/xdp.h
index 47ec5c59a586..54cf1e7cc1fc 100644
--- a/include/net/libeth/xdp.h
+++ b/include/net/libeth/xdp.h
@@ -177,6 +177,63 @@ static inline void libeth_xdpsq_unlock(struct libeth_xdpsq_lock *lock)
 		__libeth_xdpsq_unlock(lock);
 }
 
+/* XDPSQ clean-up timers */
+
+void libeth_xdpsq_init_timer(struct libeth_xdpsq_timer *timer, void *xdpsq,
+			     struct libeth_xdpsq_lock *lock,
+			     void (*poll)(struct work_struct *work));
+
+/**
+ * libeth_xdpsq_deinit_timer - deinitialize &libeth_xdpsq_timer
+ * @timer: timer to deinitialize
+ *
+ * Flush and disable the underlying workqueue.
+ */
+static inline void libeth_xdpsq_deinit_timer(struct libeth_xdpsq_timer *timer)
+{
+	cancel_delayed_work_sync(&timer->dwork);
+}
+
+/**
+ * libeth_xdpsq_queue_timer - run &libeth_xdpsq_timer
+ * @timer: timer to queue
+ *
+ * Should be called after the queue was filled and the transmission was run
+ * to complete the pending buffers if no further sending will be done in a
+ * second (-> lazy cleaning won't happen).
+ * If the timer was already run, it will be requeued back to one second
+ * timeout again.
+ */
+static inline void libeth_xdpsq_queue_timer(struct libeth_xdpsq_timer *timer)
+{
+	mod_delayed_work_on(raw_smp_processor_id(), system_bh_highpri_wq,
+			    &timer->dwork, HZ);
+}
+
+/**
+ * libeth_xdpsq_run_timer - wrapper to run a queue clean-up on a timer event
+ * @work: workqueue belonging to the corresponding timer
+ * @poll: driver-specific completion queue poll function
+ *
+ * Run the polling function on the locked queue and requeue the timer if
+ * there's more work to do.
+ * Designed to be used via LIBETH_XDP_DEFINE_TIMER() below.
+ */
+static __always_inline void
+libeth_xdpsq_run_timer(struct work_struct *work,
+		       u32 (*poll)(void *xdpsq, u32 budget))
+{
+	struct libeth_xdpsq_timer *timer = container_of(work, typeof(*timer),
+							dwork.work);
+
+	libeth_xdpsq_lock(timer->lock);
+
+	if (poll(timer->xdpsq, U32_MAX))
+		libeth_xdpsq_queue_timer(timer);
+
+	libeth_xdpsq_unlock(timer->lock);
+}
+
 /* Common Tx bits */
 
 /**
diff --git a/drivers/net/ethernet/intel/libeth/xdp.c b/drivers/net/ethernet/intel/libeth/xdp.c
index 0c0aa3b1d49d..25be680de627 100644
--- a/drivers/net/ethernet/intel/libeth/xdp.c
+++ b/drivers/net/ethernet/intel/libeth/xdp.c
@@ -54,6 +54,29 @@ __libeth_xdpsq_unlock(struct libeth_xdpsq_lock *lock)
 }
 EXPORT_SYMBOL_GPL(__libeth_xdpsq_unlock);
 
+/* XDPSQ clean-up timers */
+
+/**
+ * libeth_xdpsq_init_timer - initialize an XDPSQ clean-up timer
+ * @timer: timer to initialize
+ * @xdpsq: queue this timer belongs to
+ * @lock: corresponding XDPSQ lock
+ * @poll: queue polling/completion function
+ *
+ * XDPSQ clean-up timers must be set up before using at the queue configuration
+ * time. Set the required pointers and the cleaning callback.
+ */
+void libeth_xdpsq_init_timer(struct libeth_xdpsq_timer *timer, void *xdpsq,
+			     struct libeth_xdpsq_lock *lock,
+			     void (*poll)(struct work_struct *work))
+{
+	timer->xdpsq = xdpsq;
+	timer->lock = lock;
+
+	INIT_DELAYED_WORK(&timer->dwork, poll);
+}
+EXPORT_SYMBOL_GPL(libeth_xdpsq_init_timer);
+
 /* ``XDP_TX`` bulking */
 
 static void __cold
-- 
2.49.0


