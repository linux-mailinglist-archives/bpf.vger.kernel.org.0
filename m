Return-Path: <bpf+bounces-58608-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 699EAABE553
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 23:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA5994C6FC5
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 21:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91A725F96D;
	Tue, 20 May 2025 20:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cJUlAVU0"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B468F25E477;
	Tue, 20 May 2025 20:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747774778; cv=none; b=fj7KUt+rdClQx/qP+IxFjxwAUOKqhTOzVtE1yq6VwpHkRGxkQ7zWG+HxTvjo1YW/qfcFxlK0cvjDFWh2g5aXuLUJN0D02v3Aw1HEBV/9y4GjO+OMTLjT4jBs8zu/qrW8Zl8+MgORHyLzJH9grqc4Oi2oJf7lJ/hioL3KtM8LJyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747774778; c=relaxed/simple;
	bh=mglvQdHTjzAy5WkrsoOWPhHcAUaoYPAbZsY3CZyjfTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i+m4fn77jj9b0y8NO2H4ZVEv9jIYt0Fu62JjcAJ+BpV10/j2n7FIMg8s039fwSpOizPAuckje4wCHgVm/TvFj8YjDu+E/P+UAMYBjvadhr2qSwfl4Tf+1Qw9KxZJZM55C0FmTL8cc+uwghsy8JXTHM7van+Fo44Y5QL1EXtFWs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cJUlAVU0; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747774776; x=1779310776;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mglvQdHTjzAy5WkrsoOWPhHcAUaoYPAbZsY3CZyjfTU=;
  b=cJUlAVU0CJ6KQvUeeyLbclCk8Ui2poI6kComx62hb1ncBfsh1Sn4+AGA
   DdukOwej1Ro0qyqgrBVc2ag22Mk8EXodeVoMbRr5JjN2T7AnqdsMl1xUm
   x29f+Smoj00Zg3Q3knFKlYi+4sZHamu4K6rmT2tPZihB3P2Qi3fYHV9xH
   1D5BV2FgTCDIWIHiNEBOIms8FvISsP8k4spCUjDPoTH7eCrfk58cDlJAk
   M42HyVspFFRQjysqthiv7Z7aHkR+WzjpLeeqzeLEnu++HbiN80GtgAgxc
   OG1RJbwwJcc0wLnBNHn5meS8jzB4o0iRNsvJv1rILU0+5dVMtmCh/xlhk
   Q==;
X-CSE-ConnectionGUID: 9hvaTUKxQK+9Y/IxOSIRDA==
X-CSE-MsgGUID: O8ndNbszQrC9vdolKCGa5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="67142730"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="67142730"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 13:59:34 -0700
X-CSE-ConnectionGUID: YbEHiMLbT/WbbsdNhXHvMA==
X-CSE-MsgGUID: LbPZWr4WQwm9d3Sq6PybpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="139850893"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa007.fm.intel.com with ESMTP; 20 May 2025 13:59:34 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	anthony.l.nguyen@intel.com,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	michal.kubiak@intel.com,
	przemyslaw.kitszel@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	horms@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net-next 07/16] libeth: xdp: add XDPSQ cleanup timers
Date: Tue, 20 May 2025 13:59:08 -0700
Message-ID: <20250520205920.2134829-8-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250520205920.2134829-1-anthony.l.nguyen@intel.com>
References: <20250520205920.2134829-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Lobakin <aleksander.lobakin@intel.com>

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
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/libeth/xdp.c | 23 ++++++++++
 include/net/libeth/types.h              | 21 ++++++++-
 include/net/libeth/xdp.h                | 57 +++++++++++++++++++++++++
 3 files changed, 100 insertions(+), 1 deletion(-)

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
-- 
2.47.1


