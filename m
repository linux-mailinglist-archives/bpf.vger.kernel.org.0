Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5C03547AD
	for <lists+bpf@lfdr.de>; Mon,  5 Apr 2021 22:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240998AbhDEUlu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Apr 2021 16:41:50 -0400
Received: from mga02.intel.com ([134.134.136.20]:54260 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240981AbhDEUls (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Apr 2021 16:41:48 -0400
IronPort-SDR: AFWMUZesQoSR1DfLA0fQKpIspA3/d803N5UdFWezrOb2DNNeNFtNBBg/A2Vn7qJZSfADol6QWM
 g8TzINH5lVrw==
X-IronPort-AV: E=McAfee;i="6000,8403,9945"; a="180051523"
X-IronPort-AV: E=Sophos;i="5.81,307,1610438400"; 
   d="scan'208";a="180051523"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2021 13:41:32 -0700
IronPort-SDR: 7hHX1k0TTTvyZ4h8v4pVehE9bJvBiBYeYp/nm8oyolTxqnhRDfifj408AeFJeZmPojn84F2N+v
 tGkGPIYMXECg==
X-IronPort-AV: E=Sophos;i="5.81,307,1610438400"; 
   d="scan'208";a="418078027"
Received: from rpedgeco-mobl3.amr.corp.intel.com (HELO localhost.intel.com) ([10.212.230.218])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2021 13:41:32 -0700
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     akpm@linux-foundation.org, linux-mm@kvack.org, bpf@vger.kernel.org,
        dave.hansen@linux.intel.com, peterz@infradead.org, luto@kernel.org,
        jeyu@kernel.org
Cc:     linux-kernel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, hch@infradead.org, x86@kernel.org,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [RFC 1/3] list: Support getting most recent element in list_lru
Date:   Mon,  5 Apr 2021 13:37:09 -0700
Message-Id: <20210405203711.1095940-2-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210405203711.1095940-1-rick.p.edgecombe@intel.com>
References: <20210405203711.1095940-1-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In future patches, some functionality will use list_lru that also needs
to keep track of the most recently used element on a node. Since this
information is already contained within list_lru, add a function to get
it so that an additional list is not needed in the caller.

Do not support memcg aware list_lru's since it is not needed by the
intended caller.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 include/linux/list_lru.h | 13 +++++++++++++
 mm/list_lru.c            | 28 ++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
index 9dcaa3e582c9..4bde44a5024b 100644
--- a/include/linux/list_lru.h
+++ b/include/linux/list_lru.h
@@ -103,6 +103,19 @@ bool list_lru_add(struct list_lru *lru, struct list_head *item);
  */
 bool list_lru_del(struct list_lru *lru, struct list_head *item);
 
+/**
+ * list_lru_get_mru: gets and removes the tail from one of the node lists
+ * @list_lru: the lru pointer
+ * @nid: the node id
+ *
+ * This function removes the most recently added item from one of the node
+ * id specified. This function should not be used if the list_lru is memcg
+ * aware.
+ *
+ * Return value: The element removed
+ */
+struct list_head *list_lru_get_mru(struct list_lru *lru, int nid);
+
 /**
  * list_lru_count_one: return the number of objects currently held by @lru
  * @lru: the lru pointer.
diff --git a/mm/list_lru.c b/mm/list_lru.c
index fe230081690b..a18d9ed8abd5 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -156,6 +156,34 @@ bool list_lru_del(struct list_lru *lru, struct list_head *item)
 }
 EXPORT_SYMBOL_GPL(list_lru_del);
 
+struct list_head *list_lru_get_mru(struct list_lru *lru, int nid)
+{
+	struct list_lru_node *nlru = &lru->node[nid];
+	struct list_lru_one *l = &nlru->lru;
+	struct list_head *ret;
+
+	/* This function does not attempt to search through the memcg lists */
+	if (list_lru_memcg_aware(lru)) {
+		WARN_ONCE(1, "list_lru: %s not supported on memcg aware list_lrus", __func__);
+		return NULL;
+	}
+
+	spin_lock(&nlru->lock);
+	if (list_empty(&l->list)) {
+		ret = NULL;
+	} else {
+		/* Get tail */
+		ret = l->list.prev;
+		list_del_init(ret);
+
+		l->nr_items--;
+		nlru->nr_items--;
+	}
+	spin_unlock(&nlru->lock);
+
+	return ret;
+}
+
 void list_lru_isolate(struct list_lru_one *list, struct list_head *item)
 {
 	list_del_init(item);
-- 
2.29.2

