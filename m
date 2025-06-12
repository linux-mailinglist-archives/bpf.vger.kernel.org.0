Return-Path: <bpf+bounces-60495-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD315AD77CE
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 18:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEC0F1899ED3
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 16:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704432C327F;
	Thu, 12 Jun 2025 16:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gBk6QJzY"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FA429ACF0;
	Thu, 12 Jun 2025 16:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749744606; cv=none; b=n0YQdQdfJfNAW3zopywd+jDcPwvTpNCs9uqR/Kia4Z+s9OKX5eZ++UBD4lZaARoTazfgKFn2k8hVwvVjXJtXuZa0K8J0IqyQo8tQ5QBx7Y9iBRDh2IuFntusSWh6xpHYSpyaRiNB85/LDAFdq7X9Ql1DDWVICVyLgRaks3MhyJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749744606; c=relaxed/simple;
	bh=v1+nkxODlsKIr/NMccOdNVICiXIi9HZzBieMNXo1diQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pX2KbqMFHAgMhM0VwDHyE9RskqA5WEUrDlRtixMTJbIIRn1rTrLBmsolBWhjysD9fUXraPwR7Srr8OK/nINnM3HiaVdvsEmSCx1Rn+VOyV/hmXDZFFtIA5oBOQBgEc1N9mkLIXPe37vdWA44l5/HMCF0lP+YrypXIreQgyKwz6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gBk6QJzY; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749744605; x=1781280605;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v1+nkxODlsKIr/NMccOdNVICiXIi9HZzBieMNXo1diQ=;
  b=gBk6QJzY08OcMk9QJeqhKciqxTP1NQ5QhsTcYfqp0QgGfWF5ymUvF0r/
   8OqGXkT8AUFVou+9UGnWwCya7OH7bkev8jeRX/ogFVfTbEbpoiBa/Hj12
   5epiEXlvG7yFwHV94xdJbno3eMIGtaM/egXz6dA5q6Y/YoKka/LbwLE5V
   F6pZw8egnAGBqvAWX1BlUuiKSi5n7MITTL4NFJ/w882vmZVFe9XtDBGXy
   PB9okDBvWwOIM73mFd5dNhK153UKbTqHJw3VlwQJU5VcrB30lHlqKH7B0
   5wetIz65/2mHft+l9A7tvOGn/LK/zK3q72TyN+U5zNt02JSJt0buC+0/E
   w==;
X-CSE-ConnectionGUID: aiRRGUyzT++pcQnZqoEvqA==
X-CSE-MsgGUID: MkRIWRk6SimDbkylYA8C0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="55738961"
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; 
   d="scan'208";a="55738961"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 09:10:04 -0700
X-CSE-ConnectionGUID: 9ol9yc4lQG+ORUoxU94H9g==
X-CSE-MsgGUID: e0+72EwMSNmSzuoU3tcmig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; 
   d="scan'208";a="148468585"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa008.jf.intel.com with ESMTP; 12 Jun 2025 09:10:00 -0700
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
Subject: [PATCH iwl-next v2 08/17] libeth: xdp: add XDPSQ cleanup timers
Date: Thu, 12 Jun 2025 18:02:25 +0200
Message-ID: <20250612160234.68682-9-aleksander.lobakin@intel.com>
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
index 20977fdfd6c9..22bd038decb6 100644
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
index 0f08dd405190..6f62603cf568 100644
--- a/drivers/net/ethernet/intel/libeth/xdp.c
+++ b/drivers/net/ethernet/intel/libeth/xdp.c
@@ -56,6 +56,29 @@ __libeth_xdpsq_unlock(struct libeth_xdpsq_lock *lock)
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


