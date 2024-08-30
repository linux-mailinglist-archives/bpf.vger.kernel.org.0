Return-Path: <bpf+bounces-38571-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF729666C6
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 18:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F3AB1F22C08
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 16:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886B91BAEEF;
	Fri, 30 Aug 2024 16:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NMt1ypIX"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773381BAECD;
	Fri, 30 Aug 2024 16:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725035151; cv=none; b=B/cIxCGdwxAOwPedvFYDYLkrUrCSJeXoFMlqNeaMYit51RBTrDCx2erUlWubujCpQGsoQ7xemIUXIvwoSL4LE/ZjQmusChTsNP2ugUiWoRvYgpbZl8bFGV73oMDW+o1Fi+K2iarYhGzQiWuYbzwnNWktYmZb1GUD9wO5yWpVguM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725035151; c=relaxed/simple;
	bh=Jkw9xcvH47v01BMyofQZ1se88nDV8RAlcX4vSYpST48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B90+SYFM5o1iyLH7vLiq5LLEBLN9MY/qB5pwmA3TV7oxALrDPoTgAxIKik5zpemJYL7AgB83/X0cBSsmLuFodmxH5Vs/Q/n1FK3odsDtnA9vlbI7NrQRPXaRHmlxyx+c7n/yauR29OhH9n47xWs0gor1nGXRhJ862rxr35HL1QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NMt1ypIX; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725035150; x=1756571150;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Jkw9xcvH47v01BMyofQZ1se88nDV8RAlcX4vSYpST48=;
  b=NMt1ypIX10OfZOU9RYfZGpcjqHidjWQJ0+D7MU4MV8kAX6mneqybn6dn
   +XsVhx0UJUrFeMHGXbZKGW7X0PET1WNcIAylbpSIPsLK1STD2J0ZIM94S
   RWPMRUpQqN6FtKlC0WXQ7VNsPdH9I+lywoLywI/6Uc96NbMWYGZLf+ehR
   w4no4etwvsLyJmxMO7MQs5YgBVwag6eLsK7c8TlM9Fil1X81PRehDG3ZY
   31tNJ8gCh7dQwUZq/IDZpHMXsstE8At4WB5hIjRCEzNe6EGjkDbddcajW
   ztDo72tUVHS33BnDvGVdoGhpXecCKz1fpa0oNAvwLjwLidKBuVhE0A2Cg
   w==;
X-CSE-ConnectionGUID: W15WPPxNQH+v4Gcksaq0vQ==
X-CSE-MsgGUID: VCmqGPusSKuVpJDQp8RTNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="49068909"
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="49068909"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 09:25:50 -0700
X-CSE-ConnectionGUID: P1Msx8FsTpGlRo0jNNXMnA==
X-CSE-MsgGUID: jwX6ZVu/Rg+18wHQBZDVEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="63996446"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa009.fm.intel.com with ESMTP; 30 Aug 2024 09:25:45 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Daniel Xu <dxu@dxuuu.xyz>,
	John Fastabend <john.fastabend@gmail.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 3/9] net: napi: add ability to create CPU-pinned threaded NAPI
Date: Fri, 30 Aug 2024 18:25:02 +0200
Message-ID: <20240830162508.1009458-4-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240830162508.1009458-1-aleksander.lobakin@intel.com>
References: <20240830162508.1009458-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lorenzo Bianconi <lorenzo@kernel.org>

