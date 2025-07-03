Return-Path: <bpf+bounces-62327-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6396AF81B1
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 22:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44750585158
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 20:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A2A190679;
	Thu,  3 Jul 2025 20:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="M8R6JXbF"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8A523817F
	for <bpf@vger.kernel.org>; Thu,  3 Jul 2025 20:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751572828; cv=none; b=jy3i6AFE/g7jIz4Ml2F899JModX2hKFxh+7QAKrft3gBNlBJtg2KfSIgLeykkt2h3eHYJvhD+FoaDLnDIA5fjzf45vO3a+kOpjpaR7HfeCt4cXi6aMM98dHSKra0nG4p8Y+4Cuol/fsJ+B4qfWHSXCSjnN7DCQ8my/aO59435Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751572828; c=relaxed/simple;
	bh=ZN/sSZ5VqDrJ+/+zU/enR2Lt6V5eNXGWEbWy7w+DLlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MdnmHfpIdYbPrYPHrNo5r6EtMFXWcVF8jN0lzo3ccLJ3W3YEnMOIaUT5PWjeH7Ckq1xHFxb9k2g3jj1N0AMkFXhs1lQzJXPadQVTthod4DUgjERo0/oAubgCmfKLbAlZZq4jxbAhUkvnJir4A86VRhmQQIZkX8XoB6bWdWTfpC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=M8R6JXbF; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751572823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SGhXzWJsGk56JycQmQ+hoC74TrLHTSnR2HKmNnQu/Nw=;
	b=M8R6JXbF/SaGFD0ewZZk0dtUaSuRsaRB2w+WYGGTkJNFxeUR/FELr5MkCYl+5heZ1Bvldu
	rAph2Kt+lIAcvjEPESRtd9zcuPsoTSp6uH2XtCtVCdFuMlg4YCVOSVphNeCcvtXwz7vm07
	MnYUxRFP7aFUHRwrjaetduqdFT0oXjA=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: "Paul E . McKenney" <paulmck@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	JP Kobryn <inwardvessel@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Ying Huang <huang.ying.caritas@gmail.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Alexei Starovoitov <ast@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	bpf@vger.kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH 1/2] llist: avoid memory tearing for llist_node
Date: Thu,  3 Jul 2025 13:00:11 -0700
Message-ID: <20250703200012.3734798-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Before the commit 36df6e3dbd7e ("cgroup: make css_rstat_updated nmi
safe"), the struct llist_node is expected to be private to the one
inserting the node to the lockless list or the one removing the node
from the lockless list. After the mentioned commit, the llist_node in
the rstat code is per-cpu shared between the stacked contexts i.e.
process, softirq, hardirq & nmi. It is possible the compiler may tear
the loads or stores of llist_node. Let's avoid that.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 include/linux/llist.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/llist.h b/include/linux/llist.h
index 27b17f64bcee..607b2360c938 100644
--- a/include/linux/llist.h
+++ b/include/linux/llist.h
@@ -83,7 +83,7 @@ static inline void init_llist_head(struct llist_head *list)
  */
 static inline void init_llist_node(struct llist_node *node)
 {
-	node->next = node;
+	WRITE_ONCE(node->next, node);
 }
 
 /**
@@ -97,7 +97,7 @@ static inline void init_llist_node(struct llist_node *node)
  */
 static inline bool llist_on_list(const struct llist_node *node)
 {
-	return node->next != node;
+	return READ_ONCE(node->next) != node;
 }
 
 /**
@@ -220,7 +220,7 @@ static inline bool llist_empty(const struct llist_head *head)
 
 static inline struct llist_node *llist_next(struct llist_node *node)
 {
-	return node->next;
+	return READ_ONCE(node->next);
 }
 
 /**
-- 
2.47.1


