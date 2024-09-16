Return-Path: <bpf+bounces-39996-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DB6979F0C
	for <lists+bpf@lfdr.de>; Mon, 16 Sep 2024 12:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2BE51F2439A
	for <lists+bpf@lfdr.de>; Mon, 16 Sep 2024 10:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683FE14F132;
	Mon, 16 Sep 2024 10:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KHjUvQh7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6796149C4D;
	Mon, 16 Sep 2024 10:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726481659; cv=none; b=frbgFXSWfMUGCJyP7AZW3g6nXe9Uoh5Q53Dy+7qtUBbfbl45OTWVDqGRFpL1vqH68V35JdinUvHvnPzgs+chQLMzK8oycMJucPf8y0RJ66xt9SP/aCusfOzpRGf70Sy5JwVOrZKUzwc1m6Gb+P/IVBLLS5EV9Ssga9HS96uyVGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726481659; c=relaxed/simple;
	bh=+mOCLm5vpXETonbJPaPdyDgzqWO9T6eqfQY/D2t3yQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lyoRDkKkZXcK05sERCPzYZKY0vkMHh8Mf6E6T6Ii+gmRPp6VYr/+kntrnAHUU13metlo2kOuwySORhpNGrYis73F+szl5aWjg781aCP2b3tG1u5ipOzxaCkJ+ZZS4LQ/ysnEI/UMo2u3pS9Wk0Qmhx4rdLbq02j0X6dolF4B00Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KHjUvQh7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32A15C4CEC4;
	Mon, 16 Sep 2024 10:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726481659;
	bh=+mOCLm5vpXETonbJPaPdyDgzqWO9T6eqfQY/D2t3yQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KHjUvQh7hCFg7nsGWyY47zsFiUFPcVLWm/2cevLFjBB3YsJosGFyHpMpGmmdXjwSF
	 Qno7l498cuc086ndVAuKaIpin6k57zVP92u46HZvppiJzFQ+i7/evZllWyWqaCDHs6
	 NNNOuURm58srv3i60mEfAdZep09ozX7lrbHbV1nqSXHHYv5J57yZ2hnUslibbtfqmW
	 CFv7x0D0TCfR9vVAWgkgyNMXgLekBFYzScuXz2VIomrFiu6vuACHFAhIZkVae2NHt/
	 E8jVxYwVYctsQ8IYCf/BVIZiwqYgJrV/MQjJKRv9agbPsY7xfE0HDFzVzgnt6/J0as
	 pDt16GoJZ6/uw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: bpf@vger.kernel.org
Cc: kuba@kernel.org,
	aleksander.lobakin@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	dxu@dxuuu.xyz,
	john.fastabend@gmail.com,
	hawk@kernel.org,
	martin.lau@linux.dev,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	lorenzo.bianconi@redhat.com
Subject: [RFC/RFT v2 1/3] net: Add napi_init_for_gro routine
Date: Mon, 16 Sep 2024 12:13:43 +0200
Message-ID: <1383fe802f0edbfb527e9d6c45729d31f7be6d32.1726480607.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1726480607.git.lorenzo@kernel.org>
References: <cover.1726480607.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce napi_init_for_gro utility routine to initialize napi_struct
for GRO. This is a preliminary patch to introduce GRO support to cpumap
codebase.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 include/linux/netdevice.h |  2 ++
 net/core/dev.c            | 23 +++++++++++++++++------
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 607009150b5fa..3c4c3ae2170f0 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2628,6 +2628,8 @@ static inline void netif_napi_set_irq(struct napi_struct *napi, int irq)
  */
 #define NAPI_POLL_WEIGHT 64
 
+int napi_init_for_gro(struct net_device *dev, struct napi_struct *napi,
+		      int (*poll)(struct napi_struct *, int), int weight);
 void netif_napi_add_weight(struct net_device *dev, struct napi_struct *napi,
 			   int (*poll)(struct napi_struct *, int), int weight);
 
diff --git a/net/core/dev.c b/net/core/dev.c
index f66e614078832..c87c510abc05b 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6638,13 +6638,14 @@ void netif_queue_set_napi(struct net_device *dev, unsigned int queue_index,
 }
 EXPORT_SYMBOL(netif_queue_set_napi);
 
-void netif_napi_add_weight(struct net_device *dev, struct napi_struct *napi,
-			   int (*poll)(struct napi_struct *, int), int weight)
+int napi_init_for_gro(struct net_device *dev, struct napi_struct *napi,
+		      int (*poll)(struct napi_struct *, int), int weight)
 {
 	if (WARN_ON(test_and_set_bit(NAPI_STATE_LISTED, &napi->state)))
-		return;
+		return -EBUSY;
 
 	INIT_LIST_HEAD(&napi->poll_list);
+	INIT_LIST_HEAD(&napi->dev_list);
 	INIT_HLIST_NODE(&napi->napi_hash_node);
 	hrtimer_init(&napi->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINNED);
 	napi->timer.function = napi_watchdog;
@@ -6662,18 +6663,28 @@ void netif_napi_add_weight(struct net_device *dev, struct napi_struct *napi,
 	napi->poll_owner = -1;
 #endif
 	napi->list_owner = -1;
+	napi_hash_add(napi);
+	napi_get_frags_check(napi);
+	netif_napi_set_irq(napi, -1);
+
+	return 0;
+}
+
+void netif_napi_add_weight(struct net_device *dev, struct napi_struct *napi,
+			   int (*poll)(struct napi_struct *, int), int weight)
+{
+	if (napi_init_for_gro(dev, napi, poll, weight))
+		return;
+
 	set_bit(NAPI_STATE_SCHED, &napi->state);
 	set_bit(NAPI_STATE_NPSVC, &napi->state);
 	list_add_rcu(&napi->dev_list, &dev->napi_list);
-	napi_hash_add(napi);
-	napi_get_frags_check(napi);
 	/* Create kthread for this napi if dev->threaded is set.
 	 * Clear dev->threaded if kthread creation failed so that
 	 * threaded mode will not be enabled in napi_enable().
 	 */
 	if (dev->threaded && napi_kthread_create(napi))
 		dev->threaded = false;
-	netif_napi_set_irq(napi, -1);
 }
 EXPORT_SYMBOL(netif_napi_add_weight);
 
-- 
2.46.0