Add netif_napi_add_percpu() to pin NAPI in threaded mode to a particular
CPU. This means, if the NAPI is not threaded, it will be run as usually,
but when switching to threaded mode, it will always be run on the
specified CPU.
It's not meant to be used in drivers, but might be useful when creating
percpu threaded NAPIs, for example, to replace percpu kthreads or
workers where a NAPI context is needed.
The already existing netif_napi_add*() are not anyhow affected.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/linux/netdevice.h | 35 +++++++++++++++++++++++++++++++++--
 net/core/dev.c            | 18 +++++++++++++-----
 2 files changed, 46 insertions(+), 7 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index ca5f0dda733b..4d6fb0ccdea1 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -377,6 +377,7 @@ struct napi_struct {
 	struct list_head	dev_list;
 	struct hlist_node	napi_hash_node;
 	int			irq;
+	int			thread_cpuid;
 };
 
 enum {
@@ -2619,8 +2620,18 @@ static inline void netif_napi_set_irq(struct napi_struct *napi, int irq)
  */
 #define NAPI_POLL_WEIGHT 64
 
-void netif_napi_add_weight(struct net_device *dev, struct napi_struct *napi,
-			   int (*poll)(struct napi_struct *, int), int weight);
+void netif_napi_add_weight_percpu(struct net_device *dev,
+				  struct napi_struct *napi,
+				  int (*poll)(struct napi_struct *, int),
+				  int weight, int thread_cpuid);
+
+static inline void netif_napi_add_weight(struct net_device *dev,
+					 struct napi_struct *napi,
+					 int (*poll)(struct napi_struct *, int),
+					 int weight)
+{
+	netif_napi_add_weight_percpu(dev, napi, poll, weight, -1);
+}
 
 /**
  * netif_napi_add() - initialize a NAPI context
@@ -2665,6 +2676,26 @@ static inline void netif_napi_add_tx(struct net_device *dev,
 	netif_napi_add_tx_weight(dev, napi, poll, NAPI_POLL_WEIGHT);
 }
 
+/**
+ * netif_napi_add_percpu() - initialize a CPU-pinned threaded NAPI context
+ * @dev:  network device
+ * @napi: NAPI context
+ * @poll: polling function
+ * @thread_cpuid: CPU which this NAPI will be pinned to
+ *
+ * Variant of netif_napi_add() which pins the NAPI to the specified CPU. No
+ * changes in the "standard" mode, but in case with the threaded one, this
+ * NAPI will always be run on the passed CPU no matter where scheduled.
+ */
+static inline void netif_napi_add_percpu(struct net_device *dev,
+					 struct napi_struct *napi,
+					 int (*poll)(struct napi_struct *, int),
+					 int thread_cpuid)
+{
+	netif_napi_add_weight_percpu(dev, napi, poll, NAPI_POLL_WEIGHT,
+				     thread_cpuid);
+}
+
 /**
  *  __netif_napi_del - remove a NAPI context
  *  @napi: NAPI context
diff --git a/net/core/dev.c b/net/core/dev.c
index 98bb5f890b88..93ca3df8e9dd 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1428,8 +1428,13 @@ static int napi_kthread_create(struct napi_struct *n)
 	 * TASK_INTERRUPTIBLE mode to avoid the blocked task
 	 * warning and work with loadavg.
 	 */
-	n->thread = kthread_run(napi_threaded_poll, n, "napi/%s-%d",
-				n->dev->name, n->napi_id);
+	if (n->thread_cpuid >= 0)
+		n->thread = kthread_run_on_cpu(napi_threaded_poll, n,
+					       n->thread_cpuid, "napi/%s-%u",
+					       n->dev->name);
+	else
+		n->thread = kthread_run(napi_threaded_poll, n, "napi/%s-%d",
+					n->dev->name, n->napi_id);
 	if (IS_ERR(n->thread)) {
 		err = PTR_ERR(n->thread);
 		pr_err("kthread_run failed with err %d\n", err);
@@ -6640,8 +6645,10 @@ void netif_queue_set_napi(struct net_device *dev, unsigned int queue_index,
 }
 EXPORT_SYMBOL(netif_queue_set_napi);
 
-void netif_napi_add_weight(struct net_device *dev, struct napi_struct *napi,
-			   int (*poll)(struct napi_struct *, int), int weight)
+void netif_napi_add_weight_percpu(struct net_device *dev,
+				  struct napi_struct *napi,
+				  int (*poll)(struct napi_struct *, int),
+				  int weight, int thread_cpuid)
 {
 	if (WARN_ON(test_and_set_bit(NAPI_STATE_LISTED, &napi->state)))
 		return;
@@ -6664,6 +6671,7 @@ void netif_napi_add_weight(struct net_device *dev, struct napi_struct *napi,
 	napi->poll_owner = -1;
 #endif
 	napi->list_owner = -1;
+	napi->thread_cpuid = thread_cpuid;
 	set_bit(NAPI_STATE_SCHED, &napi->state);
 	set_bit(NAPI_STATE_NPSVC, &napi->state);
 	list_add_rcu(&napi->dev_list, &dev->napi_list);
@@ -6677,7 +6685,7 @@ void netif_napi_add_weight(struct net_device *dev, struct napi_struct *napi,
 		dev->threaded = false;
 	netif_napi_set_irq(napi, -1);
 }
-EXPORT_SYMBOL(netif_napi_add_weight);
+EXPORT_SYMBOL(netif_napi_add_weight_percpu);
 
 void napi_disable(struct napi_struct *n)
 {
-- 
2.46.0


