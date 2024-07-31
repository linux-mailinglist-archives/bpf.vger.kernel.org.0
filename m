Return-Path: <bpf+bounces-36175-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8AF943824
	for <lists+bpf@lfdr.de>; Wed, 31 Jul 2024 23:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ACF1285D17
	for <lists+bpf@lfdr.de>; Wed, 31 Jul 2024 21:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F3A16D333;
	Wed, 31 Jul 2024 21:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PHah+3+A"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A84416D315;
	Wed, 31 Jul 2024 21:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722462184; cv=none; b=g3JB+WMHEA+102d/+/fBKbMa8KLLAMW94c2y/6I4drkp6J8S4a8oq6fUtZWqaByYl4wKKiKYSovIRR2oYzGOT5Y5sAoTEamJss0JyMK3eWxixubaNr6z0NCMNfP2RoDtpWtmnU9UylOi91P1UuH48xxbZdCU04Jv9lKF6SfGPKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722462184; c=relaxed/simple;
	bh=SjUQUdkQ9apRjYg10YHnkGtMjGkuub+TW3Yfzz4DF6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D8l4MEhS50z5eMyFN3cBoobQpzQA7c2Cxenud4jGxCy/1N+p4D2RvmIfvTA6ujur5eHKJmd0Im7g+uQR0M0qKW3VktQ0p9Pngol9w03yZu2kiQIJwOFy2tT8WUFevwYvZk5DMzLZ6I6ivYjQRmAgXBzBH96pfgycTXR0CIMCPkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PHah+3+A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 704DCC32786;
	Wed, 31 Jul 2024 21:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722462183;
	bh=SjUQUdkQ9apRjYg10YHnkGtMjGkuub+TW3Yfzz4DF6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PHah+3+Af1+xYfP+T/ehHzxz0/hBSUcpmBgIF7XvwvdNDbVsOyAh7Mx6tmxfY4AIr
	 cNo8HPhXD+2yeUGIc/mzRxhTX0zdq69kzzy6gaaJpYOAtsd4BvAxfbm+iFCC/XiVLs
	 /kbmorGAszpnn03C9Sddr1xI1Hz+xZoPglRu3w/5BCXtgXqBGwgbqVMBJOCbpCWfpa
	 hpqRu3oO5ewc6D9vuDVRU/Bj46sVCWJsAjpjpdhBt6cEuan9bc4fipkCDMWlPz5+Lb
	 sx8Ophm6+jZ5VZ3pBa7ONuKJ3SisugsgEByULt7cMm8btWDiNUhb/1E401MJ70fRD1
	 PbqVdLywofWsg==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-trace-kernel@vger.kernel.org,
	peterz@infradead.org,
	oleg@redhat.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jolsa@kernel.org,
	paulmck@kernel.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH 1/8] rbtree: provide rb_find_rcu() / rb_find_add_rcu()
Date: Wed, 31 Jul 2024 14:42:49 -0700
Message-ID: <20240731214256.3588718-2-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240731214256.3588718-1-andrii@kernel.org>
References: <20240731214256.3588718-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Zijlstra <peterz@infradead.org>

Much like latch_tree, add two RCU methods for the regular RB-tree,
which can be used in conjunction with a seqcount to provide lockless
lookups.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 include/linux/rbtree.h | 67 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/include/linux/rbtree.h b/include/linux/rbtree.h
index f7edca369eda..7c173aa64e1e 100644
--- a/include/linux/rbtree.h
+++ b/include/linux/rbtree.h
@@ -244,6 +244,42 @@ rb_find_add(struct rb_node *node, struct rb_root *tree,
 	return NULL;
 }
 
+/**
+ * rb_find_add_rcu() - find equivalent @node in @tree, or add @node
+ * @node: node to look-for / insert
+ * @tree: tree to search / modify
+ * @cmp: operator defining the node order
+ *
+ * Adds a Store-Release for link_node.
+ *
+ * Returns the rb_node matching @node, or NULL when no match is found and @node
+ * is inserted.
+ */
+static __always_inline struct rb_node *
+rb_find_add_rcu(struct rb_node *node, struct rb_root *tree,
+		int (*cmp)(struct rb_node *, const struct rb_node *))
+{
+	struct rb_node **link = &tree->rb_node;
+	struct rb_node *parent = NULL;
+	int c;
+
+	while (*link) {
+		parent = *link;
+		c = cmp(node, parent);
+
+		if (c < 0)
+			link = &parent->rb_left;
+		else if (c > 0)
+			link = &parent->rb_right;
+		else
+			return parent;
+	}
+
+	rb_link_node_rcu(node, parent, link);
+	rb_insert_color(node, tree);
+	return NULL;
+}
+
 /**
  * rb_find() - find @key in tree @tree
  * @key: key to match
@@ -272,6 +308,37 @@ rb_find(const void *key, const struct rb_root *tree,
 	return NULL;
 }
 
+/**
+ * rb_find_rcu() - find @key in tree @tree
+ * @key: key to match
+ * @tree: tree to search
+ * @cmp: operator defining the node order
+ *
+ * Notably, tree descent vs concurrent tree rotations is unsound and can result
+ * in false-negatives.
+ *
+ * Returns the rb_node matching @key or NULL.
+ */
+static __always_inline struct rb_node *
+rb_find_rcu(const void *key, const struct rb_root *tree,
+	    int (*cmp)(const void *key, const struct rb_node *))
+{
+	struct rb_node *node = tree->rb_node;
+
+	while (node) {
+		int c = cmp(key, node);
+
+		if (c < 0)
+			node = rcu_dereference_raw(node->rb_left);
+		else if (c > 0)
+			node = rcu_dereference_raw(node->rb_right);
+		else
+			return node;
+	}
+
+	return NULL;
+}
+
 /**
  * rb_find_first() - find the first @key in @tree
  * @key: key to match
-- 
2.43.0


